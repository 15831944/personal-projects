// 3iMatrixEdit.cpp : implementation file
//

#include "stdafx.h"
#include "FontFire.h"
#include "3iMatrixEdit.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// C3iMatrixEdit

C3iMatrixEdit::C3iMatrixEdit()
{
	m_nTool = -1;
	m_nBrushSize = 1;
	m_pCopyBuffer = NULL;
	m_rcMarquee = CRect(0,0,0,0);
	m_rcOrgObject = CRect(0,0,0,0);
	m_bMarqueeDone = FALSE;
}

C3iMatrixEdit::~C3iMatrixEdit()
{
	if (m_pCopyBuffer){
		int cx = m_rcOrgObject.Width()/m_nZoomScale;
		for (int i=0; i< cx; i++){
			delete[] m_pCopyBuffer[i];
		}
		delete[] m_pCopyBuffer;
	}
}


BEGIN_MESSAGE_MAP(C3iMatrixEdit, C3iMatrix)
	//{{AFX_MSG_MAP(C3iMatrixEdit)
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONUP()
	ON_WM_MOUSEMOVE()
	ON_WM_PAINT()
	ON_WM_HSCROLL()
	ON_WM_VSCROLL()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// C3iMatrixEdit message handlers

#include <Winuser.h>
void C3iMatrixEdit::SelectTool(UINT nTool)
{
	m_nTool = nTool;
	// initial tool object
	switch (m_nTool)
	{
	case SELECT_PEN:	
		this->ReleaseObject();
		break;
	case SELECT_BRUSH:
		this->ReleaseObject();					
		break;
	case SELECT_TEXT:
		this->ReleaseObject();
		break;
	case SELECT_MOVE:			
		break;
	case SELECT_MARQUEE:		
		break;
	}
}

void C3iMatrixEdit::OnLButtonDown(UINT nFlags, CPoint point) 
{
	CRect rect;
	GetClientRect(&rect);
	if (rect.PtInRect(point)){
		SetCapture();
	}	

	switch (m_nTool)
	{
	case SELECT_PEN:				
		this->OnSelectPen(nFlags,point);
		break;
	case SELECT_BRUSH:				
		this->OnSelectBrush(nFlags,point);
		break;
	case SELECT_TEXT:				
		this->OnSelectText(nFlags,point);
		break;
	case SELECT_MOVE:	
		if (!m_bMarqueeDone){
			this->OnSelectMarquee(nFlags,point);				
		}
		else{
			this->OnSelectObject(nFlags,point);
		}
		break;
	case SELECT_MARQUEE:
		this->OnSelectMarquee(nFlags,point);						
		break;
	case SELECT_ZOOM:
		this->OnSelectZoom(nFlags,point);
		break;
	}	
}

void C3iMatrixEdit::OnLButtonUp(UINT nFlags, CPoint point) 
{		
	if (GetCapture()==this){
		ReleaseCapture();		
	}

	switch (m_nTool)
	{
	case SELECT_PEN:		
		break;
	case SELECT_BRUSH:
		this->OnReleaseBrush(nFlags,point);
		break;
	case SELECT_TEXT:
		this->OnReleaseText(nFlags,point);
		break;
	case SELECT_MOVE:		
		if (!m_bMarqueeDone){			
			this->OnReleaseMarquee(nFlags,point);		
		}
		else{
			this->OnReleaseObject(nFlags,point);			
		}
		break;
	case SELECT_MARQUEE:					
		this->OnReleaseMarquee(nFlags,point);								
		break;
	}
}

