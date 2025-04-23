(set-logic BV)
(declare-var x (_ BitVec 64))
(declare-var y (_ BitVec 64))
(synth-fun f ((x (_ BitVec 64))(y (_ BitVec 64))) Bool
    ; declare a list of nonterminal symbols
    ((StartBool Bool) (Start (_ BitVec 64)))
    ; define the grammar
    (
        ; rules for nonterminal symbol 1
            (StartBool Bool (
        (bvsge Start Start)
        (bvsle Start Start)
        (bvsgt Start Start)
        (bvslt Start Start)
        (bvuge Start Start)
        (bvule Start Start)
        (bvugt Start Start)
        (bvult Start Start)))

    (Start (_ BitVec 64)
        (x 
        y
        (bvneg Start)
        (bvnot Start)
        (bvand Start Start)
        (bvor Start Start)
        (bvxor Start Start)
        (bvadd Start Start)
        (bvsub Start Start)
        (bvmul Start Start)))

    )
)

(constraint (= (f x y) (bvule x y)))

(check-synth)
