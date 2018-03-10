.text
.globl main

main: 
li $v0,4	#ask user to inout 3 ints
la $a0,ask
syscall

li $v0,5	#load 1st int from user (a)
syscall
move $t0,$v0

li $v0,5	#load 2nd int from user (b)
syscall
move $t1,$v0

li $v0,5	#load 3rd int from user (c)
syscall
move $t2,$v0

mult $t0,$t1   	# a * b
mflo $t7	# store lower part of the product into t7
mult $t2,$t7	# a * b * c
mflo $t7	# store lower part of product into t7 
mfhi $t6	# store higher part of product into t6

add $t1,$t0,$t1	# a + b in t1
add $t1,$t1,$t2	# a + b + c in t1
div $t1,$t0	# sum / a
mflo $t5	# integer result in t5
mfhi $t4	# reminder in t4

li $v0,4	#print out the product of 3 numbers
la $a0,prinmult
syscall

move $a0,$t7
li $v0,1
syscall

li $v0,4	#change line
la $a0,enterlin
syscall

move $a0,$t6
li $v0,1
syscall

li $v0,4	#change line
la $a0,enterlin
syscall

li $v0,4	#print out the result and reminder of (a+b+c)/c
la $a0,divresul
syscall

move $a0,$t5
li $v0,1
syscall

li $v0,4	#change line
la $a0,enterlin
syscall

move $a0,$t4
li $v0,1
syscall

.data
ask: .asciiz "Enter 3 values for a, b and c \n"
prinmult: .asciiz "the product of a, b, c is: \n"
divresul: .asciiz "the result of (a+b+c)/a and the reminder are: \n"
enterlin: .asciiz "\n"
 
