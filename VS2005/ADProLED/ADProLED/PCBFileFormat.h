#pragma once


// CPCBFileFormat

class CPCBFileFormat : public CWnd
{
	DECLARE_DYNAMIC(CPCBFileFormat)

public:
	CPCBFileFormat();
	virtual ~CPCBFileFormat();

protected:
	DECLARE_MESSAGE_MAP()
public:
	int GetTemplate(void);
};


