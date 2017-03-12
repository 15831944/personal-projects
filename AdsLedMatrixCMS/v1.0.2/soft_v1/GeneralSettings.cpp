// GeneralSettings.cpp: implementation of the CGeneralSettings class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "MATRIX.h"
#include "GeneralSettings.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CGeneralSettings::CGeneralSettings()
{
	m_nCommPort = 0;
	m_nColumn   = 240;
	m_nRow      = 32;
	m_nScale    = 4;
	m_csFontPath = _T("");
	m_csFontText = _T("");
	m_csFontBkGnd = _T("");
	m_bSaveAfterLoaded = FALSE;
}

CGeneralSettings::~CGeneralSettings()
{

}
