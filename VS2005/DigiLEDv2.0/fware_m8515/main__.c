/*****************************************************
This program was produced by the
CodeWizardAVR V1.24.6 Professional
Automatic Program Generator
� Copyright 1998-2005 Pavel Haiduc, HP InfoTech s.r.l.
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

#include "define.h"      

// 1 Wire Bus functions
#asm
   .equ __w1_port=0x12 ;PORTD
   .equ __w1_bit=5
#endasm
#include <1wire.h>
// DS1820 Temperature Sensor functions
#include <ds18b20.h>
// DS1307 Real Time Clock functions
#include <ds1307.h>
                                      
// Declare your global variables here     
static PBYTE start_mem;
static PBYTE end_mem;        
static PBYTE buffer; 
static PBYTE org_mem;

bit is_power_off         = 0;     

register UINT count_row  = 0;
register UINT count_col  = 0;     

static BYTE scroll_rate   = 0; 
static BYTE page_index   = 0;                                 

static UINT  tick_count  = 0;      
static UINT  text_length = 0;
//static UINT  char_width[256];    

flash char  szText[] = "** CuongQuay 0915651001 **";    
static char szTitle[MAX_PAGE][MAX_TITLE]={
"TO CHUC KINH TE    ",
"DAN CU GUI GOP     ",
"DAN CU BAC THANG   ",
"DAN CU DU THUONG   ",
"DAN CU THONG THUONG"
};                               

BYTE _xtable[]= {
                0x11,0x9F,0x32,0x16,0x9C,0x54,0x50,0x1F,
                0x10,0x14,0xFE,0xEF,0xFF,0xFF,0xFF,0xFF
                };                                 

// Global variables for message control
BYTE  rx_message = UNKNOWN_MSG;
WORD  rx_wparam  = 0;
WORD  rx_lparam  = 0;
// [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
                            
extern void reset_serial();         
extern void send_echo_msg();    
extern BYTE eeprom_read(BYTE deviceID, PBYTE address);
extern void eeprom_write(BYTE deviceID, PBYTE address, BYTE data);
extern WORD eeprom_read_w(BYTE deviceID, PBYTE address);
extern void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data);
extern void eeprom_write_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size);
extern void eeprom_read_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size);

static void _displayFrame();
static void _displayLED();
static void _doPaging(); 
                                                                                 
void LoadPage();                  
void GetRTCBuffer();      
void FormatRTC(PBYTE pBuffer, UINT nBuffSize);
void BlankRAM(PBYTE start_addr,PBYTE end_addr);
///////////////////////////////////////////////////////////////
// Timer 0 overflow interrupt service routine , 40.5 us per tick                 
///////////////////////////////////////////////////////////////
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{       
    TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
    ++tick_count;    
}

#define RESET_WATCHDOG()    #asm("WDR");
///////////////////////////////////////////////////////////////
// static function(s) for led matrix display panel
///////////////////////////////////////////////////////////////
static void _setRow()
{
    BYTE i=0;      
    for (i=0; i<8; i++){            
        if (i==(7-count_row)) SCAN_DAT = ON;        
        else SCAN_DAT = OFF;        
        SCAN_CLK = 1;
        SCAN_CLK = 0;            
    }
}
            
static void _powerOff()
{
    BYTE i =0;               
    SCAN_DAT = OFF;  // data scan low        
    for (i=0; i< 8; i++)    
    {                                              
        SCAN_CLK = 1;    // clock scan high
        SCAN_CLK = 0;    // clock scan low            
    }                                         
    SCAN_STB = 1;    // strobe scan high
    SCAN_STB = 0;    // strobe scan low                    
}
#define _DELAY_BUS      1
static void _displayLED()
{                                  
    UINT i=0;        
    BYTE data[6];
    BYTE mask=0,k=0;       
    PBYTE buffer =(PBYTE)START_RAM+SCREEN_WIDTH;
    CTRL_CLK = 0;
    CTRL_STB = 0;
    for (i=0; i< 60; i++){      
        mask = 0x01;
#ifdef __TEST_LED_        
        data[0] = _xtable[i%(page_index+1)];
        data[1] = data[0];
        data[2] = data[0];
        data[3] = data[0];
        data[4] = data[0];
        data[5] = data[0];
#else                                     
        data[0] = buffer[60 -i-1];       
        data[1] = buffer[120-i-1];
        data[2] = buffer[180-i-1];
        data[3] = buffer[240-i-1];
        data[4] = buffer[300-i-1];
        data[5] = buffer[360-i-1];        
#endif        
        for (k=0; k< 8; k++){
            if ((data[0]&mask)>>(k)){
                DATA_01 = 1;delay_us(_DELAY_BUS);
            }
            else{
                DATA_01 = 0;delay_us(_DELAY_BUS);
            }    
            
            if ((data[1]&mask)>>(k)){
                DATA_02 = 1;delay_us(_DELAY_BUS);
            }
            else{
                DATA_02 = 0;delay_us(_DELAY_BUS);
            }
            
            if ((data[2]&mask)>>(k)){
                DATA_03 = 1;delay_us(_DELAY_BUS);
            }
            else{
                DATA_03 = 0;delay_us(_DELAY_BUS);
            }
            
            if ((data[3]&mask)>>(k)){
                DATA_04 = 1;delay_us(_DELAY_BUS);
            }
            else{
                DATA_04 = 0;delay_us(_DELAY_BUS);
            }
            
            if ((data[4]&mask)>>(k)){
                DATA_05 = 1;delay_us(_DELAY_BUS);
            }
            else{
                DATA_05 = 0;delay_us(_DELAY_BUS);
            }
                      
            if ((data[5]&mask)>>(k)){
                DATA_06 = 1;delay_us(_DELAY_BUS);
            }
            else{
                DATA_06 = 0;delay_us(_DELAY_BUS);
            }
            
            CTRL_CLK = 1;delay_us(_DELAY_BUS);
            CTRL_CLK = 0;delay_us(_DELAY_BUS);        
            mask = mask<<1;  
        }                   
        RESET_WATCHDOG();
    }	             
    CTRL_STB = 1;delay_us(_DELAY_BUS);
    CTRL_STB = 0;delay_us(_DELAY_BUS);
}        

static void _displayFrame()
{                 
    BYTE data = 0;  
    count_col = 0;
    count_row = 0;         

    if (is_power_off ==1){
        _powerOff();
        return;
    }
    // display one frame in the screen at the specific time 
    for (buffer = start_mem;buffer < (END_RAM); buffer++)  
    {                     
        data = (*buffer);
        #ifdef ENABLE_MASK_ROW  
        data &= ENABLE_MASK_ROW;
        #endif //ENABLE_MASK_ROW
        DATA_BIT = (data&0x01);
        
        DATA_CLK = 1;    // clock high
        DATA_CLK = 0;    // clock low   
        if ( ++count_col >= SCREEN_WIDTH)
        {                                            
            count_col = 0;      // reset for next                                                                                                                       
            _powerOff();        // turn all led off            
            
            SCAN_STB = 0;       // strobe low   
            _setRow();          // turn row-led on                                                              
            SCAN_STB = 1;       // strobe high            
                 
            DATA_STB = 1;       // strobe high            
            DATA_STB = 0;       // strobe low            
                        
            if (++count_row >= 8){ 
                count_row = 0;
            }                                                                                         
            buffer += (DATA_LENGTH - SCREEN_WIDTH);                 
        }                   
    }                         	
}     
                                  
static void _doPaging()
{
    // init state                         
    DATA_STB = 0;
    DATA_CLK = 0;               
    // scroll left with shift_step bit(s)
    if(tick_count >= 1000){   
        tick_count = 0; 
        if (scroll_rate >0){           
            scroll_rate--;             
        }
        else{                                 
            LoadPage();                        
        }
    }        
}                 

                                          
////////////////////////////////////////////////////////////////////
// General functions
//////////////////////////////////////////////////////////////////// 
BYTE GetLocalTime(BYTE hh, int offset)
{                          
    int lval= 0;
    if (offset){       
        lval = (int)hh+offset;    
        if (lval >= 24){
            lval = lval%24;
        }            
        if (lval <0){
            lval = 24 + lval;
        }
    }               
    else{
        lval = hh;
    }    
    return (BYTE)lval;
}                                    

void GetRTCBuffer()
{
    UINT nBuffSize =34;
    BYTE pBuffer[34];              
    BYTE hh=0,mm=0,ss=0,DD=0,MM=0,YY=0;  
    i2c_init();   
    rtc_get_date(&DD,&MM,&YY);
    rtc_get_time(&hh,&mm,&ss);                              
#ifdef __DUMP_LED_    
    printf("GMT: %02d:%02d:%02d %02d-%02d-%02d\r\n",hh,mm,ss,DD,MM+1,YY);              
#endif    
    if (DD> 99) DD =0;if (MM> 99) MM =0;if (YY> 99) YY =0;
    if (hh> 99) hh =0;if (mm> 99) mm =0;if (ss> 99) ss =0;                    
    sprintf(pBuffer,    "%02d-%02d-%4d"\
                        "%02d%02d"\
                        "%02d%02d"\
                        "%02d%02d"\
                        "%02d%02d"\
                        "%02d%02d"\
                        "%02d%02d",              
                        DD,MM+1,2000+YY,                                  
                        GetLocalTime(hh,+7),mm,     // HANOI
                        GetLocalTime(hh,-6),mm,     // NEWYORK
                        GetLocalTime(hh,+1),mm,     // PARIS
                        GetLocalTime(hh,+0),mm,     // LONDON
                        GetLocalTime(hh,+3),mm,     // MOSCOW
                        GetLocalTime(hh,+8),mm      // BELJING                        
                        );           
#ifdef __DUMP_LED_    
    printf("%s \r\n",pBuffer);
#endif    
    FormatRTC(pBuffer,nBuffSize);   
    PORTD = 0x00;
    DDRD = 0x3F;  
}

void FormatRTC(PBYTE pBuffer, UINT nBuffSize)
{                                                  
    UINT i =0;
    BYTE code = 0;                                 
    PBYTE pBuffOut =(PBYTE)START_RAM + SCREEN_WIDTH;                    
	for (i=0; i< nBuffSize; i++){		
		code = pBuffer[nBuffSize- i-1];		
		if (code >='0' && code <='9'){
			code = code & 0x0F;
		}
		else if (code ==' '){
			code = 0x0F;	// blank
		}
		else if (code =='-'){
			code = 0x0A;	// dash
		}
		else if (code =='.'){
			code = 0x0B;	// dot
		}
		else{
			code = 0x0F;	// blank	
		}
		pBuffOut[i] = _xtable[code];
	}
}

void SerialToRAM(PBYTE address,WORD length)                                             
{
    PBYTE temp = 0;          
    UINT i =0;     				
    temp   = (PBYTE)address;    
    LED_STATUS = 0;
    for (i =0; i< length; i++) {
        *temp++ = getchar();
        RESET_WATCHDOG();
    }                               
    LED_STATUS = 1;
}

void GetCharWidth(WORD length)
{                               
    UINT i =0;   
    BYTE devID = EEPROM_DEVICE_FONT;
    PBYTE base  = 0x0A;
    i2c_init();
    LED_STATUS = 0;              

    for (i =0; i < length; i++)
    {                           
        //char_width[i] = eeprom_read_w(devID,(PBYTE)base+(i<<1));    
        RESET_WATCHDOG();
    }                      
    LED_STATUS = 1;
    PORTD = 0x00;
    DDRD = 0x3F; 
}

void SaveToEEPROM(PBYTE address, WORD length, BYTE index)
{                             
    PBYTE temp = 0; 
    UINT i =0;     
    BYTE devID = EEPROM_DEVICE_DATA;      				
    temp   = address;   
    if (length%EEPROM_PAGE){
        length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
    }                         
    i2c_init();
    LED_STATUS = 0;         
    for (i=0; i < length; i++) {           
        eeprom_write( devID, (PBYTE)temp+ index*PAGE_SIZE, (BYTE)(*temp));	                             
        RESET_WATCHDOG();                                                       
        temp++;
    }                       
    LED_STATUS = 1;
    PORTD = 0x00;
    DDRD = 0x3F;    
}
                      
void LoadToRAM(PBYTE address, WORD length, BYTE index)
{                         
    PBYTE temp = 0;  
    UINT i=0;         
    BYTE devID = EEPROM_DEVICE_DATA;		
    temp   = address;                     
    if (length > DATA_LENGTH)    
        return; // invalid param
    if (length%EEPROM_PAGE){
        length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
    }
    i2c_init();
    LED_STATUS = 0;             
    for (i =0; i <length; i+= EEPROM_PAGE) {                                 
        eeprom_read_page( devID, (PBYTE)temp+ index*PAGE_SIZE, temp, EEPROM_PAGE );        
        temp += EEPROM_PAGE;                                
        RESET_WATCHDOG();     
    }   
    LED_STATUS = 1; 
    PORTD = 0x00;
    DDRD = 0x3F;  
}

void LoadConfig(BYTE index)
{   
    BYTE devID = EEPROM_DEVICE_DATA;
    i2c_init();
    LED_STATUS = 1;                               
    scroll_rate = eeprom_read(devID,(PBYTE)index);     
#ifdef __TEST_LED_
    scroll_rate = 10;
#endif
#ifdef __DUMP_LED_
    printf("line=%d rate=%d\r\n",index,scroll_rate);    
#endif
    LED_STATUS = 0; 
    PORTD = 0x00;
    DDRD = 0x3F;   
}

void SaveConfig(BYTE index)
{     
    BYTE devID = EEPROM_DEVICE_DATA;
    i2c_init();
    LED_STATUS = 1;  
    eeprom_write(devID,(PBYTE)index,scroll_rate);   
    LED_STATUS = 0; 
    PORTD = 0x00;
    DDRD = 0x3F;   
}

void BlankRAM(PBYTE start_addr,PBYTE end_addr)
{        
    PBYTE temp = START_RAM;
    for (temp = start_addr; temp<= end_addr; temp++)    
        *temp = 0xFF;             
}

void SetRTCDateTime()
{
    i2c_init();
    LED_STATUS = 0;   
    rtc_set_time(0,0,0);    /* clear CH bit */
    rtc_set_date(getchar(),getchar(),getchar());
    rtc_set_time(getchar(),getchar(),getchar());    
    LED_STATUS = 1;
    PORTD = 0x00;
    DDRD = 0x3F; 
}

