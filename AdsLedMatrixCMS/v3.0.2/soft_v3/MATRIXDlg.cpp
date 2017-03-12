// MATRIXDlg.cpp : implementation file
//

#include "stdafx.h"
#include "MATRIX.h"
#include "MATRIXDlg.h"
#include "ProgressDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#undef		__DEMO_

#define		ID_TIMERTIMEOUT			1980

#define		FRAME_TEXT			0
#define		FRAME_BKGND			1

#define     UNKNOWN_MSG             0

#define     LOAD_FONT_MSG	        1
#define     LOAD_TEXT_MSG           2 
#define     LOAD_BKGND_MSG          3

#define     EEPROM_LOAD_FONT_MSG	 4
#define     EEPROM_SAVE_FONT_MSG	 5
                                       
#define     EEPROM_LOAD_TEXT_MSG     6 
#define     EEPROM_SAVE_TEXT_MSG     7 

#define     EEPROM_LOAD_BKGND_MSG    8
#define     EEPROM_SAVE_BKGND_MSG    9
                                       
#define     EEPROM_LOAD_ALL_MSG		 10
#define     EEPROM_SAVE_ALL_MSG		 11
 
#define     SET_RTC_MSG              12
#define     SET_CFG_MSG              13

#define     LOAD_DEFAULT_MSG         14
#define     LOAD_TEXT_ASCII_MSG      15

#define     POWER_CTRL_MSG           16

#define		MATRIX_WIDTH			240

extern BYTE __md5Hash[16];
extern CGeneralSettings __SETTING;

/////////////////////////////////////////////////////////////////////////////
// CMATRIXDlg dialog

CMATRIXDlg::CMATRIXDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CMATRIXDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CMATRIXDlg)
	m_csText = _T("");
	m_nRate = 10;
	m_csStaticText = _T("");
	m_nScrollMode = 0;	
	m_nColor     = 0;
	m_nColorText = 0;	
	m_bLayer0 = TRUE;
	m_bLayer1 = TRUE;
	m_bLayer2 = TRUE;
	m_bLayer3 = TRUE;
	m_csCommStatus = _T("");
	m_csClock = _T("");
	m_bBkLayer = TRUE;
	m_bGradientBk = FALSE;
	m_bGradientText = FALSE;
	m_csFontBk = __SETTING.m_csFontBkGnd;
	m_csFontText = __SETTING.m_csFontText;
	m_nMaxTimeout = 5;
	m_bSending = FALSE;
	m_nLastLayer = 0;
	m_pConnectDlg = NULL;
	m_nLine = 0;
	m_nLastLine =0;
	//}}AFX_DATA_INIT
	
	for (int line=0 ; line< MAX_LINE; line++){		
		m_Rate[line] = 10;
		m_ScrollMode[line] = 4;
		for (int i=0; i< LAYER_COUNT; i++){
			m_csTextLayer[line][i] = _T("");
			m_ColorText[line][i] = 0;			
			m_GradientText[line][i] = FALSE;		
			m_csFontTextLayer[line][i].Format(__SETTING.m_csFontText,i+1);
		}
	}
	
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CMATRIXDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CMATRIXDlg)	
	DDX_Control(pDX, IDC_STATIC_FRAME, m_StaticFrame);
	DDX_Control(pDX, IDC_LIST_FONT, m_ctrlFontList);
	DDX_Control(pDX, IDC_STATIC_FONT_TEXT, m_StaticFontText);
	DDX_Control(pDX, IDC_STATIC_FONT_BK, m_StaticFontBk);
	DDX_Control(pDX, IDC_BUTTON_LOAD_TEXT_STATIC, m_BnLoadBk);
	DDX_Control(pDX, IDC_BUTTON_LOAD_TEXT, m_BnLoadText);
	DDX_Control(pDX, IDC_COMBO_COLOR, m_ctrlColorStatic);
	DDX_Control(pDX, IDC_COMBO_COLOR_TEXT, m_ctrlColorText);
	DDX_Control(pDX, IDC_LIST_LAYER, m_ctrlLayerList);
	DDX_Control(pDX, IDC_EDIT_TEXT_STATIC, m_EditStaticText);
	DDX_Control(pDX, IDC_EDIT_TEXT, m_EditText);	
	DDX_Text(pDX, IDC_EDIT_TEXT, m_csText);
	DDX_Text(pDX, IDC_EDIT_RATE, m_nRate);
	DDX_Text(pDX, IDC_EDIT_TEXT_STATIC, m_csStaticText);
	DDX_CBIndex(pDX, IDC_COMBO_SCROLL_MODE, m_nScrollMode);	
	DDX_CBIndex(pDX, IDC_COMBO_COLOR, m_nColor);
	DDX_CBIndex(pDX, IDC_COMBO_COLOR_TEXT, m_nColorText);		
	DDX_Check(pDX, IDC_CHECK_LAYER0, m_bLayer0);
	DDX_Check(pDX, IDC_CHECK_LAYER1, m_bLayer1);
	DDX_Check(pDX, IDC_CHECK_LAYER2, m_bLayer2);
	DDX_Check(pDX, IDC_CHECK_LAYER3, m_bLayer3);
	DDX_Text(pDX, IDC_STATIC_COM_STATUS, m_csCommStatus);
	DDX_Text(pDX, IDC_STATIC_CLOCK, m_csClock);
	DDX_Check(pDX, IDC_CHECK_LAYER_BK, m_bBkLayer);
	DDX_Check(pDX, IDC_CHECK_GRADIENT_BK, m_bGradientBk);
	DDX_Check(pDX, IDC_CHECK_GRADIENT_TEXT, m_bGradientText);
	DDX_Text(pDX, IDC_STATIC_FONT_BK, m_csFontBk);
	DDX_Text(pDX, IDC_STATIC_FONT_TEXT, m_csFontText);
	DDX_CBIndex(pDX, IDC_COMBO_LINE, m_nLine);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CMATRIXDlg, CDialog)
	//{{AFX_MSG_MAP(CMATRIXDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_CONVERT, OnButtonConvert)
	ON_BN_CLICKED(IDC_BUTTON_CLEAR, OnButtonClear)
	ON_BN_CLICKED(IDC_STATIC_FONT, OnStaticFont)
	ON_WM_TIMER()
	ON_BN_CLICKED(IDC_BUTTON1, OnButtonStart)
	ON_BN_CLICKED(IDC_BUTTON2, OnButtonStop)
	ON_COMMAND(ID_DEVICE_DOWNLOADDATA, OnDeviceDownloaddata)
	ON_NOTIFY(UDN_DELTAPOS, IDC_SPIN_TOPBOT, OnDeltaposSpinTopbot)
	ON_NOTIFY(UDN_DELTAPOS, IDC_SPIN_LEFTRIGHT, OnDeltaposSpinLeftright)
	ON_COMMAND(ID_DEVICE_DOWLOADSTATICTEXT, OnDeviceDowloadstatictext)
	ON_BN_CLICKED(IDC_BUTTON_LOAD_TEXT, OnButtonLoadText)
	ON_BN_CLICKED(IDC_BUTTON_LOAD_TEXT_STATIC, OnButtonLoadTextStatic)
	ON_CBN_CLOSEUP(IDC_COMBO_SCROLL_MODE, OnCloseupComboScrollMode)
	ON_NOTIFY(UDN_DELTAPOS, IDC_SPIN_LEFTRIGHT_TEXT, OnDeltaposSpinLeftrightText)
	ON_NOTIFY(UDN_DELTAPOS, IDC_SPIN_TOPBOT_TEXT, OnDeltaposSpinTopbotText)
	ON_LBN_SELCHANGE(IDC_LIST_LAYER, OnSelchangeListLayer)
	ON_BN_CLICKED(IDC_BUTTON_MERGE, OnButtonMerge)
	ON_BN_CLICKED(IDC_CHECK_LAYER0, OnCheckLayer0)
	ON_BN_CLICKED(IDC_CHECK_LAYER1, OnCheckLayer1)
	ON_BN_CLICKED(IDC_CHECK_LAYER2, OnCheckLayer2)
	ON_BN_CLICKED(IDC_CHECK_LAYER3, OnCheckLayer3)	
	ON_EN_CHANGE(IDC_EDIT_TEXT_STATIC, OnChangeEditTextStatic)
	ON_CBN_CLOSEUP(IDC_COMBO_COLOR, OnCloseupComboColor)
	ON_CBN_CLOSEUP(IDC_COMBO_COLOR_TEXT, OnCloseupComboColorText)
	ON_WM_CLOSE()
	ON_BN_CLICKED(IDC_BUTTON_CLEAK_BK, OnButtonCleakBk)
	ON_COMMAND(ID_DEVICE_SAVETEXTTOEEPROM, OnDeviceSavetexttoeeprom)
	ON_COMMAND(ID_DEVICE_LOADTEXTFROMEEPROM, OnDeviceLoadtextfromeeprom)
	ON_WM_DESTROY()
	ON_BN_CLICKED(IDC_CHECK_LAYER_BK, OnCheckLayerBk)
	ON_COMMAND(ID_OPTION_SETTINGS, OnOptionSettings)
	ON_COMMAND(ID_DEVICE_STARTSCROLL, OnDeviceStartscroll)
	ON_COMMAND(ID_DEVICE_STOPSCROLL, OnDeviceStopscroll)
	ON_COMMAND(ID_DEVICE_SAVEBACKGROUNDTOEEPROM, OnDeviceSavebackgroundtoeeprom)
	ON_COMMAND(ID_DEVICE_LOADBACKGROUNDFROMEEPROM, OnDeviceLoadbackgroundfromeeprom)
	ON_COMMAND(ID_DEVICE_POWEROFF, OnDevicePoweroff)
	ON_COMMAND(ID_DEVICE_POWERONCOMMAND, OnDevicePoweroncommand)
	ON_EN_CHANGE(IDC_EDIT_TEXT, OnChangeEditText)
	ON_COMMAND(ID_DEVICE_LOADALLDATAFROMEEPROM, OnDeviceLoadalldatafromeeprom)
	ON_COMMAND(ID_DEVICE_SAVEALLDATATOEEPROM, OnDeviceSavealldatatoeeprom)
	ON_COMMAND(ID_DEVICE_RESTOREFACTORYSETTINGS, OnDeviceRestorefactorysettings)
	ON_COMMAND(ID_DEVICE_SETDEVICEDATETIME, OnDeviceSetdevicedatetime)
	ON_COMMAND(ID_DEVICE_STANDBYSETTING, OnDeviceStandbysetting)
	ON_BN_CLICKED(IDC_CHECK_GRADIENT_TEXT, OnCheckGradientText)
	ON_BN_CLICKED(IDC_CHECK_GRADIENT_BK, OnCheckGradientBk)
	ON_COMMAND(ID_DEVICE_DOWNLOADBUILDINCHARACTERFONT, OnDeviceDownloadbuildincharacterfont)
	ON_COMMAND(ID_DEVICE_SAVEBUILDINCHARACTERFONTTOEEPROM, OnDeviceSavebuildincharacterfonttoeeprom)
	ON_COMMAND(ID_DEVICE_LOADBUILDINCHARACTERFONTFROMEEPROM, OnDeviceLoadbuildincharacterfontfromeeprom)
	ON_COMMAND(ID_DEVICE_LOADASCIITEXTUSINGEMBEDEDFONT, OnDeviceLoadasciitextusingembededfont)
	ON_COMMAND(ID_OPTION_FONTFIREEDITOR, OnOptionFontfireeditor)
	ON_LBN_SELCHANGE(IDC_LIST_FONT, OnSelchangeListFont)
	ON_NOTIFY(EN_SELCHANGE, IDC_EDIT_TEXT_STATIC, OnSelchangeEditTextStatic)
	ON_COMMAND(ID_FILE_OPENWORKSPACE, OnFileOpenworkspace)
	ON_COMMAND(ID_FILE_SAVEWORKSPACE, OnFileSaveworkspace)
	ON_BN_CLICKED(IDC_BUTTON_SET, OnButtonSet)
	ON_COMMAND(ID_MOVING_LEFTTEXT, OnMovingLefttext)
	ON_COMMAND(ID_MOVING_RIGHTTEXT, OnMovingRighttext)
	ON_COMMAND(ID_MOVING_TOPTEXT, OnMovingToptext)
	ON_COMMAND(ID_MOVING_BOTTEXT, OnMovingBottext)
	ON_COMMAND(ID_HELP_ABOUT, OnHelpAbout)
	ON_CBN_CLOSEUP(IDC_COMBO_LINE, OnCloseupComboLine)
	//}}AFX_MSG_MAP
	ON_WM_SERIAL(OnSerialMsg)

