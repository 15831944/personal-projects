// MainFrm.cpp : implementation of the CMainFrame class
//

#include "stdafx.h"
#include "ADProLED.h"
#include "ADProLEDDoc.h"
#include "ADProLEDView.h"
#include "NodeTextDlg.h"
#include "MainFrm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

#define	ID_TAB_TIMER	1000
// CMainFrame

#define	INVALID_STATE				-1
#define	STATE_ADD_NODETEXT			0

static int _nDrawState = INVALID_STATE;
#include "../../Common/VeCADAPI/CADAPI.cpp"

void CALLBACK CmdFinisheProc( VDWG hDwg, int Command)
{
	
}

void CALLBACK EntCreateProc( VDWG hDwg, VHANDLE hEnt)
{
	CMainFrame* pFrame = (CMainFrame*)AfxGetApp()->GetMainWnd();
	if (pFrame){
		pFrame->UpdateControlBarInfo(TRUE);
		pFrame->UpdateControlBarParam(TRUE);
	}
	DWORD dwType = CadEntityGetType( hEnt );
	if (dwType ==CAD_ENT_POINT){			
		CadEntityPutUserData ( hEnt, (DWORD)_gPointSize);
	}
}

void OnChangeObjControlBar( VDWG hDwg, VHANDLE hEnt )
{
	DWORD dwType = CadEntityGetType( hEnt );
	if (dwType ==CAD_ENT_POINT){
		double x=0,y=0,z=0;
		CadPointGetCoord (hEnt, &_gX,&_gY,&z);
	}
	else if (dwType ==CAD_ENT_POLYLINE){		
		_gDX = CadPlineGetWidth (hEnt);
		_gDY = CadPlineGetRadius (hEnt);			
	}
	else if (dwType ==CAD_ENT_INSBLOCK){
		double z=0;
		_gDX = CadInsBlockGetScaleX (hEnt);
		_gDY = CadInsBlockGetScaleY (hEnt);		
		CadInsBlockGetPoint (hEnt, &_gX, &_gY, &z);
	}
	else if (dwType ==CAD_ENT_ARC){		
		if (CadArcGetType(hEnt)==CAD_ELLIPSE){
			double x0=0,y0=0,z0=0;
			_gDX = CadArcGetRadHor(hEnt);
			_gDY = CadArcGetRadVer(hEnt);
			CadArcGetCenter (hEnt, &_gX, &_gY, &z0);
			
		}
		else if (CadArcGetType(hEnt)==CAD_CIRCLE){
			double x0=0,y0=0,z0=0;
			_gDX = _gDY = CadArcGetRadius (hEnt);										
			CadArcGetCenter (hEnt, &_gX, &_gY, &z0);			
		}
		else if (CadArcGetType(hEnt)==CAD_ARC){
			double x0=0,y0=0,z0=0;
			_gDX = _gDY = CadArcGetRadius (hEnt);										
			CadArcGetCenter (hEnt, &_gX, &_gY, &z0);
		}
	}
	else if (dwType ==CAD_ENT_LINE){						
		double X1=0, Y1=0, Z1=0;
		CadLineGetPoint1( hEnt, &X1, &Y1, &Z1);
		double X2=0, Y2=0, Z2=0;
		CadLineGetPoint2( hEnt, &X2, &Y2, &Z2);						
		_gDX = X2-X1;
		_gDY = Y2-Y1;		
	}
	else if (dwType ==CAD_ENT_RECT){
		double X=0, Y=0, Z=0;
		CadRectGetCenter (hEnt, &_gX, &_gY, &Z);
		_gDX=CadRectGetWidth(hEnt);
		_gDY=CadRectGetHeight(hEnt);
		
	}	
}

void CALLBACK EntSelectProc( VDWG hDwg, VHANDLE hEnt, BOOL bSelect, BOOL bFinal )
{	
	if (!bSelect){
		return;
	}
	OnChangeObjControlBar (hDwg, hEnt);
	CMainFrame* pFrame = (CMainFrame*)AfxGetApp()->GetMainWnd();
	if (pFrame){
		pFrame->UpdateControlBarInfo(FALSE);
		pFrame->UpdateControlBarParam(FALSE);
	}
}

void CALLBACK MouseMoveProc ( VDWG hDwg, int Button, int Key, int Xwin, int Ywin, double Xdwg, double Ydwg, double Zdwg )
{
	_gX = Xdwg; _gY = Ydwg;
	CMainFrame* pFrame = (CMainFrame*)AfxGetApp()->GetMainWnd();
	if (pFrame){
		pFrame->UpdateControlBarInfo(FALSE);
	}
}

void CALLBACK MouseUpProc( VDWG hDwg, int Button, int Key, int Xwin, int Ywin, double Xdwg, double Ydwg, double Zdwg )
{
	switch (Button)
	{
	case CAD_LBUTTON:
		if (_nDrawState == STATE_ADD_NODETEXT){
			CNodeTextDlg dlg;
			CMainFrame* pFrame = (CMainFrame*)AfxGetApp()->GetMainWnd();
			if (pFrame){
				pFrame->UpdateControlBarParam(TRUE);
			}			
			dlg.m_nX = (float)Xdwg; dlg.m_nY = (float)Ydwg; dlg.m_nZ = (float)Zdwg;
			if (IDOK ==dlg.DoModal()){					
				if (pFrame){					
					pFrame->UpdateControlBarParam(FALSE);						
				}
				QGraphicsText gt;
				GraphicsPath path;				
				gt.m_hWnd = _hWndCAD;
				gt.SetFont(dlg.m_ctrlNodeTextPrv.m_LogFont);
				gt.SetNodeParams(dlg.m_nDistance,dlg.m_nNodeSize);
				gt.GetGraphicsText(path, dlg.m_csText, Point(Xwin, Ywin));	
				while (_arrPointF.GetSize()>0){
					PointF* pPoint = _arrPointF.GetAt(0);
					if (pPoint){
						double Xm=0,Ym=0,Zm=0;	
						CadCoordWinToModel( _hDwgCAD, int(pPoint->X), int(pPoint->Y), &Xm,&Ym, &Zm);
						VHANDLE hEnt = CadAddPoint (_hDwgCAD, Xm, Ym, Zm);			
						CadEntityPutUserData ( hEnt, (DWORD)_gPointSize);						
					}
					delete pPoint;
					_arrPointF.RemoveAt(0);		
				}
				CadUpdate( _hDwgCAD );				
			}
			_nDrawState = INVALID_STATE;
		}
		break;
	case CAD_RBUTTON:
		break;
	case CAD_MBUTTON:
		break;
	}	
}

