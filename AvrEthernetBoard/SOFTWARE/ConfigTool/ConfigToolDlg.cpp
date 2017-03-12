// ConfigToolDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ConfigTool.h"
#include "ConfigToolDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

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

/////////////////////////////////////////////////////////////////////////////
// CConfigToolDlg dialog

CConfigToolDlg::CConfigToolDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CConfigToolDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CConfigToolDlg)
	m_csClient = _T("192.168.1.10");
	m_csMACAddr = _T("00-11-22-33-44-55");
	m_nServerPort = 1980;
	m_nClientPort = 1022;
	//}}AFX_DATA_INIT
	m_pEthernet = NULL;
	m_pBroadcast = NULL;
	m_bConnected = FALSE;
	m_bDeviceListing = FALSE;
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CConfigToolDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CConfigToolDlg)
	DDX_Control(pDX, IDC_IPADDRESS_SUBNET, m_ctrlSubnetMask);
	DDX_Control(pDX, IDC_LIST_DEVICE, m_ctrlDeviceList);
	DDX_Control(pDX, IDC_IPADDRESS_CLIENT, m_ctrlClientIP);
	DDX_Control(pDX, IDC_IPADDRESS_SERVER, m_ctrlServerIP);
	DDX_Text(pDX, IDC_EDIT_CLIENT, m_csClient);
	DDX_Text(pDX, IDC_EDIT1, m_csMACAddr);
	DDX_Text(pDX, IDC_EDIT_SRV_ADDR, m_nServerPort);
	DDX_Text(pDX, IDC_EDIT_CLI_ADDR, m_nClientPort);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CConfigToolDlg, CDialog)
	//{{AFX_MSG_MAP(CConfigToolDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_SET, OnButtonSet)
	ON_BN_CLICKED(IDC_BUTTON_GET, OnButtonGet)
	ON_BN_CLICKED(IDC_BUTTON_CONNECT, OnButtonConnect)
	ON_BN_CLICKED(IDC_BUTTON_AUTO_MAC, OnButtonAutoMac)
	ON_BN_CLICKED(IDC_BUTTON_LIST, OnButtonList)
	ON_LBN_SELCHANGE(IDC_LIST_DEVICE, OnSelchangeListDevice)
	//}}AFX_MSG_MAP
	ON_WM_ETHERNET(OnEthernetMsg)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CConfigToolDlg message handlers

BOOL CConfigToolDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	m_ctrlServerIP.SetAddress(192,168,1,2);
	m_ctrlClientIP.SetAddress(192,168,1,10);
	m_ctrlSubnetMask.SetAddress(255,255,255,0);
	
	CSpinButtonCtrl* pSpin = NULL;
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_SVR_ADDR);
	pSpin->SetRange32(1000,9999);
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_CLI_ADDR);
	pSpin->SetRange32(1000,9999);

	OnButtonAutoMac();

	m_pBroadcast = new CEthernetPort(NULL,0,1022);
	m_pBroadcast->m_hWndMsg = m_hWnd;

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CConfigToolDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CConfigToolDlg::OnPaint() 
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
HCURSOR CConfigToolDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CConfigToolDlg::OnOK() 
{	
	CDialog::OnOK();
}

typedef struct _CONFIG_MSG
{
    unsigned short type;
    unsigned char mac_addr[6];
    unsigned short HOST_ADDRESS[2];
    unsigned short SERVER_ADDRESS[2];
	unsigned short SUBNET_MASK[2];
    unsigned short CLIENT_PORT;    
    unsigned short SERVER_PORT;
        
} CONFIG_MSG;

void CConfigToolDlg::OnButtonSet() 
{
	if (m_pEthernet){
		CONFIG_MSG msg;
		msg.type = 0;
		this->UpdateData(TRUE);
		sscanf(m_csMACAddr.GetBuffer(20),"%02X-%02X-%02X-%02X-%02X-%02X",
			&msg.mac_addr[0],&msg.mac_addr[1],&msg.mac_addr[2],
			&msg.mac_addr[3],&msg.mac_addr[4],&msg.mac_addr[5]);		
		BYTE addr[4];
		m_ctrlServerIP.GetAddress(addr[0],addr[1],addr[2],addr[3]);
		msg.SERVER_ADDRESS[0]= htons((addr[0] << 8) | addr[1]); 
		msg.SERVER_ADDRESS[1]= htons((addr[2] << 8) | addr[3]);  
		m_ctrlClientIP.GetAddress(addr[0],addr[1],addr[2],addr[3]);
		msg.HOST_ADDRESS[0]= htons((addr[0] << 8) | addr[1]); 
		msg.HOST_ADDRESS[1]= htons((addr[2] << 8) | addr[3]);  
		m_ctrlSubnetMask.GetAddress(addr[0],addr[1],addr[2],addr[3]);
		msg.SUBNET_MASK[0]= htons((addr[0] << 8) | addr[1]); 
		msg.SUBNET_MASK[1]= htons((addr[2] << 8) | addr[3]);  
		msg.SERVER_PORT = m_nServerPort;
		msg.CLIENT_PORT = m_nClientPort;
		m_pEthernet->m_bReadyToSend = TRUE;
		if (!m_pEthernet->GetLastError()){
			m_pEthernet->Send(&msg,sizeof(msg));
		}
	}
}

