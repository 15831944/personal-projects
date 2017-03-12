// MatrixSimulator.cpp : implementation file
//

#include "stdafx.h"
#include "MATRIX.h"
#include "FontDisp.h"
#include "MatrixSimulator.h"
#include "resource.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#define		TIMER_ID			1001
#define		CLOCK_ID			1002

extern FONT_CHAR char_map[256];	

static BYTE __SCREEN_LAYER[MAX_LINE][MAX_LAYER][MAX_WIDTH][MAX_HEIGHT];
/////////////////////////////////////////////////////////////////////////////
// CMatrixSimulator

CMatrixSimulator::CMatrixSimulator()
{
	m_cx = 0; m_cy = 0;
	m_ptPosition = CPoint(0,0);
		
	m_bHitScroll = FALSE;
	m_bReCalcMatrix = FALSE;
	m_pDCMem = NULL;
	m_nChar  = 0;
	m_nLine = 0;
		
	m_bOnCapture = FALSE;
	m_nDrawType = 0;
	m_nColorPen = 0;
	m_nCurrentLayer = 0;
	m_bScrolling = FALSE;
	m_bVisibleLayer[0] = TRUE;
	m_bVisibleLayer[1] = TRUE;
	m_bVisibleLayer[2] = TRUE;
	m_bVisibleLayer[3] = TRUE;
	for (int i = 0; i< MAX_LAYER; i++)
	{
		m_szTextPos[i] = CSize(0,0);
		m_nTextLengthPixel[i] = 0;
		m_bLoadImage[i] = FALSE;
		for (int line =0; line < MAX_LINE; line++){
			for (int row=0; row< MAX_HEIGHT; row++){
				for (int col=0; col< MAX_WIDTH; col++){
					__SCREEN_LAYER[line][i][col][row]=BLANK_STATE;	
				}
			}
		}
	}	
}

CMatrixSimulator::~CMatrixSimulator()
{
	if (m_pDCMem){
		//m_pDCMem->SelectObject(m_pOldBitmap);
		//m_pDCMem->DeleteDC();
		delete m_pDCMem;
	}
}


BEGIN_MESSAGE_MAP(CMatrixSimulator, CStatic)
	ON_WM_CONTEXTMENU()
	//{{AFX_MSG_MAP(CMatrixSimulator)
	ON_WM_DESTROY()
	ON_WM_PAINT()
	ON_WM_TIMER()
	ON_WM_CREATE()
	ON_COMMAND(ID_POPUP_CHANGESCALE_1X1, OnPopupChangescale1x1)
	ON_COMMAND(ID_POPUP_CHANGESCALE_2X2, OnPopupChangescale2x2)
	ON_COMMAND(ID_POPUP_CHANGESCALE_3X3, OnPopupChangescale3x3)
	ON_COMMAND(ID_POPUP_CHANGESCALE_4X4, OnPopupChangescale4x4)
	ON_COMMAND(ID_POPUP_STARTSCROLL, OnPopupStartscroll)
	ON_COMMAND(ID_POPUP_STOPSCROLL, OnPopupStopscroll)
	ON_COMMAND(ID_POPUP_LOADFRAMESIMAGE, OnPopupLoadframesimage)
	ON_WM_VSCROLL()
	ON_WM_HSCROLL()
	ON_WM_LBUTTONDOWN()
	ON_WM_MOUSEMOVE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMatrixSimulator message handlers

void CMatrixSimulator::OnDestroy() 
{
	CStatic::OnDestroy();		
}

void CMatrixSimulator::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
	CDC* pDC =&dc;
	CRect rect;
	GetClientRect(rect);	
	
	if (m_pDCMem == NULL){
		m_pDCMem = new CDC();
		m_pDCMem->CreateCompatibleDC(pDC); 
		m_bmpDCMem.CreateCompatibleBitmap(pDC, rect.Width(),rect.Height() );
		m_pOldBitmap = m_pDCMem->SelectObject(&m_bmpDCMem);
		this->DisplayFrame(m_pDCMem,FALSE);	
	}		
	else if (m_bReCalcMatrix){
		m_bReCalcMatrix = FALSE;
		if(m_bmpDCMem.DeleteObject()){
			m_bmpDCMem.CreateCompatibleBitmap(pDC, rect.Width(),rect.Height() );
			m_pOldBitmap = m_pDCMem->SelectObject(&m_bmpDCMem);
			this->DisplayFrame(m_pDCMem,FALSE);	
		}
	}	

	if (m_bHitScroll){
		m_bHitScroll = FALSE;
		dc.BitBlt(0,0,rect.Width(), rect.Height(),m_pDCMem,0,0,SRCCOPY);	
	}
	else{
		this->DisplayFrame(pDC,FALSE);	
	}	
	
	pDC->DrawEdge(&rect,BDR_RAISEDINNER,BF_RECT|BF_ADJUST);	
	pDC->DrawEdge(&rect,BDR_SUNKENOUTER,BF_RECT|BF_ADJUST);

}