END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMATRIXDlg message handlers

BOOL CMATRIXDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	CRect rect;
	CWnd* pParent = GetDlgItem(IDC_STATIC_FRAME);

	pParent->GetWindowRect(&rect);	
	this->ScreenToClient(&rect);
		
	CRect rcSCRect = CRect(rect);
	rcSCRect.bottom +=12;
	m_ScrollMatrix.Create(_T(""),SS_SUNKEN|WS_VISIBLE|WS_CHILD|SS_NOTIFY,rcSCRect,this,1280);		
	m_ScrollMatrix.ShowWindow(SW_SHOW);			
	
	GetDlgItem(IDC_STATIC_MATRIX)->GetClientRect(rect);
	m_ctrlMatrix.Create(_T(""),WS_CHILD|SS_NOTIFY,rect,&m_ScrollMatrix);

	m_ctrlMatrix.ShowWindow(SW_SHOW);
	m_ctrlMatrix.UpdateWindow();
	m_ctrlMatrix.SetPixelSize(__SETTING.m_nColumn,__SETTING.m_nRow);
	m_ctrlMatrix.ReCalcLayout(__SETTING.m_nScale);
	m_ctrlMatrix.ClearScreen();

	m_ScrollMatrix.InitScroll(&m_ctrlMatrix);
	m_ScrollMatrix.SetBkColor(RGB(0,0,0));

	m_csClock.Format(_T("%dx%dx%d"),__SETTING.m_nColumn,__SETTING.m_nRow,__SETTING.m_nScale);
		
	m_EditText.InitCharFormat();
	DWORD dwMask = m_EditText.GetEventMask();
	m_EditText.SetEventMask(dwMask | ENM_CHANGE);

	m_EditStaticText.InitCharFormat();
	dwMask = m_EditStaticText.GetEventMask();
	m_EditStaticText.SetEventMask(dwMask | ENM_CHANGE | ENM_SELCHANGE);
		
	CString csDir = __SETTING.m_csFontPath;
	csDir += _T("\\Fonts\\");	
	csDir += __SETTING.m_csFontText;
	m_ctrlMatrix.LoadCharMap(csDir);	
	m_ctrlMatrix.InitDefaultFont();
	m_csFontBk = __SETTING.m_csFontBkGnd;
	m_csFontText = __SETTING.m_csFontText;
	CString csCOM = _T("COM1");
	csCOM.Format(_T("COM%d"),__SETTING.m_nCommPort+1);
	int nRes = IDOK;
	while (nRes==IDOK){		
		if (m_Serial.Open(csCOM,m_hWnd,0)!=ERROR_SUCCESS){
			m_csCommStatus.Format(_T("Kh\xF4"L"ng m\x1EDF"L" \x111"L"\x1B0"L"\x1EE3"L"c c\x1ED5"L"ng COM%d"),__SETTING.m_nCommPort+1);		
			nRes = MessageBox(m_csCommStatus + _T(". Xin h\xE3"L"y ch\x1ECD"L"n c\x1ED5"L"ng kh\xE1"L"c v\xE0"L" kh\x1EDF"L"i \x111"L"\x1ED9"L"ng l\x1EA1"L"i ch\x1B0"L"\x1A1"L"ng tr\xEC"L"nh"),
				_T("Kh\x1EDF"L"i t\x1EA1"L"o COM"),MB_OKCANCEL);
			
		}
		else{
			m_csCommStatus.Format(_T("S\x1EED"L" d\x1EE5"L"ng COM%d 9600, 8, n, 1"),__SETTING.m_nCommPort+1);
			nRes = IDCANCEL;
		}
	}
	this->UpdateData(FALSE);

	// Register only for the receive event
	// m_Serial.SetMask(	CSerial::EEventRecv  );
	m_Serial.SetupReadTimeouts(CSerial::EReadTimeoutNonblocking);
	m_Serial.Setup((CSerial::EBaudrate)CBR_9600);

	CSpinButtonCtrl* pSpin = NULL;
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_TOPBOT);
	pSpin->SetRange(-50,50);
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_LEFTRIGHT);
	pSpin->SetRange(-50,50);
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_TOPBOT_TEXT);
	pSpin->SetRange(-50,50);
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_LEFTRIGHT_TEXT);
	pSpin->SetRange(-50,50);

	for (int i=0; i < LAYER_COUNT; i++)
	{
		CString csLayer = _T("");
		csLayer.Format(_T("L\x1EDB"L"p ch\x1EEF"L" %d"),i+1);
		m_ctrlLayerList.AddString(csLayer);		
	}	
	m_ctrlLayerList.AddString(_T("L\x1EDB"L"p n\x1EC1"L"n $"));	

	m_ctrlLayerList.SetCurSel(0);	
	int nLayer = m_ctrlLayerList.GetCurSel();
	m_ctrlMatrix.SetCurrentLayer(nLayer);

	m_BnLoadText.SetShade(CShadeButtonST::SHS_HARDBUMP);	
	m_BnLoadText.SetAlign(CButtonST::ST_ALIGN_VERT);

	m_BnLoadBk.SetShade(CShadeButtonST::SHS_HARDBUMP);	
	m_BnLoadBk.SetAlign(CButtonST::ST_ALIGN_VERT);	
	
	m_pConnectDlg = new CConnectingDlg(0,this);
	CString csWindowText = _T("LCMS\x0AE"L" v3.02 - ");
	csWindowText += __SETTING.m_csLicense;
	this->SetWindowText(csWindowText+_T(""));

	CComboBox* pCombo = (CComboBox*)GetDlgItem(IDC_COMBO_SCROLL_MODE);	
	pCombo->AddString(_T("Ph\x1EA3"L"i - Tr\xE1"L"i"));	
	pCombo->AddString(_T("Tr\xE1"L"i - Ph\x1EA3"L"i"));
	pCombo->AddString(_T("Tr\xEA"L"n - D\x1B0"L"\x1EDB"L"i"));
	pCombo->AddString(_T("D\x1B0"L"\x1EDB"L"i - Tr\xEA"L"n"));
	pCombo->AddString(_T("Lu\xF4"L"n ch\x1EA1"L"y"));
	pCombo->AddString(_T("Kh\xF4"L"ng d\xF9"L"ng"));
	pCombo->SetCurSel(0);
	m_nScrollMode = 4;	// all in one

	pCombo = (CComboBox*)GetDlgItem(IDC_COMBO_LINE);
	for (i=0; i< MAX_LINE; i++){		
		CString csLine = _T("");
		csLine.Format(_T("D\xF2"L"ng %d"),i+1);
		pCombo->AddString(csLine);	
	}
	pCombo->SetCurSel(0);
	m_nLine = 0;

	this->UpdateData(FALSE);

	this->GetFontList();
	this->OnButtonClear();
	this->OnButtonCleakBk();

	SetTimer(ID_TIMERTIMEOUT,100,NULL);
	return TRUE;  // return TRUE  unless you set the focus to a control
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CMATRIXDlg::OnPaint() 
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
HCURSOR CMATRIXDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CMATRIXDlg::OnButtonConvert() 
{	
	// FontFire Editor loading...
}

