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
	m_nPlus_01 = 0;
	m_nMinus_01 = 0;
	m_nPlus_02 = 0;
	m_nPlus_03 = 0;
	m_nPlus_04 = 0;
	m_nMinus_02 = 0;
	m_nMinus_03 = 0;
	m_nMinus_04 = 0;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CCFGTOOLDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCFGTOOLDlg)
	DDX_Control(pDX, IDC_STATIC_FRAME, m_Frame);
	DDX_Control(pDX, IDC_DIGIT_STATION_3, m_Station03);
	DDX_Control(pDX, IDC_DIGIT_STATION_4, m_Station04);
	DDX_Control(pDX, IDC_DIGIT_STATION_2, m_Station02);
	DDX_Control(pDX, IDC_DIGIT_STATION_1, m_Station01);
	DDX_Text(pDX, IDC_EDIT_PLUS_01, m_nPlus_01);
	DDV_MinMaxUInt(pDX, m_nPlus_01, 0, 999);
	DDX_Text(pDX, IDC_EDIT_MINUS_01, m_nMinus_01);
	DDV_MinMaxUInt(pDX, m_nMinus_01, 0, 999);
	DDX_Text(pDX, IDC_EDIT_PLUS_2, m_nPlus_02);
	DDV_MinMaxUInt(pDX, m_nPlus_02, 0, 999);
	DDX_Text(pDX, IDC_EDIT_PLUS_3, m_nPlus_03);
	DDV_MinMaxUInt(pDX, m_nPlus_03, 0, 999);
	DDX_Text(pDX, IDC_EDIT_PLUS_4, m_nPlus_04);
	DDV_MinMaxUInt(pDX, m_nPlus_04, 0, 999);
	DDX_Text(pDX, IDC_EDIT_MINUS_2, m_nMinus_02);
	DDV_MinMaxUInt(pDX, m_nMinus_02, 0, 999);
	DDX_Text(pDX, IDC_EDIT_MINUS_3, m_nMinus_03);
	DDV_MinMaxUInt(pDX, m_nMinus_03, 0, 999);
	DDX_Text(pDX, IDC_EDIT_MINUS_4, m_nMinus_04);
	DDV_MinMaxUInt(pDX, m_nMinus_04, 0, 999);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CCFGTOOLDlg, CDialog)
	//{{AFX_MSG_MAP(CCFGTOOLDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_WM_CLOSE()
	ON_BN_CLICKED(IDC_BUTTON_PLUS_01, OnButtonPlus01)
	ON_BN_CLICKED(IDC_BUTTON_PLUS_02, OnButtonPlus02)
	ON_BN_CLICKED(IDC_BUTTON_PLUS_03, OnButtonPlus03)
	ON_BN_CLICKED(IDC_BUTTON_PLUS_04, OnButtonPlus04)
	ON_BN_CLICKED(IDC_BUTTON_MINUS_01, OnButtonMinus01)
	ON_BN_CLICKED(IDC_BUTTON_MINUS_02, OnButtonMinus02)
	ON_BN_CLICKED(IDC_BUTTON_MINUS_03, OnButtonMinus03)
	ON_BN_CLICKED(IDC_BUTTON_MINUS_04, OnButtonMinus04)
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
	this->ShowDisplay();

	CString csWindowText = _T("GameShow LED Display v1.00 - ");	
	this->SetWindowText(csWindowText+_T("Designed by CuongQuay\x99"));

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

void CCFGTOOLDlg::OnButtonPlus01() 
{
	this->UpdateData(TRUE);
	if (m_nPlus_01 >=0 && m_nPlus_01 < 1000)
		if (m_nPoint[0] <1000)
			m_nPoint[0] += m_nPlus_01;
	if (m_nPoint[0] >=1000)
		m_nPoint[0] = 999;
	this->ShowDisplay();
}

void CCFGTOOLDlg::OnButtonPlus02() 
{
	this->UpdateData(TRUE);
	if (m_nPlus_02 >=0 && m_nPlus_02 < 1000)
		if (m_nPoint[1] <1000)
			m_nPoint[1] += m_nPlus_02;
	if (m_nPoint[1] >=1000)
		m_nPoint[1] = 999;
	this->ShowDisplay();
}

void CCFGTOOLDlg::OnButtonPlus03() 
{
	this->UpdateData(TRUE);
	if (m_nPlus_03 >=0 && m_nPlus_03 < 1000)
		if (m_nPoint[2] <1000)
			m_nPoint[2] += m_nPlus_03;
	if (m_nPoint[2] >=1000)
		m_nPoint[2] = 999;
	this->ShowDisplay();
}

void CCFGTOOLDlg::OnButtonPlus04() 
{
	this->UpdateData(TRUE);
	if (m_nPlus_04 >=0 && m_nPlus_04 < 1000)
		if (m_nPoint[3] <1000)
			m_nPoint[3] += m_nPlus_04;
	if (m_nPoint[3] >=1000)
		m_nPoint[3] = 999;
	this->ShowDisplay();
}

void CCFGTOOLDlg::OnButtonMinus01() 
{
	this->UpdateData(TRUE);
	if (m_nMinus_01 >=0 && m_nMinus_01 < 1000)
		if (m_nPoint[0] >=-99)
			m_nPoint[0] -= m_nMinus_01;
	if (m_nPoint[0] <-99)
		m_nPoint[0] = -99;
	this->ShowDisplay();
}

void CCFGTOOLDlg::OnButtonMinus02() 
{
	this->UpdateData(TRUE);
	if (m_nMinus_02 >=0 && m_nMinus_02 < 1000)
		if (m_nPoint[1] >=-99)
			m_nPoint[1] -= m_nMinus_02;
	if (m_nPoint[1] <-99)
		m_nPoint[1] = -99;
	this->ShowDisplay();
}

