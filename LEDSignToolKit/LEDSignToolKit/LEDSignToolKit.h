// LEDSignToolKit.h : main header file for the LEDSIGNTOOLKIT application
//

#if !defined(AFX_LEDSIGNTOOLKIT_H__104C1DFF_5E9C_4DC6_93AF_1607D6888503__INCLUDED_)
#define AFX_LEDSIGNTOOLKIT_H__104C1DFF_5E9C_4DC6_93AF_1607D6888503__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CLEDSignToolKitApp:
// See LEDSignToolKit.cpp for the implementation of this class
//

class CLEDSignToolKitApp : public CWinApp
{
public:
	CLEDSignToolKitApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLEDSignToolKitApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CLEDSignToolKitApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LEDSIGNTOOLKIT_H__104C1DFF_5E9C_4DC6_93AF_1607D6888503__INCLUDED_)
