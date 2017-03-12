#ifndef __CUONGDD_LOG_FILE_
#define __CUONGDD_LOG_FILE_

///////////////////////////////////////////////////////////////////////////
// TRACE INTO FILE ROUNTINE ///////////////////////////////////////////////
#include <stdarg.h>
void LOG_TO_FILE(const char* szMsg, ... );
extern char _szLogFilePath[512];
extern bool _bEnableLogFile;
#endif //__CUONGDD_LOG_FILE_