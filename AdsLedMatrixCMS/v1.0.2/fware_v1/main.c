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

#include "define.h"      

// DS1307 Real Time Clock functions
#include <ds1307.h>
                                      
// Declare your global variables here     
static PBYTE start_mem;
static PBYTE end_mem;        
static PBYTE buffer; 
static PBYTE bkgnd_mem;     
static PBYTE org_mem;

bit is_show_bkgnd        = 0;
bit is_flipping_bk       = 0;

register UINT count_row  = 0;
register UINT count_col  = 0;     
static BYTE frm_delay    = 0;
static BYTE shift_rate   = 0; 
static BYTE shift_step   = 0;     
static BYTE sys_mode     = 0;    

static UINT  tick_count  = 0;
static UINT  count_shift = 0;       
static UINT  char_count  = 0;
static UINT  text_length = 0;

static UINT  char_width[256];    
static UINT  columeH = 0;
static UINT  columeL = 0;
static UINT  char_index = 0;    
static UINT  next_char_width = 0;
static UINT  current_char_width = 0;  

static char  szText[] = "-= 3iGROUP :: HTTP://WWW.3IHUT.NET =-";                    

#pragma warn-                      
eeprom BYTE _cfg_frm_delay =100;
eeprom BYTE _cfg_sys_mode =MODE_POWER;
eeprom BYTE _cfg_shift_rate =20;
eeprom BYTE _cfg_shift_step =1;
eeprom UINT _save_text_length =0;   
eeprom UINT _save_char_width[250];       
#pragma warn+
                                   
/************************************/
/* short delay with nop instruction */
/************************************/
/* Crys 16Mhz, 1 cycle = 0.0625 u_sec
/* total: 9 cycle = 0.5625 us per call
_delay_ex:
	LDS  R30,_frm_delay_G1  ; 2 cycles
	SUBI R30,LOW(1)         ; 1 cycle
	STS  _frm_delay_G1,R30  ; 2 cycles
	CPI  R30,0              ; 1 cycle
	BRNE _delay_ex	        ; 1 cycle
**************************************/
#define _delay_ex(x) {\
    while(--x);\
}\

             
// Global variables for message control
BYTE  rx_message = UNKNOWN_MSG;
WORD  rx_wparam  = 0;
WORD  rx_lparam  = 0;
// [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
                            
extern void reset_serial();         
extern void send_echo_msg();    
extern BYTE eeprom_read(BYTE deviceID, WORD address);
extern void eeprom_write(BYTE deviceID, WORD address, BYTE data);
extern WORD eeprom_read_w(BYTE deviceID, WORD address);
extern void eeprom_write_w(BYTE deviceID, WORD address, WORD data);
extern void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
extern void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);

static void _displayFrame();
static void _doScroll();
///////////////////////////////////////////////////////////////
// Timer 0 overflow interrupt service routine , 40.5 us per tick                 
///////////////////////////////////////////////////////////////
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{       
    TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
    if (is_flipping_bk){
        ++tick_count;
    }
    count_shift++;
}


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

