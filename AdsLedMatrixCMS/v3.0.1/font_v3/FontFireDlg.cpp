// FontFireDlg.cpp : implementation file
//

#include "stdafx.h"
#include "FontFire.h"
#include "FontFireDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

void WINAPI DrawWireRects(LPRECT lprcFrom, LPRECT lprcTo, UINT nMilliSecSpeed)
{
    const int nNumSteps = 10;

	GdiFlush();
    Sleep(50);  // Let the desktop window sort itself out

	// if hwnd is null - "you have the CON".
	HDC hDC = ::GetDC(NULL);

	// Pen size, urmmm not too thick
    HPEN hPen = ::CreatePen(PS_SOLID, 2, RGB(0,0,0));

	int nMode = ::SetROP2(hDC, R2_NOT);
	HPEN hOldPen = (HPEN) ::SelectObject(hDC, hPen);

	for (int i = 0; i < nNumSteps; i++)
	{
        double dFraction = (double) i / (double) nNumSteps;

        RECT transition;
        transition.left   = lprcFrom->left + (int)((lprcTo->left - lprcFrom->left) * dFraction);
        transition.right  = lprcFrom->right + (int)((lprcTo->right - lprcFrom->right) * dFraction);
        transition.top    = lprcFrom->top + (int)((lprcTo->top - lprcFrom->top) * dFraction);
        transition.bottom = lprcFrom->bottom + (int)((lprcTo->bottom - lprcFrom->bottom) * dFraction);

		POINT pt[5];
		pt[0] = CPoint(transition.left, transition.top);
		pt[1] = CPoint(transition.right,transition.top);
		pt[2] = CPoint(transition.right,transition.bottom);
		pt[3] = CPoint(transition.left, transition.bottom);
		pt[4] = CPoint(transition.left, transition.top);

		// We use Polyline because we can determine our own pen size
		// Draw Sides
		::Polyline(hDC,pt,5);

		GdiFlush();

		Sleep(nMilliSecSpeed);

		// UnDraw Sides
		::Polyline(hDC,pt,5);

		GdiFlush();
	}

	::SetROP2(hDC, nMode);
	::SelectObject(hDC, hOldPen);

	::ReleaseDC(NULL,hDC);
}
/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

#include "../Tools/StaticCounter.h"
#include "../Tools/MatrixStatic.h"
#define		TIMER_ID		1001
class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

	CRect m_rectFrom;
    BOOL  m_bWireFrame;
// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	CMatrixStatic	m_MatrixBottom;
	CMatrixStatic	m_MatrixTop;
	CStaticCounter	m_StaticCounterL;
	CStaticCounter	m_StaticCounterR;
	CStaticCopyright	m_CopyRight;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	UINT m_nCounter;
	//{{AFX_MSG(CAboutDlg)
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnDestroy();
	virtual BOOL OnInitDialog();
	afx_msg void OnTimer(UINT nIDEvent);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	m_bWireFrame = TRUE;
	//}}AFX_DATA_INIT
	m_rectFrom  =CRect(0,0,40,20);
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	DDX_Control(pDX, IDC_STATIC_MATRIX_BOTTOM, m_MatrixBottom);
	DDX_Control(pDX, IDC_STATIC_MATRIX_TOP, m_MatrixTop);
	DDX_Control(pDX, IDC_STATIC_COPYRIGHT, m_CopyRight);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
	ON_WM_CREATE()
	ON_WM_DESTROY()
	ON_WM_TIMER()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFontFireDlg dialog

CFontFireDlg::CFontFireDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CFontFireDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CFontFireDlg)	
	m_nBrushSize = 2;
	m_nSelectTool = 0;
	m_nCharWidth = 32;
	m_bWireFrame = FALSE;
	m_rectFrom  = CRect(0,0,0,0);
	m_csPreviewText = _T("");
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_hAccelerators = LoadAccelerators(AfxGetApp()->m_hInstance,MAKEINTRESOURCE(IDR_FONT_FIRE));
}

void CFontFireDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CFontFireDlg)	
	DDX_Control(pDX, IDC_EDIT_PREVIEW, m_EditPreview);
	DDX_Control(pDX, IDC_STATIC_AFFILATE, m_Affilate);
	DDX_Control(pDX, IDC_LIST_FONT, m_ListFont);	
	DDX_Text(pDX, IDC_EDIT_BRUSH_SIZE, m_nBrushSize);
	DDX_Radio(pDX, IDC_RADIO_PEN, m_nSelectTool);
	DDX_Text(pDX, IDC_EDIT_CHAR_WIDTH, m_nCharWidth);
	DDX_Text(pDX, IDC_EDIT_PREVIEW, m_csPreviewText);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CFontFireDlg, CDialog)
	//{{AFX_MSG_MAP(CFontFireDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_WM_CLOSE()
	ON_COMMAND(ID_FILE_OPENFONT, OnFileOpenfont)
	ON_COMMAND(ID_FILE_SAVEFONT, OnFileSavefont)
	ON_COMMAND(ID_FILE_SAVEAS, OnFileSaveas)
	ON_NOTIFY(NM_CLICK, IDC_LIST_FONT, OnClickListFont)
	ON_BN_CLICKED(IDC_RADIO_PEN, OnRadioPen)
	ON_BN_CLICKED(IDC_RADIO_BRUSH, OnRadioBrush)
	ON_BN_CLICKED(IDC_RADIO_SELECT, OnRadioSelect)
	ON_BN_CLICKED(IDC_RADIO_MOVE, OnRadioMove)
	ON_BN_CLICKED(IDC_RADIO_ZOOM, OnRadioZoom)
	ON_NOTIFY(UDN_DELTAPOS, IDC_SPIN_BRUSH, OnDeltaposSpinBrush)
	ON_COMMAND(ID_FILE_NEWFONT, OnFileNewfont)
	ON_BN_CLICKED(IDC_BUTTON_COPY, OnButtonCopy)
	ON_BN_CLICKED(IDC_BUTTON_PASTE, OnButtonPaste)
	ON_BN_CLICKED(IDC_BUTTON_ERASE, OnButtonErase)
	ON_BN_CLICKED(IDC_BUTTON_FILL, OnButtonFill)
	ON_NOTIFY(UDN_DELTAPOS, IDC_SPIN_CHAR_WIDTH, OnDeltaposSpinCharWidth)
	ON_COMMAND(ID_FILE_ABOUTFONTFIREEDITOR, OnFileAboutfontfireeditor)
	ON_COMMAND(ID_EDIT_COPYOBJECT, OnEditCopyobject)
	ON_COMMAND(ID_EDIT_PASTEOBJECT, OnEditPasteobject)
	ON_COMMAND(ID_EDIT_ERASEOBJECT, OnEditEraseobject)
	ON_COMMAND(ID_EDIT_SELECTOBJECT, OnEditSelectobject)
	ON_COMMAND(ID_EDIT_FILLRECT, OnEditFillrect)
	ON_COMMAND(ID_EDIT_ZOOMIN, OnEditZoomin)
	ON_COMMAND(ID_EDIT_ZOOMOUT, OnEditZoomout)
	ON_COMMAND(ID_HELP_ABOUTFONTFIREV10, OnHelpAboutfontfirev10)
	ON_COMMAND(ID_TOOL_CONVERT, OnToolConvert)
	ON_COMMAND(ID_EDIT_DESELECTOBJECT, OnEditDeselectobject)
	ON_EN_CHANGE(IDC_EDIT_PREVIEW, OnChangeEditPreview)
	ON_WM_DESTROY()
	ON_BN_CLICKED(IDC_BUTTON_PREVIEW, OnButtonPreview)
	ON_WM_CREATE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFontFireDlg message handlers

