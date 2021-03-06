// MainFrm.cpp : implementation of the CMainFrame class
//

#include "stdafx.h"
#include "DigiLED.h"
#include "DigiLEDDoc.h"
#include "DigiLEDView.h"
#include "MainFrm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMainFrame

IMPLEMENT_DYNCREATE(CMainFrame, CFrameWnd)

BEGIN_MESSAGE_MAP(CMainFrame, CFrameWnd)
	//{{AFX_MSG_MAP(CMainFrame)
	ON_WM_CREATE()
	ON_NOTIFY(CTCN_SELCHANGE, IDC_TABCTRL, OnSelchangeTabctrl)
	ON_NOTIFY(CTCN_RCLICK, IDC_TABCTRL, OnRclickTabctrl)
	ON_NOTIFY(CTCN_CLICK, IDC_TABCTRL, OnClickTabctrl)
	//}}AFX_MSG_MAP
	ON_COMMAND(ID_DEVICE_LCMSV2, &CMainFrame::OnDeviceLcmsv2)
END_MESSAGE_MAP()

static UINT indicators[] =
{
	ID_SEPARATOR,           // status line indicator
	ID_INDICATOR_CAPS,
	ID_INDICATOR_NUM,
	ID_INDICATOR_SCRL,
};

/////////////////////////////////////////////////////////////////////////////
// CMainFrame construction/destruction

CMainFrame::CMainFrame()
{
	m_nHeight = 20;
	m_orientation = 0;
}

CMainFrame::~CMainFrame()
{

}

int CMainFrame::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CFrameWnd::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	if (!m_wndToolBar.CreateEx(this, TBSTYLE_FLAT, WS_CHILD | WS_VISIBLE | CBRS_TOP
		| CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC) ||
		!m_wndToolBar.LoadToolBar(IDR_MAINFRAME))
	{
		TRACE0("Failed to create toolbar\n");
		return -1;      // fail to create
	}

	if (!m_wndStatusBar.Create(this) ||
		!m_wndStatusBar.SetIndicators(indicators,
		  sizeof(indicators)/sizeof(UINT)))
	{
		TRACE0("Failed to create status bar\n");
		return -1;      // fail to create
	}
#ifdef __DESIGN_MODE	
	DesignMenuMode();
#endif   

	// TODO: Delete these three lines if you don't want the toolbar to
	//  be dockable
	m_wndToolBar.EnableDocking(CBRS_ALIGN_ANY);
	EnableDocking(CBRS_ALIGN_ANY);
	DockControlBar(&m_wndToolBar);
	
	if(!m_wndTab.Create(WS_CHILD|WS_VISIBLE|CTCS_FOURBUTTONS|CTCS_DRAGMOVE|CTCS_TOOLTIPS|CTCS_CLOSEBUTTON|CTCS_LEFT,CRect(0,0,m_nHeight,m_nHeight),this,IDC_TABCTRL))
	{
		TRACE0("Failed to create tab control\n");
		return -1;
	}
	
	m_wndTab.ModifyStyle(CTCS_LEFT,0,0);
	m_wndTab.MoveWindow(0,0,m_nHeight,m_nHeight);
	RecalcLayout();	

	m_wndTab.SetItemTooltipText(CTCID_FIRSTBUTTON,_T("First"));
	m_wndTab.SetItemTooltipText(CTCID_PREVBUTTON,_T("Prev"));
	m_wndTab.SetItemTooltipText(CTCID_NEXTBUTTON,_T("Next"));
	m_wndTab.SetItemTooltipText(CTCID_LASTBUTTON,_T("Last"));
	m_wndTab.SetItemTooltipText(CTCID_CLOSEBUTTON,_T("Close"));	

	return 0;
}

BOOL CMainFrame::PreCreateWindow(CREATESTRUCT& cs)
{
	if( !CFrameWnd::PreCreateWindow(cs) )
		return FALSE;
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// CMainFrame diagnostics

#ifdef _DEBUG
void CMainFrame::AssertValid() const
{
	CFrameWnd::AssertValid();
}

void CMainFrame::Dump(CDumpContext& dc) const
{
	CFrameWnd::Dump(dc);
}

#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CMainFrame message handlers


void CMainFrame::DesignMenuMode()
{
	CMenu newMenu;
	newMenu.LoadMenu(IDR_MENU_DESIGN_MODE);
	ASSERT(newMenu);

	// Remove and destroy the old menu
	SetMenu(NULL);
	::DestroyMenu(m_hMenuDefault);

	// Add the new menu
	SetMenu(&newMenu);

	// Assign default menu
	m_hMenuDefault = newMenu.GetSafeHmenu();  // or newMenu.m_hMenu;
}

void CMainFrame::OnSelchangeTabctrl(NMHDR* pNMHDR, LRESULT* pResult) 
{	
	CDigiLEDView* pView =NULL;
	TRY{
		pView = (CDigiLEDView*)this->GetActiveView();
		pView->SetCurrentPage(m_wndTab.GetCurSel());
	}
	CATCH(CException,ex){
		TCHAR szError[MAX_PATH];
		LOG_TO_FILE(_T("GetActiveView(): %s"),ex->GetErrorMessage(szError,sizeof(szError)));
	}
	END_CATCH	
	*pResult = 0;
}

void CMainFrame::OnClickTabctrl(NMHDR* pNMHDR, LRESULT* pResult) 
{
	CTabSDIFrameWnd::OnClickTabctrl(pNMHDR, pResult);
	if(((CTC_NMHDR*)pNMHDR)->nItem==CTCHT_ONCLOSEBUTTON){
	}		
}

void CMainFrame::OnRclickTabctrl(NMHDR* pNMHDR, LRESULT* pResult) 
{
	*pResult = 0;
}
void CMainFrame::InitTabConrol(void)
{
	if (IsWindow(m_wndTab.m_hWnd)){
		m_wndTab.DeleteAllItems();
	}
	if (IsWindow(m_wndTab.m_hWnd)){
		m_wndTab.InsertItem(0,_T("Page 5"));
		m_wndTab.InsertItem(0,_T("Page 4"));
		m_wndTab.InsertItem(0,_T("Page 3"));
		m_wndTab.InsertItem(0,_T("Page 2"));
		m_wndTab.InsertItem(0,_T("Page 1"));
		m_wndTab.SetCurSel(0);
	}
}

void CMainFrame::OnDeviceLcmsv2()
{
	PROCESS_INFORMATION pi;	
	STARTUPINFO si;
	memset(&pi,0,sizeof(pi));
	memset(&si,0,sizeof(si));
	si.cb = sizeof(si);
	si.wShowWindow = SW_SHOW;
	CString csAppName = _T("LCMSv2.exe");
	CDigiLEDView* pView =NULL;
	TRY{
		pView = (CDigiLEDView*)this->GetActiveView();
		pView->m_Serial.Close();
	}
	CATCH(CException,ex){
		TCHAR szError[MAX_PATH];
		LOG_TO_FILE(_T("GetActiveView(): %s"),ex->GetErrorMessage(szError,sizeof(szError)));
	}
	END_CATCH
	if(!CreateProcess(csAppName,NULL,NULL,NULL,0,0,0,0,&si,&pi))
	{
		CString csMsg = _T("LCMSv2.exe do not found");		
		MessageBox(csMsg,_T("LED Matrix Editor"));
	}
	else{
		SendMessage(WM_CLOSE,0,0);
	}
}

void CMainFrame::SetTab(int nSel)
{
	m_wndTab.SetCurSel(nSel);
}
