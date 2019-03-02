.data

Arr: .word 1, 20, 45, 56, 55, 57
length: .word 6
msg_space: .asciiz "  "
nl: .asciiz "\n"
iterator: .word 0
x: .word 20 
y: .word 5


.text

PRINT:
## print Array
la $s0, Arr
lw $t0, length


Loop:
beq	$t0, $zero, Loop_complete
# make space
li $v0, 4
la $a0, msg_space
syscall

# printing Array elements
li $v0, 1
lw $a0, 0($s0)
syscall
	
addi $t0, $t0, -1
addi $s0, $s0, 4
	
j Loop
	
Loop_complete:
# make new line
li $v0, 4
la $a0, nl
syscall
jr $ra

Replace:

lw $t4, x
lw $t5, y

lw $t2, iterator

bgt $t2, $t1, exit_loop

sll $t3, $t2, 2
addu $t3, $t3, $s0

beq $t3, $t4, swap

j Replace

swap:
add $t3, $zero, $t5

exit_loop:

PRINT











