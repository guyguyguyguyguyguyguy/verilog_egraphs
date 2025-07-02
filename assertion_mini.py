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

def check_new_expr(new_expr, exprs, d):
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
    for f in m:
        generate_vars(f, d)
        new_expr = func_pat.search(f).group(1)
        all_A.add(new_expr)
        check_new_expr(new_expr, A, d)
    before = len(all_A)
    after = len(A)
    # print(f"Before: {before}\nAfter: {after}")

    return before, after

def handler(s, f):
    raise Exception("timeout")

def run_all():
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
            signal.alarm(10)
            b, a = run(f"Sygus/{file}")
        except Exception:
            continue
        finally:
            signal.alarm(0)
            import gc
            gc.collect()  # force cleanup of any stray Z3 references

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
    t_nonsimply = Then('bit-blast', 'tseitin-cnf')
    res = t(g)
    res_simp = t_nonsimply(g)
    return res[0].dimacs(), res, res_simp


def from_dimacs(dimacs, mapping):
    s = Solver()
    s.from_string(dimacs)
    return s.assertions()