void CALLBACK KeyDownProc( VDWG hDwg, int VirtKey, int Flags, BOOL bCtrl, BOOL bShift ) 
{

}

void DrawNode(int color, const double Xm, const double Ym, const double Zm)
{
	VHANDLE hEnt = CadAddPoint (_hDwgCAD, Xm, Ym, Zm);	
	CadEntityPutUserData ( hEnt, (DWORD)_gPointSize);
	CadEntityPutColor( hEnt, color);
}

#include <math.h>
void LineNode(int color, double dx, const double X1, const double Y1, const double Z1, const double X2, const double Y2, const double Z2)
{
	double ax = (double)X2 - (double)X1;
	double ay = (double)Y2 - (double)Y1;
	double az = (double)Z2 - (double)Z1;
	double x = double(X1);
	double y = double(Y1);	
	double z = double(Z1);	
	DrawNode(color,x,y,z);
	for (double t=0; t <=1; t+=double(0.001)){
		double xt = double(ax*t + X1);
		double yt = double(ay*t + Y1);
		double zt = double(ay*t + Z1);
		double d =sqrt(pow(xt-x,2)+pow(yt-y,2));
		if (d >= (dx)){
			x = xt; y = yt; z = zt;			
			DrawNode(color,xt,yt,zt);
		}				
	}
}

void RectNode(int color, double dx, double x, double y, double z, double w, double h)
{
	double x1=0,y1=0,z1=0;
	double x2=0,y2=0,z2=0;
	double x3=0,y3=0,z3=0;
	double x4=0,y4=0,z4=0;
	x1 = x4 = x-w/2; x2 = x3 = x+w/2; 	
	y1 = y2 = y-h/2; y3 = y4 = y+h/2;
	z1 = z; z2 = z; z3 = z;
	LineNode(color,dx, x1,y1,z1,x2,y2,z2);
	LineNode(color,dx, x2,y2,z2,x3,y3,z3);
	LineNode(color,dx, x3,y3,z3,x4,y4,z4);
	LineNode(color,dx, x4,y4,z4,x1,y1,z1);
}

void EllipseNode(int color, double dx, double x0, double y0, double z0, double rh, double rv, double a)
{
	double x = double(x0)+rh;
	double y = double(y0);	
	double z = double(z0);	
	for (double t=0; t <2*(3.141592); t+=double(0.001)){
		double xt = x0+ rh*cos(t);
		double yt = y0+ rv*sin(t);
		double zt = z0;
		double d =sqrt(pow(xt-x,2)+pow(yt-y,2));
		if (d >= (dx)){
			x = xt; y = yt; z = zt;			
			DrawNode(color,xt,yt,zt);
		}				
	}
}

void ArcNode(int color, double dx, double x0, double y0, double z0, double x1, double y1, double z1, double x2, double y2, double z2, double r, double a)
{
	double x = double(x0)+r;
	double y = double(y0);	
	double z = double(z0);	
	for (double t=0; t <2*(3.141592); t+=double(0.001)){
		double xt = x0+ r*cos(t);
		double yt = y0+ r*sin(t);
		double zt = z0;
		double d =sqrt(pow(xt-x,2)+pow(yt-y,2));
		if (d >= (dx)){
			x = xt; y = yt; z = zt;	
			if (xt <= x2 && xt >= x1 && yt <= y2 && yt >= y1){
				DrawNode(color,xt,yt,zt);
			}
		}				
	}
}

void CALLBACK EventExecute(VDWG hDwg, int Command)
{
	if (Command==ID_BREAK_INTO){
		int hLayer, hEnt;
		hLayer = CadGetFirstLayer( hDwg );
		while( hLayer ){
			hEnt = CadLayerGetFirstEntity( hLayer );
			while( hEnt ){
				if (CadEntityGetSelected(_hDwgCAD, hEnt)==TRUE){						
					int iVer=0;
					double x1, y1, x2, y2;		
					int color = CadEntityGetColor( hEnt);
					DWORD dwType = CadEntityGetType( hEnt );
					if (dwType ==CAD_ENT_POLYLINE){
						int nPaths = CadEntityGetNumPaths( hEnt );
						for (int i=0; i<nPaths; i++){
							int n = CadEntityGetPathSize( hEnt, i );
							BOOL bFirst = true;
							for (int j=0; j<n; j++){
								CadEntityGetVer( hEnt, iVer++, &x2, &y2 );
								if (bFirst){
									bFirst = false;									
								}else{				
									LineNode(color,_gdx, x1,y1,0,x2,y2,0);								
								}
								CadEntityErase( hEnt, TRUE);
								x1 = x2;
								y1 = y2;
							}
						}						
					}
					else if (dwType ==CAD_ENT_ARC){		
						if (CadArcGetType(hEnt)==CAD_ELLIPSE){
							double x0=0,y0=0,z0=0;
							double rh = CadArcGetRadHor(hEnt);
							double rv = CadArcGetRadVer(hEnt);
							double a = CadArcGetRotAngle(hEnt);
							CadArcGetCenter (hEnt, &x0, &y0, &z0);
							EllipseNode(color,_gdx,x0,y0,z0,rh,rv,a);
							CadEntityErase( hEnt, TRUE);
						}
						else if (CadArcGetType(hEnt)==CAD_CIRCLE){
							double x0=0,y0=0,z0=0;
							double r = CadArcGetRadius (hEnt);							
							double a = CadArcGetRotAngle(hEnt);
							CadArcGetCenter (hEnt, &x0, &y0, &z0);
							EllipseNode(color,_gdx,x0,y0,z0,r,r,a);
							CadEntityErase( hEnt, TRUE);
						}
						else if (CadArcGetType(hEnt)==CAD_ARC){
							double x0=0,y0=0,z0=0;
							double x1=0,y1=0,z1=0;
							double x2=0,y2=0,z2=0;
							double r = CadArcGetRadius (hEnt);							
							double a = CadArcGetRotAngle(hEnt);
							CadArcGetCenter (hEnt, &x0, &y0, &z0);
							CadArcGetStartPt (hEnt, &x1, &y1, &z1);
							CadArcGetEndPt (hEnt, &x2, &y2, &z2);
							ArcNode(color,_gdx,x0,y0,z0,x1,y1,z1,x2,y2,z2,r,a);
							CadEntityErase( hEnt, TRUE);
						}
					}
					else if (dwType ==CAD_ENT_LINE){						
						double X1=0, Y1=0, Z1=0;
						CadLineGetPoint1( hEnt, &X1, &Y1, &Z1);
						double X2=0, Y2=0, Z2=0;
						CadLineGetPoint2( hEnt, &X2, &Y2, &Z2);						
						LineNode(color,_gdx,X1,Y1,Z1,X2,Y2,Z2);
						CadEntityErase( hEnt, TRUE);
					}
					else if (dwType ==CAD_ENT_RECT){
						double X=0, Y=0, Z=0;
						CadRectGetCenter (hEnt, &X, &Y, &Z);
						double W=CadRectGetWidth(hEnt);
						double H=CadRectGetHeight(hEnt);
						RectNode(color,_gdx,X,Y,Z,W,H);
						CadEntityErase( hEnt, TRUE);
					}
				}
				hEnt = CadLayerGetNextEntity( hLayer, hEnt );
			}
			hLayer = CadGetNextLayer( hDwg, hLayer );
		}		
		CadUpdate( hDwg );	
	}
	else if (Command==IDC_BUTTON_CALC){
		PostMessage( theApp.GetMainWnd()->m_hWnd, WM_COMMAND, Command, 0 );
	}
}

