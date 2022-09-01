    .text

    .global _start
_start:
    la x10,var_1
    li x12,0                 //counter
    li x13,4                 //limit
loop:lbu x11,0(x10)          //takes 8 bit 
    addi x9,x11,1

    andi x9,x9,0xf           //masking upper bits
    andi x11,x11,0xf0        //masking lower bits
    or x11,x11,x9            //the resultant 8 bits to be stored

    sb x11,0(x10)
    lbu x11,0(x10)
    
    addi x10,x10,1           //next byte
    addi x12,x12,1
    bgt x13,x12,loop
    
    csrrs x5,mstatus,x0
    addi x1,x5,0x000         //to convert to user mode
    csrrs x5,mstatus,x1
    
    la x9,user_mode 
    csrrs x5,mepc,x9         //for mret to check
    
    la x9,exception_handling
    csrrs x5,mtvec,x9        //when exception occurs, to look into exception_handling 
    mret

exception_handling:
    csrrs x5,mstatus,x0
    addi x1,x5,0x000
    csrrs x5,mstatus,x1

    csrrs x5,mepc,x0
    addi x1,x5,4             //return to the line after the exception occured
    csrw mepc,x1
    mret

.balign 8
user_mode: la x9,var_1
            ld x5,3(x9)
next_command_line: addi x10,x10,1
           
    .data
    .balign 0x10
var_1:
    .word 0xccddeeff

    .align 8

stack_start:
    .space 4096              // Allocate 4k worth of stack
stack_end:


    .end
