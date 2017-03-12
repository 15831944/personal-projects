// GlobalData.h: interface for the CGlobalData class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GLOBALDATA_H__34B05F17_C74F_4951_B15E_869F24ABD201__INCLUDED_)
#define AFX_GLOBALDATA_H__34B05F17_C74F_4951_B15E_869F24ABD201__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define		MODE_COMPORT		0
#define		MODE_ETHERNET		1

class CGlobalData : public CObject  
{
public:
	COLORREF m_clrGrid;
	UINT m_nGridSize;
	COLORREF m_clrBkGnd;
	UINT m_nCurrentPage;
	UINT m_nShowTime;
	CGlobalData();
	int m_nMode;
	CString m_csClientIp;
	UINT m_nClientPort;
	UINT m_nServerPort;
	virtual ~CGlobalData();

};

#endif // !defined(AFX_GLOBALDATA_H__34B05F17_C74F_4951_B15E_869F24ABD201__INCLUDED_)