void CALLBACK PaintProc( VDWG hDwg, HDC hDrawDC, int Mode, int WinWidth, int WinHeight, double DwgLeft, double DwgBottom, double DwgRight, double DwgTop, double Scale )
{
	if (Mode){		
		int hLayer, hEnt;
		hLayer = CadGetFirstLayer( hDwg );
		while( hLayer ){
			hEnt = CadLayerGetFirstEntity( hLayer );
			while( hEnt ){
				int iVer=0;
				double x=0, y=0, z=0;					
				DWORD dwType = CadEntityGetType( hEnt );
				if (dwType ==CAD_ENT_POINT){
					int color = CadEntityGetColor( hEnt);
					COLORREF clr = CadGetColor(color);
					HBRUSH  hBrush = CreateSolidBrush(clr);
					HPEN hPen = ::CreatePen(PS_SOLID,1,RGB(50,50,50));					
					HBRUSH hBrOld = (HBRUSH)::SelectObject(hDrawDC, hBrush);									
					HPEN hPnOld = (HPEN)::SelectObject(hDrawDC,hPen);
					CadPointGetCoord (hEnt, &x,&y,&z);
					long Xw=0, Yw=0;
					CadCoordModelToWin ( hDwg, x,y,z, &Xw,&Yw);
					double size = CadEntityGetUserData(hEnt);
					double r = (size/Scale )/2;
					::Ellipse(hDrawDC,int(Xw-r),int(Yw-r),int(Xw+r),int(Yw+r));
					::SelectObject(hDrawDC, hBrOld);
					::SelectObject(hDrawDC, hPnOld);
					DeleteObject( hBrush );			
					DeleteObject ( hPen );
				}
				else if (dwType ==CAD_ENT_RECT){
					
				}

				hEnt = CadLayerGetNextEntity( hLayer, hEnt );
			}
			hLayer = CadGetNextLayer( hDwg, hLayer );
		}			
	}
}

void CALLBACK EventPolyFill (VDWG hDwg, VHANDLE hEnt, HDC hDrawDC, const POINT* pPoints, const int* pPolyCounts, int nCount, COLORREF Color)
{
	
}

void CALLBACK EntChangeProc ( VDWG hDwg, VHANDLE hEnt ) 
{
	OnChangeObjControlBar (hDwg, hEnt);
}

IMPLEMENT_DYNCREATE(CMainFrame, CTabSDIFrameWnd)

BEGIN_MESSAGE_MAP(CMainFrame, CTabSDIFrameWnd)
	ON_WM_CREATE()
	// Global help commands
	ON_COMMAND(ID_HELP_FINDER, &CFrameWnd::OnHelpFinder)
	ON_COMMAND(ID_HELP, &CFrameWnd::OnHelp)
	ON_COMMAND(ID_CONTEXT_HELP, &CFrameWnd::OnContextHelp)
	ON_COMMAND(ID_DEFAULT_HELP, &CFrameWnd::OnHelpFinder)
	ON_NOTIFY(CTCN_SELCHANGE, IDC_TABCTRL, OnSelchangeTabctrl)
	ON_NOTIFY(CTCN_RCLICK, IDC_TABCTRL, OnRclickTabctrl)
	ON_NOTIFY(CTCN_CLICK, IDC_TABCTRL, OnClickTabctrl)
	ON_WM_SIZE()
	ON_WM_TIMER()
	ON_COMMAND(ID_DRAW_TEXT, &CMainFrame::OnDrawNodeText)	
	ON_BN_CLICKED(IDC_BUTTON_CALC, &CMainFrame::OnBnClickedButtonCalc)
	ON_COMMAND(ID_TOOL_SET_PAYMENT, &CMainFrame::OnToolSetPayment)
	ON_COMMAND(ID_EXPORTTO_PROTELPCB2, &CMainFrame::OnDesignExportToProtelPCB)
END_MESSAGE_MAP()

static UINT indicators[] =
{
	ID_SEPARATOR,           // status line indicator
	ID_INDICATOR_CAPS,
	ID_INDICATOR_NUM,
	ID_INDICATOR_SCRL,
};

// CMainFrame construction/destruction

