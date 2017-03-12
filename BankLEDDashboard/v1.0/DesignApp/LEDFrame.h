#if !defined(AFX_LEDFRAME_H__2E7C07E9_3E0C_470A_BBD5_9E23A8EAD494__INCLUDED_)
#define AFX_LEDFRAME_H__2E7C07E9_3E0C_470A_BBD5_9E23A8EAD494__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// LEDFrame.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CLEDFrame window

class CLEDFrame : public CStatic
{
// Construction
public:
	CLEDFrame();

// Attributes
public:
	ARRAY_LEDEDIT m_arrLEDEdit;
	ARRAY_MATRIXEDIT m_arrMatrixEdit;
	ARRAY_STATICEDIT m_arrStaticEdit;
// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLEDFrame)
	public:
	virtual BOOL DestroyWindow();
	//}}AFX_VIRTUAL
	afx_msg LRESULT OnStaticEditLButtonUp(WPARAM wParam, LPARAM lParam);
	afx_msg LRESULT OnStaticEditRemove(WPARAM wParam, LPARAM lParam);
	afx_msg LRESULT OnStaticEditCopy(WPARAM wParam, LPARAM lParam);
	afx_msg LRESULT OnStaticEditCut(WPARAM wParam, LPARAM lParam);
	afx_msg LRESULT OnStaticEditSelected(WPARAM wParam, LPARAM lParam);
// Implementation
public:
	UINT m_nReposition;
	BOOL m_bRepositionMod;
	void SaveControl(CArchive& ar);
	void LoadControl(CArchive& ar);
	void ShowControlID(BOOL bShow);
	void InitControl(HWND hWnd=NULL);
	void AddControl();
	BOOL RemoveLED(CLEDEdit* pLED);
	BOOL RemoveMatrix(CMatrixEdit* pMatrix);
	BOOL RemoveStatic(CStaticEdit* pStatic);
	BOOL AddLED(const CRect& rect, int nDigit, int nHeight, LPCTSTR szFontName);
	BOOL AddMatrix(const CRect& rect, int nDigit, int nHeight, LPCTSTR szFontName);
	BOOL AddStatic(const CRect& rect, int nDigit, int nHeight, LPCTSTR szFontName);
	virtual ~CLEDFrame();

	// Generated message map functions
protected:
	void RemoveAll();
	void AddControl(CStaticEdit* pLED,const CRect& rect, int nDigit, int nHeight, LPCTSTR szFontName);
	void LoadControl(CArchive& ar, CStaticEdit* pLED);
	void StoreControl(CArchive& ar, CStaticEdit* pLED);
	void RemoveControl(UINT nStyle, LPVOID pLED);
	void ReCreateNumID();
	afx_msg void OnContextMenu(CWnd*, CPoint point);
	//{{AFX_MSG(CLEDFrame)
	afx_msg void OnPaint();
	afx_msg void OnEditCtlCut();
	afx_msg void OnEditCtlCopy();
	afx_msg void OnEditCtlPaste();
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:		
	BOOL m_bNewLoad;
	CBitmap m_bmpFrame;	
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LEDFRAME_H__2E7C07E9_3E0C_470A_BBD5_9E23A8EAD494__INCLUDED_)
