// SocketToolDlg.h : header file
//

#if !defined(AFX_SOCKETTOOLDLG_H__1A72E6A7_329B_4FD6_B0D2_81B926836A49__INCLUDED_)
#define AFX_SOCKETTOOLDLG_H__1A72E6A7_329B_4FD6_B0D2_81B926836A49__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "UDPSendSocket.h"
#include "UDPReceiveSocket.h"
/////////////////////////////////////////////////////////////////////////////
// CSocketToolDlg dialog

class CSocketToolDlg : public CDialog
{
// Construction
public:
	CSocketToolDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CSocketToolDlg)
	enum { IDD = IDD_SOCKETTOOL_DIALOG };
	CString	m_csSend;
	CString	m_csReceive;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSocketToolDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	CUDPReceiveSocket       m_ReceiveSocket;       
	CUDPSendSocket          m_SendSocket;       


	// Generated message map functions
	//{{AFX_MSG(CSocketToolDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SOCKETTOOLDLG_H__1A72E6A7_329B_4FD6_B0D2_81B926836A49__INCLUDED_)
