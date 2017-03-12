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
                                      //#define     __DIGITAL_CLOCK_
                                                   /***************************************************************/
/***************************************************************/
// 1 Wire Bus functions
#asm
   .equ __w1_port=0x12 ;PORTD
   .equ __w1_bit=5
#endasm
/*
  CodeVisionAVR C Compiler
  (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.

  Prototypes for Dallas Semiconductor
  1 Wire protocol functions

  BEFORE #include -ING THIS FILE YOU
  MUST DECLARE THE I/O ADDRESS OF THE
  DATA REGISTER OF THE PORT AT WHICH
  THE 1 WIRE BUS IS CONNECTED AND
  THE DATA BIT USED

  EXAMPLE FOR PORTB:

    #asm
        .equ __w1_port=0x18
        .equ __w1_bit=3
    #endasm
    #include <1wire.h>
*/
#pragma used+
unsigned char w1_init(void);
unsigned char w1_read(void);
unsigned char w1_write(unsigned char data);
unsigned char w1_search(unsigned char cmd,void *p);
unsigned char w1_dow_crc8(void *p,unsigned char n);
#pragma used-
// DS1820 Temperature Sensor functions
/*
  CodeVisionAVR C Compiler
  (C) 1998-2005 Pavel Haiduc, HP InfoTech S.R.L.

  Prototypes for Dallas Semiconductor
  DS18B20 1 Wire bus temperature sensor
  functions

  BEFORE #include -ING THIS FILE YOU
  MUST DECLARE THE I/O ADDRESS OF THE
  DATA REGISTER OF THE PORT AT WHICH
  THE 1 WIRE BUS IS CONNECTED AND
  THE DATA BIT USED

  EXAMPLE FOR PORTB:

    #asm
        .equ __w1_port=0x18
        .equ __w1_bit=3
    #endasm
    #include <ds1820.h>
*/
/*
  CodeVisionAVR C Compiler
  (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.

  Prototypes for Dallas Semiconductor
  1 Wire protocol functions

  BEFORE #include -ING THIS FILE YOU
  MUST DECLARE THE I/O ADDRESS OF THE
  DATA REGISTER OF THE PORT AT WHICH
  THE 1 WIRE BUS IS CONNECTED AND
  THE DATA BIT USED

  EXAMPLE FOR PORTB:

    #asm
        .equ __w1_port=0x18
        .equ __w1_bit=3
    #endasm
    #include <1wire.h>
*/
#pragma used+
extern struct __ds18b20_scratch_pad_struct
       {
       unsigned char temp_lsb,temp_msb,
                temp_high,temp_low,
                conf_register,
                res1,
                res2,
                res3,
                crc;
       } __ds18b20_scratch_pad;
unsigned char ds18b20_select(unsigned char *addr);
unsigned char ds18b20_read_spd(unsigned char *addr);
float ds18b20_temperature(unsigned char *addr);
unsigned char ds18b20_init(unsigned char *addr,signed char temp_low,signed char temp_high,
unsigned char resolution);
#pragma used-
#pragma library ds18b20.lib
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
static unsigned char     *    start_mem;
static unsigned char     *    end_mem;        
static unsigned char     *    buffer; 
static unsigned char     *    bkgnd_mem;     
static unsigned char     *    org_mem;
bit is_show_bkgnd        = 0;
bit is_power_off         = 0;     
bit is_stopping          = 0;   
bit is_half_above        = 0;
bit is_half_below        = 0; 
register unsigned int count_row  = 0;
register unsigned int count_col  = 0;     
register signed horiz_idx  = 0;
static unsigned char      scroll_rate   = 0; 
static unsigned char      scroll_type   = 0;    
static unsigned char      frame_index   = 0;                                 
static unsigned int  tick_count  = 0;      
static unsigned int  char_count  = 0;
static unsigned int  text_length = 0;
static unsigned int  stopping_count = 0;
static unsigned int  flipping_count = 0;
static unsigned int  char_width[256];    
static unsigned int  columeH = 0;
static unsigned int  columeL = 0;
static unsigned int  char_index = 0;    
static unsigned int  next_char_width = 0;
static unsigned int  current_char_width = 0;  
flash char  szText[] = "** CuongQuay 0915651001 **";    
static char szDateStr[] = "Bay gio la 00 gio 00 phut 00 giay. Ngay 00 thang 00 nam 0000.";
             // Global variables for message control