void CMatrixSimulator::OnTimer(UINT nIDEvent) 
{
	
	CStatic::OnTimer(nIDEvent);
}

void CMatrixSimulator::SetPixelSize(int cx, int cy)
{
	m_cx = cx; m_cy = cy;	
	ClearScreen();
	for (int i =0;i < MAX_LAYER;i++)
		ClearLayer(i);
}

void CMatrixSimulator::SetCurrentLayer(int nLayer)
{
	m_nCurrentLayer = nLayer;	
}

CSize CMatrixSimulator::GetPixelSize() const
{
	return CSize(m_cx,m_cy);
}

void CMatrixSimulator::GetPixelSize(int *cx, int *cy)
{
	*cx = m_cx; *cy = m_cy;
}

void CMatrixSimulator::DisplayFrame(CDC*pDC, BOOL bRefresh)
{
// display one frame in the screen at the specific time	
	if (pDC){
		if (pDC->m_hDC){
			for (int row=0; row < m_cy; row++)  {           
				for (int col=0; col < m_cx; col++){
					DrawPixel(pDC,row,col);
				}			
			}	
			if (bRefresh){
				this->Invalidate(FALSE);
			}
		}
	}
}

extern CGeneralSettings __SETTING;


void CMatrixSimulator::ReCalcLayout(int scale, BOOL bRedraw)
{
	m_bReCalcMatrix = TRUE;
	SetWindowPos(NULL,0,0,m_cx*scale+1,m_cy*scale+1,SWP_NOMOVE);	
	if (bRedraw)	
	{
		this->RedrawWindow();	
		GetParent()->RedrawWindow();
	}

	__SETTING.m_nScale = scale;
}

int CMatrixSimulator::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CStatic::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	return 0;
}

const COLORREF __TABLE_COLOR[] = {	
	RGB(50,50,50),
	RGB(0,0,255),
	RGB(0,255,0),
	RGB(0,255,255),
	RGB(255,0,0),
	RGB(255,0,255),
	RGB(255,255,0),
	RGB(255,255,255)
};

void CMatrixSimulator::DrawPixel(CDC*pDC,int row,int col)
{
	CRect rect = CRect();
	GetClientRect(&rect);
	
	int cx = rect.Width()/m_cx;
	int cy = rect.Height()/m_cy;	
		
	// one byte in m_pBuffer[] contain 8 lines
	CRect rc = CRect(rect);
	rc.right = rc.left + cx +1;
	rc.bottom = rc.top + cy +1;	

	rc.OffsetRect(cx*col,cy*row);
	
	// processing scroll mode
	BYTE data = BLANK_STATE;
	for (int i=MAX_LAYER-1; i>= 0; i--){
		if (m_bVisibleLayer[i]==TRUE){
			if (__SCREEN_LAYER[m_nLine][i][col][row] !=BLANK_STATE)
				data = __SCREEN_LAYER[m_nLine][i][col][row];				
		}
	}								

	COLORREF clr = __TABLE_COLOR[data];
	
	CBrush br(clr);
	CBrush* pBrOld  = pDC->SelectObject(&br);

	pDC->SelectObject(br);
	
	if ( cx > 1 ){
		pDC->Ellipse(rc);		
	}
	else{			
		pDC->SetPixel(CPoint(rc.left,rc.top),clr);
	}
	
	pDC->SelectObject(pBrOld);
}

void CMatrixSimulator::ClearScreen()
{
	for (int i = 0; i< MAX_LAYER; i++)
	{
		m_szTextPos[i] = CSize(0,0);
		m_nTextLengthPixel[i] = 0;
		m_bLoadImage[i] = FALSE;
		for (int line =0; line < MAX_LINE; line++){
			for (int row=0; row< MAX_HEIGHT; row++){
				for (int col=0; col< MAX_WIDTH; col++){
					__SCREEN_LAYER[line][i][col][row]=BLANK_STATE;	
				}
			}
		}
	}		
	this->Invalidate(FALSE);
}

