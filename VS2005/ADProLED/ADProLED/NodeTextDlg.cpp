// NodeTextDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ADProLED.h"
#include "NodeTextDlg.h"


// CNodeTextDlg dialog

IMPLEMENT_DYNAMIC(CNodeTextDlg, CDialog)

CNodeTextDlg::CNodeTextDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CNodeTextDlg::IDD, pParent)
	, m_csText(_T(""))
	, m_csFontFace(_T("Georgia"))
	, m_csFontStyle(_T(""))
	, m_csFontSize(_T("72"))
	, m_nNodeSize(0)
	, m_nDistance(4)
	, m_nX(0)
	, m_nY(0)
	, m_nZ(0)
{
	
}

CNodeTextDlg::~CNodeTextDlg()
{
}

void CNodeTextDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_PREVIEW_TEXT, m_ctrlNodeTextPrv);
	DDX_Text(pDX, IDC_EDIT_TEXT, m_csText);
	DDX_Text(pDX, IDC_EDIT_FONT_FACE, m_csFontFace);
	DDX_Text(pDX, IDC_EDIT_FONT_STYLE, m_csFontStyle);
	DDX_Text(pDX, IDC_EDIT_FONT_SIZE, m_csFontSize);	
	DDX_Text(pDX, IDC_EDIT_NODE_DISTANCE, m_nDistance);
	DDX_Text(pDX, IDC_EDIT_X, m_nX);
	DDX_Text(pDX, IDC_EDIT_Y, m_nY);
	DDX_Text(pDX, IDC_EDIT_Z, m_nZ);
	DDX_Control(pDX, IDC_LIST_FONT_FACE, m_ctrlFontFaceList);
	DDX_Control(pDX, IDC_LIST_FONT_STYLE, m_ctrlFontStyleList);
	DDX_Control(pDX, IDC_LIST_FONT_SIZE, m_ctrlFontSizeList);
	DDX_CBIndex(pDX, IDC_COMBO_NODE_SIZE, m_nNodeSize);
}


BEGIN_MESSAGE_MAP(CNodeTextDlg, CDialog)
	ON_EN_CHANGE(IDC_EDIT_TEXT, &CNodeTextDlg::OnEnChangeEditText)
	ON_EN_CHANGE(IDC_EDIT_FONT_FACE, &CNodeTextDlg::OnEnChangeEditFontFace)
	ON_EN_CHANGE(IDC_EDIT_FONT_STYLE, &CNodeTextDlg::OnEnChangeEditFontStyle)
	ON_EN_CHANGE(IDC_EDIT_FONT_SIZE, &CNodeTextDlg::OnEnChangeEditFontSize)
	ON_LBN_SELCHANGE(IDC_LIST_FONT_FACE, &CNodeTextDlg::OnLbnSelchangeListFontFace)
	ON_LBN_SELCHANGE(IDC_LIST_FONT_STYLE, &CNodeTextDlg::OnLbnSelchangeListFontStyle)
	ON_LBN_SELCHANGE(IDC_LIST_FONT_SIZE, &CNodeTextDlg::OnLbnSelchangeListFontSize)
	ON_BN_CLICKED(IDOK, &CNodeTextDlg::OnBnClickedOk)
	ON_EN_CHANGE(IDC_EDIT_NODE_DISTANCE, &CNodeTextDlg::OnEnChangeEditNodeDistance)
END_MESSAGE_MAP()


// CNodeTextDlg message handlers

