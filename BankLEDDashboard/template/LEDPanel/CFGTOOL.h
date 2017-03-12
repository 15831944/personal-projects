// CFGTOOL.h : main header file for the CFGTOOL application
//

#if !defined(AFX_CFGTOOL_H__6344B394_2296_41EC_B0A5_78EF73D0E977__INCLUDED_)
#define AFX_CFGTOOL_H__6344B394_2296_41EC_B0A5_78EF73D0E977__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CCFGTOOLApp:
// See CFGTOOL.cpp for the implementation of this class
//

class CCFGTOOLApp : public CWinApp
{
public:
	CCFGTOOLApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCFGTOOLApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CCFGTOOLApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CFGTOOL_H__6344B394_2296_41EC_B0A5_78EF73D0E977__INCLUDED_)