void C3iMatrixEdit::OnMouseMove(UINT nFlags, CPoint point) 
{			
	HCURSOR hCur = NULL;

	switch (m_nTool)
	{
	case SELECT_MARQUEE:
	{
		// override this function to reflect
		this->OnMovingMarquee(nFlags,point);
		// change the cursor display 
		CPoint ptMarquee = CPoint(point.x + abs(m_ptPosition.x),point.y + abs(m_ptPosition.y));		
		if (m_rcMarquee.PtInRect(ptMarquee) && m_bMarqueeDone){
			hCur = ::LoadCursor(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDC_SELECT_MOVE));
		}
		else{
			hCur = ::LoadCursor(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDC_SELECT_MARQUEE));
		}
		break;
	}
	case SELECT_MOVE:
	{
		// override this function to reflect
		this->OnMovingMarquee(nFlags,point);
		this->OnMovingObject(nFlags,point);
		
		// change the cursor display 
		CPoint ptMarquee = CPoint(point.x + abs(m_ptPosition.x),point.y + abs(m_ptPosition.y));		
		if (m_rcMarquee.PtInRect(ptMarquee)){
			hCur = ::LoadCursor(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDC_SELECT_MOVE));
		}
		else{
			hCur = ::LoadCursor(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDC_SELECT_ARROW));
		}
		break;
	}
	case SELECT_PEN:		
		// override this function to reflect		
		hCur = ::LoadCursor(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDC_SELECT_POINT));
		break;
	case SELECT_BRUSH:
		this->OnMovingBrush(nFlags,point);
		// override this function to reflect		
		hCur = ::LoadCursor(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDC_SELECT_BRUSH));
		break;
	case SELECT_TEXT:
		this->OnMovingText(nFlags,point);
		hCur = ::LoadCursor(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDC_SELECT_TEXT));
		break;
	case SELECT_ZOOM:
		this->OnMovingZoom(nFlags,point);
		if (nFlags & MK_CONTROL){
			hCur = ::LoadCursor(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDC_SELECT_ZOOM_OUT));
		}
		else{
			hCur = ::LoadCursor(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDC_SELECT_ZOOM_IN));
		}
		break;
	default:
		hCur = ::LoadCursor(AfxGetApp()->m_hInstance, MAKEINTRESOURCE(IDC_SELECT_ARROW));
		break;
	}
	
	
	SetClassLong(this->m_hWnd, GCL_HCURSOR,	(LONG) hCur);
}

void C3iMatrixEdit::DrawMarqueeRect(BOOL bInit)
{
	CDC* pDC = GetDC();
	CRect rcWnd = CRect();	
	this->GetWindowRect(&rcWnd);
	this->GetParent()->ScreenToClient(&rcWnd);
	if (m_rcMarquee.Width() < rcWnd.Width() && m_rcMarquee.Height() < rcWnd.Height()){			
		static CRect rcWndLast = m_rcMarquee;	
		if (bInit){
			rcWndLast = CRect(0,0,0,0);
		}
		pDC->DrawDragRect(&m_rcMarquee,CSize(1,1),&rcWndLast,CSize(1,1));
		rcWndLast = m_rcMarquee;
	}
	ReleaseDC(pDC);
}


void C3iMatrixEdit::OnPaint() 
{			
	C3iMatrix::OnPaint();
	
	if (m_bMarqueeDone){		
		this->DrawMarqueeRect(TRUE);
	}
}

void C3iMatrixEdit::ReleaseObject()
{				
	int cx = m_rcMarquee.Width()/m_nZoomScale;
	int cy = m_rcMarquee.Height()/m_nZoomScale;

	this->ReleaseCopyBuffer(cx,cy);

	m_bMarqueeDone = FALSE;	
	m_rcMarquee.InflateRect(1,1,1,1);
	InvalidateRect(m_rcMarquee,FALSE);
	m_rcOrgObject = CRect(0,0,0,0);
	m_rcMarquee = m_rcOrgObject;			
}

void C3iMatrixEdit::OnMovingMarquee(UINT nFlags, CPoint point)
{
	int x = (point.x + abs(m_ptPosition.x))/m_nZoomScale;
	int y = (point.y + abs(m_ptPosition.y))/m_nZoomScale;
	
	if (GetCapture()==this){
		if (nFlags & MK_LBUTTON) {
			if (!m_bMarqueeDone){
				int x1 = x*m_nZoomScale - abs(m_ptPosition.x);
				int y1 = y*m_nZoomScale - abs(m_ptPosition.y);
				if (m_rcMarquee.left < x1){
					m_rcMarquee.right = x1;
				}
				else{
					m_rcMarquee.left = x1;
				}
				if (m_rcMarquee.top < y1){
					m_rcMarquee.bottom = y1;
				}
				else{
					m_rcMarquee.top = y1;
				}
				this->DrawMarqueeRect();
			}
			else{
				int cx = (point.x - m_ptMoving.x);
				int cy = (point.y - m_ptMoving.y);
				m_ptMoving.x = point.x;
				m_ptMoving.y = point.y;
				m_rcMarquee.OffsetRect(cx,cy);					
				this->DrawMarqueeRect();					
			}
		}			
	}
}

