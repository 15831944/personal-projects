// CFGTOOLDlg.h : header file
//

#if !defined(AFX_CFGTOOLDLG_H__F1D5EB61_D786_40B6_8C17_7659C519CA3B__INCLUDED_)
#define AFX_CFGTOOLDLG_H__F1D5EB61_D786_40B6_8C17_7659C519CA3B__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "DigiStatic.h" 
#include "StaticFrame.h"
#include "SerialMFC.h"	// Added by ClassView
/////////////////////////////////////////////////////////////////////////////
// CCFGTOOLDlg dialog

class CCFGTOOLDlg : public CDialog
{
// Construction
public:
	int m_nPoint[4];
	CCFGTOOLDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CCFGTOOLDlg)
	enum { IDD = IDD_CFGTOOL_DIALOG };
	CStaticFrame	m_Frame;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCFGTOOLDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	void DoFormat(int value,BYTE* buffer);
	HICON m_hIcon;

	CSerialMFC m_Serial;
	// Generated message map functions
	//{{AFX_MSG(CCFGTOOLDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnClose();
	//}}AFX_MSG
	afx_msg LRESULT OnSerialMsg (WPARAM wParam, LPARAM lParam);

	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CFGTOOLDLG_H__F1D5EB61_D786_40B6_8C17_7659C519CA3B__INCLUDED_)
