(
(define-fun inv ((clk Bool) (gnt1 Bool) (gnt2 Bool) (req1 Bool) (rst Bool)) Bool (not (and gnt1 gnt2)))
)
(
(define-fun inv ((clk Bool) (gnt1 Bool) (gnt2 Bool) (rst Bool)) Bool (not (and gnt1 gnt2)))
)
(
(define-fun inv ((clk Bool) (gnt1 Bool) (gnt2 Bool) (req1 Bool)) Bool (not (and gnt1 gnt2)))
)
(
(define-fun inv ((clk Bool) (gnt1 Bool) (gnt2 Bool) (req1 Bool) (state Bool)) Bool (not (and gnt1 gnt2)))
)
(
(define-fun inv ((gnt2 Bool) (req1 Bool) (req2 Bool) (rst Bool)) Bool (or req1 (= gnt2 req2)))
)
(
(define-fun inv ((gnt1 Bool) (req1 Bool) (req2 Bool) (rst Bool)) Bool (= gnt1 (and gnt1 req1)))
)
(
(define-fun inv ((gnt1 Bool) (gnt2 Bool) (req1 Bool) (req2 Bool)) Bool (or gnt1 (= gnt2 req2)))
)
(
(define-fun inv ((clk Bool) (gnt1 Bool) (req1 Bool) (req2 Bool) (rst Bool)) Bool (= gnt1 (and gnt1 req1)))
)
(
(define-fun inv ((clk Bool) (gnt2 Bool) (req1 Bool) (req2 Bool)) Bool (= gnt2 (and gnt2 req2)))
)
(
(define-fun inv ((clk Bool) (gnt1 Bool) (req2 Bool) (state Bool)) Bool (not (and gnt1 (and req2 state))))
)
