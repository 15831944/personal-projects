// LEDSignToolKitDlg.cpp : implementation file
//

#include "stdafx.h"
#include "LEDSignToolKit.h"
#include "LEDSignToolKitDlg.h"

#include "LogFile.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#ifdef __cplusplus
extern "C" {
#endif

#include "LEDData.c"

#ifdef __cplusplus
}
#endif

extern UWord16* tbuwDataBuffer;
extern LEDDataStruct* lpstrLEDInfor;
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
// CLEDSignToolKitDlg dialog

CLEDSignToolKitDlg::CLEDSignToolKitDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CLEDSignToolKitDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CLEDSignToolKitDlg)
	m_nLEDColorText = 0;
	m_strSampleText = _T("");
	m_nNumOfCol = 16;
	m_nNumOfRow = 16;
	m_nNumOfPage = 10;
	m_nCurrentPage = 1;
	m_nCommPort = 0;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CLEDSignToolKitDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CLEDSignToolKitDlg)
	DDX_Control(pDX, IDC_STATIC_PAGE, m_ctlCurrentPage);
	DDX_Control(pDX, IDC_COMBO_COLOR_TEXT, m_ctlComboLEDText);
	DDX_Control(pDX, IDC_STATIC_LED_CONTROL, m_ctlLEDSign);
	DDX_Control(pDX, IDC_STATIC_DEMO_TEXT, m_ctlLEDText);
	DDX_CBIndex(pDX, IDC_COMBO_COLOR_TEXT, m_nLEDColorText);
	DDX_Text(pDX, IDC_EDIT_LED_TEXT, m_strSampleText);	
	DDX_Text(pDX, IDC_EDIT_NUM_OF_COL, m_nNumOfCol);
	DDV_MinMaxInt(pDX, m_nNumOfCol, 1, 16);
	DDX_Text(pDX, IDC_EDIT_NUM_OF_ROW, m_nNumOfRow);
	DDV_MinMaxInt(pDX, m_nNumOfRow, 1, 16);
	DDX_Text(pDX, IDC_EDIT_NUM_OF_PAGE, m_nNumOfPage);
	DDV_MinMaxInt(pDX, m_nNumOfPage, 1, 10);
	DDX_CBIndex(pDX, IDC_COMBO_COM, m_nCommPort);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CLEDSignToolKitDlg, CDialog)
	//{{AFX_MSG_MAP(CLEDSignToolKitDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_WM_CLOSE()
	ON_CBN_CLOSEUP(IDC_COMBO_COLOR_TEXT, OnCloseupComboColorText)
	ON_EN_CHANGE(IDC_EDIT_LED_TEXT, OnChangeEditLedText)
	ON_BN_CLICKED(IDC_BUTTON_START, OnButtonStart)	
	ON_BN_CLICKED(IDC_BUTTON_NEXT_PAGE, OnButtonNextPage)
	ON_BN_CLICKED(IDC_BUTTON_PREV_PAGE, OnButtonPrevPage)
	ON_BN_CLICKED(IDC_BUTTON_EXPORT_TO, OnButtonExportTo)
	ON_BN_CLICKED(IDC_BUTTON_IMPORT_FROM, OnButtonImportFrom)
	ON_BN_CLICKED(IDC_BUTTON_GEN_CODE, OnButtonGenCode)
	ON_BN_CLICKED(IDC_BUTTON_SET, OnButtonSet)
	ON_COMMAND(ID_FILE_OPEN, OnFileOpen)
	ON_COMMAND(ID_FILE_SAVE, OnFileSave)
	//}}AFX_MSG_MAP
	ON_WM_TEXT_CTRL(OnMsgTextCtrl)
	ON_WM_SERIAL(OnSerialMsg)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLEDSignToolKitDlg message handlers

LRESULT CLEDSignToolKitDlg::OnMsgTextCtrl (WPARAM wParam, LPARAM /*lParam*/)
{
	int nCurrentRow = (wParam&0xFF00) >> 8;
	int nCurrentPage = m_nCurrentPage = (wParam&0x00FF);

	static int nLastPage = -1;	

	this->m_ctlLEDSign.SetActiveRow(nCurrentRow);

	if (nCurrentPage < this->m_ctlLEDSign.GetNumOfPage())
	{
		if (nLastPage != nCurrentPage)
		{
			nLastPage = nCurrentPage;
			this->m_ctlCurrentPage.SetCurrentPage(nCurrentPage+1);
			this->m_ctlLEDSign.SetCurrentPage(nCurrentPage+1);
		}
	}

	return 0;
}

