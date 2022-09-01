#include<stdint.h>


struct pt_general{
    uint64_t pte[512];
};

pt_general __attribute__((aligned (0x1000))) table[3];


extern "C" uint64_t setup(){

    uint64_t va = 0xC0000000;
    uint64_t pa = 0x90000000;

    uint64_t address0= (uint64_t) &table[0];               //64 bit address 
    uint64_t address1= (uint64_t)&table[1];   
    uint64_t address2= (uint64_t)&table[2];

  
    
    uint64_t vpn0=(va >> 12) & 0x1ff;                      //format -> vpn2, vpn1, vpn0, page_offset
    uint64_t vpn1=(va >>21) & 0x1ff;
    uint64_t vpn2=(va >>30) & 0x1ff;
    uint64_t offset=(va & 0xfff);
    
    uint64_t ppn_pte0= ((address1 >> 12) & 0xfffffffffff); //44 bits in pte0
    uint64_t ppn_pte1= ((address2 >> 12) & 0xfffffffffff); //44 bits in pte 1    
    uint64_t ppn_pte2= ((pa >> 12)& 0xffffffffffffff);     //pa is 56 bits, converting it to 44 bits

    uint64_t addr_pte0=uint64_t( (address0 +(8* vpn2)) );  //base address + offset
    uint64_t addr_pte1=uint64_t( (address1 +(8* vpn1)) );
    uint64_t addr_pte2=uint64_t( (address2 +(8* vpn0)) );

    uint64_t pte0=((ppn_pte0 << 10) | 0x1);                //bits 63-54 is reserved and 9,8 is dont care. rest 11110001
    pte0 &= 0x3fffffffffffff; 

    uint64_t pte1=((ppn_pte1 << 10) | 0x1);
    pte1 &= 0x3fffffffffffff;

    uint64_t pte2=((ppn_pte2 << 10) | 0x1) | 0xff;
    pte2 &= 0x3fffffffffffff;

    uint64_t* ptr_pte0 =(uint64_t*) addr_pte0;             //pointer created pointing to the address of pte0;
    *ptr_pte0 = pte0;                                      //value stored at pte0

    uint64_t* ptr_pte1 =(uint64_t*) addr_pte1;
    *ptr_pte1 = pte1;

    uint64_t* ptr_pte2 =(uint64_t*) addr_pte2;
    *ptr_pte2 = pte2;

    return(address0);
}
