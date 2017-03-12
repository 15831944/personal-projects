// ConfigAppDlg.h : header file
//

#if !defined(AFX_CONFIGAPPDLG_H__F499CECB_940B_4DB5_B5E5_AEC9660C658F__INCLUDED_)
#define AFX_CONFIGAPPDLG_H__F499CECB_940B_4DB5_B5E5_AEC9660C658F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CConfigAppDlg dialog

class CConfigAppDlg : public CDialog
{
// Construction
public:
	CString m_csAppFile;
	CConfigAppDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CConfigAppDlg)
	enum { IDD = IDD_CONFIGAPP_DIALOG };
	CString	m_csFileBMP;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CConfigAppDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CConfigAppDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	afx_msg void OnButtonBrowse();	
	afx_msg void OnButtonIdcLoadapp();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CONFIGAPPDLG_H__F499CECB_940B_4DB5_B5E5_AEC9660C658F__INCLUDED_)
