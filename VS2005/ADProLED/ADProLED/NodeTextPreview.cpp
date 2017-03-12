// NodeTextPreview.cpp : implementation file
//

#include "stdafx.h"
#include "ADProLED.h"
#include "NodeTextPreview.h"


// CNodeTextPreview

IMPLEMENT_DYNAMIC(CNodeTextPreview, CStatic)

CNodeTextPreview::CNodeTextPreview()
: m_csText(_T(""))
{
	const int PointSize = 72;

	HDC hDC = ::GetDC(NULL);
	::ZeroMemory(& m_LogFont, sizeof(LOGFONT));
	m_LogFont.lfHeight = -::MulDiv(PointSize, ::GetDeviceCaps(hDC, LOGPIXELSY), 72);
	m_LogFont.lfWeight = FW_NORMAL;
	m_LogFont.lfOutPrecision = OUT_DEFAULT_PRECIS;
	m_LogFont.lfClipPrecision = CLIP_DEFAULT_PRECIS;
	m_LogFont.lfQuality = PROOF_QUALITY;
	m_LogFont.lfPitchAndFamily = FF_ROMAN;
	m_LogFont.lfCharSet = DEFAULT_CHARSET;
	_tcscpy_s(m_LogFont.lfFaceName, LF_FACESIZE,_T("Georgia"));
	::ReleaseDC(NULL, hDC);
}

CNodeTextPreview::~CNodeTextPreview()
{
}


BEGIN_MESSAGE_MAP(CNodeTextPreview, CStatic)
	ON_WM_PAINT()
END_MESSAGE_MAP()

// CNodeTextPreview message handlers

void CNodeTextPreview::OnPaint()
{
	CPaintDC dc(this); // device context for painting
	CDC* pDC = &dc;
	CRect rect;
	GetClientRect(rect);
	CBrush brush(RGB(0,0,0));
	CBrush brNode(RGB(250,250,250));
	CPen pen(PS_SOLID,1,RGB(250,250,250));				
	CBrush* brOld = pDC->SelectObject(&brush);	
	pDC->Rectangle(rect);	

	QGraphicsText gt;
	GraphicsPath path;
	gt.m_hWnd = m_hWnd;
	gt.SetFont(m_LogFont);	
	gt.SetNodeParams(m_nDistance, m_nNodeSize);
	gt.GetGraphicsText(path, m_csText, Point(0,0));	
	CPen* pOldPen = pDC->SelectObject(&pen);
	pDC->SelectObject(&brNode);	
	while (_arrPointF.GetSize()>0){
		PointF* pPoint = _arrPointF.GetAt(0);
		if (pPoint){			
			if (pPoint->X < (rect.right-m_nNodeSize) && pPoint->Y < (rect.bottom-m_nNodeSize)){
				pDC->Ellipse((int)pPoint->X,(int)pPoint->Y,(int)pPoint->X+m_nNodeSize,(int)pPoint->Y+m_nNodeSize);
			}
		}
		delete pPoint;
		_arrPointF.RemoveAt(0);		
	}	

	pDC->SelectObject(pOldPen);
	pDC->SelectObject(brOld);
}

void CNodeTextPreview::SetNodeParams(int nDistance, int nDrawSize)
{
	m_nDistance = nDistance;
	m_nNodeSize = nDrawSize;
}