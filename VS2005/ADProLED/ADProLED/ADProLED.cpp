// ADProLED.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "ADProLED.h"
#include "MainFrm.h"

#include "ADProLEDDoc.h"
#include "ADProLEDView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

#define	__MAKE_LICENSE

void __getCPUID(DWORD* result,DWORD param)
{
/************************************************/
// GET CPUID command OPCODE = 0xA20F			//
//----------------------------------------------//
// EAX = 0 --> Get Vendor = {EBX-EDX-ECX}		//
// EAX = 1 --> Get EBX,EDX = {Cache,ALU,CPU}	//
// EAX = 2 --> Get Cache Info					//
// EAX = 3 --> Serial no = {EAX,EBX,ECX,EDX}	//
// EAX = 80000000H ->80000004H {adv func CPU}	//
/************************************************/	
#ifndef _DEBUG
	DWORD buffer[4];
__asm 
	{
		MOV EAX, param		

		CPUID			// 27 bytes = 1B		

		MOV dword ptr [buffer+ 0], EAX
		MOV dword ptr [buffer+ 4], EBX
		MOV dword ptr [buffer+ 8], ECX
		MOV dword ptr [buffer+12], EDX
	}

	memcpy(result,buffer,sizeof(DWORD)*4);
#endif
}

BOOL __getHDDSerial(LPDWORD pSerial)
{
	DWORD dwRes = 0;
	TCHAR buffer[MAX_PATH] = {0};
	return GetVolumeInformation(_T("C:\\"),buffer,sizeof(buffer),pSerial,&dwRes,&dwRes,buffer,sizeof(buffer));
}

// CADProLEDApp

BEGIN_MESSAGE_MAP(CADProLEDApp, CWinApp)
	ON_COMMAND(ID_APP_ABOUT, &CADProLEDApp::OnAppAbout)
	// Standard file based document commands
	ON_COMMAND(ID_FILE_NEW, &CWinApp::OnFileNew)
	ON_COMMAND(ID_FILE_OPEN, &CWinApp::OnFileOpen)
	// Standard print setup command
	ON_COMMAND(ID_FILE_PRINT_SETUP, &CWinApp::OnFilePrintSetup)	
END_MESSAGE_MAP()


// CADProLEDApp construction

CADProLEDApp::CADProLEDApp()
{
	EnableHtmlHelp();

	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}


// The one and only CADProLEDApp object

CADProLEDApp theApp;
CGlobalData _stData;
HWND _hWndCAD =NULL;
VDWG _hDwgCAD =NULL;
ARRAY_HLED _arrHLED;
double _gX = 0;
double _gY = 0;
double _gDX = 0;
double _gDY = 0;
double _gdx = 15;
double _gPointSize = 5;

double _gCompPrice[20]={
500,1000,	// RED
2000,2000,	// BLUE
1800,1800,	// GREEN
5000,1000,	// WHITE+OTHER
100000,		// CPU
3000,		// POWER/W
0,			// CASE
0			// EXTRA
};

BYTE	__md5Hash[16];
// CADProLEDApp initialization

BOOL CADProLEDApp::InitInstance()
{
	DWORD dwCPUID = 0;
	__getCPUID(&dwCPUID,3);
	DWORD dwSerial = 0;
	__getHDDSerial(&dwSerial);
	CString csKey;
	csKey.Format(_T("%0004X-%0004X-%0004X-%0004X"),LOWORD(dwCPUID),HIWORD(dwCPUID),
								   LOWORD(dwSerial),HIWORD(dwSerial));
	BYTE digit[16];
	CMD5::MD5((BYTE*)csKey.GetBuffer(csKey.GetLength()),csKey.GetLength(),digit);
	
	TCHAR szDir[MAX_PATH];
	GetSystemDirectory(szDir,sizeof(szDir));
	CString csFile = szDir;	

#ifdef __MAKE_LICENSE
	CString csCmd = _T("448548076255643");
	CTime time = CTime::GetCurrentTime();
		
	if ((wcscmp(m_lpCmdLine,csCmd)==0)){		
		FILE* f = NULL;
		_wfopen_s(&f,csFile + _T("\\WSN0244.dat"),_T("wb"));
		fwrite(digit,sizeof(BYTE),16,f);
		for (int i = 0; i<1024; i++) {
			BYTE data = 0;
			data = rand();
			fwrite(&data,sizeof(BYTE),sizeof(BYTE),f);
		}
		fclose(f);			
		return FALSE;	// just exit for next time
	}
#endif
	FILE* file = NULL;
	_wfopen_s(&file,csFile + _T("\\WSN0244.dat"),_T("rb"));
	if (file!=NULL) {
		BYTE buffer[512];
		size_t count = fread(buffer,sizeof(BYTE),sizeof(buffer),file);
		memcpy(__md5Hash,buffer,16);
		fclose(file);
	}
	BOOL bFound = FALSE;
	for (int ix =0; ix< 16; ix++){
		if (__md5Hash[ix]!=digit[ix]){
			bFound = FALSE;
			break;
		}
		bFound = TRUE;
	}
#ifndef _DEBUG
	if ( !bFound ){		
		return FALSE;
	}
#endif
	// InitCommonControlsEx() is required on Windows XP if an application
	// manifest specifies use of ComCtl32.dll version 6 or later to enable
	// visual styles.  Otherwise, any window creation will fail.
	INITCOMMONCONTROLSEX InitCtrls;
	InitCtrls.dwSize = sizeof(InitCtrls);
	// Set this to include all the common control classes you want to use
	// in your application.
	InitCtrls.dwICC = ICC_WIN95_CLASSES;
	InitCommonControlsEx(&InitCtrls);

	CWinApp::InitInstance();

	// Initialize OLE libraries
	if (!AfxOleInit())
	{
		AfxMessageBox(IDP_OLE_INIT_FAILED);
		return FALSE;
	}
	AfxEnableControlContainer();
	// Standard initialization
	// If you are not using these features and wish to reduce the size
	// of your final executable, you should remove from the following
	// the specific initialization routines you do not need
	// Change the registry key under which our settings are stored
	// TODO: You should modify this string to be something appropriate
	// such as the name of your company or organization
	SetRegistryKey(_T("ADProLED-v1.0"));
	LoadStdProfileSettings(4);  // Load standard INI file options (including MRU)
	LoadSetting();
	// Register the application's document templates.  Document templates
	//  serve as the connection between documents, frame windows and views
	CSingleDocTemplate* pDocTemplate;
	pDocTemplate = new CSingleDocTemplate(
		IDR_MAINFRAME,
		RUNTIME_CLASS(CADProLEDDoc),
		RUNTIME_CLASS(CMainFrame),       // main SDI frame window
		RUNTIME_CLASS(CADProLEDView));
	if (!pDocTemplate)
		return FALSE;
	AddDocTemplate(pDocTemplate);


	// Enable DDE Execute open
	EnableShellOpen();
	RegisterShellFileTypes(TRUE);

	// Parse command line for standard shell commands, DDE, file open
	CCommandLineInfo cmdInfo;
	ParseCommandLine(cmdInfo);


	// Dispatch commands specified on the command line.  Will return FALSE if
	// app was launched with /RegServer, /Register, /Unregserver or /Unregister.
	if (!ProcessShellCommand(cmdInfo))
		return FALSE;

	// The one and only window has been initialized, so show and update it
	m_pMainWnd->ShowWindow(SW_SHOWMAXIMIZED);
	m_pMainWnd->UpdateWindow();
	// call DragAcceptFiles only if there's a suffix
	//  In an SDI app, this should occur after ProcessShellCommand
	// Enable drag/drop open
	m_pMainWnd->DragAcceptFiles();
	m_pMainWnd->SetWindowTextW(_T("Chương trình thiết kế LED Quảng cáo v1.0 - Bản quyền thuộc về Quảng Cáo Ánh Dương :: 15 Giải Phóng - Nam Định"));
	return TRUE;
}



// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	enum { IDD = IDD_ABOUTBOX };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

// Implementation
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()

// App command to run the dialog
void CADProLEDApp::OnAppAbout()
{
	CAboutDlg aboutDlg;
	aboutDlg.DoModal();
}


// CADProLEDApp message handlers


int CADProLEDApp::ExitInstance()
{
	SaveSetting();
	return CWinApp::ExitInstance();
}

void CADProLEDApp::LoadSetting(void)
{
	LPTSTR pszKey = _T("ComponentPrice");

	_gCompPrice[RED_3] = GetProfileInt(pszKey,_T("RED_3"),500);	
	_gCompPrice[RED_5] = GetProfileInt(pszKey,_T("RED_5"),1000);	
	_gCompPrice[BLUE_3] = GetProfileInt(pszKey,_T("BLUE_3"),2000);	
	_gCompPrice[BLUE_5] = GetProfileInt(pszKey,_T("BLUE_5"),2000);	
	_gCompPrice[GREEN_3] = GetProfileInt(pszKey,_T("GREEN_3"),1800);	
	_gCompPrice[GREEN_5] = GetProfileInt(pszKey,_T("GREEN_5"),1800);	
	_gCompPrice[WHITE_3] = GetProfileInt(pszKey,_T("WHITE_3"),5000);	
	_gCompPrice[OTHER] = GetProfileInt(pszKey,_T("OTHER"),1000);	
	_gCompPrice[CPU] = GetProfileInt(pszKey,_T("CPU"),100000);	
	_gCompPrice[POWER] = GetProfileInt(pszKey,_T("POWER"),3000);	
	_gCompPrice[CASE] = GetProfileInt(pszKey,_T("CASE"),100000);	
	_gCompPrice[EXTRA] = GetProfileInt(pszKey,_T("EXTRA"),0);		
	
}

void CADProLEDApp::SaveSetting(void)
{
	LPTSTR pszKey = _T("ComponentPrice");

	WriteProfileInt(pszKey,_T("RED_3"),(int)_gCompPrice[RED_3]);	
	WriteProfileInt(pszKey,_T("RED_5"),(int)_gCompPrice[RED_5]);	
	WriteProfileInt(pszKey,_T("BLUE_3"),(int)_gCompPrice[BLUE_3]);	
	WriteProfileInt(pszKey,_T("BLUE_5"),(int)_gCompPrice[BLUE_5]);	
	WriteProfileInt(pszKey,_T("GREEN_3"),(int)_gCompPrice[GREEN_3]);	
	WriteProfileInt(pszKey,_T("GREEN_5"),(int)_gCompPrice[GREEN_5]);	
	WriteProfileInt(pszKey,_T("WHITE_3"),(int)_gCompPrice[WHITE_3]);	
	WriteProfileInt(pszKey,_T("OTHER"),(int)_gCompPrice[OTHER]);	
	WriteProfileInt(pszKey,_T("CPU"),(int)_gCompPrice[CPU]);	
	WriteProfileInt(pszKey,_T("POWER"),(int)_gCompPrice[POWER]);	
	WriteProfileInt(pszKey,_T("CASE"),(int)_gCompPrice[CASE]);	
	WriteProfileInt(pszKey,_T("EXTRA"),(int)_gCompPrice[EXTRA]);	
}