CMainFrame::CMainFrame()
{
	m_nHeight = 20;

	const int PointSize = 140;

	HDC hDC = ::GetDC(NULL);
	::ZeroMemory(& m_LogFont, sizeof(LOGFONT));
	m_LogFont.lfHeight = -::MulDiv(PointSize, ::GetDeviceCaps(hDC, LOGPIXELSY), 72);
	m_LogFont.lfWeight = FW_NORMAL;
	m_LogFont.lfOutPrecision = OUT_DEFAULT_PRECIS;
	m_LogFont.lfClipPrecision = CLIP_DEFAULT_PRECIS;
	m_LogFont.lfQuality = PROOF_QUALITY;
	m_LogFont.lfPitchAndFamily = FF_ROMAN;
	_tcscpy_s(m_LogFont.lfFaceName, LF_FACESIZE,_T("Georgia"));
	::ReleaseDC(NULL, hDC);
}

CMainFrame::~CMainFrame()
{
}

int CMainFrame::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CTabSDIFrameWnd::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	if (!m_wndToolBar.CreateEx(this, TBSTYLE_DROPDOWN, WS_CHILD | WS_VISIBLE | CBRS_TOP
		| CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC) ||
		!m_wndToolBar.LoadToolBar(IDR_MAINFRAME))
	{
		TRACE0("Failed to create toolbar\n");
		return -1;      // fail to create
	}
	
	if (!m_wndDlgBar.Create(this, IDR_MAINFRAME, 
		CBRS_ALIGN_TOP, AFX_IDW_DIALOGBAR))
	{
		TRACE0("Failed to create dialogbar\n");
		return -1;		// fail to create
	}	

	if (!m_wndStatusBar.Create(this) ||
		!m_wndStatusBar.SetIndicators(indicators,
		  sizeof(indicators)/sizeof(UINT)))
	{
		TRACE0("Failed to create status bar\n");
		return -1;      // fail to create
	}

	if (CreateToolBarSnap()==FALSE){
		return -1;
	}
	if (CreateToolBarFormat()==FALSE){
		return -1;
	}
	if (CreateToolBarDim()==FALSE){
		return -1;
	}
	if (CreateToolBarDraw()==FALSE){
		return -1;
	}
	if (CreateToolBarEdit()==FALSE){
		return -1;
	}
	m_wndToolBar.SetBarStyle(m_wndToolBar.GetBarStyle() |
		CBRS_TOOLTIPS | CBRS_FLYBY);
	m_wndToolBar.EnableDocking(CBRS_ALIGN_ANY);
	EnableDocking(CBRS_ALIGN_ANY);
	DockControlBar(&m_wndToolBar);

	if (!m_wndReBar.Create(this) ||
		!m_wndReBar.AddBar(&m_wndDlgBar))
	{
		TRACE0("Failed to create rebar\n");
		return -1;      // fail to create
	}

	RECT rc0, rect;
	RecalcLayout();
	::GetWindowRect( m_wndToolBar.m_hWnd, &rc0 );
	rect.left = rc0.right;
	rect.right = rect.left;
	rect.top = rc0.top;
	rect.bottom = rect.top;
	DockControlBar( &m_TbarSnap, AFX_IDW_DOCKBAR_TOP, &rect );
	DockControlBar( &m_TbarFormat, AFX_IDW_DOCKBAR_TOP );
	DockControlBar( &m_TbarDim, AFX_IDW_DOCKBAR_TOP );
	DockControlBar( &m_TbarDraw, AFX_IDW_DOCKBAR_LEFT );
	
	RecalcLayout();
	::GetWindowRect( m_TbarDraw.m_hWnd, &rc0 );
	rect.left = rc0.left;
	rect.right = rect.left;
	rect.top = rc0.bottom;
	rect.bottom = rect.top;
	DockControlBar( &m_TbarEdit, AFX_IDW_DOCKBAR_LEFT, &rect );
	
	if(!m_wndTab.Create(WS_CHILD|WS_VISIBLE|CTCS_FOURBUTTONS|CTCS_DRAGMOVE|CTCS_TOOLTIPS|CTCS_CLOSEBUTTON|CTCS_LEFT,CRect(0,0,m_nHeight,m_nHeight),this,IDC_TABCTRL))
	{
		TRACE0("Failed to create tab control\n");
		return -1;
	}

	m_wndTab.ModifyStyle(CTCS_LEFT,0,0);
	m_wndTab.MoveWindow(0,0,m_nHeight,m_nHeight);
	InitTabLayer();
	RecalcLayout();	

	m_wndTab.SetItemTooltipText(CTCID_FIRSTBUTTON,_T("Đầu"));
	m_wndTab.SetItemTooltipText(CTCID_PREVBUTTON,_T("Trước"));
	m_wndTab.SetItemTooltipText(CTCID_NEXTBUTTON,_T("Sau"));
	m_wndTab.SetItemTooltipText(CTCID_LASTBUTTON,_T("Cuối"));
	m_wndTab.SetItemTooltipText(CTCID_CLOSEBUTTON,_T("Đóng"));
	
	SetTimer(ID_TAB_TIMER,3000,NULL);	
	
	CComboBox* pCombo = (CComboBox*)m_wndDlgBar.GetDlgItem(IDC_COMBO_LED_SIZE);	
	if (pCombo){
		pCombo->ResetContent();
		pCombo->AddString(_T("3.00"));
		pCombo->AddString(_T("5.00"));
		pCombo->SetCurSel(0);
	}
	this->UpdateControlBarInfo(FALSE);
	this->UpdateControlBarParam(FALSE);

	return 0;
}

BOOL CMainFrame::CreateToolBarSnap()
{
	DWORD CtrlStyle = TBSTYLE_DROPDOWN;
	DWORD Style = WS_CHILD | WS_VISIBLE | CBRS_TOP | CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC;
	if (m_TbarSnap.CreateEx(this, CtrlStyle, Style, CRect(0,0,0,0), IDR_SNAP )){
		if (m_TbarSnap.LoadToolBar(IDR_SNAP)){
		m_TbarSnap.SetWindowText( _T("Object Snap") );
		m_TbarSnap.EnableDocking( CBRS_ALIGN_ANY );
		return TRUE;
		}
	}
	TRACE0("Failed to create toolbar 'Object Snap'\n");
	return FALSE;      // fail to create
}