BOOL CFontFireDlg::OnInitDialog()
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
	CRect rect;
	CWnd* pParent = GetDlgItem(IDC_STATIC_FRAME);

	pParent->GetWindowRect(&rect);
	this->ScreenToClient(&rect);
	m_ScrollMatrix.Create(_T(""),SS_SUNKEN|WS_VISIBLE|WS_CHILD|SS_NOTIFY,rect,this,1280);		
	m_ScrollMatrix.ShowWindow(SW_SHOW);			

	rect.OffsetRect(2,2);
	m_FontDisp.Create(_T(""),WS_CHILD|SS_NOTIFY,CRect(rect),this,1304);
	m_FontDisp.ShowWindow(SW_HIDE);
	m_FontDisp.UpdateWindow();

	pParent->GetClientRect(rect);

	m_FontEditor.Create(_T(""),WS_VISIBLE|WS_CHILD,rect,&m_ScrollMatrix);
	m_FontEditor.ShowWindow(SW_SHOW);
	m_FontEditor.Init(WIDTH,HEIGHT,LINE_RED,8);
	m_FontEditor.SetBrushSize(m_nBrushSize);
	m_FontEditor.SelectTool(SELECT_PEN);	

	CRect rectPreview;	
	pParent = GetDlgItem(IDC_STATIC_PREVIEW);
	pParent->GetClientRect(&rectPreview);
	m_MatrixPreview.Create(_T(""),WS_VISIBLE|WS_CHILD,rectPreview,this);
	m_MatrixPreview.ShowWindow(SW_SHOW);
	m_MatrixPreview.Init(240,32,LINE_RED,3);	

	m_EditPreview.InitCharFormat();
	DWORD dwMask = m_EditPreview.GetEventMask();
	m_EditPreview.SetEventMask(dwMask | ENM_CHANGE);

	m_ScrollMatrix.InitScroll(&m_FontEditor);

	m_ImageList.Create(24,16,ILC_COLOR24|ILC_MASK,0,10);
	HICON hIcon = ::LoadIcon(AfxFindResourceHandle(MAKEINTRESOURCE(IDI_ICON_FONT),
						RT_GROUP_ICON), MAKEINTRESOURCE(IDI_ICON_FONT));
	m_ImageList.Add(hIcon);
	m_ListFont.SetImageList(&m_ImageList,0);	
	DWORD dwStyle = m_ListFont.GetExtendedStyle();
	m_ListFont.SetExtendedStyle(dwStyle|LVS_EX_GRIDLINES);
	m_ListFont.SetIconSpacing(40,40);	
	
	m_ListFont.SetBkColor(RGB(10,56,72));
	m_ListFont.SetTextColor(RGB(255,0,0));	

	CSpinButtonCtrl* pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_BRUSH);
	pSpin->SetRange(1,10);
	pSpin = (CSpinButtonCtrl*)GetDlgItem(IDC_SPIN_CHAR_WIDTH);
	pSpin->SetRange(1,WIDTH);

	this->OnFileNewfont();	

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CFontFireDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CFontFireDlg::OnPaint() 
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
HCURSOR CFontFireDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CFontFireDlg::OnOK() 
{

}

void CFontFireDlg::OnCancel() 
{

}

void CFontFireDlg::OnClose() 
{
	CDialog::EndDialog(IDOK);
}

void CFontFireDlg::OnFileOpenfont() 
{
	///////////////////////////////////////////////////////////////////
	// OPEN FILE TO IMPORT
	/*****************************************************************/
	CFileDialog dlg(TRUE,NULL,NULL,NULL,_T("Font Matrix File(*.*)|*.*||"));

	if ( dlg.DoModal() == IDCANCEL )
	{
		return ;	// nothing selected		
	}

	m_csFontFile = dlg.GetPathName();	
	m_ListFont.DeleteAllItems();
	for (int i=0; i< 256; i++){
		CString csChar = (char)(i);
		m_ListFont.InsertItem(i,csChar,0);
	}
	
	m_FontDisp.SetFontName(dlg.GetFileName());
	m_FontEditor.LoadFont(m_csFontFile);		
	SetWindowText(_T("FontFire v1.0 - ") + dlg.GetFileName());

}

