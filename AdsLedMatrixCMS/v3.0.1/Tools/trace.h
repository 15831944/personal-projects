#ifndef _TRACE_H_
#define _TRACE_H_

void MY_TRACE(LPCTSTR szMsg, ... );

///////////////////////////////////////////////////////////////////////////
// TRACE INTO FILE ROUNTINE ///////////////////////////////////////////////
#include <stdarg.h>
void MY_TRACE(LPCTSTR szMsg, ... )
{
#ifdef _TRACE_FILE

	TCHAR szPath[MAX_PATH];
	GetWindowsDirectory(szPath,sizeof(szPath));
	wcscat(szPath,_T("\\sbtrace.txt"));
	FILE* file = _wfopen(szPath,_T("a+"));

	if (file == NULL)	return;

	fseek(file,0,SEEK_END);
	DWORD dwFileSize = ftell(file);
	
	if (dwFileSize > 1024*10 /* 10 KB limit */)
	{
		fflush(file);	// empty all data
		fclose(file);
		file = _wfopen(szPath,_T("w"));

		if (file == NULL)	return;
	}

	va_list args;
	va_start(args, szMsg);

	int nBuf;
	TCHAR szBuffer[512];

	nBuf = _vsntprintf(szBuffer, sizeof(szBuffer), szMsg, args);
	
	fputws(szBuffer,file);

	va_end(args);

	fclose(file);

#else
	// trandittion TRACE rountine
	TRACE(szMsg);
#endif
}

#endif	// _TRACE_H_