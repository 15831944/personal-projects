// LEDTextCtrl.cpp : implementation file
//

#include "stdafx.h"
#include "LEDSignToolKit.h"
#include "LEDTextCtrl.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#ifdef __cplusplus
extern "C" {
#endif

#include "LEDData.h"

#ifdef __cplusplus
}
#endif

static int nTickCount = 0;	
static int nCurrentRow = 0;	

extern UWord16* tbuwDataBuffer;
extern LEDDataStruct* lpstrLEDInfor;

const UINT CLEDTextCtrl::mg_nTextCtrlMsg = ::RegisterWindowMessage(_T("CLEDTextCtrl_DefaultTextMsg"));
/////////////////////////////////////////////////////////////////////////////
// CLEDTextCtrl


CLEDTextCtrl::CLEDTextCtrl()
{
	m_strLEDText ="Quang Cao Anh Duong";
	m_clrLEDText = RGB(0,0,0);
	m_hwndDest = NULL;
}

CLEDTextCtrl::~CLEDTextCtrl()
{	
}


BEGIN_MESSAGE_MAP(CLEDTextCtrl, CStatic)
	//{{AFX_MSG_MAP(CLEDTextCtrl)
	ON_WM_PAINT()
	ON_WM_TIMER()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLEDTextCtrl message handlers

void CLEDTextCtrl::OnPaint() 
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

	
	this->DisplayData(pDC, m_strLEDText);

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
	font.Detach();
	VERIFY(font.CreateFontIndirect(&lf));		// create the font
	
	CFont* pOldFont = pDC->SelectObject(&font);

	TCHAR szCopyright[] = {	// copyright encode string
		0x66, 0x47, 0x51, 0x4B, 0x45, 0x4C, 0x47, 0x46,
		0x02, 0x40, 0x5B, 0x02, 0x61, 0x57, 0x4D, 0x4C, 
		0x45, 0x73, 0x57, 0x43, 0x5B, 0x8C, 0xBB, 0x00};

	CString csCopyright = _T("Designed by CuongQuay");
	csCopyright += char(0xAE);	// copyright
	csCopyright += char(0x99);	// trade mark

	csCopyright = _T("");

	for (int i=0; i< (int)strlen(szCopyright); i++){
		csCopyright += TCHAR(szCopyright[i]^0x22);
	}
	
	rect.right -= 10;
	rect.top = rect.bottom - 20 - GetSystemMetrics(SM_CYHSCROLL);		
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(100,100,100));	
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	rect.OffsetRect(1,1);
	pDC->SetTextColor(RGB(0,0,0));
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	pDC->SetBkMode(OPAQUE);
	

	pDC->SelectObject(pOldFont);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(brOld);

	this->DisplayData(&dc, m_strLEDText);
}

void CLEDTextCtrl::SetWindowText(LPCTSTR lpszText)
{
	m_strLEDText = lpszText;	
	this->Invalidate(FALSE);
}

void CLEDTextCtrl::SetColorText(COLORREF clrText)
{
	m_clrLEDText = clrText;
	this->Invalidate(FALSE);
}

#define ID_TIMER	1980

void CLEDTextCtrl::Run()
{
	SetTimer(ID_TIMER,1,NULL);
}

void CLEDTextCtrl::Stop()
{
	KillTimer(ID_TIMER);
	nCurrentRow = 0;
	nTickCount = 0;
}

void CLEDTextCtrl::OnTimer(UINT nIDEvent) 
{
	LEDDataStruct* pData = (LEDDataStruct*)lpstrLEDInfor;		
	
	if (++nTickCount > (int)tbuwDataBuffer[nCurrentRow])
	{		
		nTickCount = 0;
		nCurrentRow++;		
		SetColumnData(tbuwDataBuffer[nCurrentRow], pData);			

		WPARAM wParam = ((nCurrentRow/2)%(int)pData->ubNumOfRow)<<8;		
		wParam |= ((nCurrentRow/2)/(int)pData->ubNumOfRow & 0x00FF);		

		if (m_hwndDest != NULL)
			::PostMessage(m_hwndDest,mg_nTextCtrlMsg,WPARAM(wParam),LPARAM(tbuwDataBuffer[nCurrentRow]));

		if (++nCurrentRow > 2*(int)pData->ubNumOfRow*(int)pData->ubNumOfPage)
		{								
			nCurrentRow = 0;			
		}			
		
	}
	
	CStatic::OnTimer(nIDEvent);
}

void CLEDTextCtrl::SetColumnData(UWord16 uwData, const LEDDataStruct* pData)
{		
	CClientDC dc(this);
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
	lf.lfHeight = 80;				  			//  size
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

	rect.left += 10;
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(100,100,100));	
	pDC->DrawText(m_strLEDText,&rect,DT_SINGLELINE|DT_VCENTER|DT_LEFT);
	rect.OffsetRect(1,1);
	pDC->SetTextColor(m_clrLEDText);
	pDC->DrawText(m_strLEDText,&rect,DT_SINGLELINE|DT_VCENTER|DT_LEFT);
	pDC->SetBkMode(OPAQUE);		
	
	UWord16 uwBitmask = 0x0001;
	CString strTemp = m_strLEDText;
	strTemp.Remove(TCHAR(' '));
	int i = 0;
	for (int x=0; x< (int)pData->ubNumOfCol; x++)
	{				
		if (i< m_strLEDText.GetLength())
				if (m_strLEDText.GetAt(i)==TCHAR(' '))			
					i++;
		if ( (uwBitmask&uwData) ==0x0000 )
		{												
			CSize sz1 = pDC->GetTextExtent(m_strLEDText,i);
			CSize sz2 = pDC->GetTextExtent(m_strLEDText,i+1);
			CRect rcMask = CRect(rect);
			rcMask.left  = 10 + sz1.cx -2;
			rcMask.right = 10 + sz2.cx +2;		
			rcMask.bottom -=3;
			CBrush br2(RGB(0,0,0));
			pDC->SelectObject(&br2);
			pDC->Rectangle(rcMask);
		}
		uwBitmask = uwBitmask<<1;	
		i++;
	}
	
	pDC->SelectObject(pOldFont);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(brOld);	
		
	TRACE(_T("Data=%02X \n"),uwData);
}

void CLEDTextCtrl::DisplayData(CDC* pDC, LPCTSTR lpszText)
{	
	CRect rect;
	GetClientRect(rect);
	CPen pen(PS_NULL,1,RGB(0,0,0));
	CBrush brush(RGB(0,0,0));
	CPen* pOldPen = pDC->SelectObject(&pen);	
	CBrush* brOld = pDC->SelectObject(&brush);	
	pDC->Rectangle(rect);

	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));			// zero out structure			
	lf.lfHeight = 80;				  			//  size
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

	rect.left += 10;
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(100,100,100));	
	pDC->DrawText(lpszText,&rect,DT_SINGLELINE|DT_VCENTER|DT_LEFT);
	rect.OffsetRect(1,1);
	pDC->SetTextColor(m_clrLEDText);
	pDC->DrawText(lpszText,&rect,DT_SINGLELINE|DT_VCENTER|DT_LEFT);
	pDC->SetBkMode(OPAQUE);		

	pDC->SelectObject(pOldFont);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(brOld);
}

void CLEDTextCtrl::Attach(HWND hwnd)
{
	m_hwndDest = hwnd;
}