BOOL CMainFrame::CreateToolBarDraw()
{
	DWORD CtrlStyle = TBSTYLE_DROPDOWN;
	DWORD Style = WS_CHILD | WS_VISIBLE | CBRS_TOP | CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC;
	if (m_TbarDraw.CreateEx(this, CtrlStyle, Style)){
		if (m_TbarDraw.LoadToolBar(IDR_DRAW)){
		m_TbarDraw.SetWindowText( _T("Draw") );
		m_TbarDraw.EnableDocking( CBRS_ALIGN_ANY );
		return TRUE;
		}
	}
	TRACE0("Failed to create toolbar 'Draw'\n");
	return FALSE;      // fail to create
}

BOOL CMainFrame::CreateToolBarEdit()
{
	DWORD CtrlStyle = TBSTYLE_DROPDOWN;
	DWORD Style = WS_CHILD | WS_VISIBLE | CBRS_TOP | CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC;
	if (m_TbarEdit.CreateEx(this, CtrlStyle, Style)){
		if (m_TbarEdit.LoadToolBar(IDR_EDIT)){
		m_TbarEdit.SetWindowText( _T("Modify") );
		m_TbarEdit.EnableDocking( CBRS_ALIGN_ANY );
		return TRUE;
		}
	}
	TRACE0("Failed to create toolbar 'Modify'\n");
	return FALSE;      // fail to create
}

static UINT BASED_CODE format[] =
{
	// same order as in the bitmap 'format.bmp'
	//  ID_SEPARATOR,       //
	ID_FMT_LAYER,       // 0
	ID_LAYERS_ORDER,    // 1
	ID_SEPARATOR,       // 2 for "Layers" combo box (placeholder)
	ID_SEPARATOR,       // 3
	ID_SEPARATOR,       // 4 for "Colors" combo box (placeholder)
	ID_SEPARATOR,       // 5
	ID_FMT_LINETYPE,    // 6
	ID_SEPARATOR,       // 7 for "Linetypes" combo box (placeholder)
	ID_SEPARATOR,       // 8
	ID_FMT_LINEWEIGHT,  // 9
	ID_SEPARATOR,       // 10 for "Lineweights" combo box (placeholder)
};

BOOL CMainFrame::CreateToolBarFormat()
{
	const int nDropHeight = 300;	

	if (!m_TbarFormat.CreateEx( this, TBSTYLE_DROPDOWN, WS_CHILD | WS_VISIBLE | CBRS_TOP | 
                                   CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY) ||
		!m_TbarFormat.LoadBitmap( IDB_FORMAT ) ||
		!m_TbarFormat.SetButtons( format, sizeof(format)/sizeof(UINT)))
	{
		TRACE0("Failed to create Format bar\n");
		return FALSE;       // fail to create
	}
	int i =0;
	// ID_FMT_LAYER button
	i++;  
	// ID_LAYERS_ORDER button
	i++;  
	// Create "Layers" combo box
	m_TbarFormat.SetButtonInfo( i, CB_LAYERS, TBBS_SEPARATOR, 210 );
	CRect rect = CRect();
	m_TbarFormat.GetItemRect( i++, &rect );
	int h = rect.Height()+1;
	HWND hw = CadCboxCreate( CAD_CBOX_LAYER, m_TbarFormat.m_hWnd, rect.left, rect.top, 210, h, nDropHeight );
	if (hw==NULL){
		TRACE0("Failed to create Layers combo-box\n");
		return FALSE;
	}
	// separator
	m_TbarFormat.SetButtonInfo( i++, ID_SEPARATOR, TBBS_SEPARATOR, 9 );
	// Create "Colors" combo box
	m_TbarFormat.SetButtonInfo( i, CB_COLORS, TBBS_SEPARATOR, 100 );
	m_TbarFormat.GetItemRect( i++, &rect );
	h = rect.bottom - rect.top + 1;
	hw = CadCboxCreate( CAD_CBOX_COLOR, m_TbarFormat.m_hWnd, rect.left, rect.top, 100, h, nDropHeight );
	if (hw==NULL){
		TRACE0("Failed to create Colors combo-box\n");
		return FALSE;
	}
	// separator
	m_TbarFormat.SetButtonInfo( i++, ID_SEPARATOR, TBBS_SEPARATOR, 9 );
	// ID_FMT_LINETYPE button
	i++;  
	// Create "Linetypes" combo box
	m_TbarFormat.SetButtonInfo( i, CB_LTYPES, TBBS_SEPARATOR, 180 );
	m_TbarFormat.GetItemRect( i++, &rect );
	h = rect.bottom - rect.top + 1;
	hw = CadCboxCreate( CAD_CBOX_LINETYPE, m_TbarFormat.m_hWnd, rect.left, rect.top, 180, h, nDropHeight );
	if (hw==NULL){
		TRACE0("Failed to create Linetypes combo-box\n");
		return FALSE;
	}
	// separator
	m_TbarFormat.SetButtonInfo( i++, ID_SEPARATOR, TBBS_SEPARATOR, 9 );
	// ID_FMT_LINEWEIGHT button
	i++;  
	// Create "Lineweights" combo box
	m_TbarFormat.SetButtonInfo( i, CB_LWEIGHTS, TBBS_SEPARATOR, 110 );
	m_TbarFormat.GetItemRect( i++, &rect );
	h = rect.bottom - rect.top + 1;
	hw = CadCboxCreate( CAD_CBOX_LWEIGHT, m_TbarFormat.m_hWnd, rect.left, rect.top, 110, h, nDropHeight );
	if (hw==NULL){
		TRACE0("Failed to create Lineweights combo-box\n");
		return FALSE;
	}
#if 0
	// set height of the window
	m_TbarFormat.CbLweight.GetWindowRect( &rect );
	h = rect.bottom - rect.top + 3;
	m_TbarFormat.SetHeight( h );
#endif
  
	m_TbarFormat.SetWindowText( _T("Object Properties") );
	// make the window dockable
	m_TbarFormat.EnableDocking( CBRS_ALIGN_TOP );
	return TRUE;
}

