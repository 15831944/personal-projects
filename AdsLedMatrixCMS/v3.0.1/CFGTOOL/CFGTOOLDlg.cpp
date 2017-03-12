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

/////////////////////////////////////////////////////////////////////////////
// CCFGTOOLDlg dialog

CCFGTOOLDlg::CCFGTOOLDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCFGTOOLDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCFGTOOLDlg)
	m_nWidth = 160;
	m_nHeight = 16;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CCFGTOOLDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCFGTOOLDlg)
	DDX_Text(pDX, IDC_EDIT_WIDTH, m_nWidth);
	DDX_Text(pDX, IDC_EDIT_HEIGHT, m_nHeight);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CCFGTOOLDlg, CDialog)
	//{{AFX_MSG_MAP(CCFGTOOLDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_WM_CLOSE()
	//}}AFX_MSG_MAP
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
	
	CSpinButtonCtrl* pSpin = NULL;
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_WIDTH);
	pSpin->SetRange(0,1024);
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_HEIGHT);
	pSpin->SetRange(0,32);

	CString csCOM = _T("COM1");
	if (m_Serial.Open(csCOM,m_hWnd,0)!=ERROR_SUCCESS)
	{
		MessageBox(_T("An error occur while trying to open COM1"),_T("COM"),MB_OK);
	}	

	// Register only for the receive event
	// m_Serial.SetMask(	CSerial::EEventRecv  );
	m_Serial.SetupReadTimeouts(CSerial::EReadTimeoutNonblocking);
	m_Serial.Setup((CSerial::EBaudrate)CBR_9600);

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
	WORD wParam = m_nWidth;
	WORD lParam = m_nHeight;
	BYTE nMsg   = 17;

	PBYTE buffer = NULL;	
	BYTE msg[]  = {0x55,0x55,0x55,
					nMsg,
					HIBYTE(wParam),
					LOBYTE(wParam),
					HIBYTE(lParam),
					LOBYTE(lParam)
					};

	// send message command
	if (m_Serial.Write(msg,sizeof(msg))==ERROR_SUCCESS)
		Sleep(100);		
}

void CCFGTOOLDlg::OnCancel() 
{

}

void CCFGTOOLDlg::OnClose() 
{
	CDialog::EndDialog(IDOK);
}