void CFontFireDlg::OnFileSavefont() 
{
	if (!m_csFontFile.IsEmpty()){
		m_FontEditor.SaveFont(m_csFontFile);	
	}
	else{
		this->OnFileSaveas();
	}
}

void CFontFireDlg::OnFileSaveas() 
{
	///////////////////////////////////////////////////////////////////
	// SAVE FILE AS
	/*****************************************************************/
	CFileDialog dlg(FALSE,NULL,NULL,NULL,_T("Font Matrix File(*.*)|*.*||"));
#ifdef _UNICODE
	wcscpy(dlg.m_ofn.lpstrFile,m_csFontFile);
#else
	strcpy(dlg.m_ofn.lpstrFile,m_csFontFile);
#endif
	if ( dlg.DoModal() == IDCANCEL )
	{
		return ;	// nothing selected		
	}

	m_FontEditor.SaveFont(dlg.GetPathName());

}

void CFontFireDlg::OnClickListFont(NMHDR* pNMHDR, LRESULT* pResult) 
{	
	POSITION pos= m_ListFont.GetFirstSelectedItemPosition();
	if (pos!=NULL){
		int nChar = m_ListFont.GetNextSelectedItem(pos);
		m_FontEditor.SelectCharacter(nChar);		
		m_nCharWidth = m_FontEditor.GetCharWidth();
		CString csCode = _T("");
		csCode.Format(_T("[ 0x%02X ]"),nChar);
		GetDlgItem(IDC_STATIC_CODE)->SetWindowText(csCode);
		this->UpdateData(FALSE);
	}
	*pResult = 0;
}

void CFontFireDlg::OnRadioPen() 
{
	this->UpdateData(TRUE);
	m_FontEditor.SelectTool(SELECT_PEN);
}

void CFontFireDlg::OnRadioBrush() 
{
	this->UpdateData(TRUE);
	m_FontEditor.SelectTool(SELECT_BRUSH);
}

void CFontFireDlg::OnRadioSelect() 
{
	this->UpdateData(TRUE);
	m_FontEditor.SelectTool(SELECT_MARQUEE);
}

void CFontFireDlg::OnRadioMove() 
{
	this->UpdateData(TRUE);
	m_FontEditor.SelectTool(SELECT_MOVE);
}

void CFontFireDlg::OnRadioZoom() 
{
	this->UpdateData(TRUE);
	m_FontEditor.SelectTool(SELECT_ZOOM);	
}


void CFontFireDlg::OnDeltaposSpinBrush(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_UPDOWN* pNMUpDown = (NM_UPDOWN*)pNMHDR;
	
	m_nBrushSize += pNMUpDown->iDelta;
	if (m_nBrushSize > 10){
		m_nBrushSize = 10;
	}
	else
	if (m_nBrushSize <= 0){
		m_nBrushSize = 1;
	}

	m_FontEditor.SetBrushSize(m_nBrushSize);

	*pResult = 0;
}

void CFontFireDlg::OnFileNewfont() 
{
	m_ListFont.DeleteAllItems();
	for (int i=0; i< 256; i++){
		CString csChar = (char)(i);
		m_ListFont.InsertItem(i,csChar,0);
	}
	m_FontEditor.InitDefaultCharMap();
	SetWindowText(_T("FontFire v1.0 - .NewFont"));
}

void CFontFireDlg::OnButtonCopy() 
{
	m_FontEditor.CopyObject();	
}

void CFontFireDlg::OnButtonPaste() 
{
	m_FontEditor.PasteObject();
}

void CFontFireDlg::OnButtonErase() 
{
	m_FontEditor.EraseObject();
}

void CFontFireDlg::OnButtonFill() 
{
	m_FontEditor.FillRect();
}

