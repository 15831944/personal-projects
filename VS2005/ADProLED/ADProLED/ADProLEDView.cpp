// ADProLEDView.cpp : implementation of the CADProLEDView class
//

#include "stdafx.h"
#include "ADProLED.h"
#include "MainFrm.h"
#include "ADProLEDDoc.h"
#include "ADProLEDView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CADProLEDView

IMPLEMENT_DYNCREATE(CADProLEDView, CView)

BEGIN_MESSAGE_MAP(CADProLEDView, CView)
	// Standard printing commands
	ON_WM_SIZE()
	ON_COMMAND(ID_DRAW_LINE, OnDrawLine)
	ON_COMMAND(ID_DRAW_RAY, OnDrawRay)
	ON_COMMAND(ID_DRAW_MLINE, OnDrawMultiline)
	ON_COMMAND(ID_DRAW_POLYLINE, &CADProLEDView::OnDrawPolyline)
	ON_COMMAND(ID_DRAW_POLYGON, &CADProLEDView::OnDrawPolygon)
	ON_COMMAND(ID_DRAW_RECT, &CADProLEDView::OnDrawRectangle)
	ON_COMMAND(ID_DRAW_ARC_3P, &CADProLEDView::OnDrawArc3point)
	ON_COMMAND(ID_DRAW_ARC_SCE, &CADProLEDView::OnDrawArcStartCenterEnd)
	ON_COMMAND(ID_DRAW_ARC_CONTINUE, &CADProLEDView::OnDrawArcContinue)
	ON_COMMAND(ID_DRAW_ELLIPSE, &CADProLEDView::OnDrawEllipse)
	ON_COMMAND(ID_DRAW_SPLINE, &CADProLEDView::OnDrawSpline)
	ON_COMMAND(ID_DRAW_POINT_SINGLE, &CADProLEDView::OnDrawPoint)
	ON_COMMAND(ID_DRAW_CIRC_CR, &CADProLEDView::OnDrawCicleCenterRadius)
	ON_COMMAND(ID_DRAW_CIRC_CD, &CADProLEDView::OnDrawCicleDiameter)
	ON_COMMAND(ID_DRAW_CIRC_2P, &CADProLEDView::OnDrawCicle2points)
	ON_COMMAND(ID_DRAW_CIRC_3P, &CADProLEDView::OnDrawCicle3points)
	ON_COMMAND(ID_DRAW_ARC_SCA, &CADProLEDView::OnDrawArcStartCenterAngle)
	ON_COMMAND(ID_DRAW_SINGLETEXT, &CADProLEDView::OnDrawSingletext)
	ON_COMMAND(ID_DRAW_MULTI_TEXT, &CADProLEDView::OnDrawMultiText)
	ON_COMMAND(ID_DRAW_HATCH, &CADProLEDView::OnDrawHatch)
	ON_COMMAND(ID_DIM_LINEAR, &CADProLEDView::OnDimLinear)
	ON_COMMAND(ID_DIM_ALIGNED, &CADProLEDView::OnDimAligned)
	ON_COMMAND(ID_DIM_ORDINATE, &CADProLEDView::OnDimOrdinated)
	ON_COMMAND(ID_DIM_RADIUS, &CADProLEDView::OnDimRadius)
	ON_COMMAND(ID_DIM_ANGULAR, &CADProLEDView::OnDimAngle)
	ON_COMMAND(ID_FMT_DIMSTYLE, &CADProLEDView::OnDimStyle)
	ON_COMMAND(ID_DIM_DIAM, &CADProLEDView::OnDimDiameter)
	ON_COMMAND(ID_ZOOM_RTIME, &CADProLEDView::OnViewZoomRealtime)
	ON_COMMAND(ID_ZOOM_PREV, &CADProLEDView::OnViewZoomPreview)
	ON_COMMAND(ID_ZOOM_WINDOW, &CADProLEDView::OnViewZoomWindow)
	ON_COMMAND(ID_ZOOM_EXT, &CADProLEDView::OnViewZoomExtent)
	ON_COMMAND(ID_ZOOM_IN, &CADProLEDView::OnViewZoomIn)
	ON_COMMAND(ID_ZOOM_OUT, &CADProLEDView::OnViewZoomOut)
	ON_COMMAND(ID_ZOOM_SEL, &CADProLEDView::OnViewZoomSelected)
	ON_COMMAND(ID_EDIT_MOVE, &CADProLEDView::OnEditMove)
	ON_COMMAND(ID_EDIT_ROTATE, &CADProLEDView::OnEditRotate)
	ON_COMMAND(ID_EDIT_SCALE, &CADProLEDView::OnEditScale)
	ON_COMMAND(ID_EDIT_MIRROR, &CADProLEDView::OnEditMirror)
	ON_COMMAND(ID_EDIT_EXPLODE, &CADProLEDView::OnEditExplode)
	ON_COMMAND(ID_EDIT_JOINT, &CADProLEDView::OnEditJoint)
	ON_COMMAND(ID_EDIT_TRIM, &CADProLEDView::OnEditTrim)
	ON_COMMAND(ID_EDIT_EXTEND, &CADProLEDView::OnEditExtend)
	ON_COMMAND(ID_EDIT_PROP, &CADProLEDView::OnEditProperties)
	ON_COMMAND(ID_EDIT_ERASE, &CADProLEDView::OnEditDelete)
	ON_COMMAND(ID_EDIT_CUT, &CADProLEDView::OnEditCut)
	ON_COMMAND(ID_EDIT_COPY, &CADProLEDView::OnEditCopy)
	ON_COMMAND(ID_EDIT_PASTE, &CADProLEDView::OnEditPaste)
	ON_COMMAND(ID_EDIT_UNDO, &CADProLEDView::OnEditUndo)
	ON_COMMAND(ID_EDIT_REDO, &CADProLEDView::OnEditRedo)
	ON_COMMAND(ID_INS_BLOCK, &CADProLEDView::OnInsertBlock)
	ON_COMMAND(ID_INS_RASTER_IMG, &CADProLEDView::OnInsertRasterImg)
	ON_COMMAND(ID_INS_EXTERNAL, &CADProLEDView::OnInsertExtRef)
	ON_COMMAND(ID_INS_ARCVIEW, &CADProLEDView::OnInsertArcview)
	ON_COMMAND(ID_INS_XREF_MANAGER, &CADProLEDView::OnXrefManager)
	ON_COMMAND(ID_IMAGE_MANAGER, &CADProLEDView::OnImageManager)
	ON_COMMAND(ID_SELECT_BY_ID, &CADProLEDView::OnSelectById)
	ON_COMMAND(ID_SELECT_BY_USERDATA, &CADProLEDView::OnSelectByUserdata)
	ON_COMMAND(ID_SELECT_BY_TEXT, &CADProLEDView::OnSelectByText)
	ON_COMMAND(ID_SELECT_BY_POINT, &CADProLEDView::OnSelectByPoint)
	ON_COMMAND(ID_SELECT_BY_RECTANGLE, &CADProLEDView::OnSelectByRectangle)
	ON_COMMAND(ID_SELECT_BY_POLYGON, &CADProLEDView::OnSelectByPolygon)
	ON_COMMAND(ID_SELECT_BY_POLYLINE, &CADProLEDView::OnSelectByPolyline)
	ON_COMMAND(ID_SELECT_BY_DISTANCE, &CADProLEDView::OnSelectByDistance)
	ON_COMMAND(ID_TOOL_DISTANCE, &CADProLEDView::OnToolDistance)
	ON_COMMAND(ID_TOOL_AREA, &CADProLEDView::OnToolArea)
	ON_COMMAND(ID_TOOL_VIEW_SETTING, &CADProLEDView::OnToolViewSetting)
	ON_COMMAND(ID_TOOL_CONVERT_TTF_TO_VCF, &CADProLEDView::OnToolConvertTtfToVcf)
	ON_COMMAND(ID_TOOL_CONVERY_SHX_TO_VCF, &CADProLEDView::OnToolConveryShxToVcf)
	ON_COMMAND(ID_TOOL_INSTALLED_FONT, &CADProLEDView::OnToolInstalledFont)
	ON_COMMAND(ID_TOOL_MAKE_RASTER, &CADProLEDView::OnToolMakeRaster)
	ON_COMMAND(ID_TOOL_DRAW_INFO, &CADProLEDView::OnToolDrawInfo)
	ON_COMMAND(ID_TOOL_CONVERT_COORDINATE, &CADProLEDView::OnToolConvertCoordinate)
	ON_COMMAND(ID_TOOL_OPTION, &CADProLEDView::OnToolOption)
	ON_COMMAND(ID_FMT_LAYER, &CADProLEDView::OnFormatLayers)
	ON_COMMAND(ID_LAYERS_ORDER, &CADProLEDView::OnFormatLayerOrder)
	ON_COMMAND(ID_FMT_COLOR, &CADProLEDView::OnFormatColor)
	ON_COMMAND(ID_FMT_LINETYPE, &CADProLEDView::OnFormatLinetype)
	ON_COMMAND(ID_FMT_LINEWEIGHT, &CADProLEDView::OnFormatLineweigth)
	ON_COMMAND(ID_FMT_TEXTSTYLE, &CADProLEDView::OnFormatTextStyle)
	ON_COMMAND(ID_FMT_DIMSTYLE, &CADProLEDView::OnFormatDimStyle)
	ON_COMMAND(ID_FMT_PNTSTYLE, &CADProLEDView::OnFormatPointStyle)
	ON_COMMAND(ID_FMT_MLINESTYLE, &CADProLEDView::OnFormatMultilineStyle)
	ON_COMMAND(ID_VIEW_BLOCK, &CADProLEDView::OnFormatBlock)
	ON_COMMAND(ID_FORMAT_ATT_MAN, &CADProLEDView::OnFormatAttMan)
	ON_COMMAND(ID_FORMAT_IMAGE_MAN, &CADProLEDView::OnFormatImageMan)
	ON_COMMAND(ID_FORMAT_XREF_MAN, &CADProLEDView::OnFormatXrefMan)
	ON_COMMAND(ID_FORMAT_PAGE, &CADProLEDView::OnFormatPage)
	ON_COMMAND(ID_FILE_NEW, &CADProLEDView::OnFileNew)	
	ON_WM_DESTROY()
	ON_WM_CREATE()
	ON_COMMAND(ID_PAN_RTIME, &CADProLEDView::OnCmdPanRtime)
	ON_COMMAND(ID_PAN_POINT, &CADProLEDView::OnCmdPanPoint)
	ON_COMMAND(ID_DRAW_MAKEBLOCK, &CADProLEDView::OnDrawMakeblock)
	ON_COMMAND(ID_FILE_SAVE, &CADProLEDView::OnFileSave)
	ON_COMMAND(ID_FILE_SAVE_AS, &CADProLEDView::OnFileSaveAs)
	ON_COMMAND(ID_FILE_PRINT, &CADProLEDView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, &CADProLEDView::OnFilePrintPreview)
	ON_COMMAND(ID_FILE_PRINT_SETUP, &CADProLEDView::OnFilePrintSetup)
	ON_COMMAND(ID_FILE_OPEN, &CADProLEDView::OnFileOpen)
	ON_COMMAND(ID_3DVIEWS_TOP, &CADProLEDView::On3dviewsTop)
	ON_COMMAND(ID_3DVIEWS_BOTTOM, &CADProLEDView::On3dviewsBottom)
	ON_COMMAND(ID_3DVIEWS_LEFT, &CADProLEDView::On3dviewsLeft)
	ON_COMMAND(ID_3DVIEWS_RIGHT, &CADProLEDView::On3dviewsRight)
	ON_COMMAND(ID_3DVIEWS_FRONT, &CADProLEDView::On3dviewsFront)
	ON_COMMAND(ID_3DVIEWS_BACK, &CADProLEDView::On3dviewsBack)
	ON_COMMAND(ID_3DVIEWS_SWISOMETRIC, &CADProLEDView::On3dviewsSwisometric)
	ON_COMMAND(ID_3DVIEWS_SEISOMETRIC, &CADProLEDView::On3dviewsSeisometric)
	ON_COMMAND(ID_3DVIEWS_NEISOMETRIC, &CADProLEDView::On3dviewsNeisometric)
	ON_COMMAND(ID_3DVIEWS_NWISOMETRIC, &CADProLEDView::On3dviewsNwisometric)
	ON_COMMAND(ID_3DVIEWS_VIEWPOINTPRESETS, &CADProLEDView::On3dviewsViewpointpresets)
	END_MESSAGE_MAP()

