// PCBFileFormat.cpp : implementation file
//

#include "stdafx.h"
#include "ADProLED.h"
#include "PCBFileFormat.h"

// CPCBFileFormat

IMPLEMENT_DYNAMIC(CPCBFileFormat, CWnd)

CPCBFileFormat::CPCBFileFormat()
{

}

CPCBFileFormat::~CPCBFileFormat()
{
}


BEGIN_MESSAGE_MAP(CPCBFileFormat, CWnd)
END_MESSAGE_MAP()

// CPCBFileFormat message handlers

int CPCBFileFormat::GetTemplate(void)
{
	int result =0;
	try {
		while (_arrHLED.GetSize() >0){
			CHLED* pLED = _arrHLED.GetAt(0);
			FILE* file = NULL;
			FILE* fexp = NULL;
			errno_t err = fopen_s(&file,"..//HLED.TXT","rb");
			errno_t exp = fopen_s(&fexp,"..//HLED.PCB.TXT","a+");
			if (file != NULL){
				char* szBuff=NULL;
				szBuff = new char[1024];
				size_t nRead = fread(szBuff,size_t(1),size_t(1024),file);
				szBuff[nRead] = '\r';
				szBuff[nRead+1] = '\n';
				szBuff[nRead+2] = '\0';				
				for (size_t i=0; i< nRead; i++){
					char szTemp[20];
					sscanf_s(szBuff,"%s",szTemp,20);
					if (strcmp((const char*)szTemp,"XXXXXXXXXX")==0){						
						sprintf_s(szTemp,"%10.0f",pLED->m_nXCenter,10);
						memcpy_s(szBuff+1,10,szTemp,10);
					}
					else if (strcmp((const char*)szTemp,"YYYYYYYYYY")==0){											
						sprintf_s(szTemp,"%10.0f",pLED->m_nYCenter,10);
						memcpy_s(szBuff+1,10,szTemp,10);
					}
					else if (strcmp((const char*)szTemp,"X1X1X1X1X1")==0){									
						sprintf_s(szTemp,"%10.0f",pLED->m_nXPadA,10);
						memcpy_s(szBuff+1,10,szTemp,10);
					}
					else if (strcmp((const char*)szTemp,"Y1Y1Y1Y1Y1")==0){					
						sprintf_s(szTemp,"%10.0f",pLED->m_nYPadA,10);
						memcpy_s(szBuff+1,10,szTemp,10);
					}
					else if (strcmp((const char*)szTemp,"X2X2X2X2X2")==0){					
						sprintf_s(szTemp,"%10.0f",pLED->m_nXPadK,10);
						memcpy_s(szBuff+1,10,szTemp,10);
					}
					else if (strcmp((const char*)szTemp,"Y2Y2Y2Y2Y2")==0){					
						sprintf_s(szTemp,"%10.0f",pLED->m_nYPadK,10);
						memcpy_s(szBuff+1,10,szTemp,10);
					}
					else{
						
					}
					szBuff++;
				}
				szBuff -= nRead;
				fseek(fexp,0,SEEK_SET);
				fprintf_s(fexp,"%s\r\n",szBuff,MAX_PATH);
				delete[] szBuff;
				
				fclose(file);
				fclose(fexp);				
			}			
			_arrHLED.RemoveAt(0);
			delete pLED;	
		}
	}
	catch (CFileException* e){
		TCHAR szError[MAX_PATH];
		e->GetErrorMessage(szError,MAX_PATH);
		MessageBox(szError,_T("GetTemplate"));
		result = -1;
	}
	catch (CMemoryException* e){
		TCHAR szError[MAX_PATH];
		e->GetErrorMessage(szError,MAX_PATH);
		MessageBox(szError,_T("GetTemplate"));
		result = -2;
	}
	catch (CException* e){
		result = -3;
		throw e;
	}

	return result;
}
