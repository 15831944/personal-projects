//////////////////////////////////////////////////////////////////////
// DFSocketClient.cpp implement for the DFSocketClient class.
//
//  Created by Duong Dinh Cuong on 4/25/12.
//  Copyright (c) 2012 Fsoft - G10. All rights reserved.
//
//////////////////////////////////////////////////////////////////////
#include "CDFSocketClient.h"

#define IDF_DEBUG_SOCKET

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

#define IDF_FRAGMENTED_TIMEOUT  500

CDFSocketClient::CDFSocketClient()
{
#ifdef WIN32
    WORD wVersionRequested;
    WSADATA wsaData;
    int err;

    /* Use the MAKEWORD(lowbyte, highbyte) macro declared in Windef.h */
    wVersionRequested = MAKEWORD(2, 2);

    err = WSAStartup(wVersionRequested, &wsaData);
    if (err != 0) {
        /* Tell the user that we could not find a usable */
        /* Winsock DLL.                                  */
        printf("CDFSocketClient::ctor - WSAStartup failed with error: %d\r\n", err);        
    }
#endif
	m_nTimeToSleep = 1;
    memset(&m_sockAddr, 0, sizeof(struct sockaddr_in));
    m_pCallback = NULL;
    m_nClientSockFd = -1;
    m_bSockConnected = false;
    m_bSockReusable = false;
}

CDFSocketClient::~CDFSocketClient()
{
    this->CloseSocket();
#ifdef WIN32
    WSACleanup();
#endif
}

//////////////////////////////////////////////////////////////////////
// Properties = [getter/setter]
//////////////////////////////////////////////////////////////////////

void CDFSocketClient::SetSocketCallback(LPDFSOCKET_CALLBACK pCallback)
{
    this->m_pCallback = pCallback;
}

void CDFSocketClient::SetReceiveTimeout(int nTimeout)
{      
    m_nReceiveTimeout = nTimeout;
}

void CDFSocketClient::SetSocketReusable(bool bSockReusable)
{
    m_bSockReusable = bSockReusable;
}

int CDFSocketClient::GetReceiveTimeout()
{
    return m_nReceiveTimeout;
}

bool CDFSocketClient::GetSocketReusable()
{
    return m_bSockReusable;
}

void CDFSocketClient::SetSocketBufferSize(int nRxBufferSize, int nTxBufferSize)
{
    setsockopt( m_nClientSockFd, SOL_SOCKET, SO_SNDBUF, (char *)&nRxBufferSize, sizeof(nRxBufferSize) );
    setsockopt( m_nClientSockFd, SOL_SOCKET, SO_RCVBUF, (char *)&nTxBufferSize, sizeof(nTxBufferSize) );
}

int CDFSocketClient::GetSocketHandle()
{
    return m_nClientSockFd;
}

//////////////////////////////////////////////////////////////////////
// Protected/Overridden Functions
//////////////////////////////////////////////////////////////////////

void CDFSocketClient::Run()
{
	int nMsg;
	int nSize;
    
	while(this->IsRunning())
	{		
		if(PreTranslateMessage(nMsg, NULL, nSize)!=-1)
		{
#ifndef WIN32
			pthread_testcancel();
#endif
		}
		 
        char *buffer = NULL;
        int nLength = -1;
        int nResult = this->WaitForReceive(INFINITE);
        if(nResult == 0){
            PostQuitMessage(this,true);
            if (m_bSockConnected)
                OnReceiveTimeout();
        }
        else if (nResult == -1){
            PostQuitMessage(this,true);
            if (m_bSockConnected)
                OnReceiveError();
        }
        else {
            nResult = ReceiveStream(&buffer, &nLength, INFINITE);
            if ((buffer != NULL) && (nLength > 0)){
                OnReceive(buffer, nLength);
                free(buffer);
                buffer = NULL;
            }
            else{
                if(nResult == 0){
                    PostQuitMessage(this,true);
                    if (m_bSockConnected)
                        OnReceiveTimeout();
                }
                else if (nResult == -1){
                    PostQuitMessage(this,true);
                    if (m_bSockConnected) {
                        OnReceiveError();
                    }
                }
            }
        }
		DF_SOCKET_SLEEP(0);
	}
}

int CDFSocketClient::PreTranslateMessage(int &nMsg, char *pchContent, int &nSize)
{
	return CDFThread::PreTranslateMessage(nMsg, pchContent,nSize);	
}

void CDFSocketClient::OnThreadExit()
{	
	CDFThread::OnDFThreadExit();
}

