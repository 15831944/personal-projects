#pragma once


// CNodeTextPreview

class CNodeTextPreview : public CStatic
{
	DECLARE_DYNAMIC(CNodeTextPreview)

public:
	CNodeTextPreview();
	virtual ~CNodeTextPreview();
	LOGFONT m_LogFont;	
	void SetNodeParams(int nDistance, int nDrawSize);	
protected:
	int m_nNodeSize;
	int m_nDistance;
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnPaint();
public:
	CString m_csText;
};


