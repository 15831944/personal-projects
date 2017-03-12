// CodeVisionAVR C Compiler
// (C) 1998-2004 Pavel Haiduc, HP InfoTech S.R.L.
// I/O registers definitions for the ATmega162
#pragma used+
sfrb UBRR1L=0;
sfrb UCSR1B=1;
sfrb UCSR1A=2;
sfrb UDR1=3;
sfrb OSCCAL=4;
sfrb OCDR=4;
sfrb PINE=5;
sfrb DDRE=6;
sfrb PORTE=7;
sfrb ACSR=8;
sfrb UBRR0L=9;
sfrb UCSR0B=0xa;
sfrb UCSR0A=0xb;
sfrb UDR0=0xc;
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
sfrb UBRR0H=0x20;
sfrb UCSR0C=0x20;
sfrb WDTCR=0x21;
sfrb OCR2=0x22;
sfrb TCNT2=0x23;
sfrb ICR1L=0x24;
sfrb ICR1H=0x25;
sfrb ASSR=0x26;
sfrb TCCR2=0x27;
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
sfrb UBRR1H=0x3c;
sfrb UCSR1C=0x3c;
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
///////////////////////////////////////////////////////////////
// serial interrupt handle - processing serial message ...
///////////////////////////////////////////////////////////////
// [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
///////////////////////////////////////////////////////////////
unsigned char      rx_buffer[8];
extern unsigned char       rx_message;
extern unsigned int  rx_wparam;
extern unsigned int  rx_lparam;
unsigned char rx_wr_index,rx_counter;
void send_echo_msg();
// USART Receiver interrupt service routine
interrupt [20] void usart_rx_isr(void)
{
char status,data;
status=UCSR0A;
data=UDR0;
    if ((status & ((1<<4) | (1<<2) | (1<<3)))==0)
    {
        rx_buffer[rx_wr_index]=data; 
        if (++rx_wr_index == 8) rx_wr_index=0;
        if (++rx_counter == 8)
        {
            rx_counter=0;
            if (
                rx_buffer[0]==0x55 && rx_buffer[1]==0x55 &&        
                rx_buffer[2]==0x55 
                )
            {
                rx_message  = rx_buffer[3];    // message value 
                rx_wparam   = rx_buffer[4];    // wparam value
                rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
                rx_lparam   = rx_buffer[6];    // lparam value
                rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
            }
            else if(
                rx_buffer[0]==0xFF && rx_buffer[1]==0xFF &&        
                rx_buffer[2]==0xFF 
                )
            {
                rx_wr_index=0;
                rx_counter =0;
            }      
        };
    };
}
void send_echo_msg()
{
    putchar(0x55);
    putchar(0x55);
    putchar(0x55);                
    putchar(rx_message);
    putchar(rx_wparam>>8);
    putchar(rx_wparam&0x00FF);
    putchar(rx_lparam>>8);        
    putchar(rx_lparam&0x00FF);
}  
void reset_serial()
{
    rx_wr_index=0;
    rx_counter =0;
    rx_message = 0    ;
}
///////////////////////////////////////////////////////////////
// END serial interrupt handle
/////////////////////////////////////////////////////////////// 