int CDFSocketClient::WaitForReceive(int nReceiveTimeout)
{
    DF_SOCKET_FD_ZERO(&m_sReadFds);
    DF_SOCKET_FD_SET(m_nClientSockFd,&m_sReadFds);
    
    if (nReceiveTimeout > 0) {
        struct timeval timeout; 
        timeout.tv_sec = nReceiveTimeout/1000;
        timeout.tv_usec = nReceiveTimeout%1000 * 1000;
        return DF_SOCKET_SELECT(FD_SETSIZE, &m_sReadFds, NULL, NULL, &timeout);			
    }
    return DF_SOCKET_SELECT(FD_SETSIZE, &m_sReadFds, NULL, NULL, NULL);			
}

int CDFSocketClient::ReceiveStream(char** pszBuffer, int* pnLength, int nMaxLength)
{
    char* buffer = NULL;
    int nReceivedLength = 0;
    int nPossibleRead= -1;
    int nBytesRead = 0;
    int nResult = -1;
    
    do {
        if(FD_ISSET(m_nClientSockFd, &m_sReadFds)) {
#ifdef WIN32
            DF_SOCKET_IOCTL(m_nClientSockFd, FIONREAD, (u_long*)&nPossibleRead);
#else
            DF_SOCKET_IOCTL(m_nClientSockFd, FIONREAD, &nPossibleRead);
#endif
            if (nPossibleRead > 0) {
                char* tempBuffer = (char*)malloc((1 + nReceivedLength + nPossibleRead)*sizeof(char));
                if (buffer != NULL) {
                    memcpy(tempBuffer, buffer, nReceivedLength*sizeof(char));
                    free(buffer); buffer = tempBuffer;
                }
                else{
                    buffer = tempBuffer;
                }
                nBytesRead = DF_SOCKET_RECV(m_nClientSockFd, buffer + nReceivedLength, nPossibleRead, MSG_WAITALL);
                printf("CDFSocketClient::ReceiveStream(%s) - BytesRead=%d\r\n", m_csObjectName, nBytesRead);
                if (nBytesRead > 0) {
                    nReceivedLength += nBytesRead;
                }
            }
        }
        if (nReceivedLength < nMaxLength) {
            printf("CDFSocketClient::ReceiveStream(%s) - WaitForReceive=%d\r\n", m_csObjectName, IDF_FRAGMENTED_TIMEOUT);
            nResult = this->WaitForReceive(IDF_FRAGMENTED_TIMEOUT); /* next packages timeout */
            if (nResult == -1) {
                PostQuitMessage(this,true);
                OnReceiveError();
                break;
            }
        }
        else {
            printf("CDFSocketClient::ReceiveStream(%s) - DONE with %d bytes!\r\n", m_csObjectName, nReceivedLength);
            if (nReceivedLength > 0) {
                nResult = 1; /* completely without WaitForReceive(). */
            } else if (nReceivedLength == 0) {
                /* no byte to read, socket error! */
            }
            break;
        }
    } while (nResult > 0);
    (*pszBuffer) = buffer; /* Recall the buffer pointer */
    (*pnLength) = nReceivedLength;

    return nResult;
}

void CDFSocketClient::OnReceive(const char* pBuffer, const int nLength)
{    
    if (m_pCallback != NULL) {
        m_pCallback(m_oAllArg.m_pArg, DF_SOCKET_NO_ERROR, pBuffer, nLength);
        printf("CDFSocketClient::OnReceive(%s) - %d byte(s)\r\n", m_csObjectName, nLength);
    }
}

void CDFSocketClient::OnReceiveError()
{
#ifdef WIN32
    const char* error = strerror(GetLastError());
#else
    const char* error = strerror(errno); 
#endif
    this->m_bRunning = false;
    this->m_bSockConnected = false;
    if (m_pCallback != NULL) {
        m_pCallback(m_oAllArg.m_pArg, DF_SOCKET_ERROR, error, strlen(error));
    }
    printf("CDFSocketClient::OnReceiveError(%s) - %d : %s\r\n", m_csObjectName, m_nClientSockFd, error);
}

void CDFSocketClient::OnReceiveTimeout()
{
    if (m_pCallback != NULL) {
        m_pCallback(m_oAllArg.m_pArg, DF_SOCKET_TIMEOUT, NULL, 0);
    }
    printf("CDFSocketClient::OnReceiveTimeout(%s) - %d\r\n", m_csObjectName, m_nClientSockFd);
}

