
#include "stdafx.h"
#include "LogFile.h"

TCHAR _szLogFilePath[MAX_PATH] = _T("");
BOOL _bEnableLogFile = TRUE;

void LOG_TO_FILE(LPCTSTR szMsg, ... )
{
	int nBuf;
	CFile file;
	BOOL result=FALSE;	
	TCHAR szLog[MAX_PATH];
	TCHAR szBuffer[MAX_PATH];
	SYSTEMTIME time;	
	DWORD dwFileSize = 0;
	TCHAR szPath[MAX_PATH] = _T("");
try{
	GetLocalTime(&time);
	if (_bEnableLogFile){
		
	 #ifdef _UNICODE		
		swprintf(szPath,_T("%s%02d%02d%02d.log"),_szLogFilePath,time.wYear,time.wMonth,time.wDay);			
		result=file.Open(szPath,CFile::modeCreate|CFile::modeNoTruncate|CFile::modeReadWrite);
	 #else
		sprintf(szPath,"%s%02d%02d%02d.log",_szLogFilePath,time.wYear,time.wMonth,time.wDay);			
		result=file.Open(szPath,CFile::modeCreate|CFile::modeNoTruncate|CFile::modeReadWrite);
	 #endif
		if (result){		
			dwFileSize = file.SeekToEnd();				
			if (dwFileSize > MAX_LOG_FILE_SIZE)
			{
				file.Flush();
				file.Close();		
				file.Open(szPath,CFile::modeCreate|CFile::modeReadWrite);		
			}	
		}
	}

	va_list args;
	va_start(args, szMsg);	
	nBuf = _vsntprintf(szBuffer, sizeof(szBuffer), szMsg, args);
	va_end(args);

#ifdef _UNICODE	
	swprintf(szLog,_T("[%02d:%02d:%02d]- %s\r\n"),time.wHour,time.wMinute,time.wSecond,szBuffer);
	char szTemp[MAX_PATH];
	UnicodeToMultiByte(szTemp,sizeof(szTemp),szLog);
	if (_bEnableLogFile){
		if (result){
			file.Write(szTemp,strlen(szTemp)+1);
		}
	}
#else
	sprintf(szLog,_T("[%02d:%02d:%02d]- %s\r\n"),time.wHour,time.wMinute,time.wSecond,szBuffer);	
	if (_bEnableLogFile){
		if (result){
			file.Write(szLog,strlen(szLog)+1);	
		}
	}
#endif
	
	if (_bEnableLogFile){
		if (result){
			file.Close();
		}
	}
	TRACE(szLog);
}
catch( CMemoryException* e ){
	TCHAR szError[MAX_PATH];
	e->GetErrorMessage(szError,sizeof(szError),0);
	TRACE(szError);
}
catch( CFileException* e ){
	TCHAR szError[MAX_PATH];
	e->GetErrorMessage(szError,sizeof(szError),0);
	TRACE(szError);
}
catch( CException* e ){
	TCHAR szError[MAX_PATH];
	e->GetErrorMessage(szError,sizeof(szError),0);
	TRACE(szError);
}
// end of LOG_FILE	
}
