#include "ethernet.h"            
   
#define ARP_BUF ((struct ARP_HDR *)&netBuffer[0])

#define ARP_REQUEST 1
#define ARP_REPLY   2

#define ARP_HWTYPE_ETH 1
                                   
extern struct MAC_ADDRESS eth_src_addr;

unsigned int process_arp_in(void)
{          
    unsigned int len = 0;
    if(HOST_ADDRESS[0]!=ARP_BUF->dipaddr[0] || HOST_ADDRESS[1]!=ARP_BUF->dipaddr[1]){
        return 0;   // ivalid IP address
    }
    switch(ARP_BUF->opcode) 
    {
    case HTONS(ARP_REQUEST):
        {
          ARP_BUF->opcode = HTONS(2);   /* reply code */
          /* update source mac address....................*/            
          memcpy(eth_src_addr.addr,ARP_BUF->shwaddr.addr,6);
          
          memcpy(ARP_BUF->dhwaddr.addr, ARP_BUF->shwaddr.addr, 6);
          memcpy(ARP_BUF->shwaddr.addr, eth_mac_addr.addr, 6);
          memcpy(ARP_BUF->ethhdr.src.addr, eth_mac_addr.addr, 6);
          memcpy(ARP_BUF->ethhdr.dest.addr, ARP_BUF->dhwaddr.addr, 6); 
          
      
          ARP_BUF->dipaddr[0] = ARP_BUF->sipaddr[0];
          ARP_BUF->dipaddr[1] = ARP_BUF->sipaddr[1];
          ARP_BUF->sipaddr[0] = HOST_ADDRESS[0];
          ARP_BUF->sipaddr[1] = HOST_ADDRESS[1];

          ARP_BUF->ethhdr.type = HTONS(NET_ETHTYPE_ARP);   
          len = sizeof(struct ARP_HDR);   
        }      
        break;
    case HTONS(ARP_REPLY):           
        /* update source mac address....................*/            
        memcpy(eth_src_addr.addr,ARP_BUF->shwaddr.addr,6);
        break;
    }    
    
    return (unsigned int)len;
}                                                

unsigned int process_arp_out(void)
{    
    unsigned char i =0;
    unsigned int len =0;
        
    for (i=0;i<6;i++){
        if (eth_src_addr.addr[i]!=0){
            break;
        }
    }    
    if (i>=6){               
        memcpy(ARP_BUF->ethhdr.src.addr, eth_mac_addr.addr, 6);
        memset(ARP_BUF->ethhdr.dest.addr, 0xFF, 6); 
        ARP_BUF->ethhdr.type = HTONS(NET_ETHTYPE_ARP);  

        ARP_BUF->hwtype = HTONS(0x0001);
        ARP_BUF->protocol = HTONS(0x0800);
        ARP_BUF->hwlen = (0x06);
        ARP_BUF->protolen = (0x04);
        ARP_BUF->opcode = HTONS(1);   
                    
        memset(ARP_BUF->dhwaddr.addr, 0x00, 6);
        memcpy(ARP_BUF->shwaddr.addr, eth_mac_addr.addr, 6);            
                
        ARP_BUF->dipaddr[0] = SERVER_ADDRESS[0];
        ARP_BUF->dipaddr[1] = SERVER_ADDRESS[1];
        ARP_BUF->sipaddr[0] = HOST_ADDRESS[0];
        ARP_BUF->sipaddr[1] = HOST_ADDRESS[1];

        ARP_BUF->ethhdr.type = HTONS(NET_ETHTYPE_ARP);   
        len = sizeof(struct ARP_HDR);              
    }
    return (unsigned int)len;
}
