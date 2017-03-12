// MatrixEdit.cpp : implementation file
//

#include "stdafx.h"
#include "MatrixEdit.h"
#include "MatrixStatic.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMatrixEdit

CMatrixEdit::CMatrixEdit()
{
}

CMatrixEdit::~CMatrixEdit()
{
}


BEGIN_MESSAGE_MAP(CMatrixEdit, CStatic)
	//{{AFX_MSG_MAP(CMatrixEdit)
	ON_WM_PAINT()
	ON_WM_LBUTTONDBLCLK()
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONUP()
	ON_WM_MOUSEMOVE()
	ON_WM_CONTEXTMENU()
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
// CMatrixEdit message handlers

void CMatrixEdit::GetText(CString &csText)
{
	TCHAR szText[MAX_PATH];
	((CMatrixStatic*)m_pCtrl)->GetText(szText,sizeof(szText));
	csText = szText;

}

void CMatrixEdit::SetText(LPCTSTR lpszText)
{
	((CMatrixStatic*)m_pCtrl)->SetText(lpszText);
}

void CMatrixEdit::SetBkColor(COLORREF clrBk)
{
	((CMatrixStatic*)m_pCtrl)->SetBkColor(clrBk);
}

void CMatrixEdit::SetColor(COLORREF clrOff, COLORREF clrOn)
{
	((CMatrixStatic*)m_pCtrl)->SetColor(clrOff,clrOn);
}

void CMatrixEdit::SetDigit(int nDigits)
{
	TCHAR* szEdit = new TCHAR[nDigits+3];					
	for (int i=0; i< nDigits; i++){
		szEdit[i] = '0';
	}
	szEdit[nDigits]='\0';
	
	((CMatrixStatic*)m_pCtrl)->SetXCharsPerLine(nDigits);			
	((CMatrixStatic*)m_pCtrl)->AdjustClientXToSize(nDigits);	

	((CMatrixStatic*)m_pCtrl)->SetText(szEdit);
	delete szEdit;
			
	CStaticEdit::SetDigit(nDigits);
}

void CMatrixEdit::InitControl(HWND hWndMsg)
{	
	CRect rect =CRect();
	GetClientRect(rect);
	rect.DeflateRect(3,3,3,3);

	m_pCtrl = new CMatrixStatic(); 
	m_pCtrl->Create(_T("MATRIXEdit"),WS_CHILD|WS_VISIBLE,rect,this,22181);						
	((CMatrixStatic*)m_pCtrl)->SetNumberOfLines(1);
	((CMatrixStatic*)m_pCtrl)->SetXCharsPerLine(m_nDigits);
	((CMatrixStatic*)m_pCtrl)->SetSize(CMatrixStatic::SMALL);		
	((CMatrixStatic*)m_pCtrl)->AdjustClientXToSize(m_nDigits);
	((CMatrixStatic*)m_pCtrl)->AdjustClientYToSize(1);				
	((CMatrixStatic*)m_pCtrl)->SetText(_T("ABCDE"));
	m_pCtrl->ShowWindow(m_bShowNumID?SW_HIDE:SW_SHOW);
	m_pCtrl->UpdateWindow();

	CStaticEdit::InitControl(hWndMsg);

	if (m_pDataEdit){
		m_pDataEdit->m_bEnableChars = TRUE;
	}
}

void CMatrixEdit::ResizePanel()	
{
	int nBorder = 0;
	if (GetExStyle()&SS_EX_CLIENTEDGE)	nBorder += 2;		
 	if (GetExStyle()&SS_EX_STATICEDGE)	nBorder += 2;
 	if (GetExStyle()&SS_EX_MODALFRAME)	nBorder += 2;

	m_pCtrl->SetWindowPos(	NULL, -1, -1, _stParam.nWidth -6, _stParam.nHeight + nBorder -6,
 					SWP_NOMOVE | SWP_NOZORDER | SWP_NOREDRAW | SWP_NOACTIVATE);

	CStaticEdit::ResizePanel();
}

BOOL CMatrixEdit::PreTranslateMessage(MSG* pMsg) 
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

void CMatrixEdit::GetEditText(LPTSTR szEdit, int len)
{
	for (int i=0; i< len; i++){
		szEdit[i] = ' ';
	}	
	TCHAR szTemp[MAX_PATH];
	int strlen = m_pDataEdit->GetLine(0,szTemp,len);		
	if (szTemp[strlen-2]==0x0D){
		szTemp[strlen-2] ='\0';
		strlen -= 2;
	}
	if (szTemp[strlen-1]==0x0D){
		szTemp[strlen-1] ='\0';
		strlen -= 1;
	}	
	strcpy_s(szEdit+(m_nDigits-strlen),len-(m_nDigits-strlen),szTemp);
}

void CMatrixEdit::OnPaint() 
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

BOOL CMatrixEdit::DestroyWindow() 
{
	if (m_pCtrl){
		m_pCtrl->DestroyWindow();
		delete m_pCtrl;
	}	
	return CStatic::DestroyWindow();
}

void CMatrixEdit::OnLButtonDblClk(UINT nFlags, CPoint point) 
{
	CStaticEdit::OnLButtonDblClk(nFlags, point);
}

void CMatrixEdit::OnLButtonDown(UINT nFlags, CPoint point) 
{
	CStaticEdit::OnLButtonDown(nFlags, point);
}

void CMatrixEdit::OnLButtonUp(UINT nFlags, CPoint point) 
{
	CStaticEdit::OnLButtonUp(nFlags, point);
}

void CMatrixEdit::OnMouseMove(UINT nFlags, CPoint point) 
{
	CStaticEdit::OnMouseMove(nFlags, point);
}

void CMatrixEdit::OnContextMenu(CWnd* pWnd, CPoint point) 
{
	CStaticEdit::OnContextMenu(pWnd,point);	
}

void CMatrixEdit::OnPopupCopy() 
{
	CStaticEdit::OnPopupCopy();
}

void CMatrixEdit::OnPopupCut() 
{
	CStaticEdit::OnPopupCut();
}

void CMatrixEdit::OnPopupRemove() 
{
	CStaticEdit::OnPopupRemove();
}

void CMatrixEdit::OnPopupProperties() 
{
	CStaticEdit::OnPopupProperties();
}

void CMatrixEdit::OnPopupLockpanelposition() 
{
	CStaticEdit::OnPopupLockpanelposition();
}

void CMatrixEdit::OnKillFocus(CWnd* pNewWnd) 
{
	CStaticEdit::OnKillFocus(pNewWnd);	
}

int CMatrixEdit::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CStaticEdit::OnCreate(lpCreateStruct) == -1)
		return -1;	
	return 0;
}

void CMatrixEdit::ShowNumID(BOOL bShow)
{
	m_pCtrl->ShowWindow(bShow?SW_HIDE:SW_SHOW);
	CStaticEdit::ShowNumID(bShow);
}
