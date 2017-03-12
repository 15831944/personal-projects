#include "LEDPageEdit.h"
// LEDPageEdit.cpp : implementation file
//

#include "stdafx.h"
#include "LEDPageEdit.h"


// CLEDPageEdit

IMPLEMENT_DYNAMIC(CLEDPageEdit, CLEDEdit)

CLEDPageEdit::CLEDPageEdit()
{
	m_nCurPage = 0;
}

CLEDPageEdit::~CLEDPageEdit()
{
}


BEGIN_MESSAGE_MAP(CLEDPageEdit, CLEDEdit)
END_MESSAGE_MAP()



// CLEDPageEdit message handlers

void CLEDPageEdit::SetCurrentPage(int nPage, BOOL bUpdate)
{
	if (nPage >= MAX_PAGE){
		nPage = 0;
	}	
	m_nCurPage = nPage;	
	if (bUpdate){
		CLEDEdit::SetText(m_csPageText[nPage]);
	}		
}


void CLEDPageEdit::GetText(CString &csText)
{	
	CLEDEdit::GetText(csText);
}

void CLEDPageEdit::SetText(LPCTSTR lpszText)
{
	CLEDEdit::SetText(lpszText);
	m_csPageText[m_nCurPage] = lpszText;
}
void CLEDPageEdit::GetPageText(CString& csText, int nPage)
{
	if (nPage >= MAX_PAGE){
		nPage = 0;
	}
	csText = m_csPageText[nPage];
}

void CLEDPageEdit::SetPageText(LPCTSTR lpszText, int nPage)
{
	if (nPage >= MAX_PAGE){
		nPage = 0;
	}
	m_csPageText[nPage] = lpszText;
}