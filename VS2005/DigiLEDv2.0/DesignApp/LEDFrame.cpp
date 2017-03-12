// LEDFrame.cpp : implementation file
//

#include "stdafx.h"
#include "DigiLED.h"
#include "LEDFrame.h"
#include "AddControlDlg.h"
#include "resource.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CLEDFrame

CLEDFrame::CLEDFrame()
{	
	m_nReposition =0;
	m_bNewLoad = FALSE;
	m_bRepositionMod = FALSE;
}

CLEDFrame::~CLEDFrame()
{
	RemoveAll();
}


BEGIN_MESSAGE_MAP(CLEDFrame, CStatic)
	ON_WM_CONTEXTMENU()
	//{{AFX_MSG_MAP(CLEDFrame)
	ON_WM_PAINT()
	ON_COMMAND(ID_EDIT_CTL_CUT, OnEditCtlCut)
	ON_COMMAND(ID_EDIT_CTL_COPY, OnEditCtlCopy)
	ON_COMMAND(ID_EDIT_CTL_PASTE, OnEditCtlPaste)
	ON_WM_LBUTTONDBLCLK()
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONUP()
	ON_WM_SIZE()
	ON_MESSAGE(WM_STATICEDIT_LBUTTONUP,OnStaticEditLButtonUp)
	ON_MESSAGE(WM_STATICEDIT_REMOVE,OnStaticEditRemove)
	ON_MESSAGE(WM_STATICEDIT_COPY,OnStaticEditCopy)
	ON_MESSAGE(WM_STATICEDIT_CUT,OnStaticEditCut)
	ON_MESSAGE(WM_STATICEDIT_SELECTED,OnStaticEditSelected)
	//}}AFX_MSG_MAP	
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLEDFrame message handlers

BOOL CLEDFrame::DestroyWindow() 
{	
	return CStatic::DestroyWindow();
}

void CLEDFrame::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
	CDC* pDC = &dc;
	CRect rect=CRect();
	GetClientRect(&rect);
#if 0	
	
	CBrush br(_stData.m_clrBkGnd);	
	CPen pen(PS_NULL,1,RGB(0,0,0));
	CPen* pPenOld = pDC->SelectObject(&pen);
	CBrush* pBrOld = pDC->SelectObject(&br);
	pDC->Rectangle(&rect);

	CPen penGrid(PS_SOLID,1,_stData.m_clrGrid);
	pDC->SelectObject(&penGrid);
	int x = rect.Width()/_stData.m_nGridSize;
	int y = rect.Height()/_stData.m_nGridSize;
	CRect rcGrid = CRect(0,0,_stData.m_nGridSize,_stData.m_nGridSize);
	for (int i=0; i< x; i++){
		CRect rc = rcGrid;
		for (int j=0; j< y; j++){
			CRect rcDraw = rc;
			rcDraw.InflateRect(1,1,1,1);
			pDC->Rectangle(&rcDraw);
			rc.OffsetRect(0,_stData.m_nGridSize);
		}
		rcGrid.OffsetRect(_stData.m_nGridSize,0);
	}
	pDC->SelectObject(pPenOld);
	pDC->SelectObject(pBrOld);
#else
	// show main frame image
	if (m_bNewLoad)
	{
		CDC dcMemory;
		dcMemory.CreateCompatibleDC(pDC);
		CBitmap* pOldBitmap = dcMemory.SelectObject(&m_bmpFrame);						
		pDC->BitBlt(rect.left, rect.top, rect.Width()-1, rect.Height(), &dcMemory,0, 0, SRCCOPY);	
		dcMemory.SelectObject(pOldBitmap);
	}
#endif	
}

BOOL CLEDFrame::AddLED(const CRect& rect, int nDigit, int nHeight, LPCTSTR szFontName)
{	
	CLEDPageEdit* pLED = new CLEDPageEdit();						
	if ( pLED ){		
		this->AddControl(pLED,rect,nDigit,nHeight,szFontName);
		pLED->SetNumID(m_arrLEDEdit.GetSize());		
		m_arrLEDEdit.Add(pLED);				
	}
	else{
		return FALSE;	
	}			
	return TRUE;
}
BOOL CLEDFrame::AddMatrix(const CRect& rect, int nDigit, int nHeight, LPCTSTR szFontName)
{	
	CMatrixPageEdit* pLED = new CMatrixPageEdit();						
	if ( pLED ){
		this->AddControl(pLED,rect,nDigit,nHeight,szFontName);
		pLED->SetNumID(m_arrMatrixEdit.GetSize());		
		m_arrMatrixEdit.Add(pLED);				
	}
	else{
		return FALSE;	
	}			
	return TRUE;
}