static void TextFromFont(char *szText, BYTE nColor, BYTE bGradient, PBYTE pBuffer, BYTE index)
{
	int pos = 0,x=0,y=0;     
	BYTE i =0, len;
	BYTE ch = 0;
	UINT nWidth = 0;   
	UINT nCurWidth = 0, nNxtWidth = 0;		
    BYTE mask = 0x00, data = 0;
	BYTE mask_clr[2] = {0x00};
    BYTE devID = EEPROM_DEVICE_FONT;
    	
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
                               
	LED_STATUS = 0;
	i2c_init();
	len = strlen(szText);      
	if (len > MAX_TITLE){
	    len = MAX_TITLE;
	}
	for (i=0; i< len; i++){				                                     
        ch = szText[i];             
		//nCurWidth = char_width[ch];
		//nNxtWidth = char_width[ch+1];    		
		nCurWidth = eeprom_read_w(devID,(PBYTE)0x0A+(ch<<1));    
		nNxtWidth = eeprom_read_w(devID,(PBYTE)0x0A+((ch+1)<<1));    
		nWidth = (nNxtWidth - nCurWidth); 		
		if ((pos + nWidth) >= SCREEN_WIDTH)  break;		
		for (y=0; y< 8 ; y++){    		            
		    if (bGradient) {
				if (y >=0 && y <4)	mask = mask_clr[0];
				if (y >=4 && y <8)	mask = mask_clr[1];	
			}			
			for (x=0; x< nWidth; x++){                                 
			    RESET_WATCHDOG();       
			    data = eeprom_read(devID, (PBYTE)(START_RAM + 8*SCREEN_WIDTH + SCREEN_WIDTH) + (y*DATA_LENGTH + nCurWidth + x));
			    data = (~data) & (~mask); 
   				pBuffer[y*DATA_LENGTH + x + pos] = ~data;   				
			}					
		}
		pos += nWidth;	 		
	}
    
    text_length = pos;    
    LED_STATUS = 1;
    PORTD = 0x00;
    DDRD = 0x3F;     
}
        
