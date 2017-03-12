// DigiLEDView.h : interface of the CDigiLEDView class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_DIGILEDVIEW_H__40C878AD_68CA_4574_877A_97DEA267F2DD__INCLUDED_)
#define AFX_DIGILEDVIEW_H__40C878AD_68CA_4574_877A_97DEA267F2DD__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "LEDFrame.h"
#include "..\COMMON\SerialMFC.h"	// Added by ClassView
#include "EthernetPort.h"

class CDigiLEDDoc;
class CDigiLEDView : public CView
{
protected: // create from serialization only
	CDigiLEDView();
	DECLARE_DYNCREATE(CDigiLEDView)
	CEthernetPort* m_pEthernet;
// Attributes
public:
	void SetCurrentPage(int nPage);
	CDigiLEDDoc* GetDocument();
	CLEDFrame* m_pLEDFrame;
// Operations
public:
	BOOL m_bShowNumID;
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDigiLEDView)
	public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	virtual void OnInitialUpdate();
	virtual BOOL DestroyWindow();
	protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);
	//}}AFX_VIRTUAL
	
// Implementation
public:
	UINT m_nShowTime;
	UINT m_nCurPage;
	CSerialMFC m_Serial;
	CString m_csCurrentFile;
	virtual ~CDigiLEDView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	BOOL SendConfig();
	BOOL GetBuffer(PBYTE pBuffer, int nBuffSize);
	BOOL SendBuffer(PBYTE pBuffer, int nBuffSize);
	BOOL FormatBuffer(PBYTE pBuffIn, PBYTE pBuffOut, int nBuffSize);
	UINT GetLEDCount();
	BOOL LoadDigitCode(BYTE xtable[20]);
	BOOL InitComm();
	//{{AFX_MSG(CDigiLEDView)
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnDesignAddcomponent();
	afx_msg void OnViewShowcontrolid();
	afx_msg void OnUpdateViewShowcontrolid(CCmdUI* pCmdUI);
	afx_msg void OnFileNew();
	afx_msg void OnDesignRepositioncontrolnumid();
	afx_msg void OnUpdateDesignRepositioncontrolnumid(CCmdUI* pCmdUI);
	afx_msg void OnFileOpen();
	afx_msg void OnFileSave();
	afx_msg void OnDeviceDownloaddata();
	afx_msg void OnDeviceConfigrunmode();
	afx_msg void OnFileSaveAs();
	afx_msg void OnDeviceSetrtc();
	//}}AFX_MSG
	afx_msg LRESULT OnSerialMsg (WPARAM wParam, LPARAM lParam);
	afx_msg LRESULT OnEthernetMsg (WPARAM wParam, LPARAM lParam);

	DECLARE_MESSAGE_MAP()
private:	
	BOOL m_bSending;
	CTime m_TimeSent;
	CConnectingDlg* m_pConnectDlg;
	afx_msg void OnTimer(UINT_PTR nIDEvent);		
	void ShowBusyDialog(LPCTSTR lpszText);
	void DownloadData(void);
	BOOL m_bConfig;
	void GetDeviceMode(void);
};

#ifndef _DEBUG  // debug version in DigiLEDView.cpp
inline CDigiLEDDoc* CDigiLEDView::GetDocument()
   { return (CDigiLEDDoc*)m_pDocument; }
#endif

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DIGILEDVIEW_H__40C878AD_68CA_4574_877A_97DEA267F2DD__INCLUDED_)
