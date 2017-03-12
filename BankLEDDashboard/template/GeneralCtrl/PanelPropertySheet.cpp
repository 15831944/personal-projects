// PanelPropertySheet.cpp : implementation file
//

#include "stdafx.h"
#include "resource.h"
#include "PanelPropertySheet.h"

#ifdef _DEBUG
#undef THIS_FILE
static char BASED_CODE THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CPanelPropertySheet

IMPLEMENT_DYNAMIC(CPanelPropertySheet, CPropertySheet)

CPanelPropertySheet::CPanelPropertySheet(CWnd* pWndParent)
	 : CPropertySheet(IDS_PROPSHT_CAPTION, pWndParent)
{
	// Add all of the property pages here.  Note that
	// the order that they appear in here will be
	// the order they appear in on screen.  By default,
	// the first page of the set is the active one.
	// One way to make a different property page the 
	// active one is to call SetActivePage().
	
	// CUONGDD move AddPage() to parent
}

CPanelPropertySheet::~CPanelPropertySheet()
{
}


BEGIN_MESSAGE_MAP(CPanelPropertySheet, CPropertySheet)
	//{{AFX_MSG_MAP(CPanelPropertySheet)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()


/////////////////////////////////////////////////////////////////////////////
// CPanelPropertySheet message handlers

BOOL CPanelPropertySheet::OnInitDialog()
{
	BOOL bResult = CPropertySheet::OnInitDialog();

	// add a preview window to the property sheet.
	CRect rectWnd;
	GetWindowRect(rectWnd);
	SetWindowPos(NULL, 0, 0,
		rectWnd.Width() + 100,
		rectWnd.Height(),
		SWP_NOMOVE | SWP_NOZORDER | SWP_NOACTIVATE);

	CRect rectPreview(rectWnd.Width() + 5, 0,
		rectWnd.Width() + 125, 295);

	m_wndPreview.Create(NULL, NULL, WS_CHILD|WS_VISIBLE,
		rectPreview, this, 0x1000);
		
	CenterWindow();

	return bResult;
}

void CPanelPropertySheet::PostNcDestroy()
{
	CPropertySheet::PostNcDestroy();
	delete this;
}


