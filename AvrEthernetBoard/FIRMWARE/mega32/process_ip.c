#include "ethernet.h"

unsigned int process_icmp(unsigned int rcv_len);
unsigned int process_tcp(unsigned int rcv_len);
unsigned int process_udp(unsigned int rcv_len);
                                              
extern unsigned int process_udp_data(unsigned char* udpdata, unsigned int rcv_len);
extern unsigned int process_udp_conf(unsigned char* udpdata, unsigned int rcv_len);

unsigned int cal_chksum(unsigned int *sdata, unsigned int len)
{
    unsigned int acc;
  
    for(acc = 0; len > 1; len -= 2) {
        acc += *sdata;
        if(acc < *sdata) {
            ++acc;
        }
        ++sdata;
    }
    if(len == 1) {
        acc += HTONS(((unsigned int)(*(unsigned char *)sdata)) << 8);
        if(acc < HTONS(((unsigned int)(*(unsigned char *)sdata)) << 8)) {
            ++acc;
        }
    }

    return acc;
}

unsigned int ip_chksum(void)
{                               
    return cal_chksum(&netBuffer[NET_LLH_LEN],20);
}

unsigned int icmp_chksum(void)
{                               
    return cal_chksum(&netBuffer[NET_LLH_LEN+20],40);
}                                                                

unsigned int trans_chksum(unsigned int hdr_len, unsigned int proto)
{                
    unsigned int hsum, sum;
  
  /* Compute the checksum of the UDP header. */
    hsum = cal_chksum((unsigned int *)&netBuffer[20 + NET_LLH_LEN], hdr_len);

  /* Compute the checksum of the data in the UDP packet and add it to
     the UDP header checksum. */
    sum = cal_chksum((unsigned int *)&netBuffer[20 + NET_LLH_LEN + hdr_len],
		   (unsigned int)(((((unsigned int)(BUF->len[0]) << 8) + BUF->len[1]) - (20+hdr_len))));

    if((sum += hsum) < hsum) {
        ++sum;
    }
  
    if((sum += BUF->srcipaddr[0]) < BUF->srcipaddr[0]) {
        ++sum;
    }
    if((sum += BUF->srcipaddr[1]) < BUF->srcipaddr[1]) {
        ++sum;
    }
    if((sum += BUF->destipaddr[0]) < BUF->destipaddr[0]) {
        ++sum;
    }
    if((sum += BUF->destipaddr[1]) < BUF->destipaddr[1]) {
        ++sum;
    }
    if((sum += (unsigned int)HTONS(proto)) < (unsigned int)HTONS(proto)) {
        ++sum;
    }

    hsum = (unsigned int)HTONS((((unsigned int)(BUF->len[0]) << 8) + BUF->len[1]) - 20);
  
    if((sum += hsum) < hsum) {
        ++sum;
    }
  
    return sum;
}

unsigned int udp_chksum(void)
{
     return trans_chksum(8,IP_PROTO_UDP);                
}

unsigned int tcp_chksum(void)
{
     return trans_chksum(20,IP_PROTO_TCP);
}
 
unsigned int process_ip_in(unsigned int rcv_len)
{
    unsigned int len = 0;
    switch(BUF->proto)
    {
    case IP_PROTO_ICMP:
        len = process_icmp(rcv_len);
        break;
    case IP_PROTO_TCP:             
        len = process_tcp(rcv_len);
        break;
    case IP_PROTO_UDP:             
        len = process_udp(rcv_len);
        break;
    }
    return (unsigned int)len;
}

unsigned int process_icmp(unsigned int rcv_len)
{        
    unsigned char i =0; 
    unsigned int tmp16 =0;
                          
    if (ICMPBUF->type != ICMP_ECHO){
        return 0;   // process PING only
    } 
    if(HOST_ADDRESS[0]!=ICMPBUF->destipaddr[0] || HOST_ADDRESS[1]!=ICMPBUF->destipaddr[1]){
        return 0;   // ivalid IP address
    }
    if (SERVER_ADDRESS[0]!=ICMPBUF->srcipaddr[0] || SERVER_ADDRESS[1]!=ICMPBUF->srcipaddr[1]){
        return 0;   // ip banned!!!
    }                 
    if (icmp_chksum()!=0xFFFF){
        return 0;      
    }
                
    ICMPBUF->type = ICMP_ECHO_REPLY;
    
    if(ICMPBUF->icmpchksum >= HTONS(0xffff - (ICMP_ECHO << 8))) {
        ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8) + 1;
    } else {
        ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8);
    }
    
    /* Swap IP addresses. */
    tmp16 = BUF->destipaddr[0];
    ICMPBUF->destipaddr[0] = ICMPBUF->srcipaddr[0];
    ICMPBUF->srcipaddr[0] = HOST_ADDRESS[0];
    tmp16 = ICMPBUF->destipaddr[1];
    ICMPBUF->destipaddr[1] = ICMPBUF->srcipaddr[1];
    ICMPBUF->srcipaddr[1] = HOST_ADDRESS[1];    
    
    /* Build an ethernet header. */
    memcpy(IPBUF->ethhdr.dest.addr,IPBUF->ethhdr.src.addr,6);    
    memcpy(IPBUF->ethhdr.src.addr,eth_mac_addr.addr,6);                                       
    
    return (unsigned int)rcv_len;
}
                              
