#if !defined(AFX_MATRIXSIMULATOR_H__E408D794_D3F1_4C5A_BC81_0737C564F6E2__INCLUDED_)
#define AFX_MATRIXSIMULATOR_H__E408D794_D3F1_4C5A_BC81_0737C564F6E2__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MatrixSimulator.h : header file
//
#include "FontDisp.h"

#define		SCROLL_NO_LINE			0
#define		SCROLL_LINE_TOP			1
#define		SCROLL_LINE_BOTTOM		2
#define		SCROLL_LINE_ALL			3

#define		DATA_LINE			8			// alway 8 bits data line
#define		DATA_LENGTH			3936 		// 1024*8*8 = 64KBs
#define		CLOCK_LENGTH		80

#define		LAYER_COUNT			4
#define		MAX_LINE			4
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
	UINT GetCurrentPage();
	void NextPage();
	void PrevPage();
	UINT m_nLine;
	int GetBuffer(PBYTE *pBuffer, int nLayer);
	void LoadWorkspace(CFile& file);
	void SaveWorkspace(CFile& file);
	void InitDefaultFont();
	int GetFontCharWidthBuffer(PBYTE pBuffer);
	int GetFontBuffer(PBYTE* pBuffer);	
	void GradientLayer(int nColor, int nLayer);
	int GetCharWidthBuffer(PBYTE pBuffer);
	void DecompressFont(LPCTSTR szFile);
	void CompressFont(LPCTSTR szFile);
	BYTE ChangeColor(int nColor, BYTE data);
	void SetVisibleBkLayer(BOOL bVisible);
	void ClearBkGnd();
	void ClearLayer(int nLayer);
	void ChangeBkColor(int nColor, BOOL bGradient=FALSE);
	void LoadImage(LPCTSTR szFile, BOOL bBkGnd=FALSE);
	void LoadBkGnd(LPCTSTR szBmpFile);
	void ChangeColor(int nColor, int nLayer, BOOL bGradient=FALSE);
	int GetStaticBuffer(PBYTE* pBuffer);
	void SetVisibleLayer(BOOL* bLayer);
	void MergeLayer(int nLayer);
	void SetCurrentLayer(int nLayer);
	void MoveStaticText(int x,int y, BOOL bUpdate = TRUE);
	void MoveText(int x,int y, int layer = 0, BOOL bUpdate = TRUE);
	void SetScrollMode(int nMode);
	void LoadStaticText(const char *szText, int nColor, BOOL bGradient=FALSE);
	int GetBuffer(PBYTE* pBuffer);
	void LoadCharMap(LPCTSTR szFile);
	void LoadText(const char* szText, int nColor, BOOL bGradient=FALSE);
	void LoadData(PBYTE pData,int nSize);
	void StopScroll();
	void StartScroll(int nRate = 100);
	void SetRate(int nRate = 100);
	void ClearScreen();
	void ReCalcLayout(int scale, BOOL bRedraw=FALSE);
	void GetPixelSize(int* cx, int* cy);
	CSize GetPixelSize()const;
	void SetPixelSize(int cx,int cy);
	virtual ~CMatrixSimulator();

	// Generated message map functions
protected:
	void LoadFont();	
	void ShowClock(const char* szText);
	void LoadFont(PBYTE pData,int nDataLength,int nLayer);
	int TextFromFont(const char *szText, int nColor, BOOL bGradient, PBYTE *pBuffer, UINT nLenght);
	int TextToMatrix(const char* szText, int &cx, int nLayer);
	PBYTE MatrixToPixel(PBYTE pData, int nPixelLenght,int nBufferLength,int nColor);
	afx_msg void OnContextMenu(CWnd*, CPoint point);
	BYTE ExtORByte(BYTE byte1,BYTE byte2);
	void DrawBitCol(CDC*pDC,int bit_col,int bit_row);
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
	afx_msg void OnPopupLoadbackgroundimage();
	afx_msg void OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	afx_msg void OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	UINT m_nCurrentPage;
	BOOL m_bHitScroll;
	int m_nFontPixelLenght;
	int m_nChar;
	int m_nTextLength;
	int m_nFontTextLength;
	int m_nColumeL;
	int m_nColumeH;
	WORD m_wFontCharWidth[4][256];
	WORD m_wCharWidth[256];
	CSize m_szBkPos;
	CSize m_szTextPos[4];
	BOOL m_bVisibleBkLayer;
	BOOL m_bScrolling;
	BOOL m_bVisibleLayer[4];
	BOOL m_bLoadImage[4];
	BOOL m_bLoadBkgndImgs;
	int m_nCurrentLayer;
	int m_nScrollMode;
	PBYTE m_pStaticLine;
	PBYTE m_pClock;
	int m_nTextLengthPixel[4];
	PBYTE m_pOrigin;	
	int m_nRate;
	PBYTE m_pBuffer;

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
