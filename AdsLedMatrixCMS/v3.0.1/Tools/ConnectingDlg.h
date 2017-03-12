#if !defined(AFX_CONNECTINGDLG_H__94F73434_B85A_4950_A2F2_A905AFAB253E__INCLUDED_)
#define AFX_CONNECTINGDLG_H__94F73434_B85A_4950_A2F2_A905AFAB253E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// ConnectingDlg.h : header file
//
#include "../PictureFire/resource.h"
/////////////////////////////////////////////////////////////////////////////
// CConnectingDlg dialog

class CConnectingDlg : public CDialog
{
// Construction
public:
	int m_nDelayTime;
	CConnectingDlg(int nDelayTime, CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CConnectingDlg)
	enum { IDD = IDD_CONNECTING_STATUS };
	CAnimateCtrl	m_ctrlAVI;
	CString	m_csStatusText;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CConnectingDlg)
	public:
	virtual BOOL DestroyWindow();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CConnectingDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnClose();
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnDestroy();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CONNECTINGDLG_H__94F73434_B85A_4950_A2F2_A905AFAB253E__INCLUDED_)
