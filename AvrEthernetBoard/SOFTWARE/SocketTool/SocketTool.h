// SocketTool.h : main header file for the SOCKETTOOL application
//

#if !defined(AFX_SOCKETTOOL_H__F8756E70_A309_4ACC_85F5_4207006C6025__INCLUDED_)
#define AFX_SOCKETTOOL_H__F8756E70_A309_4ACC_85F5_4207006C6025__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CSocketToolApp:
// See SocketTool.cpp for the implementation of this class
//

class CSocketToolApp : public CWinApp
{
public:
	CSocketToolApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSocketToolApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CSocketToolApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SOCKETTOOL_H__F8756E70_A309_4ACC_85F5_4207006C6025__INCLUDED_)
