// DataStatic.cpp : implementation file
//

#include "stdafx.h"
#include "Matrix.h"
#include "DataStatic.h"
#include "DataGroup.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define		TIMER_ID		1002
/////////////////////////////////////////////////////////////////////////////
// CDataStatic

CDataStatic::CDataStatic()
{
	m_bSelectColor = TRUE;
	m_bEnable  = TRUE;
	m_bRunning = FALSE;
	m_clrBk = RGB(46,49,56);
	m_clrText = RGB(255,0,0);
	m_pDataEdit = NULL;
	m_nRate = 2;
	m_nCount = 0;
	m_nStyle = 0;
	m_nIndex = -1;
}

CDataStatic::~CDataStatic()
{

}


BEGIN_MESSAGE_MAP(CDataStatic, CStatic)	
	//{{AFX_MSG_MAP(CDataStatic)
	ON_WM_CTLCOLOR_REFLECT()
	ON_WM_TIMER()
	ON_WM_CREATE()
	ON_WM_DESTROY()
	ON_COMMAND(ID_POPUP_RUN, OnPopupRun)
	ON_COMMAND(ID_POPUP_STOP, OnPopupStop)
	ON_COMMAND(ID_POPUP_COLOR_GREEN, OnPopupColorGreen)
	ON_COMMAND(ID_POPUP_COLOR_RED, OnPopupColorRed)
	ON_COMMAND(ID_POPUP_COLOR_YELLOW, OnPopupColorYellow)
	ON_COMMAND(ID_POPUP_LOAD, OnPopupLoad)
	ON_WM_LBUTTONDBLCLK()
	ON_WM_KILLFOCUS()
	ON_WM_LBUTTONUP()
	ON_WM_LBUTTONDOWN()
	ON_COMMAND(ID_POPUP_ONOFF, OnPopupOnoff)
	ON_WM_CONTEXTMENU()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDataStatic message handlers

HBRUSH CDataStatic::CtlColor(CDC* pDC, UINT nCtlColor) 
{	
	pDC->SelectObject(&m_font);
	pDC->SetTextColor(m_clrText);
	
	CBrush brush(m_clrBk);	
	pDC->SetTextColor((m_bEnable)?m_clrText:RGB(200,200,200));
	pDC->SetBkColor(m_clrBk);
	CRect rect;
	CBrush* brOld = pDC->SelectObject(&brush);
	GetWindowRect(&rect);
	pDC->Rectangle(&rect);
	
	if (m_nStyle == STYLE_DATE)
	{
		CTime time = CTime::GetCurrentTime();
		this->SetWindowText(time.Format(_T(" %d/%m/%Y ")));
	}
	else if (m_nStyle == STYLE_TIME)
	{
		UINT nParam[2] = {0,0};
		CString csText;
		this->GetWindowText(csText);
#ifdef _UNICODE
		swscanf(csText,_T("%02d:%02d"),&nParam[0],&nParam[1]);
#else
		sscanf(csText,_T("%02d:%02d"),&nParam[0],&nParam[1]);
#endif
		csText.Format(_T("%02d:%02d"),nParam[0],nParam[1]);
		this->SetWindowText(csText);
	}
	
	return HBRUSH(brush);
}

void CDataStatic::OnTimer(UINT nIDEvent) 
{
	if (m_nStyle == STYLE_CLOCK)
	{		
		if (++m_nCount >= 50)
		{
			m_nCount = 0;
			CTime time = CTime::GetCurrentTime();
			this->SetWindowText(time.Format(_T("    %H:%M:%S    ")));
			this->DrawText(FALSE);
		}

		return;
	}

	if (m_bEnable && m_bRunning && m_nStyle == STYLE_TEXT)
	{		
		if (--m_nDelay > 0)
		{
			Clear();
		}

		if (++m_nCount >= m_nRate)
		{
			m_nCount = 0;			

			CString csText = _T("");
			this->GetWindowText(csText);
			CWindowDC dc(this);
			CSize sz = dc.GetTextExtent(csText);
			
			CRect rc;
			GetWindowRect(&rc);
			ScreenToClient(&rc);			

			if (m_rcCurText.left == -(sz.cx +  10))
			{
				m_rcCurText = rc;
				m_rcCurText.OffsetRect(rc.Width(),0);
			}
			

			this->DrawText(TRUE);			
		}
	}
}