void C3iMatrixEdit::OnMovingObject(UINT nFlags, CPoint point)
{	
	
}

void C3iMatrixEdit::OnSelectPen(UINT nFlags, CPoint point)
{
	int x = (point.x + abs(m_ptPosition.x))/m_nZoomScale;
	int y = (point.y + abs(m_ptPosition.y))/m_nZoomScale;

	if (!OnSetPixel(nFlags,x,y)){
		SetPixel(x,y,m_clrPen);	
	}
}

void C3iMatrixEdit::OnSelectMarquee(UINT nFlags, CPoint point)
{
	int x = (point.x + abs(m_ptPosition.x))/m_nZoomScale;
	int y = (point.y + abs(m_ptPosition.y))/m_nZoomScale;
	
	if (m_bMarqueeDone == FALSE){									
		m_rcMarquee = CRect(point.x + abs(m_ptPosition.x),
							point.y + abs(m_ptPosition.y),
							point.x + abs(m_ptPosition.x),
							point.y + abs(m_ptPosition.x));											
		this->DrawMarqueeRect(TRUE);
	}	
	else{
	// start moving marquee			
		m_ptMoving = CPoint(point.x + abs(m_ptPosition.x),
							point.y + abs(m_ptPosition.y));
	}
	
}

void C3iMatrixEdit::OnSelectObject(UINT nFlags, CPoint point)
{		
	if (m_bMarqueeDone){
		m_rcOrgObject = m_rcMarquee;	// save the marquee rectangle
		this->CopyObject();				// copy the selected marquee 
		// start moving marquee, important code!!!			
		m_ptMoving = CPoint(point.x + abs(m_ptPosition.x),
							point.y + abs(m_ptPosition.y));		
	}
}

void C3iMatrixEdit::OnReleaseMarquee(UINT nFlags, CPoint point)
{
	int x = (point.x + abs(m_ptPosition.x))/m_nZoomScale;
	int y = (point.y + abs(m_ptPosition.y))/m_nZoomScale;
	
	if (m_bMarqueeDone == FALSE){		
		int x1 = x*m_nZoomScale - abs(m_ptPosition.x);
		int y1 = y*m_nZoomScale - abs(m_ptPosition.y);
		if (m_rcMarquee.left < x1){
			m_rcMarquee.right = x1;
		}
		else{
			m_rcMarquee.left = x1;
		}
		if (m_rcMarquee.top < y1){
			m_rcMarquee.bottom = y1;
		}
		else{
			m_rcMarquee.top = y1;
		}
		m_bMarqueeDone = TRUE;
		this->DrawMarqueeRect(FALSE);		
	}	
	else{
		// snap to grid and redraw the marquee regtangle
		
		int x1 = (m_rcMarquee.left + abs(m_ptPosition.x))/m_nZoomScale;
		int y1 = (m_rcMarquee.top + abs(m_ptPosition.y))/m_nZoomScale;
		int x2 = (m_rcMarquee.right + abs(m_ptPosition.x))/m_nZoomScale;
		int y2 = (m_rcMarquee.bottom + abs(m_ptPosition.y))/m_nZoomScale;

		m_rcMarquee = CRect(
						x1*m_nZoomScale - abs(m_ptPosition.x),
						y1*m_nZoomScale - abs(m_ptPosition.y),
						x2*m_nZoomScale - abs(m_ptPosition.x),
						y2*m_nZoomScale - abs(m_ptPosition.y)
						);		

		this->DrawMarqueeRect(FALSE);		
	}	

	m_rcOrgObject = m_rcMarquee;	// save for selected marquee		
}

