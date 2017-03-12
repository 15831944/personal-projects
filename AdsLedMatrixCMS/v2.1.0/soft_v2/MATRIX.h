// MATRIX.h : main header file for the MATRIX application
//

#if !defined(AFX_MATRIX_H__881B17E5_04CB_485B_9E4C_C1F767AD3EC0__INCLUDED_)
#define AFX_MATRIX_H__881B17E5_04CB_485B_9E4C_C1F767AD3EC0__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CMATRIXApp:
// See MATRIX.cpp for the implementation of this class
//

class CMATRIXApp : public CWinApp
{
public:
	void SaveSetting();
	BOOL LoadSetting();
	CMATRIXApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMATRIXApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CMATRIXApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MATRIX_H__881B17E5_04CB_485B_9E4C_C1F767AD3EC0__INCLUDED_)
