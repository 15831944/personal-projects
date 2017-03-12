#if !defined(AFX_MATRIXDISP_H__0142AA99_F1EB_49DF_A732_E1E0F341D41C__INCLUDED_)
#define AFX_MATRIXDISP_H__0142AA99_F1EB_49DF_A732_E1E0F341D41C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// MatrixDisp.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CMatrixDisp window

#define     WIDTH               240     // pixel in colume mul 8
#define     HEIGHT              32      // pixel in row

typedef struct __ENTIRE_SCREEN
{
    BYTE *red;							// red + (j+width*i)
    BYTE *grn;							// grn + (j+width*i)
    
} ENTIRE_SCREEN, * LPENTIRE_SCREEN;          

class CMatrixDisp : public CStatic
{
// Construction
public:
	CMatrixDisp();

// Attributes
public:

// Operations
public:
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMatrixDisp)
	public:
	virtual BOOL DestroyWindow();
	//}}AFX_VIRTUAL

// Implementation
public:
	void ConvertBitStreamToFont(PBYTE pBitStream);
	void ConvertToStreamBits(PBYTE pBitStream);
	void TestCharMap(int* sz,int size);
	void ClearScreen();
	void ResizeToFit(int scale);
	virtual ~CMatrixDisp();

	// Generated message map functions
protected:
	//{{AFX_MSG(CMatrixDisp)
	afx_msg void OnPaint();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnTimer(UINT nIDEvent);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MATRIXDISP_H__0142AA99_F1EB_49DF_A732_E1E0F341D41C__INCLUDED_)
