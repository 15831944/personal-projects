#if !defined(AFX_UDPSENDSOCKET_H__81109981_4C5D_439D_94E0_7B2C722AC544__INCLUDED_)
#define AFX_UDPSENDSOCKET_H__81109981_4C5D_439D_94E0_7B2C722AC544__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// UDPSendSocket.h : header file
//



/////////////////////////////////////////////////////////////////////////////
// CUDPSendSocket command target

class CUDPSendSocket : public CAsyncSocket
{
// Attributes
public:
	bool m_bReadyToSend;
// Operations
public:
	CUDPSendSocket();
	virtual ~CUDPSendSocket();

// Overrides
public:
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CUDPSendSocket)
	public:
	virtual int Send(const void* lpBuf, int nBufLen, int nFlags = 0);
	virtual void OnSend(int nErrorCode);
	virtual void OnReceive(int nErrorCode);
	//}}AFX_VIRTUAL

	// Generated message map functions
	//{{AFX_MSG(CUDPSendSocket)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

// Implementation
protected:
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_UDPSENDSOCKET_H__81109981_4C5D_439D_94E0_7B2C722AC544__INCLUDED_)
