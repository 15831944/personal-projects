#include "rtl8019.h"
#include <string.h>
#include <delay.h>


typedef struct _stTCPIP_HDR{
  /* IP header. */
  unsigned char vhl;
  unsigned char tos;          
  unsigned char len[2];       
  unsigned char ipid[2];        
  unsigned char ipoffset[2];  
  unsigned char ttl;          
  unsigned char proto;      
  unsigned int ipchksum;
  unsigned int srcipaddr[2];
  unsigned int destipaddr[2];
  
  /* TCP header. */
  unsigned int srcport;
  unsigned int destport;
  unsigned char seqno[4];  
  unsigned char ackno[4];
  unsigned char tcpoffset;
  unsigned char flags;
  unsigned char wnd[2];     
  unsigned int tcpchksum;
  unsigned char urgp[2];
  unsigned char optdata[4]; 
  
} TCPIP_HDR;

typedef struct _stICMPIP_HDR{
  /* IP header. */
  unsigned char vhl;
  unsigned char tos;          
  unsigned char len[2];       
  unsigned char ipid[2];        
  unsigned char ipoffset[2];  
  unsigned char ttl;          
  unsigned char proto;     
  unsigned int ipchksum;
  unsigned int srcipaddr[2]; 
  unsigned int destipaddr[2];
  /* ICMP (echo) header. */
  unsigned char type;
  unsigned char icode;
  unsigned int icmpchksum;
  unsigned int id;
  unsigned int seqno;       
  
} ICMPIP_HDR;


typedef struct _stUDPIP_HDR{
  /* IP header. */
  unsigned char vhl;
  unsigned char tos;          
  unsigned char len[2];       
  unsigned char ipid[2];        
  unsigned char ipoffset[2];  
  unsigned char ttl;          
  unsigned char proto;     
  unsigned int ipchksum;
  unsigned int srcipaddr[2];
  unsigned int destipaddr[2];
  
  /* UDP header. */
  unsigned int srcport;
  unsigned int destport;
  unsigned int udplen;
  unsigned int udpchksum;
  
} UDPIP_HDR;
                 
struct MAC_ADDRESS {
    unsigned char addr[6];
};

struct ETHERNET_HDR {
  struct MAC_ADDRESS dest;
  struct MAC_ADDRESS src;
  unsigned int type;
};

struct ARP_HDR {
  struct ETHERNET_HDR ethhdr;
  unsigned int hwtype;
  unsigned int protocol;
  unsigned char hwlen;
  unsigned char protolen;
  unsigned int opcode;
  struct MAC_ADDRESS shwaddr;
  unsigned int sipaddr[2];
  struct MAC_ADDRESS dhwaddr;
  unsigned int dipaddr[2]; 
};
 
struct IP_HDR {
  struct ETHERNET_HDR ethhdr;
  /* IP header. */
  unsigned char vhl;
  unsigned char tos;          
  unsigned char len[2];       
  unsigned char ipid[2];        
  unsigned char ipoffset[2];  
  unsigned char ttl;          
  unsigned char proto;     
  unsigned int ipchksum;
  unsigned int srcipaddr[2]; 
  unsigned int destipaddr[2];
};

#define IP_PROTO_ICMP  1
#define IP_PROTO_TCP   6
#define IP_PROTO_UDP   17
                                                 
extern unsigned char* netAppData;
extern unsigned char netBuffer[RTL8019_BUFSIZE];
extern struct MAC_ADDRESS eth_mac_addr;
extern unsigned int HOST_ADDRESS[2];  
extern unsigned int SUBNET_MASK[2];

#define NET_ETHTYPE_ARP 0x0806
#define NET_ETHTYPE_IP4  0x0800
#define NET_ETHTYPE_IP6 0x86dd 

#define ICMP_ECHO_REPLY 0
#define ICMP_ECHO       8   

#define NET_LLH_LEN     14     

#define CONFIG_PORT     1022

#ifndef HTONS
#define HTONS(n) ((((unsigned int)((n) & 0xff)) << 8) | (((n) & 0xff00) >> 8))
#endif /* HTONS */
		                       
#define IPBUF ((struct IP_HDR *)&netBuffer[0])
#define BUF (( TCPIP_HDR *)&netBuffer[NET_LLH_LEN])
#define ICMPBUF (( ICMPIP_HDR *)&netBuffer[NET_LLH_LEN])
#define TCPBUF (( TCPIP_HDR *)&netBuffer[NET_LLH_LEN])
#define UDPBUF (( UDPIP_HDR *)&netBuffer[NET_LLH_LEN])

#define UDP_CONFIG      process_udp_conf                         
#define UDP_APPCALL     process_udp_data
#define TCP_APPCALL     process_tcp_data