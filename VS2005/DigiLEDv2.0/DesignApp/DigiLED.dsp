# Microsoft Developer Studio Project File - Name="DigiLED" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=DigiLED - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "DigiLED.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "DigiLED.mak" CFG="DigiLED - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "DigiLED - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "DigiLED - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "DigiLED - Win32 Release"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x409 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 /nologo /subsystem:windows /machine:I386

!ELSEIF  "$(CFG)" == "DigiLED - Win32 Debug"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x409 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 GeneralCtrl.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "DigiLED - Win32 Release"
# Name "DigiLED - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\AddControlDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\DigiLED.cpp
# End Source File
# Begin Source File

SOURCE=.\DigiLED.rc
# End Source File
# Begin Source File

SOURCE=.\DigiLEDDoc.cpp
# End Source File
# Begin Source File

SOURCE=.\DigiLEDView.cpp
# End Source File
# Begin Source File

SOURCE=.\DownloadSettingDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\GlobalData.cpp
# End Source File
# Begin Source File

SOURCE=.\LEDFrame.cpp
# End Source File
# Begin Source File

SOURCE=.\MainFrm.cpp
# End Source File
# Begin Source File

SOURCE=..\Common\Serial.cpp
# End Source File
# Begin Source File

SOURCE=..\Common\SerialEx.cpp
# End Source File
# Begin Source File

SOURCE=..\Common\SerialWnd.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\AddControlDlg.h
# End Source File
# Begin Source File

SOURCE=.\DigiLED.h
# End Source File
# Begin Source File

SOURCE=.\DigiLEDDoc.h
# End Source File
# Begin Source File

SOURCE=.\DigiLEDView.h
# End Source File
# Begin Source File

SOURCE=.\DownloadSettingDlg.h
# End Source File
# Begin Source File

SOURCE=.\GlobalData.h
# End Source File
# Begin Source File

SOURCE=.\LEDFrame.h
# End Source File
# Begin Source File

SOURCE=.\MainFrm.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=..\Common\Serial.h
# End Source File
# Begin Source File

SOURCE=..\Common\SerialEx.h
# End Source File
# Begin Source File

SOURCE=..\Common\SerialMFC.h
# End Source File
# Begin Source File

SOURCE=..\Common\SerialWnd.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\112.ico
# End Source File
# Begin Source File

SOURCE=.\res\117.ico
# End Source File
# Begin Source File

SOURCE=.\res\DigiLED.ico
# End Source File
# Begin Source File

SOURCE=.\res\DigiLED.rc2
# End Source File
# Begin Source File

SOURCE=.\res\DigiLEDDoc.ico
# End Source File
# Begin Source File

SOURCE=.\form.bmp
# End Source File
# Begin Source File

SOURCE=.\matrixsetblue.bmp
# End Source File
# Begin Source File

SOURCE=.\matrixsetsmallblue.bmp
# End Source File
# Begin Source File

SOURCE=.\matrixsettinyblue.bmp
# End Source File
# Begin Source File

SOURCE=.\res\Toolbar.bmp
# End Source File
# End Group
# Begin Source File

SOURCE=.\res\MDI.manifest
# End Source File
# Begin Source File

SOURCE=.\ReadMe.txt
# End Source File
# End Target
# End Project
# Section DigiLED : {72ADFD6C-2C39-11D0-9903-00A0C91BC942}
# 	1:21:CG_IDR_POPUP_LEDFRAME:102
# End Section
