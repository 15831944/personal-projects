;CodeVisionAVR C Compiler V1.24.7e Standard
;(C) Copyright 1998-2005 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega162
;Program type           : Application
;Clock frequency        : 16.000000 MHz
;Memory model           : Small
;Optimize for           : Speed
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 100 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : Yes
;Word align FLASH struct: No
;Enhanced core instructions    : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega162
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCSR=0x34
	.EQU MCUCR=0x35
	.EQU EMCUCR=0x36
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x20

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOV  R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOV  R30,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "main.vec"
	.INCLUDE "main.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30
	OUT  EMCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x400)
	LDI  R25,HIGH(0x400)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x4FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x4FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x164)
	LDI  R29,HIGH(0x164)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x164
;       1 /*****************************************************
;       2 This program was produced by the
;       3 CodeWizardAVR V1.24.6 Professional
;       4 Automatic Program Generator
;       5 © Copyright 1998-2005 Pavel Haiduc, HP InfoTech s.r.l.
;       6 http://www.hpinfotech.com
;       7 e-mail:office@hpinfotech.com
;       8 
;       9 Project : 
;      10 Version : 
;      11 Date    : 11/10/2005
;      12 Author  : CUONGDD                            
;      13 Company : 3iGROUP                           
;      14 Comments: 
;      15 
;      16 
;      17 Chip type           : ATmega16/162/8515
;      18 Program type        : Application
;      19 Clock frequency     : 8.000000 MHz
;      20 Memory model        : Small
;      21 External SRAM size  : 0
;      22 Data Stack size     : 256
;      23 *****************************************************/
;      24 
;      25 #include "define.h"      
;      26 
;      27 // DS1307 Real Time Clock functions
;      28 #include <ds1307.h>
;      29                                       
;      30 // Declare your global variables here     
;      31 static PBYTE start_mem;
_start_mem_G1:
	.BYTE 0x2
;      32 static PBYTE end_mem;        
_end_mem_G1:
	.BYTE 0x2
;      33 static PBYTE buffer; 
_buffer_G1:
	.BYTE 0x2
;      34 static PBYTE bkgnd_mem;     
_bkgnd_mem_G1:
	.BYTE 0x2
;      35 static PBYTE org_mem;
_org_mem_G1:
	.BYTE 0x2
;      36 
;      37 bit is_show_bkgnd        = 0;
;      38 bit is_flipping_bk       = 0;
;      39 
;      40 register UINT count_row  = 0;
;      41 register UINT count_col  = 0;     
;      42 static BYTE frm_delay    = 0;
_frm_delay_G1:
	.BYTE 0x1
;      43 static BYTE shift_rate   = 0; 
_shift_rate_G1:
	.BYTE 0x1
;      44 static BYTE shift_step   = 0;     
_shift_step_G1:
	.BYTE 0x1
;      45 static BYTE sys_mode     = 0;    
_sys_mode_G1:
	.BYTE 0x1
;      46 
;      47 static UINT  tick_count  = 0;
_tick_count_G1:
	.BYTE 0x2
;      48 static UINT  count_shift = 0;       
_count_shift_G1:
	.BYTE 0x2
;      49 static UINT  char_count  = 0;
_char_count_G1:
	.BYTE 0x2
;      50 static UINT  text_length = 0;
_text_length_G1:
	.BYTE 0x2
;      51 
;      52 static UINT  char_width[256];    
_char_width_G1:
	.BYTE 0x200
;      53 static UINT  columeH = 0;
_columeH_G1:
	.BYTE 0x2
;      54 static UINT  columeL = 0;
_columeL_G1:
	.BYTE 0x2
;      55 static UINT  char_index = 0;    
_char_index_G1:
	.BYTE 0x2
;      56 static UINT  next_char_width = 0;
_next_char_width_G1:
	.BYTE 0x2
;      57 static UINT  current_char_width = 0;  
_current_char_width_G1:
	.BYTE 0x2
;      58 
;      59 static char  szText[] = "-= 3iGROUP :: HTTP://WWW.3IHUT.NET =-";                    
_szText_G1:
	.BYTE 0x26
;      60 
;      61 #pragma warn-                      
;      62 eeprom BYTE _cfg_frm_delay =100;

	.ESEG
__cfg_frm_delay:
	.DB  0x64
;      63 eeprom BYTE _cfg_sys_mode =MODE_POWER;
__cfg_sys_mode:
	.DB  0x20
;      64 eeprom BYTE _cfg_shift_rate =20;
__cfg_shift_rate:
	.DB  0x14
;      65 eeprom BYTE _cfg_shift_step =1;
__cfg_shift_step:
	.DB  0x1
;      66 eeprom UINT _save_text_length =0;   
__save_text_length:
	.DW  0x0
