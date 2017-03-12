#if !defined(AFX_FONTDISP_H__9DF5C726_F54C_4F4E_860E_8D54907AF36D__INCLUDED_)
#define AFX_FONTDISP_H__9DF5C726_F54C_4F4E_860E_8D54907AF36D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// CFontDisp.h : header file
//
/////////////////////////////////////////////////////////////////////////////
// CFontDisp window
#define     HEIGHT							50      // pixel in row
#define     WIDTH							50      // pixel in colume 

typedef struct __FONT_CHAR
{
	int		width,heigth;					// size of the matrix
	BYTE	pdata[WIDTH][HEIGHT];

} FONT_CHAR, * LPFONT_CHAR;

class CFontDisp : public CStatic
{
// Construction
public:
	CFontDisp();

// Attributes
public:

// Operations
public:	
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFontDisp)
	public:
	//}}AFX_VIRTUAL

// Implementation
public:
	void LoadFont(LPCTSTR szFontName);
	CString& GetFontPath();
	CString& GetFontName();
	BOOL DoFontDlg();
	void Clear();
	void SaveToFile(LPCTSTR szFile);
	void ReCalcLayout();
	void DoConvert(LPLOGFONT lplf);
	void ShowFontDialog();
	virtual ~CFontDisp();

	// Generated message map functions
protected:
	void CompressFont(LPCTSTR szFile);
	void DecompressFont(LPCTSTR szFile);
	void CaptureFont(CDC*pDC, int c);
	//{{AFX_MSG(CFontDisp)
	afx_msg void OnPaint();
	afx_msg void OnStaticFont();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	CString m_csFontPath;
	CString m_csFontName;
	CSize m_szMaxSize;
	LOGFONT m_logfont;	
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FONTDISP_H__9DF5C726_F54C_4F4E_860E_8D54907AF36D__INCLUDED_)
