#if !defined(AFX_3IMATRIXEDIT_H__48A9A9B8_60EF_4279_8C44_3DA3EE82FB62__INCLUDED_)
#define AFX_3IMATRIXEDIT_H__48A9A9B8_60EF_4279_8C44_3DA3EE82FB62__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// 3iMatrixEdit.h : header file
//
#include "3iMatrix.h"

#define		SELECT_PEN			0
#define		SELECT_MARQUEE		1
#define		SELECT_BRUSH		2
#define		SELECT_TEXT			3
#define		SELECT_MOVE			4
#define		SELECT_ZOOM			5
/////////////////////////////////////////////////////////////////////////////
// C3iMatrixEdit window

class C3iMatrixEdit : public C3iMatrix
{
// Construction
public:
	C3iMatrixEdit();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(C3iMatrixEdit)
	//}}AFX_VIRTUAL

// Implementation
public:	
	void Zoom(int nLevel);
	void FillRect();	
	void SetBrushSize(UINT nBrushSize);
	void PasteObject();
	void CopyObject();
	void EraseObject();
	void ReleaseObject();
	void SelectTool(UINT nTool);		
	virtual ~C3iMatrixEdit();

	// Generated message map functions
protected:	
	virtual void OnMovingZoom(UINT nFlags, CPoint point);
	virtual void OnSelectZoom(UINT nFlags, CPoint point);
	virtual void SetBrush(int x0, int y0, int nSize, COLORREF clr);
	virtual void OnMovingText(UINT nFlags, CPoint point);
	virtual void OnMovingBrush(UINT nFlags, CPoint point);
	virtual void OnReleaseText(UINT nFlags, CPoint point);
	virtual void OnReleaseBrush(UINT nFlags, CPoint point);
	virtual void OnSelectText(UINT nFlags, CPoint point);
	virtual void OnSelectBrush(UINT nFlags, CPoint point);
	void ReleaseCopyBuffer(int cx, int cy);
	void InitCopyBuffer(int cx, int cy);
	virtual void PasteObject(int x1, int y1, int cx, int cy);
	virtual void CopyObject(int x0, int y0, int cx, int cy);
	virtual void FillRect(int x0, int y0, int cx, int cy, COLORREF clr);
	virtual void EraseObject(int x0, int y0, int cx, int cy);
	virtual void OnReleaseObject(UINT nFlags, CPoint point);
	virtual void OnReleaseMarquee(UINT nFlags, CPoint point);
	virtual void OnSelectObject(UINT nFlags, CPoint point);
	virtual void OnSelectMarquee(UINT nFlags, CPoint point);
	virtual void OnSelectPen(UINT nFlags, CPoint point);
	virtual void OnMovingObject(UINT nFlags, CPoint point);
	virtual void OnMovingMarquee(UINT nFlags, CPoint point);
	void DrawMarqueeRect(BOOL bInit=FALSE);

	//{{AFX_MSG(C3iMatrixEdit)
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnPaint();
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	//}}AFX_MSG

	UINT m_nBrushSize;

	DECLARE_MESSAGE_MAP()
private:	
	COLORREF** m_pCopyBuffer;
	CRect m_rcOrgObject;
	CPoint m_ptMoving;
	BOOL m_bMarqueeDone;
	CRect m_rcMarquee;
	UINT m_nTool;
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_3IMATRIXEDIT_H__48A9A9B8_60EF_4279_8C44_3DA3EE82FB62__INCLUDED_)
