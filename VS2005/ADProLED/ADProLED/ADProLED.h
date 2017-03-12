// ADProLED.h : main header file for the ADProLED application
//
#pragma once

#ifndef __AFXWIN_H__
	#error "include 'stdafx.h' before including this file for PCH"
#endif

#include "resource.h"       // main symbols


// CADProLEDApp:
// See ADProLED.cpp for the implementation of this class
//

class CADProLEDApp : public CWinApp
{
public:
	CADProLEDApp();


// Overrides
public:
	virtual BOOL InitInstance();

// Implementation
	afx_msg void OnAppAbout();
	DECLARE_MESSAGE_MAP()
public:
	virtual int ExitInstance();
public:	
	void LoadSetting(void);
	void SaveSetting(void);
};

extern CADProLEDApp theApp;
extern CGlobalData _stData;
extern HWND _hWndCAD;
extern VDWG _hDwgCAD;
extern double _gdx;
extern double _gX;
extern double _gY;
extern double _gDX;
extern double _gDY;
extern double _gPointSize;
extern ARRAY_HLED _arrHLED;
extern double _gCompPrice[20];

#define	RED_3			0
#define	RED_5			1

#define	BLUE_3			2
#define	BLUE_5			3

#define	GREEN_3			4
#define	GREEN_5			5

#define	WHITE_3			6
#define	OTHER			7

#define	CPU				8
#define	POWER			9

#define	CASE			10
#define	EXTRA			11


#define	LED_SIZE_3		5
#define	LED_SIZE_5		7