#pragma once


// CSettingPaymentDlg dialog

class CSettingPaymentDlg : public CDialog
{
	DECLARE_DYNAMIC(CSettingPaymentDlg)

public:
	CSettingPaymentDlg(CWnd* pParent = NULL);   // standard constructor
	virtual ~CSettingPaymentDlg();

// Dialog Data
	enum { IDD = IDD_SET_PAYMENT_DLG };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	virtual BOOL OnInitDialog();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedOk();
public:
	double _red;
};
