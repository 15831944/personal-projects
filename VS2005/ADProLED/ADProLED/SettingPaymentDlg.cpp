// SettingPaymentDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ADProLED.h"
#include "SettingPaymentDlg.h"


// CSettingPaymentDlg dialog

IMPLEMENT_DYNAMIC(CSettingPaymentDlg, CDialog)

CSettingPaymentDlg::CSettingPaymentDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSettingPaymentDlg::IDD, pParent)
	, _red(0)
{

}

CSettingPaymentDlg::~CSettingPaymentDlg()
{
}

void CSettingPaymentDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT_TOTAL_RED3, _gCompPrice[RED_3]);
	DDX_Text(pDX, IDC_EDIT_TOTAL_RED5, _gCompPrice[RED_5]);
	DDX_Text(pDX, IDC_EDIT_TOTAL_BLUE3, _gCompPrice[BLUE_3]);
	DDX_Text(pDX, IDC_EDIT_TOTAL_BLUE5, _gCompPrice[BLUE_5]);
	DDX_Text(pDX, IDC_EDIT_TOTAL_GREEN3, _gCompPrice[GREEN_3]);
	DDX_Text(pDX, IDC_EDIT_TOTAL_GREEN5, _gCompPrice[GREEN_5]);
	DDX_Text(pDX, IDC_EDIT_TOTAL_WHITE3, _gCompPrice[WHITE_3]);
	DDX_Text(pDX, IDC_EDIT_TOTAL_OTHER, _gCompPrice[OTHER]);
	DDX_Text(pDX, IDC_EDIT_TOTAL_CPU, _gCompPrice[CPU]);
	DDX_Text(pDX, IDC_EDIT_TOTAL_POWER, _gCompPrice[POWER]);
	DDX_Text(pDX, IDC_EDIT_TOTAL_CASE, _gCompPrice[CASE]);
	DDX_Text(pDX, IDC_EDIT_TOTAL_EXTRA, _gCompPrice[EXTRA]);
}


BEGIN_MESSAGE_MAP(CSettingPaymentDlg, CDialog)
	ON_BN_CLICKED(IDOK, &CSettingPaymentDlg::OnBnClickedOk)
END_MESSAGE_MAP()


// CSettingPaymentDlg message handlers
BOOL CSettingPaymentDlg::OnInitDialog()
{
	CDialog::OnInitDialog();
	return TRUE;
}

void CSettingPaymentDlg::OnBnClickedOk()
{	
	UpdateData(TRUE);
	OnOK();
}
