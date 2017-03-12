#if !defined(AFX_STATICCOPYRIGHT_H__0AD05476_EEAF_4921_B99E_0CF128B7E77D__INCLUDED_)
#define AFX_STATICCOPYRIGHT_H__0AD05476_EEAF_4921_B99E_0CF128B7E77D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// StaticCopyright.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CStaticCopyright window

class CStaticCopyright : public CStatic
{
// Construction
public:
	CStaticCopyright();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CStaticCopyright)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CStaticCopyright();

	// Generated message map functions
protected:
	//{{AFX_MSG(CStaticCopyright)
	afx_msg HBRUSH CtlColor(CDC* pDC, UINT nCtlColor);
	afx_msg void OnPaint();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STATICCOPYRIGHT_H__0AD05476_EEAF_4921_B99E_0CF128B7E77D__INCLUDED_)