static void _displayFrame()
{                   
    count_col = 0;
    count_row = 0;         
         
    columeL = current_char_width + (START_RAM_TEXT + SCREEN_WIDTH) - start_mem;
    columeH = next_char_width + (START_RAM_TEXT + SCREEN_WIDTH) - start_mem;         	                                           

    // display one frame in the screen at the specific time 
    for (buffer = start_mem;buffer < (END_RAM); buffer++)  
    {                     
    #ifdef __FLYING_TEXT_
        if (current_char_width < SCREEN_WIDTH)
		{                                  		        
			if (count_col < current_char_width){				
				if (is_show_bkgnd){
                    DATA_PORT = org_mem[count_row*DATA_LENGTH + SCREEN_WIDTH + count_col]&
                            (bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);	
                }                               
                else{
                    DATA_PORT = org_mem[count_row*DATA_LENGTH + SCREEN_WIDTH + count_col];
                }
			}
			else if ((count_col > columeL) && (count_col < columeH)){				
				if (is_show_bkgnd){
				    DATA_PORT = (*buffer)&(bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);								
				}                                                    
				else{
				    DATA_PORT = (*buffer);
				}
			}
			else{                  
			    if (is_show_bkgnd){
    	    		DATA_PORT = (bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);                				
    	        }
    	        else{
    	            DATA_PORT = 0xFF;
    	        }
			}                                                               			
        #ifdef ENABLE_MASK_ROW  
            DATA_PORT |= ENABLE_MASK_ROW;
        #endif //ENABLE_MASK_ROW
        }
        else		 
   #endif
   	    {  
   	        if (is_show_bkgnd){           
                DATA_PORT = (*buffer)&(bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);
            }
            else{                    
                DATA_PORT = (*buffer);
            }                         
        }              

        DATA_CLK = 1;    // clock high
        DATA_CLK = 0;    // clock low   
        if ( ++count_col >= SCREEN_WIDTH)
        {                                            
            count_col = 0;      // reset for next            
            
#ifndef __ANTI_SHADOW_
            SCAN_CLK = 1;       // clock scan high
            SCAN_CLK = 0;       // clock scan low
                                                                          
            SCAN_STB = 1;       // strobe scan high
            DATA_STB = 1;       // strobe high            
            SCAN_STB = 0;       // strobe scan low
            DATA_STB = 0;       // strobe low                        
                
            SCAN_DAT = OFF;     // data scan low            
#else                      
                                                                                               
            _powerOff();        // turn all led off            
            _setRow();          // turn row-led on
                                                              
            SCAN_STB = 1;       // strobe high            
            SCAN_STB = 0;       // strobe low        
            DATA_STB = 1;       // strobe high            
            DATA_STB = 0;       // strobe low            
                        
#endif          
            if (++count_row >= 8)
            { 
                count_row = 0;
            #ifndef __ANTI_SHADOW_       
                SCAN_DAT = ON;                
                if ((sys_mode&MODE_POWER)==0){
                    SCAN_DAT = OFF;                                
                }                    
            #endif
            }                                                                 
                        
            buffer += (DATA_LENGTH - SCREEN_WIDTH);                 
        }           
    }                         	
}     
                                  