;      67 eeprom UINT _save_char_width[250];       
__save_char_width:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;      68 #pragma warn+
;      69                                    
;      70 /************************************/
;      71 /* short delay with nop instruction */
;      72 /************************************/
;      73 /* Crys 16Mhz, 1 cycle = 0.0625 u_sec
;      74 /* total: 9 cycle = 0.5625 us per call
;      75 _delay_ex:
;      76 	LDS  R30,_frm_delay_G1  ; 2 cycles
;      77 	SUBI R30,LOW(1)         ; 1 cycle
;      78 	STS  _frm_delay_G1,R30  ; 2 cycles
;      79 	CPI  R30,0              ; 1 cycle
;      80 	BRNE _delay_ex	        ; 1 cycle
;      81 **************************************/
;      82 #define _delay_ex(x) {\
;      83     while(--x);\
;      84 }\
;      85 
;      86              
;      87 // Global variables for message control
;      88 BYTE  rx_message = UNKNOWN_MSG;
;      89 WORD  rx_wparam  = 0;
;      90 WORD  rx_lparam  = 0;
;      91 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;      92                             
;      93 extern void reset_serial();         
;      94 extern void send_echo_msg();    
;      95 extern BYTE eeprom_read(BYTE deviceID, WORD address);
;      96 extern void eeprom_write(BYTE deviceID, WORD address, BYTE data);
;      97 extern WORD eeprom_read_w(BYTE deviceID, WORD address);
;      98 extern void eeprom_write_w(BYTE deviceID, WORD address, WORD data);
;      99 extern void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;     100 extern void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;     101 
;     102 static void _displayFrame();
;     103 static void _doScroll();
;     104 ///////////////////////////////////////////////////////////////
;     105 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;     106 ///////////////////////////////////////////////////////////////
;     107 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;     108 {       

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     109     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     110     if (is_flipping_bk){
	SBRS R2,1
	RJMP _0x3
;     111         ++tick_count;
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	ADIW R30,1
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R31
;     112     }
;     113     count_shift++;
_0x3:
	LDS  R30,_count_shift_G1
	LDS  R31,_count_shift_G1+1
	ADIW R30,1
	STS  _count_shift_G1,R30
	STS  _count_shift_G1+1,R31
;     114 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;     115 
;     116 
;     117 ///////////////////////////////////////////////////////////////
;     118 // static function(s) for led matrix display panel
;     119 ///////////////////////////////////////////////////////////////
;     120 static void _setRow()
;     121 {
__setRow_G1:
;     122     BYTE i=0;      
;     123     for (i=0; i<8; i++){            
	ST   -Y,R16
;	i -> R16
	LDI  R16,0
	LDI  R16,LOW(0)
_0x5:
	CPI  R16,8
	BRSH _0x6
;     124         if (i==(7-count_row)) SCAN_DAT = ON;        
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	SUB  R30,R4
	SBC  R31,R5
	MOV  R26,R16
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x7
	CBI  0x12,5
;     125         else SCAN_DAT = OFF;        
	RJMP _0x8
_0x7:
	SBI  0x12,5
;     126         SCAN_CLK = 1;
_0x8:
	SBI  0x12,3
;     127         SCAN_CLK = 0;            
	CBI  0x12,3
;     128     }
	SUBI R16,-1
	RJMP _0x5
_0x6:
;     129 }
	RJMP _0xDF
;     130             
;     131 static void _powerOff()
;     132 {
__powerOff_G1:
;     133     BYTE i =0;               
;     134     SCAN_DAT = OFF;  // data scan low        
	ST   -Y,R16
;	i -> R16
	LDI  R16,0
	SBI  0x12,5
;     135     for (i=0; i< 8; i++)    
	LDI  R16,LOW(0)
_0xA:
	CPI  R16,8
	BRSH _0xB
;     136     {                                              
;     137         SCAN_CLK = 1;    // clock scan high
	SBI  0x12,3
;     138         SCAN_CLK = 0;    // clock scan low            
	CBI  0x12,3
;     139     }                                         
	SUBI R16,-1
	RJMP _0xA
_0xB:
;     140     SCAN_STB = 1;    // strobe scan high
	SBI  0x12,4
;     141     SCAN_STB = 0;    // strobe scan low                    
	CBI  0x12,4
;     142 }
_0xDF:
	LD   R16,Y+
	RET
;     143 
;     144 static void _displayFrame()
;     145 {                   
__displayFrame_G1:
;     146     count_col = 0;
	CLR  R6
	CLR  R7
;     147     count_row = 0;         
	CLR  R4
	CLR  R5
;     148          
;     149     columeL = current_char_width + (START_RAM_TEXT + SCREEN_WIDTH) - start_mem;
	LDS  R30,_current_char_width_G1
	LDS  R31,_current_char_width_G1+1
	SUBI R30,LOW(-3080)
	SBCI R31,HIGH(-3080)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	SUB  R30,R26
	SBC  R31,R27
	STS  _columeL_G1,R30
	STS  _columeL_G1+1,R31
;     150     columeH = next_char_width + (START_RAM_TEXT + SCREEN_WIDTH) - start_mem;         	                                           
	LDS  R30,_next_char_width_G1
	LDS  R31,_next_char_width_G1+1
	SUBI R30,LOW(-3080)
	SBCI R31,HIGH(-3080)
	SUB  R30,R26
	SBC  R31,R27
	STS  _columeH_G1,R30
	STS  _columeH_G1+1,R31
;     151 
;     152     // display one frame in the screen at the specific time 
;     153     for (buffer = start_mem;buffer < (END_RAM); buffer++)  
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
_0xD:
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	CPI  R26,LOW(0x8000)
	LDI  R30,HIGH(0x8000)
	CPC  R27,R30
	BRLO PC+3
	JMP _0xE
;     154     {                     
;     155     #ifdef __FLYING_TEXT_
;     156         if (current_char_width < SCREEN_WIDTH)
	LDS  R26,_current_char_width_G1
	LDS  R27,_current_char_width_G1+1
	CPI  R26,LOW(0xC8)
	LDI  R30,HIGH(0xC8)
	CPC  R27,R30
	BRLO PC+3
	JMP _0xF
;     157 		{                                  		        
;     158 			if (count_col < current_char_width){				
	LDS  R30,_current_char_width_G1
	LDS  R31,_current_char_width_G1+1
	CP   R6,R30
	CPC  R7,R31
	BRSH _0x10
;     159 				if (is_show_bkgnd){
	SBRS R2,0
	RJMP _0x11
;     160                     DATA_PORT = org_mem[count_row*DATA_LENGTH + SCREEN_WIDTH + count_col]&
;     161                             (bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);	
	MOVW R26,R4
	LDI  R30,LOW(3736)
	LDI  R31,HIGH(3736)
	CALL __MULW12U
	SUBI R30,LOW(-200)
	SBCI R31,HIGH(-200)
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_org_mem_G1
	LDS  R27,_org_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R24,X
	MOVW R30,R4
	LDI  R26,LOW(200)
	LDI  R27,HIGH(200)
	CALL __MULW12U
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_bkgnd_mem_G1
	LDS  R27,_bkgnd_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	AND  R30,R24
	RJMP _0xE0
;     162                 }                               
;     163                 else{
_0x11:
;     164                     DATA_PORT = org_mem[count_row*DATA_LENGTH + SCREEN_WIDTH + count_col];
	MOVW R26,R4
	LDI  R30,LOW(3736)
	LDI  R31,HIGH(3736)
	CALL __MULW12U
	SUBI R30,LOW(-200)
	SBCI R31,HIGH(-200)
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_org_mem_G1
	LDS  R27,_org_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
_0xE0:
	OUT  0x18,R30
;     165                 }
;     166 			}
;     167 			else if ((count_col > columeL) && (count_col < columeH)){				
	RJMP _0x13
_0x10:
	LDS  R30,_columeL_G1
	LDS  R31,_columeL_G1+1
	CP   R30,R6
	CPC  R31,R7
	BRSH _0x15
	LDS  R30,_columeH_G1
	LDS  R31,_columeH_G1+1
	CP   R6,R30
	CPC  R7,R31
	BRLO _0x16
_0x15:
	RJMP _0x14
_0x16:
;     168 				if (is_show_bkgnd){
	SBRS R2,0
	RJMP _0x17
;     169 				    DATA_PORT = (*buffer)&(bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);								
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	LD   R24,X
	MOVW R30,R4
	LDI  R26,LOW(200)
	LDI  R27,HIGH(200)
	CALL __MULW12U
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_bkgnd_mem_G1
	LDS  R27,_bkgnd_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	AND  R30,R24
	RJMP _0xE1
;     170 				}                                                    
;     171 				else{
_0x17:
;     172 				    DATA_PORT = (*buffer);
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	LD   R30,X
_0xE1:
	OUT  0x18,R30
;     173 				}
;     174 			}
;     175 			else{                  
	RJMP _0x19
_0x14:
;     176 			    if (is_show_bkgnd){
	SBRS R2,0
	RJMP _0x1A
;     177     	    		DATA_PORT = (bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);                				
	MOVW R30,R4
	LDI  R26,LOW(200)
	LDI  R27,HIGH(200)
	CALL __MULW12U
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_bkgnd_mem_G1
	LDS  R27,_bkgnd_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	RJMP _0xE2
;     178     	        }
;     179     	        else{
_0x1A:
;     180     	            DATA_PORT = 0xFF;
	LDI  R30,LOW(255)
_0xE2:
	OUT  0x18,R30
;     181     	        }
;     182 			}                                                               			
_0x19:
_0x13:
;     183         #ifdef ENABLE_MASK_ROW  
;     184             DATA_PORT |= ENABLE_MASK_ROW;
	IN   R30,0x18
	ORI  R30,LOW(0xF0)
	RJMP _0xE3
;     185         #endif //ENABLE_MASK_ROW
;     186         }
;     187         else		 
_0xF:
;     188    #endif
;     189    	    {  
;     190    	        if (is_show_bkgnd){           
	SBRS R2,0
	RJMP _0x1D
;     191                 DATA_PORT = (*buffer)&(bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	LD   R24,X
	MOVW R30,R4
	LDI  R26,LOW(200)
	LDI  R27,HIGH(200)
	CALL __MULW12U
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_bkgnd_mem_G1
	LDS  R27,_bkgnd_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	AND  R30,R24
	RJMP _0xE3
;     192             }
;     193             else{                    
_0x1D:
;     194                 DATA_PORT = (*buffer);
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	LD   R30,X
_0xE3:
	OUT  0x18,R30
;     195             }                         
;     196         }              
;     197 
;     198         DATA_CLK = 1;    // clock high
	SBI  0x7,2
;     199         DATA_CLK = 0;    // clock low   
	CBI  0x7,2
;     200         if ( ++count_col >= SCREEN_WIDTH)
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	CPI  R30,LOW(0xC8)
	LDI  R26,HIGH(0xC8)
	CPC  R31,R26
	BRLO _0x1F
;     201         {                                            
;     202             count_col = 0;      // reset for next            
	CLR  R6
	CLR  R7
;     203             
;     204 #ifndef __ANTI_SHADOW_
;     205             SCAN_CLK = 1;       // clock scan high
;     206             SCAN_CLK = 0;       // clock scan low
;     207                                                                           
;     208             SCAN_STB = 1;       // strobe scan high
;     209             DATA_STB = 1;       // strobe high            
;     210             SCAN_STB = 0;       // strobe scan low
;     211             DATA_STB = 0;       // strobe low                        
;     212                 
;     213             SCAN_DAT = OFF;     // data scan low            
;     214 #else                      
;     215                                                                                                
;     216             _powerOff();        // turn all led off            
	CALL __powerOff_G1
;     217             _setRow();          // turn row-led on
	CALL __setRow_G1
;     218                                                               
;     219             SCAN_STB = 1;       // strobe high            
	SBI  0x12,4
;     220             SCAN_STB = 0;       // strobe low        
	CBI  0x12,4
;     221             DATA_STB = 1;       // strobe high            
	SBI  0x7,0
;     222             DATA_STB = 0;       // strobe low            
	CBI  0x7,0
;     223                         
;     224 #endif          
;     225             if (++count_row >= 8)
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	SBIW R30,8
	BRLO _0x20
;     226             { 
;     227                 count_row = 0;
	CLR  R4
	CLR  R5
;     228             #ifndef __ANTI_SHADOW_       
;     229                 SCAN_DAT = ON;                
;     230                 if ((sys_mode&MODE_POWER)==0){
;     231                     SCAN_DAT = OFF;                                
;     232                 }                    
;     233             #endif
;     234             }                                                                 
;     235                         
;     236             buffer += (DATA_LENGTH - SCREEN_WIDTH);                 
_0x20:
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	SUBI R30,LOW(-3536)
	SBCI R31,HIGH(-3536)
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
;     237         }           
;     238     }                         	
_0x1F:
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	ADIW R30,1
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
	RJMP _0xD
_0xE:
;     239 }     
	RET
;     240                                   
;     241 static void _doScroll()
;     242 {
__doScroll_G1:
;     243     // init state                         
;     244     DATA_STB = 0;
	CBI  0x7,0
;     245     DATA_CLK = 0;   
	CBI  0x7,2
;     246                         
;     247     // check power off state ...
;     248     if ((sys_mode & MODE_POWER)==0) {
	LDS  R30,_sys_mode_G1
	ANDI R30,LOW(0x20)
	BRNE _0x21
;     249         _powerOff();return;
	CALL __powerOff_G1
	RET
;     250     }
;     251     if ((sys_mode & MODE_STOP)==MODE_STOP) return;
_0x21:
	LDS  R30,_sys_mode_G1
	ANDI R30,LOW(0x10)
	CPI  R30,LOW(0x10)
	BRNE _0x22
	RET
;     252                         
;     253     // scroll left with shift_step bit(s)
;     254     if(count_shift >= shift_rate)
_0x22:
	LDS  R30,_shift_rate_G1
	LDS  R26,_count_shift_G1
	LDS  R27,_count_shift_G1+1
	LDI  R31,0
	CP   R26,R30
	CPC  R27,R31
	BRSH PC+3
	JMP _0x23
;     255     {                             
;     256         count_shift = 0;          
	LDI  R30,0
	STS  _count_shift_G1,R30
	STS  _count_shift_G1+1,R30
;     257     #ifdef __FLYING_TEXT_
;     258         if ((sys_mode&MASK_MODE)==FLYING_TEXT || (sys_mode&MASK_MODE)==ALL_IN_ONE)
	LDS  R30,_sys_mode_G1
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x1)
	BREQ _0x25
	LDS  R30,_sys_mode_G1
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0xF)
	BREQ _0x25
	RJMP _0x24
_0x25:
;     259         {
;     260             if (current_char_width >= SCREEN_WIDTH)
	LDS  R26,_current_char_width_G1
	LDS  R27,_current_char_width_G1+1
	CPI  R26,LOW(0xC8)
	LDI  R30,HIGH(0xC8)
	CPC  R27,R30
	BRLO _0x27
;     261     		{     		       
;     262 			   start_mem += shift_step;		
	LDS  R30,_shift_step_G1
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	RJMP _0xE4
;     263 	    	}
;     264 		    else
_0x27:
;     265 		    if (is_flipping_bk==0)
	SBRC R2,1
	RJMP _0x29
;     266 		    {
;     267 			    start_mem += (SCREEN_WIDTH/20);
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,10
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     268     			if (start_mem > (START_RAM_TEXT + SCREEN_WIDTH) - current_char_width)
	LDS  R26,_current_char_width_G1
	LDS  R27,_current_char_width_G1+1
	LDI  R30,LOW(3080)
	LDI  R31,HIGH(3080)
	SUB  R30,R26
	SBC  R31,R27
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x2A
;     269 	    		{
;     270 		    		char_index++;				 
	LDS  R30,_char_index_G1
	LDS  R31,_char_index_G1+1
	ADIW R30,1
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R31
;     271 			    	current_char_width = char_width[char_index];
	LDI  R26,LOW(_char_width_G1)
	LDI  R27,HIGH(_char_width_G1)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	STS  _current_char_width_G1,R30
	STS  _current_char_width_G1+1,R31
;     272 				    next_char_width = char_width[char_index+1];				
	LDS  R26,_char_index_G1
	LDS  R27,_char_index_G1+1
	LSL  R26
	ROL  R27
	__ADDW2MN _char_width_G1,2
	CALL __GETW1P
	STS  _next_char_width_G1,R30
	STS  _next_char_width_G1+1,R31
;     273     				start_mem = START_RAM_TEXT + current_char_width;
	LDS  R30,_current_char_width_G1
	LDS  R31,_current_char_width_G1+1
	SUBI R30,LOW(-2880)
	SBCI R31,HIGH(-2880)
_0xE4:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     274 	    		}
;     275 		    }
_0x2A:
;     276         }
_0x29:
;     277         else
	RJMP _0x2B
_0x24:
;     278     #endif //__FLYING_TEXT_
;     279     #ifdef __SCROLL_TEXT_
;     280         {
;     281             start_mem += shift_step;
	LDS  R30,_shift_step_G1
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     282         } 
_0x2B:
;     283     #endif //__SCROLL_TEXT_      		
;     284         if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length)          
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-3096)
	SBCI R31,HIGH(-3096)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRSH PC+3
	JMP _0x2C
;     285         {   
;     286         #ifdef __FLYING_TEXT_                                                                                      
;     287             if ((sys_mode&MASK_MODE)==FLYING_TEXT || (sys_mode&MASK_MODE)==ALL_IN_ONE){                
	LDS  R30,_sys_mode_G1
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x1)
	BREQ _0x2E
	LDS  R30,_sys_mode_G1
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0xF)
	BRNE _0x2D
_0x2E:
;     288                 char_index = 0;              
	LDI  R30,0
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R30
;     289                 shift_rate = _cfg_shift_rate;
	LDI  R26,LOW(__cfg_shift_rate)
	LDI  R27,HIGH(__cfg_shift_rate)
	CALL __EEPROMRDB
	STS  _shift_rate_G1,R30
;     290                 shift_step = _cfg_shift_step;
	LDI  R26,LOW(__cfg_shift_step)
	LDI  R27,HIGH(__cfg_shift_step)
	CALL __EEPROMRDB
	STS  _shift_step_G1,R30
;     291                 current_char_width = char_width[char_index];
	LDS  R30,_char_index_G1
	LDS  R31,_char_index_G1+1
	LDI  R26,LOW(_char_width_G1)
	LDI  R27,HIGH(_char_width_G1)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	STS  _current_char_width_G1,R30
	STS  _current_char_width_G1+1,R31
;     292     		    next_char_width = char_width[char_index+1];	  
	LDS  R26,_char_index_G1
	LDS  R27,_char_index_G1+1
	LSL  R26
	ROL  R27
	__ADDW2MN _char_width_G1,2
	CALL __GETW1P
	STS  _next_char_width_G1,R30
	STS  _next_char_width_G1+1,R31
;     293                 start_mem = START_RAM_TEXT;                    		    
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     294             }    
;     295         #ifndef __ALL_IN_ONE_
;     296             else
;     297         #endif //__ALL_IN_ONE_
;     298         #endif //__FLYING_TEXT_
;     299         #ifdef __FLIPPING_BK_  
;     300             if ((sys_mode&MASK_MODE)==FLIPPING_BK || (sys_mode&MASK_MODE)==ALL_IN_ONE){                              
_0x2D:
	LDS  R30,_sys_mode_G1
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x2)
	BREQ _0x31
	LDS  R30,_sys_mode_G1
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0xF)
	BREQ _0x31
	RJMP _0x30
_0x31:
;     301                 if (tick_count <= MAX_SHOW_TIME){
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	CPI  R26,LOW(0x3E9)
	LDI  R30,HIGH(0x3E9)
	CPC  R27,R30
	BRSH _0x33
;     302                     is_show_bkgnd = 1;
	SET
	BLD  R2,0
;     303                     is_flipping_bk = 1;
	BLD  R2,1
;     304                     start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;                       
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-3096)
	SBCI R31,HIGH(-3096)
	RJMP _0xE5
;     305                 }
;     306                 else
_0x33:
;     307                 if ((MAX_SHOW_TIME < tick_count) && (tick_count <= 5*MAX_SHOW_TIME/3)){
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	CPI  R30,LOW(0x3E9)
	LDI  R26,HIGH(0x3E9)
	CPC  R31,R26
	BRLO _0x36
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	CPI  R26,LOW(0x683)
	LDI  R30,HIGH(0x683)
	CPC  R27,R30
	BRLO _0x37
_0x36:
	RJMP _0x35
_0x37:
;     308                     is_show_bkgnd = 0;
	CLT
	BLD  R2,0
;     309                     is_flipping_bk = 1;
	SET
	BLD  R2,1
;     310                     start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-3096)
	SBCI R31,HIGH(-3096)
	RJMP _0xE5