void LoadPage()
{                         
    if (++page_index >= MAX_PAGE){
        page_index = 0;
    }                   
    _powerOff();          
    LoadConfig(page_index);       
    if (scroll_rate ==0){
        return;
    } 
    BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);                
    LoadToRAM((PBYTE)START_RAM+SCREEN_WIDTH,PAGE_SIZE,page_index);                 
    GetCharWidth(255);                                            
#ifndef __OWN_TITLE_
    TextFromFont((char*)szTitle[page_index],1,0,(PBYTE)START_RAM,0);
#else
    TextFromFont((char*)(START_RAM+SCREEN_WIDTH+MAX_LED),1,0,(PBYTE)START_RAM,0);     
#endif                                                  
    GetRTCBuffer();
    _displayLED();                  
        
#ifdef __DUMP_LED_     
{         
    UINT i=0;
    PBYTE temp = 0;
    temp   =(PBYTE)START_RAM+SCREEN_WIDTH;
    for (i =0; i <MAX_LED; i++) {
        printf("%02X ",*temp);
        temp++;
    }               
    printf("%s \r\n",(char*)(START_RAM+SCREEN_WIDTH+MAX_LED));
}
#endif 
    start_mem = (PBYTE)START_RAM;
    reset_serial();    
}

///////////////////////////////////////////////////////////////
// END static function(s)
///////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////           

