    .text

    .global _start
_start:

//setting up stack pointer
la x13,stack_start
csrr a0,mhartid
li x14,1024
addi x15,a0,1
mul x16,x15,x14
add x13,x13,x16
add sp,x13,0

//setting up the flag using mhartid
la x6,flag
li x7,8
mul x7,x7,a0
add x8,x6,x7
sw a0,0(x8)

//checking for lock
la x6,flag
loop:ld x7,0(x6)
bne x7,a0,loop

//critical section
la x9,main
jalr x9

//updation (x8) for the next processor
csrr a0,mhartid
la x6,flag
li x7,8
addi a0,a0,1
mul x7,x7,a0
add x8,x6,x7
sw a0,0(x6)

exit:

    .data
    .balign 0x10

.balign 8
stack_start:
    .space 4096          // Allocate 4k worth of stack
stack_end:

.balign 8
flag:
    .space 256
    
.end

