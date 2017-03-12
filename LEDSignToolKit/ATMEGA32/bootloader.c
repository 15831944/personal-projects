
#pragma promotechar+
#pragma uchar+
#pragma regalloc-
#pragma optsize+

#include <stdio.h>
#include "bootloader.h"

#ifdef _CHIP_ATMEGA8_                       
#define PAGE_SIZE   64               // 64 bytes per page
#define PAGE_SHFL   6                // 2^6 = 64 bytes
#endif

#ifdef _CHIP_ATMEGA32_             
#define  PAGE_SIZE 	 128            // 128 Bytes
#define  PAGE_SHFL  7               // 2^7 = 128 bytes
#endif

#asm(".EQU SPMCRAddr=0x57")          // SPMCR address definition

register WORD wPageData @2;          // PageData at R2-R3
register WORD wPageAddress @4;       // PageAddress at R4-R5
register WORD wCurrentAddress @6;    // Current address of the current data -  PageAddress + loop counter
register BYTE ubSPMCRF @10;          // store SMPCR function at R10
 
register unsigned int i @11;         //  loop counter at R11-R12
register unsigned int j @13;         //  loop counter at R13-R14 

BYTE ubPageBuffer[PAGE_SIZE];    

BOOL GetPageBuffer(void)
{
    //char localCheckSum = 0;
    //char receivedCheckSum = 0;        
    for (j=0; j<PAGE_SIZE; j++)
    {
        ubPageBuffer[j]=getchar();
    //    localCheckSum += ubPageBuffer[j];
    }
    //    receivedCheckSum = getchar();  
    return TRUE; //(localCheckSum == receivedCheckSum)?TRUE:FALSE;         
}

// CVAVR compiler allocate [address] @ R30-R31
// Return to @ R30-R31 for [WORD] in flash result
WORD FLReadWord(unsigned int address)
{            
    wCurrentAddress = address;
     
#if defined _CHIP_ATMEGA128_ 
    #asm
    movw r30, r6        ;//move  CurrentAddress to Z pointer  
    elpm r2, Z+         ;//read LSB
    elpm r3, Z          ;//read MSB    
    #endasm    
#else
    #asm
    movw r30, r6        ;//move  CurrentAddress to Z pointer  
    lpm r2, Z+          ;//read LSB
    lpm r3, Z           ;//read MSB
    #endasm    
#endif
    return (ubPageBuffer[j] +(ubPageBuffer[j+1]<<8));
}

BOOL FLCheckPage(void)
{
    WORD wCheckData = 0xFFFF;
    for (j=0; j<PAGE_SIZE; j+=2)
    {
        wCurrentAddress=wPageAddress+j; 
    #if defined _CHIP_ATMEGA128_ 
        #asm
        movw r30, r6        ;//move  CurrentAddress to Z pointer  
        elpm r2, Z+         ;//read LSB
        elpm r3, Z          ;//read MSB    
        #endasm    
    #else
        #asm
        movw r30, r6        ;//move  CurrentAddress to Z pointer  
        lpm r2, Z+          ;//read LSB
        lpm r3, Z           ;//read MSB
        #endasm    
    #endif
        wCheckData = ubPageBuffer[j] +(ubPageBuffer[j+1]<<8);
        if (wPageData != wCheckData) 
            return FALSE;
    }
    return TRUE;
}  

void FLWritePage(unsigned int address)
{ 
    wPageAddress = address;    
      
    #if defined _CHIP_ATMEGA128_  
    if (wPageAddress >> 8) RAMPZ =  1;
    else RAMPZ=0;  
    #endif                 
    
    wPageAddress = wPageAddress << PAGE_SHFL;       // get next address = PageAddress* PAGE_SIZE 
              
    for (i=0; i<PAGE_SIZE; i+=2)                    // fill temporary buffer in 2 byte chunks from PageBuffer               
    {
        wPageData=ubPageBuffer[i]+(ubPageBuffer[i+1]<<8);        
        wCurrentAddress=wPageAddress+i;                  
        
        while (SPMCR&1);        //wait for spm complete 
        ubSPMCRF=0x01;          //fill buffer page
        #asm 
            movw r30, r6        ;//move CurrentAddress to Z pointer   
            mov r1, r3          ;//move Pagedata MSB reg 1
            mov r0, r2          ;//move Pagedata LSB reg 1                
            sts SPMCRAddr, r10  ;//move ubSPMCRF to SPM control register
            spm                 ;//store program memory
        #endasm
    }    
       
    while (SPMCR&1);            //wait for spm complete
    ubSPMCRF=0x03;              //erase page
    #asm 
    movw r30, r4                ;//move PageAddress to Z pointer
    sts SPMCRAddr, r10          ;//move ubSPMCRF to SPM control register              
    spm                         ;//erase page
    #endasm
          
    while (SPMCR&1);            //wait for spm complete
    ubSPMCRF=0x05;              //write page
    #asm 
    movw r30, r4                ;//move PageAddress to Z pointer
    sts SPMCRAddr, r10          ;//move ubSPMCRF to SPM control register              
    spm                         ;//write page
    #endasm

    while (SPMCR&1);            //wait for spm complete
    ubSPMCRF=0x11;              //enableRWW  see mega8 datasheet for explanation
    
    // P. 212 Section "Prevent reading the RWW section
    // during self-programming
    #asm 
    sts SPMCRAddr, r10          ;//move ubSPMCRF to SPMCR              
    spm   
    #endasm            
}
