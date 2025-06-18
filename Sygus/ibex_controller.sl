(
(define-fun inv ((EXC_PC_DBD (_ BitVec 2)) (PC_BOOT (_ BitVec 3)) (PC_JUMP (_ BitVec 3)) (debug_mode_q Bool) (exc_req_q Bool)) Bool (= EXC_PC_DBD (bvneg EXC_PC_DBD)))
)
(
(define-fun inv ((PC_EXC (_ BitVec 3)) (ctrl_fsm_ns (_ BitVec 4)) (dret_insn Bool) (instr_req_o Bool) (stall_jump_i Bool)) Bool (bvule PC_EXC (bvmul PC_EXC PC_EXC)))
)
(
(define-fun inv ((EXC_CAUSE_BREAKPOINT (_ BitVec 6)) (EXC_CAUSE_ILLEGAL_INSN (_ BitVec 6)) (EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (csr_save_id_o Bool) (debug_req_i Bool)) Bool (bvule EXC_CAUSE_BREAKPOINT EXC_CAUSE_LOAD_ACCESS_FAULT))
)
(
(define-fun inv ((EXC_CAUSE_ECALL_MMODE (_ BitVec 6)) (EXC_PC_IRQ (_ BitVec 2)) (PC_BOOT (_ BitVec 3)) (WAIT_SLEEP (_ BitVec 4)) (nmi_mode_q Bool)) Bool (bvule EXC_PC_IRQ (bvneg EXC_PC_IRQ)))
)
(
(define-fun inv ((DBG_TAKEN_IF (_ BitVec 4)) (PRIV_LVL_U (_ BitVec 2)) (csr_meip_i Bool) (debug_mode_o Bool) (stall_multdiv_i Bool)) Bool (= PRIV_LVL_U (bvneg PRIV_LVL_U)))
)
(
(define-fun inv ((DECODE (_ BitVec 4)) (PC_ERET (_ BitVec 3)) (debug_csr_save_o Bool) (debug_mode_q Bool) (ecall_insn Bool)) Bool (bvule PC_ERET (bvneg PC_ERET)))
)
(
(define-fun inv ((DECODE (_ BitVec 4)) (csr_save_cause_o Bool) (flush_id Bool) (instr_valid_i Bool) (load_err_i Bool)) Bool (bvule DECODE (bvmul DECODE DECODE)))
)
(
(define-fun inv ((DBG_CAUSE_HALTREQ (_ BitVec 3)) (EXC_PC_EXC (_ BitVec 2)) (csr_restore_dret_id_o Bool) (debug_mode_o Bool) (ecall_insn Bool)) Bool (= EXC_PC_EXC (bvneg EXC_PC_EXC)))
)
(
(define-fun inv ((ebrk_insn_i Bool) (illegal_dret Bool) (instr_fetch_err Bool) (nmi_mode_q Bool) (special_req Bool)) Bool (= illegal_dret (and illegal_dret special_req)))
)
(
(define-fun inv ((EXC_PC_IRQ (_ BitVec 2)) (debug_mode_q Bool) (ebrk_insn Bool) (ecall_insn_i Bool) (handle_irq Bool)) Bool (not (and debug_mode_q handle_irq)))
)
(
(define-fun inv ((DBG_CAUSE_STEP (_ BitVec 3)) (PC_DRET (_ BitVec 3)) (illegal_insn_q Bool) (nmi_mode_d Bool)) Bool (= DBG_CAUSE_STEP (bvneg DBG_CAUSE_STEP)))
)
(
(define-fun inv ((csr_meip_i Bool) (instr_i (_ BitVec 32)) (pc_mux_o (_ BitVec 3)) (pc_set_o Bool) (stall Bool)) Bool (bvule pc_mux_o (bvneg pc_mux_o)))
)
(
(define-fun inv ((DBG_CAUSE_STEP (_ BitVec 3)) (EXC_CAUSE_INSN_ADDR_MISA (_ BitVec 6)) (EXC_CAUSE_IRQ_EXTERNAL_M (_ BitVec 6)) (PRIV_LVL_U (_ BitVec 2)) (ecall_insn Bool)) Bool (bvule EXC_CAUSE_INSN_ADDR_MISA EXC_CAUSE_IRQ_EXTERNAL_M))
)
(
(define-fun inv ((DBG_CAUSE_STEP (_ BitVec 3)) (PC_BOOT (_ BitVec 3)) (PRIV_LVL_U (_ BitVec 2)) (exc_pc_mux_o (_ BitVec 2))) Bool (bvule PRIV_LVL_U exc_pc_mux_o))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_EXTERNAL_M (_ BitVec 6)) (PC_EXC (_ BitVec 3)) (csr_pipe_flush_i Bool) (debug_single_step_i Bool) (store_err_d Bool)) Bool (bvule PC_EXC (bvneg PC_EXC)))
)
(
(define-fun inv ((PC_JUMP (_ BitVec 3)) (csr_pipe_flush_i Bool) (csr_restore_mret_id_o Bool) (ctrl_fsm_ns (_ BitVec 4))) Bool (= PC_JUMP (bvmul PC_JUMP PC_JUMP)))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_NM (_ BitVec 6)) (debug_cause_o (_ BitVec 3)) (debug_ebreakm_i Bool) (ebrk_insn_i Bool) (id_in_ready_o Bool)) Bool (bvule debug_cause_o (bvneg debug_cause_o)))
)
(
(define-fun inv ((EXC_PC_EXC (_ BitVec 2)) (PC_JUMP (_ BitVec 3)) (clk_i Bool) (debug_req_i Bool) (exc_req_q Bool)) Bool (= EXC_PC_EXC (bvneg EXC_PC_EXC)))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_SOFTWARE_M (_ BitVec 6)) (IRQ_TAKEN (_ BitVec 4)) (exc_req_lsu Bool) (fetch_enable_i Bool) (pc_id_i (_ BitVec 32))) Bool (bvule IRQ_TAKEN (bvneg IRQ_TAKEN)))
)
(
(define-fun inv ((EXC_CAUSE_STORE_ACCESS_FAULT (_ BitVec 6)) (debug_ebreaku_i Bool) (enter_debug_mode Bool) (exc_cause_o (_ BitVec 6)) (special_req Bool)) Bool (bvule EXC_CAUSE_STORE_ACCESS_FAULT (bvmul EXC_CAUSE_STORE_ACCESS_FAULT EXC_CAUSE_STORE_ACCESS_FAULT)))
)
(
(define-fun inv ((BOOT_SET (_ BitVec 4)) (EXC_PC_DBD (_ BitVec 2)) (csr_mfip_i (_ BitVec 15)) (csr_mtip_i Bool) (debug_mode_o Bool)) Bool (= EXC_PC_DBD (bvneg EXC_PC_DBD)))
)
(
(define-fun inv ((PC_EXC (_ BitVec 3)) (csr_save_cause_o Bool) (debug_ebreaku_i Bool) (ebreak_into_debug Bool) (nmi_mode_q Bool)) Bool (bvule PC_EXC (bvmul PC_EXC PC_EXC)))
)
(
(define-fun inv ((EXC_CAUSE_ECALL_MMODE (_ BitVec 6)) (exc_pc_mux_o (_ BitVec 2)) (mfip_id (_ BitVec 4)) (rst_ni Bool) (stall_lsu_i Bool)) Bool (bvule EXC_CAUSE_ECALL_MMODE (bvmul EXC_CAUSE_ECALL_MMODE EXC_CAUSE_ECALL_MMODE)))
)
(
(define-fun inv ((enter_debug_mode Bool) (illegal_insn_q Bool) (perf_jump_o Bool) (stall_lsu_i Bool) (store_err_d Bool)) Bool (not (and perf_jump_o store_err_d)))
)
(
(define-fun inv ((debug_csr_save_o Bool) (irq_nm_i Bool) (mret_insn_i Bool) (perf_tbranch_o Bool) (rst_ni Bool)) Bool (not (and mret_insn_i perf_tbranch_o)))
)
(
(define-fun inv ((EXC_CAUSE_ECALL_MMODE (_ BitVec 6)) (EXC_CAUSE_IRQ_TIMER_M (_ BitVec 6)) (ebrk_insn Bool) (load_err_q Bool)) Bool (bvule EXC_CAUSE_ECALL_MMODE (bvneg EXC_CAUSE_IRQ_TIMER_M)))
)
(
(define-fun inv ((EXC_CAUSE_STORE_ACCESS_FAULT (_ BitVec 6)) (clk_i Bool) (debug_csr_save_o Bool) (ebrk_insn Bool)) Bool (bvule EXC_CAUSE_STORE_ACCESS_FAULT (bvmul EXC_CAUSE_STORE_ACCESS_FAULT EXC_CAUSE_STORE_ACCESS_FAULT)))
)
(
(define-fun inv ((EXC_CAUSE_ILLEGAL_INSN (_ BitVec 6)) (EXC_PC_DBG_EXC (_ BitVec 2)) (perf_jump_o Bool) (unused_csr_mtip Bool) (wfi_insn_i Bool)) Bool (bvule EXC_CAUSE_ILLEGAL_INSN (bvmul EXC_CAUSE_ILLEGAL_INSN EXC_CAUSE_ILLEGAL_INSN)))
)
(
(define-fun inv ((DBG_TAKEN_IF (_ BitVec 4)) (EXC_CAUSE_ILLEGAL_INSN (_ BitVec 6)) (csr_mtip_i Bool) (debug_ebreakm_i Bool) (ebrk_insn Bool)) Bool (= DBG_TAKEN_IF (bvneg DBG_TAKEN_IF)))
)
(
(define-fun inv ((DECODE (_ BitVec 4)) (FIRST_FETCH (_ BitVec 4)) (debug_single_step_i Bool) (handle_irq Bool) (pc_mux_o (_ BitVec 3))) Bool (bvule FIRST_FETCH DECODE))
)
(
(define-fun inv ((PC_BOOT (_ BitVec 3)) (csr_msip_i Bool) (handle_irq Bool) (illegal_dret Bool) (illegal_insn_d Bool)) Bool (= PC_BOOT (bvneg PC_BOOT)))
)
(
(define-fun inv ((BOOT_SET (_ BitVec 4)) (PC_EXC (_ BitVec 3)) (lsu_addr_last_i (_ BitVec 32)) (mret_insn Bool) (stall_branch_i Bool)) Bool (bvule PC_EXC (bvneg PC_EXC)))
)
(
(define-fun inv ((EXC_PC_IRQ (_ BitVec 2)) (debug_single_step_i Bool) (handle_irq Bool) (special_req Bool)) Bool (bvule EXC_PC_IRQ (bvneg EXC_PC_IRQ)))
)
(
(define-fun inv ((EXC_CAUSE_BREAKPOINT (_ BitVec 6)) (PRIV_LVL_M (_ BitVec 2)) (debug_mode_o Bool) (perf_jump_o Bool) (store_err_q Bool)) Bool (bvule EXC_CAUSE_BREAKPOINT (bvmul EXC_CAUSE_BREAKPOINT EXC_CAUSE_BREAKPOINT)))
)
(
(define-fun inv ((PC_EXC (_ BitVec 3)) (PC_JUMP (_ BitVec 3)) (csr_meip_i Bool) (debug_csr_save_o Bool) (stall_branch_i Bool)) Bool (bvult PC_JUMP PC_EXC))
)
(
(define-fun inv ((csr_pipe_flush Bool) (ecall_insn_i Bool) (pc_set_o Bool) (perf_tbranch_o Bool) (stall_lsu_i Bool)) Bool (not (and ecall_insn_i perf_tbranch_o)))
)
(
(define-fun inv ((EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (SLEEP (_ BitVec 4)) (csr_restore_dret_id_o Bool) (ecall_insn Bool) (mret_insn_i Bool)) Bool (bvule SLEEP (bvneg SLEEP)))
)
(
(define-fun inv ((DBG_CAUSE_STEP (_ BitVec 3)) (FIRST_FETCH (_ BitVec 4)) (csr_mfip_i (_ BitVec 15)) (flush_id Bool) (mfip_id (_ BitVec 4))) Bool (= DBG_CAUSE_STEP (bvneg DBG_CAUSE_STEP)))
)
(
(define-fun inv ((WAIT_SLEEP (_ BitVec 4)) (debug_req_i Bool) (ebreak_into_debug Bool) (pc_id_i (_ BitVec 32))) Bool (bvule WAIT_SLEEP (bvmul WAIT_SLEEP WAIT_SLEEP)))
)
(
(define-fun inv ((EXC_CAUSE_ECALL_UMODE (_ BitVec 6)) (PRIV_LVL_U (_ BitVec 2)) (illegal_dret Bool) (unused_csr_mtip Bool) (wfi_insn_i Bool)) Bool (= PRIV_LVL_U (bvneg PRIV_LVL_U)))
)
(
(define-fun inv ((EXC_CAUSE_INSN_ADDR_MISA (_ BitVec 6)) (debug_ebreaku_i Bool) (debug_mode_o Bool) (irq_pending_i Bool) (mret_insn Bool)) Bool (= EXC_CAUSE_INSN_ADDR_MISA (bvneg EXC_CAUSE_INSN_ADDR_MISA)))
)
(
(define-fun inv ((csr_restore_dret_id_o Bool) (handle_irq Bool) (illegal_insn_d Bool) (instr_valid_i Bool) (special_req Bool)) Bool (not (and csr_restore_dret_id_o illegal_insn_d)))
)
(
(define-fun inv ((EXC_PC_DBD (_ BitVec 2)) (csr_meip_i Bool) (ebreak_into_debug Bool) (mfip_id (_ BitVec 4)) (stall_lsu_i Bool)) Bool (= EXC_PC_DBD (bvneg EXC_PC_DBD)))
)
(
(define-fun inv ((EXC_CAUSE_ECALL_UMODE (_ BitVec 6)) (EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (debug_mode_d Bool) (halt_if Bool) (store_err_q Bool)) Bool (bvule EXC_CAUSE_LOAD_ACCESS_FAULT EXC_CAUSE_ECALL_UMODE))
)
(
(define-fun inv ((DBG_CAUSE_STEP (_ BitVec 3)) (IRQ_TAKEN (_ BitVec 4)) (perf_jump_o Bool) (special_req Bool)) Bool (= DBG_CAUSE_STEP (bvneg DBG_CAUSE_STEP)))
)
(
(define-fun inv ((EXC_CAUSE_BREAKPOINT (_ BitVec 6)) (IRQ_TAKEN (_ BitVec 4)) (csr_mstatus_mie_i Bool) (exc_req_lsu Bool) (perf_tbranch_o Bool)) Bool (bvule IRQ_TAKEN (bvneg IRQ_TAKEN)))
)
(
(define-fun inv ((EXC_CAUSE_INSN_ADDR_MISA (_ BitVec 6)) (EXC_CAUSE_IRQ_NM (_ BitVec 6)) (exc_req_d Bool) (id_in_ready_o Bool) (instr_fetch_err_i Bool)) Bool (= EXC_CAUSE_INSN_ADDR_MISA (bvneg EXC_CAUSE_INSN_ADDR_MISA)))
)
(
(define-fun inv ((WAIT_SLEEP (_ BitVec 4)) (debug_cause_o (_ BitVec 3)) (instr_i (_ BitVec 32)) (load_err_q Bool) (unused_csr_mtip Bool)) Bool (bvule debug_cause_o (bvneg debug_cause_o)))
)
(
(define-fun inv ((DBG_CAUSE_HALTREQ (_ BitVec 3)) (dret_insn Bool) (exc_cause_o (_ BitVec 6)) (stall Bool) (stall_jump_i Bool)) Bool (bvult (bvmul DBG_CAUSE_HALTREQ DBG_CAUSE_HALTREQ) DBG_CAUSE_HALTREQ))
)
(
(define-fun inv ((PC_DRET (_ BitVec 3)) (debug_mode_d Bool) (irq_nm_i Bool) (irq_pending_i Bool) (store_err_i Bool)) Bool (= PC_DRET (bvneg PC_DRET)))
)
(
(define-fun inv ((DBG_TAKEN_IF (_ BitVec 4)) (ecall_insn Bool) (exc_req_d Bool) (instr_fetch_err_i Bool) (load_err_i Bool)) Bool (= DBG_TAKEN_IF (bvneg DBG_TAKEN_IF)))
)
(
(define-fun inv ((EXC_CAUSE_STORE_ACCESS_FAULT (_ BitVec 6)) (csr_mfip_i (_ BitVec 15)) (exc_req_lsu Bool) (illegal_umode Bool) (perf_tbranch_o Bool)) Bool (bvule EXC_CAUSE_STORE_ACCESS_FAULT (bvmul EXC_CAUSE_STORE_ACCESS_FAULT EXC_CAUSE_STORE_ACCESS_FAULT)))
)
(
(define-fun inv ((branch_set_i Bool) (debug_mode_q Bool) (instr_valid_clear_o Bool) (mret_insn Bool) (pc_mux_o (_ BitVec 3))) Bool (bvule pc_mux_o (bvneg pc_mux_o)))
)
(
(define-fun inv ((EXC_CAUSE_ECALL_MMODE (_ BitVec 6)) (EXC_CAUSE_ILLEGAL_INSN (_ BitVec 6)) (FLUSH (_ BitVec 4)) (flush_id Bool) (perf_jump_o Bool)) Bool (bvule EXC_CAUSE_ILLEGAL_INSN EXC_CAUSE_ECALL_MMODE))
)
(
(define-fun inv ((WAIT_SLEEP (_ BitVec 4)) (csr_restore_dret_id_o Bool) (debug_cause_o (_ BitVec 3)) (debug_single_step_i Bool) (instr_fetch_err Bool)) Bool (bvule debug_cause_o (bvneg debug_cause_o)))
)
(
(define-fun inv ((FIRST_FETCH (_ BitVec 4)) (RESET (_ BitVec 4)) (exc_req_d Bool) (id_in_ready_o Bool) (instr_is_compressed_i Bool)) Bool (bvule RESET FIRST_FETCH))
)
(
(define-fun inv ((EXC_CAUSE_INSTR_ACCESS_FAULT (_ BitVec 6)) (FIRST_FETCH (_ BitVec 4)) (PC_ERET (_ BitVec 3)) (csr_meip_i Bool) (csr_mfip_i (_ BitVec 15))) Bool (bvult PC_ERET (bvneg PC_ERET)))
)
(
(define-fun inv ((EXC_PC_DBD (_ BitVec 2)) (PC_EXC (_ BitVec 3)) (exc_req_d Bool) (illegal_insn_i Bool) (stall_jump_i Bool)) Bool (= EXC_PC_DBD (bvneg EXC_PC_DBD)))
)
(
(define-fun inv ((RESET (_ BitVec 4)) (csr_mtip_i Bool) (csr_save_id_o Bool) (instr_is_compressed_i Bool) (mret_insn_i Bool)) Bool (= RESET (bvneg RESET)))
)
(
(define-fun inv ((DECODE (_ BitVec 4)) (debug_cause_o (_ BitVec 3)) (debug_ebreaku_i Bool) (id_in_ready_o Bool) (stall_lsu_i Bool)) Bool (bvule debug_cause_o (bvneg debug_cause_o)))
)
(
(define-fun inv ((PC_DRET (_ BitVec 3)) (ebreak_into_debug Bool) (instr_req_o Bool) (instr_valid_clear_o Bool) (irq_nm_i Bool)) Bool (= PC_DRET (bvneg PC_DRET)))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_TIMER_M (_ BitVec 6)) (PC_EXC (_ BitVec 3)) (exc_req_q Bool) (mfip_id (_ BitVec 4)) (stall_branch_i Bool)) Bool (bvule PC_EXC (bvneg PC_EXC)))
)
(
(define-fun inv ((EXC_CAUSE_ECALL_UMODE (_ BitVec 6)) (EXC_CAUSE_INSN_ADDR_MISA (_ BitVec 6)) (WAIT_SLEEP (_ BitVec 4)) (exc_req_q Bool) (unused_csr_mtip Bool)) Bool (bvule EXC_CAUSE_INSN_ADDR_MISA EXC_CAUSE_ECALL_UMODE))
)
(
(define-fun inv ((FLUSH (_ BitVec 4)) (PC_EXC (_ BitVec 3)) (SLEEP (_ BitVec 4)) (debug_mode_d Bool) (jump_set_i Bool)) Bool (bvule SLEEP FLUSH))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_SOFTWARE_M (_ BitVec 6)) (IRQ_TAKEN (_ BitVec 4)) (instr_fetch_err_i Bool) (instr_req_o Bool) (load_err_i Bool)) Bool (bvule IRQ_TAKEN (bvneg IRQ_TAKEN)))
)
(
(define-fun inv ((FIRST_FETCH (_ BitVec 4)) (debug_csr_save_o Bool) (instr_is_compressed_i Bool) (load_err_i Bool)) Bool (bvule FIRST_FETCH (bvneg (bvadd FIRST_FETCH FIRST_FETCH))))
)
(
(define-fun inv ((DBG_CAUSE_HALTREQ (_ BitVec 3)) (PC_EXC (_ BitVec 3)) (debug_single_step_i Bool) (ebrk_insn Bool) (illegal_insn_q Bool)) Bool (bvult PC_EXC DBG_CAUSE_HALTREQ))
)
(
(define-fun inv ((PC_ERET (_ BitVec 3)) (RESET (_ BitVec 4)) (branch_set_i Bool) (csr_mtip_i Bool) (debug_single_step_i Bool)) Bool (= RESET (bvneg RESET)))
)
(
(define-fun inv ((EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (PRIV_LVL_U (_ BitVec 2)) (csr_save_if_o Bool) (ctrl_busy_o Bool) (ctrl_fsm_ns (_ BitVec 4))) Bool (= PRIV_LVL_U (bvneg PRIV_LVL_U)))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_TIMER_M (_ BitVec 6)) (PC_EXC (_ BitVec 3)) (PRIV_LVL_U (_ BitVec 2)) (nmi_mode_d Bool) (stall_multdiv_i Bool)) Bool (bvule PC_EXC (bvneg PC_EXC)))
)
(
(define-fun inv ((DECODE (_ BitVec 4)) (EXC_CAUSE_BREAKPOINT (_ BitVec 6)) (FIRST_FETCH (_ BitVec 4)) (ctrl_fsm_ns (_ BitVec 4)) (debug_ebreaku_i Bool)) Bool (bvule DECODE (bvneg FIRST_FETCH)))
)
(
(define-fun inv ((DBG_CAUSE_STEP (_ BitVec 3)) (DECODE (_ BitVec 4)) (RESET (_ BitVec 4)) (debug_mode_d Bool) (instr_fetch_err_i Bool)) Bool (bvule RESET DECODE))
)
(
(define-fun inv ((FIRST_FETCH (_ BitVec 4)) (PRIV_LVL_M (_ BitVec 2)) (csr_restore_dret_id_o Bool) (ecall_insn Bool) (special_req Bool)) Bool (= csr_restore_dret_id_o (and csr_restore_dret_id_o special_req)))
)
(
(define-fun inv ((PC_DRET (_ BitVec 3)) (instr_i (_ BitVec 32)) (priv_mode_i (_ BitVec 2)) (rst_ni Bool) (wfi_insn_i Bool)) Bool (= PC_DRET (bvneg PC_DRET)))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_SOFTWARE_M (_ BitVec 6)) (PC_DRET (_ BitVec 3)) (load_err_q Bool) (pc_id_i (_ BitVec 32)) (store_err_d Bool)) Bool (= PC_DRET (bvneg PC_DRET)))
)
(
(define-fun inv ((EXC_CAUSE_BREAKPOINT (_ BitVec 6)) (EXC_CAUSE_INSN_ADDR_MISA (_ BitVec 6)) (debug_cause_o (_ BitVec 3)) (exc_req_q Bool) (stall Bool)) Bool (bvule EXC_CAUSE_INSN_ADDR_MISA EXC_CAUSE_BREAKPOINT))
)
(
(define-fun inv ((EXC_CAUSE_STORE_ACCESS_FAULT (_ BitVec 6)) (EXC_PC_DBG_EXC (_ BitVec 2)) (handle_irq Bool) (perf_tbranch_o Bool)) Bool (bvule EXC_CAUSE_STORE_ACCESS_FAULT (bvmul EXC_CAUSE_STORE_ACCESS_FAULT EXC_CAUSE_STORE_ACCESS_FAULT)))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_TIMER_M (_ BitVec 6)) (PRIV_LVL_U (_ BitVec 2)) (branch_set_i Bool) (ecall_insn Bool) (id_in_ready_o Bool)) Bool (= PRIV_LVL_U (bvneg PRIV_LVL_U)))
)
(
(define-fun inv ((PC_ERET (_ BitVec 3)) (csr_mfip_i (_ BitVec 15)) (exc_req_d Bool) (pc_set_o Bool) (special_req Bool)) Bool (= exc_req_d (and exc_req_d special_req)))
)
(
(define-fun inv ((PC_EXC (_ BitVec 3)) (ctrl_fsm_ns (_ BitVec 4)) (debug_ebreakm_i Bool) (pc_mux_o (_ BitVec 3)) (rst_ni Bool)) Bool (bvule PC_EXC (bvmul PC_EXC PC_EXC)))
)
(
(define-fun inv ((EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (EXC_PC_EXC (_ BitVec 2)) (FIRST_FETCH (_ BitVec 4)) (csr_meip_i Bool) (stall_multdiv_i Bool)) Bool (= EXC_PC_EXC (bvneg EXC_PC_EXC)))
)
(
(define-fun inv ((IRQ_TAKEN (_ BitVec 4)) (exc_req_d Bool) (irq_nm_i Bool) (pc_mux_o (_ BitVec 3)) (special_req Bool)) Bool (bvule pc_mux_o (bvneg pc_mux_o)))
)
(
(define-fun inv ((FLUSH (_ BitVec 4)) (dret_insn Bool) (instr_valid_clear_o Bool) (pc_id_i (_ BitVec 32))) Bool (bvule FLUSH (bvneg FLUSH)))
)
(
(define-fun inv ((DECODE (_ BitVec 4)) (EXC_CAUSE_BREAKPOINT (_ BitVec 6)) (debug_csr_save_o Bool) (ebrk_insn Bool) (pc_id_i (_ BitVec 32))) Bool (bvule DECODE (bvmul DECODE DECODE)))
)
(
(define-fun inv ((PC_BOOT (_ BitVec 3)) (csr_meip_i Bool) (ctrl_fsm_cs (_ BitVec 4)) (debug_csr_save_o Bool) (store_err_i Bool)) Bool (= PC_BOOT (bvneg PC_BOOT)))
)
(
(define-fun inv ((BOOT_SET (_ BitVec 4)) (PC_DRET (_ BitVec 3)) (csr_mtval_o (_ BitVec 32)) (ebreak_into_debug Bool) (wfi_insn_i Bool)) Bool (= PC_DRET (bvneg PC_DRET)))
)
(
(define-fun inv ((DBG_CAUSE_EBREAK (_ BitVec 3)) (EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (csr_pipe_flush Bool) (load_err_q Bool)) Bool (= DBG_CAUSE_EBREAK (bvmul DBG_CAUSE_EBREAK DBG_CAUSE_EBREAK)))
)
(
(define-fun inv ((illegal_insn_i Bool) (load_err_q Bool) (mret_insn Bool) (mret_insn_i Bool) (special_req Bool)) Bool (= mret_insn (and mret_insn mret_insn_i)))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_EXTERNAL_M (_ BitVec 6)) (EXC_PC_EXC (_ BitVec 2)) (csr_meip_i Bool) (flush_id Bool) (id_in_ready_o Bool)) Bool (= EXC_PC_EXC (bvneg EXC_PC_EXC)))
)
(
(define-fun inv ((PC_ERET (_ BitVec 3)) (PC_EXC (_ BitVec 3)) (ctrl_fsm_ns (_ BitVec 4)) (illegal_umode Bool) (pc_mux_o (_ BitVec 3))) Bool (bvult PC_EXC PC_ERET))
)
(
(define-fun inv ((EXC_CAUSE_INSTR_ACCESS_FAULT (_ BitVec 6)) (EXC_PC_DBG_EXC (_ BitVec 2)) (csr_mfip_i (_ BitVec 15)) (ebrk_insn_i Bool) (perf_tbranch_o Bool)) Bool (= EXC_CAUSE_INSTR_ACCESS_FAULT (bvmul EXC_CAUSE_INSTR_ACCESS_FAULT EXC_CAUSE_INSTR_ACCESS_FAULT)))
)
(
(define-fun inv ((EXC_CAUSE_INSN_ADDR_MISA (_ BitVec 6)) (debug_cause_o (_ BitVec 3)) (enter_debug_mode Bool) (fetch_enable_i Bool) (store_err_q Bool)) Bool (bvule debug_cause_o (bvneg debug_cause_o)))
)
(
(define-fun inv ((DBG_CAUSE_EBREAK (_ BitVec 3)) (EXC_CAUSE_IRQ_NM (_ BitVec 6)) (csr_save_if_o Bool) (exc_req_q Bool) (load_err_i Bool)) Bool (= DBG_CAUSE_EBREAK (bvmul DBG_CAUSE_EBREAK DBG_CAUSE_EBREAK)))
)
(
(define-fun inv ((RESET (_ BitVec 4)) (debug_ebreakm_i Bool) (instr_fetch_err Bool) (irq_nm_i Bool) (wfi_insn_i Bool)) Bool (= RESET (bvneg RESET)))
)
(
(define-fun inv ((EXC_PC_DBD (_ BitVec 2)) (lsu_addr_last_i (_ BitVec 32)) (pc_id_i (_ BitVec 32)) (stall Bool)) Bool (= EXC_PC_DBD (bvneg EXC_PC_DBD)))
)
(
(define-fun inv ((DBG_TAKEN_ID (_ BitVec 4)) (EXC_CAUSE_ILLEGAL_INSN (_ BitVec 6)) (EXC_CAUSE_STORE_ACCESS_FAULT (_ BitVec 6)) (load_err_i Bool) (pc_set_o Bool)) Bool (bvule EXC_CAUSE_ILLEGAL_INSN EXC_CAUSE_STORE_ACCESS_FAULT))
)
(
(define-fun inv ((ebrk_insn_i Bool) (mret_insn_i Bool) (nmi_mode_q Bool) (perf_tbranch_o Bool) (store_err_q Bool)) Bool (not (and mret_insn_i perf_tbranch_o)))
)
(
(define-fun inv ((DBG_TAKEN_IF (_ BitVec 4)) (PC_EXC (_ BitVec 3)) (exc_pc_mux_o (_ BitVec 2)) (lsu_addr_last_i (_ BitVec 32)) (mret_insn_i Bool)) Bool (bvule PC_EXC (bvneg PC_EXC)))
)
(
(define-fun inv ((BOOT_SET (_ BitVec 4)) (DBG_TAKEN_ID (_ BitVec 4)) (PC_ERET (_ BitVec 3)) (handle_irq Bool)) Bool (bvult PC_ERET (bvneg PC_ERET)))
)
(
(define-fun inv ((EXC_PC_IRQ (_ BitVec 2)) (csr_mstatus_tw_i Bool) (id_in_ready_o Bool) (instr_i (_ BitVec 32)) (stall Bool)) Bool (bvult EXC_PC_IRQ (bvneg EXC_PC_IRQ)))
)
(
(define-fun inv ((EXC_PC_DBD (_ BitVec 2)) (csr_meip_i Bool) (csr_mtip_i Bool) (csr_mtval_o (_ BitVec 32)) (csr_save_cause_o Bool)) Bool (= EXC_PC_DBD (bvneg EXC_PC_DBD)))
)
(
(define-fun inv ((EXC_PC_DBD (_ BitVec 2)) (PC_EXC (_ BitVec 3)) (csr_mstatus_tw_i Bool) (csr_restore_mret_id_o Bool) (instr_compressed_i (_ BitVec 16))) Bool (= EXC_PC_DBD (bvneg EXC_PC_DBD)))
)
(
(define-fun inv ((PC_BOOT (_ BitVec 3)) (branch_set_i Bool) (debug_mode_d Bool) (dret_insn Bool) (instr_compressed_i (_ BitVec 16))) Bool (= PC_BOOT (bvneg PC_BOOT)))
)
(
(define-fun inv ((EXC_PC_DBD (_ BitVec 2)) (FIRST_FETCH (_ BitVec 4)) (exc_cause_o (_ BitVec 6)) (instr_req_o Bool) (irq_pending_i Bool)) Bool (= EXC_PC_DBD (bvneg EXC_PC_DBD)))
)
(
(define-fun inv ((EXC_CAUSE_ILLEGAL_INSN (_ BitVec 6)) (EXC_PC_EXC (_ BitVec 2)) (PC_BOOT (_ BitVec 3)) (csr_mtip_i Bool) (illegal_insn_q Bool)) Bool (= EXC_PC_EXC (bvneg EXC_PC_EXC)))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_TIMER_M (_ BitVec 6)) (FLUSH (_ BitVec 4)) (illegal_dret Bool) (illegal_insn_d Bool) (irq_pending_i Bool)) Bool (bvule FLUSH (bvneg FLUSH)))
)
(
(define-fun inv ((EXC_PC_EXC (_ BitVec 2)) (PRIV_LVL_U (_ BitVec 2)) (flush_id Bool) (illegal_dret Bool) (instr_valid_i Bool)) Bool (= EXC_PC_EXC PRIV_LVL_U))
)
(
(define-fun inv ((RESET (_ BitVec 4)) (flush_id Bool) (instr_compressed_i (_ BitVec 16)) (load_err_d Bool)) Bool (= RESET (bvneg RESET)))
)
(
(define-fun inv ((EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (EXC_PC_EXC (_ BitVec 2)) (PRIV_LVL_U (_ BitVec 2)) (stall_multdiv_i Bool) (store_err_q Bool)) Bool (= EXC_PC_EXC PRIV_LVL_U))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_TIMER_M (_ BitVec 6)) (PC_JUMP (_ BitVec 3)) (debug_csr_save_o Bool) (debug_req_i Bool) (illegal_insn_i Bool)) Bool (bvule PC_JUMP (bvneg PC_JUMP)))
)
(
(define-fun inv ((EXC_CAUSE_ECALL_MMODE (_ BitVec 6)) (EXC_CAUSE_IRQ_SOFTWARE_M (_ BitVec 6)) (EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (debug_ebreakm_i Bool) (illegal_dret Bool)) Bool (bvule EXC_CAUSE_ECALL_MMODE (bvneg EXC_CAUSE_IRQ_SOFTWARE_M)))
)
(
(define-fun inv ((DBG_CAUSE_EBREAK (_ BitVec 3)) (DBG_TAKEN_IF (_ BitVec 4)) (EXC_CAUSE_STORE_ACCESS_FAULT (_ BitVec 6)) (debug_cause_o (_ BitVec 3)) (debug_ebreakm_i Bool)) Bool (bvule DBG_CAUSE_EBREAK debug_cause_o))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_EXTERNAL_M (_ BitVec 6)) (EXC_CAUSE_IRQ_SOFTWARE_M (_ BitVec 6)) (IRQ_TAKEN (_ BitVec 4)) (lsu_addr_last_i (_ BitVec 32)) (stall_jump_i Bool)) Bool (bvule EXC_CAUSE_IRQ_SOFTWARE_M EXC_CAUSE_IRQ_EXTERNAL_M))
)
(
(define-fun inv ((csr_save_cause_o Bool) (debug_cause_o (_ BitVec 3)) (ecall_insn_i Bool) (nmi_mode_d Bool) (priv_mode_i (_ BitVec 2))) Bool (bvule debug_cause_o (bvneg debug_cause_o)))
)
(
(define-fun inv ((csr_pipe_flush Bool) (csr_restore_mret_id_o Bool) (ctrl_fsm_cs (_ BitVec 4)) (illegal_insn_q Bool) (store_err_q Bool)) Bool (not (and csr_restore_mret_id_o store_err_q)))
)
(
(define-fun inv ((PC_DRET (_ BitVec 3)) (csr_restore_dret_id_o Bool) (csr_restore_mret_id_o Bool) (debug_req_i Bool) (illegal_insn_i Bool)) Bool (= PC_DRET (bvneg PC_DRET)))
)
(
(define-fun inv ((DBG_CAUSE_STEP (_ BitVec 3)) (EXC_CAUSE_INSTR_ACCESS_FAULT (_ BitVec 6)) (FIRST_FETCH (_ BitVec 4)) (csr_mstatus_mie_i Bool) (debug_mode_d Bool)) Bool (= DBG_CAUSE_STEP (bvneg DBG_CAUSE_STEP)))
)
(
(define-fun inv ((WAIT_SLEEP (_ BitVec 4)) (csr_pipe_flush Bool) (ecall_insn_i Bool) (nmi_mode_q Bool) (priv_mode_i (_ BitVec 2))) Bool (bvule WAIT_SLEEP (bvmul WAIT_SLEEP WAIT_SLEEP)))
)
(
(define-fun inv ((flush_id Bool) (instr_valid_clear_o Bool) (load_err_q Bool) (perf_jump_o Bool) (rst_ni Bool)) Bool (= flush_id (and flush_id instr_valid_clear_o)))
)
(
(define-fun inv ((EXC_PC_DBD (_ BitVec 2)) (IRQ_TAKEN (_ BitVec 4)) (debug_req_i Bool) (perf_tbranch_o Bool) (stall_branch_i Bool)) Bool (= EXC_PC_DBD (bvneg EXC_PC_DBD)))
)
(
(define-fun inv ((RESET (_ BitVec 4)) (csr_restore_dret_id_o Bool) (debug_mode_q Bool) (mfip_id (_ BitVec 4)) (stall_multdiv_i Bool)) Bool (= RESET (bvneg RESET)))
)
(
(define-fun inv ((DBG_CAUSE_EBREAK (_ BitVec 3)) (csr_mfip_i (_ BitVec 15)) (ecall_insn_i Bool) (illegal_insn_q Bool) (nmi_mode_q Bool)) Bool (= DBG_CAUSE_EBREAK (bvmul DBG_CAUSE_EBREAK DBG_CAUSE_EBREAK)))
)
(
(define-fun inv ((BOOT_SET (_ BitVec 4)) (EXC_CAUSE_IRQ_SOFTWARE_M (_ BitVec 6)) (csr_mstatus_mie_i Bool) (irq_nm_i Bool) (jump_set_i Bool)) Bool (= BOOT_SET (bvmul BOOT_SET BOOT_SET)))
)
(
(define-fun inv ((EXC_CAUSE_INSTR_ACCESS_FAULT (_ BitVec 6)) (EXC_CAUSE_IRQ_NM (_ BitVec 6)) (EXC_CAUSE_IRQ_SOFTWARE_M (_ BitVec 6)) (store_err_d Bool)) Bool (bvule EXC_CAUSE_INSTR_ACCESS_FAULT EXC_CAUSE_IRQ_SOFTWARE_M))
)
(
(define-fun inv ((EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (PC_JUMP (_ BitVec 3)) (debug_mode_d Bool) (debug_req_i Bool) (lsu_addr_last_i (_ BitVec 32))) Bool (bvule PC_JUMP (bvneg PC_JUMP)))
)
(
(define-fun inv ((EXC_CAUSE_STORE_ACCESS_FAULT (_ BitVec 6)) (RESET (_ BitVec 4)) (exc_req_lsu Bool) (stall Bool)) Bool (= RESET (bvneg RESET)))
)
(
(define-fun inv ((EXC_CAUSE_ILLEGAL_INSN (_ BitVec 6)) (EXC_PC_DBG_EXC (_ BitVec 2)) (dret_insn_i Bool) (nmi_mode_d Bool)) Bool (bvule EXC_CAUSE_ILLEGAL_INSN (bvmul EXC_CAUSE_ILLEGAL_INSN EXC_CAUSE_ILLEGAL_INSN)))
)
(
(define-fun inv ((FIRST_FETCH (_ BitVec 4)) (PC_BOOT (_ BitVec 3)) (csr_meip_i Bool) (ctrl_fsm_ns (_ BitVec 4)) (illegal_insn_i Bool)) Bool (= PC_BOOT (bvneg PC_BOOT)))
)
(
(define-fun inv ((EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (RESET (_ BitVec 4)) (debug_mode_q Bool) (ebreak_into_debug Bool) (instr_compressed_i (_ BitVec 16))) Bool (= RESET (bvneg RESET)))
)
(
(define-fun inv ((DBG_CAUSE_HALTREQ (_ BitVec 3)) (PC_BOOT (_ BitVec 3)) (SLEEP (_ BitVec 4)) (ebreak_into_debug Bool) (exc_req_lsu Bool)) Bool (bvult PC_BOOT DBG_CAUSE_HALTREQ))
)
(
(define-fun inv ((EXC_CAUSE_IRQ_EXTERNAL_M (_ BitVec 6)) (FIRST_FETCH (_ BitVec 4)) (debug_single_step_i Bool) (ecall_insn Bool) (nmi_mode_q Bool)) Bool (bvule FIRST_FETCH (bvneg FIRST_FETCH)))
)
(
(define-fun inv ((EXC_CAUSE_ECALL_UMODE (_ BitVec 6)) (EXC_PC_DBD (_ BitVec 2)) (branch_set_i Bool) (clk_i Bool) (instr_req_o Bool)) Bool (= EXC_PC_DBD (bvneg EXC_PC_DBD)))
)
(
(define-fun inv ((DBG_CAUSE_HALTREQ (_ BitVec 3)) (PC_ERET (_ BitVec 3)) (csr_msip_i Bool) (pc_id_i (_ BitVec 32)) (perf_tbranch_o Bool)) Bool (= DBG_CAUSE_HALTREQ PC_ERET))
)
(
(define-fun inv ((EXC_CAUSE_ILLEGAL_INSN (_ BitVec 6)) (PRIV_LVL_U (_ BitVec 2)) (fetch_enable_i Bool) (instr_is_compressed_i Bool) (pc_mux_o (_ BitVec 3))) Bool (= PRIV_LVL_U (bvneg PRIV_LVL_U)))
)
(
(define-fun inv ((FLUSH (_ BitVec 4)) (ebreak_into_debug Bool) (illegal_umode Bool) (instr_fetch_err_i Bool) (irq_nm_i Bool)) Bool (bvult FLUSH (bvneg FLUSH)))
)
(
(define-fun inv ((DECODE (_ BitVec 4)) (csr_mtval_o (_ BitVec 32)) (debug_req_i Bool) (illegal_insn_d Bool) (mret_insn Bool)) Bool (bvule DECODE (bvmul DECODE DECODE)))
)
(
(define-fun inv ((EXC_CAUSE_ILLEGAL_INSN (_ BitVec 6)) (PC_BOOT (_ BitVec 3)) (ctrl_busy_o Bool) (debug_req_i Bool) (instr_fetch_err_i Bool)) Bool (= PC_BOOT (bvneg PC_BOOT)))
)
(
(define-fun inv ((EXC_CAUSE_ECALL_UMODE (_ BitVec 6)) (PC_DRET (_ BitVec 3)) (csr_mfip_i (_ BitVec 15)) (ebrk_insn Bool) (irq_nm_i Bool)) Bool (= PC_DRET (bvneg PC_DRET)))
)
(
(define-fun inv ((csr_save_id_o Bool) (debug_cause_o (_ BitVec 3)) (instr_compressed_i (_ BitVec 16)) (stall Bool) (stall_lsu_i Bool)) Bool (bvule debug_cause_o (bvneg debug_cause_o)))
)
(
(define-fun inv ((csr_mfip_i (_ BitVec 15)) (enter_debug_mode Bool) (exc_req_q Bool) (instr_req_o Bool) (perf_jump_o Bool)) Bool (or instr_req_o (not perf_jump_o)))
)
(
(define-fun inv ((EXC_CAUSE_BREAKPOINT (_ BitVec 6)) (PC_EXC (_ BitVec 3)) (dret_insn_i Bool) (illegal_dret Bool) (load_err_q Bool)) Bool (bvule PC_EXC (bvneg PC_EXC)))
)
(
(define-fun inv ((PC_EXC (_ BitVec 3)) (illegal_umode Bool) (irq_pending_i Bool) (pc_set_o Bool)) Bool (bvule PC_EXC (bvmul PC_EXC PC_EXC)))
)
(
(define-fun inv ((EXC_CAUSE_INSN_ADDR_MISA (_ BitVec 6)) (EXC_PC_DBG_EXC (_ BitVec 2)) (PRIV_LVL_M (_ BitVec 2)) (instr_valid_i Bool) (stall Bool)) Bool (= EXC_PC_DBG_EXC PRIV_LVL_M))
)
(
(define-fun inv ((EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (ecall_insn_i Bool) (illegal_dret Bool) (instr_compressed_i (_ BitVec 16)) (load_err_q Bool)) Bool (bvule EXC_CAUSE_LOAD_ACCESS_FAULT (bvmul EXC_CAUSE_LOAD_ACCESS_FAULT EXC_CAUSE_LOAD_ACCESS_FAULT)))
)
(
(define-fun inv ((DECODE (_ BitVec 4)) (csr_restore_mret_id_o Bool) (debug_csr_save_o Bool) (debug_ebreakm_i Bool) (fetch_enable_i Bool)) Bool (bvule DECODE (bvmul DECODE DECODE)))
)
(
(define-fun inv ((csr_save_if_o Bool) (ctrl_busy_o Bool) (ebreak_into_debug Bool) (illegal_insn_q Bool)) Bool (= csr_save_if_o (and csr_save_if_o ctrl_busy_o)))
)
(
(define-fun inv ((BOOT_SET (_ BitVec 4)) (EXC_CAUSE_INSN_ADDR_MISA (_ BitVec 6)) (csr_restore_dret_id_o Bool) (dret_insn Bool) (pc_set_o Bool)) Bool (= BOOT_SET (bvmul BOOT_SET BOOT_SET)))
)
(
(define-fun inv ((EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (csr_save_cause_o Bool) (illegal_dret Bool) (instr_is_compressed_i Bool) (pc_mux_o (_ BitVec 3))) Bool (bvule EXC_CAUSE_LOAD_ACCESS_FAULT (bvmul EXC_CAUSE_LOAD_ACCESS_FAULT EXC_CAUSE_LOAD_ACCESS_FAULT)))
)
(
(define-fun inv ((PRIV_LVL_U (_ BitVec 2)) (csr_restore_mret_id_o Bool) (exc_req_d Bool) (id_in_ready_o Bool) (lsu_addr_last_i (_ BitVec 32))) Bool (= PRIV_LVL_U (bvneg PRIV_LVL_U)))
)
(
(define-fun inv ((EXC_CAUSE_ECALL_UMODE (_ BitVec 6)) (PC_DRET (_ BitVec 3)) (csr_mtval_o (_ BitVec 32)) (ebreak_into_debug Bool) (pc_set_o Bool)) Bool (= PC_DRET (bvneg PC_DRET)))
)
(
(define-fun inv ((EXC_PC_EXC (_ BitVec 2)) (FIRST_FETCH (_ BitVec 4)) (csr_mstatus_tw_i Bool) (enter_debug_mode Bool) (illegal_insn_d Bool)) Bool (= EXC_PC_EXC (bvneg EXC_PC_EXC)))
)
(
(define-fun inv ((DECODE (_ BitVec 4)) (EXC_CAUSE_INSN_ADDR_MISA (_ BitVec 6)) (EXC_CAUSE_STORE_ACCESS_FAULT (_ BitVec 6)) (debug_mode_q Bool) (stall_multdiv_i Bool)) Bool (bvule EXC_CAUSE_INSN_ADDR_MISA EXC_CAUSE_STORE_ACCESS_FAULT))
)
(
(define-fun inv ((DBG_CAUSE_EBREAK (_ BitVec 3)) (PC_DRET (_ BitVec 3)) (branch_set_i Bool) (debug_mode_q Bool) (load_err_q Bool)) Bool (bvult DBG_CAUSE_EBREAK PC_DRET))
)
(
(define-fun inv ((csr_restore_mret_id_o Bool) (irq_pending_i Bool) (mret_insn_i Bool) (special_req Bool) (unused_csr_mtip Bool)) Bool (= csr_restore_mret_id_o (and csr_restore_mret_id_o special_req)))
)
(
(define-fun inv ((branch_set_i Bool) (csr_save_cause_o Bool) (debug_csr_save_o Bool) (debug_mode_d Bool) (flush_id Bool)) Bool (= debug_csr_save_o (and debug_csr_save_o debug_mode_d)))
)
(
(define-fun inv ((DBG_TAKEN_IF (_ BitVec 4)) (irq_nm_i Bool) (jump_set_i Bool) (nmi_mode_d Bool) (store_err_d Bool)) Bool (= DBG_TAKEN_IF (bvneg DBG_TAKEN_IF)))
)
(
(define-fun inv ((EXC_PC_DBD (_ BitVec 2)) (debug_mode_o Bool) (ecall_insn Bool) (perf_jump_o Bool) (store_err_q Bool)) Bool (= EXC_PC_DBD (bvneg EXC_PC_DBD)))
)
(
(define-fun inv ((DECODE (_ BitVec 4)) (EXC_PC_EXC (_ BitVec 2)) (PRIV_LVL_U (_ BitVec 2)) (load_err_d Bool) (pc_id_i (_ BitVec 32))) Bool (= EXC_PC_EXC (bvneg EXC_PC_EXC)))
)
(
(define-fun inv ((EXC_CAUSE_INSTR_ACCESS_FAULT (_ BitVec 6)) (SLEEP (_ BitVec 4)) (csr_pipe_flush Bool) (dret_insn_i Bool) (stall_branch_i Bool)) Bool (bvule SLEEP (bvneg SLEEP)))
)
(
(define-fun inv ((EXC_CAUSE_BREAKPOINT (_ BitVec 6)) (debug_cause_o (_ BitVec 3)) (ebrk_insn_i Bool) (pc_set_o Bool) (store_err_q Bool)) Bool (bvule debug_cause_o (bvneg debug_cause_o)))
)
(
(define-fun inv ((csr_mtip_i Bool) (mfip_id (_ BitVec 4)) (unused_csr_mtip Bool)) Bool (= csr_mtip_i unused_csr_mtip))
)
(
(define-fun inv ((BOOT_SET (_ BitVec 4)) (DBG_CAUSE_EBREAK (_ BitVec 3)) (DBG_CAUSE_HALTREQ (_ BitVec 3)) (DBG_CAUSE_STEP (_ BitVec 3)) (DBG_TAKEN_ID (_ BitVec 4)) (DBG_TAKEN_IF (_ BitVec 4)) (DECODE (_ BitVec 4)) (EXC_CAUSE_BREAKPOINT (_ BitVec 6)) (EXC_CAUSE_ECALL_MMODE (_ BitVec 6)) (EXC_CAUSE_ECALL_UMODE (_ BitVec 6)) (EXC_CAUSE_ILLEGAL_INSN (_ BitVec 6)) (EXC_CAUSE_INSN_ADDR_MISA (_ BitVec 6)) (EXC_CAUSE_INSTR_ACCESS_FAULT (_ BitVec 6)) (EXC_CAUSE_IRQ_EXTERNAL_M (_ BitVec 6)) (EXC_CAUSE_IRQ_NM (_ BitVec 6)) (EXC_CAUSE_IRQ_SOFTWARE_M (_ BitVec 6)) (EXC_CAUSE_IRQ_TIMER_M (_ BitVec 6)) (EXC_CAUSE_LOAD_ACCESS_FAULT (_ BitVec 6)) (EXC_CAUSE_STORE_ACCESS_FAULT (_ BitVec 6)) (EXC_PC_DBD (_ BitVec 2)) (EXC_PC_DBG_EXC (_ BitVec 2)) (EXC_PC_EXC (_ BitVec 2)) (EXC_PC_IRQ (_ BitVec 2)) (FIRST_FETCH (_ BitVec 4)) (FLUSH (_ BitVec 4)) (IRQ_TAKEN (_ BitVec 4)) (PC_BOOT (_ BitVec 3)) (PC_DRET (_ BitVec 3)) (PC_ERET (_ BitVec 3)) (PC_EXC (_ BitVec 3)) (PC_JUMP (_ BitVec 3)) (PRIV_LVL_M (_ BitVec 2)) (SLEEP (_ BitVec 4)) (WAIT_SLEEP (_ BitVec 4)) (branch_set_i Bool) (csr_mtval_o (_ BitVec 32)) (csr_restore_dret_id_o Bool) (csr_restore_mret_id_o Bool) (csr_save_cause_o Bool) (csr_save_id_o Bool) (csr_save_if_o Bool) (ctrl_busy_o Bool) (ctrl_fsm_cs (_ BitVec 4)) (ctrl_fsm_ns (_ BitVec 4)) (debug_cause_o (_ BitVec 3)) (debug_csr_save_o Bool) (debug_mode_d Bool) (debug_mode_o Bool) (debug_mode_q Bool) (exc_cause_o (_ BitVec 6)) (exc_pc_mux_o (_ BitVec 2)) (flush_id Bool) (halt_if Bool) (id_in_ready_o Bool) (instr_compressed_i (_ BitVec 16)) (instr_i (_ BitVec 32)) (instr_is_compressed_i Bool) (instr_req_o Bool) (instr_valid_clear_o Bool) (jump_set_i Bool) (lsu_addr_last_i (_ BitVec 32)) (mfip_id (_ BitVec 4)) (nmi_mode_d Bool) (nmi_mode_q Bool) (pc_id_i (_ BitVec 32)) (pc_mux_o (_ BitVec 3)) (pc_set_o Bool) (perf_jump_o Bool) (perf_tbranch_o Bool) (priv_mode_i (_ BitVec 2)) (stall Bool) (stall_branch_i Bool) (stall_jump_i Bool) (stall_lsu_i Bool) (stall_multdiv_i Bool)) Bool (bvule EXC_PC_DBD EXC_PC_DBG_EXC))
)