void CCFGTOOLDlg::OnButtonMinus03() 
{
	this->UpdateData(TRUE);
	if (m_nMinus_03 >=0 && m_nMinus_03 < 1000)
		if (m_nPoint[2] >=-99)
			m_nPoint[2] -= m_nMinus_03;
	if (m_nPoint[2] <-99)
		m_nPoint[2] = -99;
	this->ShowDisplay();
}

void CCFGTOOLDlg::OnButtonMinus04() 
{
	this->UpdateData(TRUE);
	if (m_nMinus_04 >=0 && m_nMinus_04 < 1000)
		if (m_nPoint[3] >=-99)
			m_nPoint[3] -= m_nMinus_04;	
	if (m_nPoint[3] <-99)
		m_nPoint[3] = -99;
	this->ShowDisplay();
}

void CCFGTOOLDlg::SendData()
{
	WORD wParam = 0;
	WORD lParam = MAX_DIGIT;
	BYTE nMsg   = LOAD_DATA_MSG;
		
	BYTE msg[]  = {0x55,0x55,0x55,
					nMsg,
					HIBYTE(wParam),
					LOBYTE(wParam),
					HIBYTE(lParam),
					LOBYTE(lParam)
					};
	// send message command
	if (m_Serial.Write(msg,sizeof(msg))==ERROR_SUCCESS){
		Sleep(100);		
	}
	// send data buffer
	for (int i=0; i< MAX_DIGIT; i++){
		m_Serial.Write(&buffer[i],sizeof(BYTE));
	}
	
}

void CCFGTOOLDlg::DoFormat(int value, BYTE *buff)
{
	if (value >=0){
		buff[0] = (value/100);		
		buff[1] = (value%100)/10;
		buff[2] = (value%100)%10;
		if (buff[0]==0) {
			buff[0] =0x0F;	// off segments
			if (buff[1]==0) buff[1]=0x0F;
		}
	}
	else{
		if ((value%100)/10){		
			buff[0] = 0x0A;		// minus sign
			buff[1] = -(value%100)/10;
			buff[2] = -(value%100)%10;
		}
		else{
			buff[0] = 0x0F;		// off segments
			buff[1] = 0x0A;		// minus sign
			buff[2] = -(value%100)%10;
		}
	}
	
	BYTE xtable[20] = {0};

	FILE* file = NULL;
	file = fopen(_T("config.ini"),_T("rb"));
	if (file == NULL)	return;
	
	TCHAR szBuff[MAX_PATH] = {0};

	BYTE code = 0x00;		
	BYTE index = 0;
	while (fscanf(file,_T("%s"),szBuff) > 0) {
		if (strcmp((const char*)szBuff,_T("[DECODE]"))==0){
			while (fscanf(file,_T("%d = %x"),&index,&code) > 0){						
				xtable[index] = code;
				if (index > 15) break;
			}	
		}
	}

	fclose(file);
		

	if (buff[0]!=0xFF){
		buff[0] = xtable[buff[0]];
	}
	if (buff[1]!=0xFF){
		buff[1] = xtable[buff[1]];
	}
	if (buff[2]!=0xFF){
		buff[2] = xtable[buff[2]];
	}
}

void CCFGTOOLDlg::FormatBuffer()
{
	DoFormat(m_nPoint[0],&buffer[9]);
	DoFormat(m_nPoint[1],&buffer[6]);
	DoFormat(m_nPoint[2],&buffer[3]);
	DoFormat(m_nPoint[3],&buffer[0]);		
}

void CCFGTOOLDlg::ShowDisplay()
{
	CString csText = _T("");
	csText.Format(_T("%3d"),m_nPoint[0]);
	CDigiStatic* pStatic = (CDigiStatic*)GetDlgItem(IDC_DIGIT_STATION_1);
	pStatic->SetText(csText);

	csText.Format(_T("%3d"),m_nPoint[1]);
	pStatic = (CDigiStatic*)GetDlgItem(IDC_DIGIT_STATION_2);
	pStatic->SetText(csText);

	csText.Format(_T("%3d"),m_nPoint[2]);
	pStatic = (CDigiStatic*)GetDlgItem(IDC_DIGIT_STATION_3);
	pStatic->SetText(csText);

	csText.Format(_T("%3d"),m_nPoint[3]);
	pStatic = (CDigiStatic*)GetDlgItem(IDC_DIGIT_STATION_4);
	pStatic->SetText(csText);

	this->FormatBuffer();
	this->SendData();
}

LRESULT CCFGTOOLDlg::OnSerialMsg (WPARAM wParam, LPARAM /*lParam*/)
{
	CSerial::EEvent eEvent = CSerial::EEvent(LOWORD(wParam));
	CSerial::EError eError = CSerial::EError(HIWORD(wParam));

	if (eEvent & CSerial::EEventRecv)
	{
		// Create a clean buffer
		DWORD dwRead;
		char szData[1024*8];
		const int nBuflen = sizeof(szData)-1;

		// Obtain the data from the serial port
		do
		{
			m_Serial.Read(szData,nBuflen,&dwRead);
			szData[dwRead] = '\0';			
			if (dwRead>0)
			{
				if (szData[0]==0x55 && szData[1]== 0x55 && szData[2]==0x55)
				{
					TRACE(_T("READ %d byte(s):"),dwRead);
					for (int i =0; i< int(dwRead); i++){
						TRACE(_T("%02X "),BYTE(szData[i]));
					}
					TRACE(_T("\n"));					
				}
				else
				{
					TRACE(_T("READ = %s \r\n"),szData);
				}
			}
		} while (dwRead == nBuflen);	
			
	}

	return 0;
}
