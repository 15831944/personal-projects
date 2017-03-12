// StaticEdit.cpp : implementation file
//

#include "stdafx.h"
#include "resource.h"
#include "StaticEdit.h"
#include "MatrixStatic.h"
#include "DigiStatic.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CStaticEdit

CStaticEdit::CStaticEdit()
{	
	m_pDataEdit = NULL;
	m_pPropFrame = NULL;
#ifdef __DESIGN_MODE
	m_bLockPosition = FALSE;
#else
	m_bLockPosition = TRUE;
#endif
	m_bSelected = FALSE;
	m_pCtrl = NULL;
	m_nDigits = 4;
	m_nNumID = 0;
	m_bShowNumID = FALSE;
	m_csFontName = _T(".VnTime");

	_stParam.nLeftMargin = 5;
	_stParam.nTopMargin = 5;
	_stParam.nHeight = 20;
	_stParam.nWidth = 80;	
}

CStaticEdit::~CStaticEdit()
{	
	if (m_pDataEdit){	
		delete m_pDataEdit;
	}	
}

/////////////////////////////////////////////////////////////////////////////
// CParamsStruct

CParamsStruct::CParamsStruct()
{
	nDigits = 4;
	bEnableEdit = TRUE;
	dwExtendedStyle =0;
	clrBk = RGB(0,0,0);
	clrSeg = RGB(255,0,0);
	clrSegOff = RGB(64,0,0);
}

CParamsStruct::~CParamsStruct()
{
}


const CParamsStruct& CParamsStruct::operator =(const CParamsStruct &param)
{
	this->bEnableEdit = param.bEnableEdit;
	this->clrBk = param.clrBk;
	this->clrSeg = param.clrSeg;
	this->clrSegOff = param.clrSegOff;
	this->csFontName = param.csFontName;
	this->dwExtendedStyle = param.dwExtendedStyle;
	this->nDigits = param.nDigits;
	this->nHeight = param.nHeight;
	this->nWidth = param.nWidth;
	this->nLeft = param.nLeft;
	this->nTop = param.nTop;
	this->nLeftMargin = param.nLeftMargin;
	this->nTopMargin = param.nTopMargin;

	return *this;
}

BEGIN_MESSAGE_MAP(CStaticEdit, CStatic)
	//{{AFX_MSG_MAP(CStaticEdit)
	ON_WM_CONTEXTMENU()
	ON_WM_CTLCOLOR_REFLECT()
	ON_WM_DESTROY()
	ON_WM_MOUSEMOVE()
	ON_WM_LBUTTONUP()
	ON_WM_CREATE()
	ON_WM_LBUTTONDOWN()
	ON_WM_PAINT()
	ON_COMMAND(ID_POPUP_PROPERTIES, OnPopupProperties)
	ON_COMMAND(ID_POPUP_LOCKPANELPOSITION, OnPopupLockpanelposition)
	ON_WM_LBUTTONDBLCLK()
	ON_WM_KILLFOCUS()
	ON_COMMAND(ID_POPUP_REMOVE, OnPopupRemove)
	ON_COMMAND(ID_POPUP_COPY, OnPopupCopy)
	ON_COMMAND(ID_POPUP_CUT, OnPopupCut)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CStaticEdit message handlers

HBRUSH CStaticEdit::CtlColor(CDC* pDC, UINT nCtlColor) 
{
	CBrush brush(_stParam.clrBk);
	pDC->SetTextColor(_stParam.clrSeg);	
	pDC->SetBkColor(_stParam.clrBk);
	CRect rect;
	CBrush* brOld = pDC->SelectObject(&brush);
	GetClientRect(&rect);
	pDC->Rectangle(&rect);	
	return HBRUSH(brush);
}

void CStaticEdit::OnDestroy() 
{
	CStatic::OnDestroy();	
	
}

void CStaticEdit::OnMouseMove(UINT nFlags, CPoint point) 
{
	if ( (nFlags&MK_LBUTTON) && m_bLockPosition == FALSE )
	{		
		SetCapture();				
		// change cursor stype to move status
		::SetCursor(AfxGetApp()->LoadCursor(IDC_CURSOR_MOVE));
		this->DrawDragWindow(point);
	}

	CStatic::OnMouseMove(nFlags, point);
}

