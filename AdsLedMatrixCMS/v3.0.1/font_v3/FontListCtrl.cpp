// FontListCtrl.cpp : implementation file
//

#include "stdafx.h"
#include "FontFire.h"
#include "FontListCtrl.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CFontListCtrl

CFontListCtrl::CFontListCtrl()
{
}

CFontListCtrl::~CFontListCtrl()
{
}


BEGIN_MESSAGE_MAP(CFontListCtrl, CListCtrl)
	//{{AFX_MSG_MAP(CFontListCtrl)	
	ON_WM_PAINT()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFontListCtrl message handlers




BOOL CFontListCtrl::PreCreateWindow(CREATESTRUCT& cs) 
{
	// default is report view and full row selection
	cs.style &= ~LVS_TYPEMASK;
	cs.style &= ~LVS_SHOWSELALWAYS;
	cs.style |= LVS_OWNERDRAWFIXED;	

	return CListCtrl::PreCreateWindow(cs);

}

void CFontListCtrl::OnPaint() 
{
	// in full row select mode, we need to extend the clipping region
	// so we can paint a selection all the way to the right
	// CListCtrl::OnPaint();

	CPaintDC dc(this);
	CDC* pDC = &dc;
	pDC->SetBkMode(TRANSPARENT);
	CPen pen(PS_NULL,0,RGB(0,0,0));
	CPen* pOldPen = pDC->SelectObject(&pen);
	pDC->SetTextColor(RGB(255,0,0));
	CBrush brNormal(RGB(255,255,255));
	CBrush brSelected(RGB(25,105,130));
	CBrush* pOldBrush = pDC->SelectObject(&brNormal);
	CFont* pFont = pDC->SelectObject(&m_font);
	for (int i=0; i< GetItemCount(); i++){
		CRect rect;
		this->GetItemRect(i,&rect,LVIR_BOUNDS);			
		UINT nState = GetItemState(i,LVIS_SELECTED);
		if (nState == LVIS_SELECTED){
			pDC->SelectObject(&brSelected);
		}
		else{
			pDC->SelectObject(&brNormal);
		}
		pDC->Rectangle(rect);
		CString csText = GetItemText(i,0);
		pDC->DrawText(csText,1,rect,DT_CENTER|DT_VCENTER|DT_SINGLELINE);		
	}
	pDC->SelectObject(pFont);
	pDC->SelectObject(pOldBrush);
	pDC->SelectObject(pOldPen);
	pDC->SetBkMode(OPAQUE);

}

BOOL CFontListCtrl::SetFontList(LPCTSTR szFontName)
{
	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));			// zero out structure			
	lf.lfHeight = 16;				  		//  size
	//lf.lfWeight	= FW_BOLD;					
	lf.lfQuality= ANTIALIASED_QUALITY;						

#ifdef _UNICODE
	wcscpy((LPTSTR)lf.lfFaceName, szFontName);     // request a face name 
#else
	strcpy((LPTSTR)lf.lfFaceName, szFontName);     // request a face name 
#endif
		
	m_font.DeleteObject();
	if(m_font.CreateFontIndirect(&lf)){
		this->SetFont(&m_font);
		return TRUE;
	}
	else{
		TRACE(_T("SetFontList Error \r\n"));
		return FALSE;
	}

}
