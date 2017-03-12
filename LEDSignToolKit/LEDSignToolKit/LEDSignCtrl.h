#if !defined(AFX_LEDSIGNCTRL_H__B9541DFA_4540_4064_82E6_152407872447__INCLUDED_)
#define AFX_LEDSIGNCTRL_H__B9541DFA_4540_4064_82E6_152407872447__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// LEDSignCtrl.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CLEDSignCtrl window

class CLEDSignCtrl : public CStatic
{
// Construction
public:
	CLEDSignCtrl();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLEDSignCtrl)
	//}}AFX_VIRTUAL

// Implementation
public:	
	void SetActiveRow(int nActiveRow);
	void SetParameters(int nRow, int nCol, int nPage);
	void SetCurrentPage(int nPage);
	int GetNumOfPage();
	virtual ~CLEDSignCtrl();
	// Generated message map functions
protected:
	void DrawDelay(CDC* pDC, int nDelay, const CRect& rect);
	//{{AFX_MSG(CLEDSignCtrl)
	afx_msg HBRUSH CtlColor(CDC* pDC, UINT nCtlColor);
	afx_msg void OnPaint();
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	//}}AFX_MSG

	void DrawGrid(CDC* pDC, const CPoint& point);
	void DrawLED(CDC* pDC, const CRect& rect, BOOL bLEDOn);

	DECLARE_MESSAGE_MAP()
private:
	int m_nActiveRow;
	UINT m_nCurrentPage;
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LEDSIGNCTRL_H__B9541DFA_4540_4064_82E6_152407872447__INCLUDED_)
