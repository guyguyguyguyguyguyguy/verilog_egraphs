import re
import z3
import igraph as ig

import multiprocessing as mp
import os
import matplotlib.pyplot as plt
import numpy as np
import gc
import traceback

from io import StringIO


# Regex definitions
def_pat = re.compile(r'.*define-fun.*')
func_pat = re.compile(r'Bool\s+(.*)\)')
var_pat = re.compile(r'\((\w+)\s+(?:(Bool)|\(_\s+(BitVec)\s+(\d+)\))\)')

def get_defined_funs(file):
    with open(file, 'r') as f:
        content = f.read()
        matches = def_pat.findall(content)
        matches = {m for m in matches}
    return matches

# TODO: Can also formulate this as a minimum cover problem?
#   => Are these equivalent?
def find_max_independent_set(data):
    keys = list(data.keys())
    if len(keys) == 0:
        return {}
    g = ig.Graph()
    g.add_vertices(len(keys))

    key_to_idx = {key: i for i, key in enumerate(keys)}
    edges = []

    for key, value_list in data.items():
        for value_expr in value_list:
            value_str = str(value_expr)
            if value_str in keys:
                edges.append((key_to_idx[key], key_to_idx[value_str]))

    g.add_edges(edges)
    complement = g.complementer()
    max_clique = complement.largest_cliques()[0]
    return {keys[i] for i in max_clique}

def plot_assertion_sizes(files, befores, afters, inc, timeout):
    x = np.arange(len(files))
    width = 0.35
    plt.style.use('ggplot')

    fig, ax = plt.subplots(figsize=(14, 6), facecolor='#f7f7f7')
    ax.set_facecolor('#fdfdfd')

    rects1 = ax.bar(x - width/2, befores, width, label='Before', color='#4c72b0')
    rects2 = ax.bar(x + width/2, afters, width, label='After', color='#dd8452')

    ax.set_ylabel('Value', fontsize=12)
    ax.set_title('Before and After Comparison per File', fontsize=14, weight='bold', pad=15)
    ax.set_xticks(x)
    ax.set_xticklabels(files, rotation=45, ha='right', fontsize=9)
    ax.legend(frameon=False, fontsize=11)

    ax.grid(axis='y', linestyle='--', alpha=0.6)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)

    def autolabel(rects):
        for rect in rects:
            height = rect.get_height()
            ax.annotate(f'{height}', xy=(rect.get_x() + rect.get_width()/2, height),
                        xytext=(0, 4), textcoords="offset points",
                        ha='center', va='bottom', fontsize=8)

    autolabel(rects1)
    autolabel(rects2)
    fig.tight_layout()
    plt.savefig(f"assertion_minimisation_{'inc' if inc else ''}_{timeout}.pdf")

    plt.show()

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


m = Mistral()

def check_expr_incremental(new_expr, exprs, d):
    assertion = f"""
    (assert (not
        (implies
            (and {(' ').join(exprs)})
            {new_expr})
    ))
    """
    z3_assertion = z3.parse_smt2_string(assertion, decls=d)
    s = z3.Solver()
    s.add(z3_assertion)

    mus = m.solve(s.sexpr())
    print(mus)

    match s.check():
        case z3.sat:
            exprs.add(new_expr)

def check_expr_unsat_core(new_expr, exprs, d, required_exprs):
    s = z3.Solver()
    s.set(unsat_core=True)
    s.set(':core.minimize', True)

    for i, expr in enumerate(exprs):
        assertion = f"(assert {expr})"
        parsed_expr = z3.parse_smt2_string(assertion, decls=d)
        s.assert_and_track(parsed_expr[0], str(expr))

    negated_assertion = f"(assert (not {new_expr}))"
    negated_new_expr = z3.parse_smt2_string(negated_assertion, decls=d)
    s.add(negated_new_expr[0])

    match s.check():
        case z3.unsat:
            core = s.unsat_core()
            required_exprs[new_expr] = core

def incremental_assertion_check(file = 'Sygus/ibex_controller.sl'):
    matches = get_defined_funs(file)

    d = {}
    fst, *rst = matches
    first_assertion = gen_vars_get_fun(fst, d)
    A = {first_assertion}
    all_unique_assertions = A.copy()
    for f in rst:
        assertion = gen_vars_get_fun(f, d)
        if assertion in A:
            continue
        all_unique_assertions.add(assertion)
        check_expr_incremental(assertion, A, d)

    return len(all_unique_assertions), len(A)


