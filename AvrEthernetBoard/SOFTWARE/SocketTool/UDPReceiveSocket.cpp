// UDPReceiveSocket.cpp : implementation file
//

#include "stdafx.h"
#include "SocketTool.h"
#include "SocketToolDlg.h"
#include "UDPReceiveSocket.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CUDPReceiveSocket

CUDPReceiveSocket::CUDPReceiveSocket()
{
	BOOL bRet = FALSE;
	bRet = Create(2201,SOCK_DGRAM,FD_READ|FD_WRITE);       	
	if (bRet != TRUE){              
		UINT uErr = GetLastError();              
		TCHAR szError[256];              
		wsprintf(szError, "Server Receive Socket Create() failed: %d", uErr);              
		AfxMessageBox(szError);       
	}
	m_bReadyToSend = true;

}

CUDPReceiveSocket::~CUDPReceiveSocket()
{
}


// Do not edit the following lines, which are needed by ClassWizard.
#if 0
BEGIN_MESSAGE_MAP(CUDPReceiveSocket, CAsyncSocket)
	//{{AFX_MSG_MAP(CUDPReceiveSocket)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
#endif	// 0

/////////////////////////////////////////////////////////////////////////////
// CUDPReceiveSocket member functions

void CUDPReceiveSocket::OnReceive(int nErrorCode) 
{
	static int i=0;    
	i++;    
	TCHAR buff[4096];   
	int nRead;   
	CString strSendersIp="192.168.1.10";   
	UINT uSendersPort=1980;    
	// Could use Receive here if you don’t need the senders address & port   
	nRead = ReceiveFrom(buff, 4096, strSendersIp, uSendersPort);       
	switch (nRead)   
	{   
	case 0:       // Connection was closed.      
		Close();            
		break;   
	case SOCKET_ERROR:      
		if (GetLastError() != WSAEWOULDBLOCK)       
		{         
			AfxMessageBox ("Error occurred");         
			Close();      
		}      
		break;   
	default: // Normal case: Receive() returned the # of bytes received.      
		buff[nRead] = 0; //terminate the string (assuming a string for this example)      
		CString strReceivedData(buff);       // This is the input data    
		((CSocketToolDlg*)m_pDlg)->m_csReceive+=buff;
		((CSocketToolDlg*)m_pDlg)->UpdateData(FALSE);
	}
	
	TRACE("%s \n",buff);
	CAsyncSocket::OnReceive(nErrorCode);
}

int CUDPReceiveSocket::Send(const void* lpBuf, int nBufLen, int nFlags) 
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