const TCHAR _FONT_STYLE[6][20] = {_T("Regular"),_T("Italic"),_T("Bold"),_T("Bold Italic"),_T("Medium"),_T("Normal")}; 
void CNodeTextDlg::OnEnChangeEditText()
{
	this->UpdateData(TRUE);
	HDC hDC = ::GetDC(NULL);
	LOGFONT LogFont;
	::ZeroMemory(&LogFont, sizeof(LOGFONT));
	UINT nFontSize = _wtoi(m_csFontSize.GetBuffer(5));
	LogFont.lfHeight = -::MulDiv(nFontSize, ::GetDeviceCaps(hDC, LOGPIXELSY), 72);
	LogFont.lfWeight = FW_NORMAL;
	LogFont.lfOutPrecision = OUT_DEFAULT_PRECIS;
	LogFont.lfClipPrecision = CLIP_DEFAULT_PRECIS;
	LogFont.lfQuality = PROOF_QUALITY;
	LogFont.lfPitchAndFamily = FF_ROMAN;
	if (m_csFontStyle.IsEmpty()){
		LogFont.lfCharSet = SYMBOL_CHARSET;
	}
	else{
		LogFont.lfCharSet = DEFAULT_CHARSET;
	}
	_tcscpy_s(LogFont.lfFaceName, LF_FACESIZE, m_csFontFace);
	::ReleaseDC(NULL, hDC);
	for (int i=0; i< 6; i++){
		if (wcscmp(_FONT_STYLE[i],m_csFontStyle)==0){
			switch (i){
				case 0:
					LogFont.lfWeight =FW_REGULAR;
					break;
				case 1:
					LogFont.lfWeight =FW_REGULAR;
					LogFont.lfItalic =TRUE;
					break;
				case 2:
					LogFont.lfWeight =FW_BOLD;
					break;
				case 3:
					LogFont.lfWeight =FW_BOLD;
					LogFont.lfItalic =TRUE;
					break;
				case 4:
					LogFont.lfWeight =FW_MEDIUM;
					break;
				case 5:
					LogFont.lfWeight =FW_NORMAL;
					break;
			}
		}		
	}
	memcpy(&m_ctrlNodeTextPrv.m_LogFont,&LogFont,sizeof(LOGFONT));
	int nSize =0;
	switch (m_nNodeSize){
	case 0:
		nSize = LED_SIZE_3;
		break;
	case 1:
		nSize = LED_SIZE_5;
		break;
	default:
		nSize = LED_SIZE_3;
		break;
	}
	m_ctrlNodeTextPrv.SetNodeParams(m_nDistance,(int)nSize);
	m_ctrlNodeTextPrv.m_csText = m_csText;
	m_ctrlNodeTextPrv.Invalidate(FALSE);
}

void CNodeTextDlg::OnEnChangeEditFontFace()
{
	this->UpdateData(TRUE);
	m_ctrlFontFaceList.SelectString(0,m_csFontFace);
}

void CNodeTextDlg::OnEnChangeEditFontStyle()
{
	this->UpdateData(TRUE);
	m_ctrlFontStyleList.SelectString(0,m_csFontStyle);
}

void CNodeTextDlg::OnEnChangeEditFontSize()
{
	this->UpdateData(TRUE);
}

void CNodeTextDlg::OnEnChangeEditNodeDistance()
{
	
}

BOOL CALLBACK EnumFontStyleCallBack(ENUMLOGFONT* lplf, LPNEWTEXTMETRIC lpntm, DWORD FontType, LPVOID lParam) 
{ 
    CNodeTextDlg* pDlg = (CNodeTextDlg*)lParam; 
 
	int nIndex = pDlg->m_ctrlFontStyleList.FindStringExact(0,lplf->elfStyle);
	if (nIndex ==LB_ERR){
		LPTSTR szItem = lplf->elfStyle;
		while(szItem[0]==' '){
			if (szItem[0]){
				szItem++;
			}
			else{
				break;
			}
		}
		pDlg->m_ctrlFontStyleList.AddString(szItem);							
	}
 
    return TRUE; 
     
    UNREFERENCED_PARAMETER( lpntm ); 
} 

void CNodeTextDlg::OnLbnSelchangeListFontFace()
{
	this->UpdateData(TRUE);
	int nIndex = m_ctrlFontFaceList.GetCurSel();
	if (nIndex != LB_ERR){
		TCHAR szFaceName[LF_FACESIZE];
		m_ctrlFontStyleList.ResetContent();
		m_ctrlFontFaceList.GetText(nIndex,szFaceName);
		HDC hDC = ::GetDC(m_hWnd);
		EnumFontFamilies(hDC, (LPCTSTR) szFaceName, 
			(FONTENUMPROC) EnumFontStyleCallBack, (LPARAM) this); 
		::ReleaseDC(m_hWnd,hDC);
		m_ctrlFontStyleList.SetCurSel(0);
		OnLbnSelchangeListFontStyle();
		OnLbnSelchangeListFontSize();
		m_csFontFace = szFaceName;
		this->UpdateData(FALSE);
		OnEnChangeEditText();
	}
}

