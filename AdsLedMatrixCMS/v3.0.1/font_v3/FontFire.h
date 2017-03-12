// FontFire.h : main header file for the FONTFIRE application
//

#if !defined(AFX_FONTFIRE_H__4BC1F870_FB73_4506_9ADC_E2499ACCC892__INCLUDED_)
#define AFX_FONTFIRE_H__4BC1F870_FB73_4506_9ADC_E2499ACCC892__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CFontFireApp:
// See FontFire.cpp for the implementation of this class
//

class CFontFireApp : public CWinApp
{
public:
	CFontFireApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CFontFireApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CFontFireApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_FONTFIRE_H__4BC1F870_FB73_4506_9ADC_E2499ACCC892__INCLUDED_)
