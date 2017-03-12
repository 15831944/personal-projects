// FontEditor.h: interface for the CFontEditor class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_FONTEDITOR_H__56F65AFC_1987_4A89_8CE2_AEE04D2E0860__INCLUDED_)
#define AFX_FONTEDITOR_H__56F65AFC_1987_4A89_8CE2_AEE04D2E0860__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "3iMatrixEdit.h"

class CFontEditor : public C3iMatrixEdit  
{
public:
	UINT GetCharWidth();
	void SetCharWidth(UINT nWidth);
	void InitDefaultCharMap();
	void SelectCharacter(int nChar);
	CFontEditor();
	void LoadFont(LPCTSTR szFile);
	void SaveFont(LPCTSTR szFile);
	virtual ~CFontEditor();
protected:
	UINT m_nCharacter;
	virtual BOOL OnSetPixel(UINT nFlags, int x, int y);
	virtual BOOL InitLineList(LINE_LIST *pLineList);
	virtual void OnProcessBuffer(PBYTE pBuffer, int nSize, int nColor, int cx, int cy);
	virtual CPoint OnChangePosition(int x, int y);
};

#endif // !defined(AFX_FONTEDITOR_H__56F65AFC_1987_4A89_8CE2_AEE04D2E0860__INCLUDED_)