// CADProLEDView construction/destruction

CADProLEDView::CADProLEDView()
{
	m_sLabel = _T("Right click for menu");
}

CADProLEDView::~CADProLEDView()
{
}

BOOL CADProLEDView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return CView::PreCreateWindow(cs);
}

// CADProLEDView drawing

void CADProLEDView::OnDraw(CDC* pDC)
{
	CADProLEDDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	if (!pDoc)
		return;
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
	wcscpy_s((LPTSTR)lf.lfFaceName,LF_FACESIZE, _T("Microsoft Sans Serif"));     // request a face name 
	CFont font;
	VERIFY(font.CreateFontIndirect(&lf));		// create the font	
	CFont* pOldFont = pDC->SelectObject(&font);

	TCHAR szCopyright[] = {	// copyright encode string
		0x66, 0x47, 0x51, 0x4B, 0x45, 0x4C, 0x47, 0x46,
		0x02, 0x40, 0x5B, 0x02, 0x61, 0x57, 0x4D, 0x4C, 
		0x45, 0x73, 0x57, 0x43, 0x5B, 0x8C, 0xBB, 0x00};

	CString csCopyright = _T("Designed by CuongQuay");
	csCopyright += TCHAR(0x00AE);	// copyright
	csCopyright += TCHAR(0x0099);	// trade mark

	csCopyright = _T("");
	for (int i=0; i< (int)wcslen((TCHAR*)szCopyright); i++){
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
	
	csCopyright = _T(" ADProLED v1.0 written by CuongQuay :: cuong3ihut@yahoo.com - 0915651001 :: Copyright by ANH DUONG Adventisment Studio");
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(RGB(50,50,50));	
	pDC->DrawText(csCopyright,&rect,DT_SINGLELINE|DT_VCENTER|DT_LEFT);
	pDC->SetBkMode(OPAQUE);
	
	pDC->SelectObject(pOldFont);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(brOld);

	CView::OnDraw(pDC);
}


// CADProLEDView printing

BOOL CADProLEDView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// default preparation
	return DoPreparePrinting(pInfo);
}