BOOL CLEDFrame::AddStatic(const CRect& rect, int nDigit, int nHeight, LPCTSTR szFontName)
{	
	CStaticPageEdit* pLED = new CStaticPageEdit();						
	if ( pLED ){
		this->AddControl(pLED,rect,nDigit,nHeight,szFontName);
		pLED->SetNumID(m_arrStaticEdit.GetSize());		
		m_arrStaticEdit.Add(pLED);				
	}
	else{
		return FALSE;	
	}			
	return TRUE;
}

LRESULT CLEDFrame::OnStaticEditLButtonUp(WPARAM wParam, LPARAM lParam)
{
#ifdef __DESIGN_MODE
	CStaticPageEdit* pLED = (CStaticPageEdit*)wParam;
	if (pLED){
		CRect rect=CRect();
		pLED->GetWindowRect(&rect);
		ScreenToClient(&rect);
		int x = (rect.left/_stData.m_nGridSize)*_stData.m_nGridSize;
		int y = (rect.top/_stData.m_nGridSize)*_stData.m_nGridSize;	
		pLED->SetWindowPos(NULL,x,y,0,0,SWP_NOSIZE);
		if (m_bRepositionMod){
			pLED->SetNumID(m_nReposition++);
		}
	}
#endif
	return 0;
}

LRESULT CLEDFrame::OnStaticEditRemove(WPARAM wParam, LPARAM lParam)
{			
	return 0;
}

LRESULT CLEDFrame::OnStaticEditCut(WPARAM wParam, LPARAM lParam)
{
	return 0;
}

LRESULT CLEDFrame::OnStaticEditCopy(WPARAM wParam, LPARAM lParam)
{
	return 0;
}

LRESULT CLEDFrame::OnStaticEditSelected(WPARAM wParam, LPARAM lParam)
{
	return 0;
}

BOOL CLEDFrame::RemoveLED(CLEDPageEdit* pLED)
{
	int index = 0;
	BOOL bFound = FALSE;
	CLEDPageEdit* pLEDFound = NULL;
	for (int i=0; i< m_arrLEDEdit.GetSize(); i++){
		pLEDFound = m_arrLEDEdit.GetAt(i);
		if (pLEDFound !=NULL && pLEDFound == pLED){
			bFound = TRUE;
			index =i;
			break;
		}
	}

	if (bFound){
		pLEDFound->DestroyWindow();
		delete pLEDFound;
		m_arrLEDEdit.RemoveAt(index);
	}

	return TRUE;
}

BOOL CLEDFrame::RemoveMatrix(CMatrixPageEdit* pLED)
{
	int index =0;
	BOOL bFound = FALSE;
	CMatrixPageEdit* pLEDFound = NULL;
	for (int i=0; i< m_arrMatrixEdit.GetSize(); i++){
		pLEDFound = m_arrMatrixEdit.GetAt(i);
		if (pLEDFound !=NULL && pLEDFound == pLED){
			bFound = TRUE;
			index =i;
			break;
		}
	}

	if (bFound){
		pLEDFound->DestroyWindow();
		delete pLEDFound;
		m_arrMatrixEdit.RemoveAt(index);
	}

	return TRUE;
}

BOOL CLEDFrame::RemoveStatic(CStaticPageEdit* pLED)
{
	int index =0;
	BOOL bFound = FALSE;
	CStaticPageEdit* pLEDFound = NULL;
	for (int i=0; i< m_arrStaticEdit.GetSize(); i++){
		pLEDFound = m_arrStaticEdit.GetAt(i);
		if (pLEDFound !=NULL && pLEDFound == pLED){
			bFound = TRUE;
			index =i;
			break;
		}
	}

	if (bFound){
		pLEDFound->DestroyWindow();
		delete pLEDFound;
		m_arrStaticEdit.RemoveAt(index);
	}

	return TRUE;
}

