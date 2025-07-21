

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

(declare-sort |s641_s| 0)
(declare-fun |s641_is| (|s641_s|) Bool)
(declare-fun |s641#0| (|s641_s|) Bool) 


(define-fun |s641_n CK| ((state |s641_s|)) Bool (|s641#0| state))
(declare-fun |s641#1| (|s641_s|) Bool) 


(define-fun |s641_n G1| ((state |s641_s|)) Bool (|s641#1| state))
(declare-fun |s641#2| (|s641_s|) Bool) 


(define-fun |s641_n G10| ((state |s641_s|)) Bool (|s641#2| state))
(declare-fun |s641#3| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#4| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#3| state))) 


(declare-fun |s641#5| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_5| (|s641_s|) |dff_s|)
(define-fun |s641#6| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#4| state) (ite (|s641#5| state) #b1 #b0))) 
(declare-fun |s641#7| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#8| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#6| state) (|s641#7| state))) 
(define-fun |s641#9| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#8| state))) 

(define-fun |s641_n G100BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#9| state)) #b1))
(declare-fun |s641#10| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#11| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#10| state))) 
(declare-fun |s641#12| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#13| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#12| state))) 
(define-fun |s641#14| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#11| state) (|s641#13| state))) 


(declare-fun |s641#15| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_3| (|s641_s|) |dff_s|)
(define-fun |s641#16| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#14| state) (ite (|s641#15| state) #b1 #b0))) 
(declare-fun |s641#17| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#18| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#11| state) (|s641#17| state))) 
(define-fun |s641#19| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#18| state) (ite (|s641#2| state) #b1 #b0))) 
(declare-fun |s641#20| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#21| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#20| state))) 
(define-fun |s641#22| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#19| state) (|s641#21| state))) 
(define-fun |s641#23| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#16| state) (|s641#22| state))) 
(define-fun |s641#24| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#23| state))) 
(declare-fun |s641#25| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#26| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#24| state) (|s641#25| state))) 


(declare-fun |s641#27| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_4| (|s641_s|) |dff_s|)
(define-fun |s641#28| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#26| state) (ite (|s641#27| state) #b1 #b0))) 
(declare-fun |s641#29| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#30| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#28| state) (|s641#29| state))) 
(define-fun |s641#31| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#30| state))) 

(define-fun |s641_n G101BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#31| state)) #b1))
(define-fun |s641#32| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#17| state))) 
(define-fun |s641#33| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#11| state) (|s641#32| state))) 
(define-fun |s641#34| ((state |s641_s|)) (_ BitVec 1) (bvnot (ite (|s641#2| state) #b1 #b0))) 
(define-fun |s641#35| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#33| state) (|s641#34| state))) 
(define-fun |s641#36| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#35| state) (|s641#21| state))) 
(define-fun |s641#37| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#14| state) (|s641#36| state))) 
(declare-fun |s641#38| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#39| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#38| state))) 


(declare-fun |s641#40| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_2| (|s641_s|) |dff_s|)
(define-fun |s641#41| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#39| state) (ite (|s641#40| state) #b1 #b0))) 
(define-fun |s641#42| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#26| state))) 
(define-fun |s641#43| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#11| state) (|s641#42| state))) 
(define-fun |s641#44| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#43| state))) 


(declare-fun |s641#45| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_14| (|s641_s|) |dff_s|)
(define-fun |s641#46| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#44| state) (ite (|s641#45| state) #b1 #b0))) 
(define-fun |s641#47| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#46| state))) 
(define-fun |s641#48| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#41| state) (|s641#47| state))) 
(define-fun |s641#49| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#14| state) (|s641#48| state))) 
(define-fun |s641#50| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#18| state) (|s641#34| state))) 
(define-fun |s641#51| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#50| state) (|s641#21| state))) 
(define-fun |s641#52| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#49| state) (|s641#51| state))) 
(define-fun |s641#53| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#52| state))) 
(declare-fun |s641#54| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#55| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#53| state) (|s641#54| state))) 
(define-fun |s641#56| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#55| state))) 
(define-fun |s641#57| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#11| state) (|s641#56| state))) 
(define-fun |s641#58| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#57| state))) 


(declare-fun |s641#59| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_13| (|s641_s|) |dff_s|)
(define-fun |s641#60| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#58| state) (ite (|s641#59| state) #b1 #b0))) 
(define-fun |s641#61| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#60| state))) 
(define-fun |s641#62| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#61| state) (|s641#47| state))) 


(declare-fun |s641#63| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_0| (|s641_s|) |dff_s|)
(define-fun |s641#64| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#39| state) (ite (|s641#63| state) #b1 #b0))) 
(define-fun |s641#65| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#33| state) (ite (|s641#2| state) #b1 #b0))) 
(define-fun |s641#66| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#65| state) (|s641#21| state))) 
(define-fun |s641#67| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#14| state) (|s641#66| state))) 


(declare-fun |s641#68| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_1| (|s641_s|) |dff_s|)
(define-fun |s641#69| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#67| state) (ite (|s641#68| state) #b1 #b0))) 
(define-fun |s641#70| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#69| state))) 
(declare-fun |s641#71| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#72| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#70| state) (|s641#71| state))) 
(define-fun |s641#73| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#72| state))) 
(define-fun |s641#74| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#11| state) (|s641#73| state))) 
(define-fun |s641#75| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#74| state))) 


(declare-fun |s641#76| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_12| (|s641_s|) |dff_s|)
(define-fun |s641#77| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#75| state) (ite (|s641#76| state) #b1 #b0))) 
(define-fun |s641#78| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#77| state))) 
(define-fun |s641#79| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#64| state) (|s641#78| state))) 
(define-fun |s641#80| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#62| state) (|s641#79| state))) 
(define-fun |s641#81| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#37| state) (|s641#80| state))) 
(define-fun |s641#82| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#81| state))) 
(declare-fun |s641#83| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#84| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#82| state) (|s641#83| state))) 
(define-fun |s641#85| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#84| state))) 
(define-fun |s641#86| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#11| state) (|s641#85| state))) 
(define-fun |s641#87| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#86| state))) 


(declare-fun |s641#88| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_11| (|s641_s|) |dff_s|)
(define-fun |s641#89| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#87| state) (ite (|s641#88| state) #b1 #b0))) 
(declare-fun |s641#90| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#91| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#89| state) (|s641#90| state))) 
(define-fun |s641#92| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#91| state))) 

(define-fun |s641_n G103BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#92| state)) #b1))
(declare-fun |s641#93| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#94| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#77| state) (|s641#93| state))) 
(define-fun |s641#95| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#94| state))) 

(define-fun |s641_n G104BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#95| state)) #b1))
(declare-fun |s641#96| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#97| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#60| state) (|s641#96| state))) 
(define-fun |s641#98| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#97| state))) 

(define-fun |s641_n G105BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#98| state)) #b1))
(declare-fun |s641#99| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#100| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#46| state) (|s641#99| state))) 
(define-fun |s641#101| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#100| state))) 

(define-fun |s641_n G106BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#101| state)) #b1))


(declare-fun |s641#102| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_15| (|s641_s|) |dff_s|)
(define-fun |s641#103| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#4| state) (ite (|s641#102| state) #b1 #b0))) 
(declare-fun |s641#104| (|s641_s|) (_ BitVec 1)) 
(define-fun |s641#105| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#103| state) (|s641#104| state))) 

(define-fun |s641_n G107| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#105| state)) #b1))


(define-fun |s641_n G11| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#12| state)) #b1))
(declare-fun |s641#106| (|s641_s|) Bool) 


(define-fun |s641_n G12| ((state |s641_s|)) Bool (|s641#106| state))


(define-fun |s641_n G13| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#20| state)) #b1))


(declare-fun |s641#107| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_6| (|s641_s|) |dff_s|)
(define-fun |s641#108| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#55| state) (ite (|s641#107| state) #b1 #b0))) 
(define-fun |s641#109| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#108| state))) 
(define-fun |s641#110| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#109| state) (|s641#6| state))) 
(define-fun |s641#111| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#110| state))) 

(define-fun |s641_n G138| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#111| state)) #b1))


(define-fun |s641_n G14| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#90| state)) #b1))


(define-fun |s641_n G15| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#93| state)) #b1))


(define-fun |s641_n G16| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#96| state)) #b1))


(define-fun |s641_n G17| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#99| state)) #b1))


(define-fun |s641_n G18| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#104| state)) #b1))
(declare-fun |s641#112| (|s641_s|) Bool) 


(define-fun |s641_n G19| ((state |s641_s|)) Bool (|s641#112| state))


(define-fun |s641_n G2| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#38| state)) #b1))
(declare-fun |s641#113| (|s641_s|) Bool) 


(define-fun |s641_n G20| ((state |s641_s|)) Bool (|s641#113| state))
(declare-fun |s641#114| (|s641_s|) Bool) 


(define-fun |s641_n G21| ((state |s641_s|)) Bool (|s641#114| state))


(define-fun |s641_n G22| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#83| state)) #b1))


(define-fun |s641_n G23| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#71| state)) #b1))


(define-fun |s641_n G24| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#54| state)) #b1))


(define-fun |s641_n G25| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#25| state)) #b1))
(declare-fun |s641#115| (|s641_s|) Bool) 


(define-fun |s641_n G26| ((state |s641_s|)) Bool (|s641#115| state))
(declare-fun |s641#116| (|s641_s|) Bool) 


(define-fun |s641_n G27| ((state |s641_s|)) Bool (|s641#116| state))
(declare-fun |s641#117| (|s641_s|) Bool) 


(define-fun |s641_n G28| ((state |s641_s|)) Bool (|s641#117| state))
(declare-fun |s641#118| (|s641_s|) Bool) 


(define-fun |s641_n G29| ((state |s641_s|)) Bool (|s641#118| state))


(define-fun |s641_n G3| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#10| state)) #b1))
(declare-fun |s641#119| (|s641_s|) Bool) 


(define-fun |s641_n G30| ((state |s641_s|)) Bool (|s641#119| state))
(declare-fun |s641#120| (|s641_s|) Bool) 


(define-fun |s641_n G31| ((state |s641_s|)) Bool (|s641#120| state))
(declare-fun |s641#121| (|s641_s|) Bool) 


(define-fun |s641_n G32| ((state |s641_s|)) Bool (|s641#121| state))
(declare-fun |s641#122| (|s641_s|) Bool) 


(define-fun |s641_n G33| ((state |s641_s|)) Bool (|s641#122| state))
(declare-fun |s641#123| (|s641_s|) Bool) 


(define-fun |s641_n G34| ((state |s641_s|)) Bool (|s641#123| state))


(define-fun |s641_n G35| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#7| state)) #b1))


(define-fun |s641_n G36| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#29| state)) #b1))


(define-fun |s641_n G4| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#3| state)) #b1))
(declare-fun |s641#124| (|s641_s|) Bool) 


(define-fun |s641_n G5| ((state |s641_s|)) Bool (|s641#124| state))
(declare-fun |s641#125| (|s641_s|) Bool) 


(define-fun |s641_n G6| ((state |s641_s|)) Bool (|s641#125| state))
(declare-fun |s641#126| (|s641_s|) Bool) 


(define-fun |s641_n G8| ((state |s641_s|)) Bool (|s641#126| state))


(declare-fun |s641#127| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_16| (|s641_s|) |dff_s|)
(define-fun |s641#128| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#4| state) (ite (|s641#127| state) #b1 #b0))) 
(define-fun |s641#129| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#128| state) (ite (|s641#112| state) #b1 #b0))) 

(define-fun |s641_n G83| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#129| state)) #b1))


(declare-fun |s641#130| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_17| (|s641_s|) |dff_s|)
(define-fun |s641#131| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#4| state) (ite (|s641#130| state) #b1 #b0))) 
(define-fun |s641#132| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#131| state) (ite (|s641#113| state) #b1 #b0))) 

(define-fun |s641_n G84| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#132| state)) #b1))


(declare-fun |s641#133| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_18| (|s641_s|) |dff_s|)
(define-fun |s641#134| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#4| state) (ite (|s641#133| state) #b1 #b0))) 
(define-fun |s641#135| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#134| state) (ite (|s641#114| state) #b1 #b0))) 

(define-fun |s641_n G85| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#135| state)) #b1))

(define-fun |s641_n G86BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#85| state)) #b1))

(define-fun |s641_n G87BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#73| state)) #b1))

(define-fun |s641_n G88BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#56| state)) #b1))

(define-fun |s641_n G89BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#42| state)) #b1))


(define-fun |s641_n G9| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#17| state)) #b1))


(declare-fun |s641#136| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_7| (|s641_s|) |dff_s|)
(define-fun |s641#137| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#4| state) (ite (|s641#136| state) #b1 #b0))) 
(define-fun |s641#138| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#137| state) (|s641#21| state))) 
(define-fun |s641#139| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#32| state) (ite (|s641#2| state) #b1 #b0))) 


(declare-fun |s641#140| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_8| (|s641_s|) |dff_s|)
(define-fun |s641#141| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#72| state) (ite (|s641#140| state) #b1 #b0))) 
(define-fun |s641#142| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#139| state) (|s641#141| state))) 
(define-fun |s641#143| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#138| state) (|s641#142| state))) 
(define-fun |s641#144| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#17| state) (ite (|s641#2| state) #b1 #b0))) 
(define-fun |s641#145| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#144| state) (|s641#28| state))) 
(define-fun |s641#146| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#145| state) (|s641#21| state))) 
(define-fun |s641#147| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#143| state) (|s641#146| state))) 


(declare-fun |s641#148| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_10| (|s641_s|) |dff_s|)
(define-fun |s641#149| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#84| state) (ite (|s641#148| state) #b1 #b0))) 


(declare-fun |s641#150| (|s641_s|) Bool) 
(declare-fun |s641_h DFF_9| (|s641_s|) |dff_s|)
(define-fun |s641#151| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#4| state) (ite (|s641#150| state) #b1 #b0))) 
(define-fun |s641#152| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#149| state) (|s641#151| state))) 
(define-fun |s641#153| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#152| state) (|s641#141| state))) 
(define-fun |s641#154| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#153| state) (|s641#137| state))) 
(define-fun |s641#155| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#108| state) (|s641#6| state))) 
(define-fun |s641#156| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#155| state) (|s641#28| state))) 
(define-fun |s641#157| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#156| state) (|s641#13| state))) 
(define-fun |s641#158| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#154| state) (|s641#157| state))) 
(define-fun |s641#159| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#147| state) (|s641#158| state))) 
(define-fun |s641#160| ((state |s641_s|)) (_ BitVec 1) (bvnot (ite (|s641#106| state) #b1 #b0))) 
(define-fun |s641#161| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#151| state) (|s641#21| state))) 
(define-fun |s641#162| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#32| state) (|s641#34| state))) 
(define-fun |s641#163| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#162| state) (|s641#149| state))) 
(define-fun |s641#164| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#161| state) (|s641#163| state))) 
(define-fun |s641#165| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#160| state) (|s641#164| state))) 
(define-fun |s641#166| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#6| state) (|s641#21| state))) 
(define-fun |s641#167| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#17| state) (|s641#34| state))) 
(define-fun |s641#168| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#167| state) (|s641#108| state))) 
(define-fun |s641#169| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#166| state) (|s641#168| state))) 
(define-fun |s641#170| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#165| state) (|s641#169| state))) 
(define-fun |s641#171| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#159| state) (|s641#170| state))) 
(define-fun |s641#172| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#171| state))) 
(define-fun |s641#173| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#172| state) (ite (|s641#115| state) #b1 #b0))) 

(define-fun |s641_n G90| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#173| state)) #b1))

(define-fun |s641_n G91| ((state |s641_s|)) Bool (|s641#116| state))
(define-fun |s641#174| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#12| state) (ite (|s641#106| state) #b1 #b0))) 
(define-fun |s641#175| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#174| state) (|s641#20| state))) 
(define-fun |s641#176| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#175| state) (ite (|s641#117| state) #b1 #b0))) 

(define-fun |s641_n G92| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#176| state)) #b1))

(define-fun |s641_n G94| ((state |s641_s|)) Bool (|s641#118| state))
(define-fun |s641#177| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#149| state) (ite (|s641#119| state) #b1 #b0))) 
(define-fun |s641#178| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#177| state))) 

(define-fun |s641_n G95BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#178| state)) #b1))
(define-fun |s641#179| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#151| state) (ite (|s641#120| state) #b1 #b0))) 
(define-fun |s641#180| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#179| state))) 

(define-fun |s641_n G96BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#180| state)) #b1))
(define-fun |s641#181| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#141| state) (ite (|s641#121| state) #b1 #b0))) 
(define-fun |s641#182| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#181| state))) 

(define-fun |s641_n G97BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#182| state)) #b1))
(define-fun |s641#183| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#137| state) (ite (|s641#122| state) #b1 #b0))) 
(define-fun |s641#184| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#183| state))) 

(define-fun |s641_n G98BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#184| state)) #b1))
(define-fun |s641#185| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#108| state) (ite (|s641#123| state) #b1 #b0))) 
(define-fun |s641#186| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#185| state))) 

(define-fun |s641_n G99BF| ((state |s641_s|)) Bool (= ((_ extract 0 0) (|s641#186| state)) #b1))
(declare-fun |s641#187| (|s641_s|) Bool) 


(define-fun |s641_n GND| ((state |s641_s|)) Bool (|s641#187| state))
(declare-fun |s641#188| (|s641_s|) Bool) 


(define-fun |s641_n VDD| ((state |s641_s|)) Bool (|s641#188| state))
(define-fun |s641#189| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#39| state) (|s641#77| state))) 
(define-fun |s641#190| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#189| state) (|s641#61| state))) 
(define-fun |s641#191| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#190| state) (|s641#47| state))) 
(define-fun |s641#192| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#39| state) (|s641#46| state))) 
(define-fun |s641#193| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#149| state))) 
(define-fun |s641#194| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#151| state))) 
(define-fun |s641#195| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#193| state) (|s641#194| state))) 
(define-fun |s641#196| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#84| state) (|s641#193| state))) 
(define-fun |s641#197| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#195| state) (|s641#196| state))) 
(define-fun |s641#198| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#197| state))) 
(define-fun |s641#199| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#6| state))) 
(define-fun |s641#200| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#109| state) (|s641#199| state))) 
(define-fun |s641#201| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#55| state) (|s641#109| state))) 
(define-fun |s641#202| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#200| state) (|s641#201| state))) 
(define-fun |s641#203| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#202| state))) 
(define-fun |s641#204| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#141| state))) 
(define-fun |s641#205| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#137| state))) 
(define-fun |s641#206| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#204| state) (|s641#205| state))) 
(define-fun |s641#207| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#72| state) (|s641#204| state))) 
(define-fun |s641#208| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#206| state) (|s641#207| state))) 
(define-fun |s641#209| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#208| state))) 
(define-fun |s641#210| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#204| state) (|s641#137| state))) 
(define-fun |s641#211| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#210| state))) 
(define-fun |s641#212| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#193| state) (|s641#151| state))) 
(define-fun |s641#213| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#212| state))) 
(define-fun |s641#214| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#39| state) (|s641#89| state))) 
(define-fun |s641#215| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#89| state) (ite (|s641#126| state) #b1 #b0))) 
(define-fun |s641#216| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#214| state) (|s641#215| state))) 
(define-fun |s641#217| ((state |s641_s|)) (_ BitVec 1) (bvand (ite (|s641#126| state) #b1 #b0) (|s641#149| state))) 
(define-fun |s641#218| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#217| state) (|s641#151| state))) 
(define-fun |s641#219| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#78| state) (|s641#61| state))) 
(define-fun |s641#220| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#219| state) (|s641#47| state))) 
(define-fun |s641#221| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#218| state) (|s641#220| state))) 
(define-fun |s641#222| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#216| state) (|s641#221| state))) 
(define-fun |s641#223| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#77| state) (ite (|s641#124| state) #b1 #b0))) 
(define-fun |s641#224| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#189| state) (|s641#223| state))) 
(define-fun |s641#225| ((state |s641_s|)) (_ BitVec 1) (bvand (ite (|s641#124| state) #b1 #b0) (|s641#141| state))) 
(define-fun |s641#226| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#225| state) (|s641#137| state))) 
(define-fun |s641#227| ((state |s641_s|)) (_ BitVec 1) (bvnot (|s641#89| state))) 
(define-fun |s641#228| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#227| state) (|s641#61| state))) 
(define-fun |s641#229| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#228| state) (|s641#47| state))) 
(define-fun |s641#230| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#226| state) (|s641#229| state))) 
(define-fun |s641#231| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#224| state) (|s641#230| state))) 
(define-fun |s641#232| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#39| state) (|s641#60| state))) 
(define-fun |s641#233| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#60| state) (ite (|s641#125| state) #b1 #b0))) 
(define-fun |s641#234| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#232| state) (|s641#233| state))) 
(define-fun |s641#235| ((state |s641_s|)) (_ BitVec 1) (bvand (ite (|s641#125| state) #b1 #b0) (|s641#108| state))) 
(define-fun |s641#236| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#235| state) (|s641#6| state))) 
(define-fun |s641#237| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#227| state) (|s641#78| state))) 
(define-fun |s641#238| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#237| state) (|s641#47| state))) 
(define-fun |s641#239| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#236| state) (|s641#238| state))) 
(define-fun |s641#240| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#234| state) (|s641#239| state))) 
(define-fun |s641#241| ((state |s641_s|)) (_ BitVec 1) (bvand (ite (|s641#1| state) #b1 #b0) (|s641#46| state))) 
(define-fun |s641#242| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#192| state) (|s641#241| state))) 
(define-fun |s641#243| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#61| state) (|s641#28| state))) 
(define-fun |s641#244| ((state |s641_s|)) (_ BitVec 1) (bvand (ite (|s641#1| state) #b1 #b0) (|s641#227| state))) 
(define-fun |s641#245| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#244| state) (|s641#78| state))) 
(define-fun |s641#246| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#243| state) (|s641#245| state))) 
(define-fun |s641#247| ((state |s641_s|)) (_ BitVec 1) (bvor (|s641#242| state) (|s641#246| state))) 
(define-fun |s641#248| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#214| state) (|s641#78| state))) 
(define-fun |s641#249| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#62| state) (|s641#248| state))) 
(define-fun |s641#250| ((state |s641_s|)) (_ BitVec 1) (bvand (|s641#232| state) (|s641#47| state))) 
(define-fun |s641_a| ((state |s641_s|)) Bool (and
  (|dff_a| (|s641_h DFF_0| state))
  (|dff_a| (|s641_h DFF_1| state))
  (|dff_a| (|s641_h DFF_2| state))
  (|dff_a| (|s641_h DFF_3| state))
  (|dff_a| (|s641_h DFF_4| state))
  (|dff_a| (|s641_h DFF_9| state))
  (|dff_a| (|s641_h DFF_5| state))
  (|dff_a| (|s641_h DFF_6| state))
  (|dff_a| (|s641_h DFF_7| state))
  (|dff_a| (|s641_h DFF_8| state))
  (|dff_a| (|s641_h DFF_10| state))
  (|dff_a| (|s641_h DFF_11| state))
  (|dff_a| (|s641_h DFF_12| state))
  (|dff_a| (|s641_h DFF_13| state))
  (|dff_a| (|s641_h DFF_14| state))
  (|dff_a| (|s641_h DFF_15| state))
  (|dff_a| (|s641_h DFF_16| state))
  (|dff_a| (|s641_h DFF_17| state))
  (|dff_a| (|s641_h DFF_18| state))
))
(define-fun |s641_u| ((state |s641_s|)) Bool (and
  (|dff_u| (|s641_h DFF_0| state))
  (|dff_u| (|s641_h DFF_1| state))
  (|dff_u| (|s641_h DFF_2| state))
  (|dff_u| (|s641_h DFF_3| state))
  (|dff_u| (|s641_h DFF_4| state))
  (|dff_u| (|s641_h DFF_9| state))
  (|dff_u| (|s641_h DFF_5| state))
  (|dff_u| (|s641_h DFF_6| state))
  (|dff_u| (|s641_h DFF_7| state))
  (|dff_u| (|s641_h DFF_8| state))
  (|dff_u| (|s641_h DFF_10| state))
  (|dff_u| (|s641_h DFF_11| state))
  (|dff_u| (|s641_h DFF_12| state))
  (|dff_u| (|s641_h DFF_13| state))
  (|dff_u| (|s641_h DFF_14| state))
  (|dff_u| (|s641_h DFF_15| state))
  (|dff_u| (|s641_h DFF_16| state))
  (|dff_u| (|s641_h DFF_17| state))
  (|dff_u| (|s641_h DFF_18| state))
))
(define-fun |s641_i| ((state |s641_s|)) Bool (and
  (|dff_i| (|s641_h DFF_0| state))
  (|dff_i| (|s641_h DFF_1| state))
  (|dff_i| (|s641_h DFF_2| state))
  (|dff_i| (|s641_h DFF_3| state))
  (|dff_i| (|s641_h DFF_4| state))
  (|dff_i| (|s641_h DFF_9| state))
  (|dff_i| (|s641_h DFF_5| state))
  (|dff_i| (|s641_h DFF_6| state))
  (|dff_i| (|s641_h DFF_7| state))
  (|dff_i| (|s641_h DFF_8| state))
  (|dff_i| (|s641_h DFF_10| state))
  (|dff_i| (|s641_h DFF_11| state))
  (|dff_i| (|s641_h DFF_12| state))
  (|dff_i| (|s641_h DFF_13| state))
  (|dff_i| (|s641_h DFF_14| state))
  (|dff_i| (|s641_h DFF_15| state))
  (|dff_i| (|s641_h DFF_16| state))
  (|dff_i| (|s641_h DFF_17| state))
  (|dff_i| (|s641_h DFF_18| state))
))
(define-fun |s641_h| ((state |s641_s|)) Bool (and
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_0| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_0| state))) 
  (= (= ((_ extract 0 0) (|s641#89| state)) #b1) (|dff_n D| (|s641_h DFF_0| state))) 
  (= (|s641#63| state) (|dff_n Q| (|s641_h DFF_0| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_1| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_1| state))) 
  (= (= ((_ extract 0 0) (|s641#191| state)) #b1) (|dff_n D| (|s641_h DFF_1| state))) 
  (= (|s641#68| state) (|dff_n Q| (|s641_h DFF_1| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_2| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_2| state))) 
  (= (= ((_ extract 0 0) (|s641#60| state)) #b1) (|dff_n D| (|s641_h DFF_2| state))) 
  (= (|s641#40| state) (|dff_n Q| (|s641_h DFF_2| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_3| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_3| state))) 
  (= (= ((_ extract 0 0) (|s641#192| state)) #b1) (|dff_n D| (|s641_h DFF_3| state))) 
  (= (|s641#15| state) (|dff_n Q| (|s641_h DFF_3| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_4| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_4| state))) 
  (= (= ((_ extract 0 0) (|s641#28| state)) #b1) (|dff_n D| (|s641_h DFF_4| state))) 
  (= (|s641#27| state) (|dff_n Q| (|s641_h DFF_4| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_9| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_9| state))) 
  (= (= ((_ extract 0 0) (|s641#198| state)) #b1) (|dff_n D| (|s641_h DFF_9| state))) 
  (= (|s641#150| state) (|dff_n Q| (|s641_h DFF_9| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_5| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_5| state))) 
  (= (= ((_ extract 0 0) (|s641#203| state)) #b1) (|dff_n D| (|s641_h DFF_5| state))) 
  (= (|s641#5| state) (|dff_n Q| (|s641_h DFF_5| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_6| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_6| state))) 
  (= (= ((_ extract 0 0) (|s641#111| state)) #b1) (|dff_n D| (|s641_h DFF_6| state))) 
  (= (|s641#107| state) (|dff_n Q| (|s641_h DFF_6| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_7| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_7| state))) 
  (= (= ((_ extract 0 0) (|s641#209| state)) #b1) (|dff_n D| (|s641_h DFF_7| state))) 
  (= (|s641#136| state) (|dff_n Q| (|s641_h DFF_7| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_8| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_8| state))) 
  (= (= ((_ extract 0 0) (|s641#211| state)) #b1) (|dff_n D| (|s641_h DFF_8| state))) 
  (= (|s641#140| state) (|dff_n Q| (|s641_h DFF_8| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_10| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_10| state))) 
  (= (= ((_ extract 0 0) (|s641#213| state)) #b1) (|dff_n D| (|s641_h DFF_10| state))) 
  (= (|s641#148| state) (|dff_n Q| (|s641_h DFF_10| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_11| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_11| state))) 
  (= (= ((_ extract 0 0) (|s641#222| state)) #b1) (|dff_n D| (|s641_h DFF_11| state))) 
  (= (|s641#88| state) (|dff_n Q| (|s641_h DFF_11| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_12| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_12| state))) 
  (= (= ((_ extract 0 0) (|s641#231| state)) #b1) (|dff_n D| (|s641_h DFF_12| state))) 
  (= (|s641#76| state) (|dff_n Q| (|s641_h DFF_12| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_13| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_13| state))) 
  (= (= ((_ extract 0 0) (|s641#240| state)) #b1) (|dff_n D| (|s641_h DFF_13| state))) 
  (= (|s641#59| state) (|dff_n Q| (|s641_h DFF_13| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_14| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_14| state))) 
  (= (= ((_ extract 0 0) (|s641#247| state)) #b1) (|dff_n D| (|s641_h DFF_14| state))) 
  (= (|s641#45| state) (|dff_n Q| (|s641_h DFF_14| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_15| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_15| state))) 
  (= (= ((_ extract 0 0) (|s641#249| state)) #b1) (|dff_n D| (|s641_h DFF_15| state))) 
  (= (|s641#102| state) (|dff_n Q| (|s641_h DFF_15| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_16| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_16| state))) 
  (= (= ((_ extract 0 0) (|s641#191| state)) #b1) (|dff_n D| (|s641_h DFF_16| state))) 
  (= (|s641#127| state) (|dff_n Q| (|s641_h DFF_16| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_17| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_17| state))) 
  (= (= ((_ extract 0 0) (|s641#250| state)) #b1) (|dff_n D| (|s641_h DFF_17| state))) 
  (= (|s641#130| state) (|dff_n Q| (|s641_h DFF_17| state))) 
  (= (|s641_is| state) (|dff_is| (|s641_h DFF_18| state)))
  (= (|s641#0| state) (|dff_n CK| (|s641_h DFF_18| state))) 
  (= (= ((_ extract 0 0) (|s641#192| state)) #b1) (|dff_n D| (|s641_h DFF_18| state))) 
  (= (|s641#133| state) (|dff_n Q| (|s641_h DFF_18| state))) 
  (|dff_h| (|s641_h DFF_0| state))
  (|dff_h| (|s641_h DFF_1| state))
  (|dff_h| (|s641_h DFF_2| state))
  (|dff_h| (|s641_h DFF_3| state))
  (|dff_h| (|s641_h DFF_4| state))
  (|dff_h| (|s641_h DFF_9| state))
  (|dff_h| (|s641_h DFF_5| state))
  (|dff_h| (|s641_h DFF_6| state))
  (|dff_h| (|s641_h DFF_7| state))
  (|dff_h| (|s641_h DFF_8| state))
  (|dff_h| (|s641_h DFF_10| state))
  (|dff_h| (|s641_h DFF_11| state))
  (|dff_h| (|s641_h DFF_12| state))
  (|dff_h| (|s641_h DFF_13| state))
  (|dff_h| (|s641_h DFF_14| state))
  (|dff_h| (|s641_h DFF_15| state))
  (|dff_h| (|s641_h DFF_16| state))
  (|dff_h| (|s641_h DFF_17| state))
  (|dff_h| (|s641_h DFF_18| state))
))
(define-fun |s641_t| ((state |s641_s|) (next_state |s641_s|)) Bool (and
  (|dff_t| (|s641_h DFF_0| state) (|s641_h DFF_0| next_state))
  (|dff_t| (|s641_h DFF_1| state) (|s641_h DFF_1| next_state))
  (|dff_t| (|s641_h DFF_2| state) (|s641_h DFF_2| next_state))
  (|dff_t| (|s641_h DFF_3| state) (|s641_h DFF_3| next_state))
  (|dff_t| (|s641_h DFF_4| state) (|s641_h DFF_4| next_state))
  (|dff_t| (|s641_h DFF_9| state) (|s641_h DFF_9| next_state))
  (|dff_t| (|s641_h DFF_5| state) (|s641_h DFF_5| next_state))
  (|dff_t| (|s641_h DFF_6| state) (|s641_h DFF_6| next_state))
  (|dff_t| (|s641_h DFF_7| state) (|s641_h DFF_7| next_state))
  (|dff_t| (|s641_h DFF_8| state) (|s641_h DFF_8| next_state))
  (|dff_t| (|s641_h DFF_10| state) (|s641_h DFF_10| next_state))
  (|dff_t| (|s641_h DFF_11| state) (|s641_h DFF_11| next_state))
  (|dff_t| (|s641_h DFF_12| state) (|s641_h DFF_12| next_state))
  (|dff_t| (|s641_h DFF_13| state) (|s641_h DFF_13| next_state))
  (|dff_t| (|s641_h DFF_14| state) (|s641_h DFF_14| next_state))
  (|dff_t| (|s641_h DFF_15| state) (|s641_h DFF_15| next_state))
  (|dff_t| (|s641_h DFF_16| state) (|s641_h DFF_16| next_state))
  (|dff_t| (|s641_h DFF_17| state) (|s641_h DFF_17| next_state))
  (|dff_t| (|s641_h DFF_18| state) (|s641_h DFF_18| next_state))
)) 