#include "resource.h"
void CDataStatic::OnContextMenu(CWnd*, CPoint point)
{
	if (m_nStyle != STYLE_STATIC)
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
		VERIFY(menu.LoadMenu(CG_IDR_POPUP_DATA_STATIC));

		CMenu* pPopup = menu.GetSubMenu(0);
		ASSERT(pPopup != NULL);
		CWnd* pWndPopupOwner = this;

		if (m_bRunning == TRUE)
		{			
			pPopup->CheckMenuItem(ID_POPUP_RUN,MF_CHECKED|MF_BYCOMMAND);			
			pPopup->CheckMenuItem(ID_POPUP_STOP,MF_UNCHECKED|MF_BYCOMMAND);			
		}
		else
		{			
			pPopup->CheckMenuItem(ID_POPUP_STOP,MF_CHECKED|MF_BYCOMMAND);			
			pPopup->CheckMenuItem(ID_POPUP_RUN,MF_UNCHECKED|MF_BYCOMMAND);			
		}
		
		pPopup->ModifyMenu(ID_POPUP_ONOFF,MF_BYCOMMAND|MF_STRING,ID_POPUP_ONOFF,m_bEnable?_T("T\x1EAF"L"t \x111"L"i"):_T("B\x1EAD"L"t l\xEA"L"n"));

		pPopup->EnableMenuItem(ID_POPUP_LOAD,m_nStyle==0?MF_ENABLED:MF_GRAYED);
		pPopup->EnableMenuItem(ID_POPUP_RUN,m_nStyle==0?MF_ENABLED:MF_GRAYED);
		pPopup->EnableMenuItem(ID_POPUP_STOP,m_nStyle==0?MF_ENABLED:MF_GRAYED);

		pPopup->EnableMenuItem(ID_POPUP_COLOR_RED,m_bSelectColor?MF_ENABLED:MF_GRAYED);
		pPopup->EnableMenuItem(ID_POPUP_COLOR_GREEN,m_bSelectColor?MF_ENABLED:MF_GRAYED);
		pPopup->EnableMenuItem(ID_POPUP_COLOR_YELLOW,m_bSelectColor?MF_ENABLED:MF_GRAYED);
		

		pPopup->TrackPopupMenu(TPM_LEFTALIGN | TPM_RIGHTBUTTON, point.x, point.y,
			pWndPopupOwner);
	}
}

int CDataStatic::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CStatic::OnCreate(lpCreateStruct) == -1)
		return -1;			

	return 0;
}

void CDataStatic::OnDestroy() 
{
	CStatic::OnDestroy();
	if (m_pDataEdit)
	{
		m_pDataEdit->DestroyWindow();
		delete m_pDataEdit;
	}
	KillTimer(TIMER_ID);	
}

void CDataStatic::DrawText(BOOL bScroll)
{
	CWindowDC dc(this);
	CDC* pDC = &dc;

	CPen pen(PS_NULL,0,RGB(0,0,0));
	CPen* pOldPen = pDC->SelectObject(&pen);
	CFont* pFont = pDC->SelectObject(&m_font);
	pDC->SetBkColor(m_clrBk);
	CRect rect;
	GetWindowRect(&rect);
	ScreenToClient(&rect);
	
	
	CString csText;
	this->GetWindowText(csText);
		
	if (m_bEnable == FALSE)
		csText = _T("");

	pDC->SetTextColor(m_clrBk);	
	pDC->DrawText(csText,m_rcCurText,DT_VCENTER|DT_SINGLELINE);	
	if (bScroll)	
		m_rcCurText.left -=1;
	pDC->SetTextColor(m_clrText);
	pDC->DrawText(csText,m_rcCurText,DT_VCENTER|DT_SINGLELINE);			

	pDC->SelectObject(pFont);
	pDC->SelectObject(pOldPen);
}