static UINT BASED_CODE dim[] =
{
	// same order as in the bitmap 'dim.bmp'
	ID_DIM_LINEAR,     // 0
	ID_DIM_ALIGNED,    // 1
	ID_DIM_ORDINATE,   // 2
	ID_DIM_RADIUS,     // 3
	ID_DIM_DIAM,       // 4
	ID_DIM_ANGULAR,    // 5
	ID_SEPARATOR,      // 6
	ID_DIM_LEADER,     // 7
	ID_DIM_CMARK,      // 8
	ID_SEPARATOR,      // 6
	ID_SEPARATOR,      // 9 for "Dim styles" combo box (placeholder)
	ID_FMT_DIMSTYLE    // 10
};

BOOL CMainFrame::CreateToolBarDim()
{
	const int nDropHeight = 330;
	
	if (!m_TbarDim.CreateEx( this, WS_CHILD | WS_VISIBLE | CBRS_TOP | 
                                   CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY) ||
		!m_TbarDim.LoadBitmap( IDB_DIM ) ||
		!m_TbarDim.SetButtons( dim, sizeof(dim)/sizeof(UINT)))
	{
		TRACE0("Failed to create Format bar\n");
		return FALSE;       // fail to create
	}
	int i =0;
	// ID_DIM_LINEAR button
	i++;  
	// ID_DIM_ALIGNED button
	i++;  
	// ID_DIM_ORDINATE
	i++;
	// ID_DIM_RADIUS
	i++;
	// ID_DIM_DIAM
	i++;
	// ID_DIM_ANGULAR
	i++;
	// ID_SEPARATOR
	m_TbarDim.SetButtonInfo( i++, ID_SEPARATOR, TBBS_SEPARATOR, 9 );
	// ID_DIM_LEADER
	i++;
	// ID_DIM_CMARK
	i++;
	// ID_SEPARATOR
	m_TbarDim.SetButtonInfo( i++, ID_SEPARATOR, TBBS_SEPARATOR, 9 );
	// Create "Dim styles" combo box
	m_TbarDim.SetButtonInfo( i, CB_DIMS, TBBS_SEPARATOR, 153 );
	CRect rect =CRect();
	m_TbarDim.GetItemRect( i++, &rect );
	int h = rect.bottom - rect.top + 1;
	HWND hw = CadCboxCreate( CAD_CBOX_DIMSTYLE, m_TbarDim.m_hWnd, rect.left, rect.top, 150, h, nDropHeight );
	if (hw==NULL){
		TRACE0("Failed to create DimStyles combo-box\n");
		return FALSE;
	}
	// ID_DIM_STYLES
	i++;
	
	m_TbarDim.SetWindowText( _T("Dimension") );
	// make the window dockable
	m_TbarDim.EnableDocking( CBRS_ALIGN_TOP );
	return TRUE;
}

BOOL CMainFrame::PreCreateWindow(CREATESTRUCT& cs)
{
	if( !CTabSDIFrameWnd::PreCreateWindow(cs) )
		return FALSE;
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	cs.style = WS_OVERLAPPED | WS_CAPTION | FWS_ADDTOTITLE
		 | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_MAXIMIZE | WS_SYSMENU;

	return TRUE;
}


// CMainFrame diagnostics

#ifdef _DEBUG
void CMainFrame::AssertValid() const
{
	CFrameWnd::AssertValid();
}

void CMainFrame::Dump(CDumpContext& dc) const
{
	CFrameWnd::Dump(dc);
}

#endif //_DEBUG


// CMainFrame message handlers

void CMainFrame::OnSelchangeTabctrl(NMHDR* pNMHDR, LRESULT* pResult) 
{	
	char szName[128];
	CString csText = _T("");
	m_wndTab.GetItemText(m_wndTab.GetCurSel(),csText);	
	WideCharToMultiByte(CP_ACP,0,csText.GetBuffer(128),128,szName,128,NULL,NULL);
	VHANDLE hLayer = CadGetLayerByName( _hDwgCAD, (LPCTSTR)szName);			
	if (hLayer){
		CadSetCurLayer(_hDwgCAD,hLayer);
	}

	*pResult = 0;
}

void CMainFrame::OnClickTabctrl(NMHDR* pNMHDR, LRESULT* pResult) 
{
	CTabSDIFrameWnd::OnClickTabctrl(pNMHDR, pResult);
	if(((CTC_NMHDR*)pNMHDR)->nItem==CTCHT_ONCLOSEBUTTON){
	}		
}

void CMainFrame::OnRclickTabctrl(NMHDR* pNMHDR, LRESULT* pResult) 
{
	CMenu menu;
	menu.CreatePopupMenu();

	menu.AppendMenu(MF_STRING,1,_T("Đóng lại"));	
	menu.AppendMenu(MF_STRING,2,_T("Xem thuộc tính"));
	
	CPoint pt(((CTC_NMHDR*)pNMHDR)->ptHitTest);
	m_wndTab.ClientToScreen(&pt);

	int nRet = menu.TrackPopupMenu(TPM_LEFTALIGN|TPM_RIGHTBUTTON|TPM_RETURNCMD|TPM_NONOTIFY, pt.x, pt.y, this);
	switch(nRet)
	{
	case 1:
		{
			CADProLEDView* pView = new CADProLEDView;
			if(!pView){
				break;
			}			
			char szName[128];
			CString csText = _T("");
			m_wndTab.GetItemText(m_wndTab.GetCurSel(),csText);	
			WideCharToMultiByte(CP_ACP,0,csText.GetBuffer(128),128,szName,128,NULL,NULL);
			VHANDLE hLayer = CadGetLayerByName( _hDwgCAD, (LPCTSTR)szName);
			if (hLayer){
				m_wndTab.DeleteItem(m_wndTab.GetCurSel());
				CadLayerPutVisible( hLayer, FALSE);
			}
		}
		break;
	case 2:
		{
			CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_LAYER);
		}
		break;	
	}
	*pResult = 0;
}

void CMainFrame::OnSize(UINT nType, int cx, int cy)
{
	CTabSDIFrameWnd::OnSize(nType, cx, cy);		
}

void CMainFrame::OnTimer(UINT_PTR nIDEvent)
{
	if (nIDEvent == ID_TAB_TIMER){
		
	}
	CTabSDIFrameWnd::OnTimer(nIDEvent);
}