void CMATRIXDlg::OnButtonClear() 
{
	this->UpdateData(TRUE);
	int nLayer = m_ctrlLayerList.GetCurSel();
	m_ctrlMatrix.SetCurrentLayer(nLayer);
	m_ctrlMatrix.ClearLayer(nLayer);	
	m_csTextLayer[m_nLine][nLayer] = m_csText = _T("");
	this->UpdateData(FALSE);
}

void CMATRIXDlg::OnStaticFont() 
{

}

void CMATRIXDlg::OnTimer(UINT nIDEvent) 
{		
	if (m_bSending){
		CTime sTime = CTime::GetCurrentTime();
		CTimeSpan interval = sTime-m_TimeSent;
		if (interval > m_nMaxTimeout){
			m_bSending = FALSE;
			MessageBox(_T("Kh\xF4"L"ng nh\x1EAD"L"n \x111"L"\x1B0"L"\x1EE3"L"c th\xF4"L"ng b\xE1"L"o x\xE1"L"c nh\x1EAD"L"n t\x1EEB"L" thi\x1EBF"L"t b\x1ECB"L". Xin h\xE3"L"y th\x1EED"L" l\x1EA1"L"i."),_T("Loi truyen thong."));
		}
	}
	CDialog::OnTimer(nIDEvent);
}

void CMATRIXDlg::OnButtonStart() 
{
	this->UpdateData(TRUE);
	this->OnDevicePoweroncommand();
}

void CMATRIXDlg::OnButtonStop() 
{
	this->UpdateData(TRUE);
	this->OnDevicePoweroff();
}

void CMATRIXDlg::OnButtonSet() 
{
	this->UpdateData(TRUE);
	int sel = m_nLine;
	WORD wParam = 0;
	wParam = m_nScrollMode;
	wParam = (wParam<<8)|m_nRate;	
	SendCommandMsg(SET_CFG_MSG,wParam,sel);
}


/***********************************************************/
// 55 55 55 MSG WPARAM_H WPRARAM_L LPARAM_H LPARAM_L 
//-----------------------------------------------------------
// MSG    = LOAD_RAM_MSG
// WPARAM = length of text in pixel
// LPARAM = reserved
/***********************************************************/
void CMATRIXDlg::OnDeviceDownloaddata() 
{
	this->UpdateData();

	if (TRUE){
		PBYTE pBuffer = NULL;
		int sel = m_nLine;//m_ctrlLayerList.GetCurSel();
		//UINT nLength = m_ctrlMatrix.GetBuffer(&pBuffer,sel);
		this->OnButtonMerge();
		UINT nLength = m_ctrlMatrix.GetBuffer(&pBuffer);
		PBYTE pDest = new BYTE[DATA_LENGTH*4];
		nLength = this->ProcessData(pDest,pBuffer,nLength);
		this->SendCommandMsg(LOAD_TEXT_MSG,nLength,sel);
		this->SendData(LOAD_TEXT_MSG,pDest,nLength);
		delete[] pDest;
	}

	if (__SETTING.m_bSaveAfterLoaded)
		this->OnDeviceSavetexttoeeprom();
}

void CMATRIXDlg::OnDeviceDowloadstatictext() 
{	
	PBYTE pBuffer = NULL;
	UINT nLength = m_ctrlMatrix.GetStaticBuffer(&pBuffer);
	PBYTE pDest = new BYTE[DATA_LENGTH*4];
//	this->ProcessData(pDest,pBuffer,nLength);
	this->SendCommandMsg(LOAD_BKGND_MSG,nLength);
	this->SendData(LOAD_BKGND_MSG,pDest,nLength);
	delete[] pDest;

	if (__SETTING.m_bSaveAfterLoaded)
		this->OnDeviceSavebackgroundtoeeprom();
}

