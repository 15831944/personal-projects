// SettingDlg.cpp : implementation file
//

#include "stdafx.h"
#include "MATRIX.h"
#include "SettingDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern CGeneralSettings __SETTING;
/////////////////////////////////////////////////////////////////////////////
// CSettingDlg dialog


CSettingDlg::CSettingDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSettingDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSettingDlg)
	m_nComPort = 0;
	m_nColumn = 40;
	m_nRow = 1;
	m_nScale = -1;
	m_bSaveAfterLoaded = TRUE;
	//}}AFX_DATA_INIT
}


void CSettingDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSettingDlg)
	DDX_CBIndex(pDX, IDC_COMBO_COMPORT, m_nComPort);
	DDX_Text(pDX, IDC_EDIT_COLUMN, m_nColumn);
	DDX_CBIndex(pDX, IDC_COMBO_ROW, m_nRow);
	DDX_CBIndex(pDX, IDC_COMBO_RESIZE, m_nScale);
	DDX_Check(pDX, IDC_CHECK_SAVE_AFTER_LOAD, m_bSaveAfterLoaded);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSettingDlg, CDialog)
	//{{AFX_MSG_MAP(CSettingDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSettingDlg message handlers


BOOL CSettingDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_nComPort = __SETTING.m_nCommPort;
	m_nColumn  = __SETTING.m_nColumn;
	m_nRow	   = __SETTING.m_nRow/8 -1;
	m_nScale   = __SETTING.m_nScale -1;
	m_bSaveAfterLoaded = __SETTING.m_bSaveAfterLoaded;

	CSpinButtonCtrl* pSpin = NULL;
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_COLUMN);
	pSpin->SetRange(0,1000);

	this->UpdateData(FALSE);

	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CSettingDlg::OnOK() 
{
	this->UpdateData(TRUE);

	__SETTING.m_nCommPort = m_nComPort;
	__SETTING.m_nColumn = m_nColumn;
	__SETTING.m_nRow = (m_nRow+1)*8;
	__SETTING.m_nScale = m_nScale + 1;
	__SETTING.m_bSaveAfterLoaded = m_bSaveAfterLoaded;

	CDialog::OnOK();
}
