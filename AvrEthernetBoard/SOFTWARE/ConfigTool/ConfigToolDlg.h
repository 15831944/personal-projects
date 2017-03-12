// ConfigToolDlg.h : header file
//

#if !defined(AFX_CONFIGTOOLDLG_H__D631E42D_6E5C_4B8B_95C0_40590D5766F9__INCLUDED_)
#define AFX_CONFIGTOOLDLG_H__D631E42D_6E5C_4B8B_95C0_40590D5766F9__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "EthernetPort.h"
/////////////////////////////////////////////////////////////////////////////
// CConfigToolDlg dialog

class CConfigToolDlg : public CDialog
{
// Construction
public:
	CConfigToolDlg(CWnd* pParent = NULL);	// standard constructor
	CEthernetPort* m_pEthernet;
	CEthernetPort* m_pBroadcast;
// Dialog Data
	//{{AFX_DATA(CConfigToolDlg)
	enum { IDD = IDD_CONFIGTOOL_DIALOG };
	CIPAddressCtrl	m_ctrlSubnetMask;
	CListBox	m_ctrlDeviceList;
	CIPAddressCtrl	m_ctrlClientIP;
	CIPAddressCtrl	m_ctrlServerIP;
	CString	m_csClient;
	CString	m_csMACAddr;
	UINT	m_nServerPort;
	UINT	m_nClientPort;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CConfigToolDlg)
	public:
	virtual BOOL DestroyWindow();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	BOOL m_bDeviceListing;
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CConfigToolDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	afx_msg void OnButtonSet();
	afx_msg void OnButtonGet();
	afx_msg void OnButtonConnect();
	afx_msg void OnButtonAutoMac();
	afx_msg void OnButtonList();
	afx_msg void OnSelchangeListDevice();
	//}}AFX_MSG
	LRESULT OnEthernetMsg (WPARAM wParam, LPARAM /*lParam*/);
	DECLARE_MESSAGE_MAP()
private:
	BOOL m_bConnected;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CONFIGTOOLDLG_H__D631E42D_6E5C_4B8B_95C0_40590D5766F9__INCLUDED_)
