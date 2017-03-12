/*****************************************************
This program was produced by the
CodeWizardAVR V1.24.4a Standard
Automatic Program Generator
© Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com
e-mail:office@hpinfotech.com

Project : 
Version : 
Date    : 19/5/2005
Author  : 3iGROUP                
Company : http://www.3ihut.net   
Comments: 


Chip type           : ATmega8515
Program type        : Application
Clock frequency     : 8.000000 MHz
Memory model        : Small
External SRAM size  : 32768
Ext. SRAM wait state: 0
Data Stack size     : 128
*****************************************************/
// CodeVisionAVR C Compiler
// (C) 1998-2002 Pavel Haiduc, HP InfoTech S.R.L.
// I/O registers definitions for the ATmega8515(L)
#pragma used+
sfrb OSCCAL=4;
sfrb PINE=5;
sfrb DDRE=6;
sfrb PORTE=7;
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
sfrb UCSRC=0x20;
sfrb WDTCR=0x21;
sfrb ICR1L=0x24;
sfrb ICR1H=0x25;
sfrw ICR1=0x24;   // 16 bit access
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
sfrb OCR0=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb EMCUCR=0x36;
sfrb SPMCR=0x37;
sfrb TIFR=0x38;
sfrb TIMSK=0x39;
sfrb GIFR=0x3a;
sfrb GICR=0x3b;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-
// Interrupt vectors definitions
// CodeVisionAVR C Compiler
// (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.
#pragma used+
void delay_us(unsigned int n);
void delay_ms(unsigned int n);
#pragma used-
// CodeVisionAVR C Compiler
// (C) 1998-2006 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for standard I/O functions
// CodeVisionAVR C Compiler
// (C) 1998-2002 Pavel Haiduc, HP InfoTech S.R.L.
// Variable length argument list macros
typedef char *va_list;
#pragma used+
char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
char *gets(char *str,unsigned int len);
void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);
                                               #pragma used-
#pragma library stdio.lib
// CodeVisionAVR C Compiler
// (C) 1998-2005 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for string functions
#pragma used+
char *strcat(char *str1,char *str2);
char *strcatf(char *str1,char flash *str2);
char *strchr(char *str,char c);
signed char strcmp(char *str1,char *str2);
signed char strcmpf(char *str1,char flash *str2);
char *strcpy(char *dest,char *src);
char *strcpyf(char *dest,char flash *src);
unsigned char strcspn(char *str,char *set);
unsigned char strcspnf(char *str,char flash *set);
unsigned int strlenf(char flash *str);
char *strncat(char *str1,char *str2,unsigned char n);
char *strncatf(char *str1,char flash *str2,unsigned char n);
signed char strncmp(char *str1,char *str2,unsigned char n);
signed char strncmpf(char *str1,char flash *str2,unsigned char n);
char *strncpy(char *dest,char *src,unsigned char n);
char *strncpyf(char *dest,char flash *src,unsigned char n);
char *strpbrk(char *str,char *set);
char *strpbrkf(char *str,char flash *set);
signed char strpos(char *str,char c);
char *strrchr(char *str,char c);
char *strrpbrk(char *str,char *set);
char *strrpbrkf(char *str,char flash *set);
signed char strrpos(char *str,char c);
char *strstr(char *str1,char *str2);
char *strstrf(char *str1,char flash *str2);
unsigned char strspn(char *str,char *set);
unsigned char strspnf(char *str,char flash *set);
char *strtok(char *str1,char flash *str2);
 unsigned int strlen(char *str);
