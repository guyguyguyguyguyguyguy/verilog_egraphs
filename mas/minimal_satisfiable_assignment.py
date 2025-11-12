from collections import defaultdict
from cvc5.pythonic import *

from utils import *


seen_mus = []
seen_notmus = []

solver = Solver()
solver.setOption("produce-models", "true") 
solver.set("produce-unsat-cores", "true")
solver.set("minimal-unsat-cores", "true")

def get_mus(v_file, a_file):
    iassertions, iall_vars_inq, ivars_per_assertion, lone_assertions = get_assertions(a_file)   
    variables = get_variables(v_file)

    msa = set()
    mus = set()
    for assertions, all_vars_inq, vars_per_assertion in zip(iassertions, iall_vars_inq, ivars_per_assertion):
        msas = search_msas(assertions, vars_per_assertion, all_vars_inq)
        best_msa = min(msas, key=len)
        amus = all_vars_inq - best_msa
        best_msa = set(map(str, best_msa))

        msa.update(best_msa)
        mus.update(amus)

    for la in lone_assertions:
        a ,= la
        fv = free_variables(a)
        best_msa = set(map(str, fv))
        msa.update(best_msa)

    return variables, variables - msa, msa, mus

def search_msas(assertions, vars_per_assertion, all_vars, its=1):
    mhs = approx_mhs(vars_per_assertion)
    msas = []
    for  _ in range(its):
        match is_mus(all_vars - mhs, assertions):
            case [True, _]: 
                msas.append(mhs)
            case [False, proof]:
                print('before: ', len(mhs))
                msa = ascend_to_boundary(mhs, all_vars, assertions, proof)
                print('after: ', len(msa))
                msas.append(msa)
                include = (msa - mhs)
                mhs = approx_mhs(vars_per_assertion, T=include)
    return msas

def most_frequent_var(vars_per_assertion):
    counter = defaultdict(int)
    for s in vars_per_assertion:
        for v in s:
            counter[v] +=1
    return max(counter, key=counter.get) 

def approx_mhs(vars_per_assertion, *, T=None):
    T = T or set()
    uncovered = {x for x in vars_per_assertion if not x & T}
    T.add(most_frequent_var(uncovered))
    while uncovered:
        nv = most_frequent_var(uncovered)
        T.add(nv)
        uncovered = {x for x in uncovered if nv not in x} 
    return T

def is_mus(cand, assertions):
    global seen_mus, seen_notmus

    if any(cand.issubset(m) for m in seen_mus): 
        return True, None
    if any(n.issubset(cand) for n in seen_notmus):
        return False, None

    solver.push()
    orig_as = list(assertions.children())
    tags = [Bool(f"@a{i}") for i in range(len(orig_as))]

    for t, a in zip(tags, orig_as):
        solver.add(Implies(t, ForAll(list(cand), a)))

    if solver.check(tags) == sat:
        seen_mus = {m for m in seen_mus if not m.issubset(cand)}
        seen_mus.add(frozenset(cand))
        solver.pop()
        return True, None
    else:
        seen_notmus = {n for n in seen_notmus if not cand.issubset(n)}
        seen_notmus.add(frozenset(cand))
        core_tags = set(solver.unsat_core())
        pas = [a for t, a in zip(tags, orig_as) if t in core_tags]
        solver.pop()
        return False, pas


def ascend_to_boundary(mhs ,all_vars, assertions, pas):
    minimal_vars = minimal_witnesses(mhs, pas)
    msa = mhs.union(minimal_vars)
    while not (ret := is_mus(all_vars - msa, assertions))[0]:
        w = minimal_witnesses(msa, ret[1])
        msa.update(w)
        print("Size of msa is: ", len(msa))
    assert is_mus(all_vars - msa, assertions)[0]
    return msa

def minimal_witnesses(msa, pas):
    d = DisjointSets(pas)
    rvs = [d.difference(msa) for d in d.var_ind_subsets()]
    return approx_mhs(rvs)


v, un, n, m = get_mus("../Variables/s1238.txt", '../Sygus/s1238.sl')
