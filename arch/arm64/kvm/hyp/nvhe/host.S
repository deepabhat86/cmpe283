/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Copyright (C) 2020 - Google Inc
 * Author: Andrew Scull <ascull@google.com>
 */

#include <linux/linkage.h>

#include <asm/assembler.h>
#include <asm/kvm_asm.h>
#include <asm/kvm_mmu.h>

	.text

SYM_FUNC_START(__host_exit)
	stp	x0, x1, [sp, #-16]!

	get_host_ctxt	x0, x1

	ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)

	/* Store the host regs x2 and x3 */
	stp	x2, x3,   [x0, #CPU_XREG_OFFSET(2)]

	/* Retrieve the host regs x0-x1 from the stack */
	ldp	x2, x3, [sp], #16	// x0, x1

	/* Store the host regs x0-x1 and x4-x17 */
	stp	x2, x3,   [x0, #CPU_XREG_OFFSET(0)]
	stp	x4, x5,   [x0, #CPU_XREG_OFFSET(4)]
	stp	x6, x7,   [x0, #CPU_XREG_OFFSET(6)]
	stp	x8, x9,   [x0, #CPU_XREG_OFFSET(8)]
	stp	x10, x11, [x0, #CPU_XREG_OFFSET(10)]
	stp	x12, x13, [x0, #CPU_XREG_OFFSET(12)]
	stp	x14, x15, [x0, #CPU_XREG_OFFSET(14)]
	stp	x16, x17, [x0, #CPU_XREG_OFFSET(16)]

	/* Store the host regs x18-x29, lr */
	save_callee_saved_regs x0

	/* Save the host context pointer in x29 across the function call */
	mov	x29, x0
	bl	handle_trap

	/* Restore host regs x0-x17 */
	ldp	x0, x1,   [x29, #CPU_XREG_OFFSET(0)]
	ldp	x2, x3,   [x29, #CPU_XREG_OFFSET(2)]
	ldp	x4, x5,   [x29, #CPU_XREG_OFFSET(4)]
	ldp	x6, x7,   [x29, #CPU_XREG_OFFSET(6)]

	/* x0-7 are use for panic arguments */
__host_enter_for_panic:
	ldp	x8, x9,   [x29, #CPU_XREG_OFFSET(8)]
	ldp	x10, x11, [x29, #CPU_XREG_OFFSET(10)]
	ldp	x12, x13, [x29, #CPU_XREG_OFFSET(12)]
	ldp	x14, x15, [x29, #CPU_XREG_OFFSET(14)]
	ldp	x16, x17, [x29, #CPU_XREG_OFFSET(16)]

	/* Restore host regs x18-x29, lr */
	restore_callee_saved_regs x29

	/* Do not touch any register after this! */
__host_enter_without_restoring:
	eret
	sb
SYM_FUNC_END(__host_exit)

/*
 * void __noreturn __hyp_do_panic(bool restore_host, u64 spsr, u64 elr, u64 par);
 */
SYM_FUNC_START(__hyp_do_panic)
	/* Load the format arguments into x1-7 */
	mov	x6, x3
	get_vcpu_ptr x7, x3

	mrs	x3, esr_el2
	mrs	x4, far_el2
	mrs	x5, hpfar_el2

	/* Prepare and exit to the host's panic funciton. */
	mov	lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
		      PSR_MODE_EL1h)
	msr	spsr_el2, lr
	ldr	lr, =panic
	msr	elr_el2, lr

	/*
	 * Set the panic format string and enter the host, conditionally
	 * restoring the host context.
	 */
	cmp	x0, xzr
	ldr	x0, =__hyp_panic_string
	b.eq	__host_enter_without_restoring
	b	__host_enter_for_panic
SYM_FUNC_END(__hyp_do_panic)

.macro host_el1_sync_vect
	.align 7
.L__vect_start\@:
	stp	x0, x1, [sp, #-16]!
	mrs	x0, esr_el2
	lsr	x0, x0, #ESR_ELx_EC_SHIFT
	cmp	x0, #ESR_ELx_EC_HVC64
	ldp	x0, x1, [sp], #16
	b.ne	__host_exit

	/* Check for a stub HVC call */
	cmp	x0, #HVC_STUB_HCALL_NR
	b.hs	__host_exit

	/*
	 * Compute the idmap address of __kvm_handle_stub_hvc and
	 * jump there. Since we use kimage_voffset, do not use the
	 * HYP VA for __kvm_handle_stub_hvc, but the kernel VA instead
	 * (by loading it from the constant pool).
	 *
	 * Preserve x0-x4, which may contain stub parameters.
	 */
	ldr	x5, =__kvm_handle_stub_hvc
	ldr_l	x6, kimage_voffset

	/* x5 = __pa(x5) */
	sub	x5, x5, x6
	br	x5
.L__vect_end\@:
.if ((.L__vect_end\@ - .L__vect_start\@) > 0x80)
	.error "host_el1_sync_vect larger than vector entry"
.endif
.endm

.macro invalid_host_el2_vect
	.align 7
	/* If a guest is loaded, panic out of it. */
	stp	x0, x1, [sp, #-16]!
	get_loaded_vcpu x0, x1
	cbnz	x0, __guest_exit_panic
	add	sp, sp, #16

	/*
	 * The panic may not be clean if the exception is taken before the host
	 * context has been saved by __host_exit or after the hyp context has
	 * been partially clobbered by __host_enter.
	 */
	b	hyp_panic
.endm

.macro invalid_host_el1_vect
	.align 7
	mov	x0, xzr		/* restore_host = false */
	mrs	x1, spsr_el2
	mrs	x2, elr_el2
	mrs	x3, par_el1
	b	__hyp_do_panic
.endm

/*
 * The host vector does not use an ESB instruction in order to avoid consuming
 * SErrors that should only be consumed by the host. Guest entry is deferred by
 * __guest_enter if there are any pending asynchronous exceptions so hyp will
 * always return to the host without having consumerd host SErrors.
 *
 * CONFIG_KVM_INDIRECT_VECTORS is not applied to the host vectors because the
 * host knows about the EL2 vectors already, and there is no point in hiding
 * them.
 */
	.align 11
SYM_CODE_START(__kvm_hyp_host_vector)
	invalid_host_el2_vect			// Synchronous EL2t
	invalid_host_el2_vect			// IRQ EL2t
	invalid_host_el2_vect			// FIQ EL2t
	invalid_host_el2_vect			// Error EL2t

	invalid_host_el2_vect			// Synchronous EL2h
	invalid_host_el2_vect			// IRQ EL2h
	invalid_host_el2_vect			// FIQ EL2h
	invalid_host_el2_vect			// Error EL2h

	host_el1_sync_vect			// Synchronous 64-bit EL1
	invalid_host_el1_vect			// IRQ 64-bit EL1
	invalid_host_el1_vect			// FIQ 64-bit EL1
	invalid_host_el1_vect			// Error 64-bit EL1

	invalid_host_el1_vect			// Synchronous 32-bit EL1
	invalid_host_el1_vect			// IRQ 32-bit EL1
	invalid_host_el1_vect			// FIQ 32-bit EL1
	invalid_host_el1_vect			// Error 32-bit EL1
SYM_CODE_END(__kvm_hyp_host_vector)
