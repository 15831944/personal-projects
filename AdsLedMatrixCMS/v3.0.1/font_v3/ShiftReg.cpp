// ShiftReg.cpp: implementation of the CShiftReg class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "ShiftReg.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CShiftReg::CShiftReg()
{
	m_btData = 0x00;
	m_pNext = NULL;	
}

CShiftReg::~CShiftReg()
{
	if(m_pNext){
		delete m_pNext;
		m_pNext = NULL;
	}	
}

CShiftReg::CShiftReg(BYTE btInit):m_btData(btInit)
{
	m_pNext = NULL;
}

int CShiftReg::ShiftBit(int bit)
{
	int out = BYTE(m_btData & 0x01);
	m_btData = (m_btData >> 1) | (bit<<8);
	if (m_pNext){
		out = m_pNext->ShiftBit(out);
	}
	return out;
}

BYTE CShiftReg::ShiftByte(BYTE byte)
{
	BYTE btOut = 0;
	for (int i=0; i< 8; i++){
		btOut |= ShiftBit(int(byte>>i)&0x01);
		btOut = btOut<<1;
	}
	return btOut;
}

BOOL CShiftReg::Add(CShiftReg* pNext)
{	
	if (AfxIsMemoryBlock(pNext,sizeof(CShiftReg))){
		if (m_pNext==NULL){
			m_pNext = pNext;				
		}
		else{
			m_pNext->Add(pNext);
		}
		return TRUE;
	}
	else{
		delete pNext;
		pNext = NULL;
	}
	return FALSE;
}

void CShiftReg::Remove()
{
	CShiftReg* pTemp = this;
	CShiftReg* pParent = this;
	while(!pTemp->IsEOF()){
		pParent = pTemp;
		pTemp = pTemp->m_pNext;
	}
	if (pTemp != this){
		pParent->m_pNext=NULL;
		delete pTemp;		
	}
	
}

BOOL CShiftReg::IsEOF()
{
	return (m_pNext==NULL)?TRUE:FALSE;
}

void CShiftReg::RemoveAll()
{
	CShiftReg* pTemp = this;
	while(!pTemp->IsEOF())
		pTemp->Remove();
}