void CMATRIXDlg::OnDeltaposSpinTopbot(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_UPDOWN* pNMUpDown = (NM_UPDOWN*)pNMHDR;
	
	m_ctrlMatrix.MoveStaticText(0,pNMUpDown->iDelta);
	
	*pResult = 0;
}

void CMATRIXDlg::OnDeltaposSpinLeftright(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_UPDOWN* pNMUpDown = (NM_UPDOWN*)pNMHDR;
			
	m_ctrlMatrix.MoveStaticText(-pNMUpDown->iDelta,0);	

	*pResult = 0;
}

void CMATRIXDlg::OnButtonLoadText() 
{
	this->OnDeviceDownloaddata();
}

void CMATRIXDlg::OnButtonLoadTextStatic() 
{
	this->OnDeviceDowloadstatictext();
}

void CMATRIXDlg::OnCloseupComboScrollMode() 
{
	this->UpdateData(TRUE);	
	m_ctrlMatrix.SetScrollMode(m_nScrollMode);	
}

void CMATRIXDlg::OnDeltaposSpinLeftrightText(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_UPDOWN* pNMUpDown = (NM_UPDOWN*)pNMHDR;
	
	int nLayer = m_ctrlLayerList.GetCurSel();
	m_ctrlMatrix.MoveText(-pNMUpDown->iDelta,0,nLayer);

	*pResult = 0;
}

void CMATRIXDlg::OnDeltaposSpinTopbotText(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_UPDOWN* pNMUpDown = (NM_UPDOWN*)pNMHDR;
	
	int nLayer = m_ctrlLayerList.GetCurSel();
	m_ctrlMatrix.MoveText(0,pNMUpDown->iDelta,nLayer);

	*pResult = 0;
}

void CMATRIXDlg::OnSelchangeListLayer() 
{
	this->UpdateData(TRUE);
	CString strFolderName = _T("");
	strFolderName = __SETTING.m_csFontPath;
	strFolderName += _T("\\Fonts");
	
	int nLayer = m_ctrlLayerList.GetCurSel();
	if (nLayer < LAYER_COUNT){
		
		m_ColorText[m_nLine][m_nLastLayer] = m_nColorText; 
		m_ctrlMatrix.SetCurrentLayer(nLayer);
		
		m_csTextLayer[m_nLine][m_nLastLayer] = m_csText;
		m_csText   = m_csTextLayer[m_nLine][nLayer];

		m_GradientText[m_nLine][m_nLastLayer] = m_bGradientText;
		m_bGradientText   = m_GradientText[m_nLine][nLayer];

		m_csFontTextLayer[m_nLine][m_nLastLayer] = m_csFontText;
		m_csFontText   = m_csFontTextLayer[m_nLine][nLayer];	
	
		m_ctrlMatrix.LoadCharMap(strFolderName + _T("\\") + m_csFontText);

		m_nLastLayer = nLayer;
		m_nColorText = m_ColorText[m_nLine][nLayer];			
		
		this->UpdateData(FALSE);

		m_EditText.SetTextColor(m_nColorText+1);
	}
	else{
		m_ctrlMatrix.LoadCharMap(strFolderName + _T("\\") + m_csFontBk);
	}	

}

void CMATRIXDlg::OnButtonMerge() 
{
	CProgressDlg* m_pDlg = NULL;
	m_pDlg = new CProgressDlg(this);

	if (m_pDlg != NULL)
	{
		m_pDlg->Create(IDD_PROGRESS_DIALOG,this);
		m_pDlg->ShowWindow(SW_SHOW);
		m_pDlg->UpdateWindow();
	}

	m_pDlg->m_ctrlProgress.SetRange32(0,1);
	m_pDlg->m_ctrlProgress.SetStep(1);
	m_pDlg->m_ctrlProgress.SetPos(1);
	m_pDlg->m_csText = _T("Merging visible layers...");	
	m_pDlg->UpdateData(FALSE);	Sleep(500);


	this->UpdateData(TRUE);
	BOOL bLayer[4] = {m_bLayer0,m_bLayer1,m_bLayer2,m_bLayer3};
	this->m_ctrlMatrix.ClearScreen();
	for (int i=3; i>= 0; i--)
		if (bLayer[i])
			m_ctrlMatrix.MergeLayer(i);	
	m_ctrlMatrix.SetVisibleLayer(bLayer);

	m_pDlg->DestroyWindow();
	delete m_pDlg;
}

void CMATRIXDlg::OnCheckLayer0() 
{	
	this->UpdateData(TRUE);
	BOOL bLayer[4] = {m_bLayer0,m_bLayer1,m_bLayer2,m_bLayer3};	
	m_ctrlMatrix.SetVisibleLayer(bLayer);
	m_ctrlMatrix.Invalidate(FALSE);
	m_nColorText = m_ColorText[m_nLine][0];
	this->UpdateData(FALSE);
}

void CMATRIXDlg::OnCheckLayer1() 
{
	this->UpdateData(TRUE);
	BOOL bLayer[4] = {m_bLayer0,m_bLayer1,m_bLayer2,m_bLayer3};	
	m_ctrlMatrix.SetVisibleLayer(bLayer);
	m_ctrlMatrix.Invalidate(FALSE);
	m_nColorText = m_ColorText[m_nLine][1];
	this->UpdateData(FALSE);
	
}

void CMATRIXDlg::OnCheckLayer2() 
{
	this->UpdateData(TRUE);
	BOOL bLayer[4] = {m_bLayer0,m_bLayer1,m_bLayer2,m_bLayer3};	
	m_ctrlMatrix.SetVisibleLayer(bLayer);
	m_ctrlMatrix.Invalidate(FALSE);
	m_nColorText = m_ColorText[m_nLine][2];
	this->UpdateData(FALSE);
	
}

void CMATRIXDlg::OnCheckLayer3() 
{
	this->UpdateData(TRUE);
	BOOL bLayer[4] = {m_bLayer0,m_bLayer1,m_bLayer2,m_bLayer3};	
	m_ctrlMatrix.SetVisibleLayer(bLayer);
	m_ctrlMatrix.Invalidate(FALSE);
	m_nColorText = m_ColorText[m_nLine][3];
	this->UpdateData(FALSE);
	
}

void CMATRIXDlg::OnCheckLayerBk() 
{
	this->UpdateData(TRUE);	
	m_ctrlMatrix.SetVisibleBkLayer(m_bBkLayer);
	m_ctrlMatrix.Invalidate(FALSE);
}

void CMATRIXDlg::OnChangeEditText() 
{
	this->UpdateData(TRUE);	
	int nLayer = m_ctrlLayerList.GetCurSel();
	if (nLayer < LAYER_COUNT){
		m_csTextLayer[m_nLine][nLayer] = m_csText;
		m_ctrlMatrix.SetCurrentLayer(nLayer);
	#ifdef _UNICODE
		char buffer[512];
		LPTSTR szData = (LPTSTR)m_csText.GetBuffer(m_csText.GetLength());		
		int length = WideCharToMultiByte(CP_ACP,0,szData,wcslen(szData),buffer,sizeof(buffer),NULL,NULL);	
		buffer[length] = '\0';
		m_ctrlMatrix.LoadText(buffer,m_nColorText+1,m_bGradientText);	
	#else
		m_ctrlMatrix.LoadText(m_csText.GetBuffer(255),m_nColorText+1,m_bGradientText);	
	#endif
		this->UpdateData(FALSE);
	}
}

