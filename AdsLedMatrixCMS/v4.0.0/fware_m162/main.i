/*****************************************************
This program was produced by the
CodeWizardAVR V1.24.6 Professional
Automatic Program Generator
© Copyright 1998-2005 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com
e-mail:office@hpinfotech.com

Project : 
Version : 
Date    : 11/10/2005
Author  : CUONGDD                            
Company : 3iGROUP                           
Comments: 


Chip type           : ATmega16/162/8515
Program type        : Application
Clock frequency     : 8.000000 MHz
Memory model        : Small
External SRAM size  : 0
Data Stack size     : 256
*****************************************************/
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
// DS1307 Real Time Clock functions
/*
  CodeVisionAVR C Compiler
  (C) 1998-2005 Pavel Haiduc, HP InfoTech S.R.L.

  Prototypes for the Dallas Semiconductors
  DS1307 I2C Bus Real Time Clock functions

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
    #include <ds1307.h>
*/
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
#pragma used+
unsigned char rtc_read(unsigned char address);
void rtc_write(unsigned char address,unsigned char data);
void rtc_init(unsigned char rs,unsigned char sqwe,unsigned char out);
void rtc_get_time(unsigned char *hour,unsigned char *min,unsigned char *sec);
void rtc_set_time(unsigned char hour,unsigned char min,unsigned char sec);
void rtc_get_date(unsigned char *date,unsigned char *month,unsigned char *year);
void rtc_set_date(unsigned char date,unsigned char month,unsigned char year);
#pragma used-
#pragma library ds1307.lib
                                      // Declare your global variables here     
static unsigned char     *    start_memR =0;         
static unsigned char     *    start_memG =0;         
static unsigned char     *    start_memB =0;         
bit power_off = 0;
bit is_stopping = 0;
register unsigned int x=0;
register unsigned int y=0;   
static unsigned char       mask = 0xFF;                              
static unsigned int  scroll_count = 0;  
static unsigned int  scroll_updown = 0;    
static unsigned int  stopping_count = 0;       
static unsigned char       tick_count  = 0;       
static unsigned char       frame_index = 0;   
static unsigned char       scroll_step = 0;
static unsigned int  text_length = 0;              
static unsigned char       scroll_rate = 2;
static unsigned char       scroll_temp = 2;
static unsigned char       scroll_type = 0;            
             // Global variables for message control
unsigned char       rx_message = 0    ;
unsigned int  rx_wparam  = 0;
unsigned int  rx_lparam  = 0;
// [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
                            extern void reset_serial();         
