    .text

    .global _start
_start:
    li x10,7
    jal setup_stack
    
    la  x13, my_func
    jalr x13

    li x12,6
    li x11,4
    
    la x9,add
    jalr x9

    la x9,diff
    jalr x9

    la x9,prod
    jalr x9

label:
    addi x0,x0,1
    j label


setup_stack:
    la x2, stack_end    //initializing the stack pointer
    ret

    .data
    .align 8

stack_start:
    .space 4096         // Allocate 4k worth of stack
stack_end:

    .end
