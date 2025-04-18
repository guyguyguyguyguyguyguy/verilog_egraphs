(set-logic BV)

(declare-var x (_ BitVec 64))
(declare-var y (_ BitVec 64))


(synth-fun f ((x (_ BitVec 64))(y (_ BitVec 64))) (_ BitVec 64)
; declare a list of nonterminal symbols
((Start (_ BitVec 64)))
; define the grammar
(
; rules for nonterminal symbol 1
(Start (_ BitVec 64)
(x y
(bvneg Start)
(bvnot Start)
(bvadd Start Start)
(bvsub Start Start)
(bvand Start Start)
(bvmul Start Start)
(bvor Start Start)))
; rules for the next nonterminal symbol would go here
)
)

(constraint (= (f x y) (bvor x y)))

(check-synth)