void CMATRIXDlg::OnChangeEditTextStatic() 
{
	this->UpdateData(TRUE);	
	int nLayer = m_ctrlLayerList.GetCurSel();
	if (nLayer < LAYER_COUNT){
		m_ctrlMatrix.SetCurrentLayer(nLayer);	
	}

#ifdef _UNICODE
	char buffer[512];
	LPTSTR szData = (LPTSTR)m_csStaticText.GetBuffer(m_csStaticText.GetLength());		
	int length = WideCharToMultiByte(CP_ACP,0,szData,wcslen(szData),buffer,sizeof(buffer),NULL,NULL);	
	buffer[length] = '\0';
	m_ctrlMatrix.LoadStaticText(buffer,m_nColor+1,m_bGradientBk);	
#else
	m_ctrlMatrix.LoadStaticText(m_csText.GetBuffer(255),m_nColor+1,m_bGradientBk);	
#endif
	this->UpdateData(FALSE);
}

void CMATRIXDlg::OnCloseupComboColor() 
{		
	this->UpdateData(TRUE);			
	m_ctrlMatrix.ChangeBkColor(m_nColor+1,m_bGradientBk);
	m_ctrlMatrix.Invalidate(FALSE);	
	m_EditStaticText.SetTextColor(m_nColor+1);	
}

void CMATRIXDlg::OnCloseupComboColorText() 
{
	m_ColorText[m_nLine][m_nLastLayer] = m_nColorText;

	this->UpdateData(TRUE);	
	int nLayer = m_ctrlLayerList.GetCurSel();		
	m_ctrlMatrix.SetCurrentLayer(nLayer);
	m_ctrlMatrix.ChangeColor(m_nColorText+1,nLayer,m_bGradientText);
	m_ctrlMatrix.Invalidate(FALSE);	
	m_EditText.SetTextColor(m_nColorText+1);
	m_ColorText[m_nLine][nLayer] = m_nColorText;
	this->UpdateData(FALSE);
}

void CMATRIXDlg::OnOK() 
{

}

void CMATRIXDlg::OnCancel() 
{

}

void CMATRIXDlg::OnClose() 
{	
	CDialog::EndDialog(IDOK);
}

void CMATRIXDlg::OnButtonCleakBk() 
{
	m_csStaticText = _T("");
	m_ctrlMatrix.ClearBkGnd();
	this->UpdateData(FALSE);
}

LRESULT CMATRIXDlg::OnSerialMsg (WPARAM wParam, LPARAM /*lParam*/)
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
				for (int i=0; i< (int)dwRead; i++){
					if (szData[i+0]==0x55 && szData[i+1]== 0x55 && szData[i+2]==0x55)
					{
						if (m_bSending){
							m_bSending = FALSE;
							MessageBox(_T("\x110"L"\xE3"L" truy\x1EC1"L"n xong! Nh\x1EA5"L"n OK \x111"L"\x1EC3"L" ti\x1EBF"L"p t\x1EE5"L"c."));
							if (m_pConnectDlg)
							::PostMessage(m_pConnectDlg->m_hWnd,WM_CLOSE,0,0);
						}
						break;
					}				
				}
			}
		} while (dwRead == nBuflen);	
			
	}

	return 0;
}

#define     MODE_FONT           0x80
#define     MODE_CLOCK          0x40
#define     MODE_POWER          0x20
#define     MODE_STOP           0x10
#define     MODE_3              0x08
#define     MODE_2              0x04
#define     MODE_1              0x02
#define     MODE_0              0x01

void CMATRIXDlg::SetConfigMsg(int nRate, int nStep, int nScroll, int nPowerOff)
{	
	if (!GetPermission(__SETTING.m_csAppPath + _T("\\license.dat"),__SETTING.m_csLicense)){
		return;
	}

	BYTE mode = (nScroll & 0x0F) ;

	if (nStep==0)	mode |= MODE_STOP;
	else	mode &= (~MODE_STOP);
	if (nPowerOff) mode &= (~MODE_POWER);
	else	mode |= MODE_POWER;	
	
	if (nScroll==4){
		mode |= 0x0F;
	}

	int nLayer = m_ctrlLayerList.GetCurSel();

	BYTE msg[8]  = {0x55,0x55,0x55,
					SET_CFG_MSG,
					(BYTE)nLayer,	// wparam H
					(BYTE)nRate,	// wparam L
					(BYTE)(mode),	// lparam H	
					(BYTE)(10)		// lparam L
					};
	// send message command
	if (m_Serial.Write(msg,sizeof(msg))==ERROR_SUCCESS)
		Sleep(100);

}

void CMATRIXDlg::SendExtra(PBYTE pData, int nLength, LPCTSTR szText)
{
#ifndef __DEMO_
	if (!GetPermission(__SETTING.m_csAppPath + _T("\\license.dat"),__SETTING.m_csLicense)){
		return;
	}

	CProgressDlg* m_pDlg = NULL;
	m_pDlg = new CProgressDlg(this);

	if (m_pDlg != NULL)
	{
		m_pDlg->Create(IDD_PROGRESS_DIALOG,this);
		m_pDlg->ShowWindow(SW_SHOW);
		m_pDlg->UpdateWindow();
	}

	m_pDlg->m_ctrlProgress.SetRange32(0,nLength);
	m_pDlg->m_ctrlProgress.SetStep(1);
	m_pDlg->m_csText = szText==NULL?_T("\x110"L"ang n\x1EA1"L"p xu\x1ED1"L"ng..."):szText;
	DWORD dwPos = 0;

	for (int i = 0; i < (int)nLength; i++)
	{
		dwPos ++;
		m_pDlg->m_csProgress.Format(_T("%d%%"),100*(i+1)/nLength);								
		m_pDlg->m_ctrlProgress.SetPos(dwPos);				
		m_pDlg->UpdateData(FALSE);

		m_Serial.Write(pData++,sizeof(BYTE));
		for (int nop =0; nop <10000;nop++);
	}	
	Sleep(100);
	m_pDlg->DestroyWindow();
	delete m_pDlg;
#endif
}

void CMATRIXDlg::SendData(UINT nMsgType, PBYTE pData, UINT nLength, LPCTSTR szText)
{
#ifndef __DEMO_
	if (!GetPermission(__SETTING.m_csAppPath + _T("\\license.dat"),__SETTING.m_csLicense)){
		return;
	}

	CProgressDlg* m_pDlg = NULL;
	m_pDlg = new CProgressDlg(this);

	if (m_pDlg != NULL)
	{
		m_pDlg->Create(IDD_PROGRESS_DIALOG,this);
		m_pDlg->ShowWindow(SW_SHOW);
		m_pDlg->UpdateWindow();
	}

	m_pDlg->m_ctrlProgress.SetRange32(0,nLength*4);
	m_pDlg->m_ctrlProgress.SetPos(0);
	m_pDlg->m_ctrlProgress.SetStep(1);
	m_pDlg->m_csText = (szText==NULL)?_T("\x110"L"ang n\x1EA1"L"p xu\x1ED1"L"ng..."):szText;
	DWORD dwPos = 0;

	if (!GetPermission(__SETTING.m_csAppPath + _T("\\license.dat"),__SETTING.m_csLicense)){
		return;
	}

	for (int i = 0; i < (int)nLength*4; i++)
	{
		dwPos ++;
		m_pDlg->m_csProgress.Format(_T("%d%%"),100*(i)/(nLength*4));								
		m_pDlg->m_ctrlProgress.SetPos(dwPos);				
		m_pDlg->UpdateData(FALSE);

		m_Serial.Write(pData++,sizeof(BYTE));
		for (int nop =0; nop <1000;nop++);				
		
	}	
	Sleep(500);
	m_pDlg->DestroyWindow();
	delete m_pDlg;

	m_nMaxTimeout = (((nLength*4)/64)*20)/1000;
	if (m_nMaxTimeout < 5)	m_nMaxTimeout = 5;
	m_TimeSent = CTime::GetCurrentTime();
	this->m_bSending = TRUE;
#endif
}

