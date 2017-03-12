// CodeVisionAVR C Compiler
// (C) 1998-2002 Pavel Haiduc, HP InfoTech S.R.L.
// I/O registers definitions for the ATmega8515(L)
#pragma used+
sfrb OSCCAL=4;
sfrb PINE=5;
sfrb DDRE=6;
sfrb PORTE=7;
sfrb ACSR=8;
sfrb UBRRL=9;
sfrb UCSRB=0xa;
sfrb UCSRA=0xb;
sfrb UDR=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb PINA=0x19;
sfrb DDRA=0x1a;
sfrb PORTA=0x1b;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   // 16 bit access
sfrb UBRRH=0x20;
sfrb UCSRC=0x20;
sfrb WDTCR=0x21;
sfrb ICR1L=0x24;
sfrb ICR1H=0x25;
sfrw ICR1=0x24;   // 16 bit access
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  // 16 bit access
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  // 16 bit access
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  // 16 bit access
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb SFIOR=0x30;
sfrb OCR0=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb EMCUCR=0x36;
sfrb SPMCR=0x37;
sfrb TIFR=0x38;
sfrb TIMSK=0x39;
sfrb GIFR=0x3a;
sfrb GICR=0x3b;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-
// Interrupt vectors definitions
// CodeVisionAVR C Compiler
// (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.
#pragma used+
void delay_us(unsigned int n);
void delay_ms(unsigned int n);
#pragma used-
// CodeVisionAVR C Compiler
// (C) 1998-2006 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for standard I/O functions
// CodeVisionAVR C Compiler
// (C) 1998-2002 Pavel Haiduc, HP InfoTech S.R.L.
// Variable length argument list macros
typedef char *va_list;
#pragma used+
char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
char *gets(char *str,unsigned int len);
void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);
                                               #pragma used-
#pragma library stdio.lib
// CodeVisionAVR C Compiler
// (C) 1998-2005 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for string functions
#pragma used+
char *strcat(char *str1,char *str2);
char *strcatf(char *str1,char flash *str2);
char *strchr(char *str,char c);
signed char strcmp(char *str1,char *str2);
signed char strcmpf(char *str1,char flash *str2);
char *strcpy(char *dest,char *src);
char *strcpyf(char *dest,char flash *src);
unsigned char strcspn(char *str,char *set);
unsigned char strcspnf(char *str,char flash *set);
unsigned int strlenf(char flash *str);
char *strncat(char *str1,char *str2,unsigned char n);
char *strncatf(char *str1,char flash *str2,unsigned char n);
signed char strncmp(char *str1,char *str2,unsigned char n);
signed char strncmpf(char *str1,char flash *str2,unsigned char n);
char *strncpy(char *dest,char *src,unsigned char n);
char *strncpyf(char *dest,char flash *src,unsigned char n);
char *strpbrk(char *str,char *set);
char *strpbrkf(char *str,char flash *set);
signed char strpos(char *str,char c);
char *strrchr(char *str,char c);
char *strrpbrk(char *str,char *set);
char *strrpbrkf(char *str,char flash *set);
signed char strrpos(char *str,char c);
char *strstr(char *str1,char *str2);
char *strstrf(char *str1,char flash *str2);
unsigned char strspn(char *str,char *set);
unsigned char strspnf(char *str,char flash *set);
char *strtok(char *str1,char flash *str2);
 unsigned int strlen(char *str);
