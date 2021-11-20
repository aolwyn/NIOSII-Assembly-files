.global _start
.org 0x0000
_start:
	
	movia r2, LIST
	movi r3, 0
	ldw r5, N(r0)
LOOP:
IF:
	ldw r4, 0(r2)
	ble r4, r0, END_IF
THEN:
	add r3, r3, r4
END_IF:
	addi r2, r2, 4
	subi r5, r5, 1
	bgt r5, r0, LOOP
	
	stw r3, SUM(r0)
_end:
	br _end
#------------------------
.org 0x1000
LIST: .word -12, 30, 20, -2, 8, -32, 10
N: .word 7
SUM: .skip 4
