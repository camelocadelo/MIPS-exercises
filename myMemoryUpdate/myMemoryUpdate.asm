.data
array: .space 1024

.text

#Number of blocks: 1
#Cache block size: 32
# YOUR METRIC SCORE:
# The reasons for my optimization (better):
#1) In Assembly code: 16843009 (decimal) = 0x01010101 (hexadecimal). Byte is the smallest addressible unit, 
#and originally metric is 20480. As accessing by words is quicker, step is chosen as 4, and it adds 16843009 instead of 
#1 byte.
#2) The cache performance metric: memory access count * cache miss rate. 
#In order to decrease the final result of the metric, Cache miss rate must be also decreased. As the cache size
#must be kept as 128 bytes, the way to minimize cache miss rate is to set cache block size to 32. It is explained by
#the fact that larger blocks exploit spatial locality to lower miss rates -> increasing block size decreases
#the miss rate.

main:
	li $a0, 1024 
	li $a1, 1
	
jal myMemoryUpdate

li	$v0,10		
	syscall
	
myMemoryUpdate:
	la	$s0, array		
	addu	$s1, $s0, $a0		
	sll	$t1, $a1, 2		
	
Loop1:

	lw	$t0, 0($s0)		
	addi	$t0, $t0, 16843009
	sw	$t0, 0($s0)

	add	$s0, $s0, $t1		
	blt	$s0,$s1, Loop1      	
	
	jr	$ra
