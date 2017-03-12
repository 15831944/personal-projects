// AddControlDlg.cpp : implementation file
//

#include "stdafx.h"
#include "DigiLED.h"
#include "AddControlDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAddControlDlg dialog


CAddControlDlg::CAddControlDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CAddControlDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CAddControlDlg)
	m_nWidth = 68;
	m_nHeight = 19;
	m_nControlID = 0;
	m_nNums = 1;
	m_nDigits = 6;
	m_csFontName = _T(".VnTime");
	//}}AFX_DATA_INIT
}


void CAddControlDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAddControlDlg)
	DDX_Control(pDX, IDC_STATIC_COPY, m_FrameCopy);
	DDX_Text(pDX, IDC_EDIT_CTL_WIDTH, m_nWidth);
	DDX_Text(pDX, IDC_EDIT_CTL_HEIGHT, m_nHeight);
	DDX_CBIndex(pDX, IDC_COMBO_STYLE, m_nControlID);
	DDX_Text(pDX, IDC_EDIT_NUM, m_nNums);
	DDX_Text(pDX, IDC_EDIT_CTL_DIGITS, m_nDigits);
	DDX_Text(pDX, IDC_STATIC_FONT_NAME, m_csFontName);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CAddControlDlg, CDialog)
	//{{AFX_MSG_MAP(CAddControlDlg)
	ON_BN_CLICKED(IDC_ADD_CONTROL, OnAddControl)
	ON_BN_CLICKED(IDC_BUTTON_FONT, OnButtonFont)
	ON_BN_CLICKED(IDC_FINISH, OnFinish)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CAddControlDlg message handlers


void CAddControlDlg::OnAddControl() 
{
	this->UpdateData(TRUE);
	CDialog::EndDialog(IDC_ADD_CONTROL);	
}

BOOL CAddControlDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	CSpinButtonCtrl* pSpin = NULL;
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_NUM);
	pSpin->SetRange(1,20);
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_CTL_WIDTH);
	pSpin->SetRange(1,1000);
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_CTL_HEIGHT);
	pSpin->SetRange(1,200);
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_CTL_DIGITS);
	pSpin->SetRange(1,100);
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CAddControlDlg::OnButtonFont() 
{
	// Show the font dialog with 12 point "Times New Roman" as the 
	// selected font.
	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));

	CClientDC dc(this);
	lf.lfHeight = -MulDiv(12, dc.GetDeviceCaps(LOGPIXELSY), 72);
#ifdef _UNICODE
	wcscpy_s(lf.lfFaceName, LF_FACESIZE, m_csFontName);
#else
	strcpy_s(lf.lfFaceName, LF_FACESIZE, m_csFontName);
#endif
	this->UpdateData(TRUE);
	CFontDialog dlg(&lf);
	if (IDOK ==dlg.DoModal()){
		m_csFontName = dlg.GetFaceName();
		this->UpdateData(FALSE);
	}
}

void CAddControlDlg::OnFinish() 
{
	CDialog::EndDialog(IDOK);	
}
