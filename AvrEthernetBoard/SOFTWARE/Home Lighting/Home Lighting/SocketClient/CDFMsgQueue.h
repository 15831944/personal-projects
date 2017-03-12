//  ---------------------------------------------------------
//  Copyright (c) Neopost Inc., 2012. All rights reserved.   
//  ---------------------------------------------------------
//  Domain     -    IDFNetworks
//  Version    -    0.1
//  ---------------------------------------------------------
//  File Name  -    CDFMsgQueue.h
//  Initiated  -    Neopost OSDC, FPT Software, G10-iOS Team.
//  Change History: 
//      - [06/25/2012][iOS Hanoi]: Creation.
//      - [Date][Author]: [Reason to modify]
//  ---------------------------------------------------------



#ifndef __DF_MSGQUEUE__H__
#define __DF_MSGQUEUE__H__
#ifndef WIN32
#include <pthread.h>
#define	H_MUTEX		pthread_mutex_t
#else
#include <windows.h>
#define	H_MUTEX		CRITICAL_SECTION	
#endif

#ifndef WIN32
#define		MUTEX_LOCK(m)   pthread_mutex_lock(&m)
#define		MUTEX_UNLOCK(m) pthread_mutex_unlock(&m)
#define		INIT_MUTEX(m)   pthread_mutex_init(&m,NULL)
#define		EXIT_MUTEX(m)   pthread_mutex_exit(&m,NULL)
#else
#define		MUTEX_LOCK(m)   EnterCriticalSection(&m)
#define		MUTEX_UNLOCK(m) LeaveCriticalSection(&m)
#define		INIT_MUTEX(m)   InitializeCriticalSection(&m);
#define		EXIT_MUTEX(m)   DeleteCriticalSection(&m);
#endif

typedef struct tagMsgQueueItem
{
	int nMsg;
	int nSize;
	char *pData;
	tagMsgQueueItem *pNext;	
}MSG_QUEUE_ITEM;

class CDFMsgQueue  
{
public:
	int GetFirstMsg(MSG_QUEUE_ITEM **pNext,int &nMsg, void **pData, int &nSize);
	int GetNextMsg(MSG_QUEUE_ITEM **pNext,int &nMsg, void **pData, int &nSize);
	int GetSize();
	bool IsCreate();
	int RecvMsg(int &nMsg, void *pData, int &nSize);
	int SendMsg(int nMsg, void* pData, int nSize, bool bHighPriority=false);
	void Destroy();
	int Create();
	CDFMsgQueue();
	virtual ~CDFMsgQueue();
	MSG_QUEUE_ITEM *m_pFirst;
	MSG_QUEUE_ITEM *m_pLast;
	H_MUTEX m_Mutex;
	bool m_bCreated;
protected:
	int m_nCount;
};

#endif