// Dib.h: interface for the CDib class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_DIB_H__06C02D31_17C3_49FD_AE98_022A6CDEC1BD__INCLUDED_)
#define AFX_DIB_H__06C02D31_17C3_49FD_AE98_022A6CDEC1BD__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "Vfw.h"

#pragma comment(lib,"Vfw32")

class CDib  
{
public:
	CString GetFileName();
	void Draw(CDC*pDC,const CRect& rcDest);
	CSize GetSize()const;
	CDib();
	BOOL Load(LPCTSTR szPathName); 
	BOOL Draw(CDC *pdc, const CRect* rcDst, const CRect* rcSrc) ; 

	virtual ~CDib();
private:
	CString m_strFilename;
	HDRAWDIB m_hdd;
	BITMAPINFOHEADER *m_pbmih;
	LPBYTE GetBits();
	UINT GetNumPaletteColors();
	void DeleteObject() ;
};

#endif // !defined(AFX_DIB_H__06C02D31_17C3_49FD_AE98_022A6CDEC1BD__INCLUDED_)
