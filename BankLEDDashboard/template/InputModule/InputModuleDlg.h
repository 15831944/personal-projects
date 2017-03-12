// InputModuleDlg.h : header file
//

#if !defined(AFX_INPUTMODULEDLG_H__C1929B57_B0DD_4EC4_AFC1_891566CE7B41__INCLUDED_)
#define AFX_INPUTMODULEDLG_H__C1929B57_B0DD_4EC4_AFC1_891566CE7B41__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "../GeneralCtrl/LEDEdit.h"
#include "../GeneralCtrl/StaticEdit.h"
#include "../GeneralCtrl/MatrixEdit.h"
/////////////////////////////////////////////////////////////////////////////
// CInputModuleDlg dialog

class CInputModuleDlg : public CDialog
{
// Construction
public:
	CInputModuleDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CInputModuleDlg)
	enum { IDD = IDD_INPUTMODULE_DIALOG };
	CStaticEdit	m_Text;
	CMatrixEdit	m_ctrlMatrixEdit;
	CLEDEdit	m_Digit;	
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CInputModuleDlg)
	public:
	virtual BOOL DestroyWindow();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CInputModuleDlg)
	virtual BOOL OnInitDialog();	
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButtonOnoff();
	afx_msg void OnButton1();
	afx_msg void OnOk();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_INPUTMODULEDLG_H__C1929B57_B0DD_4EC4_AFC1_891566CE7B41__INCLUDED_)