unsigned char       rx_message = 0    ;
unsigned int  rx_wparam  = 0;
unsigned int  rx_lparam  = 0;
// [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
                            extern void reset_serial();         
extern void send_echo_msg();    
extern unsigned char      eeprom_read(unsigned char      deviceID, unsigned char     *    address);
extern void eeprom_write(unsigned char      deviceID, unsigned char     *    address, unsigned char      data);
extern unsigned int eeprom_read_w(unsigned char      deviceID, unsigned char     *    address);
extern void eeprom_write_w(unsigned char      deviceID, unsigned char     *    address, unsigned int data);
extern void eeprom_write_page(unsigned char      deviceID, unsigned char     *    address, unsigned char     *    buffer, unsigned char      page_size);
extern void eeprom_read_page(unsigned char      deviceID, unsigned char     *    address, unsigned char     *    buffer, unsigned char      page_size);
static void _displayFrame();
static unsigned char _doScroll(); 
                                                                                 extern void getLunarStr(char* sz, short h, short m, short dd, short mm, int yyyy);
void LoadFrame();      
void BlankRAM(unsigned char     *    start_addr,unsigned char     *    end_addr);
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
static void _setRow()
{
    unsigned char      i=0;        
    PORTD.5      = 1; 
    for (i=0; i<8; i++){            
        if (i==(7-count_row)){ 
            PORTD.5      = 0;        
        }
        else{
            PORTD.5      = 1;        
        }
        PORTD.3      = 1;
        PORTD.3      = 0;            
    }
}
            static void _powerOff()
{
    unsigned char      i =0;               
    PORTD.5      = 1;  // data scan low        
    for (i=0; i<8; i++)    
    {                                              
        PORTD.3      = 1;    // clock scan high
        PORTD.3      = 0;    // clock scan low            
    }                                         
    PORTD.4      = 1;    // strobe scan high
    PORTD.4      = 0;    // strobe scan low                    
}
static void _displayFrame()
{                                   
    count_col = 0;
    count_row = 0;         
    if (is_power_off ==1){
        _powerOff();
        return;
    }
                 columeL = current_char_width + ((0x500        + 144*8)    + 144) - (unsigned int)start_mem;
    columeH = next_char_width + ((0x500        + 144*8)    + 144) - (unsigned int)start_mem;         	                                           
    // display one frame in the screen at the specific time 
    for (buffer = start_mem;buffer < (0x7FFF); buffer++)  
    {      
        if (scroll_type == 1 && current_char_width < 144)
		{                                  		        
			if (count_col < current_char_width){				
				if (is_show_bkgnd){
                    PORTB        = org_mem[count_row*(3936 -144)	 + 144 + count_col]&
                            (bkgnd_mem[count_col+144*count_row]);	
                }                               
                else{
                    PORTB        = org_mem[count_row*(3936 -144)	 + 144 + count_col];
                }
			}
			else if ((count_col > columeL) && (count_col < columeH)){				
				if (is_show_bkgnd){
				    PORTB        = (*buffer)&(bkgnd_mem[count_col+144*count_row]);								
				}                                                    
				else{
				    PORTB        = (*buffer);
				}
			}
			else{                  
			    if (is_show_bkgnd){
    	    		PORTB        = (bkgnd_mem[count_col+144*count_row]);                				
    	        }
    	        else{
    	            PORTB        = 0xFF;
    	        }
			}                                                               			
        }
        else{     	        
            if ( is_half_above ==1){                            
                if (horiz_idx < 8){
                    if (count_row > 7-horiz_idx){
                        PORTB        = *(buffer+horiz_idx*(3936 -144)	-8*(3936 -144)	)>>2;
                    }
                    else{                             
                        PORTB        = *(buffer+horiz_idx*(3936 -144)	);
                    }  
                }
                else{                                                        
                    if (count_row < (16-horiz_idx)){
                        PORTB        = *(buffer+(horiz_idx-8)*(3936 -144)	)>>2 | 0xCC;
                    }
                    else{
                        PORTB        = 0xFF;
                    }
                }                    
            }
            else if ( is_half_below ==1){         
                if (horiz_idx < 8){
                    if (count_row < horiz_idx){
                        PORTB        = *(buffer+8*(3936 -144)	-horiz_idx*(3936 -144)	)<<2 | 0x33;
                    }
                    else{
                        PORTB        = *(buffer-horiz_idx*(3936 -144)	);
                    }   
                }                    
                else{                                             
                    if (count_row > horiz_idx-8){
                        PORTB        = *(buffer+8*(3936 -144)	-horiz_idx*(3936 -144)	)<<2 | 0x33;
                    }
                    else{
                        PORTB        = 0xFF;
                    }
                }
            }                
            else{
                if (is_show_bkgnd){           
                    if (count_col < 32){     
                        PORTB        = (bkgnd_mem[count_col+144*count_row]);
                    }
                    else{
                        PORTB        = (*buffer);
                    }
                }                     
                else{                     
                    PORTB        = (*buffer);
                }
            }            
                                 }              
                         PORTB        |= 0xF0;
                PORTE.2      = 1;    // clock high
        PORTE.2      = 0;    // clock low   
        if ( ++count_col >= 144)
        {                                            
            count_col = 0;      // reset for next                                                                                                                       
                        _powerOff();        // turn all led off            
                        _setRow();          // turn row-led on                                                           
                                                                                                          PORTD.4      = 1;       // strobe high                                                    
            PORTD.4      = 0;       // strobe low 
            PORTE.0      = 1;       // strobe high            
            PORTE.0      = 0;       // strobe low                                                 
                                                if (++count_row >= 8){ 
                count_row = 0;
            }                                             
            delay_ms(1);                                            
            buffer += ((3936 -144)	 - 144);                 
        }                   
    }                         	
}     
                                  static unsigned char _doScroll()
{
    // init state                         
    PORTE.0      = 0;
    PORTE.2      = 0;                
    // scroll left with shift_step bit(s)
    if(tick_count >= scroll_rate)
    {                             
        tick_count = 0; 
        is_show_bkgnd = 0;          
        switch (scroll_type)
        {
        case 1:        
            if (current_char_width > 144){
                if (is_stopping==0){
                    if (stopping_count < 100){
                        is_stopping = 1;
                        //start_mem = (PBYTE)(START_RAM_TEXT+SCREEN_WIDTH);
                    }
                    else{
                        start_mem++;
                    }
                }
                else{
                    if (++stopping_count > 100){
                        is_stopping = 0;
                    }
                }
                                              }
		    else{
			    start_mem += (2);
    			if (start_mem > ((0x500        + 144*8)    + 144) - current_char_width){
		    		char_index++;				 
			    	current_char_width = char_width[char_index];
				    next_char_width = char_width[char_index+1];				
    				start_mem = (unsigned char     *   )(0x500        + 144*8)    + current_char_width;
	    		}
		    }  
		    if (start_mem >= ((0x500        + 144*8)    + 144 + 16)+ text_length){
		        LoadFrame();
		    }
            break;
        case 0:
            start_mem++;    
            if (start_mem >= ((0x500        + 144*8)    + 144 + 16)+ text_length){
		        LoadFrame();
		    }
            break;
        case 2:                                  
            if (start_mem < ((0x500        + 144*8)    + 144)){		    
                start_mem+=32;    
            }
            else {		    
                if (is_power_off==0){                
                    if (++stopping_count > 100/2){
                        is_power_off=1;                    
                        stopping_count=0;                
                    }
                }
                else{                                     
                    if (++stopping_count > 100){            
                        is_power_off=0;
                        stopping_count=0;                    
                        if(++flipping_count > 3){
                            flipping_count=0;
                            scroll_type = 0;
                        }
                    }
                }
            }  
            break;
        case 3      :      
            start_mem++;    
            is_show_bkgnd = 1;            
            if (start_mem >= ((0x500        + 144*8)    + 144 + 16)+ text_length){
		        LoadFrame();
		    }
            break;     
        case 4:
            if (start_mem < ((0x500        + 144*8)    + 144)){		    
                start_mem+=8;    
            }   
            else if (start_mem >= ((0x500        + 144*8)    + 144) && start_mem < ((0x500        + 144*8)    + 144)+8){
                if (is_stopping==0){
                    is_stopping =1;
                }
                else{
                    if (++stopping_count > 100){                       
                        is_stopping = 0; 
                        start_mem +=8;
                    }
                }
            }
            else{
                if (is_stopping==0){
                    start_mem++; 
                }
            }                   
            if (start_mem >= ((0x500        + 144*8)    + 144 + 16)+ text_length){
		        LoadFrame();
		    }
            break;      
        case 5       : 
            if (is_half_above==1){ 
                if (is_stopping ==0){            
                    if (++horiz_idx >=16){                
                        is_half_above = 0;
                        is_half_below = 1;        
                        horiz_idx  = 16;
                        start_mem += 144;                                  
                        if (start_mem >= ((0x500        + 144*8)    +(text_length+144))){ 
                            is_half_above = 0;
                            is_half_below = 0;
                            LoadFrame();
                        } 
                    }
                }
                else{                  
                    if (++stopping_count > 100){                       
                        is_stopping = 0;
                    }
                }
            }
            else if (is_half_below==1){                
                if (--horiz_idx <0){
                    horiz_idx =0; 
                    is_half_below = 0;
                    is_half_above = 1;
                    is_stopping =1;
                    stopping_count = 0; 
                }   
            }                                
            break;        
        case 6:
            if (is_half_below==1){       
                if (is_stopping ==0){      
                    if (++horiz_idx >=16){                
                        is_half_above = 1;
                        is_half_below = 0;   
                        horiz_idx  = 16;                
                        start_mem += 144;                                  
                        if (start_mem >= ((0x500        + 144*8)    +(text_length+144))){
                            is_half_above = 0;
                            is_half_below = 0;
                            LoadFrame();
                        }              
                    }
                }
                else{
                    if (++stopping_count > 100){                       
                        is_stopping = 0;
                    }
                }
            }
            else if (is_half_above==1){
                if (--horiz_idx <0){
                    horiz_idx =0; 
                    is_half_below = 1;
                    is_half_above = 0;     
                    is_stopping =1;
                    stopping_count = 0; 
                }  
            }                       
            break;              
        case 7:                        
            if (is_half_above==1){
                if (--horiz_idx <0){
                    horiz_idx =0; 
                    is_half_below = 0;
                    is_half_above = 0;     
                    is_stopping =1;
                    stopping_count = 0; 
                }  
            }        
            start_mem++;                  
            if (start_mem >= ((0x500        + 144*8)    +(text_length+144))){
                is_half_above = 0;
                is_half_below = 0;
                LoadFrame();
            }            
            break;
        case 8:  
                                                                                                                                                                                                                    		                                                		        		                                                                                                                                                                                                                                                                                                                                                start_mem++;    
            if (start_mem >= ((0x500        + 144*8)    + 144 + 16)+ text_length){
		        LoadFrame();
		    }
		            break; 
        default:
            break;
        }          
    } 
    return 1;       
}                 
                                          ////////////////////////////////////////////////////////////////////
