#if !defined(AFX_LEDTEXTCTRL_H__F6E688CC_77E9_42C4_A95B_8FB92EC91E1E__INCLUDED_)
#define AFX_LEDTEXTCTRL_H__F6E688CC_77E9_42C4_A95B_8FB92EC91E1E__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// LEDTextCtrl.h : header file
//
#include "LEDData.h"
/////////////////////////////////////////////////////////////////////////////
// CLEDTextCtrl window

#define ON_WM_TEXT_CTRL(memberFxn)	\
	ON_REGISTERED_MESSAGE(CLEDTextCtrl::mg_nTextCtrlMsg,memberFxn)

class CLEDTextCtrl : public CStatic
{
// Construction
public:
	CLEDTextCtrl();

// Attributes
public:
	static const UINT mg_nTextCtrlMsg;
// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLEDTextCtrl)
	//}}AFX_VIRTUAL

// Implementation
public:
	void Attach(HWND hwnd);
	void Stop();
	void Run();
	void SetColorText(COLORREF clrText);
	void SetWindowText(LPCTSTR lpszText);
	virtual ~CLEDTextCtrl();

	// Generated message map functions
protected:
	HWND m_hwndDest;
	void DisplayData(CDC* pDC, LPCTSTR lpszText);
	void SetColumnData(UWord16 uwData, const LEDDataStruct* pData);
	//{{AFX_MSG(CLEDTextCtrl)
	afx_msg void OnPaint();
	afx_msg void OnTimer(UINT nIDEvent);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	COLORREF m_clrLEDText;
	CString m_strLEDText;
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LEDTEXTCTRL_H__F6E688CC_77E9_42C4_A95B_8FB92EC91E1E__INCLUDED_)