static void _doScroll()
{
    // init state                         
    DATA_STB = 0;
    DATA_CLK = 0;   
                        
    // check power off state ...
    if ((sys_mode & MODE_POWER)==0) {
        _powerOff();return;
    }
    if ((sys_mode & MODE_STOP)==MODE_STOP) return;
                        
    // scroll left with shift_step bit(s)
    if(count_shift >= shift_rate)
    {                             
        count_shift = 0;          
    #ifdef __FLYING_TEXT_
        if ((sys_mode&MASK_MODE)==FLYING_TEXT || (sys_mode&MASK_MODE)==ALL_IN_ONE)
        {
            if (current_char_width >= SCREEN_WIDTH)
    		{     		       
			   start_mem += shift_step;		
	    	}
		    else
		    if (is_flipping_bk==0)
		    {
			    start_mem += (SCREEN_WIDTH/20);
    			if (start_mem > (START_RAM_TEXT + SCREEN_WIDTH) - current_char_width)
	    		{
		    		char_index++;				 
			    	current_char_width = char_width[char_index];
				    next_char_width = char_width[char_index+1];				
    				start_mem = START_RAM_TEXT + current_char_width;
	    		}
		    }
        }
        else
    #endif //__FLYING_TEXT_
    #ifdef __SCROLL_TEXT_
        {
            start_mem += shift_step;
        } 
    #endif //__SCROLL_TEXT_      		
        if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length)          
        {   
        #ifdef __FLYING_TEXT_                                                                                      
            if ((sys_mode&MASK_MODE)==FLYING_TEXT || (sys_mode&MASK_MODE)==ALL_IN_ONE){                
                char_index = 0;              
                shift_rate = _cfg_shift_rate;
                shift_step = _cfg_shift_step;
                current_char_width = char_width[char_index];
    		    next_char_width = char_width[char_index+1];	  
                start_mem = START_RAM_TEXT;                    		    
            }    
        #ifndef __ALL_IN_ONE_
            else
        #endif //__ALL_IN_ONE_
        #endif //__FLYING_TEXT_
        #ifdef __FLIPPING_BK_  
            if ((sys_mode&MASK_MODE)==FLIPPING_BK || (sys_mode&MASK_MODE)==ALL_IN_ONE){                              
                if (tick_count <= MAX_SHOW_TIME){
                    is_show_bkgnd = 1;
                    is_flipping_bk = 1;
                    start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;                       
                }
                else
                if ((MAX_SHOW_TIME < tick_count) && (tick_count <= 5*MAX_SHOW_TIME/3)){
                    is_show_bkgnd = 0;
                    is_flipping_bk = 1;
                    start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
                }
                else
                if ((5*MAX_SHOW_TIME/3 < tick_count) && (tick_count <= 6*MAX_SHOW_TIME/3)){
                    is_show_bkgnd = 1;
                    is_flipping_bk = 1;
                    start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
                }
                else
                if ((6*MAX_SHOW_TIME/3 < tick_count) && (tick_count <= 7*MAX_SHOW_TIME/3)){
                    is_show_bkgnd = 0;
                    is_flipping_bk = 1;
                    start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
                }
                else
                if ((7*MAX_SHOW_TIME/3 < tick_count) && (tick_count <= 8*MAX_SHOW_TIME/3)){
                    is_show_bkgnd = 1;
                    is_flipping_bk = 1;
                    start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
                }
                else
                if ((8*MAX_SHOW_TIME/3 < tick_count) && (tick_count <= 9*MAX_SHOW_TIME/3)){
                    is_show_bkgnd = 0;
                    is_flipping_bk = 1;
                    start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
                }
                else
                if ((9*MAX_SHOW_TIME/3 < tick_count) && (tick_count <= 10*MAX_SHOW_TIME/3)){
                    is_show_bkgnd = 1;
                    is_flipping_bk = 1;
                    start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
                }     
                else{ 
                    tick_count = 0;
                    is_show_bkgnd = 0;
                    is_flipping_bk = 0;      
                    shift_rate = _cfg_shift_rate;
                    shift_step = _cfg_shift_step;
                    start_mem = START_RAM_TEXT;
                }
            }
            else
        #endif //__FLIPPING_BK_              
        #ifdef __ALWAY_BKGND_
            if ((sys_mode&MASK_MODE)==ALWAY_BKGND){   
                is_show_bkgnd = 1;  // alway show the bakgnd
                shift_rate = _cfg_shift_rate;
                shift_step = _cfg_shift_step;
                start_mem = START_RAM_TEXT;
            }
        #ifdef __SCROLL_TEXT_
            else                
        #endif //__SCROLL_TEXT_
        #endif //__ALWAY_BKGND_    
        #ifdef __SCROLL_TEXT_
            {                              
                is_show_bkgnd = 0;  // disable background
                shift_rate = _cfg_shift_rate;
                shift_step = _cfg_shift_step;
                start_mem = START_RAM_TEXT;
            }                   
        #endif //__SCROLL_TEXT_
        }
    }        

}          
////////////////////////////////////////////////////////////////////
// General functions
//////////////////////////////////////////////////////////////////// 
#define RESET_WATCHDOG()    #asm("WDR");

void SerialToRAM(WORD address,WORD length, BYTE type)                                             
{
    PBYTE temp = 0;          
    UINT i =0, row =0;     				
    temp   = address;    
    LED_STATUS = 0;
    for (row =0; row < 8; row++)
    {
        for (i =0; i< length; i++) 
        {
            *temp++ = ~getchar();
            RESET_WATCHDOG();
        }                               
        if (type == FRAME_TEXT)   
            temp += DATA_LENGTH - length;        
    }              
    LED_STATUS = 1;
}

void LoadCharWidth(WORD length)
{                               
    UINT i =0;  
    LED_STATUS = 0;   
    for (i =0; i < length; i++)
    {                           
        WORD data = 0;
        data = getchar();                       // LOBYTE 
        RESET_WATCHDOG();       
        char_width[i] = data;        
        data = getchar();                       // HIBYTE
        RESET_WATCHDOG();
        char_width[i] |= (data<<8)&0xFF00;
    }                  
    current_char_width = 0xFFFF;
    
    LED_STATUS = 1;
}

