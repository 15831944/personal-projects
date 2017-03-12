// DataEdit.cpp : implementation file
//

#include "stdafx.h"
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
	m_bEnableChars = FALSE;
}

CDataEdit::~CDataEdit()
{
}


BEGIN_MESSAGE_MAP(CDataEdit, CRichEditCtrl)
	//{{AFX_MSG_MAP(CDataEdit)
	ON_WM_CTLCOLOR_REFLECT()
	ON_WM_CREATE()
	ON_WM_CHAR()
	ON_CONTROL_REFLECT(EN_KILLFOCUS, OnKillfocus)
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
	wcscpy_s((LPTSTR)lf.lfFaceName, LF_FACESIZE, _T(".VnTime"));     // request a face name 
#else
	strcpy_s((LPTSTR)lf.lfFaceName, LF_FACESIZE, _T(".VnTime"));     // request a face name 
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

int CDataEdit::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CRichEditCtrl::OnCreate(lpCreateStruct) == -1)
		return -1;	

	this->InitCharFormat();

	return 0;
}

void CDataEdit::InitCharFormat(int nHeight)
{
	CHARFORMAT cf = {0};
	cf.cbSize = sizeof(CHARFORMAT);
	cf.crTextColor = RGB(255,0,0);
	cf.yHeight = nHeight;
#ifdef _UNICODE
	wcscpy_s(cf.szFaceName, LF_FACESIZE, _T(".VnTime"));
#else
	strcpy_s(cf.szFaceName, LF_FACESIZE, _T(".VnTime"));
#endif
	cf.dwMask = CFM_FACE | CFM_SIZE | CFM_COLOR;
	SetDefaultCharFormat(cf);

	PARAFORMAT pf;

	// Modify the paragraph format so that the text is centered. 
	pf.cbSize = sizeof(PARAFORMAT);
	pf.dwMask = PFM_ALIGNMENT | PFM_NUMBERING;
	pf.wAlignment = PFA_CENTER;
	pf.wNumbering = 0;
	SetParaFormat(pf);

}

void CDataEdit::OnChar(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	if (!m_bEnableChars){
		if (nChar >= '0' && nChar <='9' || nChar =='-' || nChar =='.'){	
			CString csText;
			TCHAR szEdit[20];
			this->GetLine(0,szEdit,20);
			csText = szEdit;			
			int nPos = csText.Find('.',0);
			if (nPos <0 ){
				if (csText.GetLength() < GetLimitText()){					
					CRichEditCtrl::OnChar(nChar, nRepCnt, nFlags);				
				}
				else{
					//do not call CRichEditCtrl::OnChar(nChar, nRepCnt, nFlags);											
				}
			}
			else{					
				CRichEditCtrl::OnChar(nChar, nRepCnt, nFlags);							
			}			
		}
	}
	else{
		CRichEditCtrl::OnChar(nChar, nRepCnt, nFlags);
	}
}

void CDataEdit::OnKillfocus() 
{	
	this->ShowWindow(SW_HIDE);
	this->EnableWindow(FALSE);	
}