void CStaticEdit::OnLButtonUp(UINT nFlags, CPoint point) 
{	
	//CStatic::OnLButtonUp(nFlags, point);

	if (m_bLockPosition == TRUE){
		return ;
	}

	ReleaseCapture();	
		
	// change cursor stype to normal status
	::SetCursor(AfxGetApp()->LoadCursor(IDC_ARROW));	

	{
		CRect rcWnd = CRect();
		this->GetWindowRect(&rcWnd);	
		GetParent()->ScreenToClient(&rcWnd);			
		this->SetWindowPos(NULL,rcWnd.left + (point.x - m_ptPoint.x),rcWnd.top + (point.y - m_ptPoint.y),0,0,SWP_NOSIZE);		
		// Redraw client
		this->Invalidate(TRUE);		

		// Redraw border
		rcWnd.InflateRect(1,1,1,1);
		GetParent()->RedrawWindow(rcWnd);
	}
	if (m_hWndMsg){
		::PostMessage(m_hWndMsg,WM_STATICEDIT_LBUTTONUP,
			WPARAM(this),
			LPARAM(MAKELPARAM(point.x,point.y))
			);
	}	
}

int CStaticEdit::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CStatic::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	// TODO: Add your specialized creation code here
	_stParam.nHeight = lpCreateStruct->cy;
	_stParam.nWidth = lpCreateStruct->cx;
	
	return 0;
}

void CStaticEdit::OnLButtonDown(UINT nFlags, CPoint point) 
{
	this->m_ptPoint = point;	
#ifdef __DESIGN_MODE	
	if (nFlags &MK_CONTROL ){
		m_bSelected = !m_bSelected;		
	}
	else{
		m_bSelected = TRUE;
	}
#endif
	if (m_hWndMsg){
		::PostMessage(m_hWndMsg,WM_STATICEDIT_SELECTED,
			WPARAM(this),
			LPARAM(m_bSelected)
			);
	}
	this->SetFocus();
	//CStatic::OnLButtonDown(nFlags, point);
}

void CStaticEdit::DrawDragWindow(CPoint& point)
{
	CDC* pDC = GetParent()->GetDC();	
	if (pDC!=NULL){
		CRect rcWnd = CRect();
		this->GetWindowRect(&rcWnd);	
		GetParent()->ScreenToClient(&rcWnd);			
		this->SetWindowPos(NULL,rcWnd.left + (point.x - m_ptPoint.x),rcWnd.top + (point.y - m_ptPoint.y),0,0,SWP_NOSIZE);				
		this->Invalidate(TRUE);		

	}
	ReleaseDC(pDC);
}

BOOL CStaticEdit::DestroyWindow() 
{
	return CStatic::DestroyWindow();
}


void CStaticEdit::OnPaint() 
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
	GetClientRect(&rect);
	rect.DeflateRect(2,2,2,2);
	CString csText = _T("");
	this->GetWindowText(csText);
	pDC->DrawText(csText,&rect,DT_CENTER|DT_SINGLELINE|DT_VCENTER);	

	if (m_bShowNumID){
		this->DrawNumID(pDC);
	}

	pDC->SelectObject(brOld);
	pDC->SelectObject(pFont);	
}

void CStaticEdit::RedrawPanel()
{
 	CRect rcPanel = CRect();
 	this->GetWindowRect(&rcPanel);		
 	this->GetParent()->ScreenToClient(&rcPanel); 	
	this->GetParent()->RedrawWindow(rcPanel);
}


void CStaticEdit::OnPopupProperties() 
{
	this->OnProperties();	
}

void CStaticEdit::OnPopupLockpanelposition() 
{
	this->m_bLockPosition = ! m_bLockPosition;
	
}

void CStaticEdit::OnProperties()
{
	m_bSelected = FALSE;
	if (m_pPropFrame == NULL)
	{
		m_pPropFrame = new CPropertyFrame;
		CRect rect(0, 0, 0, 0);
		CString strTitle;
		VERIFY(strTitle.LoadString(IDS_PROPSHT_CAPTION));
		m_pPropFrame->m_pPanel = (CStaticEdit*)this;

		if (!m_pPropFrame->Create(NULL, strTitle,
			WS_POPUP | WS_CAPTION | WS_SYSMENU, rect, this))
		{
			delete m_pPropFrame;
			m_pPropFrame = NULL;
			return;
		}
		
		m_pPropFrame->CenterWindow();
	}

	// Before unhiding the modeless property sheet, update its
	// settings appropriately.  For example, if you are reflecting
	// the state of the currently selected item, pick up that
	// information from the active view and change the property
	// sheet settings now.

	if (m_pPropFrame != NULL && !m_pPropFrame->IsWindowVisible())
		m_pPropFrame->ShowWindow(SW_SHOW);
}

