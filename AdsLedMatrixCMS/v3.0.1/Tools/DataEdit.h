#if !defined(AFX_DATAEDIT_H__FCAB6CA2_2A03_4D20_8D8B_C74077E608DB__INCLUDED_)
#define AFX_DATAEDIT_H__FCAB6CA2_2A03_4D20_8D8B_C74077E608DB__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DataEdit.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDataEdit window

class CDataEdit : public CEdit
{
// Construction
public:
	CDataEdit();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDataEdit)
	public:
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CDataEdit();
	// Generated message map functions
protected:	
	//{{AFX_MSG(CDataEdit)
	afx_msg HBRUSH CtlColor(CDC* pDC, UINT nCtlColor);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	CFont m_font;
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DATAEDIT_H__FCAB6CA2_2A03_4D20_8D8B_C74077E608DB__INCLUDED_)
