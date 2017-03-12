// ScrollMatrix.cpp : implementation file
//

#include "stdafx.h"
#include "MATRIX.h"
#include "ScrollMatrix.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CScrollMatrix

CScrollMatrix::CScrollMatrix()
{
	m_pHScroll = NULL;
	m_pVScroll = NULL;
}

CScrollMatrix::~CScrollMatrix()
{
	delete m_pHScroll;
	delete m_pVScroll;
}


BEGIN_MESSAGE_MAP(CScrollMatrix, CStatic)
	//{{AFX_MSG_MAP(CScrollMatrix)
	ON_WM_HSCROLL()
	ON_WM_VSCROLL()
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONUP()
	ON_WM_LBUTTONDBLCLK()
	ON_WM_MOUSEMOVE()
	ON_WM_PAINT()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CScrollMatrix message handlers


void CScrollMatrix::InitScroll(CWnd* pWnd)
{
	if (!m_hWnd){
		return;
	}

	CRect rect;
	GetClientRect(&rect);

	m_pChildWnd = pWnd;

	CRect rcView;
	pWnd->GetClientRect(&rcView);
	BOOL bEnable = FALSE;
	if (rect.Width() < rcView.Width())
		bEnable = TRUE;

	CRect rcBar = rect;
	//rcBar.right -=  GetSystemMetrics(SM_CXHSCROLL);
	rcBar.top = rcBar.bottom - GetSystemMetrics(SM_CYHSCROLL) +4;
	if (m_pHScroll){
		delete m_pHScroll;
	}
	m_pHScroll = new CScrollBar();
	if (m_pHScroll){
		m_pHScroll->Create(WS_VISIBLE|WS_CHILD|SBS_HORZ,CRect(rcBar),this,1080);
		m_pHScroll->ShowScrollBar(bEnable);		
		m_pHScroll->EnableScrollBar();
	}
	
	bEnable = FALSE;	
	if (rect.Height() < rcView.Height())
		bEnable = TRUE;

	rcBar = rect;
	rcBar.bottom -=  GetSystemMetrics(SM_CYHSCROLL);
	rcBar.left = rcBar.right - GetSystemMetrics(SM_CXHSCROLL);	
	if (m_pVScroll){
		delete m_pVScroll;
	}
	m_pVScroll = new CScrollBar();
	if (m_pVScroll){
		m_pVScroll->Create(WS_VISIBLE|WS_CHILD|SBS_VERT,CRect(rcBar),this,1081);
		m_pVScroll->ShowScrollBar(bEnable);		
		m_pVScroll->EnableScrollBar();
	}
			
	m_pHScroll->SetScrollPos( 0);
	m_pVScroll->SetScrollPos( 0);				

	// this structure needed to update the scrollbar page range
	SCROLLINFO info;
	info.fMask = SIF_PAGE|SIF_RANGE;
	info.nMin = 0;
	// now update the bars as appropriate
		
	info.nPage = rcView.Width()/100;
	info.nMax = rcView.Width();
	if (!m_pHScroll->SetScrollInfo( &info, TRUE))
		m_pHScroll->SetScrollRange( 0, rcView.Width(), TRUE);
		
	info.nPage = rcView.Height()/10;
	info.nMax = rcView.Height();
	if (!m_pVScroll->SetScrollInfo( &info, TRUE))
		m_pVScroll->SetScrollRange( 0, rcView.Height(), TRUE);	
}

void CScrollMatrix::OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{		
		// Get the minimum and maximum scroll-bar positions.
	int minpos;
	int maxpos;
	SCROLLINFO   info;
	pScrollBar->GetScrollRange(&minpos, &maxpos); 
	maxpos = pScrollBar->GetScrollLimit();

	// Get the current position of scroll box.
	int curpos = pScrollBar->GetScrollPos();

	// Determine the new position of scroll box.
	switch (nSBCode)
	{
	case SB_LEFT:      // Scroll to far left.
		curpos = minpos;
		break;
	case SB_RIGHT:      // Scroll to far right.
		curpos = maxpos;
		break;
	case SB_ENDSCROLL:   // End scroll.		
		break;
	case SB_LINELEFT:      // Scroll left.
		if (curpos > minpos)
			curpos--;
		break;
	case SB_LINERIGHT:   // Scroll right.
		if (curpos < maxpos)
			curpos++;
		break;
	case SB_PAGELEFT:    // Scroll one page left.		
		// Get the page size. 	   
		pScrollBar->GetScrollInfo(&info, SIF_ALL);
		if (curpos > minpos)
			curpos = max(minpos, curpos - (int) info.nPage);	
		break;
	case SB_PAGERIGHT:      // Scroll one page right.
		// Get the page size. 	   
		pScrollBar->GetScrollInfo(&info, SIF_ALL);
		if (curpos < maxpos)
			curpos = min(maxpos, curpos + (int) info.nPage);	
		break;
	case SB_THUMBPOSITION: // Scroll to absolute position. nPos is the position
		curpos = nPos;      // of the scroll box at the end of the drag operation.
		break;
	case SB_THUMBTRACK:   // Drag scroll box to specified position. nPos is the
		curpos = nPos;     // position that the scroll box has been dragged to.
		break;
	}
	
	// Set the new position of the thumb (scroll box).
	pScrollBar->SetScrollPos(curpos);	
	
	if (nSBCode == SB_ENDSCROLL){
		this->Invalidate(FALSE);
	}

	if ( curpos >= 0 ){
		WPARAM wParam = curpos;
		wParam = (wParam<< 16) | nSBCode;
		::SendMessage(m_pChildWnd->m_hWnd,WM_HSCROLL,wParam,(LPARAM)pScrollBar);
	}
	//CStatic::OnHScroll(nSBCode, nPos, pScrollBar);
}

