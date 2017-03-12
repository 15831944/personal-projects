// DxButton.cpp : implementation file
//

#include "stdafx.h"
#include "DxButton.h"
	
#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDxButton

CDxButton::CDxButton()
{
	m_bColorStyle = FALSE;
	m_bHighlight = FALSE;
	m_hFace		 = NULL;
	m_hHighlight = NULL;
	m_clrText = RGB(0,0,0);
	m_clrTextHighlight = RGB(0,0,0);
	m_bPressing = FALSE;
}

CDxButton::~CDxButton()
{
	
}


BEGIN_MESSAGE_MAP(CDxButton, CButton)
	//{{AFX_MSG_MAP(CDxButton)
	ON_WM_MOUSEMOVE()
	ON_WM_KILLFOCUS()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDxButton message handlers

void CDxButton::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct) 
{


   // This code only works with buttons.
   
   ASSERT(lpDrawItemStruct->CtlType == ODT_BUTTON);
   
   CRect rcDefault = lpDrawItemStruct->rcItem;      
   CRect rcText		 = rcDefault;   
   
   CPoint iconPos((rcDefault.Height()-32)/2,(rcDefault.Height()-32)/2);
   
   CDC *pdc = CDC::FromHandle(lpDrawItemStruct->hDC);
   
   // Get the button's text.
   
   CString strText;
   GetWindowText(strText);
   pdc->SetBkMode(TRANSPARENT);

   // Change text color
   COLORREF clrOld = ::SetTextColor(lpDrawItemStruct->hDC,m_clrText);   

   // Setting the text font
   CFont *pOldFont = pdc->SelectObject(&m_Font);
   
   // Create the brushes for painting

   CBrush brFace;
   CBrush brPushed;
   CBrush *pbrOld;

   brFace.CreateSolidBrush(::GetSysColor(COLOR_3DFACE));
   brPushed.CreateSolidBrush(RGB(240,240,240));
      

   pbrOld = pdc->SelectObject(&brFace);

   UINT state = lpDrawItemStruct->itemState;
   
   COLORREF clrTopLeft = RGB(255,255,255);
   COLORREF clrBottomRight = ::GetSysColor(COLOR_3DSHADOW);

   HICON hIcon = m_hFace;

	if ((state& ODS_DEFAULT))
	{
		hIcon = m_hFace;
		clrTopLeft = RGB(255,255,255);      // normal state
	    clrBottomRight = ::GetSysColor(COLOR_3DSHADOW); 
	}
	else if ((state & ODS_SELECTED))
	{
		hIcon = m_hHighlight;
		pdc->SelectObject(&brPushed);
		clrTopLeft = ::GetSysColor(COLOR_3DSHADOW);    // button pushed	
	    clrBottomRight = RGB(255,255,255); 		
		::SetTextColor(lpDrawItemStruct->hDC,m_clrTextHighlight); 
	}
	else if ((state & ODS_DISABLED))
	{	
		hIcon = m_hFace;
		clrTopLeft = ::GetSysColor(COLOR_3DFACE);      // button pushed	
	    clrBottomRight = ::GetSysColor(COLOR_3DFACE); 
	}
	else if ((m_bHighlight) )
	{		
		hIcon = m_hHighlight;		
		clrTopLeft = RGB(255,255,255);					// highlight state
	    clrBottomRight = ::GetSysColor(COLOR_3DSHADOW); 		
		::SetTextColor(lpDrawItemStruct->hDC,m_clrTextHighlight);   
	}

   // Draw the buttons

   pdc->Rectangle(&rcDefault);
   pdc->Draw3dRect(&rcDefault,clrTopLeft,clrBottomRight);   
   if(m_bHighlight && !(state & ODS_SELECTED))
   {
	   rcDefault.DeflateRect(1,1);
	   pdc->Draw3dRect(&rcDefault,clrTopLeft,clrBottomRight);   
   }

   // Draw the icons

   if(pdc->DrawIcon(iconPos,hIcon))
   {
	   rcText.left +=32;
   }
   
   pdc->DrawText(strText,&rcText, DT_SINGLELINE|DT_VCENTER|DT_CENTER);

   // draw clor fase for button color style
   if (m_bColorStyle)
   {	   
	   CBrush brFace(m_clrFace);
	   CBrush*pbrOld = pdc->SelectObject(&brFace);
	   CPen Pen(PS_SOLID,0,m_clrFace);
	   CPen* pPen = pdc->SelectObject(&Pen);
	   rcDefault.DeflateRect(1,1);
	   pdc->Rectangle(&rcDefault);
	   pdc->SelectObject(pbrOld);
	   pdc->SelectObject(pPen);
   }
   // Reset text color
   ::SetTextColor(lpDrawItemStruct->hDC, clrOld);
   
   // Reset objects
   pdc->SelectObject(pOldFont);
   pdc->SelectObject(pbrOld);   
   pdc->SetBkMode(OPAQUE);      

}

