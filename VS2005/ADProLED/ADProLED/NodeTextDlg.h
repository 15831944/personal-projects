#pragma once
#include "nodetextpreview.h"
#include "afxwin.h"


// CNodeTextDlg dialog

class CNodeTextDlg : public CDialog
{
	DECLARE_DYNAMIC(CNodeTextDlg)

public:
	CNodeTextDlg(CWnd* pParent = NULL);   // standard constructor
	virtual ~CNodeTextDlg();	
// Dialog Data
	enum { IDD = IDD_NODETEXT_DLG };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnEnChangeEditText();
	afx_msg void OnEnChangeEditFontFace();
	afx_msg void OnEnChangeEditFontStyle();
	afx_msg void OnEnChangeEditFontSize();
	afx_msg void OnLbnSelchangeListFontFace();
	afx_msg void OnLbnSelchangeListFontStyle();
	afx_msg void OnLbnSelchangeListFontSize();
	afx_msg void OnEnChangeEditNodeDistance();	
public:
	CNodeTextPreview m_ctrlNodeTextPrv;
	CString m_csText;
	CString m_csFontFace;
	CString m_csFontStyle;
	CString m_csFontSize;
public:
	int m_nNodeSize;
	int m_nDistance;
	float m_nX;
	float m_nY;
	float m_nZ;
public:
	virtual BOOL OnInitDialog();
	afx_msg void OnBnClickedOk();
	CListBox m_ctrlFontFaceList;
	CListBox m_ctrlFontStyleList;
	CListBox m_ctrlFontSizeList;
public:	
};
