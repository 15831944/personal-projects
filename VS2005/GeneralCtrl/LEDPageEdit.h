#pragma once

#include "LEDEdit.h"
// CLEDPageEdit

class AFX_EXT_CLASS CLEDPageEdit : public CLEDEdit
{
	DECLARE_DYNAMIC(CLEDPageEdit)

public:
	CLEDPageEdit();
	void GetPageText(CString& csText, int nPage);
	virtual void SetPageText(LPCTSTR lpszText, int nPage);
	virtual void SetCurrentPage(int nPage, BOOL bUpdate);
	virtual void SetText(LPCTSTR lpszText);
	virtual void GetText(CString& csText);
	virtual ~CLEDPageEdit();

protected:
	CString m_csPageText[MAX_PAGE];
	DECLARE_MESSAGE_MAP()
private:
	int m_nCurPage;
private:
};

typedef CTypedPtrArray<CPtrArray, CLEDPageEdit*> ARRAY_LEDPAGEEDIT;