void CDxButton::OnMouseMove(UINT nFlags, CPoint point) 
{
	if(nFlags!=MK_LBUTTON)
	{
		if(GetCapture()!=this)
			SetCapture();		
		CRect rc ;
		this->GetClientRect(&rc);
		if(rc.PtInRect(point))
		{	
			if(m_bHighlight==FALSE)
				Invalidate();
			m_bHighlight = TRUE;			
		}
		else 
		{	
			if(m_bHighlight==TRUE)
				Invalidate();			
			m_bHighlight = FALSE;						
			if(GetCapture()==this)
				::ReleaseCapture();
		} 
	}
	
	CButton::OnMouseMove(nFlags, point);
}

void CDxButton::SetTextColor(COLORREF clrText, COLORREF clrTextHighlight)
{	
	m_clrText = clrText;
	m_clrTextHighlight = clrTextHighlight;
}

void CDxButton::SetWindowText(LPCTSTR lpszString)
{
	Invalidate(TRUE);
	CButton::SetWindowText(lpszString );
}

void CDxButton::OnKillFocus(CWnd* pNewWnd) 
{
	m_bHighlight = FALSE;
	CButton::OnKillFocus(pNewWnd);
	
}


HICON CDxButton::SetIcon(HICON hIcon)
{
	m_hFace = hIcon;
	m_hHighlight = hIcon;
	return CButton::SetIcon(hIcon);
}

void CDxButton::SetIcon(HICON hFace, HICON hHighlight)
{
	m_hFace = hFace;
	m_hHighlight = hHighlight;
}

HCURSOR CDxButton::SetCursor(HCURSOR hCursor)
{		
	return (HCURSOR)SetClassLong(m_hWnd,GCL_HCURSOR,(LONG)hCursor);
}


void CDxButton::SetFont(LOGFONT lfont)
{
	VERIFY(m_Font.CreateFontIndirect(&lfont));		// create the font
}

void CDxButton::SetFont(LPCTSTR lpszFontFace,UINT nHeigh,UINT nStyle,BOOL bItalic,BOOL bUnderline)
{
	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));			// zero out structure
		
	lf.lfHeight = nHeigh;			  			//  size
	lf.lfWeight	= nStyle;	
	lf.lfItalic = bItalic;
	lf.lfUnderline = bUnderline;
	lf.lfQuality= ANTIALIASED_QUALITY;
	lf.lfPitchAndFamily = FF_SCRIPT|FF_SWISS;

#ifdef _UNICODE
	wcscpy(lf.lfFaceName, lpszFontFace);        // request a face name 
#else
	strcpy(lf.lfFaceName, lpszFontFace);        // request a face name 
#endif
	VERIFY(m_Font.CreateFontIndirect(&lf));		// create the font
	
}

BOOL CDxButton::PreTranslateMessage(MSG* pMsg) 
{	
	return CButton::PreTranslateMessage(pMsg);
}