void SaveCharWidth(WORD length)
{
    UINT i =0;  
    LED_STATUS = 0;   
    for (i =0; i < length; i++)
    {                           
        _save_char_width[i] = char_width[i];
        RESET_WATCHDOG();
    }              
    LED_STATUS = 1;
}

void GetCharWidth(WORD length)
{                               
    UINT i =0;  
    LED_STATUS = 0;   
    for (i =0; i < length; i++)
    {                           
        char_width[i] = _save_char_width[i];
        RESET_WATCHDOG();
    }              
    LED_STATUS = 1;
}
                                          
void SaveFontHeader(WORD length)
{   
    UINT i =0;  
    LED_STATUS = 0;    
    // init I2C bus
    i2c_init();
    for (i =0; i < length; i++)
    {                           
        eeprom_write_w(EEPROM_DEVICE_FONT,i,char_width[i]);
        RESET_WATCHDOG();        
    }                 
  
    LED_STATUS = 1;
}

void SaveToEEPROM(WORD address,WORD length,BYTE type)
{                             
    PBYTE temp = 0;    
#ifndef EEPROM_PAGE     
    UINT i =0, row =0;  
#endif    
    PBYTE end  = START_RAM_TEXT;     
    BYTE devID = EEPROM_DEVICE_32;      				
    temp   = address;         
        
    if (length > DATA_LENGTH)    
        return; // invalid param          
#ifdef EEPROM_PAGE
    if (length%EEPROM_PAGE)
        length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
#endif       
    
    // init I2C bus
    i2c_init();
    LED_STATUS = 0;        
    
       
#ifdef EEPROM_PAGE            
    if ((type == FRAME_TEXT) || (type == FRAME_FONT)) end = END_RAM;
    if (type == FRAME_FONT) devID = EEPROM_DEVICE_FONT;
    
    for (temp = address; temp < end; temp+= EEPROM_PAGE) 
    {   
        RESET_WATCHDOG();               
        if (temp >= END_RAM32) devID = EEPROM_DEVICE_64;            	                                              
        eeprom_write_page( devID, temp, temp, EEPROM_PAGE);	      
    }       
#else // NONE PAGING
    for (row =0; row < 8; row++)   
    {
        for (i =0; i< length; i++) 
        {                  
            if (i >= DATA_LENGTH32) devID = EEPROM_DEVICE_64;            	                                              
            eeprom_write( devID, temp, *temp++ );RESET_WATCHDOG();	    
        }           
        if ((type == FRAME_TEXT) || (type == FRAME_FONT))  
            temp += DATA_LENGTH - length;   
    }
#endif
        
    LED_STATUS = 1;   
}
                      
void LoadToRAM(WORD address,WORD length,BYTE type)
{                         
    PBYTE temp = 0;          
    UINT i =0, row =0;
    BYTE devID = EEPROM_DEVICE_32;      				
    temp   = address;                 

    if (length > DATA_LENGTH)    
        return; // invalid param
#ifdef EEPROM_PAGE
    if (length%EEPROM_PAGE)
        length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
#endif       
    // init I2C bus
    i2c_init();
    LED_STATUS = 0;             
    if (type == FRAME_FONT) devID = EEPROM_DEVICE_FONT;      
    for (row =0; row < 8; row++)            
    {                           
#ifdef EEPROM_PAGE          
        for (i =0; i< length; i+=EEPROM_PAGE) 
        {                                 
            if (i >= DATA_LENGTH32) devID = EEPROM_DEVICE_64;
            eeprom_read_page( devID, temp, temp, EEPROM_PAGE );	                                   
            temp += EEPROM_PAGE;
            RESET_WATCHDOG();     
        }         
#else    
        for (i =0; i< length; i++) 
        {                                 
            if (i >= DATA_LENGTH32) devID = EEPROM_DEVICE_64;
            *temp = eeprom_read( devID, temp++ );
            RESET_WATCHDOG();	                      
        }
#endif        
        if ((type == FRAME_TEXT) || (type == FRAME_FONT))  
            temp += DATA_LENGTH - length;  
    }             

    LED_STATUS = 1;  
}

