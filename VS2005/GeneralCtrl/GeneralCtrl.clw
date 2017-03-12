; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CMatrixStatic
LastTemplate=CStatic
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "generalctrl.h"
LastPage=0

ClassCount=16
Class1=CColorCombo
Class2=CDataEdit
Class3=CDigiStatic
Class4=CDigiClock
Class5=CDigiScroll
Class6=CDxButton
Class7=CLEDCtrl
Class8=CLEDSign
Class9=CMatrixStatic
Class10=CPanelPropertyPageGeneral
Class11=CPanelPropertySheet
Class12=CPreviewWnd
Class13=CPropertyFrame
Class14=CStaticFrame

ResourceCount=2
Resource1=CG_IDR_POPUP_INPUT_PANEL
Class15=CLEDEdit
Class16=CMatrixEdit
Resource2=IDD_PROPPAGE_GENERAL

[CLS:CColorCombo]
Type=0
BaseClass=CComboBox
HeaderFile=ColorCombo.h
ImplementationFile=ColorCombo.cpp
LastObject=ID_POPUP_COPY

[CLS:CDataEdit]
Type=0
BaseClass=CRichEditCtrl
HeaderFile=DataEdit.h
ImplementationFile=DataEdit.cpp

[CLS:CDigiStatic]
Type=0
BaseClass=CStatic
HeaderFile=DigiStatic.h
ImplementationFile=DigiStatic.cpp

[CLS:CDigiClock]
Type=0
BaseClass=CDigiStatic
HeaderFile=DigiUtil.h
ImplementationFile=DigiUtil.cpp

[CLS:CDigiScroll]
Type=0
BaseClass=CDigiStatic
HeaderFile=DigiUtil.h
ImplementationFile=DigiUtil.cpp

[CLS:CDxButton]
Type=0
BaseClass=CButton
HeaderFile=DxButton.h
ImplementationFile=DxButton.cpp

[CLS:CLEDCtrl]
Type=0
BaseClass=CStatic
HeaderFile=LEDCtrl.h
ImplementationFile=LEDCtrl.cpp
Filter=W
VirtualFilter=WC
LastObject=ID_POPUP_CUT

[CLS:CLEDSign]
Type=0
BaseClass=CStatic
HeaderFile=LEDSign.h
ImplementationFile=LEDSign.cpp

[CLS:CMatrixStatic]
Type=0
BaseClass=CStatic
HeaderFile=MatrixStatic.h
ImplementationFile=MatrixStatic.cpp
LastObject=CMatrixStatic

[CLS:CPanelPropertyPageGeneral]
Type=0
BaseClass=CPropertyPage
HeaderFile=PanelPropertyPage.h
ImplementationFile=panelpropertypage.cpp
Filter=D
VirtualFilter=idWC
LastObject=CPanelPropertyPageGeneral

[CLS:CPanelPropertySheet]
Type=0
BaseClass=CPropertySheet
HeaderFile=PanelPropertySheet.h
ImplementationFile=PanelPropertySheet.cpp

[CLS:CPreviewWnd]
Type=0
BaseClass=CWnd
HeaderFile=PreviewWnd.h
ImplementationFile=PreviewWnd.cpp

[CLS:CPropertyFrame]
Type=0
BaseClass=CMiniFrameWnd
HeaderFile=PropertyFrame.h
ImplementationFile=PropertyFrame.cpp

[CLS:CStaticFrame]
Type=0
BaseClass=CStatic
HeaderFile=StaticFrame.h
ImplementationFile=StaticFrame.cpp

[DLG:IDD_PROPPAGE_GENERAL]
Type=1
Class=CPanelPropertyPageGeneral
ControlCount=29
Control1=IDC_STATIC,button,1342177287
Control2=IDC_EDIT_WIDTH,edit,1350639616
Control3=IDC_SPIN_WIDTH,msctls_updown32,1342177334
Control4=IDC_EDIT_HEIGHT,edit,1350639616
Control5=IDC_SPIN_HEIGHT,msctls_updown32,1342177334
Control6=IDC_EDIT_LEFT,edit,1350639616
Control7=IDC_SPIN_LEFT,msctls_updown32,1342177334
Control8=IDC_EDIT_TOP,edit,1350639616
Control9=IDC_SPIN_TOP,msctls_updown32,1342177334
Control10=IDC_STATIC,static,1342308352
Control11=IDC_STATIC,static,1342308352
Control12=IDC_STATIC,static,1342308352
Control13=IDC_STATIC,static,1342308352
Control14=IDC_STATIC,button,1342177287
Control15=IDC_CHECK_CLIENT_EDGE,button,1342242819
Control16=IDC_CHECK_STATIC_EDGE,button,1342242819
Control17=IDC_CHECK_MODAL_FRAME,button,1342242819
Control18=IDC_STATIC,button,1342177287
Control19=IDC_COMBO_LEDCOLOR,combobox,1344340003
Control20=IDC_COMBO_BKCOLOR,combobox,1344340003
Control21=IDC_STATIC,static,1342308352
Control22=IDC_STATIC,static,1342308352
Control23=IDC_STATIC,button,1342177287
Control24=IDC_EDIT_DIGITS,edit,1350639744
Control25=IDC_SPIN_DIGITS,msctls_updown32,1342177334
Control26=IDC_STATIC,static,1342308352
Control27=IDC_CHECK_ENABLE_EDIT,button,1342242819
Control28=IDC_COMBO_LEDCOLOR_OFF,combobox,1344340003
Control29=IDC_STATIC,static,1342308352

[MNU:CG_IDR_POPUP_INPUT_PANEL]
Type=1
Class=CLEDCtrl
Command1=ID_POPUP_LOCKPANELPOSITION
Command2=ID_POPUP_CUT
Command3=ID_POPUP_COPY
Command4=ID_POPUP_REMOVE
Command5=ID_POPUP_PROPERTIES
CommandCount=5

[CLS:CLEDEdit]
Type=0
HeaderFile=LEDEdit.h
ImplementationFile=LEDEdit.cpp
BaseClass=CStatic
Filter=W
VirtualFilter=WC
LastObject=CLEDEdit

[CLS:CMatrixEdit]
Type=0
HeaderFile=MatrixEdit.h
ImplementationFile=MatrixEdit.cpp
BaseClass=CStatic
Filter=W
LastObject=CMatrixEdit
VirtualFilter=WC

