.data

#deg: .double 30.0  #ENTER YOUR ANGLE HERE

message: .asciiz "Enter your angle in degrees: "

pi: .double 3.142
half_angle: .double 180.00
sum: .double 0.0
rad: .double 0.0
X: .double 0.0
one: .double 1.0
denum: .double 0.0
neg_one: .double -1.0
ten: .double 10.0
i: .double 0.0
double_zero: .double 0.0
two: .double 2.0

.text
main: 
       li $v0, 4
       la $a0, message
       syscall
       
       li $v0, 7
       syscall
       
       jal my_sin
       
       li $v0, 10
       syscall

my_sin: 
	ldc1 $f2, pi
	ldc1 $f4, half_angle 
	#ldc1 $f6, deg
	ldc1 $f8, sum
	ldc1 $f10, rad
	ldc1 $f28, X   
        ldc1 $f14, i
	ldc1 $f16, one
	ldc1 $f18, denum
	ldc1 $f20, two
	ldc1 $f26, neg_one
	ldc1 $f6, double_zero
	ldc1 $f30, ten
	    
	div.d $f0, $f0, $f4     #deg = deg/180
	mul.d $f10, $f0, $f2   #rad = deg*pi
	add.d $f28, $f6, $f10   #X = rad
	add.d $f8, $f6, $f10  #sum = rad
	
       add.d $f14, $f14, $f16 # i = 1.00
       #li $a0, 1
       #mtc1.d $a0, $f14
       #cvt.d.w $f14, $f14 # i = 1.00
	
	jal Loop
	
	jr $ra
	
Loop: 
	c.eq.d $f14, $f30
	bc1t exit_loop
	
	#li $a1, 2
	#mtc1.d $a1, $f20
	#cvt.d.w $f20, $f20 
	
	mul.d $f22, $f14, $f20   #$f22 = i*2
	
	add.d $f24, $f22, $f16   #f24 = i*2 + 1
        mul.d $f24, $f24, $f22  #f24 = (i*2+1) * (i*2)
	add.d $f18, $f6, $f24   #$f18 (denum) = (i*2+1) * (i*2)
	mul.d $f28, $f28, $f26   #X = X*(-1)
	mul.d $f28, $f28, $f10   #X = X * (-1) * rad
	mul.d $f28, $f28, $f10   #X = X * (-1) * rad * rad
	div.d $f28, $f28, $f18   #X = X * (-1) * rad * rad / denum
	add.d $f8, $f8, $f28     # sum = sum + X
	
        #mcvt.w.d $f14, $f14
	#mfc1 $a3, $f14
	#addi $a3, $a3, 1 
	add.d $f14, $f14, $f16   #i = i + 1
	
	j Loop
	
exit_loop: 
        li, $v0, 3
        add.d $f12, $f8, $f6
        syscall
	 
	