void LoadConfig()
{                                
    sys_mode   = _cfg_sys_mode;
    shift_rate = _cfg_shift_rate;
    shift_step = _cfg_shift_step;    
    frm_delay  = _cfg_frm_delay;
    
    if (_save_text_length > DATA_LENGTH)
        _save_text_length = 0; 
    text_length = _save_text_length; 
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
    rtc_set_date(getchar(),getchar(),getchar());
    rtc_set_time(getchar(),getchar(),getchar());    
    LED_STATUS = 1;
}

static void TextFromFont(char *szText, BYTE nColor, BYTE bGradient, PBYTE pBuffer, WORD length)
{
	int pos = 0,x=0,y=0;     
	BYTE i =0, len;
	BYTE ch = 0;
	UINT nWidth = 0;   
	UINT nCurWidth = 0, nNxtWidth = 0;		
    BYTE mask = 0x00, data = 0;
	BYTE mask_clr[2] = {0x00};
	
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
    char_width[0] = 0;
    
	for (i=0; i< len; i++)
	{				                                     
        ch = szText[i];             
		nCurWidth = eeprom_read_w(EEPROM_DEVICE_FONT,(WORD)ch);
		nNxtWidth = eeprom_read_w(EEPROM_DEVICE_FONT,(WORD)ch+1);
		nWidth = (nNxtWidth - nCurWidth); 
		
		if ((pos + nWidth) >= length)  break;
		
		for (y=0; y< 8 ; y++)
		{    		            
		    if (bGradient) {
				if (y >=0 && y <4)	mask = mask_clr[0];
				if (y >=4 && y <8)	mask = mask_clr[1];	
			}
			
			for (x=0; x< nWidth; x++)
			{                                 
			    RESET_WATCHDOG();       
			    data = eeprom_read(EEPROM_DEVICE_FONT, START_RAM_TEXT + y*DATA_LENGTH + nCurWidth + x);
			    data = (~data) & (~mask);
   				pBuffer[y*length + x + pos] = ~data;   				
			}					
		}
		pos += nWidth;	 
		if (length == DATA_LENGTH) 
            char_width[(WORD)i+1] = pos;		
	}	                           
	
    if (length == DATA_LENGTH)     
        text_length = pos;
            
    LED_STATUS = 1;
}

void SaveTextToEEPROM()
{                       
    UINT i =0;              
    UINT length = 0;
    length = strlen(szText);    
    
    if (length > sizeof(szText))    
        return; // invalid value
    
    eeprom_write_w(EEPROM_DEVICE_EXTRA,(WORD)0,(WORD)length);
    
#ifdef EEPROM_PAGE
    if (length%EEPROM_PAGE)
        length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
#endif       
    // init I2C bus
    i2c_init();
    LED_STATUS = 0;             
    
#ifdef EEPROM_PAGE          
    for (i =0; i< length; i+=EEPROM_PAGE) 
    {                                 
        eeprom_write_page( EEPROM_DEVICE_EXTRA, i+sizeof(UINT), &szText[i], EEPROM_PAGE );	                                   
        RESET_WATCHDOG();     
    }         
#else    
    for (i =0; i< length; i++) 
    {                                       
        eeprom_write( EEPROM_DEVICE_EXTRA, i+sizeof(UINT) ,szText[i]);
        RESET_WATCHDOG();	                      
    }
#endif                         

    LED_STATUS = 1;  
    
}                      

void GetTextFromEEPROM()
{                         
    UINT i =0;              
    UINT length = 0, szLen=0;
    szLen = length = eeprom_read_w(EEPROM_DEVICE_EXTRA,(WORD)0);
    if (length > sizeof(szText))    
        return; // invalid param
#ifdef EEPROM_PAGE
    if (length%EEPROM_PAGE)
        length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
#endif       
    // init I2C bus
    i2c_init();
    LED_STATUS = 0;             

#ifdef EEPROM_PAGE          
    for (i =0; i< length; i+=EEPROM_PAGE) 
    {                                 
        eeprom_read_page( EEPROM_DEVICE_EXTRA, i+sizeof(UINT), &szText[i], EEPROM_PAGE );	                                   
        RESET_WATCHDOG();     
    }         
#else    
    for (i =0; i< length; i++) 
    {                                       
        szText[i] = eeprom_read( EEPROM_DEVICE_EXTRA, i+sizeof(UINT));
        RESET_WATCHDOG();	                      
    }
#endif                         
    szText[szLen] = '\0';
    LED_STATUS = 1;  
}