void InitDevice()
{
// Declare your local variables here
// Crystal Oscillator division factor: 1  
#ifdef _MEGA162_INCLUDED_ 
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif                    
#endif

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

UCSRA=0x00;
UCSRB=0x98;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x67;

MCUCR=0x80;
EMCUCR=0x00;     

TIMSK=0x02;

// I2C Bus initialization
i2c_init();

// DS1307 Real Time Clock initialization
// Square wave output on pin SQW/OUT: Off
// SQW/OUT pin state: 1
rtc_init(0,0,1);   

#ifdef __WATCH_DOG_
//WDTCR=0x1F;
//WDTCR=0x0F;
#endif 
    printf("                                          \r\n");
    printf("|=========================================|\r\n");
    printf("|      DigiLED AVR Firmware v1.0.0        |\r\n");
    printf("|_________________________________________|\r\n");
    printf("|        Copyright by CuongQuay           |\r\n");  
    printf("|    cuong3ihut@yahoo.com - 0915651001    |\r\n");
    printf("|       Started date: 24.05.2007          |\r\n");
    printf("|       Release date: 23.06.2007          |\r\n");
    printf("|_________________________________________|\r\n");              
    printf("                                          \r\n");    
    RESET_WATCHDOG();
#ifdef __TEST_RTC_
{                                
    BYTE hh=0,mm=0,ss=0,DD=0,MM=0,YY=0;
    rtc_get_date(&DD,&MM,&YY);
    rtc_get_time(&hh,&mm,&ss);
    printf("DS1307 GMT: %02d:%02d:%02d %02d-%02d-%02d\r\n",hh,mm,ss,DD,MM,YY);
}           
#endif    
    RESET_WATCHDOG();               
}

