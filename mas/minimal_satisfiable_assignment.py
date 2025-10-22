# Taken from Mint -> https://alexeyignatiev.github.io/software/mintt ijk/
#==============================================================================
from pysmt.smtlib.parser import SmtLibParser
from pysmt.shortcuts import Not, ForAll, is_sat, is_unsat, get_model, qelim, Bool, Not, Solver
from pysmt.exceptions import SolverReturnedUnknownResultError

import re
import time
import random
import z3

from io import StringIO
#==============================================================================


class Mistral:
    """
        Mistral solver class.
    """

    def __init__(self, simplify=True, incremental=True):
        """
            Constructor.
        """

        self.simplify = simplify
        self.incremental = incremental
        self.cost = 0
        self.sname = 'z3'

    def solve(self, query):
        """
            This method implements find_msa() procedure from Fig. 2
            of the dillig-cav12 paper.
        """

        self.script = SmtLibParser().get_script(StringIO(query))
        self.formula = self.script.get_last_formula()
        self.formula = self.formula.simplify()

        self.fvars = self.formula.get_free_variables()

        if get_model(self.formula, solver_name=self.sname) == None:
            return None

        X = frozenset(list(self.fvars)[0])
        mus = self.compute_mus(X, self.fvars - X, 0)
        # return MSA (minimal satisfying assignment)
        return self.fvars- mus

    def compute_mus(self, X, fvars, lb):
        """
            Algorithm implements find_mus() procedure from Fig. 1
            of the dillig-cav12 paper.
        """

        if not fvars or len(fvars) <= lb:
            return frozenset()

        best = set()
        x = frozenset([next(iter(fvars))])

        if self.get_model_forall(X.union(x)):
            Y = self.compute_mus(X.union(x), fvars - x, lb - 1)

            cost_curr = len(Y) + 1
            if cost_curr > lb:
                best = Y.union(x)
                lb = cost_curr

        Y = self.compute_mus(X, fvars - x, lb)
        if len(Y) > lb:
            best = Y

        return best

    def get_model_forall(self, x_univl):
        return get_model(ForAll(x_univl, self.formula),
                solver_name=self.sname)


