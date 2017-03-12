// StaticCopyright.cpp : implementation file
//

#include "stdafx.h"
#include "FontFire.h"
#include "StaticCopyright.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CStaticCopyright

CStaticCopyright::CStaticCopyright()
{
}

CStaticCopyright::~CStaticCopyright()
{
}


BEGIN_MESSAGE_MAP(CStaticCopyright, CStatic)
	//{{AFX_MSG_MAP(CStaticCopyright)
	ON_WM_CTLCOLOR_REFLECT()
	ON_WM_PAINT()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CStaticCopyright message handlers

HBRUSH CStaticCopyright::CtlColor(CDC* pDC, UINT nCtlColor) 
{	
	CBrush brush(RGB(0,0,0));	
	pDC->SetTextColor(RGB(255,0,0));
	pDC->SetBkColor(RGB(0,0,0));
	CRect rect;
	CBrush* brOld = pDC->SelectObject(&brush);
	//GetWindowRect(&rect);
	//pDC->Rectangle(&rect);	
	
	return HBRUSH(NULL);
}

void CStaticCopyright::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
	
	CDC* pDC = &dc;
	CRect rect;
	GetClientRect(rect);
	CPen pen(PS_NULL,1,RGB(0,0,0));
	CBrush brush(RGB(0,0,0));
	CPen* pOldPen = pDC->SelectObject(&pen);	
	CBrush* brOld = pDC->SelectObject(&brush);	
	pDC->Rectangle(rect);

	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));			// zero out structure			
	lf.lfHeight = 14;				  		//  size
	lf.lfWeight	= FW_NORMAL;					
	lf.lfQuality= ANTIALIASED_QUALITY;						

#ifdef _UNICODE
	wcscpy((LPTSTR)lf.lfFaceName, _T("Ms Sans Serif"));     // request a face name 
#else
	strcpy((LPTSTR)lf.lfFaceName, _T("Microsoft Sans Serif"));     // request a face name 
#endif
	
	CFont font;	
	font.CreateFontIndirect(&lf);		// create the font	
	CFont* pOldFont = pDC->SelectObject(&font);

	CString csText = _T("");
	GetWindowText(csText);
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetBkColor(RGB(0,0,0));	
	pDC->SetTextColor(RGB(53,56,52));
	pDC->DrawText(csText,&rect,DT_CENTER|DT_VCENTER);
	rect.OffsetRect(-1,-1);	
	pDC->SetTextColor(RGB(0,0,0));
	pDC->DrawText(csText,&rect,DT_CENTER|DT_VCENTER);
	
	pDC->SetBkMode(OPAQUE);

	pDC->SelectObject(pOldFont);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(brOld);
}