extern void send_echo_msg();    
extern unsigned char      eeprom_read(unsigned char      deviceID, unsigned int address);
extern void eeprom_write(unsigned char      deviceID, unsigned int address, unsigned char      data);
extern unsigned int eeprom_read_w(unsigned char      deviceID, unsigned int address);
extern void eeprom_write_w(unsigned char      deviceID, unsigned int address, unsigned int data);
extern void eeprom_write_page(unsigned char      deviceID, unsigned int address, unsigned char     *    buffer, unsigned char      page_size);
extern void eeprom_read_page(unsigned char      deviceID, unsigned int address, unsigned char     *    buffer, unsigned char      page_size);
static void _displayFrame();
static void _doScroll();   
void LoadFrame(unsigned char      index);     
void BlankRAM(unsigned char     *    start_addr,unsigned char     *    end_addr);
void LoadToRAM(unsigned char     *    address,unsigned int length,unsigned char      index);
///////////////////////////////////////////////////////////////
// Timer 0 overflow interrupt service routine , 40.5 us per tick                 
///////////////////////////////////////////////////////////////
interrupt [18] void timer0_ovf_isr(void)
{       
    TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
    ++tick_count;    
}
///////////////////////////////////////////////////////////////
// static function(s) for led matrix display panel
///////////////////////////////////////////////////////////////
static void putdata()
{                          
    unsigned char      tempH = 0, tempL =0;          
    unsigned char      temp_byte = 0;    
    unsigned char      temp_bit = 0;
    temp_byte = (scroll_updown/8);
    temp_bit = (scroll_updown%8);
	for (x=0; x< 240  ; x++){
		tempL = ~start_memR[(64            /8)*(x) + temp_byte]; 
		tempH = ~start_memR[(64            /8)*(x) + temp_byte+1]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		PORTB        = ~tempL & mask;                                  
		PORTD.5      = 1;
		PORTD.5      = 0;					         
		tempL = ~start_memB[(64            /8)*(x) + temp_byte]; 
		tempH = ~start_memB[(64            /8)*(x) + temp_byte+1]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		PORTB        = ~tempL & mask;
		PORTD.5      = 1;
		PORTD.5      = 0;				             
        tempL = ~start_memG[(64            /8)*(x) + temp_byte]; 
		tempH = ~start_memG[(64            /8)*(x) + temp_byte+1]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		PORTB        = ~tempL & mask;
		PORTD.5      = 1;
		PORTD.5      = 0;				
	}         
	      PORTE.0      = 1;
    PORTE.0      = 0; 
            for (x=0; x< 240  ; x++){ 
        tempL = ~start_memR[(64            /8)*(x) + temp_byte+1]; 
		tempH = ~start_memR[(64            /8)*(x) + temp_byte+2]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		PORTB        = ~tempL & mask;
		PORTD.5      = 1;
		PORTD.5      = 0;				
        tempL = ~start_memB[(64            /8)*(x) + temp_byte+1]; 
		tempH = ~start_memB[(64            /8)*(x) + temp_byte+2]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		PORTB        = ~tempL & mask;
		PORTD.5      = 1;
		PORTD.5      = 0;               
        tempL = ~start_memG[(64            /8)*(x) + temp_byte+1]; 
		tempH = ~start_memG[(64            /8)*(x) + temp_byte+2]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		PORTB        = ~tempL & mask;
		PORTD.5      = 1;
		PORTD.5      = 0;					
	}
	               PORTE.2      = 1;       
    PORTE.2      = 0;     	         
}
 static void putdata0()
{                          
	for (x=0; x< 240  ; x++){
		PORTB        = start_memR[(64            /8)*(x) ]; 
		PORTD.5      = 1;
		PORTD.5      = 0;					         
		PORTB        = start_memB[(64            /8)*(x) ]; 
		PORTD.5      = 1;
		PORTD.5      = 0;				             
		PORTB        = start_memG[(64            /8)*(x) ]; 
		PORTD.5      = 1;
		PORTD.5      = 0;				
	}         
	      PORTE.0      = 1;
    PORTE.0      = 0; 
            for (x=0; x< 240  ; x++){ 
        PORTB        = start_memR[(64            /8)*(x) + 1]; 		  
		PORTD.5      = 1;
		PORTD.5      = 0;				
        PORTB        = start_memB[(64            /8)*(x) + 1]; 
    	PORTD.5      = 1;
		PORTD.5      = 0;               
        PORTB        = start_memG[(64            /8)*(x) + 1];
        PORTD.5      = 1;
		PORTD.5      = 0;					
	}
	               PORTE.2      = 1;       
    PORTE.2      = 0;     	         
}
   static void _displayFrame()
{                                
    putdata();
    putdata();
    putdata();                
    if (scroll_updown==0){
        putdata0();            
    }             
    else{
        putdata();
    }
}     
                      static void _doScript_0()
{
    if (scroll_step ==0){                 
        start_memR += (64            /8);  
        start_memG += (64            /8);  
        start_memB += (64            /8);  
        if (++scroll_count > 240  ){     
            scroll_temp =scroll_rate;
            scroll_rate =2;
            scroll_step++; 
            scroll_count=0;
        }
    }                                      
    else if (scroll_step ==1){
        start_memR -= (64            /8);   
        if (++scroll_count > 240  ){                
            scroll_step++; 
            scroll_count=0;                        
        }
    }    
    else if (scroll_step ==2){
        start_memG -= (64            /8);   
        if (++scroll_count > 240  ){
            scroll_step++; 
            scroll_count=0;
        }
    }
    else if (scroll_step ==3){
        start_memB -= (64            /8);   
        if (++scroll_count > 240  ){
            scroll_step++; 
            scroll_count=0;
        }
    }               
    else if (scroll_step ==4){  
        if (++scroll_count > 100  ){   
            scroll_step++; 
            scroll_count=0; 
            scroll_temp =scroll_rate;
            scroll_rate =100;
        }
    }
    else if (scroll_step ==5){
        if (++scroll_updown >=64            ){                
            scroll_step++;                
            scroll_updown =0;  
            scroll_rate =scroll_temp;     
        }
    }
    else if (scroll_step ==6){  
        if (++scroll_count > 100  ){   
            scroll_step++; 
            scroll_count=0; 
        }
    }
    else{
        LoadFrame(++frame_index);
    }
}
                                           static void _doScript_1()
{    
    if (scroll_step ==0){
        mask = 0x00; 
        scroll_step++;
    }    
    else if (scroll_step ==1){  
        if (++scroll_count > 2){   
            scroll_step++; 
            scroll_count=0; 
        }
    }
    else if (scroll_step ==2){
        mask = 0xFF;  
        scroll_step++;
    }
    else if (scroll_step ==3){  
        if (++scroll_count > 2){   
            scroll_step++; 
            scroll_count=0; 
        }
    }
    else if (scroll_step ==4){  
        if (++scroll_count > 100  ){   
            scroll_step++; 
            scroll_count=0;                
            scroll_temp =scroll_rate;
            scroll_rate =100;
        }
    }                  
    else if (scroll_step ==5){
        start_memR += (64            /8); 
        start_memG += (64            /8); 
        start_memB += (64            /8); 
        if (++scroll_updown >=64            ){                
            scroll_step++;       
            scroll_rate =2;         
        }
    }
    else if (scroll_step ==6){
        start_memR -= (64            /8); 
        start_memG -= (64            /8); 
        start_memB -= (64            /8); 
        if (--scroll_updown <=0){                
            scroll_step++;                
            scroll_updown =0;  
            scroll_rate =scroll_temp;     
        }
    }
    else{
        LoadFrame(++frame_index);
    }
}
                                                                                          static void _doScroll()
{                                        
  if (tick_count > scroll_rate){
    tick_count = 0;    
    switch (scroll_type)
    {
    case 0:                     
        _doScript_0();             
        break;  
    case 1:                     
        _doScript_1();             
        break; 
    default:        
        LoadFrame(++frame_index);
        break;
    }	
	if (frame_index >= 4){
	    frame_index=0;
	}
    		  }
             }          
