// DigiLEDView.cpp : implementation of the CDigiLEDView class
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

#define		MAX_LED					317
#define     WAKEUP_CHAR             0xAA
#define     ESCAPE_CHAR             0xFF

#define		__WORK_FILE_NAME	_T("DigiLED.dat")

#define		ID_TIMERTIMEOUT			1080

static BYTE _xtable[]= {
                0x11,0x9F,0x32,0x16,0x9C,0x54,0x50,0x1F,
                0x10,0x14,0xFE,0xEF,0xFF,0xFF,0xFF,0xFF
                };   
/////////////////////////////////////////////////////////////////////////////
// CDigiLEDView

IMPLEMENT_DYNCREATE(CDigiLEDView, CView)

BEGIN_MESSAGE_MAP(CDigiLEDView, CView)
	//{{AFX_MSG_MAP(CDigiLEDView)	
	ON_WM_CREATE()
	ON_WM_SIZE()
	ON_COMMAND(ID_DESIGN_ADDCOMPONENT, OnDesignAddcomponent)
	ON_COMMAND(ID_VIEW_SHOWCONTROLID, OnViewShowcontrolid)
	ON_UPDATE_COMMAND_UI(ID_VIEW_SHOWCONTROLID, OnUpdateViewShowcontrolid)
	ON_COMMAND(ID_FILE_NEW, OnFileNew)
	ON_COMMAND(ID_DESIGN_REPOSITIONCONTROLNUMID, OnDesignRepositioncontrolnumid)
	ON_UPDATE_COMMAND_UI(ID_DESIGN_REPOSITIONCONTROLNUMID, OnUpdateDesignRepositioncontrolnumid)
	ON_COMMAND(ID_FILE_OPEN, OnFileOpen)
	ON_COMMAND(ID_FILE_SAVE, OnFileSave)
	ON_COMMAND(ID_DEVICE_DOWNLOADDATA, OnDeviceDownloaddata)
	ON_COMMAND(ID_DEVICE_CONFIGRUNMODE, OnDeviceConfigrunmode)
	ON_COMMAND(ID_FILE_SAVE_AS, OnFileSaveAs)
	ON_COMMAND(ID_DEVICE_SETRTC, OnDeviceSetrtc)
	//}}AFX_MSG_MAP
	ON_WM_SERIAL(OnSerialMsg)
	ON_WM_ETHERNET(OnEthernetMsg)
	// Standard printing commands	
	ON_WM_TIMER()	
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDView construction/destruction

CDigiLEDView::CDigiLEDView()
{	
	m_bConfig = FALSE;
	m_nCurPage = 0;
	m_pConnectDlg = NULL;
	m_bSending = FALSE;
	m_pLEDFrame = NULL;
	m_pEthernet = NULL;
	m_bShowNumID = FALSE;
	m_csCurrentFile = _T("");
}

CDigiLEDView::~CDigiLEDView()
{
	if (m_pLEDFrame){
		m_pLEDFrame->DestroyWindow();
		delete m_pLEDFrame;
	}
}

BOOL CDigiLEDView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return CView::PreCreateWindow(cs);
}

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDView drawing

void CDigiLEDView::OnDraw(CDC* pDC)
{
	CDigiLEDDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	
	CRect rect;
	GetClientRect(rect);
	CPen pen(PS_NULL,1,RGB(50,50,50));
	CBrush brush(RGB(0,0,0));
	CPen* pOldPen = pDC->SelectObject(&pen);	
	CBrush* brOld = pDC->SelectObject(&brush);	
	pDC->Rectangle(rect);

	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT));			// zero out structure			
	lf.lfHeight = 12;				  			//  size
	lf.lfWeight	= FW_NORMAL;					
	lf.lfQuality= ANTIALIASED_QUALITY;						
#ifdef _UNICODE
	wcscpy_s((LPTSTR)lf.lfFaceName,LF_FACESIZE, _T("Microsoft Sans Serif"));     // request a face name 
#else
	strcpy_s((LPTSTR)lf.lfFaceName,LF_FACESIZE, _T("Microsoft Sans Serif"));     // request a face name 
#endif
	CFont font;
	VERIFY(font.CreateFontIndirect(&lf));		// create the font
	
	CFont* pOldFont = pDC->SelectObject(&font);
