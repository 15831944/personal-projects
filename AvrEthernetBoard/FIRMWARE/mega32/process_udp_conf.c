#include "ethernet.h"

typedef struct _CONFIG_MSG
{
    unsigned int type;
    unsigned char mac_addr[6];
    unsigned int HOST_ADDRESS[2];
    unsigned int SERVER_ADDRESS[2];
    unsigned int SUBNET_MASK[2];
    unsigned int CLIENT_PORT;    
    unsigned int SERVER_PORT;
        
} CONFIG_MSG;
                
extern void SaveConfig();

unsigned int process_udp_conf(unsigned char* udpdata, unsigned int rcv_len)
{                         
    if (rcv_len ==sizeof(CONFIG_MSG)){                       
        CONFIG_MSG* msg = NULL;
        msg = (CONFIG_MSG*)udpdata;
        if (msg->type ==0){  // set config           
            memcpy(eth_mac_addr.addr,msg->mac_addr,6); 
            HOST_ADDRESS[0] = msg->HOST_ADDRESS[0];
            HOST_ADDRESS[1] = msg->HOST_ADDRESS[1];
            SERVER_ADDRESS[0] = msg->SERVER_ADDRESS[0];
            SERVER_ADDRESS[1] = msg->SERVER_ADDRESS[1];            
            SUBNET_MASK[0] = msg->SUBNET_MASK[0];
            SUBNET_MASK[1] = msg->SUBNET_MASK[1];
            CLIENT_PORT = msg->CLIENT_PORT;
            SERVER_PORT = msg->SERVER_PORT;  
            SaveConfig();     
        }
        else{               // get config
            memcpy(msg->mac_addr,eth_mac_addr.addr,6); 
            msg->HOST_ADDRESS[0] = HOST_ADDRESS[0];
            msg->HOST_ADDRESS[1] = HOST_ADDRESS[1];
            msg->SERVER_ADDRESS[0] = SERVER_ADDRESS[0];
            msg->SERVER_ADDRESS[1] = SERVER_ADDRESS[1];            
            msg->SUBNET_MASK[0] = SUBNET_MASK[0];
            msg->SUBNET_MASK[1] = SUBNET_MASK[1];
            msg->CLIENT_PORT = CLIENT_PORT;
            msg->SERVER_PORT = SERVER_PORT;                    
        }
    }                            
    else{
    }
    return (rcv_len);                                                 
}