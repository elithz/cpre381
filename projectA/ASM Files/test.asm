# This program sums an array from memory. It stores the result in s0
# and it also saves the sum of the previous elements in memory at each 
# index. This is meant to test the six instructions required for project A.
.text
.globl main
main:
lw $t0, 0($zero) #get the size of the array
addi $t1, $zero 4 #address of the first element in memory
add $s0, $zero, $zero #zero out the register where the sum is saved
j check # jump to the condition
loop:
lw $t2, 0($t1) # get an element of the array
add $s0, $t2, $s0 # add the element to the sum
sw $s0, 0($t1) # store the sum back to memory
addi $t1, $t1, 4 # get the address of the next element
addi $t0, $t0, -1 # decrement the counter 
check:
beq $t0, $zero, exit # check if the counter is zero.
j loop #jump to the loop
exit:
