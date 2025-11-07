import re

from collections import defaultdict
from cvc5.pythonic import *


seen_mus = []
seen_notmus = []

solver = Solver()
solver.setOption("produce-proofs", "true") 
solver.setOption("produce-models", "true") 
solver.setOption("proof-format-mode", "dot")

def get_mus(v_file, a_file):
    assertions, all_vars_inq, vars_per_assertion = get_assertions(a_file)   
    variables = get_variables(v_file)

    msas = search_msas(assertions, vars_per_assertion, all_vars_inq)
    best_msa =min(msas, key=len)
    amus = all_vars_inq - best_msa
    best_msa = set(map(str, best_msa))

    return variables - best_msa, best_msa,amus

def search_msas(assertions, vars_per_assertion, all_vars, its=2):
    mhs = approx_mhs(vars_per_assertion)
    msas = []
    for  _ in range(its):
        match is_mus(all_vars - mhs, assertions):
            case [True, _]: 
                print(len(mhs))
                # descend_to_boundary(mhs, query)
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

def approx_mhs(vars_per_assertion,*, T=set()):
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
    phi = ForAll(list(cand), assertions)
    solver.add(phi)
    if solver.check() == sat:
        seen_mus = {m for m in seen_mus if not m.issubset(cand)}
        seen_mus.add(frozenset(cand))
        solver.pop()
        return True, None
    else:
        sat_notmus = {n for n in seen_notmus if not cand.issubset(n)}
        sat_notmus.add(frozenset(cand))
        proof = solver.proof()
        solver.pop()
        return False, proof

def ascend_to_boundary(mhs ,all_vars, assertions, proof):
    specified_vars = witnesses(all_vars - mhs, assertions, proof)
    msa = mhs.union(specified_vars)
    while not (ret := is_mus(msa, assertions))[0]:
        msa.update(witnesses(all_vars - msa, assertions, ret[1]))
    assert is_mus(msa, assertions)[0]
    return msa

def witnesses(cand, assertions, proof):
    vvars = handle_rules(cand, proof, assertions.children())
    var_sets = [set() for _ in vvars]
    for vvs in zip(*vvars):
        for i, vs in enumerate(var_sets):
            vs.add(vvs[i])
            cand_p = cand - vs
            if is_sat_forall(cand_p, assertions):
                return cand - cand_p
    return {x for y in vvars for x in y}

def get_assertions(file):
    func_pat = re.compile(r"(?:Bool|\(_\s+BitVec\s+\d+\))\s+(.*)\)")
    var_pat = re.compile(r"\((\w+)\s+(?:(Bool)|\(_\s+(BitVec)\s+(\d+)\))\)")

    assertions = set()
    env = {}
 
    with open(file, 'r') as f:
        for l in f.readlines():
            if (body := func_pat.search(l)) is not None:
                expr = body.group(1)
                for m in var_pat.findall(l):
                    match m:
                        case [n, "", _, w]:  env[n] = BitVec(n, int(w))
                        case [n, _, "", ""]: env[n] = Bool(n)
                assertions.add(parse_body_to_cvc5(expr, env=env))

    assertions = And(*assertions)
    free_vars = free_variables(assertions)
    return assertions, frozenset(free_vars), [frozenset(free_variables(a)) for a in assertions.children()]


# Helpers 

def _tok(s: str):
    s = s.replace('(', ' ( ').replace(')', ' ) ')
    return [t for t in s.split() if t]

def _parse(tokens):
    t = tokens.pop(0)
    if t == '(':
        lst = []
        while tokens[0] != ')':
            lst.append(_parse(tokens))
        tokens.pop(0)
        return lst
    elif t == ')':
        raise ValueError('unmatched )')
    else:
        return t

