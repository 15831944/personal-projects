// ColorCombo.cpp : implementation file
//

#include "stdafx.h"
#include "LEDSignCtrl.h"
#include "ColorCombo.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CColorCombo

CColorCombo::CColorCombo()
{
}

CColorCombo::~CColorCombo()
{
}


BEGIN_MESSAGE_MAP(CColorCombo, CComboBox)
	//{{AFX_MSG_MAP(CColorCombo)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CColorCombo message handlers

void CColorCombo::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct) 
{
	if (lpDrawItemStruct->CtlType != ODT_COMBOBOX)
		return ;

	LPCTSTR lpszText = (LPCTSTR) lpDrawItemStruct->itemData;
	ASSERT(lpszText != NULL);
	CDC dc,*pDC = NULL;
	dc.Attach(lpDrawItemStruct->hDC);
	pDC = &dc;

	CString csItem = lpszText;	

	CBrush brR(RGB(255,0,0));
	CBrush brG(RGB(0,255,0));
	CBrush brY(RGB(255,255,0));
	CBrush brB(RGB(0,0,255));
	CBrush brW(RGB(255,255,255));

	CPen pen(PS_SOLID,3,RGB(0,0,0));
	CPen* pOldPen = pDC->SelectObject(&pen);
	CBrush* pBrOld = NULL;
	if (csItem.GetAt(0) == 'R') 
		pBrOld = pDC->SelectObject(&brR);
	if (csItem.GetAt(0) == 'G') 
		pBrOld = pDC->SelectObject(&brG);
	if (csItem.GetAt(0) == 'Y') 
		pBrOld = pDC->SelectObject(&brY);
	if (csItem.GetAt(0) == 'B') 
		pBrOld = pDC->SelectObject(&brB);
	if (csItem.GetAt(0) == 'W') 
		pBrOld = pDC->SelectObject(&brW);
	pDC->Rectangle(&lpDrawItemStruct->rcItem);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(pBrOld);
	
	pDC->Detach();
	
}

COLORREF CColorCombo::GetColorItem(int nIndex)
{	
	COLORREF clrItem = RGB(0,0,0);
	
	return clrItem;
}
