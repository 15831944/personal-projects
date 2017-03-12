// MainFrm.h : interface of the CMainFrame class
//


#pragma once
#include "PCBFileFormat.h"
#include "..\..\Common\Controls\TabSDIFrameWnd.h"

class CMainFrame : public CTabSDIFrameWnd
{
	
protected: // create from serialization only
	CMainFrame();
	DECLARE_DYNCREATE(CMainFrame)

// Attributes
public:
	LOGFONT m_LogFont;
	QGdiPlus m_GdiPlus;
	CPCBFileFormat m_PCBFile;
// Operations
public:
	BOOL CreateToolBarDraw();
	BOOL CreateToolBarEdit();
	BOOL CreateToolBarSnap();
	BOOL CreateToolBarFormat();
	BOOL CreateToolBarDim();
// Overrides
public:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	int InitVeCAD(HWND hWnd);
	void InitTabLayer(void);
	void UpdateControlBarParam(BOOL bUpdate);
	void UpdateControlBarInfo(BOOL bUpdate);
// Implementation
public:
	virtual ~CMainFrame();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:  // control bar embedded members
	CStatusBar  m_wndStatusBar;
	CToolBar    m_wndToolBar;
	CToolBar    m_TbarDraw;
	CToolBar    m_TbarEdit;
	CToolBar    m_TbarSnap;
	CToolBar    m_TbarFormat;
	CToolBar    m_TbarDim;
	CReBar      m_wndReBar;
	CDialogBar  m_wndDlgBar;
	int			m_nHeight;		
// Generated message map functions
protected:
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnSelchangeTabctrl(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnRclickTabctrl(NMHDR* pNMHDR, LRESULT* pResult) ;
	afx_msg void OnClickTabctrl(NMHDR* pNMHDR, LRESULT* pResult);
	DECLARE_MESSAGE_MAP()
private:
	int m_orientation;
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnTimer(UINT_PTR nIDEvent);
	virtual BOOL DestroyWindow();
	afx_msg void OnDrawNodeText();
	virtual BOOL PreTranslateMessage(MSG* pMsg);		
	afx_msg void OnBnClickedButtonCalc();
	afx_msg void OnToolSetPayment();
	afx_msg void OnDesignExportToProtelPCB();
	void AddLED(double x, double y, double x0, double y0, double size);
	afx_msg void OnExporttoProtelpcb2();
};


