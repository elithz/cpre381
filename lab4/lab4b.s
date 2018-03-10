.text
.globl main
#we were instructed to add comments to this file to explore its operation and functions.


main: li $v0,4 #establish default of 4 to reg 3
la $a0,prompt #ask for new value and store in a0
syscall #execute block

li $v0,5 #load 5 into v0
syscall #execute block

lw $t0,x #load predefined 3 into t0
add $t0,$t0,$v0 #add t0 and v0 (the default of x and prompted value together)
sw $t0,y #store result of addition into t0


.data
prompt: .asciiz "Enter a value"
x: .word 3 #predefined value for x
y: .word 0 #predefined value for y
