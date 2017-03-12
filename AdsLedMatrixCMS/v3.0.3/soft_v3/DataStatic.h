#if !defined(AFX_DATASTATIC_H__FDE13EBA_2F68_45D9_8EC9_CCA76D9DD04C__INCLUDED_)
#define AFX_DATASTATIC_H__FDE13EBA_2F68_45D9_8EC9_CCA76D9DD04C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DataStatic.h : header file
//
#include "dataedit.h"
/////////////////////////////////////////////////////////////////////////////
// CDataStatic window

#ifndef DECLARE_USER_MESSAGE
	#define DECLARE_USER_MESSAGE(name) \
				static const UINT name = ::RegisterWindowMessage(name##_MSG);
#endif

#define WMU_DATA_STATIC_LOAD_MSG			_T("WMU_DATA_STATIC_LOAD--CUONGDD")
#define WMU_DATA_STATIC_UNIFORMCOLOR_MSG			_T("WMU_DATA_STATIC_UNIFORMCOLOR--CUONGDD")
#define WMU_DATA_STATIC_ONOFF_MSG			_T("WMU_DATA_STATIC_ONOFF--CUONGDD")

#define		STYLE_TEXT				0
#define		STYLE_SHORT_TEXT		1
#define		STYLE_TIME				2
#define		STYLE_CLOCK				3
#define		STYLE_DATE				4
#define		STYLE_STATIC			5


class CDataStatic : public CStatic
{
// Construction
public:
	CDataStatic();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDataStatic)
	public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	//}}AFX_VIRTUAL

// Implementation
public:
	void SetMode(int nMode);
	void SetSelectColor(BOOL bEnable);
	void SetEnable(BOOL bEnable);
	BOOL EnableWindow( BOOL bEnable = TRUE );
	int GetMode();
	void SetTextColor(COLORREF clrText);
	void SetLimitText(int nLimit);
	int m_nIndex;
	COLORREF GetTextColor();
	COLORREF GetBkColor();
	void SetFont(LPCTSTR szFontName, UINT nHeight);
	void SetStyle(int nStyle=0);
	void SetRate(UINT nRate);
	void SetBkColor(COLORREF clrBk);
	void SetColor(COLORREF clrBk,COLORREF clrText);
	void Stop();
	void Start();
	void Init(HWND hMsg = NULL);
	void DrawText(BOOL bScroll =FALSE);
	virtual ~CDataStatic();

	// Generated message map functions
protected:
	void Clear();
	afx_msg void OnContextMenu(CWnd*, CPoint point);
	//{{AFX_MSG(CDataStatic)
	afx_msg HBRUSH CtlColor(CDC* pDC, UINT nCtlColor);
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnDestroy();
	afx_msg void OnPopupRun();
	afx_msg void OnPopupStop();
	afx_msg void OnPopupColorGreen();
	afx_msg void OnPopupColorRed();
	afx_msg void OnPopupColorYellow();
	afx_msg void OnPopupLoad();
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnPopupOnoff();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	BOOL m_nDelay;
	BOOL m_bSelectColor;
	UINT m_nCount;
	CFont m_font;
	int m_nStyle;
	UINT m_nRate;
	HWND m_hMsg;
	COLORREF m_clrText;
	COLORREF m_clrBk;
	UINT m_nEditShow;
	CDataEdit* m_pDataEdit;
	BOOL m_bRunning;
	BOOL m_bEnable ; 
	CRect m_rcCurText;
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DATASTATIC_H__FDE13EBA_2F68_45D9_8EC9_CCA76D9DD04C__INCLUDED_)
