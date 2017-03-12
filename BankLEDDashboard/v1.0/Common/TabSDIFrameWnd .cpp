/**********************************************************************
**
**	TabSDIFrameWnd.cpp : implementation file of CTabSDIFrameWnd class
**
**	by Andrzej Markowski July 2005
**
**********************************************************************/

#include "stdafx.h"
#include "TabSDIFrameWnd.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CTabSDIFrameWnd

IMPLEMENT_DYNCREATE(CTabSDIFrameWnd, CFrameWnd)

CTabSDIFrameWnd::CTabSDIFrameWnd()
{
}

CTabSDIFrameWnd::~CTabSDIFrameWnd()
{
}


BEGIN_MESSAGE_MAP(CTabSDIFrameWnd, CFrameWnd)
	//{{AFX_MSG_MAP(CTabSDIFrameWnd)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
	ON_NOTIFY(CTCN_SELCHANGE, IDC_TABCTRL, OnSelchangeTabctrl)
	ON_NOTIFY(CTCN_CLICK, IDC_TABCTRL, OnClickTabctrl)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTabSDIFrameWnd message handlers

void CTabSDIFrameWnd::OnSelchangeTabctrl(NMHDR* pNMHDR, LRESULT* pResult) 
{	
	*pResult = 0;
}

void CTabSDIFrameWnd::OnClickTabctrl(NMHDR* pNMHDR, LRESULT* pResult) 
{
	if(((CTC_NMHDR*)pNMHDR)->nItem==CTCHT_ONCLOSEBUTTON){
	}
	*pResult = 0;
}