static void LoadTextASCII(WORD rx_wparam, WORD rx_lparam)
{
    UINT i =0;                          
    for (i =0; i< (UINT)rx_wparam; i++)
    {
        szText[i] = getchar();RESET_WATCHDOG();
    }
    szText[rx_wparam] = '\0';          
    SaveTextToEEPROM();
           
    if ((rx_lparam>>8) == FRAME_TEXT)
    {        
        BlankRAM(START_RAM_TEXT,END_RAM);
        TextFromFont(szText,rx_lparam&0x03,rx_lparam&0x04,START_RAM_TEXT+SCREEN_WIDTH,DATA_LENGTH); 
    }   
    else
    {                                    
        BlankRAM(START_RAM_BK,START_RAM_TEXT);                           
        TextFromFont(szText,rx_lparam&0x03,rx_lparam&0x04,START_RAM_BK,SCREEN_WIDTH);                           
    }    
    start_mem = START_RAM_TEXT + SCREEN_WIDTH;				
  	bkgnd_mem = START_RAM_BK;	
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

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 250.000 kHz
// Mode: Normal top=FFh
// OC0 output: Disconnected
TCCR0=0x03;     // 4 us per tick
TCNT0=0x05;     // 1ms = 4*250
OCR0=0x00;      // 255 -250 = TCNT0

#ifdef _MEGA162_INCLUDED_
UCSR0A=0x00;
UCSR0B=0x98;
UCSR0C=0x86;
UBRR0H=0x00;
UBRR0L=0x67;      //  16 MHz     

#else // _MEGA8515_INCLUDE_     
UCSRA=0x00;
UCSRB=0x98;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x33;       // 8 MHz
#endif

// Lower page wait state(s): None
// Upper page wait state(s): None
MCUCR=0x80;
EMCUCR=0x00;     

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x02;
ETIMSK=0x00;

// Load calibration byte for osc.  
#ifdef _MEGA162_INCLUDED_
OSCCAL = 0x5E; 
#else
OSCCAL = 0xA7; 
#endif            

// I2C Bus initialization
// i2c_init();

// DS1307 Real Time Clock initialization
// Square wave output on pin SQW/OUT: Off
// SQW/OUT pin state: 1
// rtc_init(0,0,1);
    
// Watchdog Timer initialization
// Watchdog Timer Prescaler: OSC/2048k     
#ifdef __WATCH_DOG_
WDTCR=0x1F;
WDTCR=0x0F;
#endif
}

