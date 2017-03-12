// MatrixPageEdit.cpp : implementation file
//

#include "stdafx.h"
#include "MatrixPageEdit.h"


// CMatrixPageEdit

IMPLEMENT_DYNAMIC(CMatrixPageEdit, CMatrixEdit)

CMatrixPageEdit::CMatrixPageEdit()
{
	m_nCurPage = 0;
}

CMatrixPageEdit::~CMatrixPageEdit()
{
}


BEGIN_MESSAGE_MAP(CMatrixPageEdit, CMatrixEdit)
END_MESSAGE_MAP()



// CMatrixPageEdit message handlers

void CMatrixPageEdit::SetCurrentPage(int nPage, BOOL bUpdate)
{
	if (nPage >= MAX_PAGE){
		nPage = 0;
	}
	m_nCurPage = nPage;
	if (bUpdate){
		CMatrixEdit::SetText(m_csPageText[nPage]);
	}
}


void CMatrixPageEdit::GetText(CString &csText)
{
	CMatrixEdit::GetText(csText);
}

void CMatrixPageEdit::SetText(LPCTSTR lpszText)
{
	CMatrixEdit::SetText(lpszText);
	m_csPageText[m_nCurPage] = lpszText;
}

void CMatrixPageEdit::GetPageText(CString& csText, int nPage)
{
	if (nPage >= MAX_PAGE){
		nPage = 0;
	}
	csText = m_csPageText[nPage];
}

void CMatrixPageEdit::SetPageText(LPCTSTR lpszText, int nPage)
{
	if (nPage >= MAX_PAGE){
		nPage = 0;
	}
	m_csPageText[nPage] = lpszText;
}