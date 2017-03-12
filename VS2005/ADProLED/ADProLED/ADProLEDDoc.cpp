// ADProLEDDoc.cpp : implementation of the CADProLEDDoc class
//

#include "stdafx.h"
#include "ADProLED.h"

#include "ADProLEDDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CADProLEDDoc

IMPLEMENT_DYNCREATE(CADProLEDDoc, CDocument)

BEGIN_MESSAGE_MAP(CADProLEDDoc, CDocument)
END_MESSAGE_MAP()


// CADProLEDDoc construction/destruction

CADProLEDDoc::CADProLEDDoc()
{
	// TODO: add one-time construction code here

}

CADProLEDDoc::~CADProLEDDoc()
{
}

BOOL CADProLEDDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: add reinitialization code here
	// (SDI documents will reuse this document)

	return TRUE;
}




// CADProLEDDoc serialization

void CADProLEDDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: add storing code here
	}
	else
	{
		// TODO: add loading code here
	}
}


// CADProLEDDoc diagnostics

#ifdef _DEBUG
void CADProLEDDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CADProLEDDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG


// CADProLEDDoc commands
