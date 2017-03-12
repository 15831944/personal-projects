#if !defined(AFX_FONTLISTCTRL_H__D1412018_2B89_4E3D_B148_F75C3738A038__INCLUDED_)
#define AFX_FONTLISTCTRL_H__D1412018_2B89_4E3D_B148_F75C3738A038__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// FontListCtrl.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CFontListCtrl window

class CFontListCtrl : public CListCtrl
{
// Construction
public:
	CFontListCtrl();

// Attributes
public:

public:
	enum EHighlight {HIGHLIGHT_NORMAL, HIGHLIGHT_ALLCOLUMNS, HIGHLIGHT_ROW};
protected:
	int  m_nHighlight;		// Indicate type of selection highlighting

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFontListCtrl)
	protected:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	//}}AFX_VIRTUAL

// Implementation
public:
	BOOL SetFontList(LPCTSTR szFontName);
	virtual ~CFontListCtrl();

	// Generated message map functions
protected:
	CFont m_font;
	//{{AFX_MSG(CFontListCtrl)
	afx_msg void OnPaint();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FONTLISTCTRL_H__D1412018_2B89_4E3D_B148_F75C3738A038__INCLUDED_)
