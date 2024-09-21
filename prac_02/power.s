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

 push %rax			# save first result 
 
 push $2
 push $5
 call power_function
 sub $8, %rsp 			# --------- TODO err correct len

 pop %rbx			# retreive first result
 add %rax, %rbx			# add results


# TEMP TEST AREA -- START 

# ------- infinite looping. Echo $? = 130. Review. 32 to 64 bit.

# TEMP TEST AREA -- END

 movq $1, %rax
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
 movq %rsp, %rbp 		# %rbp now = %rsp position.
 sub $8, %rsp			# add temp space to stack.
 
 movq -24(%rbp), %rcx
 movq -16(%rbp), %rbx
 movq -16(%rbp), %rax

 movq $0, -8(%rbp)		# ensure temp storage = 0.
 
loop_top: 
 cmp $1, %rcx			# exit if exponent =< 1.
 je loop_exit

 movq -8(%rbp), %rax		# multiply current res by base.
 imulq %rbx, %rax		# store in %rax.

 movq %rax, -8(%rbp)  		# necessity questionable tbh.

 dec %rcx 			# decr exponent.

 jmp loop_top

loop_exit: 
 movq -8(%rbp), %rax 		# lots of pointless mov.
 movq %rbp, %rsp 		# move %rsp back to "init" pos.
 pop %rbp			# reassign %rbp original value.

 ret 				# pop return addr for %eip.
