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
static PBYTE start_memR =NULL;         
static PBYTE start_memG =NULL;         
static PBYTE start_memB =NULL;         

bit power_off = 0;
bit is_stopping = 0;

register UINT x=0;
register UINT y=0;   
static BYTE  mask = 0xFF;                              
static UINT  scroll_count = 0;  
static UINT  scroll_updown = 0;    
static UINT  stopping_count = 0;       
static BYTE  tick_count  = 0;       
static BYTE  frame_index = 0;   
static BYTE  scroll_step = 0;

static UINT  text_length = 0;              
static BYTE  scroll_rate = FAST_RATE;
static BYTE  scroll_temp = FAST_RATE;
static BYTE  scroll_type = 0;            
             
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
void LoadFrame(BYTE index);     
void BlankRAM(PBYTE start_addr,PBYTE end_addr);
void LoadToRAM(PBYTE address,WORD length,BYTE index);
///////////////////////////////////////////////////////////////
// Timer 0 overflow interrupt service routine , 40.5 us per tick                 
///////////////////////////////////////////////////////////////
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{       
    TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
    ++tick_count;    
}

///////////////////////////////////////////////////////////////
// static function(s) for led matrix display panel
///////////////////////////////////////////////////////////////

static void putdata()
{                          
    BYTE tempH = 0, tempL =0;          
    BYTE temp_byte = 0;    
    BYTE temp_bit = 0;
    temp_byte = (scroll_updown/8);
    temp_bit = (scroll_updown%8);
	for (x=0; x< SCREEN_WIDTH; x++){
		tempL = ~start_memR[(SCREEN_HEIGHT/8)*(x) + temp_byte]; 
		tempH = ~start_memR[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		DATA_PORT = ~tempL & mask;                                  
		DATA_CLK = 1;
		DATA_CLK = 0;					         
		tempL = ~start_memB[(SCREEN_HEIGHT/8)*(x) + temp_byte]; 
		tempH = ~start_memB[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		DATA_PORT = ~tempL & mask;
		DATA_CLK = 1;
		DATA_CLK = 0;				             
        tempL = ~start_memG[(SCREEN_HEIGHT/8)*(x) + temp_byte]; 
		tempH = ~start_memG[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		DATA_PORT = ~tempL & mask;
		DATA_CLK = 1;
		DATA_CLK = 0;				
	}         
	  
    DATA_STB0 = 1;
    DATA_STB0 = 0; 
    
    
    for (x=0; x< SCREEN_WIDTH; x++){ 
        tempL = ~start_memR[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
		tempH = ~start_memR[(SCREEN_HEIGHT/8)*(x) + temp_byte+2]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		DATA_PORT = ~tempL & mask;
		DATA_CLK = 1;
		DATA_CLK = 0;				
        tempL = ~start_memB[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
		tempH = ~start_memB[(SCREEN_HEIGHT/8)*(x) + temp_byte+2]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		DATA_PORT = ~tempL & mask;
		DATA_CLK = 1;
		DATA_CLK = 0;               
        tempL = ~start_memG[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
		tempH = ~start_memG[(SCREEN_HEIGHT/8)*(x) + temp_byte+2]; 
		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
		DATA_PORT = ~tempL & mask;
		DATA_CLK = 1;
		DATA_CLK = 0;					
	}
	           
    DATA_STB1 = 1;       
    DATA_STB1 = 0;     	         
}
 
static void putdata0()
{                          
	for (x=0; x< SCREEN_WIDTH; x++){
		DATA_PORT = start_memR[(SCREEN_HEIGHT/8)*(x) ]; 
		DATA_CLK = 1;
		DATA_CLK = 0;					         
		DATA_PORT = start_memB[(SCREEN_HEIGHT/8)*(x) ]; 
		DATA_CLK = 1;
		DATA_CLK = 0;				             
		DATA_PORT = start_memG[(SCREEN_HEIGHT/8)*(x) ]; 
		DATA_CLK = 1;
		DATA_CLK = 0;				
	}         
	  
    DATA_STB0 = 1;
    DATA_STB0 = 0; 
    
    
    for (x=0; x< SCREEN_WIDTH; x++){ 
        DATA_PORT = start_memR[(SCREEN_HEIGHT/8)*(x) + 1]; 		  
		DATA_CLK = 1;
		DATA_CLK = 0;				
        DATA_PORT = start_memB[(SCREEN_HEIGHT/8)*(x) + 1]; 
    	DATA_CLK = 1;
		DATA_CLK = 0;               
        DATA_PORT = start_memG[(SCREEN_HEIGHT/8)*(x) + 1];
        DATA_CLK = 1;
		DATA_CLK = 0;					
	}
	           
    DATA_STB1 = 1;       
    DATA_STB1 = 0;     	         
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
        start_memR += (SCREEN_HEIGHT/8);  
        start_memG += (SCREEN_HEIGHT/8);  
        start_memB += (SCREEN_HEIGHT/8);  
        if (++scroll_count > SCREEN_WIDTH){     
            scroll_temp =scroll_rate;
            scroll_rate =FAST_RATE;
            scroll_step++; 
            scroll_count=0;
        }
    }                                      
    else if (scroll_step ==1){
        start_memR -= (SCREEN_HEIGHT/8);   
        if (++scroll_count > SCREEN_WIDTH){                
            scroll_step++; 
            scroll_count=0;                        
        }
    }    
    else if (scroll_step ==2){
        start_memG -= (SCREEN_HEIGHT/8);   
        if (++scroll_count > SCREEN_WIDTH){
            scroll_step++; 
            scroll_count=0;
        }
    }
    else if (scroll_step ==3){
        start_memB -= (SCREEN_HEIGHT/8);   
        if (++scroll_count > SCREEN_WIDTH){
            scroll_step++; 
            scroll_count=0;
        }
    }               
    else if (scroll_step ==4){  
        if (++scroll_count > MAX_STOP_TIME){   
            scroll_step++; 
            scroll_count=0; 
            scroll_temp =scroll_rate;
            scroll_rate =SLOW_RATE;
        }
    }
    else if (scroll_step ==5){
        if (++scroll_updown >=SCREEN_HEIGHT){                
            scroll_step++;                
            scroll_updown =0;  
            scroll_rate =scroll_temp;     
        }
    }
    else if (scroll_step ==6){  
        if (++scroll_count > MAX_STOP_TIME){   
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
        if (++scroll_count > MIN_STOP_TIME){   
            scroll_step++; 
            scroll_count=0; 
        }
    }
    else if (scroll_step ==2){
        mask = 0xFF;  
        scroll_step++;
    }
    else if (scroll_step ==3){  
        if (++scroll_count > MIN_STOP_TIME){   
            scroll_step++; 
            scroll_count=0; 
        }
    }
    else if (scroll_step ==4){  
        if (++scroll_count > MAX_STOP_TIME){   
            scroll_step++; 
            scroll_count=0;                
            scroll_temp =scroll_rate;
            scroll_rate =SLOW_RATE;
        }
    }                  
    else if (scroll_step ==5){
        start_memR += (SCREEN_HEIGHT/8); 
        start_memG += (SCREEN_HEIGHT/8); 
        start_memB += (SCREEN_HEIGHT/8); 
        if (++scroll_updown >=SCREEN_HEIGHT){                
            scroll_step++;       
            scroll_rate =FAST_RATE;         
        }
    }
    else if (scroll_step ==6){
        start_memR -= (SCREEN_HEIGHT/8); 
        start_memG -= (SCREEN_HEIGHT/8); 
        start_memB -= (SCREEN_HEIGHT/8); 
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
	if (frame_index >= MAX_FRAME){
	    frame_index=0;
	}
    		
  }
             
}          
////////////////////////////////////////////////////////////////////
// General functions
//////////////////////////////////////////////////////////////////// 
#define RESET_WATCHDOG()    #asm("WDR");
                                                                            
void LoadConfig(BYTE index)
{
    BYTE devID = EEPROM_DEVICE_BASE;    
    WORD base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = 0x8000;    
    }                 
    devID &= 0xF7;      // clear bit A3 
    
    // init I2C bus
    i2c_init();
    LED_STATUS = 0;
    scroll_rate = eeprom_read(devID, (WORD)base+0);    
    scroll_type = eeprom_read(devID, (WORD)base+1);    
    text_length = eeprom_read_w(devID, (WORD)base+2); 
    printf("index=%d scroll_rate=%d scroll_type=%d text_lenth=%d\r\n",
            index,   scroll_rate,   scroll_type,   text_length); 
    
    if (text_length > MAX_LENGTH){
        text_length= 0;            
    }
    if (scroll_rate > MAX_RATE){
        scroll_rate = 0;
    }
    LED_STATUS = 1;   
}

void LoadFrame(BYTE index)
{                 
    if (index >= MAX_FRAME){
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
                            
    BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
    LoadToRAM((PBYTE)START_RAM,text_length,index);    
    start_memR = (PBYTE)START_RAM + 0*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
    start_memG = (PBYTE)START_RAM + 1*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
    start_memB = (PBYTE)START_RAM + 2*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);             
}
                       
void SaveTextLength(BYTE index)
{
    BYTE devID = EEPROM_DEVICE_BASE;    
    WORD base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = 0x8000;    
    }                 
    devID &= 0xF7;      // clear bit A3 
    
    i2c_init();
    LED_STATUS = 0;   
    eeprom_write_w(devID, base+2,text_length); 
    LED_STATUS = 1;   
}

void SaveConfig(BYTE rate,BYTE type, BYTE index)
{                     
    BYTE devID = EEPROM_DEVICE_BASE;    
    WORD base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = 0x8000;    
    }                 
    devID &= 0xF7;      // clear bit A3  
    i2c_init();
    LED_STATUS = 0;  
    eeprom_write(devID, base+0,rate);    
    eeprom_write(devID, base+1,type);    
    LED_STATUS = 1;       
}

void SaveToEEPROM(PBYTE address,WORD length,BYTE index)
{                             
    PBYTE tempL = 0;     
    BYTE devID = EEPROM_DEVICE_BASE;
    WORD base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = 0x8000;    
    }         				
    tempL = address;         
        
    if (length > MAX_LENGTH)    
        return; // invalid param 
    length = (WORD)address+MAX_COLOR*(SCREEN_HEIGHT/8)*(length);         
    if (length%EEPROM_PAGE)
        length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
    // init I2C bus
    i2c_init();
    LED_STATUS = 0;        
    
    for (tempL = address; tempL < length; tempL+= EEPROM_PAGE) 
    {   
        RESET_WATCHDOG();                          	                                              
        eeprom_write_page( devID, base+(WORD)tempL, (PBYTE)tempL, EEPROM_PAGE);	      
    }       
        
    LED_STATUS = 1;   
}
                      
void LoadToRAM(PBYTE address,WORD length,BYTE index)
{                         
    PBYTE tempL = 0;          
    BYTE devID = EEPROM_DEVICE_BASE;
    WORD base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = 0x8000;    
    }       				
    tempL = address;                 

    if (length > MAX_LENGTH)    
        return; // invalid param
    length = (WORD)address+MAX_COLOR*(SCREEN_HEIGHT/8)*(length);         
    if (length%EEPROM_PAGE)
        length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
    // init I2C bus
    i2c_init();
    LED_STATUS = 0;             
 
    for (tempL = address; tempL < length; tempL+= EEPROM_PAGE) 
    {
        eeprom_read_page( devID, base+(WORD)tempL, (PBYTE)tempL, EEPROM_PAGE );	                                   
        RESET_WATCHDOG();     
    }             

    LED_STATUS = 1;   
}

void SerialToRAM(PBYTE address,WORD length)                                             
{
    PBYTE tempL = 0;          
    UINT i =0;     				
    tempL   = address;    
    LED_STATUS = 0;
    for (i =0; i< (length)*(SCREEN_HEIGHT/8)*MAX_COLOR; i++)         
    {                          
        BYTE data = 0;
        data = ~getchar();
        *tempL = data;
        tempL++;
        RESET_WATCHDOG();                                     
    }              
    LED_STATUS = 1;
}
                      
void BlankRAM(PBYTE start_addr,PBYTE end_addr)
{        
    PBYTE tempL = START_RAM;
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
#ifdef _MEGA162_INCLUDED_ 
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif                    
#endif

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
UBRRL=0x67;       // 16 MHz
#endif

// Lower page wait state(s): None
// Upper page wait state(s): None
MCUCR=0x80;
EMCUCR=0x00;     

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x02;              
#ifdef _MEGA162_INCLUDED_
ETIMSK=0x00;
#endif
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
// rtc_init(3,0,1);

//i2c_init(); // must be call before
//rtc_init(3,0,1); // init RTC DS1307  
//rtc_set_time(15,2,0);
//rtc_set_date(9,5,6);    
                
// Watchdog Timer initialization
// Watchdog Timer Prescaler: OSC/2048k     
#ifdef __WATCH_DOG_
WDTCR=0x1F;
WDTCR=0x0F;
#endif
}

void PowerReset()
{      
    InitDevice();
    
    start_memR = (PBYTE)START_RAM;
    start_memG = (PBYTE)START_RAM;
    start_memB = (PBYTE)START_RAM;
   
    LED_STATUS = 0;
    BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);  
    
    LED_STATUS = 0;  
    delay_ms(50);
    LED_STATUS = 1;
    delay_ms(50);
    LED_STATUS = 0;
    delay_ms(100);    
    LED_STATUS = 1;
                
    frame_index= 0;
    LoadFrame(frame_index);
    start_memR = (PBYTE)START_RAM + 0*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
    start_memG = (PBYTE)START_RAM + 1*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
    start_memB = (PBYTE)START_RAM + 2*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
                 
    printf("LCMS v4.00 Designed by CuongQuay\r\n");  
    printf("cuong3ihut@yahoo.com - 0915651001\r\n");
    printf("Release date: 03.12.2006\r\n");
}

