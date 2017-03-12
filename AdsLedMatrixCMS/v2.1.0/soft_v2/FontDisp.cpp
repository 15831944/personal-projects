// CFontDisp.cpp : implementation file
//

#include "stdafx.h"
#include "MATRIX.h"
#include "FontDisp.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern CGeneralSettings __SETTING;
FONT_CHAR char_map[256];	
BOOL CALLBACK EnumFamCallBack(LPLOGFONT lplf, LPNEWTEXTMETRIC lpntm, DWORD FontType, LPVOID lParam);
/////////////////////////////////////////////////////////////////////////////
// CFontDisp

CFontDisp::CFontDisp()
{
	memset(&m_logfont, 0, sizeof(LOGFONT));			// zero out structure			
	m_logfont.lfHeight = 22;				  			//  size
	m_logfont.lfWeight	= FW_BOLD;					
	m_logfont.lfQuality= ANTIALIASED_QUALITY;				
#ifdef _UNICODE		
	wcscpy((LPTSTR)(m_logfont.lfFaceName), _T(".VnTime"));     // request a face name 
#else
	strcpy((LPTSTR)(m_logfont.lfFaceName), _T(".VnTime"));     // request a face name 
#endif
	m_szMaxSize = CSize(32,32);
	
}

CFontDisp::~CFontDisp()
{
}


BEGIN_MESSAGE_MAP(CFontDisp, CStatic)
	//{{AFX_MSG_MAP(CFontDisp)
	ON_WM_PAINT()
	ON_BN_CLICKED(IDC_STATIC_FONT, OnStaticFont)
	ON_WM_CREATE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFontDisp message handlers

void CFontDisp::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
	
	CRect rect;
	GetClientRect(&rect);
	CDC* pDC = (CDC*)&dc;
	
	CPen pen(PS_NULL,1,RGB(0,0,0));

	CPen* pPen = pDC->SelectObject(&pen);

	pDC->Rectangle(rect);

	rect.DeflateRect(2,2);
	
	CFont font;
	VERIFY(font.CreateFontIndirect(&m_logfont));		// create the font
		
	CFont* pOldFont = pDC->SelectObject(&font);	
	
	CRect rc = rect;

	pDC->SelectObject(pPen);
	pDC->SelectObject(pOldFont);
}

void CFontDisp::OnStaticFont() 
{
#if 0	
	m_logfont.lfHeight = 36;
	wcscpy(m_logfont.lfFaceName,_T(""));
	m_logfont.lfPitchAndFamily = 0;
    EnumFontFamiliesEx(GetDC()->m_hDC, &m_logfont, (FONTENUMPROC) EnumFamCallBack, (LPARAM) this,0); 
#endif
}


int CFontDisp::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CStatic::OnCreate(lpCreateStruct) == -1)
		return -1;
	ReCalcLayout();
	return 0;
}

void CFontDisp::ShowFontDialog()
{
	this->OnStaticFont();
	this->Invalidate(FALSE);
}

void CFontDisp::DoConvert(LPLOGFONT lplf)
{
	CClientDC dc(this); // device context for painting
	
	CRect rect;
	GetClientRect(&rect);
	CDC* pDC = (CDC*)&dc;
	
	CPen pen(PS_NULL,1,RGB(0,0,0));

	CPen* pPen = pDC->SelectObject(&pen);

	pDC->Rectangle(rect);	
	
	CFont font;	
	VERIFY(font.CreateFontIndirect(lplf));		// create the font
		
	CFont* pOldFont = pDC->SelectObject(&font);	
	
	CRect rcText = rect;
	rcText.DeflateRect(2,2);

	for (int c = 0; c< 255;c++)
	{
		pDC->Rectangle(rect);		
		CString str = c;		

		pDC->DrawText(str,CRect(rcText),DT_SINGLELINE);			
		Invalidate();
		Sleep(10);
		CaptureFont(pDC,c);
	}

	pDC->SelectObject(pPen);
	pDC->SelectObject(pOldFont);
}

