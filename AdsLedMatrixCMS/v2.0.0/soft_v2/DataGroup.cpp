// DataGroup.cpp : implementation file
//

#include "stdafx.h"
#include "BDT.h"
#include "DataGroup.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDataGroup

CDataGroup::CDataGroup()
{
	m_clrBk = RGB(180,180,180);
	m_clrText = RGB(255,0,0);
	m_pDataStatic = NULL;
	m_pTitleStatic = NULL;
	m_bUniformColor = FALSE;
	m_bUniformOnOff = FALSE;
}

CDataGroup::~CDataGroup()
{
	
}


BEGIN_MESSAGE_MAP(CDataGroup, CStatic)
	//{{AFX_MSG_MAP(CDataGroup)
	ON_WM_CTLCOLOR_REFLECT()
	ON_WM_DESTROY()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDataGroup message handlers

HBRUSH CDataGroup::CtlColor(CDC* pDC, UINT nCtlColor) 
{		
	CBrush brush(m_clrBk);
	pDC->SetTextColor(m_clrText);
	pDC->SetBkColor(m_clrBk);
	CRect rect;
	CBrush* brOld = pDC->SelectObject(&brush);
	GetWindowRect(&rect);
	pDC->Rectangle(&rect);	

	return HBRUSH(brush);
}

void CDataGroup::SetBkColor(COLORREF clrBk)
{
	m_clrBk = clrBk;
	this->Invalidate(FALSE);
}

void CDataGroup::Init(int nIndex, int nCount, UINT nStyle, HWND hMsg)
{
	m_nIndex = nIndex;
	m_nCount = nCount;
	int cy = 0;
	CRect rc;
	this->GetWindowRect(&rc);
	this->ScreenToClient(&rc);
	CRect rect = CRect(rc.left+1,rc.top+1,rc.right-1,rc.top -1 + 25);
	cy = 25;
	if (!m_pTitleStatic)
	{
		m_pTitleStatic = new CDataStatic();
		m_pTitleStatic->Create(_T("Static"),
				WS_CHILD|SS_NOTIFY|SS_CENTER|SS_CENTERIMAGE,
				rect,
				this);		
		m_pTitleStatic->Init(NULL);
		m_pTitleStatic->SetStyle(STYLE_STATIC);
		m_pTitleStatic->SetFont(_T(".VnTime"),18);
		CString csText;
		this->GetWindowText(csText);
		m_pTitleStatic->SetWindowText(csText);
		m_pTitleStatic->ShowWindow(SW_SHOW);
		m_pTitleStatic->UpdateWindow();
	}
	
	rect.OffsetRect(0,5);
	rect.bottom -= 5;	
	
	if (!m_pDataStatic)
	{
		m_pDataStatic = new CDataStatic*[nCount];
		for (int i=0; i< nCount; i++)
		{
			m_pDataStatic[i] = new CDataStatic();
			cy += 20;
			rect.OffsetRect(0,20);
			m_pDataStatic[i]->Create(NULL,
				WS_CHILD|SS_NOTIFY|SS_CENTER ,
				CRect(rect),this);					
			m_pDataStatic[i]->Init(hMsg);
			m_pDataStatic[i]->SetStyle(nStyle);
			m_pDataStatic[i]->m_nIndex = (nIndex + i);
			m_pDataStatic[i]->SetFont(_T(".VnTime"),16);
			m_pDataStatic[i]->ShowWindow(SW_SHOW);
			m_pDataStatic[i]->UpdateWindow();

			
		}
	}
	
	SetWindowPos(	NULL, -1, -1, rc.Width(), cy,
		SWP_NOMOVE | SWP_NOZORDER | SWP_NOREDRAW | SWP_NOACTIVATE);		
}

void CDataGroup::OnDestroy() 
{
	CStatic::OnDestroy();

	if (m_pTitleStatic)
	{
		m_pTitleStatic->DestroyWindow();
		delete m_pTitleStatic;
	}
	if (m_pDataStatic)
	{
		for (int i=0; i< m_nCount; i++)
		{
			if (m_pDataStatic[i])
			{
				m_pDataStatic[i]->DestroyWindow();
				delete m_pDataStatic[i];
			}
		}
		delete m_pDataStatic;
	}		
}

void CDataGroup::SetTitleColor(COLORREF clrTitle)
{
	if (m_pTitleStatic)
		m_pTitleStatic->SetColor(m_pTitleStatic->GetBkColor(),clrTitle);
}

void CDataGroup::SetBkColorItem(COLORREF clrItemBk)
{
	if (m_pDataStatic)
	{
		for (int i = 0; i< m_nCount; i++)
		{
			if (m_pDataStatic[i])
				m_pDataStatic[i]->SetBkColor(clrItemBk);
		}
	}
}

void CDataGroup::SetTitleFont(LPCTSTR szName, UINT nSize)
{
	if (m_pTitleStatic)
		m_pTitleStatic->SetFont(szName,nSize);
}

void CDataGroup::SetItemFont(LPCTSTR szName, UINT nSize)
{
	if (m_pDataStatic)
	{
		for (int i = 0; i< m_nCount; i++)
		{
			if (m_pDataStatic[i])
				m_pDataStatic[i]->SetFont(szName,nSize);
		}
	}
}

void CDataGroup::SetTitleBkColor(COLORREF clrBk)
{
	if (m_pTitleStatic)
		m_pTitleStatic->SetBkColor(clrBk);
}	

void CDataGroup::GetTextSequence(CString &csData)
{
	if (!m_pDataStatic)	return;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{
			CString csText = _T("");
			m_pDataStatic[i]->GetWindowText(csText);
			csData += _T("--") + csText;
		}
	}
}