#ifdef _UNICODE
	TCHAR szCopyright[] = {	// copyright encode string
		0x66, 0x47, 0x51, 0x4B, 0x45, 0x4C, 0x47, 0x46,
		0x02, 0x40, 0x5B, 0x02, 0x61, 0x57, 0x4D, 0x4C, 
		0x45, 0x73, 0x57, 0x43, 0x5B, 0x8C, 0xBB, 0x00};
#else
	BYTE szCopyright[] = {	// copyright encode string
		0x66, 0x47, 0x51, 0x4B, 0x45, 0x4C, 0x47, 0x46,
		0x02, 0x40, 0x5B, 0x02, 0x61, 0x57, 0x4D, 0x4C, 
		0x45, 0x73, 0x57, 0x43, 0x5B, 0x8C, 0xBB, 0x00};
#endif
	CString csCopyright = _T("Designed by CuongQuay");
	csCopyright += TCHAR(0x00AE);	// copyright
	csCopyright += TCHAR(0x0099);	// trade mark

	csCopyright = _T("");
#ifdef _UNICODE
	for (int i=0; i< (int)wcslen((TCHAR*)szCopyright); i++){
		csCopyright += TCHAR(szCopyright[i]^0x0022);
	}
#else
	for (int i=0; i< (int)strlen((TCHAR*)szCopyright); i++){
		csCopyright += TCHAR(szCopyright[i]^0x0022);
	}
#endif
	rect.right -= 10;
	rect.top = rect.bottom - 20;		
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(100,100,100));	
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	rect.OffsetRect(1,1);
	pDC->SetTextColor(RGB(0,0,0));
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	pDC->SetBkMode(OPAQUE);
	
	csCopyright = _T(" DigiLED v2.0 written by CuongQuay\x99");
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(50,50,50));	
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_LEFT);
	pDC->SetBkMode(OPAQUE);
	
	pDC->SelectObject(pOldFont);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(brOld);

	CView::OnDraw(pDC);
}

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDView printing

BOOL CDigiLEDView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// default preparation
	return DoPreparePrinting(pInfo);
}

void CDigiLEDView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add extra initialization before printing
}

void CDigiLEDView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add cleanup after printing
}

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDView diagnostics

#ifdef _DEBUG
void CDigiLEDView::AssertValid() const
{
	CView::AssertValid();
}

void CDigiLEDView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CDigiLEDDoc* CDigiLEDView::GetDocument() // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CDigiLEDDoc)));
	return (CDigiLEDDoc*)m_pDocument;
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDView message handlers

int CDigiLEDView::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CView::OnCreate(lpCreateStruct) == -1)
		return -1;	
	return 0;
}

void CDigiLEDView::OnSize(UINT nType, int cx, int cy) 
{
	CView::OnSize(nType, cx, cy);
	if (m_pLEDFrame){
		if (IsWindow(m_pLEDFrame->m_hWnd)){
			m_pLEDFrame->SetWindowPos(NULL,0,0,cx,cy-20,SWP_FRAMECHANGED);				
		}
	}
}

void CDigiLEDView::OnInitialUpdate() 
{
	CView::OnInitialUpdate();
	
	m_pLEDFrame = new CLEDFrame();
	if (m_pLEDFrame){
		CRect rect = CRect();
		GetClientRect(&rect);
		m_pLEDFrame->Create(_T(""),WS_CHILD|WS_VISIBLE|SS_NOTIFY,rect,this,0x2201);
		m_pLEDFrame->InitControl(m_hWnd);
		m_pLEDFrame->ShowWindow(SW_SHOW);
		m_pLEDFrame->UpdateWindow();		
	}	
	GetDeviceMode();
	if (_stData.m_nMode == MODE_COMPORT){
		this->InitComm();	
	}
	else{
		m_pEthernet = new CEthernetPort();
		m_pEthernet->m_hWndMsg = m_hWnd;
	}
	this->LoadDigitCode(_xtable);	

	SetTimer(ID_TIMERTIMEOUT,100,NULL);
}

void CDigiLEDView::OnDesignAddcomponent() 
{
	m_pLEDFrame->AddControl();	
}

void CDigiLEDView::OnViewShowcontrolid() 
{
	m_bShowNumID = !m_bShowNumID;
	m_pLEDFrame->ShowControlID(m_bShowNumID);
}