void CFontDisp::CaptureFont(CDC *pDC, int c)
{	
	CWnd* pWnd = this;//CWnd::GetDesktopWindow(); 
	CBitmap 	bitmap;
	CClientDC	dc(pWnd);
	CDC 		memDC;
	CRect		rect;
	
	this->GetClientRect(&rect);
	rect.DeflateRect(2,2);
	memDC.CreateCompatibleDC(&dc); 	

	CSize sz = pDC->GetTextExtent(c);
		
	ABC abc;
	pDC->GetCharABCWidths(c,c,&abc);

	if (m_logfont.lfItalic)
	{
		if (c != ' ')
			sz.cx += abc.abcC + ((c=='P')?2:0);
	}

	if (sz.cy > HEIGHT) sz.cy = HEIGHT;		
	if (sz.cx > WIDTH) sz.cx = WIDTH;	

	char_map[int(c)].heigth = sz.cy;
	char_map[int(c)].width = sz.cx;		

	bitmap.CreateCompatibleBitmap(&dc, sz.cx, sz.cy );
	
	CBitmap* pOldBitmap = memDC.SelectObject(&bitmap);
	memDC.BitBlt(0, 0, sz.cx, sz.cy, &dc, 2+ (m_logfont.lfItalic?abc.abcA:0), 2, SRCCOPY); 	

#if 0
	CBrush br(RGB(0,0,0));
	CBrush* pBr = pDC->SelectObject(&br);
	pDC->Rectangle(2,2,sz.cx+2,sz.cy+2);
	pDC->SelectObject(pBr);
	Invalidate();Sleep(500);
#endif

	for (int x = 0; x < sz.cx; x++)
	{
		for (int y = 0; y < sz.cy; y++)
		{
			COLORREF clr = memDC.GetPixel(x,y);
			char_map[int(c)].pdata[x][y] = (clr==RGB(255,255,255))?0:1;
		}
	}

	memDC.SelectObject(pOldBitmap);
}

void CFontDisp::ReCalcLayout()
{
	SetWindowPos(NULL,0,0,m_szMaxSize.cx,m_szMaxSize.cy,SWP_NOMOVE);		
}

void CFontDisp::SaveToFile(LPCTSTR szFile)
{
#ifdef __OLD_VER_SAVE_FONT
	CFile file(szFile,CFile::modeCreate|CFile::modeWrite);
	CArchive ar(&file,CArchive::store);
	for (int i = 0; i < 256; i++)
	{
		ar<<char_map[i].heigth<<char_map[i].width;
		for (int x = 0; x < char_map[i].width; x++)
		{
			for (int y = 0; y < char_map[i].heigth; y++)
			{
				ar<<char_map[i].pdata[x][y];
			}
		}
	}
	ar.Close();
	file.Close();
#else
	this->CompressFont(szFile);
#endif
}

void CFontDisp::Clear()
{
	for (int i=0;i<256;i++)		
		for (int x=0;x<HEIGHT;x++)
			for (int y=0;y<WIDTH;y++)
				char_map[i].pdata[x][y] = 0;
}

#include <math.h>
BOOL CFontDisp::DoFontDlg()
{
					
	CClientDC dc(NULL);
	LOGFONT lf = m_logfont;
	lf.lfHeight = -::MulDiv(-lf.lfHeight, dc.GetDeviceCaps(LOGPIXELSY), 72);
	CFontDialog dlg(&lf);	
	if (dlg.DoModal() == IDOK)
	{
		lf.lfHeight = ::MulDiv(-lf.lfHeight, 72, dc.GetDeviceCaps(LOGPIXELSY));				

		m_logfont = lf;	
		CFont font;
		VERIFY(font.CreateFontIndirect(&m_logfont));		// create the font
		
		CFont* pOldFont = dc.SelectObject(&font);	
		
		TEXTMETRIC metric = {0};
		dc.GetTextMetrics(&metric);
		CSize sz = CSize(metric.tmMaxCharWidth,metric.tmHeight);
		int nItalic = (m_logfont.lfItalic)?sz.cy/3:0;
		m_szMaxSize.cx = sz.cx + 10 + nItalic;		
		m_szMaxSize.cy = sz.cy + 10;
		dc.SelectObject(pOldFont);
						
		m_csFontName.Format(_T("%s_%d"),
			dlg.GetFaceName(),
			lf.lfHeight);

		if (dlg.IsBold())
			m_csFontName += _T("_B");
		if (dlg.IsItalic())
			m_csFontName += _T("_I");
		
		m_csFontPath = __SETTING.m_csFontPath;
		m_csFontPath += _T("\\Fonts");
		CreateDirectory(m_csFontPath,NULL);

		m_csFontPath += _T("\\") + m_csFontName;

		ReCalcLayout();

		this->RedrawWindow();
		CFile file;
		if (!file.Open(m_csFontPath,CFile::modeRead))
		{
			this->DoConvert(&lf);
			this->SaveToFile(m_csFontPath);
		}
		else
		{
			file.Close();
			DecompressFont(m_csFontPath);			
		}		

		return TRUE;
	}

	return FALSE;
}

