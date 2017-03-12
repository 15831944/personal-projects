
#ifndef __PROTECTED_SOFT_
#define __PROTECTED_SOFT_

#include "md5.h"

extern BOOL GetPermission(LPCTSTR szLicenseFile,CString& csLicenseInfo);
extern CString GetSerialNo();
extern void __getCPUID(DWORD* result,DWORD param);
extern BOOL __getHDDSerial(LPDWORD pSerial);


#endif // __PROTECTED_SOFT_