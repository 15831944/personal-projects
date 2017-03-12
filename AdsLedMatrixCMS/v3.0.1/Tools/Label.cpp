// Label.cpp : implementation file
//

#include "stdafx.h"
#include "Label.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#ifdef _UNICODE
#define	strcpy	wcscpy
#endif
/////////////////////////////////////////////////////////////////////////////
// CLabel

CLabel::CLabel()
{	 
	m_nHeight = 14;		
	m_nStyle  = LS_CAPTION;
	m_clrText = RGB(0,0,255);
	m_bHighlight = FALSE;
	m_strFontFace = _T("Microsoft Sans Serif");
}

CLabel::~CLabel()
{
}


BEGIN_MESSAGE_MAP(CLabel, CStatic)
	//{{AFX_MSG_MAP(CLabel)
	ON_WM_PAINT()
	ON_WM_CTLCOLOR_REFLECT()	
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLabel message handlers

void CLabel::OnPaint() 
{
	if (m_nStyle == LS_LABEL)	
	{
		CStatic::OnPaint();
		// act as default
		return;
	}

	CPaintDC dc(this); // device context for painting		

	CFont Font;

	CRect rc;
	GetClientRect(&rc);

	CString strText = _T("");
	GetWindowText(strText);

	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));			// zero out structure
		
	lf.lfHeight = m_nHeight;

	lf.lfQuality = ANTIALIASED_QUALITY;	
	lf.lfItalic = FALSE;
	lf.lfWeight	= FW_BOLD;		
	lf.lfUnderline = FALSE;
	lf.lfQuality= ANTIALIASED_QUALITY;	

	strcpy(lf.lfFaceName, m_strFontFace);        // request a face name 
	VERIFY(Font.CreateFontIndirect(&lf));		// create the font
		
	CFont * pOldFont = dc.SelectObject(&Font);	

	dc.SetBkMode(TRANSPARENT);
	dc.SetTextColor(RGB(255,250,250));
	dc.DrawText(strText,&rc, DT_VCENTER);
	
	rc.DeflateRect(-1,-1);

	dc.SetTextColor(RGB(100,100,100));
	dc.DrawText(strText,&rc, DT_VCENTER);
	
	dc.SelectObject(pOldFont);
}

void CLabel::SetTextHight(int nHeight)
{
	m_nHeight = nHeight;
}

void CLabel::SetFontFace(LPCTSTR lpszFace)
{
	m_strFontFace = lpszFace;
}

void CLabel::SetStyle(UINT nStyle)
{
	m_nStyle = nStyle;
}

HBRUSH CLabel::CtlColor(CDC* pDC, UINT nCtlColor) 
{
	if (m_nStyle == LS_LABEL)
	{		
		if (m_bHighlight)
			pDC->SetTextColor(RGB(255,0,0));
		else
			pDC->SetTextColor(RGB(0,0,255));
			
		RedrawWindow();
	
	}
	

	return (HBRUSH)GetStockObject(NULL_BRUSH);
}


