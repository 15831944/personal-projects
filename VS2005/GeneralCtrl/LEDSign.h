#if !defined(AFX_LEDSIGN_H__3262DA37_2A55_4DFC_A2DD_08419BF50315__INCLUDED_)
#define AFX_LEDSIGN_H__3262DA37_2A55_4DFC_A2DD_08419BF50315__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// LEDSign.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CLEDSign window

class CLEDSign : public CStatic
{
// Construction
public:
	CLEDSign();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLEDSign)
	//}}AFX_VIRTUAL

// Implementation
public:
	void RedrawPanel();
	virtual ~CLEDSign();

	// Generated message map functions
protected:
	//{{AFX_MSG(CLEDSign)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LEDSIGN_H__3262DA37_2A55_4DFC_A2DD_08419BF50315__INCLUDED_)
