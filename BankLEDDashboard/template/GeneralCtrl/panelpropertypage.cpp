// PanelPropertyPage.cpp : implementation file
//

#include "stdafx.h"
#include "resource.h"
#include "PanelPropertyPage.h"

#ifdef _DEBUG
#undef THIS_FILE
static char BASED_CODE THIS_FILE[] = __FILE__;
#endif

#include "StaticEdit.h"


const COLORREF __TABLE_COLOR[] = {	
	RGB(10,10,10),
	RGB(0,0,255),
	RGB(0,255,0),
	RGB(0,255,255),
	RGB(255,0,0),
	RGB(255,0,255),
	RGB(255,255,0),
	RGB(255,255,255)
};

const COLORREF __TABLE_COLOR_OFF[] = {	
	RGB(0,0,0),
	RGB(0,0,64),
	RGB(0,64,0),
	RGB(0,64,64),
	RGB(64,0,0),
	RGB(64,0,64),
	RGB(64,64,0),
	RGB(64,64,64)
};

IMPLEMENT_DYNCREATE(CPanelPropertyPageGeneral, CPropertyPage)
/////////////////////////////////////////////////////////////////////////////
// CPanelPropertyPageGeneral property page

CPanelPropertyPageGeneral::CPanelPropertyPageGeneral() : CPropertyPage(CPanelPropertyPageGeneral::IDD)
{
	//{{AFX_DATA_INIT(CPanelPropertyPageGeneral)
	m_bCheckStaticEdge = FALSE;
	m_bCheckModalFrame = FALSE;
	m_bCheckClientEdge = FALSE;	
	m_nHeight = 0;
	m_nLeft = 0;
	m_nTop = 0;
	m_nWidth = 0;	
	m_nColorSeg =4;
	m_nColorSegOff =4;
	m_nColorBk =0;
	m_nDigits = 0;
	m_bEnableEdit = FALSE;	
	//}}AFX_DATA_INIT
}

CPanelPropertyPageGeneral::~CPanelPropertyPageGeneral()
{
}

void CPanelPropertyPageGeneral::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CPanelPropertyPageGeneral)
	DDX_Control(pDX, IDC_COMBO_LEDCOLOR_OFF, m_ClrComboSegOff);
	DDX_Control(pDX, IDC_COMBO_BKCOLOR, m_ClrComboBk);
	DDX_Control(pDX, IDC_COMBO_LEDCOLOR, m_ClrComboSeg);
	DDX_Check(pDX, IDC_CHECK_STATIC_EDGE, m_bCheckStaticEdge);
	DDX_Check(pDX, IDC_CHECK_MODAL_FRAME, m_bCheckModalFrame);
	DDX_Check(pDX, IDC_CHECK_CLIENT_EDGE, m_bCheckClientEdge);		
	DDX_Text(pDX, IDC_EDIT_HEIGHT, m_nHeight);
	DDX_Text(pDX, IDC_EDIT_LEFT, m_nLeft);
	DDX_Text(pDX, IDC_EDIT_TOP, m_nTop);
	DDX_Text(pDX, IDC_EDIT_WIDTH, m_nWidth);
	DDX_CBIndex(pDX, IDC_COMBO_LEDCOLOR, m_nColorSeg);
	DDX_CBIndex(pDX, IDC_COMBO_BKCOLOR, m_nColorBk);
	DDX_Text(pDX, IDC_EDIT_DIGITS, m_nDigits);
	DDX_Check(pDX, IDC_CHECK_ENABLE_EDIT, m_bEnableEdit);
	DDX_CBIndex(pDX, IDC_COMBO_LEDCOLOR_OFF, m_nColorSegOff);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CPanelPropertyPageGeneral, CPropertyPage)
	//{{AFX_MSG_MAP(CPanelPropertyPageGeneral)
	ON_NOTIFY(UDN_DELTAPOS, IDC_SPIN_HEIGHT, OnDeltaposSpinHeight)
	ON_NOTIFY(UDN_DELTAPOS, IDC_SPIN_LEFT, OnDeltaposSpinLeft)
	ON_NOTIFY(UDN_DELTAPOS, IDC_SPIN_TOP, OnDeltaposSpinTop)
	ON_NOTIFY(UDN_DELTAPOS, IDC_SPIN_WIDTH, OnDeltaposSpinWidth)
	ON_BN_CLICKED(IDC_CHECK_CLIENT_EDGE, OnCheckClientEdge)
	ON_BN_CLICKED(IDC_CHECK_MODAL_FRAME, OnCheckModalFrame)
	ON_BN_CLICKED(IDC_CHECK_STATIC_EDGE, OnCheckStaticEdge)
	ON_EN_CHANGE(IDC_EDIT_WIDTH, OnChangeEditWidth)
	ON_EN_CHANGE(IDC_EDIT_TOP, OnChangeEditTop)
	ON_EN_CHANGE(IDC_EDIT_LEFT, OnChangeEditLeft)
	ON_EN_CHANGE(IDC_EDIT_HEIGHT, OnChangeEditHeight)
	ON_WM_CREATE()
	ON_CBN_CLOSEUP(IDC_COMBO_BKCOLOR, OnCloseupComboBkcolor)
	ON_CBN_CLOSEUP(IDC_COMBO_LEDCOLOR, OnCloseupComboLedcolor)
	ON_EN_CHANGE(IDC_EDIT_DIGITS, OnChangeEditDigits)
	ON_NOTIFY(UDN_DELTAPOS, IDC_SPIN_DIGITS, OnDeltaposSpinDigits)
	ON_BN_CLICKED(IDC_CHECK_ENABLE_EDIT, OnCheckEnableEdit)
	ON_CBN_CLOSEUP(IDC_COMBO_LEDCOLOR_OFF, OnCloseupComboLedcolorOff)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()



