// InputModule.h : main header file for the INPUTMODULE application
//

#if !defined(AFX_INPUTMODULE_H__EBBF4E50_114E_470C_BED8_B31AA24E2AD4__INCLUDED_)
#define AFX_INPUTMODULE_H__EBBF4E50_114E_470C_BED8_B31AA24E2AD4__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CInputModuleApp:
// See InputModule.cpp for the implementation of this class
//

class CInputModuleApp : public CWinApp
{
public:
	CInputModuleApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CInputModuleApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CInputModuleApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_INPUTMODULE_H__EBBF4E50_114E_470C_BED8_B31AA24E2AD4__INCLUDED_)
