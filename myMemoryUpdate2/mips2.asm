.data
array: .space 1024

.text

#for (int index = 0; index < arrSize/loopSize; index ++) {
#for (int repIdx=0; repIdx < repCount ; repIdx ++) {
#for (int loopIdx = 0; loopIdx < loopSize ; loopIdx += stepSize){
#array[index] = array[index] + 1; 
#}
#}
#}
#}

main:	li	$a0, 1024       # array size in BYTES (power of 2 < array size)
	li	$a1, 1		# step size 
	li	$a2, 4		# rep count
	li      $a3, 4        #loopSize = 2
	
	
	div $t4, $a0, $a3                   # arrSize/loopSize
		
	jal	accessBytes	# lb/sb
	
	li $v0, 10
	syscall
	
accessBytes:
	la	$s0, array		# ptr to array
	addu	$s1, $s0, $t4		# hardcode array limit (ptr): s1 = oopSize
	add	$t7, $t7, $zero
	
byteLoop:

	lbu	$t0, 0($s0)		# array[index]++
	addi	$t0, $t0, 1
	sb	$t0, 0($s0)
	addi	$t7, $t7, 1
	j	loopIndexCheck
	
loopIndexCheck:
	addu	$s0, $s0, $a1		
	blt	$t7, $a3, byteLoop	
	
	subi	$s0, $s0, 4
	add	$t7, $zero, $zero
	
	addi	$a2, $a2, -1 
	bgtz 	$a2, byteLoop	        # repIdx < 4
	
	addi	$a2, $a2, 4
	addi	$t4, $t4, -1
	addi	$s0,$s0,4
	bgtz	$t4, byteLoop

       jr $ra