void C3iMatrixEdit::OnReleaseObject(UINT nFlags, CPoint point)
{
	if (m_bMarqueeDone){				
		// draging object, moving data from org
		// current rectangle is marquee rect		
		if (m_rcMarquee != m_rcOrgObject){
			int x0 = (abs(m_rcOrgObject.left))/m_nZoomScale;
			int y0 = (abs(m_rcOrgObject.top))/m_nZoomScale;
								
			int cx = m_rcOrgObject.Width()/m_nZoomScale;
			int cy = m_rcOrgObject.Height()/m_nZoomScale;

			this->EraseObject(x0,y0,cx,cy);
			this->PasteObject();		
		}		
		m_rcOrgObject = m_rcMarquee;
	}				
	
}

void C3iMatrixEdit::OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{	
	if (nSBCode==SB_ENDSCROLL){
		C3iMatrix::OnHScroll(nSBCode, nPos, pScrollBar);
		this->DrawMarqueeRect(TRUE);	
	}
}

void C3iMatrixEdit::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{	
	if (nSBCode==SB_ENDSCROLL){
		C3iMatrix::OnVScroll(nSBCode, nPos, pScrollBar);
		this->DrawMarqueeRect(TRUE);		
	}
}

void C3iMatrixEdit::EraseObject()
{
	int x0 = (abs(m_rcOrgObject.left))/m_nZoomScale;
	int y0 = (abs(m_rcOrgObject.top))/m_nZoomScale;
		
	int x1 = (abs(m_rcMarquee.left))/m_nZoomScale;
	int y1 = (abs(m_rcMarquee.top))/m_nZoomScale;
		
	int cx = m_rcOrgObject.Width()/m_nZoomScale;
	int cy = m_rcOrgObject.Height()/m_nZoomScale;

	this->EraseObject(x0,y0,cx,cy);

	m_bMarqueeDone = FALSE;	
	m_rcMarquee.InflateRect(1,1,1,1);
	InvalidateRect(m_rcMarquee,FALSE);
	m_rcOrgObject = CRect(0,0,0,0);
	m_rcMarquee = m_rcOrgObject;	

}

void C3iMatrixEdit::EraseObject(int x0, int y0, int cx, int cy)
{
	if (!m_pCurLineList){
		return;
	}

	for (int y =0; y< cy; y++){		
		for (int x =0; x< cx; x++){
			CLineColor* pLineColor = NULL;			
			CPoint rPixel = OnChangePosition(x + x0,y + y0);
			if (m_pCurLineList->GetSize() > (rPixel.y)){
				pLineColor = m_pCurLineList->GetAt(rPixel.y);		
			}
			if (pLineColor){								
				UINT nFlags = MK_CONTROL;				
				if (!OnSetPixel(nFlags,x+x0,y+y0)){					
				}
				pLineColor->SetPixel(rPixel.x,RGB(0,0,0));
				this->DrawPixel(RGB(0,0,0),x + x0,y + y0,TRUE);				
			}
		}
	}

}

void C3iMatrixEdit::CopyObject(int x0, int y0, int cx, int cy)
{	
	if (!m_pCurLineList){
		return;
	}

	if (m_bMarqueeDone && !m_pCopyBuffer){			
		// allocate memory for copy buffer
		this->InitCopyBuffer(cx,cy);
		this->BeginWaitCursor();
		// copy each bit into temporary buffer
		for (int y =0; y< cy; y++){			
			for (int x =0; x< cx; x++){
				CLineColor* pLine0 = NULL;	
				CPoint rP0 = OnChangePosition(x + x0,y + y0);
				if (m_pCurLineList->GetSize() > (rP0.y)){			
					pLine0 = m_pCurLineList->GetAt(rP0.y);
				}
				if (pLine0 && m_pCopyBuffer){					
					m_pCopyBuffer[x][y] = pLine0->GetPixel(rP0.x);					
				}
			}			
		}
		this->EndWaitCursor();
	}	
}

