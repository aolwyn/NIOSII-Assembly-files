.global _start
.org 0x0000
_start:
	
	movi sp, 0x7FFC
	movi r2, xLIST
	movi r3, yLIST
	ldw r4, N(r0)
    ldw r5, SLOPE(r0)
	ldw r6, INTERCEPT(r0)
	call line
	stw r2, NEGCOUNT(r0)
	
	break
#-------------------
line: 	
	subi sp, sp, 16
	stw r3, 20(sp)	#list2 pointer
	stw r4, 16(sp)	#original N
	stw r5, 12(sp)	#slope
	stw r6, 8(sp)	#intercept
	stw r7, 4(sp)	#use to load element from list1
	stw r8, 0(sp)	#use to increment counter for ZCOUNT
	
	movi r8, 0		#count = 0
l_loop:
	ldw r7, 0(r2)
	mul r7, r7, r5
	add r7, r7, r6
	stw r7, 0(r3)
l_if:
	bgt r7, r0, l_end_if
l_then:
	addi r8, r8, 1
l_end_if:
	addi r2, r2, 4
	addi r3, r3, 4
	subi r4, r4, 1
	bgt  r4, r0, l_loop
	
	mov r2, r8
	
	
	ldw r3, 20(sp)	#list2 pointer
	ldw r4, 16(sp)	#original N
	ldw r5, 12(sp)	#slope
	ldw r6, 8(sp)	#intercept
	ldw r7, 4(sp)	#use to load element from list1
	ldw r8, 0(sp)	#use to increment counter for ZCOUNT
	addi sp, sp, 24
	
	ret
#-------------------
.org 0x1000
N: .word 7
SLOPE: .word 1
INTERCEPT: .word -5
xLIST: .word 0, 1, 2, 8, 3, 9, 12
yLIST: .skip 200
NEGCOUNT: .skip 4

.end
	