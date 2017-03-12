/*****************************************************
This program was produced by the
CodeWizardAVR V1.24.8d Standard
Automatic Program Generator
© Copyright 1998-2006 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 11/14/2006
Author  : Duong Dinh Cuong                
Company : Elcom Tech Center - ELCOM JSC   
Comments: 


Chip type           : ATmega32
Program type        : Application
Clock frequency     : 7.372800 MHz
Memory model        : Small
External SRAM size  : 0
Data Stack size     : 512
*****************************************************/

#include "define.h"                 
#include "ethernet.h"    

struct MAC_ADDRESS eth_mac_addr = {0x00,0x31,0x32,0x33,0x34,0x35};  
struct MAC_ADDRESS eth_src_addr = {0x00,0x00,0x00,0x00,0x00,0x00};

unsigned char netBuffer[RTL8019_BUFSIZE];   
unsigned char* netAppData = netBuffer;
unsigned int HOST_ADDRESS[2] ={ HTONS((NET_IPADDR0 << 8) | NET_IPADDR1), 
                                HTONS((NET_IPADDR2 << 8) | NET_IPADDR3) };
unsigned int SERVER_ADDRESS[2] ={ HTONS((SRV_IPADDR0 << 8) | SRV_IPADDR1), 
                                HTONS((SRV_IPADDR2 << 8) | SRV_IPADDR3) };       
unsigned int SUBNET_MASK[2] ={HTONS(0xFFFF),HTONS(0xFF00)};                                
unsigned int SERVER_PORT = 1980;
unsigned int CLIENT_PORT = 2201;
                             
static unsigned int udp_id_num =0;

BYTE  rx_buffer[RX_BUFFER_SIZE];
BYTE  rx_message = UNKNOWN_MSG;
WORD  rx_wparam  = 0;
WORD  rx_lparam  = 0;

extern void reset_serial();         
extern void send_echo_msg();  
                                
extern unsigned int ip_chksum(void);
extern unsigned int udp_chksum(void);
extern unsigned int process_arp_in(void);
extern unsigned int process_arp_out(void);
extern unsigned int process_ip_in(unsigned int rcv_len);
extern unsigned int nic_poll(unsigned char* buffer);    
extern void nic_send(unsigned char* buffer, unsigned int len);

extern BYTE eeprom_read(BYTE deviceID, PBYTE address);
extern void eeprom_write(BYTE deviceID, PBYTE address, BYTE data);
extern WORD eeprom_read_w(BYTE deviceID, PBYTE address);
extern void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data);
                                                
#define RESET_WATCHDOG()    #asm("WDR");

// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void)
{   
#ifdef _USE_INTERRUPT
    rtl8019ProcessInterrupt();    
#endif    
}

#define ETHE_BUF ((struct ETHERNET_HDR *)&netBuffer[0])

int process_serial()
{            
    unsigned int len =0;  
    unsigned int tmp16 =0;
   	#asm("cli"); 
    RESET_WATCHDOG();
    len = NET_LLH_LEN + sizeof(UDPIP_HDR);
    len += rx_lparam;
    
    memcpy((unsigned char*)(&netBuffer[NET_LLH_LEN] + sizeof(UDPIP_HDR)),rx_buffer,rx_lparam);
    
    UDPBUF->vhl =0x45;
    UDPBUF->tos =0x00;
    UDPBUF->len[0] = 0x00;
    UDPBUF->len[1] = 0x00;
    UDPBUF->ipid[0] = ++udp_id_num>>8;
    UDPBUF->ipid[1] = udp_id_num&0xFF;
    UDPBUF->ipoffset[0] =0x00;
    UDPBUF->ipoffset[1] =0x00;
    UDPBUF->ttl = 0x80;              
    UDPBUF->proto = IP_PROTO_UDP;
    UDPBUF->ipchksum =0;
    
    /* Assign IP addresses. */
    UDPBUF->destipaddr[0] = SERVER_ADDRESS[0];
    UDPBUF->srcipaddr[0] = HOST_ADDRESS[0];
    UDPBUF->destipaddr[1] = SERVER_ADDRESS[1];
    UDPBUF->srcipaddr[1] = HOST_ADDRESS[1];  
    /* Swap UDP port*/
    tmp16 = UDPBUF->srcport;
    UDPBUF->srcport = HTONS(CLIENT_PORT);  
    UDPBUF->destport = HTONS(SERVER_PORT);
    UDPBUF->udplen = HTONS(len - (NET_LLH_LEN + 20));    

    /* adjust ip header length*/                     
    tmp16 = len - NET_LLH_LEN;
    UDPBUF->len[0] = tmp16>>8;
    UDPBUF->len[1] = tmp16&0xFF;

    UDPBUF->udpchksum =0;  
    UDPBUF->udpchksum = ~udp_chksum();
    
    /* calc ip header checksum */
    UDPBUF->ipchksum = 0;
    UDPBUF->ipchksum = ~ip_chksum();
        
    /* Build an ethernet header. */
    memcpy(IPBUF->ethhdr.dest.addr,eth_src_addr.addr,6);    
    memcpy(IPBUF->ethhdr.src.addr,eth_mac_addr.addr,6); 
    IPBUF->ethhdr.type =HTONS(NET_ETHTYPE_IP4);     
    
    reset_serial();            
    #asm("sei");     
    return len;
}     
 