void CDFSocketClient::OnDisconnected()
{
    if (m_nClientSockFd != -1) {        
	    DF_SOCKET_CLOSE(m_nClientSockFd);
	    DF_SOCKET_FD_CLR(m_nClientSockFd,&m_sReadFds);  
        this->m_bSockConnected = false;
        if (m_pCallback != NULL){
            m_pCallback(m_oAllArg.m_pArg, DF_SOCKET_DISCONNECTED, NULL, 0);
            m_pCallback = NULL;
        }
        printf("CDFSocketClient::OnDisconnected(%s) - %d\r\n", m_csObjectName, m_nClientSockFd);
    }
}

//////////////////////////////////////////////////////////////////////
// Public Functions
//////////////////////////////////////////////////////////////////////

int CDFSocketClient::SocketFromHandle(int sockFd)
{
     if (sockFd != -1){
        this->m_nClientSockFd = sockFd;
        DF_SOCKET_FD_ZERO(&m_sReadFds);
	    DF_SOCKET_FD_SET(m_nClientSockFd,&m_sReadFds);
        return 0;
     }
     return -1;
}

int CDFSocketClient::CreateSocket(const char* strHostName, int nPort)
{
    if (m_bSockReusable && m_bSockConnected) {
        return(int)0;
    }
    
    hostent *host;

    if ((m_nClientSockFd = DF_SOCKET_SOCKET(AF_INET, SOCK_STREAM, 0)) == -1)
	{
		printf("CDFSocketClient::CreateSocket(%s) - Error:%s\r\n", m_csObjectName, strerror(errno));		
		return -1;
	}

	if ((host=gethostbyname(strHostName)) == NULL)
	{
		printf("CDFSocketClient::CreateSocket(%s) - Error:%s\r\n", m_csObjectName, strerror(errno));		
		return -1;
	}

	m_sockAddr.sin_family = AF_INET;
	m_sockAddr.sin_port = htons(nPort);
	m_sockAddr.sin_addr = *((struct in_addr *)host->h_addr);
	DF_SOCKET_BZERO(&(m_sockAddr.sin_zero), 8);
#ifndef WIN32
    int sock_set_value = 1;
    int sock_buf_size = 0;
    socklen_t opt_size = sizeof(sock_buf_size);
    
    getsockopt(m_nClientSockFd, SOL_SOCKET, SO_SNDBUF, &sock_buf_size, &opt_size);
    printf("CDFSocketClient::CreateSocket(%s) - SO_SNDBUF=%d\r\n", m_csObjectName, sock_buf_size);
    getsockopt(m_nClientSockFd, SOL_SOCKET, SO_RCVBUF, &sock_buf_size, &opt_size);
    printf("CDFSocketClient::CreateSocket(%s) - SO_RCVBUF=%d\r\n", m_csObjectName, sock_buf_size);

    // We expect write failures to occur but we want to handle them where 
    // the error occurs rather than in a SIGPIPE handler.
    setsockopt(m_nClientSockFd, SOL_SOCKET, SO_NOSIGPIPE, (void *)&sock_set_value, sizeof(int));
    signal(SIGPIPE, SIG_IGN);
    
    /* Enable Blocking Mode O_NONBLOCK = OFF */
    int flags = fcntl(m_nClientSockFd, F_GETFL, 0);
    fcntl(m_nClientSockFd, F_SETFL, flags & (~O_NONBLOCK));
#endif     
    printf("CDFSocketClient::CreateSocket(%s) - Handle=%d\r\n", m_csObjectName, m_nClientSockFd);
     
    return (int)0;
}

