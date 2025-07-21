

(declare-sort |dff_s| 0)
(declare-fun |dff_is| (|dff_s|) Bool)
(declare-fun |dff#0| (|dff_s|) Bool) 


(define-fun |dff_n CK| ((state |dff_s|)) Bool (|dff#0| state))
(declare-fun |dff#1| (|dff_s|) Bool) 


(define-fun |dff_n D| ((state |dff_s|)) Bool (|dff#1| state))
(define-fun |dff#2| ((state |dff_s|)) (_ BitVec 1) (bvnot (ite (|dff#0| state) #b1 #b0))) 
(define-fun |dff#3| ((state |dff_s|)) (_ BitVec 1) (ite (|dff#1| state) (|dff#2| state) #b0)) 
(define-fun |dff#4| ((state |dff_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|dff#3| state)) #b1) #b0 (ite (|dff#0| state) #b1 #b0))) 
(define-fun |dff#5| ((state |dff_s|)) (_ BitVec 1) (bvnot (|dff#4| state))) 

(define-fun |dff_n Q| ((state |dff_s|)) Bool (= ((_ extract 0 0) (|dff#5| state)) #b1))
(define-fun |dff_a| ((state |dff_s|)) Bool true)
(define-fun |dff_u| ((state |dff_s|)) Bool true)
(define-fun |dff_i| ((state |dff_s|)) Bool true)
(define-fun |dff_h| ((state |dff_s|)) Bool true)
(define-fun |dff_t| ((state |dff_s|) (next_state |dff_s|)) Bool true) 

(declare-sort |s27_s| 0)
(declare-fun |s27_is| (|s27_s|) Bool)
(declare-fun |s27#0| (|s27_s|) Bool) 


(define-fun |s27_n CK| ((state |s27_s|)) Bool (|s27#0| state))
(declare-fun |s27#1| (|s27_s|) Bool) 


(define-fun |s27_n G0| ((state |s27_s|)) Bool (|s27#1| state))
(declare-fun |s27#2| (|s27_s|) Bool) 


(define-fun |s27_n G1| ((state |s27_s|)) Bool (|s27#2| state))


(declare-fun |s27#3| (|s27_s|) Bool) 
(declare-fun |s27_h DFF_0| (|s27_s|) |dff_s|)
(declare-fun |s27#4| (|s27_s|) (_ BitVec 1)) 
(define-fun |s27#5| ((state |s27_s|)) (_ BitVec 1) (bvnot (ite (|s27#1| state) #b1 #b0))) 


(declare-fun |s27#6| (|s27_s|) Bool) 
(declare-fun |s27_h DFF_1| (|s27_s|) |dff_s|)
(define-fun |s27#7| ((state |s27_s|)) (_ BitVec 1) (bvand (|s27#5| state) (ite (|s27#6| state) #b1 #b0))) 
(define-fun |s27#8| ((state |s27_s|)) (_ BitVec 1) (bvor (|s27#4| state) (|s27#7| state))) 


(declare-fun |s27#9| (|s27_s|) Bool) 
(declare-fun |s27_h DFF_2| (|s27_s|) |dff_s|)
(define-fun |s27#10| ((state |s27_s|)) (_ BitVec 1) (bvor (ite (|s27#2| state) #b1 #b0) (ite (|s27#9| state) #b1 #b0))) 
(define-fun |s27#11| ((state |s27_s|)) (_ BitVec 1) (bvnot (|s27#10| state))) 
(define-fun |s27#12| ((state |s27_s|)) (_ BitVec 1) (bvor (|s27#11| state) (|s27#7| state))) 
(define-fun |s27#13| ((state |s27_s|)) (_ BitVec 1) (bvand (|s27#8| state) (|s27#12| state))) 
(define-fun |s27#14| ((state |s27_s|)) (_ BitVec 1) (bvnot (|s27#13| state))) 
(define-fun |s27#15| ((state |s27_s|)) (_ BitVec 1) (bvor (ite (|s27#3| state) #b1 #b0) (|s27#14| state))) 

(define-fun |s27_n G17| ((state |s27_s|)) Bool (= ((_ extract 0 0) (|s27#15| state)) #b1))
(declare-fun |s27#16| (|s27_s|) Bool) 


(define-fun |s27_n G2| ((state |s27_s|)) Bool (|s27#16| state))


(define-fun |s27_n G3| ((state |s27_s|)) Bool (= ((_ extract 0 0) (|s27#4| state)) #b1))
(declare-fun |s27#17| (|s27_s|) Bool) 


(define-fun |s27_n GND| ((state |s27_s|)) Bool (|s27#17| state))
(declare-fun |s27#18| (|s27_s|) Bool) 


(define-fun |s27_n VDD| ((state |s27_s|)) Bool (|s27#18| state))
(define-fun |s27#19| ((state |s27_s|)) (_ BitVec 1) (bvnot (|s27#15| state))) 
(define-fun |s27#20| ((state |s27_s|)) (_ BitVec 1) (bvor (|s27#5| state) (|s27#19| state))) 
(define-fun |s27#21| ((state |s27_s|)) (_ BitVec 1) (bvnot (|s27#20| state))) 
(define-fun |s27#22| ((state |s27_s|)) (_ BitVec 1) (bvor (ite (|s27#16| state) #b1 #b0) (|s27#11| state))) 
(define-fun |s27#23| ((state |s27_s|)) (_ BitVec 1) (bvnot (|s27#22| state))) 
(define-fun |s27_a| ((state |s27_s|)) Bool (and
  (|dff_a| (|s27_h DFF_0| state))
  (|dff_a| (|s27_h DFF_1| state))
  (|dff_a| (|s27_h DFF_2| state))
))
(define-fun |s27_u| ((state |s27_s|)) Bool (and
  (|dff_u| (|s27_h DFF_0| state))
  (|dff_u| (|s27_h DFF_1| state))
  (|dff_u| (|s27_h DFF_2| state))
))
(define-fun |s27_i| ((state |s27_s|)) Bool (and
  (|dff_i| (|s27_h DFF_0| state))
  (|dff_i| (|s27_h DFF_1| state))
  (|dff_i| (|s27_h DFF_2| state))
))
(define-fun |s27_h| ((state |s27_s|)) Bool (and
  (= (|s27_is| state) (|dff_is| (|s27_h DFF_0| state)))
  (= (|s27#0| state) (|dff_n CK| (|s27_h DFF_0| state))) 
  (= (= ((_ extract 0 0) (|s27#21| state)) #b1) (|dff_n D| (|s27_h DFF_0| state))) 
  (= (|s27#3| state) (|dff_n Q| (|s27_h DFF_0| state))) 
  (= (|s27_is| state) (|dff_is| (|s27_h DFF_1| state)))
  (= (|s27#0| state) (|dff_n CK| (|s27_h DFF_1| state))) 
  (= (= ((_ extract 0 0) (|s27#19| state)) #b1) (|dff_n D| (|s27_h DFF_1| state))) 
  (= (|s27#6| state) (|dff_n Q| (|s27_h DFF_1| state))) 
  (= (|s27_is| state) (|dff_is| (|s27_h DFF_2| state)))
  (= (|s27#0| state) (|dff_n CK| (|s27_h DFF_2| state))) 
  (= (= ((_ extract 0 0) (|s27#23| state)) #b1) (|dff_n D| (|s27_h DFF_2| state))) 
  (= (|s27#9| state) (|dff_n Q| (|s27_h DFF_2| state))) 
  (|dff_h| (|s27_h DFF_0| state))
  (|dff_h| (|s27_h DFF_1| state))
  (|dff_h| (|s27_h DFF_2| state))
))
(define-fun |s27_t| ((state |s27_s|) (next_state |s27_s|)) Bool (and
  (|dff_t| (|s27_h DFF_0| state) (|s27_h DFF_0| next_state))
  (|dff_t| (|s27_h DFF_1| state) (|s27_h DFF_1| next_state))
  (|dff_t| (|s27_h DFF_2| state) (|s27_h DFF_2| next_state))
)) 