void CNodeTextDlg::OnLbnSelchangeListFontStyle()
{
	this->UpdateData(TRUE);
	int nIndex = m_ctrlFontStyleList.GetCurSel();
	if (nIndex != LB_ERR){
		TCHAR szFaceStyle[LF_FACESIZE];
		m_ctrlFontStyleList.GetText(nIndex,szFaceStyle);		
		m_csFontStyle = szFaceStyle;
		this->UpdateData(FALSE);
		OnEnChangeEditText();
	}
}

void CNodeTextDlg::OnLbnSelchangeListFontSize()
{
	this->UpdateData(TRUE);
	int nIndex = m_ctrlFontSizeList.GetCurSel();
	if (nIndex != LB_ERR){
		TCHAR szFontSize[LF_FACESIZE];
		m_ctrlFontSizeList.GetText(nIndex,szFontSize);		
		m_csFontSize = szFontSize;
		this->UpdateData(FALSE);
		OnEnChangeEditText();
	}
}

BOOL CALLBACK EnumFamCallBack(LPLOGFONT lplf, LPNEWTEXTMETRIC lpntm, DWORD FontType, LPVOID lParam) 
{ 
    CNodeTextDlg* pDlg = (CNodeTextDlg*)lParam; 
	pDlg->m_ctrlFontFaceList.AddString(lplf->lfFaceName);
    return TRUE; 
     
    UNREFERENCED_PARAMETER( lpntm ); 
} 
#define	MAX_LIST_SIZE		16
const int _FONT_SIZE[MAX_LIST_SIZE] = {20,22,24,26,28,36,48,56,64,72,120,140,160,180,220,300};
BOOL CNodeTextDlg::OnInitDialog()
{
	CComboBox* pCombo = (CComboBox*)GetDlgItem(IDC_COMBO_NODE_SIZE);	
	if (pCombo){
		pCombo->ResetContent();
		pCombo->AddString(_T("3.00"));
		pCombo->AddString(_T("5.00"));
		pCombo->SetCurSel(0);
	}

	CDialog::OnInitDialog();	

	HDC hDC = ::GetDC(m_hWnd);
    EnumFontFamilies(hDC, (LPCTSTR) NULL, 
        (FONTENUMPROC) EnumFamCallBack, (LPARAM) this); 
	::ReleaseDC(m_hWnd,hDC);
	m_ctrlFontFaceList.SetCurSel(0);
	OnLbnSelchangeListFontFace();
	for (int i=0; i< MAX_LIST_SIZE; i++){
		TCHAR szDest[5];
		_itow_s(_FONT_SIZE[i],szDest,5,10);
		m_ctrlFontSizeList.AddString(szDest);
	}
	m_ctrlFontSizeList.SetCurSel(10);
	OnLbnSelchangeListFontSize();	
	
	switch ((int)_gPointSize){
	case LED_SIZE_3:
		m_nNodeSize = 0;
		break;
	case LED_SIZE_5:
		m_nNodeSize = 1;
		break;
	default:
		m_nNodeSize = 0;
	}	
	m_nDistance = (int)_gdx;

	this->UpdateData(FALSE);
	return TRUE;  // return TRUE unless you set the focus to a control
}

void CNodeTextDlg::OnBnClickedOk()
{	
	this->UpdateData(TRUE);	
	switch (m_nNodeSize){
	case 0:
		_gPointSize = LED_SIZE_3;
		break;
	case 1:
		_gPointSize = LED_SIZE_5;
		break;
	default:
		_gPointSize = LED_SIZE_3;
		break;
	}
	_gdx =m_nDistance;		
	CDialog::OnOK();
}
