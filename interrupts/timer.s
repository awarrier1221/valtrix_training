/*
              The base address and size of the CLINT device's register
              map is - 0x02000000, 0xC0000

              The register map of the CLINT is given below -

              0000 MSIP HART 0
              0004 MSIP HART 1
              4000 MTIMECMP LO HART 0
              4004 MTIMECMP HI HART 0
              4008 MTIMECMP LO HART 1
              400C MTIMECMP HI HART 1
              BFF8 MTIME LO
              BFFC MTIME HI
*/ 
.equiv MSTATUS_MIE,   0x00000008

.equiv MIE_MTIE,  0x00000080

.equiv MSTATUS_MPP,   0x00001800

.equiv MTIME_ADDR,    0x02004000

.equiv MTIMECMP_ADDR, 0x0200BFF8

.equiv MIP_MTIP,      0x00000000

    .text

    .global _start
_start:
   
    la x5,MTIME_ADDR
    sw x0,0(x5)           //setting lower and higher bits to 0
    sw x0,4(x5)
    lw x3,0(x5)
  
    li t0,-1
    la x5,MTIMECMP_ADDR
    sw t0,0(x5)           // to prevents mtimecmp from temporarily becoming 
                          //smaller than the lesser of the old and new values.
    
    addi x6,zero,0x3
    slli x6,x6,15
    sw x6,0(x5)          //32768 cycles per sec. 3s - 0x18000
    sw x6,4(x5)
    
    la a0,trap_routine
    csrw mtvec,a0

    li t0,MSTATUS_MIE
    csrw mstatus,t0

    li t0,MIP_MTIP
    csrw mip,t0

    li t0,MIE_MTIE
    csrw mie, t0
    
loop:nop
    la x5,MTIME_ADDR
    lw x6,0(x5)
    j loop

.balign 8
    trap_routine:
        csrr t0,mcause
        mret
    
    .data
    .balign 0x10

    .end
