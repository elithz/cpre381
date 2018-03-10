.text
.globl main


main:

	#################### getting inputs of b[i][j] and a[i][j] from user ########################
	li $t1,4

loop1:	li $s0,0


loop2:	li $s1,0
	sll $t0,$s0,2
	addu $t0,$t0,$s1
	sll $t0,$t0,3
	addu $t0,$t7,$t0	#store array b in t7
	
	li $v0,4	#ask user to input b
	la $a0,ask1
	syscall
	move $a0,$s0
	li $v0,1
	syscall
	li $v0,4	
	la $a0,ask2
	syscall
	move $a0,$s1
	li $v0,1
	syscall
	li $v0,4	
	la $a0,ask3
	syscall
	
	
	li $v0,7	#load double
	syscall
	s.d $f0,0($t0)
	
	################## now for a #################################
	
	sll $t0,$s0,2
	addu $t0,$t0,$s1
	sll $t0,$t0,3
	addu $t0,$t6,$t0	#store array a in t6
	
	li $v0,4	#ask user to input b
	la $a0,ask4
	syscall
	move $a0,$s0
	li $v0,1
	syscall
	li $v0,4	
	la $a0,ask5
	syscall
	move $a0,$s1
	li $v0,1
	syscall
	li $v0,4	
	la $a0,ask6
	syscall
	
	
	li $v0,7	#load double
	syscall
	s.d $f0,0($t0)
	
	addiu $s0,$s0,1
	bne $s2,$t1,loop2
	
	addiu $s1,$s1,1
	bne $s0,$t1,loop1
	
	

	################### start computing the multiplication #########################

	li $t1,4
	li $s0,0

L1:	li $s1,0

L2:	li $s2,0
	sll $t2,$s0,2
	addu $t2,$t2,$s1
	sll $t2,$t2,3
	addu $t2,$t5,$t2	#a0 => s5 I store c into t5
	l.d $f4,0($t2)

L3:	sll $t0,$s2,2
	addu $t0,$t0,$s1
	sll $t0,$t0,3
	addu $t0,$t7,$t0	#a2 => t7
	l.d $f16,0($t0)
	
	sll $t0,$s0,2
	addu $t0,$t0,$s2
	sll $t0,$t0,3
	addu $t0,$t6,$t0	#a1 => t6
	l.d $f18,0($t0)
	
	mul.d $f4, $f18, $f16
	
	addiu $s2,$s2,1
	bne $s2,$t1,L3
	s.d $f4,0($t2)
	
	addiu $s1,$s1,1
	bne $s1,$t1,L2
	addiu $s0,$s0,1
	bne $s0,$t1,L1
	
	
	######################## use loop for printout the c ##########################
	li $t1,4
	li $s0,0

outp1:	li $s1,0

outp2:	sll $t2,$s0,2
	addu $t2,$t2,$s1
	sll $t2,$t2,3
	addu $t2,$t5,$t2	#a0 => s5 I store c into t5
	
	li $v0,4	
	la $a0,rst1
	syscall
	move $a0,$s0
	li $v0,1
	syscall
	li $v0,4	
	la $a0,rst2
	syscall
	move $a0,$s1
	li $v0,1
	syscall
	li $v0,4	
	la $a0,rst3
	syscall
	
	l.d $f9,0($t2)	#load c[i][j]
	mov.s $f12,$f9	#move it for output ready
	li $v0,3	#output
	syscall
	li $v0,4	#change line
	la $a0,enterlin
	syscall
	
	
	
	
.data
ask1: .asciiz "input b["
ask2: .asciiz "]["
ask3: .asciiz "]:\n"

ask4: .asciiz "input a["
ask5: .asciiz "]["
ask6: .asciiz "]:\n"

rst1: .asciiz "output c["
rst2: .asciiz "]["
rst3: .asciiz "]"

enterlin: .asciiz "\n"