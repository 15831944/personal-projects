// DigiLEDDoc.cpp : implementation of the CDigiLEDDoc class
//

#include "stdafx.h"
#include "DigiLED.h"

#include "DigiLEDView.h"
#include "DigiLEDDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDDoc

IMPLEMENT_DYNCREATE(CDigiLEDDoc, CDocument)

BEGIN_MESSAGE_MAP(CDigiLEDDoc, CDocument)
	//{{AFX_MSG_MAP(CDigiLEDDoc)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDDoc construction/destruction

CDigiLEDDoc::CDigiLEDDoc()
{
	// TODO: add one-time construction code here

}

CDigiLEDDoc::~CDigiLEDDoc()
{
}

BOOL CDigiLEDDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	return TRUE;
}



/////////////////////////////////////////////////////////////////////////////
// CDigiLEDDoc serialization

void CDigiLEDDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
	}
	else
	{
	}
}

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDDoc diagnostics

#ifdef _DEBUG
void CDigiLEDDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CDigiLEDDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CDigiLEDDoc commands