void *memccpy(void *dest,void *src,char c,unsigned n);
void *memchr(void *buf,unsigned char c,unsigned n);
signed char memcmp(void *buf1,void *buf2,unsigned n);
signed char memcmpf(void *buf1,void flash *buf2,unsigned n);
void *memcpy(void *dest,void *src,unsigned n);
void *memcpyf(void *dest,void flash *src,unsigned n);
void *memmove(void *dest,void *src,unsigned n);
void *memset(void *buf,unsigned char c,unsigned n);
#pragma used-
#pragma library string.lib
/*
  CodeVisionAVR C Compiler
  (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.

  Prototypes for I2C bus master functions

  BEFORE #include -ING THIS FILE YOU
  MUST DECLARE THE I/O ADDRESS OF THE
  DATA REGISTER OF THE PORT AT WHICH
  THE I2C BUS IS CONNECTED AND
  THE DATA BITS USED FOR SDA & SCL

  EXAMPLE FOR PORTB:

    #asm
        .equ __i2c_port=0x18
        .equ __sda_bit=3
        .equ __scl_bit=4
    #endasm
    #include <i2c.h>
*/
#pragma used+
void i2c_init(void);
unsigned char i2c_start(void);
void i2c_stop(void);
unsigned char i2c_read(unsigned char ack);
unsigned char i2c_write(unsigned char data);
#pragma used-
/***************************************************************/
                                               /**************************************************************/
/* serial flags definition                                    */  
/**************************************************************/
// USART Receiver buffer
/**************************************************************/
/* IO port definition                                         */  
/**************************************************************/
       /**************************************************************/
/* matrix size const definition                               */  
/**************************************************************/
//#define     ENABLE_MASK_ROW     0xF0
                                                                                                                                                                    /**************************************************************/
/* serial message const definition                            */  
/**************************************************************/
                                                                                         /***************************************************************/
/***************************************************************/
const long int TK21[] ={
	0x46c960, 0x2ed954, 0x54d4a0, 0x3eda50, 0x2a7552, 0x4e56a0, 0x38a7a7, 0x5ea5d0, 0x4a92b0, 0x32aab5,
	0x58a950, 0x42b4a0, 0x2cbaa4, 0x50ad50, 0x3c55d9, 0x624ba0, 0x4ca5b0, 0x375176, 0x5c5270, 0x466930,
	0x307934, 0x546aa0, 0x3ead50, 0x2a5b52, 0x504b60, 0x38a6e6, 0x5ea4e0, 0x48d260, 0x32ea65, 0x56d520,
	0x40daa0, 0x2d56a3, 0x5256d0, 0x3c4afb, 0x6249d0, 0x4ca4d0, 0x37d0b6, 0x5ab250, 0x44b520, 0x2edd25,
	0x54b5a0, 0x3e55d0, 0x2a55b2, 0x5049b0, 0x3aa577, 0x5ea4b0, 0x48aa50, 0x33b255, 0x586d20, 0x40ad60,
	0x2d4b63, 0x525370, 0x3e49e8, 0x60c970, 0x4c54b0, 0x3768a6, 0x5ada50, 0x445aa0, 0x2fa6a4, 0x54aad0,
	0x4052e0, 0x28d2e3, 0x4ec950, 0x38d557, 0x5ed4a0, 0x46d950, 0x325d55, 0x5856a0, 0x42a6d0, 0x2c55d4,
	0x5252b0, 0x3ca9b8, 0x62a930, 0x4ab490, 0x34b6a6, 0x5aad50, 0x4655a0, 0x2eab64, 0x54a570, 0x4052b0,
	0x2ab173, 0x4e6930, 0x386b37, 0x5e6aa0, 0x48ad50, 0x332ad5, 0x582b60, 0x42a570, 0x2e52e4, 0x50d160,
	0x3ae958, 0x60d520, 0x4ada90, 0x355aa6, 0x5a56d0, 0x462ae0, 0x30a9d4, 0x54a2d0, 0x3ed150, 0x28e952
}; /* Years 2000-2099 */
//char CAN[10][10] = {"Giap", "At", "Binh", "Dinh", "Mau", "Ky", "Canh", "Tan", "Nham", "Quy"};
//char CHI[12][10] = {"Ty'", "Suu", "Dan", "Mao", "Thin", "Ty.", "Ngo", "Mui", "Than", "Dau", "Tuat", "Hoi"};
//char TUAN[7][10] = {"Chu Nhat", "Thu Hai", "Thu Ba", "Thu Tu", "Thu Nam", "Thu Sau", "Thu Bay"};
typedef struct _LunarDate{
    unsigned char      day;
    unsigned char      month;
    unsigned int year;
    unsigned char      leap;
    long int jd; 
} LUNAR_DATE;
              LUNAR_DATE ld;