void CDigiLEDView::OnUpdateViewShowcontrolid(CCmdUI* pCmdUI) 
{
	pCmdUI->SetCheck(m_bShowNumID?1:0);	
}

BOOL CDigiLEDView::DestroyWindow() 
{
	m_Serial.Close();
	KillTimer(ID_TIMERTIMEOUT);
	return CView::DestroyWindow();
}

void CDigiLEDView::OnFileNew() 
{
	CFile file(__WORK_FILE_NAME,CFile::modeRead);
	CArchive ar(&file,CArchive::load);
	m_pLEDFrame->LoadControl(ar);
	CMainFrame* pFrame = (CMainFrame*)AfxGetMainWnd();
	if (IsWindow(pFrame->m_hWnd)){
		pFrame->InitTabConrol();
	}
	SetCurrentPage(0);
}

void CDigiLEDView::OnDesignRepositioncontrolnumid() 
{
	m_pLEDFrame->m_nReposition =0;
	m_pLEDFrame->m_bRepositionMod =!m_pLEDFrame->m_bRepositionMod;
}

void CDigiLEDView::OnUpdateDesignRepositioncontrolnumid(CCmdUI* pCmdUI) 
{
	pCmdUI->SetCheck(m_pLEDFrame->m_bRepositionMod?1:0);	
}

void CDigiLEDView::OnFileOpen() 
{	
	TCHAR szError[MAX_PATH];
	try {
		TCHAR szFilter[MAX_PATH] = _T("Design Files (*.led)|*.led|All Files (*.*)|*.*||");
 
		CFileDialog fDlg(TRUE,_T("led"),NULL,OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilter,this);
		if (IDOK==fDlg.DoModal()){	
			m_csCurrentFile = fDlg.GetPathName();
			CFile file(m_csCurrentFile,CFile::modeRead);
			CArchive ar(&file,CArchive::load);
			m_pLEDFrame->LoadControl(ar);
			CMainFrame* pFrame = (CMainFrame*)AfxGetMainWnd();
			if (IsWindow(pFrame->m_hWnd)){
				pFrame->InitTabConrol();
			}
			SetCurrentPage(0);
			m_bShowNumID = FALSE;
		}	
	}
	catch (CFileException* e){
		e->GetErrorMessage(szError,sizeof(szError));
		MessageBox(szError,_T("DigiLED Error"),MB_OK|MB_ICONWARNING);		
	}
	catch (CMemoryException* e){
		e->GetErrorMessage(szError,sizeof(szError));
		MessageBox(szError,_T("DigiLED Error"),MB_OK|MB_ICONWARNING);
	}
}

void CDigiLEDView::OnFileSave() 
{			
	TCHAR szError[MAX_PATH];
	try {
		CFile file(m_csCurrentFile,CFile::modeCreate|CFile::modeWrite);
		CArchive ar(&file,CArchive::store);
		m_pLEDFrame->SaveControl(ar);	
	}
	catch (CFileException* e){
		e->GetErrorMessage(szError,sizeof(szError));
		this->OnFileSaveAs();				
	}
	catch (CMemoryException* e){
		e->GetErrorMessage(szError,sizeof(szError));
		MessageBox(szError,_T("DigiLED Error"),MB_OK|MB_ICONWARNING);
	}
}

void CDigiLEDView::OnFileSaveAs() 
{
	TCHAR szError[MAX_PATH];
	try {

		TCHAR szFilter[MAX_PATH] = _T("Design Files (*.led)|*.led|All Files (*.*)|*.*||");
 
		CFileDialog fDlg(FALSE,_T("led"),NULL,OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilter,this);
		if (IDOK==fDlg.DoModal()){		
			CFile file(fDlg.GetPathName(),CFile::modeCreate|CFile::modeWrite);
			CArchive ar(&file,CArchive::store);
			m_pLEDFrame->SaveControl(ar);
		}
	}
	catch (CFileException* e){
		e->GetErrorMessage(szError,sizeof(szError));
		MessageBox(szError,_T("DigiLED Error"),MB_OK|MB_ICONWARNING);		
	}
	catch (CMemoryException* e){
		e->GetErrorMessage(szError,sizeof(szError));
		MessageBox(szError,_T("DigiLED Error"),MB_OK|MB_ICONWARNING);
	}
}

