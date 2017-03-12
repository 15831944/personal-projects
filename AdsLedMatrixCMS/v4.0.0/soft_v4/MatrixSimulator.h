#if !defined(AFX_MATRIXSIMULATOR_H__E408D794_D3F1_4C5A_BC81_0737C564F6E2__INCLUDED_)
#define AFX_MATRIXSIMULATOR_H__E408D794_D3F1_4C5A_BC81_0737C564F6E2__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MatrixSimulator.h : header file
//
#include "FontDisp.h"

#define		MAX_LAYER			4
#define		MAX_LINE			8
#define		MAX_WIDTH			1024
#define		MAX_HEIGHT			64
#define		MAX_COLOR			3
#define		BLANK_STATE			0x00		
/////////////////////////////////////////////////////////////////////////////
// CMatrixSimulator window

class CMatrixSimulator : public CStatic
{
// Construction
public:
	CMatrixSimulator();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMatrixSimulator)
	//}}AFX_VIRTUAL

// Implementation
public:
	UINT GetBuffer(PBYTE pBuffer);
	void SelectDraw(UINT nType, UINT nColor);
	UINT m_nLine;
	void LoadWorkspace(CFile& file);
	void SaveWorkspace(CFile& file);
	void GradientLayer(int nColor, int nLayer);
	void DecompressFont(LPCTSTR szFile);
	void CompressFont(LPCTSTR szFile);
	void ClearLayer(int nLayer);
	void ChangeColor(int nColor, int nLayer, BOOL bGradient=FALSE);
	void SetVisibleLayer(BOOL* bLayer);
	void SetCurrentLayer(int nLayer);
	void MoveText(int x,int y, int layer = 0, BOOL bUpdate = TRUE);
	void SetScrollMode(int nMode);
	void LoadCharMap(LPCTSTR szFile);
	void LoadText(const char* szText, int nColor, BOOL bGradient=FALSE);
	void SetRate(int nRate = 100);
	void ClearScreen();
	void ReCalcLayout(int scale, BOOL bRedraw=FALSE);
	void GetPixelSize(int* cx, int* cy);
	CSize GetPixelSize()const;
	void SetPixelSize(int cx,int cy);
	virtual ~CMatrixSimulator();

	// Generated message map functions
protected:
	HCURSOR m_hPointer;
	BOOL m_bOnCapture;
	UINT m_nDrawType;
	UINT m_nColorPen;
	void LoadImage(LPCTSTR szBmpFile);
	afx_msg void OnContextMenu(CWnd*, CPoint point);
	void DrawPixel(CDC*pDC,int row,int col);
	void DisplayFrame(CDC* pDC,BOOL bRefresh);
	//{{AFX_MSG(CMatrixSimulator)
	afx_msg void OnDestroy();
	afx_msg void OnPaint();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnPopupChangescale1x1();
	afx_msg void OnPopupChangescale2x2();
	afx_msg void OnPopupChangescale3x3();
	afx_msg void OnPopupChangescale4x4();
	afx_msg void OnPopupStartscroll();
	afx_msg void OnPopupStopscroll();
	afx_msg void OnPopupLoadframesimage();
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	BOOL m_bHitScroll;
	int m_nChar;	
	CSize m_szTextPos[4];	
	BOOL m_bScrolling;
	BOOL m_bVisibleLayer[4];
	BOOL m_bLoadImage[4];
	int m_nCurrentLayer;
	int m_nScrollMode;	
	int m_nTextLengthPixel[4];	
	int m_nRate;	

	int m_cy;
	int m_cx;
	CPoint m_ptPosition;
	CBitmap* m_pOldBitmap;	
	CBitmap m_bmpDCMem;
	CDC* m_pDCMem;
	BOOL m_bReCalcMatrix;
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MATRIXSIMULATOR_H__E408D794_D3F1_4C5A_BC81_0737C564F6E2__INCLUDED_)
