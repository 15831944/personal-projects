// LineColor.h: interface for the CLineColor class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_LINECOLOR_H__2E2894F9_B224_439C_A263_6F7DC9973E8D__INCLUDED_)
#define AFX_LINECOLOR_H__2E2894F9_B224_439C_A263_6F7DC9973E8D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#undef _WINDOWS_
#include <afxwin.h>
#include <afxtempl.h>
#include "ShiftReg.h"

class CLineColor : public CObject  
{
public:
	void SetPixel(int bit,const COLORREF& clrBit);
	COLORREF GetPixel(int bit);
	CLineColor();
	virtual ~CLineColor();
	CShiftReg *m_pLineR, *m_pLineG, *m_pLineB;
};

typedef CTypedPtrArray<CObArray, CLineColor*> LINE_LIST;

#endif // !defined(AFX_LINECOLOR_H__2E2894F9_B224_439C_A263_6F7DC9973E8D__INCLUDED_)