void CConfigToolDlg::OnButtonGet() 
{
	if (m_pEthernet){
		CONFIG_MSG msg;
		msg.type = 1;
		this->UpdateData(TRUE);
		sscanf(m_csMACAddr.GetBuffer(20),"%02X-%02X-%02X-%02X-%02X-%02X",
			&msg.mac_addr[0],&msg.mac_addr[1],&msg.mac_addr[2],
			&msg.mac_addr[3],&msg.mac_addr[4],&msg.mac_addr[5]);		
		BYTE addr[4];
		m_ctrlServerIP.GetAddress(addr[0],addr[1],addr[2],addr[3]);
		msg.SERVER_ADDRESS[0]= htons((addr[0] << 8) | addr[1]); 
		msg.SERVER_ADDRESS[1]= htons((addr[2] << 8) | addr[3]);  
		m_ctrlClientIP.GetAddress(addr[0],addr[1],addr[2],addr[3]);
		msg.HOST_ADDRESS[0]= htons((addr[0] << 8) | addr[1]); 
		msg.HOST_ADDRESS[1]= htons((addr[2] << 8) | addr[3]);
		m_ctrlSubnetMask.GetAddress(addr[0],addr[1],addr[2],addr[3]);
		msg.SUBNET_MASK[0]= htons((addr[0] << 8) | addr[1]); 
		msg.SUBNET_MASK[1]= htons((addr[2] << 8) | addr[3]);  
		msg.SERVER_PORT = m_nServerPort;
		msg.CLIENT_PORT = m_nClientPort;
		m_pEthernet->m_bReadyToSend = TRUE;
		if (!m_pEthernet->GetLastError()){
			m_pEthernet->Send(&msg,sizeof(msg));
		}
	}
}

LRESULT CConfigToolDlg::OnEthernetMsg (WPARAM wParam, LPARAM /*lParam*/)
{
	char szData[1024];  	
	UINT nListenPort = 1980;
	CString csIpAddr = m_csClient;
	// Could use Receive here if you don’t need the senders address & port   
	int nRead = 0;
	CEthernetPort* pSock=NULL;
	if (m_bDeviceListing){
		pSock = m_pBroadcast;
	}
	else{
		pSock = m_pEthernet;
	}
	if (pSock){
		nRead = pSock->ReceiveFrom(szData, sizeof(szData), csIpAddr, nListenPort);       	
	}
	
	switch (nRead)   
	{   
	case 0:					// Connection was closed.      
		pSock->Close();            
		break;   
	case SOCKET_ERROR:      // Connection error
		if (GetLastError() != WSAEWOULDBLOCK)       
		{         
			AfxMessageBox ("Socket Receive error!");         
			pSock->Close();      
		}      
		break;   
	default: // Normal case: Receive() returned the # of bytes received.      
		CONFIG_MSG* msg = (CONFIG_MSG*)szData;
		m_csMACAddr.Format("%02X-%02X-%02X-%02X-%02X-%02X",
			msg->mac_addr[0],msg->mac_addr[1],msg->mac_addr[2],
			msg->mac_addr[3],msg->mac_addr[4],msg->mac_addr[5]);
		m_ctrlServerIP.SetAddress(
			msg->SERVER_ADDRESS[0]&0xFF,(msg->SERVER_ADDRESS[0]>>8)&0xFF,
			msg->SERVER_ADDRESS[1]&0xFF,(msg->SERVER_ADDRESS[1]>>8)&0xFF);
		m_ctrlClientIP.SetAddress(
			msg->HOST_ADDRESS[0]&0xFF,(msg->HOST_ADDRESS[0]>>8)&0xFF,
			msg->HOST_ADDRESS[1]&0xFF,(msg->HOST_ADDRESS[1]>>8)&0xFF);
		m_ctrlSubnetMask.SetAddress(
			msg->SUBNET_MASK[0]&0xFF,(msg->SUBNET_MASK[0]>>8)&0xFF,
			msg->SUBNET_MASK[1]&0xFF,(msg->SUBNET_MASK[1]>>8)&0xFF);
		m_nServerPort = msg->SERVER_PORT;
		m_nClientPort = msg->CLIENT_PORT;
		if (m_bDeviceListing){
			m_bDeviceListing=FALSE;
			CString csText=_T("");
			csText.Format("%d.%d.%d.%d",msg->HOST_ADDRESS[0]&0xFF,(msg->HOST_ADDRESS[0]>>8)&0xFF,
			msg->HOST_ADDRESS[1]&0xFF,(msg->HOST_ADDRESS[1]>>8)&0xFF);
			if (m_ctrlDeviceList.FindString(-1,csText)>=0){				
			}
			else{
				m_ctrlDeviceList.AddString(csText);
			}
		}
		this->UpdateData(FALSE);
	}
	return 0;
}

