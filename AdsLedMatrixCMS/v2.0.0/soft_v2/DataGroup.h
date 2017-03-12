#if !defined(AFX_DATAGROUP_H__8C2A4CB1_29D2_4547_BCF3_5856611087E8__INCLUDED_)
#define AFX_DATAGROUP_H__8C2A4CB1_29D2_4547_BCF3_5856611087E8__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DataGroup.h : header file
//
#include "datastatic.h"
/////////////////////////////////////////////////////////////////////////////
// CDataGroup window

class CDataGroup : public CStatic
{
// Construction
public:
	CDataGroup();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDataGroup)
	//}}AFX_VIRTUAL

// Implementation
public:
	BOOL SetItemMode(int nIndex, int nMode);
	int GetItemIndex(int item);
	CDataStatic** GetDataObject();
	int GetItemCount();
	void SetColorSelectable(BOOL bEnable);
	void SetUniformOnOffMode(BOOL bUniform);
	void SetUniformOnOff(BOOL bOnOff);
	BOOL EnableWindow(BOOL bEnable);
	void SetUniformColor(COLORREF clr);
	int GetItemMode(int nIndex);
	BOOL m_bUniformColor;
	BOOL m_bUniformOnOff;
	void SetUniformColorMode(BOOL bUniform=TRUE);
	void SetAllItemColor(COLORREF clrText,BOOL bUniform=FALSE);
	BOOL SetItemColor(int nIndex, COLORREF clrText);
	BOOL GetItemColor(int nIndex,COLORREF& clrText);
	BOOL SetItemText(int nIndex, char *szText, UINT nSize);
	BOOL GetItemText(int nIndex,char* szText, UINT nSize);
	void SetAllItemText(LPCTSTR szText);
	void GetTextSequence(CString& csData);
	void SetTitleBkColor(COLORREF clrBk);
	void SetItemFont(LPCTSTR szName, UINT nSize);
	void SetTitleFont(LPCTSTR szName, UINT nSize);
	void SetBkColorItem(COLORREF clrItemBk);
	void SetTitleColor(COLORREF clrTitle);
	void Init(int nIndex, int nCount,UINT nStyle=0,HWND hMsg = NULL);
	void SetBkColor(COLORREF clrBk);
	virtual ~CDataGroup();

	// Generated message map functions
protected:
	CDataStatic** m_pDataStatic;
	CDataStatic* m_pTitleStatic;
	//{{AFX_MSG(CDataGroup)
	afx_msg HBRUSH CtlColor(CDC* pDC, UINT nCtlColor);
	afx_msg void OnDestroy();
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	int m_nIndex;
	int m_nCount;
	COLORREF m_clrText;
	COLORREF m_clrBk;
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DATAGROUP_H__8C2A4CB1_29D2_4547_BCF3_5856611087E8__INCLUDED_)
