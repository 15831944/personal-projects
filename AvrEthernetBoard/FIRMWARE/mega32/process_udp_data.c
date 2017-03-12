#include "ethernet.h"


unsigned int process_udp_data(unsigned char* udpdata, unsigned int rcv_len)
{           
    unsigned int i = 0;  
    for (i=0; i< rcv_len; i++){
        putchar(udpdata[i]);
        delay_us(100); 
        #asm("WDR");
    }    
    return (0);                                                 
}