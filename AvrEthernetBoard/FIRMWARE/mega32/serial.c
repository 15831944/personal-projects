#include "define.h"

///////////////////////////////////////////////////////////////
// serial interrupt handle - processing serial message ...
///////////////////////////////////////////////////////////////
// [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
///////////////////////////////////////////////////////////////
extern BYTE rx_buffer[RX_BUFFER_SIZE];
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
        if (++rx_wr_index == RX_BUFFER_SIZE){
            rx_wr_index=0;
        }                         
        rx_wparam = 0;    
        rx_lparam = ++rx_counter; 
        if (rx_counter == RX_BUFFER_SIZE)
        {            
            rx_message=DATA_INCOMMING;              
            rx_counter=0;
        }       
    }
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
    rx_wr_index =0;
    rx_counter  =0;
    rx_wparam   =0;
    rx_lparam   =0;
    rx_message  =UNKNOWN_MSG;
}

///////////////////////////////////////////////////////////////
// END serial interrupt handle
/////////////////////////////////////////////////////////////// 