unsigned int process_tcp(unsigned int rcv_len)
{
    if(HOST_ADDRESS[0]!=TCPBUF->destipaddr[0] || HOST_ADDRESS[1]!=TCPBUF->destipaddr[1]){
        return 0;   // ivalid IP address
    }
    if (SERVER_ADDRESS[0]!=TCPBUF->srcipaddr[0] || SERVER_ADDRESS[1]!=TCPBUF->srcipaddr[1]){
        return 0;   // ip banned!!!
    }                    
    if (tcp_chksum()!=0xFFFF){
        return 0; // drop packet
    }       
    TCPBUF->tcpchksum =0;                                                      
    return (unsigned int)rcv_len;                                         
}

unsigned int process_udp(unsigned int rcv_len)
{
    unsigned int len =0;  
    unsigned int tmp16 =0;  
    
    if((HOST_ADDRESS[0])!=(UDPBUF->destipaddr[0]) || (HOST_ADDRESS[1])!=(UDPBUF->destipaddr[1])){
        if ((0xFFFF) != (UDPBUF->destipaddr[0]) || (0xFFFF) != (UDPBUF->destipaddr[1])){
            return 0;                                                                      
        }
    }
    if (udp_chksum()!=0xFFFF){     
        return 0;
    }                 
    len = NET_LLH_LEN + sizeof(UDPIP_HDR);                                     
    if (UDPBUF->destport == HTONS(CONFIG_PORT)){  
        len += UDP_CONFIG((unsigned char*)(&netBuffer[NET_LLH_LEN]+sizeof(UDPIP_HDR)),HTONS(UDPBUF->udplen)-8);
        tmp16 = UDPBUF->destipaddr[0];
        UDPBUF->destipaddr[0] = UDPBUF->srcipaddr[0];
        UDPBUF->srcipaddr[0] = HOST_ADDRESS[0];
        tmp16 = UDPBUF->destipaddr[1];
        UDPBUF->destipaddr[1] = UDPBUF->srcipaddr[1];
        UDPBUF->srcipaddr[1] = HOST_ADDRESS[1];  
        tmp16 = UDPBUF->srcport;
        UDPBUF->srcport = UDPBUF->destport;  
        UDPBUF->destport = tmp16;        
        UDPBUF->udplen = HTONS(len - (NET_LLH_LEN + 20));    
               
        tmp16 = len - NET_LLH_LEN;
        UDPBUF->len[0] = tmp16>>8;
        UDPBUF->len[1] = tmp16&0xFF;

        UDPBUF->udpchksum =0;  
        UDPBUF->udpchksum = ~udp_chksum();    
        UDPBUF->ipchksum = 0;
        UDPBUF->ipchksum = ~ip_chksum();
        
        memcpy(IPBUF->ethhdr.dest.addr,IPBUF->ethhdr.src.addr,6);    
        memcpy(IPBUF->ethhdr.src.addr,eth_mac_addr.addr,6);   
    }
    else if (UDPBUF->destport == HTONS(CLIENT_PORT)){        
        if (SERVER_ADDRESS[0]!=UDPBUF->srcipaddr[0] || SERVER_ADDRESS[1]!=UDPBUF->srcipaddr[1]){
            return 0;   // ip banned!!!
        }                            
        len += UDP_APPCALL((unsigned char*)(&netBuffer[NET_LLH_LEN]+sizeof(UDPIP_HDR)),HTONS(UDPBUF->udplen)-8);
        len =0; // drop all data, don't echo to host   
    }            
    else{
        len =0; // drop all data, don't echo to host   
    }
    return (unsigned int)len;    
}    