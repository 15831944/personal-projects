// FontFireDlg.h : header file
//

#if !defined(AFX_FONTFIREDLG_H__D5B1559E_43E6_4594_8D41_BD893F97A6BF__INCLUDED_)
#define AFX_FONTFIREDLG_H__D5B1559E_43E6_4594_8D41_BD893F97A6BF__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "MatrixPreview.h"
#include "ScrollMatrix.h"
#include "FontEditor.h"
#include "DataEdit.h"
#include "FontListCtrl.h"
#include "FontDisp.h"	// Added by ClassView
/////////////////////////////////////////////////////////////////////////////
// CFontFireDlg dialog

class CFontFireDlg : public CDialog
{
// Construction
public:
	CFontDisp m_FontDisp;
	CString m_csFontFile;
	CImageList m_ImageList;
	CFontFireDlg(CWnd* pParent = NULL);	// standard constructor
	void SetFontList(LPCTSTR szFontName);
	CRect m_rectFrom;
    BOOL  m_bWireFrame;
// Dialog Data
	//{{AFX_DATA(CFontFireDlg)
	enum { IDD = IDD_FONTFIRE_DIALOG };
	CDataEdit m_EditPreview;
	CStaticCopyright	m_Affilate;
	CFontListCtrl	m_ListFont;
	UINT	m_nBrushSize;
	int		m_nSelectTool;
	UINT	m_nCharWidth;
	CString	m_csPreviewText;
	//}}AFX_DATA
	CScrollMatrix	m_ScrollMatrix;
	CMatrixPreview	m_MatrixPreview;
	CFontEditor		m_FontEditor;
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFontFireDlg)
	public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:		
	HACCEL m_hAccelerators;
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CFontFireDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnClose();
	afx_msg void OnFileOpenfont();
	afx_msg void OnFileSavefont();
	afx_msg void OnFileSaveas();
	afx_msg void OnClickListFont(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnRadioPen();
	afx_msg void OnRadioBrush();
	afx_msg void OnRadioSelect();
	afx_msg void OnRadioMove();
	afx_msg void OnRadioZoom();
	afx_msg void OnDeltaposSpinBrush(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnFileNewfont();
	afx_msg void OnButtonCopy();
	afx_msg void OnButtonPaste();
	afx_msg void OnButtonErase();
	afx_msg void OnButtonFill();
	afx_msg void OnDeltaposSpinCharWidth(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnFileAboutfontfireeditor();
	afx_msg void OnEditCopyobject();
	afx_msg void OnEditPasteobject();
	afx_msg void OnEditEraseobject();
	afx_msg void OnEditSelectobject();
	afx_msg void OnEditFillrect();
	afx_msg void OnEditZoomin();
	afx_msg void OnEditZoomout();
	afx_msg void OnHelpAboutfontfirev10();
	afx_msg void OnToolConvert();
	afx_msg void OnEditDeselectobject();
	afx_msg void OnChangeEditPreview();
	afx_msg void OnDestroy();
	afx_msg void OnButtonPreview();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FONTFIREDLG_H__D5B1559E_43E6_4594_8D41_BD893F97A6BF__INCLUDED_)
