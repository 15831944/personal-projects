// MD5.h: interface for the CMD5 class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_MD5_H__AAD48264_9044_4E6D_8FC5_73B68F2747E5__INCLUDED_)
#define AFX_MD5_H__AAD48264_9044_4E6D_8FC5_73B68F2747E5__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

typedef struct _structMD5_STATE 
{
    DWORD count[2];		/* message length in bits, lsw first */
    DWORD abcd[4];		/* digest buffer */
    BYTE buf[64];		/* accumulate block */

} MD5_STATE;

class CMD5  
{
public:		
	static void MD5(const BYTE* data, int len, BYTE digest[16]);
	CMD5();
	virtual ~CMD5();

private:
	static MD5_STATE* pms;
	static void Init();
	static void Finish(BYTE digest[16]);
	static void Append(const BYTE* data, int nbytes );	
	static void Process(const BYTE *data);
};

#endif // !defined(AFX_MD5_H__AAD48264_9044_4E6D_8FC5_73B68F2747E5__INCLUDED_)
