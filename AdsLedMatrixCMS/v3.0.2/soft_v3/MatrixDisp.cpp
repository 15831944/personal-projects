// MatrixDisp.cpp : implementation file
//

#include "stdafx.h"
#include "MATRIX.h"
#include "FontDisp.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern FONT_CHAR char_map[256];	
extern BYTE bit_stream[32768];

/////////////////////////////////////////////////////////////////////////////
// CMatrixDisp

CMatrixDisp::CMatrixDisp()
{
	m_screen_view.red = NULL;
	m_screen_view.grn = NULL;

	m_screen.red = new BYTE[HEIGHT*WIDTH];
	m_screen.grn = new BYTE[HEIGHT*WIDTH];
	m_screen_view.red = new BYTE[HEIGHT*WIDTH/8];
	m_screen_view.grn = new BYTE[HEIGHT*WIDTH/8];

	memset(m_screen_view.red,0x00,HEIGHT*WIDTH/8);
	memset(m_screen_view.grn,0x00,HEIGHT*WIDTH/8);
}

CMatrixDisp::~CMatrixDisp()
{	
	delete[] m_screen.red;
	delete[] m_screen.grn;
	delete[] m_screen_view.red;
	delete[] m_screen_view.grn;


}


BEGIN_MESSAGE_MAP(CMatrixDisp, CStatic)
	//{{AFX_MSG_MAP(CMatrixDisp)
	ON_WM_PAINT()
	ON_WM_CREATE()
	ON_WM_SIZE()
	ON_WM_TIMER()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMatrixDisp message handlers

void CMatrixDisp::OnPaint() 
{

	CPaintDC dc(this); // device context for painting
	CDC* pDC = (CDC*)&dc;

	if (!m_screen_view.red || !m_screen_view.grn)
		return;

	CRect rect = CRect();
	GetClientRect(&rect);
	int cx = rect.Width()/WIDTH +0;
	int cy = rect.Height()/HEIGHT +0;	
	
	CBrush brR(RGB(255,0,0));
	CBrush brG(RGB(0,255,0));
	CBrush brY(RGB(255,255,0));
	CBrush brW(RGB(255,255,255));
	CBrush* pBrC = NULL;
	CBrush* pBr  = pDC->SelectObject(&brR);

	for (int i = 0; i<WIDTH;i++)
	{
		CRect rc = CRect(rect);
		rc.right = rc.left + cx +1;
		rc.bottom = rc.top + cy +1;

		rc.OffsetRect(cx*i,0);
		for (int j = 0;j<HEIGHT; j++)
		{			
			int mask = 0x01;
			if (m_screen_view.red[j + HEIGHT*(i/8)] & (mask<<i%8))
				pBrC = &brR;
			else
			if (m_screen_view.grn[j + HEIGHT*(i/8)] & (mask<<i%8))
				pBrC = &brG;
			else 
				pBrC = &brW;			
			
			if ((m_screen_view.red[j + HEIGHT*(i/8)]  & (mask<<i%8)) && 
				(m_screen_view.grn[j + HEIGHT*(i/8)]  & (mask<<i%8)) )
				pBrC = &brY;

			pDC->SelectObject(pBrC);	

			pDC->Ellipse(rc);
			rc.OffsetRect(0,cy);
		}
	}
	pDC->SelectObject(pBr);
}

BOOL CMatrixDisp::DestroyWindow() 
{
	// TODO: Add your specialized code here and/or call the base class
	
	return CStatic::DestroyWindow();
}

int CMatrixDisp::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CStatic::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	return 0;
}

void CMatrixDisp::OnSize(UINT nType, int cx, int cy) 
{
	CStatic::OnSize(nType, cx, cy);
}

void CMatrixDisp::ResizeToFit(int scale)
{
	SetWindowPos(NULL,0,0,WIDTH*scale,HEIGHT*scale,SWP_NOMOVE);	
}

void CMatrixDisp::ClearScreen()
{
	for (int x = 0; x < WIDTH; x++)
	{
		for (int y = 0; y < HEIGHT; y++)
		{								
			m_screen.red[y + HEIGHT*(x)] = 0x00;
			m_screen.grn[y + HEIGHT*(x)] = 0x00;
		}
	}	
		
}

#define		FONT_HEIGHT		24

