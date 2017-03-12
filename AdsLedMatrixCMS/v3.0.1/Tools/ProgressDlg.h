#if !defined(AFX_PROGRESSDLG_H__5AB524EE_92B4_449E_BCA1_416118403164__INCLUDED_)
#define AFX_PROGRESSDLG_H__5AB524EE_92B4_449E_BCA1_416118403164__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// ProgressDlg.h : header file
//
/////////////////////////////////////////////////////////////////////////////
// CProgressDlg dialog
#include "../PictureFire/resource.h"

class CProgressDlg : public CDialog
{
// Construction
public:
	CProgressDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CProgressDlg)
	enum { IDD = IDD_PROGRESS_DIALOG };
	CStatic	m_ctlProgress;
	CStatic	m_ctlText;
	CProgressCtrl	m_ctrlProgress;
	CString	m_csProgress;
	CString	m_csText;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CProgressDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CProgressDlg)
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PROGRESSDLG_H__5AB524EE_92B4_449E_BCA1_416118403164__INCLUDED_)