LRESULT CLEDSignToolKitDlg::OnSerialMsg (WPARAM wParam, LPARAM /*lParam*/)
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
				
			}
		} while (dwRead == nBuflen);	
			
	}

	return 0;
}


BOOL CLEDSignToolKitDlg::OnInitDialog()
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
	
	// TODO: Add extra initialization here
	this->m_ctlLEDText.SetWindowText(m_strSampleText);
	this->m_ctlLEDText.Attach(this->m_hWnd);
	this->OnCloseupComboColorText();	
	this->m_ctlCurrentPage.SetCurrentPage(m_nCurrentPage);
	this->m_ctlLEDSign.SetCurrentPage(m_nCurrentPage);

	m_nNumOfCol = lpstrLEDInfor->ubNumOfCol;
	m_nNumOfRow = lpstrLEDInfor->ubNumOfRow;
	m_nNumOfPage = lpstrLEDInfor->ubNumOfPage;

	CSpinButtonCtrl* pSpin = NULL;

	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_COL);
	pSpin->SetRange(1,16);
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_ROW);
	pSpin->SetRange(1,16);
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_PAGE);
	pSpin->SetRange(1,10);

	this->UpdateData(FALSE);

	if (m_Serial.Open("COM1",m_hWnd,0)!=ERROR_SUCCESS)
	{
		MessageBox("Open COM1 Error. Please try again");
		return FALSE;
	}


	// Register only for the receive event
	// m_Serial.SetMask(	CSerial::EEventRecv  );
	m_Serial.SetupReadTimeouts(CSerial::EReadTimeoutNonblocking);
	m_Serial.Setup((CSerial::EBaudrate)CBR_9600);

	this->UpdateData(FALSE);

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CLEDSignToolKitDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CLEDSignToolKitDlg::OnPaint() 
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
HCURSOR CLEDSignToolKitDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CLEDSignToolKitDlg::OnOK() 
{

}

void CLEDSignToolKitDlg::OnCancel() 
{

}

void CLEDSignToolKitDlg::OnClose() 
{
	CDialog::EndDialog(IDOK) ;
}

void CLEDSignToolKitDlg::OnCloseupComboColorText() 
{
	this->UpdateData(TRUE);
	COLORREF clr = RGB(0,0,0);
	if (m_nLEDColorText == 0)
		clr = RGB(255,0,0);
	else
	if (m_nLEDColorText == 1)
		clr = RGB(0,255,0);
	else
	if (m_nLEDColorText == 2)
		clr = RGB(255,255,0);
	else
	if (m_nLEDColorText == 3)
		clr = RGB(0,0,255);
	else
	if (m_nLEDColorText == 4)
		clr = RGB(255,255,255);
	m_ctlLEDText.SetColorText(clr);
}

void CLEDSignToolKitDlg::OnChangeEditLedText() 
{
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialog::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.
	
	// TODO: Add your control notification handler code here

	this->UpdateData(TRUE);
	CString strTemp = m_strSampleText;
	strTemp.Remove(TCHAR(' '));
	int nNumOfChar = m_nNumOfCol;
	for (int i=0; i< m_strSampleText.GetLength(); i++)
	{
		if (m_strSampleText.GetAt(i)==TCHAR(' '))	
		{			
			if (strTemp.GetLength() <= m_nNumOfCol)
				nNumOfChar++;			
		}
	}
	if (strTemp.GetLength() <= m_nNumOfCol)
		this->m_ctlLEDText.SetWindowText(m_strSampleText.Left(nNumOfChar));
	
}

void CLEDSignToolKitDlg::OnButtonStart() 
{
	static bool bStartSimulate = true;	
	CWnd* pWnd = (CWnd*)GetDlgItem(IDC_BUTTON_START);
	if (bStartSimulate==true)
	{
		bStartSimulate = false;
		this->m_ctlLEDText.Run();	
		pWnd->SetWindowText(_T("Cancel"));
	}
	else
	{
		bStartSimulate = true;		
		this->m_ctlLEDText.Stop();	
		this->m_ctlLEDSign.SetActiveRow(-1);
		pWnd->SetWindowText(_T("Simulate"));
	}
}

