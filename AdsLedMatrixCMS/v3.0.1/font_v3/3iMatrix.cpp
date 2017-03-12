// 3iMatrix.cpp : implementation file
//

#include "stdafx.h"
#include "ShiftReg.h"
#include "3iMatrix.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// C3iMatrix

C3iMatrix::C3iMatrix()
{	
	m_pDCMem = NULL;	
	m_nZoomScale = 0;
	m_nLineMode  = 0;
	m_bReCalcMatrix = FALSE;
	m_clrPen = RGB(255,0,0);
	m_clrBrush = RGB(255,0,0);
	m_ptPosition = CPoint(0,0);	
	m_pCurLineList = &m_arrLineList;
	m_arrLineList.RemoveAll();
}

C3iMatrix::~C3iMatrix()
{
	m_pDCMem->SelectObject(m_pOldBitmap);
	m_pDCMem->DeleteDC();
	delete m_pDCMem;
	this->ReleaseDataLine(&m_arrLineList);
}


BEGIN_MESSAGE_MAP(C3iMatrix, CStatic)
	//{{AFX_MSG_MAP(C3iMatrix)
	ON_WM_DESTROY()
	ON_WM_LBUTTONDOWN()
	ON_WM_PAINT()
	ON_WM_VSCROLL()
	ON_WM_HSCROLL()
	ON_WM_MOUSEMOVE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// C3iMatrix message handlers

BOOL C3iMatrix::DestroyWindow() 
{
	// TODO: Add your specialized code here and/or call the base class
	
	return CStatic::DestroyWindow();
}

void C3iMatrix::OnDestroy() 
{
	CStatic::OnDestroy();
	
	// TODO: Add your message handler code here
	
}

void C3iMatrix::OnLButtonDown(UINT nFlags, CPoint point) 
{		
	int x = (point.x + abs(m_ptPosition.x))/m_nZoomScale;
	int y = (point.y + abs(m_ptPosition.y))/m_nZoomScale;
		
	if (!OnSetPixel(nFlags,x,y)){
		SetPixel(x,y,m_clrPen);	
	}
}

void C3iMatrix::OnPaint() 
{
	CPaintDC dc(this); // device context for painting	
	CRect rect;
	GetClientRect(rect);
	
	if (m_pDCMem == NULL){
		m_pDCMem = new CDC();
		m_pDCMem->CreateCompatibleDC(GetDC()); 
		m_bmpDCMem.CreateCompatibleBitmap(GetDC(), rect.Width(),rect.Height() );
		m_pOldBitmap = m_pDCMem->SelectObject(&m_bmpDCMem);
		this->DrawFrame(FALSE);	// init matrix grid
	}		
	else if (m_bReCalcMatrix){
		m_bReCalcMatrix = FALSE;
		if(m_bmpDCMem.DeleteObject()){
			m_bmpDCMem.CreateCompatibleBitmap(GetDC(), rect.Width(),rect.Height() );
			m_pOldBitmap = m_pDCMem->SelectObject(&m_bmpDCMem);
			this->DrawFrame(FALSE);	// init matrix grid
		}
	}
	dc.BitBlt(0,0,rect.Width(), rect.Height(),m_pDCMem,0,0,SRCCOPY);	
	dc.DrawEdge(&rect,BDR_RAISEDINNER,BF_RECT|BF_ADJUST);	
	dc.DrawEdge(&rect,BDR_SUNKENINNER,BF_RECT|BF_ADJUST);	
	
}

void C3iMatrix::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
	m_ptPosition.y = -int(nPos);
	SetWindowPos(NULL,m_ptPosition.x,m_ptPosition.y,0,0,SWP_NOSIZE|SWP_NOREDRAW);
}

void C3iMatrix::OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
	m_ptPosition.x = -int(nPos);
	SetWindowPos(NULL,m_ptPosition.x,m_ptPosition.y,0,0,SWP_NOSIZE|SWP_NOREDRAW);
}

BOOL C3iMatrix::AddDataLine(LINE_LIST *pLineList,CShiftReg *pLR, CShiftReg *pLG, CShiftReg *pLB)
{
	if (!m_pCurLineList){
		return FALSE;
	}

	CLineColor* pLineColor = new CLineColor();
	if (AfxIsMemoryBlock(pLineColor,sizeof(CLineColor))){
		pLineColor->m_pLineR = pLR;
		pLineColor->m_pLineG = pLG;
		pLineColor->m_pLineB = pLB;
		pLineList->Add(pLineColor);
	}
	else{		
		pLineColor = NULL;
		return FALSE;
	}
	return TRUE;
}

BOOL C3iMatrix::InitLineList(LINE_LIST* pLineList)
{
	return FALSE;
}

BOOL C3iMatrix::RemoveDataLine()
{
	if (!m_pCurLineList){
		return FALSE;
	}
	int nIndex = m_pCurLineList->GetSize()-1;
	CLineColor* pLineColor = m_pCurLineList->GetAt(nIndex);
	if (AfxIsMemoryBlock(pLineColor,sizeof(CLineColor))){
		m_pCurLineList->RemoveAt(nIndex);
	}
	else{		
		delete pLineColor;
		m_pCurLineList->RemoveAt(nIndex);
		return FALSE;
	}
	return TRUE;
}

BOOL C3iMatrix::Init(int cx, int cy, int nLineMode, int nZoom)
{	
	this->SetSizeInPixel(cx,cy);
	this->SetLineMode(nLineMode);
	this->SetZoomScale(nZoom);
	this->InitLineList(&m_arrLineList);
	this->ReCalcMatrixClient();

	return TRUE;
}