void CDxButton::ButtonPress()
{
	m_bPressing = TRUE;

	CRect rcDefault;
	GetClientRect(&rcDefault);
	CRect rcText		 = rcDefault;   
    
	CClientDC *pdc = new CClientDC(this);
   
	// Get the button's text.
   
	CString strText;
	GetWindowText(strText);
	pdc->SetBkMode(TRANSPARENT);

	// Change text color
	COLORREF clrOld = pdc->SetTextColor(m_clrText);   

	// Setting the text font
	CFont *pOldFont = pdc->SelectObject(&m_Font);
   
	// Create the brushes for painting

	CBrush brFace;
	CBrush brPushed;
	CBrush *pbrOld;

	brFace.CreateSolidBrush(::GetSysColor(COLOR_3DFACE));
	brPushed.CreateSolidBrush(RGB(240,240,240));
    

	pbrOld = pdc->SelectObject(&brFace);   
   
	COLORREF clrTopLeft = RGB(255,255,255);
	COLORREF clrBottomRight = ::GetSysColor(COLOR_3DSHADOW);

		
	// pressed state

	pdc->SelectObject(&brPushed);
	clrTopLeft = ::GetSysColor(COLOR_3DSHADOW);    // button pushed	
	clrBottomRight = RGB(255,255,255); 		
	pdc->SetTextColor(m_clrTextHighlight); 
		
	// Draw the buttons

	pdc->Rectangle(&rcDefault);
	pdc->Draw3dRect(&rcDefault,clrTopLeft,clrBottomRight);   
   
	pdc->DrawText(strText,&rcText, DT_SINGLELINE|DT_VCENTER|DT_CENTER);

	// Reset text color
	pdc->SetTextColor(clrOld);
   
	// Reset objects
	pdc->SelectObject(pOldFont);
	pdc->SelectObject(pbrOld);   
	pdc->SetBkMode(OPAQUE);  

	delete pdc;
}

void CDxButton::ButtonRelease()
{
	m_bPressing = FALSE;

	CRect rcDefault;
	GetClientRect(&rcDefault);
	CRect rcText		 = rcDefault;   
    
	CClientDC *pdc = new CClientDC(this);
   
	// Get the button's text.
   
	CString strText;
	GetWindowText(strText);
	pdc->SetBkMode(TRANSPARENT);

	// Change text color
	COLORREF clrOld = pdc->SetTextColor(m_clrText);   

	// Setting the text font
	CFont *pOldFont = pdc->SelectObject(&m_Font);
   
	// Create the brushes for painting

	CBrush brFace;
	CBrush brPushed;
	CBrush *pbrOld;

	brFace.CreateSolidBrush(::GetSysColor(COLOR_3DFACE));
	brPushed.CreateSolidBrush(RGB(240,240,240));
    

	pbrOld = pdc->SelectObject(&brFace);   
   
	COLORREF clrTopLeft = RGB(255,255,255);
	COLORREF clrBottomRight = ::GetSysColor(COLOR_3DSHADOW);

		
	// normal state

	//	pdc->SelectObject(&brPushed);
	//	clrTopLeft = RGB(255,255,255);      // normal state
	//	clrBottomRight = ::GetSysColor(COLOR_3DSHADOW); 
	//	pdc->SetTextColor(m_clrTextHighlight); 
		
	// Draw the buttons

	pdc->Rectangle(&rcDefault);
	pdc->Draw3dRect(&rcDefault,clrTopLeft,clrBottomRight);   
   
	pdc->DrawText(strText,&rcText, DT_SINGLELINE|DT_VCENTER|DT_CENTER);

	// Reset text color
	pdc->SetTextColor(clrOld);
   
	// Reset objects
	pdc->SelectObject(pOldFont);
	pdc->SelectObject(pbrOld);   
	pdc->SetBkMode(OPAQUE);  

	delete pdc;
}

void CDxButton::ButtonRefresh()
{
	Invalidate();
}

void CDxButton::SetColorFace(COLORREF clrFace, BOOL bReraw)
{
	m_clrFace = clrFace;
	if (bReraw) Invalidate();

}

void CDxButton::SetColorButtonStyle(BOOL bStyle)
{
	m_bColorStyle = bStyle;
}
