    .text

    .global _start
_start:

    la x10,var_1
    li x12,0          //counter
    li x13,4          //limit
loop:lbu x11,0(x10)   //takes 8 bit 
    addi x9,x11,1

    andi x9,x9,0xf    //masking upper bits
    andi x11,x11,0xf0 //masking lower bits
    or x11,x11,x9     //the resultant 8 bits to be stored

    sb x11,0(x10)
    lbu x11,0(x10)
    
    addi x10,x10,1    //next byte
    addi x12,x12,1
    bgt x13,x12,loop

    .data
    .balign 0x10

var_1:
    .word 0xccddeeff  //convert to cddeeff0

    .end
