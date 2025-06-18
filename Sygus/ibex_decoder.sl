(
(define-fun inv ((IMM_B_J (_ BitVec 3)) (OPCODE_OP_IMM (_ BitVec 7)) (OP_B_IMM Bool) (zimm_rs1_type_o (_ BitVec 32))) Bool OP_B_IMM)
)
(
(define-fun inv ((ALU_LT (_ BitVec 5)) (OPCODE_BRANCH (_ BitVec 7)) (OP_B_IMM Bool) (OP_B_REG_B Bool) (imm_a_mux_sel_o Bool)) Bool OP_B_IMM)
)
(
(define-fun inv ((ALU_GEU (_ BitVec 5)) (ALU_SRL (_ BitVec 5)) (IMM_B_B (_ BitVec 3)) (OPCODE_BRANCH (_ BitVec 7)) (illegal_insn Bool)) Bool (bvule ALU_SRL ALU_GEU))
)
(
(define-fun inv ((ALU_GE (_ BitVec 5)) (ALU_SUB (_ BitVec 5)) (OP_A_IMM (_ BitVec 2)) (data_we_o Bool) (instr_rdata_i (_ BitVec 32))) Bool (bvule ALU_SUB ALU_GE))
)
(
(define-fun inv ((ALU_SUB (_ BitVec 5)) (OPCODE_STORE (_ BitVec 7)) (data_req_o Bool) (imm_a_mux_sel_o Bool)) Bool (= ALU_SUB (bvmul ALU_SUB ALU_SUB)))
)
(
(define-fun inv ((ALU_LT (_ BitVec 5)) (IMM_B_INCR_PC (_ BitVec 3)) (OPCODE_AUIPC (_ BitVec 7)) (RV32E (_ BitVec 32)) (illegal_c_insn_i Bool)) Bool (= IMM_B_INCR_PC (bvneg IMM_B_INCR_PC)))
)
(
(define-fun inv ((ALU_GE (_ BitVec 5)) (ALU_SUB (_ BitVec 5)) (OPCODE_JALR (_ BitVec 7)) (imm_j_type_o (_ BitVec 32)) (regfile_raddr_a_o (_ BitVec 5))) Bool (bvule ALU_SUB ALU_GE))
)
(
(define-fun inv ((OPCODE_OP (_ BitVec 7)) (OPCODE_OP_IMM (_ BitVec 7)) (alu_op_b_mux_sel_o Bool) (csr_pipe_flush_o Bool) (instr_new_i Bool)) Bool (bvule OPCODE_OP_IMM OPCODE_OP))
)
(
(define-fun inv ((OP_B_IMM Bool) (illegal_reg_rv32e Bool) (opcode (_ BitVec 7)) (wfi_insn_o Bool)) Bool OP_B_IMM)
)
(
(define-fun inv ((ALU_SRL (_ BitVec 5)) (CSR_OP_READ (_ BitVec 2)) (MD_OP_DIV (_ BitVec 2)) (MD_OP_REM (_ BitVec 2)) (regfile_raddr_a_o (_ BitVec 5))) Bool (bvule CSR_OP_READ MD_OP_DIV))
)
(
(define-fun inv ((ALU_XOR (_ BitVec 5)) (RF_WD_LSU (_ BitVec 2)) (data_we_o Bool) (opcode (_ BitVec 7))) Bool (= RF_WD_LSU (bvneg RF_WD_LSU)))
)
(
(define-fun inv ((ALU_GE (_ BitVec 5)) (IMM_A_Z Bool) (IMM_B_B (_ BitVec 3)) (alu_op_b_mux_sel_o Bool) (regfile_raddr_a_o (_ BitVec 5))) Bool (not IMM_A_Z))
)
(
(define-fun inv ((IMM_B_J (_ BitVec 3)) (instr_new_i Bool) (jump_in_dec_o Bool) (multdiv_signed_mode_o (_ BitVec 2)) (regfile_raddr_a_o (_ BitVec 5))) Bool (= IMM_B_J (bvneg IMM_B_J)))
)
(
(define-fun inv ((ALU_SLT (_ BitVec 5)) (OPCODE_LUI (_ BitVec 7)) (dret_insn_o Bool) (imm_b_type_o (_ BitVec 32)) (imm_i_type_o (_ BitVec 32))) Bool (bvule OPCODE_LUI (bvneg OPCODE_LUI)))
)
(
(define-fun inv ((ALU_ADD (_ BitVec 5)) (data_sign_extension_o Bool) (data_we_o Bool) (mult_en_o Bool)) Bool (= ALU_ADD (bvneg ALU_ADD)))
)
(
(define-fun inv ((ALU_ADD (_ BitVec 5)) (OPCODE_LOAD (_ BitVec 7)) (OPCODE_OP (_ BitVec 7)) (alu_op_a_mux_sel_o (_ BitVec 2)) (dret_insn_o Bool)) Bool (bvule OPCODE_LOAD OPCODE_OP))
)
(
(define-fun inv ((OP_A_CURRPC (_ BitVec 2)) (branch_in_dec_o Bool) (imm_u_type_o (_ BitVec 32)) (instr_rdata_i (_ BitVec 32))) Bool (bvule imm_u_type_o instr_rdata_i))
)
(
(define-fun inv ((ALU_SLT (_ BitVec 5)) (IMM_A_ZERO Bool) (OPCODE_LOAD (_ BitVec 7)) (data_req_o Bool) (instr (_ BitVec 32))) Bool (bvule OPCODE_LOAD (bvneg OPCODE_LOAD)))
)
(
(define-fun inv ((ALU_GE (_ BitVec 5)) (ALU_LT (_ BitVec 5)) (CSR_OP_SET (_ BitVec 2)) (IMM_B_J (_ BitVec 3)) (MD_OP_REM (_ BitVec 2))) Bool (bvule ALU_LT ALU_GE))
)
(
(define-fun inv ((ALU_XOR (_ BitVec 5)) (CSR_OP_READ (_ BitVec 2)) (MD_OP_REM (_ BitVec 2)) (ebrk_insn_o Bool)) Bool (bvule CSR_OP_READ MD_OP_REM))
)
(
(define-fun inv ((IMM_B_INCR_PC (_ BitVec 3)) (alu_operator_o (_ BitVec 5)) (illegal_c_insn_i Bool) (imm_i_type_o (_ BitVec 32)) (multdiv_operator_o (_ BitVec 2))) Bool (= IMM_B_INCR_PC (bvneg IMM_B_INCR_PC)))
)
(
(define-fun inv ((ALU_LTU (_ BitVec 5)) (IMM_B_B (_ BitVec 3)) (branch_in_dec_o Bool) (data_sign_extension_o Bool) (mret_insn_o Bool)) Bool (bvule IMM_B_B (bvneg IMM_B_B)))
)
(
(define-fun inv ((ALU_SRL (_ BitVec 5)) (MD_OP_DIV (_ BitVec 2)) (regfile_we Bool) (regfile_we_o Bool)) Bool (= regfile_we regfile_we_o))
)
(
(define-fun inv ((branch_in_dec_o Bool) (data_type_o (_ BitVec 2)) (ebrk_insn_o Bool) (illegal_reg_rv32e Bool) (instr_new_i Bool)) Bool (not illegal_reg_rv32e))
)
(
(define-fun inv ((IMM_B_S (_ BitVec 3)) (illegal_insn Bool) (imm_a_mux_sel_o Bool) (wfi_insn_o Bool)) Bool (= IMM_B_S (bvmul IMM_B_S IMM_B_S)))
)
(
(define-fun inv ((ALU_SLL (_ BitVec 5)) (csr_access_o Bool) (imm_b_mux_sel_o (_ BitVec 3)) (regfile_we Bool)) Bool (bvule imm_b_mux_sel_o (bvneg imm_b_mux_sel_o)))
)
(
(define-fun inv ((ALU_ADD (_ BitVec 5)) (CSR_OP_SET (_ BitVec 2)) (imm_u_type_o (_ BitVec 32)) (jump_set_o Bool) (regfile_waddr_o (_ BitVec 5))) Bool (= CSR_OP_SET (bvneg CSR_OP_SET)))
)
(
(define-fun inv ((IMM_A_Z Bool) (csr_pipe_flush_o Bool) (dret_insn_o Bool)) Bool (not (and csr_pipe_flush_o dret_insn_o)))
)
(
(define-fun inv ((ALU_LT (_ BitVec 5)) (MD_OP_MULH (_ BitVec 2)) (OPCODE_LUI (_ BitVec 7)) (instr (_ BitVec 32)) (regfile_we Bool)) Bool (bvule MD_OP_MULH (bvneg MD_OP_MULH)))
)
(
(define-fun inv ((MD_OP_MULL (_ BitVec 2)) (OPCODE_JALR (_ BitVec 7)) (csr_op (_ BitVec 2)) (data_sign_extension_o Bool) (imm_i_type_o (_ BitVec 32))) Bool (bvule MD_OP_MULL csr_op))
)
(
(define-fun inv ((ALU_OR (_ BitVec 5)) (CSR_OP_WRITE (_ BitVec 2)) (IMM_B_U (_ BitVec 3)) (alu_operator_o (_ BitVec 5)) (mult_en_o Bool)) Bool (bvule CSR_OP_WRITE (bvneg CSR_OP_WRITE)))
)
(
(define-fun inv ((ALU_NE (_ BitVec 5)) (IMM_B_S (_ BitVec 3)) (RV32E (_ BitVec 32)) (alu_operator_o (_ BitVec 5)) (regfile_we Bool)) Bool (bvule IMM_B_S (bvneg IMM_B_S)))
)
(
(define-fun inv ((ALU_ADD (_ BitVec 5)) (OPCODE_OP (_ BitVec 7)) (OP_B_REG_B Bool) (RF_WD_LSU (_ BitVec 2)) (csr_illegal Bool)) Bool (= RF_WD_LSU (bvneg RF_WD_LSU)))
)
(
(define-fun inv ((ALU_SLT (_ BitVec 5)) (ALU_SRA (_ BitVec 5)) (MD_OP_MULH (_ BitVec 2)) (OPCODE_JALR (_ BitVec 7)) (RF_WD_LSU (_ BitVec 2))) Bool (bvule RF_WD_LSU MD_OP_MULH))
)
(
(define-fun inv ((OP_A_REG_A (_ BitVec 2)) (RV32E (_ BitVec 32)) (alu_op_a_mux_sel_o (_ BitVec 2)) (instr_new_i Bool) (instr_rdata_i (_ BitVec 32))) Bool (bvule RV32E instr_rdata_i))
)
(
(define-fun inv ((ALU_EQ (_ BitVec 5)) (illegal_c_insn_i Bool) (illegal_insn Bool) (mret_insn_o Bool) (regfile_wdata_sel_o (_ BitVec 2))) Bool (bvule ALU_EQ (bvmul ALU_EQ ALU_EQ)))
)
(
(define-fun inv ((ALU_SLL (_ BitVec 5)) (MD_OP_MULL (_ BitVec 2)) (OPCODE_LOAD (_ BitVec 7)) (multdiv_operator_o (_ BitVec 2))) Bool (bvule MD_OP_MULL multdiv_operator_o))
)
(
(define-fun inv ((OPCODE_JALR (_ BitVec 7)) (RF_WD_LSU (_ BitVec 2)) (alu_operator_o (_ BitVec 5)) (regfile_waddr_o (_ BitVec 5)) (regfile_wdata_sel_o (_ BitVec 2))) Bool (bvule RF_WD_LSU (bvnot RF_WD_LSU)))
)
(
(define-fun inv ((ALU_LTU (_ BitVec 5)) (CSR_OP_READ (_ BitVec 2)) (IMM_B_I (_ BitVec 3)) (OPCODE_BRANCH (_ BitVec 7)) (branch_in_dec_o Bool)) Bool (= CSR_OP_READ (bvneg CSR_OP_READ)))
)
(
(define-fun inv ((IMM_A_Z Bool) (RF_WD_CSR (_ BitVec 2)) (RF_WD_EX (_ BitVec 2)) (imm_j_type_o (_ BitVec 32))) Bool (= RF_WD_CSR (bvneg RF_WD_CSR)))
)
(
(define-fun inv ((ALU_LTU (_ BitVec 5)) (MD_OP_DIV (_ BitVec 2)) (OP_B_IMM Bool) (div_en_o Bool) (imm_u_type_o (_ BitVec 32))) Bool (= MD_OP_DIV (bvneg MD_OP_DIV)))
)
(
(define-fun inv ((ALU_LT (_ BitVec 5)) (ALU_OR (_ BitVec 5)) (imm_u_type_o (_ BitVec 32)) (regfile_waddr_o (_ BitVec 5)) (regfile_we_o Bool)) Bool (bvule ALU_OR ALU_LT))
)
(
(define-fun inv ((ALU_SUB (_ BitVec 5)) (IMM_B_U (_ BitVec 3)) (branch_in_dec_o Bool) (ecall_insn_o Bool) (mret_insn_o Bool)) Bool (bvule IMM_B_U (bvneg IMM_B_U)))
)
(
(define-fun inv ((ALU_EQ (_ BitVec 5)) (ALU_GE (_ BitVec 5)) (IMM_B_J (_ BitVec 3)) (MD_OP_REM (_ BitVec 2)) (imm_b_type_o (_ BitVec 32))) Bool (bvule ALU_GE ALU_EQ))
)
(
(define-fun inv ((ALU_GE (_ BitVec 5)) (ALU_SRL (_ BitVec 5)) (IMM_A_Z Bool) (OPCODE_OP_IMM (_ BitVec 7)) (illegal_insn Bool)) Bool (bvule ALU_SRL ALU_GE))
)
(
(define-fun inv ((IMM_A_ZERO Bool) (OPCODE_AUIPC (_ BitVec 7)) (RF_WD_EX (_ BitVec 2)) (imm_a_mux_sel_o Bool) (regfile_we Bool)) Bool IMM_A_ZERO)
)
(
(define-fun inv ((OPCODE_OP_IMM (_ BitVec 7)) (RF_WD_LSU (_ BitVec 2)) (RV32M (_ BitVec 32)) (illegal_c_insn_i Bool) (instr_rdata_i (_ BitVec 32))) Bool (bvule RF_WD_LSU (bvnot RF_WD_LSU)))
)
(
(define-fun inv ((IMM_B_S (_ BitVec 3)) (OPCODE_JAL (_ BitVec 7)) (OP_B_REG_B Bool) (instr_new_i Bool) (mret_insn_o Bool)) Bool (= IMM_B_S (bvmul IMM_B_S IMM_B_S)))
)
(
(define-fun inv ((ALU_SLL (_ BitVec 5)) (IMM_B_J (_ BitVec 3)) (illegal_insn_o Bool) (jump_set_o Bool) (multdiv_operator_o (_ BitVec 2))) Bool (= IMM_B_J (bvneg IMM_B_J)))
)
(
(define-fun inv ((ALU_XOR (_ BitVec 5)) (OPCODE_OP (_ BitVec 7)) (illegal_reg_rv32e Bool) (jump_in_dec_o Bool) (zimm_rs1_type_o (_ BitVec 32))) Bool (bvule ALU_XOR (bvmul ALU_XOR ALU_XOR)))
)
(
(define-fun inv ((RV32E (_ BitVec 32)) (alu_operator_o (_ BitVec 5)) (data_we_o Bool) (regfile_raddr_b_o (_ BitVec 5)) (regfile_waddr_o (_ BitVec 5))) Bool (= RV32E (bvneg RV32E)))
)
(
(define-fun inv ((ALU_AND (_ BitVec 5)) (OP_A_REG_A (_ BitVec 2)) (alu_operator_o (_ BitVec 5)) (csr_op (_ BitVec 2)) (imm_s_type_o (_ BitVec 32))) Bool (bvule OP_A_REG_A csr_op))
)
(
(define-fun inv ((ALU_SRL (_ BitVec 5)) (RF_WD_CSR (_ BitVec 2)) (imm_j_type_o (_ BitVec 32))) Bool (= RF_WD_CSR (bvneg RF_WD_CSR)))
)
(
(define-fun inv ((ALU_LT (_ BitVec 5)) (OP_B_IMM Bool) (data_we_o Bool) (ecall_insn_o Bool) (wfi_insn_o Bool)) Bool (not (and data_we_o ecall_insn_o)))
)
(
(define-fun inv ((OP_A_REG_A (_ BitVec 2)) (RF_WD_LSU (_ BitVec 2)) (ecall_insn_o Bool) (imm_b_mux_sel_o (_ BitVec 3)) (instr_new_i Bool)) Bool (= OP_A_REG_A RF_WD_LSU))
)
(
(define-fun inv ((ALU_OR (_ BitVec 5)) (RF_WD_EX (_ BitVec 2)) (csr_pipe_flush_o Bool) (instr (_ BitVec 32))) Bool (bvule RF_WD_EX (bvneg RF_WD_EX)))
)
(
(define-fun inv ((IMM_B_U (_ BitVec 3)) (OPCODE_BRANCH (_ BitVec 7)) (OPCODE_JALR (_ BitVec 7)) (OP_A_REG_A (_ BitVec 2)) (OP_B_REG_B Bool)) Bool (bvule OPCODE_BRANCH OPCODE_JALR))
)
(
(define-fun inv ((CSR_OP_WRITE (_ BitVec 2)) (IMM_B_B (_ BitVec 3)) (mult_en_o Bool) (opcode (_ BitVec 7))) Bool (bvule IMM_B_B (bvneg IMM_B_B)))
)
(
(define-fun inv ((ALU_SLT (_ BitVec 5)) (IMM_B_INCR_PC (_ BitVec 3)) (MD_OP_MULL (_ BitVec 2)) (data_sign_extension_o Bool) (multdiv_signed_mode_o (_ BitVec 2))) Bool (= IMM_B_INCR_PC (bvneg IMM_B_INCR_PC)))
)
(
(define-fun inv ((ALU_SLL (_ BitVec 5)) (imm_a_mux_sel_o Bool) (imm_j_type_o (_ BitVec 32)) (imm_s_type_o (_ BitVec 32)) (jump_in_dec_o Bool)) Bool (bvule ALU_SLL (bvmul ALU_SLL ALU_SLL)))
)
(
(define-fun inv ((ALU_AND (_ BitVec 5)) (OPCODE_JALR (_ BitVec 7)) (ebrk_insn_o Bool) (illegal_reg_rv32e Bool) (mret_insn_o Bool)) Bool (bvule ALU_AND (bvmul ALU_AND ALU_AND)))
)
(
(define-fun inv ((RF_WD_EX (_ BitVec 2)) (csr_access_o Bool) (dret_insn_o Bool) (illegal_insn Bool) (instr (_ BitVec 32))) Bool (not (and csr_access_o illegal_insn)))
)
(
(define-fun inv ((OP_B_IMM Bool) (data_type_o (_ BitVec 2)) (dret_insn_o Bool) (regfile_raddr_b_o (_ BitVec 5))) Bool OP_B_IMM)
)
(
(define-fun inv ((IMM_B_I (_ BitVec 3)) (IMM_B_INCR_PC (_ BitVec 3)) (IMM_B_U (_ BitVec 3)) (jump_set_o Bool) (regfile_wdata_sel_o (_ BitVec 2))) Bool (bvult IMM_B_I IMM_B_INCR_PC))
)
(
(define-fun inv ((ALU_XOR (_ BitVec 5)) (IMM_B_INCR_PC (_ BitVec 3)) (OPCODE_STORE (_ BitVec 7)) (data_we_o Bool) (regfile_raddr_b_o (_ BitVec 5))) Bool (= IMM_B_INCR_PC (bvneg IMM_B_INCR_PC)))
)
(
(define-fun inv ((IMM_B_B (_ BitVec 3)) (IMM_B_INCR_PC (_ BitVec 3)) (MD_OP_MULH (_ BitVec 2)) (OPCODE_LUI (_ BitVec 7)) (RF_WD_CSR (_ BitVec 2))) Bool (bvule MD_OP_MULH RF_WD_CSR))
)
(
(define-fun inv ((ALU_SRA (_ BitVec 5)) (OPCODE_LOAD (_ BitVec 7)) (data_type_o (_ BitVec 2)) (illegal_reg_rv32e Bool) (regfile_wdata_sel_o (_ BitVec 2))) Bool (not illegal_reg_rv32e))
)
(
(define-fun inv ((OPCODE_JAL (_ BitVec 7)) (RF_WD_LSU (_ BitVec 2)) (branch_in_dec_o Bool) (imm_j_type_o (_ BitVec 32)) (jump_set_o Bool)) Bool (bvule RF_WD_LSU (bvnot RF_WD_LSU)))
)
(
(define-fun inv ((CSR_OP_CLEAR (_ BitVec 2)) (csr_op (_ BitVec 2)) (imm_j_type_o (_ BitVec 32)) (mret_insn_o Bool) (regfile_waddr_o (_ BitVec 5))) Bool (bvule csr_op CSR_OP_CLEAR))
)
(
(define-fun inv ((MD_OP_DIV (_ BitVec 2)) (OP_A_CURRPC (_ BitVec 2)) (ebrk_insn_o Bool) (jump_in_dec_o Bool) (regfile_we Bool)) Bool (= MD_OP_DIV OP_A_CURRPC))
)
(
(define-fun inv ((ALU_AND (_ BitVec 5)) (CSR_OP_CLEAR (_ BitVec 2)) (OPCODE_OP (_ BitVec 7)) (data_we_o Bool) (mult_en_o Bool)) Bool (bvule ALU_AND (bvmul ALU_AND ALU_AND)))
)
(
(define-fun inv ((ALU_SLTU (_ BitVec 5)) (div_en_o Bool) (illegal_insn_o Bool) (instr_rdata_i (_ BitVec 32)) (regfile_raddr_a_o (_ BitVec 5))) Bool (not (and div_en_o illegal_insn_o)))
)
(
(define-fun inv ((CSR_OP_SET (_ BitVec 2)) (OPCODE_BRANCH (_ BitVec 7)) (RV32M (_ BitVec 32)) (imm_s_type_o (_ BitVec 32))) Bool (= CSR_OP_SET (bvneg CSR_OP_SET)))
)
(
(define-fun inv ((CSR_OP_READ (_ BitVec 2)) (MD_OP_DIV (_ BitVec 2)) (RF_WD_CSR (_ BitVec 2)) (csr_op_o (_ BitVec 2)) (data_req_o Bool)) Bool (= MD_OP_DIV RF_WD_CSR))
)
(
(define-fun inv ((ALU_ADD (_ BitVec 5)) (IMM_A_Z Bool) (OPCODE_LUI (_ BitVec 7))) Bool (not IMM_A_Z))
)
(
(define-fun inv ((IMM_B_B (_ BitVec 3)) (OPCODE_BRANCH (_ BitVec 7)) (csr_pipe_flush_o Bool) (multdiv_signed_mode_o (_ BitVec 2)) (regfile_wdata_sel_o (_ BitVec 2))) Bool (bvule IMM_B_B (bvmul IMM_B_B IMM_B_B)))
)
(
(define-fun inv ((CSR_OP_WRITE (_ BitVec 2)) (IMM_B_J (_ BitVec 3)) (RF_WD_EX (_ BitVec 2)) (csr_pipe_flush_o Bool) (imm_a_mux_sel_o Bool)) Bool (= CSR_OP_WRITE RF_WD_EX))
)
(
(define-fun inv ((CSR_OP_READ (_ BitVec 2)) (MD_OP_REM (_ BitVec 2)) (data_we_o Bool) (ebrk_insn_o Bool) (regfile_raddr_b_o (_ BitVec 5))) Bool (= CSR_OP_READ (bvneg CSR_OP_READ)))
)
(
(define-fun inv ((ALU_NE (_ BitVec 5)) (ALU_SUB (_ BitVec 5)) (MD_OP_MULL (_ BitVec 2)) (OPCODE_OP_IMM (_ BitVec 7)) (RF_WD_CSR (_ BitVec 2))) Bool (bvule ALU_SUB ALU_NE))
)
(
(define-fun inv ((ALU_OR (_ BitVec 5)) (RF_WD_LSU (_ BitVec 2)) (RV32E (_ BitVec 32)) (branch_in_dec_o Bool) (illegal_reg_rv32e Bool)) Bool (not illegal_reg_rv32e))
)
(
(define-fun inv ((ALU_SLT (_ BitVec 5)) (MD_OP_MULL (_ BitVec 2)) (csr_op (_ BitVec 2)) (ecall_insn_o Bool) (opcode (_ BitVec 7))) Bool (bvule MD_OP_MULL csr_op))
)
(
(define-fun inv ((ALU_AND (_ BitVec 5)) (OPCODE_AUIPC (_ BitVec 7)) (data_type_o (_ BitVec 2)) (dret_insn_o Bool) (jump_in_dec_o Bool)) Bool (bvule ALU_AND (bvmul ALU_AND ALU_AND)))
)
(
(define-fun inv ((ALU_GE (_ BitVec 5)) (MD_OP_MULH (_ BitVec 2)) (csr_pipe_flush_o Bool) (ebrk_insn_o Bool) (imm_a_mux_sel_o Bool)) Bool (bvule MD_OP_MULH (bvneg MD_OP_MULH)))
)
(
(define-fun inv ((IMM_A_Z Bool) (data_type_o (_ BitVec 2)) (div_en_o Bool) (regfile_wdata_sel_o (_ BitVec 2)) (regfile_we_o Bool)) Bool (bvule data_type_o (bvneg data_type_o)))
)
(
(define-fun inv ((ALU_OR (_ BitVec 5)) (CSR_OP_CLEAR (_ BitVec 2)) (data_we_o Bool) (regfile_wdata_sel_o (_ BitVec 2)) (regfile_we Bool)) Bool (bvule ALU_OR (bvmul ALU_OR ALU_OR)))
)
(
(define-fun inv ((ALU_EQ (_ BitVec 5)) (ALU_OR (_ BitVec 5)) (MD_OP_DIV (_ BitVec 2)) (MD_OP_REM (_ BitVec 2)) (OP_A_REG_A (_ BitVec 2))) Bool (bvult MD_OP_DIV MD_OP_REM))
)
(
(define-fun inv ((IMM_B_J (_ BitVec 3)) (div_en_o Bool) (jump_set_o Bool) (opcode (_ BitVec 7)) (regfile_waddr_o (_ BitVec 5))) Bool (= IMM_B_J (bvneg IMM_B_J)))
)
(
(define-fun inv ((ALU_XOR (_ BitVec 5)) (RF_WD_EX (_ BitVec 2)) (data_sign_extension_o Bool)) Bool (bvule RF_WD_EX (bvneg RF_WD_EX)))
)
(
(define-fun inv ((IMM_B_J (_ BitVec 3)) (div_en_o Bool) (imm_u_type_o (_ BitVec 32)) (mret_insn_o Bool) (multdiv_operator_o (_ BitVec 2))) Bool (= IMM_B_J (bvneg IMM_B_J)))
)
(
(define-fun inv ((ALU_NE (_ BitVec 5)) (ALU_SLL (_ BitVec 5)) (MD_OP_MULH (_ BitVec 2)) (imm_i_type_o (_ BitVec 32)) (mult_en_o Bool)) Bool (bvule ALU_SLL ALU_NE))
)
(
(define-fun inv ((ALU_GEU (_ BitVec 5)) (ALU_OR (_ BitVec 5)) (ALU_SLL (_ BitVec 5)) (OP_A_IMM (_ BitVec 2)) (data_req_o Bool)) Bool (bvule ALU_OR ALU_GEU))
)
(
(define-fun inv ((ALU_SRA (_ BitVec 5)) (OP_B_REG_B Bool) (instr (_ BitVec 32))) Bool (not OP_B_REG_B))
)
(
(define-fun inv ((IMM_B_U (_ BitVec 3)) (MD_OP_MULL (_ BitVec 2)) (OPCODE_JALR (_ BitVec 7)) (csr_op (_ BitVec 2)) (instr_new_i Bool)) Bool (bvule MD_OP_MULL csr_op))
)
(
(define-fun inv ((ALU_NE (_ BitVec 5)) (ALU_SRA (_ BitVec 5)) (alu_op_a_mux_sel_o (_ BitVec 2)) (imm_s_type_o (_ BitVec 32)) (imm_u_type_o (_ BitVec 32))) Bool (bvule ALU_SRA ALU_NE))
)
(
(define-fun inv ((MD_OP_DIV (_ BitVec 2)) (OPCODE_JALR (_ BitVec 7)) (alu_operator_o (_ BitVec 5)) (illegal_insn_o Bool)) Bool (= MD_OP_DIV (bvneg MD_OP_DIV)))
)
(
(define-fun inv ((ALU_LTU (_ BitVec 5)) (ALU_SRA (_ BitVec 5)) (dret_insn_o Bool) (imm_u_type_o (_ BitVec 32))) Bool (bvule ALU_SRA ALU_LTU))
)
(
(define-fun inv ((ALU_LTU (_ BitVec 5)) (alu_op_b_mux_sel_o Bool) (branch_in_dec_o Bool) (instr_rdata_i (_ BitVec 32)) (opcode (_ BitVec 7))) Bool (bvule ALU_LTU (bvmul ALU_LTU ALU_LTU)))
)
(
(define-fun inv ((IMM_A_ZERO Bool) (IMM_B_U (_ BitVec 3)) (alu_op_b_mux_sel_o Bool) (csr_illegal Bool) (csr_op (_ BitVec 2))) Bool IMM_A_ZERO)
)
(
(define-fun inv ((CSR_OP_READ (_ BitVec 2)) (IMM_B_INCR_PC (_ BitVec 3)) (data_we_o Bool)) Bool (= CSR_OP_READ (bvneg CSR_OP_READ)))
)
(
(define-fun inv ((ALU_ADD (_ BitVec 5)) (ALU_NE (_ BitVec 5)) (IMM_A_ZERO Bool) (RF_WD_LSU (_ BitVec 2)) (alu_op_a_mux_sel_o (_ BitVec 2))) Bool IMM_A_ZERO)
)
(
(define-fun inv ((ALU_ADD (_ BitVec 5)) (IMM_A_Z Bool) (mret_insn_o Bool) (regfile_wdata_sel_o (_ BitVec 2))) Bool (not IMM_A_Z))
)
(
(define-fun inv ((ALU_NE (_ BitVec 5)) (IMM_B_U (_ BitVec 3)) (OPCODE_LUI (_ BitVec 7)) (illegal_insn Bool) (regfile_raddr_a_o (_ BitVec 5))) Bool (bvule IMM_B_U (bvneg IMM_B_U)))
)
(
(define-fun inv ((ALU_NE (_ BitVec 5)) (ALU_OR (_ BitVec 5)) (ALU_SLT (_ BitVec 5)) (IMM_B_I (_ BitVec 3)) (data_req_o Bool)) Bool (bvule ALU_NE ALU_SLT))
)
(
(define-fun inv ((ALU_OR (_ BitVec 5)) (MD_OP_MULL (_ BitVec 2)) (alu_op_a_mux_sel_o (_ BitVec 2)) (illegal_reg_rv32e Bool) (instr_rdata_i (_ BitVec 32))) Bool (bvule MD_OP_MULL alu_op_a_mux_sel_o))
)
(
(define-fun inv ((IMM_B_S (_ BitVec 3)) (MD_OP_MULL (_ BitVec 2)) (OPCODE_STORE (_ BitVec 7)) (instr_new_i Bool) (multdiv_operator_o (_ BitVec 2))) Bool (= MD_OP_MULL (bvneg MD_OP_MULL)))
)
(
(define-fun inv ((ALU_XOR (_ BitVec 5)) (MD_OP_REM (_ BitVec 2)) (ecall_insn_o Bool) (illegal_insn Bool) (illegal_reg_rv32e Bool)) Bool (bvule ALU_XOR (bvmul ALU_XOR ALU_XOR)))
)
(
(define-fun inv ((CSR_OP_WRITE (_ BitVec 2)) (IMM_B_U (_ BitVec 3)) (OPCODE_JALR (_ BitVec 7)) (OP_A_REG_A (_ BitVec 2)) (regfile_wdata_sel_o (_ BitVec 2))) Bool (bvule IMM_B_U (bvneg IMM_B_U)))
)
(
(define-fun inv ((IMM_A_Z Bool) (OPCODE_LOAD (_ BitVec 7)) (div_en_o Bool) (mult_en_o Bool)) Bool (bvule OPCODE_LOAD (bvneg OPCODE_LOAD)))
)
(
(define-fun inv ((ALU_OR (_ BitVec 5)) (CSR_OP_CLEAR (_ BitVec 2)) (MD_OP_REM (_ BitVec 2)) (OP_B_IMM Bool) (RF_WD_EX (_ BitVec 2))) Bool OP_B_IMM)
)
(
(define-fun inv ((ALU_SLL (_ BitVec 5)) (IMM_B_U (_ BitVec 3)) (OPCODE_BRANCH (_ BitVec 7)) (csr_pipe_flush_o Bool) (data_we_o Bool)) Bool (bvule IMM_B_U (bvneg IMM_B_U)))
)
(
(define-fun inv ((IMM_B_S (_ BitVec 3)) (OP_A_REG_A (_ BitVec 2)) (imm_j_type_o (_ BitVec 32)) (jump_in_dec_o Bool) (multdiv_operator_o (_ BitVec 2))) Bool (= OP_A_REG_A (bvneg OP_A_REG_A)))
)
(
(define-fun inv ((ALU_SRL (_ BitVec 5)) (ALU_SUB (_ BitVec 5)) (CSR_OP_READ (_ BitVec 2)) (OPCODE_BRANCH (_ BitVec 7)) (regfile_raddr_b_o (_ BitVec 5))) Bool (bvule ALU_SUB ALU_SRL))
)
(
(define-fun inv ((IMM_A_Z Bool) (csr_illegal Bool) (csr_pipe_flush_o Bool) (data_type_o (_ BitVec 2)) (illegal_insn Bool)) Bool (not (and csr_illegal csr_pipe_flush_o)))
)
(
(define-fun inv ((ALU_SLTU (_ BitVec 5)) (ALU_SRA (_ BitVec 5)) (ALU_SRL (_ BitVec 5)) (OP_A_REG_A (_ BitVec 2)) (RF_WD_LSU (_ BitVec 2))) Bool (bvule ALU_SRA ALU_SLTU))
)
(
(define-fun inv ((ALU_LTU (_ BitVec 5)) (OPCODE_AUIPC (_ BitVec 7)) (OPCODE_BRANCH (_ BitVec 7)) (csr_op (_ BitVec 2)) (csr_pipe_flush_o Bool)) Bool (bvule OPCODE_AUIPC OPCODE_BRANCH))
)
(
(define-fun inv ((ALU_ADD (_ BitVec 5)) (CSR_OP_CLEAR (_ BitVec 2)) (OP_A_IMM (_ BitVec 2)) (imm_j_type_o (_ BitVec 32)) (regfile_we Bool)) Bool (= CSR_OP_CLEAR OP_A_IMM))
)
(
(define-fun inv ((ALU_AND (_ BitVec 5)) (ALU_SUB (_ BitVec 5)) (ebrk_insn_o Bool) (mult_en_o Bool)) Bool (bvule ALU_SUB ALU_AND))
)
(
(define-fun inv ((ALU_GEU (_ BitVec 5)) (ALU_SLL (_ BitVec 5)) (CSR_OP_WRITE (_ BitVec 2)) (div_en_o Bool) (jump_set_o Bool)) Bool (bvule ALU_SLL ALU_GEU))
)
(
(define-fun inv ((ALU_AND (_ BitVec 5)) (OPCODE_OP (_ BitVec 7)) (data_type_o (_ BitVec 2)) (imm_b_mux_sel_o (_ BitVec 3)) (imm_u_type_o (_ BitVec 32))) Bool (bvule imm_b_mux_sel_o (bvneg imm_b_mux_sel_o)))
)
(
(define-fun inv ((ALU_LT (_ BitVec 5)) (CSR_OP_CLEAR (_ BitVec 2)) (OPCODE_OP_IMM (_ BitVec 7)) (RF_WD_CSR (_ BitVec 2)) (zimm_rs1_type_o (_ BitVec 32))) Bool (bvult OPCODE_OP_IMM (bvneg OPCODE_OP_IMM)))
)
(
(define-fun inv ((ALU_SRL (_ BitVec 5)) (OP_B_REG_B Bool) (ebrk_insn_o Bool) (instr_new_i Bool) (regfile_we_o Bool)) Bool (not OP_B_REG_B))
)
(
(define-fun inv ((CSR_OP_WRITE (_ BitVec 2)) (MD_OP_MULL (_ BitVec 2)) (alu_op_b_mux_sel_o Bool) (imm_b_type_o (_ BitVec 32)) (regfile_raddr_b_o (_ BitVec 5))) Bool (bvule MD_OP_MULL CSR_OP_WRITE))
)
(
(define-fun inv ((CSR_DCSR (_ BitVec 12)) (CSR_DPC (_ BitVec 12)) (CSR_DSCRATCH0 (_ BitVec 12)) (CSR_DSCRATCH1 (_ BitVec 12)) (CSR_MIE (_ BitVec 12)) (CSR_MSTATUS (_ BitVec 12)) (CSR_OP_READ (_ BitVec 2)) (CSR_OP_SET (_ BitVec 2)) (CSR_OP_WRITE (_ BitVec 2)) (csr_access_o Bool) (csr_op_o (_ BitVec 2)) (csr_pipe_flush_o Bool) (instr (_ BitVec 32))) Bool (bvult CSR_OP_READ CSR_OP_SET))
)
(
(define-fun inv ((ALU_ADD (_ BitVec 5)) (ALU_AND (_ BitVec 5)) (ALU_EQ (_ BitVec 5)) (ALU_GE (_ BitVec 5)) (ALU_GEU (_ BitVec 5)) (ALU_LT (_ BitVec 5)) (ALU_LTU (_ BitVec 5)) (ALU_NE (_ BitVec 5)) (ALU_OR (_ BitVec 5)) (ALU_SLL (_ BitVec 5)) (ALU_SLT (_ BitVec 5)) (ALU_SLTU (_ BitVec 5)) (ALU_SRA (_ BitVec 5)) (ALU_SRL (_ BitVec 5)) (ALU_SUB (_ BitVec 5)) (ALU_XOR (_ BitVec 5)) (CSR_OP_CLEAR (_ BitVec 2)) (CSR_OP_READ (_ BitVec 2)) (CSR_OP_SET (_ BitVec 2)) (CSR_OP_WRITE (_ BitVec 2)) (IMM_A_Z Bool) (IMM_A_ZERO Bool) (IMM_B_B (_ BitVec 3)) (IMM_B_I (_ BitVec 3)) (IMM_B_INCR_PC (_ BitVec 3)) (IMM_B_J (_ BitVec 3)) (IMM_B_S (_ BitVec 3)) (IMM_B_U (_ BitVec 3)) (MD_OP_DIV (_ BitVec 2)) (MD_OP_MULH (_ BitVec 2)) (MD_OP_MULL (_ BitVec 2)) (MD_OP_REM (_ BitVec 2)) (OP_A_CURRPC (_ BitVec 2)) (OP_A_IMM (_ BitVec 2)) (OP_A_REG_A (_ BitVec 2)) (OP_B_IMM Bool) (OP_B_REG_B Bool) (RF_WD_CSR (_ BitVec 2)) (RF_WD_EX (_ BitVec 2)) (RF_WD_LSU (_ BitVec 2)) (RV32M (_ BitVec 32)) (alu_op_a_mux_sel_o (_ BitVec 2)) (alu_op_b_mux_sel_o Bool) (alu_operator_o (_ BitVec 5)) (branch_in_dec_o Bool) (csr_access_o Bool) (csr_illegal Bool) (csr_op (_ BitVec 2)) (data_req_o Bool) (data_sign_extension_o Bool) (data_type_o (_ BitVec 2)) (data_we_o Bool) (div_en_o Bool) (dret_insn_o Bool) (ebrk_insn_o Bool) (ecall_insn_o Bool) (illegal_insn Bool) (illegal_insn_o Bool) (illegal_reg_rv32e Bool) (imm_a_mux_sel_o Bool) (imm_b_mux_sel_o (_ BitVec 3)) (instr (_ BitVec 32)) (jump_in_dec_o Bool) (jump_set_o Bool) (mret_insn_o Bool) (mult_en_o Bool) (multdiv_operator_o (_ BitVec 2)) (multdiv_signed_mode_o (_ BitVec 2)) (opcode (_ BitVec 7)) (regfile_wdata_sel_o (_ BitVec 2)) (regfile_we Bool) (regfile_we_o Bool) (wfi_insn_o Bool)) Bool IMM_A_ZERO)
)
