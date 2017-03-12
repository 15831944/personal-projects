/********************************************************************************
	Copyright 2005 Sjaak Priester	

	This is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This software is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this software; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.

	http://www.gnu.org/licenses/
********************************************************************************/
//
//==============
// Version 1.0, September 21, 2005.
// (c) 2005, Sjaak Priester, Amsterdam.
// http://www.sjaakpriester.nl

#include "StdAfx.h"
#include "QGraphicsText.h"
#include "ADProLED.h"

//======================================
// Global variable declaration
// 
ARRAY_POINTF _arrPointF;
//======================================
// QGraphicsText
//

QGraphicsText::QGraphicsText()
: m_hFont(0)
, m_pKerningPairs(0)
, m_nKPairs(0)
, m_bFlipY(true)
, m_hWnd (NULL)
{
	m_nNodeSize = 4;
	m_nDistance = 4;
	_arrPointF.RemoveAll();
}

QGraphicsText::~QGraphicsText()
{
	while (_arrPointF.GetSize()){
		PointF* pPointF = _arrPointF.GetAt(0);
		if (pPointF){
			delete pPointF;
		}
		_arrPointF.RemoveAt(0);
	}

	delete m_pKerningPairs;
	if (m_hFont) ::DeleteObject(m_hFont);
}

void QGraphicsText::SetFont(const LOGFONT& logfont, bool bFlipY)
{
	m_bFlipY = bFlipY;

	delete[] m_pKerningPairs;
	m_pKerningPairs = 0;

	if (m_hFont) ::DeleteObject(m_hFont);
	m_hFont = ::CreateFontIndirect(& logfont);

	if (m_hFont)
	{
		HDC hDC = ::GetDC(m_hWnd);
		if (hDC)
		{
			HGDIOBJ hOldFont = ::SelectObject(hDC, m_hFont);

			m_nKPairs = ::GetKerningPairs(hDC, 0, NULL);
			if (m_nKPairs > 0)
			{
				m_pKerningPairs = new KERNINGPAIR[m_nKPairs];
				::GetKerningPairs(hDC, m_nKPairs, m_pKerningPairs);	// No problem if m_pKerningPairs == 0.
			}

			::SelectObject(hDC, hOldFont);
			::ReleaseDC(m_hWnd, hDC);
		}
	}
}

int QGraphicsText::GetGraphicsText(GraphicsPath& path, LPCTSTR str, PointF pntOrigin) const
{
	path.SetFillMode(FillModeWinding);

	HDC hDC = ::GetDC(m_hWnd);
	if (hDC)
	{
		// Internally, QGraphicsText considers the left point on the base line of the
		// character as the origin. Windows GDI and GDI+ however see the upper
		// left point of the character cell as the origin. Compensate for compatibility.
		HGDIOBJ hOldFont = ::SelectObject(hDC, m_hFont);

		TEXTMETRIC tm;
		::GetTextMetrics(hDC, & tm);

		if (m_bFlipY) pntOrigin.Y += (REAL) tm.tmAscent;
		else pntOrigin.Y -= (REAL) tm.tmAscent;

		::SelectObject(hDC, hOldFont);
		::ReleaseDC(m_hWnd, hDC);
	}

	MAT2 mat = { 0 };		// Prepare unit matrix, no transformation.
	mat.eM11.value = 1;
	mat.eM22.value = 1;

	const TCHAR * p = str;

	Status stat(Ok);
	while (* p && stat == Ok)
	{
		stat = RetrieveGlyph(* p, pntOrigin, mat, path);

		const TCHAR * pNext = ::CharNext(p);
		pntOrigin.X += RetrieveCellWidth(* p, *pNext);

		p = pNext;
	}
	if (stat != Ok) --p;
	return (int)(p - str);
}

int QGraphicsText::RetrieveCellWidth(UINT nChar, UINT nNextChar) const
{
	HDC hDC = ::GetDC(m_hWnd);
	if (hDC)
	{
		HGDIOBJ hOldFont = ::SelectObject(hDC, m_hFont);

		MAT2 mat = { 0 };		// Prepare unit matrix, no transformation.
		mat.eM11.value = 1;
		mat.eM22.value = 1;

		GLYPHMETRICS gm;

		// Get the GLYPHMETRICS for an untransformed glyph.
		DWORD nBytes = ::GetGlyphOutline(hDC, nChar, GGO_METRICS, & gm, 0, NULL, & mat);
		if (nBytes == GDI_ERROR) return -1;

		// Determine the width of the character cell.
		// We simple add up the horizontal and vertical values, to get
		// something sensible in most cases.
		// Typically for Latin fonts, gm.gmCellIncY will be 0.
		int nCell = gm.gmCellIncX + gm.gmCellIncY;

		// QPathText supports character kerning.
		// Note that many TrueType fonts don't have kerning information.
		// Off the standard Windows fonts, 'Garamond' and 'Monotype Corsiva' are some of the few, so use
		// these for testing.
		KERNINGPAIR * pKP = m_pKerningPairs;
		for (int i = 0; i < m_nKPairs; ++i)
		{
			// Note that nNextChar may be 0, but that won't harm.
			if (pKP->wFirst == nChar && pKP->wSecond == nNextChar)
			{
				nCell += pKP->iKernAmount;		// Adapt the character cell width with the kerning
				break;							// amount (probably, but not necesarily < 0)
			}
			++pKP;
		}
		
		::SelectObject(hDC, hOldFont);
		::ReleaseDC(m_hWnd, hDC);

		return nCell;
	}
	return -1;
}

