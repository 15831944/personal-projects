
#ifndef __DEFINE_H_
#define __DEFINE_H_

#include <mega8515.h>     
#include <delay.h>        
#include <stdio.h>    
#include <string.h>
#include <i2c.h>                            

/***************************************************************/
#define     __WATCH_DOG_
#define     __SMALL_RAM_        
#define     __EEPROM_WRITE_BYTE
                                               
#define     EEPROM_PAGE         64   

#define     EEPROM_DEVICE_BASE   0xA0

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

#define     DATA_PORT       PORTB       // pin 0..7 red-green
#define     DATA_CLK        PORTE.2     // pin 29 black-blue
#define     DATA_STB        PORTE.0     // pin 31 red-yellow
       
#define     SCAN_CLK        PORTD.3     // pin 13 blue 
#define     SCAN_STB        PORTD.4     // pin 14 orange
#define     SCAN_DAT        PORTD.5     // pin 15 white

/**************************************************************/
/* matrix size const definition                               */  
/**************************************************************/

#define     SCREEN_WIDTH        160  
#define     SCREEN_HEIGHT       16

#define     ENABLE_MASK_ROW     0xFA
//#define     ENABLE_MASK_ROW     0xF0
                          
#define     __INVERT_LEVEL_ 
                              
#define     __ANTI_SHADOW_                                                          

#define     MAX_STOP_TIME       100
#define     MAX_FLIP_TIME       3

#define     MAX_FRAME            4
                                 
#ifdef      __INVERT_LEVEL_
 #define     ON                  0
 #define     OFF                 1
#else     //__NONINVERT_LEVEL_
 #define     ON                  1
 #define     OFF                 0
#endif    //__INVERT_LEVEL_

#define     SCREEN_HIDE         16

#define     START_RAM           0x500    // Start Ext.RAM space
                         
#define     DATA_LENGTH32       (3936 -SCREEN_WIDTH)	
#define     DATA_LENGTH64       (8032 -SCREEN_WIDTH)	

#define     END_RAM32           0x7FFF
#define     END_RAM64           0xFFFF

#ifdef      __SMALL_RAM_
 #define     END_RAM            END_RAM32
 #define	 DATA_LENGTH		DATA_LENGTH32
#else
 #define     END_RAM            END_RAM64
 #define	 DATA_LENGTH		DATA_LENGTH64
#endif
                         
#define     START_RAM_BK        START_RAM   
#define     START_RAM_TEXT      (START_RAM_BK + SCREEN_WIDTH*8)   
                 
/**************************************************************/
/* serial message const definition                            */  
/**************************************************************/
#define		FRAME_TEXT			0
#define		FRAME_BKGND			1
                                      
#define     __SCROLL_TOP_                     
#define     __SCROLL_BOTTOM_
#undef      __SHOW_DATE_STR_

#define     SCROLL_TEXT             0
#define     FLYING_TEXT             1
#define     FLIPPING_TEXT           2
#define     SHOW_BKGND              3      
#define     RIGHT_LEFT              4
#define     SCROLL_TOP              5       
#define     SCROLL_BOTTOM           6
#define     TEARS_DROPPED           7
#define     SHOW_DATE_STR           8

#define     UNKNOWN_MSG              0    

#define     LOAD_TEXT_MSG            1 
#define     LOAD_BKGND_MSG           2                                       
#define     SAVE_ALL_MSG		     3 
#define     SET_RTC_MSG              4
#define     SET_CFG_MSG              5

#define     WAKEUP_CHAR              0x55
#define     ESCAPE_CHAR              0xFF
                                                   
#define     LED_STATUS               PORTB.4

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