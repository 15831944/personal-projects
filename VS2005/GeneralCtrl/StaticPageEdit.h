#pragma once

#include "StaticEdit.h"

// CStaticPageEdit

class AFX_EXT_CLASS CStaticPageEdit : public CStaticEdit
{
	DECLARE_DYNAMIC(CStaticPageEdit)

public:
	CStaticPageEdit();
	void SetCurrentPage(int nPage, BOOL bUpdate);
	virtual void GetPageText(CString& csText, int nPage);
	virtual void SetPageText(LPCTSTR lpszText, int nPage);
	void InitControl(HWND hWndMsg);
	virtual void GetText(CString& csText);
	virtual void SetText(LPCTSTR lpszText);
	virtual ~CStaticPageEdit();

protected:
	CString m_csPageText[MAX_PAGE];
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	DECLARE_MESSAGE_MAP()
private:
	int m_nCurPage;
};

typedef CTypedPtrArray<CPtrArray, CStaticPageEdit*> ARRAY_STATICPAGEEDIT;
