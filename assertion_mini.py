import re
from z3 import *

def_pat = re.compile(r'.*define-fun.*')
func_pat = re.compile(r'Bool\s+(.*)\)')
var_pat = re.compile(r'\((\w+)\s+(?:(Bool)|\(_\s+(BitVec)\s+(\d+)\))\)')

def generate_vars(new_def, d):
    for m in var_pat.findall(new_def):
        match m:
            case [n, '', bv, w]:
                tmp = BitVec(n, int(w))
            case [n, b, '', '']:
                tmp = Bool(n)

        d[n] = tmp

sum = 0
def check_new_expr(new_expr, exprs, d):
    global sum
    assertion = f"""
    (assert (not
        (implies
            (and {(' ').join(exprs)})
            {new_expr})
    ))
    """
    z3_assertion = parse_smt2_string(assertion, decls=d)
    s = Solver()
    s.add(z3_assertion)
    match s.check():
        case z3.sat:
            exprs.add(new_expr)


def run(file = 'Sygus/ibex_controller.sl'):

    with open(file, 'r') as f:
        content = f.read()
        matches = def_pat.findall(content)
        matches = {m for m in matches}

    """
    not [A => B] is unsat
    """

    d = {}
    m = iter(matches)
    start = next(m)
    generate_vars(start, d)
    new_expr = func_pat.search(start).group(1)
    A = set([new_expr])
    all_A = set([new_expr])
    for i, f in enumerate(m):
        generate_vars(f, d)
        new_expr = func_pat.search(f).group(1)
        if new_expr in all_A:
            continue
        all_A.add(new_expr)
        check_new_expr(new_expr, A, d)
    before = len(all_A)
    after = len(A)
    # print(f"Before: {before}\nAfter: {after}")

    return before, after


def check_expr(new_expr, exprs, d, required_exprs):
    s = Solver()
    s.set(unsat_core=True)

    # Add each expression from exprs as a separate tracked assertion
    for i, expr in enumerate(exprs):
        assertion = f"(assert {expr})"
        parsed_expr = parse_smt2_string(assertion, decls=d)
        s.assert_and_track(parsed_expr[0], str(expr))

    # Add the negation of new_expr
    negated_assertion = f"(assert (not {new_expr}))"
    negated_new_expr = parse_smt2_string(negated_assertion, decls=d)
    s.add(negated_new_expr[0])

    match s.check():
        case z3.unsat:
            core = s.unsat_core()
            required_exprs[new_expr] = core

def run_optimal(file = 'Sygus/ibex_controller.sl'):
    with open(file, 'r') as f:
        content = f.read()
        matches = def_pat.findall(content)
        matches = {m for m in matches}

    """
    not [A => B] is unsat
    """
    from collections import defaultdict
    required_exprs = {}

    A = set(map(lambda m: func_pat.search(m).group(1), matches))
    a = list(A)
    before = len(A)
    d = {}
    for f in iter(matches):
        generate_vars(f, d)

    for e, Ap in [(e, a[:i] + a[i+1:]) for i, e in enumerate(a)]:
        check_expr(e, Ap, d, required_exprs)

    largest_unneeded = find_max_independent_set(required_exprs)
    after = A - largest_unneeded

    return before, len(after)

def handler(s, f):
    raise Exception("timeout")

def run_all(incremental: bool = False):
    from os import listdir
    import matplotlib.pyplot as plt
    import numpy as np
    import signal

    befores = []
    afters  = []
    files   = []

    for file in listdir("Sygus"):
        signal.signal(signal.SIGALRM, handler)
        signal.alarm(10)
        try:
            signal.signal(signal.SIGALRM, handler)
            signal.alarm(30)
            if incremental:
                b, a = run(f"Sygus/{file}")
            else:
                b, a = run_optimal(f"Sygus/{file}")
        except Exception:
            continue
        finally:
            signal.alarm(0)
            import gc
            gc.collect()

        print(file)
        print(f"\t{'before:':<8} {b:>10}")
        print(f"\t{'after:':<8} {a:>10}")
        befores.append(b)
        afters.append(a)
        files.append(file)

    x = np.arange(len(files))
    width = 0.35

    # Style
    plt.style.use('ggplot')  # optional style baseline

    fig, ax = plt.subplots(figsize=(14, 6), facecolor='#f7f7f7')
    ax.set_facecolor('#fdfdfd')  # inner plot background

    # Custom colours
    color_before = '#4c72b0'
    color_after = '#dd8452'

    rects1 = ax.bar(x - width/2, befores, width, label='Before', color=color_before)
    rects2 = ax.bar(x + width/2, afters, width, label='After', color=color_after)

    # Labels and title
    ax.set_ylabel('Value', fontsize=12)
    ax.set_title('Before and After Comparison per File', fontsize=14, weight='bold', pad=15)
    ax.set_xticks(x)
    ax.set_xticklabels(files, rotation=45, ha='right', fontsize=9)
    ax.legend(frameon=False, fontsize=11)

    # Grid
    ax.grid(axis='y', linestyle='--', alpha=0.6)
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)

    # Annotate bars with values
    def autolabel(rects):
        for rect in rects:
            height = rect.get_height()
            ax.annotate(f'{height}',
                        xy=(rect.get_x() + rect.get_width()/2, height),
                        xytext=(0, 4),
                        textcoords="offset points",
                        ha='center', va='bottom',
                        fontsize=8)

    autolabel(rects1)
    autolabel(rects2)

    fig.tight_layout()
    plt.show()



# TODO: Need to find a way to do mapping between dimacs and original variable names
def to_dimacs(file, mapping):
    with open(file, 'r') as f:
        content = f.read()
        matches = def_pat.findall(content)
        matches = {m for m in matches}

    d = {}
    m = iter(matches)
    start = next(m)
    generate_vars(start, d)
    new_expr = func_pat.search(start).group(1)
    A = set([new_expr])
    all_A = set()
    for f in m:
        generate_vars(f, d)
        new_expr = func_pat.search(f).group(1)
        all_A.add(new_expr)

    poop = f"(assert (and {' '.join(all_A)}))"
    g = Goal()
    tmp = z3.parse_smt2_string(poop, decls=d)
    g.add(tmp)
    t = Then('simplify', 'bit-blast', 'aig', 'bv-slice', 'ctx-simplify', 'tseitin-cnf')
    tt = Then('bit-blast', 'tseitin-cnf')
    res = t(g)
    res_ns = tt(g)
    return res[0].dimacs(), res, res_ns


def from_dimacs(dimacs, mapping):
    s = Solver()
    s.from_string(dimacs)
    return s.assertions()


import igraph as ig

import igraph as ig

def find_max_independent_set(data):
    keys = list(data.keys())
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

import multiprocessing as mp
import os
import matplotlib.pyplot as plt
import numpy as np
import gc

def run_worker(filepath, incremental, queue):
    try:
        if incremental:
            result = run(filepath)
        else:
            result = run_optimal(filepath)
        queue.put((filepath, result[0], result[1]))
    except Exception as e:
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
            filepath, b, a = queue.get()
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

    if not files:
        print("No files processed.")
        return

    # Plotting
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
    plt.show()


if __name__ == "__main__":
    run_all()
