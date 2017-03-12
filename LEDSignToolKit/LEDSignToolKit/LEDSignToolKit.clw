; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CLEDSignToolKitDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "ledsigntoolkit.h"
LastPage=0

ClassCount=8
Class1=CColorCombo
Class2=CLEDSignCtrl
Class3=CLEDSignToolKitApp
Class4=CAboutDlg
Class5=CLEDSignToolKitDlg
Class6=CLEDTextCtrl

ResourceCount=4
Resource1=IDD_LEDSIGNTOOLKIT_DIALOG
Resource2=IDD_ABOUTBOX
Class7=CPageNumber
Resource3=IDD_DIALOG_DELAY
Class8=CDelaySettingDlg
Resource4=IDR_MENU

[CLS:CColorCombo]
Type=0
BaseClass=CComboBox
HeaderFile=ColorCombo.h
ImplementationFile=ColorCombo.cpp

[CLS:CLEDSignCtrl]
Type=0
BaseClass=CStatic
HeaderFile=LEDSignCtrl.h
ImplementationFile=LEDSignCtrl.cpp
Filter=W
VirtualFilter=WC
LastObject=CLEDSignCtrl

[CLS:CLEDSignToolKitApp]
Type=0
BaseClass=CWinApp
HeaderFile=LEDSignToolKit.h
ImplementationFile=LEDSignToolKit.cpp

[CLS:CAboutDlg]
Type=0
BaseClass=CDialog
HeaderFile=LEDSignToolKitDlg.cpp
ImplementationFile=LEDSignToolKitDlg.cpp
LastObject=CAboutDlg

[CLS:CLEDSignToolKitDlg]
Type=0
BaseClass=CDialog
HeaderFile=LEDSignToolKitDlg.h
ImplementationFile=LEDSignToolKitDlg.cpp
Filter=D
VirtualFilter=dWC
LastObject=ID_FILE_EXIT

[CLS:CLEDTextCtrl]
Type=0
BaseClass=CStatic
HeaderFile=LEDTextCtrl.h
ImplementationFile=LEDTextCtrl.cpp

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_LEDSIGNTOOLKIT_DIALOG]
Type=1
Class=CLEDSignToolKitDlg
ControlCount=28
Control1=IDC_EDIT_LED_TEXT,edit,1350631552
Control2=IDC_COMBO_COLOR_TEXT,combobox,1344340003
Control3=IDC_BUTTON_START,button,1342242816
Control4=IDC_EDIT_NUM_OF_COL,edit,1350639744
Control5=IDC_SPIN_COL,msctls_updown32,1342177334
Control6=IDC_EDIT_NUM_OF_ROW,edit,1350639744
Control7=IDC_SPIN_ROW,msctls_updown32,1342177334
Control8=IDC_EDIT_NUM_OF_PAGE,edit,1350639744
Control9=IDC_SPIN_PAGE,msctls_updown32,1342177334
Control10=IDC_BUTTON_NEXT_PAGE,button,1342242816
Control11=IDC_BUTTON_PREV_PAGE,button,1342242816
Control12=IDC_BUTTON_EXPORT_TO,button,1342242816
Control13=IDC_BUTTON_IMPORT_FROM,button,1342242816
Control14=IDC_BUTTON_GEN_CODE,button,1342242816
Control15=IDC_STATIC_DEMO_TEXT,static,1342181382
Control16=IDC_STATIC_LED_CONTROL,static,1342181636
Control17=IDC_STATIC,button,1342177287
Control18=IDC_STATIC,button,1342177287
Control19=IDC_STATIC,static,1342308864
Control20=IDC_STATIC,static,1342308864
Control21=IDC_STATIC_PAGE,static,1342177287
Control22=IDC_STATIC,button,1342177287
Control23=IDC_STATIC,static,1342308352
Control24=IDC_STATIC,static,1342308352
Control25=IDC_STATIC,static,1342308352
Control26=IDC_BUTTON_SET,button,1342242816
Control27=IDC_COMBO_COM,combobox,1344340227
Control28=IDC_STATIC,static,1342308352

[MNU:IDR_MENU]
Type=1
Class=CLEDSignToolKitDlg
Command1=ID_FILE_OPEN
Command2=ID_FILE_SAVE
Command3=ID_FILE_EXIT
CommandCount=3

[CLS:CPageNumber]
Type=0
HeaderFile=PageNumber.h
ImplementationFile=PageNumber.cpp
BaseClass=CStatic
Filter=W
VirtualFilter=WC
LastObject=CPageNumber

[DLG:IDD_DIALOG_DELAY]
Type=1
Class=CDelaySettingDlg
ControlCount=1
Control1=IDC_EDIT_DELAY,edit,1350631552

[CLS:CDelaySettingDlg]
Type=0
HeaderFile=DelaySettingDlg.h
ImplementationFile=DelaySettingDlg.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC

