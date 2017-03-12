// MatrixPreview.cpp: implementation of the CMatrixPreview class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "FontFire.h"
#include "MatrixPreview.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

extern __FONT_CHAR char_map[256];	
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CMatrixPreview::CMatrixPreview()
{

}

CMatrixPreview::~CMatrixPreview()
{

}

BOOL CMatrixPreview::InitLineList(LINE_LIST *pLineList)
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

CPoint CMatrixPreview::OnChangePosition(int x, int y)
{
	return CPoint(x,y);
}

void CMatrixPreview::OnProcessBuffer(PBYTE pBuffer, int nSize, int nColor, int cx, int cy)
{

}

void CMatrixPreview::LoadText(LPCTSTR szText)
{
#ifdef _UNICODE
	if (wcscmp(szText,_T(""))==0){
#else
	if (strcmp(szText,_T(""))==0){
#endif
		ClearScreen();
	}
	else{
#ifdef _UNICODE
		int nLen = wcslen(szText);
#else
		int nLen = strlen(szText);
#endif
		int nPos = 0;
		for (int i=0; i< nLen; i++){
			char c = (char)szText[i];
			this->PutChar(nPos,BYTE(c));
			nPos += char_map[BYTE(c)].width;
		}
	}
	this->Invalidate(TRUE);
}

void CMatrixPreview::ClearScreen()
{
	for (int x=0; x< m_sizePixel.cx; x++){
		for (int y=0; y< m_sizePixel.cy; y++){
			SetPixel(x,y,RGB(0,0,0));
		}
	}
}

void CMatrixPreview::PutChar(UINT nPos, BYTE ch)
{
	int cx = char_map[ch].width;
	int cy = char_map[ch].heigth;

	for (int x=0;x<cx;x++){
		for (int y=0; y< cy; y++){
			if (char_map[ch].pdata[x][y]){
				this->SetPixel(nPos + x,y,RGB(255,0,0));
			}
			else{
				this->SetPixel(nPos + x,y,RGB(0,0,0));
			}

		}
	}	
}

void CMatrixPreview::SetPixel(int x, int y, COLORREF clr)
{
	if (!m_pCurLineList){
		return;
	}

	CPoint realPoint = OnChangePosition(x,y);
	
	if (m_pCurLineList->GetSize() > realPoint.y){
		CLineColor* pLineColor = m_pCurLineList->GetAt(realPoint.y);
		if (AfxIsMemoryBlock(pLineColor,sizeof(CLineColor))){
			pLineColor->SetPixel(realPoint.x,clr);
			this->DrawPixel(clr,x,y,FALSE);			
		}
	}	
}