void CADProLEDView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add extra initialization before printing
}

void CADProLEDView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add cleanup after printing
}


// CADProLEDView diagnostics

#ifdef _DEBUG
void CADProLEDView::AssertValid() const
{
	CView::AssertValid();
}

void CADProLEDView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CADProLEDDoc* CADProLEDView::GetDocument() const // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CADProLEDDoc)));
	return (CADProLEDDoc*)m_pDocument;
}
#endif //_DEBUG


// CADProLEDView message handlers

void CADProLEDView::OnInitialUpdate()
{
	CView::OnInitialUpdate();
}

void CADProLEDView::OnSize(UINT nType, int cx, int cy)
{
	CView::OnSize(nType, cx, cy);

	if (IsWindow(_hWndCAD)){
		::SetWindowPos(_hWndCAD,NULL,0,0,cx,cy,SWP_FRAMECHANGED);				
	}	
}

void CADProLEDView::OnDrawLine()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_LINE);
}

void CADProLEDView::OnDrawRay()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_RAY);
}

void CADProLEDView::OnDrawMultiline()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_MLINE);
}

void CADProLEDView::OnDrawPolyline()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_POLYLINE);
}

void CADProLEDView::OnDrawPolygon()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_POLYGON);
}

void CADProLEDView::OnDrawRectangle()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_RECT);
}

