#if !defined(AFX_STATICFRAME_H__EDA1EB22_DBA5_40DB_86E2_4AF994DF2A9E__INCLUDED_)
#define AFX_STATICFRAME_H__EDA1EB22_DBA5_40DB_86E2_4AF994DF2A9E__INCLUDED_

#include "DigiStatic.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// StaticFrame.h : header file
//
#define		MAX_ROW		20
#define		MAX_COL		78
#define		CEL_CX		12
#define		CEL_CY		20
/////////////////////////////////////////////////////////////////////////////
// CStaticFrame window

class CStaticFrame : public CStatic
{
// Construction
public:
	CStaticFrame();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CStaticFrame)
	//}}AFX_VIRTUAL

// Implementation
public:
	void InitLEDs();
	CDigiStatic m_LED[MAX_ROW][MAX_COL];
	virtual ~CStaticFrame();

	// Generated message map functions
protected:
	//{{AFX_MSG(CStaticFrame)
	afx_msg void OnPaint();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STATICFRAME_H__EDA1EB22_DBA5_40DB_86E2_4AF994DF2A9E__INCLUDED_)
