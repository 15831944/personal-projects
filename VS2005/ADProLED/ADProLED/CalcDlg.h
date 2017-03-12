#pragma once


// CCalcDlg dialog

class CCalcDlg : public CDialog
{
	DECLARE_DYNAMIC(CCalcDlg)

public:
	CCalcDlg(CWnd* pParent = NULL);   // standard constructor
	virtual ~CCalcDlg();

// Dialog Data
	enum { IDD = IDD_CALC_DLG };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP()
public:
	virtual BOOL DestroyWindow();
public:
	CString m_csTitleNode;
	CString m_csTitleRED3;
	CString m_csTitleRED5;
	CString m_csTitleBLUE3;
	CString m_csTitleBLUE5;
	CString m_csTitleGREEN3;
	CString m_csTitleGREEN5;
	CString m_csTitleWHITE3;
	CString m_csTitleOTHER;
	CString m_csTitleCPU;
	CString m_csTitlePOWER;
	CString m_csTitleCASE;
	CString m_csTitleEXTRA;

	UINT m_nTotalNode;
	UINT m_nTotalRED3;
	UINT m_nTotalRED5;
	UINT m_nTotalBLUE3;
	UINT m_nTotalBLUE5;
	UINT m_nTotalGREEN3;
	UINT m_nTotalGREEN5;
	UINT m_nTotalWHITE3;
	UINT m_nTotalOTHER;
	UINT m_nTotalCPU;
	UINT m_nTotalPOWER;
	CString m_csTotalCASE;
	CString m_csTotalEXTRA;
	CString m_csTitleTotal;
	CString m_csTotalPay;
public:
	void Calc(void);
public:
	afx_msg void OnEnChangeEditTotalCase();
public:
	afx_msg void OnEnChangeEditTotalExtra();
public:
	afx_msg void OnEnChangeEditTotalPower();
public:
	afx_msg void OnEnChangeEditTotalCpu();
public:
	afx_msg void OnEnChangeEditTotalOther();
public:
	afx_msg void OnEnChangeEditTotalWhite3();
public:
	afx_msg void OnEnChangeEditTotalGreen5();
public:
	afx_msg void OnEnChangeEditTotalGreen3();
public:
	afx_msg void OnEnChangeEditTotalBlue5();
public:
	afx_msg void OnEnChangeEditTotalBlue3();
public:
	afx_msg void OnEnChangeEditTotalRed5();
public:
	afx_msg void OnEnChangeEditTotalRed3();
public:
	afx_msg void OnEnChangeEditTotalNode();
};
