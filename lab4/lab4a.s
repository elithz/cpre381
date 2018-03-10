# PROGRAM: Hello, World!

.data # Data declaration section
out_string: .asciiz "\nHello, World!\n"

.text # Assembly language instructions
main: # Start of code section
li $v0, 4 
la $a0, out_string 
syscall