void CLEDFrame::OnContextMenu(CWnd*, CPoint point)
{

	// CG: This block was added by the Pop-up Menu component
	{
		if (point.x == -1 && point.y == -1){
			//keystroke invocation
			CRect rect;
			GetClientRect(rect);
			ClientToScreen(rect);

			point = rect.TopLeft();
			point.Offset(5, 5);
		}

		CMenu menu;
		VERIFY(menu.LoadMenu(CG_IDR_POPUP_LEDFRAME));

		CMenu* pPopup = menu.GetSubMenu(0);
		ASSERT(pPopup != NULL);
		CWnd* pWndPopupOwner = this;
		
		pPopup->TrackPopupMenu(TPM_LEFTALIGN | TPM_RIGHTBUTTON, point.x, point.y,
			pWndPopupOwner);
	}
}

void CLEDFrame::OnEditCtlCut() 
{
}

void CLEDFrame::OnEditCtlCopy() 
{
}

void CLEDFrame::OnEditCtlPaste() 
{
}



void CLEDFrame::OnLButtonDblClk(UINT nFlags, CPoint point) 
{	
	CStatic::OnLButtonDblClk(nFlags, point);
}

void CLEDFrame::OnLButtonDown(UINT nFlags, CPoint point) 
{
	CStatic::OnLButtonDown(nFlags, point);
}

void CLEDFrame::OnLButtonUp(UINT nFlags, CPoint point) 
{
	CStatic::OnLButtonUp(nFlags, point);
}

void CLEDFrame::AddControl()
{
	CAddControlDlg dlg;
	int nRes = dlg.DoModal();
	CRect rect = CRect(0,0,dlg.m_nWidth,dlg.m_nHeight);
	while (nRes == IDC_ADD_CONTROL){
		for (int i=0; i< (int)dlg.m_nNums; i++){
			if (dlg.m_nControlID == STYLE_LED){
				if (!AddLED(rect,dlg.m_nDigits,dlg.m_nHeight,dlg.m_csFontName)){
					break;
				}
			}
			else if (dlg.m_nControlID == STYLE_MATRIX){
				if (!AddMatrix(rect,dlg.m_nDigits,dlg.m_nHeight,dlg.m_csFontName)){
					break;
				}
			}
			else if (dlg.m_nControlID == STYLE_STATIC){
				if (!AddStatic(rect,dlg.m_nDigits,dlg.m_nHeight,dlg.m_csFontName)){
					break;
				}
			}
			rect.OffsetRect(0,dlg.m_nHeight);
		}
		nRes = dlg.DoModal();
	}			
}

void CLEDFrame::ReCreateNumID()
{
	for (int i=0; i< m_arrLEDEdit.GetSize(); i++){
		CLEDPageEdit* pLED = m_arrLEDEdit.GetAt(i);
		if (pLED){
			pLED->SetNumID(i);
		}
	}
	for (int i=0; i< m_arrMatrixEdit.GetSize(); i++){
		CMatrixPageEdit* pLED = m_arrMatrixEdit.GetAt(i);
		if (pLED){
			pLED->SetNumID(i);
		}
	}
	for (int i=0; i< m_arrStaticEdit.GetSize(); i++){
		CStaticPageEdit* pLED = m_arrStaticEdit.GetAt(i);
		if (pLED){
			pLED->SetNumID(i);
		}
	}
}

void CLEDFrame::RemoveControl(UINT nStyle, LPVOID pLED)
{
	RemoveLED((CLEDPageEdit*)pLED);
	RemoveMatrix((CMatrixPageEdit*)pLED);
	RemoveStatic((CStaticPageEdit*)pLED);	
	ReCreateNumID();
}

void CLEDFrame::InitControl(HWND hWnd)
{
	m_bmpFrame.LoadBitmap(IDB_MAINFORM);	
}

void CLEDFrame::ShowControlID(BOOL bShow)
{
	for (int i=0; i< m_arrLEDEdit.GetSize(); i++){
		CLEDPageEdit* pLED = m_arrLEDEdit.GetAt(i);
		if (pLED){
			pLED->ShowNumID(bShow);
		}
	}
	for (int i=0; i< m_arrMatrixEdit.GetSize(); i++){
		CMatrixPageEdit* pLED = m_arrMatrixEdit.GetAt(i);
		if (pLED){
			pLED->ShowNumID(bShow);
		}
	}
	for (int i=0; i< m_arrStaticEdit.GetSize(); i++){
		CStaticPageEdit* pLED = m_arrStaticEdit.GetAt(i);
		if (pLED){
			pLED->ShowNumID(bShow);
		}
	}	
}

