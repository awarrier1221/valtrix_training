    .text

    .global _start
_start:
    la x2, stack_end             //setup stack pointer

    la x5,setup                  //setup the table for translation in mmu.cpp
    jalr x5
    
return:csrrs x5,mstatus,x0
    addi x1,x5,0x000
    csrrs x5,mstatus,x1         //setting mpp
    
    la x9,_startsu 
    csrrs x5,mepc,x9            //setting mepc for mret to move to

    la x9,exception_handling
    csrrs x5,mtvec,x9 

    add x1,x10,x0
    srli x1,x1,12
    li x9,0x8000000000000000    //sv39 mode 
    or x1,x1,x9
    csrw satp,x1
    csrr x1,satp

    mret

exception_handling:
    csrrs x5,mstatus,x0
    addi x1,x5,0x000
    csrrs x5,mstatus,x1

    csrrs x5,mepc,x0
    addi x1,x5,4                //return to the line after the exception occured
    csrw mepc,x1
    mret

    .data
    .align 8

stack_start:
    .space 4096                // Allocate 4k worth of stack
stack_end:


    .end
