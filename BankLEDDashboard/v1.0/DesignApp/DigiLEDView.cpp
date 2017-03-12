// DigiLEDView.cpp : implementation of the CDigiLEDView class
//

#include "stdafx.h"
#include "DigiLED.h"

#include "DigiLEDDoc.h"
#include "DigiLEDView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define		ID_TIMERTIMEOUT			1080

#define     WAKEUP_CHAR              0xAA
#define     ESCAPE_CHAR              0xFF

#define		__WORK_FILE_NAME	_T("DigiLED.dat")

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
	ON_WM_TIMER()
	ON_COMMAND(ID_DEVICE_LCMSV20, OnDeviceLcmsv20)
	//}}AFX_MSG_MAP
	ON_WM_SERIAL(OnSerialMsg)
	// Standard printing commands	
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDView construction/destruction

CDigiLEDView::CDigiLEDView()
{	
	m_bSending = FALSE;
	m_pLEDFrame = NULL;
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
	wcscpy((LPTSTR)lf.lfFaceName, _T("Microsoft Sans Serif"));     // request a face name 
#else
	strcpy((LPTSTR)lf.lfFaceName, _T("Microsoft Sans Serif"));     // request a face name 
#endif
	CFont font;
	VERIFY(font.CreateFontIndirect(&lf));		// create the font
	
	CFont* pOldFont = pDC->SelectObject(&font);

	BYTE szCopyright[] = {	// copyright encode string
		0x66, 0x47, 0x51, 0x4B, 0x45, 0x4C, 0x47, 0x46,
		0x02, 0x40, 0x5B, 0x02, 0x61, 0x57, 0x4D, 0x4C, 
		0x45, 0x73, 0x57, 0x43, 0x5B, 0x8C, 0xBB, 0x00};

	CString csCopyright = _T("Designed by CuongQuay");
	csCopyright += TCHAR(0x00AE);	// copyright
	csCopyright += TCHAR(0x0099);	// trade mark

	csCopyright = _T("");
	for (int i=0; i< (int)strlen((TCHAR*)szCopyright); i++){
		csCopyright += TCHAR(szCopyright[i]^0x0022);
	}

	rect.right -= 10;
	rect.top = rect.bottom - 20;		
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(100,100,100));	
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	rect.OffsetRect(1,1);
	pDC->SetTextColor(RGB(0,0,0));
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_RIGHT);
	pDC->SetBkMode(OPAQUE);
	
	csCopyright = _T(" DigiLED v1.0 written by CuongQuay\x99");
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

	this->InitComm();
	this->LoadDigitCode();			
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
		TCHAR szFilter[MAX_PATH] = "Design Files (*.led)|*.led|All Files (*.*)|*.*||";
 
		CFileDialog fDlg(TRUE,_T("led"),NULL,OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilter,this);
		if (IDOK==fDlg.DoModal()){	
			m_csCurrentFile = fDlg.GetPathName();
			CFile file(m_csCurrentFile,CFile::modeRead);
			CArchive ar(&file,CArchive::load);
			m_pLEDFrame->LoadControl(ar);
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

		TCHAR szFilter[MAX_PATH] = "Design Files (*.led)|*.led|All Files (*.*)|*.*||";
 
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
#include "DownloadSettingDlg.h"
void CDigiLEDView::OnDeviceDownloaddata() 
{
	CDownloadSettingDlg dlg;
	dlg.SetTitleText(_T("Download Settings"));
	if (IDOK==dlg.DoModal()){
		m_nCurPage = dlg.m_nPage;
		m_nShowTime = dlg.m_nShowTime;
		try {
			int nBuffSize = GetLEDCount();
			BYTE* pBuffer = new BYTE[nBuffSize+MAX_TITLE];
			if (pBuffer){
				if (GetBuffer(pBuffer,nBuffSize)){					
					if (FormatBuffer(pBuffer,nBuffSize)){
						CStaticEdit* pLED = NULL;											
						if (m_pLEDFrame->m_arrStaticEdit.GetSize()){
							pLED = m_pLEDFrame->m_arrStaticEdit.GetAt(0);
						}
						if (pLED){
							CString csText;
							pLED->GetText(csText);
							memcpy(pBuffer+nBuffSize,csText.GetBuffer(MAX_TITLE),MAX_TITLE);
						}
						SendBuffer(pBuffer,nBuffSize+MAX_TITLE);												
					}
				}
			}

			delete[] pBuffer;
		}
		catch (CMemoryException* e){
			throw e;
		}
	}
}

void CDigiLEDView::OnDeviceConfigrunmode() 
{
	CDownloadSettingDlg dlg;
	dlg.SetTitleText(_T("Run Mode Settings"));
	if (IDOK==dlg.DoModal()){		
		m_nCurPage = dlg.m_nPage;
		m_nShowTime = dlg.m_nShowTime;
		this->SendConfig();
	}
}

BOOL CDigiLEDView::InitComm()
{
	TCHAR szCOM[10] = _T("COM1");

	try {
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
	 
	return TRUE;
}

LRESULT CDigiLEDView::OnSerialMsg (WPARAM wParam, LPARAM /*lParam*/)
{
	CSerial::EEvent eEvent = CSerial::EEvent(LOWORD(wParam));
	CSerial::EError eError = CSerial::EError(HIWORD(wParam));

	if (eEvent & CSerial::EEventRecv)
	{
		// Create a clean buffer
		DWORD dwRead;
		BYTE szData[1024*8];
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
					MessageBox(_T("Download data succefull!"));
				}		
			}
		} while (dwRead == nBuflen);	
			
	}

	return 0;

}

