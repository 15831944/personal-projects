//////////////////////////////////////////////////////////////////////
// CDFMsgQueue.cpp: implementation of the CDFMsgQueue class.
//
//  Created by Duong Dinh Cuong on 4/25/12.
//  Copyright (c) 2012 Fsoft - G10. All rights reserved.
//
//////////////////////////////////////////////////////////////////////

#include "CDFMsgQueue.h"
#include "string.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CDFMsgQueue::CDFMsgQueue()
{
	m_bCreated=false;
	m_pFirst=NULL;
	m_pLast=NULL;
	m_nCount=0;
}

CDFMsgQueue::~CDFMsgQueue()
{

}

int CDFMsgQueue::Create()
{
	m_pFirst=NULL;
	m_pLast=NULL;
#ifndef WIN32
	pthread_mutex_init(&m_Mutex,NULL);
#else
	InitializeCriticalSection(&m_Mutex);
#endif
	m_bCreated=true;
	return 0;
}

void CDFMsgQueue::Destroy()
{
	m_bCreated=false;
	MUTEX_LOCK(m_Mutex);	
	while(m_pFirst!=NULL)
	{
		MSG_QUEUE_ITEM *pTmp=m_pFirst;		
		m_pFirst=m_pFirst->pNext;
		delete pTmp->pData;
		delete pTmp;
	}
	m_pFirst=NULL;
	m_pLast=NULL;
	MUTEX_UNLOCK(m_Mutex);

#ifndef WIN32
    pthread_mutex_destroy(&m_Mutex);
#else
	DeleteCriticalSection(&m_Mutex);
#endif 
}

int CDFMsgQueue::SendMsg(int nMsg, void *pData, int nSize, bool bHighPriority)
{
	MUTEX_LOCK(m_Mutex);
	if(!m_bCreated)
	{
		MUTEX_UNLOCK(m_Mutex);
		return -1;
	}
	MSG_QUEUE_ITEM *pNewItem=new MSG_QUEUE_ITEM;
	pNewItem->nMsg=nMsg;
	pNewItem->nSize=nSize;
	if(nSize>0)
	{
		m_nCount++;
		pNewItem->pData=new char[nSize];
		memcpy(pNewItem->pData,pData,nSize);
	}
	else
	{
		pNewItem->pData=NULL;
	}
	
	pNewItem->pNext=NULL;	
	
	if(!bHighPriority)
	{
		if(m_pLast==NULL)
		{
			m_pLast=pNewItem;
			m_pFirst=m_pLast;
		}
		else
		{
			m_pLast->pNext=pNewItem;
			m_pLast=pNewItem;
		}
	}
	else 
	{
		if(m_pLast==NULL)
		{
			m_pLast=pNewItem;
			m_pFirst=m_pLast;
		}
		else
		{
			pNewItem->pNext=m_pFirst;
			m_pFirst=pNewItem;
		}
	}
	MUTEX_UNLOCK(m_Mutex);
	return 0;
}

int CDFMsgQueue::RecvMsg(int &nMsg, void *pData, int &nSize)
{
	MUTEX_LOCK(m_Mutex);
	if(!m_bCreated)
	{
		MUTEX_UNLOCK(m_Mutex);
		return -1;
	}
	if(m_pFirst==NULL)
	{
		MUTEX_UNLOCK(m_Mutex);
		return -1;
	}
	nMsg=m_pFirst->nMsg;
	nSize=m_pFirst->nSize;
	if(nSize > 0)
	{
		--m_nCount;
		memcpy(pData, m_pFirst->pData,nSize);
	}
	MSG_QUEUE_ITEM *pTmp=m_pFirst;
	m_pFirst=m_pFirst->pNext;
	if(m_pFirst==NULL)
		m_pLast=NULL;
	if(pTmp->nSize>0)
		delete pTmp->pData;
	delete pTmp;
	MUTEX_UNLOCK(m_Mutex);
	return 0;
}

bool CDFMsgQueue::IsCreate()
{
	return m_bCreated;
}


int CDFMsgQueue::GetSize()
{
	return m_nCount;
}

int CDFMsgQueue::GetFirstMsg(MSG_QUEUE_ITEM **pNext,int &nMsg, void **pData, int &nSize)
{
 	MUTEX_LOCK(m_Mutex);
 	if(!m_bCreated)
 	{
 		MUTEX_UNLOCK(m_Mutex);
 		return -1;
 	}
 	if(m_pFirst==NULL)
 	{
 		MUTEX_UNLOCK(m_Mutex);
 		return -1;
 	}
 	nMsg=m_pFirst->nMsg;
 	nSize=m_pFirst->nSize;
 	if(nSize>0)
 	{	
 		(*pData) = m_pFirst->pData;
 		*pNext = m_pFirst->pNext;
 	}	
 	
 	MUTEX_UNLOCK(m_Mutex);
 	return 0;
}

int CDFMsgQueue::GetNextMsg(MSG_QUEUE_ITEM **pNext, int &nMsg, void **pData, int &nSize)
{
	MUTEX_LOCK(m_Mutex);
	if(!m_bCreated)
	{
		MUTEX_UNLOCK(m_Mutex);
		return -1;
	}
	if(pNext==NULL)
	{
		MUTEX_UNLOCK(m_Mutex);
		return -1;
	}

	nMsg=(*pNext)->nMsg;
	nSize=(*pNext)->nSize;
	if(nSize>0)
	{	
		(*pData) = (*pNext)->pData;
		*pNext = (*pNext)->pNext;
	}	
	
	MUTEX_UNLOCK(m_Mutex);
	return 0;
}

