.data
	DISPLAY: .space 16384 #65536 #0x00100 # 8*8*4, we need to reserve this space at the beginning of .data segment
	DISPLAYWIDTH: .word 64
	DISPLAYHEIGHT: .word 64
	
	BLACK: .word 0x000000
	RED: .word 0xff0000
	ORANGE: .word 0xffb62f
	YELLOW: .word 0xffff4c
	GREEN: .word 0x48fc84
	LIGHT_BLUE: .word 0x8ad6e8
	BLUE: .word 0x4876ff
	VIOLET: .word 0xbf3eff

	thirty_two: .double 32.0
	eight: .double 8.0
	zero: .double 0.0
	
	#radius: .double 15.0 #for the first semicircle only
	increment: .double 0.01
	neg_one: .double -1.0
	seventeen: .double 17.0
	fifteen: .double 15.0
	sixty_four: .double 64.0
		
.text

j main

set_pixel_color:

	lw $t0, DISPLAYWIDTH
	mul $t0, $t0, $a1 	# y*DISPLAYWIDTH
	add $t0,$t0, $a0 	# +x
	sll $t0, $t0, 2 	# *4
	la $t1, DISPLAY 	# get address of display: DISPLAY
	add $t1, $t1, $t0	# add the calculated address of the pixel
	sw $a3, ($t1) 		# write color to that pixel
	jr $ra 			# return
	
main:
	l.d $f0, zero
	l.d $f2, thirty_two  #f2 = x center (must be saved)
	l.d $f4, sixty_four  #f4 = second x limit

	l.d $f14, neg_one #f14 = neg_one	
        l.d $f28, increment
        l.d $f6, eight
        li $t6, 15  #radius = 15
        li $t5, 9
drawRainbow:

	beq $t6, 15, red 
	beq $t6, 14, orange
	beq $t6, 13, yellow
	beq $t6, 12, green
	beq $t6, 11, light_blue
	beq $t6, 10, blue
	beq $t6, 9, violet
	
loop2:	
	mul $t7, $t6, $t6
	  
	mtc1 $t6, $f10
	cvt.d.w $f10, $f10
	
	mtc1 $t7, $f12
	cvt.d.w $f12, $f12
	
	sub.d $f18, $f2, $f10 #f18 = 32 - radius (starting x) = 17
	
loop1:
	add.d $f20, $f18, $f0 #f20 = f18 = starting variable = 17
	
	sub.d, $f26, $f2, $f20  #f26 = x(c) - x

	mul.d $f26, $f26, $f26 #f26 = (x(c) - x)^2
	sub.d $f26, $f12, $f26 #$f26 = r*r - (x(c) - x)^2
	sqrt.d $f26, $f26 # f26 = sqrt(r*r - (x(c) - x)^2)

	sub.d $f26, $f2, $f26  #f26 = y(c)- (sqrt(r*r - (x(c) - x)^2))
	add.d $f22, $f26, $f0  #f22= y
	
	cvt.w.d $f20, $f20   #int x1
	mfc1 $t2, $f20
	
	cvt.w.d $f22, $f22   #int y
	mfc1 $t4, $f22
	
	add $a0, $t2, $zero   #x in argument form
	add $a1, $t4, $zero   # y in argument form
 
 
        jal set_pixel_color #color the current pixel
        
	sub.d $f24, $f4, $f20 #f24 = 2(x(c) - x = 47
	cvt.w.d $f24, $f24  #int x2
	mfc1 $t3, $f24  
	add $a0, $t3, $zero   #x2 in argument form
	
	jal set_pixel_color #color the current pixel
	
	add.d $f18, $f18, $f28	# increment x

       	c.le.d $f18, $f2
       	bc1t loop1 
	
loop3:	
	cvt.w.d $f10, $f10   
	mfc1 $t6, $f10	
	addi $t6, $t6, -1
	bge $t6, $t5, drawRainbow
	
	add $a2, $t6, $zero
	
	li $v0, 10
	syscall
	
red: 			
 	lw $a3, RED
 	j loop2
 	
orange: 
	lw $a3, ORANGE
	j loop2
	
green:
	lw $a3, GREEN
        j loop2
        
yellow:
	lw $a3, YELLOW
	j loop2
	
light_blue: 
	lw $a3, LIGHT_BLUE
	j loop2
	
blue:
	lw $a3, BLUE
	j loop2
	
violet:
	lw $a3, VIOLET
	j loop2
	
	
	
	
