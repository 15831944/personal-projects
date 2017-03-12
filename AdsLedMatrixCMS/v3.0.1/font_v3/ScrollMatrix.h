#if !defined(AFX_SCROLLMATRIX_H__40BB2DA9_1266_4D15_9F93_E503F663B262__INCLUDED_)
#define AFX_SCROLLMATRIX_H__40BB2DA9_1266_4D15_9F93_E503F663B262__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// ScrollMatrix.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CScrollMatrix window

class CScrollMatrix : public CStatic
{
// Construction
public:
	CScrollMatrix();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CScrollMatrix)
	public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	//}}AFX_VIRTUAL

// Implementation
public:
	void InitScroll(CWnd* pWnd);
	virtual ~CScrollMatrix();

	// Generated message map functions
protected:
	CScrollBar* m_pHScroll;
	CScrollBar* m_pVScroll;
	//{{AFX_MSG(CScrollMatrix)
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnPaint();	
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	CWnd* m_pChildWnd;
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SCROLLMATRIX_H__40BB2DA9_1266_4D15_9F93_E503F663B262__INCLUDED_)
