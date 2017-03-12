#if !defined(AFX_LEDEDIT_H__12B24A60_E0F7_4A51_83AE_302B22F177A5__INCLUDED_)
#define AFX_LEDEDIT_H__12B24A60_E0F7_4A51_83AE_302B22F177A5__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// LEDEdit.h : header file
//
#include "StaticEdit.h"
/////////////////////////////////////////////////////////////////////////////
// CLEDEdit window

class AFX_EXT_CLASS CLEDEdit : public CStaticEdit
{
// Construction
public:
	CLEDEdit();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLEDEdit)
	public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	virtual BOOL DestroyWindow();
	//}}AFX_VIRTUAL

// Implementation
public:
	void ShowNumID(BOOL bShow=TRUE);
	virtual void ResizePanel();
	virtual void InitControl(HWND hWndMsg=NULL);
	virtual void SetDigit(int nDigits);
	virtual void SetColor(COLORREF clrOff,COLORREF clrOn);
	virtual void SetBkColor(COLORREF clrBk);
	virtual void SetText(LPCTSTR lpszText);
	virtual void GetText(CString& csText);
	virtual ~CLEDEdit();

	// Generated message map functions
protected:
	virtual void GetEditText(LPTSTR szEdit, int len);
	//{{AFX_MSG(CLEDEdit)
	afx_msg void OnContextMenu(CWnd*, CPoint point);
	afx_msg void OnPaint();
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnPopupCopy();
	afx_msg void OnPopupCut();
	afx_msg void OnPopupRemove();
	afx_msg void OnPopupProperties();
	afx_msg void OnPopupLockpanelposition();
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

typedef CTypedPtrArray<CPtrArray, CLEDEdit*> ARRAY_LEDEDIT;

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LEDEDIT_H__12B24A60_E0F7_4A51_83AE_302B22F177A5__INCLUDED_)