void CMATRIXDlg::OnDeviceSavetexttoeeprom() 
{
	this->ShowBusyDialog(GetStringResource(IDS_SAVE_TEXT));	
	this->SendCommandMsg(EEPROM_SAVE_TEXT_MSG);	
}

void CMATRIXDlg::OnDeviceLoadtextfromeeprom() 
{
	this->ShowBusyDialog(GetStringResource(IDS_LOAD_TEXT));	
	this->SendCommandMsg(EEPROM_LOAD_TEXT_MSG);	
}

void CMATRIXDlg::OnDestroy() 
{
	if (m_pConnectDlg)
	{
		m_pConnectDlg->DestroyWindow();
		delete m_pConnectDlg;
	}
	KillTimer(ID_TIMERTIMEOUT);
	m_ctrlMatrix.DestroyWindow();
	CDialog::OnDestroy();			
}

#include "SettingDlg.h"
void CMATRIXDlg::OnOptionSettings() 
{
	CSettingDlg dlg;
	if (dlg.DoModal()==IDOK)
	{
		m_ctrlMatrix.SetPixelSize(__SETTING.m_nColumn,__SETTING.m_nRow);
		m_ctrlMatrix.ReCalcLayout(__SETTING.m_nScale,TRUE);	
		m_ScrollMatrix.InitScroll(&m_ctrlMatrix);
		m_csClock.Format(_T("%dx%dx%d"),__SETTING.m_nColumn,__SETTING.m_nRow,__SETTING.m_nScale);
		this->UpdateData(FALSE);
	}
	
}

void CMATRIXDlg::OnDeviceStartscroll() 
{
	OnButtonStart();	
}

void CMATRIXDlg::OnDeviceStopscroll() 
{
	OnButtonStop();
}

void CMATRIXDlg::OnDeviceSavebackgroundtoeeprom() 
{
	this->ShowBusyDialog(GetStringResource(IDS_SAVE_BACKGROUND));	
	this->SendCommandMsg(EEPROM_SAVE_BKGND_MSG);	
}

void CMATRIXDlg::OnDeviceLoadbackgroundfromeeprom() 
{		
	this->ShowBusyDialog(GetStringResource(IDS_LOAD_BACKGROUND));		
	this->SendCommandMsg(EEPROM_LOAD_BKGND_MSG);	
}

void CMATRIXDlg::OnDevicePoweroff() 
{
	this->SendCommandMsg(POWER_CTRL_MSG,1,0);
}

void CMATRIXDlg::OnDevicePoweroncommand() 
{
	this->SendCommandMsg(POWER_CTRL_MSG,0,0);
}

void CMATRIXDlg::ShowBusyDialog(LPCTSTR lpszText)
{
	if (m_pConnectDlg !=NULL)
	{
		m_pConnectDlg->DestroyWindow();
		delete m_pConnectDlg;
	}

	m_pConnectDlg = new CConnectingDlg(10,this);	
	
	if (m_pConnectDlg)
	{
		if (lpszText)	
			m_pConnectDlg->m_csStatusText = lpszText;		
		m_pConnectDlg->Create(IDD_CONNECTING_STATUS);
		m_pConnectDlg->ShowWindow(SW_SHOW);
		m_pConnectDlg->UpdateWindow();		
	}
}

void CMATRIXDlg::OnDeviceLoadalldatafromeeprom() 
{
	this->UpdateData();
	int sel = m_ctrlLayerList.GetCurSel();
	this->ShowBusyDialog(GetStringResource(IDS_LOAD_ALL_DATA));	
	this->SendCommandMsg(EEPROM_LOAD_ALL_MSG,0,sel);	
}

void CMATRIXDlg::OnDeviceSavealldatatoeeprom() 
{
	this->UpdateData();
	int sel = m_ctrlLayerList.GetCurSel();
	this->ShowBusyDialog(GetStringResource(IDS_SAVE_ALL_DATA));	
	this->SendCommandMsg(EEPROM_SAVE_ALL_MSG,0,sel);	
}

void CMATRIXDlg::OnDeviceRestorefactorysettings() 
{
	this->SendCommandMsg(LOAD_DEFAULT_MSG);
}

void CMATRIXDlg::SendCommandMsg(int nMsg, WORD wParam, WORD lParam)
{
#ifndef __DEMO_
	if (!GetPermission(__SETTING.m_csAppPath + _T("\\license.dat"),__SETTING.m_csLicense)){
		return;
	}

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
	
	m_nMaxTimeout = 5;
	m_TimeSent = CTime::GetCurrentTime();
	this->m_bSending = TRUE;
#endif
}

void CMATRIXDlg::OnDeviceSetdevicedatetime() 
{
	this->SendCommandMsg(SET_RTC_MSG);
	CTime time = CTime::GetCurrentTime();	
	BYTE buffer[6] = {time.GetDay(),time.GetMonth(),time.GetYear()%(2000),
					  time.GetHour(),time.GetMinute(),time.GetSecond()}; 
	m_Serial.Write(buffer,sizeof(buffer));	
}

void CMATRIXDlg::OnDeviceStandbysetting() 
{
	
}

void CMATRIXDlg::OnCheckGradientText() 
{
	this->UpdateData(TRUE);
	int nLayer = m_ctrlLayerList.GetCurSel();
	m_GradientText[m_nLine][nLayer] = m_bGradientText;
	if (m_bGradientText)
	{
		m_ctrlMatrix.GradientLayer(m_ColorText[m_nLine][nLayer]+1,nLayer);
		m_ctrlMatrix.Invalidate(FALSE);
	}
	else
	{
		OnChangeEditText();
	}
}

void CMATRIXDlg::OnCheckGradientBk() 
{
	this->UpdateData(TRUE);
	if (m_bGradientBk)
	{
		m_ctrlMatrix.GradientLayer(m_nColor+1,-1);	
		m_ctrlMatrix.Invalidate(FALSE);
	}
	else
	{
		OnChangeEditTextStatic();
	}
}

void CMATRIXDlg::OnDeviceDownloadbuildincharacterfont() 
{
	PBYTE pBuffer = NULL;
	UINT nLength = m_ctrlMatrix.GetFontBuffer(&pBuffer);
	BYTE char_width[512];
	UINT nTextLength = m_ctrlMatrix.GetFontCharWidthBuffer((PBYTE)char_width);	
	PBYTE pDest = new BYTE[DATA_LENGTH*4];
//	this->ProcessData(pDest,pBuffer,nLength);		
	this->SendCommandMsg(LOAD_FONT_MSG,nLength,nTextLength);
	this->SendData(LOAD_FONT_MSG,pDest,nLength);	
	this->SendExtra(char_width,int(nTextLength*sizeof(WORD)));
	delete[] pDest;

	if (__SETTING.m_bSaveAfterLoaded)
		this->OnDeviceSavebuildincharacterfonttoeeprom();
}

void CMATRIXDlg::OnDeviceSavebuildincharacterfonttoeeprom() 
{
	this->ShowBusyDialog(GetStringResource(IDS_SAVE_CHARACTER_FONT));	
	this->SendCommandMsg(EEPROM_SAVE_FONT_MSG);	
}

void CMATRIXDlg::OnDeviceLoadbuildincharacterfontfromeeprom() 
{
	this->ShowBusyDialog(GetStringResource(IDS_LOAD_CHARACTER_FONT));	
	this->SendCommandMsg(EEPROM_LOAD_FONT_MSG);		
}

