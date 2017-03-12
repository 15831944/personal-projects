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

bit data_bit = 0;       
bit power_off = 0;
bit is_stopping = 0;    

register UINT x=0;
register UINT y=0;   
                                
static int   scroll_count = 0;
static UINT  tick_count  = 0;       
static UINT  stopping_count = 0;       
static BYTE  frame_index = 0;   

static UINT  text_length = 0;              
static BYTE  scroll_rate = 20;
static BYTE  scroll_type = LEFT_RIGHT;            
                                                                                                     
static char szBuff[50] = "0123456789:/'C";
                               
#ifdef _CLOCK_MODE_             

#endif
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
void GetRTCClock();
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

static void _putData()
{                                                
    for (y=0; y< SCREEN_HEIGHT; y++){             
        data_bit = (start_mem[(y)/8 + 4*(x)]>>(y%8)) & 0x01; 					
        if (power_off) data_bit =OFF_LED;
               
        if (scroll_type == BOTTOM_TOP){
            if (SCREEN_HEIGHT -y > (SCREEN_HEIGHT<<1) -scroll_count)
                CTRL_OUT = OFF_LED;
            else                   
                CTRL_OUT = data_bit;
        }   
        else if (scroll_type == TOP_BOTTOM){
            if (y >= scroll_count -SCREEN_HEIGHT){
                if (scroll_count >= SCREEN_HEIGHT)
                    CTRL_OUT = data_bit;
                else                   
                    CTRL_OUT = OFF_LED;
            }
            else{                      
                if (scroll_count >= SCREEN_HEIGHT)
                    CTRL_OUT = OFF_LED;
                else                   
                    CTRL_OUT = data_bit;
            }
        }
        else{                   
            CTRL_OUT = data_bit;
        }                                 
        __CTRL_CLK();	    		
    }                           
    if (scroll_type==TOP_BOTTOM || scroll_type == BOTTOM_TOP){
        if (SCREEN_HEIGHT >= scroll_count){      
            int i =0;               
            CTRL_OUT = OFF_LED; // turn off the LED
            for (i =0; i< (SCREEN_HEIGHT-scroll_count);i++)
                __CTRL_CLK();                           
        }
    }               
	__CTRL_STB();
}

static void _displayFrame()
{                                  
	for (x=0; x< SCREEN_WIDTH; x++){
		_putData();
		__DATA_CLK();					
	}           
    __DATA_STB();             	
}     
                                                                                  
