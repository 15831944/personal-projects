#if !defined(AFX_ETHERNETPORT_H__FF23638E_3DD8_4461_B785_E0A5AAD3435F__INCLUDED_)
#define AFX_ETHERNETPORT_H__FF23638E_3DD8_4461_B785_E0A5AAD3435F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// EthernetPort.h : header file
//


/////////////////////////////////////////////////////////////////////////////
// CEthernetPort command target

class CEthernetPort : public CAsyncSocket
{
// Attributes
public:
	bool m_bReadyToSend;
	HWND m_hWndMsg;
// Operations
public:
	CEthernetPort();
	virtual ~CEthernetPort();

// Overrides
public:
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CEthernetPort)
	public:
	virtual void OnReceive(int nErrorCode);
	virtual void OnSend(int nErrorCode);
	virtual int Send(const void* lpBuf, int nBufLen, int nFlags = 0);
	//}}AFX_VIRTUAL

	// Generated message map functions
	//{{AFX_MSG(CEthernetPort)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

// Implementation
protected:
};

const UINT mg_nDefaultEthMsg = ::RegisterWindowMessage(_T("CEthernet_DefaultMsg_CUONGDD"));

#define ON_WM_ETHERNET(memberFxn)	\
	ON_REGISTERED_MESSAGE(mg_nDefaultEthMsg,memberFxn)

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ETHERNETPORT_H__FF23638E_3DD8_4461_B785_E0A5AAD3435F__INCLUDED_)
