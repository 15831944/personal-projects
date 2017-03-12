// MainFrm.h : interface of the CMainFrame class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_MAINFRM_H__89D52408_10A3_4D34_B610_4E64F4B24628__INCLUDED_)
#define AFX_MAINFRM_H__89D52408_10A3_4D34_B610_4E64F4B24628__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "..\..\Common\Controls\TabSDIFrameWnd.h"

class CMainFrame : public CTabSDIFrameWnd
{
	
protected: // create from serialization only
	CMainFrame();
	DECLARE_DYNCREATE(CMainFrame)

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMainFrame)
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	//}}AFX_VIRTUAL

// Implementation
public:
	void SetTab(int nSel);
	virtual ~CMainFrame();
	void InitTabConrol(void);
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:  // control bar embedded members
	CStatusBar  m_wndStatusBar;
	CToolBar    m_wndToolBar;
	int			m_nHeight;

// Generated message map functions
protected:
	void DesignMenuMode();
	//{{AFX_MSG(CMainFrame)
	afx_msg void OnSelchangeTabctrl(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnRclickTabctrl(NMHDR* pNMHDR, LRESULT* pResult) ;
	afx_msg void OnClickTabctrl(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	int m_orientation;	
	afx_msg void OnDeviceLcmsv2();	
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MAINFRM_H__89D52408_10A3_4D34_B610_4E64F4B24628__INCLUDED_)