void C3iMatrix::DrawTest()
{	
	CPen pen(PS_SOLID,1,RGB(255,255,255));
	m_pDCMem->SelectObject(&pen);
	m_pDCMem->SetTextColor(RGB(255,0,0));
	m_pDCMem->SetBkColor(RGB(0,0,0));
	CRect rect;
	GetClientRect(&rect);
	m_pDCMem->DrawText("THIS IS A DRAW TEST",rect,DT_SINGLELINE|DT_VCENTER|DT_CENTER);

	this->Invalidate();
}

void C3iMatrix::ReCalcMatrixClient()
{
	CRect rect;
	GetClientRect(&rect);	
	m_bReCalcMatrix = TRUE;
	int cx = m_nZoomScale*m_sizePixel.cx;
	int cy = m_nZoomScale*m_sizePixel.cy;
	SetWindowPos(NULL,0,0,cx,cy,SWP_NOMOVE|SWP_FRAMECHANGED);	
}

void C3iMatrix::DrawFrame(BOOL bRefresh)
{		
	if (!m_pCurLineList){
		return;
	}

	// transfer to memDC buffer
	for (int x = 0; x< m_sizePixel.cx; x++){				
		for (int y = 0; y < m_sizePixel.cy; y++){			
			CPoint realPoint = OnChangePosition(x,y);
			if (m_pCurLineList->GetSize() > realPoint.y){				
				CLineColor* pLine = m_pCurLineList->GetAt(realPoint.y);				
				this->DrawPixel(pLine->GetPixel(realPoint.x),x,y);			
			}			
		}		
	}
	
	if (bRefresh){
		this->Invalidate(FALSE);
	}
}

void C3iMatrix::DrawPixel(const COLORREF& clr, int x, int y, BOOL bDraw)
{	
	CRect rc;
	GetClientRect(&rc);
	int cy = (rc.Height()/m_sizePixel.cy);
	int cx = (rc.Width()/m_sizePixel.cx);
	CRect rcPixel = CRect(rc);
	rcPixel.right = rcPixel.left + cx +1 ;
	rcPixel.bottom = rcPixel.top + cy +1 ;
	rcPixel.OffsetRect(x*cx,y*cy);
	
	CBrush br(clr);
	CPen pen(PS_SOLID,1,RGB(100,100,100));
	if (m_pDCMem){
		if (m_pDCMem->m_hDC){
			m_pDCMem->SelectObject(&br);
			m_pDCMem->SelectObject(&pen);
		}
		if (m_nZoomScale ==1){
			m_pDCMem->SetPixel(rcPixel.left,rcPixel.top,clr);
		}
		else
		if (m_nZoomScale ==2){
#if 0
			m_pDCMem->SetPixel(rcPixel.left-1,rcPixel.top-0,clr);
			m_pDCMem->SetPixel(rcPixel.left-1,rcPixel.top-1,clr);
			m_pDCMem->SetPixel(rcPixel.left,rcPixel.top-0,clr);
			m_pDCMem->SetPixel(rcPixel.left,rcPixel.top-1,clr);
#endif
			m_pDCMem->Rectangle(rcPixel);
		}
		else{
			m_pDCMem->Rectangle(rcPixel);
		}
		if (bDraw){
			InvalidateRect(rcPixel);
		}
	}
}

void C3iMatrix::ReleaseDataLine(LINE_LIST* pLineList)
{	
	if (!pLineList){
		return;
	}
	while (pLineList->GetSize()){
		CLineColor* pLineColor = pLineList->GetAt(0);
		if (AfxIsMemoryBlock(pLineColor,sizeof(CLineColor))){
			if (pLineColor->m_pLineR)
				delete pLineColor->m_pLineR;
			if (pLineColor->m_pLineG)
				delete pLineColor->m_pLineG;
			if (pLineColor->m_pLineB)
				delete pLineColor->m_pLineB;
			delete pLineColor;
			pLineList->RemoveAt(0);
		}
		else{
			pLineList->RemoveAt(0);
			continue;
		}
	}	
}

void C3iMatrix::SetPixel(int x, int y, COLORREF clr)
{
	if (!m_pCurLineList){
		return;
	}

	CPoint realPoint = OnChangePosition(x,y);
	
	if (m_pCurLineList->GetSize() > realPoint.y){
		CLineColor* pLineColor = m_pCurLineList->GetAt(realPoint.y);
		if (AfxIsMemoryBlock(pLineColor,sizeof(CLineColor))){
			pLineColor->SetPixel(realPoint.x,clr);
			this->DrawPixel(clr,x,y,TRUE);			
		}
	}	
}

BOOL C3iMatrix::OnSetPixel(UINT nFlags, int x, int y)
{
	return FALSE;
}

#include "resource.h"
void C3iMatrix::OnMouseMove(UINT nFlags, CPoint point) 
{
	HCURSOR hCur = ::LoadCursor(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDC_SELECT_POINT));	
	SetClassLong(this->m_hWnd, GCL_HCURSOR,	(LONG) hCur);
}

BOOL C3iMatrix::GetDataMap(void *pBuffer, int nSize)
{
	int cx = m_sizePixel.cx;
	int cy = m_sizePixel.cy;	
	int nColor = 0;
	switch (m_nLineMode)
	{
	case 1:		// RED
	case 2:		// GREEN
	case 4:		// BLUE
		nColor = 1;
		break;
	case 3:		// RED-GREEN
	case 6:		// GREEN-BLUE
		nColor = 2;
		break;
	case 7:		// RED-GREEN-BLUE
		nColor = 3;
		break;
	}

	if (nSize < nColor*cx*cy/8){
		return FALSE;
	}
		
	this->OnProcessBuffer((PBYTE)pBuffer,nSize,nColor, cx, cy);

	return TRUE;
}
