// ColorText.cpp : implementation file
//

#include "stdafx.h"
#include "matrix.h"
#include "ColorText.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CColorText

CColorText::CColorText()
{
}

CColorText::~CColorText()
{
}


BEGIN_MESSAGE_MAP(CColorText, CStatic)
	//{{AFX_MSG_MAP(CColorText)
	ON_WM_CTLCOLOR_REFLECT()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CColorText message handlers

HBRUSH CColorText::CtlColor(CDC* pDC, UINT nCtlColor) 
{		
	COLORREF bkClr = GetSysColor(COLOR_3DFACE);
	CBrush brush(bkClr);			
	
	CRect rect;
	CBrush* brOld = pDC->SelectObject(&brush);
	pDC->SetTextColor(RGB(255,0,0));
	pDC->SetBkColor(bkClr);
	GetWindowRect(&rect);
	pDC->Rectangle(&rect);

	return HBRUSH(brush);
}
