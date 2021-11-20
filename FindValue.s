.text
.global _start
.org 0x0000
_start:

	movi r2, LIST
	ldw r3, VAL(r0)
	ldw r4, N(r0)
	call valcount
	stw r2, REPCOUNT(r0)
	
	break
#----------------------
valcount:
	subi sp, sp, 16
	stw	 r3, 12(sp)	#target value
	stw  r4, 8(sp)	#original N
	stw  r5, 4(sp)	#current list element
	stw  r6, 0(sp)
	
	movi r6, 0		#count = 0
vc_loop:
	ldw r5, 0(r2)
	bne r5, r3, vc_end_if
vc_then:
	addi r6, r6, 1
vc_end_if:
	addi r2, r2, 4
	subi r4, r4, 1
	bgt  r4, r0, vc_loop
	mov r2, r6
	
	ldw  r3, 12(sp)
	ldw  r4, 8(sp)
	ldw  r5, 4(sp)
	ldw  r6, 0(sp)
	addi sp, sp, 16
	
	ret
#----------------------
.org 0x1000
LIST: .word 1, 3, 8, 9, 7, 6, -2, 8, 8
N: .word 9
VAL: .word 8
REPCOUNT: .skip 4
.end

