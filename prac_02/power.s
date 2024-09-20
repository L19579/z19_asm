# SECTION: Main

# PURPOSE: see README.md

.section .data

.section .text

.globl _start

_start: 
 push $3
 push $2
 call power_function
 sub $8, %rsp			# reset stack pointer. 

 push $rax			# save first result 
 
 push $2
 push $5
 call power_function
 sub $8, %rsp 			# --------- TODO err correct len

 pop %rbx			# retreive first result
 add %rax, %rbx		# add results

 mov $1, %rax
 int $0x80 			# end

# SECTION:	Power function
#
# PUPROSE: 	Raise base by power. Store res in %rax. 
#  
# VARIABLES: 	%rax - temp
#		%rbx - base 
#		%rcx - exponent
# 	    -4(%rbp) - tempRcurrent res.

.type power_function, @function

power_function:
 push %rbp 			# store original stack pointer.
 mov %rsp, %rbp 		# %rbp now = %rsp position.
 sub $8, $rsp			# add temp space to stack.
 
 mov -24(%rbp), %rcx
 mov -16(%rbp), %rbx
 mov -16(%rbp), %rax

 mov $0, -8(%rbp)		# ensure temp storage = 0.
 
loop_top: 
 cmp $1, %rcx			# exit if exponent =< 1.
 jge loop_exit

 mov -4(%rbp), %rax		# multiply current res by base.
 imul %rbx, %rax		# store in %rax.

 mov %rax, -4(%rbp)  		# necessity questionable tbh.

 dec %rcx 			# decr exponent.

 jmp loop_top

loop_exit: 
 mov -4(%rbp), %rax 		# lots of pointless mov.
 mov %rbp, %rsp 		# move %rsp back to "init" pos.
 pop %rbp			# reassign %rbp original value.

 ret 				# pop return addr for %eip.