void CMatrixSimulator::ClearLayer(int nLayer)
{	
	m_szTextPos[nLayer] = CSize(0,0);
	m_bLoadImage[nLayer] = FALSE;
	for (int row=0; row< MAX_HEIGHT; row++){
		for (int col=0; col< MAX_WIDTH; col++){
			__SCREEN_LAYER[m_nLine][nLayer][col][row]=BLANK_STATE;	
		}
	}
	this->Invalidate(FALSE);
}

void CMatrixSimulator::SetRate(int nRate)
{
	m_nRate = nRate;
}

void CMatrixSimulator::LoadText(const char *szText, int nColor, BOOL bGradient)
{
	int cx =0, offset =0;
	int len = strlen(szText);

	if (m_bLoadImage[m_nCurrentLayer]){
		return;
	}

	for (int row=0; row< MAX_HEIGHT; row++){
		for (int col=0; col< MAX_WIDTH; col++){
			__SCREEN_LAYER[m_nLine][m_nCurrentLayer][col][row]=BLANK_STATE;	
		}
	}

	for (int i=0; i< len; i++){
		BYTE c = szText[i];
		if (c >255) c =255;
		if (c==0x0D){
			offset += char_map[c].heigth;
			if (cx > m_nTextLengthPixel[m_nCurrentLayer]){
				m_nTextLengthPixel[m_nCurrentLayer] = cx;
			}
			if (i+2 < len){
				i+= 2;	// ignor CRLF
				c = szText[i];
			}
			cx = 0;
		}
		for (int col=0; col < char_map[c].width; col++){
			for (int row=0; row < char_map[c].heigth; row++){
				if (char_map[c].pdata[col][row]!=BLANK_STATE){
					__SCREEN_LAYER[m_nLine][m_nCurrentLayer][cx+col][row+offset] = nColor;
				}
				else{
					__SCREEN_LAYER[m_nLine][m_nCurrentLayer][cx+col][row+offset] = BLANK_STATE;
				}
			}			
		}
		cx +=char_map[c].width; 
		int cx_next = cx + char_map[BYTE(szText[i+1])].width;
		if (cx_next >= MAX_WIDTH){			
			break;
		}
	}

	if (cx > m_nTextLengthPixel[m_nCurrentLayer]){
		m_nTextLengthPixel[m_nCurrentLayer] = cx;
	}

	MoveText(m_szTextPos[m_nCurrentLayer].cx,m_szTextPos[m_nCurrentLayer].cy,m_nCurrentLayer,FALSE);
	
	this->Invalidate(FALSE);
}

void CMatrixSimulator::LoadCharMap(LPCTSTR szFile)
{
	DecompressFont(szFile);
}

void CMatrixSimulator::SetScrollMode(int nMode)
{
	m_nScrollMode = nMode;
}

void CMatrixSimulator::MoveText(int x, int y, int layer, BOOL bUpdate)
{
	if (x >0 || y >0){
		for (int cx=0; cx< MAX_WIDTH; cx++){
			for (int cy=0; cy< m_cy; cy++){
				if (cx+x < MAX_WIDTH){
				__SCREEN_LAYER[m_nLine][layer][cx][cy] = __SCREEN_LAYER[m_nLine][layer][cx+x][cy+y];
				}
				else{
				__SCREEN_LAYER[m_nLine][layer][cx][cy] = BLANK_STATE;
				}
			}
		}
	}
	if (x <0 || y <0){
		for (int cx= MAX_WIDTH; cx>=0; cx--){
			for (int cy=m_cy; cy>=0; cy--){
				if (cx+x >=0){
				__SCREEN_LAYER[m_nLine][layer][cx][cy] = __SCREEN_LAYER[m_nLine][layer][cx+x][cy+y];
				}
				else{
				__SCREEN_LAYER[m_nLine][layer][cx][cy] = BLANK_STATE;
				}
			}
		}
	}
	if (bUpdate){
		m_szTextPos[layer].cx += x;
		m_szTextPos[layer].cy += y;
	}
	this->Invalidate(FALSE);
}

void CMatrixSimulator::SetVisibleLayer(BOOL *bLayer)
{
	memcpy(m_bVisibleLayer,bLayer,sizeof(m_bVisibleLayer));
}

