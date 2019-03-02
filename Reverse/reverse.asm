	.data
str_old:	.space	10
str_new:	.space	10


	.text
	.globl main
main:
	li	$v0, 8			
	la	$a0, str_old	
	li	$a1, 6		
	syscall

	jal	strlen			
	
	add	$t1, $zero, $v0		
	add	$t2, $zero, $a0		
	add	$a0, $zero, $v0		

	
reverse:
	li	$t0, 0			
	li	$t3, 0		
	
	reverse_loop:
		add	$t3, $t2, $t0	
		lb	$t4, 0($t3)		
		beqz	$t4, exit              
		beq    $t4, '-', exit		
		sb	$t4, str_new($t1)
		subi	$t1, $t1, 1	
		addi	$t0, $t0, 1		
		j	reverse_loop		
	
exit:
	li	$v0, 4		
	la	$a0, str_new		
	syscall
		
	li	$v0, 10			
	syscall
	

strlen:
	li	$t0, 0
	li	$t2, 0
	
	strlen_loop:
		add	$t2, $a0, $t0
		lb	$t1, 0($t2)
		beqz	$t1,  strlen_end
		beq     $t1, '-', strlen_end
		addiu	$t0, $t0, 1
		j	strlen_loop
		
	strlen_end:
		subi	$t0, $t0, 1
		add	$v0, $zero, $t0
		add	$t0, $zero, $zero
		jr	$ra