#define		MAX_TITLE			20
void CDigiLEDView::DownloadData(void)
{
	try {
		int nBuffSize = GetLEDCount();
		BYTE* pBuffer = new BYTE[nBuffSize+MAX_TITLE];
		memset(pBuffer,0x20,nBuffSize+MAX_TITLE);
		if (pBuffer){				
			CString csText;
			csText.Format(_T("Downloading Page %d. Please wait..."),m_nCurPage+1);
			ShowBusyDialog(csText);
			if (GetBuffer(pBuffer,nBuffSize)){
				BYTE* pDataSend = new BYTE[nBuffSize+MAX_TITLE];				
				memset(pDataSend,0xFF,nBuffSize+MAX_TITLE);
				if (FormatBuffer(pBuffer,pDataSend,nBuffSize)){
					CStaticEdit* pLED = m_pLEDFrame->m_arrStaticEdit.GetAt(0);
					if (pLED){
						CString csText;
						pLED->GetPageText(csText,m_nCurPage);
						memcpy(pDataSend+MAX_LED,csText.GetBuffer(MAX_TITLE),MAX_TITLE);
					}
					SendBuffer(pDataSend,MAX_LED+MAX_TITLE);
				}
				delete[] pDataSend;
			}				
		}

		delete[] pBuffer;
	}
	catch (CMemoryException* e){
		throw e;
	}
}

#include "DownloadSettingDlg.h"
void CDigiLEDView::OnDeviceDownloaddata() 
{
	m_nCurPage = 0;
	SetCurrentPage(m_nCurPage);
	CMainFrame* pFrame = (CMainFrame*)AfxGetMainWnd();
	if (IsWindow(pFrame->m_hWnd)){
		pFrame->SetTab(m_nCurPage);
	}
	CDownloadSettingDlg dlg;
	dlg.m_nPage = m_nCurPage;
	dlg.SetTitleText(_T("Download Settings"));	
	if (IDOK==dlg.DoModal()){
		m_nCurPage = dlg.m_nPage;
		m_nShowTime = dlg.m_nShowTime;
		DownloadData();
	}
}

void CDigiLEDView::OnDeviceConfigrunmode() 
{
	CDownloadSettingDlg dlg;
	dlg.m_nPage = m_nCurPage;
	dlg.SetTitleText(_T("Run Mode Settings"));
	if (IDOK==dlg.DoModal()){
		m_bConfig = TRUE;
		m_nCurPage = dlg.m_nPage;
		m_nShowTime = dlg.m_nShowTime;
		this->SendConfig();
	}
}

BOOL CDigiLEDView::InitComm()
{
	char szCOM[10] = "COM1";

	try {
		FILE* file = NULL;
		errno_t err = fopen_s(&file,"config.ini","rb");
		if (file != NULL){
			char szBuff[MAX_PATH] = {0};		
			while (fscanf_s(file,"%s",szBuff,MAX_PATH) > 0) {
				if (strcmp((const char*)szBuff,"[HARDWARE]")==0){
					while (fscanf_s(file,"%s = %s",szBuff,MAX_PATH,szCOM,10) > 0){						
						if (strcmp((const char*)szBuff,"PORT")==0){
							break;
						}
					}	
				}
			}

			fclose(file);
		}
	}
	catch (CFileException* e){
		TCHAR szError[MAX_PATH];
		e->GetErrorMessage(szError,MAX_PATH);
		MessageBox(szError,_T("InitComm"));
	}
	catch (CMemoryException* e){
		TCHAR szError[MAX_PATH];
		e->GetErrorMessage(szError,MAX_PATH);
		MessageBox(szError,_T("InitComm"));
	}
	catch (CException* e){
		throw e;
	}
	TCHAR wcsCOM[10];
#ifdef	_UNICODE
	MultiByteToWideChar(CP_ACP,0,szCOM,10,wcsCOM,10);
#else
	strcpy_s(wcsCOM,10,szCOM);
#endif
	if (m_Serial.Open(wcsCOM,m_hWnd,0)!=ERROR_SUCCESS)
	{
		CString csText = _T("");
		csText.Format(_T("The %s isn't exist or may be used by another program!"),wcsCOM);
		MessageBox(csText,_T("OpenCOMM"),MB_OK);
		return FALSE;
	}	

	// Register only for the receive event
	// m_Serial.SetMask(	CSerial::EEventRecv  );
	m_Serial.SetupReadTimeouts(CSerial::EReadTimeoutNonblocking);
	m_Serial.Setup((CSerial::EBaudrate)CBR_9600);
	 
	return TRUE;
}