void CMatrixSimulator::OnContextMenu(CWnd*, CPoint point)
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
		VERIFY(menu.LoadMenu(CG_IDR_POPUP_MATRIX_SIMULATOR));

		CMenu* pPopup = menu.GetSubMenu(0);
		ASSERT(pPopup != NULL);
		CWnd* pWndPopupOwner = this;

		pPopup->TrackPopupMenu(TPM_LEFTALIGN | TPM_RIGHTBUTTON, point.x, point.y,
			pWndPopupOwner);
	}
}

void CMatrixSimulator::ChangeColor(int nColor, int nLayer, BOOL bGradient)
{
	for (int y=0 ; y < MAX_HEIGHT; y++)
	{
		for (int x=0 ; x < MAX_WIDTH; x++)
		{
			if (__SCREEN_LAYER[m_nLine][nLayer][x][y]!=BLANK_STATE){
				__SCREEN_LAYER[m_nLine][nLayer][x][y] = nColor;
			}
		}
	}
	m_nColorPen = nColor;
	this->Invalidate(FALSE);
}

void CMatrixSimulator::OnPopupChangescale1x1() 
{
	this->ReCalcLayout(1,TRUE);
}

void CMatrixSimulator::OnPopupChangescale2x2() 
{
	this->ReCalcLayout(2,TRUE);
}

void CMatrixSimulator::OnPopupChangescale3x3() 
{
	this->ReCalcLayout(3,TRUE);
}

void CMatrixSimulator::OnPopupChangescale4x4() 
{
	this->ReCalcLayout(4,TRUE);
}

void CMatrixSimulator::OnPopupStartscroll() 
{

}

void CMatrixSimulator::OnPopupStopscroll() 
{

}

void CMatrixSimulator::OnPopupLoadframesimage() 
{
	///////////////////////////////////////////////////////////////////
	// OPEN FILE TO IMPORT
	/*****************************************************************/
	CFileDialog dlg(TRUE,NULL,NULL,NULL,_T("Bitmap File(*.bmp)|*.bmp||"));

	if ( dlg.DoModal() == IDCANCEL )
	{
		return ;	// nothing selected		
	}

	CString csFile = dlg.GetPathName();	

#ifdef _UNICODE
	char szBuffer[MAX_PATH];
	LPTSTR szData = (LPTSTR)csFile.GetBuffer(csFile.GetLength());
	if (wcslen(szData)>=1024)	szData[1024] = '\0';	
	int len = WideCharToMultiByte(CP_ACP,0,szData,wcslen(szData),szBuffer,sizeof(szBuffer),NULL,NULL);
	szBuffer[len] = '\0';
#endif
	LoadImage(csFile);
	RedrawWindow();	
}

#define	FONT_HEIGHT		32

void CMatrixSimulator::CompressFont(LPCTSTR szFile)
{
	BYTE dim[256][2];
	BYTE buffer[FONT_HEIGHT*8*256];
	memset(buffer,0x00,sizeof(buffer));
	for (int i=0; i< 256; i++)
	{
		for (int x=0; x< FONT_HEIGHT; x++)
		{
			for (int y=0; y < FONT_HEIGHT; y++)
			{
				if (char_map[i].pdata[y][x] != BLANK_STATE)
					buffer[y + (x/8)*FONT_HEIGHT + i*FONT_HEIGHT*FONT_HEIGHT/8] |= 1<<(x%8);
				else
					buffer[y + (x/8)*FONT_HEIGHT + i*FONT_HEIGHT*FONT_HEIGHT/8] &= ~(1<<(x%8));				
			}
		}

		dim[i][0] = char_map[i].heigth;
		dim[i][1] = char_map[i].width ;
	}
	

	CFile file(szFile,CFile::modeCreate|CFile::modeWrite);
	file.WriteHuge(buffer,sizeof(buffer));
	file.SeekToBegin();
	file.Write(dim,sizeof(dim));
	file.Close();
}