void PowerReset()
{   
    start_mem = START_RAM_TEXT;     
    end_mem   = END_RAM;
    bkgnd_mem = START_RAM_BK;
    org_mem   = START_RAM_TEXT;	                   

    InitDevice();
       
    LED_STATUS = 0;
    BlankRAM(START_RAM,END_RAM);    
    delay_ms(500);LED_STATUS = 1;
    LoadConfig();
   
    GetCharWidth(250);
    current_char_width = 0xFFFF;
    next_char_width = 0xFFFF;	 

    delay_ms(500);LED_STATUS = 0;
    LoadToRAM(START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND);  
    LoadToRAM(START_RAM_TEXT + SCREEN_WIDTH,_save_text_length,FRAME_TEXT);      
    LED_STATUS = 1;             
        
    if (sys_mode&MODE_FONT)                 
    {
        BlankRAM(START_RAM,END_RAM);   
        GetTextFromEEPROM();
        TextFromFont(szText, 1, 1, START_RAM_TEXT + SCREEN_WIDTH, DATA_LENGTH);
        start_mem = START_RAM_TEXT + SCREEN_WIDTH;        
    } 
               
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
    case LOAD_FONT_MSG:
        {
            if (rx_wparam > DATA_LENGTH) rx_wparam = DATA_LENGTH;
            BlankRAM(START_RAM_TEXT,END_RAM);                       
            char_count  = rx_lparam;                   
            text_length = rx_wparam;   
            SerialToRAM(START_RAM_TEXT,text_length,FRAME_TEXT);             
            LoadCharWidth(char_count);                                                              
			start_mem = START_RAM_TEXT;				
	    	bkgnd_mem = START_RAM_BK;										  
        }				
        break;
    case LOAD_TEXT_MSG:
        {
            if (rx_wparam > DATA_LENGTH) rx_wparam = DATA_LENGTH;
            BlankRAM(START_RAM_TEXT,END_RAM);                       
            char_count  = rx_lparam;                   
            text_length = rx_wparam;   
            SerialToRAM(START_RAM_TEXT + SCREEN_WIDTH,text_length,FRAME_TEXT);                
            LoadCharWidth(char_count);                                                              
			start_mem = START_RAM_TEXT + SCREEN_WIDTH;				
	    	bkgnd_mem = START_RAM_BK;		    									  
        }				
        break;
    case LOAD_BKGND_MSG:
        {
            if (rx_wparam > SCREEN_WIDTH) rx_wparam = SCREEN_WIDTH;
            BlankRAM(START_RAM_BK,START_RAM_TEXT);                    
            SerialToRAM(START_RAM_BK,rx_wparam,FRAME_BKGND);                                               
		    start_mem = START_RAM_TEXT + SCREEN_WIDTH;				
		    bkgnd_mem = START_RAM_BK;				    
		}
        break;     
    case EEPROM_LOAD_FONT_MSG:
        {
            LoadToRAM(START_RAM_TEXT,text_length,FRAME_FONT);                                                
        }
        break;                
    case EEPROM_SAVE_FONT_MSG:
        {                               									                                          
            SaveToEEPROM(START_RAM_TEXT,text_length,FRAME_FONT);                 
            SaveFontHeader(char_count);                      
        }
        break;
    case EEPROM_LOAD_TEXT_MSG:
        {          
            LoadToRAM(START_RAM_TEXT + SCREEN_WIDTH,text_length = _save_text_length,FRAME_TEXT);
        }
        break;                   
    case EEPROM_SAVE_TEXT_MSG:
        {                                                
            SaveToEEPROM(START_RAM_TEXT,_save_text_length = text_length,FRAME_TEXT);       
            SaveCharWidth(char_count);   
        }
        break;
    case EEPROM_LOAD_BKGND_MSG:
        {                                                                  
            LoadToRAM(START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND);                                                                                                           
        }  
        break;                 
    case EEPROM_SAVE_BKGND_MSG:
        {                                                                  
            SaveToEEPROM(START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND);
        }
        break;
    case EEPROM_LOAD_ALL_MSG:
        {   
            LoadToRAM(START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND);     
            LoadToRAM(START_RAM_TEXT + SCREEN_WIDTH,text_length = _save_text_length,FRAME_TEXT);
        }
        break;                
    case EEPROM_SAVE_ALL_MSG:
        {       
            SaveCharWidth(char_count);   
            SaveToEEPROM(START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND);
            SaveToEEPROM(START_RAM_TEXT,_save_text_length = text_length,FRAME_TEXT);
        }            
        break;
    case SET_RTC_MSG:
        {                                
            SetRTCDateTime();
        }
        break;
    case SET_CFG_MSG:
        {
            _cfg_shift_rate  = shift_rate  = rx_wparam&0x00ff;
            _cfg_shift_step  = shift_step  = rx_wparam>>8;                       
            _cfg_frm_delay   = frm_delay   = rx_lparam&0x00ff;
            _cfg_sys_mode    = sys_mode    = rx_lparam>>8;                     
            // preset value for scrolling, must be set here
            current_char_width = next_char_width = 0xFFFF;
        }
        break;
    case LOAD_DEFAULT_MSG:
        {
            _cfg_shift_rate  = shift_rate  = 10;
            _cfg_shift_step  = shift_step  = 1;
            _cfg_sys_mode    = sys_mode    = 0x0F;
            _cfg_frm_delay   = frm_delay   = 100; 
            _save_text_length = text_length = SCREEN_WIDTH;
        }	 	                 
        break;           
    case LOAD_TEXT_ASCII_MSG:
        {                                                
            LoadTextASCII(rx_wparam,rx_lparam);
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
            _displayFrame();
            _doScroll();                        
        }
        RESET_WATCHDOG();
    };
}
                         
