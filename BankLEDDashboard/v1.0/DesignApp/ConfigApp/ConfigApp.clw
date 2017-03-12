; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CConfigAppDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "ConfigApp.h"

ClassCount=4
Class1=CConfigAppApp
Class2=CConfigAppDlg
Class3=CAboutDlg

ResourceCount=3
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Resource3=IDD_CONFIGAPP_DIALOG

[CLS:CConfigAppApp]
Type=0
HeaderFile=ConfigApp.h
ImplementationFile=ConfigApp.cpp
Filter=N

[CLS:CConfigAppDlg]
Type=0
HeaderFile=ConfigAppDlg.h
ImplementationFile=ConfigAppDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC

[CLS:CAboutDlg]
Type=0
HeaderFile=ConfigAppDlg.h
ImplementationFile=ConfigAppDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_CONFIGAPP_DIALOG]
Type=1
Class=CConfigAppDlg
ControlCount=3
Control1=IDOK,button,1342242817
Control2=IDC_EDIT_BMP_FILE,edit,1350631552
Control3=IDC_BUTTON_BROWSE,button,1342242816

