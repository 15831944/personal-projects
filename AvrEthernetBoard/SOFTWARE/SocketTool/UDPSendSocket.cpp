// UDPSendSocket.cpp : implementation file
//

#include "stdafx.h"
#include "SocketTool.h"
#include "UDPSendSocket.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CUDPSendSocket

CUDPSendSocket::CUDPSendSocket()
{
	// Create a socket for sending       
	// **DO NOT SPECIFY DESTINATION ADDRESS HERE**       
	BOOL bRet = Create(0,SOCK_DGRAM,FD_WRITE);       
	if (bRet != TRUE)       
	{              
		UINT uErr = GetLastError();              
		TCHAR szError[256];              
		wsprintf(szError, "Send Socket Create() failed: %d", uErr);              
		AfxMessageBox(szError);       
	}

}

CUDPSendSocket::~CUDPSendSocket()
{
}


// Do not edit the following lines, which are needed by ClassWizard.
#if 0
BEGIN_MESSAGE_MAP(CUDPSendSocket, CAsyncSocket)
	//{{AFX_MSG_MAP(CUDPSendSocket)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
#endif	// 0

/////////////////////////////////////////////////////////////////////////////
// CUDPSendSocket member functions

int CUDPSendSocket::Send(const void* lpBuf, int nBufLen, int nFlags) 
{
	if ( ! m_bReadyToSend )              
		return(false);        
	m_bReadyToSend = false;        
	int dwBytes;

	CAsyncSocket *paSocket = this;
	// Specify destination here (IP number obscured - could use computer name instead)
	if ((dwBytes = CAsyncSocket::SendTo((LPCTSTR)lpBuf,nBufLen,2201,"192.168.1.10")) == SOCKET_ERROR)       
	{
		UINT uErr = GetLastError();
		if (uErr != WSAEWOULDBLOCK) 
		{                     
			TCHAR szError[256];                     
			wsprintf(szError, "Server Socket failed to send: %d", uErr);                     
			AfxMessageBox(szError);              
		}
		return(false);
	}       

	return(true);	
}

void CUDPSendSocket::OnSend(int nErrorCode) 
{
	m_bReadyToSend = true;    // The socket is now ready to send       
	
	CAsyncSocket::OnSend(nErrorCode);
}

void CUDPSendSocket::OnReceive(int nErrorCode) 
{
		
	CAsyncSocket::OnReceive(nErrorCode);
}
