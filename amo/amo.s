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

li x11,1
la x12,lock
again:lw x9,0(x12)
    bnez x9,again
    amoswap.w.aq x9,x11,0(x12)
    bnez x9,again

//critical_section
critical:la x9,main
jalr x9

release: 
amoswap.w.rl x0,x0,0(x12)

exit:
    .data

.balign 8
lock:
    .word 0


.balign 8
stack_start:
    .space 4096         // Allocate 4k worth of stack
stack_end:

.end

