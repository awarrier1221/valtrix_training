    .text

    .global _start
_start:

    la x10, array
    li x11,0
    li x12,0
    la x8,length
    ld x7,0(x8)
    
loop:ld x9,0(x10)
     add x11,x11,x9
     addi x12,x12,1
     addi x10,x10,8
     bgt x7,x12,loop	

    .data
    .balign 0x10

length:
     .dword 4
.balign 0x10
array:
    .dword 1 
    .dword 2
    .dword 1
    .dword 3

    .end
