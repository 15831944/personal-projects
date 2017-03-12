// LEDSignCtrl.cpp : implementation file
//

#include "stdafx.h"
#include "LEDSignToolKit.h"
#include "LEDSignCtrl.h"

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

LEDDataStruct* lpstrLEDInfor = NULL;
UWord16* tbuwDataBuffer = NULL;
/////////////////////////////////////////////////////////////////////////////
// CLEDSignCtrl

CLEDSignCtrl::CLEDSignCtrl()
{
	m_nActiveRow = -1;
	m_nCurrentPage = 0;
	lpstrLEDInfor = LEDChanel;
	int nBufferSize = lpstrLEDInfor->ubNumOfRow*(2*sizeof(UWord16))*lpstrLEDInfor->ubNumOfPage;
	tbuwDataBuffer = (UWord16*)malloc(nBufferSize);
	memcpy(tbuwDataBuffer, _LEDChanelBuffer + 3, nBufferSize);
}

CLEDSignCtrl::~CLEDSignCtrl()
{
	if (tbuwDataBuffer != NULL)
		free(tbuwDataBuffer);
}


BEGIN_MESSAGE_MAP(CLEDSignCtrl, CStatic)
	//{{AFX_MSG_MAP(CLEDSignCtrl)
	ON_WM_CTLCOLOR_REFLECT()
	ON_WM_PAINT()
	ON_WM_LBUTTONUP()
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONDBLCLK()
	ON_WM_MOUSEMOVE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLEDSignCtrl message handlers

HBRUSH CLEDSignCtrl::CtlColor(CDC* pDC, UINT nCtlColor) 
{
	// TODO: Change any attributes of the DC here
	
	// TODO: Return a non-NULL brush if the parent's handler should not be called
	return NULL;
}

void CLEDSignCtrl::OnPaint() 
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

	this->DrawGrid(pDC, CPoint(0,0));

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
	csCopyright += char(0xAE);	// copyright
	csCopyright += char(0x99);	// trade mark

	csCopyright = _T("");

	for (int i=0; i< (int)strlen(szCopyright); i++){
		csCopyright += TCHAR(szCopyright[i]^0x22);
	}
	
	rect.right -= 10;
	rect.top = rect.bottom - 10 - GetSystemMetrics(SM_CYHSCROLL);		
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
}

void CLEDSignCtrl::DrawDelay(CDC *pDC, int nDelay, const CRect &rect)
{
	CString strTemp = _T("");
	strTemp.Format(_T("%d ms"),nDelay);
	CRect rc = CRect(rect);	
	
	CPen pen(PS_SOLID,1,RGB(0,0,0));		
	CPen* pOldPen = pDC->SelectObject(&pen);	
	rc.DeflateRect(4,4,4,4);
	rc.right -= 10;

	pDC->Rectangle(rc);
	
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(100,100,100));		
	pDC->DrawText(strTemp, &rc, DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	pDC->SetBkMode(OPAQUE);
	pDC->SelectObject(pOldPen);	
}

void CLEDSignCtrl::DrawGrid(CDC* pDC, const CPoint& point)
{
	CRect rect;
	GetClientRect(rect);
	int cx = rect.Height()/lpstrLEDInfor->ubNumOfCol;
	CRect rcLED = CRect(rect);
	rcLED.right = rcLED.left + cx;
	rcLED.bottom = rcLED.top + cx;
	
	UINT nCurrentRow = 0;		
	
	UWord16* pDataBuffer = tbuwDataBuffer + (m_nCurrentPage-1)*lpstrLEDInfor->ubNumOfRow*2;

	if (m_nActiveRow >=0)
	{
		CPen pen(PS_SOLID,2,RGB(255,100,100));		
		CPen* pOldPen= pDC->SelectObject(&pen);			
		CRect rcRow = rect;			
		rcRow.left += (cx-1)*lpstrLEDInfor->ubNumOfCol + 1;
		rcRow.bottom = rcRow.top + cx;
		rcRow.DeflateRect(2,2,2,2);
		rcRow.OffsetRect(0, (cx-1)*m_nActiveRow);
		pDC->Rectangle(rcRow);
		pDC->SelectObject(pOldPen);	
	}

	for (int y=0; y< (int)lpstrLEDInfor->ubNumOfRow; y++)
	{		
		int nDelay = pDataBuffer[nCurrentRow++];		

		CRect rcDelay = CRect(rcLED);
		rcDelay.right = rect.right;
		rcDelay.left += rect.Height();
		this->DrawDelay(pDC, nDelay, rcDelay);
		
		UWord16 uwData = pDataBuffer[nCurrentRow++];
		UWord16 uwBitmask = 0x0001;			

		for (int x=0; x< (int)lpstrLEDInfor->ubNumOfCol; x++)
		{
			CPen pen(PS_SOLID,1,RGB(100,100,100));		
			CPen* pOldPen= pDC->SelectObject(&pen);
			pDC->Rectangle(rcLED);
			pDC->SelectObject(pOldPen);	
			this->DrawLED(pDC,rcLED, (uwBitmask&uwData)?true:false);
			pDC->SelectObject(pOldPen);
			rcLED.OffsetRect(cx-1,0);
			uwBitmask = uwBitmask<<1;
		}			

		rcLED.left = rect.left;
		rcLED.right = rcLED.left + cx;
		rcLED.OffsetRect(0,cx-1);
	}		
}

