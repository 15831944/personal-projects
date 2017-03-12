// DataEdit.cpp : implementation file
//

#include "stdafx.h"
#include "MATRIX.h"
#include "DataEdit.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDataEdit

CDataEdit::CDataEdit()
{
}

CDataEdit::~CDataEdit()
{
}


BEGIN_MESSAGE_MAP(CDataEdit, CRichEditCtrl)
	//{{AFX_MSG_MAP(CDataEdit)
	ON_WM_CTLCOLOR_REFLECT()
	ON_CONTROL_REFLECT(EN_UPDATE, OnUpdate)
	ON_WM_CREATE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDataEdit message handlers

HBRUSH CDataEdit::CtlColor(CDC* pDC, UINT nCtlColor) 
{	
	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));			// zero out structure			
	lf.lfHeight = 16;				  			//  size
	lf.lfWeight	= FW_BOLD;					
	lf.lfQuality= ANTIALIASED_QUALITY;						
#ifdef _UNICODE
	wcscpy((LPTSTR)lf.lfFaceName, _T(".VnTime"));     // request a face name 
#else
	strcpy((LPTSTR)lf.lfFaceName, _T(".VnTime"));     // request a face name 
#endif
	CFont font;
	VERIFY(font.CreateFontIndirect(&lf));		// create the font
	
	pDC->SelectObject(&font);
	pDC->SetTextColor(RGB(255,0,0));
	
	CBrush brush(RGB(250,250,250));
	pDC->SetTextColor(RGB(255,0,0));
	pDC->SetBkMode(TRANSPARENT);
	CRect rect;
	CBrush* brOld = pDC->SelectObject(&brush);
	GetWindowRect(&rect);
	ScreenToClient(&rect);
	rect.InflateRect(1,1,-1,-1);
	pDC->Rectangle(&rect);

	return HBRUSH(NULL);
}

void CDataEdit::OnUpdate() 
{
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CEdit::OnInitDialog()
	// function to send the EM_SETEVENTMASK message to the control
	// with the ENM_UPDATE flag ORed into the lParam mask.
	
	// TODO: Add your control notification handler code here
	
}

int CDataEdit::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CRichEditCtrl::OnCreate(lpCreateStruct) == -1)
		return -1;	

	this->InitCharFormat();

	return 0;
}

void CDataEdit::InitCharFormat()
{
	CHARFORMAT cf = {0};
	cf.cbSize = sizeof(CHARFORMAT);
	cf.crTextColor = RGB(255,0,0);
	cf.yHeight = 300;
	cf.dwMask = CFM_EMBOSS|CFM_OUTLINE|CFM_SHADOW|CFM_BOLD|CFM_COLOR|CFM_BACKCOLOR|CFM_FACE|CFM_SIZE;
	cf.dwEffects = CFE_BOLD|CFE_SHADOW;
	strcpy(cf.szFaceName,(".VnTime"));	
	SetDefaultCharFormat(cf);
}


void CDataEdit::SetTextColor(COLORREF clr)
{	
	CHARFORMAT cf = {0};
	cf.cbSize = sizeof(CHARFORMAT);
	cf.crTextColor = clr;	
	cf.yHeight = 300;
	strcpy(cf.szFaceName,(".VnTime"));
	cf.dwMask = CFM_EMBOSS|CFM_OUTLINE|CFM_SHADOW|CFM_BOLD|CFM_COLOR|CFM_BACKCOLOR|CFM_FACE|CFM_SIZE;
	cf.dwEffects = CFE_BOLD|CFE_SHADOW;
	SetDefaultCharFormat(cf);	
}

void CDataEdit::SetTextColor(int nColor)
{
	const COLORREF __TABLE_COLOR[] = {		
							RGB(50,50,50),
							RGB(0,0,255),
							RGB(0,255,0),
							RGB(0,255,255),
							RGB(255,0,0),
							RGB(255,0,255),
							RGB(255,255,0),
							RGB(155,155,155)						
							};

	this->SetTextColor(__TABLE_COLOR[nColor]);
}