void CMATRIXDlg::OnDeviceLoadasciitextusingembededfont() 
{
	this->UpdateData(TRUE);
#ifdef _UNICODE
	char buffer[512];
	LPTSTR szData = (LPTSTR)m_csText.GetBuffer(m_csText.GetLength());		
	int length = WideCharToMultiByte(CP_ACP,0,szData,wcslen(szData),buffer,sizeof(buffer),NULL,NULL);	
	buffer[length] = '\0';
#endif

	WORD lParam = (m_nColorText + 1);
	if(m_bGradientText)	lParam |= 0x04;

	this->ShowBusyDialog(GetStringResource(IDS_LOAD_ASCII_TEXT));	
	this->SendCommandMsg(LOAD_TEXT_ASCII_MSG,length,lParam);	
	this->SendExtra((PBYTE)buffer, length);	
}

CString CMATRIXDlg::GetStringResource(UINT nID)
{
	TCHAR szText[MAX_PATH];
	LoadString(AfxGetApp()->m_hInstance,nID,szText,sizeof(szText));
	return CString(szText);
}

void CMATRIXDlg::GetFontList()
{
	WIN32_FIND_DATA FindFileData;
	HANDLE hFind;
	
	CString strFolderName = _T("\\\\Fonts");
	strFolderName = __SETTING.m_csFontPath;
	strFolderName += _T("\\Fonts");

	hFind = FindFirstFile(strFolderName + _T("\\*"), &FindFileData);
	if (hFind != INVALID_HANDLE_VALUE) {
		do{
			if (FindFileData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY){
			}
			else if (FindFileData.dwFileAttributes != -1 && wcscmp(FindFileData.cFileName,_T(""))){
				CString csPath = strFolderName + _T("\\") + FindFileData.cFileName;
				m_ctrlFontList.AddString(FindFileData.cFileName);
			}	
		}
		while(FindNextFile(hFind,&FindFileData));
	}

	FindClose(hFind);

}

void CMATRIXDlg::OnOptionFontfireeditor() 
{
	PROCESS_INFORMATION pi;	
	STARTUPINFO si;
	memset(&pi,0,sizeof(pi));
	memset(&si,0,sizeof(si));
	si.cb = sizeof(si);
	si.wShowWindow = SW_SHOW;
	CString csFontFire = __SETTING.m_csFontPath + _T("\\FontFire.exe");

	if(!CreateProcess(csFontFire,NULL,NULL,NULL,0,0,0,0,&si,&pi))
	{
		CString csMsg = _T("");
		csMsg.Format(_T("Kh\xF4"L"ng t\xEC"L"m th\x1EA5"L"y FontFire.exe trong th\x1B0"L" m\x1EE5"L"c %s"),__SETTING.m_csFontPath);
		MessageBox(csMsg,_T("FontEditor"));
	}
	
}

void CMATRIXDlg::OnSelchangeListFont() 
{
	int nIndex = m_ctrlFontList.GetCurSel();
	CString csText = _T("");
	m_ctrlFontList.GetText(nIndex,csText);	
	
	CString strFolderName = _T("");
	strFolderName = __SETTING.m_csFontPath;
	strFolderName += _T("\\Fonts");
	m_ctrlMatrix.LoadCharMap(strFolderName + _T("\\") + csText);
	
	if (m_ctrlLayerList.GetCurSel() < 4){
		this->OnChangeEditText();
		m_csFontText = csText;
		__SETTING.m_csFontText = m_csFontText;
	}
	else{
		this->OnChangeEditTextStatic();
		m_csFontBk = csText;
		__SETTING.m_csFontBkGnd = m_csFontBk;
	}
	this->UpdateData(FALSE);

	m_ctrlMatrix.Invalidate(FALSE);
}

void CMATRIXDlg::OnSelchangeEditTextStatic(NMHDR* pNMHDR, LRESULT* pResult) 
{
	SELCHANGE *pSelChange = reinterpret_cast<SELCHANGE *>(pNMHDR);
	// TODO: The control will not send this notification unless you override the
	// CDialog::OnInitDialog() function to send the EM_SETEVENTMASK message
	// to the control with the ENM_SELCHANGE flag ORed into the lParam mask.
	CString strFolderName = _T("");
	strFolderName = __SETTING.m_csFontPath;
	strFolderName += _T("\\Fonts");
	m_ctrlMatrix.LoadCharMap(strFolderName + _T("\\") + m_csFontBk);			
	
	*pResult = 0;
}

void CMATRIXDlg::OnFileOpenworkspace() 
{	
	///////////////////////////////////////////////////////////////////
	// Open Workspace ...
	/*****************************************************************/
	CFileDialog dlg(TRUE,_T("lcm"),NULL,OFN_HIDEREADONLY|OFN_OVERWRITEPROMPT,
		_T("LCMS File(*.lcm)|*.lcm||"));		

	if ( dlg.DoModal() == IDCANCEL )
	{
		return ;	// nothing selected		
	}	

	TRY{
		CFile file(dlg.GetPathName(),CFile::modeRead);
				
		file.Read(&__SETTING.m_nColumn,sizeof(__SETTING.m_nColumn));
		file.Read(&__SETTING.m_nRow,sizeof(__SETTING.m_nRow));
		file.Read(&__SETTING.m_nCommPort,sizeof(__SETTING.m_nCommPort));
		TCHAR szText[255];
		file.Read(szText,255*sizeof(TCHAR));
		__SETTING.m_csFontText = szText;
		file.Read(szText,255*sizeof(TCHAR));		
		__SETTING.m_csFontBkGnd = szText;


		m_ctrlMatrix.SetPixelSize(__SETTING.m_nColumn,__SETTING.m_nRow);
		m_ctrlMatrix.ReCalcLayout(__SETTING.m_nScale,TRUE);		
		m_csClock.Format(_T("%dx%dx%d"),__SETTING.m_nColumn,__SETTING.m_nRow,__SETTING.m_nScale);

		file.Read(szText,255*sizeof(TCHAR));
		m_csText = szText;
		file.Read(szText,255*sizeof(TCHAR));
		m_csFontText = szText;

		for (int line=0; line< MAX_LINE; line++){
			file.Read(&m_Rate[line],sizeof(m_Rate[line]));	
			file.Read(&m_ScrollMode[line],sizeof(m_ScrollMode[line]));	
	
			for (int i =0; i < LAYER_COUNT; i++){
				file.Read(&m_ColorText[line][i],sizeof(m_ColorText[line][i]));	
				file.Read(&m_GradientText[line][i],sizeof(m_GradientText[line][i]));	
				TCHAR szText[255];
				file.Read(szText,255*sizeof(TCHAR));	
				m_csTextLayer[line][i] = szText;
				file.Read(szText,255*sizeof(TCHAR));	
				m_csFontTextLayer[line][i] = szText;
			}
		}
		
		file.Read(&m_nLastLayer,sizeof(m_nLastLayer));
		m_ctrlLayerList.SetCurSel(m_nLastLayer);		

		file.Read(szText,255*sizeof(TCHAR));	
		m_csStaticText = szText;

		file.Read(&m_bBkLayer,sizeof(m_bBkLayer));
		file.Read(&m_bGradientBk,sizeof(m_bGradientBk));
		file.Read(&m_bGradientText,sizeof(m_bGradientText));
		file.Read(&m_bLayer0,sizeof(m_bLayer0));
		file.Read(&m_bLayer1,sizeof(m_bLayer1));
		file.Read(&m_bLayer2,sizeof(m_bLayer2));
		file.Read(&m_bLayer3,sizeof(m_bLayer3));
		file.Read(&m_nColor,sizeof(m_nColor));
		file.Read(&m_nColorText,sizeof(m_nColorText));
		file.Read(&m_nRate,sizeof(m_nRate));
		file.Read(&m_nScrollMode,sizeof(m_nScrollMode));		
		
		m_ctrlMatrix.SetVisibleBkLayer(m_bBkLayer);
		BOOL bLayer[4] = {m_bLayer0,m_bLayer1,m_bLayer2,m_bLayer3};	
		m_ctrlMatrix.SetVisibleLayer(bLayer);	

		this->UpdateData(FALSE);		
		this->OnChangeEditText();
		this->OnChangeEditTextStatic();
		this->OnCheckGradientBk();
		this->OnCheckGradientText();

		m_ctrlMatrix.LoadWorkspace(file);
		file.Close();
	}
	CATCH(CFileException, pEx){
		// Simply show an error message to the user.
		pEx->ReportError();
	}
	AND_CATCH(CMemoryException, pEx)   {
		// We can't recover from this memory exception, so we'll
		// just terminate the app without any cleanup. Normally, an
		// an application should do everything it possibly can to
		// clean up properly and _not_ call AfxAbort().

		AfxAbort();
	}
	END_CATCH
}

