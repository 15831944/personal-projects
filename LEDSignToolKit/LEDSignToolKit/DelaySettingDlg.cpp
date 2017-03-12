// DelaySettingDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ledsigntoolkit.h"
#include "DelaySettingDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDelaySettingDlg dialog


CDelaySettingDlg::CDelaySettingDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDelaySettingDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDelaySettingDlg)
	m_nDelay = 0;
	//}}AFX_DATA_INIT
}


void CDelaySettingDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDelaySettingDlg)
	DDX_Text(pDX, IDC_EDIT_DELAY, m_nDelay);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDelaySettingDlg, CDialog)
	//{{AFX_MSG_MAP(CDelaySettingDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDelaySettingDlg message handlers
