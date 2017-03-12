// FontEditor.cpp: implementation of the CFontEditor class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "FontFire.h"
#include "FontEditor.h"
#include "FontFireDlg.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

#define		__DEMO_

__FONT_CHAR char_map[256];	
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CFontEditor::CFontEditor()
{
	m_nCharacter = 0;
}

CFontEditor::~CFontEditor()
{

}

BOOL CFontEditor::InitLineList(LINE_LIST *pLineList)
{
	for (int y=0; y <m_sizePixel.cy; y++){
		CShiftReg* lineR = new CShiftReg();
		CShiftReg* lineG = new CShiftReg();
		CShiftReg* lineB = new CShiftReg();
		for (int x=0; x <m_sizePixel.cy; x++){
			if (m_nLineMode&LINE_RED){
				CShiftReg* pNextR = new CShiftReg();
				lineR->Add(pNextR);
			}
			if (m_nLineMode&LINE_GREEN){
				CShiftReg* pNextG = new CShiftReg();
				lineG->Add(pNextG);
			}
			if (m_nLineMode&LINE_BLUE){
				CShiftReg* pNextB = new CShiftReg();
				lineB->Add(pNextB);
			}
		}
		this->AddDataLine(pLineList,lineR,lineG,lineB);
	}

	return TRUE;
}

CPoint CFontEditor::OnChangePosition(int x, int y)
{
	return CPoint(x,y);
}

void CFontEditor::OnProcessBuffer(PBYTE pBuffer, int nSize, int nColor, int cx, int cy)
{

}

#define	FONT_HEIGHT		32

void CFontEditor::LoadFont(LPCTSTR szFile)
{
	BYTE dim[256][2];
	BYTE buffer[FONT_HEIGHT*8*256];
	memset(buffer,0x00,sizeof(buffer));

	CFile file(szFile,CFile::modeRead);
	file.ReadHuge(buffer,sizeof(buffer));
	file.SeekToBegin();
	file.Read(dim,sizeof(dim));
	file.Close();
	
	for (int i=0; i< 256; i++)
	{
		for (int x=0; x< FONT_HEIGHT; x++)
		{
			for (int y=0; y < FONT_HEIGHT; y++)
			{
				if (buffer[y + (x/8)*FONT_HEIGHT + i*FONT_HEIGHT*FONT_HEIGHT/8] & (1<<(x%8)))
					char_map[i].pdata[y][x] = 1;
				else
					char_map[i].pdata[y][x] = 0;
			}
		}
		char_map[i].heigth = dim[i][0];		
		char_map[i].width  = dim[i][1];		
	}

	for (int x=0; x< m_sizePixel.cx; x++){
		for (int y=0; y< m_sizePixel.cy; y++){
			SetPixel(x,y,RGB(0,0,0));
		}
	}

	CScrollMatrix* pParent = (CScrollMatrix*)GetParent();
	if (pParent){
		CFontFireDlg* pDlg = (CFontFireDlg*)pParent->GetParent();
		if (pDlg){
			CString csFontName = pDlg->m_FontDisp.GetFontName();
			csFontName = csFontName.Left(csFontName.Find(_T("_"),0));
			pDlg->SetFontList(csFontName);
		}
	}
}

#define	_T_APP_PATH			_T("m_csAppPath")
extern BOOL GetRegKey(CString csKey, LPTSTR szValue);

void CFontEditor::SaveFont(LPCTSTR szFile)
{
	TCHAR szDir[MAX_PATH];
	GetRegKey(_T_APP_PATH,szDir);
	CString csLicFile = szDir;
	csLicFile += _T("\\fontlic.dat");
	CString csLicenseInfo;
	if (!GetPermission(csLicFile, csLicenseInfo))
	{
		MessageBox(_T("Unregistered version.Please conntact cuong3ihut@yahoo.com to get a licensed copy."));
		return;
	}

	BYTE dim[256][2];
	BYTE buffer[FONT_HEIGHT*8*256];
	memset(buffer,0x00,sizeof(buffer));
	for (int i=0; i< 256; i++)
	{
		for (int x=0; x< FONT_HEIGHT; x++)
		{
			for (int y=0; y < FONT_HEIGHT; y++)
			{
				if (char_map[i].pdata[y][x])
					buffer[y + (x/8)*FONT_HEIGHT + i*FONT_HEIGHT*FONT_HEIGHT/8] |= 1<<(x%8);
				else
					buffer[y + (x/8)*FONT_HEIGHT + i*FONT_HEIGHT*FONT_HEIGHT/8] &= ~(1<<(x%8));				
			}
		}

		dim[i][0] = char_map[i].heigth;
		dim[i][1] = char_map[i].width ;
	}
	
#ifndef __DEMO_
	CFile file(szFile,CFile::modeCreate|CFile::modeWrite);
	file.WriteHuge(buffer,sizeof(buffer));
	file.SeekToBegin();
	file.Write(dim,sizeof(dim));
	file.Close();
#endif
}

#include "ScrollMatrix.h"
void CFontEditor::SelectCharacter(int nChar)
{
	int cx = char_map[nChar].width;
	int cy = char_map[nChar].heigth;

	m_nCharacter = nChar;
	SetSizeInPixel(cx,cy);
	ReCalcMatrixClient();
	((CScrollMatrix*)GetParent())->InitScroll(this);	

	for (int x=0;x<cx;x++){
		for (int y=0; y< cy; y++){
			if (char_map[nChar].pdata[x][y]){
				this->SetPixel(x,y,RGB(255,0,0));
			}
			else{
				this->SetPixel(x,y,RGB(0,0,0));
			}

		}
	}
	this->Invalidate(FALSE);
}

BOOL CFontEditor::OnSetPixel(UINT nFlags, int x, int y)
{			
	if (nFlags & MK_CONTROL){
		m_clrPen = RGB(0,0,0);
		char_map[m_nCharacter].pdata[x][y] = 0;
	}
	else{
		m_clrPen = RGB(255,0,0);
		char_map[m_nCharacter].pdata[x][y] = 1;
	}
	
	return FALSE;	// call default SetPixel
}

void CFontEditor::InitDefaultCharMap()
{
	for (int i=0; i< 256; i++)
	{
		for (int x=0; x< FONT_HEIGHT; x++)
		{
			for (int y=0; y < FONT_HEIGHT; y++)
			{
				char_map[i].pdata[y][x] = 0;
			}
		}
		char_map[i].heigth = FONT_HEIGHT;		
		char_map[i].width  = FONT_HEIGHT;		
	}

	SetSizeInPixel(FONT_HEIGHT,FONT_HEIGHT);
	ReCalcMatrixClient();
	CScrollMatrix* pParent = (CScrollMatrix*)GetParent();
	pParent->InitScroll(this);	
	this->Invalidate(FALSE);

	for (int x=0; x< m_sizePixel.cx; x++){
		for (int y=0; y< m_sizePixel.cy; y++){
			SetPixel(x,y,RGB(0,0,0));
		}
	}
	CFontFireDlg* pDlg = (CFontFireDlg*)pParent->GetParent();
	pDlg->SetFontList(_T("Ms Sans Serif"));
}

void CFontEditor::SetCharWidth(UINT nWidth)
{
	char_map[m_nCharacter].heigth = FONT_HEIGHT;		
	char_map[m_nCharacter].width  = nWidth;
	this->SetSizeInPixel(nWidth,FONT_HEIGHT);
	this->ReCalcMatrixClient();
	((CScrollMatrix*)GetParent())->InitScroll(this);	
	this->Invalidate(FALSE);
}

UINT CFontEditor::GetCharWidth()
{
	return char_map[m_nCharacter].width;
}
