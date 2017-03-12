//  ---------------------------------------------------------
//  Copyright (c) Neopost Inc., 2012. All rights reserved.   
//  ---------------------------------------------------------
//  Domain     -    IDFNetworks
//  Version    -    0.1
//  ---------------------------------------------------------
//  File Name  -    CDFSocketClient.h
//  Initiated  -    Neopost OSDC, FPT Software, G10-iOS Team.
//  Change History: 
//      - [06/25/2012][iOS Hanoi]: Creation.
//      - [Date][Author]: [Reason to modify]
//  ---------------------------------------------------------



#ifndef __DF_SOCKET_CLIENT__H__
#define __DF_SOCKET_CLIENT__H__

#include "CDFThread.h"
#define __xdr_bool

#include <stdio.h>
#include <stdlib.h> 
#include <errno.h>
#include <string.h>
#include <iostream>
#ifndef WIN32
 #include <fcntl.h>
 #include <netdb.h>  
 #include <unistd.h>
 #include <netinet/in.h> 
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/time.h>
 #include <sys/ioctl.h>
 #include <arpa/inet.h>
#endif

#ifdef WIN32          
 #define MSG_WAITALL 0         
 #define MSG_DONTWAIT 0x40     
 #define MSG_NOSIGNAL 0x400    
#else
 #define MAXLONG    0x7fffffff
 #define INFINITE   0xFFFFFFFF
#endif     

#define DF_SOCKET_FD_CLR(fd, set) FD_CLR(fd, set)
#define DF_SOCKET_FD_SET(fd, set) FD_SET(fd, set)
#define DF_SOCKET_FD_ZERO(set) FD_ZERO(set)

#define DF_SOCKET_CONNECT   connect
#define DF_SOCKET_SELECT    select
#define DF_SOCKET_SEND      send
#define DF_SOCKET_SOCKET    socket
#define DF_SOCKET_RECV      recv

#ifdef WIN32
    #pragma comment(lib,"ws2_32.lib")
    #define DF_SOCKET_CLOSE closesocket
    #define DF_SOCKET_IOCTL ioctlsocket
    #define DF_SOCKET_BZERO ZeroMemory
    #define DF_SOCKET_SLEEP Sleep
    #define DF_SOCKET_FD_ISSET(fd, set) __WSAFDIsSet((SOCKET)(fd), (fd_set *)(set))
#else
    #define DF_SOCKET_CLOSE close
    #define DF_SOCKET_IOCTL ioctl
    #define DF_SOCKET_BZERO bzero    
    #define DF_SOCKET_SLEEP sleep
    #define DF_SOCKET_FD_ISSET(fd, set) fd_isset(fd, (fd_set *)(set))
#endif

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef WIN32
 #define CALLBACK    
#endif

#define DF_SOCKET_NO_ERROR      0x0000
#define DF_SOCKET_CONNECTED     0x0001
#define DF_SOCKET_DISCONNECTED  0x0002
#define DF_SOCKET_TIMEOUT       0x0003
#define DF_SOCKET_ERROR         0x0004

typedef void (CALLBACK *LPDFSOCKET_CALLBACK)(void*, int, const char*, int);

class CDFSocketClient : public CDFThread  
{
public:
	CDFSocketClient();
	virtual ~CDFSocketClient();
    int Connect();
    int CloseSocket();
    int GetSocketHandle();
    int Send(const char *pBuffer, int nLength);
    int Receive(char *pBuffer, int nLength);        
    int CreateSocket(const char* strHostName, int nPort);
    int SocketFromHandle(int sockFd);
    int GetReceiveTimeout();
    bool GetSocketReusable();
    void SetSocketReusable(bool bSockReusable);
    void SetReceiveTimeout(int nTimeout);
    void SetSocketBufferSize(int nRxBufferSize, int nTxBufferSize);
    void SetSocketCallback(LPDFSOCKET_CALLBACK pCallback);
protected:	
    virtual void Run();
    virtual void OnReceive(const char* pBuffer, const int nLength);
    virtual void OnReceiveError();
    virtual void OnReceiveTimeout();
	virtual void OnDisconnected();
	virtual void OnThreadExit();	
	virtual int PreTranslateMessage(int &nMsg, char *pchContent, int &nSize);	
    int WaitForReceive(int nReceiveTimeout);
    int ReceiveStream(char** pszBuffer, int* pnLength, int nMaxLength);

private:
	unsigned int m_nTimeToSleep;	
    int m_nClientSockFd;
    fd_set m_sReadFds;
    int m_nReceiveTimeout;
    bool m_bSockReusable;
    bool m_bSockConnected;
    struct sockaddr_in m_sockAddr;
    LPDFSOCKET_CALLBACK m_pCallback;
};

#endif