class MistralLattice:
    """
        Fixed version with correct MUS interpretation.
    """
    def __init__(self, simplify=True, random_probes=20):
        self.simplify = simplify
        self.sname = 'z3'
        self.sat_calls = 0
        self.random_probes = random_probes

        self.known_sat = set()
        self.known_unsat = set()

    def solve(self, query):
        self.script = SmtLibParser().get_script(StringIO(query))
        self.formula = self.script.get_last_formula()
        self.formula = self.formula.simplify()
        self.fvars = self.formula.get_free_variables()

        if get_model(self.formula, solver_name=self.sname) == None:
            return None

        self.known_sat = set()
        self.known_unsat = set()
        self.sat_calls = 0

        unusable = self.vars_explore()
        usable = self.fvars - unusable
        if len(usable) == 0:
            return set()
        max_free_sets = self.random_exploration(usable)

        best_free_set = max(max_free_sets, key=lambda x: len(x))

        maximal_free_set = self.greedy_expand_free_set(best_free_set)

        return self.fvars - maximal_free_set

    def vars_explore(self):
        unusable = set()

        for v in self.fvars:
            result = get_model(ForAll([v], self.formula), solver_name=self.sname)

            if result is not None:
                self.known_sat.add(frozenset({v}))
            else:
                self.known_unsat.add(frozenset({v}))
                unusable.add(v)

        return unusable


    def random_exploration(self, usable):
        """
            Find boundary points: maximal sets where ForAll is SAT.
        """
        usable_list = list(usable)
        n = len(usable_list)

        boundary_points = []

        for i in range(self.random_probes):

            size = random.randint(0, n)
            X_free = frozenset(random.sample(usable_list, size))

            is_sat = self.get_model_forall_lattice(X_free)

            if is_sat:
                X_free = self.climb_to_boundary(X_free, usable_list)
                # print(f"  Found SAT boundary: {len(X_free)} free vars")
            else:
                X_free = self.descend_to_boundary(X_free, usable_list)
                # print(f"  Descended to SAT: {len(X_free)} free vars")

            boundary_points.append(X_free)

        return boundary_points

    def greedy_expand_free_set(self, X_free):
        """
            Greedily try to add more variables to the free set.

            Goal: Maximize |X_free| such that ∀(X_free). formula is SAT
            This gives us the MINIMAL satisfying assignment (complement).
        """
        improved = True
        iterations = 0

        while improved:
            improved = False
            iterations += 1

            # Variables not yet in free set (candidates to add)
            candidates = list(self.fvars - X_free)
            random.shuffle(candidates)

            for var in candidates:
                # Try adding this variable to free set
                X_new = X_free.union(frozenset([var]))

                # Check if still SAT with more free variables
                if self.get_model_forall_lattice(X_new):
                    X_free = X_new
                    improved = True
                    break  # Restart with new free set

        return X_free

    def climb_to_boundary(self, X_free, all_vars):
        """Add variables to free set while remaining SAT."""
        available = [v for v in all_vars if v not in X_free]
        random.shuffle(available)

        for var in available:
            X_new = X_free.union(frozenset([var]))
            if self.get_model_forall_lattice(X_new):
                X_free = X_new

        return X_free

    def descend_to_boundary(self, X_free, all_vars):
        """Remove variables from free set until SAT."""
        X_list = list(X_free)
        random.shuffle(X_list)

        # Keep removing until we hit SAT
        while X_list and not self.get_model_forall_lattice(X_free):
            var = X_list.pop()
            X_free = X_free - frozenset([var])

        return X_free

    def get_model_forall_lattice(self, x_univl):
        """Check with lattice pruning."""
        x_set = frozenset(x_univl)

        # Prune: if subset is UNSAT, this is UNSAT
        for unsat_set in self.known_unsat:
            if unsat_set.issubset(x_set):
                return False

        # Prune: if superset is SAT, this is SAT
        for sat_set in self.known_sat:
            if x_set.issubset(sat_set):
                return True

        # Check it
        self.sat_calls += 1
        result = get_model(ForAll(x_univl, self.formula), solver_name=self.sname)

        if result is not None:
            self.known_sat.add(x_set)
        else:
            self.known_unsat.add(x_set)

        return result is not None


# Regex definitions
def_pat = re.compile(r'.*define-fun.*')
func_pat = re.compile(r'(?:Bool|\(_\s+BitVec\s+\d+\))\s+(.*)\)')
var_pat = re.compile(r'\((\w+)\s+(?:(Bool)|\(_\s+(BitVec)\s+(\d+)\))\)')

def get_defined_funs(file):
    with open(file, 'r') as f:
        content = f.read()
        matches = def_pat.findall(content)
    return set(matches)

def generate_vars(expr, d):
    for m in var_pat.findall(expr):
        match m:
            case [n, '', _, w]:
                tmp = z3.BitVec(n, int(w))
            case [n, _, '', '']:
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

    minimal_uni_subset = m.solve(s.to_smt2())
    return minimal_uni_subset

def get_variables(file):
    with open(file, 'r') as f:
        variables = set(v for v in f.read().split())
    return variables


def run_get_mas():
    variables = get_variables(f"../variables.txt")
    matches = get_defined_funs(f"../SygusResult.sl")

    # variables = get_variables(f"../Variables/c17.txt")
    # matches = get_defined_funs(f"../Sygus/c17.sl")

    # m = Mistral()
    m = MistralLattice(random_probes=50)
    d = {}

    # start = time.time()
    assertions = {gen_vars_get_fun(a, d) for a in matches}
    mas = {str(a) for a in get_mas(assertions, d, m)}
    underspecified = variables - mas
    # print(time.time() - start)
    return underspecified