void CMATRIXDlg::OnFileSaveworkspace() 
{
	///////////////////////////////////////////////////////////////////
	// Save Workspace as ...
	/*****************************************************************/
	CFileDialog dlg(FALSE,_T("lcm"),NULL,OFN_HIDEREADONLY|OFN_OVERWRITEPROMPT,
		_T("LCMS File(*.lcm)|*.lcm||"));		
	
	if ( dlg.DoModal() == IDCANCEL )
	{
		return ;	// nothing selected		
	}	

	TRY{
		CFile file(dlg.GetPathName(),CFile::modeCreate|CFile::modeWrite);		

		this->UpdateData(TRUE);
				
		file.Write(&__SETTING.m_nColumn,sizeof(__SETTING.m_nColumn));
		file.Write(&__SETTING.m_nRow,sizeof(__SETTING.m_nRow));
		file.Write(&__SETTING.m_nCommPort,sizeof(__SETTING.m_nCommPort));
		file.Write(__SETTING.m_csFontText.GetBuffer(__SETTING.m_csFontText.GetLength()),255*sizeof(TCHAR));
		file.Write(__SETTING.m_csFontBkGnd.GetBuffer(__SETTING.m_csFontBkGnd.GetLength()),255*sizeof(TCHAR));		

		file.Write(m_csText.GetBuffer(m_csText.GetLength()),255*sizeof(TCHAR));
		file.Write(m_csFontText.GetBuffer(m_csFontText.GetLength()),255*sizeof(TCHAR));

		for (int line =0; line < MAX_LINE; line++){		
			file.Write(&m_Rate[line],sizeof(m_Rate[line]));	
			file.Write(&m_ScrollMode[line],sizeof(m_ScrollMode[line]));	
				
			for (int i=0; i< LAYER_COUNT; i++){	
				file.Write(&m_ColorText[line][i],sizeof(m_ColorText[line][i]));	
				file.Write(&m_GradientText[line][i],sizeof(m_GradientText[line][i]));	
				file.Write(m_csTextLayer[line][i].GetBuffer(m_csTextLayer[line][i].GetLength()),255*sizeof(TCHAR));	
				file.Write(m_csFontTextLayer[line][i].GetBuffer(m_csFontTextLayer[line][i].GetLength()),255*sizeof(TCHAR));	
			}
		}
		file.Write(&m_nLastLayer,sizeof(m_nLastLayer));

		file.Write(m_csStaticText.GetBuffer(m_csStaticText.GetLength()),255*sizeof(TCHAR));

		file.Write(&m_bBkLayer,sizeof(m_bBkLayer));
		file.Write(&m_bGradientBk,sizeof(m_bGradientBk));
		file.Write(&m_bGradientText,sizeof(m_bGradientText));
		file.Write(&m_bLayer0,sizeof(m_bLayer0));
		file.Write(&m_bLayer1,sizeof(m_bLayer1));
		file.Write(&m_bLayer2,sizeof(m_bLayer2));
		file.Write(&m_bLayer3,sizeof(m_bLayer3));
		file.Write(&m_nColor,sizeof(m_nColor));
		file.Write(&m_nColorText,sizeof(m_nColorText));
		file.Write(&m_nRate,sizeof(m_nRate));
		file.Write(&m_nScrollMode,sizeof(m_nScrollMode));		

		m_ctrlMatrix.SaveWorkspace(file);
		file.Close();
	}
	CATCH(CFileException, pEx){
		// Simply show an error message to the user.
		pEx->ReportError();
	}
	AND_CATCH(CMemoryException, pEx)   {
		// We can't recover from this memory exception, so we'll
		// just terminate the app without any cleanup. Normally, an
		// an application should do everything it possibly can to
		// clean up properly and _not_ call AfxAbort().

		AfxAbort();
	}
	END_CATCH
}


void CMATRIXDlg::OnMovingLefttext() 
{
	int nLayer = m_ctrlLayerList.GetCurSel();

	if(nLayer<4){
		m_ctrlMatrix.MoveText(-1,0,nLayer);
	}
	else{
		m_ctrlMatrix.MoveStaticText(-1,0,nLayer);
	}
	
}

void CMATRIXDlg::OnMovingRighttext() 
{
	int nLayer = m_ctrlLayerList.GetCurSel();
	
	if(nLayer < LAYER_COUNT){
		m_ctrlMatrix.MoveText(+1,0,nLayer);
	}
	else{
		m_ctrlMatrix.MoveStaticText(+1,0,nLayer);
	}
}

void CMATRIXDlg::OnMovingToptext() 
{
/*	int nLayer = m_ctrlLayerList.GetCurSel();
	
	if(nLayer<4){
		m_ctrlMatrix.MoveText(0,-1,nLayer);
	}
	else{
		m_ctrlMatrix.MoveStaticText(0,-1,nLayer);
	}
*/	
}

void CMATRIXDlg::OnMovingBottext() 
{
/*	int nLayer = m_ctrlLayerList.GetCurSel();
	
	if(nLayer<4){
		m_ctrlMatrix.MoveText(0,+1,nLayer);
	}
	else{
		m_ctrlMatrix.MoveStaticText(0,+1,nLayer);
	}
*/	
}

void CMATRIXDlg::OnHelpAbout() 
{
	MessageBox(GetSerialNo(),_T("Serial Number"));
}

int CMATRIXDlg::ProcessData(PBYTE pDest, PBYTE pSrc, int nLength)
{	
	for(int x=0; x< nLength; x++){
		BYTE col[8] = {0};
		for (int y=0; y< 8;y++){
			col[y] = pSrc[x + y*DATA_LENGTH];
		}
		
		BYTE mask = 0x01;
		for (int b=0; b< 4; b++){
			pDest[x*4+b] = 0;
			for (int i=0; i< 8; i++){
				if (col[i]&mask){
					pDest[x*4+b] |= (1<<i);
				}
								
			}
			mask = mask<<2;
		}
	}

	return nLength;
}

void CMATRIXDlg::OnCloseupComboLine() 
{
	this->UpdateData(TRUE);
	CString strFolderName = _T("");
	strFolderName = __SETTING.m_csFontPath;
	strFolderName += _T("\\Fonts");

	m_ScrollMode[m_nLastLine] = m_nScrollMode;
	m_nScrollMode = m_ScrollMode[m_nLine];

	m_Rate[m_nLastLine] = m_nRate;
	m_nRate = m_Rate[m_nLine];
	
	int nLayer = m_ctrlLayerList.GetCurSel();		
	m_nColorText = m_ColorText[m_nLine][nLayer];			
	m_csText = m_csTextLayer[m_nLine][nLayer];
	m_bGradientText = m_GradientText[m_nLine][nLayer];
	m_csFontText = m_csFontTextLayer[m_nLine][nLayer];
		
	m_ctrlMatrix.LoadCharMap(strFolderName + _T("\\") + m_csFontText);	

	this->UpdateData(FALSE);

	m_nLastLine = m_nLine;
	m_ctrlMatrix.m_nLine = m_nLine;

	m_EditText.SetTextColor(m_nColorText+1);

	m_ctrlMatrix.Invalidate();	
	
	
}
