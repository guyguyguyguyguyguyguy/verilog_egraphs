(declare-fun x () (_ BitVec 64))
(declare-fun y () (_ BitVec 64))

(define-fun f ((x (_ BitVec 64)) (y (_ BitVec 64))) (_ BitVec 64) (bvand x y))
(define-fun g ((x (_ BitVec 64)) (y (_ BitVec 64))) (_ BitVec 64) (bvsub x (bvand x (bvnot y))))

(assert (not (= (f x y) (g x y))))
(check-sat)

