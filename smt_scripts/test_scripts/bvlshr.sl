(set-logic BV)
(declare-var x (_ BitVec 64))
(declare-var y (_ BitVec 64))
(synth-fun f ((x (_ BitVec 64))(y (_ BitVec 64))) (_ BitVec 64)
    ; declare a list of nonterminal symbols
    ((Start (_ BitVec 64)) (StartBool Bool))
    ; define the grammar
    (
        ; rules for nonterminal symbol 1
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

    (StartBool Bool (
        (bvsge Start Start)
        (bvsle Start Start)
        (bvsgt Start Start)
        (bvslt Start Start)
        (bvuge Start Start)
        (bvule Start Start)
        (bvugt Start Start)
        (bvult Start Start)))

    )
)

(constraint (= (f x y) (bvlshr x y)))

(check-synth)