int CDFSocketClient::Connect()
{
    if (m_bSockReusable && m_bSockConnected) {
        return(int)0;
    }
    
    if (m_nClientSockFd != -1)
    {
        fd_set fdset;
        struct timeval tv;
        
        fcntl(m_nClientSockFd, F_SETFL, O_NONBLOCK);
        
        DF_SOCKET_CONNECT(m_nClientSockFd, (struct sockaddr *)&m_sockAddr, sizeof(struct sockaddr));
        
        DF_SOCKET_FD_ZERO(&fdset);
        DF_SOCKET_FD_SET(m_nClientSockFd, &fdset);
        tv.tv_sec =  30;  /* 5 second timeout */
        tv.tv_usec = 0;
        
        if (DF_SOCKET_SELECT(m_nClientSockFd + 1, NULL, &fdset, NULL, &tv) > 0) {
            int so_error;
            socklen_t len = sizeof so_error;
            
            getsockopt(m_nClientSockFd, SOL_SOCKET, SO_ERROR, &so_error, &len);
            
            if (so_error == 0) {
                DF_SOCKET_FD_ZERO(&m_sReadFds);
                DF_SOCKET_FD_SET(m_nClientSockFd, &m_sReadFds);
                this->m_bSockConnected = true;
                if (m_pCallback != NULL){
                    m_pCallback(m_oAllArg.m_pArg, DF_SOCKET_CONNECTED, NULL, 0);
                }
                printf("CDFSocketClient::Connected(%s) - Handle=%d\r\n", m_csObjectName, m_nClientSockFd);
                
                return (int)0;
            }
        }
        printf("CDFSocketClient::Connect(%s) - Error:%s\r\n", m_csObjectName, strerror(errno));
        DF_SOCKET_CLOSE(m_nClientSockFd);
        if (m_pCallback != NULL){
            m_pCallback(m_oAllArg.m_pArg, DF_SOCKET_DISCONNECTED, NULL, 0);
            m_pCallback = NULL;
        }
        return -1;
        
        /*** Old version of blocking mode ***
	    if (DF_SOCKET_CONNECT(m_nClientSockFd, (struct sockaddr *)&m_sockAddr, sizeof(struct sockaddr)) == -1)
	    {
		    printf("CDFSocketClient::Connect(%s) - Error:%s\r\n", m_csObjectName, strerror(errno));
            DF_SOCKET_CLOSE(m_nClientSockFd);
            if (m_pCallback != NULL){
                m_pCallback(m_oAllArg.m_pArg, DF_SOCKET_DISCONNECTED, NULL, 0);
                m_pCallback = NULL;
            }
		    return -1;
	    }
        
	    DF_SOCKET_FD_ZERO(&m_sReadFds);
	    DF_SOCKET_FD_SET(m_nClientSockFd, &m_sReadFds);
        this->m_bSockConnected = true;
        if (m_pCallback != NULL){
            m_pCallback(m_oAllArg.m_pArg, DF_SOCKET_CONNECTED, NULL, 0);
            m_pCallback = NULL;
        }
        printf("CDFSocketClient::Connected(%s) - Handle=%d\r\n", m_csObjectName, m_nClientSockFd);
        
	    return (int)0; */
    }
    return -1;
}

int CDFSocketClient::CloseSocket()
{
    printf("CDFSocketClient::CloseSocket(%s) - Handle=%d\r\n", m_csObjectName, m_nClientSockFd);
    if (m_nClientSockFd != -1) {
        this->m_bSockConnected = false;
        DF_SOCKET_FD_CLR(m_nClientSockFd,&m_sReadFds);
        if ( DF_SOCKET_CLOSE(m_nClientSockFd) > 0) {
#ifdef WIN32
            const char* error = strerror(GetLastError());
#else
            const char* error = strerror(errno); 
#endif
            printf("CDFSocketClient::CloseSocket(%s) - %d : %s\r\n", m_csObjectName, m_nClientSockFd, error);
            return (int)-1;
        }
    }
    return (int)(0);
}

int CDFSocketClient::Send(const char *pBuffer, int nLength)
{
    int nResult = -1;
    int nBytesSent = 0;
    while (nBytesSent < nLength) {
        nResult = DF_SOCKET_SEND(m_nClientSockFd, pBuffer + nBytesSent, nLength - nBytesSent, 0);
        if (nResult > 0) {
            nBytesSent += nResult;
        }
        else {
            this->m_bSockConnected = false;
#ifdef WIN32
            const char* error = strerror(GetLastError());
#else
            const char* error = strerror(errno); 
#endif
            printf("CDFSocketClient::Send(%s) - %d : %s\r\n", m_csObjectName, m_nClientSockFd, error);
            return nResult;
        }
    }
    printf("CDFSocketClient::Sent(%s) - %d byte(s)\r\n", m_csObjectName, nBytesSent); 
    
    return (nLength - nBytesSent);
}

int CDFSocketClient::Receive(char *pBuffer, int nLength)
{
    int nResult = WaitForReceive(m_nReceiveTimeout);
    if(nResult > 0) {
        return DF_SOCKET_RECV(m_nClientSockFd, pBuffer, nLength, MSG_WAITALL);  
    }
    else if (nResult == 0) {
        this->OnReceiveTimeout();
    }
    else {
        this->OnDisconnected();
    }
    return (int)nResult;
}