def assertion_minimisation(file = 'Sygus/ibex_controller.sl'):
    matches = get_defined_funs(file)

    required_exprs = {}

    A = set(map(lambda m: func_pat.search(m).group(1), matches))
    a = list(A)
    d = {}
    for f in matches:
        generate_vars(f, d)

    for i, e in enumerate(A):
        Ap = a[:i] + a[i+1:]
        check_expr_unsat_core(e, Ap, d, required_exprs)
    largest_unneeded = find_max_independent_set(required_exprs)
    after = A - largest_unneeded

    return len(a), len(after)

def run_worker(filepath, incremental, queue):
    try:
        if incremental:
            result = incremental_assertion_check(filepath)
        else:
            result = assertion_minimisation(filepath)
        queue.put((filepath, result[0], result[1]))
    except Exception as e:
        traceback.print_exc()
        queue.put((filepath, None, None))

def run_all(incremental: bool = False, timeout: int = 300):
    befores = []
    afters = []
    files = []

    for file in os.listdir("Sygus"):
        if not file.endswith(".sl"):
            continue

        full_path = os.path.join("Sygus", file)
        queue = mp.Queue()
        p = mp.Process(target=run_worker, args=(full_path, incremental, queue))
        p.start()
        p.join(timeout)

        if p.is_alive():
            print(f"Timeout on file: {file}")
            p.terminate()
            p.join()
            continue

        if not queue.empty():
            _, b, a = queue.get()
            if b is None or a is None:
                print(f"Error on file: {file}")
                continue

            print(file)
            print(f"\t{'before:':<8} {b:>10}")
            print(f"\t{'after:':<8} {a:>10}")
            befores.append(b)
            afters.append(a)
            files.append(file)

        gc.collect()

    plot_assertion_sizes(files, befores, afters, incremental, timeout)

"""
What we want to do given a set of assertions A:
    => Give the algorithm(s) and complexity of finding the actual minimal set A' such that A <=> A'
    => Give assurences about the assertion minimisation algorithm
        -> It gives an A' such that A' <=> A
        -> When does it minimise
        -> How well does it minimise
        -> etc.

https://theory.stanford.edu/~aiken/publications/papers/cav12b.pdf
https://arxiv.org/pdf/1104.2312
https://en.wikipedia.org/wiki/Set_cover_problem
https://cstheory.stackexchange.com/questions/4238/complexity-of-finding-minimal-cover-of-fds
https://users.cms.caltech.edu/~umans/papers/BU07.pdf
https://dev.to/hebashakeel/minimal-cover-417l
"""

#==============================================================================
from pysmt.exceptions import SolverReturnedUnknownResultError
from pysmt.shortcuts import Bool, get_model, Not, Solver
#==============================================================================
def get_qmodel(x_univl, formula, maxiters=None, solver_name=None, verbose=False):
    """
        A simple 2QBF CEGAR implementation for SMT.
    """

    x_univl = set(x_univl)
    x_exist = formula.get_free_variables() - x_univl

    with Solver(name=solver_name) as asolver:
        asolver.add_assertion(Bool(True))
        iters = 0

        while maxiters is None or iters <= maxiters:
            iters += 1

            amodel = asolver.solve()
            if not amodel:
                return None
            else:
                cand = {v: asolver.get_value(v) for v in x_exist}
                subform = formula.substitute(cand).simplify()
                if verbose:
                    print('c qsolve cand{0}: {1}'.format(iters, cand))

                cmodel = get_model(Not(subform), solver_name=solver_name)
                if cmodel is None:
                    return cand
                else:
                    coex = {v: cmodel[v] for v in x_univl}
                    subform = formula.substitute(coex).simplify()
                    if verbose:
                        print('c qsolve coex{0}: {1}'.format(iters, coex))

                    asolver.add_assertion(subform)

        raise SolverReturnedUnknownResultError

#==============================================================================
from pysmt.smtlib.parser import SmtLibParser
from pysmt.shortcuts import Not, ForAll, is_sat, is_unsat, get_model, qelim
#==============================================================================
class Mistral:
    """
        Mistral solver class.
    """

    def __init__(self, simplify=True):
        """
            Constructor.
        """

        self.simplify = simplify
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

        # testing if formula is satisfiable
        if get_model(self.formula, solver_name=self.sname) == None:
            return None

        mus = self.compute_mus(frozenset([]), self.fvars, 0)
        return mus

    def compute_mus(self, X, fvars, lb):
        """
            Algorithm implements find_mus() procedure from Fig. 1
            of the dillig-cav12 paper.
        """

        if not fvars or len(fvars) <= lb:
            return frozenset()

        best = set()
        x = frozenset([next(iter(fvars))])  # should choose x in a more clever way

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
        """
            Calls either pysmt.shortcuts.get_model() or get_qmodel().
        """

        return get_qmodel(x_univl, self.formula, solver_name=self.sname,
                verbose=False)
