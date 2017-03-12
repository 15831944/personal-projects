
#ifndef __DEFINE_H_
#define __DEFINE_H_

#include <mega8515.h>     
#include <delay.h>        
#include <stdio.h>    
#include <string.h>
#include <i2c.h>                            

/***************************************************************/
#define     __WATCH_DOG_
#define     __EEPROM_WRITE_BYTE
                                               
#define     EEPROM_PAGE               64   
#define     EEPROM_DEVICE_BASE      0xa0
/**************************************************************/
/* serial flags definition                                    */  
/**************************************************************/

#define RXB8 1
#define TXB8 0
#define UPE 2
#define OVR 3
#define FE 4
#define UDRE 5
#define RXC 7

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<OVR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)

// USART Receiver buffer
#define RX_BUFFER_SIZE 8

/**************************************************************/
/* IO port definition                                         */  
/**************************************************************/
#define     DATA_PORT       PORTB       // data out
#define     DATA_CLK        PORTD.5     // pin 15  
#define     DATA_STB0       PORTE.0     // pin 1
#define     DATA_STB1       PORTE.2     // pin 2
                             
#define     LEFT_RIGHT		    0
#define     RIGHT_LEFT		    1
#define     TOP_BOTTOM		    2
#define     BOTTOM_TOP		    3
#define     SCROLLING           4
#define     NOT_USE             5
    
#define     MAX_FRAME           4

/**************************************************************/
/* matrix size const definition                               */  
/**************************************************************/

#define     SCREEN_WIDTH        240  
#define     SCREEN_HEIGHT       64            

#define     MAX_COLOR           3

#define     MAX_STOP_TIME       100  
#define     MAX_RATE            100           
#define     MIN_RATE            2   
#define     FAST_RATE           10

#define     START_RAM           0x500    // Start Ext.RAM space

#define     END_RAM32           0x8000

#define     END_RAM             END_RAM32
#define     MAX_LENGTH          3936  
                 
/**************************************************************/
/* serial message const definition                            */  
/**************************************************************/
#define		FRAME_TEXT			0
#define		FRAME_BKGND			1
#define		FRAME_FONT			2


#define     UNKNOWN_MSG              0    

#define     LOAD_FONT_MSG	         1
#define     LOAD_TEXT_MSG            2 
#define     LOAD_BKGND_MSG           3

#define     EEPROM_LOAD_FONT_MSG	 4
#define     EEPROM_SAVE_FONT_MSG	 5
                                       
#define     EEPROM_LOAD_TEXT_MSG     6 
#define     EEPROM_SAVE_TEXT_MSG     7 

#define     EEPROM_LOAD_BKGND_MSG    8
#define     EEPROM_SAVE_BKGND_MSG    9
                                       
#define     EEPROM_LOAD_ALL_MSG		 10
#define     EEPROM_SAVE_ALL_MSG	     11
 
#define     SET_RTC_MSG              12
#define     SET_CFG_MSG              13

#define     LOAD_DEFAULT_MSG         14       
#define     LOAD_TEXT_ASCII_MSG      15     

#define     POWER_CTRL_MSG           16  
#define     DIMENSION_CONFIG         17

#define     WAKEUP_CHAR              0x55
#define     ESCAPE_CHAR              0xFF
                                                   
#define     LED_STATUS              PORTB.4

/***************************************************************/
#define     BYTE                unsigned char     
#define     PBYTE               BYTE*   
#define     WORD                unsigned int
#define     BOOL                unsigned char
#define     TRUE                1
#define     FALSE               0
#define     LONG                long      
#define     UINT                unsigned int
/***************************************************************/

#endif //__DEFINE_H_