LRESULT CDigiLEDView::OnEthernetMsg (WPARAM wParam, LPARAM /*lParam*/)
{
	char szData[1024];  	
	// Could use Receive here if you don’t need the senders address & port   
	int nRead = m_pEthernet->ReceiveFrom(szData, 4096, _stData.m_csClientIp, _stData.m_nServerPort);       
	switch (nRead)   
	{   
	case 0:					// Connection was closed.      
		m_pEthernet->Close();            
		break;   
	case SOCKET_ERROR:      // Connection error
		if (GetLastError() != WSAEWOULDBLOCK)       
		{         
			AfxMessageBox (_T("Can't read from socket"));         
			m_pEthernet->Close();      
		}      
		break;   
	default: // Normal case: Receive() returned the # of bytes received.      
		szData[nRead] = '\0'; //terminate the string (assuming a string for this example)      
		if (((BYTE)szData[0]==WAKEUP_CHAR) && 
			((BYTE)szData[1]== WAKEUP_CHAR) && 
			((BYTE)szData[2]==WAKEUP_CHAR))
		{
			TRACE(_T("READ %d byte(s):"),nRead);
			for (int i =0; i< int(nRead); i++)
				TRACE(_T("%02X "),BYTE(szData[i]));
			TRACE(_T("\n"));
				
			m_bSending = FALSE;
			if (m_bConfig){
				MessageBox(_T("Config Run Mode Successful"));
			}
			else{
				CMainFrame* pFrame = (CMainFrame*)AfxGetMainWnd();
				++m_nCurPage;										
				if (m_nCurPage >=MAX_PAGE){
					m_nCurPage =0;
				}
				else{						
					DownloadData();
				}
				SetCurrentPage(m_nCurPage);
				if (IsWindow(pFrame->m_hWnd)){
					pFrame->SetTab(m_nCurPage);
				}
			}			
		}				
	}
	return 0;
}

LRESULT CDigiLEDView::OnSerialMsg (WPARAM wParam, LPARAM /*lParam*/)
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
				if (((BYTE)szData[0]==WAKEUP_CHAR) && 
					((BYTE)szData[1]== WAKEUP_CHAR) && 
					((BYTE)szData[2]==WAKEUP_CHAR))
				{
					for (int i=0; i< (int)dwRead; i++){
						TRACE("%02X ",(BYTE)szData[i]);
					}
					TRACE("\n");
					m_bSending = FALSE;
					if (m_bConfig){
						MessageBox(_T("Config Run Mode Successful"));
					}
					else{
						CMainFrame* pFrame = (CMainFrame*)AfxGetMainWnd();
						++m_nCurPage;										
						if (m_nCurPage >=MAX_PAGE){
							m_nCurPage =0;
						}
						else{						
							DownloadData();
						}
						SetCurrentPage(m_nCurPage);
						if (IsWindow(pFrame->m_hWnd)){
							pFrame->SetTab(m_nCurPage);
						}
					}				
				}	
			}
		} while (dwRead == nBuflen);	
			
	}

	return 0;

}

BOOL CDigiLEDView::LoadDigitCode(BYTE xtable[])
{	
	return TRUE;
}

UINT CDigiLEDView::GetLEDCount()
{
	int size =0;
	if (!m_pLEDFrame){
		return 0;
	}
	size = m_pLEDFrame->m_arrLEDEdit.GetSize();
	UINT nCount =0;
	for (int i=0; i< size; i++){
		CLEDEdit* pLED = m_pLEDFrame->m_arrLEDEdit.GetAt(i);
		if (pLED){
			nCount += pLED->GetDigits();
		}
	}
	return nCount;
}

BOOL CDigiLEDView::FormatBuffer(PBYTE pBuffIn, PBYTE pBuffOut, int nBuffSize)
{	
	BOOL bSign = FALSE;
	for (int i=0; i< nBuffSize; i++){
		BYTE code = pBuffIn[i];		
		if (code & 0x80){
			bSign = TRUE;
			code &= 0x7F;
		}
		
		if (code >='0' && code <='9'){
			code = code & 0x0F;
		}
		else if (code ==' '){
			code = 0x0F;	// blank
		}
		else if (code =='-'){
			code = 0x0A;	// dash
		}
		else if (code =='.'){
			code = 0x0B;	// dot
		}
		else{
			code = 0x0F;	// blank	
		}
		pBuffOut[i] = _xtable[code];
		if (bSign){
			pBuffOut[i] &= _xtable[0x0B];
			bSign = FALSE;
		}		
	}	
	return TRUE;
}

