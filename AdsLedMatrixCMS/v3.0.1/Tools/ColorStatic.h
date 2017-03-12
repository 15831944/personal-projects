#if !defined(AFX_COLORSTATIC_H__054AB333_0ADC_484D_99B3_08CC71F6D64F__INCLUDED_)
#define AFX_COLORSTATIC_H__054AB333_0ADC_484D_99B3_08CC71F6D64F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// ColorStatic.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CColorStatic window

class CColorStatic : public CStatic
{
// Construction
public:
	CColorStatic();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CColorStatic)
	//}}AFX_VIRTUAL

// Implementation
public:
	void SetColorBk(COLORREF clr){m_clrBk = clr;}
	COLORREF GetColorBk(){return m_clrBk;}
	virtual ~CColorStatic();

	// Generated message map functions
protected:
	//{{AFX_MSG(CColorStatic)
	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	afx_msg void OnPaint();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	COLORREF m_clrBk;
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COLORSTATIC_H__054AB333_0ADC_484D_99B3_08CC71F6D64F__INCLUDED_)
