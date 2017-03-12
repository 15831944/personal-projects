// ConfigApp.h : main header file for the CONFIGAPP application
//

#if !defined(AFX_CONFIGAPP_H__BEB15B18_90AE_4275_B640_3AF87F87EBCF__INCLUDED_)
#define AFX_CONFIGAPP_H__BEB15B18_90AE_4275_B640_3AF87F87EBCF__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CConfigAppApp:
// See ConfigApp.cpp for the implementation of this class
//

class CConfigAppApp : public CWinApp
{
public:
	CConfigAppApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CConfigAppApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CConfigAppApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CONFIGAPP_H__BEB15B18_90AE_4275_B640_3AF87F87EBCF__INCLUDED_)