void C3iMatrixEdit::PasteObject(int x1, int y1, int cx, int cy)
{
	if (!m_pCurLineList){
		return;
	}

	this->BeginWaitCursor();
	for (int y =0; y< cy; y++){				
		for (int x =0; x< cx; x++){			
			CLineColor* pLine1 = NULL;
			CPoint rP1 = OnChangePosition(x + x1,y + y1);
			if (m_pCurLineList->GetSize() > (rP1.y)){			
				pLine1 = m_pCurLineList->GetAt(rP1.y);
			}
			if (pLine1 && m_pCopyBuffer){								
				COLORREF clr = m_pCopyBuffer[x][y];
				UINT nFlags = MK_CONTROL;
				if (clr==RGB(0,0,0))
					nFlags = MK_CONTROL;	// off pixel
				else
					nFlags &= (~MK_CONTROL);	// on pixel
				if (!OnSetPixel(nFlags,x+x1,y+y1)){					
				}
				pLine1->SetPixel(rP1.x,clr);	
				this->DrawPixel(clr,x + x1,y + y1,TRUE);					
			}
		}			
		
	}
	this->EndWaitCursor();
}

void C3iMatrixEdit::InitCopyBuffer(int cx, int cy)
{
	// allocate buffer memory to copy
	if (!m_pCopyBuffer){
		m_pCopyBuffer = new COLORREF*[cx];
		if (m_pCopyBuffer){
			for (int i=0; i< cx; i++){
				m_pCopyBuffer[i] = new COLORREF[cy];
			}
		}
	}
}

void C3iMatrixEdit::ReleaseCopyBuffer(int cx, int cy)
{
	if (m_pCopyBuffer){
		for (int i =0; i< cx; i++){
			delete[] m_pCopyBuffer[i];
		}
		delete[] m_pCopyBuffer;
		m_pCopyBuffer = NULL;
	}
}

void C3iMatrixEdit::CopyObject()
{
	int x0 = (abs(m_rcOrgObject.left))/m_nZoomScale;
	int y0 = (abs(m_rcOrgObject.top))/m_nZoomScale;
		
	int cx = m_rcOrgObject.Width()/m_nZoomScale;
	int cy = m_rcOrgObject.Height()/m_nZoomScale;

	this->CopyObject(x0,y0,cx,cy);	
}

void C3iMatrixEdit::PasteObject()
{
	int x1 = (abs(m_rcMarquee.left))/m_nZoomScale;
	int y1 = (abs(m_rcMarquee.top))/m_nZoomScale;
		
	int cx = m_rcMarquee.Width()/m_nZoomScale;
	int cy = m_rcMarquee.Height()/m_nZoomScale;
	
	this->PasteObject(x1,y1,cx,cy);	
	CRect rcRedraw = m_rcMarquee;
	rcRedraw.InflateRect(1,1,1,1);
	this->InvalidateRect(rcRedraw);
	this->DrawMarqueeRect(TRUE);
}

void C3iMatrixEdit::OnSelectBrush(UINT nFlags, CPoint point)
{	
	int x0 = (point.x + abs(m_ptPosition.x))/m_nZoomScale;
	int y0 = (point.y + abs(m_ptPosition.y))/m_nZoomScale;

	this->SetBrush(x0,y0,m_nBrushSize,m_clrBrush);	
}

void C3iMatrixEdit::OnSelectText(UINT nFlags, CPoint point)
{

}

void C3iMatrixEdit::OnReleaseBrush(UINT nFlags, CPoint point)
{

}

void C3iMatrixEdit::OnReleaseText(UINT nFlags, CPoint point)
{

}

void C3iMatrixEdit::OnMovingBrush(UINT nFlags, CPoint point)
{
#if 0
	int x = (point.x + abs(m_ptPosition.x))/m_nZoomScale;
	int y = (point.y + abs(m_ptPosition.y))/m_nZoomScale;
		
	CRect rect;
	GetClientRect(&rect);
	
	if (GetCapture()==this){
		ReleaseCapture();
	}
	if (rect.PtInRect(point)){
		m_rcMarquee.left = x*m_nZoomScale - abs(m_ptPosition.x);
		m_rcMarquee.top  = y*m_nZoomScale - abs(m_ptPosition.y);
		m_rcMarquee.right = m_rcMarquee.left + m_nBrushSize*m_nZoomScale;							
		m_rcMarquee.bottom = m_rcMarquee.top + m_nBrushSize*m_nZoomScale;							
		
		this->DrawMarqueeRect(FALSE);		
	}	
#endif
}