void CLEDSignCtrl::DrawLED(CDC* pDC, const CRect& rect, BOOL bLEDOn)
{
	CBrush brOn(RGB(250,0,0));	
	CBrush brOff(RGB(50,0,0));	
	CBrush* pBrOld = NULL;	
	pBrOld = pDC->SelectObject(bLEDOn?&brOn:&brOff);	
	CRect rcLED = CRect(rect);
	rcLED.DeflateRect(10,10);
	pDC->Ellipse(rcLED);
	pDC->SelectObject(pBrOld);
}

void CLEDSignCtrl::OnLButtonUp(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	
	CStatic::OnLButtonUp(nFlags, point);
}

void CLEDSignCtrl::OnLButtonDown(UINT nFlags, CPoint point) 
{
	CClientDC dc(this); // device context for painting	
	CDC* pDC = &dc;
	CRect rect;
	GetClientRect(rect);
	rect.OffsetRect(0,0);
	int cx = rect.Height()/lpstrLEDInfor->ubNumOfCol;
	CRect rcLED = CRect(rect);
	rcLED.right = rcLED.left + cx;
	rcLED.bottom = rcLED.top + cx;
	
	UINT nCurrentRow = 0;			
	
	UWord16* pDataBuffer = tbuwDataBuffer + (m_nCurrentPage-1)*lpstrLEDInfor->ubNumOfRow*2;

	for (int y=0; y< (int)lpstrLEDInfor->ubNumOfRow; y++)
	{		
		nCurrentRow++;
		UWord16 uwBitmask = 0x0001;		
		UWord16* puwData = (UWord16*)&pDataBuffer[nCurrentRow++];

		for (int x=0; x< (int)lpstrLEDInfor->ubNumOfCol; x++)
		{			
			if (rcLED.PtInRect(point))
			{
				if (uwBitmask&(*puwData))
				{
					(*puwData) &= ~(uwBitmask);
				}
				else
				{
					(*puwData) |= (uwBitmask);
				}
			}
			CPen pen(PS_SOLID,1,RGB(100,100,100));		
			CPen* pOldPen= pDC->SelectObject(&pen);
			CBrush brush(RGB(0,0,0));	
			CBrush* pOldBrush = pDC->SelectObject(&brush);	
			pDC->Rectangle(rcLED);
			pDC->SelectObject(pOldPen);	
			this->DrawLED(pDC,rcLED, (uwBitmask&(*puwData))?true:false);					
			pDC->SelectObject(pOldPen);			
			pDC->SelectObject(pOldBrush);	

			rcLED.OffsetRect(cx-1,0);
			uwBitmask = uwBitmask<<1;
		}			

		rcLED.left = rect.left;
		rcLED.right = rcLED.left + cx;
		rcLED.OffsetRect(0,cx-1);
	}		
	
	CStatic::OnLButtonDown(nFlags, point);
}

#include "DelaySettingDlg.h"
void CLEDSignCtrl::OnLButtonDblClk(UINT nFlags, CPoint point) 
{
	CClientDC dc(this);
	CDC* pDC =&dc;
	CRect rect;
	GetClientRect(rect);
	int cx = rect.Height()/lpstrLEDInfor->ubNumOfCol;
	CRect rcLED = CRect(rect);
	rcLED.right = rcLED.left + cx;
	rcLED.bottom = rcLED.top + cx;
	
	UINT nCurrentRow = 0;		
	
	UWord16* pDataBuffer = tbuwDataBuffer + (m_nCurrentPage-1)*lpstrLEDInfor->ubNumOfRow*2;

	for (int y=0; y< (int)lpstrLEDInfor->ubNumOfRow; y++)
	{		
		UWord16* pDelay = &pDataBuffer[nCurrentRow++];
		CRect rcDelay = CRect(rcLED);
		rcDelay.right = rect.right;
		rcDelay.left += rect.Height();
	
		if (rcDelay.PtInRect(point))
		{
			CDelaySettingDlg dlg;
			dlg.m_nDelay = *pDelay;			
			if (dlg.DoModal()==IDOK)
			{
				*pDelay = dlg.m_nDelay;
			}
		}		

		nCurrentRow++;

		rcLED.left = rect.left;
		rcLED.right = rcLED.left + cx;
		rcLED.OffsetRect(0,cx-1);
	}

	this->Invalidate(FALSE);
	
	CStatic::OnLButtonDblClk(nFlags, point);
}

void CLEDSignCtrl::OnMouseMove(UINT nFlags, CPoint point) 
{	
	CStatic::OnMouseMove(nFlags, point);
}

int CLEDSignCtrl::GetNumOfPage()
{
	return lpstrLEDInfor->ubNumOfPage;
}

void CLEDSignCtrl::SetCurrentPage(int nPage)
{
	m_nCurrentPage = nPage;
	this->Invalidate(FALSE);
}

void CLEDSignCtrl::SetParameters(int nRow, int nCol, int nPage)
{
	lpstrLEDInfor = LEDChanel;
	lpstrLEDInfor->ubNumOfRow = nRow;
	lpstrLEDInfor->ubNumOfCol = nCol;
	lpstrLEDInfor->ubNumOfPage = nPage;
	if (tbuwDataBuffer !=NULL)
	{
		free(tbuwDataBuffer);
		tbuwDataBuffer = NULL;
	}
	int nBufferSize = lpstrLEDInfor->ubNumOfRow*(2*sizeof(UWord16))*lpstrLEDInfor->ubNumOfPage;
	tbuwDataBuffer = (UWord16*)malloc(nBufferSize);
	memcpy(tbuwDataBuffer, _LEDChanelBuffer + 3, nBufferSize);
}


void CLEDSignCtrl::SetActiveRow(int nActiveRow)
{
	m_nActiveRow = nActiveRow;
	this->Invalidate(TRUE);
}
