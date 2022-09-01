    .text

    .global _start
_start:

       li x8,4            //outter counter
second:li x7,4            //inner counter
       la x9,array        //x9 holds the address of the first element for comparison
back:  ld x10,0(x9)       //ith element
       ld x11,8(x9)       //(i+1)th element
       bgt x10,x11,swap   //compare, swap
return:sd x10,0(x9)       //after swapping store the values
       sd x11,8(x9)
       addi x9,x9,8       //increment the address in x9 to next dword 
       addi x7,x7,-1      //decement the inner counter
       bgt x7,x0,back     //check if pass is over
       addi x8,x8,-1      // decrement the outter counter
       bgt x8,x0,second   //check if max no.of passes is over
    
done:  la x9,array
       ld x10,0(x9)
       ld x11,8(x9)
       ld x12,16(x9)
       ld x13,24(x9)
       ld x14,32(x9)
        j exit

swap: add x12,x11,0
      add x11,x10,0
      add x10,x12,0
      j return
exit:

    .data
    .balign 0x10

array:
    .dword 5
    .dword 1
    .dword 4
    .dword 2
    .dword 8

    .end
