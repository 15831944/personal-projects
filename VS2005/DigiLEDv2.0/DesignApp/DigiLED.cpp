// DigiLED.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "DigiLED.h"

#include "MainFrm.h"
#include "DigiLEDDoc.h"
#include "DigiLEDView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

void _DisplayErrorMessage(){
	LPVOID lpMsgBuf;
	FormatMessage( 
		FORMAT_MESSAGE_ALLOCATE_BUFFER | 
		FORMAT_MESSAGE_FROM_SYSTEM | 
		FORMAT_MESSAGE_IGNORE_INSERTS,
		NULL,
		GetLastError(),
		MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
		(LPTSTR) &lpMsgBuf,
		0,
		NULL 
	);
	// Process any inserts in lpMsgBuf.
	// ...
	// Display the string.
	MessageBox( NULL, (LPCTSTR)lpMsgBuf, _T("Error"), MB_OK | MB_ICONINFORMATION );
	// Free the buffer.
	LocalFree( lpMsgBuf );
}

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDApp

BEGIN_MESSAGE_MAP(CDigiLEDApp, CWinApp)
	//{{AFX_MSG_MAP(CDigiLEDApp)
	ON_COMMAND(ID_APP_ABOUT, OnAppAbout)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
	// Standard file based document commands
	ON_COMMAND(ID_FILE_NEW, CWinApp::OnFileNew)
	ON_COMMAND(ID_FILE_OPEN, CWinApp::OnFileOpen)
	// Standard print setup command
	ON_COMMAND(ID_FILE_PRINT_SETUP, CWinApp::OnFilePrintSetup)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDApp construction

CDigiLEDApp::CDigiLEDApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CDigiLEDApp object

CDigiLEDApp theApp;
CGlobalData _stData;
/////////////////////////////////////////////////////////////////////////////
// CDigiLEDApp initialization

BOOL CDigiLEDApp::InitInstance()
{
	AfxEnableControlContainer();

	if (!AfxSocketInit())
	{
		return FALSE;
	}

	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

	// Change the registry key under which our settings are stored.
	// TODO: You should modify this string to be something appropriate
	// such as the name of your company or organization.
	SetRegistryKey(_T("DigiLED-DIYW"));

	LoadStdProfileSettings();  // Load standard INI file options (including MRU)

	LoadSetting();

	// Register the application's document templates.  Document templates
	//  serve as the connection between documents, frame windows and views.

	CSingleDocTemplate* pDocTemplate;
	pDocTemplate = new CSingleDocTemplate(
		IDR_MAINFRAME,
		RUNTIME_CLASS(CDigiLEDDoc),
		RUNTIME_CLASS(CMainFrame),       // main SDI frame window
		RUNTIME_CLASS(CDigiLEDView));
	AddDocTemplate(pDocTemplate);

	// Parse command line for standard shell commands, DDE, file open
	CCommandLineInfo cmdInfo;
	ParseCommandLine(cmdInfo);

	// Dispatch commands specified on the command line
	if (!ProcessShellCommand(cmdInfo))
		return FALSE;

	// The one and only window has been initialized, so show and update it.
	m_pMainWnd->ShowWindow(SW_MAXIMIZE);
	m_pMainWnd->UpdateWindow();
	m_pMainWnd->SetWindowTextA(_T("DigiLED v2.0 - copyright by \xA9 CuongQuay\x99"));

	return TRUE;
}

int CDigiLEDApp::ExitInstance() 
{
	SaveSetting();
	return CWinApp::ExitInstance();
}

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
		// No message handlers
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

// App command to run the dialog
void CDigiLEDApp::OnAppAbout()
{
	CAboutDlg aboutDlg;
	aboutDlg.DoModal();
}

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDApp message handlers


void CDigiLEDApp::LoadSetting(void)
{
	LPTSTR pszKey = _T("Settings");

	_stData.m_csClientIp = GetProfileString(pszKey,_T("m_csClientIp"),_T("192.168.1.10"));
	_stData.m_nClientPort = GetProfileInt(pszKey,_T("m_nClientPort"),2201);
	_stData.m_nServerPort = GetProfileInt(pszKey,_T("m_nServerPort"),1980);

}

void CDigiLEDApp::SaveSetting(void)
{
	LPTSTR pszKey = _T("Settings");

	WriteProfileString(pszKey,_T("m_csClientIp"),	_stData.m_csClientIp);
	WriteProfileInt(pszKey,_T("m_nClientPort"),		_stData.m_nClientPort);
	WriteProfileInt(pszKey,_T("m_nServerPort"),		_stData.m_nServerPort);
}