Status QGraphicsText::RetrieveGlyph(UINT nChar, PointF pntOrigin, MAT2 matTransform, GraphicsPath& path) const
{
	Status stat(GenericError);

	HDC hDC = ::GetDC(m_hWnd);
	if (hDC)
	{
		stat = Ok;
		HGDIOBJ hOldFont = ::SelectObject(hDC, m_hFont);
		
		if (m_bFlipY)
		{
			NegateFixed(matTransform.eM21);
			NegateFixed(matTransform.eM22);
		}

		GLYPHMETRICS gm;
		UINT uFormat = GGO_NATIVE;
#if (_WIN32_WINNT >= 0x0500)
		uFormat |= GGO_UNHINTED;	// Gives a result which seems closer to GraphicsPath::AddString
#endif

		// Ask Windows GDI how big the buffer must be.
		DWORD nBytes = ::GetGlyphOutline(hDC, nChar, uFormat, & gm, 0, NULL, & matTransform);
		if (nBytes == GDI_ERROR) stat = Win32Error;
		else if (nBytes > 0)	// if 0: no glyph (space character), just return Ok.
		{
			BYTE * pBuf = new BYTE[nBytes];
			if (! pBuf) stat = OutOfMemory;
			else
			{
				// Get the glyph outline from Window's depths.
				::GetGlyphOutline(hDC, nChar, uFormat, & gm, nBytes, pBuf, & matTransform);

				BYTE * pData(pBuf);

				// Transform the outline data from GetGlyphOutline, which are in a very contrived
				// format with FIXED real numbers, in a form GDI+ will understand and add them to path.
				// Refer to MSDN KB 243285.
				while (nBytes)
				{
					// Data consists of one or more TTPOLYGONHEADERs...
					TTPOLYGONHEADER * pPH = (TTPOLYGONHEADER *) pData;
					if (pPH->dwType != TT_POLYGON_TYPE) return NotImplemented;

					PointF pntStart(RealFromFixed(pPH->pfxStart.x), RealFromFixed(pPH->pfxStart.y));														

					pData += sizeof(TTPOLYGONHEADER);
					int nCurveBytes = pPH->cb - sizeof(TTPOLYGONHEADER);
					
					while (nCurveBytes)
					{
						// ... each followed by one or more TTPOLYCURVEs...
						TTPOLYCURVE * pPC = (TTPOLYCURVE *) pData;

						POINTFX * pFX = pPC->apfx;

						// ... which can be of several types.
						switch (pPC->wType)
						{
						case TT_PRIM_LINE:
							{
								// Multiple lines: store as line in path.
								for (int i = 0; i < pPC->cpfx; ++i)
								{
									PointF pntEnd(RealFromFixed(pFX->x), RealFromFixed(pFX->y));
									++pFX;
																		
									PutLine(hDC,pntStart+pntOrigin,pntEnd+pntOrigin);

									stat = path.AddLine(pntStart + pntOrigin, pntEnd + pntOrigin);
									if (stat != Ok) break;
																		
									pntStart = pntEnd;
								}
							}
							break;
						case TT_PRIM_QSPLINE:
							{
								// Multiple quadratic B-splines: transform to cubic Bézier curves and store in path.
								for (int i = 0; i < pPC->cpfx;)
								{
									PointF pntB(RealFromFixed(pFX->x), RealFromFixed(pFX->y));		// Quadratic control point.
									++pFX;
									++i;

									PointF pntEnd(RealFromFixed(pFX->x), RealFromFixed(pFX->y));	// Quadratic end point.

									if (i == (pPC->cpfx - 1))
									{
										// Last end point is given explicitly, so do not modify pntEnd...
										++pFX;	// ...but do update pointer...
										++i;	// ...and counter.
									}
									else
									{
										// End point is midpoint of control point (pntB) and next point (pntEnd).
										pntEnd = pntB + pntEnd;
										pntEnd.X *= 0.5f;
										pntEnd.Y *= 0.5f;
									}

									// Convert quadratic B-spline to cubic Bézier.
									// Start and end points are unmodified.
									PointF pnt1(pntStart);		// First Bézier control point.
									pnt1.X += (2.0f / 3.0f) * (pntB.X - pntStart.X);
									pnt1.Y += (2.0f / 3.0f) * (pntB.Y - pntStart.Y);

									PointF pnt2(pntB);			// Second Bézier control point.
									pnt2.X += (pntEnd.X - pntB.X) / 3.0f;
									pnt2.Y += (pntEnd.Y - pntB.Y) / 3.0f;
																		
									pntStart = PutBezier(hDC,pntStart+pntOrigin,pnt1+pntOrigin,pnt2+pntOrigin,pntEnd+pntOrigin);								
									stat = path.AddBezier(pntStart + pntOrigin, pnt1 + pntOrigin, pnt2 + pntOrigin, pntEnd + pntOrigin);
									
									if (stat != Ok) break;

									pntStart = pntStart - pntOrigin;
								}
							}							
							break;
						default:
							break;
						}											

						int nBytesProcessed = sizeof(TTPOLYCURVE) + (pPC->cpfx - 1) * sizeof(POINTFX);

						pData += nBytesProcessed;
						nCurveBytes -= nBytesProcessed;
					}
					
					PointF pntClose(RealFromFixed(pPH->pfxStart.x), RealFromFixed(pPH->pfxStart.y));
					if (!pntStart.Equals(pntClose)){
						PutLine(hDC,pntStart+pntOrigin,pntClose+pntOrigin);
					}

					if (stat == Ok) stat = path.CloseFigure();
					if (stat != Ok) break;

					nBytes -= pPH->cb;
				}
			}
			delete[] pBuf;
		}
		
		::SelectObject(hDC, hOldFont);
		::ReleaseDC(NULL, hDC);
	}
	return stat;
}

