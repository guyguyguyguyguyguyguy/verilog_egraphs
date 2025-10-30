# Taken from Mint -> https://alexeyignatiev.github.io/software/mintt ijk/
# ==============================================================================
from pysmt.smtlib.parser import SmtLibParser
from pysmt.shortcuts import (
    Not,
    ForAll,
    is_sat,
    is_unsat,
    get_model,
    qelim,
    Bool,
    Solver,
)
from pysmt.smtlib.script import smtlibscript_from_formula
from pysmt.exceptions import SolverReturnedUnknownResultError
import re
import time
import random
import z3
import more_itertools
from io import StringIO


# ==============================================================================
class MistralLattice:
    """
    Fixed version with correct MUS interpretation using incremental Z3 solving.
    """

    def __init__(self, simplify=True):
        self.simplify = simplify
        self.sname = "z3"
        self.sat_calls = 0
        self.known_sat = set()
        self.known_unsat = set()
        self.assertion_vars = None
        self.z3_solver = None
        self.z3_vars = {}
        self.z3_formula = None
        self.z3_negated_formula = None

    def solve(self, query, z3_vars=None, z3_solver=None):
        self.script = SmtLibParser().get_script(StringIO(query))
        self.formula = self.script.get_last_formula()
        self.formula = self.formula.simplify()
        self.fvars = self.formula.get_free_variables()

        self._init_from_z3_solver(z3_solver, z3_vars)

        self.known_sat = set()
        self.known_unsat = set()
        self.sat_calls = 0

        self.assertion_vars = [sf.get_free_variables() for sf in self.formula.args()]
        max_free_sets = self._search(self.assertion_vars)
        best_free_set = max(max_free_sets, key=lambda x: len(x))
        return self.fvars - best_free_set

    def _init_from_z3_solver(self, z3_solver, z3_vars):
        self.z3_vars = z3_vars

        assertions = z3_solver.assertions()
        if len(assertions) == 1:
            self.z3_formula = assertions[0]
        else:
            self.z3_formula = z3.And(*assertions)

        self.z3_negated_formula = z3.Not(self.z3_formula)
        self.z3_solver = z3.Solver()

    def _compute_var_frequency(self, available_vars):
        var_freq = {v: 0 for v in available_vars}
        for assertion_var_set in self.assertion_vars:
            for v in assertion_var_set:
                if v in var_freq:
                    var_freq[v] += 1
        return var_freq

    def climb_to_boundary(self, X_free, batch_size=5):
        available = [v for v in self.fvars if v not in X_free]
        if not available:
            return frozenset(X_free)

        var_freq = self._compute_var_frequency(available)
        available.sort(key=lambda v: var_freq[v])
        adaptive_batch = min(batch_size, max(1, len(available) // 10))

        i = 0
        while i < len(available):
            batch_end = min(i + adaptive_batch, len(available))
            batch = available[i:batch_end]

            X_new = X_free.union(frozenset(batch))
            if self.get_model_forall_lattice(X_new):
                X_free = X_new
                i = batch_end
            else:
                success_count = 0
                for var in batch:
                    X_new = X_free.union(frozenset([var]))
                    if self.get_model_forall_lattice(X_new):
                        X_free = X_new
                        success_count += 1

                if success_count < len(batch) / 2:
                    adaptive_batch = max(1, adaptive_batch // 2)

                i = batch_end

        return frozenset(X_free)

    def descend_to_boundary(self, X_free):
        X_list = list(X_free)
        var_freq = self._compute_var_frequency(X_list)
        X_list.sort(key=lambda v: var_freq[v], reverse=True)

        while X_list and not self.get_model_forall_lattice(X_free):
            var = X_list.pop(0)
            X_free = X_free - frozenset([var])

        return frozenset(X_free)

    def _search(self, assertion_vars):
        mhss = [self.get_mhs(assertion_vars)]
        free_sets = set()
        for mhs in mhss:
            if self.get_model_forall_lattice(mhs):
                free_sets.add(self.climb_to_boundary(mhs))
            else:
                free_sets.add(self.descend_to_boundary(mhs))
        return free_sets

    def get_mhs(self, assertion_vars):
        sorted_vars = sorted(assertion_vars, key=lambda x: len(x))
        mhs = set()
        covered = set()

        for var_set in sorted_vars:
            if var_set.issubset(covered):
                continue
            candidates = var_set - covered
            if candidates:
                best_var = next(iter(candidates))
                mhs.add(best_var)
                covered.add(best_var)

        return mhs

    def get_model_forall_lattice(self, x_univl):
        x_set = frozenset(x_univl)

        for unsat_set in self.known_unsat:
            if unsat_set.issubset(x_set):
                return False

        for sat_set in self.known_sat:
            if x_set.issubset(sat_set):
                return True

        self.sat_calls += 1

        z3_vars_to_quantify = []
        for pysmt_var in x_univl:
            var_name = pysmt_var.symbol_name()
            if var_name in self.z3_vars:
                z3_vars_to_quantify.append(self.z3_vars[var_name])

        self.z3_solver.push()

        if z3_vars_to_quantify:
            existential_query = z3.Exists(z3_vars_to_quantify, self.z3_negated_formula)
        else:
            existential_query = self.z3_negated_formula

        self.z3_solver.add(existential_query)

        result = self.z3_solver.check()

        self.z3_solver.pop()

        forall_is_sat = result == z3.unsat

        if forall_is_sat:
            self.known_sat.add(x_set)
        else:
            self.known_unsat.add(x_set)

        return forall_is_sat


# Regex definitions
def_pat = re.compile(r".*define-fun.*")
func_pat = re.compile(r"(?:Bool|\(_\s+BitVec\s+\d+\))\s+(.*)\)")
var_pat = re.compile(r"\((\w+)\s+(?:(Bool)|\(_\s+(BitVec)\s+(\d+)\))\)")


def get_defined_funs(file):
    with open(file, "r") as f:
        content = f.read()
        matches = def_pat.findall(content)
    return set(matches)


def generate_vars(expr, d):
    for m in var_pat.findall(expr):
        match m:
            case [n, "", _, w]:
                tmp = z3.BitVec(n, int(w))
            case [n, _, "", ""]:
                tmp = z3.Bool(n)
        d[n] = tmp


def gen_vars_get_fun(expr, d):
    generate_vars(expr, d)
    return func_pat.search(expr).group(1)


def get_mas(exprs, d, m):
    assertion = f"""
    (assert
        (and {(' ').join(exprs)})
    )
    """
    z3_assertion = z3.parse_smt2_string(assertion, decls=d)
    s = z3.Solver()
    s.add(z3_assertion)

    # Pass Z3 solver and variables directly to avoid duplicate work!
    minimal_uni_subset = m.solve(s.to_smt2(), z3_vars=d, z3_solver=s)
    return minimal_uni_subset


def get_variables(file):
    with open(file, "r") as f:
        variables = set(v for v in f.read().split())
    return variables


def run_get_mas():
    variables = get_variables(f"Variables/s15850.txt")
    matches = get_defined_funs(f"Sygus/s15850.sl")

    m = MistralLattice()
    d = {}
    assertions = {gen_vars_get_fun(a, d) for a in matches}
    print("vars: ", len(variables))
    mas = get_mas(assertions, d, m)
    mas = {str(a) for a in mas}
    underspecified = variables - mas
    print("underspecified: ", len(assertions))
    return underspecified


run_get_mas()
