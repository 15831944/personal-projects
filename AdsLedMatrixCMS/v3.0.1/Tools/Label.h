#if !defined(AFX_LABEL_H__63FC0EE7_E125_44CC_B603_2E4F910656A9__INCLUDED_)
#define AFX_LABEL_H__63FC0EE7_E125_44CC_B603_2E4F910656A9__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Label.h : header file
//

#define		LS_LABEL		0
#define		LS_CAPTION		1
/////////////////////////////////////////////////////////////////////////////
// CLabel window

class CLabel : public CStatic
{
// Construction
public:
	CLabel();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLabel)
	//}}AFX_VIRTUAL

// Implementation
public:
	BOOL m_bHighlight;
	void SetStyle(UINT nStyle = 0);
	void SetFontFace(LPCTSTR lpszFace);
	void SetTextHight(int nHeight);
	virtual ~CLabel();

	// Generated message map functions
protected:
	COLORREF m_clrText;
	UINT m_nStyle;
	CString m_strFontFace;
	int m_nHeight;
	//{{AFX_MSG(CLabel)
	afx_msg void OnPaint();
	afx_msg HBRUSH CtlColor(CDC* pDC, UINT nCtlColor);		
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LABEL_H__63FC0EE7_E125_44CC_B603_2E4F910656A9__INCLUDED_)
