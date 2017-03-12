#if !defined(AFX_ADDCONTROLDLG_H__B55EEDAC_AD56_49F5_AE5B_F569703EB95C__INCLUDED_)
#define AFX_ADDCONTROLDLG_H__B55EEDAC_AD56_49F5_AE5B_F569703EB95C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// AddControlDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CAddControlDlg dialog

class CAddControlDlg : public CDialog
{
// Construction
public:
	CAddControlDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CAddControlDlg)
	enum { IDD = IDD_ADDCONTROL_DLG };
	CStaticFrame m_FrameCopy;
	UINT	m_nWidth;
	UINT	m_nHeight;
	int		m_nControlID;
	UINT	m_nNums;
	UINT	m_nDigits;
	CString	m_csFontName;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAddControlDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CAddControlDlg)
	afx_msg void OnAddControl();
	virtual BOOL OnInitDialog();
	afx_msg void OnButtonFont();
	afx_msg void OnFinish();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ADDCONTROLDLG_H__B55EEDAC_AD56_49F5_AE5B_F569703EB95C__INCLUDED_)