void PowerReset()
{   
    start_mem = (PBYTE)START_RAM;     
    end_mem   = (PBYTE)END_RAM;
    org_mem   = (PBYTE)START_RAM;	                   

    InitDevice();
                     
    LED_STATUS = 0;
    BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);    
    delay_ms(500);
    LED_STATUS = 1;
        
    LED_STATUS = 0;  
    page_index = 0; 
    LoadPage();        
    LED_STATUS = 1;             
                       
    // reload configuration
    LED_STATUS = 0;
    delay_ms(100);
    LED_STATUS = 1;  
    PORTD = 0x00;
    DDRD = 0x3F;      
}

void ProcessCommand()
{
   	#asm("cli"); 
    RESET_WATCHDOG();
    // Turn off the scan board           
    _powerOff();
    // serial message processing     
    switch (rx_message)
    {                  
    case LOAD_DATA_MSG:
        {       
            if (rx_wparam > DATA_LENGTH) rx_wparam = DATA_LENGTH;
            BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
            page_index = rx_wparam>>8; 
            scroll_rate = rx_wparam&0x00FF;                                   
            text_length = rx_lparam;                     
            SerialToRAM((PBYTE)START_RAM+SCREEN_WIDTH,text_length);                
            start_mem = (PBYTE)START_RAM;
            SaveConfig(page_index);					    		    		    	
            SaveToEEPROM((PBYTE)START_RAM+SCREEN_WIDTH,PAGE_SIZE,page_index);            
        }				
        break;   
    case LOAD_CONFIG_MSG:
        {    
            page_index = rx_wparam>>8;
            scroll_rate = rx_wparam&0x00FF;             
            SaveConfig(page_index);
        }
        break;       
    case SET_RTC_MSG:
        {                                
            SetRTCDateTime();
        }
        break;    
    default:
        break;
    }                 
    send_echo_msg();            
    rx_message = UNKNOWN_MSG;
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
        if (rx_message != UNKNOWN_MSG){   
            ProcessCommand();   
        }
        else{               
            _doPaging();
            _displayFrame();                        
        }
        RESET_WATCHDOG();
    }
}
                         
#include "define.h"