void *memccpy(void *dest,void *src,char c,unsigned n);
void *memchr(void *buf,unsigned char c,unsigned n);
signed char memcmp(void *buf1,void *buf2,unsigned n);
signed char memcmpf(void *buf1,void flash *buf2,unsigned n);
void *memcpy(void *dest,void *src,unsigned n);
void *memcpyf(void *dest,void flash *src,unsigned n);
void *memmove(void *dest,void *src,unsigned n);
void *memset(void *buf,unsigned char c,unsigned n);
#pragma used-
#pragma library string.lib
/*
  CodeVisionAVR C Compiler
  (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.

  Prototypes for I2C bus master functions

  BEFORE #include -ING THIS FILE YOU
  MUST DECLARE THE I/O ADDRESS OF THE
  DATA REGISTER OF THE PORT AT WHICH
  THE I2C BUS IS CONNECTED AND
  THE DATA BITS USED FOR SDA & SCL

  EXAMPLE FOR PORTB:

    #asm
        .equ __i2c_port=0x18
        .equ __sda_bit=3
        .equ __scl_bit=4
    #endasm
    #include <i2c.h>
*/
#pragma used+
void i2c_init(void);
unsigned char i2c_start(void);
void i2c_stop(void);
unsigned char i2c_read(unsigned char ack);
unsigned char i2c_write(unsigned char data);
#pragma used-
/***************************************************************/
                                               /**************************************************************/
/* serial flags definition                                    */  
/**************************************************************/
// USART Receiver buffer
/**************************************************************/
/* IO port definition                                         */  
/**************************************************************/
                                 /**************************************************************/
/* matrix size const definition                               */  
/**************************************************************/
                                          /**************************************************************/
/* serial message const definition                            */  
/**************************************************************/
                                                                                                                                  /***************************************************************/
/***************************************************************/
// I2C Bus functions
#asm
   .equ __i2c_port=0x12 ;PORTD
   .equ __sda_bit=3
   .equ __scl_bit=2
#endasm                   
unsigned char      eeprom_read(unsigned char      deviceID, unsigned int address) 
{
    unsigned char      data;
    i2c_start();
    i2c_write(deviceID);        // issued R/W = 0
    i2c_write(address>>8);      // high word address
    i2c_write(address&0x0FF);   // low word address
        i2c_start();
    i2c_write(deviceID | 1);    // issued R/W = 1
    data=i2c_read(0);      // read at current
    i2c_stop();
    return data;
}
void eeprom_write(unsigned char      deviceID, unsigned int address, unsigned char      data) 
{
    i2c_start();
    i2c_write(deviceID);        // device address
    i2c_write(address>>8);      // high word address
    i2c_write(address&0x0FF);   // low word address
    i2c_write(data);
    i2c_stop();
    /* 10ms delay to complete the write operation */
    delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
}                                 
unsigned int eeprom_read_w(unsigned char      deviceID, unsigned int address)
{
    unsigned int result = 0;
    result = eeprom_read(deviceID,address);
    result = (result<<8) | eeprom_read(deviceID,address+1);
    return result;
}
void eeprom_write_w(unsigned char      deviceID, unsigned int address, unsigned int data)
{
    eeprom_write(deviceID,address,data>>8);
    eeprom_write(deviceID,address+1,data&0x0FF);    
}
void eeprom_read_page(unsigned char      deviceID, unsigned int address, unsigned char     *    buffer, unsigned char      page_size)
{
    unsigned char      i = 0;
    i2c_start();
    i2c_write(deviceID);            // issued R/W = 0
    i2c_write(address>>8);          // high word address
    i2c_write(address&0xFF);        // low word address
        i2c_start();
    i2c_write(deviceID | 1);        // issued R/W = 1
                                        while ( i < page_size-1 )
    {
        buffer[i++] = i2c_read(1);   // read at current
    }
    buffer[page_size-1] = i2c_read(0); // read last byte
             i2c_stop();
}
void eeprom_write_page(unsigned char      deviceID, unsigned int address, unsigned char     *    buffer, unsigned char      page_size)
{
    unsigned char      i = 0;
    i2c_start();
    i2c_write(deviceID);            // issued R/W = 0
    i2c_write(address>>8);          // high word address
    i2c_write(address&0xFF);        // low word address
                                            while ( i < page_size )
    {
        i2c_write(buffer[i++]);
        #asm("nop");#asm("nop");
    }          
    i2c_stop(); 
    delay_ms(10);
}
                                              
