// MatrixPreview.h: interface for the CMatrixPreview class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_MATRIXPREVIEW_H__B15A632B_C317_46DF_A551_5FD842D08744__INCLUDED_)
#define AFX_MATRIXPREVIEW_H__B15A632B_C317_46DF_A551_5FD842D08744__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "3iMatrix.h"

class CMatrixPreview : public C3iMatrix  
{
public:
	void ClearScreen();
	void LoadText(LPCTSTR lpszPreviewText);
	CMatrixPreview();
	virtual ~CMatrixPreview();
protected:
	virtual void SetPixel(int x, int y, COLORREF clr);
	void PutChar(UINT nPos,BYTE ch);
	virtual BOOL InitLineList(LINE_LIST *pLineList);
	virtual void OnProcessBuffer(PBYTE pBuffer, int nSize, int nColor, int cx, int cy);
	virtual CPoint OnChangePosition(int x, int y);
};

#endif // !defined(AFX_MATRIXPREVIEW_H__B15A632B_C317_46DF_A551_5FD842D08744__INCLUDED_)
