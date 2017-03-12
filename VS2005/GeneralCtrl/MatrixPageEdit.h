#pragma once

#include "MatrixEdit.h"
// CMatrixPageEdit

class AFX_EXT_CLASS CMatrixPageEdit : public CMatrixEdit
{
	DECLARE_DYNAMIC(CMatrixPageEdit)

public:
	CMatrixPageEdit();
	void GetPageText(CString& csText, int nPage);
	virtual void SetPageText(LPCTSTR lpszText, int nPage);
	virtual void SetCurrentPage(int nPage, BOOL bUpdate);
	virtual void SetText(LPCTSTR lpszText);
	virtual void GetText(CString& csText);
	virtual ~CMatrixPageEdit();

protected:
	CString m_csPageText[MAX_PAGE];
	DECLARE_MESSAGE_MAP()
private:
	int m_nCurPage;
};

typedef CTypedPtrArray<CPtrArray, CMatrixPageEdit*> ARRAY_MATRIXPAGEEDIT;
