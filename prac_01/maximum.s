# See README.md for intentions. 

# Variables:
# 	%eax - holds current value; code for $0x80 sys call.
#	%ebx - holds highest value; auto output to sstdout.
#	%edi - iterator/pos.


.section .data
 arr:
	.long 10,45,1,33,21,78,6,6,6,2,0


.section .text

.globl _start

_start: 
 movl $0, %edi
 movl arr(, %edi, 4), %eax
 movl %eax, %ebx

loop_start: 
 cmpl $0, %eax 			# zero is our end of arr indicator
 je loop_exit

 incl %edi
 movl arr(, %edi, 4), %eax
 
 cmpl %ebx, %eax
 jle loop_start

 movl %eax, %ebx		# copy %eax to %ebx if %eax >
 jmp loop_start

loop_exit: 
 movl $1, %eax
 int $0x80