static void _doScroll()
{
  if (tick_count > scroll_rate){    
    switch (scroll_type)
    {
    case LEFT_RIGHT:                
        if (is_stopping==0){   
            if (scroll_rate > MIN_RATE)
       	        start_mem += 4;
       	    else 
       	        start_mem += 8;
   	    }
   	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
   	        is_stopping = 1;
   	    if (is_stopping ==1)
   	    {
   	        if (stopping_count++>MAX_STOP_TIME)
   	        {
   	            is_stopping=0;
   	            stopping_count = 0;
   	        }
   	    }                                  
       	if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
   	    {                  
   	        LoadFrame(++frame_index);
       	}           
   	    break;
    case RIGHT_LEFT:
       	if (is_stopping==0){
   	        if (scroll_rate > MIN_RATE)
   	            start_mem -= 4;      
   	        else
   	            start_mem -= 8;
   	        
   	    }
   	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
   	        is_stopping = 1;
   	    if (is_stopping ==1)
   	    {
   	        if (stopping_count++ >MAX_STOP_TIME)
   	        {
   	            is_stopping=0;
   	            stopping_count = 0;
   	        }
   	    }
   	    else if (start_mem < START_RAM_TEXT)             
       	{
       	    scroll_count = 0;             
   	        LoadFrame(++frame_index);
       	}
       	break;
    case BOTTOM_TOP:               
        if (scroll_count >=0){        
            scroll_count--;   
        }
        else{                      
            stopping_count = 0;
            scroll_count = SCREEN_HEIGHT<<1;
            start_mem += 4*SCREEN_WIDTH;                                  
            if (start_mem >= (START_RAM_TEXT +4*(text_length+SCREEN_WIDTH))){
                LoadFrame(++frame_index);
            }  
        }
        if (is_stopping==1)
        {               
            if (stopping_count++ > MAX_STOP_TIME)
            {
                is_stopping = 0;
                stopping_count = 0; 
            }
            else{
                scroll_count++;
            }
        }   
        if (scroll_count == SCREEN_HEIGHT){
            is_stopping = 1;
        }
        
        break;
    case TOP_BOTTOM:
        if (scroll_count == SCREEN_HEIGHT){
            is_stopping = 1;
        }                   
        if (scroll_count <= (SCREEN_HEIGHT<<1)){ 
            scroll_count++;                
        }
        else {            
            scroll_count = 0;  
            stopping_count = 0;
            start_mem += 4*SCREEN_WIDTH;                                  
            if (start_mem >= (START_RAM_TEXT +4*(text_length+SCREEN_WIDTH))){
                LoadFrame(++frame_index);
            }                              
        }  
        if (is_stopping==1)
        {               
            if (stopping_count++ > MAX_STOP_TIME)
            {
                is_stopping = 0;
                stopping_count = 0;      
            }
            else{
                scroll_count--;
            }
        }   
        break;  
    case SCROLLING:   
        if (scroll_rate > MIN_RATE)
   	        start_mem += 4;
   	    else 
   	        start_mem += 8;
        if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
   	    {            
   	        LoadFrame(++frame_index);
       	}       	  
        break;  
    case NOT_USE:
        LoadFrame(++frame_index);
        break;  
    default:
        break;
    }
	tick_count = 0;
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
        base = (WORD)index*4;
        devID = EEPROM_DEVICE_BASE+(3<<1);    
    }                     
    
    // init I2C bus
    i2c_init();
    LED_STATUS = 1;
    scroll_rate = eeprom_read(devID, (WORD)base+0);    
    scroll_type = eeprom_read(devID, (WORD)base+1);    
    text_length = eeprom_read_w(devID, (WORD)base+2); 
    printf("line=%d rate=%d type=%d len=%d\r\n",index,scroll_rate,scroll_type,text_length);
    if (text_length > DATA_LENGTH){
        text_length= 0;            
    }
    if (scroll_type > NOT_USE){
        scroll_type = NOT_USE;
    }          
    if (scroll_rate > MAX_RATE){
        scroll_rate = 0;
    }
    LED_STATUS = 0;   
}
                       
void SaveTextLength(BYTE index)
{
    BYTE devID = EEPROM_DEVICE_BASE;    
    WORD base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = (WORD)index*4;
        devID = EEPROM_DEVICE_BASE+(3<<1);    
    }                
    
    i2c_init();
    LED_STATUS = 1;   
    eeprom_write_w(devID, base+2,text_length); 
    LED_STATUS = 0;   
}

void SaveConfig(BYTE rate,BYTE type, BYTE index)
{                     
    BYTE devID = EEPROM_DEVICE_BASE;    
    WORD base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = (WORD)index*4;
        devID = EEPROM_DEVICE_BASE+(3<<1);    
    }                
    
    i2c_init();
    LED_STATUS = 1;  
    eeprom_write(devID, base+0,rate);    
    eeprom_write(devID, base+1,type);    
    LED_STATUS = 0;       
}

void SaveToEEPROM(PBYTE address,WORD length,BYTE index)
{                             
    PBYTE temp = 0;     
    BYTE devID = EEPROM_DEVICE_BASE;
    WORD base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = ((WORD)index-3)*(SMALL_SIZE);                       
        devID = EEPROM_DEVICE_BASE+(3<<1);    
    }         				
    temp = address;         
        
    if (length > DATA_LENGTH)    
        return; // invalid param 
    length = (WORD)address+4*(SCREEN_WIDTH+length);         
    if (length%EEPROM_PAGE)
        length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
    // init I2C bus
    i2c_init();
    LED_STATUS = 1;        
    
    for (temp = address; temp < length; temp+= EEPROM_PAGE) 
    {   
        RESET_WATCHDOG();                          	                                              
        eeprom_write_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE);	      
    }       
        
    LED_STATUS = 0;   
}
                      
