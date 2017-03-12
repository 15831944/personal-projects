//////////////////////////////////////////////////////////////////////
// CDFThread.cpp implement for the CDFThread class.
//
//  Created by Duong Dinh Cuong on 4/25/12.
//  Copyright (c) 2012 Fsoft - G10. All rights reserved.
//
//////////////////////////////////////////////////////////////////////
#include "CDFThread.h"
#include <iostream>

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////
CDFThread::CDFThread() 
{
	m_bRunning=false;
	m_oAllArg.m_pArg=NULL;
}

CDFThread::~CDFThread() 
{

}

//////////////////////////////////////////////////////////////////////
// Public/Private Functions
//////////////////////////////////////////////////////////////////////

int CDFThread::CreateQueue()
{
	return m_oMsgQueue.Create();	
}

int CDFThread::Start()
{
	int l_nCode = -1;
	m_oAllArg.m_pThis = this;
	if (this->CreateQueue() !=-1){
        m_bRunning=true;
    }
#ifndef WIN32
	pthread_attr_t tAttr;
	if (!SetThreadAttr(&tAttr,64*1024))
	{
		l_nCode = pthread_create(&m_hThreadHandle,&tAttr,CDFThread::EntryPoint,(void*)&m_oAllArg);
         if (l_nCode != 0){
	        m_bRunning=false;
        }
	}
	else
	{
		m_bRunning=false;	
	}
	pthread_attr_destroy(&tAttr);
#else
	DWORD idDFThread = 0;
	m_hThreadHandle = CreateThread(NULL,0, CDFThread::EntryPoint, (LPVOID)&m_oAllArg,0,&idDFThread );
    if (m_hThreadHandle == NULL){
	    m_bRunning=false;
    }
#endif    
	return l_nCode;
}

#ifndef WIN32
void* CDFThread::EntryPoint(void * l_pAllArg)
#else
DWORD WINAPI CDFThread::EntryPoint(void * l_pAllArg)
#endif
{
	AllArg *p = (AllArg*)l_pAllArg;
	CDFThread * l_pThisDFThread = (CDFThread*)(p->m_pThis);
	l_pThisDFThread->Run();
	return NULL;
}

void CDFThread::InitThread(void* l_pArg)
{
	m_oAllArg.m_pArg = l_pArg;
}

int CDFThread::PostThreadMessage(CDFThread *pThread, int nMsg, char* pchContent,int nSize, bool bHighPriority)
{
	return pThread->m_oMsgQueue.SendMsg(nMsg,pchContent,nSize, bHighPriority);
}      

int CDFThread::PostThreadMessage(CDFThread *pThread, int nMsg, bool bHighPriority)
{
	return pThread->m_oMsgQueue.SendMsg(nMsg,NULL,0, bHighPriority);
}      

int CDFThread::PreTranslateMessage(int &nMsg,char* pchContent,int &nSize)
{
	int nResult=m_oMsgQueue.RecvMsg(nMsg, pchContent, nSize);
	if (nResult!=-1&&nMsg == MSG_THREAD_EXIT)
	{
		OnDFThreadExit();
		m_bRunning=false;
		m_oMsgQueue.Destroy();
		CDFThread::Exit();
	}
	return nResult;
}

void CDFThread::SetObjectName(const char* csName)
{
	int l_nLen = strlen(csName);		
	memcpy(m_csObjectName,csName,l_nLen);
	m_csObjectName[l_nLen]='\0';
}

void CDFThread::OnDFThreadExit()
{
    	
}

int CDFThread::PostQuitMessage(CDFThread *pDFThread, bool bHighPriority)
{
	return pDFThread->m_oMsgQueue.SendMsg(MSG_THREAD_EXIT, NULL, 0, bHighPriority);
}

bool CDFThread::IsRunning()
{
	return m_bRunning;
}

#ifndef WIN32
int CDFThread::SetThreadAttr(pthread_attr_t* pAttr, unsigned stack_size)
{	
	int rc;
	int ret = 0;

	rc = pthread_attr_init(pAttr);
	if (rc != 0) {
		return -1;
	}

	rc = pthread_attr_setscope(pAttr, PTHREAD_SCOPE_SYSTEM);
	if (rc != 0) {
		ret = -1;
		goto _SetDFThreadAttrExit;
	}

#ifdef HPUX
	/* HPUX default stack size is 64KB --> need to increase to a usable size */
	if (stack_size < 1024000) stack_size = 1024000;
#endif /* HPUX */

	if (stack_size > 0) {
		rc = pthread_attr_setstacksize(pAttr, stack_size);
		if (rc != 0) {
			ret = -1;
			goto _SetDFThreadAttrExit;
		}
	}

	return ret;

_SetDFThreadAttrExit:

	rc = pthread_attr_destroy(pAttr);
	if (rc != 0) {
	}

	return ret;  
}
#endif

void CDFThread::Exit()
{
#ifndef WIN32
		pthread_cancel(m_hThreadHandle);		
#else
		ExitThread(0);
#endif
}