void CPanelPropertyPageGeneral::OnDeltaposSpinHeight(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_UPDOWN* pNMUpDown = (NM_UPDOWN*)pNMHDR;
	
	((CParamsStruct*)GetParams())->nHeight += pNMUpDown->iDelta;
	this->m_nHeight = ((CParamsStruct*)GetParams())->nHeight;

	*pResult = 0;
}

void CPanelPropertyPageGeneral::OnDeltaposSpinLeft(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_UPDOWN* pNMUpDown = (NM_UPDOWN*)pNMHDR;
	
	((CParamsStruct*)GetParams())->nLeftMargin += pNMUpDown->iDelta;
	this->m_nLeft = ((CParamsStruct*)GetParams())->nLeftMargin;

	*pResult = 0;
}

void CPanelPropertyPageGeneral::OnDeltaposSpinTop(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_UPDOWN* pNMUpDown = (NM_UPDOWN*)pNMHDR;
	
	((CParamsStruct*)GetParams())->nTopMargin += pNMUpDown->iDelta;
	this->m_nTop = ((CParamsStruct*)GetParams())->nTopMargin;

	*pResult = 0;
}

void CPanelPropertyPageGeneral::OnDeltaposSpinWidth(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_UPDOWN* pNMUpDown = (NM_UPDOWN*)pNMHDR;
	
	((CParamsStruct*)GetParams())->nWidth += pNMUpDown->iDelta;
	this->m_nWidth = ((CParamsStruct*)GetParams())->nWidth;

	*pResult = 0;
}

void CPanelPropertyPageGeneral::OnCheckEnableEdit() 
{
	this->UpdateData(TRUE);

	((CParamsStruct*)GetParams())->bEnableEdit = m_bEnableEdit;	
}

void CPanelPropertyPageGeneral::OnCheckClientEdge() 
{
	this->UpdateData(TRUE);

	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();
	CStaticEdit* pPanel = (CStaticEdit*)pFrame->m_pPanel;

	if (m_bCheckClientEdge)
		((CParamsStruct*)GetParams())->dwExtendedStyle |= SS_EX_CLIENTEDGE;
	else
		((CParamsStruct*)GetParams())->dwExtendedStyle &= ~SS_EX_CLIENTEDGE;

	pPanel->RedrawPanel();
}

void CPanelPropertyPageGeneral::OnCheckModalFrame() 
{
	this->UpdateData(TRUE);

	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();
	CStaticEdit* pPanel = (CStaticEdit*)pFrame->m_pPanel;

	if (m_bCheckModalFrame)
		((CParamsStruct*)GetParams())->dwExtendedStyle |= SS_EX_MODALFRAME;
	else
		((CParamsStruct*)GetParams())->dwExtendedStyle &= ~SS_EX_MODALFRAME;	

	pPanel->RedrawPanel();
}

void CPanelPropertyPageGeneral::OnCheckStaticEdge() 
{
	this->UpdateData(TRUE);	

	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();
	CStaticEdit* pPanel = (CStaticEdit*)pFrame->m_pPanel;

	if (m_bCheckStaticEdge)
		((CParamsStruct*)GetParams())->dwExtendedStyle |=  SS_EX_STATICEDGE;
	else
		((CParamsStruct*)GetParams())->dwExtendedStyle &=  ~SS_EX_STATICEDGE;

	pPanel->RedrawPanel();
}

