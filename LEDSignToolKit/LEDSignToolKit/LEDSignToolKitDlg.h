// LEDSignToolKitDlg.h : header file
//

#if !defined(AFX_LEDSIGNTOOLKITDLG_H__BFD30A6B_BC1B_485B_8067_FAC3CF5D7F27__INCLUDED_)
#define AFX_LEDSIGNTOOLKITDLG_H__BFD30A6B_BC1B_485B_8067_FAC3CF5D7F27__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "ColorCombo.h"
#include "LEDTextCtrl.h"
#include "LEDSignCtrl.h"
#include "PageNumber.h"
#include "SerialMFC.h"
/////////////////////////////////////////////////////////////////////////////
// CLEDSignToolKitDlg dialog

class CLEDSignToolKitDlg : public CDialog
{
// Construction
public:
	int m_nCurrentPage;
	CLEDSignToolKitDlg(CWnd* pParent = NULL);	// standard constructor
	CSerialMFC m_Serial;
// Dialog Data
	//{{AFX_DATA(CLEDSignToolKitDlg)
	enum { IDD = IDD_LEDSIGNTOOLKIT_DIALOG };
	CPageNumber	m_ctlCurrentPage;
	CColorCombo	m_ctlComboLEDText;
	CLEDSignCtrl	m_ctlLEDSign;
	CLEDTextCtrl	m_ctlLEDText;
	int		m_nLEDColorText;
	CString	m_strSampleText;	
	int		m_nNumOfCol;
	int		m_nNumOfRow;
	int		m_nNumOfPage;
	int		m_nCommPort;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLEDSignToolKitDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	void DownloadToDevice();
	void GenerateCformat(CFile& file, const CString& strFileName);
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CLEDSignToolKitDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnClose();
	afx_msg void OnCloseupComboColorText();
	afx_msg void OnChangeEditLedText();
	afx_msg void OnButtonStart();	
	afx_msg void OnButtonNextPage();
	afx_msg void OnButtonPrevPage();
	afx_msg void OnButtonExportTo();
	afx_msg void OnButtonImportFrom();
	afx_msg void OnButtonGenCode();
	afx_msg void OnButtonSet();
	afx_msg void OnFileOpen();
	afx_msg void OnFileSave();
	//}}AFX_MSG
	afx_msg LRESULT OnMsgTextCtrl (WPARAM wParam, LPARAM /*lParam*/);
	afx_msg LRESULT OnSerialMsg (WPARAM wParam, LPARAM lParam);

	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LEDSIGNTOOLKITDLG_H__BFD30A6B_BC1B_485B_8067_FAC3CF5D7F27__INCLUDED_)
