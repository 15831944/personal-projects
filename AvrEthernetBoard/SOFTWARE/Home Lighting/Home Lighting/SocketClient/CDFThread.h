//  ---------------------------------------------------------
//  Copyright (c) Neopost Inc., 2012. All rights reserved.   
//  ---------------------------------------------------------
//  Domain     -    IDFNetworks
//  Version    -    0.1
//  ---------------------------------------------------------
//  File Name  -    CDFThread.h
//  Initiated  -    Neopost OSDC, FPT Software, G10-iOS Team.
//  Change History: 
//      - [06/25/2012][iOS Hanoi]: Creation.
//      - [Date][Author]: [Reason to modify]
//  ---------------------------------------------------------



#ifndef __DF_THREAD__H__
#define __DF_THREAD__H__

#ifndef WIN32
#include <pthread.h>
#else
#include <process.h>
#endif

#include "CDFMsgQueue.h"

#ifndef WIN32
#define	 H_THREAD		pthread_t	
#else
#define	 H_THREAD		HANDLE	
#endif

#define MSG_THREAD_EXIT            0x0fffffff

class CDFThread
{
public:
	virtual void Exit();
	bool IsRunning();
	virtual void OnDFThreadExit();
	int CreateQueue();
	static int PostThreadMessage(CDFThread *pThread, int nMsg, char* pchContent,int nSize, bool bHighPriority=false);
	static int PostThreadMessage(CDFThread *pThread, int nMsg, bool bHighPriority=false);
	static int PostQuitMessage(CDFThread *pThread,bool bHighPriority=false);
	struct AllArg{
        	void* m_pArg;
		CDFThread* m_pThis;
	} m_oAllArg;
	CDFThread();
	void InitThread(void * arg);
	int Start();                           
	void SetObjectName(const char* csName);
    const char* GetObjectName() { return m_csObjectName; }
	virtual ~CDFThread();
protected:      
#ifndef WIN32
	virtual int SetThreadAttr(pthread_attr_t* tAttr, unsigned stack_size=0);
#endif
	
#ifndef WIN32
	static void* EntryPoint(void* pThis);     
#else
	static DWORD WINAPI EntryPoint(void * l_pAllArg);
#endif
	virtual  void Run()=0;      
	virtual int PreTranslateMessage(int &nMsg,char* pchContent,int &nSize);
	char m_csObjectName[20];      

protected:
	bool m_bRunning;

private:      
	H_THREAD m_hThreadHandle;      
	CDFMsgQueue m_oMsgQueue;

};
#endif
