// ColorStatic.cpp : implementation file
//

#include "stdafx.h"
#include "ColorStatic.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CColorStatic

CColorStatic::CColorStatic()
{
	m_clrBk = RGB(255,0,0);
}

CColorStatic::~CColorStatic()
{
}


BEGIN_MESSAGE_MAP(CColorStatic, CStatic)
	//{{AFX_MSG_MAP(CColorStatic)
	ON_WM_CTLCOLOR()
	ON_WM_PAINT()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CColorStatic message handlers

HBRUSH CColorStatic::OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor) 
{
	HBRUSH hbr = CStatic::OnCtlColor(pDC, pWnd, nCtlColor);
	
	
	return hbr;
}

void CColorStatic::OnPaint() 
{
	CPaintDC dc(this); // device context for painting	
	
	CDC* pDC = &dc;
	CRect rect;
	GetClientRect(&rect);	
		
	CPen pen(PS_NULL,0,m_clrBk);
	CPen* pOldPen = pDC->SelectObject(&pen);
	CBrush br(m_clrBk);
	CBrush* pOldBr= pDC->SelectObject(&br);
	
	pDC->Rectangle(rect);

	pDC->SelectObject(pOldBr);
	pDC->SelectObject(pOldPen);
}

