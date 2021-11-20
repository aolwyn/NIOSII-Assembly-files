.text 
.global _start
.org 0x0000
_start:
main:

	movi r2, LIST1
	movi r3, LIST2
	ldw r4, N(r0)
	call listcopy
	
	break
#-------------------
listcopy:
	subi sp, sp, 16
	stw	r2, 12(sp)
	stw r3, 8(sp)
	stw r4, 4(sp)
	stw r5, 0(sp)
c_loop:
	ldw r5, 0(r2)
	stw r5, 0(r3)
	addi r2, r2, 4
	addi r3, r3, 4
	subi r4, r4, 1
	bgt r4, r0, c_loop
	

	ldw	r2, 12(sp)
	ldw r3, 8(sp)
	ldw r4, 4(sp)
	ldw r5, 0(sp)
	addi sp, sp, 16
	ret
#-------------------
.org 0x1000
LIST1:	.word 12, 6, 0, 9, 6, 2
LIST2:	.skip 200
N:	.word 6