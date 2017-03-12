// PanelPropertySheet.h : header file
//
// CPanelPropertySheet is a modeless property sheet that is 
// created once and not destroyed until the application
// closes.  It is initialized and controlled from
// CPropertyFrame.
 // CPanelPropertySheet has been customized to include
// a preview window.
 
#ifndef __PANELPROPERTYSHEET_H__
#define __PANELPROPERTYSHEET_H__

#include "PanelPropertyPage.h"
#include "PreviewWnd.h"

/////////////////////////////////////////////////////////////////////////////
// CPanelPropertySheet

class CPanelPropertySheet : public CPropertySheet
{
	DECLARE_DYNAMIC(CPanelPropertySheet)

// Construction
public:
	CPanelPropertySheet(CWnd* pWndParent = NULL);

// Attributes
public:
	CPanelPropertyPageGeneral m_PageGeneral;
	CPreviewWnd m_wndPreview;

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CPanelPropertySheet)
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CPanelPropertySheet();
		 virtual BOOL OnInitDialog();
	 virtual void PostNcDestroy();

// Generated message map functions
protected:
	//{{AFX_MSG(CPanelPropertySheet)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

#endif	// __PANELPROPERTYSHEET_H__