BOOL CMainFrame::DestroyWindow()
{
	KillTimer(ID_TAB_TIMER);

	return CTabSDIFrameWnd::DestroyWindow();
}

int CMainFrame::InitVeCAD(HWND hWnd)
{
#ifndef USE_CAD_LIB
	if (CadLoadLibrary()==FALSE){		
		LPVOID lpMsgBuf;
		FormatMessage( 
			FORMAT_MESSAGE_ALLOCATE_BUFFER | 
			FORMAT_MESSAGE_FROM_SYSTEM | 
			FORMAT_MESSAGE_IGNORE_INSERTS,
			NULL,
			GetLastError(),
			MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
			(LPTSTR) &lpMsgBuf,
			0,
			NULL 
		);
		// Process any inserts in lpMsgBuf.
		// ...
		// Display the string.
		MessageBox( (LPCTSTR)lpMsgBuf, _T("Error"), MB_OK | MB_ICONINFORMATION );
		// Free the buffer.
		LocalFree( lpMsgBuf );

		return 1;
	}
#endif
	// register VeCAD
	CadRegistration( 1950125322 );
	// Set default accelerator keys
	CadAccelSetDefault();
	CadSetDefaultFont(_T("Microsoft Sans Serif"));

	_hDwgCAD = CadCreate();		
	_hWndCAD = CadWndCreate(_hDwgCAD,hWnd,CAD_WS_DEFAULT,0,0,100,100);	
	
	if (_hWndCAD){		
		CadOnEventCmdFinish( (F_CMDFINISH)CmdFinisheProc );
		CadOnEventEntCreate( (F_ENTCREATE)EntCreateProc );	
		CadOnEventEntSelect( (F_ENTSELECT)EntSelectProc );
		CadOnEventMouseUp ( (F_MOUSEUP)MouseUpProc );
		CadOnEventMouseMove ( (F_MOUSEMOVE)MouseMoveProc);
		CadOnEventKeyDown ( (F_KEYDOWN)KeyDownProc );
		CadOnEventExecute ( (F_EXECUTE)EventExecute);
		CadOnEventPaint ( (F_PAINT)PaintProc);
		CadOnEventEntChange ( (F_ENTCHANGE)EntChangeProc );
		CadOnEventPolyFill( (F_POLYFILL)EventPolyFill, true );

		CadGridPutType( _hDwgCAD, true, CAD_GRID_LINE);
		CadGridPutColor( _hDwgCAD, true, _stData.m_clrBold);
		CadGridPutBoldStep( _hDwgCAD, _stData.m_nBoldSize, _stData.m_nBoldSize, _stData.m_nBoldSize);
				
		CadGridPutType( _hDwgCAD, false, CAD_GRID_LINE);
		CadGridPutColor( _hDwgCAD, false, _stData.m_clrGrid);
		CadGridPutSize( _hDwgCAD, _stData.m_nGridSize, _stData.m_nGridSize, _stData.m_nGridSize);
		
		CadGridPutSnap( _hDwgCAD, false);
		CadGridPutShow( _hDwgCAD, true );		
		CadGridPutLevel( _hDwgCAD, CAD_GRID_BELOW);

		CadPutPointMode( _hDwgCAD, CAD_PNT_NONE | CAD_PNT_CIRCLE);
		CadPutPointSize( _hDwgCAD, 3);

		CadAddLinetype( _hDwgCAD, (LPCTSTR)"Dot-Dot",(LPCTSTR)"0,-20",(LPCTSTR)". . . . . ");
		CadAddLinetype( _hDwgCAD, (LPCTSTR)"Dash-Dot",(LPCTSTR)"2,-5,0,-5",(LPCTSTR)"_ . _ . _ ");
		
		CadViewScale( _hDwgCAD, _hWndCAD, 0.5, -1,-1);

		CadMenuAdd( CAD_MENU_EDIT, (LPCTSTR)"Break To Nodes", ID_BREAK_INTO  );
		CadMenuAdd( CAD_MENU_EDIT, (LPCTSTR)"-", 0  );
		CadMenuAdd( CAD_MENU_EDIT, (LPCTSTR)"Calculate Payment ", IDC_BUTTON_CALC  );
		
	}
	else{
		return -1;
	}
		
	return 0;
}

void CMainFrame::InitTabLayer(void)
{
	if (IsWindow(m_wndTab.m_hWnd)){
		m_wndTab.DeleteAllItems();
	}
	VHANDLE hLayer = CadGetFirstLayer( _hDwgCAD);
	while( hLayer !=NULL) {
		if (CadLayerGetVisible(hLayer)==TRUE){			
			TCHAR szName[128];
			WCHAR wcsName[128];
			CadLayerGetName( hLayer, szName);
			MultiByteToWideChar( CP_ACP, 0, (char*)(szName), -1,wcsName, 128 );		
			if (IsWindow(m_wndTab.m_hWnd)){
				m_wndTab.InsertItem(0,wcsName);
			}
		}
		hLayer = CadGetNextLayer (_hDwgCAD, hLayer);
	}
}

void CMainFrame::OnDrawNodeText()
{	
	_nDrawState = STATE_ADD_NODETEXT;
}

BOOL CMainFrame::PreTranslateMessage(MSG* pMsg)
{	
	return CTabSDIFrameWnd::PreTranslateMessage(pMsg);
}

void CMainFrame::UpdateControlBarParam(BOOL bUpdate)
{
	CWnd* pWnd  = NULL;
	TCHAR szItem[10];
	m_wndDlgBar.UpdateData(TRUE);
	pWnd = m_wndDlgBar.GetDlgItem(IDC_COMBO_LED_SIZE);	
	CComboBox* pCombo = (CComboBox*)pWnd;
	if (bUpdate==FALSE){
		int sel = -1;
		switch ((int)_gPointSize){
		case LED_SIZE_3:
			sel = 0;
			break;
		case LED_SIZE_5:
			sel = 1;
			break;
		default:
			sel = 0;
		}
		pCombo->SetCurSel(sel);
	}else{
		switch (pCombo->GetCurSel()){
		case 0:
			_gPointSize = LED_SIZE_3;
			break;
		case 1:
			_gPointSize = LED_SIZE_5;
			break;
		default:
			_gPointSize = LED_SIZE_3;
			break;
		}			
	}

	pWnd = m_wndDlgBar.GetDlgItem(IDC_EDIT_NODE_SPACE);	
	if (bUpdate==FALSE){
		swprintf_s(szItem,_T("%2.2f"),_gdx,10);
		pWnd->SetWindowText(szItem);
	}else{
		pWnd->GetWindowTextW(szItem,10);
		_gdx = _wtof(szItem);
	}
	
}


