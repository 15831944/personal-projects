#if !defined(AFX_COLORTEXT_H__3038332F_DFFA_45A2_869D_44A01CD59450__INCLUDED_)
#define AFX_COLORTEXT_H__3038332F_DFFA_45A2_869D_44A01CD59450__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// ColorText.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CColorText window

class CColorText : public CStatic
{
// Construction
public:
	CColorText();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CColorText)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CColorText();

	// Generated message map functions
protected:
	//{{AFX_MSG(CColorText)
	afx_msg HBRUSH CtlColor(CDC* pDC, UINT nCtlColor);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COLORTEXT_H__3038332F_DFFA_45A2_869D_44A01CD59450__INCLUDED_)
