// ConnectingDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ConnectingDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define		CONNECT_TIMER_ID			100
#define		CONNECT_TIMER_INTERVAL		1000
/////////////////////////////////////////////////////////////////////////////
// CConnectingDlg dialog


CConnectingDlg::CConnectingDlg(int nDelayTime, CWnd* pParent /*=NULL*/)
	: CDialog(CConnectingDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CConnectingDlg)
	m_nDelayTime = nDelayTime;	
	m_csStatusText = _T("Please wait ... ");
	//}}AFX_DATA_INIT
}


void CConnectingDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CConnectingDlg)
	DDX_Control(pDX, IDC_ANIMATE, m_ctrlAVI);
	DDX_Text(pDX, IDC_STATIC_TEXT, m_csStatusText);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CConnectingDlg, CDialog)
	//{{AFX_MSG_MAP(CConnectingDlg)
	ON_WM_TIMER()
	ON_WM_CLOSE()
	ON_WM_DESTROY()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CConnectingDlg message handlers

BOOL CConnectingDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_ctrlAVI.Open(IDR_CONNECTING)	;
	m_ctrlAVI.Play(0,-1,-1);
	if (m_nDelayTime > 0)
		SetTimer(CONNECT_TIMER_ID,CONNECT_TIMER_INTERVAL,NULL);

	this->UpdateData(FALSE);

	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

BOOL CConnectingDlg::DestroyWindow() 
{		
	return CDialog::DestroyWindow();
}

void CConnectingDlg::OnTimer(UINT nIDEvent) 
{
	if (nIDEvent == CONNECT_TIMER_ID)
	{
		if (--m_nDelayTime <0)
		{
			KillTimer(CONNECT_TIMER_ID);
			EndDialog(IDOK);
		}
	}

	CDialog::OnTimer(nIDEvent);
}

void CConnectingDlg::OnClose() 
{		
	CDialog::EndDialog(IDOK);
}

void CConnectingDlg::OnOK() 
{
	
}

void CConnectingDlg::OnCancel() 
{

}

void CConnectingDlg::OnDestroy() 
{
	m_ctrlAVI.Close();
	KillTimer(CONNECT_TIMER_ID);
	CDialog::OnDestroy();		
}
