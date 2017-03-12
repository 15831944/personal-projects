#include "stdafx.h"        // Standard windows header file
#include "ProtectedSoft.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

void __getCPUID(DWORD* result,DWORD param)
{
/************************************************/
// GET CPUID command OPCODE = 0xA20F			//
//----------------------------------------------//
// EAX = 0 --> Get Vendor = {EBX-EDX-ECX}		//
// EAX = 1 --> Get EBX,EDX = {Cache,ALU,CPU}	//
// EAX = 2 --> Get Cache Info					//
// EAX = 3 --> Serial no = {EAX,EBX,ECX,EDX}	//
// EAX = 80000000H ->80000004H {adv func CPU}	//
/************************************************/	
#ifndef  _DEBUG

	DWORD buffer[4];
__asm 
	{
		MOV EAX, param		

		CPUID			// 27 bytes = 1B		

		MOV dword ptr [buffer+ 0], EAX
		MOV dword ptr [buffer+ 4], EBX
		MOV dword ptr [buffer+ 8], ECX
		MOV dword ptr [buffer+12], EDX
	}

	memcpy(result,buffer,sizeof(DWORD)*4);

#endif
}

BOOL __getHDDSerial(LPDWORD pSerial)
{
	DWORD dwRes = 0;
	TCHAR buffer[MAX_PATH] = {0};
	return GetVolumeInformation(_T("C:\\"),buffer,sizeof(buffer),pSerial,&dwRes,&dwRes,buffer,sizeof(buffer));
}

BYTE __md5Hash[16];

#define	__GET_PERMISSION(bPermission)\
{\
	for (int ix =0; ix< 16; ix++)\
	{\
		if (__md5Hash[ix]!=_digit_code[ix])\
			break;\
	};\
	if ( ix < 16)\
	{\
		bPermission = FALSE;\
	}\
	else{\
		bPermission = TRUE;\
	};\
}

BOOL GetPermission(LPCTSTR szLicenseFile, CString& csLicenseInfo)
{
	BOOL bPermission = FALSE;
	CString csKey;
	DWORD dwCPUID = 0;
	__getCPUID(&dwCPUID,3);
	DWORD dwSerial = 0;
	__getHDDSerial(&dwSerial);
	dwCPUID ^= 0x22111A6E;dwSerial ^=0x112295A8;
	csKey.Format(_T("%0004X-%0004X-%0004X-%0004X"),
		LOWORD(dwCPUID),LOWORD(dwSerial),HIWORD(dwSerial),HIWORD(dwCPUID));

	BYTE _digit_code[16];
	CMD5::MD5((BYTE*)csKey.GetBuffer(csKey.GetLength()),csKey.GetLength(),_digit_code);
	FILE* file = _wfopen(szLicenseFile,_T("rb"));
	if (file!=NULL)
	{
		BYTE buffer[512];
		int count = fread(buffer,sizeof(BYTE),sizeof(buffer),file);
		memcpy(__md5Hash,buffer+16,16);
		csLicenseInfo = (TCHAR*)(buffer + 100);
		fclose(file);
	}
	for (int i=0; i< 100; i++)
		__GET_PERMISSION(bPermission);
	
	csLicenseInfo = _T("Designed by CuongQuay\x099"L"");
	return TRUE;//bPermission;
}

CString GetSerialNo()
{
	CString csKey;
	DWORD dwCPUID = 0;
	__getCPUID(&dwCPUID,3);
	DWORD dwSerial = 0;
	__getHDDSerial(&dwSerial);
	dwCPUID ^= 0x22111A6E;dwSerial ^=0x112295A8;
	csKey.Format(_T("%0004X-%0004X-%0004X-%0004X"),
		LOWORD(dwCPUID),LOWORD(dwSerial),HIWORD(dwSerial),HIWORD(dwCPUID));
	
	BYTE _digit_code[16];
	CMD5::MD5((BYTE*)csKey.GetBuffer(csKey.GetLength()),csKey.GetLength(),_digit_code);
	
	return csKey;
}