void LoadToRAM(PBYTE address,WORD length,BYTE index)
{                         
    PBYTE temp = 0;                                                                  
    BYTE devID = EEPROM_DEVICE_BASE;
    WORD base = 0;   // base address
    devID += index<<1;                 
    if (index >=4){
        base = ((WORD)index-3)*(SMALL_SIZE);                              
        devID = EEPROM_DEVICE_BASE+(3<<1);    
    }       				
    temp = address;                 

    if (length > DATA_LENGTH)    
        return; // invalid param
    length = (WORD)address+4*(SCREEN_WIDTH+length);         
    if (length%EEPROM_PAGE)
        length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
    // init I2C bus
    i2c_init();
    LED_STATUS = 1;             
 
    for (temp = address; temp < length; temp+= EEPROM_PAGE) 
    {
        eeprom_read_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE );	                                   
        RESET_WATCHDOG();     
    }             

    LED_STATUS = 0;   
}

void LoadFrame(BYTE index)
{                 
    if (index >= MAX_FRAME) index=0;  
    #ifdef _CLOCK_MODE_
     index=0;
    #endif
    
    LoadConfig(index);  
    if (scroll_type==NOT_USE){
        return;           
    }      
                 
    BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
    LoadToRAM((PBYTE)START_RAM_TEXT,text_length,index);
    stopping_count = 0;
    scroll_count = 0;
    is_stopping = 0;
    switch (scroll_type)
    {
    case LEFT_RIGHT:
        start_mem = (PBYTE)START_RAM_TEXT; 
        break;                
    case RIGHT_LEFT:
        start_mem = (PBYTE)START_RAM_TEXT + (text_length<<2); 
        break;
    case BOTTOM_TOP:                             
        scroll_count = SCREEN_HEIGHT<<1;
        start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
        break;
    case TOP_BOTTOM:   
        scroll_count = 0;                     
        start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
        break;  
    case SCROLLING:
        start_mem = (PBYTE)START_RAM_TEXT;
        break;
    default: 
        break;
    }
#ifdef _CLOCK_MODE_
    GetRTCClock();
#endif     
                       
}

