// PageNumber.cpp : implementation file
//

#include "stdafx.h"
#include "ledsigntoolkit.h"
#include "PageNumber.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CPageNumber

CPageNumber::CPageNumber()
{
	m_nPageNo = 1;
}

CPageNumber::~CPageNumber()
{
}


BEGIN_MESSAGE_MAP(CPageNumber, CStatic)
	//{{AFX_MSG_MAP(CPageNumber)
	ON_WM_PAINT()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPageNumber message handlers

void CPageNumber::OnPaint() 
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
	lf.lfHeight = 150;				  			//  size
	lf.lfWeight	= FW_NORMAL;					
	lf.lfQuality= ANTIALIASED_QUALITY;						
#ifdef _UNICODE
	wcscpy((LPTSTR)lf.lfFaceName, _T("Microsoft Sans Serif"));     // request a face name 
#else
	strcpy((LPTSTR)lf.lfFaceName, _T("Microsoft Sans Serif"));     // request a face name 
#endif
	CFont font;
	font.Detach();
	VERIFY(font.CreateFontIndirect(&lf));		// create the font
	
	CFont* pOldFont = pDC->SelectObject(&font);

	CString csTemp = _T("0");
	csTemp.Format(_T("%d"),m_nPageNo);	
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(100,100,100));	
	pDC->DrawText(csTemp,&rect,DT_SINGLELINE|DT_VCENTER|DT_CENTER);
	rect.OffsetRect(1,1);
	pDC->SetTextColor(RGB(0,0,0));
	pDC->DrawText(csTemp,&rect,DT_SINGLELINE|DT_VCENTER|DT_CENTER);
	pDC->SetBkMode(OPAQUE);
	

	pDC->SelectObject(pOldFont);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(brOld);
}

void CPageNumber::SetCurrentPage(int nPage)
{
	m_nPageNo = nPage;
	this->Invalidate(FALSE);
}