#define LOAD_DATA_MSG	         1
BOOL CDigiLEDView::SendBuffer(PBYTE pBuffer, int nBuffSize)
{
	WORD lParam = nBuffSize;
	BYTE nMsg   = LOAD_DATA_MSG;
	WORD wParam = m_nCurPage&0xFF;
	wParam = (wParam<<8)|(m_nShowTime&0xFF);	
		
	BYTE msg[]  = {WAKEUP_CHAR,WAKEUP_CHAR,WAKEUP_CHAR,
					nMsg,
					HIBYTE(wParam),
					LOBYTE(wParam),
					HIBYTE(lParam),
					LOBYTE(lParam)
					};
	if (_stData.m_nMode == MODE_COMPORT){
		// send message command
		if (m_Serial.Write(msg,sizeof(msg))==ERROR_SUCCESS){
			Sleep(100);		
		}
		// send data buffer
		for (int i=0; i< nBuffSize; i++){
			m_Serial.Write(&pBuffer[i],sizeof(BYTE));
			BOOL bFound = FALSE;
			for (int idx=0; idx< sizeof(_xtable);idx++){
				if (pBuffer[i] == _xtable[idx]){
					TRACE(_T("%x"),idx);
					bFound = TRUE;
					break;
				}
			}
			if (!bFound){
				TRACE(".",pBuffer[i]);
			}
		}
	}
	else{
		if (m_pEthernet){
			m_pEthernet->m_bReadyToSend = true;
			m_pEthernet->Send(msg,sizeof(msg));
			Sleep(100);	
			m_pEthernet->m_bReadyToSend = true;
			m_pEthernet->Send(pBuffer,nBuffSize);
			Sleep(nBuffSize);			
		}
	}	
	
	m_TimeSent = CTime::GetCurrentTime();
	this->m_bSending = TRUE;

	return TRUE;
}

#define	LOAD_CONFIG_MSG		2
BOOL CDigiLEDView::SendConfig()
{
	WORD lParam = 0;
	BYTE nMsg   = LOAD_CONFIG_MSG;
	WORD wParam = m_nCurPage&0xFF;
	wParam = (wParam<<8)|(m_nShowTime&0xFF);	
		
	BYTE msg[]  = {WAKEUP_CHAR,WAKEUP_CHAR,WAKEUP_CHAR,
					nMsg,
					HIBYTE(wParam),
					LOBYTE(wParam),
					HIBYTE(lParam),
					LOBYTE(lParam)
					};
	if (_stData.m_nMode == MODE_COMPORT){
		// send message command
		if (m_Serial.Write(msg,sizeof(msg))==ERROR_SUCCESS){
			Sleep(100);		
		}
	}
	else{
		if (m_pEthernet){
			m_pEthernet->m_bReadyToSend = true;
			m_pEthernet->Send(msg,sizeof(msg));
			Sleep(100);	
		}
	}
	m_TimeSent = CTime::GetCurrentTime();
	this->m_bSending = TRUE;

	return TRUE;
}

BOOL CDigiLEDView::GetBuffer(PBYTE pBuffer, int nBuffSize)
{	
	if (!m_pLEDFrame){
		return 0;
	}
	int size = m_pLEDFrame->m_arrLEDEdit.GetSize();	
	UINT nCount =0;
	for (int i=0; i< size; i++){
		CLEDEdit* pLED = m_pLEDFrame->m_arrLEDEdit.GetAt(i);
		if (pLED){			
			CString csText;
			if (m_pLEDFrame->IsPageEnable(pLED->GetNumID())){
				pLED->GetPageText(csText,m_nCurPage);
			}
			else{
				pLED->GetPageText(csText,0);
			}
			int length = csText.GetLength();
			if (csText.GetAt(length-2)==0x0D){
				csText.SetAt(length-2,'\0');
				length -= 2;
			}
			else if (csText.GetAt(length-1)==0x0D){
				csText.SetAt(length-1,'\0');
				length -= 1;
			}
			int nPos = csText.Find('.',0);
			if (nPos >=0){
				csText.Remove('.');
				length -=1;
			}
			char szBuff[20];
#ifdef _UNICODE
			WideCharToMultiByte(CP_ACP,0,csText.GetBuffer(20),20,szBuff,20,NULL,NULL);			
#else
			strcpy_s(szBuff,20,csText.GetBuffer(20));
#endif							
			if (nPos >=0){
				szBuff[nPos-1] |= 0x80;
			}
			for (int x=0; x< length; x++){
				*(pBuffer+nCount+length-x-1)=(BYTE)szBuff[x];								
			}
			nCount += pLED->GetDigits()-1;
		}
		else{
			return FALSE;
		}
	}	
	return TRUE;
}