LUNAR_DATE ly[14];
long int jdn(int dd, int mm, int yy) {
	int a=0, y=0, m=0;
	a = ((14 - mm) / 12);
	y = yy+4800-a;
	m = mm+12*a-3;	
	return (long int)((153*m+2)/5  + 365*y - (y/100) - 32045 + dd + (y/4)  + (y/400));
}
void decodeLunarYear(int yy, long int k) {	
	int regularMonths[12];
	int monthLengths[2]={29,30};
	long int offsetOfTet=0,currentJD=0,solarNY=0;
	int leapMonth=0,leapMonthLength=0;
	int i=0, j=0,mm=0;
	offsetOfTet = k >> 17;
	leapMonth = k & 0xf;
	leapMonthLength = monthLengths[k >> 16 & 0x1];
	solarNY = jdn(1, 1, yy);
	currentJD = (long int)(solarNY+offsetOfTet);
	j = k >> 4;
	for(i = 0; i < 12; i++) {
		regularMonths[12 - i - 1] = monthLengths[j & 0x1];
		j >>= 1;
	}
	if (leapMonth == 0) {
		for(mm = 1; mm <= 12; mm++) {
			ly[mm].day = 1;
			ly[mm].month = mm;
			ly[mm].year = yy;
			ly[mm].leap = 0;
			ly[mm].jd = currentJD;
			currentJD += regularMonths[mm-1];
		}
	} else {
		for(mm = 1; mm <= leapMonth; mm++) {
			ly[mm].day = 1;
			ly[mm].month = mm;
			ly[mm].year = yy;
			ly[mm].leap = 0;
			ly[mm].jd = currentJD;
			currentJD += regularMonths[mm-1];
		}		
		ly[mm].day = 1;
			ly[mm].month = leapMonth;
			ly[mm].year = yy;
			ly[mm].leap = 0;
			ly[mm].jd = currentJD;
		currentJD += leapMonthLength;
		for(mm = leapMonth+2; mm <= 13; mm++) {
			ly[mm].day = 1;
			ly[mm].month = mm-1;
			ly[mm].year = yy;
			ly[mm].leap = 0;
			ly[mm].jd = currentJD;
			currentJD += regularMonths[mm-2];
		}
	}	
}
void getYearInfo(int yyyy) {
	long int yearCode = 0;
	yearCode = TK21[yyyy - 2000];
	decodeLunarYear(yyyy, yearCode);
}
void getLunarDate(int dd, int mm, int yyyy) {
	int i =13;
	long int jd =0;	
	getYearInfo(yyyy);
	jd = jdn(dd, mm, yyyy);
	if (jd < ly[1].jd) {
		getYearInfo(yyyy - 1);
	}	
	if (ly[13].jd==0) i=12;
	while (jd < ly[i].jd) {
		i--;
	}	
	ld.day = ly[i].day + jd - ly[i].jd;	
	ld.month = ly[i].month;
	ld.year = ly[i].year;
	ld.leap = ly[i].leap;
	ld.jd = jd;
}
void getLunarStr(char* sz, short h, short m, short dd, short mm, int yyyy){	
	getLunarDate(dd, mm, yyyy);	
		sprintf(sz,"B©y giê lµ %02d:%02d ngµy %d/%d/%d (%d/%d ¢m lÞch)",	            
                h,m,dd,mm,yyyy,
                ld.day,ld.month);
             /*	sprintf(sz,"%s %s,%s,%s",
	    TUAN[(ld[4] + 1)%7],
	    CAN[(ld[4] + 9)%10],CHI[(ld[4]+1)%12],
	    CAN[(ld[2]*12+ld[1]+3)%10],CHI[(ld[1]+1)%12],
	    CAN[(ld[2]+6)%10],CHI[(ld[2]+8)%12]);
*/	    
}
