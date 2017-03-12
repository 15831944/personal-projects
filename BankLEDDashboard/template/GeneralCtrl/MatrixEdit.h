#if !defined(AFX_MATRIXEDIT_H__50562D92_EBD8_46E0_A37B_3ECD21ACB582__INCLUDED_)
#define AFX_MATRIXEDIT_H__50562D92_EBD8_46E0_A37B_3ECD21ACB582__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MatrixEdit.h : header file
//
#include "StaticEdit.h"
/////////////////////////////////////////////////////////////////////////////
// CMatrixEdit window

class AFX_EXT_CLASS CMatrixEdit : public CStaticEdit
{
// Construction
public:
	CMatrixEdit();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMatrixEdit)
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
	virtual ~CMatrixEdit();

	// Generated message map functions
protected:
	virtual void GetEditText(LPTSTR szEdit, int len);
	//{{AFX_MSG(CMatrixEdit)
	afx_msg void OnPaint();
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
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

typedef CTypedPtrArray<CPtrArray, CMatrixEdit*> ARRAY_MATRIXEDIT;

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MATRIXEDIT_H__50562D92_EBD8_46E0_A37B_3ECD21ACB582__INCLUDED_)
