// MATRIX.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "MATRIX.h"
#include "MATRIXDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define		_T_GENERAL_REGKEY	_T("Software\\3iGROUP\\FontFire v1.0\\Settings")
#define		_T_APP_PATH			_T("m_csAppPath")

#include <atlbase.h>
BOOL GetRegKey(CString csKey, LPTSTR szValue)
{
	CRegKey regKey;
	if (ERROR_SUCCESS == regKey.Open(HKEY_CURRENT_USER,_T_GENERAL_REGKEY))
	{		
		DWORD dwCount = sizeof(TCHAR)*MAX_PATH;		
		if (ERROR_SUCCESS == regKey.QueryValue(szValue,csKey,&dwCount))		
		{
			regKey.Close();
			return TRUE;
		}

		regKey.Close();
	}

	return FALSE;
}

BOOL SetRegKey(CString csKey, LPTSTR szValue)
{
	CRegKey regKey;
	if (ERROR_SUCCESS == regKey.Create(HKEY_CURRENT_USER,_T_GENERAL_REGKEY))
	{		
		DWORD dwCount = sizeof(TCHAR)*20;		
		if (ERROR_SUCCESS == regKey.SetValue(szValue,csKey))		
		{
			regKey.Close();
			return TRUE;
		}

		regKey.Close();
	}
	return FALSE;
}

/////////////////////////////////////////////////////////////////////////////
// CMATRIXApp

BEGIN_MESSAGE_MAP(CMATRIXApp, CWinApp)
	//{{AFX_MSG_MAP(CMATRIXApp)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMATRIXApp construction

CMATRIXApp::CMATRIXApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CMATRIXApp object

CMATRIXApp theApp;
CGeneralSettings __SETTING;
/////////////////////////////////////////////////////////////////////////////
// CMATRIXApp initialization

BOOL CMATRIXApp::InitInstance()
{
	AfxEnableControlContainer();

	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.
	AfxInitRichEdit();
	if (!AfxSocketInit())
	{
		return FALSE;
	}

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif
	
	SetRegistryKey(_T("3iGROUP"));
	LoadStdProfileSettings();  // Load standard INI file options (including MRU)
	if(!LoadSetting()){
#ifdef _UNICODE
		MessageBox(NULL,_T("Ch\x1B0"L"\x1A1"L"ng tr\xEC"L"nh \x111"L"\x1B0"L"\x1EE3"L"c kh\x1EDF"L"i \x111"L"\x1ED9"L"ng l\x1EA7"L"n \x111"L"\x1EA7"L"u ti\xEA"L"n v\xE0"L" \x111"L"\xE3"L" \x111"L"\x1B0"L"\x1EE3"L"c c\xE0"L"i \x111"L"\x1EB7"L"t. Xin h\xE3"L"y kh\x1EDF"L"i \x111"L"\x1ED9"L"ng l\x1EA1"L"i ch\x1B0"L"\x1A1"L"ng tr\xEC"L"nh!"),_T("C\xE0"L"i \x111"L"\x1EB7"L"t ch\x1B0"L"\x1A1"L"ng tr\xEC"L"nh"),MB_OK);
#else
		MessageBox(NULL,_T("You are running on the first time. The program is installed. Please try again!"),_T("Install"),MB_OK);
#endif
		return FALSE;
	}

	CMATRIXDlg dlg;
	m_pMainWnd = &dlg;
	
	int nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
		
	}
	else if (nResponse == IDCANCEL)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with Cancel
	}

	this->SaveSetting();

	// Since the dialog has been closed, return FALSE so that we exit the
	//  application, rather than start the application's message pump.
	return FALSE;
}

BOOL CMATRIXApp::LoadSetting()
{
	LPTSTR pszKey = _T("Settings");

	__SETTING.m_nCommPort = GetProfileInt(pszKey,_T("m_nCommPort"),0);	
	__SETTING.m_nColumn = GetProfileInt(pszKey,_T("m_nColumn"),160);
	__SETTING.m_nRow = GetProfileInt(pszKey,_T("m_nRow"),16);
	__SETTING.m_nScale = GetProfileInt(pszKey,_T("m_nScale"),4);
	__SETTING.m_bSaveAfterLoaded = GetProfileInt(pszKey,_T("m_bSaveAfterLoaded"),0);
	//__SETTING.m_csAppPath = GetProfileString(pszKey,_T("m_csAppPath"),_T(""));
	TCHAR szDir[MAX_PATH];
	if(GetRegKey(_T_APP_PATH,szDir)){
		__SETTING.m_csFontPath = szDir;
	}
	else{
		GetCurrentDirectory(sizeof(szDir),szDir);
		SetRegKey(_T_APP_PATH,szDir);
		return FALSE;
	}

	__SETTING.m_csFontText = GetProfileString(pszKey,_T("m_csFontText"),_T(".VnTime_22_B"));
	__SETTING.m_csFontBkGnd = GetProfileString(pszKey,_T("m_csFontBkGnd"),_T(".VnTime_22_B"));

	__SETTING.m_csClientIp = GetProfileString(pszKey,_T("m_csClientIp"),_T("192.168.1.10"));
	__SETTING.m_nClientPort = GetProfileInt(pszKey,_T("m_nClientPort"),2201);
	__SETTING.m_nServerPort = GetProfileInt(pszKey,_T("m_nServerPort"),1980);

	return TRUE;
}

void CMATRIXApp::SaveSetting()
{
	LPTSTR pszKey = _T("Settings");

	WriteProfileInt(pszKey,_T("m_nCommPort"),	__SETTING.m_nCommPort);
	WriteProfileInt(pszKey,_T("m_nColumn"),	__SETTING.m_nColumn);
	WriteProfileInt(pszKey,_T("m_nRow"),	__SETTING.m_nRow);
	WriteProfileInt(pszKey,_T("m_nScale"),	__SETTING.m_nScale);
	WriteProfileInt(pszKey,_T("m_bSaveAfterLoaded"),	__SETTING.m_bSaveAfterLoaded);
	//WriteProfileString(pszKey,_T("m_csAppPath"),	__SETTING.m_csAppPath);
	WriteProfileString(pszKey,_T("m_csFontText"),	__SETTING.m_csFontText);
	WriteProfileString(pszKey,_T("m_csFontBkGnd"),	__SETTING.m_csFontBkGnd);
	WriteProfileString(pszKey,_T("m_csClientIp"),	__SETTING.m_csClientIp);
	WriteProfileInt(pszKey,_T("m_nClientPort"),		__SETTING.m_nClientPort);
	WriteProfileInt(pszKey,_T("m_nServerPort"),	__SETTING.m_nServerPort);
}
