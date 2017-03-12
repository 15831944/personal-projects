// DigiLED.h : main header file for the DIGILED application
//

#if !defined(AFX_DIGILED_H__197B4388_8A61_41A2_A903_241D1CACCA06__INCLUDED_)
#define AFX_DIGILED_H__197B4388_8A61_41A2_A903_241D1CACCA06__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDApp:
// See DigiLED.cpp for the implementation of this class
//

class CDigiLEDApp : public CWinApp
{
public:
	CDigiLEDApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDigiLEDApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
	//{{AFX_MSG(CDigiLEDApp)
	afx_msg void OnAppAbout();
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DIGILED_H__197B4388_8A61_41A2_A903_241D1CACCA06__INCLUDED_)
