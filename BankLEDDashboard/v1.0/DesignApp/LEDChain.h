// LEDChain.h: interface for the CLEDChain class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_LEDCHAIN_H__87C65DAD_32AE_417B_904D_08D3FD84DE8D__INCLUDED_)
#define AFX_LEDCHAIN_H__87C65DAD_32AE_417B_904D_08D3FD84DE8D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "LED7Digit.h"

class CLEDChain : public CObject  
{
public:
	CLEDChain();
	CLED7Digit m_LED;
	virtual ~CLEDChain();

};

typedef CTypedPtrArray<CPtrArray, CLEDChain*> ARRAY_LEDCHAIN;

#endif // !defined(AFX_LEDCHAIN_H__87C65DAD_32AE_417B_904D_08D3FD84DE8D__INCLUDED_)
