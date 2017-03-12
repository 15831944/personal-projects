#if !defined(AFX_3IMATRIX_H__CBE428F7_7C0F_4131_BD76_4C6CA9E9D47E__INCLUDED_)
#define AFX_3IMATRIX_H__CBE428F7_7C0F_4131_BD76_4C6CA9E9D47E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// 3iMatrix.h : header file
//
#include "LineColor.h"


#define		LINE_RED		1
#define		LINE_GREEN		2
#define		LINE_BLUE		4

////////////////////////////////////////////////
// C3iMatrix window

class C3iMatrix : public CStatic
{
// Construction
public:
	C3iMatrix();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(C3iMatrix)
	public:
	virtual BOOL DestroyWindow();
	//}}AFX_VIRTUAL

// Implementation
public:	
	BOOL GetDataMap(void *pBuffer, int nSize);
	virtual void SetPixel(int x, int y, COLORREF clr);
	void SetColorPen(COLORREF clr){m_clrPen = clr;}
	void SetColorBrush(COLORREF clr){m_clrBrush = clr;}
	COLORREF GetColorPen()const {return m_clrPen;}
	void SetLineMode(int nMode){m_nLineMode = nMode;}
	void SetZoomScale(int nZoom){m_nZoomScale = nZoom;}
	LINE_LIST* GetCurLineList()const {return (LINE_LIST*)m_pCurLineList;}
	void SetCurLineList(LINE_LIST* pLineList){m_pCurLineList=pLineList;}
	virtual void DrawFrame(BOOL bRefresh=TRUE);
	void ReCalcMatrixClient();
	void DrawTest();
	BOOL Init(int cx, int cy, int nLineMode, int nZoom=1);
	BOOL RemoveDataLine();	
	void SetSizeInPixel(int cx, int cy){m_sizePixel = CSize(cx,cy);}
	virtual ~C3iMatrix();	
	// Generated message map functions
protected:
	virtual void OnProcessBuffer(PBYTE pBuffer, int nSize, int nColor, int cx, int cy)=0;
	virtual BOOL InitLineList(LINE_LIST* pLineList);
	virtual BOOL OnSetPixel(UINT nFlags, int x, int y);
	virtual CPoint OnChangePosition(int x, int y)=0;
	void ReleaseDataLine(LINE_LIST* pLineList);	
	BOOL AddDataLine(LINE_LIST *pLineList,CShiftReg *pLR, CShiftReg *pLG, CShiftReg *pLB);
	void DrawPixel(const COLORREF& clr, int x, int y, BOOL bDraw=FALSE);
	CPoint m_ptPosition;
	LINE_LIST m_arrLineList;
	LINE_LIST* m_pCurLineList;
	COLORREF m_clrPen;
	COLORREF m_clrBrush;
	int m_nZoomScale;
	int m_nLineMode;
	CDC* m_pDCMem;
	CSize m_sizePixel;
	//{{AFX_MSG(C3iMatrix)
	afx_msg void OnDestroy();
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnPaint();	
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()	
private:
	BOOL m_bReCalcMatrix;
	CBitmap* m_pOldBitmap;	
	CBitmap m_bmpDCMem;
	
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_3IMATRIX_H__CBE428F7_7C0F_4131_BD76_4C6CA9E9D47E__INCLUDED_)
