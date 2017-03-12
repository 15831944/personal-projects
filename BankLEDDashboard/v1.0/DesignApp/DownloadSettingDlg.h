#if !defined(AFX_DOWNLOADSETTINGDLG_H__7FF01F65_8A5B_46E3_92CB_293E38721324__INCLUDED_)
#define AFX_DOWNLOADSETTINGDLG_H__7FF01F65_8A5B_46E3_92CB_293E38721324__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DownloadSettingDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDownloadSettingDlg dialog

class CDownloadSettingDlg : public CDialog
{
// Construction
public:
	void SetTitleText(LPCTSTR szTitle);
	CDownloadSettingDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CDownloadSettingDlg)
	enum { IDD = IDD_DIALOG_DOWNLOAD };
	int		m_nPage;
	int		m_nShowTime;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDownloadSettingDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CDownloadSettingDlg)
	virtual BOOL OnInitDialog();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	CString m_csTitleText;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DOWNLOADSETTINGDLG_H__7FF01F65_8A5B_46E3_92CB_293E38721324__INCLUDED_)
