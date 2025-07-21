

(declare-sort |c17_s| 0)
(declare-fun |c17_is| (|c17_s|) Bool)
(declare-fun |c17#0| (|c17_s|) Bool) 


(define-fun |c17_n CK| ((state |c17_s|)) Bool (|c17#0| state))
(declare-fun |c17#1| (|c17_s|) Bool) 


(define-fun |c17_n N1| ((state |c17_s|)) Bool (|c17#1| state))
(declare-fun |c17#2| (|c17_s|) Bool) 


(define-fun |c17_n N2| ((state |c17_s|)) Bool (|c17#2| state))
(declare-fun |c17#3| (|c17_s|) (_ BitVec 1)) 
(define-fun |c17#4| ((state |c17_s|)) (_ BitVec 1) (bvand (ite (|c17#1| state) #b1 #b0) (|c17#3| state))) 
(define-fun |c17#5| ((state |c17_s|)) (_ BitVec 1) (bvnot (|c17#4| state))) 
(declare-fun |c17#6| (|c17_s|) (_ BitVec 1)) 
(define-fun |c17#7| ((state |c17_s|)) (_ BitVec 1) (bvand (|c17#3| state) (|c17#6| state))) 
(define-fun |c17#8| ((state |c17_s|)) (_ BitVec 1) (bvnot (|c17#7| state))) 
(define-fun |c17#9| ((state |c17_s|)) (_ BitVec 1) (bvand (ite (|c17#2| state) #b1 #b0) (|c17#8| state))) 
(define-fun |c17#10| ((state |c17_s|)) (_ BitVec 1) (bvnot (|c17#9| state))) 
(define-fun |c17#11| ((state |c17_s|)) (_ BitVec 1) (bvand (|c17#5| state) (|c17#10| state))) 
(define-fun |c17#12| ((state |c17_s|)) (_ BitVec 1) (bvnot (|c17#11| state))) 

(define-fun |c17_n N22| ((state |c17_s|)) Bool (= ((_ extract 0 0) (|c17#12| state)) #b1))
(declare-fun |c17#13| (|c17_s|) (_ BitVec 1)) 
(define-fun |c17#14| ((state |c17_s|)) (_ BitVec 1) (bvand (|c17#8| state) (|c17#13| state))) 
(define-fun |c17#15| ((state |c17_s|)) (_ BitVec 1) (bvnot (|c17#14| state))) 
(define-fun |c17#16| ((state |c17_s|)) (_ BitVec 1) (bvand (|c17#10| state) (|c17#15| state))) 
(define-fun |c17#17| ((state |c17_s|)) (_ BitVec 1) (bvnot (|c17#16| state))) 

(define-fun |c17_n N23| ((state |c17_s|)) Bool (= ((_ extract 0 0) (|c17#17| state)) #b1))


(define-fun |c17_n N3| ((state |c17_s|)) Bool (= ((_ extract 0 0) (|c17#3| state)) #b1))


(define-fun |c17_n N6| ((state |c17_s|)) Bool (= ((_ extract 0 0) (|c17#6| state)) #b1))


(define-fun |c17_n N7| ((state |c17_s|)) Bool (= ((_ extract 0 0) (|c17#13| state)) #b1))
(define-fun |c17_a| ((state |c17_s|)) Bool true)
(define-fun |c17_u| ((state |c17_s|)) Bool true)
(define-fun |c17_i| ((state |c17_s|)) Bool true)
(define-fun |c17_h| ((state |c17_s|)) Bool true)
(define-fun |c17_t| ((state |c17_s|) (next_state |c17_s|)) Bool true) 