void CLEDFrame::LoadControl(CArchive& ar)
{
	this->RemoveAll();
	TCHAR szError[MAX_PATH];
	try {		
		int nSize =0;
		ar>>nSize;		
		for (int i=0; i< nSize; i++){			
			CLEDPageEdit* pLED =NULL;
			if (!pLED){ 
				pLED = new CLEDPageEdit();			
			}
			if (pLED){
				this->LoadControl(ar,pLED);					
				m_arrLEDEdit.SetAtGrow(pLED->GetNumID(),pLED);
			}
		}
		ar>>nSize;
		for (int i=0; i< nSize; i++){
			CMatrixPageEdit* pLED = NULL;			
			if (!pLED){
				pLED =new CMatrixPageEdit();				
			}
			if (pLED){
				this->LoadControl(ar,pLED);					
				m_arrMatrixEdit.SetAtGrow(pLED->GetNumID(),pLED);
			}
		}
		ar>>nSize;
		for (int i=0; i< nSize; i++){
			CStaticPageEdit* pLED = NULL;
			pLED =new CStaticPageEdit();							
			if (pLED){
				this->LoadControl(ar,pLED);						
				m_arrStaticEdit.SetAtGrow(pLED->GetNumID(),pLED);
			}
		}		

		m_bNewLoad = TRUE;
		this->Invalidate(FALSE);
	}
	catch (CFileException* e){
		e->GetErrorMessage(szError,sizeof(szError));
		MessageBox(szError);
	}
	catch (CMemoryException* e){
		e->GetErrorMessage(szError,sizeof(szError));
		MessageBox(szError);
	}
	catch (CArchiveException* e){
		e->GetErrorMessage(szError,sizeof(szError));
		MessageBox(szError);
	}	
}

void CLEDFrame::SaveControl(CArchive& ar)
{
	if (!m_bNewLoad){
		return;
	}
	TCHAR szError[MAX_PATH];
	try {
		ar<<m_arrLEDEdit.GetSize();
		for (int i=0; i< m_arrLEDEdit.GetSize(); i++){			
			CLEDPageEdit* pLED = m_arrLEDEdit.GetAt(i);
			if (pLED){
				this->StoreControl(ar,pLED);				
			}
		}
		ar<<m_arrMatrixEdit.GetSize();
		for (int i=0; i< m_arrMatrixEdit.GetSize(); i++){
			CMatrixPageEdit* pLED = m_arrMatrixEdit.GetAt(i);
			if (pLED){
				this->StoreControl(ar,pLED);
			}
		}
		ar<<m_arrStaticEdit.GetSize();
		for (int i=0; i< m_arrStaticEdit.GetSize(); i++){
			CStaticPageEdit* pLED = m_arrStaticEdit.GetAt(i);
			if (pLED){
				this->StoreControl(ar,pLED);
			}
		}		
	}
	catch (CFileException* e){
		e->GetErrorMessage(szError,sizeof(szError));	
		MessageBox(szError);
	}
	catch (CMemoryException* e){
		e->GetErrorMessage(szError,sizeof(szError));
		MessageBox(szError);
	}
	catch (CArchiveException* e){
		e->GetErrorMessage(szError,sizeof(szError));
		MessageBox(szError);
	}
}

void CLEDFrame::StoreControl(CArchive& ar, CStaticEdit *pLED)
{
	CRect rect;
	pLED->GetWindowRect(&rect);
	ar<<rect;
	ar<<pLED->GetDigits();
	ar<<pLED->GetFontName();
	ar<<pLED->_stParam.clrBk;
	ar<<pLED->_stParam.clrSegOff;
	ar<<pLED->_stParam.clrSeg;
	ar<<pLED->GetNumID();
	CString csText;
	for (int i=0; i< MAX_PAGE; i++){
		pLED->GetPageText(csText,MAX_PAGE-i-1);			
		ar<<csText;		
	}
}

