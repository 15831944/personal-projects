// StaticFrame.cpp : implementation file
//

#include "stdafx.h"
#include "StaticFrame.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CStaticFrame

CStaticFrame::CStaticFrame()
{
}

CStaticFrame::~CStaticFrame()
{
}


BEGIN_MESSAGE_MAP(CStaticFrame, CStatic)
	//{{AFX_MSG_MAP(CStaticFrame)
	ON_WM_PAINT()
	ON_WM_CREATE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CStaticFrame message handlers

void CStaticFrame::OnPaint() 
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
	lf.lfHeight = 12;				  			//  size
	lf.lfWeight	= FW_NORMAL;					
	lf.lfQuality= ANTIALIASED_QUALITY;						
#ifdef _UNICODE
	wcscpy_s((LPTSTR)lf.lfFaceName, LF_FACESIZE, _T("Microsoft Sans Serif"));     // request a face name 
#else
	strcpy_s((LPTSTR)lf.lfFaceName, LF_FACESIZE, _T("Microsoft Sans Serif"));     // request a face name 
#endif
	CFont font;
	VERIFY(font.CreateFontIndirect(&lf));		// create the font
	
	CFont* pOldFont = pDC->SelectObject(&font);
#ifdef _UNICODE
	TCHAR szCopyright[] = {	// copyright encode string
		0x66, 0x47, 0x51, 0x4B, 0x45, 0x4C, 0x47, 0x46,
		0x02, 0x40, 0x5B, 0x02, 0x61, 0x57, 0x4D, 0x4C, 
		0x45, 0x73, 0x57, 0x43, 0x5B, 0x8C, 0xBB, 0x00};
#else
	BYTE szCopyright[] = {	// copyright encode string
		0x66, 0x47, 0x51, 0x4B, 0x45, 0x4C, 0x47, 0x46,
		0x02, 0x40, 0x5B, 0x02, 0x61, 0x57, 0x4D, 0x4C, 
		0x45, 0x73, 0x57, 0x43, 0x5B, 0x8C, 0xBB, 0x00};
#endif
	CString csCopyright = _T("Designed by CuongQuay");
	csCopyright += TCHAR(0x00AE);	// copyright
	csCopyright += TCHAR(0x0099);	// trade mark

	csCopyright = _T("");
#ifdef _UNICODE
	for (int i=0; i< (int)wcslen((TCHAR*)szCopyright); i++){
		csCopyright += TCHAR(szCopyright[i]^0x0022);
	}
#else
	for (int i=0; i< (int)strlen((TCHAR*)szCopyright); i++){
		csCopyright += TCHAR(szCopyright[i]^0x0022);
	}
#endif
	rect.right -= 10;
	rect.top = rect.bottom - 20;		
	
	rect.OffsetRect(0,-18);
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(100,100,100));	
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	rect.OffsetRect(1,1);
	pDC->SetTextColor(RGB(0,0,0));
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	pDC->SetBkMode(OPAQUE);
	
	rect.OffsetRect(0,+18);
	csCopyright = _T(" This software is written by CuongQuay\x99 cuong3ihut@yahoo.com - 0915651001");
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(50,50,50));	
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	pDC->SetBkMode(OPAQUE);
	
	pDC->SelectObject(pOldFont);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(brOld);

	CStatic::OnPaint();
}

int CStaticFrame::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CStatic::OnCreate(lpCreateStruct) == -1)
		return -1;

	return 0;
}