;     311                 }
;     312                 else
_0x35:
;     313                 if ((5*MAX_SHOW_TIME/3 < tick_count) && (tick_count <= 6*MAX_SHOW_TIME/3)){
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	CPI  R30,LOW(0x683)
	LDI  R26,HIGH(0x683)
	CPC  R31,R26
	BRLO _0x3A
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	CPI  R26,LOW(0x7D1)
	LDI  R30,HIGH(0x7D1)
	CPC  R27,R30
	BRLO _0x3B
_0x3A:
	RJMP _0x39
_0x3B:
;     314                     is_show_bkgnd = 1;
	SET
	BLD  R2,0
;     315                     is_flipping_bk = 1;
	BLD  R2,1
;     316                     start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-3096)
	SBCI R31,HIGH(-3096)
	RJMP _0xE5
;     317                 }
;     318                 else
_0x39:
;     319                 if ((6*MAX_SHOW_TIME/3 < tick_count) && (tick_count <= 7*MAX_SHOW_TIME/3)){
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	CPI  R30,LOW(0x7D1)
	LDI  R26,HIGH(0x7D1)
	CPC  R31,R26
	BRLO _0x3E
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	CPI  R26,LOW(0x91E)
	LDI  R30,HIGH(0x91E)
	CPC  R27,R30
	BRLO _0x3F
_0x3E:
	RJMP _0x3D
_0x3F:
;     320                     is_show_bkgnd = 0;
	CLT
	BLD  R2,0
;     321                     is_flipping_bk = 1;
	SET
	BLD  R2,1
;     322                     start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-3096)
	SBCI R31,HIGH(-3096)
	RJMP _0xE5
;     323                 }
;     324                 else
_0x3D:
;     325                 if ((7*MAX_SHOW_TIME/3 < tick_count) && (tick_count <= 8*MAX_SHOW_TIME/3)){
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	CPI  R30,LOW(0x91E)
	LDI  R26,HIGH(0x91E)
	CPC  R31,R26
	BRLO _0x42
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	CPI  R26,LOW(0xA6B)
	LDI  R30,HIGH(0xA6B)
	CPC  R27,R30
	BRLO _0x43
_0x42:
	RJMP _0x41
_0x43:
;     326                     is_show_bkgnd = 1;
	SET
	BLD  R2,0
;     327                     is_flipping_bk = 1;
	BLD  R2,1
;     328                     start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-3096)
	SBCI R31,HIGH(-3096)
	RJMP _0xE5
;     329                 }
;     330                 else
_0x41:
;     331                 if ((8*MAX_SHOW_TIME/3 < tick_count) && (tick_count <= 9*MAX_SHOW_TIME/3)){
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	CPI  R30,LOW(0xA6B)
	LDI  R26,HIGH(0xA6B)
	CPC  R31,R26
	BRLO _0x46
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	CPI  R26,LOW(0xBB9)
	LDI  R30,HIGH(0xBB9)
	CPC  R27,R30
	BRLO _0x47
_0x46:
	RJMP _0x45
_0x47:
;     332                     is_show_bkgnd = 0;
	CLT
	BLD  R2,0
;     333                     is_flipping_bk = 1;
	SET
	BLD  R2,1
;     334                     start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-3096)
	SBCI R31,HIGH(-3096)
	RJMP _0xE5
;     335                 }
;     336                 else
_0x45:
;     337                 if ((9*MAX_SHOW_TIME/3 < tick_count) && (tick_count <= 10*MAX_SHOW_TIME/3)){
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	CPI  R30,LOW(0xBB9)
	LDI  R26,HIGH(0xBB9)
	CPC  R31,R26
	BRLO _0x4A
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	CPI  R26,LOW(0xD06)
	LDI  R30,HIGH(0xD06)
	CPC  R27,R30
	BRLO _0x4B
_0x4A:
	RJMP _0x49
_0x4B:
;     338                     is_show_bkgnd = 1;
	SET
	BLD  R2,0
;     339                     is_flipping_bk = 1;
	BLD  R2,1
;     340                     start_mem = (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length;
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-3096)
	SBCI R31,HIGH(-3096)
	RJMP _0xE5
;     341                 }     
;     342                 else{ 
_0x49:
;     343                     tick_count = 0;
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     344                     is_show_bkgnd = 0;
	CLT
	BLD  R2,0
;     345                     is_flipping_bk = 0;      
	BLD  R2,1
;     346                     shift_rate = _cfg_shift_rate;
	LDI  R26,LOW(__cfg_shift_rate)
	LDI  R27,HIGH(__cfg_shift_rate)
	CALL __EEPROMRDB
	STS  _shift_rate_G1,R30
;     347                     shift_step = _cfg_shift_step;
	LDI  R26,LOW(__cfg_shift_step)
	LDI  R27,HIGH(__cfg_shift_step)
	CALL __EEPROMRDB
	STS  _shift_step_G1,R30
;     348                     start_mem = START_RAM_TEXT;
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
_0xE5:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     349                 }
;     350             }
;     351             else
	RJMP _0x4D
_0x30:
;     352         #endif //__FLIPPING_BK_              
;     353         #ifdef __ALWAY_BKGND_
;     354             if ((sys_mode&MASK_MODE)==ALWAY_BKGND){   
	LDS  R30,_sys_mode_G1
	ANDI R30,LOW(0xF)
	CPI  R30,LOW(0x3)
	BRNE _0x4E
;     355                 is_show_bkgnd = 1;  // alway show the bakgnd
	SET
	BLD  R2,0
;     356                 shift_rate = _cfg_shift_rate;
	RJMP _0xE6
;     357                 shift_step = _cfg_shift_step;
;     358                 start_mem = START_RAM_TEXT;
;     359             }
;     360         #ifdef __SCROLL_TEXT_
;     361             else                
_0x4E:
;     362         #endif //__SCROLL_TEXT_
;     363         #endif //__ALWAY_BKGND_    
;     364         #ifdef __SCROLL_TEXT_
;     365             {                              
;     366                 is_show_bkgnd = 0;  // disable background
	CLT
	BLD  R2,0
;     367                 shift_rate = _cfg_shift_rate;
_0xE6:
	LDI  R26,LOW(__cfg_shift_rate)
	LDI  R27,HIGH(__cfg_shift_rate)
	CALL __EEPROMRDB
	STS  _shift_rate_G1,R30
;     368                 shift_step = _cfg_shift_step;
	LDI  R26,LOW(__cfg_shift_step)
	LDI  R27,HIGH(__cfg_shift_step)
	CALL __EEPROMRDB
	STS  _shift_step_G1,R30
;     369                 start_mem = START_RAM_TEXT;
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     370             }                   
_0x4D:
;     371         #endif //__SCROLL_TEXT_
;     372         }
;     373     }        
_0x2C:
;     374 
;     375 }          
_0x23:
	RET
;     376 ////////////////////////////////////////////////////////////////////
;     377 // General functions
;     378 //////////////////////////////////////////////////////////////////// 
;     379 #define RESET_WATCHDOG()    #asm("WDR");
;     380 
;     381 void SerialToRAM(WORD address,WORD length, BYTE type)                                             
;     382 {
_SerialToRAM:
;     383     PBYTE temp = 0;          
;     384     UINT i =0, row =0;     				
;     385     temp   = address;    
	CALL __SAVELOCR6
;	address -> Y+9
;	length -> Y+7
;	type -> Y+6
;	*temp -> R16,R17
;	i -> R18,R19
;	row -> R20,R21
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,0
	LDI  R19,0
	LDI  R20,0
	LDI  R21,0
	__GETWRS 16,17,9
;     386     LED_STATUS = 0;
	CBI  0x18,4
;     387     for (row =0; row < 8; row++)
	__GETWRN 20,21,0
_0x51:
	__CPWRN 20,21,8
	BRLO PC+3
	JMP _0x52
;     388     {
;     389         for (i =0; i< length; i++) 
	__GETWRN 18,19,0
_0x54:
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	CP   R18,R30
	CPC  R19,R31
	BRLO PC+3
	JMP _0x55
;     390         {
;     391             *temp++ = ~getchar();
	PUSH R17
	PUSH R16
	__ADDWRN 16,17,1
	CALL _getchar
	COM  R30
	POP  R26
	POP  R27
	ST   X,R30
;     392             RESET_WATCHDOG();
	WDR
;     393         }                               
	__ADDWRN 18,19,1
	JMP  _0x54
_0x55:
;     394         if (type == FRAME_TEXT)   
	LDD  R30,Y+6
	CPI  R30,0
	BRNE _0x56
;     395             temp += DATA_LENGTH - length;        
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LDI  R30,LOW(3736)
	LDI  R31,HIGH(3736)
	SUB  R30,R26
	SBC  R31,R27
	__ADDWRR 16,17,30,31
;     396     }              
_0x56:
	__ADDWRN 20,21,1
	JMP  _0x51
_0x52:
;     397     LED_STATUS = 1;
	SBI  0x18,4
;     398 }
	CALL __LOADLOCR6
	ADIW R28,11
	RET
;     399 
;     400 void LoadCharWidth(WORD length)
;     401 {                               
_LoadCharWidth:
;     402     UINT i =0;  
;     403     LED_STATUS = 0;   
	ST   -Y,R17
	ST   -Y,R16
;	length -> Y+2
;	i -> R16,R17
	LDI  R16,0
	LDI  R17,0
	CBI  0x18,4
;     404     for (i =0; i < length; i++)
	__GETWRN 16,17,0
_0x58:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R16,R30
	CPC  R17,R31
	BRLO PC+3
	JMP _0x59
;     405     {                           
;     406         WORD data = 0;
;     407         data = getchar();                       // LOBYTE 
	SBIW R28,2
	LDI  R24,2
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x5A*2)
	LDI  R31,HIGH(_0x5A*2)
	CALL __INITLOCB
;	length -> Y+4
;	data -> Y+0
	CALL _getchar
	LDI  R31,0
	ST   Y,R30
	STD  Y+1,R31
;     408         RESET_WATCHDOG();       
	WDR
;     409         char_width[i] = data;        
	MOVW R30,R16
	LDI  R26,LOW(_char_width_G1)
	LDI  R27,HIGH(_char_width_G1)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	LD   R26,Y
	LDD  R27,Y+1
	STD  Z+0,R26
	STD  Z+1,R27
;     410         data = getchar();                       // HIBYTE
	CALL _getchar
	LDI  R31,0
	ST   Y,R30
	STD  Y+1,R31
;     411         RESET_WATCHDOG();
	WDR
;     412         char_width[i] |= (data<<8)&0xFF00;
	MOVW R30,R16
	LDI  R26,LOW(_char_width_G1)
	LDI  R27,HIGH(_char_width_G1)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	MOVW R26,R30
	CALL __GETW1P
	MOVW R26,R30
	LD   R31,Y
	LDI  R30,LOW(0)
	OR   R30,R26
	OR   R31,R27
	MOVW R26,R0
	ST   X+,R30
	ST   X,R31
;     413     }                  
	ADIW R28,2
	__ADDWRN 16,17,1
	JMP  _0x58
_0x59:
;     414     current_char_width = 0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _current_char_width_G1,R30
	STS  _current_char_width_G1+1,R31
;     415     
;     416     LED_STATUS = 1;
	SBI  0x18,4
