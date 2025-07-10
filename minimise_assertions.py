import re
import z3
import igraph as ig

import multiprocessing as mp
import os
import matplotlib.pyplot as plt
import numpy as np
import gc



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
    m = iter(matches)
    assertion = gen_vars_get_fun(next(m), d)
    A = set([assertion])
    all_unique_assertions = A.copy()
    for f in m:
        assertion = gen_vars_get_fun(next(m), d)
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
        print(e)
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