void QGraphicsText::PutNode(HDC hDC, const PointF& pntPoint) const
{	
	PointF* pPoint = new PointF(pntPoint);
	if (pPoint){		
		_arrPointF.Add(pPoint);
	}
	
	//::Ellipse(hDC,int(pntPoint.X),int(pntPoint.Y),
	//			int(pntPoint.X)+m_nNodeSize,int(pntPoint.Y)+m_nNodeSize);
}

#include <math.h>
void QGraphicsText::PutLine(HDC hDC, const PointF& pntStart, const PointF& pntEnd) const
{
	int ax = (int)pntEnd.X - (int)pntStart.X;
	int ay = (int)pntEnd.Y - (int)pntStart.Y;
	REAL x = REAL(pntStart.X);
	REAL y = REAL(pntStart.Y);	
	
	for (double t=0; t <=1; t+=double(0.001)){
		REAL xt = REAL(ax*t + pntStart.X);
		REAL yt = REAL(ay*t + pntStart.Y);
		double d = sqrt(pow(xt-x,2)+pow(yt-y,2));
		double dx = CadDistModelToWin (_hDwgCAD,m_nDistance);
		if (d >=dx){
			x = xt; y = yt;			
			PutNode(hDC,PointF(xt,yt));
		}				
	}
}

PointF QGraphicsText::PutBezier(HDC hDC, const PointF& pntStart, const PointF& pntFirst, const PointF& pntSecond, const PointF& pntEnd) const
{
	int cx = 3*((int)pntFirst.X-(int)pntStart.X);
	int bx = 3*((int)pntSecond.X-(int)pntFirst.X)-cx;
	int ax = (int)pntEnd.X-(int)pntStart.X-cx-bx;

	int cy = 3*((int)pntFirst.Y-(int)pntStart.Y);
	int by = 3*((int)pntSecond.Y-(int)pntFirst.Y)-cy;
	int ay = (int)pntEnd.Y-(int)pntStart.Y-cy-by;
	
	REAL x = REAL(pntStart.X);
	REAL y = REAL(pntStart.Y);
	PointF pntNewStart(x,y);	
	
	for (double t=0; t <=1; t+= double(0.001)){
		REAL xt = REAL(ax*pow(t,3) + bx*(pow(t,2)) + cx*t + pntStart.X);
		REAL yt = REAL(ay*pow(t,3) + by*(pow(t,2)) + cy*t + pntStart.Y);
		double d = sqrt(pow(xt-x,2)+pow(yt-y,2));
		double dx = CadDistModelToWin (_hDwgCAD,m_nDistance);
		if (d >=dx){
			x = xt; y = yt;
			pntNewStart = PointF(x,y);
			PutNode(hDC,PointF(xt,yt));
		}		
	}

	return pntNewStart;
}
void QGraphicsText::SetNodeParams(int nDistance, int nDrawSize)
{
	m_nDistance = nDistance;
	m_nNodeSize = nDrawSize;
}