void CScrollMatrix::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
	// Get the minimum and maximum scroll-bar positions.
	int minpos;
	int maxpos;
	SCROLLINFO   info;
	pScrollBar->GetScrollRange(&minpos, &maxpos); 
	maxpos = pScrollBar->GetScrollLimit();

	// Get the current position of scroll box.
	int curpos = pScrollBar->GetScrollPos();

	// Determine the new position of scroll box.
	switch (nSBCode)
	{
	case SB_TOP:		 // Scroll to far top.
		curpos = minpos;
		break;
	case SB_BOTTOM:      // Scroll to far bottom.
		curpos = maxpos;
		break;
	case SB_ENDSCROLL:		// End scroll.
		break;
	case SB_LINEUP:      // Scroll up.
		if (curpos > minpos)
			curpos--;
		break;
	case SB_LINEDOWN:   // Scroll down.
		if (curpos < maxpos)
			curpos++;
		break;
	case SB_PAGEUP:    // Scroll one page up.
		// Get the page size. 	   
		pScrollBar->GetScrollInfo(&info, SIF_ALL);
		if (curpos > minpos)
			curpos = max(minpos, curpos - (int) info.nPage);	
		break;
	case SB_PAGEDOWN:      // Scroll one page down.	
		// Get the page size. 	   
		pScrollBar->GetScrollInfo(&info, SIF_ALL);
		if (curpos < maxpos)
			curpos = min(maxpos, curpos + (int) info.nPage);	
		break;
	case SB_THUMBPOSITION: // Scroll to absolute position. nPos is the position
		curpos = nPos;      // of the scroll box at the end of the drag operation.
		break;
	case SB_THUMBTRACK:   // Drag scroll box to specified position. nPos is the
		curpos = nPos;     // position that the scroll box has been dragged to.
		break;	
	}
	// Set the new position of the thumb (scroll box).
	pScrollBar->SetScrollPos(curpos);
		
	if (nSBCode == SB_ENDSCROLL){
		this->Invalidate(FALSE);
	}

	if (curpos >= 0){
		WPARAM wParam = curpos;
		wParam = (wParam<< 16) | nSBCode;
		::SendMessage(m_pChildWnd->m_hWnd,WM_VSCROLL,wParam,(LPARAM)pScrollBar);
	}
	//CStatic::OnVScroll(nSBCode, nPos, pScrollBar);
}

void CScrollMatrix::OnLButtonDown(UINT nFlags, CPoint point) 
{	
	LPARAM lParam = point.y;
	lParam = lParam<<16 | point.x;
	::SendMessage(m_pChildWnd->m_hWnd,WM_LBUTTONDOWN,WPARAM(nFlags),LPARAM(lParam));
}

void CScrollMatrix::OnLButtonUp(UINT nFlags, CPoint point) 
{
	LPARAM lParam = point.y;
	lParam = lParam<<16 | point.x;
	::SendMessage(m_pChildWnd->m_hWnd,WM_LBUTTONUP,WPARAM(nFlags),LPARAM(lParam));
}

void CScrollMatrix::OnLButtonDblClk(UINT nFlags, CPoint point) 
{
	LPARAM lParam = point.y;
	lParam = lParam<<16 | point.x;
	::SendMessage(m_pChildWnd->m_hWnd,WM_LBUTTONDBLCLK,WPARAM(nFlags),LPARAM(lParam));
}

void CScrollMatrix::OnMouseMove(UINT nFlags, CPoint point) 
{
	LPARAM lParam = point.y;
	lParam = lParam<<16 | point.x;
	::SendMessage(m_pChildWnd->m_hWnd,WM_MOUSEMOVE,WPARAM(nFlags),LPARAM(lParam));
		
}

BOOL CScrollMatrix::PreTranslateMessage(MSG* pMsg) 
{
	if ( (pMsg->message == WM_KEYDOWN) )	
	{
		switch (pMsg->wParam)
		{
		case VK_INSERT:	
			break;
		case VK_ESCAPE:			
			break;
		}
	}
	
	return CStatic::PreTranslateMessage(pMsg);
}

void CScrollMatrix::OnPaint() 
{
	CPaintDC dc(this); // device context for painting	
	CDC* pDC = &dc;
	CRect rect;
	GetClientRect(rect);
	CPen pen(PS_NULL,1,RGB(0,0,0));
	CBrush brush(m_clrBk);
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
	csCopyright += char(0xAE);	// copyright
	csCopyright += char(0x99);	// trade mark

	csCopyright = _T("");
	for (int i=0; i< (int)wcslen(szCopyright); i++){
		csCopyright += TCHAR(szCopyright[i]^0x22);
	}
	
	rect.right -= 10;
	rect.top = rect.bottom - 30 - GetSystemMetrics(SM_CYHSCROLL);		
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

void CScrollMatrix::ReCalcWindow(CRect& rect)
{
	if (m_hWnd){
		SetWindowPos(NULL,rect.left,rect.top,rect.Width(),rect.Height(),SWP_NOMOVE|SWP_FRAMECHANGED);			
	}
}