void ProcessCommand()
{
   	#asm("cli"); 
    RESET_WATCHDOG();

    // serial message processing     
    switch (rx_message)
    {                  
    case LOAD_TEXT_MSG:
        {                
            text_length = rx_wparam;      
            if (text_length > SCREEN_WIDTH<<1){
                text_length = SCREEN_WIDTH<<1;
            }
            frame_index = rx_lparam&0x0F;   
            BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
            SerialToRAM((PBYTE)START_RAM,text_length);                		               				
			SaveToEEPROM((PBYTE)START_RAM,text_length,rx_lparam);
			SaveTextLength(rx_lparam);							      
			
			start_memR = (PBYTE)START_RAM + 0*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
            start_memG = (PBYTE)START_RAM + 1*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
            start_memB = (PBYTE)START_RAM + 2*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);

        }				
        break;           
    case LOAD_BKGND_MSG:
        break;   
    case SET_CFG_MSG: 
        {               
            SaveConfig(rx_wparam&0x0FF,rx_wparam>>8,rx_lparam); 
        }
        break;    
    case EEPROM_SAVE_TEXT_MSG:     
    case EEPROM_SAVE_ALL_MSG:  
        break;         
    case EEPROM_LOAD_TEXT_MSG:    
    case EEPROM_LOAD_ALL_MSG:
        break;  
    case POWER_CTRL_MSG:    
        {
            power_off = rx_wparam&0x01;
        }
        break;     
    default:
        break;
    }                 
    send_echo_msg();            
    rx_message = UNKNOWN_MSG;
    #asm("sei");        
}           
void DelayFrame(BYTE dly)
{
    BYTE i =0;
    for (i=0;i<dly;i++){
        if (rx_message != UNKNOWN_MSG){           
            break;
        }   
        delay_ms(10);
        RESET_WATCHDOG();
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
BYTE eeprom_read(BYTE deviceID, WORD address) 
{
    BYTE data;
    i2c_start();
    i2c_write(deviceID);        // issued R/W = 0
    i2c_write(address>>8);      // high word address
    i2c_write(address&0x0FF);   // low word address
    
    i2c_start();
    i2c_write(deviceID | 1);    // issued R/W = 1
    data=i2c_read(NO_ACK);      // read at current
    i2c_stop();
    return data;
}

void eeprom_write(BYTE deviceID, WORD address, BYTE data) 
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

WORD eeprom_read_w(BYTE deviceID, WORD address)
{
    WORD result = 0;
    result = eeprom_read(deviceID,address);
    result = (result<<8) | eeprom_read(deviceID,address+1);
    return result;
}
void eeprom_write_w(BYTE deviceID, WORD address, WORD data)
{
    eeprom_write(deviceID,address,data>>8);
    eeprom_write(deviceID,address+1,data&0x0FF);    
}

#endif // __EEPROM_WRITE_BYTE
void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
{
    BYTE i = 0;
    i2c_start();
    i2c_write(deviceID);            // issued R/W = 0
    i2c_write(address>>8);          // high word address
    i2c_write(address&0xFF);        // low word address
    
    i2c_start();
    i2c_write(deviceID | 1);        // issued R/W = 1
                                    
    while ( i < page_size-1 )
    {
        buffer[i++] = i2c_read(ACK);   // read at current
    }
    buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
         
    i2c_stop();
}

void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
{
    BYTE i = 0;
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
                                              
