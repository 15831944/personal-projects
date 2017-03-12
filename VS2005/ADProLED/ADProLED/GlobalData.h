// GlobalData.h: interface for the CGlobalData class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GLOBALDATA_H__34B05F17_C74F_4951_B15E_869F24ABD201__INCLUDED_)
#define AFX_GLOBALDATA_H__34B05F17_C74F_4951_B15E_869F24ABD201__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CGlobalData : public CObject  
{
public:
	COLORREF m_clrGrid;
	COLORREF m_clrBold;
	UINT m_nGridSize;
	UINT m_nBoldSize;
	COLORREF m_clrBkGnd;
	CGlobalData();
	virtual ~CGlobalData();

};

#endif // !defined(AFX_GLOBALDATA_H__34B05F17_C74F_4951_B15E_869F24ABD201__INCLUDED_)
