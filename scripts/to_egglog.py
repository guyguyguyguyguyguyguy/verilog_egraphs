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

(relation Root (Expr))
(relation True (Expr))
(relation False (Expr))

{'\n'.join(f'(Root {a} )' for a in assertions)}

(rule
 ((Not ?a))
 ((False ?a)))

(rule
  ((= ?c (And ?a ?b))
   (False ?a))
  ((False ?c)))

(rule 
 ((= ?c (Not ?a))
  (False ?a))
 ((True ?c)))

(rule
 ((Root (Not ?a)))
 ((False ?a)))

(rule
 ((True (Not ?a)))
 ((False ?a)))

(rule 
 ((True (And ?a ?b)))
 ((True ?a) (True ?b)))

(rule
 ((Root ?a))
 ((True ?a)))

(rule
 ((Or ?a ?b)
  (False ?a))
 ((True ?b)))

(rule
 ((Eq ?a ?b)
  (False ?a))
 ((False ?b)))

(rule
 ((Eq ?a ?b)
  (True ?a))
 ((True ?b)))

(rule
 ((True (Eq ?a (And ?a ?b)))
  (True ?a))
 ((True ?b)))

(rule
 ((= ?c (Eq ?a (Or ?a ?b)))
  (True ?c))
 ((union ?a ?c)))

(rule
 ((False ?a)
  (= ?c (And ?a ?b)))
 ((False ?c)))

(rule
 ((True ?a)
  (= ?c (Or ?a ?b)))
 ((True ?c)))

(rule
 ((True ?a)
  (= ?c (Not ?a)))
 ((False ?c)))

(rule
 ((False ?a)
  (= ?c (Not ?a)))
 ((True ?c)))

(rule 
 ((= ?c (And ?a ?b))
  (Root ?c)
  (True ?a))
 ((union ?c ?b)))

(rule
 ((= ?c (Or ?a ?b))
  (Root ?c)
  (False ?a))
 ((union ?c ?b)))

(rule
 ((= ?c (Eq ?a ?b))
  (Root ?c)
  (True ?a))
 ((union ?c ?b)))

(rewrite (Or ?a ?b) (Or ?b ?a))
(rewrite (And ?a ?b) (And ?b ?a))
(rewrite (Eq ?a ?b) (Eq ?b ?a))

;(print "Sizes before running:")
(print-size Root)
(print-size True)
(print-size False)

(run 20)

(print-size Root)
(print-size True)
(print-size False)
"""


out_file = file.removesuffix('.sl').removeprefix('Sygus/')
with open(f"egglog/{out_file}.egg", 'w') as f:
    f.write(output)
