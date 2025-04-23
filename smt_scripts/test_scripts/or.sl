(set-logic UF)
(declare-var x Bool)
(declare-var y Bool)
(synth-fun f ((x Bool)(y Bool)) Bool
    ; declare a list of nonterminal symbols
    ((Start Bool))
    ; define the grammar
    (
        ; rules for nonterminal symbol 1
        (Start Bool
            (x 
            y
            (not Start)
            (= Start Start)
            (and Start Start)
            (or Start Start)
            )
        )
    )
)

(constraint (= (f x y) (or x y)))

(check-synth)
