#if !defined(AFX_COLORCOMBO_H__595C8B61_2C9C_4A2B_9E83_CDD0F5B7EA33__INCLUDED_)
#define AFX_COLORCOMBO_H__595C8B61_2C9C_4A2B_9E83_CDD0F5B7EA33__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// ColorCombo.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CColorCombo window

class CColorCombo : public CComboBox
{
// Construction
public:
	CColorCombo();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CColorCombo)
	public:
	virtual void DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct);
	//}}AFX_VIRTUAL

// Implementation
public:
	COLORREF GetColorItem(int nIndex);
	virtual ~CColorCombo();

	// Generated message map functions
protected:
	//{{AFX_MSG(CColorCombo)
		// NOTE - the ClassWizard will add and remove member functions here.
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_COLORCOMBO_H__595C8B61_2C9C_4A2B_9E83_CDD0F5B7EA33__INCLUDED_)