def _eval(ast, env, bv_widths):
    if isinstance(ast, str):
        if ast == 'true':  return BoolVal(True)
        if ast == 'false': return BoolVal(False)
        # use declared symbol if present; otherwise assume Bool
        if ast in env:
            return env[ast]
        v = Bool(ast)
        env[ast] = v
        return v

    if isinstance(ast, list) and len(ast) == 3 and ast[0] == '_' and str(ast[1]).startswith('bv'):
        val = int(str(ast[1])[2:]); width = int(ast[2])
        return BitVecVal(val, width)

    op, *args = ast
    if op == 'and':  return And(*[_eval(a, env, bv_widths) for a in args])
    if op == 'or':   return Or(*[_eval(a, env, bv_widths) for a in args])
    if op == 'not':  return Not(_eval(args[0], env, bv_widths))
    if op == 'xor':  return Xor(_eval(args[0], env, bv_widths), _eval(args[1], env, bv_widths))
    if op == '=>':   return Implies(_eval(args[0], env, bv_widths), _eval(args[1], env, bv_widths))
    if op == 'ite':
        c,a,b = (_eval(x, env, bv_widths) for x in args)
        return If(c,a,b)
    if op == '=':
        a = _eval(args[0], env, bv_widths); b = _eval(args[1], env, bv_widths)
        return a == b
    # simple BV ops (extend as needed)
    if op == 'bvnot': return ~_eval(args[0], env, bv_widths)
    if op == 'bvand': return _eval(args[0], env, bv_widths) & _eval(args[1], env, bv_widths)
    if op == 'bvor':  return _eval(args[0], env, bv_widths) | _eval(args[1], env, bv_widths)
    if op == 'bvxor': return _eval(args[0], env, bv_widths) ^ _eval(args[1], env, bv_widths)
    if op == 'bvadd': return _eval(args[0], env, bv_widths) + _eval(args[1], env, bv_widths)
    if op == 'bvsub': return _eval(args[0], env, bv_widths) - _eval(args[1], env, bv_widths)
    if op == 'bvmul': return _eval(args[0], env, bv_widths) * _eval(args[1], env, bv_widths)
    if op == 'bvneg': return -_eval(args[0], env, bv_widths)
    if op == 'concat': return Concat(*[_eval(a, env, bv_widths) for a in args])
    if op == 'bvult':
        a,b = _eval(args[0], env, bv_widths), _eval(args[1], env, bv_widths)
        return ULT(a,b)
    if op == 'bvule':
        a,b = _eval(args[0], env, bv_widths), _eval(args[1], env, bv_widths)
        return ULE(a,b)
    if op == 'bvugt':
        a,b = _eval(args[0], env, bv_widths), _eval(args[1], env, bv_widths)
        return UGT(a,b)
    if op == 'bvuge':
        a,b = _eval(args[0], env, bv_widths), _eval(args[1], env, bv_widths)
        return UGE(a,b)

    # unknown operator -> treat as symbol (rare in bodies)
    return env[op]

def parse_body_to_cvc5(body: str, *, env, bv_widths=None):
    tokens = _tok(body)
    ast = _parse(tokens)
    return _eval(ast, env, bv_widths or {})

def rel_rule(p):
    c ,= p.getChildren()
    while c.getRule().name not in ["CONTRA", "EQ_RESOLVE"]:
        c ,= c.getChildren()

    return c, c.getRule().name

def handle_rules(cand, p, assertions):
    match rel_rule(p):
        case (c, "CONTRA"):
            return get_contra_vars(cand, c, assertions)
        case (c, "EQ_RESOLVE"):
            return get_eqres_vars(cand, c, assertions)
        case _: 
            raise NotImplementedError("Need to add more")

def get_contra_vars(cand, con, assertions):
    r_vars = []
    c1, c2 =  con.getChildren()
    c1idx, c2idx = c1.getArguments()[0].as_long(), c2.getArguments()[0].as_long()
    ra = [assertions[c1idx], assertions[c2idx]]
    for a in ra:
        vs = set()
        vs = free_variables(a)
        r_vars.append(cand & vs)
    return r_vars

# TODO: This does not work!!!!!
def get_eqres_vars(cand, eqr, assertions):
    c ,= [c for c in eqr.getChildren() if c.getRule().name != 'ASSUME']
    rhs = c
    while (ch := rhs.getChildren()):
        rhs = ch[-1]

    idxs = [i for i, x in enumerate(rhs.getArguments()[0].children()[0].children()) if is_false(x)]
    ra = [assertions[idx] for idx in idxs]
    r_vars = []
    for a in ra:
        vs = set()
        vs = free_variables(a)
        r_vars.append(cand & vs)
    return r_vars

def is_sat_forall(vars_set, query):
    solver.push()
    solver.add(ForAll(list(vars_set), query))
    r = solver.check()
    solver.pop()
    return r == sat

def free_variables(a):
    vs = set()
    stack = [a]
    while stack:
        t = stack.pop()
        if (cs := t.children()):
            stack.extend(cs)
        else:
            vs.add(t)
    return vs

def get_variables(file):
    with open(file, "r") as f:
        variables = set(v for v in f.read().split())
    return variables


get_mus("../Variables/s1238.txt", '../Sygus/s1238.sl')