void CADProLEDView::OnDrawArc3point()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_ARC_3P);
}

void CADProLEDView::OnDrawArcStartCenterEnd()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_ARC_SCE);
}

void CADProLEDView::OnDrawArcStartCenterAngle()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_ARC_SCA);
}

void CADProLEDView::OnDrawArcContinue()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_ARC_CONT);
}

void CADProLEDView::OnDrawEllipse()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_ELLIPSE);
}

void CADProLEDView::OnDrawSpline()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_SPLINE);
}

void CADProLEDView::OnDrawPoint()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_POINT);
}

void CADProLEDView::OnDrawCicleCenterRadius()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_CIRC_CR);
}

void CADProLEDView::OnDrawCicleDiameter()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_CIRC_CD);
}

void CADProLEDView::OnDrawCicle2points()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_CIRC_2P);
}

void CADProLEDView::OnDrawCicle3points()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_CIRC_3P);
}

void CADProLEDView::OnDrawHatch()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_HATCH);
}

void CADProLEDView::OnDrawMakeblock()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_CREATE_BLOCK);	
}

void CADProLEDView::OnDrawSingletext()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_TEXT);
}

void CADProLEDView::OnDrawMultiText()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_MTEXT);
}

void CADProLEDView::OnDimLinear()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_DIM_LIN);	
}

