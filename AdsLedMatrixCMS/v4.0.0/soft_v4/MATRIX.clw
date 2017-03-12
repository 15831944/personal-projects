; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CMATRIXDlg
LastTemplate=CStatic
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "matrix.h"
LastPage=0

ClassCount=13
Class1=CButtonST
Class2=CColorCombo
Class3=CConnectingDlg
Class4=CDataEdit
Class5=CFontDisp
Class6=CMATRIXApp
Class7=CMatrixDisp
Class8=CMATRIXDlg
Class9=CMatrixSimulator
Class10=CProgressDlg
Class11=CSettingDlg

ResourceCount=7
Resource1=IDR_MENU
Resource2=IDD_SETTING_DIALOG
Resource3=IDD_MATRIX_DIALOG
Resource4=IDD_PROGRESS_DIALOG
Resource5=CG_IDR_POPUP_MATRIX_SIMULATOR
Class12=CColorText
Class13=CStaticFrame
Resource6=IDD_CONNECTING_STATUS
Resource7=IDR_SHORT_KEY

[CLS:CButtonST]
Type=0
BaseClass=CButton
HeaderFile=BtnST.h
ImplementationFile=BtnST.cpp
LastObject=CButtonST

[CLS:CColorCombo]
Type=0
BaseClass=CComboBox
HeaderFile=ColorCombo.h
ImplementationFile=ColorCombo.cpp

[CLS:CConnectingDlg]
Type=0
BaseClass=CDialog
HeaderFile=ConnectingDlg.h
ImplementationFile=ConnectingDlg.cpp
Filter=D
VirtualFilter=dWC
LastObject=CConnectingDlg

[CLS:CDataEdit]
Type=0
BaseClass=CEdit
HeaderFile=DataEdit.h
ImplementationFile=DataEdit.cpp

[CLS:CFontDisp]
Type=0
BaseClass=CStatic
HeaderFile=fontdisp.h
ImplementationFile=FontDisp.cpp

[CLS:CMATRIXApp]
Type=0
BaseClass=CWinApp
HeaderFile=MATRIX.h
ImplementationFile=MATRIX.cpp

[CLS:CMatrixDisp]
Type=0
BaseClass=CStatic
HeaderFile=MatrixDisp.h
ImplementationFile=MatrixDisp.cpp

[CLS:CMATRIXDlg]
Type=0
BaseClass=CDialog
HeaderFile=MATRIXDlg.h
ImplementationFile=MATRIXDlg.cpp
LastObject=ID_FILE_OPENWORKSPACE
Filter=D
VirtualFilter=dWC

[CLS:CMatrixSimulator]
Type=0
BaseClass=CStatic
HeaderFile=MatrixSimulator.h
ImplementationFile=MatrixSimulator.cpp
Filter=W
VirtualFilter=WC
LastObject=CMatrixSimulator

[CLS:CProgressDlg]
Type=0
BaseClass=CDialog
HeaderFile=ProgressDlg.h
ImplementationFile=ProgressDlg.cpp

[CLS:CSettingDlg]
Type=0
BaseClass=CDialog
HeaderFile=SettingDlg.h
ImplementationFile=SettingDlg.cpp
Filter=D
VirtualFilter=dWC

[DLG:IDD_CONNECTING_STATUS]
Type=1
Class=CConnectingDlg
ControlCount=5
Control1=IDC_ANIMATE,SysAnimate32,1342242822
Control2=IDC_STATIC_TEXT,static,1342308352
Control3=IDC_STATIC,static,1342177294
Control4=IDC_STATIC,static,1342177296
Control5=IDC_STATIC,static,1342177296

[DLG:IDD_MATRIX_DIALOG]
Type=1
Class=CMATRIXDlg
ControlCount=42
Control1=IDC_RADIO_POINTER,button,1342308361
Control2=IDC_RADIO_PEN,button,1342177289
Control3=IDC_COMBO_COLOR_PEN,combobox,1344340003
Control4=IDC_EDIT_TEXT,RICHEDIT,1353777348
Control5=IDC_LIST_FONT,listbox,1352732931
Control6=IDC_EDIT_RATE,edit,1350631552
Control7=IDC_SPIN_RATE,msctls_updown32,1342177462
Control8=IDC_COMBO_LINE,combobox,1344340227
Control9=IDC_COMBO_SCROLL_MODE,combobox,1344339971
Control10=IDC_COMBO_COLOR_TEXT,combobox,1344340003
Control11=IDC_LIST_LAYER,listbox,1352728833
Control12=IDC_BUTTON_LOAD_TEXT,button,1342242816
Control13=IDC_BUTTON_SET,button,1342242816
Control14=IDC_STATIC,static,1342177296
Control15=IDC_STATIC_FONT_TEXT,static,1342308864
Control16=IDC_STATIC,static,1342177296
Control17=IDC_STATIC,static,1342308352
Control18=IDC_STATIC_MATRIX,static,1207959813
Control19=IDC_BUTTON_START,button,1342242816
Control20=IDC_BUTTON_STOP,button,1342242816
Control21=IDC_STATIC,static,1342308865
Control22=IDC_STATIC,static,1342308865
Control23=IDC_SPIN_TOPBOT_TEXT,msctls_updown32,1342177318
Control24=IDC_SPIN_LEFTRIGHT_TEXT,msctls_updown32,1342177380
Control25=IDC_CHECK_LAYER0,button,1342242819
Control26=IDC_CHECK_LAYER1,button,1342242819
Control27=IDC_CHECK_LAYER2,button,1342242819
Control28=IDC_CHECK_LAYER3,button,1342242819
Control29=IDC_STATIC,static,1342177296
Control30=IDC_STATIC,static,1342177296
Control31=IDC_STATIC,static,1342177298
Control32=IDC_STATIC_FRAME,static,1342181380
Control33=IDC_STATIC_COM_STATUS,static,1342308865
Control34=IDC_STATIC,static,1342177296
Control35=IDC_STATIC_CLOCK,static,1342308865
Control36=IDC_STATIC,static,1342308864
Control37=IDC_STATIC,static,1342177287
Control38=IDC_STATIC,static,1342177298
Control39=IDC_STATIC,static,1342308352
Control40=IDC_BUTTON_CLEAR_LAYER,button,1342242816
Control41=IDC_STATIC,static,1342177298
Control42=IDC_STATIC,static,1342308352

