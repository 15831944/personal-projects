; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CUDPReceiveSocket
LastTemplate=CAsyncSocket
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "SocketTool.h"

ClassCount=5
Class1=CSocketToolApp
Class2=CSocketToolDlg
Class3=CAboutDlg

ResourceCount=3
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Class4=CUDPReceiveSocket
Class5=CUDPSendSocket
Resource3=IDD_SOCKETTOOL_DIALOG

[CLS:CSocketToolApp]
Type=0
HeaderFile=SocketTool.h
ImplementationFile=SocketTool.cpp
Filter=N

[CLS:CSocketToolDlg]
Type=0
HeaderFile=SocketToolDlg.h
ImplementationFile=SocketToolDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC

[CLS:CAboutDlg]
Type=0
HeaderFile=SocketToolDlg.h
ImplementationFile=SocketToolDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_SOCKETTOOL_DIALOG]
Type=1
Class=CSocketToolDlg
ControlCount=3
Control1=IDOK,button,1342242817
Control2=IDC_EDIT_SEND,edit,1350631552
Control3=IDC_EDIT_RECV,edit,1352728580

[CLS:CUDPReceiveSocket]
Type=0
HeaderFile=UDPReceiveSocket.h
ImplementationFile=UDPReceiveSocket.cpp
BaseClass=CAsyncSocket
Filter=N
VirtualFilter=q
LastObject=CUDPReceiveSocket

[CLS:CUDPSendSocket]
Type=0
HeaderFile=UDPSendSocket.h
ImplementationFile=UDPSendSocket.cpp
BaseClass=CAsyncSocket
Filter=N
LastObject=CUDPSendSocket
VirtualFilter=q

