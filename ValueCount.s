.global _start
.org 0x0000
_start:
main:

movi sp, 0x7FFC

ldw r3, N(r0)
ldw r4, VAL(r0)
movi r5, LIST
call valuecount
stw r2, REPEATS(r0)

break
#---------------------------
valuecount:
	subi sp, sp, 8
	stw	r6, 4(sp)
	stw r7, 0(sp)
	movi r7, 0
	
LOOP:
	ldw r6, 0(r5)
	bne r6, r4, END_IF
THEN:
	addi r7, r7, 1
END_IF:
	addi r5, r5, 4
	subi r3, r3, 1
	bgt r3, r0, LOOP
	mov r2, r7
	
	ldw	r6, 4(sp)
	ldw r7, 0(sp)
	addi sp, sp, 8
	ret
#---------------------------
	.org 0x1000
N: .word 8
LIST: .word 7, 0xF, 0, 7, -13, 16, 1, 7
VAL: .word 7
REPEATS: .skip 4
	