void CDataStatic::Init(HWND hMsg)
{
	m_pDataEdit = new CDataEdit();
	if (m_pDataEdit)
	{
		CRect rect;
		GetClientRect(&rect);
		m_pDataEdit->Create(WS_CHILD/*|WS_BORDER*/|ES_AUTOHSCROLL,rect,this,1021);		
		m_pDataEdit->InitCharFormat();
		m_pDataEdit->ShowWindow(SW_HIDE);
		m_pDataEdit->UpdateWindow();
		this->m_nEditShow = SW_HIDE;
		this->m_pDataEdit->EnableWindow(FALSE);
	}

	GetWindowRect(&m_rcCurText);	
	ScreenToClient(&m_rcCurText);
	m_rcCurText.left   += 5;
	m_rcCurText.right  -= 5;
	m_rcCurText.top    += 5;
	m_rcCurText.bottom -= 5;
	
	m_hMsg = hMsg;
	SetTimer(TIMER_ID,10,NULL);
}

void CDataStatic::Start()
{
	this->Clear();
	m_nDelay = 10;
	m_bRunning = TRUE;	
}

void CDataStatic::Stop()
{
	m_bRunning = FALSE;
	this->Invalidate();
}

void CDataStatic::OnPopupRun() 
{
	this->Start();	
}


void CDataStatic::OnPopupStop() 
{
	this->Stop();
}

void CDataStatic::OnPopupColorGreen() 
{	
	m_clrText = RGB(0,255,0);
	if (!m_bRunning)
		this->Invalidate();
}

void CDataStatic::OnPopupColorRed() 
{	
	m_clrText = RGB(255,0,0);
	if (!m_bRunning)
		this->Invalidate();
}

void CDataStatic::OnPopupColorYellow() 
{		
	m_clrText = RGB(255,255,0);
	if (!m_bRunning)
		this->Invalidate();
}

DECLARE_USER_MESSAGE(WMU_DATA_STATIC_LOAD)

void CDataStatic::OnPopupLoad() 
{	
	if (m_hMsg)
		::PostMessage(m_hMsg,WMU_DATA_STATIC_LOAD,WPARAM(this),(LPARAM)m_nIndex);	
}

void CDataStatic::OnLButtonDblClk(UINT nFlags, CPoint point) 
{
	if (m_bEnable == FALSE)	return;

	if (m_pDataEdit && (m_nStyle < 3))
	{
		this->Stop();
		CString csText = _T("");
		GetWindowText(csText);
		this->m_pDataEdit->EnableWindow(TRUE);
		m_pDataEdit->SetWindowText(csText);
		m_pDataEdit->ShowWindow(SW_SHOW);
		m_pDataEdit->UpdateWindow();
		this->m_nEditShow = SW_SHOW;		
		this->m_pDataEdit->SetFocus();
	}
	
	if (m_nStyle != STYLE_STATIC)
	{
		if (m_bSelectColor)
		{
			if (m_clrText == RGB(255,0,0))
				m_clrText = RGB(255,255,0);
			else if (m_clrText == RGB(0,255,0))
				m_clrText = RGB(255,0,0);
			else if (m_clrText == RGB(255,255,0))
				m_clrText = RGB(0,255,0);

			CDataGroup* pParent = (CDataGroup*)GetParent();
			if (pParent !=NULL)
				pParent->SetAllItemColor(m_clrText,TRUE);
			
			this->Invalidate();
		}		
	}	

	if(GetCapture()!=this)
		SetCapture();	

	CStatic::OnLButtonDblClk(nFlags, point);
}

