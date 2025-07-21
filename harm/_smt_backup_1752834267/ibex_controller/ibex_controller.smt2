

(declare-sort |ibex_controller_s| 0)
(declare-fun |ibex_controller_is| (|ibex_controller_s|) Bool)

(declare-fun |ibex_controller#0| (|ibex_controller_s|) (_ BitVec 1)) 

(define-fun |ibex_controller_n $auto$async2sync.cc:228:execute$2242| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#0| state)) #b1))

(declare-fun |ibex_controller#1| (|ibex_controller_s|) (_ BitVec 1)) 

(define-fun |ibex_controller_n $auto$async2sync.cc:228:execute$2240| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#1| state)) #b1))

(declare-fun |ibex_controller#2| (|ibex_controller_s|) (_ BitVec 1)) 

(define-fun |ibex_controller_n $auto$async2sync.cc:228:execute$2238| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#2| state)) #b1))

(declare-fun |ibex_controller#3| (|ibex_controller_s|) (_ BitVec 1)) 

(define-fun |ibex_controller_n $auto$async2sync.cc:228:execute$2236| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#3| state)) #b1))

(declare-fun |ibex_controller#4| (|ibex_controller_s|) (_ BitVec 4)) 

(define-fun |ibex_controller_n $auto$async2sync.cc:228:execute$2234| ((state |ibex_controller_s|)) (_ BitVec 4) (|ibex_controller#4| state))

(declare-fun |ibex_controller#5| (|ibex_controller_s|) (_ BitVec 1)) 

(define-fun |ibex_controller_n $auto$async2sync.cc:228:execute$2232| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#5| state)) #b1))

(declare-fun |ibex_controller#6| (|ibex_controller_s|) (_ BitVec 1)) 

(define-fun |ibex_controller_n $auto$async2sync.cc:228:execute$2230| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#6| state)) #b1))
(declare-fun |ibex_controller#7| (|ibex_controller_s|) Bool) 




(define-fun |ibex_controller_n CK| ((state |ibex_controller_s|)) Bool (|ibex_controller#7| state))
(declare-fun |ibex_controller#8| (|ibex_controller_s|) Bool) 


(define-fun |ibex_controller_n branch_set_i| ((state |ibex_controller_s|)) Bool (|ibex_controller#8| state))
(declare-fun |ibex_controller#9| (|ibex_controller_s|) Bool) 


(define-fun |ibex_controller_n csr_meip_i| ((state |ibex_controller_s|)) Bool (|ibex_controller#9| state))
(declare-fun |ibex_controller#10| (|ibex_controller_s|) (_ BitVec 15)) 


(define-fun |ibex_controller_n csr_mfip_i| ((state |ibex_controller_s|)) (_ BitVec 15) (|ibex_controller#10| state))
(declare-fun |ibex_controller#11| (|ibex_controller_s|) Bool) 


(define-fun |ibex_controller_n csr_msip_i| ((state |ibex_controller_s|)) Bool (|ibex_controller#11| state))
(declare-fun |ibex_controller#12| (|ibex_controller_s|) Bool) 


(define-fun |ibex_controller_n csr_mstatus_mie_i| ((state |ibex_controller_s|)) Bool (|ibex_controller#12| state))
(declare-fun |ibex_controller#13| (|ibex_controller_s|) Bool) 


(define-fun |ibex_controller_n csr_mstatus_tw_i| ((state |ibex_controller_s|)) Bool (|ibex_controller#13| state))
(declare-fun |ibex_controller#14| (|ibex_controller_s|) Bool) 


(define-fun |ibex_controller_n csr_mtip_i| ((state |ibex_controller_s|)) Bool (|ibex_controller#14| state))
(declare-fun |ibex_controller#15| (|ibex_controller_s|) (_ BitVec 32)) 
(declare-fun |ibex_controller#16| (|ibex_controller_s|) (_ BitVec 1)) 
(declare-fun |ibex_controller#17| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#18| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#16| state) (|ibex_controller#17| state))) 
(define-fun |ibex_controller#19| ((state |ibex_controller_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|ibex_controller#18| state)) #b1) #b00000000000000000000000000000000 (|ibex_controller#15| state))) 
(declare-fun |ibex_controller#20| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#21| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#20| state) (|ibex_controller#17| state))) 
(define-fun |ibex_controller#22| ((state |ibex_controller_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|ibex_controller#21| state)) #b1) #b00000000000000000000000000000000 (|ibex_controller#19| state))) 
(declare-fun |ibex_controller#23| (|ibex_controller_s|) (_ BitVec 32)) 
(declare-fun |ibex_controller#24| (|ibex_controller_s|) (_ BitVec 16)) 
(declare-fun |ibex_controller#25| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#26| ((state |ibex_controller_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|ibex_controller#25| state)) #b1) (concat #b0000000000000000 (|ibex_controller#24| state)) (|ibex_controller#23| state))) 
(declare-fun |ibex_controller#27| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#28| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#0| state) #b0)) 
(define-fun |ibex_controller#29| ((state |ibex_controller_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|ibex_controller#28| state)) #b1) (|ibex_controller#26| state) (|ibex_controller#22| state))) 
(declare-fun |ibex_controller#30| (|ibex_controller_s|) (_ BitVec 32)) 
(declare-fun |ibex_controller#31| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#32| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#31| state) (|ibex_controller#17| state))) 
(define-fun |ibex_controller#33| ((state |ibex_controller_s|)) (_ BitVec 32) (ite (= ((_ extract 0 0) (|ibex_controller#32| state)) #b1) (|ibex_controller#30| state) (|ibex_controller#29| state))) 
(define-fun |ibex_controller#34| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#1| state) #b0)) 
(define-fun |ibex_controller#35| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#2| state) #b0)) 
(define-fun |ibex_controller#36| ((state |ibex_controller_s|)) Bool (or  (= ((_ extract 0 0) (|ibex_controller#34| state)) #b1) false  (= ((_ extract 0 0) (|ibex_controller#35| state)) #b1) false)) 
(define-fun |ibex_controller#37| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#3| state) #b0)) 
(define-fun |ibex_controller#38| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#36| state) false  (= ((_ extract 0 0) (|ibex_controller#37| state)) #b1) false)) 
(define-fun |ibex_controller#39| ((state |ibex_controller_s|)) (_ BitVec 32) (ite (|ibex_controller#38| state) (|ibex_controller#33| state) #b00000000000000000000000000000000)) 
(define-fun |ibex_controller#40| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#4| state) #b0000)) 
(define-fun |ibex_controller#41| ((state |ibex_controller_s|)) Bool (= (|ibex_controller#40| state) #b0110)) 
(define-fun |ibex_controller#42| ((state |ibex_controller_s|)) (_ BitVec 32) (ite (|ibex_controller#41| state) (|ibex_controller#39| state) #b00000000000000000000000000000000)) 

(define-fun |ibex_controller_n csr_mtval_o| ((state |ibex_controller_s|)) (_ BitVec 32) (|ibex_controller#42| state))
(declare-fun |ibex_controller#43| (|ibex_controller_s|) Bool) 


(define-fun |ibex_controller_n csr_pipe_flush_i| ((state |ibex_controller_s|)) Bool (|ibex_controller#43| state))
(declare-fun |ibex_controller#44| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#45| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#44| state) (|ibex_controller#17| state))) 
(define-fun |ibex_controller#46| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#45| state)) #b1) #b1 #b0)) 
(declare-fun |ibex_controller#47| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#48| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#47| state) (|ibex_controller#17| state))) 
(define-fun |ibex_controller#49| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#48| state)) #b1) #b0 (|ibex_controller#46| state))) 
(define-fun |ibex_controller#50| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#38| state) #b0 (|ibex_controller#49| state))) 
(define-fun |ibex_controller#51| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#41| state) (|ibex_controller#50| state) #b0)) 

(define-fun |ibex_controller_n csr_restore_dret_id_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#51| state)) #b1))
(define-fun |ibex_controller#52| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#48| state)) #b1) #b1 #b0)) 
(define-fun |ibex_controller#53| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#38| state) #b0 (|ibex_controller#52| state))) 
(define-fun |ibex_controller#54| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#41| state) (|ibex_controller#53| state) #b0)) 

(define-fun |ibex_controller_n csr_restore_mret_id_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#54| state)) #b1))
(define-fun |ibex_controller#55| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#5| state) #b0)) 
(declare-fun |ibex_controller#56| (|ibex_controller_s|) (_ BitVec 1)) 
(declare-fun |ibex_controller#57| (|ibex_controller_s|) Bool) 
(declare-fun |ibex_controller#58| (|ibex_controller_s|) Bool) 
(define-fun |ibex_controller#59| ((state |ibex_controller_s|)) Bool (not (or  (|ibex_controller#57| state) (|ibex_controller#58| state)))) 
(define-fun |ibex_controller#60| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#59| state) (|ibex_controller#56| state) #b0)) 
(declare-fun |ibex_controller#61| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#62| ((state |ibex_controller_s|)) Bool (= (concat (ite (|ibex_controller#58| state) #b1 #b0) (ite (|ibex_controller#57| state) #b1 #b0)) #b11)) 
(define-fun |ibex_controller#63| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#62| state) (|ibex_controller#61| state) (|ibex_controller#60| state))) 
(define-fun |ibex_controller#64| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#55| state) (|ibex_controller#63| state))) 
(define-fun |ibex_controller#65| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#64| state)) #b1) #b0 #b1)) 
(define-fun |ibex_controller#66| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#18| state)) #b1) (|ibex_controller#65| state) #b1)) 
(define-fun |ibex_controller#67| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#21| state)) #b1) #b1 (|ibex_controller#66| state))) 
(define-fun |ibex_controller#68| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#28| state)) #b1) #b1 (|ibex_controller#67| state))) 
(define-fun |ibex_controller#69| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#32| state)) #b1) #b1 (|ibex_controller#68| state))) 
(define-fun |ibex_controller#70| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#38| state) (|ibex_controller#69| state) #b0)) 
(define-fun |ibex_controller#71| ((state |ibex_controller_s|)) Bool (not (or  (= ((_ extract 0 0) (|ibex_controller#55| state)) #b1) false))) 
(define-fun |ibex_controller#72| ((state |ibex_controller_s|)) Bool (and (or  (= ((_ extract 0 0) (|ibex_controller#63| state)) #b1) false) (or  (|ibex_controller#71| state) false))) 
(define-fun |ibex_controller#73| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#72| state) #b1 #b0)) 
(declare-fun |ibex_controller#74| (|ibex_controller_s|) Bool) 
(declare-fun |ibex_controller#75| (|ibex_controller_s|) Bool) 
(define-fun |ibex_controller#76| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#74| state) false  (|ibex_controller#75| state) false)) 
(define-fun |ibex_controller#77| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#76| state) #b1 #b0)) 
(define-fun |ibex_controller#78| ((state |ibex_controller_s|)) (_ BitVec 1) (bvnot (|ibex_controller#55| state))) 
(declare-fun |ibex_controller#79| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#80| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#6| state) #b0)) 
(define-fun |ibex_controller#81| ((state |ibex_controller_s|)) (_ BitVec 1) (bvnot (|ibex_controller#80| state))) 
(define-fun |ibex_controller#82| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#79| state) (|ibex_controller#81| state))) 
(declare-fun |ibex_controller#83| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#84| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#83| state) (ite (|ibex_controller#12| state) #b1 #b0))) 
(define-fun |ibex_controller#85| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#82| state) (|ibex_controller#84| state))) 
(define-fun |ibex_controller#86| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#78| state) (|ibex_controller#85| state))) 
(define-fun |ibex_controller#87| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#86| state)) #b1) #b1 #b0)) 
(define-fun |ibex_controller#88| ((state |ibex_controller_s|)) Bool (= (|ibex_controller#40| state) #b1001)) 
(define-fun |ibex_controller#89| ((state |ibex_controller_s|)) Bool (= (|ibex_controller#40| state) #b1000)) 
(define-fun |ibex_controller#90| ((state |ibex_controller_s|)) Bool (= (|ibex_controller#40| state) #b0111)) 
(define-fun |ibex_controller#91| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#90| state) (|ibex_controller#87| state) (ite (|ibex_controller#89| state) (|ibex_controller#77| state) (ite (|ibex_controller#88| state) (|ibex_controller#73| state) (ite (|ibex_controller#41| state) (|ibex_controller#70| state) #b0))))) 

(define-fun |ibex_controller_n csr_save_cause_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#91| state)) #b1))
(define-fun |ibex_controller#92| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#88| state) (|ibex_controller#73| state) (ite (|ibex_controller#41| state) (|ibex_controller#70| state) #b0))) 

(define-fun |ibex_controller_n csr_save_id_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#92| state)) #b1))
(define-fun |ibex_controller#93| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#90| state) (|ibex_controller#87| state) (ite (|ibex_controller#89| state) (|ibex_controller#77| state) #b0))) 

(define-fun |ibex_controller_n csr_save_if_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#93| state)) #b1))
(define-fun |ibex_controller#94| ((state |ibex_controller_s|)) Bool (or  (= ((_ extract 0 0) (|ibex_controller#79| state)) #b1) false  (= ((_ extract 0 0) (|ibex_controller#83| state)) #b1) false)) 
(define-fun |ibex_controller#95| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#94| state) false  (|ibex_controller#75| state) false)) 
(define-fun |ibex_controller#96| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#95| state) false  (= ((_ extract 0 0) (|ibex_controller#55| state)) #b1) false)) 
(define-fun |ibex_controller#97| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#96| state) false  (|ibex_controller#74| state) false)) 
(define-fun |ibex_controller#98| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#97| state) #b1 #b0)) 
(define-fun |ibex_controller#99| ((state |ibex_controller_s|)) Bool (= (|ibex_controller#40| state) #b0011)) 
(define-fun |ibex_controller#100| ((state |ibex_controller_s|)) Bool (= (|ibex_controller#40| state) #b0010)) 
(define-fun |ibex_controller#101| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#100| state) #b0 (ite (|ibex_controller#99| state) (|ibex_controller#98| state) #b1))) 

(define-fun |ibex_controller_n ctrl_busy_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#101| state)) #b1))
(define-fun |ibex_controller#102| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (|ibex_controller#74| state) #b100 #b011)) 
(define-fun |ibex_controller#103| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (|ibex_controller#76| state) (|ibex_controller#102| state) #b001)) 
(define-fun |ibex_controller#104| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (|ibex_controller#89| state) (|ibex_controller#103| state) #b001)) 

(define-fun |ibex_controller_n debug_cause_o| ((state |ibex_controller_s|)) (_ BitVec 3) (|ibex_controller#104| state))
(define-fun |ibex_controller#105| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#89| state) (|ibex_controller#77| state) (ite (|ibex_controller#88| state) (|ibex_controller#73| state) #b0))) 

(define-fun |ibex_controller_n debug_csr_save_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#105| state)) #b1))


(define-fun |ibex_controller_n debug_ebreakm_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#61| state)) #b1))


(define-fun |ibex_controller_n debug_ebreaku_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#56| state)) #b1))

(define-fun |ibex_controller_n debug_mode_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#55| state)) #b1))


(define-fun |ibex_controller_n debug_req_i| ((state |ibex_controller_s|)) Bool (|ibex_controller#75| state))


(define-fun |ibex_controller_n debug_single_step_i| ((state |ibex_controller_s|)) Bool (|ibex_controller#74| state))


(define-fun |ibex_controller_n dret_insn_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#44| state)) #b1))


(define-fun |ibex_controller_n ebrk_insn_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#16| state)) #b1))


(define-fun |ibex_controller_n ecall_insn_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#20| state)) #b1))
(define-fun |ibex_controller#106| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (= ((_ extract 0 0) (|ibex_controller#35| state)) #b1) #b000111 #b000101)) 
(define-fun |ibex_controller#107| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (= ((_ extract 0 0) (|ibex_controller#64| state)) #b1) #b000000 #b000011)) 
(define-fun |ibex_controller#108| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (= ((_ extract 0 0) (|ibex_controller#18| state)) #b1) (|ibex_controller#107| state) (|ibex_controller#106| state))) 
(define-fun |ibex_controller#109| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (|ibex_controller#62| state) #b001011 #b001000)) 
(define-fun |ibex_controller#110| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (= ((_ extract 0 0) (|ibex_controller#21| state)) #b1) (|ibex_controller#109| state) (|ibex_controller#108| state))) 
(define-fun |ibex_controller#111| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (= ((_ extract 0 0) (|ibex_controller#28| state)) #b1) #b000010 (|ibex_controller#110| state))) 
(define-fun |ibex_controller#112| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (= ((_ extract 0 0) (|ibex_controller#32| state)) #b1) #b000001 (|ibex_controller#111| state))) 
(define-fun |ibex_controller#113| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (|ibex_controller#38| state) (|ibex_controller#112| state) #b000000)) 
(define-fun |ibex_controller#114| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (|ibex_controller#11| state) #b100011 #b100111)) 
(define-fun |ibex_controller#115| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (|ibex_controller#9| state) #b101011 (|ibex_controller#114| state))) 
(define-fun |ibex_controller#116| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 1 1) (|ibex_controller#10| state)) #b1) #b0001 #b0000)) 
(define-fun |ibex_controller#117| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 2 2) (|ibex_controller#10| state)) #b1) #b0010 (|ibex_controller#116| state))) 
(define-fun |ibex_controller#118| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 3 3) (|ibex_controller#10| state)) #b1) #b0011 (|ibex_controller#117| state))) 
(define-fun |ibex_controller#119| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 4 4) (|ibex_controller#10| state)) #b1) #b0100 (|ibex_controller#118| state))) 
(define-fun |ibex_controller#120| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 5 5) (|ibex_controller#10| state)) #b1) #b0101 (|ibex_controller#119| state))) 
(define-fun |ibex_controller#121| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 6 6) (|ibex_controller#10| state)) #b1) #b0110 (|ibex_controller#120| state))) 
(define-fun |ibex_controller#122| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 7 7) (|ibex_controller#10| state)) #b1) #b0111 (|ibex_controller#121| state))) 
(define-fun |ibex_controller#123| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 8 8) (|ibex_controller#10| state)) #b1) #b1000 (|ibex_controller#122| state))) 
(define-fun |ibex_controller#124| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 9 9) (|ibex_controller#10| state)) #b1) #b1001 (|ibex_controller#123| state))) 
(define-fun |ibex_controller#125| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 10 10) (|ibex_controller#10| state)) #b1) #b1010 (|ibex_controller#124| state))) 
(define-fun |ibex_controller#126| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 11 11) (|ibex_controller#10| state)) #b1) #b1011 (|ibex_controller#125| state))) 
(define-fun |ibex_controller#127| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 12 12) (|ibex_controller#10| state)) #b1) #b1100 (|ibex_controller#126| state))) 
(define-fun |ibex_controller#128| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 13 13) (|ibex_controller#10| state)) #b1) #b1101 (|ibex_controller#127| state))) 
(define-fun |ibex_controller#129| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 14 14) (|ibex_controller#10| state)) #b1) #b1110 (|ibex_controller#128| state))) 
(define-fun |ibex_controller#130| ((state |ibex_controller_s|)) Bool (distinct (|ibex_controller#10| state) #b000000000000000)) 
(define-fun |ibex_controller#131| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (|ibex_controller#130| state) (concat #b11 (|ibex_controller#129| state)) (|ibex_controller#115| state))) 
(define-fun |ibex_controller#132| ((state |ibex_controller_s|)) Bool (not (or  (= ((_ extract 0 0) (|ibex_controller#80| state)) #b1) false))) 
(define-fun |ibex_controller#133| ((state |ibex_controller_s|)) Bool (and (or  (= ((_ extract 0 0) (|ibex_controller#79| state)) #b1) false) (or  (|ibex_controller#132| state) false))) 
(define-fun |ibex_controller#134| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (|ibex_controller#133| state) #b111111 (|ibex_controller#131| state))) 
(define-fun |ibex_controller#135| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (= ((_ extract 0 0) (|ibex_controller#86| state)) #b1) (|ibex_controller#134| state) #b000000)) 
(define-fun |ibex_controller#136| ((state |ibex_controller_s|)) (_ BitVec 6) (ite (|ibex_controller#90| state) (|ibex_controller#135| state) (ite (|ibex_controller#41| state) (|ibex_controller#113| state) #b000000))) 

(define-fun |ibex_controller_n exc_cause_o| ((state |ibex_controller_s|)) (_ BitVec 6) (|ibex_controller#136| state))
(define-fun |ibex_controller#137| ((state |ibex_controller_s|)) (_ BitVec 2) (ite (= ((_ extract 0 0) (|ibex_controller#55| state)) #b1) #b11 #b00)) 
(define-fun |ibex_controller#138| ((state |ibex_controller_s|)) (_ BitVec 2) (ite (|ibex_controller#38| state) (|ibex_controller#137| state) #b01)) 
(define-fun |ibex_controller#139| ((state |ibex_controller_s|)) (_ BitVec 2) (ite (|ibex_controller#76| state) #b10 #b01)) 
(define-fun |ibex_controller#140| ((state |ibex_controller_s|)) (_ BitVec 2) (ite (|ibex_controller#89| state) (|ibex_controller#139| state) (ite (|ibex_controller#88| state) #b10 (ite (|ibex_controller#41| state) (|ibex_controller#138| state) #b01)))) 

(define-fun |ibex_controller_n exc_pc_mux_o| ((state |ibex_controller_s|)) (_ BitVec 2) (|ibex_controller#140| state))
(declare-fun |ibex_controller#141| (|ibex_controller_s|) Bool) 


(define-fun |ibex_controller_n fetch_enable_i| ((state |ibex_controller_s|)) Bool (|ibex_controller#141| state))
(declare-fun |ibex_controller#142| (|ibex_controller_s|) (_ BitVec 1)) 
(declare-fun |ibex_controller#143| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#144| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#142| state) (|ibex_controller#143| state))) 
(declare-fun |ibex_controller#145| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#146| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#144| state) (|ibex_controller#145| state))) 
(declare-fun |ibex_controller#147| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#148| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#146| state) (|ibex_controller#147| state))) 
(define-fun |ibex_controller#149| ((state |ibex_controller_s|)) (_ BitVec 1) (bvnot (|ibex_controller#148| state))) 
(define-fun |ibex_controller#150| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#48| state) (|ibex_controller#45| state))) 
(declare-fun |ibex_controller#151| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#152| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#151| state) (|ibex_controller#17| state))) 
(define-fun |ibex_controller#153| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#150| state) (|ibex_controller#152| state))) 
(define-fun |ibex_controller#154| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (ite (|ibex_controller#43| state) #b1 #b0) (|ibex_controller#17| state))) 
(define-fun |ibex_controller#155| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#153| state) (|ibex_controller#154| state))) 
(define-fun |ibex_controller#156| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#21| state) (|ibex_controller#18| state))) 
(declare-fun |ibex_controller#157| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#158| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#45| state) (|ibex_controller#78| state))) 
(define-fun |ibex_controller#159| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#157| state) (|ibex_controller#158| state))) 
(define-fun |ibex_controller#160| ((state |ibex_controller_s|)) Bool (distinct (concat (ite (|ibex_controller#58| state) #b1 #b0) (ite (|ibex_controller#57| state) #b1 #b0)) #b11)) 
(define-fun |ibex_controller#161| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (ite (|ibex_controller#13| state) #b1 #b0) (|ibex_controller#152| state))) 
(define-fun |ibex_controller#162| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#48| state) (|ibex_controller#161| state))) 
(define-fun |ibex_controller#163| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (ite (|ibex_controller#160| state) #b1 #b0) (|ibex_controller#162| state))) 
(define-fun |ibex_controller#164| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#159| state) (|ibex_controller#163| state))) 
(define-fun |ibex_controller#165| ((state |ibex_controller_s|)) Bool (distinct (|ibex_controller#40| state) #b0110)) 
(define-fun |ibex_controller#166| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#164| state) (ite (|ibex_controller#165| state) #b1 #b0))) 
(define-fun |ibex_controller#167| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#156| state) (|ibex_controller#166| state))) 
(define-fun |ibex_controller#168| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#167| state) (|ibex_controller#32| state))) 
(define-fun |ibex_controller#169| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#168| state) (ite (|ibex_controller#165| state) #b1 #b0))) 
(define-fun |ibex_controller#170| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#155| state) (|ibex_controller#169| state))) 
(declare-fun |ibex_controller#171| (|ibex_controller_s|) (_ BitVec 1)) 
(declare-fun |ibex_controller#172| (|ibex_controller_s|) (_ BitVec 1)) 
(define-fun |ibex_controller#173| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#171| state) (|ibex_controller#172| state))) 
(define-fun |ibex_controller#174| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#170| state) (|ibex_controller#173| state))) 
(define-fun |ibex_controller#175| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#174| state)) #b1) #b1 #b0)) 
(define-fun |ibex_controller#176| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (ite (|ibex_controller#74| state) #b1 #b0) (|ibex_controller#17| state))) 
(define-fun |ibex_controller#177| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (ite (|ibex_controller#75| state) #b1 #b0) (|ibex_controller#176| state))) 
(define-fun |ibex_controller#178| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#177| state) (|ibex_controller#78| state))) 
(define-fun |ibex_controller#179| ((state |ibex_controller_s|)) Bool (or  (= ((_ extract 0 0) (|ibex_controller#178| state)) #b1) false  (= ((_ extract 0 0) (|ibex_controller#86| state)) #b1) false)) 
(define-fun |ibex_controller#180| ((state |ibex_controller_s|)) Bool (and (or  (|ibex_controller#179| state) false) (or  (= ((_ extract 0 0) (|ibex_controller#148| state)) #b1) false))) 
(define-fun |ibex_controller#181| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#180| state) #b1 (|ibex_controller#175| state))) 
(define-fun |ibex_controller#182| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#17| state)) #b1) (|ibex_controller#181| state) #b0)) 
(define-fun |ibex_controller#183| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#86| state)) #b1) #b1 (|ibex_controller#182| state))) 
(define-fun |ibex_controller#184| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#178| state)) #b1) #b1 (|ibex_controller#183| state))) 
(define-fun |ibex_controller#185| ((state |ibex_controller_s|)) Bool (not (or  (= ((_ extract 0 0) (|ibex_controller#148| state)) #b1) false))) 
(define-fun |ibex_controller#186| ((state |ibex_controller_s|)) Bool (not (or  (= ((_ extract 0 0) (|ibex_controller#174| state)) #b1) false))) 
(define-fun |ibex_controller#187| ((state |ibex_controller_s|)) Bool (and (or  (|ibex_controller#185| state) false) (or  (|ibex_controller#186| state) false))) 
(define-fun |ibex_controller#188| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#187| state) (|ibex_controller#184| state) (|ibex_controller#182| state))) 
(define-fun |ibex_controller#189| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#178| state)) #b1) #b1 (|ibex_controller#87| state))) 
(define-fun |ibex_controller#190| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#41| state) (|ibex_controller#99| state) (|ibex_controller#100| state))) 
(define-fun |ibex_controller#191| ((state |ibex_controller_s|)) Bool (= (|ibex_controller#40| state) #b0101)) 
(define-fun |ibex_controller#192| ((state |ibex_controller_s|)) Bool (= (|ibex_controller#40| state) #b0100)) 
(define-fun |ibex_controller#193| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#192| state) (|ibex_controller#189| state) (ite (|ibex_controller#191| state) (|ibex_controller#188| state) (ite (|ibex_controller#190| state) #b1 #b0)))) 
(define-fun |ibex_controller#194| ((state |ibex_controller_s|)) (_ BitVec 1) (bvnot (|ibex_controller#193| state))) 
(define-fun |ibex_controller#195| ((state |ibex_controller_s|)) (_ BitVec 1) (bvand (|ibex_controller#149| state) (|ibex_controller#194| state))) 

(define-fun |ibex_controller_n id_in_ready_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#195| state)) #b1))


(define-fun |ibex_controller_n illegal_insn_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#157| state)) #b1))


(define-fun |ibex_controller_n instr_compressed_i| ((state |ibex_controller_s|)) (_ BitVec 16) (|ibex_controller#24| state))


(define-fun |ibex_controller_n instr_fetch_err_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#31| state)) #b1))


(define-fun |ibex_controller_n instr_i| ((state |ibex_controller_s|)) (_ BitVec 32) (|ibex_controller#23| state))


(define-fun |ibex_controller_n instr_is_compressed_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#25| state)) #b1))
(define-fun |ibex_controller#196| ((state |ibex_controller_s|)) Bool (= (|ibex_controller#40| state) #b0001)) 
(define-fun |ibex_controller#197| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#41| state) (|ibex_controller#90| state) (|ibex_controller#191| state) (|ibex_controller#192| state) (|ibex_controller#88| state) (|ibex_controller#89| state) (|ibex_controller#196| state))) 
(define-fun |ibex_controller#198| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#197| state) #b1 #b0)) 

(define-fun |ibex_controller_n instr_req_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#198| state)) #b1))
(define-fun |ibex_controller#199| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#148| state) (|ibex_controller#193| state))) 
(define-fun |ibex_controller#200| ((state |ibex_controller_s|)) (_ BitVec 1) (bvnot (|ibex_controller#199| state))) 
(define-fun |ibex_controller#201| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#38| state) (|ibex_controller#69| state) #b1)) 
(define-fun |ibex_controller#202| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#178| state)) #b1) #b0 (|ibex_controller#87| state))) 
(define-fun |ibex_controller#203| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#187| state) (|ibex_controller#202| state) #b0)) 
(define-fun |ibex_controller#204| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#99| state) (|ibex_controller#88| state) (|ibex_controller#100| state))) 
(define-fun |ibex_controller#205| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#192| state) (|ibex_controller#87| state) (ite (|ibex_controller#191| state) (|ibex_controller#203| state) (ite (|ibex_controller#89| state) (|ibex_controller#77| state) (ite (|ibex_controller#204| state) #b1 (ite (|ibex_controller#41| state) (|ibex_controller#201| state) #b0)))))) 
(define-fun |ibex_controller#206| ((state |ibex_controller_s|)) (_ BitVec 1) (bvor (|ibex_controller#200| state) (|ibex_controller#205| state))) 

(define-fun |ibex_controller_n instr_valid_clear_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#206| state)) #b1))


(define-fun |ibex_controller_n instr_valid_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#17| state)) #b1))


(define-fun |ibex_controller_n irq_nm_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#79| state)) #b1))


(define-fun |ibex_controller_n irq_pending_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#83| state)) #b1))
(declare-fun |ibex_controller#207| (|ibex_controller_s|) Bool) 


(define-fun |ibex_controller_n jump_set_i| ((state |ibex_controller_s|)) Bool (|ibex_controller#207| state))


(define-fun |ibex_controller_n load_err_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#172| state)) #b1))


(define-fun |ibex_controller_n lsu_addr_last_i| ((state |ibex_controller_s|)) (_ BitVec 32) (|ibex_controller#15| state))


(define-fun |ibex_controller_n mret_insn_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#47| state)) #b1))


(define-fun |ibex_controller_n pc_id_i| ((state |ibex_controller_s|)) (_ BitVec 32) (|ibex_controller#30| state))
(define-fun |ibex_controller#208| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|ibex_controller#45| state)) #b1) #b100 #b000)) 
(define-fun |ibex_controller#209| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|ibex_controller#48| state)) #b1) #b011 (|ibex_controller#208| state))) 
(define-fun |ibex_controller#210| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (|ibex_controller#38| state) #b010 (|ibex_controller#209| state))) 
(define-fun |ibex_controller#211| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (|ibex_controller#76| state) #b010 #b000)) 
(define-fun |ibex_controller#212| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|ibex_controller#86| state)) #b1) #b010 #b000)) 
(define-fun |ibex_controller#213| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#8| state) false  (|ibex_controller#207| state) false)) 
(define-fun |ibex_controller#214| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (|ibex_controller#213| state) #b001 #b000)) 
(define-fun |ibex_controller#215| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|ibex_controller#174| state)) #b1) #b000 (|ibex_controller#214| state))) 
(define-fun |ibex_controller#216| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (= ((_ extract 0 0) (|ibex_controller#17| state)) #b1) (|ibex_controller#215| state) #b000)) 
(define-fun |ibex_controller#217| ((state |ibex_controller_s|)) (_ BitVec 3) (ite (|ibex_controller#191| state) (|ibex_controller#216| state) (ite (|ibex_controller#90| state) (|ibex_controller#212| state) (ite (|ibex_controller#89| state) (|ibex_controller#211| state) (ite (|ibex_controller#88| state) #b010 (ite (|ibex_controller#41| state) (|ibex_controller#210| state) #b000)))))) 

(define-fun |ibex_controller_n pc_mux_o| ((state |ibex_controller_s|)) (_ BitVec 3) (|ibex_controller#217| state))
(define-fun |ibex_controller#218| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#48| state)) #b1) #b1 (|ibex_controller#46| state))) 
(define-fun |ibex_controller#219| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#38| state) (|ibex_controller#69| state) (|ibex_controller#218| state))) 
(define-fun |ibex_controller#220| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#213| state) #b1 #b0)) 
(define-fun |ibex_controller#221| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#174| state)) #b1) #b0 (|ibex_controller#220| state))) 
(define-fun |ibex_controller#222| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#17| state)) #b1) (|ibex_controller#221| state) #b0)) 
(define-fun |ibex_controller#223| ((state |ibex_controller_s|)) Bool (not (or  (= ((_ extract 0 0) (|ibex_controller#40| state)) #b1) (= ((_ extract 1 1) (|ibex_controller#40| state)) #b1) (= ((_ extract 2 2) (|ibex_controller#40| state)) #b1) (= ((_ extract 3 3) (|ibex_controller#40| state)) #b1)))) 
(define-fun |ibex_controller#224| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#223| state) (|ibex_controller#88| state) (|ibex_controller#196| state))) 
(define-fun |ibex_controller#225| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#191| state) (|ibex_controller#222| state) (ite (|ibex_controller#90| state) (|ibex_controller#87| state) (ite (|ibex_controller#89| state) (|ibex_controller#77| state) (ite (|ibex_controller#224| state) #b1 (ite (|ibex_controller#41| state) (|ibex_controller#219| state) #b0)))))) 

(define-fun |ibex_controller_n pc_set_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#225| state)) #b1))
(define-fun |ibex_controller#226| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#213| state) (ite (|ibex_controller#207| state) #b1 #b0) #b0)) 
(define-fun |ibex_controller#227| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#174| state)) #b1) #b0 (|ibex_controller#226| state))) 
(define-fun |ibex_controller#228| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#17| state)) #b1) (|ibex_controller#227| state) #b0)) 
(define-fun |ibex_controller#229| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#191| state) (|ibex_controller#228| state) #b0)) 

(define-fun |ibex_controller_n perf_jump_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#229| state)) #b1))
(define-fun |ibex_controller#230| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#213| state) (ite (|ibex_controller#8| state) #b1 #b0) #b0)) 
(define-fun |ibex_controller#231| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#174| state)) #b1) #b0 (|ibex_controller#230| state))) 
(define-fun |ibex_controller#232| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#17| state)) #b1) (|ibex_controller#231| state) #b0)) 
(define-fun |ibex_controller#233| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#191| state) (|ibex_controller#232| state) #b0)) 

(define-fun |ibex_controller_n perf_tbranch_o| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#233| state)) #b1))


(define-fun |ibex_controller_n priv_mode_i| ((state |ibex_controller_s|)) (_ BitVec 2) (concat (ite (|ibex_controller#58| state) #b1 #b0) (ite (|ibex_controller#57| state) #b1 #b0)))


(define-fun |ibex_controller_n rst_ni| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1))


(define-fun |ibex_controller_n stall_branch_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#147| state)) #b1))


(define-fun |ibex_controller_n stall_jump_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#145| state)) #b1))


(define-fun |ibex_controller_n stall_lsu_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#142| state)) #b1))


(define-fun |ibex_controller_n stall_multdiv_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#143| state)) #b1))


(define-fun |ibex_controller_n store_err_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#171| state)) #b1))


(define-fun |ibex_controller_n wfi_insn_i| ((state |ibex_controller_s|)) Bool (= ((_ extract 0 0) (|ibex_controller#151| state)) #b1))
(define-fun |ibex_controller#234| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#48| state)) #b1) #b0 #b0)) 
(define-fun |ibex_controller#235| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#38| state) #b0 (|ibex_controller#234| state))) 
(define-fun |ibex_controller#236| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#133| state) #b1 #b0)) 
(define-fun |ibex_controller#237| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#86| state)) #b1) (|ibex_controller#236| state) #b0)) 
(define-fun |ibex_controller#238| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#90| state) (|ibex_controller#237| state) (ite (|ibex_controller#41| state) (|ibex_controller#235| state) #b0))) 
(define-fun |ibex_controller#239| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#41| state) (|ibex_controller#90| state))) 
(define-fun |ibex_controller#240| ((state |ibex_controller_s|)) Bool (distinct (concat (ite (|ibex_controller#90| state) #b1 #b0) (concat (ite (|ibex_controller#133| state) #b1 #b0) (|ibex_controller#86| state))) #b101)) 
(define-fun |ibex_controller#241| ((state |ibex_controller_s|)) Bool (distinct (concat (ite (|ibex_controller#41| state) #b1 #b0) (ite (|ibex_controller#38| state) #b1 #b0)) #b11)) 
(define-fun |ibex_controller#242| ((state |ibex_controller_s|)) Bool (distinct (concat (ite (|ibex_controller#90| state) #b1 #b0) (|ibex_controller#86| state)) #b10)) 
(define-fun |ibex_controller#243| ((state |ibex_controller_s|)) Bool (distinct (concat (ite (|ibex_controller#41| state) #b1 #b0) (concat (ite (|ibex_controller#38| state) #b1 #b0) (|ibex_controller#48| state))) #b100)) 
(define-fun |ibex_controller#244| ((state |ibex_controller_s|)) Bool (and  (|ibex_controller#239| state) (|ibex_controller#240| state) (|ibex_controller#241| state) (|ibex_controller#242| state) (|ibex_controller#243| state))) 
(define-fun |ibex_controller#245| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#244| state) (|ibex_controller#238| state) (|ibex_controller#6| state))) 
(define-fun |ibex_controller#246| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#245| state) #b0)) 
(define-fun |ibex_controller#247| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#45| state)) #b1) #b0 #b0)) 
(define-fun |ibex_controller#248| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#48| state)) #b1) #b0 (|ibex_controller#247| state))) 
(define-fun |ibex_controller#249| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#38| state) #b0 (|ibex_controller#248| state))) 
(define-fun |ibex_controller#250| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#76| state) #b1 #b0)) 
(define-fun |ibex_controller#251| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#89| state) (|ibex_controller#250| state) (ite (|ibex_controller#88| state) #b1 (ite (|ibex_controller#41| state) (|ibex_controller#249| state) #b0)))) 
(define-fun |ibex_controller#252| ((state |ibex_controller_s|)) Bool (distinct (concat (ite (|ibex_controller#41| state) #b1 #b0) (concat (ite (|ibex_controller#38| state) #b1 #b0) (concat (|ibex_controller#45| state) (|ibex_controller#48| state)))) #b1000)) 
(define-fun |ibex_controller#253| ((state |ibex_controller_s|)) Bool (distinct (concat (ite (|ibex_controller#41| state) #b1 #b0) (concat (ite (|ibex_controller#38| state) #b1 #b0) (|ibex_controller#48| state))) #b101)) 
(define-fun |ibex_controller#254| ((state |ibex_controller_s|)) Bool (distinct (concat (ite (|ibex_controller#89| state) #b1 #b0) (ite (|ibex_controller#76| state) #b1 #b0)) #b10)) 
(define-fun |ibex_controller#255| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#41| state) (|ibex_controller#88| state) (|ibex_controller#89| state))) 
(define-fun |ibex_controller#256| ((state |ibex_controller_s|)) Bool (and  (|ibex_controller#252| state) (|ibex_controller#241| state) (|ibex_controller#253| state) (|ibex_controller#254| state) (|ibex_controller#255| state))) 
(define-fun |ibex_controller#257| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (|ibex_controller#256| state) (|ibex_controller#251| state) (|ibex_controller#5| state))) 
(define-fun |ibex_controller#258| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#257| state) #b0)) 
(define-fun |ibex_controller#259| ((state |ibex_controller_s|)) Bool (and (or  (= ((_ extract 0 0) (|ibex_controller#154| state)) #b1) false) (or  (= ((_ extract 0 0) (|ibex_controller#86| state)) #b1) false))) 
(define-fun |ibex_controller#260| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (|ibex_controller#259| state) #b0111 #b0101)) 
(define-fun |ibex_controller#261| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#152| state)) #b1) #b0010 (|ibex_controller#260| state))) 
(define-fun |ibex_controller#262| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#45| state)) #b1) #b0101 (|ibex_controller#261| state))) 
(define-fun |ibex_controller#263| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#48| state)) #b1) #b0101 (|ibex_controller#262| state))) 
(define-fun |ibex_controller#264| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#64| state)) #b1) #b1001 #b0101)) 
(define-fun |ibex_controller#265| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#18| state)) #b1) (|ibex_controller#264| state) #b0101)) 
(define-fun |ibex_controller#266| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#21| state)) #b1) #b0101 (|ibex_controller#265| state))) 
(define-fun |ibex_controller#267| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#28| state)) #b1) #b0101 (|ibex_controller#266| state))) 
(define-fun |ibex_controller#268| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#32| state)) #b1) #b0101 (|ibex_controller#267| state))) 
(define-fun |ibex_controller#269| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (|ibex_controller#38| state) (|ibex_controller#268| state) (|ibex_controller#263| state))) 
(define-fun |ibex_controller#270| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#178| state)) #b1) #b1000 (|ibex_controller#269| state))) 
(define-fun |ibex_controller#271| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#174| state)) #b1) #b0110 (|ibex_controller#40| state))) 
(define-fun |ibex_controller#272| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#17| state)) #b1) (|ibex_controller#271| state) (|ibex_controller#40| state))) 
(define-fun |ibex_controller#273| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#86| state)) #b1) #b0111 (|ibex_controller#272| state))) 
(define-fun |ibex_controller#274| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#178| state)) #b1) #b1000 (|ibex_controller#273| state))) 
(define-fun |ibex_controller#275| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (|ibex_controller#187| state) (|ibex_controller#274| state) (|ibex_controller#272| state))) 
(define-fun |ibex_controller#276| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#195| state)) #b1) #b0101 #b0000)) 
(define-fun |ibex_controller#277| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#86| state)) #b1) #b0111 (|ibex_controller#276| state))) 
(define-fun |ibex_controller#278| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#178| state)) #b1) #b1000 (|ibex_controller#277| state))) 
(define-fun |ibex_controller#279| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (|ibex_controller#97| state) #b0100 #b0000)) 
(define-fun |ibex_controller#280| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (|ibex_controller#141| state) #b0001 #b0000)) 
(define-fun |ibex_controller#281| ((state |ibex_controller_s|)) Bool (or  (|ibex_controller#90| state) (|ibex_controller#88| state) (|ibex_controller#89| state))) 
(define-fun |ibex_controller#282| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (|ibex_controller#223| state) (|ibex_controller#280| state) (ite (|ibex_controller#196| state) #b0100 (ite (|ibex_controller#100| state) #b0011 (ite (|ibex_controller#99| state) (|ibex_controller#279| state) (ite (|ibex_controller#192| state) (|ibex_controller#278| state) (ite (|ibex_controller#191| state) (|ibex_controller#275| state) (ite (|ibex_controller#281| state) #b0101 (ite (|ibex_controller#41| state) (|ibex_controller#270| state) #b0000))))))))) 
(define-fun |ibex_controller#283| ((state |ibex_controller_s|)) Bool (distinct (concat (ite (|ibex_controller#99| state) #b1 #b0) (ite (|ibex_controller#97| state) #b1 #b0)) #b10)) 
(define-fun |ibex_controller#284| ((state |ibex_controller_s|)) Bool (distinct (concat (ite (|ibex_controller#223| state) #b1 #b0) (ite (|ibex_controller#141| state) #b1 #b0)) #b10)) 
(define-fun |ibex_controller#285| ((state |ibex_controller_s|)) Bool (distinct (concat (ite (|ibex_controller#192| state) #b1 #b0) (concat (|ibex_controller#195| state) (concat (|ibex_controller#86| state) (|ibex_controller#178| state)))) #b1000)) 
(define-fun |ibex_controller#286| ((state |ibex_controller_s|)) Bool (and  (|ibex_controller#283| state) (|ibex_controller#284| state) (|ibex_controller#285| state))) 
(define-fun |ibex_controller#287| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (|ibex_controller#286| state) (|ibex_controller#282| state) (|ibex_controller#4| state))) 
(define-fun |ibex_controller#288| ((state |ibex_controller_s|)) (_ BitVec 4) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#287| state) #b0000)) 
(define-fun |ibex_controller#289| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#172| state) #b0)) 
(define-fun |ibex_controller#290| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#171| state) #b0)) 
(define-fun |ibex_controller#291| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#169| state) #b0)) 
(define-fun |ibex_controller#292| ((state |ibex_controller_s|)) (_ BitVec 1) (ite (= ((_ extract 0 0) (|ibex_controller#27| state)) #b1) (|ibex_controller#166| state) #b0)) 
(define-fun |ibex_controller_a| ((state |ibex_controller_s|)) Bool true)
(define-fun |ibex_controller_u| ((state |ibex_controller_s|)) Bool true)
(define-fun |ibex_controller_i| ((state |ibex_controller_s|)) Bool true)
(define-fun |ibex_controller_h| ((state |ibex_controller_s|)) Bool true)
(define-fun |ibex_controller_t| ((state |ibex_controller_s|) (next_state |ibex_controller_s|)) Bool (and
  (= (|ibex_controller#246| state) (|ibex_controller#6| next_state)) 
  (= (|ibex_controller#258| state) (|ibex_controller#5| next_state)) 
  (= (|ibex_controller#288| state) (|ibex_controller#4| next_state)) 
  (= (|ibex_controller#289| state) (|ibex_controller#3| next_state)) 
  (= (|ibex_controller#290| state) (|ibex_controller#2| next_state)) 
  (= (|ibex_controller#291| state) (|ibex_controller#1| next_state)) 
  (= (|ibex_controller#292| state) (|ibex_controller#0| next_state)) 
)) 


