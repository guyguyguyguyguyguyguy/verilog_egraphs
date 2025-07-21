

(declare-sort |arb2_s| 0)
(declare-fun |arb2_is| (|arb2_s|) Bool)

(declare-fun |arb2#0| (|arb2_s|) (_ BitVec 1)) 

(define-fun |arb2_n $auto$async2sync.cc:228:execute$16| ((state |arb2_s|)) Bool (= ((_ extract 0 0) (|arb2#0| state)) #b1))
(declare-fun |arb2#1| (|arb2_s|) Bool) 




(define-fun |arb2_n CK| ((state |arb2_s|)) Bool (|arb2#1| state))
(declare-fun |arb2#2| (|arb2_s|) (_ BitVec 1)) 
(declare-fun |arb2#3| (|arb2_s|) (_ BitVec 1)) 
(define-fun |arb2#4| ((state |arb2_s|)) (_ BitVec 1) (bvnot (|arb2#3| state))) 
(define-fun |arb2#5| ((state |arb2_s|)) (_ BitVec 1) (bvand (|arb2#2| state) (|arb2#4| state))) 
(declare-fun |arb2#6| (|arb2_s|) (_ BitVec 1)) 
(define-fun |arb2#7| ((state |arb2_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|arb2#6| state)) #b1) #b0 (|arb2#0| state))) 
(define-fun |arb2#8| ((state |arb2_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|arb2#7| state)) #b1) (|arb2#5| state) (|arb2#2| state))) 

(define-fun |arb2_n gnt1| ((state |arb2_s|)) Bool (= ((_ extract 0 0) (|arb2#8| state)) #b1))
(define-fun |arb2#9| ((state |arb2_s|)) (_ BitVec 1) (bvnot (|arb2#2| state))) 
(define-fun |arb2#10| ((state |arb2_s|)) (_ BitVec 1) (bvand (|arb2#3| state) (|arb2#9| state))) 
(define-fun |arb2#11| ((state |arb2_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|arb2#7| state)) #b1) (|arb2#3| state) (|arb2#10| state))) 

(define-fun |arb2_n gnt2| ((state |arb2_s|)) Bool (= ((_ extract 0 0) (|arb2#11| state)) #b1))


(define-fun |arb2_n req1| ((state |arb2_s|)) Bool (= ((_ extract 0 0) (|arb2#2| state)) #b1))


(define-fun |arb2_n req2| ((state |arb2_s|)) Bool (= ((_ extract 0 0) (|arb2#3| state)) #b1))


(define-fun |arb2_n rst| ((state |arb2_s|)) Bool (= ((_ extract 0 0) (|arb2#6| state)) #b1))
(define-fun |arb2#12| ((state |arb2_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|arb2#6| state)) #b1) #b0 (|arb2#8| state))) 
(define-fun |arb2_a| ((state |arb2_s|)) Bool true)
(define-fun |arb2_u| ((state |arb2_s|)) Bool true)
(define-fun |arb2_i| ((state |arb2_s|)) Bool true)
(define-fun |arb2_h| ((state |arb2_s|)) Bool true)
(define-fun |arb2_t| ((state |arb2_s|) (next_state |arb2_s|)) Bool 
  (= (|arb2#12| state) (|arb2#0| next_state)) 
) 