BOOL CDigiLEDView::LoadDigitCode()
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

BOOL CDigiLEDView::FormatBuffer(PBYTE pBuffer, int nBuffSize)
{
	for (int i=0; i< nBuffSize; i++){
		BYTE code = pBuffer[i];		
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
		pBuffer[i] = _xtable[code];			
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

	// send message command
	if (m_Serial.Write(msg,sizeof(msg))==ERROR_SUCCESS){
		Sleep(100);		
	}
	// send data buffer
	for (int i=0; i< nBuffSize; i++){
		m_Serial.Write(&pBuffer[i],sizeof(BYTE));		
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

	// send message command
	if (m_Serial.Write(msg,sizeof(msg))==ERROR_SUCCESS){
		Sleep(100);		
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
			pLED->GetText(csText);
			int length = csText.GetLength(); // bypass 0D-0A
			if (csText.GetAt(length-2)==0x0D){
				csText.SetAt(length-2,'\0');
				length -= 2;
			}
			//memcpy(pBuffer+nCount,csText.GetBuffer(length),length);
			TCHAR szBuff[12];
			strcpy(szBuff,csText.GetBuffer(length));			
			for (int x=0; x< length; x++){
				*(pBuffer+nCount+length-x-1)=szBuff[x];
			}
			nCount += pLED->GetDigits();
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

	// send message command
	if (m_Serial.Write(msg,sizeof(msg))==ERROR_SUCCESS){
		Sleep(100);		
	}
	CTime time = CTime::GetCurrentTime();
	tm gmt_time = *(time.GetGmtTm(&gmt_time));
	BYTE buffer[6] = {gmt_time.tm_mday,gmt_time.tm_mon,(gmt_time.tm_year+1900)%(2000),
					  gmt_time.tm_hour,gmt_time.tm_min,gmt_time.tm_sec}; 
	m_Serial.Write(buffer,sizeof(buffer));	
	
	m_TimeSent = CTime::GetCurrentTime();
	this->m_bSending = TRUE;

}

void CDigiLEDView::OnTimer(UINT nIDEvent) 
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

void CDigiLEDView::OnDeviceLcmsv20() 
{
	PROCESS_INFORMATION pi;	
	STARTUPINFO si;
	memset(&pi,0,sizeof(pi));
	memset(&si,0,sizeof(si));
	si.cb = sizeof(si);
	si.wShowWindow = SW_SHOW;
	CString csFontFire = _T("LCMSv2.exe");	

	if(!CreateProcess(csFontFire,NULL,NULL,NULL,0,0,0,0,&si,&pi))
	{
		CString csMsg = _T("LCMSv2.exe do not found");		
		MessageBox(csMsg,_T("LED Matrix Editor"));
	}		
}