// General functions
//////////////////////////////////////////////////////////////////// 
void SerialToRAM(unsigned char     *    address,unsigned int length, unsigned char      type)                                             
{
    unsigned char     *    temp = 0;          
    unsigned int i =0, row =0;     				
    temp   = (unsigned char     *   )address;    
    PORTB.4 = 0;
    for (row =0; row < 8; row++)
    {
        for (i =0; i< length; i++) 
        {
            *temp++ = ~getchar();
            #asm("WDR");;
        }                               
        if (type == 0)   
            temp += (3936 -144)	 - length;        
    }              
    PORTB.4 = 1;
}
void LoadCharWidth(unsigned int length)
{                               
    unsigned int i =0;  
    PORTB.4 = 0;   
    for (i =0; i < length; i++)
    {                           
        unsigned int data = 0;
        data = getchar();                       // LOBYTE 
        #asm("WDR");;       
        char_width[i] = data;        
        data = getchar();                       // HIBYTE
        #asm("WDR");;
        char_width[i] |= (data<<8)&0xFF00;
    }                  
    current_char_width = 0xFFFF;
        PORTB.4 = 1;
}
void SaveCharWidth(unsigned int length, unsigned char      index)
{
    unsigned int i =0;                 
    unsigned char      devID = 0xA0;
    unsigned char     *    base  = 0x0A;   
    devID += index<<1;
    i2c_init();
    PORTB.4 = 0;   
    for (i =0; i < length; i++)
    {                           
        eeprom_write_w(devID,base+(i<<1),char_width[i]);
        #asm("WDR");;
    }              
    PORTB.4 = 1; 
    PORTD = 0x00;
    DDRD = 0x3F; 
}
void GetCharWidth(unsigned int length, unsigned char      index)
{                               
    unsigned int i =0;   
    unsigned char      devID = 0xA0;
    unsigned char     *    base  = 0x0A;              
    devID += index<<1;
    i2c_init();
    PORTB.4 = 0;              
    for (i =0; i < length; i++)
    {                           
        char_width[i] = eeprom_read_w(devID,base+(i<<1));    
        #asm("WDR");;
    }                      
    PORTB.4 = 1;
    PORTD = 0x00;
    DDRD = 0x3F; 
}
void SaveToEEPROM(unsigned char     *    address, unsigned char      type, unsigned char      index)
{                             
    unsigned char     *    temp = 0;    
    unsigned char     *    end  = (0x500        + 144*8)   ;     
    unsigned char      devID = 0xA0;      				
    devID += index<<1;
    temp   = address;         
               i2c_init();
    PORTB.4 = 0;        
        if (type == 0) end = (unsigned char     *   )0x7FFF;
        for (temp = address; temp < end; temp+= 64   ) 
    {   
        #asm("WDR");;               
        eeprom_write_page( devID, temp, temp, 64   );	      
    }       
    PORTB.4 = 1;
    PORTD = 0x00;
    DDRD = 0x3F;    
}
                      void LoadToRAM(unsigned char     *    address, unsigned int length, unsigned char      type, unsigned char      index)
{                         
    unsigned char     *    temp = 0;          
    unsigned int i =0, row =0;    
    unsigned char      devID = 0xA0;
    devID += index<<1;      				
    temp   = address;                 
        if (length > (3936 -144)	)    
        return; // invalid param
    if (length%64   )
        length = 64   *(length/64   ) + 64   ;        
    i2c_init();
    PORTB.4 = 0;             
    for (row =0; row < 8; row++)            
    {                           
        for (i =0; i< length; i+=64   ) 
        {                                 
            eeprom_read_page( devID, temp, temp, 64    );	                                   
            temp += 64   ;
            #asm("WDR");;     
        }         
        if (type == 0)  
            temp += (3936 -144)	 - length;  
    }             
        PORTB.4 = 1; 
    PORTD = 0x00;
    DDRD = 0x3F;  
}
void LoadConfig(unsigned char      index)
{   
    unsigned char      devID = 0xA0;
    devID += index<<1; 
    i2c_init();
    PORTB.4 = 1;                  
    #asm("WDR");;             
    scroll_type   = eeprom_read(devID,0);
    scroll_rate = eeprom_read(devID,(unsigned char     *   )1);
    text_length =  eeprom_read_w(devID,(unsigned char     *   )2); 
    char_count =  eeprom_read_w(devID,(unsigned char     *   )4);         
    printf("line=%d rate=%d type=%d len=%d\r\n",index,scroll_rate,scroll_type,text_length);
    if (text_length > (3936 -144)	){
        text_length= 0;            
    }
    if (char_count > 255){
        char_count = 0;
    }
    PORTB.4 = 0; 
    PORTD = 0x00;
    DDRD = 0x3F;   
}
void SaveConfig(unsigned char      index)
{     
    unsigned char      devID = 0xA0;
    devID += index<<1; 
    i2c_init();
    PORTB.4 = 1;  
    eeprom_write(devID,(unsigned char     *   )0,scroll_type);
    eeprom_write(devID,(unsigned char     *   )1,scroll_rate);   
    PORTB.4 = 0; 
    PORTD = 0x00;
    DDRD = 0x3F;   
}
void SaveTextLength(unsigned int length, unsigned char      index)
{
    unsigned char      devID = 0xA0;
    devID += index<<1; 
    i2c_init();
    PORTB.4 = 1;   
    eeprom_write_w(devID, (unsigned char     *   )2,length); 
    eeprom_write_w(devID, (unsigned char     *   )4,char_count); 
    PORTB.4 = 0;
    PORTD = 0x00;
    DDRD = 0x3F;        
}
void BlankRAM(unsigned char     *    start_addr,unsigned char     *    end_addr)
{        
    unsigned char     *    temp = 0x500    ;
    for (temp = start_addr; temp<= end_addr; temp++)    
        *temp = 0xFF;             
}
void SetRTCDateTime()
{
    i2c_init();
    PORTB.4 = 0;   
    rtc_set_time(0,0,0);    /* clear CH bit */
    rtc_set_date(getchar(),getchar(),getchar());
    rtc_set_time(getchar(),getchar(),getchar());    
    PORTB.4 = 1;
    PORTD = 0x00;
    DDRD = 0x3F; 
}
static void TextFromFont(char *szText, unsigned char      nColor, unsigned char      bGradient, unsigned char     *    pBuffer, unsigned char      index)
{
	int pos = 0,x=0,y=0;     
	unsigned char      i =0, len;
	unsigned char      ch = 0;
	unsigned int nWidth = 0;   
	unsigned int nCurWidth = 0, nNxtWidth = 0;		
    unsigned char      mask = 0x00, data = 0;
	unsigned char      mask_clr[2] = {0x00};
    unsigned char      devID = 0xA0;
    devID += index<<1; 
    		switch (nColor)
	{
	case 0:
		mask = 0xFF;		// BLANK
		mask_clr[0] = 0xFF;
		mask_clr[1] = 0xFF;
		break;
	case 1:
		mask = 0xAA;		// RED			RRRR	
		mask_clr[0] = 0x99;	// GREEN		RGRG
		mask_clr[1] = 0x88;	// YELLOW		RYRY
		break;
	case 2:
		mask = 0x55;		// GREEN		GGGG
		mask_clr[0] = 0x44;	// YELLOW		GYGY
		mask_clr[1] = 0x66;	// RED			GRGR	
		break;
	case 3:
		mask = 0x00;		// YELLOW		YYYY
		mask_clr[0] = 0x22;	// RED			YRYR	
		mask_clr[1] = 0x11;	// GREEN		YGYG
		break;
	default:
		break;
	}	
                           	PORTB.4 = 0;
	i2c_init();
	len = strlen(szText);
	for (i=0; i< len; i++){				                                     
        ch = szText[i];             
		nCurWidth = char_width[ch];
		nNxtWidth = char_width[ch+1];    		
		nWidth = (nNxtWidth - nCurWidth); 		
		if ((pos + nWidth) >= (3936 -144)	)  break;		
		for (y=0; y< 8 ; y++){    		            
		    if (bGradient) {
				if (y >=0 && y <4)	mask = mask_clr[0];
				if (y >=4 && y <8)	mask = mask_clr[1];	
			}			
			for (x=0; x< nWidth; x++){                                 
			    #asm("WDR");;       
			    data = eeprom_read(devID, (unsigned char     *   )((0x500        + 144*8)    + 144 + y*(3936 -144)	 + nCurWidth + x));
			    data = (~data) & (~mask); 
   				pBuffer[y*(3936 -144)	 + x + pos] = ~data;   				
			}					
		}
		pos += nWidth;	 		
	}	                           
        text_length = pos;    
    PORTB.4 = 1;
    PORTD = 0x00;
    DDRD = 0x3F;     
}
void LoadFrame()
{  
    is_stopping = 0;
    stopping_count = 0;
    if (++frame_index >= 4){
        frame_index = 0;
    }                   
    _powerOff();
        LoadConfig(frame_index);              
    BlankRAM((unsigned char     *   )0x500    ,(unsigned char     *   )0x7FFF);
    GetCharWidth(char_count,frame_index);                               
    if (scroll_type != 8){
        LoadToRAM((unsigned char     *   )0x500       ,144,1,frame_index);    	 
        LoadToRAM((unsigned char     *   )(0x500        + 144*8)    + 144,text_length,0,frame_index);    
    }
    switch (scroll_type)
    {
    case 1: 
        {
            char_index = 0;
            start_mem = (unsigned char     *   )(0x500        + 144*8)   ;        
        }
        break;   
    case 3      :     
        is_show_bkgnd = 1;
    case 2:          
    case 0:            
    case 4:
        {
            char_index = 0xFF;                     
            start_mem = (unsigned char     *   )(0x500        + 144*8)   ;        
        }
        break;     
    case 5       :
        {
            is_half_above = 0;
            is_half_below = 1;
            char_index = 0xFF; 
            horiz_idx  = 16;
            start_mem = (unsigned char     *   )(0x500        + 144*8)    + 144;
        }
        break;   
    case 6:                                                       
        {
            is_half_above = 1;
            is_half_below = 0;                             
            char_index = 0xFF;        
            horiz_idx  = 16;
            start_mem = (unsigned char     *   )(0x500        + 144*8)    + 144;        
        }
        break;         
        case 7:            
        {
            is_half_above = 1;
            is_half_below = 0;                             
            char_index = 0xFF;        
            horiz_idx  = 16;
            start_mem = (unsigned char     *   )(0x500        + 144*8)   ;                
        }
        break;
    case 8:
        {        
            int temp=0;                                                                                    
            unsigned char      hh=0,mm=0,ss=0;
            unsigned char      DD=0,MM=0,YY=00;
            i2c_init();                           
            rtc_get_date(&DD,&MM,&YY);
            rtc_get_time(&hh,&mm,&ss);                                                                                                                  
                                                                                                        getLunarStr(szDateStr,hh,mm,DD,MM,2000+YY);                                      
                    BlankRAM((unsigned char     *   )0x500    ,(unsigned char     *   )0x7FFF);
            TextFromFont(szDateStr, 1, 0, (unsigned char     *   )(0x500        + 144*8)    + 144, frame_index);
            char_index = 0xFF;      
                                                                                        start_mem = (unsigned char     *   )(0x500        + 144*8)   ;                            
                }
        break;         
    default:        
        break;
    }       
    reset_serial();    
    current_char_width = char_width[char_index];
    next_char_width = char_width[char_index+1];
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
DDRA=0x00;
PORTB=0x00;
DDRB=0xFF;
PORTC=0x00;
DDRC=0x00;
PORTD = 0x00;
DDRD = 0x00;
PORTE=0x00;
DDRE=0x05;
TCCR0=0x03; 
TCNT0=0x05; 
OCR0=0x00;  
UCSR0A=0x00;
UCSR0B=0x98;
UCSR0C=0x86;
UBRR0H=0x00;
UBRR0L=0x67;
MCUCR=0x80;
EMCUCR=0x00;     
TIMSK=0x02;
(*(unsigned char *) 0x7d)=0x00;
// I2C Bus initialization
i2c_init();
// DS1307 Real Time Clock initialization
// Square wave output on pin SQW/OUT: Off
// SQW/OUT pin state: 1
rtc_init(0,0,1);   
WDTCR=0x1F;
WDTCR=0x0F;
    printf("LCMS v2.02 Designed by CuongQuay\r\n");  
    printf("cuong3ihut@yahoo.com - 0915651001\r\n");
    printf("Release date: 09.01.2007\r\n");
                }
