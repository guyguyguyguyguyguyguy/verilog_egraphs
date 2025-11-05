import re
import random
import z3
import more_itertools

from collections import defaultdict
from io import StringIO
from pysmt.smtlib.parser import SmtLibParser
from pysmt.shortcuts import ForAll, get_model

seen_mus = []
seen_notmus = []

def get_mus(v_file, a_file):
    query, all_vars_inq, vars_per_assertion = get_assertions(a_file)   
    variables = get_variables(v_file)

    msas = search_msas(query, vars_per_assertion, all_vars_inq)
    best_msa =min(msas, key=len)
    amus = all_vars_inq - best_msa
    best_msa = set(map(str, best_msa))

    return query, variables - best_msa, best_msa, all_vars_inq, amus

def search_msas(query, vars_per_assertion, all_vars, its=5):
    mhs = approx_mhs(vars_per_assertion)
    msas = []
    for  _ in range(its):
        if is_mus(all_vars - mhs, query):
            print(len(mhs))
            # descend_to_boundary(mhs, query)
            msas.append(mhs)
        else:
            print('before: ', len(mhs))
            msa = ascend_to_boundary(mhs, vars_per_assertion,  all_vars, query)
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

def approx_mhs(vars_per_assertion,*, T=set()):
    uncovered = {x for x in vars_per_assertion if not x & T}
    T.add(most_frequent_var(uncovered))
    while uncovered:
        nv = most_frequent_var(uncovered)
        T.add(nv)
        uncovered = {x for x in uncovered if nv not in x} 
    return T

def is_mus(cand, query):
    global seen_mus, seen_notmus

    if any(cand.issubset(m) for m in seen_mus): 
        return True
    if any(n.issubset(cand) for n in seen_notmus):
        return False

    if get_model(ForAll(cand, query), solver_name='cvc5') is not None:
        seen_mus = {m for m in seen_mus if not m.issubset(cand)}
        seen_mus.add(frozenset(cand))
        return True
    else:
        sat_notmus = {n for n in seen_notmus if not cand.issubset(n)}
        sat_notmus.add(frozenset(cand))
        return False

def ascend_to_boundary(mhs ,vars_per_assertion, all_vars, query):
    specified_vars = approx_unsatcore(all_vars - mhs, vars_per_assertion,  query)
    msa = mhs.union(specified_vars)
    assert is_mus(msa, query)
    return msa

# will be a way to do this incrementally
def approx_unsatcore(cmus, vpa, query):
    specified = set()
    for i, (vs, a) in enumerate(zip(vpa, query.args())):
        qv = vs.intersection(cmus - specified) 
        if not qv or qv.issubset(specified):
            continue
        if not is_mus(qv, a):
            specified.update(qv)
    return specified

def get_assertions(file):
    func_pat = re.compile(r"(?:Bool|\(_\s+BitVec\s+\d+\))\s+(.*)\)")
    var_pat = re.compile(r"\((\w+)\s+(?:(Bool)|\(_\s+(BitVec)\s+(\d+)\))\)")

    d = {}
    exprs = set()
 
    with open(file, 'r') as f:
        for l in f.readlines():
            if (body := func_pat.search(l)) is not None:
                expr = body.group(1)
                for m in var_pat.findall(l):
                    match m:
                        case [n, "", _, w]:  d[n] = z3.BitVec(n, int(w))
                        case [n, _, "", ""]: d[n] = z3.Bool(n)
                exprs.add(expr)

    assertions = f"(assert (and {(' ').join(exprs)}))"
    s = z3.Solver()
    s.add(z3.parse_smt2_string(assertions, decls=d))

    script = SmtLibParser().get_script(StringIO(s.to_smt2()))
    query = script.get_last_formula().simplify()

    return query, query.get_free_variables(), [a.get_free_variables() for a in query.args()]

def get_variables(file):
    with open(file, "r") as f:
        variables = set(v for v in f.read().split())
    return variables