void C3iMatrixEdit::OnMovingText(UINT nFlags, CPoint point)
{

}

void C3iMatrixEdit::SetBrushSize(UINT nBrushSize)
{ 
	m_nBrushSize = nBrushSize;
}

void C3iMatrixEdit::SetBrush(int x0, int y0, int nSize, COLORREF clr)
{
	if (!m_pCurLineList){
		return;
	}

	this->BeginWaitCursor();

	for (int y =0; y< int(nSize); y++){		
		for (int x =0; x< int(nSize); x++){
			CPoint rP0 = OnChangePosition(x + x0,y + y0);
			CLineColor* pLine0 = NULL;		
			if (m_pCurLineList->GetSize() > (rP0.y)){			
				pLine0 = m_pCurLineList->GetAt(rP0.y);
			}		
			if (AfxIsMemoryBlock(pLine0,sizeof(CLineColor))){		
				UINT nFlags = MK_CONTROL;
				if (clr==RGB(0,0,0))
					nFlags = MK_CONTROL;	// off pixel
				else
					nFlags &= (~MK_CONTROL);	// on pixel
				if (!OnSetPixel(nFlags,x+x0,y+y0)){					
				}
				pLine0->SetPixel(rP0.x,clr);					
				this->DrawPixel(clr,x + x0,y + y0,TRUE);					
			}
		}			
		
	}

	this->EndWaitCursor();	
}

void C3iMatrixEdit::FillRect(int x0, int y0, int cx, int cy, COLORREF clr)
{	
	if (!m_pCurLineList){
		return;
	}

	this->BeginWaitCursor();

	for (int y =0; y< int(cy); y++){		
		for (int x =0; x< int(cx); x++){
			CPoint rP0 = OnChangePosition(x + x0,y + y0);
			CLineColor* pLine0 = NULL;		
			if (m_pCurLineList->GetSize() > (rP0.y)){			
				pLine0 = m_pCurLineList->GetAt(rP0.y);
			}		
			if (AfxIsMemoryBlock(pLine0,sizeof(CLineColor))){												
				pLine0->SetPixel(rP0.x,clr);					
				this->DrawPixel(clr,x + x0,y + y0,TRUE);					
			}
		}			
		
	}

	this->EndWaitCursor();	
}

void C3iMatrixEdit::FillRect()
{
	int x0 = (m_rcMarquee.left + abs(m_ptPosition.x))/m_nZoomScale;
	int y0 = (m_rcMarquee.top + abs(m_ptPosition.y))/m_nZoomScale;

	int cx = (m_rcMarquee.Width())/m_nZoomScale;
	int cy = (m_rcMarquee.Height())/m_nZoomScale;	

	this->FillRect(x0,y0,cx,cy,m_clrBrush);

	m_bMarqueeDone = FALSE;	
	m_rcMarquee.InflateRect(1,1,1,1);
	InvalidateRect(m_rcMarquee,FALSE);
	m_rcOrgObject = CRect(0,0,0,0);
	m_rcMarquee = m_rcOrgObject;	
}

#include "ScrollMatrix.h"
void C3iMatrixEdit::OnSelectZoom(UINT nFlags, CPoint point)
{
	if (nFlags&MK_CONTROL){
		if(--m_nZoomScale <=0){
			m_nZoomScale=1;
		}
	}
	else{
		if(++m_nZoomScale >=10){
			m_nZoomScale--;
		}
	}
	C3iMatrix::ReCalcMatrixClient();
	CScrollMatrix* pParent = (CScrollMatrix*)GetParent();
	pParent->InitScroll(this);
	this->Invalidate(FALSE);
}

void C3iMatrixEdit::Zoom(int nLevel)
{
	m_nZoomScale += nLevel;
	C3iMatrix::ReCalcMatrixClient();	
	CScrollMatrix* pParent = (CScrollMatrix*)GetParent();
	pParent->InitScroll(this);
	this->Invalidate(FALSE);
}

void C3iMatrixEdit::OnMovingZoom(UINT nFlags, CPoint point)
{

}
