#ifndef __CUONGDD_LOG_FILE_
#define __CUONGDD_LOG_FILE_

#define		MAX_LOG_FILE_SIZE		(10*1024*1024)

///////////////////////////////////////////////////////////////////////////
// TRACE INTO FILE ROUNTINE ///////////////////////////////////////////////
#include <stdarg.h>
void LOG_TO_FILE(LPCTSTR szMsg, ... );
extern TCHAR _szLogFilePath[MAX_PATH];
extern BOOL _bEnableLogFile;
#endif //__CUONGDD_LOG_FILE_