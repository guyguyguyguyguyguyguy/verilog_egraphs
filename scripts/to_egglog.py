import sys
import re

file = sys.argv[1]

# Match the define-fun structure and extract the body expression
func_pat = re.compile(r'Bool\s+(.*)')

with open(file, 'r') as f:
    content = f.read()
    matches = func_pat.findall(content)
    matches = {m[:-1] for m in matches}

operators = {
    'or':   'Or',
    'and':  'And',
    '=':    'Eq',
    'not':  'Not'
}

op_pattern = re.compile(r'(?<!\w)(' + '|'.join(re.escape(op) for op in operators.keys()) + r')(?!\w)')
excluded = '|'.join(re.escape(k) + r'\b' for k in operators.keys())
var_pat = re.compile(rf"\b(?!{excluded})\w+\b")


assertions = map(lambda s: var_pat.sub(lambda m: f'(Var "{m.group(0)}")', s), matches)
assertions = map(lambda s: op_pattern.sub(lambda m: operators[m.group(1)], s), assertions)


output = f"""(datatype Expr
	(Var String) 
    (Bool bool)
    (Not Expr)
    (And Expr Expr)
    (Or Expr Expr)
    (Eq Expr Expr))

{'\n'.join(assertions)}

(rule (
	(Not ?a)
    (And ?a ?b)
)(
  (union ?b (Bool true))
))

(run 1)"""


out_file = file.removesuffix('.sl').removeprefix('Sygus/')
with open(f"egglog/{out_file}.egg", 'w') as f:
    f.write(output)
