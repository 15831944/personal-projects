#include "define.h"   
                   
void demo_AAA(PBYTE address,WORD length)
{    
UINT i = 0;         
PBYTE pbuffer = 0;
pbuffer = address;
// 0x18
for (i = 0; i< length; i+=8)
 {
    pbuffer[i+0] = ~0x00;
    pbuffer[i+1] = ~0x00;
    pbuffer[i+2] = ~0x00;
    pbuffer[i+3] = ~0x0A;

    pbuffer[i+4] = ~0x09;
    pbuffer[i+5] = ~0x00;
    pbuffer[i+6] = ~0x00;
    pbuffer[i+7] = ~0x00;
 }

// 0x36
for (i = length; i< 2*length; i+=8)
 {
    pbuffer[i+0] = ~0x00;
    pbuffer[i+1] = ~0x00;
    pbuffer[i+2] = ~0x0A;
    pbuffer[i+3] = ~0x09;

    pbuffer[i+4] = ~0x00;
    pbuffer[i+5] = ~0x0A;
    pbuffer[i+6] = ~0x09;
    pbuffer[i+7] = ~0x00;
 }

// 0x63  
for (i = 2*length; i< 3*length; i+=8)
 {
    pbuffer[i+0] = ~0x00;
    pbuffer[i+1] = ~0x0A;
    pbuffer[i+2] = ~0x09;
    pbuffer[i+3] = ~0x00;

    pbuffer[i+4] = ~0x00;
    pbuffer[i+5] = ~0x00;
    pbuffer[i+6] = ~0x0A;
    pbuffer[i+7] = ~0x09;
 }       
 
// 0x63
for (i = 3*length; i< 4*length; i+=8)
 {
    pbuffer[i+0] = ~0x00;
    pbuffer[i+1] = ~0x0A;
    pbuffer[i+2] = ~0x09;
    pbuffer[i+3] = ~0x00;

    pbuffer[i+4] = ~0x00;
    pbuffer[i+5] = ~0x00;
    pbuffer[i+6] = ~0x0A;
    pbuffer[i+7] = ~0x09;
 }     
 
// 7F  
for (i = 4*length; i< 5*length; i+=8)
 {
    pbuffer[i+0] = ~0x00;
    pbuffer[i+1] = ~0x0A;
    pbuffer[i+2] = ~0x09;
    pbuffer[i+3] = ~0x09;

    pbuffer[i+4] = ~0x09;
    pbuffer[i+5] = ~0x09;
    pbuffer[i+6] = ~0x0A;
    pbuffer[i+7] = ~0x09;
 }                  

// 0x63
for (i = 5*length; i< 6*length; i+=8)
 {
    pbuffer[i+0] = ~0x00;
    pbuffer[i+1] = ~0x0A;
    pbuffer[i+2] = ~0x09;
    pbuffer[i+3] = ~0x00;

    pbuffer[i+4] = ~0x00;
    pbuffer[i+5] = ~0x00;
    pbuffer[i+6] = ~0x0A;
    pbuffer[i+7] = ~0x09;
 }

// 0x63
for (i = 6*length; i< 7*length; i+=8)
 {
    pbuffer[i+0] = ~0x00;
    pbuffer[i+1] = ~0x0A;
    pbuffer[i+2] = ~0x09;
    pbuffer[i+3] = ~0x00;

    pbuffer[i+4] = ~0x00;
    pbuffer[i+5] = ~0x00;
    pbuffer[i+6] = ~0x0A;
    pbuffer[i+7] = ~0x09;
 }     
                     
// 0x00
for (i = 7*length; i< 8*length; i+=8)
 {
    pbuffer[i+0] = ~0x00;
    pbuffer[i+1] = ~0x00;
    pbuffer[i+2] = ~0x00;
    pbuffer[i+3] = ~0x00;

    pbuffer[i+4] = ~0x00;
    pbuffer[i+5] = ~0x00;
    pbuffer[i+6] = ~0x00;
    pbuffer[i+7] = ~0x00;
 } 
}