void CMainFrame::UpdateControlBarInfo(BOOL bUpdate)
{
	CWnd* pWnd =NULL;
	TCHAR szItem[10];
	m_wndDlgBar.UpdateData(TRUE);
	pWnd = m_wndDlgBar.GetDlgItem(IDC_EDIT_PX);	
	if (bUpdate==FALSE){
		swprintf_s(szItem,_T("%2.2f"),_gX,10);
		pWnd->SetWindowText(szItem);
	}else{
		pWnd->GetWindowTextW(szItem,10);
		_gX = _wtof(szItem);
	}

	pWnd = m_wndDlgBar.GetDlgItem(IDC_EDIT_PY);	
	if (bUpdate==FALSE){
		swprintf_s(szItem,_T("%2.2f"),_gY,10);
		pWnd->SetWindowText(szItem);
	}else{
		pWnd->GetWindowTextW(szItem,10);
		_gY = _wtof(szItem);
	}

	pWnd = m_wndDlgBar.GetDlgItem(IDC_EDIT_DX);	
	if (bUpdate==FALSE){
		swprintf_s(szItem,_T("%2.2f"),_gDX,10);
		pWnd->SetWindowText(szItem);
	}else{
		pWnd->GetWindowTextW(szItem,10);
		_gDX = _wtof(szItem);
	}

	pWnd = m_wndDlgBar.GetDlgItem(IDC_EDIT_DY);	
	if (bUpdate==FALSE){
		swprintf_s(szItem,_T("%2.2f"),_gDY,10);
		pWnd->SetWindowText(szItem);
	}else{
		pWnd->GetWindowTextW(szItem,10);
		_gDY = _wtof(szItem);
	}
}

#include "CalcDlg.h"
void CMainFrame::OnBnClickedButtonCalc()
{
	CCalcDlg dlg;
	int hLayer, hEnt;
	hLayer = CadGetFirstLayer( _hDwgCAD );
	while( hLayer ){
		hEnt = CadLayerGetFirstEntity( hLayer );
		while( hEnt ){
			if (CadEntityGetSelected(_hDwgCAD, hEnt)==TRUE){
				int iVer=0;
				double x=0, y=0, z=0;					
				DWORD dwType = CadEntityGetType( hEnt );
				if (dwType ==CAD_ENT_POINT){
					int color = CadEntityGetColor( hEnt);
					if (color ==CAD_COLOR_BYLAYER ){
						color = CadLayerGetColor( hLayer);
					}
					double size = CadEntityGetUserData(hEnt);
					switch (color){
						case CAD_COLOR_RED:
							if (size==LED_SIZE_3){
								dlg.m_nTotalRED3++;
							}
							else if (size==LED_SIZE_5){
								dlg.m_nTotalRED5++;
							}						
							break;
						case CAD_COLOR_BLUE:
							if (size==LED_SIZE_3){
								dlg.m_nTotalBLUE3++;
							}
							else if (size==LED_SIZE_5){
								dlg.m_nTotalBLUE5++;
							}
							break;
						case CAD_COLOR_GREEN:
							if (size==LED_SIZE_3){
								dlg.m_nTotalGREEN3++;
							}
							else if (size==LED_SIZE_5){
								dlg.m_nTotalGREEN5++;
							}
							break;					
						case CAD_COLOR_WHITE:
							dlg.m_nTotalWHITE3++;
							break;
						default:
							dlg.m_nTotalOTHER++;
							break;
					}												
				}
			}
			hEnt = CadLayerGetNextEntity( hLayer, hEnt );
		}
		hLayer = CadGetNextLayer( _hDwgCAD, hLayer );
	}
	if (IDOK==dlg.DoModal()){

	}
}
#include "SettingPaymentDlg.h"
void CMainFrame::OnToolSetPayment()
{
	CSettingPaymentDlg dlg;
	if (IDOK==dlg.DoModal()){

	}
}

void CMainFrame::OnDesignExportToProtelPCB()
{
	int hLayer, hEnt;
	double x0=0, y0=0;
	double x=0, y=0, z=0;
	hLayer = CadGetFirstLayer( _hDwgCAD );
	while( hLayer ){
		hEnt = CadLayerGetFirstEntity( hLayer );		
		while( hEnt ){
			int iVer=0;								
			DWORD dwType = CadEntityGetType( hEnt );
			if (dwType ==CAD_ENT_POINT){
				int color = CadEntityGetColor( hEnt);					
				double size = CadEntityGetUserData(hEnt);
				CadPointGetCoord (hEnt, &x,&y,&z);
				AddLED(x, y, x0, y0, size);					
				x0=x, y0=y;
			}			
			hEnt = CadLayerGetNextEntity( hLayer, hEnt );
		}
		hLayer = CadGetNextLayer( _hDwgCAD, hLayer );
	}	

	m_PCBFile.GetTemplate();
}

void CMainFrame::AddLED(double x, double y, double x0, double y0, double size)
{
	double Lef, Bot, Rig, Top;
	// get drawing's extents in a window and save this part as an image
	Lef = CadGetWinLeft( _hDwgCAD );
	Rig = CadGetWinRight( _hDwgCAD );
	Top = CadGetWinTop( _hDwgCAD );
	Bot = CadGetWinBottom( _hDwgCAD );	
	CHLED* pLED = new CHLED();	
	if (pLED){
		x += abs(Lef);
		y += abs(Bot);
		x *= 100000;
		y *= 100000;
		double r=50000;
		pLED->m_nXCenter = x;
		pLED->m_nYCenter = y;
		pLED->m_nXPadA = x +r;
		pLED->m_nYPadA = y;
		pLED->m_nXPadK = x -r;
		pLED->m_nYPadK = y;
		_arrHLED.Add(pLED);						
	}
}
