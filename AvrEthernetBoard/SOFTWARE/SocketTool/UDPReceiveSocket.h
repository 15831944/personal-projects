#if !defined(AFX_UDPRECEIVESOCKET_H__073DDA54_54C9_43E6_A5BA_3C1BD4648E66__INCLUDED_)
#define AFX_UDPRECEIVESOCKET_H__073DDA54_54C9_43E6_A5BA_3C1BD4648E66__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// UDPReceiveSocket.h : header file
//

#include <afxtempl.h>

/////////////////////////////////////////////////////////////////////////////
// CUDPReceiveSocket command target

class CUDPReceiveSocket : public CAsyncSocket
{
// Attributes
public:
	bool m_bReadyToSend;
	CDialog* m_pDlg;
// Operations
public:
	CUDPReceiveSocket();
	virtual ~CUDPReceiveSocket();

// Overrides
public:
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CUDPReceiveSocket)
	public:
	virtual void OnReceive(int nErrorCode);
	virtual int Send(const void* lpBuf, int nBufLen, int nFlags = 0);
	//}}AFX_VIRTUAL

	// Generated message map functions
	//{{AFX_MSG(CUDPReceiveSocket)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

// Implementation
protected:
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_UDPRECEIVESOCKET_H__073DDA54_54C9_43E6_A5BA_3C1BD4648E66__INCLUDED_)