void CMatrixSimulator::DecompressFont(LPCTSTR szFile)
{
	BYTE dim[256][2];
	BYTE buffer[FONT_HEIGHT*8*256];
	memset(buffer,0x00,sizeof(buffer));

	CFile file(szFile,CFile::modeRead);
	file.ReadHuge(buffer,sizeof(buffer));
	file.SeekToBegin();
	file.Read(dim,sizeof(dim));
	file.Close();
	
	for (int i=0; i< 256; i++)
	{
		for (int x=0; x< FONT_HEIGHT; x++)
		{
			for (int y=0; y < FONT_HEIGHT; y++)
			{
				if (buffer[y + (x/8)*FONT_HEIGHT + i*FONT_HEIGHT*FONT_HEIGHT/8] & (1<<(x%8)))
					char_map[i].pdata[y][x] = 1;
				else
					char_map[i].pdata[y][x] = BLANK_STATE;
			}
		}
		char_map[i].heigth = dim[i][0];		
		char_map[i].width  = dim[i][1];		
	}

}

void CMatrixSimulator::GradientLayer(int nColor, int nLayer)
{

}

void CMatrixSimulator::SaveWorkspace(CFile &file)
{
	file.Write(&m_cx,sizeof(m_cx));
	file.Write(&m_cy,sizeof(m_cy));
	
	file.Write(&m_nCurrentLayer,sizeof(m_nCurrentLayer));

	for(int i=0; i< MAX_LAYER; i++){
		file.Write(&m_bLoadImage[i],sizeof(m_bLoadImage[i]));
		file.Write(&m_szTextPos[i].cx,sizeof(m_szTextPos[i].cx));
		file.Write(&m_szTextPos[i].cy,sizeof(m_szTextPos[i].cy));
		file.Write((LPVOID)__SCREEN_LAYER[i],sizeof(__SCREEN_LAYER[i]));
		file.Write(&m_nTextLengthPixel[i],sizeof(m_nTextLengthPixel[i]));
	}
}

void CMatrixSimulator::LoadWorkspace(CFile &file)
{
	file.Read(&m_cx,sizeof(m_cx));
	file.Read(&m_cy,sizeof(m_cy));
	
	file.Read(&m_nCurrentLayer,sizeof(m_nCurrentLayer));

	for(int i=0; i< MAX_LAYER; i++){
		file.Read(&m_bLoadImage[i],sizeof(m_bLoadImage[i]));
		file.Read(&m_szTextPos[i].cx,sizeof(m_szTextPos[i].cx));
		file.Read(&m_szTextPos[i].cy,sizeof(m_szTextPos[i].cy));
		file.Read((LPVOID)__SCREEN_LAYER[i],sizeof(__SCREEN_LAYER[i]));		
		file.Read(&m_nTextLengthPixel[i],sizeof(m_nTextLengthPixel[i]));
	}
	
}

void CMatrixSimulator::OnVScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
	m_ptPosition.y = -int(nPos);
	TRACE(_T("nPos=%d \n"),nPos);
	m_bHitScroll = TRUE;
	SetWindowPos(NULL,m_ptPosition.x,m_ptPosition.y,0,0,SWP_NOSIZE|SWP_NOREDRAW);
	this->DisplayFrame(m_pDCMem,TRUE);	
}

void CMatrixSimulator::OnHScroll(UINT nSBCode, UINT nPos, CScrollBar* pScrollBar) 
{
	m_ptPosition.x = -int(nPos);
	TRACE(_T("nPos=%d \n"),nPos);
	m_bHitScroll = TRUE;
	SetWindowPos(NULL,m_ptPosition.x,m_ptPosition.y,0,0,SWP_NOSIZE|SWP_NOREDRAW);
	this->DisplayFrame(m_pDCMem,TRUE);	
}