void SaveConfig()
{
    BYTE i=0;                           
    PBYTE address =0;
    for (i=0; i<6; i++){
        eeprom_write(EEPROM_DEVICE_BASE,address++,eth_mac_addr.addr[i]);    
    }
    eeprom_write_w(EEPROM_DEVICE_BASE,address++,SERVER_ADDRESS[0]);
    ++address;    
    eeprom_write_w(EEPROM_DEVICE_BASE,address++,SERVER_ADDRESS[1]);
    ++address;
    eeprom_write_w(EEPROM_DEVICE_BASE,address++,HOST_ADDRESS[0]);
    ++address;    
    eeprom_write_w(EEPROM_DEVICE_BASE,address++,HOST_ADDRESS[1]);
    ++address;                                      
    eeprom_write_w(EEPROM_DEVICE_BASE,address++,SUBNET_MASK[0]);
    ++address;    
    eeprom_write_w(EEPROM_DEVICE_BASE,address++,SUBNET_MASK[1]);
    ++address; 
    eeprom_write_w(EEPROM_DEVICE_BASE,address++,SERVER_PORT);
    ++address;    
    eeprom_write_w(EEPROM_DEVICE_BASE,address++,CLIENT_PORT);
    ++address;
}
 
void LoadConfig()
{
    BYTE i=0;                           
    PBYTE address =0;
    for (i=0; i<6; i++){
        eth_mac_addr.addr[i] = eeprom_read(EEPROM_DEVICE_BASE,address++);    
    }
    SERVER_ADDRESS[0] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
    ++address;    
    SERVER_ADDRESS[1] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
    ++address;
    HOST_ADDRESS[0] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
    ++address;    
    HOST_ADDRESS[1] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
    ++address;                                      
    SUBNET_MASK[0] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
    ++address;    
    SUBNET_MASK[1] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
    ++address;                 
    SERVER_PORT =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
    ++address;    
    CLIENT_PORT =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
    ++address;
}
                 
void DoConfig()
{
    char ch =''; 
    unsigned char i=0;  
    unsigned int temp[4];                       
    printf("\r\nMAC ADDRESS: %02X-%02X-%02X-%02X-%02X-%02X [Y]/[N]?",
        eth_mac_addr.addr[0],eth_mac_addr.addr[1],eth_mac_addr.addr[2],
        eth_mac_addr.addr[3],eth_mac_addr.addr[4],eth_mac_addr.addr[5]);
    ch =getchar();
    if (ch=='N' || ch =='n'){
        printf("\r\nENT ADDRESS: ");     
        for (i=0; i<5; i++){
            scanf("%02x",&eth_mac_addr.addr[i]);
            printf("%02X-",eth_mac_addr.addr[i]);
        }                                        
        scanf("%02x",&eth_mac_addr.addr[5]);
        printf("%02X",eth_mac_addr.addr[5]);
    }
    printf("\r\nSRV ADDRESS: %d.%d.%d.%d [Y]/[N]?",
        SERVER_ADDRESS[0]&0xFF,SERVER_ADDRESS[0]>>8,
        SERVER_ADDRESS[1]&0xFF,SERVER_ADDRESS[1]>>8);
    ch =getchar();
    if (ch=='N' || ch =='n'){
        printf("\r\nENT ADDRESS: ");
        for (i=0; i<3; i++){ 
            scanf("%d.",&temp[i]);
            printf("%d.",temp[i]);
        }                           
        scanf("%d",&temp[3]);
        printf("%d",temp[3]);  
        SERVER_ADDRESS[0] = HTONS((temp[0] << 8) | temp[1]); 
        SERVER_ADDRESS[1] = HTONS((temp[2] << 8) | temp[3]);
    }    
    printf("\r\nHST ADDRESS: %d.%d.%d.%d [Y]/[N]?",
        HOST_ADDRESS[0]&0xFF,HOST_ADDRESS[0]>>8,
        HOST_ADDRESS[1]&0xFF,HOST_ADDRESS[1]>>8);
    ch =getchar();
    if (ch=='N' || ch =='n'){
        printf("\r\nENT ADDRESS: ");
        for (i=0; i<3; i++){ 
            scanf("%d.",&temp[i]);
            printf("%d.",temp[i]);
        }                           
        scanf("%d",&temp[3]);
        printf("%d",temp[3]);  
        HOST_ADDRESS[0] = HTONS((temp[0] << 8) | temp[1]); 
        HOST_ADDRESS[1] = HTONS((temp[2] << 8) | temp[3]);
    }    
    printf("\r\nSUBNET MASK: %d.%d.%d.%d [Y]/[N]?",
        SUBNET_MASK[0]&0xFF,SUBNET_MASK[0]>>8,
        SUBNET_MASK[1]&0xFF,SUBNET_MASK[1]>>8);
    ch =getchar();
    if (ch=='N' || ch =='n'){
        printf("\r\nENT ADDRESS: ");
        for (i=0; i<3; i++){ 
            scanf("%d.",&temp[i]);
            printf("%d.",temp[i]);
        }                           
        scanf("%d",&temp[3]);
        printf("%d",temp[3]);  
        SUBNET_MASK[0] = HTONS((temp[0] << 8) | temp[1]); 
        SUBNET_MASK[1] = HTONS((temp[2] << 8) | temp[3]);
    }    
    printf("\r\nUDP SRVPORT: %d [Y]/[N]?",SERVER_PORT);
    ch =getchar();
    if (ch=='N' || ch =='n'){        
        printf("\r\nNEW SRVPORT: ");
        scanf("%4d",&SERVER_PORT);
        printf("%d",SERVER_PORT);
    }
    printf("\r\nUDP HSTPORT: %d [Y]/[N]?",CLIENT_PORT); 
    ch =getchar();
    if (ch=='N' || ch =='n'){        
        printf("\r\nNEW HSTPORT: ");
        scanf("%4d",&CLIENT_PORT);
        printf("%d",CLIENT_PORT);
    }        
    SaveConfig();
    printf("\r\nSAVE CONFIGURATION DONE...\r\n");
}
                                                   
