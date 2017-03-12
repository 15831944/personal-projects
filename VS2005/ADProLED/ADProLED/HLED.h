#pragma once


// CHLED

class CHLED : public CWnd
{
	DECLARE_DYNAMIC(CHLED)

public:
	CHLED();
	double m_nXCenter;
	double m_nYCenter;
	double m_nXPadA;
	double m_nYPadA;
	double m_nXPadK;
	double m_nYPadK;
	virtual ~CHLED();

protected:
	DECLARE_MESSAGE_MAP()
};

typedef CTypedPtrArray<CPtrArray, CHLED*> ARRAY_HLED;