;     417 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
;     418 
;     419 void SaveCharWidth(WORD length)
;     420 {
_SaveCharWidth:
;     421     UINT i =0;  
;     422     LED_STATUS = 0;   
	ST   -Y,R17
	ST   -Y,R16
;	length -> Y+2
;	i -> R16,R17
	LDI  R16,0
	LDI  R17,0
	CBI  0x18,4
;     423     for (i =0; i < length; i++)
	__GETWRN 16,17,0
_0x5C:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R16,R30
	CPC  R17,R31
	BRLO PC+3
	JMP _0x5D
;     424     {                           
;     425         _save_char_width[i] = char_width[i];
	MOVW R30,R16
	LDI  R26,LOW(__save_char_width)
	LDI  R27,HIGH(__save_char_width)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	MOVW R30,R16
	LDI  R26,LOW(_char_width_G1)
	LDI  R27,HIGH(_char_width_G1)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	MOVW R26,R0
	CALL __EEPROMWRW
;     426         RESET_WATCHDOG();
	WDR
;     427     }              
	__ADDWRN 16,17,1
	JMP  _0x5C
_0x5D:
;     428     LED_STATUS = 1;
	SBI  0x18,4
;     429 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
;     430 
;     431 void GetCharWidth(WORD length)
;     432 {                               
_GetCharWidth:
;     433     UINT i =0;  
;     434     LED_STATUS = 0;   
	ST   -Y,R17
	ST   -Y,R16
;	length -> Y+2
;	i -> R16,R17
	LDI  R16,0
	LDI  R17,0
	CBI  0x18,4
;     435     for (i =0; i < length; i++)
	__GETWRN 16,17,0
_0x5F:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R16,R30
	CPC  R17,R31
	BRLO PC+3
	JMP _0x60
;     436     {                           
;     437         char_width[i] = _save_char_width[i];
	MOVW R30,R16
	LDI  R26,LOW(_char_width_G1)
	LDI  R27,HIGH(_char_width_G1)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	MOVW R30,R16
	LDI  R26,LOW(__save_char_width)
	LDI  R27,HIGH(__save_char_width)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	MOVW R26,R0
	ST   X+,R30
	ST   X,R31
;     438         RESET_WATCHDOG();
	WDR
;     439     }              
	__ADDWRN 16,17,1
	JMP  _0x5F
_0x60:
;     440     LED_STATUS = 1;
	SBI  0x18,4
;     441 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
;     442                                           
;     443 void SaveFontHeader(WORD length)
;     444 {   
_SaveFontHeader:
;     445     UINT i =0;  
;     446     LED_STATUS = 0;    
	ST   -Y,R17
	ST   -Y,R16
;	length -> Y+2
;	i -> R16,R17
	LDI  R16,0
	LDI  R17,0
	CBI  0x18,4
;     447     // init I2C bus
;     448     i2c_init();
	CALL _i2c_init
;     449     for (i =0; i < length; i++)
	__GETWRN 16,17,0
_0x62:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R16,R30
	CPC  R17,R31
	BRLO PC+3
	JMP _0x63
;     450     {                           
;     451         eeprom_write_w(EEPROM_DEVICE_FONT,i,char_width[i]);
	LDI  R30,LOW(164)
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	MOVW R30,R16
	LDI  R26,LOW(_char_width_G1)
	LDI  R27,HIGH(_char_width_G1)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_write_w
;     452         RESET_WATCHDOG();        
	WDR
;     453     }                 
	__ADDWRN 16,17,1
	JMP  _0x62
_0x63:
;     454   
;     455     LED_STATUS = 1;
	SBI  0x18,4
;     456 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
;     457 
;     458 void SaveToEEPROM(WORD address,WORD length,BYTE type)
;     459 {                             
_SaveToEEPROM:
;     460     PBYTE temp = 0;    
;     461 #ifndef EEPROM_PAGE     
;     462     UINT i =0, row =0;  
;     463 #endif    
;     464     PBYTE end  = START_RAM_TEXT;     
;     465     BYTE devID = EEPROM_DEVICE_32;      				
;     466     temp   = address;         
	CALL __SAVELOCR5
;	address -> Y+8
;	length -> Y+6
;	type -> Y+5
;	*temp -> R16,R17
;	*end -> R18,R19
;	devID -> R20
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,LOW(0xB40)
	LDI  R19,HIGH(0xB40)
	LDI  R20,160
	__GETWRS 16,17,8
;     467         
;     468     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xE99)
	LDI  R30,HIGH(0xE99)
	CPC  R27,R30
	BRLO _0x64
;     469         return; // invalid param          
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     470 #ifdef EEPROM_PAGE
;     471     if (length%EEPROM_PAGE)
_0x64:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ANDI R30,LOW(0x3F)
	BREQ _0x65
;     472         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	CALL __DIVW21U
	CALL __LSLW2
	CALL __LSLW4
	SUBI R30,LOW(-64)
	SBCI R31,HIGH(-64)
	STD  Y+6,R30
	STD  Y+6+1,R31
;     473 #endif       
;     474     
;     475     // init I2C bus
;     476     i2c_init();
_0x65:
	CALL _i2c_init
;     477     LED_STATUS = 0;        
	CBI  0x18,4
;     478     
;     479        
;     480 #ifdef EEPROM_PAGE            
;     481     if ((type == FRAME_TEXT) || (type == FRAME_FONT)) end = END_RAM;
	LDD  R26,Y+5
	CPI  R26,LOW(0x0)
	BREQ _0x67
	CPI  R26,LOW(0x2)
	BRNE _0x66
_0x67:
	__GETWRN 18,19,32768
;     482     if (type == FRAME_FONT) devID = EEPROM_DEVICE_FONT;
_0x66:
	LDD  R26,Y+5
	CPI  R26,LOW(0x2)
	BRNE _0x69
	LDI  R20,LOW(164)
;     483     
;     484     for (temp = address; temp < end; temp+= EEPROM_PAGE) 
_0x69:
	__GETWRS 16,17,8
_0x6B:
	__CPWRR 16,17,18,19
	BRLO PC+3
	JMP _0x6C
;     485     {   
;     486         RESET_WATCHDOG();               
	WDR
;     487         if (temp >= END_RAM32) devID = EEPROM_DEVICE_64;            	                                              
	__CPWRN 16,17,32768
	BRLO _0x6D
	LDI  R20,LOW(162)
;     488         eeprom_write_page( devID, temp, temp, EEPROM_PAGE);	      
_0x6D:
	ST   -Y,R20
	ST   -Y,R17
	ST   -Y,R16
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	CALL _eeprom_write_page
;     489     }       
	__ADDWRN 16,17,64
	JMP  _0x6B
_0x6C:
;     490 #else // NONE PAGING
;     491     for (row =0; row < 8; row++)   
;     492     {
;     493         for (i =0; i< length; i++) 
;     494         {                  
;     495             if (i >= DATA_LENGTH32) devID = EEPROM_DEVICE_64;            	                                              
;     496             eeprom_write( devID, temp, *temp++ );RESET_WATCHDOG();	    
;     497         }           
;     498         if ((type == FRAME_TEXT) || (type == FRAME_FONT))  
;     499             temp += DATA_LENGTH - length;   
;     500     }
;     501 #endif
;     502         
;     503     LED_STATUS = 1;   
	SBI  0x18,4
;     504 }
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     505                       
;     506 void LoadToRAM(WORD address,WORD length,BYTE type)
;     507 {                         
_LoadToRAM:
;     508     PBYTE temp = 0;          
;     509     UINT i =0, row =0;
;     510     BYTE devID = EEPROM_DEVICE_32;      				
;     511     temp   = address;                 
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x6E*2)
	LDI  R31,HIGH(_0x6E*2)
	CALL __INITLOCB
	CALL __SAVELOCR6
;	address -> Y+10
;	length -> Y+8
;	type -> Y+7
;	*temp -> R16,R17
;	i -> R18,R19
;	row -> R20,R21
;	devID -> Y+6
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,0
	LDI  R19,0
	LDI  R20,0
	LDI  R21,0
	__GETWRS 16,17,10
;     512 
;     513     if (length > DATA_LENGTH)    
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CPI  R26,LOW(0xE99)
	LDI  R30,HIGH(0xE99)
	CPC  R27,R30
	BRLO _0x6F
;     514         return; // invalid param
	CALL __LOADLOCR6
	ADIW R28,12
	RET
;     515 #ifdef EEPROM_PAGE
;     516     if (length%EEPROM_PAGE)
_0x6F:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ANDI R30,LOW(0x3F)
	BREQ _0x70
;     517         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	CALL __DIVW21U
	CALL __LSLW2
	CALL __LSLW4
	SUBI R30,LOW(-64)
	SBCI R31,HIGH(-64)
	STD  Y+8,R30
	STD  Y+8+1,R31
;     518 #endif       
;     519     // init I2C bus
;     520     i2c_init();
_0x70:
	CALL _i2c_init
;     521     LED_STATUS = 0;             
	CBI  0x18,4
;     522     if (type == FRAME_FONT) devID = EEPROM_DEVICE_FONT;      
	LDD  R26,Y+7
	CPI  R26,LOW(0x2)
	BRNE _0x71
	LDI  R30,LOW(164)
	STD  Y+6,R30
;     523     for (row =0; row < 8; row++)            
_0x71:
	__GETWRN 20,21,0
_0x73:
	__CPWRN 20,21,8
	BRLO PC+3
	JMP _0x74
;     524     {                           
;     525 #ifdef EEPROM_PAGE          
;     526         for (i =0; i< length; i+=EEPROM_PAGE) 
	__GETWRN 18,19,0
_0x76:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	CP   R18,R30
	CPC  R19,R31
	BRLO PC+3
	JMP _0x77
;     527         {                                 
;     528             if (i >= DATA_LENGTH32) devID = EEPROM_DEVICE_64;
	__CPWRN 18,19,3736
	BRLO _0x78
	LDI  R30,LOW(162)
	STD  Y+6,R30
;     529             eeprom_read_page( devID, temp, temp, EEPROM_PAGE );	                                   
_0x78:
	LDD  R30,Y+6
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	CALL _eeprom_read_page
;     530             temp += EEPROM_PAGE;
	__ADDWRN 16,17,64
;     531             RESET_WATCHDOG();     
	WDR
;     532         }         
	__ADDWRN 18,19,64
	JMP  _0x76
_0x77:
;     533 #else    
;     534         for (i =0; i< length; i++) 
;     535         {                                 
;     536             if (i >= DATA_LENGTH32) devID = EEPROM_DEVICE_64;
;     537             *temp = eeprom_read( devID, temp++ );
;     538             RESET_WATCHDOG();	                      
;     539         }
;     540 #endif        
;     541         if ((type == FRAME_TEXT) || (type == FRAME_FONT))  
	LDD  R26,Y+7
	CPI  R26,LOW(0x0)
	BREQ _0x7A
	CPI  R26,LOW(0x2)
	BRNE _0x79
_0x7A:
;     542             temp += DATA_LENGTH - length;  
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(3736)
	LDI  R31,HIGH(3736)
	SUB  R30,R26
	SBC  R31,R27
	__ADDWRR 16,17,30,31
;     543     }             
_0x79:
	__ADDWRN 20,21,1
	JMP  _0x73
_0x74:
;     544 
;     545     LED_STATUS = 1;  
	SBI  0x18,4
;     546 }
	CALL __LOADLOCR6
	ADIW R28,12
	RET
;     547 
;     548 void LoadConfig()
;     549 {                                
_LoadConfig:
;     550     sys_mode   = _cfg_sys_mode;
	LDI  R26,LOW(__cfg_sys_mode)
	LDI  R27,HIGH(__cfg_sys_mode)
	CALL __EEPROMRDB
	STS  _sys_mode_G1,R30
;     551     shift_rate = _cfg_shift_rate;
	LDI  R26,LOW(__cfg_shift_rate)
	LDI  R27,HIGH(__cfg_shift_rate)
	CALL __EEPROMRDB
	STS  _shift_rate_G1,R30
;     552     shift_step = _cfg_shift_step;    
	LDI  R26,LOW(__cfg_shift_step)
	LDI  R27,HIGH(__cfg_shift_step)
	CALL __EEPROMRDB
	STS  _shift_step_G1,R30
;     553     frm_delay  = _cfg_frm_delay;
	LDI  R26,LOW(__cfg_frm_delay)
	LDI  R27,HIGH(__cfg_frm_delay)
	CALL __EEPROMRDB
	STS  _frm_delay_G1,R30
;     554     
;     555     if (_save_text_length > DATA_LENGTH)
	LDI  R26,LOW(__save_text_length)
	LDI  R27,HIGH(__save_text_length)
	CALL __EEPROMRDW
	CPI  R30,LOW(0xE99)
	LDI  R26,HIGH(0xE99)
	CPC  R31,R26
	BRLO _0x7C
;     556         _save_text_length = 0; 
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	LDI  R26,LOW(__save_text_length)
	LDI  R27,HIGH(__save_text_length)
	CALL __EEPROMWRW
;     557     text_length = _save_text_length; 
_0x7C:
	LDI  R26,LOW(__save_text_length)
	LDI  R27,HIGH(__save_text_length)
	CALL __EEPROMRDW
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     558 }
	RET
;     559 
;     560 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     561 {        
_BlankRAM:
;     562     PBYTE temp = START_RAM;
;     563     for (temp = start_addr; temp<= end_addr; temp++)    
	ST   -Y,R17
	ST   -Y,R16
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*temp -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x7E:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x7F
;     564         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     565 }
	__ADDWRN 16,17,1
	RJMP _0x7E
_0x7F:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;     566 
;     567 void SetRTCDateTime()
;     568 {
_SetRTCDateTime:
;     569     i2c_init();
	CALL _i2c_init
;     570     LED_STATUS = 0;   
	CBI  0x18,4
;     571     rtc_set_date(getchar(),getchar(),getchar());
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _rtc_set_date
;     572     rtc_set_time(getchar(),getchar(),getchar());    
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _rtc_set_time
;     573     LED_STATUS = 1;
	SBI  0x18,4
;     574 }
	RET
;     575 
;     576 static void TextFromFont(char *szText, BYTE nColor, BYTE bGradient, PBYTE pBuffer, WORD length)
;     577 {
_TextFromFont_G1:
;     578 	int pos = 0,x=0,y=0;     
;     579 	BYTE i =0, len;
;     580 	BYTE ch = 0;
;     581 	UINT nWidth = 0;   
;     582 	UINT nCurWidth = 0, nNxtWidth = 0;		
;     583     BYTE mask = 0x00, data = 0;
;     584 	BYTE mask_clr[2] = {0x00};
;     585 	
;     586 	switch (nColor)
	SBIW R28,13
	LDI  R24,13
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x80*2)
	LDI  R31,HIGH(_0x80*2)
	CALL __INITLOCB
	CALL __SAVELOCR6
;	*szText -> Y+25
;	nColor -> Y+24
;	bGradient -> Y+23
;	*pBuffer -> Y+21
;	length -> Y+19
;	pos -> R16,R17
;	x -> R18,R19
;	y -> R20,R21
;	i -> Y+18
;	len -> Y+17
;	ch -> Y+16
;	nWidth -> Y+14
;	nCurWidth -> Y+12
;	nNxtWidth -> Y+10
;	mask -> Y+9
;	data -> Y+8
;	mask_clr -> Y+6
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	LDI  R20,0
	LDI  R21,0
	LDD  R30,Y+24
;     587 	{
;     588 	case 0:
	CPI  R30,0
	BRNE _0x84
;     589 		mask = 0xFF;		// BLANK
	LDI  R30,LOW(255)
	STD  Y+9,R30
;     590 		mask_clr[0] = 0xFF;
	STD  Y+6,R30
;     591 		mask_clr[1] = 0xFF;
	STD  Y+7,R30
;     592 		break;
	RJMP _0x83
;     593 	case 1:
_0x84:
	CPI  R30,LOW(0x1)
	BRNE _0x85
;     594 		mask = 0xAA;		// RED			RRRR	
	LDI  R30,LOW(170)
	STD  Y+9,R30
;     595 		mask_clr[0] = 0x99;	// GREEN		RGRG
	LDI  R30,LOW(153)
	STD  Y+6,R30
;     596 		mask_clr[1] = 0x88;	// YELLOW		RYRY
	LDI  R30,LOW(136)
	STD  Y+7,R30
;     597 		break;
	RJMP _0x83
;     598 	case 2:
_0x85:
	CPI  R30,LOW(0x2)
	BRNE _0x86
;     599 		mask = 0x55;		// GREEN		GGGG
	LDI  R30,LOW(85)
	STD  Y+9,R30
;     600 		mask_clr[0] = 0x44;	// YELLOW		GYGY
	LDI  R30,LOW(68)
	STD  Y+6,R30
;     601 		mask_clr[1] = 0x66;	// RED			GRGR	
	LDI  R30,LOW(102)
	STD  Y+7,R30
;     602 		break;
	RJMP _0x83
;     603 	case 3:
_0x86:
	CPI  R30,LOW(0x3)
	BRNE _0x88
;     604 		mask = 0x00;		// YELLOW		YYYY
	LDI  R30,LOW(0)
	STD  Y+9,R30
;     605 		mask_clr[0] = 0x22;	// RED			YRYR	
	LDI  R30,LOW(34)
	STD  Y+6,R30
;     606 		mask_clr[1] = 0x11;	// GREEN		YGYG
	LDI  R30,LOW(17)
	STD  Y+7,R30
;     607 		break;
;     608 	default:
_0x88:
;     609 		break;
;     610 	}	
_0x83:
;     611                            
;     612 	LED_STATUS = 0;
	CBI  0x18,4
;     613 	i2c_init();
	CALL _i2c_init
;     614 	len = strlen(szText);
	LDD  R30,Y+25
	LDD  R31,Y+25+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen
	STD  Y+17,R30
;     615     char_width[0] = 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _char_width_G1,R30
	STS  _char_width_G1+1,R31
;     616     
;     617 	for (i=0; i< len; i++)
	STD  Y+18,R30
_0x8A:
	LDD  R30,Y+17
	LDD  R26,Y+18
	CP   R26,R30
	BRLO PC+3
	JMP _0x8B
;     618 	{				                                     
;     619         ch = szText[i];             
	LDD  R30,Y+18
	LDD  R26,Y+25
	LDD  R27,Y+25+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	STD  Y+16,R30
;     620 		nCurWidth = eeprom_read_w(EEPROM_DEVICE_FONT,(WORD)ch);
	LDI  R30,LOW(164)
	ST   -Y,R30
	LDD  R30,Y+17
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read_w
	STD  Y+12,R30
	STD  Y+12+1,R31
;     621 		nNxtWidth = eeprom_read_w(EEPROM_DEVICE_FONT,(WORD)ch+1);
	LDI  R30,LOW(164)
	ST   -Y,R30
	LDD  R30,Y+17
	LDI  R31,0
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read_w
	STD  Y+10,R30
	STD  Y+10+1,R31
;     622 		nWidth = (nNxtWidth - nCurWidth); 
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+14,R30
	STD  Y+14+1,R31
;     623 		
;     624 		if ((pos + nWidth) >= length)  break;
	ADD  R30,R16
	ADC  R31,R17
	MOVW R26,R30
	LDD  R30,Y+19
	LDD  R31,Y+19+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x8C
	JMP  _0x8B
;     625 		
;     626 		for (y=0; y< 8 ; y++)
_0x8C:
	__GETWRN 20,21,0
_0x8E:
	__CPWRN 20,21,8
	BRLT PC+3
	JMP _0x8F
;     627 		{    		            
;     628 		    if (bGradient) {
	LDD  R30,Y+23
	CPI  R30,0
	BREQ _0x90
;     629 				if (y >=0 && y <4)	mask = mask_clr[0];
	SUBI R20,0
	SBCI R21,0
	BRLT _0x92
	__CPWRN 20,21,4
	BRLT _0x93
_0x92:
	RJMP _0x91
_0x93:
	LDD  R30,Y+6
	STD  Y+9,R30
;     630 				if (y >=4 && y <8)	mask = mask_clr[1];	
_0x91:
	__CPWRN 20,21,4
	BRLT _0x95
	__CPWRN 20,21,8
	BRLT _0x96
_0x95:
	RJMP _0x94
_0x96:
	LDD  R30,Y+7
	STD  Y+9,R30
;     631 			}
_0x94:
;     632 			
;     633 			for (x=0; x< nWidth; x++)
_0x90:
	__GETWRN 18,19,0
_0x98:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	CP   R18,R30
	CPC  R19,R31
	BRLO PC+3
	JMP _0x99
;     634 			{                                 
;     635 			    RESET_WATCHDOG();       
	WDR
;     636 			    data = eeprom_read(EEPROM_DEVICE_FONT, START_RAM_TEXT + y*DATA_LENGTH + nCurWidth + x);
	LDI  R30,LOW(164)
	ST   -Y,R30
	MOVW R26,R20
	LDI  R30,LOW(3736)
	LDI  R31,HIGH(3736)
	CALL __MULW12
	SUBI R30,LOW(-2880)
	SBCI R31,HIGH(-2880)
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	ADD  R30,R26
	ADC  R31,R27
	ADD  R30,R18
	ADC  R31,R19
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STD  Y+8,R30
;     637 			    data = (~data) & (~mask);
	COM  R30
	MOV  R26,R30
	LDD  R30,Y+9
	COM  R30
	AND  R30,R26
	STD  Y+8,R30
;     638    				pBuffer[y*length + x + pos] = ~data;   				
	LDD  R30,Y+19
	LDD  R31,Y+19+1
	MOVW R26,R20
	CALL __MULW12U
	ADD  R30,R18
	ADC  R31,R19
	ADD  R30,R16
	ADC  R31,R17
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+8
	COM  R30
	ST   X,R30
;     639 			}					
	__ADDWRN 18,19,1
	JMP  _0x98
_0x99:
;     640 		}
	__ADDWRN 20,21,1
	JMP  _0x8E
_0x8F:
;     641 		pos += nWidth;	 
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	__ADDWRR 16,17,30,31
;     642 		if (length == DATA_LENGTH) 
	LDD  R26,Y+19
	LDD  R27,Y+19+1
	CPI  R26,LOW(0xE98)
	LDI  R30,HIGH(0xE98)
	CPC  R27,R30
	BRNE _0x9A
;     643             char_width[(WORD)i+1] = pos;		
	LDD  R26,Y+18
	CLR  R27
	LSL  R26
	ROL  R27
	__ADDW2MN _char_width_G1,2
	ST   X+,R16
	ST   X,R17
;     644 	}	                           
_0x9A:
	LDD  R30,Y+18
	SUBI R30,-LOW(1)
	STD  Y+18,R30
	JMP  _0x8A
_0x8B:
;     645 	
;     646     if (length == DATA_LENGTH)     
	LDD  R26,Y+19
	LDD  R27,Y+19+1
	CPI  R26,LOW(0xE98)
	LDI  R30,HIGH(0xE98)
	CPC  R27,R30
	BRNE _0x9B
;     647         text_length = pos;
	__PUTWMRN _text_length_G1,0,16,17
;     648             
;     649     LED_STATUS = 1;
_0x9B:
	SBI  0x18,4
;     650 }
	CALL __LOADLOCR6
	ADIW R28,27
	RET
