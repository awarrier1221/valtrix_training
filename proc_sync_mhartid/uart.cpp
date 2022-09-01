#include<stdint.h>


typedef uint64_t va_t;
typedef uint64_t pa_t;
volatile uint64_t  tohost;
volatile uint64_t  fromhost;
volatile uint64_t  magic_mem[8];
volatile char      printchar;
volatile char     printstr;
volatile int printnum;


extern "C" void putc_spike(const char c)
{
    printchar = c;

    magic_mem[0] = 64;                     //this is a format for spike to know what to output through uart
    magic_mem[1] = 1;
    magic_mem[2] = (va_t)(&printchar);
    magic_mem[3] = 1;

    tohost = (va_t)magic_mem;

    while (fromhost == 0)
        ;
    fromhost = 0;

}

extern "C" void putc_char(const char c){
    putc_spike(c);
}


extern "C" void putc_string(const char* b)
{
    
    while (*b != '\0')
    {
        putc_spike(*b);
        b++;
    }
    
}

extern "C" int reverse(int k){
    int remainder;
    int reverse=0;
    while (k != 0) {
        reverse = reverse * 10 + k % 10;
        if(k / 10==0){
            
        }
  } 
  return reverse;  
}

extern "C" int length(int k)
{
    int count=1;//if k is 0
    k /=10;
    while(k != 0){
        count ++;
        k /=10;
    }
    return count;
}

extern "C" void putc_num(int k)
{
    int digit=length(k);
    printnum = reverse(k);
    int remainder;
    int ascii;
    while (printnum > 0){
        ascii =(printnum % 10) + 48;
        putc_char(ascii);
        digit--;
        printnum /=10;
    }
    while(digit !=0){
        putc_char(48);
        digit --;
    }

}


extern "C" void exit_spike()
{
    magic_mem[0] = 93;
    magic_mem[1] = 1;

    tohost = (va_t)magic_mem;
    while (fromhost == 0);
    fromhost = 0;

    while(1);
}      

extern "C" int main(){

    char b[5]="mell";
    putc_string(b);
    return 0;
}