////////////////////////////////////////////////////////////////////
// General functions
//////////////////////////////////////////////////////////////////// 
                                                                            void LoadConfig(unsigned char      index)
{
    unsigned char      devID = 0xa0;    
    unsigned int base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = 0x8000;    
    }                 
    devID &= 0xF7;      // clear bit A3 
        // init I2C bus
    i2c_init();
    PORTB.4 = 0;
    scroll_rate = eeprom_read(devID, (unsigned int)base+0);    
    scroll_type = eeprom_read(devID, (unsigned int)base+1);    
    text_length = eeprom_read_w(devID, (unsigned int)base+2); 
    printf("index=%d scroll_rate=%d scroll_type=%d text_lenth=%d\r\n",
            index,   scroll_rate,   scroll_type,   text_length); 
        if (text_length > 3936  ){
        text_length= 0;            
    }
    if (scroll_rate > 100           ){
        scroll_rate = 0;
    }
    PORTB.4 = 1;   
}
void LoadFrame(unsigned char      index)
{                 
    if (index >= 4){
        index=0;
    }      
    LoadConfig(index);  
    if (scroll_type==-1){
        return;           
    }                                                                     
    reset_serial();
    is_stopping = 0;
    scroll_step = 0;
    scroll_count = 0;
    scroll_updown = 0;
    stopping_count = 0;    
                                BlankRAM((unsigned char     *   )0x500    ,(unsigned char     *   )0x8000);
    LoadToRAM((unsigned char     *   )0x500    ,text_length,index);    
    start_memR = (unsigned char     *   )0x500     + 0*(240  <<1)*(64            /8);
    start_memG = (unsigned char     *   )0x500     + 1*(240  <<1)*(64            /8);
    start_memB = (unsigned char     *   )0x500     + 2*(240  <<1)*(64            /8);             
}
                       void SaveTextLength(unsigned char      index)
{
    unsigned char      devID = 0xa0;    
    unsigned int base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = 0x8000;    
    }                 
    devID &= 0xF7;      // clear bit A3 
        i2c_init();
    PORTB.4 = 0;   
    eeprom_write_w(devID, base+2,text_length); 
    PORTB.4 = 1;   
}
void SaveConfig(unsigned char      rate,unsigned char      type, unsigned char      index)
{                     
    unsigned char      devID = 0xa0;    
    unsigned int base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = 0x8000;    
    }                 
    devID &= 0xF7;      // clear bit A3  
    i2c_init();
    PORTB.4 = 0;  
    eeprom_write(devID, base+0,rate);    
    eeprom_write(devID, base+1,type);    
    PORTB.4 = 1;       
}
void SaveToEEPROM(unsigned char     *    address,unsigned int length,unsigned char      index)
{                             
    unsigned char     *    tempL = 0;     
    unsigned char      devID = 0xa0;
    unsigned int base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = 0x8000;    
    }         				
    tempL = address;         
            if (length > 3936  )    
        return; // invalid param 
    length = (unsigned int)address+3*(64            /8)*(length);         
    if (length%64   )
        length = 64   *(length/64   ) + 64   ;  
    // init I2C bus
    i2c_init();
    PORTB.4 = 0;        
        for (tempL = address; tempL < length; tempL+= 64   ) 
    {   
        #asm("WDR");;                          	                                              
        eeprom_write_page( devID, base+(unsigned int)tempL, (unsigned char     *   )tempL, 64   );	      
    }       
            PORTB.4 = 1;   
}
                      void LoadToRAM(unsigned char     *    address,unsigned int length,unsigned char      index)
{                         
    unsigned char     *    tempL = 0;          
    unsigned char      devID = 0xa0;
    unsigned int base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = 0x8000;    
    }       				
    tempL = address;                 
    if (length > 3936  )    
        return; // invalid param
    length = (unsigned int)address+3*(64            /8)*(length);         
    if (length%64   )
        length = 64   *(length/64   ) + 64   ;  
    // init I2C bus
    i2c_init();
    PORTB.4 = 0;             
     for (tempL = address; tempL < length; tempL+= 64   ) 
    {
        eeprom_read_page( devID, base+(unsigned int)tempL, (unsigned char     *   )tempL, 64    );	                                   
        #asm("WDR");;     
    }             
    PORTB.4 = 1;   
}
void SerialToRAM(unsigned char     *    address,unsigned int length)                                             
{
    unsigned char     *    tempL = 0;          
    unsigned int i =0;     				
    tempL   = address;    
    PORTB.4 = 0;
    for (i =0; i< (length)*(64            /8)*3; i++)         
    {                          
        unsigned char      data = 0;
        data = ~getchar();
        *tempL = data;
        tempL++;
        #asm("WDR");;                                     
    }              
    PORTB.4 = 1;
}
                      void BlankRAM(unsigned char     *    start_addr,unsigned char     *    end_addr)
{        
    unsigned char     *    tempL = 0x500    ;
    for (tempL = start_addr; tempL<= end_addr; tempL++)    
        *tempL = 0xFF;             
}
///////////////////////////////////////////////////////////////
// END static function(s)
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////           
void InitDevice()
{
// Declare your local variables here
// Crystal Oscillator division factor: 1  
#pragma optsize-
(*(unsigned char *) 0x61)=0x80;
(*(unsigned char *) 0x61)=0x00;
PORTA=0x00;
DDRA=0xFF;
PORTB=0x00;
DDRB=0xFF;
PORTC=0x00;
DDRC=0xFF;
PORTD=0x00;
DDRD=0x30; 
PORTE=0x00;
DDRE=0xFF;
// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 250.000 kHz
// Mode: Normal top=FFh
// OC0 output: Disconnected
TCCR0=0x03;     // 4 us per tick
TCNT0=0x05;     // 1ms = 4*250
OCR0=0x00;      // 255 -250 = TCNT0
UCSR0A=0x00;
UCSR0B=0x98;
UCSR0C=0x86;
UBRR0H=0x00;
UBRR0L=0x67;      //  16 MHz     
// Lower page wait state(s): None
// Upper page wait state(s): None
MCUCR=0x80;
EMCUCR=0x00;     
// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x02;              
(*(unsigned char *) 0x7d)=0x00;
// Load calibration byte for osc.  
OSCCAL = 0x5E; 
// I2C Bus initialization
// i2c_init();
// DS1307 Real Time Clock initialization
// Square wave output on pin SQW/OUT: Off
// SQW/OUT pin state: 1
// rtc_init(3,0,1);
//i2c_init(); // must be call before
//rtc_init(3,0,1); // init RTC DS1307  
//rtc_set_time(15,2,0);
//rtc_set_date(9,5,6);    
                // Watchdog Timer initialization
// Watchdog Timer Prescaler: OSC/2048k     
WDTCR=0x1F;
WDTCR=0x0F;
}
void PowerReset()
{      
    InitDevice();
        start_memR = (unsigned char     *   )0x500    ;
    start_memG = (unsigned char     *   )0x500    ;
    start_memB = (unsigned char     *   )0x500    ;
       PORTB.4 = 0;
    BlankRAM((unsigned char     *   )0x500    ,(unsigned char     *   )0x8000);  
        PORTB.4 = 0;  
    delay_ms(50);
    PORTB.4 = 1;
    delay_ms(50);
    PORTB.4 = 0;
    delay_ms(100);    
    PORTB.4 = 1;
                    frame_index= 0;
    LoadFrame(frame_index);
    start_memR = (unsigned char     *   )0x500     + 0*(240  <<1)*(64            /8);
    start_memG = (unsigned char     *   )0x500     + 1*(240  <<1)*(64            /8);
    start_memB = (unsigned char     *   )0x500     + 2*(240  <<1)*(64            /8);
                     printf("LCMS v4.00 Designed by CuongQuay\r\n");  
    printf("cuong3ihut@yahoo.com - 0915651001\r\n");
    printf("Release date: 03.12.2006\r\n");
}
void ProcessCommand()
{
   	#asm("cli"); 
    #asm("WDR");;
    // serial message processing     
    switch (rx_message)
    {                  
    case 2 :
        {                
            text_length = rx_wparam;      
            if (text_length > 240  <<1){
                text_length = 240  <<1;
            }
            frame_index = rx_lparam&0x0F;   
            BlankRAM((unsigned char     *   )0x500    ,(unsigned char     *   )0x8000);
            SerialToRAM((unsigned char     *   )0x500    ,text_length);                		               				
			SaveToEEPROM((unsigned char     *   )0x500    ,text_length,rx_lparam);
			SaveTextLength(rx_lparam);							      
						start_memR = (unsigned char     *   )0x500     + 0*(240  <<1)*(64            /8);
            start_memG = (unsigned char     *   )0x500     + 1*(240  <<1)*(64            /8);
            start_memB = (unsigned char     *   )0x500     + 2*(240  <<1)*(64            /8);
        }				
        break;           
    case 3:
        break;   
    case 13: 
        {               
            SaveConfig(rx_wparam&0x0FF,rx_wparam>>8,rx_lparam); 
        }
        break;    
    case 7 :     
    case 11:  
        break;         
    case 6 :    
    case 10:
        break;  
    case 16  :    
        {
            power_off = rx_wparam&0x01;
        }
        break;     
    default:
        break;
    }                 
    send_echo_msg();            
    rx_message = 0    ;
    #asm("sei");        
}           
void DelayFrame(unsigned char      dly)
{
    unsigned char      i =0;
    for (i=0;i<dly;i++){
        if (rx_message != 0    ){           
            break;
        }   
        delay_ms(10);
        #asm("WDR");;
    }
}
////////////////////////////////////////////////////////////////////////////////
// MAIN PROGRAM
////////////////////////////////////////////////////////////////////////////////
void main(void)
{         
    if (MCUCSR & 8){
        // Watchdog Reset
        MCUCSR&=0xE0;  
        reset_serial(); 
    }
    else {      
        MCUCSR&=0xE0;
    }                                     
         PowerReset();                        
    #asm("sei");     
    while (1){                     
        if (rx_message != 0    ){   
            ProcessCommand();   
        }
        else{           
            _displayFrame();
            _doScroll();            
        }
        #asm("WDR");;
    };
}
                         