void SerialToRAM(PBYTE address,WORD length)                                             
{
    PBYTE temp = 0;          
    UINT i =0;     				
    temp   = address;    
    LED_STATUS = 1;
    for (i =0; i< (length<<2); i++)         
    {                          
        BYTE data = 0;
        data = ~getchar();
        *temp = data;
        temp++;
        RESET_WATCHDOG();                                     
    }              
    LED_STATUS = 0;
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

#ifdef _CLOCK_MODE_
void GetRTCClock()
{         
    int temp=0;     
    WORD ch=0,length=0;
    WORD i=0,x=0,y=0,pos=0;                                                                               
    PBYTE pClockBuff = START_RAM_TEXT+SCREEN_WIDTH*4;
    PBYTE pClockDisp = START_RAM_TEXT+SCREEN_WIDTH*4+(14*CHAR_WIDTH*4);
    BYTE hh=0,mm=0,ss=0;
    BYTE DD=0,MM=0,YY=00;
    i2c_init();          
    RESET_WATCHDOG();                 
    rtc_get_date(&DD,&MM,&YY);
    rtc_get_time(&hh,&mm,&ss);                                                                                                                  
    RESET_WATCHDOG();
    if (!ds18b20_init(0,10,40,DS18B20_9BIT_RES)){
        printf("INIT DS18B20 ERROR!! \r\n");
    }
    temp=(int)ds18b20_temperature(0);        
    if (temp<0 || temp>100) temp = 0;       
    sprintf(szBuff,"%02d:%02d%02d/%02d%02d'C",hh,mm,DD,MM,temp);
    printf("%02d:%02d %02d/%02d %02d'C \r\n",hh,mm,DD,MM,temp);
    
    for (i=0; i<14; i++){    
        ch = (WORD)szBuff[i]&0x0F;
        length = CHAR_WIDTH;         
        if (i==2 || i==7 || i==12){
            length = SYMB_WIDTH;
        }                         
        if (i==2) ch = 0x0A;
        if (i==7) ch = 0x0B;
        if (i==12) ch = 0x0C;
        if (i==13) ch = 0x0D;
        for (x=0; x< length; x++){
            for (y=0; y<4; y++){
                pClockDisp[pos+(x*4)+y]=pClockBuff[ch*(CHAR_WIDTH*4)+(x*4)+y];
            }
        }                             
        if (i==2 || i==7 || i==12){
            pos += (SYMB_WIDTH*4);
        }        
        else{                 
            pos += (CHAR_WIDTH*4);
        }
        RESET_WATCHDOG();
    }
    start_mem = (PBYTE)START_RAM_TEXT+SCREEN_WIDTH*4+(14*CHAR_WIDTH*4);  
    text_length += (11*CHAR_WIDTH+3*SYMB_WIDTH);                             
}
#endif
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

PORTD=0xFF;
DDRD=0x00; 

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
i2c_init();

// DS1307 Real Time Clock initialization
// Square wave output on pin SQW/OUT: Off
// SQW/OUT pin state: 1
rtc_init(3,0,1);
// Watchdog Timer initialization
// Watchdog Timer Prescaler: OSC/2048k     
#ifdef __WATCH_DOG_
WDTCR=0x1F;
WDTCR=0x0F;
#endif
}

void PowerReset()
{      
    start_mem = (PBYTE)START_RAM_TEXT;                    

    InitDevice();
       
    LED_STATUS = 0;
    BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);  
    
    LED_STATUS = 0;  
    delay_ms(50);
    LED_STATUS = 1;
    delay_ms(50);
    LED_STATUS = 0;
    delay_ms(500);    
    LED_STATUS = 1;
                
    frame_index= 0;
    LoadFrame(frame_index);
        
#ifdef _INIT_EEPROM_ 
{
    BYTE i =0;
    for (i =0; i< MAX_FRAME; i++){   
        SaveConfig(10,0,i);
        text_length = 160;
        SaveTextLength(i);            
    }
}
#endif  
    printf("LCMS v3.03 Designed by CuongQuay\r\n");  
    printf("cuong3ihut@yahoo.com - 0915651001\r\n");
    printf("Started date: 31.03.2007\r\n");
    
#ifdef _CLOCK_MODE_
GetRTCClock();
#endif    
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
            frame_index = rx_lparam&0x0F;   
            BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
            SerialToRAM((PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH),text_length);                
			start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);				
			SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
			SaveTextLength(rx_lparam);							  
        }				
        break;           
    case LOAD_BKGND_MSG:
        {
        }
        break; 
    case SET_RTC_MSG:
        {     
            SetRTCDateTime();
        }
        break;  
    case SET_CFG_MSG: 
        {               
            SaveConfig(rx_wparam&0x0FF,rx_wparam>>8,rx_lparam); 
        }
        break;    
    case EEPROM_SAVE_TEXT_MSG:     
    case EEPROM_SAVE_ALL_MSG:  
        {                                                          
            SaveTextLength(rx_lparam);              
            SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
        }
        break;         
    case EEPROM_LOAD_TEXT_MSG:    
    case EEPROM_LOAD_ALL_MSG:
        {
            LoadConfig(rx_lparam);                               
            LoadToRAM((PBYTE)START_RAM_TEXT,text_length,rx_lparam); 
            start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);
        }
        break;  
    case POWER_CTRL_MSG:
        power_off = rx_wparam&0x01;
        break;     
    default:
        break;
    }                 
    send_echo_msg();            
    rx_message = UNKNOWN_MSG;
    #asm("sei");        
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
            if (!is_stopping){
                _displayFrame();
            }
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
                                              
