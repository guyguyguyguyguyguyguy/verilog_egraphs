(declare-fun a () (_ BitVec 64))
(declare-fun b () (_ BitVec 64))

(define-fun f ((x (_ BitVec 64)) (y (_ BitVec 64))) (_ BitVec 64) (bvsub a b))
(define-fun g ((x (_ BitVec 64)) (y (_ BitVec 64))) (_ BitVec 64) (bvneg (bvsub b a)))

(assert (not (= (f a b) (g a b))))

(check-sat)
