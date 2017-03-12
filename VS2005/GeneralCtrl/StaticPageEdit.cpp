// StaticPageEdit.cpp : implementation file
//

#include "stdafx.h"
#include "StaticPageEdit.h"


// CStaticPageEdit

IMPLEMENT_DYNAMIC(CStaticPageEdit, CStaticEdit)

CStaticPageEdit::CStaticPageEdit()
{
	m_nCurPage = 0;
}

CStaticPageEdit::~CStaticPageEdit()
{
}


BEGIN_MESSAGE_MAP(CStaticPageEdit, CStaticEdit)
	ON_WM_CREATE()
END_MESSAGE_MAP()



// CStaticPageEdit message handlers

void CStaticPageEdit::InitControl(HWND hWndMsg)
{
	CStaticEdit::InitControl(hWndMsg);
}

int CStaticPageEdit::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CStaticEdit::OnCreate(lpCreateStruct) == -1)
		return -1;
		
	return 0;
}


void CStaticPageEdit::SetCurrentPage(int nPage, BOOL bUpdate)
{
	if (nPage >= MAX_PAGE){
		nPage = 0;
	}
	m_nCurPage = nPage;
	if (bUpdate){
		CStaticEdit::SetText(m_csPageText[nPage]);
	}
}

void CStaticPageEdit::SetText(LPCTSTR lpszText)
{
	CStaticEdit::SetText(lpszText);
	m_csPageText[m_nCurPage] = lpszText;
}

void CStaticPageEdit::GetText(CString& csText)
{	
	CStaticEdit::GetText(csText);
}

void CStaticPageEdit::GetPageText(CString& csText, int nPage)
{
	if (nPage >= MAX_PAGE){
		nPage = 0;
	}
	csText = m_csPageText[nPage];
}

void CStaticPageEdit::SetPageText(LPCTSTR lpszText, int nPage)
{
	if (nPage >= MAX_PAGE){
		nPage = 0;
	}
	m_csPageText[nPage] = lpszText;
}