void CPanelPropertyPageGeneral::OnChangeEditDigits() 
{
	CEdit* pEdit = (CEdit*)GetDlgItem(IDC_EDIT_DIGITS);
	if (!pEdit->IsWindowVisible())	return;

	TCHAR szBuffer[10] = {0};
	((CEdit*)GetDlgItem(IDC_EDIT_DIGITS))->GetLine(0,szBuffer,sizeof(szBuffer));

#ifdef _UNICODE
	swscanf(szBuffer,_T("%d"),&((CParamsStruct*)GetParams())->nDigits);	
#else
	sscanf(szBuffer,_T("%d"),&((CParamsStruct*)GetParams())->nDigits);	
#endif

	this->m_nDigits = ((CParamsStruct*)GetParams())->nDigits;
	
	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();
	
	CStaticEdit* pPanel = (CStaticEdit*)pFrame->m_pPanel;
	pPanel->SetDigit(m_nDigits);
	
}

void CPanelPropertyPageGeneral::OnDeltaposSpinDigits(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_UPDOWN* pNMUpDown = (NM_UPDOWN*)pNMHDR;
	
	((CParamsStruct*)GetParams())->nDigits += pNMUpDown->iDelta;
	this->m_nDigits = ((CParamsStruct*)GetParams())->nDigits;
	
	*pResult = 0;
}

void CPanelPropertyPageGeneral::OnChangeEditHeight() 
{	
	CEdit* pEdit = (CEdit*)GetDlgItem(IDC_EDIT_HEIGHT);
	if (!pEdit->IsWindowVisible())	return;

	TCHAR szBuffer[10] = {0};
	((CEdit*)GetDlgItem(IDC_EDIT_HEIGHT))->GetLine(0,szBuffer,sizeof(szBuffer));

#ifdef _UNICODE
	swscanf(szBuffer,_T("%d"),&((CParamsStruct*)GetParams())->nHeight);	
#else
	sscanf(szBuffer,_T("%d"),&((CParamsStruct*)GetParams())->nHeight);	
#endif

	this->m_nHeight = ((CParamsStruct*)GetParams())->nHeight;
	
	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();
	
	CStaticEdit* pPanel = (CStaticEdit*)pFrame->m_pPanel;
	pPanel->ResizePanel();	
		
}

LPVOID CPanelPropertyPageGeneral::GetParams()
{
	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();

	return LPVOID(&((CStaticEdit*)pFrame->m_pPanel)->_stParam);			
}

BOOL CPanelPropertyPageGeneral::OnInitDialog() 
{
	CPropertyPage::OnInitDialog();

	return TRUE;  
}

BOOL CPanelPropertyPageGeneral::OnSetActive() 
{
	this->m_nHeight = ((CParamsStruct*)GetParams())->nHeight;
	this->m_nWidth  = ((CParamsStruct*)GetParams())->nWidth;
	this->m_nLeft   = ((CParamsStruct*)GetParams())->nLeftMargin;
	this->m_nTop    = ((CParamsStruct*)GetParams())->nTopMargin;
		
	this->m_nDigits = ((CParamsStruct*)GetParams())->nDigits;
	this->m_bEnableEdit = ((CParamsStruct*)GetParams())->bEnableEdit;

	this->m_bCheckClientEdge = ((CParamsStruct*)GetParams())->dwExtendedStyle & SS_EX_CLIENTEDGE;
	this->m_bCheckStaticEdge = ((CParamsStruct*)GetParams())->dwExtendedStyle & SS_EX_STATICEDGE;
	this->m_bCheckModalFrame = ((CParamsStruct*)GetParams())->dwExtendedStyle & SS_EX_MODALFRAME;

	for (int i=0; i< sizeof(__TABLE_COLOR); i++){
		if (((CParamsStruct*)GetParams())->clrBk == __TABLE_COLOR[i]){
			break;
		}
	}
	if (i < sizeof(__TABLE_COLOR)){
		m_nColorBk = i;
	}
	for ( i=0; i< sizeof(__TABLE_COLOR); i++){
		if (((CParamsStruct*)GetParams())->clrSeg == __TABLE_COLOR[i]){
			break;
		}
	}
	if (i < sizeof(__TABLE_COLOR)){
		m_nColorSeg = i;
	}

	for ( i=0; i< sizeof(__TABLE_COLOR_OFF); i++){
		if (((CParamsStruct*)GetParams())->clrSegOff == __TABLE_COLOR_OFF[i]){
			break;
		}
	}
	if (i < sizeof(__TABLE_COLOR_OFF)){
		m_nColorSegOff = i;
	}

	this->InitControl();


	this->UpdateData(FALSE);
	
	return CPropertyPage::OnSetActive();
}

BOOL CPanelPropertyPageGeneral::OnKillActive() 
{
	
	return CPropertyPage::OnKillActive();
}