#define     SET_RTC_MSG  3
void CDigiLEDView::OnDeviceSetrtc() 
{
	WORD lParam = 0;
	BYTE nMsg   = SET_RTC_MSG;
	WORD wParam = 0;
	wParam = (wParam<<8)|(m_nShowTime&0xFF);	
		
	BYTE msg[]  = {WAKEUP_CHAR,WAKEUP_CHAR,WAKEUP_CHAR,
					nMsg,
					HIBYTE(wParam),
					LOBYTE(wParam),
					HIBYTE(lParam),
					LOBYTE(lParam)
					};
	if (_stData.m_nMode == MODE_COMPORT){
		// send message command
		if (m_Serial.Write(msg,sizeof(msg))==ERROR_SUCCESS){
			Sleep(100);		
		}
	}
	else{
		if (m_pEthernet){
			m_pEthernet->m_bReadyToSend = true;
			m_pEthernet->Send(msg,sizeof(msg));
			Sleep(100);	
		}
	}
	CTime time = CTime::GetCurrentTime();
	tm gmt_time = *(time.GetGmtTm(&gmt_time));
	BYTE buffer[6] = {gmt_time.tm_mday,gmt_time.tm_mon,(gmt_time.tm_year+1900)%(2000),
					  gmt_time.tm_hour,gmt_time.tm_min,gmt_time.tm_sec}; 
	if (_stData.m_nMode == MODE_COMPORT){	
		m_Serial.Write(buffer,sizeof(buffer));		
	}
	else{
		if (m_pEthernet){
			m_pEthernet->m_bReadyToSend = true;
			m_pEthernet->Send(buffer,sizeof(buffer));
			Sleep(100);	
		}
	}
	m_bConfig = TRUE;
	m_TimeSent = CTime::GetCurrentTime();
	this->m_bSending = TRUE;
}

void CDigiLEDView::OnTimer(UINT_PTR nIDEvent)
{
	if (m_bSending){
		CTime sTime = CTime::GetCurrentTime();
		CTimeSpan interval = sTime-m_TimeSent;
		if (interval > 10){
			m_bSending = FALSE;
			MessageBox(_T("Send data timeout. Please try again"));
		}
	}	
	CView::OnTimer(nIDEvent);
}

void CDigiLEDView::SetCurrentPage(int nPage)
{
	m_nCurPage = nPage;
	m_pLEDFrame->SetCurrentPage(nPage);
}

void CDigiLEDView::ShowBusyDialog(LPCTSTR lpszText)
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



void CDigiLEDView::GetDeviceMode(void)
{
	try {
		FILE* file = NULL;
		errno_t err = fopen_s(&file,"config.ini","rb");
		if (file != NULL){
			char szBuff[MAX_PATH] = {0};		
			while (fscanf_s(file,"%s",szBuff,MAX_PATH) > 0) {
				if (strcmp((const char*)szBuff,"[HARDWARE]")==0){
					while (fscanf_s(file,"%s = %d",szBuff,MAX_PATH,&_stData.m_nMode,10) > 0){						
						if (strcmp((const char*)szBuff,"MODE")==0){
							break;
						}
					}	
				}
			}

			fclose(file);
		}
	}
	catch (CFileException* e){
		TCHAR szError[MAX_PATH];
		e->GetErrorMessage(szError,MAX_PATH);
		MessageBox(szError,_T("GetDeviceMod"));
	}
	catch (CMemoryException* e){
		TCHAR szError[MAX_PATH];
		e->GetErrorMessage(szError,MAX_PATH);
		MessageBox(szError,_T("GetDeviceMod"));
	}
	catch (CException* e){
		throw e;
	}
}
