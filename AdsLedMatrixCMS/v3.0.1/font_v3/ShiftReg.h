// ShiftReg.h: interface for the CShiftReg class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SHIFTREG_H__5C34CC66_BA67_440D_834E_4342DDBEACDA__INCLUDED_)
#define AFX_SHIFTREG_H__5C34CC66_BA67_440D_834E_4342DDBEACDA__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CShiftReg
{
public:	
	void SetByte(BYTE byte){m_btData = byte;}
	CShiftReg* GetNext(){return m_pNext;}
	BYTE GetByte(){return m_btData;}
	BYTE ShiftByte(BYTE byte = 0);
	void RemoveAll();
	void Remove();
	CShiftReg(BYTE btInit);
	BOOL Add(CShiftReg* pNext);
	int ShiftBit(int bit=0);	
	CShiftReg();
	virtual ~CShiftReg();
protected:	
	BOOL IsEOF();
private:
	BYTE m_btData;
	CShiftReg* m_pNext;
};


#endif // !defined(AFX_SHIFTREG_H__5C34CC66_BA67_440D_834E_4342DDBEACDA__INCLUDED_)
