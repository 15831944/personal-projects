// DigiLEDDoc.h : interface of the CDigiLEDDoc class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_DIGILEDDOC_H__0425DBF1_3D8A_415B_98E2_3DC3E51466DE__INCLUDED_)
#define AFX_DIGILEDDOC_H__0425DBF1_3D8A_415B_98E2_3DC3E51466DE__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


class CDigiLEDDoc : public CDocument
{
protected: // create from serialization only
	CDigiLEDDoc();
	DECLARE_DYNCREATE(CDigiLEDDoc)

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDigiLEDDoc)
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CDigiLEDDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CDigiLEDDoc)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DIGILEDDOC_H__0425DBF1_3D8A_415B_98E2_3DC3E51466DE__INCLUDED_)
