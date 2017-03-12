// ADProLEDView.h : interface of the CADProLEDView class
//


#pragma once

class CADProLEDView : public CView
{
protected: // create from serialization only	
	DECLARE_DYNCREATE(CADProLEDView)

// Attributes
public:
	
	CADProLEDDoc* GetDocument() const;
// Operations
public:
	CString m_sLabel;
	CString m_sTooltip;
	CString m_sUrl;
// Overrides
public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);

// Implementation
public:
	CADProLEDView();
	virtual ~CADProLEDView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	DECLARE_MESSAGE_MAP()
public:
	virtual void OnInitialUpdate();
public:
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnDrawLine();
	afx_msg void OnDrawRay();
	afx_msg void OnDrawMultiline();
public:
	afx_msg void OnDrawPolyline();
public:
	afx_msg void OnDrawPolygon();
public:
	afx_msg void OnDrawRectangle();
public:
	afx_msg void OnDrawArc3point();
public:
	afx_msg void OnDrawArcStartCenterEnd();
public:
	afx_msg void OnDrawArcContinue();
public:
	afx_msg void OnDrawEllipse();
public:
	afx_msg void OnDrawSpline();
public:
	afx_msg void OnDrawPoint();
public:
	afx_msg void OnDrawCicleCenterRadius();
public:
	afx_msg void OnDrawCicleDiameter();
public:
	afx_msg void OnDrawCicle2points();
public:
	afx_msg void OnDrawCicle3points();
public:
	afx_msg void OnDrawArcStartCenterAngle();
public:
	afx_msg void OnDrawSingletext();
public:
	afx_msg void OnDrawMultiText();
public:
	afx_msg void OnDrawHatch();
public:
	afx_msg void OnDimLinear();
public:
	afx_msg void OnDimAligned();
public:
	afx_msg void OnDimOrdinated();
public:
	afx_msg void OnDimRadius();
public:
	afx_msg void OnDimAngle();
public:
	afx_msg void OnDimStyle();
public:
	afx_msg void OnDimDiameter();
public:
	afx_msg void OnViewZoomRealtime();
public:
	afx_msg void OnViewZoomPreview();
public:
	afx_msg void OnViewZoomWindow();
public:
	afx_msg void OnViewZoomIn();
public:
	afx_msg void OnViewZoomOut();
public:
	afx_msg void OnViewZoomSelected();
public:
	afx_msg void OnEditMove();
public:
	afx_msg void OnEditRotate();
public:
	afx_msg void OnEditScale();
public:
	afx_msg void OnEditMirror();
public:
	afx_msg void OnEditExplode();
public:
	afx_msg void OnEditJoint();
public:
	afx_msg void OnEditTrim();
public:
	afx_msg void OnEditExtend();
public:
	afx_msg void OnEditProperties();
public:
	afx_msg void OnEditDelete();
public:
	afx_msg void OnEditCut();
public:
	afx_msg void OnEditCopy();
public:
	afx_msg void OnEditPaste();
public:
	afx_msg void OnEditUndo();
public:
	afx_msg void OnEditRedo();
public:
	afx_msg void OnInsertBlock();
public:
	afx_msg void OnInsertRasterImg();
public:
	afx_msg void OnInsertExtRef();
public:
	afx_msg void OnInsertArcview();
public:
	afx_msg void OnXrefManager();
public:
	afx_msg void OnImageManager();
public:
	afx_msg void OnSelectById();
public:
	afx_msg void OnSelectByUserdata();
public:
	afx_msg void OnSelectByText();
public:
	afx_msg void OnSelectByPoint();
public:
	afx_msg void OnSelectByRectangle();
public:
	afx_msg void OnSelectByPolygon();
public:
	afx_msg void OnSelectByPolyline();
public:
	afx_msg void OnSelectByDistance();
public:
	afx_msg void OnToolDistance();
public:
	afx_msg void OnToolArea();
public:
	afx_msg void OnToolViewSetting();
public:
	afx_msg void OnToolConvertTtfToVcf();
public:
	afx_msg void OnToolConveryShxToVcf();
public:
	afx_msg void OnToolInstalledFont();
public:
	afx_msg void OnToolMakeRaster();
public:
	afx_msg void OnToolDrawInfo();
public:
	afx_msg void OnToolConvertCoordinate();
public:
	afx_msg void OnToolOption();
public:
	afx_msg void OnFormatLayers();
public:
	afx_msg void OnFormatLayerOrder();
public:
	afx_msg void OnFormatColor();
public:
	afx_msg void OnFormatLinetype();
public:
	afx_msg void OnFormatLineweigth();
public:
	afx_msg void OnFormatTextStyle();
public:
	afx_msg void OnFormatDimStyle();
public:
	afx_msg void OnFormatPointStyle();
public:
	afx_msg void OnFormatMultilineStyle();
public:
	afx_msg void OnFormatBlock();
public:
	afx_msg void OnFormatAttMan();
public:
	afx_msg void OnFormatImageMan();
public:
	afx_msg void OnFormatXrefMan();
public:
	afx_msg void OnFormatPage();
public:
	afx_msg void OnFileNew();
public:
	afx_msg void OnViewZoomExtent();
public:
	afx_msg void OnDestroy();
public:
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
public:
	afx_msg void OnCmdPanRtime();
public:
	afx_msg void OnCmdPanPoint();
public:
	afx_msg void OnDrawMakeblock();
public:
	afx_msg void OnFileSave();
public:
	afx_msg void OnFileSaveAs();
public:
	afx_msg void OnFilePrint();
public:
	afx_msg void OnFilePrintPreview();
public:
	afx_msg void OnFilePrintSetup();
public:
	afx_msg void OnFileOpen();
public:
	afx_msg void On3dviewsTop();
public:
	afx_msg void On3dviewsBottom();
public:
	afx_msg void On3dviewsLeft();
public:
	afx_msg void On3dviewsRight();
public:
	afx_msg void On3dviewsFront();
public:
	afx_msg void On3dviewsBack();
public:
	afx_msg void On3dviewsSwisometric();
public:
	afx_msg void On3dviewsSeisometric();
public:
	afx_msg void On3dviewsNeisometric();
public:
	afx_msg void On3dviewsNwisometric();
public:
	afx_msg void On3dviewsViewpointpresets();
};

#ifndef _DEBUG  // debug version in ADProLEDView.cpp
inline CADProLEDDoc* CADProLEDView::GetDocument() const
   { return reinterpret_cast<CADProLEDDoc*>(m_pDocument); }
#endif

