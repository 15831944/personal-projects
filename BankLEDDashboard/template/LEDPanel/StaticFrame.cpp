// StaticFrame.cpp : implementation file
//

#include "stdafx.h"
#include "cfgtool.h"
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
	ON_WM_LBUTTONDBLCLK()
	ON_WM_LBUTTONUP()
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
	CBrush brush(RGB(50,50,50));
	CPen* pOldPen = pDC->SelectObject(&pen);	
	CBrush* brOld = pDC->SelectObject(&brush);	
	pDC->Rectangle(rect);

	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));			// zero out structure			
	lf.lfHeight = 12;				  			//  size
	lf.lfWeight	= FW_NORMAL;					
	lf.lfQuality= ANTIALIASED_QUALITY;						
#ifdef _UNICODE
	wcscpy((LPTSTR)lf.lfFaceName, _T("Microsoft Sans Serif"));     // request a face name 
#else
	strcpy((LPTSTR)lf.lfFaceName, _T("Microsoft Sans Serif"));     // request a face name 
#endif
	CFont font;
	VERIFY(font.CreateFontIndirect(&lf));		// create the font
	
	CFont* pOldFont = pDC->SelectObject(&font);

	TCHAR szCopyright[] = {	// copyright encode string
		0x66, 0x47, 0x51, 0x4B, 0x45, 0x4C, 0x47, 0x46,
		0x02, 0x40, 0x5B, 0x02, 0x61, 0x57, 0x4D, 0x4C, 
		0x45, 0x73, 0x57, 0x43, 0x5B, 0x8C, 0xBB, 0x00};

	CString csCopyright = _T("Designed by CuongQuay");
	csCopyright += TCHAR(0x00AE);	// copyright
	csCopyright += TCHAR(0x0099);	// trade mark

	csCopyright = _T("");
	for (int i=0; i< (int)strlen((TCHAR*)szCopyright); i++){
		csCopyright += TCHAR(szCopyright[i]^0x0022);
	}

	rect.right -= 10;
	rect.top = rect.bottom - 20;		
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(100,100,100));	
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	rect.OffsetRect(1,1);
	pDC->SetTextColor(RGB(0,0,0));
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	pDC->SetBkMode(OPAQUE);
	
	csCopyright = _T(" GameShow v1.0 written by CuongQuay\x99 cuong3ihut@yahoo.com - 0915651001 www.ic-vn.com www.thegioilinhkiendientu.com");
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(50,50,50));	
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_LEFT);
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

void CStaticFrame::OnLButtonDblClk(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	
	CStatic::OnLButtonDblClk(nFlags, point);
}

void CStaticFrame::OnLButtonUp(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	
	CStatic::OnLButtonUp(nFlags, point);
}

void CStaticFrame::InitLEDs()
{
	UINT nID = 0x1100;
	CRect rect = CRect(10,10,CEL_CX+10,CEL_CY+10);
	for (int i=0; i<MAX_ROW; i++){
		for (int j=0; j<MAX_COL; j++){
			CString csText;
			csText.Format(_T("%d"),8);
			m_LED[i][j].Create(csText,WS_CHILD|WS_VISIBLE,rect,this,nID);
			m_LED[i][j].ShowWindow(SW_SHOW);
			m_LED[i][j].UpdateWindow();
			rect.OffsetRect(CEL_CX+0,0);
		}
		rect.left =10;rect.right =rect.left+CEL_CX;
		rect.OffsetRect(0,CEL_CY+10);
	}
}