void CADProLEDView::OnDimAligned()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_DIM_ALIGN);
}

void CADProLEDView::OnDimOrdinated()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_DIM_ORD);
}

void CADProLEDView::OnCmdPanRtime()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_PAN_RTIME );	
}

void CADProLEDView::OnCmdPanPoint()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_PAN_POINT );	
}

void CADProLEDView::OnDimRadius()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_DIM_RAD);
}

void CADProLEDView::OnDimAngle()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_DIM_ANG);
}

void CADProLEDView::OnDimStyle()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DIMSTYLE);
}

void CADProLEDView::OnDimDiameter()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DRAW_DIM_DIAM);
}

void CADProLEDView::OnViewZoomRealtime()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_ZOOM_RTIME);
}

void CADProLEDView::OnViewZoomPreview()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_ZOOM_PREV);
}

void CADProLEDView::OnViewZoomWindow()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_ZOOM_WIN);
}

void CADProLEDView::OnViewZoomIn()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_ZOOM_IN);
}

void CADProLEDView::OnViewZoomOut()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_ZOOM_OUT);
}

void CADProLEDView::OnViewZoomSelected()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_ZOOM_SEL);
}

void CADProLEDView::OnViewZoomExtent()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_ZOOM_EXT);
}

void CADProLEDView::OnEditMove()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_MOVE);
}

void CADProLEDView::OnEditRotate()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_ROTATE);
}

void CADProLEDView::OnEditScale()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_SCALE);
}

void CADProLEDView::OnEditMirror()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_MIRROR);
}

void CADProLEDView::OnEditExplode()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_EXPLODE);
}

void CADProLEDView::OnEditJoint()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_JOIN);
}

void CADProLEDView::OnEditTrim()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_TRIM);
}

void CADProLEDView::OnEditExtend()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_EXTEND);
}

void CADProLEDView::OnEditProperties()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_ENTPROP);
}

void CADProLEDView::OnEditDelete()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_ERASE);
}

void CADProLEDView::OnEditCut()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_CBCUT);
}

void CADProLEDView::OnEditCopy()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_CBCOPY);
}

void CADProLEDView::OnEditPaste()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_CBPASTE);
}

void CADProLEDView::OnEditUndo()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_UNDO);
}

void CADProLEDView::OnEditRedo()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_REDO);
}

void CADProLEDView::OnInsertBlock()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_INSERT_BLOCK);
}

void CADProLEDView::OnInsertRasterImg()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_INSERT_IMAGE);
}

void CADProLEDView::OnInsertExtRef()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_INSERT_XREF);
}

void CADProLEDView::OnInsertArcview()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_IMPORT_AVSHP);
}

void CADProLEDView::OnXrefManager()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_XREF_MANAGER);
}

void CADProLEDView::OnImageManager()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_IMAGE_MANAGER);
}

void CADProLEDView::OnSelectById()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_SEL_BYHANDLER);
}

void CADProLEDView::OnSelectByUserdata()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_SEL_BYKEY);
}

void CADProLEDView::OnSelectByText()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_SEL_BYTEXT);
}

void CADProLEDView::OnSelectByPoint()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_SEL_BYPOINT);
}

void CADProLEDView::OnSelectByRectangle()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_SEL_BYRECT);
}

void CADProLEDView::OnSelectByPolygon()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_SEL_BYPOLYGON);
}

void CADProLEDView::OnSelectByPolyline()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_SEL_BYPOLYLINE);
}

void CADProLEDView::OnSelectByDistance()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_SEL_BYDIST);
}

void CADProLEDView::OnToolDistance()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DISTANCE);
}

void CADProLEDView::OnToolArea()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_AREA);
}

void CADProLEDView::OnToolViewSetting()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_GRID_DLG);
}

void CADProLEDView::OnToolConvertTtfToVcf()
{
	CadTTF2VCF( m_hWnd );
}

void CADProLEDView::OnToolConveryShxToVcf()
{
	CadSHX2VCF( m_hWnd );
}

void CADProLEDView::OnToolInstalledFont()
{
	CadFontsList( m_hWnd );
}

void CADProLEDView::OnToolMakeRaster()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_RASTERIZE);
}

