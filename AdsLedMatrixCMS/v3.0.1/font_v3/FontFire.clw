; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CAboutDlg
LastTemplate=CStatic
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "FontFire.h"

ClassCount=5
Class1=CFontFireApp
Class2=CFontFireDlg
Class3=CAboutDlg

ResourceCount=5
Resource1=IDD_FONTFIRE_DIALOG
Resource2=IDR_MAINFRAME
Resource3=IDD_ABOUTBOX
Class4=CFontListCtrl
Class5=CStaticCopyright
Resource4=IDR_MENU
Resource5=IDR_FONT_FIRE

[CLS:CFontFireApp]
Type=0
HeaderFile=FontFire.h
ImplementationFile=FontFire.cpp
Filter=N

[CLS:CFontFireDlg]
Type=0
HeaderFile=FontFireDlg.h
ImplementationFile=FontFireDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC
LastObject=CFontFireDlg

[CLS:CAboutDlg]
Type=0
HeaderFile=FontFireDlg.h
ImplementationFile=FontFireDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC
LastObject=CAboutDlg

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=5
Control1=IDC_STATIC_COPYRIGHT,static,1342308353
Control2=IDC_STATIC_COUNTER_L,static,1342308359
Control3=IDC_STATIC_MATRIX_TOP,static,1342177287
Control4=IDC_STATIC_MATRIX_BOTTOM,static,1342177287
Control5=IDC_STATIC_COUNTER_R,static,1342308359

[DLG:IDD_FONTFIRE_DIALOG]
Type=1
Class=CFontFireDlg
ControlCount=19
Control1=IDC_RADIO_PEN,button,1342308361
Control2=IDC_RADIO_BRUSH,button,1342177289
Control3=IDC_EDIT_BRUSH_SIZE,edit,1350639616
Control4=IDC_SPIN_BRUSH,msctls_updown32,1342177334
Control5=IDC_RADIO_SELECT,button,1342177289
Control6=IDC_RADIO_MOVE,button,1342177289
Control7=IDC_RADIO_ZOOM,button,1342177289
Control8=IDC_BUTTON_COPY,button,1342242816
Control9=IDC_BUTTON_PASTE,button,1342242816
Control10=IDC_BUTTON_ERASE,button,1342242816
Control11=IDC_BUTTON_FILL,button,1342242816
Control12=IDC_STATIC_FRAME,static,1342177289
Control13=IDC_LIST_FONT,SysListView32,1350632452
Control14=IDC_EDIT_CHAR_WIDTH,edit,1350631552
Control15=IDC_SPIN_CHAR_WIDTH,msctls_updown32,1342177334
Control16=IDC_STATIC_CODE,static,1342308353
Control17=IDC_STATIC,static,1342177298
Control18=IDC_STATIC_PREVIEW,static,1082130432
Control19=IDC_EDIT_PREVIEW,RICHEDIT,1342242944

[MNU:IDR_MENU]
Type=1
Class=CFontFireDlg
Command1=ID_FILE_OPENFONT
Command2=ID_FILE_NEWFONT
Command3=ID_FILE_SAVEFONT
Command4=ID_FILE_SAVEAS
Command5=ID_FILE_ABOUTFONTFIREEDITOR
Command6=ID_EDIT_COPYOBJECT
Command7=ID_EDIT_PASTEOBJECT
Command8=ID_EDIT_ERASEOBJECT
Command9=ID_EDIT_FILLRECT
Command10=ID_EDIT_SELECTOBJECT
Command11=ID_EDIT_DESELECTOBJECT
Command12=ID_EDIT_ZOOMIN
Command13=ID_EDIT_ZOOMOUT
Command14=ID_TOOL_CONVERT
Command15=ID_HELP_ABOUTFONTFIREV10
CommandCount=15

[CLS:CFontListCtrl]
Type=0
HeaderFile=FontListCtrl.h
ImplementationFile=FontListCtrl.cpp
BaseClass=CListCtrl
Filter=W
VirtualFilter=FWC
LastObject=CFontListCtrl

[CLS:CStaticCopyright]
Type=0
HeaderFile=StaticCopyright.h
ImplementationFile=StaticCopyright.cpp
BaseClass=CStatic
Filter=W
VirtualFilter=WC
LastObject=CStaticCopyright

[ACL:IDR_FONT_FIRE]
Type=1
Class=?
Command1=ID_EDIT_COPYOBJECT
Command2=ID_EDIT_SELECTOBJECT
Command3=ID_FILE_NEWFONT
Command4=ID_FILE_OPENFONT
Command5=ID_FILE_SAVEFONT
Command6=ID_EDIT_PASTEOBJECT
Command7=ID_EDIT_ZOOMIN
Command8=ID_EDIT_ERASEOBJECT
Command9=ID_EDIT_DESELECTOBJECT
Command10=ID_EDIT_ZOOMOUT
CommandCount=10

