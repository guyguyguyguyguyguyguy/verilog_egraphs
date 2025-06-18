(
(define-fun inv ((MD_ABS_B (_ BitVec 3)) (MD_OP_DIV (_ BitVec 2)) (clk_i Bool) (op_b_shift_d (_ BitVec 33)) (res_adder_h (_ BitVec 33))) Bool (= MD_OP_DIV (bvneg MD_OP_DIV)))
)
(
(define-fun inv ((MD_ABS_B (_ BitVec 3)) (accum_window_d (_ BitVec 33)) (accum_window_q (_ BitVec 33)) (multdiv_state_d (_ BitVec 5)) (sign_b Bool)) Bool (bvule MD_ABS_B (bvmul MD_ABS_B MD_ABS_B)))
)
(
(define-fun inv ((MD_IDLE (_ BitVec 3)) (div_change_sign Bool) (mult_en_i Bool) (op_a_i (_ BitVec 32)) (valid_o Bool)) Bool (= MD_IDLE (bvneg MD_IDLE)))
)
(
(define-fun inv ((MD_OP_MULL (_ BitVec 2)) (alu_operand_b_o (_ BitVec 33)) (multdiv_state_d (_ BitVec 5)) (op_b_i (_ BitVec 32)) (res_adder_h (_ BitVec 33))) Bool (= MD_OP_MULL (bvneg MD_OP_MULL)))
)
(
(define-fun inv ((MD_CHANGE_SIGN (_ BitVec 3)) (MD_OP_DIV (_ BitVec 2)) (next_quotient (_ BitVec 33)) (op_a_ext (_ BitVec 33)) (rem_change_sign Bool)) Bool (= MD_OP_DIV (bvneg MD_OP_DIV)))
)
(
(define-fun inv ((MD_IDLE (_ BitVec 3)) (MD_LAST (_ BitVec 3)) (alu_operand_a_o (_ BitVec 33)) (div_change_sign Bool) (rst_ni Bool)) Bool (bvult MD_IDLE MD_LAST))
)
(
(define-fun inv ((MD_IDLE (_ BitVec 3)) (op_a_ext (_ BitVec 33)) (op_a_shift_q (_ BitVec 33)) (op_numerator_q (_ BitVec 32)) (res_adder_h (_ BitVec 33))) Bool (= MD_IDLE (bvneg MD_IDLE)))
)
(
(define-fun inv ((MD_CHANGE_SIGN (_ BitVec 3)) (MD_FINISH (_ BitVec 3)) (alu_operand_a_o (_ BitVec 33)) (op_numerator_d (_ BitVec 32)) (operator_i (_ BitVec 2))) Bool (bvult MD_CHANGE_SIGN MD_FINISH))
)
(
(define-fun inv ((MD_LAST (_ BitVec 3)) (accum_window_d (_ BitVec 33)) (mult_en_i Bool) (op_remainder (_ BitVec 33)) (sign_a Bool)) Bool (= MD_LAST (bvneg MD_LAST)))
)
(
(define-fun inv ((MD_COMP (_ BitVec 3)) (alu_operand_a_o (_ BitVec 33)) (equal_to_zero Bool) (rst_ni Bool) (valid_o Bool)) Bool (bvule MD_COMP (bvneg MD_COMP)))
)
(
(define-fun inv ((MD_LAST (_ BitVec 3)) (MD_OP_MULH (_ BitVec 2)) (alu_operand_a_o (_ BitVec 33)) (alu_operand_b_o (_ BitVec 33)) (res_adder_h (_ BitVec 33))) Bool (= MD_LAST (bvneg MD_LAST)))
)
(
(define-fun inv ((MD_OP_MULH (_ BitVec 2)) (MD_OP_MULL (_ BitVec 2)) (b_0 (_ BitVec 32)) (next_quotient (_ BitVec 33)) (op_b_shift_q (_ BitVec 33))) Bool (bvule MD_OP_MULL MD_OP_MULH))
)
(
(define-fun inv ((MD_ABS_B (_ BitVec 3)) (MD_CHANGE_SIGN (_ BitVec 3)) (MD_IDLE (_ BitVec 3)) (alu_adder_i (_ BitVec 32)) (multdiv_state_m1 (_ BitVec 5))) Bool (bvult MD_ABS_B MD_CHANGE_SIGN))
)
(
(define-fun inv ((MD_OP_DIV (_ BitVec 2)) (clk_i Bool) (op_a_ext (_ BitVec 33)) (op_numerator_q (_ BitVec 32)) (res_adder_l (_ BitVec 33))) Bool (= MD_OP_DIV (bvneg MD_OP_DIV)))
)
(
(define-fun inv ((MD_OP_DIV (_ BitVec 2)) (div_change_sign Bool) (is_greater_equal Bool) (op_b_shift_q (_ BitVec 33)) (rst_ni Bool)) Bool (= MD_OP_DIV (bvneg MD_OP_DIV)))
)
(
(define-fun inv ((accum_window_q (_ BitVec 33)) (b_0 (_ BitVec 32)) (op_a_bw_last_pp (_ BitVec 33)) (rem_change_sign Bool) (res_adder_l (_ BitVec 33))) Bool (bvule (bvmul b_0 b_0) b_0))
)
(
(define-fun inv ((MD_COMP (_ BitVec 3)) (MD_IDLE (_ BitVec 3)) (alu_operand_b_o (_ BitVec 33)) (div_en_i Bool) (op_a_shift_d (_ BitVec 33))) Bool (bvult MD_IDLE MD_COMP))
)
(
(define-fun inv ((MD_IDLE (_ BitVec 3)) (MD_OP_MULH (_ BitVec 2)) (alu_operand_a_o (_ BitVec 33)) (one_shift (_ BitVec 33)) (op_a_bw_last_pp (_ BitVec 33))) Bool (= MD_IDLE (bvneg MD_IDLE)))
)
(
(define-fun inv ((MD_OP_MULL (_ BitVec 2)) (alu_adder_ext_i (_ BitVec 34)) (op_a_bw_last_pp (_ BitVec 33)) (op_b_ext (_ BitVec 33)) (op_b_shift_d (_ BitVec 33))) Bool (= MD_OP_MULL (bvneg MD_OP_MULL)))
)
(
(define-fun inv ((MD_ABS_B (_ BitVec 3)) (MD_OP_DIV (_ BitVec 2)) (md_state_q (_ BitVec 3)) (sign_b Bool) (valid_o Bool)) Bool (= MD_OP_DIV (bvneg MD_OP_DIV)))
)
(
(define-fun inv ((MD_ABS_B (_ BitVec 3)) (MD_FINISH (_ BitVec 3)) (is_greater_equal Bool) (op_a_i (_ BitVec 32)) (op_a_shift_q (_ BitVec 33))) Bool (bvult MD_ABS_B MD_FINISH))
)
(
(define-fun inv ((MD_ABS_A (_ BitVec 3)) (MD_FINISH (_ BitVec 3)) (alu_operand_a_o (_ BitVec 33)) (op_a_shift_q (_ BitVec 33)) (operator_i (_ BitVec 2))) Bool (bvult MD_ABS_A MD_FINISH))
)
(
(define-fun inv ((MD_LAST (_ BitVec 3)) (alu_adder_ext_i (_ BitVec 34)) (multdiv_state_d (_ BitVec 5)) (next_reminder (_ BitVec 33)) (sign_b Bool)) Bool (= MD_LAST (bvneg MD_LAST)))
)
(
(define-fun inv ((MD_COMP (_ BitVec 3)) (MD_LAST (_ BitVec 3)) (multdiv_result_o (_ BitVec 32)) (op_b_shift_q (_ BitVec 33)) (rem_change_sign Bool)) Bool (bvult MD_COMP MD_LAST))
)
(
(define-fun inv ((MD_COMP (_ BitVec 3)) (MD_LAST (_ BitVec 3)) (multdiv_state_q (_ BitVec 5)) (op_a_i (_ BitVec 32)) (sign_b Bool)) Bool (bvult MD_COMP MD_LAST))
)
(
(define-fun inv ((MD_LAST (_ BitVec 3)) (alu_adder_ext_i (_ BitVec 34)) (alu_operand_b_o (_ BitVec 33)) (is_greater_equal Bool) (sign_b Bool)) Bool (= MD_LAST (bvneg MD_LAST)))
)
(
(define-fun inv ((MD_ABS_A (_ BitVec 3)) (MD_IDLE (_ BitVec 3)) (op_a_ext (_ BitVec 33)) (op_b_shift_q (_ BitVec 33)) (valid_o Bool)) Bool (bvult MD_IDLE MD_ABS_A))
)
(
(define-fun inv ((MD_COMP (_ BitVec 3)) (next_quotient (_ BitVec 33)) (op_b_shift_q (_ BitVec 33)) (op_numerator_q (_ BitVec 32)) (rem_change_sign Bool)) Bool (bvule MD_COMP (bvneg MD_COMP)))
)
(
(define-fun inv ((MD_COMP (_ BitVec 3)) (accum_window_d (_ BitVec 33)) (alu_adder_i (_ BitVec 32)) (multdiv_result_o (_ BitVec 32)) (next_reminder (_ BitVec 33))) Bool (bvule (bvmul MD_COMP MD_COMP) MD_COMP))
)
(
(define-fun inv ((MD_ABS_A (_ BitVec 3)) (b_0 (_ BitVec 32)) (mult_en_i Bool) (next_quotient (_ BitVec 33)) (sign_a Bool)) Bool (= MD_ABS_A (bvmul MD_ABS_A MD_ABS_A)))
)
(
(define-fun inv ((alu_operand_b_o (_ BitVec 33)) (next_reminder (_ BitVec 33)) (op_a_shift_d (_ BitVec 33)) (rem_change_sign Bool) (sign_a Bool)) Bool (= rem_change_sign sign_a))
)
(
(define-fun inv ((div_change_sign Bool) (multdiv_state_m1 (_ BitVec 5)) (op_remainder (_ BitVec 33)) (rem_change_sign Bool) (sign_a Bool)) Bool (= rem_change_sign sign_a))
)
(
(define-fun inv ((MD_OP_MULL (_ BitVec 2)) (one_shift (_ BitVec 33)) (op_a_i (_ BitVec 32)) (op_numerator_d (_ BitVec 32)) (operator_i (_ BitVec 2))) Bool (= MD_OP_MULL (bvneg MD_OP_MULL)))
)
(
(define-fun inv ((MD_COMP (_ BitVec 3)) (alu_adder_ext_i (_ BitVec 34)) (alu_adder_i (_ BitVec 32)) (div_change_sign Bool) (op_a_shift_q (_ BitVec 33))) Bool (bvule (bvmul MD_COMP MD_COMP) MD_COMP))
)
(
(define-fun inv ((MD_COMP (_ BitVec 3)) (equal_to_zero Bool) (op_a_ext (_ BitVec 33)) (op_a_shift_q (_ BitVec 33)) (res_adder_h (_ BitVec 33))) Bool (bvule (bvmul MD_COMP MD_COMP) MD_COMP))
)
(
(define-fun inv ((MD_OP_MULL (_ BitVec 2)) (alu_adder_i (_ BitVec 32)) (clk_i Bool) (is_greater_equal Bool) (multdiv_state_m1 (_ BitVec 5))) Bool (= MD_OP_MULL (bvneg MD_OP_MULL)))
)
(
(define-fun inv ((MD_ABS_A (_ BitVec 3)) (MD_FINISH (_ BitVec 3)) (equal_to_zero Bool) (next_quotient (_ BitVec 33)) (res_adder_l (_ BitVec 33))) Bool (bvult MD_ABS_A MD_FINISH))
)
(
(define-fun inv ((MD_FINISH (_ BitVec 3)) (MD_OP_DIV (_ BitVec 2)) (alu_operand_b_o (_ BitVec 33)) (multdiv_result_o (_ BitVec 32)) (op_numerator_q (_ BitVec 32))) Bool (= MD_OP_DIV (bvneg MD_OP_DIV)))
)
(
(define-fun inv ((MD_OP_MULH (_ BitVec 2)) (div_en_i Bool) (multdiv_result_o (_ BitVec 32)) (op_b_shift_q (_ BitVec 33)) (op_numerator_d (_ BitVec 32))) Bool (bvule MD_OP_MULH (bvneg MD_OP_MULH)))
)
(
(define-fun inv ((MD_FINISH (_ BitVec 3)) (MD_LAST (_ BitVec 3)) (next_quotient (_ BitVec 33)) (op_a_shift_d (_ BitVec 33)) (op_b_i (_ BitVec 32))) Bool (bvult MD_LAST MD_FINISH))
)
(
(define-fun inv ((MD_IDLE (_ BitVec 3)) (multdiv_state_d (_ BitVec 5)) (op_a_shift_q (_ BitVec 33)) (op_b_i (_ BitVec 32)) (op_numerator_d (_ BitVec 32))) Bool (= MD_IDLE (bvneg MD_IDLE)))
)
(
(define-fun inv ((MD_LAST (_ BitVec 3)) (MD_OP_MULL (_ BitVec 2)) (clk_i Bool) (op_a_i (_ BitVec 32)) (res_adder_h (_ BitVec 33))) Bool (= MD_OP_MULL (bvneg MD_OP_MULL)))
)
(
(define-fun inv ((MD_IDLE (_ BitVec 3)) (MD_LAST (_ BitVec 3)) (is_greater_equal Bool) (mult_en_i Bool) (res_adder_l (_ BitVec 33))) Bool (bvult MD_IDLE MD_LAST))
)
(
(define-fun inv ((MD_COMP (_ BitVec 3)) (MD_IDLE (_ BitVec 3)) (b_0 (_ BitVec 32)) (one_shift (_ BitVec 33)) (op_b_shift_d (_ BitVec 33))) Bool (bvult MD_IDLE MD_COMP))
)
(
(define-fun inv ((MD_ABS_A (_ BitVec 3)) (MD_CHANGE_SIGN (_ BitVec 3)) (clk_i Bool) (multdiv_state_m1 (_ BitVec 5)) (valid_o Bool)) Bool (bvult MD_ABS_A MD_CHANGE_SIGN))
)
(
(define-fun inv ((MD_ABS_A (_ BitVec 3)) (MD_FINISH (_ BitVec 3)) (MD_OP_DIV (_ BitVec 2)) (multdiv_state_m1 (_ BitVec 5)) (op_a_i (_ BitVec 32))) Bool (bvult MD_ABS_A MD_FINISH))
)
(
(define-fun inv ((MD_OP_MULL (_ BitVec 2)) (md_state_q (_ BitVec 3)) (multdiv_state_m1 (_ BitVec 5)) (op_a_i (_ BitVec 32)) (op_a_shift_q (_ BitVec 33))) Bool (= MD_OP_MULL (bvneg MD_OP_MULL)))
)
(
(define-fun inv ((MD_ABS_A (_ BitVec 3)) (MD_ABS_B (_ BitVec 3)) (MD_CHANGE_SIGN (_ BitVec 3)) (MD_COMP (_ BitVec 3)) (MD_FINISH (_ BitVec 3)) (MD_IDLE (_ BitVec 3)) (MD_LAST (_ BitVec 3)) (MD_OP_MULH (_ BitVec 2)) (MD_OP_MULL (_ BitVec 2)) (accum_window_d (_ BitVec 33)) (accum_window_q (_ BitVec 33)) (alu_adder_i (_ BitVec 32)) (div_change_sign Bool) (equal_to_zero Bool) (md_state_d (_ BitVec 3)) (md_state_q (_ BitVec 3)) (multdiv_state_d (_ BitVec 5)) (multdiv_state_m1 (_ BitVec 5)) (multdiv_state_q (_ BitVec 5)) (next_quotient (_ BitVec 33)) (next_reminder (_ BitVec 33)) (op_a_ext (_ BitVec 33)) (op_a_i (_ BitVec 32)) (op_a_shift_d (_ BitVec 33)) (op_a_shift_q (_ BitVec 33)) (op_b_ext (_ BitVec 33)) (op_b_i (_ BitVec 32)) (op_b_shift_d (_ BitVec 33)) (op_b_shift_q (_ BitVec 33)) (op_numerator_d (_ BitVec 32)) (op_numerator_q (_ BitVec 32)) (operator_i (_ BitVec 2)) (rem_change_sign Bool) (res_adder_h (_ BitVec 33)) (res_adder_l (_ BitVec 33)) (sign_a Bool) (sign_b Bool) (valid_o Bool)) Bool (bvule MD_OP_MULL MD_OP_MULH))
)
(
(define-fun inv ((MD_IDLE (_ BitVec 3)) (accum_window_d (_ BitVec 33)) (accum_window_q (_ BitVec 33)) (md_state_d (_ BitVec 3)) (md_state_q (_ BitVec 3)) (multdiv_state_d (_ BitVec 5)) (multdiv_state_q (_ BitVec 5)) (op_a_shift_d (_ BitVec 33)) (op_a_shift_q (_ BitVec 33)) (op_b_shift_d (_ BitVec 33)) (op_b_shift_q (_ BitVec 33)) (op_numerator_d (_ BitVec 32)) (op_numerator_q (_ BitVec 32))) Bool (bvule MD_IDLE md_state_q))
)