BOOL CDataStatic::PreTranslateMessage(MSG* pMsg) 
{
	if ( (pMsg->message == WM_KEYDOWN) )	
	{
		switch (pMsg->wParam)
		{
		case VK_ESCAPE:
			ReleaseCapture();
			this->m_nEditShow = SW_HIDE;
			this->m_pDataEdit->ShowWindow(SW_HIDE);
			this->m_pDataEdit->EnableWindow(FALSE);
			break;
		case VK_RETURN:
			if (this->m_nEditShow == SW_SHOW)
			{
				ReleaseCapture();
				//if (this->GetFocus() == (CWnd*)(m_pDataEdit))
				{					
					this->m_nEditShow = SW_HIDE;
					this->m_pDataEdit->ShowWindow(SW_HIDE);
					this->m_pDataEdit->EnableWindow(FALSE);
					this->m_pDataEdit->SetSel(0,-1);
					CString csEdit = _T("");
					int len = this->m_pDataEdit->LineLength(0);
					this->m_pDataEdit->GetLine(0,csEdit.GetBuffer(len), len); 					
					
					if (m_nStyle == STYLE_TIME)
					{
						UINT nParam[2] = {0,0};
					#ifdef _UNICODE
						swscanf(csEdit,_T("%02d%02d"),&nParam[0],&nParam[1]);
					#else
						sscanf(csEdit,_T("%02d%02d"),&nParam[0],&nParam[1]);
					#endif
						
						csEdit.Format(_T("%02d:%02d"),nParam[0],nParam[1]);
					}		
					else if (m_nStyle == STYLE_SHORT_TEXT)
					{
						// alpha numberic filter

						char buffer[512];
						LPTSTR szData = (LPTSTR)csEdit.GetBuffer(csEdit.GetLength());		
						int length = WideCharToMultiByte(CP_ACP,0,szData,wcslen(szData),buffer,sizeof(buffer),NULL,NULL);	
						// filter A-Z 0-9 characters
						for (int c =0; c< length; c++)
						{
							if (isalnum(buffer[c])==0)
								buffer[c] = 0x20;
						}
						buffer[c] = '\0';
						WCHAR szWChar[1024];
						MultiByteToWideChar( CP_ACP, 0, (char*)(buffer), -1, szWChar, sizeof(buffer) );			
						
						csEdit.Format(_T("%4s"),_wcsupr(szWChar));
					}
					
					this->SetWindowText(csEdit);
				}								
			}
			break;
		}
	}
		
	return CStatic::PreTranslateMessage(pMsg);
}

void CDataStatic::SetColor(COLORREF clrBk, COLORREF clrText)
{
	m_clrBk = clrBk; m_clrText = clrText;
	this->Invalidate();
}

void CDataStatic::SetBkColor(COLORREF clrBk)
{
	m_clrBk = clrBk;
	this->Invalidate();
}

void CDataStatic::SetTextColor(COLORREF clrText)
{
	m_clrText = clrText;
	this->Invalidate();
}

void CDataStatic::SetRate(UINT nRate)
{
	m_nRate = nRate;
}

void CDataStatic::SetStyle(int nStyle)
{
	m_nStyle = nStyle;
	if (nStyle == STYLE_TIME)
		this->SetLimitText(4);
	else if (nStyle == STYLE_SHORT_TEXT)
		this->SetLimitText(4);
}

void CDataStatic::Clear()
{
	CWindowDC dc(this);
	CDC* pDC = &dc;

	CBrush brush(m_clrBk);	

	CPen pen(PS_NULL,0,RGB(0,0,0));
	CPen* pOldPen = pDC->SelectObject(&pen);
	CBrush * pBr = pDC->SelectObject(&brush);
	CRect rect;
	GetWindowRect(&rect);
	ScreenToClient(&rect);

	pDC->Rectangle(&rect);

	pDC->SelectObject(pBr);
	pDC->SelectObject(pOldPen);
}