void CFontFireDlg::OnDeltaposSpinCharWidth(NMHDR* pNMHDR, LRESULT* pResult) 
{
	NM_UPDOWN* pNMUpDown = (NM_UPDOWN*)pNMHDR;
	
	m_nCharWidth += pNMUpDown->iDelta;
	if (m_nCharWidth > WIDTH){
		m_nCharWidth = WIDTH;
	}
	else
	if (m_nCharWidth < 0){
		m_nCharWidth = 0;
	}

	
	m_FontEditor.SetCharWidth(m_nCharWidth);

	*pResult = 0;
}

void CFontFireDlg::OnFileAboutfontfireeditor() 
{
	CAboutDlg dlgAbout;
	dlgAbout.DoModal();
}

void CFontFireDlg::OnEditCopyobject() 
{
	this->OnButtonCopy();
}

void CFontFireDlg::OnEditPasteobject() 
{
	this->OnButtonPaste();
}

void CFontFireDlg::OnEditEraseobject() 
{
	this->OnButtonErase();
}

void CFontFireDlg::OnEditSelectobject() 
{
	m_nSelectTool = 2;
	this->UpdateData(FALSE);
	m_FontEditor.SelectTool(SELECT_MARQUEE);	
}

void CFontFireDlg::OnEditFillrect() 
{
	this->OnButtonFill();
}

void CFontFireDlg::OnEditZoomin() 
{
	m_FontEditor.Zoom(+1);
}

void CFontFireDlg::OnEditZoomout() 
{
	m_FontEditor.Zoom(-1);
}

void CFontFireDlg::OnHelpAboutfontfirev10() 
{
	this->OnFileAboutfontfireeditor();
}

void CFontFireDlg::OnToolConvert() 
{
	m_FontDisp.ShowWindow(SW_SHOW);
	m_FontEditor.ShowWindow(SW_HIDE);	
	if(m_FontDisp.DoFontDlg()){
		m_FontEditor.LoadFont(m_FontDisp.GetFontPath());
		m_csFontFile = m_FontDisp.GetFontName();
		SetWindowText(_T("FontFire v1.0 - ") + m_csFontFile);
	}
	m_FontDisp.ShowWindow(SW_HIDE);
	m_FontEditor.ShowWindow(SW_SHOW);	
}

BOOL CFontFireDlg::PreTranslateMessage(MSG* pMsg) 
{
	TranslateAccelerator(m_hWnd,m_hAccelerators,pMsg);
	return CDialog::PreTranslateMessage(pMsg);
}

void CFontFireDlg::OnEditDeselectobject() 
{
	m_FontEditor.ReleaseObject();	
}

void CFontFireDlg::OnChangeEditPreview() 
{
	// TODO: If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialog::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.
	
	this->UpdateData(TRUE);
	m_MatrixPreview.LoadText(m_csPreviewText.GetBuffer(20));
	
}

void CFontFireDlg::OnDestroy() 
{
	CDialog::OnDestroy();
	
	m_FontDisp.DestroyWindow();	

	if (!m_rectFrom.IsRectEmpty())
	{
		CRect rect;
		GetWindowRect(rect);

        if (m_bWireFrame)
        {
            rect.DeflateRect(2,2);
            DrawWireRects(rect, m_rectFrom, 20);
        }
        else
    		DrawAnimatedRects(m_hWnd,IDANI_CAPTION, rect, m_rectFrom);
	}
	
}

void CFontFireDlg::OnButtonPreview() 
{
		
}

int CAboutDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	this->ClientToScreen(&m_rectFrom);

	if (!m_rectFrom.IsRectEmpty())
	{
		CRect rectTo(lpCreateStruct->x,lpCreateStruct->y, 
			lpCreateStruct->x + lpCreateStruct->cx,
			lpCreateStruct->y + lpCreateStruct->cy);

        if (m_bWireFrame)
            DrawWireRects(m_rectFrom, rectTo, 20);
        else
		    DrawAnimatedRects(m_hWnd, IDANI_CAPTION, m_rectFrom, rectTo);
	}

	return 0;
}

