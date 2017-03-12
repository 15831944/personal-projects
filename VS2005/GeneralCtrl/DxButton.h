#if !defined(AFX_DXBUTTON_H__8E7CFE25_8E97_4857_9EE6_05BD55CF1388__INCLUDED_)
#define AFX_DXBUTTON_H__8E7CFE25_8E97_4857_9EE6_05BD55CF1388__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DxButton.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDxButton window

class CDxButton : public CButton
{
// Construction
public:
	CDxButton();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDxButton)
	public:
	virtual void DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct);
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	//}}AFX_VIRTUAL

// Implementation
public:
	void SetColorButtonStyle(BOOL bStyle = TRUE);
	void SetColorFace(COLORREF clrFace,BOOL bRedraw = TRUE);
	void ButtonRefresh();
	BOOL m_bPressing;
	void ButtonRelease();
	void ButtonPress();
	void SetFont(LPCTSTR lpszFontFace,UINT nHeigh = 14,UINT nStyle = FW_DONTCARE,BOOL bItalic = FALSE,BOOL bUnderline = FALSE);
	void SetFont(LOGFONT lfont);
	HCURSOR SetCursor(HCURSOR hCursor);
	void SetIcon(HICON hFace,HICON hHighlight);
	HICON SetIcon(HICON hIcon);
	void SetWindowText( LPCTSTR lpszString );
	void SetTextColor(COLORREF clrText,COLORREF clrTextHighlight);
	virtual ~CDxButton();

	// Generated message map functions
protected:
	BOOL m_bColorStyle;
	COLORREF m_clrFace;
	HICON m_hHighlight;
	HICON m_hFace;
	COLORREF m_clrTextHighlight;
	COLORREF m_clrText;
	//{{AFX_MSG(CDxButton)
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnKillFocus(CWnd* pNewWnd);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	CFont m_Font;
	BOOL m_bHighlight;


};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DXBUTTON_H__8E7CFE25_8E97_4857_9EE6_05BD55CF1388__INCLUDED_)
