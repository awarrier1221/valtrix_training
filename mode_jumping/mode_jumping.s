    .text

    .global _start
_start:
    la x10,var_1
    li x12,0             //counter
    li x13,4             //limit
loop:lbu x11,0(x10)      //takes 8 bit 
    addi x9,x11,1

    andi x9,x9,0xf       //masking upper bits
    andi x11,x11,0xf0    //masking lower bits
    or x11,x11,x9        //the resultant 8 bits to be stored

    sb x11,0(x10)
    lbu x11,0(x10)
    
    addi x10,x10,1       //next byte
    addi x12,x12,1
    bgt x13,x12,loop
    
    csrrs x5,mstatus,x0
    addi x1,x5,0x000
    csrrs x5,mstatus,x1  //setting mpp
    la x9,user_mode 
    csrrs x5,mepc,x9     //setting mepc for mret to move to
    la x9,machine_mode
    csrrs x5,mtvec,x9    //for ecall to check and can only be accessed in machine mode
    mret
    
    

user_mode: li x1,0x800
    ecall

.balign 8
machine_mode:li x1,0x0


    .data
    .balign 0x10
var_1:
    .word 0xccddeeff

    .align 8

stack_start:
    .space 4096          // Allocate 4k worth of stack
stack_end:


    .end
