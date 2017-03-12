// PanelPropertyPage.h : header file
//

#ifndef __PANELPROPERTYPAGE_H__
#define __PANELPROPERTYPAGE_H__

#include "resource.h"
#include "ColorCombo.h"
/////////////////////////////////////////////////////////////////////////////
// CPanelPropertyPageGeneral dialog

class CPanelPropertyPageGeneral : public CPropertyPage
{
	DECLARE_DYNCREATE(CPanelPropertyPageGeneral)

// Construction
public:	
	LPVOID GetParams();
	CPanelPropertyPageGeneral();
	~CPanelPropertyPageGeneral();

// Dialog Data
	//{{AFX_DATA(CPanelPropertyPageGeneral)
	enum { IDD = IDD_PROPPAGE_GENERAL };
	CColorCombo	m_ClrComboSegOff;
	CColorCombo	m_ClrComboBk;
	CColorCombo	m_ClrComboSeg;
	BOOL	m_bCheckStaticEdge;
	BOOL	m_bCheckModalFrame;
	BOOL	m_bCheckClientEdge;
	int		m_nHeight;
	int		m_nLeft;
	int		m_nTop;
	int		m_nWidth;
	int		m_nColorSeg;
	int		m_nColorBk;
	UINT	m_nDigits;
	BOOL	m_bEnableEdit;
	int		m_nColorSegOff;
	//}}AFX_DATA


// Overrides
	// ClassWizard generate virtual function overrides
	//{{AFX_VIRTUAL(CPanelPropertyPageGeneral)
	public:
	virtual BOOL OnSetActive();
	virtual BOOL OnKillActive();
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	// Generated message map functions
	void InitControl();
	//{{AFX_MSG(CPanelPropertyPageGeneral)
	afx_msg void OnDeltaposSpinHeight(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnDeltaposSpinLeft(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnDeltaposSpinTop(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnDeltaposSpinWidth(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnCheckClientEdge();
	afx_msg void OnCheckModalFrame();
	afx_msg void OnCheckStaticEdge();
	afx_msg void OnChangeEditWidth();
	afx_msg void OnChangeEditTop();
	afx_msg void OnChangeEditLeft();
	afx_msg void OnChangeEditHeight();
	virtual BOOL OnInitDialog();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnCloseupComboBkcolor();
	afx_msg void OnCloseupComboLedcolor();
	afx_msg void OnChangeEditDigits();
	afx_msg void OnDeltaposSpinDigits(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnCheckEnableEdit();
	afx_msg void OnCloseupComboLedcolorOff();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

};


#endif // __PANELPROPERTYPAGE_H__
