; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "inputmodule.h"
LastPage=0

ClassCount=3
Class1=CInputModuleApp
Class2=CInputModuleDlg
Class3=CProgressDlg

ResourceCount=5
Resource1=CG_IDR_POPUP_INPUT_PANEL
Resource2=IDD_DIALOG_PASSWORD
Resource3=IDD_DIALOG
Resource4=CG_IDD_PROGRESS
Resource5=IDD_INPUTMODULE_DIALOG

[CLS:CInputModuleApp]
Type=0
BaseClass=CWinApp
HeaderFile=InputModule.h
ImplementationFile=InputModule.cpp

[CLS:CInputModuleDlg]
Type=0
BaseClass=CDialog
HeaderFile=InputModuleDlg.h
ImplementationFile=InputModuleDlg.cpp
Filter=D
VirtualFilter=dWC

[CLS:CProgressDlg]
Type=0
BaseClass=CDialog
HeaderFile=ProgDlg.h
ImplementationFile=ProgDlg.cpp

[DLG:IDD_INPUTMODULE_DIALOG]
Type=1
Class=CInputModuleDlg
ControlCount=21
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC_IO,static,1342308352
Control4=IDC_BUTTON_ONOFF,button,1342242816
Control5=IDC_STATIC_CONTROL,static,1342308608
Control6=IDC_STATIC_INPUT,static,1342177537
Control7=IDC_BUTTON1,button,1342242816
Control8=IDC_STATIC,static,1342312961
Control9=IDC_STATIC,static,1342312961
Control10=IDC_STATIC,static,1342312961
Control11=IDC_STATIC,static,1342312961
Control12=IDC_STATIC,static,1342312961
Control13=IDC_STATIC,static,1342312961
Control14=IDC_STATIC,static,1342312961
Control15=IDC_STATIC,static,1342312961
Control16=IDC_STATIC,static,1342312961
Control17=IDC_STATIC_DIGIT,static,1342309121
Control18=IDC_CHECK1,button,1342242819
Control19=IDC_CHECK2,button,1342242819
Control20=IDC_STATIC_MATRIX,static,1342308864
Control21=IDC_STATIC_TEXT,static,1342308352

[DLG:CG_IDD_PROGRESS]
Type=1
Class=CProgressDlg
ControlCount=4
Control1=IDCANCEL,button,1342242817
Control2=CG_IDC_PROGDLG_PROGRESS,msctls_progress32,1350565888
Control3=CG_IDC_PROGDLG_PERCENT,static,1342308352
Control4=CG_IDC_PROGDLG_STATUS,static,1342308352

[DLG:IDD_DIALOG_PASSWORD]
Type=1
Class=?
ControlCount=2
Control1=IDC_EDIT2,edit,1350631584
Control2=IDC_STATIC,button,1342177287

[DLG:IDD_DIALOG]
Type=1
Class=?
ControlCount=10
Control1=IDC_COMBO,combobox,1344340226
Control2=IDC_STATIC,button,1342177287
Control3=IDC_LIST1,listbox,1352728835
Control4=IDC_STATIC,static,1342308352
Control5=IDC_EDIT1,edit,1350631552
Control6=IDC_EDIT3,edit,1350631552
Control7=IDC_STATIC,static,1342308352
Control8=IDC_STATIC,static,1342308352
Control9=IDC_COMBO2,combobox,1344340226
Control10=IDC_STATIC,static,1342308352

[MNU:CG_IDR_POPUP_INPUT_PANEL]
Type=1
Class=?
Command1=ID_POPUP_LOCKPANELPOSITION
Command2=ID_POPUP_UPDATE_CONFIGURATION
Command3=ID_POPUP_ADVANCED
Command4=ID_POPUP_PROPERTIES
CommandCount=4

