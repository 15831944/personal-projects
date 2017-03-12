// LEDEdit.cpp : implementation file
//

#include "stdafx.h"
#include "LEDEdit.h"
#include "DigiStatic.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CLEDEdit

CLEDEdit::CLEDEdit()
{
}

CLEDEdit::~CLEDEdit()
{
}


BEGIN_MESSAGE_MAP(CLEDEdit, CStatic)
	//{{AFX_MSG_MAP(CLEDEdit)
	ON_WM_CONTEXTMENU()
	ON_WM_PAINT()
	ON_WM_LBUTTONDBLCLK()
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONUP()
	ON_WM_MOUSEMOVE()
	ON_COMMAND(ID_POPUP_COPY, OnPopupCopy)
	ON_COMMAND(ID_POPUP_CUT, OnPopupCut)
	ON_COMMAND(ID_POPUP_REMOVE, OnPopupRemove)
	ON_COMMAND(ID_POPUP_PROPERTIES, OnPopupProperties)
	ON_COMMAND(ID_POPUP_LOCKPANELPOSITION, OnPopupLockpanelposition)
	ON_WM_KILLFOCUS()
	ON_WM_CREATE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLEDEdit message handlers

void CLEDEdit::GetText(CString &csText)
{
	((CDigiStatic*)m_pCtrl)->GetText(csText);
}

void CLEDEdit::SetText(LPCTSTR lpszText)
{
	((CDigiStatic*)m_pCtrl)->SetText(lpszText);
}

void CLEDEdit::SetBkColor(COLORREF clrBk)
{
	((CDigiStatic*)m_pCtrl)->SetBkColor(clrBk);
}

void CLEDEdit::SetColor(COLORREF clrOff, COLORREF clrOn)
{
	((CDigiStatic*)m_pCtrl)->SetColor(clrOff,clrOn);
}

void CLEDEdit::SetDigit(int nDigits)
{
	TCHAR* szEdit = new TCHAR[nDigits+3];					
	for (int i=0; i< nDigits; i++){
		szEdit[i] = '0';
	}
	szEdit[nDigits]='\0';	
	((CDigiStatic*)m_pCtrl)->SetText(szEdit);
	delete szEdit;

	CStaticEdit::SetDigit(nDigits);
}

void CLEDEdit::InitControl(HWND hWndMsg)
{	
	CRect rect =CRect();
	GetClientRect(rect);
	rect.DeflateRect(3,3,3,3);
	
	m_pCtrl = new CDigiStatic();
	m_pCtrl->Create(_T("LEDEdit"),WS_CHILD|WS_VISIBLE,rect,this,22180);
	m_pCtrl->ShowWindow(m_bShowNumID?SW_HIDE:SW_SHOW);
	m_pCtrl->UpdateWindow();	

	CStaticEdit::InitControl(hWndMsg);

	if (m_pDataEdit){
		m_pDataEdit->m_bEnableChars = FALSE;
	}
}

void CLEDEdit::ResizePanel()
{	
	int nBorder = 0;
	if (GetExStyle()&SS_EX_CLIENTEDGE)	nBorder += 2;		
 	if (GetExStyle()&SS_EX_STATICEDGE)	nBorder += 2;
 	if (GetExStyle()&SS_EX_MODALFRAME)	nBorder += 2;

	m_pCtrl->SetWindowPos(	NULL, -1, -1, _stParam.nWidth -6, _stParam.nHeight + nBorder -6,
 					SWP_NOMOVE | SWP_NOZORDER | SWP_NOREDRAW | SWP_NOACTIVATE);
	
	CStaticEdit::ResizePanel();
}

BOOL CLEDEdit::PreTranslateMessage(MSG* pMsg) 
{
	if ( (pMsg->message == WM_KEYDOWN) )	
	{
		switch (pMsg->wParam)
		{
		case VK_ESCAPE:			
			break;
		case VK_RETURN:			
			break;
		}
	}
	return CStaticEdit::PreTranslateMessage(pMsg);
}

