# Taken from Mint -> https://alexeyignatiev.github.io/software/mintt ijk/
# ==============================================================================
from pysmt.smtlib.parser import SmtLibParser
from pysmt.shortcuts import ForAll, get_model
import re
import time
import random
import z3
import more_itertools
from io import StringIO
# ==============================================================================
class MistralLattice:
    """
    Fixed version with correct MUS interpretation.
    """
    def __init__(self, simplify=True):
        self.simplify = simplify
        self.sname = "z3"
        self.sat_calls = 0
        self.known_sat = set()
        self.known_unsat = set()
        self.assertion_vars = None
    
    def solve(self, query, z3_vars=None, z3_solver=None):
        self.script = SmtLibParser().get_script(StringIO(query))
        self.formula = self.script.get_last_formula()
        self.formula = self.formula.simplify()
        self.fvars = self.formula.get_free_variables()
        
        print("Vars in assertions: ", len(self.fvars))
        
        self.known_sat = set()
        self.known_unsat = set()
        self.sat_calls = 0
        self.assertion_vars = [sf.get_free_variables() for sf in self.formula.args()]
        max_free_sets = self._search(self.assertion_vars)
        best_free_set = max(max_free_sets, key=lambda x: len(x))
        return self.fvars - best_free_set
    
    def _compute_var_frequency(self, available_vars):
        var_freq = {v: 0 for v in available_vars}
        for assertion_var_set in self.assertion_vars:
            for v in assertion_var_set:
                if v in var_freq:
                    var_freq[v] += 1
        return var_freq
    
    def climb_to_boundary(self, X_free, potential_vars=None):
        if potential_vars is None:
            potential_vars = [v for v in self.fvars if v not in X_free]
        
        if not potential_vars:
            return frozenset(X_free)
        
        var_freq = self._compute_var_frequency(potential_vars)
        potential_vars.sort(key=lambda v: var_freq[v])
        
        batches = list(more_itertools.chunked(potential_vars, 3))
        
        for batch in batches:
            X_new = X_free.union(frozenset(batch))
            
            if self.get_model_forall_lattice(X_new):
                X_free = X_new  
            else:
                return self.descend_to_boundary(X_free)
        
        return frozenset(X_free)
    
    def descend_to_boundary(self, X_free):
        X_list = list(X_free)
        
        if not X_list or self.get_model_forall_lattice(X_free):
            return frozenset(X_free)
        
        var_freq = self._compute_var_frequency(X_list)
        X_list.sort(key=lambda v: var_freq[v], reverse=True)
        
        batches = list(more_itertools.chunked(X_list, 10))
        
        for batch in batches:
            X_new = X_free - frozenset(batch)
            
            if self.get_model_forall_lattice(X_new):
                return self.climb_to_boundary(X_new, list(batch))
            X_free = X_new
        
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
        result = get_model(ForAll(x_univl, self.formula), solver_name=self.sname)
        
        if result is not None:
            self.known_sat.add(x_set)
        else:
            self.known_unsat.add(x_set)
        
        return result is not None

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
    mas = m.solve(s.to_smt2())
    return mas

def get_variables(file):
    with open(file, "r") as f:
        variables = set(v for v in f.read().split())
    return variables

def run_get_mas():
    variables = get_variables(f"../Variables/s38417.txt")
    matches = get_defined_funs(f"../Sygus/s38417.sl")
    variables = get_variables(f"../Variables/s1238.txt")
    matches = get_defined_funs(f"../Sygus/s1238.sl")
    m = MistralLattice()
    d = {}
    assertions = {gen_vars_get_fun(a, d) for a in matches}
    print("vars: ", len(variables))
    mas = get_mas(assertions, d, m)
    print("MUS: ", len(m.fvars - mas))
    mas = {str(a) for a in mas}
    underspecified = variables - mas
    print("underspecified: ", len(underspecified))
    return underspecified

run_get_mas()
