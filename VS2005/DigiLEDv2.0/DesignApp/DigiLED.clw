; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CDigiLEDView
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "DigiLED.h"
LastPage=0

ClassCount=8
Class1=CDigiLEDApp
Class2=CDigiLEDDoc
Class3=CDigiLEDView
Class4=CMainFrame

ResourceCount=6
Resource1=CG_IDR_POPUP_LEDFRAME
Class5=CAboutDlg
Class6=CLEDFrame
Resource2=IDD_ABOUTBOX
Resource3=IDD_ADDCONTROL_DLG
Class7=CAddControlDlg
Resource4=IDR_MENU_DESIGN_MODE
Resource5=IDR_MAINFRAME
Class8=CDownloadSettingDlg
Resource6=IDD_DIALOG_DOWNLOAD

[CLS:CDigiLEDApp]
Type=0
HeaderFile=DigiLED.h
ImplementationFile=DigiLED.cpp
Filter=N

[CLS:CDigiLEDDoc]
Type=0
HeaderFile=DigiLEDDoc.h
ImplementationFile=DigiLEDDoc.cpp
Filter=N
LastObject=ID_FILE_SAVE

[CLS:CDigiLEDView]
Type=0
HeaderFile=DigiLEDView.h
ImplementationFile=DigiLEDView.cpp
Filter=C
BaseClass=CView
VirtualFilter=VWC
LastObject=ID_DEVICE_SETRTC


[CLS:CMainFrame]
Type=0
HeaderFile=MainFrm.h
ImplementationFile=MainFrm.cpp
Filter=W
LastObject=ID_DEVICE_CONFIGRUNMODE
BaseClass=CFrameWnd
VirtualFilter=fWC




[CLS:CAboutDlg]
Type=0
HeaderFile=DigiLED.cpp
ImplementationFile=DigiLED.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[MNU:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_FILE_SAVE_AS
Command5=ID_FILE_PRINT
Command6=ID_FILE_PRINT_PREVIEW
Command7=ID_FILE_PRINT_SETUP
Command8=ID_FILE_MRU_FILE1
Command9=ID_APP_EXIT
Command10=ID_DEVICE_DOWNLOADDATA
Command11=ID_DEVICE_CONFIGRUNMODE
Command12=ID_DEVICE_SETRTC
Command13=ID_VIEW_TOOLBAR
Command14=ID_VIEW_STATUS_BAR
Command15=ID_APP_ABOUT
CommandCount=15

[ACL:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_DEVICE_DOWNLOADDATA
Command2=ID_FILE_NEW
Command3=ID_FILE_OPEN
Command4=ID_FILE_PRINT
Command5=ID_DEVICE_CONFIGRUNMODE
Command6=ID_FILE_SAVE
Command7=ID_NEXT_PANE
Command8=ID_PREV_PANE
CommandCount=8

[TB:IDR_MAINFRAME]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_EDIT_CUT
Command5=ID_EDIT_COPY
Command6=ID_EDIT_PASTE
Command7=ID_FILE_PRINT
Command8=ID_APP_ABOUT
CommandCount=8

[CLS:CLEDFrame]
Type=0
HeaderFile=LEDFrame.h
ImplementationFile=LEDFrame.cpp
BaseClass=CStatic
Filter=W
VirtualFilter=WC
LastObject=CLEDFrame

[MNU:IDR_MENU_DESIGN_MODE]
Type=1
Class=CLEDFrame
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_FILE_SAVE_AS
Command5=ID_FILE_PRINT
Command6=ID_FILE_PRINT_PREVIEW
Command7=ID_FILE_PRINT_SETUP
Command8=ID_FILE_MRU_FILE1
Command9=ID_APP_EXIT
Command10=ID_EDIT_UNDO
Command11=ID_EDIT_CUT
Command12=ID_EDIT_COPY
Command13=ID_EDIT_PASTE
Command14=ID_DESIGN_ADDCOMPONENT
Command15=ID_DESIGN_REPOSITIONCONTROLNUMID
Command16=ID_VIEW_SHOWCONTROLID
Command17=ID_VIEW_TOOLBAR
Command18=ID_VIEW_STATUS_BAR
Command19=ID_APP_ABOUT
CommandCount=19

[DLG:IDD_ADDCONTROL_DLG]
Type=1
Class=CAddControlDlg
ControlCount=21
Control1=IDC_ADD_CONTROL,button,1342242817
Control2=IDC_STATIC,button,1342177287
Control3=IDC_COMBO_STYLE,combobox,1344339971
Control4=IDC_STATIC,static,1342308352
Control5=IDC_STATIC,static,1342308352
Control6=IDC_EDIT_NUM,edit,1350631552
Control7=IDC_SPIN_NUM,msctls_updown32,1342177462
Control8=IDC_STATIC_FONT_NAME,static,1342308352
Control9=IDC_STATIC,button,1342177287
Control10=IDC_STATIC,static,1342308352
Control11=IDC_EDIT_CTL_WIDTH,edit,1350631552
Control12=IDC_SPIN_CTL_WIDTH,msctls_updown32,1342177462
Control13=IDC_EDIT_CTL_HEIGHT,edit,1350631552
Control14=IDC_SPIN_CTL_HEIGHT,msctls_updown32,1342177462
Control15=IDC_STATIC,static,1342308352
Control16=IDC_STATIC_COPY,static,1342177284
Control17=IDC_FINISH,button,1342242816
Control18=IDC_EDIT_CTL_DIGITS,edit,1350631552
Control19=IDC_SPIN_CTL_DIGITS,msctls_updown32,1342177462
Control20=IDC_STATIC,static,1342308352
Control21=IDC_BUTTON_FONT,button,1342242816

[CLS:CAddControlDlg]
Type=0
HeaderFile=AddControlDlg.h
ImplementationFile=AddControlDlg.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC
LastObject=CAddControlDlg

[MNU:CG_IDR_POPUP_LEDFRAME]
Type=1
Class=CLEDFrame
Command1=ID_EDIT_CTL_CUT
Command2=ID_EDIT_CTL_COPY
Command3=ID_EDIT_CTL_PASTE
Command4=ID_POPUP_PREFERENCES
CommandCount=4

[DLG:IDD_DIALOG_DOWNLOAD]
Type=1
Class=CDownloadSettingDlg
ControlCount=8
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,button,1342177287
Control4=IDC_COMBO_PAGE,combobox,1344339971
Control5=IDC_EDIT_SHOW_TIME,edit,1350631552
Control6=IDC_SPIN_SHOW_TIME,msctls_updown32,1342177462
Control7=IDC_STATIC,static,1342308352
Control8=IDC_STATIC,static,1342308352

[CLS:CDownloadSettingDlg]
Type=0
HeaderFile=DownloadSettingDlg.h
ImplementationFile=DownloadSettingDlg.cpp
BaseClass=CDialog
Filter=D
VirtualFilter=dWC
LastObject=CDownloadSettingDlg

