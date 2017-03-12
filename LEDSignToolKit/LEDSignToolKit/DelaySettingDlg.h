#if !defined(AFX_DELAYSETTINGDLG_H__9C6E20F6_48E3_40B5_8E9B_8F30CB0EA3A5__INCLUDED_)
#define AFX_DELAYSETTINGDLG_H__9C6E20F6_48E3_40B5_8E9B_8F30CB0EA3A5__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DelaySettingDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDelaySettingDlg dialog

class CDelaySettingDlg : public CDialog
{
// Construction
public:
	CDelaySettingDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CDelaySettingDlg)
	enum { IDD = IDD_DIALOG_DELAY };
	int		m_nDelay;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDelaySettingDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CDelaySettingDlg)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DELAYSETTINGDLG_H__9C6E20F6_48E3_40B5_8E9B_8F30CB0EA3A5__INCLUDED_)
