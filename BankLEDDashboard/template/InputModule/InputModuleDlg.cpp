// InputModuleDlg.cpp : implementation file
//

#include "stdafx.h"
#include "InputModule.h"
#include "InputModuleDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define WM_BITLBUTTONUP		WM_USER + 100
/////////////////////////////////////////////////////////////////////////////
// CInputModuleDlg dialog

CInputModuleDlg::CInputModuleDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CInputModuleDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CInputModuleDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CInputModuleDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CInputModuleDlg)
	DDX_Control(pDX, IDC_STATIC_TEXT, m_Text);
	DDX_Control(pDX, IDC_STATIC_MATRIX, m_ctrlMatrixEdit);
	DDX_Control(pDX, IDC_STATIC_DIGIT, m_Digit);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CInputModuleDlg, CDialog)
	//{{AFX_MSG_MAP(CInputModuleDlg)		
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_ONOFF, OnButtonOnoff)
	ON_BN_CLICKED(IDC_BUTTON1, OnButton1)
	ON_BN_CLICKED(IDOK, OnOk)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CInputModuleDlg message handlers

BOOL CInputModuleDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	m_Digit.InitControl(m_hWnd);
	m_Text.InitControl(0);
	
	m_ctrlMatrixEdit.InitControl(m_hWnd);
	m_ctrlMatrixEdit.SetDigit(50);	
	m_ctrlMatrixEdit.SetBkColor(RGB(0,0,0));
	m_ctrlMatrixEdit.SetColor(RGB(64,0,0),RGB(255,0,0));
	m_ctrlMatrixEdit.SetText("Hello-AAAAAAAAAAAA");

	return TRUE;  // return TRUE  unless you set the focus to a control
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CInputModuleDlg::OnPaint() 
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
HCURSOR CInputModuleDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CInputModuleDlg::OnButtonOnoff() 
{
}

void CInputModuleDlg::OnButton1() 
{

}

BOOL CInputModuleDlg::DestroyWindow() 
{
	m_Digit.DestroyWindow();
	m_ctrlMatrixEdit.DestroyWindow();
	return CDialog::DestroyWindow();
}

void CInputModuleDlg::OnOk() 
{

}