;     651 
;     652 void SaveTextToEEPROM()
;     653 {                       
_SaveTextToEEPROM:
;     654     UINT i =0;              
;     655     UINT length = 0;
;     656     length = strlen(szText);    
	CALL __SAVELOCR4
;	i -> R16,R17
;	length -> R18,R19
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	LDI  R30,LOW(_szText_G1)
	LDI  R31,HIGH(_szText_G1)
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen
	MOVW R18,R30
;     657     
;     658     if (length > sizeof(szText))    
	__CPWRN 18,19,39
	BRLO _0x9C
;     659         return; // invalid value
	CALL __LOADLOCR4
	ADIW R28,4
	RET
;     660     
;     661     eeprom_write_w(EEPROM_DEVICE_EXTRA,(WORD)0,(WORD)length);
_0x9C:
	LDI  R30,LOW(166)
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R19
	ST   -Y,R18
	CALL _eeprom_write_w
;     662     
;     663 #ifdef EEPROM_PAGE
;     664     if (length%EEPROM_PAGE)
	MOVW R30,R18
	ANDI R30,LOW(0x3F)
	BREQ _0x9D
;     665         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
	MOVW R26,R18
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	CALL __DIVW21U
	CALL __LSLW2
	CALL __LSLW4
	SUBI R30,LOW(-64)
	SBCI R31,HIGH(-64)
	MOVW R18,R30
;     666 #endif       
;     667     // init I2C bus
;     668     i2c_init();
_0x9D:
	CALL _i2c_init
;     669     LED_STATUS = 0;             
	CBI  0x18,4
;     670     
;     671 #ifdef EEPROM_PAGE          
;     672     for (i =0; i< length; i+=EEPROM_PAGE) 
	__GETWRN 16,17,0
_0x9F:
	__CPWRR 16,17,18,19
	BRLO PC+3
	JMP _0xA0
;     673     {                                 
;     674         eeprom_write_page( EEPROM_DEVICE_EXTRA, i+sizeof(UINT), &szText[i], EEPROM_PAGE );	                                   
	LDI  R30,LOW(166)
	ST   -Y,R30
	MOVW R30,R16
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R16
	SUBI R30,LOW(-_szText_G1)
	SBCI R31,HIGH(-_szText_G1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(64)
	ST   -Y,R30
	CALL _eeprom_write_page
;     675         RESET_WATCHDOG();     
	WDR
;     676     }         
	__ADDWRN 16,17,64
	JMP  _0x9F
_0xA0:
;     677 #else    
;     678     for (i =0; i< length; i++) 
;     679     {                                       
;     680         eeprom_write( EEPROM_DEVICE_EXTRA, i+sizeof(UINT) ,szText[i]);
;     681         RESET_WATCHDOG();	                      
;     682     }
;     683 #endif                         
;     684 
;     685     LED_STATUS = 1;  
	SBI  0x18,4
;     686     
;     687 }                      
	CALL __LOADLOCR4
	ADIW R28,4
	RET
;     688 
;     689 void GetTextFromEEPROM()
;     690 {                         
_GetTextFromEEPROM:
;     691     UINT i =0;              
;     692     UINT length = 0, szLen=0;
;     693     szLen = length = eeprom_read_w(EEPROM_DEVICE_EXTRA,(WORD)0);
	CALL __SAVELOCR6
;	i -> R16,R17
;	length -> R18,R19
;	szLen -> R20,R21
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	LDI  R20,0
	LDI  R21,0
	LDI  R30,LOW(166)
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read_w
	MOVW R18,R30
	MOVW R20,R30
;     694     if (length > sizeof(szText))    
	__CPWRN 18,19,39
	BRLO _0xA1
;     695         return; // invalid param
	CALL __LOADLOCR6
	ADIW R28,6
	RET
;     696 #ifdef EEPROM_PAGE
;     697     if (length%EEPROM_PAGE)
_0xA1:
	MOVW R30,R18
	ANDI R30,LOW(0x3F)
	BREQ _0xA2
;     698         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
	MOVW R26,R18
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	CALL __DIVW21U
	CALL __LSLW2
	CALL __LSLW4
	SUBI R30,LOW(-64)
	SBCI R31,HIGH(-64)
	MOVW R18,R30
;     699 #endif       
;     700     // init I2C bus
;     701     i2c_init();
_0xA2:
	CALL _i2c_init
;     702     LED_STATUS = 0;             
	CBI  0x18,4
;     703 
;     704 #ifdef EEPROM_PAGE          
;     705     for (i =0; i< length; i+=EEPROM_PAGE) 
	__GETWRN 16,17,0
_0xA4:
	__CPWRR 16,17,18,19
	BRLO PC+3
	JMP _0xA5
;     706     {                                 
;     707         eeprom_read_page( EEPROM_DEVICE_EXTRA, i+sizeof(UINT), &szText[i], EEPROM_PAGE );	                                   
	LDI  R30,LOW(166)
	ST   -Y,R30
	MOVW R30,R16
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R16
	SUBI R30,LOW(-_szText_G1)
	SBCI R31,HIGH(-_szText_G1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(64)
	ST   -Y,R30
	CALL _eeprom_read_page
;     708         RESET_WATCHDOG();     
	WDR
;     709     }         
	__ADDWRN 16,17,64
	JMP  _0xA4
_0xA5:
;     710 #else    
;     711     for (i =0; i< length; i++) 
;     712     {                                       
;     713         szText[i] = eeprom_read( EEPROM_DEVICE_EXTRA, i+sizeof(UINT));
;     714         RESET_WATCHDOG();	                      
;     715     }
;     716 #endif                         
;     717     szText[szLen] = '\0';
	LDI  R26,LOW(_szText_G1)
	LDI  R27,HIGH(_szText_G1)
	ADD  R26,R20
	ADC  R27,R21
	LDI  R30,LOW(0)
	ST   X,R30
;     718     LED_STATUS = 1;  
	SBI  0x18,4
;     719 }
	CALL __LOADLOCR6
	ADIW R28,6
	RET
;     720 
;     721 static void LoadTextASCII(WORD rx_wparam, WORD rx_lparam)
;     722 {
_LoadTextASCII_G1:
;     723     UINT i =0;                          
;     724     for (i =0; i< (UINT)rx_wparam; i++)
	ST   -Y,R17
	ST   -Y,R16
;	rx_wparam -> Y+4
;	rx_lparam -> Y+2
;	i -> R16,R17
	LDI  R16,0
	LDI  R17,0
	__GETWRN 16,17,0
_0xA7:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CP   R16,R30
	CPC  R17,R31
	BRLO PC+3
	JMP _0xA8
;     725     {
;     726         szText[i] = getchar();RESET_WATCHDOG();
	MOVW R30,R16
	SUBI R30,LOW(-_szText_G1)
	SBCI R31,HIGH(-_szText_G1)
	PUSH R31
	PUSH R30
	CALL _getchar
	POP  R26
	POP  R27
	ST   X,R30
	WDR
;     727     }
	__ADDWRN 16,17,1
	JMP  _0xA7
_0xA8:
;     728     szText[rx_wparam] = '\0';          
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SUBI R26,LOW(-_szText_G1)
	SBCI R27,HIGH(-_szText_G1)
	LDI  R30,LOW(0)
	ST   X,R30
;     729     SaveTextToEEPROM();
	CALL _SaveTextToEEPROM
;     730            
;     731     if ((rx_lparam>>8) == FRAME_TEXT)
	LDD  R30,Y+3
	ANDI R31,HIGH(0x0)
	SBIW R30,0
	BRNE _0xA9
;     732     {        
;     733         BlankRAM(START_RAM_TEXT,END_RAM);
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     734         TextFromFont(szText,rx_lparam&0x03,rx_lparam&0x04,START_RAM_TEXT+SCREEN_WIDTH,DATA_LENGTH); 
	LDI  R30,LOW(_szText_G1)
	LDI  R31,HIGH(_szText_G1)
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R30,LOW(0x3)
	ANDI R31,HIGH(0x3)
	ST   -Y,R30
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ANDI R30,LOW(0x4)
	ANDI R31,HIGH(0x4)
	ST   -Y,R30
	LDI  R30,LOW(3080)
	LDI  R31,HIGH(3080)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3736)
	LDI  R31,HIGH(3736)
	RJMP _0xE7
;     735     }   
;     736     else
_0xA9:
;     737     {                                    
;     738         BlankRAM(START_RAM_BK,START_RAM_TEXT);                           
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     739         TextFromFont(szText,rx_lparam&0x03,rx_lparam&0x04,START_RAM_BK,SCREEN_WIDTH);                           
	LDI  R30,LOW(_szText_G1)
	LDI  R31,HIGH(_szText_G1)
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R30,LOW(0x3)
	ANDI R31,HIGH(0x3)
	ST   -Y,R30
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ANDI R30,LOW(0x4)
	ANDI R31,HIGH(0x4)
	ST   -Y,R30
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
_0xE7:
	ST   -Y,R31
	ST   -Y,R30
	CALL _TextFromFont_G1
;     740     }    
;     741     start_mem = START_RAM_TEXT + SCREEN_WIDTH;				
	LDI  R30,LOW(3080)
	LDI  R31,HIGH(3080)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     742   	bkgnd_mem = START_RAM_BK;	
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _bkgnd_mem_G1,R30
	STS  _bkgnd_mem_G1+1,R31
;     743 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;     744 ///////////////////////////////////////////////////////////////
;     745 // END static function(s)
;     746 ///////////////////////////////////////////////////////////////
;     747 
;     748 ///////////////////////////////////////////////////////////////           
;     749 
;     750 void InitDevice()
;     751 {
_InitDevice:
;     752 // Declare your local variables here
;     753 // Crystal Oscillator division factor: 1  
;     754 #ifdef _MEGA162_INCLUDED_ 
;     755 #pragma optsize-
;     756 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     757 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     758 #ifdef _OPTIMIZE_SIZE_
;     759 #pragma optsize+
;     760 #endif                    
;     761 #endif
;     762 
;     763 PORTA=0x00;
	OUT  0x1B,R30
;     764 DDRA=0x00;
	OUT  0x1A,R30
;     765 
;     766 PORTB=0x00;
	OUT  0x18,R30
;     767 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     768 
;     769 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     770 DDRC=0x00;
	OUT  0x14,R30
;     771 
;     772 PORTD = 0x00;
	OUT  0x12,R30
;     773 DDRD = 0x00;
	OUT  0x11,R30
;     774 
;     775 PORTE=0x00;
	OUT  0x7,R30
;     776 DDRE=0x05;
	LDI  R30,LOW(5)
	OUT  0x6,R30
;     777 
;     778 // Timer/Counter 0 initialization
;     779 // Clock source: System Clock
;     780 // Clock value: 250.000 kHz
;     781 // Mode: Normal top=FFh
;     782 // OC0 output: Disconnected
;     783 TCCR0=0x03;     // 4 us per tick
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     784 TCNT0=0x05;     // 1ms = 4*250
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     785 OCR0=0x00;      // 255 -250 = TCNT0
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     786 
;     787 #ifdef _MEGA162_INCLUDED_
;     788 UCSR0A=0x00;
	OUT  0xB,R30
;     789 UCSR0B=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     790 UCSR0C=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     791 UBRR0H=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     792 UBRR0L=0x67;      //  16 MHz     
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     793 
;     794 #else // _MEGA8515_INCLUDE_     
;     795 UCSRA=0x00;
;     796 UCSRB=0x98;
;     797 UCSRC=0x86;
;     798 UBRRH=0x00;
;     799 UBRRL=0x33;       // 8 MHz
;     800 #endif
;     801 
;     802 // Lower page wait state(s): None
;     803 // Upper page wait state(s): None
;     804 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     805 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     806 
;     807 // Timer(s)/Counter(s) Interrupt(s) initialization
;     808 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     809 ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
;     810 
;     811 // Load calibration byte for osc.  
;     812 #ifdef _MEGA162_INCLUDED_
;     813 OSCCAL = 0x5E; 
	LDI  R30,LOW(94)
	OUT  0x4,R30
;     814 #else
;     815 OSCCAL = 0xA7; 
;     816 #endif            
;     817 
;     818 // I2C Bus initialization
;     819 // i2c_init();
;     820 
;     821 // DS1307 Real Time Clock initialization
;     822 // Square wave output on pin SQW/OUT: Off
;     823 // SQW/OUT pin state: 1
;     824 // rtc_init(0,0,1);
;     825     
;     826 // Watchdog Timer initialization
;     827 // Watchdog Timer Prescaler: OSC/2048k     
;     828 #ifdef __WATCH_DOG_
;     829 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     830 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     831 #endif
;     832 }
	RET
;     833 
;     834 void PowerReset()
;     835 {   
_PowerReset:
;     836     start_mem = START_RAM_TEXT;     
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     837     end_mem   = END_RAM;
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	STS  _end_mem_G1,R30
	STS  _end_mem_G1+1,R31
;     838     bkgnd_mem = START_RAM_BK;
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _bkgnd_mem_G1,R30
	STS  _bkgnd_mem_G1+1,R31
;     839     org_mem   = START_RAM_TEXT;	                   
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	STS  _org_mem_G1,R30
	STS  _org_mem_G1+1,R31
;     840 
;     841     InitDevice();
	CALL _InitDevice
;     842        
;     843     LED_STATUS = 0;
	CBI  0x18,4
;     844     BlankRAM(START_RAM,END_RAM);    
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     845     delay_ms(500);LED_STATUS = 1;
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
	SBI  0x18,4
;     846     LoadConfig();
	CALL _LoadConfig
;     847    
;     848     GetCharWidth(250);
	LDI  R30,LOW(250)
	LDI  R31,HIGH(250)
	ST   -Y,R31
	ST   -Y,R30
	CALL _GetCharWidth
;     849     current_char_width = 0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _current_char_width_G1,R30
	STS  _current_char_width_G1+1,R31
;     850     next_char_width = 0xFFFF;	 
	STS  _next_char_width_G1,R30
	STS  _next_char_width_G1+1,R31
;     851 
;     852     delay_ms(500);LED_STATUS = 0;
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
	CBI  0x18,4
;     853     LoadToRAM(START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND);  
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _LoadToRAM
;     854     LoadToRAM(START_RAM_TEXT + SCREEN_WIDTH,_save_text_length,FRAME_TEXT);      
	LDI  R30,LOW(3080)
	LDI  R31,HIGH(3080)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(__save_text_length)
	LDI  R27,HIGH(__save_text_length)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _LoadToRAM
;     855     LED_STATUS = 1;             
	SBI  0x18,4
;     856         
;     857     if (sys_mode&MODE_FONT)                 
	LDS  R30,_sys_mode_G1
	ANDI R30,LOW(0x80)
	BREQ _0xAB
;     858     {
;     859         BlankRAM(START_RAM,END_RAM);   
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     860         GetTextFromEEPROM();
	CALL _GetTextFromEEPROM
;     861         TextFromFont(szText, 1, 1, START_RAM_TEXT + SCREEN_WIDTH, DATA_LENGTH);
	LDI  R30,LOW(_szText_G1)
	LDI  R31,HIGH(_szText_G1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(3080)
	LDI  R31,HIGH(3080)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(3736)
	LDI  R31,HIGH(3736)
	ST   -Y,R31
	ST   -Y,R30
	CALL _TextFromFont_G1
;     862         start_mem = START_RAM_TEXT + SCREEN_WIDTH;        
	LDI  R30,LOW(3080)
	LDI  R31,HIGH(3080)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     863     } 
;     864                
;     865     // reload configuration
;     866     LED_STATUS = 0;
_0xAB:
	CBI  0x18,4
;     867     delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     868     LED_STATUS = 1;  
	SBI  0x18,4
;     869     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     870     DDRD = 0x3F;      
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     871 }
	RET
;     872 
;     873 void ProcessCommand()
;     874 {
_ProcessCommand:
;     875    	#asm("cli"); 
	cli
;     876     RESET_WATCHDOG();
	WDR
;     877     // Turn off the scan board           
;     878     _powerOff();
	CALL __powerOff_G1
;     879     // serial message processing     
;     880     switch (rx_message)
	MOV  R30,R8
;     881     {                  
;     882     case LOAD_FONT_MSG:
	CPI  R30,LOW(0x1)
	BRNE _0xAF
;     883         {
;     884             if (rx_wparam > DATA_LENGTH) rx_wparam = DATA_LENGTH;
	LDI  R30,LOW(3736)
	LDI  R31,HIGH(3736)
	CP   R30,R9
	CPC  R31,R10
	BRSH _0xB0
	__PUTW1R 9,10
;     885             BlankRAM(START_RAM_TEXT,END_RAM);                       
_0xB0:
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     886             char_count  = rx_lparam;                   
	__PUTWMRN _char_count_G1,0,11,12
;     887             text_length = rx_wparam;   
	__PUTWMRN _text_length_G1,0,9,10
;     888             SerialToRAM(START_RAM_TEXT,text_length,FRAME_TEXT);             
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _SerialToRAM
;     889             LoadCharWidth(char_count);                                                              
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _LoadCharWidth
;     890 			start_mem = START_RAM_TEXT;				
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     891 	    	bkgnd_mem = START_RAM_BK;										  
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _bkgnd_mem_G1,R30
	STS  _bkgnd_mem_G1+1,R31
;     892         }				
;     893         break;
	RJMP _0xAE
;     894     case LOAD_TEXT_MSG:
_0xAF:
	CPI  R30,LOW(0x2)
	BRNE _0xB1
;     895         {
;     896             if (rx_wparam > DATA_LENGTH) rx_wparam = DATA_LENGTH;
	LDI  R30,LOW(3736)
	LDI  R31,HIGH(3736)
	CP   R30,R9
	CPC  R31,R10
	BRSH _0xB2
	__PUTW1R 9,10
;     897             BlankRAM(START_RAM_TEXT,END_RAM);                       
_0xB2:
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     898             char_count  = rx_lparam;                   
	__PUTWMRN _char_count_G1,0,11,12
;     899             text_length = rx_wparam;   
	__PUTWMRN _text_length_G1,0,9,10
;     900             SerialToRAM(START_RAM_TEXT + SCREEN_WIDTH,text_length,FRAME_TEXT);                
	LDI  R30,LOW(3080)
	LDI  R31,HIGH(3080)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _SerialToRAM
;     901             LoadCharWidth(char_count);                                                              
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _LoadCharWidth
;     902 			start_mem = START_RAM_TEXT + SCREEN_WIDTH;				
	LDI  R30,LOW(3080)
	LDI  R31,HIGH(3080)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     903 	    	bkgnd_mem = START_RAM_BK;		    									  
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _bkgnd_mem_G1,R30
	STS  _bkgnd_mem_G1+1,R31
;     904         }				
;     905         break;
	RJMP _0xAE
;     906     case LOAD_BKGND_MSG:
_0xB1:
	CPI  R30,LOW(0x3)
	BRNE _0xB3
;     907         {
;     908             if (rx_wparam > SCREEN_WIDTH) rx_wparam = SCREEN_WIDTH;
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	CP   R30,R9
	CPC  R31,R10
	BRSH _0xB4
	__PUTW1R 9,10
;     909             BlankRAM(START_RAM_BK,START_RAM_TEXT);                    
_0xB4:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     910             SerialToRAM(START_RAM_BK,rx_wparam,FRAME_BKGND);                                               
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R10
	ST   -Y,R9
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _SerialToRAM
;     911 		    start_mem = START_RAM_TEXT + SCREEN_WIDTH;				
	LDI  R30,LOW(3080)
	LDI  R31,HIGH(3080)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     912 		    bkgnd_mem = START_RAM_BK;				    
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _bkgnd_mem_G1,R30
	STS  _bkgnd_mem_G1+1,R31
;     913 		}
;     914         break;     
	RJMP _0xAE
;     915     case EEPROM_LOAD_FONT_MSG:
_0xB3:
	CPI  R30,LOW(0x4)
	BRNE _0xB5
;     916         {
;     917             LoadToRAM(START_RAM_TEXT,text_length,FRAME_FONT);                                                
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _LoadToRAM
;     918         }
;     919         break;                
	RJMP _0xAE
;     920     case EEPROM_SAVE_FONT_MSG:
_0xB5:
	CPI  R30,LOW(0x5)
	BRNE _0xB6
;     921         {                               									                                          
;     922             SaveToEEPROM(START_RAM_TEXT,text_length,FRAME_FONT);                 
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _SaveToEEPROM
;     923             SaveFontHeader(char_count);                      
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _SaveFontHeader
;     924         }
;     925         break;
	RJMP _0xAE
;     926     case EEPROM_LOAD_TEXT_MSG:
_0xB6:
	CPI  R30,LOW(0x6)
	BRNE _0xB7
;     927         {          
;     928             LoadToRAM(START_RAM_TEXT + SCREEN_WIDTH,text_length = _save_text_length,FRAME_TEXT);
	LDI  R30,LOW(3080)
	LDI  R31,HIGH(3080)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(__save_text_length)
	LDI  R27,HIGH(__save_text_length)
	CALL __EEPROMRDW
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _LoadToRAM
;     929         }
;     930         break;                   
	RJMP _0xAE
;     931     case EEPROM_SAVE_TEXT_MSG:
_0xB7:
	CPI  R30,LOW(0x7)
	BRNE _0xB8
;     932         {                                                
;     933             SaveToEEPROM(START_RAM_TEXT,_save_text_length = text_length,FRAME_TEXT);       
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	LDI  R26,LOW(__save_text_length)
	LDI  R27,HIGH(__save_text_length)
	CALL __EEPROMWRW
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _SaveToEEPROM
;     934             SaveCharWidth(char_count);   
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _SaveCharWidth
;     935         }
;     936         break;
	RJMP _0xAE
;     937     case EEPROM_LOAD_BKGND_MSG:
_0xB8:
	CPI  R30,LOW(0x8)
	BRNE _0xB9
;     938         {                                                                  
;     939             LoadToRAM(START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND);                                                                                                           
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _LoadToRAM
;     940         }  
;     941         break;                 
	RJMP _0xAE
;     942     case EEPROM_SAVE_BKGND_MSG:
_0xB9:
	CPI  R30,LOW(0x9)
	BRNE _0xBA
;     943         {                                                                  
;     944             SaveToEEPROM(START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _SaveToEEPROM
;     945         }
;     946         break;
	RJMP _0xAE
;     947     case EEPROM_LOAD_ALL_MSG:
_0xBA:
	CPI  R30,LOW(0xA)
	BRNE _0xBB
;     948         {   
;     949             LoadToRAM(START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND);     
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _LoadToRAM
;     950             LoadToRAM(START_RAM_TEXT + SCREEN_WIDTH,text_length = _save_text_length,FRAME_TEXT);
	LDI  R30,LOW(3080)
	LDI  R31,HIGH(3080)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(__save_text_length)
	LDI  R27,HIGH(__save_text_length)
	CALL __EEPROMRDW
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _LoadToRAM
;     951         }
;     952         break;                
	RJMP _0xAE
;     953     case EEPROM_SAVE_ALL_MSG:
_0xBB:
	CPI  R30,LOW(0xB)
	BRNE _0xBC
;     954         {       
;     955             SaveCharWidth(char_count);   
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _SaveCharWidth
;     956             SaveToEEPROM(START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _SaveToEEPROM
;     957             SaveToEEPROM(START_RAM_TEXT,_save_text_length = text_length,FRAME_TEXT);
	LDI  R30,LOW(2880)
	LDI  R31,HIGH(2880)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	LDI  R26,LOW(__save_text_length)
	LDI  R27,HIGH(__save_text_length)
	CALL __EEPROMWRW
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _SaveToEEPROM
;     958         }            
;     959         break;
	RJMP _0xAE
;     960     case SET_RTC_MSG:
_0xBC:
	CPI  R30,LOW(0xC)
	BRNE _0xBD
;     961         {                                
;     962             SetRTCDateTime();
	CALL _SetRTCDateTime
;     963         }
;     964         break;
	RJMP _0xAE
;     965     case SET_CFG_MSG:
_0xBD:
	CPI  R30,LOW(0xD)
	BRNE _0xBE
;     966         {
;     967             _cfg_shift_rate  = shift_rate  = rx_wparam&0x00ff;
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	STS  _shift_rate_G1,R30
	LDI  R26,LOW(__cfg_shift_rate)
	LDI  R27,HIGH(__cfg_shift_rate)
	CALL __EEPROMWRB
;     968             _cfg_shift_step  = shift_step  = rx_wparam>>8;                       
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	STS  _shift_step_G1,R30
	LDI  R26,LOW(__cfg_shift_step)
	LDI  R27,HIGH(__cfg_shift_step)
	CALL __EEPROMWRB
;     969             _cfg_frm_delay   = frm_delay   = rx_lparam&0x00ff;
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	STS  _frm_delay_G1,R30
	LDI  R26,LOW(__cfg_frm_delay)
	LDI  R27,HIGH(__cfg_frm_delay)
	CALL __EEPROMWRB
;     970             _cfg_sys_mode    = sys_mode    = rx_lparam>>8;                     
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	STS  _sys_mode_G1,R30
	LDI  R26,LOW(__cfg_sys_mode)
	LDI  R27,HIGH(__cfg_sys_mode)
	CALL __EEPROMWRB
;     971             // preset value for scrolling, must be set here
;     972             current_char_width = next_char_width = 0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _next_char_width_G1,R30
	STS  _next_char_width_G1+1,R31
	STS  _current_char_width_G1,R30
	STS  _current_char_width_G1+1,R31
;     973         }
;     974         break;
	RJMP _0xAE
;     975     case LOAD_DEFAULT_MSG:
_0xBE:
	CPI  R30,LOW(0xE)
	BRNE _0xBF
;     976         {
;     977             _cfg_shift_rate  = shift_rate  = 10;
	LDI  R30,LOW(10)
	STS  _shift_rate_G1,R30
	LDI  R26,LOW(__cfg_shift_rate)
	LDI  R27,HIGH(__cfg_shift_rate)
	CALL __EEPROMWRB
;     978             _cfg_shift_step  = shift_step  = 1;
	LDI  R30,LOW(1)
	STS  _shift_step_G1,R30
	LDI  R26,LOW(__cfg_shift_step)
	LDI  R27,HIGH(__cfg_shift_step)
	CALL __EEPROMWRB
;     979             _cfg_sys_mode    = sys_mode    = 0x0F;
	LDI  R30,LOW(15)
	STS  _sys_mode_G1,R30
	LDI  R26,LOW(__cfg_sys_mode)
	LDI  R27,HIGH(__cfg_sys_mode)
	CALL __EEPROMWRB
;     980             _cfg_frm_delay   = frm_delay   = 100; 
	LDI  R30,LOW(100)
	STS  _frm_delay_G1,R30
	LDI  R26,LOW(__cfg_frm_delay)
	LDI  R27,HIGH(__cfg_frm_delay)
	CALL __EEPROMWRB
;     981             _save_text_length = text_length = SCREEN_WIDTH;
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
	LDI  R26,LOW(__save_text_length)
	LDI  R27,HIGH(__save_text_length)
	CALL __EEPROMWRW
;     982         }	 	                 
;     983         break;           
	RJMP _0xAE
;     984     case LOAD_TEXT_ASCII_MSG:
_0xBF:
	CPI  R30,LOW(0xF)
	BRNE _0xC1
;     985         {                                                
;     986             LoadTextASCII(rx_wparam,rx_lparam);
	ST   -Y,R10
	ST   -Y,R9
	ST   -Y,R12
	ST   -Y,R11
	CALL _LoadTextASCII_G1
;     987         }                    
;     988         break;
;     989     default:
_0xC1:
;     990         break;
;     991     }                 
_0xAE:
;     992     send_echo_msg();            
	RCALL _send_echo_msg
;     993     rx_message = UNKNOWN_MSG;
	CLR  R8
;     994     #asm("sei");
	sei
;     995     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     996     DDRD = 0x3F;     
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     997 
;     998 }          
	RET
;     999 ////////////////////////////////////////////////////////////////////////////////
;    1000 // MAIN PROGRAM
;    1001 ////////////////////////////////////////////////////////////////////////////////
;    1002 void main(void)
;    1003 {         
_main:
;    1004     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0xC2
;    1005         // Watchdog Reset
;    1006         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;    1007         reset_serial(); 
	RCALL _reset_serial
;    1008     }
;    1009     else {      
	RJMP _0xC3
_0xC2:
;    1010         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;    1011     }                                     
_0xC3:
;    1012      
;    1013     PowerReset();                        
	CALL _PowerReset
;    1014     #asm("sei");     
	sei
;    1015             
;    1016     while (1){                     
_0xC4:
;    1017         if (rx_message != UNKNOWN_MSG){   
	TST  R8
	BREQ _0xC7
;    1018             ProcessCommand();   
	CALL _ProcessCommand
;    1019         }
;    1020         else{           
	RJMP _0xC8
_0xC7:
;    1021             _displayFrame();
	CALL __displayFrame_G1
;    1022             _doScroll();                        
	CALL __doScroll_G1
;    1023         }
_0xC8:
;    1024         RESET_WATCHDOG();
	WDR
;    1025     };
	JMP  _0xC4
;    1026 }
_0xC9:
	NOP
	RJMP _0xC9
;    1027                          
;    1028 #include "define.h"
;    1029 
;    1030 ///////////////////////////////////////////////////////////////
;    1031 // serial interrupt handle - processing serial message ...
;    1032 ///////////////////////////////////////////////////////////////
;    1033 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;    1034 ///////////////////////////////////////////////////////////////
;    1035 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;    1036 extern BYTE  rx_message;
;    1037 extern WORD  rx_wparam;
;    1038 extern WORD  rx_lparam;
;    1039 
;    1040 #if RX_BUFFER_SIZE<256
;    1041 unsigned char rx_wr_index,rx_counter;
;    1042 #else
;    1043 unsigned int rx_wr_index,rx_counter;
;    1044 #endif
;    1045 
;    1046 void send_echo_msg();
;    1047 
;    1048 // USART Receiver interrupt service routine
;    1049 #ifdef _MEGA162_INCLUDED_                    
;    1050 interrupt [USART0_RXC] void usart_rx_isr(void)
;    1051 #else
;    1052 interrupt [USART_RXC] void usart_rx_isr(void)
;    1053 #endif
;    1054 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;    1055 char status,data;
;    1056 #ifdef _MEGA162_INCLUDED_  
;    1057 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;    1058 data=UDR0;
	IN   R17,12
;    1059 #else     
;    1060 status=UCSRA;
;    1061 data=UDR;
;    1062 #endif          
;    1063     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+3
	JMP _0xCA
;    1064     {
;    1065         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R13
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;    1066         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0xCB
	CLR  R13
;    1067         if (++rx_counter == RX_BUFFER_SIZE)
_0xCB:
	INC  R14
	LDI  R30,LOW(8)
	CP   R30,R14
	BRNE _0xCC
;    1068         {
;    1069             rx_counter=0;
	CLR  R14
;    1070             if (
;    1071                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;    1072                 rx_buffer[2]==WAKEUP_CHAR 
;    1073                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BRNE _0xCE
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BRNE _0xCE
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ _0xCF
_0xCE:
	RJMP _0xCD
_0xCF:
;    1074             {
;    1075                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 8,_rx_buffer,3
;    1076                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 9,_rx_buffer,4
	CLR  R10
;    1077                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R9
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 9,10
;    1078                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 11,_rx_buffer,6
	CLR  R12
;    1079                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;    1080             }
;    1081             else if(
	RJMP _0xD0
_0xCD:
;    1082                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;    1083                 rx_buffer[2]==ESCAPE_CHAR 
;    1084                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0xD2
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0xD2
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0xD3
_0xD2:
	RJMP _0xD1
_0xD3:
;    1085             {
;    1086                 rx_wr_index=0;
	CLR  R13
;    1087                 rx_counter =0;
	CLR  R14
;    1088             }      
;    1089         };
_0xD1:
_0xD0:
_0xCC:
;    1090     };
_0xCA:
;    1091 }
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;    1092 
;    1093 void send_echo_msg()
;    1094 {
_send_echo_msg:
;    1095     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;    1096     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;    1097     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;    1098     putchar(rx_message);
	ST   -Y,R8
	CALL _putchar
;    1099     putchar(rx_wparam>>8);
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;    1100     putchar(rx_wparam&0x00FF);
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;    1101     putchar(rx_lparam>>8);        
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;    1102     putchar(rx_lparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;    1103 }  
	RET
;    1104 
;    1105 void reset_serial()
;    1106 {
_reset_serial:
;    1107     rx_wr_index=0;
	CLR  R13
;    1108     rx_counter =0;
	CLR  R14
;    1109     rx_message = UNKNOWN_MSG;
	CLR  R8
;    1110 }
	RET
;    1111 
;    1112 ///////////////////////////////////////////////////////////////
;    1113 // END serial interrupt handle
;    1114 /////////////////////////////////////////////////////////////// 
;    1115 /*****************************************************
;    1116 This program was produced by the
;    1117 CodeWizardAVR V1.24.4a Standard
;    1118 Automatic Program Generator
;    1119 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;    1120 http://www.hpinfotech.com
;    1121 e-mail:office@hpinfotech.com
;    1122 
;    1123 Project : 
;    1124 Version : 
;    1125 Date    : 19/5/2005
;    1126 Author  : 3iGROUP                
;    1127 Company : http://www.3ihut.net   
;    1128 Comments: 
;    1129 
;    1130 
;    1131 Chip type           : ATmega8515
;    1132 Program type        : Application
;    1133 Clock frequency     : 8.000000 MHz
;    1134 Memory model        : Small
;    1135 External SRAM size  : 32768
;    1136 Ext. SRAM wait state: 0
;    1137 Data Stack size     : 128
;    1138 *****************************************************/
;    1139 
;    1140 #include "define.h"                                           
;    1141 
;    1142 #define     ACK                 1
;    1143 #define     NO_ACK              0
;    1144 
;    1145 // I2C Bus functions
;    1146 #asm
;    1147    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;    1148    .equ __sda_bit=3
   .equ __sda_bit=3
;    1149    .equ __scl_bit=2
   .equ __scl_bit=2
;    1150 #endasm                   
;    1151 
;    1152 #ifdef __EEPROM_WRITE_BYTE
;    1153 BYTE eeprom_read(BYTE deviceID, WORD address) 
;    1154 {
_eeprom_read:
;    1155     BYTE data;
;    1156     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	address -> Y+1
;	data -> R16
	CALL _i2c_start
;    1157     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;    1158     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;    1159     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;    1160     
;    1161     i2c_start();
	CALL _i2c_start
;    1162     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;    1163     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R16,R30
;    1164     i2c_stop();
	CALL _i2c_stop
;    1165     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0xDE
;    1166 }
;    1167 
;    1168 void eeprom_write(BYTE deviceID, WORD address, BYTE data) 
;    1169 {
_eeprom_write:
;    1170     i2c_start();
	CALL _i2c_start
;    1171     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;    1172     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;    1173     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;    1174     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	CALL _i2c_write
;    1175     i2c_stop();
	CALL _i2c_stop
;    1176 
;    1177     /* 10ms delay to complete the write operation */
;    1178     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;    1179 }                                 
_0xDE:
	ADIW R28,4
	RET
;    1180 
;    1181 WORD eeprom_read_w(BYTE deviceID, WORD address)
;    1182 {
_eeprom_read_w:
;    1183     WORD result = 0;
;    1184     result = eeprom_read(deviceID,address*2);
	ST   -Y,R17
	ST   -Y,R16
;	deviceID -> Y+4
;	address -> Y+2
;	result -> R16,R17
	LDI  R16,0
	LDI  R17,0
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	LSL  R30
	ROL  R31
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	MOV  R16,R30
	CLR  R17
;    1185     result = (result<<8) | eeprom_read(deviceID,address*2+1);
	MOV  R31,R16
	LDI  R30,LOW(0)
	PUSH R31
	PUSH R30
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	LSL  R30
	ROL  R31
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	POP  R26
	POP  R27
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	MOVW R16,R30
;    1186     return result;
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0xDD
;    1187 }
;    1188 void eeprom_write_w(BYTE deviceID, WORD address, WORD data)
;    1189 {
_eeprom_write_w:
;    1190     eeprom_write(deviceID,address*2,data>>8);
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	LSL  R30
	ROL  R31
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _eeprom_write
;    1191     eeprom_write(deviceID,address*2+1,data&0x0FF);    
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	LSL  R30
	ROL  R31
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _eeprom_write
;    1192 }
_0xDD:
	ADIW R28,5
	RET
;    1193 
;    1194 #endif // __EEPROM_WRITE_BYTE
;    1195 void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;    1196 {
_eeprom_read_page:
;    1197     BYTE i = 0;
;    1198     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;    1199     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;    1200     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;    1201     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;    1202     
;    1203     i2c_start();
	CALL _i2c_start
;    1204     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;    1205                                     
;    1206     while ( i < page_size-1 )
_0xD4:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0xD6
;    1207     {
;    1208         buffer[i++] = i2c_read(ACK);   // read at current
	MOV  R30,R16
	SUBI R16,-1
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_read
	POP  R26
	POP  R27
	ST   X,R30
;    1209     }
	RJMP _0xD4
_0xD6:
;    1210     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	POP  R26
	POP  R27
	ST   X,R30
;    1211          
;    1212     i2c_stop();
	CALL _i2c_stop
;    1213 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;    1214 
;    1215 void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;    1216 {
_eeprom_write_page:
;    1217     BYTE i = 0;
;    1218     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;    1219     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;    1220     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;    1221     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;    1222                                         
;    1223     while ( i < page_size )
_0xD7:
	LDD  R30,Y+1
	CP   R16,R30
	BRLO PC+3
	JMP _0xD9
;    1224     {
;    1225         i2c_write(buffer[i++]);
	MOV  R30,R16
	SUBI R16,-1
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	ST   -Y,R30
	CALL _i2c_write
;    1226         #asm("nop");#asm("nop");
	nop
	nop
;    1227     }          
	JMP  _0xD7
_0xD9:
;    1228     i2c_stop(); 
	CALL _i2c_stop
;    1229     delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;    1230 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;    1231                                               

_getchar:
     sbis usr,rxc
     rjmp _getchar
     in   r30,udr
	RET
_putchar:
     sbis usr,udre
     rjmp _putchar
     ld   r30,y
     out  udr,r30
	ADIW R28,1
	RET
_rtc_set_time:
	CALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	CALL _i2c_write
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_write
	LD   R30,Y
	ST   -Y,R30
	CALL _bin2bcd
	ST   -Y,R30
	CALL _i2c_write
	LDD  R30,Y+1
	ST   -Y,R30
	CALL _bin2bcd
	ST   -Y,R30
	CALL _i2c_write
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _bin2bcd
	ST   -Y,R30
	CALL _i2c_write
	CALL _i2c_stop
	RJMP _0xDC
_rtc_set_date:
	CALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	CALL _i2c_write
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL _i2c_write
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _bin2bcd
	ST   -Y,R30
	CALL _i2c_write
	LDD  R30,Y+1
	ST   -Y,R30
	CALL _bin2bcd
	ST   -Y,R30
	CALL _i2c_write
	LD   R30,Y
	ST   -Y,R30
	CALL _bin2bcd
	ST   -Y,R30
	CALL _i2c_write
	CALL _i2c_stop
_0xDC:
	ADIW R28,3
	RET

	.equ __i2c_dir=__i2c_port-1
	.equ __i2c_pin=__i2c_port-2
_i2c_init:
	cbi  __i2c_port,__scl_bit
	cbi  __i2c_port,__sda_bit
	sbi  __i2c_dir,__scl_bit
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay2
_i2c_start:
	cbi  __i2c_dir,__sda_bit
	cbi  __i2c_dir,__scl_bit
	clr  r30
	nop
	sbis __i2c_pin,__sda_bit
	ret
	sbis __i2c_pin,__scl_bit
	ret
	rcall __i2c_delay1
	sbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	ldi  r30,1
__i2c_delay1:
	ldi  r22,27
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir,__sda_bit
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
__i2c_delay2:
	ldi  r22,53
__i2c_delay2l:
	dec  r22
	brne __i2c_delay2l
	ret
_i2c_read:
	ldi  r23,8
__i2c_read0:
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_read3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_read3
	rcall __i2c_delay1
	clc
	sbic __i2c_pin,__sda_bit
	sec
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	rol  r30
	dec  r23
	brne __i2c_read0
	ld   r23,y+
	tst  r23
	brne __i2c_read1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_read2
__i2c_read1:
	sbi  __i2c_dir,__sda_bit
__i2c_read2:
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay1

_i2c_write:
	ld   r30,y+
	ldi  r23,8
__i2c_write0:
	lsl  r30
	brcc __i2c_write1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_write2
__i2c_write1:
	sbi  __i2c_dir,__sda_bit
__i2c_write2:
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_write3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_write3
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	dec  r23
	brne __i2c_write0
	cbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	ldi  r30,1
	sbic __i2c_pin,__sda_bit
	clr  r30
	sbi  __i2c_dir,__scl_bit
	ret

_strlen:
	ld   r26,y+
	ld   r27,y+
	clr  r30
	clr  r31
__strlen0:
	ld   r22,x+
	tst  r22
	breq __strlen1
	adiw r30,1
	rjmp __strlen0
__strlen1:
	ret

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

_bcd2bin:
	ld   r30,y
	swap r30
	andi r30,0xf
	mov  r26,r30
	lsl  r26
	lsl  r26
	add  r30,r26
	lsl  r30
	ld   r26,y+
	andi r26,0xf
	add  r30,r26
	ret

_bin2bcd:
	ld   r26,y+
	clr  r30
__bin2bcd0:
	subi r26,10
	brmi __bin2bcd1
	subi r30,-16
	rjmp __bin2bcd0
__bin2bcd1:
	subi r26,-10
	add  r30,r26
	ret

__ANEGW1:
	COM  R30
	COM  R31
	ADIW R30,1
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__EEPROMRDW:
	ADIW R26,1
	RCALL __EEPROMRDB
	MOV  R31,R30
	SBIW R26,1

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRW:
	RCALL __EEPROMWRB
	ADIW R26,1
	PUSH R30
	MOV  R30,R31
	RCALL __EEPROMWRB
	POP  R30
	SBIW R26,1
	RET

__EEPROMWRB:
	SBIC EECR,EEWE
	RJMP __EEPROMWRB
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD R26,R28
	ADC R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
