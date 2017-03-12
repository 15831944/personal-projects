
#ifndef __DEFINE_H_
#define __DEFINE_H_

#include <mega32.h>     
#include <delay.h>        
#include <stdio.h>    
#include <string.h>
#include <i2c.h>                            

/***************************************************************/
#define     __WATCH_DOG_       
#define     __EEPROM_WRITE_BYTE         
                                               
#define     EEPROM_PAGE             64   
#define     EEPROM_DEVICE_BASE      0xA0     

#undef      _DEBUG         
#define     _DUMP_REG
#undef      _USE_INTERRUPT

#define     NET_IPADDR0     192 
#define     NET_IPADDR1     168 
#define     NET_IPADDR2     1   
#define     NET_IPADDR3     10   

#define     SRV_IPADDR0     192 
#define     SRV_IPADDR1     168 
#define     SRV_IPADDR2     1   
#define     SRV_IPADDR3     2	

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

 
/**************************************************************/
/* matrix size const definition                               */  
/**************************************************************/
                                         
                 
/**************************************************************/
/* serial message const definition                            */  
/**************************************************************/

#define     UNKNOWN_MSG              0    
#define     DATA_INCOMMING           1                                
                    
#define     COMM_TIMEOUT             1000

#define     WAKEUP_CHAR              0xAA
#define     ESCAPE_CHAR              0xFF
                                                   
#define     CONFIG_MOD               (!PINB.7)
#define     RESET_MOD                (!PINB.6)
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