/////////////////////////////////////////////////////////////////////////////
// Main entry for application device
/////////////////////////////////////////////////////////////////////////////

void main(void)
{

PORTA=0x00;
DDRA=0xFF;
PORTB=0xF0;
DDRB=0x0F;
PORTC=0xFF;
DDRC=0xFF;
PORTD=0x00;
DDRD=0xF8;

GICR|=0x40;
MCUCR=0x03;
MCUCSR=0x00;
GIFR=0x40;

TIMSK=0x00;

UCSRA=0x00;
UCSRB=0x98;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x2F;    
UBRRL=0x33;    

ACSR=0x80;
SFIOR=0x00;

OSCCAL=0xAD;

i2c_init();

if (RESET_MOD){                          
    printf("\r\nRESETTING DEVICE..\r\n");
    SaveConfig();
    printf("\r\nMASTER RESET DONE!\r\n");
}
else{      
    LoadConfig();
}

if (CONFIG_MOD){
    printf("                                          \r\n");
    printf("|=========================================|\r\n");
    printf("|      Ethernet AVR Firmware v1.0.0       |\r\n");
    printf("|_________________________________________|\r\n");
    printf("|        Copyright by CuongQuay           |\r\n");  
    printf("|    cuong3ihut@yahoo.com - 0915651001    |\r\n");
    printf("|       Started date: 22.07.2007          |\r\n");
    printf("|       Release date: --.--.2007          |\r\n");
    printf("|_________________________________________|\r\n");              
    printf("                                          \r\n");         
    DoConfig(); /////////////////////////////////////////////
    printf("                                          \r\n"); 
}

    rtl8019Init();
#ifdef _DUMP_REG
if (CONFIG_MOD){
    rtl8019DumpReg();
}
#endif 
#ifdef __WATCH_DOG_
    WDTCR=0x1F;
    WDTCR=0x0F;
#endif 
    #asm("sei");
    while (1){             
        unsigned int rcv_len = 0;
        rcv_len = nic_poll(netBuffer);    
        if(rcv_len == 0){ 
            if (rx_message != UNKNOWN_MSG){ 
                rcv_len = process_arp_out();
                if (rcv_len){                   
                    nic_send(netBuffer,rcv_len);
                }
                else{   
                    if (rx_lparam){               
                        rcv_len = process_serial(); 
                        if (rcv_len){
                            nic_send(netBuffer,rcv_len);
                        }                      
                    }      
                    rx_message = UNKNOWN_MSG;
                }                  
            }    
            delay_ms(1);
            if (++rx_wparam >COMM_TIMEOUT){
                rx_message = DATA_INCOMMING;
                rx_wparam =0;    
            }  
        }
        else{            
            unsigned int len = 0;                     
            if(ETHE_BUF->type == HTONS(NET_ETHTYPE_IP4)){
                len = process_ip_in(rcv_len);
                if (len >0 && len <=RTL8019_BUFSIZE){
                    nic_send(netBuffer,len);  
                }
            }                     
            else if(ETHE_BUF->type == HTONS(NET_ETHTYPE_ARP)){
                len = process_arp_in();
                if (len >0 && len <=RTL8019_BUFSIZE){
                    nic_send(netBuffer,len);                
                }
            }
        }                  
        RESET_WATCHDOG();
    }
}
