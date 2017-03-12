// EthernetPort.cpp : implementation file
//

#include "stdafx.h"
#include "DigiLED.h"
#include "EthernetPort.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CEthernetPort

CEthernetPort::CEthernetPort()
{
	BOOL bRet = FALSE;
	bRet = Create(_stData.m_nClientPort,SOCK_DGRAM,FD_READ|FD_WRITE);       	
	if (bRet != TRUE){              
		UINT uErr = GetLastError();              
		TCHAR szError[256];              
		wsprintf(szError, _T("Server Receive Socket Create() failed: %d"), uErr);              
		AfxMessageBox(szError);       
	}
	m_bReadyToSend = true;
}

CEthernetPort::~CEthernetPort()
{
}


// Do not edit the following lines, which are needed by ClassWizard.
#if 0
BEGIN_MESSAGE_MAP(CEthernetPort, CAsyncSocket)
	//{{AFX_MSG_MAP(CEthernetPort)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
#endif	// 0

/////////////////////////////////////////////////////////////////////////////
// CEthernetPort member functions

void CEthernetPort::OnReceive(int nErrorCode) 
{	
	::SendMessage(m_hWndMsg,mg_nDefaultEthMsg,WPARAM(0),LPARAM(nErrorCode));	
	
	CAsyncSocket::OnReceive(nErrorCode);
}

void CEthernetPort::OnSend(int nErrorCode) 
{
	CAsyncSocket::OnSend(nErrorCode);
}

int CEthernetPort::Send(const void* lpBuf, int nBufLen, int nFlags) 
{
	if ( ! m_bReadyToSend )              
		return(false);        
	m_bReadyToSend = false;      
	int dwBytes;

	CAsyncSocket *paSocket = this;
	// Specify destination here (IP number obscured - could use computer name instead)
	if ((dwBytes = CAsyncSocket::SendTo((LPCTSTR)lpBuf,nBufLen,_stData.m_nClientPort,_stData.m_csClientIp)) == SOCKET_ERROR)       
	{
		UINT uErr = GetLastError();
		if (uErr != WSAEWOULDBLOCK) 
		{                     
			TCHAR szError[256];                     
			wsprintf(szError, _T("Can not send to %s on port %d ."),_stData.m_csClientIp,_stData.m_nClientPort);                     
			AfxMessageBox(szError);              
		}
		return(false);
	}       
	Sleep(1);
	return(true);	
}