void CConfigToolDlg::OnButtonConnect() 
{
	if (!m_bConnected){
		this->UpdateData(TRUE);		
		m_pEthernet = new CEthernetPort(m_csClient,1980,1022);
		m_pEthernet->m_hWndMsg = m_hWnd;
		if (!m_pEthernet->GetLastError()){
			m_bConnected = TRUE;
			GetDlgItem(IDC_BUTTON_CONNECT)->SetWindowText("Dis&connect");
		}
	}
	else{
		m_bConnected = FALSE;
		delete m_pEthernet;
		m_pEthernet =NULL;
		GetDlgItem(IDC_BUTTON_CONNECT)->SetWindowText("&Connect");
	}
}

BOOL CConfigToolDlg::DestroyWindow() 
{
	if (m_pEthernet){
		delete m_pEthernet;
	}
	if (m_pBroadcast){
		delete m_pBroadcast;
	}
	return CDialog::DestroyWindow();
}

void CConfigToolDlg::OnButtonAutoMac() 
{
	BYTE mac_addr[6];
	mac_addr[0]=0xAC;
	mac_addr[1]=0xDE;
	mac_addr[2]=0x48;
	mac_addr[3]=rand();
	mac_addr[4]=rand();
	mac_addr[5]=rand();
	m_csMACAddr.Format("%02X-%02X-%02X-%02X-%02X-%02X",
		mac_addr[0],mac_addr[1],mac_addr[2],
		mac_addr[3],mac_addr[4],mac_addr[5]);
	this->UpdateData(FALSE);
}

void CConfigToolDlg::OnButtonList() 
{	
	if (!m_pBroadcast->GetLastError()){
		CONFIG_MSG msg;
		msg.type = 1;
		this->UpdateData(TRUE);
		sscanf(m_csMACAddr.GetBuffer(20),"%02X-%02X-%02X-%02X-%02X-%02X",
			&msg.mac_addr[0],&msg.mac_addr[1],&msg.mac_addr[2],
			&msg.mac_addr[3],&msg.mac_addr[4],&msg.mac_addr[5]);		
		BYTE addr[4];
		m_ctrlServerIP.GetAddress(addr[0],addr[1],addr[2],addr[3]);
		msg.SERVER_ADDRESS[0]= htons((addr[0] << 8) | addr[1]); 
		msg.SERVER_ADDRESS[1]= htons((addr[2] << 8) | addr[3]);  
		m_ctrlClientIP.GetAddress(addr[0],addr[1],addr[2],addr[3]);
		msg.HOST_ADDRESS[0]= htons((addr[0] << 8) | addr[1]); 
		msg.HOST_ADDRESS[1]= htons((addr[2] << 8) | addr[3]);  
		msg.SERVER_PORT = m_nServerPort;
		msg.CLIENT_PORT = m_nClientPort;
		m_pBroadcast->m_bReadyToSend = TRUE;
		m_bDeviceListing = TRUE;
		m_pBroadcast->SendBroadcast(&msg,sizeof(msg));	
	}
}

void CConfigToolDlg::OnSelchangeListDevice() 
{
	int sel = m_ctrlDeviceList.GetCurSel();
	if (sel !=LB_ERR){
		CString csText=_T("");
		m_ctrlDeviceList.GetText(sel,csText);
		m_csClient = csText;
		this->UpdateData(FALSE);
	}
}
