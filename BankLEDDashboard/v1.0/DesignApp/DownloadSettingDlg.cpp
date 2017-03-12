// DownloadSettingDlg.cpp : implementation file
//

#include "stdafx.h"
#include "DigiLED.h"
#include "DownloadSettingDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDownloadSettingDlg dialog


CDownloadSettingDlg::CDownloadSettingDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDownloadSettingDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDownloadSettingDlg)
	m_nPage = 0;
	m_nShowTime = 5;
	//}}AFX_DATA_INIT
}


void CDownloadSettingDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDownloadSettingDlg)
	DDX_CBIndex(pDX, IDC_COMBO_PAGE, m_nPage);
	DDX_Text(pDX, IDC_EDIT_SHOW_TIME, m_nShowTime);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDownloadSettingDlg, CDialog)
	//{{AFX_MSG_MAP(CDownloadSettingDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDownloadSettingDlg message handlers

BOOL CDownloadSettingDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	SetWindowText(m_csTitleText);
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CDownloadSettingDlg::OnOK() 
{
	this->UpdateData(TRUE);
	
	CDialog::OnOK();
}

void CDownloadSettingDlg::SetTitleText(LPCTSTR szTitle)
{
	m_csTitleText = szTitle;
}
