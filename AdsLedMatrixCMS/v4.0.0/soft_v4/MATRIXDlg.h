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
	CColorCombo	m_ctrlColorPen;
	CStaticFrame m_StaticFrame;
	CScrollMatrix m_ScrollMatrix;
	CListBox	m_ctrlFontList;
	CColorText	m_StaticFontText;			
	CColorCombo	m_ctrlColorText;
	CListBox	m_ctrlLayerList;	
	CDataEdit	m_EditText;	
	CMatrixSimulator m_ctrlMatrix;
	CString	m_csText;
	CFontDisp m_Font;
	int		m_nRate;	
	int		m_nScrollMode;
	int		m_nColorText;		
	BOOL	m_bLayer0;
	BOOL	m_bLayer1;
	BOOL	m_bLayer2;
	BOOL	m_bLayer3;	
	CString	m_csCommStatus;
	CString	m_csClock;		
	CString	m_csFontText;
	int		m_nLine;
	int		m_nLastLine;
	int		m_nColorPen;	
	int		m_nDrawType;
	//}}AFX_DATA
	int		m_Rate[MAX_LINE];
	int		m_ScrollMode[MAX_LINE];	

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMATRIXDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:	
	CTime m_TimeSent;
	CString GetStringResource(UINT nID);
	void SendExtra(PBYTE pBuffer, int nLength, LPCTSTR szText=NULL);
	void SendCommandMsg(int nMsg, WORD wParam=0, WORD lParam=0);
	void ShowBusyDialog(LPCTSTR lpszText=NULL);
	void SetConfigMsg(int nRate, int nStep = 1, int nScroll=0, int nPowerOff =0);
	HICON m_hIcon;
	int	m_ColorText[MAX_LINE][MAX_LAYER];	
	BOOL m_GradientText[MAX_LINE][MAX_LAYER];
	CString m_csTextLayer[MAX_LINE][MAX_LAYER];
	CString m_csFontTextLayer[MAX_LINE][MAX_LAYER];
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
	afx_msg void OnButtonLoadText();	
	afx_msg void OnCloseupComboScrollMode();
	afx_msg void OnDeltaposSpinLeftrightText(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnDeltaposSpinTopbotText(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnSelchangeListLayer();
	afx_msg void OnCheckLayer0();
	afx_msg void OnCheckLayer1();
	afx_msg void OnCheckLayer2();
	afx_msg void OnCheckLayer3();			
	afx_msg void OnCloseupComboColorText();
	virtual void OnOK();
	virtual void OnCancel();
	afx_msg void OnClose();	
	afx_msg void OnDestroy();	
	afx_msg void OnOptionSettings();
	afx_msg void OnDevicePoweroff();
	afx_msg void OnDevicePoweroncommand();
	afx_msg void OnChangeEditText();
	afx_msg void OnDeviceRestorefactorysettings();
	afx_msg void OnDeviceSetdevicedatetime();
	afx_msg void OnDeviceStandbysetting();
	afx_msg void OnOptionFontfireeditor();
	afx_msg void OnSelchangeListFont();	
	afx_msg void OnFileSaveworkspace();
	afx_msg void OnFileOpenworkspace();
	afx_msg void OnButtonSet();
	afx_msg void OnMovingLefttext();
	afx_msg void OnMovingRighttext();
	afx_msg void OnMovingToptext();
	afx_msg void OnMovingBottext();
	afx_msg void OnHelpAbout();
	afx_msg void OnCloseupComboLine();
	afx_msg void OnButtonClearLayer();
	afx_msg void OnRadioPen();
	afx_msg void OnRadioPointer();
	afx_msg void OnCloseupComboColorPen();
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
