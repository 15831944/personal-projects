/*****************************************************
This program was produced by the
CodeWizardAVR V1.25.9 Professional
Automatic Program Generator
© Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project :
Version :
Date    : 11/17/2009
Author  : CuongQuay
Company : HOME
Comments:


Chip type           : ATmega32
Program type        : Boot Loader - Size:2048words
Clock frequency     : 8.000000 MHz
Memory model        : Small
External SRAM size  : 0
Data Stack size     : 512
*****************************************************/

#include <stdio.h>
#include <delay.h>
#include <mega32.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

#include "bootloader.h"

// Declare your global variables here
void Initialize()
{
    PORTA=0x00;
    DDRA=0xFF;
    PORTB=0xF0;
    DDRB=0x0F;
    PORTC=0xFF;
    DDRC=0xFF;
    PORTD=0x00;
    DDRD=0xF8;

    GICR|=0x40;
    MCUCR=0x03;
    MCUCSR=0x00;
    GIFR=0x40;

    TIMSK=0x00;

    UCSRA=0x00;
    UCSRB=0x98;
    UCSRC=0x86;
    UBRRH=0x00;
    UBRRL=0x2F;
    UBRRL=0x33;

    ACSR=0x80;
    SFIOR=0x00;

    OSCCAL=0xAD;

    if (1){
        printf("                                          \r\n");
        printf("|=========================================|\r\n");
        printf("|       LEDSign AVR Firmware v2.0.0       |\r\n");
        printf("|_________________________________________|\r\n");
    }
}

extern BYTE ubPageBuffer[];

void GetDataFromHost()
{
    WORD wFlashAddr = 0xFFFF;

    while (1)
    {
        wFlashAddr = getchar() & 0x0F;     // get MSB address
        wFlashAddr = wFlashAddr<<8; // store into word
        wFlashAddr |= getchar() & 0x0F;    // get LSB address
        printf("ADDRESS: %0004X", wFlashAddr);

        if (wFlashAddr == 0xFFFF)
            break;

        if (GetPageBuffer())
        {
            int i =0;
            for (i=0; i<128; i++)
            {
                printf("%02X ",ubPageBuffer[i]);
            }
            FLWritePage(wFlashAddr);
            if (FLCheckPage())
            {
                printf("Write successful");
            }
        }
    }
}

void SendToDisplay()
{
    BYTE ubTempData;
    WORD wTempData = 0;
    WORD wCurrentAddr = 0;
    WORD wNumOfRow = 0;
    WORD wNumOfPage = 0;

    wNumOfRow = FLReadWord(wCurrentAddr++);
    wCurrentAddr++;//wNumOfCol = FLReadWord(wCurrentAddr++);
    wNumOfPage = FLReadWord(wCurrentAddr++);

    while (1)
    {
        wTempData = FLReadWord(wCurrentAddr++);
        delay_ms(wTempData);
        wTempData = FLReadWord(wCurrentAddr++);

        ubTempData = wTempData & 0x00FF;

        PORTC.5 = (ubTempData&0x01)>>0;
        PORTC.4 = (ubTempData&0x02)>>1;
        PORTC.3 = (ubTempData&0x04)>>2;
        PORTC.2 = (ubTempData&0x08)>>3;
        PORTC.1 = (ubTempData&0x10)>>4;
        PORTC.0 = (ubTempData&0x20)>>5;
        PORTB.5 = (ubTempData&0x40)>>6;
        PORTB.4 = (ubTempData&0x80)>>7;

        ubTempData = wTempData >> 8;

        PORTB.3 = (ubTempData&0x01)>>0;
        PORTB.2 = (ubTempData&0x02)>>1;
        PORTB.1 = (ubTempData&0x04)>>2;
        PORTB.0 = (ubTempData&0x08)>>3;
        PORTD.7 = (ubTempData&0x10)>>4;
        PORTB.7 = (ubTempData&0x20)>>5;
        PORTD.5 = (ubTempData&0x40)>>6;
        PORTD.6 = (ubTempData&0x80)>>7;

        if (++wCurrentAddr > 2*wNumOfRow*wNumOfPage)
        {
            wCurrentAddr = 0;
        }
    }
}

void main(void)
{
    Initialize();
    GetDataFromHost();
}

#pragma promotechar+
#pragma uchar+
#pragma regalloc-
#pragma optsize+

#include <stdio.h>
#include "bootloader.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

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
