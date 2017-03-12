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
// CodeVisionAVR C Compiler
// (C) 1998-2006 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for standard I/O functions
// CodeVisionAVR C Compiler
// (C) 1998-2002 Pavel Haiduc, HP InfoTech S.R.L.
// Variable length argument list macros
typedef char *va_list;
typedef char *va_list;
typedef char *va_list;
#pragma used+
char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
char *gets(char *str,unsigned int len);
void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void snprintf(char *str, unsigned int size, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
void vsnprintf (char *str, unsigned int size, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);
                                               #pragma used-
#pragma library stdio.lib
// CodeVisionAVR C Compiler
// (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.
#pragma used+
#pragma used+
void delay_us(unsigned int n);
void delay_ms(unsigned int n);
#pragma used-
// CodeVisionAVR C Compiler
// (C) 1998-2004 Pavel Haiduc, HP InfoTech S.R.L.
// I/O registers definitions for the ATmega32
#pragma used+
#pragma used+
sfrb TWBR=0;
sfrb TWSR=1;
sfrb TWAR=2;
sfrb TWDR=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      // 16 bit access
sfrb ADCSRA=6;
sfrb ADCSR=6;     // for compatibility with older code
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRRL=9;
sfrb UCSRB=0xa;
sfrb UCSRA=0xb;
sfrb UDR=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb PINA=0x19;
sfrb DDRA=0x1a;
sfrb PORTA=0x1b;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   // 16 bit access
sfrb UBRRH=0x20;
sfrb UCSRC=0X20;
sfrb WDTCR=0x21;
sfrb ASSR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  // 16 bit access
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  // 16 bit access
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  // 16 bit access
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb SFIOR=0x30;
sfrb OSCCAL=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TWCR=0x36;
sfrb SPMCR=0x37;
sfrb TIFR=0x38;
sfrb TIMSK=0x39;
sfrb GIFR=0x3a;
sfrb GICR=0x3b;
sfrb OCR0=0X3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-
// Interrupt vectors definitions
// Needed by the power management functions (sleep.h)
#asm
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
#endasm
extern unsigned char GetPageBuffer(void);
extern unsigned char GetPageBuffer(void);
extern unsigned char FLCheckPage(void);
extern void FLWritePage(unsigned int address);
extern unsigned int FLReadWord(unsigned int address);
// CodeVisionAVR C Compiler
// (C) 1998-2004 Pavel Haiduc, HP InfoTech S.R.L.
// I/O registers definitions for the ATmega32
											// Declare your global variables here            
void Initialize()
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
              extern unsigned char ubPageBuffer[];  
void GetDataFromHost()
{    
    unsigned int wFlashAddr = 0xFFFF;        
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
    unsigned char ubTempData;
    unsigned int wTempData = 0;                   
    unsigned int wCurrentAddr = 0;                       
    unsigned int wNumOfRow = 0;    
    unsigned int wNumOfPage = 0;      		
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