void CMatrixSimulator::LoadImage(LPCTSTR szBmpFile)
{
	CDib dib;
	dib.Load(szBmpFile);
	CClientDC dc(this);
	CDC memDC;
	memDC.CreateCompatibleDC(&dc); 	
	CBitmap bitmap;
	if (dib.GetSize().cx > 1024 || dib.GetSize().cy > 1024)
	{
		MessageBox(_T("T\x1EAD"L"p tin \x1EA3"L"nh c\xF3"L" k\xED"L"ch th\x1B0"L"\x1EDB"L"c qu\xE1"L" l\x1EDB"L"n"),_T("Nap \x1EA3"L"nh"),MB_OK);
		return;
	}

	int cx = dib.GetSize().cx;
	int cy = dib.GetSize().cy;
	if (cx > MAX_WIDTH ) cx = MAX_WIDTH;
	if (cy > MAX_HEIGHT ) cy = MAX_HEIGHT;
	CRect rcDest = CRect(0,0,cx,cy);
	CRect rcSrc = CRect(0,0,cx,cy);
	dib.Draw(&dc,&rcDest,&rcSrc);
	
	bitmap.CreateCompatibleBitmap(&dc, cx, cy );
	
	CBitmap* pOldBitmap = memDC.SelectObject(&bitmap);
	memDC.BitBlt(0, 0, cx, cy, &dc, 0, 0, SRCCOPY); 
		
	for (int x = 0; x < cx; x++)
	{
		for (int y = 0; y < cy; y++)
		{
			COLORREF clr = memDC.GetPixel(x,y);				
			for (int i=0; i < sizeof(__TABLE_COLOR); i++){
				if (clr == __TABLE_COLOR[i]){
					if (clr == RGB(0,0,0)){
						i =0;						
					}
					break;
				}
				else if (clr >= __TABLE_COLOR[i] - 100 && 
					clr <= __TABLE_COLOR[i] + 100){
					break;
				}
			}
			__SCREEN_LAYER[m_nLine][m_nCurrentLayer][x][y] = i;			
		}
	}

	memDC.SelectObject(pOldBitmap);
	m_bLoadImage[m_nCurrentLayer] = TRUE;
	GetParent()->RedrawWindow(CRect(0,0,m_cx,m_cy));
}

void CMatrixSimulator::OnLButtonDown(UINT nFlags, CPoint point) 
{
	// get the position on the axis
	CRect rect;
	GetClientRect(&rect);
	int cx = rect.Width()/m_cx;
	int cy = rect.Height()/m_cy;	
	int x = (point.x+0)/cx;
	int y = (point.y+0)/cy;
	TRACE(_T("Point=(%d,%d)\n"),point.x,point.y);
	if (m_nDrawType){
		__SCREEN_LAYER[m_nLine][m_nCurrentLayer][x][y] = m_nColorPen;
		this->Invalidate(FALSE);
	}
	//CStatic::OnLButtonDown(nFlags, point);
}

void CMatrixSimulator::SelectDraw(UINT nType, UINT nColor)
{
	m_nDrawType = nType;
	m_nColorPen = nColor;
}

void CMatrixSimulator::OnMouseMove(UINT nFlags, CPoint point) 
{
	if (m_nDrawType){
		CRect rect;
		GetClientRect(&rect);
		if (rect.PtInRect(point)){
			if (m_bOnCapture==FALSE){
				SetCapture();
				m_bOnCapture = TRUE;
			}
			else{
				// change draw tool icon
				::SetCursor(LoadCursor(AfxGetApp()->m_hInstance,MAKEINTRESOURCE(IDC_PEN)));
			}			
		}
		else{
			m_bOnCapture = FALSE;
			ReleaseCapture();
			::SetCursor(LoadCursor(AfxGetApp()->m_hInstance,MAKEINTRESOURCE(IDC_POINTER)));			
		}
	}
	
	//CStatic::OnMouseMove(nFlags, point);
}

UINT CMatrixSimulator::GetBuffer(PBYTE pBuffer)
{	
	for (int col =0; col < m_cx; col++){
		for (int row =0; row< m_cy; row++){
			BYTE data = BLANK_STATE;
			//data = __SCREEN_LAYER[m_nLine][0][col][row];				
			for (int i=MAX_LAYER-1; i>= 0; i--){
				if (m_bVisibleLayer[i]==TRUE){
					if (__SCREEN_LAYER[m_nLine][i][col][row] !=BLANK_STATE)
						data = __SCREEN_LAYER[m_nLine][i][col][row];				
				}
			}
			if (data==4 || data==5 || data==6 || data==7){
				pBuffer[row/8+(col + 0*m_cx)*m_cy/8] |=  1<< (row%8);
			}
			else{
				pBuffer[row/8+(col + 0*m_cx)*m_cy/8] &=  ~(1<< (row%8));
			}

			if (data==2 || data==3 || data==6 || data==7){
				pBuffer[row/8+(col + 1*m_cx)*m_cy/8] |=  1<< (row%8);
			}
			else{
				pBuffer[row/8+(col + 1*m_cx)*m_cy/8] &=  ~(1<< (row%8));
			}

			if (data==1 || data==3 || data==5 || data==7){
				pBuffer[row/8+(col + 2*m_cx)*m_cy/8] |=  1<< (row%8);
			}
			else{
				pBuffer[row/8+(col + 2*m_cx)*m_cy/8] &=  ~(1<< (row%8));
			}
		}
	}

	return (m_cx);
}
