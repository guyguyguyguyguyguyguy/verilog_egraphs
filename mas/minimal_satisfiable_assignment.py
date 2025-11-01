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


class MistralMHSLattice:
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
        print([len(x) for x in max_free_sets])
        best_free_set = max(max_free_sets, key=lambda x: len(x))
        return self.fvars - best_free_set
    
    def _compute_var_frequency(self, available_vars):
        var_freq = {v: 0 for v in available_vars}
        for assertion_var_set in self.assertion_vars:
            for v in assertion_var_set:
                if v in var_freq:
                    var_freq[v] += 1
        return var_freq


    # TODO: Need a way to get the (minimal) unsat core
    def descend_to_boundary(self, X_free):
        """Use PySMT's UnsatCoreSolver with proper tracking."""
        from pysmt.shortcuts import Solver, Not, ForAll, Implies, And
        
        X_list = list(X_free)
        
        if not X_list:
            return frozenset()
        
        if self.get_model_forall_lattice(X_free):
            return frozenset(X_free)
        
        # Strategy: For each conjunction in the formula, track which variables appear
        # Then find which conjunctions are in the UNSAT core
        
        with Solver(name=self.sname, unsat_cores_mode='named') as solver:
            # Get individual conjuncts from the formula
            if self.formula.is_and():
                conjuncts = self.formula.args()
            else:
                conjuncts = [self.formula]
            
            # Add each conjunct as a named assertion with quantification
            for i, conjunct in enumerate(conjuncts):
                # Only quantify over variables that appear in both X_free and this conjunct
                conjunct_vars = conjunct.get_free_variables()
                vars_to_quantify = X_free.intersection(conjunct_vars)
                
                if vars_to_quantify:
                    assertion = ForAll(vars_to_quantify, conjunct)
                    assertion_name = f"conjunct_{i}"
                    solver.add_assertion(assertion, named=assertion_name)
            
            result = solver.solve()
            
            if not result:  # UNSAT - we have a conflict!
                core = solver.get_named_unsat_core()
                
                # Find which variables are in the core conjuncts
                conflicting_vars = set()
                for name in core.keys():
                    if name.startswith('conjunct_'):
                        idx = int(name.replace('conjunct_', ''))
                        if idx < len(conjuncts):
                            conjunct_vars = conjuncts[idx].get_free_variables()
                            conflicting_vars.update(X_free.intersection(conjunct_vars))
                
                conflicting_vars = frozenset(conflicting_vars)
                
                if conflicting_vars:
                    X_sat = X_free - conflicting_vars
                    
                    if not X_sat or not self.get_model_forall_lattice(X_sat):
                        if X_sat:
                            return self.descend_to_boundary(X_sat)
                        else:
                            return frozenset()
                    
                    # Try to add back variables
                    for var in conflicting_vars:
                        X_candidate = X_sat.union(frozenset([var]))
                        if self.get_model_forall_lattice(X_candidate):
                            X_sat = X_candidate
                    
                    return frozenset(X_sat)
        
        return self._descend_systematic(X_free)

    def _descend_systematic(self, X_free):
        """Fallback: systematic removal."""
        X_list = list(X_free)
        
        if not X_list:
            return frozenset()
        
        var_freq = self._compute_var_frequency(X_list)
        X_list.sort(key=lambda v: var_freq[v], reverse=True)
        
        X_current = X_free
        
        for var in X_list:
            X_without = X_current - frozenset([var])
            
            if self.get_model_forall_lattice(X_without):
                # Try to add back vars
                for v in X_list:
                    if v not in X_without:
                        X_cand = X_without.union(frozenset([v]))
                        if self.get_model_forall_lattice(X_cand):
                            X_without = X_cand
                return frozenset(X_without)
            
            X_current = X_without
        
        return frozenset()
    
    def _search(self, assertion_vars):
        mhss = [self.get_mhs(assertion_vars)]
        free_sets = []
        for _ in range(5):
            mhs = mhss.pop()
            print(len(mhs), len(self.assertion_vars))
            if self.get_model_forall_lattice(mhs):
                free_sets.append(mhs)
                return free_sets
            else:
                free_set = self.descend_to_boundary(mhs)
                free_sets.append(free_set)
                new_mhs = self.get_mhs(assertion_vars, mhs - free_set)
                mhss.append(new_mhs)
        return free_sets
    
    def get_mhs(self, assertion_vars, to_ignore = set()):
        uncovered_sets = [frozenset(var_set) for var_set in assertion_vars]
        mhs = set()
        
        while uncovered_sets:
            var_freq = {}
            for var_set in uncovered_sets:
                for var in var_set:
                    if var not in mhs and var not in to_ignore:
                        var_freq[var] = var_freq.get(var, 0) + 1
            
            if not var_freq:
                break
            
            best_var = max(var_freq.keys(), key=lambda v: var_freq[v])
            mhs.add(best_var)
            
            uncovered_sets = [s for s in uncovered_sets if best_var not in s]
        
        return mhs
    
    def get_model_forall_lattice(self, x_univl):
        x_set = frozenset(x_univl)
        
        if any(unsat_set.issubset(x_set) for unsat_set in self.known_unsat):
            return False
        
        if any(x_set.issubset(sat_set) for sat_set in self.known_sat):
            return True
        
        self.sat_calls += 1
        result = get_model(ForAll(x_univl, self.formula), solver_name=self.sname)

        if result is not None:
            self.known_sat = {s for s in self.known_sat if not s.issubset(x_set)}
            self.known_sat.add(x_set)
        else:
            self.known_unsat = {s for s in self.known_unsat if not x_set.issubset(s)}
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

def run_get_mas(vf="../Variables/s38584.txt", sf="../Sygus/s38584.sl"):
    import time
    start = time.time()
    variables = get_variables(vf)
    matches = get_defined_funs(sf)

    m = MistralMHSLattice()
    d = {}
    assertions = {gen_vars_get_fun(a, d) for a in matches}
    print("vars: ", len(variables))
    mas = get_mas(assertions, d, m)
    print("MUS: ", len(m.fvars - mas))
    mas = {str(a) for a in mas}
    underspecified = variables - mas
    print("underspecified: ", len(underspecified))
    print("time: ", time.time() - start)
    return underspecified

import sys


if __name__ == '__main__':
    print(sys.argv)
    if len(sys.argv) == 2:
        vf = sys.argv[1]
        sf = f"../Sygus/{re.search(r'Variables\/(.*)\.txt', vf).group(1)}.sl"
        _ = run_get_mas(vf, sf)
    else:
        _ = run_get_mas()