void CLEDEdit::GetEditText(LPTSTR szEdit, int len)
{
	int strlen = this->m_pDataEdit->LineLength(0);	
	if (len > m_nDigits){
		len = m_nDigits;
	}
	for (int i=0; i< len; i++){
		szEdit[i] = ' ';
	}
	this->m_pDataEdit->GetLine(0,szEdit+(m_nDigits-strlen));
}

void CLEDEdit::OnPaint() 
{
// default
	//CStatic::OnPaint();

	// extra drawed
	CPaintDC dc(this);
	CRect rect = CRect();	
	GetClientRect(&rect);
	CDC* pDC = &dc;
	CFont* pFont = pDC->SelectObject(&m_font);
	CBrush brush(_stParam.clrBk);
	pDC->SetTextColor(_stParam.clrSeg);	
	pDC->SetBkColor(_stParam.clrBk);
	CBrush* brOld = pDC->SelectObject(&brush);		
	pDC->Rectangle(&rect);

	// draw extended edges
	this->GetClientRect(&rect);			

	if (m_bSelected){
		CBrush br(RGB(250,250,150));
		CBrush* brOld = pDC->SelectObject(&br);
		pDC->Rectangle(&rect);
		rect.DeflateRect(2,2,2,2);
		pDC->SelectObject(&brush);		
		pDC->Rectangle(&rect);
		pDC->SelectObject(brOld);
	}
	else{
		if (_stParam.dwExtendedStyle & SS_EX_STATICEDGE){
			pDC->DrawEdge(&rect,BDR_SUNKENOUTER,BF_RECT);		
		}
		else if (_stParam.dwExtendedStyle & SS_EX_CLIENTEDGE){
			pDC->DrawEdge(&rect,EDGE_ETCHED,BF_RECT);
		}
		else if (_stParam.dwExtendedStyle & SS_EX_MODALFRAME){
			pDC->DrawEdge(&rect,EDGE_RAISED,BF_RECT);		
		}
	}	
	
	if (m_bShowNumID){
		this->DrawNumID(pDC);
	}

	pDC->SelectObject(brOld);
	pDC->SelectObject(pFont);

}

BOOL CLEDEdit::DestroyWindow() 
{
	if (m_pCtrl){
		m_pCtrl->DestroyWindow();
		delete m_pCtrl;
	}	
	return CStatic::DestroyWindow();
}

void CLEDEdit::OnLButtonDblClk(UINT nFlags, CPoint point) 
{
	CStaticEdit::OnLButtonDblClk(nFlags, point);	
}

void CLEDEdit::OnLButtonDown(UINT nFlags, CPoint point) 
{
	CStaticEdit::OnLButtonDown(nFlags, point);
}

void CLEDEdit::OnLButtonUp(UINT nFlags, CPoint point) 
{
	CStaticEdit::OnLButtonUp(nFlags, point);
}

void CLEDEdit::OnMouseMove(UINT nFlags, CPoint point) 
{	
	CStaticEdit::OnMouseMove(nFlags, point);
}

void CLEDEdit::OnContextMenu(CWnd* pWnd, CPoint point)
{
	CStaticEdit::OnContextMenu(pWnd, point);
}

void CLEDEdit::OnPopupCopy() 
{
	CStaticEdit::OnPopupCopy();
}

void CLEDEdit::OnPopupCut() 
{
	CStaticEdit::OnPopupCut();
}

void CLEDEdit::OnPopupRemove() 
{
	CStaticEdit::OnPopupRemove();
}

void CLEDEdit::OnPopupProperties() 
{
	CStaticEdit::OnPopupProperties();
}

void CLEDEdit::OnPopupLockpanelposition() 
{
	CStaticEdit::OnPopupLockpanelposition();
}

void CLEDEdit::OnKillFocus(CWnd* pNewWnd) 
{
	CStaticEdit::OnKillFocus(pNewWnd);	
}

int CLEDEdit::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CStaticEdit::OnCreate(lpCreateStruct) == -1)
		return -1;
		
	return 0;
}

void CLEDEdit::ShowNumID(BOOL bShow)
{
	m_pCtrl->ShowWindow(bShow?SW_HIDE:SW_SHOW);
	CStaticEdit::ShowNumID(bShow);	
}