void CLEDFrame::LoadControl(CArchive &ar, CStaticEdit *pLED)
{
	int nDigits;
	UINT nNumID=0;
	CString csFontName;
	CRect rect;
	CString csText;
	ar>>rect;
	ar>>nDigits;
	ar>>csFontName;
	ar>>pLED->_stParam.clrBk;
	ar>>pLED->_stParam.clrSegOff;
	ar>>pLED->_stParam.clrSeg;
	ar>>nNumID;		

	for (int i=0; i< MAX_PAGE; i++){		
		ar>>csText;		
		pLED->SetPageText(csText,MAX_PAGE -i-1);	
	}

	ScreenToClient(&rect);
	if (pLED){
		pLED->Create(_T(""),WS_CHILD|WS_VISIBLE|SS_NOTIFY,rect,this);
		pLED->InitControl(m_hWnd);		
		pLED->ShowWindow(SW_SHOW);
		pLED->UpdateWindow();						
		pLED->SetDigit(nDigits);
		pLED->SetFont(csFontName,rect.Height()-3);
		pLED->SetBkColor(pLED->_stParam.clrBk);
		pLED->SetColor(pLED->_stParam.clrSegOff,pLED->_stParam.clrSeg);		
		pLED->SetText(csText);		
		pLED->SetNumID(nNumID);		
	}
}

void CLEDFrame::AddControl(CStaticEdit *pLED, const CRect &rect, int nDigit, int nHeight, LPCTSTR szFontName)
{
	if (pLED){
		pLED->Create(_T(""),WS_CHILD|WS_VISIBLE|SS_NOTIFY,rect,this);
		pLED->InitControl(m_hWnd);
		pLED->SetDigit(nDigit);
		pLED->SetFont(szFontName,nHeight-4);
		pLED->SetBkColor(pLED->_stParam.clrBk);
		pLED->SetColor(pLED->_stParam.clrSegOff,pLED->_stParam.clrSeg);		
		pLED->ShowWindow(SW_SHOW);
		pLED->UpdateWindow();	
		pLED->RedrawPanel();
	}
}

void CLEDFrame::OnSize(UINT nType, int cx, int cy) 
{
	CStatic::OnSize(nType, cx, cy);			
}

void CLEDFrame::RemoveAll()
{
	while (m_arrLEDEdit.GetSize()){
		CLEDPageEdit* pLED = m_arrLEDEdit.GetAt(0);
		if ( pLED ){
			m_arrLEDEdit.RemoveAt(0);
			pLED->DestroyWindow();
			delete pLED;
		}
	}
	while (m_arrMatrixEdit.GetSize()){
		CMatrixPageEdit* pLED = m_arrMatrixEdit.GetAt(0);
		if ( pLED ){
			m_arrMatrixEdit.RemoveAt(0);
			pLED->DestroyWindow();
			delete pLED;
		}
	}
	while (m_arrStaticEdit.GetSize()){
		CStaticPageEdit* pLED = m_arrStaticEdit.GetAt(0);
		if ( pLED ){
			m_arrStaticEdit.RemoveAt(0);
			pLED->DestroyWindow();
			delete pLED;
		}
	}
}

#define	MAX_UPDTBL		39
const BOOL _bLEDPageTbl[MAX_UPDTBL] = {
	12,11,10,
	22,21,20,
	32,31,30,
	39,38,37,
	46,45,44,
	53,52,51,
	60,59,58,
	71,70,69,
	79,78,77,
	83,82,81,
	13,
	23,
	33,
	40,
	47,
	54,
	61,
	72,
	84
};

BOOL CLEDFrame::IsPageEnable(UINT nID)
{
	BOOL bEnabled = FALSE;
	for (int i=0; i< MAX_UPDTBL; i++){
		if (nID == _bLEDPageTbl[i]){
			bEnabled = TRUE;
			break;
		}
	}	
	return bEnabled;
}

void CLEDFrame::SetCurrentPage(int nPage)
{
	for (int i=0; i< m_arrLEDEdit.GetSize(); i++){
		CLEDPageEdit* pLED = m_arrLEDEdit.GetAt(i);
		if (pLED){			
			pLED->SetCurrentPage(nPage,IsPageEnable(pLED->GetNumID()));
		}
	}
	for (int i=0; i< m_arrMatrixEdit.GetSize(); i++){
		CMatrixPageEdit* pLED = m_arrMatrixEdit.GetAt(i);
		if (pLED){
			pLED->SetCurrentPage(nPage,FALSE);
		}
	}
	for (int i=0; i< m_arrStaticEdit.GetSize(); i++){
		CStaticPageEdit* pLED = m_arrStaticEdit.GetAt(i);
		if (pLED){
			pLED->SetCurrentPage(nPage,TRUE);
		}
	}
}
