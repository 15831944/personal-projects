// CFGTOOLDlg.cpp : implementation file
//

#include "stdafx.h"
#include "CFGTOOL.h"
#include "CFGTOOLDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define     LOAD_DATA_MSG	         1
#define     MAX_DIGIT				12

BYTE buffer[MAX_DIGIT] = {0x00};
/////////////////////////////////////////////////////////////////////////////
// CCFGTOOLDlg dialog

CCFGTOOLDlg::CCFGTOOLDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCFGTOOLDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCFGTOOLDlg)
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CCFGTOOLDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCFGTOOLDlg)
	DDX_Control(pDX, IDC_STATIC_FRAME, m_Frame);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CCFGTOOLDlg, CDialog)
	//{{AFX_MSG_MAP(CCFGTOOLDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_WM_CLOSE()
	//}}AFX_MSG_MAP
	ON_WM_SERIAL(OnSerialMsg)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCFGTOOLDlg message handlers

BOOL CCFGTOOLDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	TCHAR szCOM[10] = _T("COM1");

	FILE* file = NULL;
	file = fopen(_T("config.ini"),_T("rb"));
	if (file != NULL){
		TCHAR szBuff[MAX_PATH] = {0};		
		while (fscanf(file,_T("%s"),szBuff) > 0) {
			if (strcmp((const char*)szBuff,_T("[HARDWARE]"))==0){
				while (fscanf(file,_T("%s = %s"),szBuff,szCOM) > 0){						
					if (strcmp((const char*)szBuff,_T("PORT"))==0){
						break;
					}
				}	
			}
		}

		fclose(file);
	}

	if (m_Serial.Open(szCOM,m_hWnd,0)!=ERROR_SUCCESS)
	{
		CString csText = _T("");
		csText.Format(_T("The %s isn't exist or may be used by another program!"),szCOM);
		MessageBox(csText,_T("OpenCOMM"),MB_OK);
		return FALSE;
	}	

	// Register only for the receive event
	// m_Serial.SetMask(	CSerial::EEventRecv  );
	m_Serial.SetupReadTimeouts(CSerial::EReadTimeoutNonblocking);
	m_Serial.Setup((CSerial::EBaudrate)CBR_9600);

	m_nPoint[0] =m_nPoint[1] =m_nPoint[2] =m_nPoint[3] =0;

	CString csWindowText = _T("GameShow LED Display v1.00 - ");	
	this->SetWindowText(csWindowText+_T("Designed by CuongQuay\x99"));

	m_Frame.InitLEDs();

	return TRUE;  // return TRUE  unless you set the focus to a control
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CCFGTOOLDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{		
		CDialog::OnPaint();		
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CCFGTOOLDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CCFGTOOLDlg::OnOK() 
{	
	this->UpdateData(TRUE);	
}

void CCFGTOOLDlg::OnCancel() 
{

}

void CCFGTOOLDlg::OnClose() 
{
	CDialog::EndDialog(IDOK);
}

LRESULT CCFGTOOLDlg::OnSerialMsg (WPARAM wParam, LPARAM lParam)
{
	return 0;
}