void CDataStatic::SetFont(LPCTSTR szFontName, UINT nHeight)
{
	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));			// zero out structure			
	lf.lfHeight = nHeight;				  		//  size
	lf.lfWeight	= FW_BOLD;					
	lf.lfQuality= ANTIALIASED_QUALITY;						

#ifdef _UNICODE
	wcscpy((LPTSTR)lf.lfFaceName, szFontName);     // request a face name 
#else
	strcpy((LPTSTR)lf.lfFaceName, szFontName);     // request a face name 
#endif
	
	m_font.DeleteObject();
	m_font.CreateFontIndirect(&lf);		// create the font	
	
}

void CDataStatic::OnKillFocus(CWnd* pNewWnd) 
{
	CStatic::OnKillFocus(pNewWnd);	
	
}

COLORREF CDataStatic::GetBkColor()
{
	return m_clrBk;
}

void CDataStatic::OnLButtonUp(UINT nFlags, CPoint point) 
{
	if (m_bEnable == FALSE) return;

	if(GetCapture()==this)
		return;

	if (m_nStyle != STYLE_STATIC )
	{
		if (m_bSelectColor)
		{
			if (m_clrText == RGB(255,0,0))
				m_clrText = RGB(0,255,0);
			else if (m_clrText == RGB(0,255,0))
				m_clrText = RGB(255,255,0);
			else if (m_clrText == RGB(255,255,0))
				m_clrText = RGB(255,0,0);
			CDataGroup* pParent = (CDataGroup*)GetParent();
			if (pParent !=NULL)
				pParent->SetAllItemColor(m_clrText,TRUE);
			this->Invalidate();		
		}		
	}

	CStatic::OnLButtonUp(nFlags, point);
}

COLORREF CDataStatic::GetTextColor()
{
	return m_clrText;
}

void CDataStatic::SetLimitText(int nLimit)
{
	if (m_pDataEdit)
		m_pDataEdit->LimitText(nLimit);
}

void CDataStatic::OnLButtonDown(UINT nFlags, CPoint point) 
{
	if (GetCapture()==(CDataStatic*)this)
	{
		CRect rect = CRect(0,0,0,0);
		this->GetClientRect(rect);		
		if (rect.PtInRect(point)==FALSE)
		{
			m_pDataEdit->ShowWindow(SW_HIDE);
			m_pDataEdit->EnableWindow(FALSE);
			ReleaseCapture();
		}
	}

	CStatic::OnLButtonDown(nFlags, point);
}

int CDataStatic::GetMode()
{
	int nMode = 0;
	if (m_bEnable)	
		nMode = (m_bRunning)?int(2):int(1);			
	return nMode;
}

void CDataStatic::SetMode(int nMode)
{
	SetEnable(TRUE);
	if (nMode==2)	Start();
	if (nMode==1)	Stop();
	if (nMode==0)	SetEnable(FALSE);
}

BOOL CDataStatic::EnableWindow(BOOL bEnable)
{
	return CStatic::EnableWindow(m_bEnable = bEnable);
}

DECLARE_USER_MESSAGE(WMU_DATA_STATIC_ONOFF)

void CDataStatic::OnPopupOnoff() 
{
	m_bEnable = (!m_bEnable);	
	this->Invalidate();
	CDataGroup* pParent = (CDataGroup*)GetParent();
	if (pParent !=NULL)
		if (m_hMsg && pParent->m_bUniformOnOff)
			::PostMessage(m_hMsg,WMU_DATA_STATIC_ONOFF,WPARAM(this),(LPARAM)m_bEnable);	
}

void CDataStatic::SetEnable(BOOL bEnable)
{
	m_bEnable = bEnable;
}

void CDataStatic::SetSelectColor(BOOL bEnable)
{
	m_bSelectColor = bEnable;
}