void CDataGroup::SetAllItemText(LPCTSTR szText)
{
	if (!m_pDataStatic)	return;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			m_pDataStatic[i]->SetWindowText(szText);		
		}
	}
}

BOOL CDataGroup::GetItemText(int nIndex, char *szText, UINT nSize)
{
	if (!m_pDataStatic)	return FALSE;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			if (m_pDataStatic[i]->m_nIndex == nIndex)
				break;
		}
	}

	if (i < m_nCount)
	{
#ifndef _UNICODE
		m_pDataStatic[i]->GetWindowText(szText);
#else
		CString csText = _T("");
		m_pDataStatic[i]->GetWindowText(csText);
		
		LPTSTR szData = (LPTSTR)csText.GetBuffer(csText.GetLength());
		if (wcslen(szData)>=1024)	szData[1024] = '\0';	
		int len = WideCharToMultiByte(CP_ACP,0,szData,wcslen(szData),szText,nSize,NULL,NULL);
		szText[len] = '\0';		
#endif

		return TRUE;
	}

	return FALSE;
}

BOOL CDataGroup::SetItemText(int nIndex, char *szText, UINT nSize)
{
	if (!m_pDataStatic)	return FALSE;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			if (m_pDataStatic[i]->m_nIndex == nIndex)
				break;
		}
	}

	if (i < m_nCount)
	{
#ifndef _UNICODE
		m_pDataStatic[i]->SetWindowText(szText);
#else
		WCHAR szWChar[1024];
		MultiByteToWideChar( CP_ACP, 0, (char*)(szText), -1, szWChar, nSize );			
		m_pDataStatic[i]->SetWindowText(szWChar);				
#endif

		return TRUE;
	}

	return FALSE;
}

BOOL CDataGroup::GetItemColor(int nIndex, COLORREF &clrText)
{
	if (!m_pDataStatic)	return FALSE;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			if (m_pDataStatic[i]->m_nIndex == nIndex)
				break;
		}
	}

	if (i < m_nCount)
	{
		clrText = m_pDataStatic[i]->GetTextColor();
		return TRUE;
	}

	return FALSE;
}

BOOL CDataGroup::SetItemColor(int nIndex, COLORREF clrText)
{
	if (!m_pDataStatic)	return FALSE;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			if (m_pDataStatic[i]->m_nIndex == nIndex)
				break;
		}
	}

	if (i < m_nCount)
	{
		m_pDataStatic[i]->SetTextColor(clrText);
		return TRUE;
	}

	return FALSE;
}

BOOL CDataGroup::SetItemMode(int nIndex, int nMode)
{
	if (!m_pDataStatic)	return FALSE;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			if (m_pDataStatic[i]->m_nIndex == nIndex)
				break;
		}
	}

	if (i < m_nCount)
	{
		m_pDataStatic[i]->SetMode(nMode);
		return TRUE;
	}

	return FALSE;
}

DECLARE_USER_MESSAGE(WMU_DATA_STATIC_UNIFORMCOLOR)

#include "BDTDlg.h"
void CDataGroup::SetAllItemColor(COLORREF clrText, BOOL bUniform)
{
	if (!m_pDataStatic || !m_bUniformColor)
		return;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			m_pDataStatic[i]->SetTextColor(clrText);		
		}
	}

	if (bUniform)
	{
		CBDTDlg* pParent = (CBDTDlg*)GetParent();
		if (pParent !=NULL)
			::PostMessage(pParent->m_hWnd,WMU_DATA_STATIC_UNIFORMCOLOR,WPARAM(clrText),LPARAM(m_nIndex));
	}
}

void CDataGroup::SetUniformColorMode(BOOL bUniform)
{
	m_bUniformColor = bUniform;
}

int CDataGroup::GetItemMode(int nIndex)
{
	if (!m_pDataStatic)	return FALSE;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			if (m_pDataStatic[i]->m_nIndex == (int)nIndex)
				break;
		}
	}

	if (i < m_nCount)
	{		
		return m_pDataStatic[i]->GetMode();
	}

	return -1;
}

void CDataGroup::SetUniformColor(COLORREF clrText)
{
	if (!m_pDataStatic || !m_bUniformColor)
		return;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			m_pDataStatic[i]->SetTextColor(clrText);			
		}
	}
}

BOOL CDataGroup::EnableWindow(BOOL bEnable)
{
	if (!m_pDataStatic)
		return FALSE;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			m_pDataStatic[i]->EnableWindow(bEnable);			
		}
	}

	this->Invalidate();

	return TRUE;
}

void CDataGroup::SetUniformOnOff(BOOL bOnOff)
{
	if (!m_pDataStatic || !m_bUniformOnOff)
		return;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			m_pDataStatic[i]->SetEnable(bOnOff);			
		}
	}

	this->Invalidate();
}

void CDataGroup::SetUniformOnOffMode(BOOL bUniform)
{
	m_bUniformOnOff = bUniform;
}

void CDataGroup::SetColorSelectable(BOOL bEnable)
{
	if (!m_pDataStatic)
		return;
	
	for (int i = 0; i < m_nCount; i++)
	{		
		if (m_pDataStatic[i])
		{			
			m_pDataStatic[i]->SetSelectColor(bEnable);			
		}
	}

}

int CDataGroup::GetItemCount()
{
	return m_nCount;
}

CDataStatic** CDataGroup::GetDataObject()
{
	return m_pDataStatic;
}

int CDataGroup::GetItemIndex(int item)
{
	return m_pDataStatic[item]->m_nIndex;
}


