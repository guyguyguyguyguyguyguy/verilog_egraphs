

(declare-sort |ibex_multdiv_slow_s| 0)
(declare-fun |ibex_multdiv_slow_is| (|ibex_multdiv_slow_s|) Bool)

(declare-fun |ibex_multdiv_slow#0| (|ibex_multdiv_slow_s|) (_ BitVec 32)) 

(define-fun |ibex_multdiv_slow_n $auto$async2sync.cc:228:execute$415| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (|ibex_multdiv_slow#0| state))

(declare-fun |ibex_multdiv_slow#1| (|ibex_multdiv_slow_s|) (_ BitVec 33)) 

(define-fun |ibex_multdiv_slow_n $auto$async2sync.cc:228:execute$413| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (|ibex_multdiv_slow#1| state))

(declare-fun |ibex_multdiv_slow#2| (|ibex_multdiv_slow_s|) (_ BitVec 33)) 

(define-fun |ibex_multdiv_slow_n $auto$async2sync.cc:228:execute$411| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (|ibex_multdiv_slow#2| state))

(declare-fun |ibex_multdiv_slow#3| (|ibex_multdiv_slow_s|) (_ BitVec 33)) 

(define-fun |ibex_multdiv_slow_n $auto$async2sync.cc:228:execute$409| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (|ibex_multdiv_slow#3| state))

(declare-fun |ibex_multdiv_slow#4| (|ibex_multdiv_slow_s|) (_ BitVec 5)) 

(define-fun |ibex_multdiv_slow_n $auto$async2sync.cc:228:execute$407| ((state |ibex_multdiv_slow_s|)) (_ BitVec 5) (|ibex_multdiv_slow#4| state))

(declare-fun |ibex_multdiv_slow#5| (|ibex_multdiv_slow_s|) (_ BitVec 3)) 

(define-fun |ibex_multdiv_slow_n $auto$async2sync.cc:228:execute$405| ((state |ibex_multdiv_slow_s|)) (_ BitVec 3) (|ibex_multdiv_slow#5| state))
(declare-fun |ibex_multdiv_slow#6| (|ibex_multdiv_slow_s|) Bool) 




(define-fun |ibex_multdiv_slow_n CK| ((state |ibex_multdiv_slow_s|)) Bool (|ibex_multdiv_slow#6| state))
(declare-fun |ibex_multdiv_slow#7| (|ibex_multdiv_slow_s|) (_ BitVec 34)) 


(define-fun |ibex_multdiv_slow_n alu_adder_ext_i| ((state |ibex_multdiv_slow_s|)) (_ BitVec 34) (|ibex_multdiv_slow#7| state))
(declare-fun |ibex_multdiv_slow#8| (|ibex_multdiv_slow_s|) (_ BitVec 32)) 


(define-fun |ibex_multdiv_slow_n alu_adder_i| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (|ibex_multdiv_slow#8| state))
(declare-fun |ibex_multdiv_slow#9| (|ibex_multdiv_slow_s|) (_ BitVec 1)) 
(define-fun |ibex_multdiv_slow#10| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#2| state) #b000000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow#11| ((state |ibex_multdiv_slow_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#5| state) #b000)) 
(define-fun |ibex_multdiv_slow#12| ((state |ibex_multdiv_slow_s|)) Bool (not (or  (= ((_ extract 0 0) (|ibex_multdiv_slow#11| state)) #b1) (= ((_ extract 1 1) (|ibex_multdiv_slow#11| state)) #b1) (= ((_ extract 2 2) (|ibex_multdiv_slow#11| state)) #b1)))) 
(define-fun |ibex_multdiv_slow#13| ((state |ibex_multdiv_slow_s|)) Bool (= (|ibex_multdiv_slow#11| state) #b001)) 
(define-fun |ibex_multdiv_slow#14| ((state |ibex_multdiv_slow_s|)) Bool (= (|ibex_multdiv_slow#11| state) #b010)) 
(define-fun |ibex_multdiv_slow#15| ((state |ibex_multdiv_slow_s|)) Bool (= (|ibex_multdiv_slow#11| state) #b101)) 
(define-fun |ibex_multdiv_slow#16| ((state |ibex_multdiv_slow_s|)) Bool (or  (|ibex_multdiv_slow#12| state) (|ibex_multdiv_slow#13| state) (|ibex_multdiv_slow#14| state) (|ibex_multdiv_slow#15| state))) 
(define-fun |ibex_multdiv_slow#17| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#16| state) #b000000000000000000000000000000001 (concat ((_ extract 31 0) (|ibex_multdiv_slow#10| state)) #b1))) 
(declare-fun |ibex_multdiv_slow#18| (|ibex_multdiv_slow_s|) Bool) 
(declare-fun |ibex_multdiv_slow#19| (|ibex_multdiv_slow_s|) Bool) 
(define-fun |ibex_multdiv_slow#20| ((state |ibex_multdiv_slow_s|)) Bool (not (or  (|ibex_multdiv_slow#18| state) (|ibex_multdiv_slow#19| state)))) 
(define-fun |ibex_multdiv_slow#21| ((state |ibex_multdiv_slow_s|)) Bool (= (concat (ite (|ibex_multdiv_slow#19| state) #b1 #b0) (ite (|ibex_multdiv_slow#18| state) #b1 #b0)) #b01)) 
(define-fun |ibex_multdiv_slow#22| ((state |ibex_multdiv_slow_s|)) Bool (or  (|ibex_multdiv_slow#20| state) (|ibex_multdiv_slow#21| state))) 
(define-fun |ibex_multdiv_slow#23| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#22| state) (|ibex_multdiv_slow#10| state) (|ibex_multdiv_slow#17| state))) 

(define-fun |ibex_multdiv_slow_n alu_operand_a_o| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (|ibex_multdiv_slow#23| state))
(define-fun |ibex_multdiv_slow#24| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#3| state) #b000000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow#25| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (bvnot ((_ extract 31 0) (|ibex_multdiv_slow#24| state)))) 
(define-fun |ibex_multdiv_slow#26| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (bvnot ((_ extract 31 0) (|ibex_multdiv_slow#10| state)))) 
(declare-fun |ibex_multdiv_slow#27| (|ibex_multdiv_slow_s|) (_ BitVec 32)) 
(define-fun |ibex_multdiv_slow#28| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (bvnot (|ibex_multdiv_slow#27| state))) 
(declare-fun |ibex_multdiv_slow#29| (|ibex_multdiv_slow_s|) (_ BitVec 32)) 
(define-fun |ibex_multdiv_slow#30| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (bvnot (|ibex_multdiv_slow#29| state))) 
(define-fun |ibex_multdiv_slow#31| ((state |ibex_multdiv_slow_s|)) Bool (or  (|ibex_multdiv_slow#12| state) (|ibex_multdiv_slow#14| state))) 
(define-fun |ibex_multdiv_slow#32| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#13| state) (concat (|ibex_multdiv_slow#30| state) #b1) (ite (|ibex_multdiv_slow#31| state) (concat (|ibex_multdiv_slow#28| state) #b1) (ite (|ibex_multdiv_slow#15| state) (concat (|ibex_multdiv_slow#26| state) #b1) (concat (|ibex_multdiv_slow#25| state) #b1))))) 
(define-fun |ibex_multdiv_slow#33| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#1| state) #b000000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow#34| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (bvand ((_ extract 31 0) (|ibex_multdiv_slow#33| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#24| state)) ((_ extract 0 0) (|ibex_multdiv_slow#24| state))))))))))))))))))))))))))))))))))) 
(define-fun |ibex_multdiv_slow#35| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvand ((_ extract 32 32) (|ibex_multdiv_slow#33| state)) ((_ extract 0 0) (|ibex_multdiv_slow#24| state)))) 
(define-fun |ibex_multdiv_slow#36| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvnot (|ibex_multdiv_slow#35| state))) 
(define-fun |ibex_multdiv_slow#37| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (bvnot (|ibex_multdiv_slow#34| state))) 
(define-fun |ibex_multdiv_slow#38| ((state |ibex_multdiv_slow_s|)) Bool (= (|ibex_multdiv_slow#11| state) #b100)) 
(define-fun |ibex_multdiv_slow#39| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#38| state) (concat (|ibex_multdiv_slow#35| state) (|ibex_multdiv_slow#37| state)) (concat (|ibex_multdiv_slow#36| state) (|ibex_multdiv_slow#34| state)))) 
(define-fun |ibex_multdiv_slow#40| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#20| state) (concat (|ibex_multdiv_slow#36| state) (|ibex_multdiv_slow#34| state)) (ite (|ibex_multdiv_slow#21| state) (|ibex_multdiv_slow#39| state) (|ibex_multdiv_slow#32| state)))) 

(define-fun |ibex_multdiv_slow_n alu_operand_b_o| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (|ibex_multdiv_slow#40| state))
(declare-fun |ibex_multdiv_slow#41| (|ibex_multdiv_slow_s|) Bool) 


(define-fun |ibex_multdiv_slow_n div_en_i| ((state |ibex_multdiv_slow_s|)) Bool (|ibex_multdiv_slow#41| state))
(declare-fun |ibex_multdiv_slow#42| (|ibex_multdiv_slow_s|) Bool) 


(define-fun |ibex_multdiv_slow_n equal_to_zero| ((state |ibex_multdiv_slow_s|)) Bool (|ibex_multdiv_slow#42| state))
(declare-fun |ibex_multdiv_slow#43| (|ibex_multdiv_slow_s|) Bool) 


(define-fun |ibex_multdiv_slow_n mult_en_i| ((state |ibex_multdiv_slow_s|)) Bool (|ibex_multdiv_slow#43| state))
(define-fun |ibex_multdiv_slow#44| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#41| state) (concat #b0 ((_ extract 31 0) (|ibex_multdiv_slow#10| state))) ((_ extract 32 0) (|ibex_multdiv_slow#7| state)))) 

(define-fun |ibex_multdiv_slow_n multdiv_result_o| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) ((_ extract 31 0) (|ibex_multdiv_slow#44| state)))


(define-fun |ibex_multdiv_slow_n op_a_i| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (|ibex_multdiv_slow#29| state))


(define-fun |ibex_multdiv_slow_n op_b_i| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (|ibex_multdiv_slow#27| state))


(define-fun |ibex_multdiv_slow_n operator_i| ((state |ibex_multdiv_slow_s|)) (_ BitVec 2) (concat (ite (|ibex_multdiv_slow#19| state) #b1 #b0) (ite (|ibex_multdiv_slow#18| state) #b1 #b0)))


(define-fun |ibex_multdiv_slow_n rst_ni| ((state |ibex_multdiv_slow_s|)) Bool (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1))
(declare-fun |ibex_multdiv_slow#45| (|ibex_multdiv_slow_s|) (_ BitVec 2)) 


(define-fun |ibex_multdiv_slow_n signed_mode_i| ((state |ibex_multdiv_slow_s|)) (_ BitVec 2) (|ibex_multdiv_slow#45| state))
(define-fun |ibex_multdiv_slow#46| ((state |ibex_multdiv_slow_s|)) Bool (= (|ibex_multdiv_slow#11| state) #b110)) 
(define-fun |ibex_multdiv_slow#47| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvor (ite (|ibex_multdiv_slow#20| state) #b1 #b0) (ite (|ibex_multdiv_slow#21| state) #b1 #b0))) 
(define-fun |ibex_multdiv_slow#48| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvand (ite (|ibex_multdiv_slow#38| state) #b1 #b0) (|ibex_multdiv_slow#47| state))) 
(define-fun |ibex_multdiv_slow#49| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvor (ite (|ibex_multdiv_slow#46| state) #b1 #b0) (|ibex_multdiv_slow#48| state))) 

(define-fun |ibex_multdiv_slow_n valid_o| ((state |ibex_multdiv_slow_s|)) Bool (= ((_ extract 0 0) (|ibex_multdiv_slow#49| state)) #b1))
(define-fun |ibex_multdiv_slow#50| ((state |ibex_multdiv_slow_s|)) (_ BitVec 3) (ite (|ibex_multdiv_slow#22| state) #b000 #b101)) 
(define-fun |ibex_multdiv_slow#51| ((state |ibex_multdiv_slow_s|)) (_ BitVec 5) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#4| state) #b00000)) 
(define-fun |ibex_multdiv_slow#52| ((state |ibex_multdiv_slow_s|)) Bool (= (|ibex_multdiv_slow#51| state) #b00001)) 
(define-fun |ibex_multdiv_slow#53| ((state |ibex_multdiv_slow_s|)) (_ BitVec 3) (ite (|ibex_multdiv_slow#52| state) #b100 #b011)) 
(define-fun |ibex_multdiv_slow#54| ((state |ibex_multdiv_slow_s|)) (_ BitVec 3) (ite (|ibex_multdiv_slow#42| state) #b110 #b001)) 
(define-fun |ibex_multdiv_slow#55| ((state |ibex_multdiv_slow_s|)) (_ BitVec 3) (ite (|ibex_multdiv_slow#22| state) #b011 (|ibex_multdiv_slow#54| state))) 
(define-fun |ibex_multdiv_slow#56| ((state |ibex_multdiv_slow_s|)) Bool (= (|ibex_multdiv_slow#11| state) #b011)) 
(define-fun |ibex_multdiv_slow#57| ((state |ibex_multdiv_slow_s|)) (_ BitVec 3) (ite (|ibex_multdiv_slow#12| state) (|ibex_multdiv_slow#55| state) (ite (|ibex_multdiv_slow#13| state) #b010 (ite (|ibex_multdiv_slow#14| state) #b011 (ite (|ibex_multdiv_slow#56| state) (|ibex_multdiv_slow#53| state) (ite (|ibex_multdiv_slow#38| state) (|ibex_multdiv_slow#50| state) (ite (|ibex_multdiv_slow#15| state) #b110 (ite (|ibex_multdiv_slow#46| state) #b000 #b000)))))))) 
(define-fun |ibex_multdiv_slow#58| ((state |ibex_multdiv_slow_s|)) Bool (or  (|ibex_multdiv_slow#43| state) false  (|ibex_multdiv_slow#41| state) false)) 
(define-fun |ibex_multdiv_slow#59| ((state |ibex_multdiv_slow_s|)) (_ BitVec 3) (ite (|ibex_multdiv_slow#58| state) (|ibex_multdiv_slow#57| state) (|ibex_multdiv_slow#5| state))) 
(define-fun |ibex_multdiv_slow#60| ((state |ibex_multdiv_slow_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#59| state) #b000)) 
(define-fun |ibex_multdiv_slow#61| ((state |ibex_multdiv_slow_s|)) (_ BitVec 5) (bvsub (|ibex_multdiv_slow#51| state) #b00001)) 
(define-fun |ibex_multdiv_slow#62| ((state |ibex_multdiv_slow_s|)) (_ BitVec 5) (ite (|ibex_multdiv_slow#12| state) #b11111 (ite (|ibex_multdiv_slow#56| state) (|ibex_multdiv_slow#61| state) #b00000))) 
(define-fun |ibex_multdiv_slow#63| ((state |ibex_multdiv_slow_s|)) Bool (or  (|ibex_multdiv_slow#56| state) (|ibex_multdiv_slow#12| state))) 
(define-fun |ibex_multdiv_slow#64| ((state |ibex_multdiv_slow_s|)) Bool (and  (|ibex_multdiv_slow#58| state) (|ibex_multdiv_slow#63| state))) 
(define-fun |ibex_multdiv_slow#65| ((state |ibex_multdiv_slow_s|)) (_ BitVec 5) (ite (|ibex_multdiv_slow#64| state) (|ibex_multdiv_slow#62| state) (|ibex_multdiv_slow#4| state))) 
(define-fun |ibex_multdiv_slow#66| ((state |ibex_multdiv_slow_s|)) (_ BitVec 5) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#65| state) #b00000)) 
(define-fun |ibex_multdiv_slow#67| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#22| state) (concat #b0 ((_ extract 32 1) (|ibex_multdiv_slow#24| state))) #b000000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow#68| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvand ((_ extract 31 31) (|ibex_multdiv_slow#27| state)) ((_ extract 1 1) (|ibex_multdiv_slow#45| state)))) 
(define-fun |ibex_multdiv_slow#69| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#68| state)) #b1) (|ibex_multdiv_slow#8| state) (|ibex_multdiv_slow#27| state))) 
(define-fun |ibex_multdiv_slow#70| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#22| state) (concat #b0 (concat (|ibex_multdiv_slow#68| state) ((_ extract 31 1) (|ibex_multdiv_slow#27| state)))) #b000000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow#71| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#12| state) (|ibex_multdiv_slow#70| state) (ite (|ibex_multdiv_slow#14| state) (concat #b0 (|ibex_multdiv_slow#69| state)) (ite (|ibex_multdiv_slow#56| state) (|ibex_multdiv_slow#67| state) #b000000000000000000000000000000000)))) 
(define-fun |ibex_multdiv_slow#72| ((state |ibex_multdiv_slow_s|)) Bool (distinct (concat (ite (|ibex_multdiv_slow#22| state) #b1 #b0) (ite (|ibex_multdiv_slow#12| state) #b1 #b0)) #b01)) 
(define-fun |ibex_multdiv_slow#73| ((state |ibex_multdiv_slow_s|)) Bool (distinct (concat (ite (|ibex_multdiv_slow#22| state) #b1 #b0) (ite (|ibex_multdiv_slow#56| state) #b1 #b0)) #b01)) 
(define-fun |ibex_multdiv_slow#74| ((state |ibex_multdiv_slow_s|)) Bool (or  (|ibex_multdiv_slow#56| state) (|ibex_multdiv_slow#12| state) (|ibex_multdiv_slow#14| state))) 
(define-fun |ibex_multdiv_slow#75| ((state |ibex_multdiv_slow_s|)) Bool (and  (|ibex_multdiv_slow#58| state) (|ibex_multdiv_slow#72| state) (|ibex_multdiv_slow#73| state) (|ibex_multdiv_slow#74| state))) 
(define-fun |ibex_multdiv_slow#76| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#75| state) (|ibex_multdiv_slow#71| state) (|ibex_multdiv_slow#3| state))) 
(define-fun |ibex_multdiv_slow#77| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#76| state) #b000000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow#78| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvand ((_ extract 31 31) (|ibex_multdiv_slow#29| state)) ((_ extract 0 0) (|ibex_multdiv_slow#45| state)))) 
(define-fun |ibex_multdiv_slow#79| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#78| state)) #b1) (concat #b0 (|ibex_multdiv_slow#8| state)) #b000000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow#80| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvxor (|ibex_multdiv_slow#78| state) (|ibex_multdiv_slow#68| state))) 
(define-fun |ibex_multdiv_slow#81| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#80| state)) #b1) (concat #b0 (|ibex_multdiv_slow#8| state)) #b000000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow#82| ((state |ibex_multdiv_slow_s|)) Bool (= (concat (ite (|ibex_multdiv_slow#19| state) #b1 #b0) (ite (|ibex_multdiv_slow#18| state) #b1 #b0)) #b10)) 
(define-fun |ibex_multdiv_slow#83| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#82| state) (|ibex_multdiv_slow#81| state) (|ibex_multdiv_slow#79| state))) 
(define-fun |ibex_multdiv_slow#84| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvnot ((_ extract 32 32) (|ibex_multdiv_slow#7| state)))) 
(define-fun |ibex_multdiv_slow#85| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvxor ((_ extract 31 31) (|ibex_multdiv_slow#10| state)) ((_ extract 31 31) (|ibex_multdiv_slow#24| state)))) 
(define-fun |ibex_multdiv_slow#86| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#85| state)) #b1) ((_ extract 31 31) (|ibex_multdiv_slow#10| state)) (|ibex_multdiv_slow#84| state))) 
(define-fun |ibex_multdiv_slow#87| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#86| state)) #b1) ((_ extract 33 1) (|ibex_multdiv_slow#7| state)) (|ibex_multdiv_slow#10| state))) 
(define-fun |ibex_multdiv_slow#88| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (bvshl #b000000000000000000000000000000001 (concat #b0000000000000000000000000000 (|ibex_multdiv_slow#51| state)))) 
(define-fun |ibex_multdiv_slow#89| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (bvor (|ibex_multdiv_slow#33| state) (|ibex_multdiv_slow#88| state))) 
(define-fun |ibex_multdiv_slow#90| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#86| state)) #b1) (|ibex_multdiv_slow#89| state) (|ibex_multdiv_slow#33| state))) 
(define-fun |ibex_multdiv_slow#91| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#22| state) ((_ extract 32 0) (|ibex_multdiv_slow#7| state)) (ite (|ibex_multdiv_slow#82| state) (|ibex_multdiv_slow#90| state) (concat #b0 ((_ extract 31 0) (|ibex_multdiv_slow#87| state)))))) 
(define-fun |ibex_multdiv_slow#92| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#0| state) #b00000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow#93| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) ((_ extract 0 0) (bvlshr (|ibex_multdiv_slow#92| state) (concat #b000000000000000000000000000 (|ibex_multdiv_slow#61| state))))) 
(define-fun |ibex_multdiv_slow#94| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#20| state) ((_ extract 32 0) (|ibex_multdiv_slow#7| state)) (ite (|ibex_multdiv_slow#21| state) ((_ extract 33 1) (|ibex_multdiv_slow#7| state)) (concat ((_ extract 31 0) (|ibex_multdiv_slow#87| state)) (|ibex_multdiv_slow#93| state))))) 
(define-fun |ibex_multdiv_slow#95| ((state |ibex_multdiv_slow_s|)) (_ BitVec 31) (bvand ((_ extract 31 1) (|ibex_multdiv_slow#29| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) ((_ extract 0 0) (|ibex_multdiv_slow#27| state)))))))))))))))))))))))))))))))))) 
(define-fun |ibex_multdiv_slow#96| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvand (|ibex_multdiv_slow#78| state) ((_ extract 0 0) (|ibex_multdiv_slow#27| state)))) 
(define-fun |ibex_multdiv_slow#97| ((state |ibex_multdiv_slow_s|)) (_ BitVec 1) (bvnot (|ibex_multdiv_slow#96| state))) 
(define-fun |ibex_multdiv_slow#98| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (bvand (|ibex_multdiv_slow#29| state) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) (concat ((_ extract 0 0) (|ibex_multdiv_slow#27| state)) ((_ extract 0 0) (|ibex_multdiv_slow#27| state))))))))))))))))))))))))))))))))))) 
(define-fun |ibex_multdiv_slow#99| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#20| state) (concat (|ibex_multdiv_slow#97| state) (|ibex_multdiv_slow#98| state)) (ite (|ibex_multdiv_slow#21| state) (concat #b1 (concat (|ibex_multdiv_slow#97| state) (|ibex_multdiv_slow#95| state))) (ite (|ibex_multdiv_slow#82| state) #b111111111111111111111111111111111 (concat (|ibex_multdiv_slow#78| state) (|ibex_multdiv_slow#29| state)))))) 
(define-fun |ibex_multdiv_slow#100| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#12| state) (|ibex_multdiv_slow#99| state) (ite (|ibex_multdiv_slow#14| state) (concat #b00000000000000000000000000000000 ((_ extract 31 31) (|ibex_multdiv_slow#92| state))) (ite (|ibex_multdiv_slow#56| state) (|ibex_multdiv_slow#94| state) (ite (|ibex_multdiv_slow#38| state) (|ibex_multdiv_slow#91| state) (ite (|ibex_multdiv_slow#15| state) (|ibex_multdiv_slow#83| state) #b000000000000000000000000000000000)))))) 
(define-fun |ibex_multdiv_slow#101| ((state |ibex_multdiv_slow_s|)) Bool (or  (|ibex_multdiv_slow#38| state) (|ibex_multdiv_slow#56| state) (|ibex_multdiv_slow#12| state) (|ibex_multdiv_slow#14| state) (|ibex_multdiv_slow#15| state))) 
(define-fun |ibex_multdiv_slow#102| ((state |ibex_multdiv_slow_s|)) Bool (distinct (concat (ite (|ibex_multdiv_slow#15| state) #b1 #b0) (concat (ite (|ibex_multdiv_slow#82| state) #b1 #b0) (|ibex_multdiv_slow#78| state))) #b100)) 
(define-fun |ibex_multdiv_slow#103| ((state |ibex_multdiv_slow_s|)) Bool (distinct (concat (ite (|ibex_multdiv_slow#15| state) #b1 #b0) (concat (ite (|ibex_multdiv_slow#82| state) #b1 #b0) (|ibex_multdiv_slow#80| state))) #b110)) 
(define-fun |ibex_multdiv_slow#104| ((state |ibex_multdiv_slow_s|)) Bool (and  (|ibex_multdiv_slow#58| state) (|ibex_multdiv_slow#101| state) (|ibex_multdiv_slow#102| state) (|ibex_multdiv_slow#103| state))) 
(define-fun |ibex_multdiv_slow#105| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#104| state) (|ibex_multdiv_slow#100| state) (|ibex_multdiv_slow#2| state))) 
(define-fun |ibex_multdiv_slow#106| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#105| state) #b000000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow#107| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#20| state) (concat ((_ extract 31 0) (|ibex_multdiv_slow#33| state)) #b0) (ite (|ibex_multdiv_slow#21| state) #b000000000000000000000000000000000 (|ibex_multdiv_slow#90| state)))) 
(define-fun |ibex_multdiv_slow#108| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#20| state) (concat (|ibex_multdiv_slow#29| state) #b0) (ite (|ibex_multdiv_slow#21| state) (concat (|ibex_multdiv_slow#78| state) (|ibex_multdiv_slow#29| state)) #b000000000000000000000000000000000))) 
(define-fun |ibex_multdiv_slow#109| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#12| state) (|ibex_multdiv_slow#108| state) (ite (|ibex_multdiv_slow#13| state) #b000000000000000000000000000000000 (ite (|ibex_multdiv_slow#56| state) (|ibex_multdiv_slow#107| state) #b000000000000000000000000000000000)))) 
(define-fun |ibex_multdiv_slow#110| ((state |ibex_multdiv_slow_s|)) Bool (or  (|ibex_multdiv_slow#56| state) (|ibex_multdiv_slow#12| state) (|ibex_multdiv_slow#13| state))) 
(define-fun |ibex_multdiv_slow#111| ((state |ibex_multdiv_slow_s|)) Bool (distinct (concat (ite (|ibex_multdiv_slow#56| state) #b1 #b0) (ite (|ibex_multdiv_slow#21| state) #b1 #b0)) #b11)) 
(define-fun |ibex_multdiv_slow#112| ((state |ibex_multdiv_slow_s|)) Bool (distinct (concat (ite (|ibex_multdiv_slow#12| state) #b1 #b0) (concat (ite (|ibex_multdiv_slow#21| state) #b1 #b0) (ite (|ibex_multdiv_slow#20| state) #b1 #b0))) #b100)) 
(define-fun |ibex_multdiv_slow#113| ((state |ibex_multdiv_slow_s|)) Bool (and  (|ibex_multdiv_slow#58| state) (|ibex_multdiv_slow#110| state) (|ibex_multdiv_slow#111| state) (|ibex_multdiv_slow#112| state))) 
(define-fun |ibex_multdiv_slow#114| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (|ibex_multdiv_slow#113| state) (|ibex_multdiv_slow#109| state) (|ibex_multdiv_slow#1| state))) 
(define-fun |ibex_multdiv_slow#115| ((state |ibex_multdiv_slow_s|)) (_ BitVec 33) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#114| state) #b000000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow#116| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#78| state)) #b1) (|ibex_multdiv_slow#8| state) (|ibex_multdiv_slow#29| state))) 
(define-fun |ibex_multdiv_slow#117| ((state |ibex_multdiv_slow_s|)) Bool (and  (|ibex_multdiv_slow#58| state) (|ibex_multdiv_slow#13| state))) 
(define-fun |ibex_multdiv_slow#118| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (ite (|ibex_multdiv_slow#117| state) (|ibex_multdiv_slow#116| state) (|ibex_multdiv_slow#0| state))) 
(define-fun |ibex_multdiv_slow#119| ((state |ibex_multdiv_slow_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|ibex_multdiv_slow#9| state)) #b1) (|ibex_multdiv_slow#118| state) #b00000000000000000000000000000000)) 
(define-fun |ibex_multdiv_slow_a| ((state |ibex_multdiv_slow_s|)) Bool true)
(define-fun |ibex_multdiv_slow_u| ((state |ibex_multdiv_slow_s|)) Bool true)
(define-fun |ibex_multdiv_slow_i| ((state |ibex_multdiv_slow_s|)) Bool true)
(define-fun |ibex_multdiv_slow_h| ((state |ibex_multdiv_slow_s|)) Bool true)
(define-fun |ibex_multdiv_slow_t| ((state |ibex_multdiv_slow_s|) (next_state |ibex_multdiv_slow_s|)) Bool (and
  (= (|ibex_multdiv_slow#60| state) (|ibex_multdiv_slow#5| next_state)) 
  (= (|ibex_multdiv_slow#66| state) (|ibex_multdiv_slow#4| next_state)) 
  (= (|ibex_multdiv_slow#77| state) (|ibex_multdiv_slow#3| next_state)) 
  (= (|ibex_multdiv_slow#106| state) (|ibex_multdiv_slow#2| next_state)) 
  (= (|ibex_multdiv_slow#115| state) (|ibex_multdiv_slow#1| next_state)) 
  (= (|ibex_multdiv_slow#119| state) (|ibex_multdiv_slow#0| next_state)) 
)) 


