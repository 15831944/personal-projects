#ifndef _LED_DATA_H

#define _LED_DATA_H


typedef unsigned short	UByte8;
typedef unsigned int	UWord16;

struct _strLEDDataStruct {
   UWord16 ubNumOfRow;
   UWord16 ubNumOfCol;
   UWord16 ubNumOfPage;   
} ;

typedef struct _strLEDDataStruct LEDDataStruct;

#define GPI_INIT_BITMAP(name, ubNumOfRow, ubNumOfCol, ubNumOfPage) \
	const LEDDataStruct* name = (LEDDataStruct*) &_##name##Buffer; \
	const UWord16 _##name##Buffer[(ubNumOfRow*(1 + sizeof(UWord16))*ubNumOfPage + 3*sizeof(UByte8))] 

#define GPI_DECLARE_BITMAP(name) \
	extern UWord16 _##name##Buffer[]; \
	extern LEDDataStruct* name;

GPI_DECLARE_BITMAP(LEDChanel)


#endif //_LED_DATA_H