void CStaticEdit::OnContextMenu(CWnd* pWnd, CPoint point)
{
#ifdef __DESIGN_MODE
	// CG: This block was added by the Pop-up Menu component
	{
		if (point.x == -1 && point.y == -1){
			//keystroke invocation
			CRect rect;
			GetClientRect(rect);
			ClientToScreen(rect);

			point = rect.TopLeft();
			point.Offset(5, 5);
		}

		CMenu menu;
		VERIFY(menu.LoadMenu(CG_IDR_POPUP_INPUT_PANEL));

		CMenu* pPopup = menu.GetSubMenu(0);
		ASSERT(pPopup != NULL);
		CWnd* pWndPopupOwner = this;

		if (m_bLockPosition == TRUE)
		{			
			pPopup->CheckMenuItem(ID_POPUP_LOCKPANELPOSITION,MF_CHECKED|MF_BYCOMMAND);			
		}
		else
		{			
			pPopup->CheckMenuItem(ID_POPUP_LOCKPANELPOSITION,MF_UNCHECKED|MF_BYCOMMAND);			
		}

		pPopup->TrackPopupMenu(TPM_LEFTALIGN | TPM_RIGHTBUTTON, point.x, point.y,
			pWndPopupOwner);
	}
#endif
}

void CStaticEdit::ResizePanel()
{
 	int nBorder = 0;
 	CRect rect = CRect();
 	this->GetClientRect(&rect);
 	
 	if (GetExStyle()&SS_EX_CLIENTEDGE)	nBorder += 2;		
 	if (GetExStyle()&SS_EX_STATICEDGE)	nBorder += 2;
 	if (GetExStyle()&SS_EX_MODALFRAME)	nBorder += 2;
 		
 	this->SetWindowPos(	NULL, -1, -1, _stParam.nWidth, _stParam.nHeight + nBorder,
 					SWP_NOMOVE | SWP_NOZORDER | SWP_NOREDRAW | SWP_NOACTIVATE);		
 	
	this->m_pDataEdit->SetWindowPos(	NULL, -1, -1, _stParam.nWidth -6, _stParam.nHeight + nBorder -6,
 					SWP_NOMOVE | SWP_NOZORDER | SWP_NOREDRAW | SWP_NOACTIVATE);

	this->m_pDataEdit->InitCharFormat((_stParam.nHeight + nBorder)*10);

	this->RedrawPanel();
}

void CStaticEdit::InitControl(HWND hWndMsg)
{	
	m_hWndMsg = hWndMsg;

	CRect rect =CRect();
	GetClientRect(rect);
	rect.DeflateRect(2,2,2,2);

	SetWindowText(_T(""));	

	SetFont(m_csFontName,(_stParam.nHeight - 6));

	m_pDataEdit = new CDataEdit();
	if (m_pDataEdit)
	{
		this->m_pDataEdit->Create(WS_CHILD/*|WS_BORDER*/|ES_AUTOHSCROLL,rect,this,1021);		
		this->m_pDataEdit->InitCharFormat();
		this->m_pDataEdit->ShowWindow(SW_HIDE);
		this->m_pDataEdit->UpdateWindow();				
		this->m_pDataEdit->EnableWindow(FALSE);
		this->m_pDataEdit->m_bEnableChars = TRUE;		
		this->m_pDataEdit->SetFocus();
	}
	this->SetFocus();
}

void CStaticEdit::OnLButtonDblClk(UINT nFlags, CPoint point) 
{
	if (_stParam.bEnableEdit){
		this->m_pDataEdit->Clear();
		this->m_pDataEdit->EnableWindow(TRUE);
		this->m_pDataEdit->ShowWindow(SW_SHOW);
		this->m_pDataEdit->UpdateWindow();	
		this->m_pDataEdit->SetFocus();		
	}

	//CStatic::OnLButtonDblClk(nFlags, point);
}

BOOL CStaticEdit::PreTranslateMessage(MSG* pMsg) 
{
	if ( (pMsg->message == WM_KEYDOWN) )	
	{
		switch (pMsg->wParam)
		{
		case VK_ESCAPE:			
			ReleaseCapture();			
			m_bSelected =FALSE;
			this->m_pDataEdit->ShowWindow(SW_HIDE);			
			this->m_pDataEdit->EnableWindow(FALSE);
			this->RedrawPanel();
			break;
		case VK_RETURN:			
			{
				ReleaseCapture();
				if (this->GetFocus() == (CWnd*)(m_pDataEdit))
				{										
					this->m_pDataEdit->ShowWindow(SW_HIDE);					
					this->m_pDataEdit->EnableWindow(FALSE);
					this->m_pDataEdit->SetSel(0,-1);
					TCHAR szEdit[MAX_PATH]; 
					this->GetEditText(szEdit,sizeof(szEdit));
					this->SetText(szEdit);									
				}								
			}
			break;
		case VK_DELETE:
			//this->OnPopupRemove();			
			break;
		}
	}
	
	return CStatic::PreTranslateMessage(pMsg);
}

void CStaticEdit::SetDigit(int nDigits)
{
	m_nDigits = _stParam.nDigits = nDigits;
	if (m_pDataEdit){
		m_pDataEdit->LimitText(nDigits);
	}
	this->RedrawPanel();
}

