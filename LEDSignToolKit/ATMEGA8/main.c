/*****************************************************
This program was produced by the
CodeWizardAVR V2.04.4a Evaluation
Automatic Program Generator
© Copyright 1998-2009 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 1.0
Date    : 10/8/2009
Author  : DUONG Dinh Cuong
Company : HOME
Comments: 


Chip type               : ATmega8
Program type            : Boot Loader - Size:1024words
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/

#include <mega8.h>
#include <stdio.h>
#include <delay.h>    
                                 
#define BOOL    unsigned char
#define BYTE    unsigned char
#define WORD    unsigned int
#define DWORD   unsigned long

#define TRUE    1
#define FALSE   0

extern flash unsigned int _dataBuffer[];

void Initialize()
{
    PORTB=0x00;
    DDRB=0xBF;

    PORTC=0x00;
    DDRC=0x7F;

    PORTD=0x00;
    DDRD=0xFF;

    TCCR0=0x00;
    TCNT0=0x00;

    MCUCR=0x00;

    TIMSK=0x00;

    ACSR=0x80;
    SFIOR=0x00;    

#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif
}

void SendToDisplay()
{    
    BYTE ubTempData;
    WORD wTempData = 0;                   
    WORD wCurrentAddr = 0;                       
    WORD wNumOfRow = 0;    
    WORD wNumOfPage = 0;      		
	    
    wNumOfRow = _dataBuffer[wCurrentAddr++];    
    wCurrentAddr++;  /* wNumOfCol unused */
    wNumOfPage = _dataBuffer[wCurrentAddr++];
    
    while (1)
    {        
        wTempData = _dataBuffer[wCurrentAddr++];
        delay_ms(wTempData);
        wTempData = _dataBuffer[wCurrentAddr++];
                
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
                                			        
        if (wCurrentAddr > (2*wNumOfRow*wNumOfPage + 4))
        {								
            wCurrentAddr = 3;   /* start of data block */			
        }
    }
}

void main(void)
{
    Initialize();                                                                    
    SendToDisplay();            
}