void CAboutDlg::OnDestroy() 
{
	CDialog::OnDestroy();

	if (!m_rectFrom.IsRectEmpty())
	{
		CRect rect;
		GetWindowRect(rect);

        if (m_bWireFrame)
        {
            rect.DeflateRect(2,2);
            DrawWireRects(rect, m_rectFrom, 20);
        }
        else
    		DrawAnimatedRects(m_hWnd,IDANI_CAPTION, rect, m_rectFrom);
	}
	
}

int CFontFireDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;

	if (!m_rectFrom.IsRectEmpty())
	{
		CRect rectTo(lpCreateStruct->x,lpCreateStruct->y, 
			lpCreateStruct->x + lpCreateStruct->cx,
			lpCreateStruct->y + lpCreateStruct->cy);

        if (m_bWireFrame)
            DrawWireRects(m_rectFrom, rectTo, 20);
        else
		    DrawAnimatedRects(m_hWnd, IDANI_CAPTION, m_rectFrom, rectTo);
	}

	return 0;
}

void CFontFireDlg::SetFontList(LPCTSTR szFontName)
{
	m_ListFont.SetFontList(szFontName);
}

BOOL CAboutDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_StaticCounterL.Create(_T(""),WS_VISIBLE|SS_NOTIFY|WS_BORDER, CStaticCounter::GetRect(IDC_STATIC_COUNTER_L, this),(CWnd*)this);
	m_StaticCounterL.SetBlankPadding(9);
	m_StaticCounterL.SetColourFaded(RGB(40,40,40));
	m_StaticCounterL.SetFormatString("%8f");
	m_StaticCounterL.SetColours( RGB(255,255,0), 0, RGB(150,0,0) );
	m_StaticCounterL.SetDraw3DBar(false);

	m_StaticCounterR.Create(_T(""),WS_VISIBLE|SS_NOTIFY|WS_BORDER, CStaticCounter::GetRect(IDC_STATIC_COUNTER_R, this),(CWnd*)this);	
	m_StaticCounterR.SetColours(RGB(255,0,0), RGB(50,0,0), RGB(0,0,0));
	m_StaticCounterR.SetAllowInteraction(true);
	m_StaticCounterR.SetFormatString("%10f");
	m_StaticCounterR.SetDrawFaded(true);
	m_StaticCounterR.SetDraw3DBar(false);

	m_StaticCounterL.SetPos( float(1234.5678), true, 0, float(1234.5678));
	m_StaticCounterR.SetPos( float(987.6543), true, 0, float(987.6543));

	m_MatrixTop.SetNumberOfLines(3);
	m_MatrixTop.SetXCharsPerLine(32);
	
	m_MatrixTop.SetBitmapResource(IDB_MATRIXTINY);
	m_MatrixTop.SetSize(CMatrixStatic::TINY);
	m_MatrixTop.AdjustClientXToSize(32);
	m_MatrixTop.AdjustClientYToSize(3);
	m_MatrixTop.SetText(_T(" !\"#$%&'()*+,-./0123456789;:<=>?@ABCDEFGHIJKLMNO PQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"));

	m_MatrixBottom.SetNumberOfLines(1);
	m_MatrixBottom.SetXCharsPerLine(16);
	m_MatrixBottom.SetColor(RGB(12,50,0),RGB(255,255,0));
	m_MatrixBottom.SetBitmapResource(IDB_MATRIXLARGE);
	m_MatrixBottom.SetSize(CMatrixStatic::LARGE);
	m_MatrixBottom.AdjustClientXToSize(16);
	m_MatrixBottom.AdjustClientYToSize(1);
	m_MatrixBottom.SetText(_T("* FONT  EDITOR *"));

	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CAboutDlg::OnTimer(UINT nIDEvent) 
{
	if (nIDEvent==TIMER_ID){
		m_nCounter++;
		m_StaticCounterL.SetPos((int)m_nCounter, false, 0, 1000);
		m_StaticCounterR.SetPos((int)m_nCounter, true, 0, 1000);
		if (m_nCounter>1000) m_nCounter=0;
	}		
	CDialog::OnTimer(nIDEvent);
}