void CStaticEdit::OnKillFocus(CWnd* pNewWnd) 
{		
	this->RedrawPanel();
	CStatic::OnKillFocus(pNewWnd);	
}

void CStaticEdit::SetFont(LPCTSTR szFontName, UINT nHeight)
{
	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));			// zero out structure			
	lf.lfHeight = nHeight;				  		//  size
	lf.lfWeight	= FW_BOLD;					
	lf.lfQuality= ANTIALIASED_QUALITY;						

#ifdef _UNICODE
	wcscpy_s((LPTSTR)lf.lfFaceName,LF_FACESIZE, szFontName);     // request a face name 
#else
	strcpy_s((LPTSTR)lf.lfFaceName,LF_FACESIZE, szFontName);     // request a face name 
#endif
	
	m_font.DeleteObject();
	m_font.CreateFontIndirect(&lf);		// create the font	
	_stParam.csFontName = szFontName;
	
}

void CStaticEdit::OnPopupRemove() 
{
	if (m_hWndMsg){
		::PostMessage(m_hWndMsg,WM_STATICEDIT_REMOVE,
			WPARAM(this),
			LPARAM(0)
			);
	}	
}

void CStaticEdit::OnPopupCopy() 
{
	if (m_hWndMsg){
		::PostMessage(m_hWndMsg,WM_STATICEDIT_COPY,
			WPARAM(this),
			LPARAM(0)
			);
	}	
}

void CStaticEdit::OnPopupCut() 
{
	if (m_hWndMsg){
		::PostMessage(m_hWndMsg,WM_STATICEDIT_CUT,
			WPARAM(this),
			LPARAM(0)
			);
	}
}

const CStaticEdit& CStaticEdit::operator =(const CStaticEdit &srcLED)
{
	this->_stParam = srcLED._stParam;
	this->m_bLockPosition = srcLED.m_bLockPosition;
	this->m_bSelected = FALSE;
	this->m_csFontName = srcLED.m_csFontName;	
	this->m_hWndMsg = srcLED.m_hWndMsg;	
	this->m_nDigits = srcLED.m_nDigits;
	this->m_ptPoint = srcLED.m_ptPoint;

	return *this;
}

void CStaticEdit::SetColor(COLORREF clrOff, COLORREF clrOn)
{
	
}

void CStaticEdit::SetBkColor(COLORREF clrBk)
{
	
}

void CStaticEdit::SetText(LPCTSTR lpszText)
{
	SetWindowText(lpszText);	
	this->Invalidate(FALSE);
}

void CStaticEdit::GetPageText(CString& csText, int nPage)
{
}

void CStaticEdit::SetPageText(LPCTSTR lpszText, int nPage)
{
}

void CStaticEdit::GetText(CString& csText)
{	
	GetWindowText(csText);	
}

void CStaticEdit::GetEditText(LPTSTR szEdit, int len)
{
	len = m_pDataEdit->GetLine(0,szEdit,len);	
	if (szEdit[len-2]==0x0D){
		szEdit[len-2] ='\0';
		len -= 2;
	}
	if (szEdit[len-1]==0x0D){
		szEdit[len-1] ='\0';
		len -= 1;
	}	
}

void CStaticEdit::DrawNumID(CDC *pDC)
{
	CString csNumID;
	csNumID.Format(_T("%d"),m_nNumID);
	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));			// zero out structure			
	lf.lfHeight = 10;				  		//  size
	lf.lfWeight	= FW_NORMAL;					
	lf.lfQuality= ANTIALIASED_QUALITY;						

#ifdef _UNICODE
	wcscpy_s((LPTSTR)lf.lfFaceName, LF_FACESIZE, _T("Arial"));     // request a face name 
#else
	strcpy_s((LPTSTR)lf.lfFaceName, LF_FACESIZE, _T("Arial"));     // request a face name 
#endif
	CFont font;
	font.DeleteObject();
	font.CreateFontIndirect(&lf);		// create the font	
	CFont* pOldFont = pDC->SelectObject(&font);
	CRect rect;
	GetClientRect(rect);	
	pDC->SetTextColor(RGB(255,255,255));
	pDC->DrawText(csNumID,&rect,DT_LEFT|DT_SINGLELINE|DT_VCENTER);
	pDC->SelectObject(pOldFont);
}

void CStaticEdit::SetNumID(UINT nID)
{
	m_nNumID = nID;
	this->Invalidate(FALSE);
}

void CStaticEdit::ShowNumID(BOOL bShow)
{
	m_bShowNumID = bShow;
	this->Invalidate(FALSE);
}

int CStaticEdit::GetDigits() const
{
	return m_nDigits;
}

CString CStaticEdit::GetFontName() const
{
	return m_csFontName;
}

UINT CStaticEdit::GetNumID() const
{
	return m_nNumID;
}
