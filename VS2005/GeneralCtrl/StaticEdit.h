#if !defined(AFX_STATICEDIT_H__CE03FEA0_6079_42EE_9F61_147ADF70E002__INCLUDED_)
#define AFX_STATICEDIT_H__CE03FEA0_6079_42EE_9F61_147ADF70E002__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// StaticEdit.h : header file
//
#include "PropertyFrame.h"
#include "DataEdit.h"

#define		SS_EX_CLIENTEDGE		0x0001
#define		SS_EX_MODALFRAME		0x0002
#define		SS_EX_STATICEDGE		0x0004

#define		WM_STATICEDIT_LBUTTONUP		WM_USER + 100
#define		WM_STATICEDIT_CUT			WM_USER + 101
#define		WM_STATICEDIT_COPY			WM_USER + 102
#define		WM_STATICEDIT_REMOVE		WM_USER + 103
#define		WM_STATICEDIT_SELECTED		WM_USER + 104

class AFX_EXT_CLASS CParamsStruct : public CObject
{
public:
	CParamsStruct();
	~CParamsStruct();
	// size & margin
	int nLeftMargin;
	int nHeight;
	int nTopMargin;
	int nWidth;
	int nLeft;
	int nTop;

	COLORREF clrSeg;
	COLORREF clrSegOff;
	COLORREF clrBk;

	int nDigits;
	BOOL bEnableEdit;
	CString csFontName;

	DWORD dwExtendedStyle;
	const CParamsStruct& operator =(const CParamsStruct &param);
};

#define STYLE_LED			0
#define STYLE_MATRIX		1
#define STYLE_STATIC		2

#define	MAX_PAGE			5

//#define	__DESIGN_MODE
/////////////////////////////////////////////////////////////////////////////
// CStaticEdit window

class AFX_EXT_CLASS CStaticEdit : public CStatic
{
// Construction
public:
	CStaticEdit();
	const CStaticEdit& operator =(const CStaticEdit &srcLED);	
// Attributes
public:
	CParamsStruct _stParam;		
// Operations
public:
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CStaticEdit)
	public:
	virtual BOOL DestroyWindow();
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	//}}AFX_VIRTUAL

// Implementation
public:	
	UINT GetNumID()const;
	CString GetFontName()const;
	int GetDigits()const;	
	void ShowNumID(BOOL bShow=TRUE);
	void SetNumID(UINT nID);
	virtual void GetPageText(CString& csText, int nPage);
	virtual void SetPageText(LPCTSTR lpszText, int nPage);
	virtual void GetText(CString& csText);
	virtual void SetText(LPCTSTR lpszText);
	virtual void SetBkColor(COLORREF clrBk);
	virtual void SetColor(COLORREF clrOff,COLORREF clrOn);	
	virtual void SetDigit(int nDigits);
	virtual void InitControl(HWND hWndMsg=NULL);
	virtual void ResizePanel();
	virtual void RedrawPanel();	
	virtual ~CStaticEdit();
	void OnProperties();
	void SetFont(LPCTSTR szFontName, UINT nHeight);
	// Generated message map functions
protected:	
	UINT m_nNumID;
	BOOL m_bShowNumID;	
	BOOL m_bLockPosition;
	void DrawNumID(CDC* pDC);
	virtual void GetEditText(LPTSTR szEdit, int len);
	CStatic* m_pCtrl;		
	CString m_csFontName;
	CFont m_font;
	HWND m_hWndMsg;
	int m_nDigits;
	BOOL m_bSelected;	
	CDataEdit* m_pDataEdit;
	void DrawDragWindow(CPoint& point);
	//{{AFX_MSG(CStaticEdit)
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
	afx_msg HBRUSH CtlColor(CDC* pDC, UINT nCtlColor);
	afx_msg void OnDestroy();
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnPaint();
	afx_msg void OnPopupProperties();
	afx_msg void OnPopupLockpanelposition();
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg void OnPopupRemove();
	afx_msg void OnPopupCopy();
	afx_msg void OnPopupCut();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:		
	CPoint m_ptPoint;
	CPropertyFrame* m_pPropFrame;		
};

#include <afxtempl.h>
typedef CTypedPtrArray<CPtrArray, CStaticEdit*> ARRAY_STATICEDIT;
/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STATICEDIT_H__CE03FEA0_6079_42EE_9F61_147ADF70E002__INCLUDED_)
