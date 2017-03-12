# Microsoft Developer Studio Project File - Name="FontFire" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=FontFire - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "FontFire.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "FontFire.mak" CFG="FontFire - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "FontFire - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "FontFire - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "FontFire - Win32 Release"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 /nologo /subsystem:windows /machine:I386
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "FontFire - Win32 Debug"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# SUBTRACT LINK32 /pdb:none

!ENDIF 

# Begin Target

# Name "FontFire - Win32 Release"
# Name "FontFire - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\3iMatrix.cpp
# End Source File
# Begin Source File

SOURCE=.\3iMatrixEdit.cpp
# End Source File
# Begin Source File

SOURCE=.\DataEdit.cpp
# End Source File
# Begin Source File

SOURCE=.\FontDisp.cpp
# End Source File
# Begin Source File

SOURCE=.\FontEditor.cpp
# End Source File
# Begin Source File

SOURCE=.\FontFire.cpp
# End Source File
# Begin Source File

SOURCE=.\FontFire.rc
# End Source File
# Begin Source File

SOURCE=.\FontFireDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\FontListCtrl.cpp
# End Source File
# Begin Source File

SOURCE=.\LineColor.cpp
# End Source File
# Begin Source File

SOURCE=.\MatrixPreview.cpp
# End Source File
# Begin Source File

SOURCE=.\ScrollMatrix.cpp
# End Source File
# Begin Source File

SOURCE=.\ShiftReg.cpp
# End Source File
# Begin Source File

SOURCE=.\StaticCopyright.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\3iMatrix.h
# End Source File
# Begin Source File

SOURCE=.\3iMatrixEdit.h
# End Source File
# Begin Source File

SOURCE=.\DataEdit.h
# End Source File
# Begin Source File

SOURCE=.\FontDisp.h
# End Source File
# Begin Source File

SOURCE=.\FontEditor.h
# End Source File
# Begin Source File

SOURCE=.\FontFire.h
# End Source File
# Begin Source File

SOURCE=.\FontFireDlg.h
# End Source File
# Begin Source File

SOURCE=.\FontListCtrl.h
# End Source File
# Begin Source File

SOURCE=.\LineColor.h
# End Source File
# Begin Source File

SOURCE=.\MatrixPreview.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\ScrollMatrix.h
# End Source File
# Begin Source File

SOURCE=.\ShiftReg.h
# End Source File
# Begin Source File

SOURCE=.\StaticCopyright.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\156.ico
# End Source File
# Begin Source File

SOURCE=.\res\157.ico
# End Source File
# Begin Source File

SOURCE=.\res\arrow_m.cur
# End Source File
# Begin Source File

SOURCE=.\res\arrow_r.cur
# End Source File
# Begin Source File

SOURCE=.\res\beam_m.cur
# End Source File
# Begin Source File

SOURCE=.\res\CROSS02.CUR
# End Source File
# Begin Source File

SOURCE=.\res\cur00001.cur
# End Source File
# Begin Source File

SOURCE=.\res\cur1270.cur
# End Source File
# Begin Source File

SOURCE=.\res\cur1310.cur
# End Source File
# Begin Source File

SOURCE=.\res\cursor1.cur
# End Source File
# Begin Source File

SOURCE=.\res\FontFire.ico
# End Source File
# Begin Source File

SOURCE=.\res\FontFire.rc2
# End Source File
# Begin Source File

SOURCE=.\res\icon1.ico
# End Source File
# Begin Source File

SOURCE=.\res\matrixsetblue.bmp
# End Source File
# Begin Source File

SOURCE=.\res\matrixsetsmallblue.bmp
# End Source File
# Begin Source File

SOURCE=.\res\matrixsettinyblue.bmp
# End Source File
# Begin Source File

SOURCE=.\res\move_m.cur
# End Source File
# End Group
# Begin Group "Tools"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\Tools\3DBar.cpp
# End Source File
# Begin Source File

SOURCE=..\Tools\3DBar.h
# End Source File
# Begin Source File

SOURCE=..\Tools\MatrixStatic.cpp
# End Source File
# Begin Source File

SOURCE=..\Tools\MatrixStatic.h
# End Source File
# Begin Source File

SOURCE=..\Tools\MD5.cpp
# End Source File
# Begin Source File

SOURCE=..\Tools\MD5.h
# End Source File
# Begin Source File

SOURCE=..\Tools\MemDC.h
# End Source File
# Begin Source File

SOURCE=..\Tools\ProtectedSoft.cpp
# End Source File
# Begin Source File

SOURCE=..\Tools\ProtectedSoft.h
# End Source File
# Begin Source File

SOURCE=..\Tools\StaticCounter.cpp
# End Source File
# Begin Source File

SOURCE=..\Tools\StaticCounter.h
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