void PowerReset()
{   
    start_mem = (unsigned char     *   )(0x500        + 144*8)   ;     
    end_mem   = (unsigned char     *   )0x7FFF;
    bkgnd_mem = (unsigned char     *   )0x500       ;
    org_mem   = (unsigned char     *   )(0x500        + 144*8)   ;	                   
    InitDevice();
                         PORTB.4 = 0;
    BlankRAM((unsigned char     *   )0x500    ,(unsigned char     *   )0x7FFF);    
    delay_ms(500);
    PORTB.4 = 1;
        current_char_width = 0xFFFF;
    next_char_width = 0xFFFF;	 
        PORTB.4 = 0;  
    frame_index = 0; 
    LoadFrame();        
    PORTB.4 = 1;             
                           // reload configuration
    PORTB.4 = 0;
    delay_ms(100);
    PORTB.4 = 1;  
    PORTD = 0x00;
    DDRD = 0x3F;      
}
void ProcessCommand()
{
   	#asm("cli"); 
    #asm("WDR");;
    // Turn off the scan board           
    _powerOff();
    // serial message processing     
    switch (rx_message)
    {                  
    case 1 :
        {
            if (rx_wparam > (3936 -144)	) rx_wparam = (3936 -144)	;
            BlankRAM((unsigned char     *   )(0x500        + 144*8)   ,(unsigned char     *   )0x7FFF);
            frame_index = rx_lparam>>8;                       
            char_count  = rx_lparam&0x00FF;                   
            text_length = rx_wparam;   
            SerialToRAM((unsigned char     *   )(0x500        + 144*8)    + 144,text_length,0);                
            LoadCharWidth(char_count);                                                              
			start_mem = (unsigned char     *   )(0x500        + 144*8)    + 144;				
	    	bkgnd_mem = (unsigned char     *   )0x500       ;		    		    		    	
            SaveCharWidth(char_count,frame_index);                           
            SaveTextLength(text_length,frame_index);
            SaveToEEPROM((unsigned char     *   )(0x500        + 144*8)   ,0,frame_index);            
            current_char_width = next_char_width = 0xFFFF;								  
        }				
        break;
    case 2                                       :
        {
            if (rx_wparam > 144) rx_wparam = 144;
            frame_index = rx_lparam>>8;  
            BlankRAM((unsigned char     *   )0x500       ,(unsigned char     *   )(0x500        + 144*8)   );                    
            SerialToRAM((unsigned char     *   )0x500       ,rx_wparam,1);                                               
		    start_mem = (unsigned char     *   )(0x500        + 144*8)    + 144;				
		    bkgnd_mem = (unsigned char     *   )0x500       ;	
		    		    SaveToEEPROM((unsigned char     *   )0x500       ,1,frame_index);			    
		}
        break; 
    case 5:
        {    
            frame_index = rx_lparam>>8;
            scroll_type  = rx_wparam&0x00FF;
            scroll_rate = rx_wparam>>8;             
            SaveConfig(frame_index);
        }
        break;   
    case 4:
        {                                
            SetRTCDateTime();
        }
        break;    
    default:
        break;
    }                 
    send_echo_msg();            
    rx_message = 0    ;
    #asm("sei");
    PORTD = 0x00;
    DDRD = 0x3F;     
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
            _doScroll();
            _displayFrame();         
        }
        #asm("WDR");;
    }
}
                         