void CPanelPropertyPageGeneral::OnChangeEditWidth() 
{
	CEdit* pEdit = (CEdit*)GetDlgItem(IDC_EDIT_WIDTH);
	if (!pEdit->IsWindowVisible())	return;

	TCHAR szBuffer[10] = {0};
	((CEdit*)GetDlgItem(IDC_EDIT_WIDTH))->GetLine(0,szBuffer,sizeof(szBuffer));

#ifdef _UNICODE
	swscanf(szBuffer,_T("%d"),&((CParamsStruct*)GetParams())->nWidth);	
#else
	sscanf(szBuffer,_T("%d"),&((CParamsStruct*)GetParams())->nWidth);	
#endif
	
	this->m_nWidth = ((CParamsStruct*)GetParams())->nWidth;

	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();

	CStaticEdit* pPanel = (CStaticEdit*)pFrame->m_pPanel;
	pPanel->ResizePanel();	
}

void CPanelPropertyPageGeneral::OnChangeEditTop() 
{
	CEdit* pEdit = (CEdit*)GetDlgItem(IDC_EDIT_TOP);
	if (!pEdit->IsWindowVisible())	return;

	TCHAR szBuffer[10] = {0};
	((CEdit*)GetDlgItem(IDC_EDIT_TOP))->GetLine(0,szBuffer,sizeof(szBuffer));

#ifdef _UNICODE
	swscanf(szBuffer,_T("%d"),&((CParamsStruct*)GetParams())->nTopMargin);	
#else
	sscanf(szBuffer,_T("%d"),&((CParamsStruct*)GetParams())->nTopMargin);	
#endif

	this->m_nTop = ((CParamsStruct*)GetParams())->nTopMargin;	

	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();
	
	CStaticEdit* pPanel = (CStaticEdit*)pFrame->m_pPanel;
	pPanel->ResizePanel();	
}

void CPanelPropertyPageGeneral::OnChangeEditLeft() 
{
	CEdit* pEdit = (CEdit*)GetDlgItem(IDC_EDIT_LEFT);
	if (!pEdit->IsWindowVisible())	return;

	TCHAR szBuffer[10] = {0};
	((CEdit*)GetDlgItem(IDC_EDIT_LEFT))->GetLine(0,szBuffer,sizeof(szBuffer));

#ifdef _UNICODE
	swscanf(szBuffer,_T("%d"),&((CParamsStruct*)GetParams())->nLeftMargin);	
#else
	sscanf(szBuffer,_T("%d"),&((CParamsStruct*)GetParams())->nLeftMargin);	
#endif

	this->m_nLeft = ((CParamsStruct*)GetParams())->nLeftMargin;

	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();
	
	CStaticEdit* pPanel = (CStaticEdit*)pFrame->m_pPanel;
	pPanel->ResizePanel();	
}

int CPanelPropertyPageGeneral::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CPropertyPage::OnCreate(lpCreateStruct) == -1)
		return -1;	
	
	return 0;
}

void CPanelPropertyPageGeneral::InitControl()
{
	CSpinButtonCtrl *pSpin = NULL;
	pSpin =(CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_WIDTH);
	pSpin->SetRange(0,1000);
	pSpin =(CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_HEIGHT);
	pSpin->SetRange(0,200);
	pSpin =(CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_LEFT);
	pSpin->SetRange(0,20);
	pSpin =(CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_TOP);
	pSpin->SetRange(0,20);
	pSpin =(CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_DIGITS);
	pSpin->SetRange(1,100);
}

void CPanelPropertyPageGeneral::OnCloseupComboBkcolor() 
{
	this->UpdateData(TRUE);
	((CParamsStruct*)GetParams())->clrBk = __TABLE_COLOR[m_nColorBk];
	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();
	
	CStaticEdit* pPanel = (CStaticEdit*)pFrame->m_pPanel;	
	pPanel->SetBkColor(__TABLE_COLOR[m_nColorBk]);
}

void CPanelPropertyPageGeneral::OnCloseupComboLedcolor() 
{
	this->UpdateData(TRUE);
	((CParamsStruct*)GetParams())->clrSeg = __TABLE_COLOR[m_nColorSeg];	
	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();
	
	CStaticEdit* pPanel = (CStaticEdit*)pFrame->m_pPanel;
	pPanel->SetColor(__TABLE_COLOR_OFF[m_nColorSegOff],__TABLE_COLOR[m_nColorSeg]);
}

void CPanelPropertyPageGeneral::OnCloseupComboLedcolorOff() 
{
	this->UpdateData(TRUE);
	((CParamsStruct*)GetParams())->clrSeg = __TABLE_COLOR[m_nColorSeg];	
	CPanelPropertySheet* pSheet = (CPanelPropertySheet*)GetParent();
	CPropertyFrame* pFrame = (CPropertyFrame*)pSheet->GetParent();
	
	CStaticEdit* pPanel = (CStaticEdit*)pFrame->m_pPanel;
	pPanel->SetColor(__TABLE_COLOR_OFF[m_nColorSegOff],__TABLE_COLOR[m_nColorSeg]);
}