[DLG:IDD_PROGRESS_DIALOG]
Type=1
Class=CProgressDlg
ControlCount=4
Control1=IDC_PROGRESS,msctls_progress32,1342177281
Control2=IDC_STATIC_PROGRESS,static,1342308352
Control3=IDC_STATIC_TEXT,static,1342308352
Control4=IDC_STATIC,static,1342177296

[DLG:IDD_SETTING_DIALOG]
Type=1
Class=CSettingDlg
ControlCount=15
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_COMBO_COMPORT,combobox,1344340227
Control4=IDC_STATIC,static,1342177296
Control5=IDC_EDIT_COLUMN,edit,1350631552
Control6=IDC_SPIN_COLUMN,msctls_updown32,1342177334
Control7=IDC_STATIC,button,1342177287
Control8=IDC_STATIC,static,1342308352
Control9=IDC_STATIC,static,1342308352
Control10=IDC_COMBO_RESIZE,combobox,1344339971
Control11=IDC_STATIC,static,1342177296
Control12=IDC_STATIC,static,1342308352
Control13=IDC_CHECK_SAVE_AFTER_LOAD,button,1342242819
Control14=IDC_EDIT_ROW,edit,1350631552
Control15=IDC_SPIN_ROW,msctls_updown32,1342177334

[MNU:IDR_MENU]
Type=1
Class=CMATRIXDlg
Command1=ID_FILE_OPENWORKSPACE
Command2=ID_FILE_SAVEWORKSPACE
Command3=ID_FILE_EXIT
Command4=ID_DEVICE_DOWNLOADDATA
Command5=ID_DEVICE_SAVEALLDATATOEEPROM
Command6=ID_DEVICE_STANDBYSETTING
Command7=ID_DEVICE_SETDEVICEDATETIME
Command8=ID_DEVICE_RESTOREFACTORYSETTINGS
Command9=ID_DEVICE_POWERONCOMMAND
Command10=ID_DEVICE_POWEROFF
Command11=ID_OPTION_FONTFIREEDITOR
Command12=ID_OPTION_SETTINGS
Command13=ID_HELP_ABOUT
CommandCount=13

[MNU:CG_IDR_POPUP_MATRIX_SIMULATOR]
Type=1
Class=CMATRIXDlg
Command1=ID_POPUP_LOADFRAMESIMAGE
Command2=ID_POPUP_CHANGESCALE_1X1
Command3=ID_POPUP_CHANGESCALE_2X2
Command4=ID_POPUP_CHANGESCALE_3X3
Command5=ID_POPUP_CHANGESCALE_4X4
Command6=ID_POPUP_STARTSCROLL
Command7=ID_POPUP_STOPSCROLL
Command8=ID_MOVING_LEFTTEXT
Command9=ID_MOVING_RIGHTTEXT
Command10=ID_MOVING_TOPTEXT
Command11=ID_MOVING_BOTTEXT
CommandCount=11

[CLS:CColorText]
Type=0
HeaderFile=ColorText.h
ImplementationFile=ColorText.cpp
BaseClass=CStatic
Filter=W
VirtualFilter=WC
LastObject=CColorText

[CLS:CStaticFrame]
Type=0
HeaderFile=StaticFrame.h
ImplementationFile=StaticFrame.cpp
BaseClass=CStatic
Filter=W
VirtualFilter=WC
LastObject=CStaticFrame

[ACL:IDR_SHORT_KEY]
Type=1
Class=?
Command1=ID_MOVING_BOTTEXT
Command2=ID_MOVING_LEFTTEXT
Command3=ID_MOVING_RIGHTTEXT
Command4=ID_MOVING_TOPTEXT
CommandCount=4

