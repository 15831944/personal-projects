// LineColor.cpp: implementation of the CLineColor class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "FontFire.h"
#include "LineColor.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CLineColor::CLineColor()
{
	m_pLineR = NULL;
	m_pLineG = NULL;
	m_pLineB = NULL;
}

CLineColor::~CLineColor()
{

}

COLORREF CLineColor::GetPixel(int bit)
{
	int index = int(bit/8) + 1;
	int R =0,G =0,B =0;
	CShiftReg* pNextR = m_pLineR;
	CShiftReg* pNextG = m_pLineG;
	CShiftReg* pNextB = m_pLineB;
	for (int i=0; i< index; i++){		
		if (pNextR == NULL){
			R = 0;
		}
		else{
			pNextR = pNextR->GetNext();
		}
		
		if (pNextG == NULL){
			G = 0;
		}
		else{
			pNextG = pNextG->GetNext();
		}
		
		if (pNextB == NULL){
			B = 0;
		}
		else{
			pNextB = pNextB->GetNext();
		}
	}
	if (pNextR){
		R = (pNextR->GetByte()>>(bit%8))&0x01;
	}
	if (pNextG){
		G = (pNextG->GetByte()>>(bit%8))&0x01;
	}
	if (pNextB){
		B = (pNextB->GetByte()>>(bit%8))&0x01;
	}
	R = R?255:0;
	G = G?255:0;
	B = B?255:0;
	return RGB(R,G,B);
}

void CLineColor::SetPixel(int bit, const COLORREF &clrBit)
{
	int index = int(bit/8) + 1;
	
	BYTE R = GetRValue(clrBit);
	BYTE G = GetGValue(clrBit);
	BYTE B = GetBValue(clrBit);

	CShiftReg* pNextR = m_pLineR;
	CShiftReg* pNextG = m_pLineG;
	CShiftReg* pNextB = m_pLineB;
	for (int i=0; i< index; i++){		
		if (pNextR == NULL){
			R = 0;
		}
		else{
			pNextR = pNextR->GetNext();
		}
		
		if (pNextG == NULL){
			G = 0;
		}
		else{
			pNextG = pNextG->GetNext();
		}
		
		if (pNextB == NULL){
			B = 0;
		}
		else{
			pNextB = pNextB->GetNext();
		}
	}
	if (pNextR){
		BYTE byte = pNextR->GetByte();
		byte = (R)?byte|1<<(bit%8):byte&~(1<<(bit%8));
		pNextR->SetByte(byte);		
	}
	if (pNextG){
		BYTE byte = pNextG->GetByte();
		byte = (G)?byte|1<<(bit%8):byte&~(1<<(bit%8));
		pNextG->SetByte(byte);	
	}
	if (pNextB){
		BYTE byte = pNextB->GetByte();
		byte = (B)?byte|1<<(bit%8):byte&~(1<<(bit%8));
		pNextB->SetByte(byte);	
	}	
}
