(set-logic UF)
(declare-var x Bool)

(synth-fun f ((x Bool)) Bool
    ; declare a list of nonterminal symbols
    ((Start Bool))
    ; define the grammar
    (
        ; rules for nonterminal symbol 1
        (Start Bool
            (x 
            
            (not Start)
            (= Start Start)
            (and Start Start)
            (or Start Start)
            )
        )
    )
)

(constraint (= (f x) (not x)))

(check-synth)