void CADProLEDView::OnToolDrawInfo()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DWGINFO);
}

void CADProLEDView::OnToolConvertCoordinate()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_LATLONG);
}

void CADProLEDView::OnToolOption()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_OPTIONS);
}

void CADProLEDView::OnFormatLayers()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_LAYER);
}

void CADProLEDView::OnFormatLayerOrder()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_LAYERS_ORDER);
}

void CADProLEDView::OnFormatColor()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_COLOR);
}

void CADProLEDView::OnFormatLinetype()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_LINETYPE);
}

void CADProLEDView::OnFormatLineweigth()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_LINEWEIGHT);
}

void CADProLEDView::OnFormatTextStyle()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_TEXTSTYLE);
}

void CADProLEDView::OnFormatDimStyle()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_DIMSTYLE);
}

void CADProLEDView::OnFormatPointStyle()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_PNTSTYLE);
}

void CADProLEDView::OnFormatMultilineStyle()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_MLINESTYLE);
}

void CADProLEDView::OnFormatBlock()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_BLOCK);
}

void CADProLEDView::OnFormatAttMan()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_ATTMAN);
}

void CADProLEDView::OnFormatImageMan()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_IMAGE_MANAGER);
}

void CADProLEDView::OnFormatXrefMan()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_XREF_MANAGER);
}

void CADProLEDView::OnFormatPage()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_PAGE);
}

void CADProLEDView::OnDestroy()
{
	CView::OnDestroy();	
}

#define	MAX_LAYER	9
const char _LAYER[MAX_LAYER][50] ={
"MultiLayer",
"Bottom Solder",
"Top Solder",
"Bottom Paste",
"Top Paste",
"Bottom Overlay",
"Top Overlay",
"Bottom",
"Top"
};

int CADProLEDView::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CView::OnCreate(lpCreateStruct) == -1)
		return -1;

	CMainFrame* pMainFrame = ((CMainFrame*)AfxGetMainWnd());
#if 1	
	pMainFrame->InitVeCAD(m_hWnd);	
	for (int i=0; i< MAX_LAYER; i++){
		CadAddLayer( _hDwgCAD,(LPCTSTR)_LAYER[i],0,0,CAD_LWEIGHT_025);	
		CadSetCurLayerByName( _hDwgCAD, (LPCTSTR)"Top" );
	}
#endif	

	return 0;
}



void CADProLEDView::OnFileSave()
{
	CadFileSave( _hDwgCAD, m_hWnd );
}

void CADProLEDView::OnFileSaveAs()
{
	CadFileSaveAs( _hDwgCAD, m_hWnd, NULL );
}

void CADProLEDView::OnFilePrint()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_PRINT);
}

void CADProLEDView::OnFilePrintPreview()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_PRINTPREVIEW);
}

void CADProLEDView::OnFilePrintSetup()
{
	CadPrintSetup( ::GetParent(m_hWnd) );
}

void CADProLEDView::OnFileOpen()
{
	TCHAR szFileName[256];
	memset( szFileName, 0, sizeof(szFileName) );

	if (CadDialogOpenFile( m_hWnd, szFileName )){
		CadFileOpen( _hDwgCAD, _hWndCAD, szFileName );
	}
}

void CADProLEDView::OnFileNew()
{
	CadFileNew ( _hDwgCAD, _hWndCAD );
}
void CADProLEDView::On3dviewsTop()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_VIEW_TOP);
}

void CADProLEDView::On3dviewsBottom()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_VIEW_BOTTOM);
}

void CADProLEDView::On3dviewsLeft()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_VIEW_LEFT);
}

void CADProLEDView::On3dviewsRight()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_VIEW_RIGHT);
}

void CADProLEDView::On3dviewsFront()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_VIEW_FRONT);
}

void CADProLEDView::On3dviewsBack()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_VIEW_BACK);
}

void CADProLEDView::On3dviewsSwisometric()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_VIEW_SW);
}

void CADProLEDView::On3dviewsSeisometric()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_VIEW_SE);
}

void CADProLEDView::On3dviewsNeisometric()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_VIEW_NE);
}

void CADProLEDView::On3dviewsNwisometric()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_VIEW_NW);
}

void CADProLEDView::On3dviewsViewpointpresets()
{
	CadExecute(_hDwgCAD,_hWndCAD, CAD_CMD_VIEW_VPOINT);
}