void CMatrixDisp::TestCharMap(int* sz,int size)
{

	CFile file;
	file.Open("C:\\bitstream",CFile::modeRead);

	// font header info
	for (int i=0;i<FONT_HEIGHT;i++)
	{		
		for (int j=0; j< 8; j++)
		{			
			int cx = 0, cy = 32;			
			file.Read(&cx,sizeof(BYTE));
			file.Read(&cy,sizeof(BYTE));
			

			char_map[i*8+j].heigth = cy;
			char_map[i*8+j].width  = cx;	
		}
	}

	file.ReadHuge(bit_stream+512,32768-512);
	file.Close();

	int cx =0, cy =0;	

	BYTE mask = 0x01;

	for ( i =0; i< size; i++)
	{		
		for (int x = 0; x < abs(char_map[sz[i]].width); x++)
		{			
			for (int y = 0; y < abs(char_map[sz[i]].heigth); y++)
			{							
				if ((bit_stream[FONT_HEIGHT*FONT_HEIGHT*(sz[i]/8) + x*abs(char_map[sz[i]].heigth)+y] & (1<<(sz[i]%8))) )				
				{
					m_screen.red[cy+y + HEIGHT*cx] |= ( mask );
					//m_screen.grn[cy+y][cx+0] |= ( mask );
				}
				else
				{
					m_screen.red[cy+y + HEIGHT*cx] &= ~( mask );
					//m_screen.grn[cy+y][cx+0] &= ~( mask );
				}
				
				
			}			

			mask = mask<<1;
			if (mask == 0) 
			{
				mask = 0x01; 
				cx ++;
			}
		}		
	}	
	
	memcpy(m_screen.red+HEIGHT*WIDTH/8,m_screen.red,HEIGHT*WIDTH/8);
	memcpy(m_screen.grn+HEIGHT*WIDTH/8,m_screen.grn,HEIGHT*WIDTH/8);

	memcpy(m_screen_view.red,m_screen.red,HEIGHT*WIDTH/8);
	memcpy(m_screen_view.grn,m_screen.grn,HEIGHT*WIDTH/8);

	memset(m_screen.red,0x00,HEIGHT*WIDTH/8);
	memset(m_screen.grn,0x00,HEIGHT*WIDTH/8);

	RedrawWindow();
	Sleep(300);
	KillTimer(1234);
	SetTimer(1234,100,NULL);

}

/*****************************************************
01234567 01234567 01234567 01234567 01234567 01234567
-----------------------------------------------------

32x32 ---> 1024 bytes ----> 8 chars
256 chars = 32*1024 = 32768 bytes
BYTE bit_stream[32768]; // 256 chars bmp font
******************************************************/

void CMatrixDisp::ConvertToStreamBits(PBYTE pBitStream)
{
	int bit_start = 0;
	int bit_count = 0;

	BYTE mask = 0x01;		// bit 0 at start

	CFile file;
	file.Open("C:\\bitstream",CFile::modeCreate | CFile::modeWrite);

	// All ASCII table		i = 8, j = 3
	for (int i=0;i<FONT_HEIGHT;i++)
	{
		mask = 0x01;	// reset mask

		for (int j=0; j< 8; j++)
		{
			int cy = char_map[i*8+j].heigth;
			int cx = char_map[i*8+j].width;				
			file.Write(&cx,sizeof(BYTE));			
			file.Write(&cy,sizeof(BYTE));			

			// handle each character 
			for (int x=0; x< cx; x++)
			{
				for (int y=0; y< cy; y++)
				{
					if (char_map[i*8+j].pdata[y][x])
						pBitStream[(i*FONT_HEIGHT*FONT_HEIGHT) + (x*cy + y)] |= mask;
					else
						pBitStream[(i*FONT_HEIGHT*FONT_HEIGHT) + (x*cy + y)] &= ~mask;

					bit_count++;
				}
			}

			mask = mask<<1;
		}
	}

	
	file.Write(pBitStream+512,32768-512);

	file.Close();
}

void CMatrixDisp::ConvertBitStreamToFont(PBYTE pBitStream)
{
	BYTE mask = 0x01;		// bit 0 at start

	// All ASCII table
	for (int i=0;i<FONT_HEIGHT;i++)
	{
		mask = 0x01;	// reset mask

		for (int j=0; j< 8; j++)
		{
			int cy = char_map[i*8+j].heigth;
			int cx = char_map[i*8+j].width;				
		
			// handle each character 
			for (int x=0; x< cx; x++)
			{
				for (int y=0; y< cy; y++)
				{
					if (pBitStream[(i*FONT_HEIGHT*FONT_HEIGHT) + (x*cy + y)] & mask)
						char_map[i*8+j].pdata[x][y] = 1;						
					else
						char_map[i*8+j].pdata[x][y] = 0;
						
				}
			}

			mask = mask<<1;
		}
	}
}

// -----------------------------------------
// 0011 0110 0111 0111 | 1001 0001 0000 1101

void CMatrixDisp::OnTimer(UINT nIDEvent) 
{	
#if 0
	static int s = 0;
	for (int i = 0; i< WIDTH/8; i++)
	{
		for (int j = 0; j< HEIGHT; j++)
		{						
			m_screen_view.red[j+ HEIGHT*(i)] = m_screen.red[(j) + HEIGHT*(i+s)];			
		}		
	}

	s++;
	if (s > 2*WIDTH/8) s = 0;

	RedrawWindow();
#endif
	CStatic::OnTimer(nIDEvent);
}
