#if !defined(AFX_PAGENUMBER_H__19BA2979_EE70_4FFE_965C_8EAEFA790AC9__INCLUDED_)
#define AFX_PAGENUMBER_H__19BA2979_EE70_4FFE_965C_8EAEFA790AC9__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// PageNumber.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CPageNumber window

class CPageNumber : public CStatic
{
// Construction
public:
	CPageNumber();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CPageNumber)
	//}}AFX_VIRTUAL

// Implementation
public:
	void SetCurrentPage(int nPage);
	virtual ~CPageNumber();

	// Generated message map functions
protected:
	//{{AFX_MSG(CPageNumber)
	afx_msg void OnPaint();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	UINT m_nPageNo;
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_PAGENUMBER_H__19BA2979_EE70_4FFE_965C_8EAEFA790AC9__INCLUDED_)