void CLEDSignToolKitDlg::OnButtonNextPage() 
{
	m_nCurrentPage++;
	if (m_nCurrentPage > this->m_ctlLEDSign.GetNumOfPage())
		m_nCurrentPage = 1;
	this->m_ctlCurrentPage.SetCurrentPage(m_nCurrentPage);
	this->m_ctlLEDSign.SetCurrentPage(m_nCurrentPage);
}

void CLEDSignToolKitDlg::OnButtonPrevPage() 
{
	m_nCurrentPage--;
	if (m_nCurrentPage <= 0)
		m_nCurrentPage = this->m_ctlLEDSign.GetNumOfPage();
	this->m_ctlCurrentPage.SetCurrentPage(m_nCurrentPage);
	this->m_ctlLEDSign.SetCurrentPage(m_nCurrentPage);
}

void CLEDSignToolKitDlg::OnButtonExportTo() 
{
	///////////////////////////////////////////////////////////////////
	// Save Workspace as ...
	/*****************************************************************/
	CFileDialog dlg(FALSE,_T("led"),NULL,OFN_HIDEREADONLY|OFN_OVERWRITEPROMPT,
		_T("LEDSign Data File(*.led)|*.led||"));		
	
	if ( dlg.DoModal() == IDCANCEL )
	{
		return ;	// nothing selected		
	}	

	TRY{
		CFile file(dlg.GetPathName(),CFile::modeCreate|CFile::modeWrite);		

		this->UpdateData(TRUE);
		
		int nBufferSize = lpstrLEDInfor->ubNumOfRow*(2*sizeof(UWord16))*lpstrLEDInfor->ubNumOfPage;			

		file.Write(lpstrLEDInfor, sizeof(LEDDataStruct));
		file.Write(tbuwDataBuffer,nBufferSize);
		
			
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

void CLEDSignToolKitDlg::OnButtonImportFrom() 
{
	///////////////////////////////////////////////////////////////////
	// Open Workspace ...
	/*****************************************************************/
	CFileDialog dlg(TRUE,_T("led"),NULL,OFN_HIDEREADONLY|OFN_OVERWRITEPROMPT,
		_T("LEDSign Data File(*.led)|*.led||"));		

	if ( dlg.DoModal() == IDCANCEL )
	{
		return ;	// nothing selected		
	}	

	TRY{
		CFile file(dlg.GetPathName(),CFile::modeRead);						
		
		file.Read(lpstrLEDInfor, sizeof(LEDDataStruct));

		int nBufferSize = lpstrLEDInfor->ubNumOfRow*(2*sizeof(UWord16))*lpstrLEDInfor->ubNumOfPage;

		file.Read(tbuwDataBuffer,nBufferSize);

		this->m_ctlCurrentPage.SetCurrentPage(m_nCurrentPage);
		this->m_ctlLEDSign.SetCurrentPage(m_nCurrentPage);

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

void CLEDSignToolKitDlg::OnButtonGenCode() 
{
	//DownloadToDevice();

	//return;
	///////////////////////////////////////////////////////////////////
	// Save Workspace as ...
	/*****************************************************************/
	CFileDialog dlg(FALSE,_T("c"),NULL,OFN_HIDEREADONLY|OFN_OVERWRITEPROMPT,
		_T("C File(*.c)|*.c||"));		
	
	if ( dlg.DoModal() == IDCANCEL )
	{
		return ;	// nothing selected		
	}	

	TRY{
		CFile file(dlg.GetPathName(),CFile::modeCreate|CFile::modeWrite);		

		this->GenerateCformat(file, dlg.GetFileTitle());
			
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

void CLEDSignToolKitDlg::OnButtonSet() 
{
	this->UpdateData(TRUE);
	this->m_ctlLEDSign.SetParameters(m_nNumOfRow, m_nNumOfCol, m_nNumOfPage);
	this->m_ctlLEDSign.SetCurrentPage(m_nCurrentPage);
}


void CLEDSignToolKitDlg::GenerateCformat(CFile &file, const CString& strFileName)
{	
	TRY
	{
		CString strBuffer = _T("");
		strBuffer += _T("/* LED data automatic generated by LEDSignToolKit */\r\n");

		int nBufferLen = m_nNumOfRow*(2)*m_nNumOfPage + 4;	

		CString strTemp = _T("");
		strTemp.Format(_T("\r\nconst unsigned int _dataBuffer[%ld] = "),nBufferLen);
		strBuffer += strTemp;
		strBuffer += _T("\r\n{");		

		strTemp.Format(_T("\r\n %d, %d, %d,	/* rows, cols, pages */"),m_nNumOfRow,m_nNumOfCol, m_nNumOfPage);
		strBuffer += strTemp;   
 				
		for (int page=0; page< (int)lpstrLEDInfor->ubNumOfPage; page++)
		{
			int nCurrentRow = 0;	
			UWord16* pDataBuffer = tbuwDataBuffer + (page)*lpstrLEDInfor->ubNumOfRow*2;

			strTemp.Format(_T("\r\n /* %d */ "), page+1);
			strBuffer += strTemp;	

			for (int row=0; row< (int)lpstrLEDInfor->ubNumOfRow; row++)
			{
				UWord16 uwDelay = pDataBuffer[nCurrentRow++];

				strTemp.Format(_T("0x%0004X, "), uwDelay);
				strBuffer += strTemp;				
				
				UWord16 uwData = pDataBuffer[nCurrentRow++];

				strTemp.Format(_T("0x%0004X, "), uwData);
				strBuffer += strTemp;	
			}
		}

		strBuffer += _T("\r\n 0\r\n};\r\n\r\n");
		
		int len = strBuffer.GetLength();
		file.Write(strBuffer.GetBuffer(len),len);

		
	}
	CATCH(CException, pEx)
	{
		pEx->ReportError();
	}	
	END_CATCH
}

void CLEDSignToolKitDlg::OnFileOpen() 
{
	this->OnButtonImportFrom();
	
}

void CLEDSignToolKitDlg::OnFileSave() 
{
	this->OnButtonExportTo();
	
}

#define PAGE_SIZE	128

void CLEDSignToolKitDlg::DownloadToDevice()
{	
	BYTE data = 0xFF;
	UWord16 uwAddress = 0;

	UWord16 uwBuffSize = 3 + lpstrLEDInfor->ubNumOfRow*(2*sizeof(UWord16))*lpstrLEDInfor->ubNumOfPage;	
	UWord16* pDataBuffer = _LEDChanelBuffer;//(tbuwDataBuffer - 3);

	LOG_TO_FILE("DownloadToDevice %d",uwBuffSize);
	m_Serial.Write(&data, sizeof(BYTE));
	m_Serial.Write(&data, sizeof(BYTE));
	LOG_TO_FILE("ADDRESS %d",data);

	for (int i=0; i< (int)uwBuffSize; i++)
	{
		if ( ((i%PAGE_SIZE) == 0) )
		{
			int j=0;
			// write cycle, need to wait at  least 
			Sleep(100); // 100ms for flash written
			// set the address of buffer to write
			data = (uwAddress>>8) & 0x0FF;
			m_Serial.Write(&data, sizeof(BYTE));
			for(j=0; j<1000; j++);
			data = (uwAddress) & 0x0FF;
			m_Serial.Write(&data, sizeof(BYTE));
			for(j=0; j<1000; j++);
			uwAddress++;
		}
		m_Serial.Write(pDataBuffer, sizeof(BYTE));
		for(int j=0; j<1000; j++);
		pDataBuffer++;
	}

	int nRemaining = 0;

	if ( (uwBuffSize%PAGE_SIZE) > 0)
	{
		nRemaining = ( (uwBuffSize/PAGE_SIZE) + 1 )*PAGE_SIZE - uwBuffSize;

		for (int i=0; i< (int)nRemaining; i++)
		{			
			m_Serial.Write(&data, sizeof(BYTE));
			for(int j=0; j<1000; j++);
		}
	}
	
	CString szBuff;
	szBuff.Format("Success write to device with %d bytes + %d padding bytes",uwBuffSize, nRemaining);
	MessageBox(szBuff,"Communication",MB_ICONINFORMATION);
	
}
