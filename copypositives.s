.global _start
.org 0x0000
_start:
	
	movi sp, 0x7FFC
	
	movi r2, LIST1
	movi r3, LIST2
	ldw r4, N(r0)
	call copylistpos
	stw r2, POS(r0)
	
	break
#-------------------
copylistpos:
	subi sp, sp, 16
	stw r3, 12(sp)	#list2 ptr
	stw r4,	8(sp)	#original N
	stw r5,	4(sp)	#load element from list1
	stw r6, 0(sp) 	#counter 'k'
	
	movi r6, 0		#k = 0
cl_loop:
	ldw r5, 0(r2)			#load element from list 1 into temp
	blt r5, r0, cl_end_if	#if (r5 < 0) -> go to cl_end_if
cl_then:
	addi r6, r6, 1			#increment k by 1 (k = k + 1)
	stw r5, 0(r3)			#store positive list1 element into list 2
	addi r3, r3, 4			#increment list2 pointer to next element
cl_end_if:
	addi r2, r2, 4			#increment list1 pointer to next element
	subi r4, r4, 1			#subtract 1 from N (elements in list)
	bgt r4, r0, cl_loop		#if (r4 > 0) -> go to cl_loop
	
	mov r2, r6				#copy counter value (k) into the return register (r2)
	
	
	ldw r3, 12(sp)	#list2 ptr
	ldw r4,	8(sp)	#original N
	ldw r5,	4(sp)	#load element from list1
	ldw r6, 0(sp) 	#counter 'k'
	addi sp, sp, 16
	ret
	
#-------------------
.org 0x1000
N: .word 7
LIST1: .word 7, -1, 2, -8, 3, -9, 12
LIST2: .skip 200
POS: .skip 4

.end
	