BOOL CALLBACK EnumFamCallBack(LPLOGFONT lplf, LPNEWTEXTMETRIC lpntm, DWORD FontType, LPVOID lParam) 
{ 
    CFontDisp* pFontDisp = (CFontDisp*) lParam; 	
		
	pFontDisp->DoConvert(lplf);

	TCHAR szDir[MAX_PATH];
	GetCurrentDirectory(sizeof(szDir),szDir);
	CString csDir = szDir;
	csDir += _T("\\Fonts");
	CreateDirectory(csDir,NULL);

	CString csFaceName = _T("");

	lplf->lfHeight = ::MulDiv(lplf->lfHeight, 72, (pFontDisp->GetDC())->GetDeviceCaps(LOGPIXELSY));

	csFaceName.Format(_T("%s_d"),lplf->lfFaceName,lplf->lfHeight);		

	if (lplf->lfWeight == FW_BOLD)
		csFaceName += _T("_B");		
	if (lplf->lfItalic == TRUE)
		csFaceName += _T("_I");	
	TRACE(_T("\n %s"),csFaceName);
	
	
	pFontDisp->SaveToFile(csDir+_T("\\")+csFaceName);

	return TRUE;

    UNREFERENCED_PARAMETER( lpntm ); 
} 

void CFontDisp::CompressFont(LPCTSTR szFile)
{
	BYTE dim[256][2];
	BYTE buffer[32*4*256];
	memset(buffer,0x00,sizeof(buffer));
	for (int i=0; i< 256; i++)
	{
		for (int x=0; x< 32; x++)
		{
			for (int y=0; y < 32; y++)
			{
				if (char_map[i].pdata[y][x])
					buffer[y + (x/8)*32 + i*128] |= 1<<(x%8);
				else
					buffer[y + (x/8)*32 + i*128] &= ~(1<<(x%8));				
			}
		}

		dim[i][0] = char_map[i].heigth;
		dim[i][1] = char_map[i].width ;
	}
	

	CFile file(szFile,CFile::modeCreate|CFile::modeWrite);
	file.WriteHuge(buffer,sizeof(buffer));
	file.SeekToBegin();
	file.Write(dim,sizeof(dim));
	file.Close();
}

void CFontDisp::DecompressFont(LPCTSTR szFile)
{
	BYTE dim[256][2];
	BYTE buffer[32*4*256];
	memset(buffer,0x00,sizeof(buffer));

	CFile file(szFile,CFile::modeRead);
	file.ReadHuge(buffer,sizeof(buffer));
	file.SeekToBegin();
	file.Read(dim,sizeof(dim));
	file.Close();
	
	for (int i=0; i< 256; i++)
	{
		for (int x=0; x< 32; x++)
		{
			for (int y=0; y < 32; y++)
			{
				if (buffer[y + (x/8)*32 + i*128] & (1<<(x%8)))
					char_map[i].pdata[y][x] = 1;
				else
					char_map[i].pdata[y][x] = 0;
			}
		}
		char_map[i].heigth = dim[i][0];		
		char_map[i].width  = dim[i][1];		
	}

}

CString& CFontDisp::GetFontName()
{
	return m_csFontName;
}

CString& CFontDisp::GetFontPath()
{
	return m_csFontPath;
}

void CFontDisp::LoadFont(LPCTSTR szFontName)
{
	this->DecompressFont(szFontName);
}
