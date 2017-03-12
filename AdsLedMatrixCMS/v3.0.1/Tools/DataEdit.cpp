// DataEdit.cpp : implementation file
//

#include "stdafx.h"
#include "DataEdit.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDataEdit

CDataEdit::CDataEdit()
{
}

CDataEdit::~CDataEdit()
{
}


BEGIN_MESSAGE_MAP(CDataEdit, CEdit)
	//{{AFX_MSG_MAP(CDataEdit)
	ON_WM_CTLCOLOR_REFLECT()
	ON_WM_CREATE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDataEdit message handlers

HBRUSH CDataEdit::CtlColor(CDC* pDC, UINT nCtlColor) 
{	

	return HBRUSH(NULL);
}

int CDataEdit::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CEdit::OnCreate(lpCreateStruct) == -1)
		return -1;		

	// older versions of Windows* (NT 3.51 for instance)
	// fail with DEFAULT_GUI_FONT
	if (!m_font.CreateStockObject(DEFAULT_GUI_FONT))
		if (!m_font.CreatePointFont(80, _T("MS Sans Serif")))
			return -1;
	this->SetFont(&m_font);

	return 0;
}


