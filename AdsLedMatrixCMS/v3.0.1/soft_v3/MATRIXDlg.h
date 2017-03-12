// MATRIXDlg.h : header file
//

#if !defined(AFX_MATRIXDLG_H__EBE5FFE5_8FCB_48DE_ACAA_997FD828D6AD__INCLUDED_)
#define AFX_MATRIXDLG_H__EBE5FFE5_8FCB_48DE_ACAA_997FD828D6AD__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "DataEdit.h"
#include "MatrixSimulator.h"
#include "SerialMFC.h"	// Added by ClassView
#include "ColorCombo.h"
#include "ColorText.h"
#include "FontDisp.h"
#include "StaticFrame.h"
#include "ScrollMatrix.h"
#include "ShadeButtonST.h"
#include "ConnectingDlg.h"	// Added by ClassView
/////////////////////////////////////////////////////////////////////////////
// CMATRIXDlg dialog

class CMATRIXDlg : public CDialog
{
// Construction
public:	
	CConnectingDlg* m_pConnectDlg;
	void SendData(UINT nMsgType,PBYTE pData,UINT nLength, LPCTSTR szText=NULL);
	CSerialMFC m_Serial;
	CMATRIXDlg(CWnd* pParent = NULL);	// standard constructor	
// Dialog Data
	//{{AFX_DATA(CMATRIXDlg)
	enum { IDD = IDD_MATRIX_DIALOG };
	CStaticFrame m_StaticFrame;
	CScrollMatrix m_ScrollMatrix;
	CListBox	m_ctrlFontList;
	CColorText	m_StaticFontText;
	CColorText	m_StaticFontBk;
	CShadeButtonST	m_BnLoadBk;
	CShadeButtonST	m_BnLoadText;
	CColorCombo	m_ctrlColorStatic;
	CColorCombo	m_ctrlColorText;
	CListBox	m_ctrlLayerList;
	CDataEdit	m_EditStaticText;
	CDataEdit	m_EditText;	
	CMatrixSimulator m_ctrlMatrix;
	CString	m_csText;
	CFontDisp m_Font;
	int		m_nRate;
	int		m_Rate[4];
	CString	m_csStaticText;
	int		m_nScrollMode;
	int		m_ScrollMode[4];	
	int		m_nColor;
	int		m_nColorText;		
	BOOL	m_bLayer0;
	BOOL	m_bLayer1;
	BOOL	m_bLayer2;
	BOOL	m_bLayer3;	
	CString	m_csCommStatus;
	CString	m_csClock;
	BOOL	m_bBkLayer;
	BOOL	m_bGradientBk;
	BOOL	m_bGradientText;
	CString	m_csFontBk;
	CString	m_csFontText;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMATRIXDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	CTime m_TimeSent;
	int ProcessData(PBYTE pDest,PBYTE pSrc, int nLength);
	CString GetStringResource(UINT nID);
	void SendExtra(PBYTE pBuffer, int nLength, LPCTSTR szText=NULL);
	void SendCommandMsg(int nMsg, WORD wParam=0, WORD lParam=0);
	void ShowBusyDialog(LPCTSTR lpszText=NULL);
	void SetConfigMsg(int nRate, int nStep = 1, int nScroll=0, int nPowerOff =0);
	HICON m_hIcon;
	int	m_ColorText[4];	
	BOOL m_GradientText[4];
	CString m_csTextLayer[4];
	CString m_csFontTextLayer[4];
	// Generated message map functions
	//{{AFX_MSG(CMATRIXDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButtonConvert();
	afx_msg void OnButtonClear();
	afx_msg void OnStaticFont();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnButtonStart();
	afx_msg void OnButtonStop();
	afx_msg void OnDeviceDownloaddata();
	afx_msg void OnDeltaposSpinTopbot(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnDeltaposSpinLeftright(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnDeviceDowloadstatictext();
	afx_msg void OnButtonLoadText();
	afx_msg void OnButtonLoadTextStatic();
	afx_msg void OnCloseupComboScrollMode();
	afx_msg void OnDeltaposSpinLeftrightText(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnDeltaposSpinTopbotText(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnSelchangeListLayer();
	afx_msg void OnButtonMerge();
	afx_msg void OnCheckLayer0();
	afx_msg void OnCheckLayer1();
	afx_msg void OnCheckLayer2();
	afx_msg void OnCheckLayer3();	
	afx_msg void OnChangeEditTextStatic();
	afx_msg void OnCloseupComboColor();
	afx_msg void OnCloseupComboColorText();
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnClose();
	afx_msg void OnButtonCleakBk();
	afx_msg void OnDeviceSavetexttoeeprom();
	afx_msg void OnDeviceLoadtextfromeeprom();
	afx_msg void OnDestroy();
	afx_msg void OnCheckLayerBk();
	afx_msg void OnOptionSettings();
	afx_msg void OnDeviceStartscroll();
	afx_msg void OnDeviceStopscroll();
	afx_msg void OnDeviceSavebackgroundtoeeprom();
	afx_msg void OnDeviceLoadbackgroundfromeeprom();
	afx_msg void OnDevicePoweroff();
	afx_msg void OnDevicePoweroncommand();
	afx_msg void OnChangeEditText();
	afx_msg void OnDeviceLoadalldatafromeeprom();
	afx_msg void OnDeviceSavealldatatoeeprom();
	afx_msg void OnDeviceRestorefactorysettings();
	afx_msg void OnDeviceSetdevicedatetime();
	afx_msg void OnDeviceStandbysetting();
	afx_msg void OnCheckGradientText();
	afx_msg void OnCheckGradientBk();
	afx_msg void OnDeviceDownloadbuildincharacterfont();
	afx_msg void OnDeviceSavebuildincharacterfonttoeeprom();
	afx_msg void OnDeviceLoadbuildincharacterfontfromeeprom();
	afx_msg void OnDeviceLoadasciitextusingembededfont();
	afx_msg void OnOptionFontfireeditor();
	afx_msg void OnSelchangeListFont();
	afx_msg void OnSelchangeEditTextStatic(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnFileOpenworkspace();
	afx_msg void OnFileSaveworkspace();
	afx_msg void OnButtonSet();
	afx_msg void OnMovingLefttext();
	afx_msg void OnMovingRighttext();
	afx_msg void OnMovingToptext();
	afx_msg void OnMovingBottext();
	afx_msg void OnHelpAbout();
	//}}AFX_MSG
	afx_msg LRESULT OnSerialMsg (WPARAM wParam, LPARAM lParam);

	DECLARE_MESSAGE_MAP()
private:
	UINT m_nMaxTimeout;
	BOOL m_bSending;
	int m_nPowerOff;
	int m_nLastLayer;
	void GetFontList();
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MATRIXDLG_H__EBE5FFE5_8FCB_48DE_ACAA_997FD828D6AD__INCLUDED_)