///////////////////////////////////////////////////////////////
// serial interrupt handle - processing serial message ...
///////////////////////////////////////////////////////////////
// [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
///////////////////////////////////////////////////////////////
BYTE rx_buffer[RX_BUFFER_SIZE];
extern BYTE  rx_message;
extern WORD  rx_wparam;
extern WORD  rx_lparam;

#if RX_BUFFER_SIZE<256
unsigned char rx_wr_index,rx_counter;
#else
unsigned int rx_wr_index,rx_counter;
#endif

void send_echo_msg();

// USART Receiver interrupt service routine
#ifdef _MEGA162_INCLUDED_                    
interrupt [USART0_RXC] void usart_rx_isr(void)
#else
interrupt [USART_RXC] void usart_rx_isr(void)
#endif
{
char status,data;
#ifdef _MEGA162_INCLUDED_  
status=UCSR0A;
data=UDR0;
#else     
status=UCSRA;
data=UDR;
#endif          
    if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
    {
        rx_buffer[rx_wr_index]=data; 
        if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
        if (++rx_counter == RX_BUFFER_SIZE)
        {
            rx_counter=0;
            if (
                rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
                rx_buffer[2]==WAKEUP_CHAR 
                )
            {
                rx_message  = rx_buffer[3];    // message value 
                rx_wparam   = rx_buffer[4];    // wparam value
                rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
                rx_lparam   = rx_buffer[6];    // lparam value
                rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
            }
            else if(
                rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
                rx_buffer[2]==ESCAPE_CHAR 
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
    putchar(WAKEUP_CHAR);
    putchar(WAKEUP_CHAR);
    putchar(WAKEUP_CHAR);                
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
    rx_message = UNKNOWN_MSG;
}

///////////////////////////////////////////////////////////////
// END serial interrupt handle
/////////////////////////////////////////////////////////////// 
/*****************************************************
This program was produced by the
CodeWizardAVR V1.24.4a Standard
Automatic Program Generator
� Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
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

#include "define.h"                                           

#define     ACK                 1
#define     NO_ACK              0

// I2C Bus functions
#asm
   .equ __i2c_port=0x12 ;PORTD
   .equ __sda_bit=3
   .equ __scl_bit=2
#endasm                   

#ifdef __EEPROM_WRITE_BYTE
BYTE eeprom_read(BYTE deviceID, PBYTE address) 
{
    BYTE data;
    i2c_start();
    i2c_write(deviceID);        // issued R/W = 0
    i2c_write((WORD)address>>8);      // high word address
    i2c_write((WORD)address&0x0FF);   // low word address
    
    i2c_start();
    i2c_write(deviceID | 1);    // issued R/W = 1
    data=i2c_read(NO_ACK);      // read at current
    i2c_stop();
    return data;
}

void eeprom_write(BYTE deviceID, PBYTE address, BYTE data) 
{
    i2c_start();
    i2c_write(deviceID);        // device address
    i2c_write((WORD)address>>8);      // high word address
    i2c_write((WORD)address&0x0FF);   // low word address
    i2c_write(data);
    i2c_stop();

    /* 10ms delay to complete the write operation */
    delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
}                                 

WORD eeprom_read_w(BYTE deviceID, PBYTE address)
{
    WORD result = 0;
    result = eeprom_read(deviceID,address);
    result = (result<<8) | eeprom_read(deviceID,address+1);
    return result;
}
void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data)
{
    eeprom_write(deviceID,address,data>>8);
    eeprom_write(deviceID,address+1,data&0x0FF);    
}

#endif // __EEPROM_WRITE_BYTE
void eeprom_read_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
{
    BYTE i = 0;
    i2c_start();
    i2c_write(deviceID);            // issued R/W = 0
    i2c_write((WORD)address>>8);          // high word address
    i2c_write((WORD)address&0xFF);        // low word address
    
    i2c_start();
    i2c_write(deviceID | 1);        // issued R/W = 1
                                    
    while ( i < page_size-1 )
    {
        buffer[i++] = i2c_read(ACK);   // read at current
    }
    buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
         
    i2c_stop();
}

void eeprom_write_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
{
    BYTE i = 0;
    i2c_start();
    i2c_write(deviceID);            // issued R/W = 0
    i2c_write((WORD)address>>8);          // high word address
    i2c_write((WORD)address&0xFF);        // low word address
                                        
    while ( i < page_size )
    {
        i2c_write(buffer[i++]);
        #asm("nop");#asm("nop");
    }          
    i2c_stop(); 
    delay_ms(10);
}
                                              
