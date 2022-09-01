    .text

    .global _start
_start:
la sp,stack_end

critical:la x9,main
jalr x9

exit:

    .data
    .balign 0x10

.balign 8
stack_start:
    .space 4096         // Allocate 4k worth of stack
stack_end:

.end

