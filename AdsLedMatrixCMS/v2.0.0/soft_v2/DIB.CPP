// Dib.cpp : Defines the initialization routines for the DLL.
//

#include "stdafx.h"
#include "Dib.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif


//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

// First two bytes of bitmap file should be "BM" 

const BITMAP_TYPE = (WORD)('M' << 8) | 'B'; 

CDib::CDib() 
{ 
	m_pbmih = NULL; 
	m_hdd = NULL; 
} 


CDib::~CDib() 
{ 
	DeleteObject(); 
} 

BOOL CDib::Load(LPCTSTR szPathName)
{
	m_strFilename = szPathName;

	CFile file(szPathName,CFile::modeRead);

	BITMAPFILEHEADER hdr; 

	DWORD len = file.Read(&hdr, sizeof(hdr)); 

	if ((len!=sizeof(hdr)) || (hdr.bfType != BITMAP_TYPE)) 
	{ 

		TRACE0("***CDib: bad BITMAPFILEHEADER\n"); 

		return FALSE; 

	} 

	len = file.GetLength() - len; 

	m_pbmih = (BITMAPINFOHEADER*) new char[len]; 

	file.Read(m_pbmih, len); 
	
	return TRUE;

}

// Common function to delete stuff 

void CDib::DeleteObject() 
{ 
	if (m_hdd) 
	{ 
		DrawDibClose(m_hdd); 
		m_hdd = NULL; 
	} 

	if (m_pbmih) 
	{ 
		delete [] (char*)m_pbmih; 
		m_pbmih = NULL; 
	} 
} 

// Get number of palette colors 

UINT CDib::GetNumPaletteColors() 
{ 
	UINT nColors=m_pbmih->biClrUsed; 
	if (nColors==0 && m_pbmih->biBitCount<=8) 
	nColors = 1<<m_pbmih->biBitCount; 
	return nColors; 
} 


////////////////// 
// Get ptr to actual bits. 
// 

LPBYTE CDib::GetBits() 
{ 
	return (LPBYTE)m_pbmih + m_pbmih->biSize 
		+ GetNumPaletteColors()*sizeof(RGBQUAD); 
} 


//////////////////////////////////////////////////////////////// 

// Draw routine for a DIB on caller's DC. Like above, but 

// caller can specify source and destination rectangles. 

// Use Video for Windows DrawDIB API to do the work. 

// 

BOOL CDib::Draw(CDC *pdc, const CRect* rcDst, const CRect* rcSrc) 
{ 
	if (!m_pbmih) 
		return FALSE; 

	if (!m_hdd) 
		VERIFY(m_hdd = DrawDibOpen()); 

	CRect rc; 

	if (!rcSrc) 
	{ 
	// if no source rect, use whole bitmap 
		rc.SetRect(0, 0, m_pbmih->biWidth, m_pbmih->biHeight); 
		rcSrc=&rc; 

	} 

	if (!rcDst) rcDst=rcSrc; 

	// This is as easy as it gets in Windows. 

	return DrawDibDraw(m_hdd, 
					*pdc, 
					rcDst->left,
					rcDst->top, 
					rcDst->Width(),
					rcDst->Height(), 
					m_pbmih, 
					GetBits(), 
					rcSrc->left,
					rcSrc->top,
					rcSrc->Width(), 
					rcSrc->Height(), 
					0); 

} 

CSize CDib::GetSize() const
{
	return CSize(m_pbmih->biWidth,m_pbmih->biHeight);
}

void CDib::Draw(CDC *pDC, const CRect &rcDest)
{
	CSize size = GetSize();
	this->Draw(pDC,&rcDest,&CRect(0,0,size.cx,size.cy));
}

CString CDib::GetFileName()
{
	return m_strFilename;
}
