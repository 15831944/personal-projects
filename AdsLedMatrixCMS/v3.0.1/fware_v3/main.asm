
;CodeVisionAVR C Compiler V1.25.1 Standard
;(C) Copyright 1998-2006 Pavel Haiduc, HP InfoTech s.r.l.
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

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
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

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
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

	.MACRO __PUTBR0MN
	STS  @0+@1,R0
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
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
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
;      32 
;      33 bit data_bit = 0;       
;      34 bit power_off = 0;
;      35 bit is_stopping = 0;
;      36 
;      37 register UINT x=0;
;      38 register UINT y=0;   
;      39                                 
;      40 static int   scroll_count = 0;
_scroll_count_G1:
	.BYTE 0x2
;      41 static UINT  tick_count  = 0;       
_tick_count_G1:
	.BYTE 0x2
;      42 static UINT  stopping_count = 0;       
_stopping_count_G1:
	.BYTE 0x2
;      43 static BYTE  frame_index = 0;   
_frame_index_G1:
	.BYTE 0x1
;      44 
;      45 static UINT  text_length = 0;              
_text_length_G1:
	.BYTE 0x2
;      46 static BYTE  scroll_rate = 20;
_scroll_rate_G1:
	.BYTE 0x1
;      47 static BYTE  scroll_type = LEFT_RIGHT;            
_scroll_type_G1:
	.BYTE 0x1
;      48              
;      49 // Global variables for message control
;      50 BYTE  rx_message = UNKNOWN_MSG;
;      51 WORD  rx_wparam  = 0;
;      52 WORD  rx_lparam  = 0;
;      53 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;      54                             
;      55 extern void reset_serial();         
;      56 extern void send_echo_msg();    
;      57 extern BYTE eeprom_read(BYTE deviceID, WORD address);
;      58 extern void eeprom_write(BYTE deviceID, WORD address, BYTE data);
;      59 extern WORD eeprom_read_w(BYTE deviceID, WORD address);
;      60 extern void eeprom_write_w(BYTE deviceID, WORD address, WORD data);
;      61 extern void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      62 extern void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      63 
;      64 static void _displayFrame();
;      65 static void _doScroll();   
;      66 void LoadFrame(BYTE index);
;      67 void BlankRAM(PBYTE start_addr,PBYTE end_addr);
;      68 
;      69 ///////////////////////////////////////////////////////////////
;      70 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;      71 ///////////////////////////////////////////////////////////////
;      72 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;      73 {       

	.CSEG
_timer0_ovf_isr:
;      74     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;      75     ++tick_count;    
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	ADIW R30,1
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R31
;      76 }
	RETI
;      77 
;      78 ///////////////////////////////////////////////////////////////
;      79 // static function(s) for led matrix display panel
;      80 ///////////////////////////////////////////////////////////////
;      81 
;      82 static void _putData()
;      83 {                                                
__putData_G1:
	PUSH R15
;      84     for (y=0; y< SCREEN_HEIGHT; y++){             
	CLR  R6
	CLR  R7
_0x5:
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	CP   R6,R30
	CPC  R7,R31
	BRLO PC+3
	JMP _0x6
;      85         data_bit = (start_mem[(y)/8 + 4*(x)]>>(y%8)) & 0x01; 					
	MOVW R30,R6
	CALL __LSRW3
	MOVW R26,R30
	MOVW R30,R4
	CALL __LSLW2
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	MOVW R30,R6
	ANDI R30,LOW(0x7)
	ANDI R31,HIGH(0x7)
	LDI  R27,0
	CALL __ASRW12
	BST  R30,0
	BLD  R2,0
;      86         if (power_off) data_bit =OFF_LED;
	SBRS R2,1
	RJMP _0x7
	SET
	BLD  R2,0
;      87                
;      88         if (scroll_type == BOTTOM_TOP){
_0x7:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0x8
;      89             if (SCREEN_HEIGHT -y > (SCREEN_HEIGHT<<1) -scroll_count)
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	SUB  R30,R6
	SBC  R31,R7
	MOVW R0,R30
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	SUB  R30,R26
	SBC  R31,R27
	CP   R30,R0
	CPC  R31,R1
	BRLO PC+3
	JMP _0x9
;      90                 CTRL_OUT = OFF_LED;
	SBI  0x18,3
;      91             else                   
	RJMP _0xA
_0x9:
;      92                 CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;      93         }   
_0xA:
;      94         else if (scroll_type == TOP_BOTTOM){
	RJMP _0xB
_0x8:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0xC
;      95             if (y >= scroll_count -SCREEN_HEIGHT){
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,16
	CP   R6,R30
	CPC  R7,R31
	BRSH PC+3
	JMP _0xD
;      96                 if (scroll_count >= SCREEN_HEIGHT)
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRGE PC+3
	JMP _0xE
;      97                     CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;      98                 else                   
	RJMP _0xF
_0xE:
;      99                     CTRL_OUT = OFF_LED;
	SBI  0x18,3
;     100             }
_0xF:
;     101             else{                      
	RJMP _0x10
_0xD:
;     102                 if (scroll_count >= SCREEN_HEIGHT)
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRGE PC+3
	JMP _0x11
;     103                     CTRL_OUT = OFF_LED;
	SBI  0x18,3
;     104                 else                   
	RJMP _0x12
_0x11:
;     105                     CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;     106             }
_0x12:
_0x10:
;     107         }
;     108         else{                   
	RJMP _0x13
_0xC:
;     109             CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;     110         }                                 
_0x13:
_0xB:
;     111         __CTRL_CLK();	    		
	__DELAY_USB 5
	SBI  0x18,2
	__DELAY_USB 5
	CBI  0x18,2
;     112     }            
_0x4:
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	RJMP _0x5
_0x6:
;     113      
;     114     if (scroll_type==TOP_BOTTOM || scroll_type == BOTTOM_TOP){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x2)
	BRNE PC+3
	JMP _0x15
	CPI  R26,LOW(0x3)
	BRNE PC+3
	JMP _0x15
	RJMP _0x14
_0x15:
;     115         if (SCREEN_HEIGHT >= scroll_count){      
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,17
	BRLT PC+3
	JMP _0x17
;     116             int i =0;               
;     117             CTRL_OUT = OFF_LED; // turn off the LED
	SBIW R28,2
	LDI  R24,2
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x18*2)
	LDI  R31,HIGH(_0x18*2)
	CALL __INITLOCB
;	i -> Y+0
	SBI  0x18,3
;     118             for (i =0; i< (SCREEN_HEIGHT-scroll_count);i++)
	LDI  R30,0
	STD  Y+0,R30
	STD  Y+0+1,R30
_0x1A:
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	SUB  R30,R26
	SBC  R31,R27
	LD   R26,Y
	LDD  R27,Y+1
	CP   R26,R30
	CPC  R27,R31
	BRLT PC+3
	JMP _0x1B
;     119                 __CTRL_CLK();                           
	__DELAY_USB 5
	SBI  0x18,2
	__DELAY_USB 5
	CBI  0x18,2
_0x19:
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,1
	ST   Y,R30
	STD  Y+1,R31
	RJMP _0x1A
_0x1B:
;     120         }
	ADIW R28,2
;     121     }
_0x17:
;     122         
;     123 	__CTRL_STB();
_0x14:
	__DELAY_USB 5
	SBI  0x18,4
	__DELAY_USB 5
	CBI  0x18,4
;     124 }
	RET
;     125 
;     126 static void _displayFrame()
;     127 {                                  
__displayFrame_G1:
	PUSH R15
;     128 	for (x=0; x< SCREEN_WIDTH; x++){
	CLR  R4
	CLR  R5
_0x1D:
	LDI  R30,LOW(192)
	LDI  R31,HIGH(192)
	CP   R4,R30
	CPC  R5,R31
	BRLO PC+3
	JMP _0x1E
;     129 		_putData();
	CALL __putData_G1
;     130 		__DATA_CLK();					
	SBI  0x18,0
	CBI  0x18,0
;     131 	}           
_0x1C:
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x1D
_0x1E:
;     132     __DATA_STB();             	
	SBI  0x18,1
	CBI  0x18,1
;     133 }     
	RET
;     134                                                                                   
;     135 static void _doScroll()
;     136 {                                        
__doScroll_G1:
	PUSH R15
;     137   if (tick_count > scroll_rate){    
	LDS  R30,_scroll_rate_G1
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRLO PC+3
	JMP _0x1F
;     138     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     139     {
;     140     case LEFT_RIGHT:                
	CPI  R30,0
	BREQ PC+3
	JMP _0x23
;     141         if (is_stopping==0){   
	SBRC R2,2
	RJMP _0x24
;     142             if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRSH PC+3
	JMP _0x25
;     143        	        start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     144        	    else 
	RJMP _0x26
_0x25:
;     145        	        start_mem += 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     146    	    }
_0x26:
;     147    	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
_0x24:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xB00)
	LDI  R30,HIGH(0xB00)
	CPC  R27,R30
	BREQ PC+3
	JMP _0x27
;     148    	        is_stopping = 1;
	SET
	BLD  R2,2
;     149    	    if (is_stopping ==1)
_0x27:
	SBRS R2,2
	RJMP _0x28
;     150    	    {
;     151    	        if (stopping_count++>MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRSH PC+3
	JMP _0x29
;     152    	        {
;     153    	            is_stopping=0;
	CLT
	BLD  R2,2
;     154    	            stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     155    	        }
;     156    	    }                                  
_0x29:
;     157        	if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
_0x28:
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-224)
	SBCI R31,HIGH(-224)
	CALL __LSLW2
	SUBI R30,LOW(-2048)
	SBCI R31,HIGH(-2048)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRLO PC+3
	JMP _0x2A
;     158    	    {         
;     159    	        frame_index++;         
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
;     160    	        LoadFrame(frame_index);
	ST   -Y,R30
	CALL _LoadFrame
;     161        	}           
;     162    	    break;
_0x2A:
	RJMP _0x22
;     163     case RIGHT_LEFT:
_0x23:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x2B
;     164        	if (is_stopping==0){
	SBRC R2,2
	RJMP _0x2C
;     165    	        if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRSH PC+3
	JMP _0x2D
;     166    	            start_mem -= 4;      
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SBIW R30,4
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     167    	        else
	RJMP _0x2E
_0x2D:
;     168    	            start_mem -= 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SBIW R30,8
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     169    	        
;     170    	    }
_0x2E:
;     171    	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
_0x2C:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xB00)
	LDI  R30,HIGH(0xB00)
	CPC  R27,R30
	BREQ PC+3
	JMP _0x2F
;     172    	        is_stopping = 1;
	SET
	BLD  R2,2
;     173    	    if (is_stopping ==1)
_0x2F:
	SBRS R2,2
	RJMP _0x30
;     174    	    {
;     175    	        if (stopping_count++ >MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRSH PC+3
	JMP _0x31
;     176    	        {
;     177    	            is_stopping=0;
	CLT
	BLD  R2,2
;     178    	            stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     179    	        }
;     180    	    }
_0x31:
;     181    	    else if (start_mem < START_RAM_TEXT)             
	RJMP _0x32
_0x30:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0x800)
	LDI  R30,HIGH(0x800)
	CPC  R27,R30
	BRLO PC+3
	JMP _0x33
;     182        	{
;     183        	    scroll_count = 0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     184    	        frame_index++;             
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
;     185    	        LoadFrame(frame_index);
	ST   -Y,R30
	CALL _LoadFrame
;     186        	}
;     187        	break;
_0x33:
_0x32:
	RJMP _0x22
;     188     case BOTTOM_TOP:               
_0x2B:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x34
;     189         if (scroll_count >=0){        
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,0
	BRGE PC+3
	JMP _0x35
;     190             scroll_count--;   
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     191         }
;     192         else{
	RJMP _0x36
_0x35:
;     193             frame_index++;
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
;     194             scroll_count = 0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     195             LoadFrame(frame_index);   
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	CALL _LoadFrame
;     196         }
_0x36:
;     197         if (is_stopping==1)
	SBRS R2,2
	RJMP _0x37
;     198         {               
;     199             if (stopping_count++ > MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRSH PC+3
	JMP _0x38
;     200             {
;     201                 is_stopping = 0;
	CLT
	BLD  R2,2
;     202                 stopping_count = 0; 
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     203             }
;     204             else{
	RJMP _0x39
_0x38:
;     205                 scroll_count++;
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	ADIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     206             }
_0x39:
;     207         }   
;     208         if (scroll_count == SCREEN_HEIGHT){
_0x37:
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BREQ PC+3
	JMP _0x3A
;     209             is_stopping = 1;
	SET
	BLD  R2,2
;     210         }
;     211         
;     212         break;
_0x3A:
	RJMP _0x22
;     213     case TOP_BOTTOM:
_0x34:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x3B
;     214         if (scroll_count == SCREEN_HEIGHT){
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BREQ PC+3
	JMP _0x3C
;     215             is_stopping = 1;
	SET
	BLD  R2,2
;     216         }                   
;     217         if (scroll_count <= (SCREEN_HEIGHT<<1)){ 
_0x3C:
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,33
	BRLT PC+3
	JMP _0x3D
;     218             scroll_count++;                
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	ADIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     219         }
;     220         else {
	RJMP _0x3E
_0x3D:
;     221             stopping_count = 0;  
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     222             frame_index++;
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
;     223             LoadFrame(frame_index);                              
	ST   -Y,R30
	CALL _LoadFrame
;     224         }  
_0x3E:
;     225         if (is_stopping==1)
	SBRS R2,2
	RJMP _0x3F
;     226         {               
;     227             if (stopping_count++ > MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRSH PC+3
	JMP _0x40
;     228             {
;     229                 is_stopping = 0;
	CLT
	BLD  R2,2
;     230                 stopping_count = 0;      
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     231             }
;     232             else{
	RJMP _0x41
_0x40:
;     233                 scroll_count--;
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     234             }
_0x41:
;     235         }   
;     236         break;  
_0x3F:
	RJMP _0x22
;     237     case SCROLLING:   
_0x3B:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x42
;     238         if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRSH PC+3
	JMP _0x43
;     239    	        start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     240    	    else 
	RJMP _0x44
_0x43:
;     241    	        start_mem += 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     242         if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
_0x44:
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-224)
	SBCI R31,HIGH(-224)
	CALL __LSLW2
	SUBI R30,LOW(-2048)
	SBCI R31,HIGH(-2048)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRLO PC+3
	JMP _0x45
;     243    	    {         
;     244    	        frame_index++;         
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
;     245    	        LoadFrame(frame_index);
	ST   -Y,R30
	CALL _LoadFrame
;     246        	}       	  
;     247         break;  
_0x45:
	RJMP _0x22
;     248     case NOT_USE:
_0x42:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x47
;     249         frame_index++;
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
;     250         LoadFrame(frame_index);
	ST   -Y,R30
	CALL _LoadFrame
;     251         break;  
	RJMP _0x22
;     252     default:
_0x47:
;     253         break;
;     254     }
_0x22:
;     255 	tick_count = 0;
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     256 	if (frame_index >= MAX_FRAME) frame_index=0;
	LDS  R26,_frame_index_G1
	CPI  R26,LOW(0x4)
	BRSH PC+3
	JMP _0x48
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     257     		
;     258   }
_0x48:
;     259              
;     260 }          
_0x1F:
	RET
;     261 ////////////////////////////////////////////////////////////////////
;     262 // General functions
;     263 //////////////////////////////////////////////////////////////////// 
;     264 #define RESET_WATCHDOG()    #asm("WDR");
;     265                                                                             
;     266 void LoadConfig(BYTE index)
;     267 {
_LoadConfig:
	PUSH R15
;     268     BYTE devID = EEPROM_DEVICE_BASE;
;     269     devID += index<<1;                
	ST   -Y,R16
;	index -> Y+1
;	devID -> R16
	LDI  R16,160
	LDD  R30,Y+1
	LSL  R30
	ADD  R16,R30
;     270     // init I2C bus
;     271     i2c_init();
	CALL _i2c_init
;     272     LED_STATUS = 1;
	SBI  0x18,4
;     273     scroll_rate = eeprom_read(devID, 0);    
	ST   -Y,R16
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     274     scroll_type = eeprom_read(devID, 1);    
	ST   -Y,R16
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_type_G1,R30
;     275     text_length = eeprom_read_w(devID, 2);    
	ST   -Y,R16
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read_w
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     276     if (text_length > DATA_LENGTH){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0xEA1)
	LDI  R30,HIGH(0xEA1)
	CPC  R27,R30
	BRSH PC+3
	JMP _0x49
;     277         text_length= 0;            
	LDI  R30,0
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R30
;     278     }
;     279     if (scroll_type > NOT_USE){
_0x49:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x6)
	BRSH PC+3
	JMP _0x4A
;     280         scroll_type = NOT_USE;
	LDI  R30,LOW(5)
	STS  _scroll_type_G1,R30
;     281     }          
;     282     if (scroll_rate > MAX_RATE){
_0x4A:
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x65)
	BRSH PC+3
	JMP _0x4B
;     283         scroll_rate = 0;
	LDI  R30,LOW(0)
	STS  _scroll_rate_G1,R30
;     284     }
;     285     LED_STATUS = 0;   
_0x4B:
	CBI  0x18,4
;     286 }
	LDD  R16,Y+0
	ADIW R28,2
	RET
;     287                        
;     288 void SaveTextLength(BYTE index)
;     289 {
_SaveTextLength:
	PUSH R15
;     290     BYTE devID = EEPROM_DEVICE_BASE;
;     291     devID += index<<1; 
	ST   -Y,R16
;	index -> Y+1
;	devID -> R16
	LDI  R16,160
	LDD  R30,Y+1
	LSL  R30
	ADD  R16,R30
;     292     i2c_init();
	CALL _i2c_init
;     293     LED_STATUS = 1;   
	SBI  0x18,4
;     294     eeprom_write_w(devID, 2,text_length); 
	ST   -Y,R16
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_write_w
;     295     LED_STATUS = 0;   
	CBI  0x18,4
;     296 }
	LDD  R16,Y+0
	ADIW R28,2
	RET
;     297 
;     298 void SaveConfig(BYTE rate,BYTE type, BYTE index)
;     299 {                     
_SaveConfig:
	PUSH R15
;     300     BYTE devID = EEPROM_DEVICE_BASE;
;     301     devID += index<<1; 
	ST   -Y,R16
;	rate -> Y+3
;	type -> Y+2
;	index -> Y+1
;	devID -> R16
	LDI  R16,160
	LDD  R30,Y+1
	LSL  R30
	ADD  R16,R30
;     302     i2c_init();
	CALL _i2c_init
;     303     LED_STATUS = 1;  
	SBI  0x18,4
;     304     eeprom_write(devID, 0,rate);    
	ST   -Y,R16
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _eeprom_write
;     305     eeprom_write(devID, 1,type);    
	ST   -Y,R16
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+5
	ST   -Y,R30
	CALL _eeprom_write
;     306     LED_STATUS = 0;       
	CBI  0x18,4
;     307 }
	LDD  R16,Y+0
	ADIW R28,4
	RET
;     308 
;     309 void SaveToEEPROM(WORD address,WORD length,BYTE index)
;     310 {                             
_SaveToEEPROM:
	PUSH R15
;     311     PBYTE temp = 0;      
;     312     BYTE devID = EEPROM_DEVICE_BASE;
;     313     devID += index<<1;      				
	CALL __SAVELOCR3
;	address -> Y+6
;	length -> Y+4
;	index -> Y+3
;	*temp -> R16,R17
;	devID -> R18
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,160
	LDD  R30,Y+3
	LSL  R30
	ADD  R18,R30
;     314     temp   = address;         
	__GETWRS 16,17,6
;     315         
;     316     if (length > DATA_LENGTH)    
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CPI  R26,LOW(0xEA1)
	LDI  R30,HIGH(0xEA1)
	CPC  R27,R30
	BRSH PC+3
	JMP _0x4C
;     317         return; // invalid param 
	CALL __LOADLOCR3
	ADIW R28,8
	RET
;     318     length = address+4*(SCREEN_WIDTH+length);         
_0x4C:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	CALL __LSLW2
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+4,R30
	STD  Y+4+1,R31
;     319     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BRNE PC+3
	JMP _0x4D
;     320         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	CALL __DIVW21U
	CALL __LSLW2
	CALL __LSLW4
	SUBI R30,LOW(-64)
	SBCI R31,HIGH(-64)
	STD  Y+4,R30
	STD  Y+4+1,R31
;     321     // init I2C bus
;     322     i2c_init();
_0x4D:
	CALL _i2c_init
;     323     LED_STATUS = 1;        
	SBI  0x18,4
;     324     
;     325     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,6
_0x4F:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CP   R16,R30
	CPC  R17,R31
	BRLO PC+3
	JMP _0x50
;     326     {   
;     327         RESET_WATCHDOG();                          	                                              
	WDR
;     328         eeprom_write_page( devID, temp, temp, EEPROM_PAGE);	      
	ST   -Y,R18
	ST   -Y,R17
	ST   -Y,R16
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	CALL _eeprom_write_page
;     329     }       
_0x4E:
	__ADDWRN 16,17,64
	RJMP _0x4F
_0x50:
;     330         
;     331     LED_STATUS = 0;   
	CBI  0x18,4
;     332 }
	CALL __LOADLOCR3
	ADIW R28,8
	RET
;     333                       
;     334 void LoadToRAM(WORD address,WORD length,BYTE index)
;     335 {                         
_LoadToRAM:
	PUSH R15
;     336     PBYTE temp = 0;          
;     337     BYTE devID = EEPROM_DEVICE_BASE;
;     338     devID += index<<1;      				
	CALL __SAVELOCR3
;	address -> Y+6
;	length -> Y+4
;	index -> Y+3
;	*temp -> R16,R17
;	devID -> R18
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,160
	LDD  R30,Y+3
	LSL  R30
	ADD  R18,R30
;     339     temp   = address;                 
	__GETWRS 16,17,6
;     340 
;     341     if (length > DATA_LENGTH)    
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CPI  R26,LOW(0xEA1)
	LDI  R30,HIGH(0xEA1)
	CPC  R27,R30
	BRSH PC+3
	JMP _0x51
;     342         return; // invalid param
	CALL __LOADLOCR3
	ADIW R28,8
	RET
;     343     length = address+4*(SCREEN_WIDTH+length);         
_0x51:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	CALL __LSLW2
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+4,R30
	STD  Y+4+1,R31
;     344     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BRNE PC+3
	JMP _0x52
;     345         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	CALL __DIVW21U
	CALL __LSLW2
	CALL __LSLW4
	SUBI R30,LOW(-64)
	SBCI R31,HIGH(-64)
	STD  Y+4,R30
	STD  Y+4+1,R31
;     346     // init I2C bus
;     347     i2c_init();
_0x52:
	CALL _i2c_init
;     348     LED_STATUS = 1;             
	SBI  0x18,4
;     349  
;     350     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,6
_0x54:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CP   R16,R30
	CPC  R17,R31
	BRLO PC+3
	JMP _0x55
;     351     {
;     352         eeprom_read_page( devID, temp, temp, EEPROM_PAGE );	                                   
	ST   -Y,R18
	ST   -Y,R17
	ST   -Y,R16
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	CALL _eeprom_read_page
;     353         RESET_WATCHDOG();     
	WDR
;     354     }             
_0x53:
	__ADDWRN 16,17,64
	RJMP _0x54
_0x55:
;     355 
;     356     LED_STATUS = 0;   
	CBI  0x18,4
;     357 }
	CALL __LOADLOCR3
	ADIW R28,8
	RET
;     358 
;     359 void LoadFrame(BYTE index)
;     360 {                 
_LoadFrame:
	PUSH R15
;     361     if (index >= MAX_FRAME) index=0;  
;	index -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x4)
	BRSH PC+3
	JMP _0x56
	LDI  R30,LOW(0)
	ST   Y,R30
;     362 
;     363     LoadConfig(index);  
_0x56:
	LD   R30,Y
	ST   -Y,R30
	CALL _LoadConfig
;     364     if (scroll_type==NOT_USE){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x5)
	BREQ PC+3
	JMP _0x57
;     365         return;           
	ADIW R28,1
	RET
;     366     }                   
;     367     BlankRAM(START_RAM,END_RAM);
_0x57:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     368     LoadToRAM(START_RAM_TEXT,text_length,index);
	LDI  R30,LOW(2048)
	LDI  R31,HIGH(2048)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	ST   -Y,R30
	CALL _LoadToRAM
;     369     stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     370     scroll_count = 0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     371     is_stopping = 0;
	CLT
	BLD  R2,2
;     372     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     373     {
;     374     case LEFT_RIGHT:
	CPI  R30,0
	BREQ PC+3
	JMP _0x5B
;     375         start_mem = START_RAM_TEXT; 
	LDI  R30,LOW(2048)
	LDI  R31,HIGH(2048)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     376         break;                
	RJMP _0x5A
;     377     case RIGHT_LEFT:
_0x5B:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x5C
;     378         start_mem = START_RAM_TEXT + (text_length<<2); 
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	CALL __LSLW2
	SUBI R30,LOW(-2048)
	SBCI R31,HIGH(-2048)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     379         break;
	RJMP _0x5A
;     380     case BOTTOM_TOP:                             
_0x5C:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x5D
;     381         scroll_count = SCREEN_HEIGHT<<1;
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     382         start_mem = START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(2816)
	LDI  R31,HIGH(2816)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     383         break;
	RJMP _0x5A
;     384     case TOP_BOTTOM:   
_0x5D:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x5E
;     385         scroll_count = 0;                     
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     386         start_mem = START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(2816)
	LDI  R31,HIGH(2816)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     387         break;  
	RJMP _0x5A
;     388     case SCROLLING:
_0x5E:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x60
;     389         start_mem = START_RAM_TEXT;
	LDI  R30,LOW(2048)
	LDI  R31,HIGH(2048)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     390         break;
	RJMP _0x5A
;     391     default: 
_0x60:
;     392         break;
;     393     }                            
_0x5A:
;     394 }
	ADIW R28,1
	RET
;     395 
;     396 void SerialToRAM(WORD address,WORD length)                                             
;     397 {
_SerialToRAM:
	PUSH R15
;     398     PBYTE temp = 0;          
;     399     UINT i =0;     				
;     400     temp   = address;    
	CALL __SAVELOCR4
;	address -> Y+6
;	length -> Y+4
;	*temp -> R16,R17
;	i -> R18,R19
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,0
	LDI  R19,0
	__GETWRS 16,17,6
;     401     LED_STATUS = 1;
	SBI  0x18,4
;     402     for (i =0; i< (length<<2); i++)         
	__GETWRN 18,19,0
_0x62:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL __LSLW2
	CP   R18,R30
	CPC  R19,R31
	BRLO PC+3
	JMP _0x63
;     403     {                          
;     404         BYTE data = 0;
;     405         data = ~getchar();
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x64*2)
	LDI  R31,HIGH(_0x64*2)
	CALL __INITLOCB
;	address -> Y+7
;	length -> Y+5
;	data -> Y+0
	CALL _getchar
	COM  R30
	ST   Y,R30
;     406         *temp = data;
	MOVW R26,R16
	ST   X,R30
;     407         temp++;
	__ADDWRN 16,17,1
;     408         RESET_WATCHDOG();                                     
	WDR
;     409     }              
	ADIW R28,1
_0x61:
	__ADDWRN 18,19,1
	RJMP _0x62
_0x63:
;     410     LED_STATUS = 0;
	CBI  0x18,4
;     411 }
	CALL __LOADLOCR4
	ADIW R28,8
	RET
;     412                       
;     413 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     414 {        
_BlankRAM:
	PUSH R15
;     415     PBYTE temp = START_RAM;
;     416     for (temp = start_addr; temp<= end_addr; temp++)    
	ST   -Y,R17
	ST   -Y,R16
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*temp -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x66:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRSH PC+3
	JMP _0x67
;     417         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     418 }
_0x65:
	__ADDWRN 16,17,1
	RJMP _0x66
_0x67:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;     419 
;     420 
;     421 ///////////////////////////////////////////////////////////////
;     422 // END static function(s)
;     423 ///////////////////////////////////////////////////////////////
;     424 
;     425 ///////////////////////////////////////////////////////////////           
;     426 
;     427 void InitDevice()
;     428 {
_InitDevice:
	PUSH R15
;     429 // Declare your local variables here
;     430 // Crystal Oscillator division factor: 1  
;     431 #ifdef _MEGA162_INCLUDED_ 
;     432 #pragma optsize-
;     433 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     434 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     435 #ifdef _OPTIMIZE_SIZE_
;     436 #pragma optsize+
;     437 #endif                    
;     438 #endif
;     439 
;     440 PORTA=0x00;
	OUT  0x1B,R30
;     441 DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;     442 
;     443 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
;     444 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     445 
;     446 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     447 DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
;     448 
;     449 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     450 DDRD=0x00; 
	OUT  0x11,R30
;     451 
;     452 PORTE=0x00;
	OUT  0x7,R30
;     453 DDRE=0xFF;
	LDI  R30,LOW(255)
	OUT  0x6,R30
;     454 
;     455 // Timer/Counter 0 initialization
;     456 // Clock source: System Clock
;     457 // Clock value: 250.000 kHz
;     458 // Mode: Normal top=FFh
;     459 // OC0 output: Disconnected
;     460 TCCR0=0x03;     // 4 us per tick
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     461 TCNT0=0x05;     // 1ms = 4*250
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     462 OCR0=0x00;      // 255 -250 = TCNT0
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     463 
;     464 #ifdef _MEGA162_INCLUDED_
;     465 UCSR0A=0x00;
	OUT  0xB,R30
;     466 UCSR0B=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     467 UCSR0C=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     468 UBRR0H=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     469 UBRR0L=0x67;      //  16 MHz     
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     470 
;     471 #else // _MEGA8515_INCLUDE_     
;     472 UCSRA=0x00;
;     473 UCSRB=0x98;
;     474 UCSRC=0x86;
;     475 UBRRH=0x00;
;     476 UBRRL=0x33;       // 8 MHz
;     477 #endif
;     478 
;     479 // Lower page wait state(s): None
;     480 // Upper page wait state(s): None
;     481 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     482 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     483 
;     484 // Timer(s)/Counter(s) Interrupt(s) initialization
;     485 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     486 ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
;     487 
;     488 // Load calibration byte for osc.  
;     489 #ifdef _MEGA162_INCLUDED_
;     490 OSCCAL = 0x5E; 
	LDI  R30,LOW(94)
	OUT  0x4,R30
;     491 #else
;     492 OSCCAL = 0xA7; 
;     493 #endif            
;     494 
;     495 // I2C Bus initialization
;     496 // i2c_init();
;     497 
;     498 // DS1307 Real Time Clock initialization
;     499 // Square wave output on pin SQW/OUT: Off
;     500 // SQW/OUT pin state: 1
;     501 // rtc_init(3,0,1);
;     502 
;     503 //i2c_init(); // must be call before
;     504 //rtc_init(3,0,1); // init RTC DS1307  
;     505 //rtc_set_time(15,2,0);
;     506 //rtc_set_date(9,5,6);    
;     507                 
;     508 // Watchdog Timer initialization
;     509 // Watchdog Timer Prescaler: OSC/2048k     
;     510 #ifdef __WATCH_DOG_
;     511 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     512 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     513 #endif
;     514 }
	RET
;     515 
;     516 void PowerReset()
;     517 {      
_PowerReset:
	PUSH R15
;     518     start_mem = START_RAM_TEXT;                    
	LDI  R30,LOW(2048)
	LDI  R31,HIGH(2048)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     519 
;     520     InitDevice();
	CALL _InitDevice
;     521        
;     522     LED_STATUS = 0;
	CBI  0x18,4
;     523     BlankRAM(START_RAM,END_RAM);  
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     524     
;     525     LED_STATUS = 0;  
	CBI  0x18,4
;     526     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     527     LED_STATUS = 1;
	SBI  0x18,4
;     528     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     529     LED_STATUS = 0;
	CBI  0x18,4
;     530     delay_ms(500);    
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     531     LED_STATUS = 1;            
	SBI  0x18,4
;     532 
;     533 #ifdef _INIT_EEPROM_ 
;     534 {
;     535     BYTE i =0;
;     536     for (i =0; i< MAX_FRAME; i++){   
;     537         SaveConfig(10,0,i);
;     538         text_length = 160;
;     539         SaveTextLength(i);            
;     540     }
;     541 }
;     542 #endif    
;     543 }
	RET
;     544 
;     545 void ProcessCommand()
;     546 {
_ProcessCommand:
	PUSH R15
;     547    	#asm("cli"); 
	cli
;     548     RESET_WATCHDOG();
	WDR
;     549 
;     550     // serial message processing     
;     551     switch (rx_message)
	MOV  R30,R8
;     552     {                  
;     553     case LOAD_TEXT_MSG:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x6B
;     554         {                
;     555             text_length = rx_wparam;            
	__PUTWMRN _text_length_G1,0,9,10
;     556             frame_index = rx_lparam&0x0F;   
	__GETW1R 11,12
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	STS  _frame_index_G1,R30
;     557             BlankRAM(START_RAM,END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     558             SerialToRAM(START_RAM_TEXT+4*(SCREEN_WIDTH),text_length);                
	LDI  R30,LOW(2816)
	LDI  R31,HIGH(2816)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _SerialToRAM
;     559 			start_mem = START_RAM_TEXT+4*(SCREEN_WIDTH);				
	LDI  R30,LOW(2816)
	LDI  R31,HIGH(2816)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     560 			SaveToEEPROM(START_RAM_TEXT,text_length,rx_lparam);
	LDI  R30,LOW(2048)
	LDI  R31,HIGH(2048)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	CALL _SaveToEEPROM
;     561 			SaveTextLength(rx_lparam);							  
	ST   -Y,R11
	CALL _SaveTextLength
;     562         }				
;     563         break;           
	RJMP _0x6A
;     564     case LOAD_BKGND_MSG:
_0x6B:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x6C
;     565         {
;     566         }
;     567         break;   
	RJMP _0x6A
;     568     case SET_CFG_MSG: 
_0x6C:
	CPI  R30,LOW(0xD)
	BREQ PC+3
	JMP _0x6D
;     569         {               
;     570             SaveConfig(rx_wparam&0x0FF,rx_wparam>>8,rx_lparam); 
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	ST   -Y,R11
	CALL _SaveConfig
;     571         }
;     572         break;    
	RJMP _0x6A
;     573     case EEPROM_SAVE_TEXT_MSG:     
_0x6D:
	CPI  R30,LOW(0x7)
	BREQ PC+3
	JMP _0x6E
;     574     case EEPROM_SAVE_ALL_MSG:  
	RJMP _0x6F
_0x6E:
	CPI  R30,LOW(0xB)
	BREQ PC+3
	JMP _0x70
_0x6F:
;     575         {                                                          
;     576             SaveTextLength(rx_lparam);              
	ST   -Y,R11
	CALL _SaveTextLength
;     577             SaveToEEPROM(START_RAM_TEXT,text_length,rx_lparam);
	LDI  R30,LOW(2048)
	LDI  R31,HIGH(2048)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	CALL _SaveToEEPROM
;     578         }
;     579         break;         
	RJMP _0x6A
;     580     case EEPROM_LOAD_TEXT_MSG:    
_0x70:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0x71
;     581     case EEPROM_LOAD_ALL_MSG:
	RJMP _0x72
_0x71:
	CPI  R30,LOW(0xA)
	BREQ PC+3
	JMP _0x73
_0x72:
;     582         {
;     583             LoadConfig(rx_lparam);                               
	ST   -Y,R11
	CALL _LoadConfig
;     584             LoadToRAM(START_RAM_TEXT,text_length,rx_lparam); 
	LDI  R30,LOW(2048)
	LDI  R31,HIGH(2048)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	CALL _LoadToRAM
;     585             start_mem = START_RAM_TEXT+4*(SCREEN_WIDTH);
	LDI  R30,LOW(2816)
	LDI  R31,HIGH(2816)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     586         }
;     587         break;  
	RJMP _0x6A
;     588     case POWER_CTRL_MSG:
_0x73:
	CPI  R30,LOW(0x10)
	BREQ PC+3
	JMP _0x75
;     589         power_off = rx_wparam&0x01;
	BST  R9,0
	BLD  R2,1
;     590         break;     
	RJMP _0x6A
;     591     default:
_0x75:
;     592         break;
;     593     }                 
_0x6A:
;     594     send_echo_msg();            
	CALL _send_echo_msg
;     595     rx_message = UNKNOWN_MSG;
	CLR  R8
;     596     #asm("sei");        
	sei
;     597 }           
	RET
;     598 void DelayFrame(BYTE dly)
;     599 {
_DelayFrame:
	PUSH R15
;     600     BYTE i =0;
;     601     for (i=0;i<dly;i++){
	ST   -Y,R16
;	dly -> Y+1
;	i -> R16
	LDI  R16,0
	LDI  R16,LOW(0)
_0x77:
	LDD  R30,Y+1
	CP   R16,R30
	BRLO PC+3
	JMP _0x78
;     602         if (rx_message != UNKNOWN_MSG){           
	TST  R8
	BRNE PC+3
	JMP _0x79
;     603             break;
	RJMP _0x78
;     604         }   
;     605         delay_ms(10);
_0x79:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     606         RESET_WATCHDOG();
	WDR
;     607     }
_0x76:
	SUBI R16,-1
	RJMP _0x77
_0x78:
;     608 }
	LDD  R16,Y+0
	ADIW R28,2
	RET
;     609 ////////////////////////////////////////////////////////////////////////////////
;     610 // MAIN PROGRAM
;     611 ////////////////////////////////////////////////////////////////////////////////
;     612 void main(void)
;     613 {         
_main:
;     614     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x7A
;     615         // Watchdog Reset
;     616         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     617         reset_serial(); 
	CALL _reset_serial
;     618     }
;     619     else {      
	RJMP _0x7B
_0x7A:
;     620         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     621     }                                     
_0x7B:
;     622      
;     623     PowerReset();                        
	CALL _PowerReset
;     624     #asm("sei");     
	sei
;     625 
;     626     while (1){                     
_0x7C:
;     627         if (rx_message != UNKNOWN_MSG){   
	TST  R8
	BRNE PC+3
	JMP _0x7F
;     628             ProcessCommand();   
	CALL _ProcessCommand
;     629         }
;     630         else{           
	RJMP _0x80
_0x7F:
;     631             _displayFrame();
	CALL __displayFrame_G1
;     632             _doScroll();            
	CALL __doScroll_G1
;     633         }
_0x80:
;     634         RESET_WATCHDOG();
	WDR
;     635     };
	RJMP _0x7C
_0x7E:
;     636 
;     637 }
_0x81:
	NOP
	RJMP _0x81
;     638                          
;     639 #include "define.h"
;     640 
;     641 ///////////////////////////////////////////////////////////////
;     642 // serial interrupt handle - processing serial message ...
;     643 ///////////////////////////////////////////////////////////////
;     644 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     645 ///////////////////////////////////////////////////////////////
;     646 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     647 extern BYTE  rx_message;
;     648 extern WORD  rx_wparam;
;     649 extern WORD  rx_lparam;
;     650 
;     651 #if RX_BUFFER_SIZE<256
;     652 unsigned char rx_wr_index,rx_counter;
;     653 #else
;     654 unsigned int rx_wr_index,rx_counter;
;     655 #endif
;     656 
;     657 void send_echo_msg();
;     658 
;     659 // USART Receiver interrupt service routine
;     660 #ifdef _MEGA162_INCLUDED_                    
;     661 interrupt [USART0_RXC] void usart_rx_isr(void)
;     662 #else
;     663 interrupt [USART_RXC] void usart_rx_isr(void)
;     664 #endif
;     665 {

	.CSEG
_usart_rx_isr:
;     666 char status,data;
;     667 #ifdef _MEGA162_INCLUDED_  
;     668 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;     669 data=UDR0;
	IN   R17,12
;     670 #else     
;     671 status=UCSRA;
;     672 data=UDR;
;     673 #endif          
;     674     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+3
	JMP _0x82
;     675     {
;     676         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R13
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;     677         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BREQ PC+3
	JMP _0x83
	CLR  R13
;     678         if (++rx_counter == RX_BUFFER_SIZE)
_0x83:
	INC  R14
	LDI  R30,LOW(8)
	CP   R30,R14
	BREQ PC+3
	JMP _0x84
;     679         {
;     680             rx_counter=0;
	CLR  R14
;     681             if (
;     682                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;     683                 rx_buffer[2]==WAKEUP_CHAR 
;     684                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BREQ PC+3
	JMP _0x86
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BREQ PC+3
	JMP _0x86
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ PC+3
	JMP _0x86
	RJMP _0x87
_0x86:
	RJMP _0x85
_0x87:
;     685             {
;     686                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 8,_rx_buffer,3
;     687                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 9,_rx_buffer,4
	CLR  R10
;     688                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R9
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 9,10
;     689                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 11,_rx_buffer,6
	CLR  R12
;     690                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;     691             }
;     692             else if(
	RJMP _0x88
_0x85:
;     693                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;     694                 rx_buffer[2]==ESCAPE_CHAR 
;     695                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BREQ PC+3
	JMP _0x8A
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BREQ PC+3
	JMP _0x8A
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ PC+3
	JMP _0x8A
	RJMP _0x8B
_0x8A:
	RJMP _0x89
_0x8B:
;     696             {
;     697                 rx_wr_index=0;
	CLR  R13
;     698                 rx_counter =0;
	CLR  R14
;     699             }      
;     700         };
_0x89:
_0x88:
_0x84:
;     701     };
_0x82:
;     702 }
	LD   R16,Y+
	LD   R17,Y+
	RETI
;     703 
;     704 void send_echo_msg()
;     705 {
_send_echo_msg:
	PUSH R15
;     706     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     707     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     708     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     709     putchar(rx_message);
	ST   -Y,R8
	CALL _putchar
;     710     putchar(rx_wparam>>8);
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     711     putchar(rx_wparam&0x00FF);
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     712     putchar(rx_lparam>>8);        
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     713     putchar(rx_lparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     714 }  
	RET
;     715 
;     716 void reset_serial()
;     717 {
_reset_serial:
	PUSH R15
;     718     rx_wr_index=0;
	CLR  R13
;     719     rx_counter =0;
	CLR  R14
;     720     rx_message = UNKNOWN_MSG;
	CLR  R8
;     721 }
	RET
;     722 
;     723 ///////////////////////////////////////////////////////////////
;     724 // END serial interrupt handle
;     725 /////////////////////////////////////////////////////////////// 
;     726 /*****************************************************
;     727 This program was produced by the
;     728 CodeWizardAVR V1.24.4a Standard
;     729 Automatic Program Generator
;     730 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;     731 http://www.hpinfotech.com
;     732 e-mail:office@hpinfotech.com
;     733 
;     734 Project : 
;     735 Version : 
;     736 Date    : 19/5/2005
;     737 Author  : 3iGROUP                
;     738 Company : http://www.3ihut.net   
;     739 Comments: 
;     740 
;     741 
;     742 Chip type           : ATmega8515
;     743 Program type        : Application
;     744 Clock frequency     : 8.000000 MHz
;     745 Memory model        : Small
;     746 External SRAM size  : 32768
;     747 Ext. SRAM wait state: 0
;     748 Data Stack size     : 128
;     749 *****************************************************/
;     750 
;     751 #include "define.h"                                           
;     752 
;     753 #define     ACK                 1
;     754 #define     NO_ACK              0
;     755 
;     756 // I2C Bus functions
;     757 #asm
;     758    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;     759    .equ __sda_bit=3
   .equ __sda_bit=3
;     760    .equ __scl_bit=2
   .equ __scl_bit=2
;     761 #endasm                   
;     762 
;     763 #ifdef __EEPROM_WRITE_BYTE
;     764 BYTE eeprom_read(BYTE deviceID, WORD address) 
;     765 {
_eeprom_read:
	PUSH R15
;     766     BYTE data;
;     767     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	address -> Y+1
;	data -> R16
	CALL _i2c_start
;     768     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     769     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     770     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     771     
;     772     i2c_start();
	CALL _i2c_start
;     773     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     774     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R16,R30
;     775     i2c_stop();
	CALL _i2c_stop
;     776     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	ADIW R28,4
	RET
;     777 }
;     778 
;     779 void eeprom_write(BYTE deviceID, WORD address, BYTE data) 
;     780 {
_eeprom_write:
	PUSH R15
;     781     i2c_start();
;	deviceID -> Y+3
;	address -> Y+1
;	data -> Y+0
	CALL _i2c_start
;     782     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     783     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     784     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     785     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	CALL _i2c_write
;     786     i2c_stop();
	CALL _i2c_stop
;     787 
;     788     /* 10ms delay to complete the write operation */
;     789     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     790 }                                 
	ADIW R28,4
	RET
;     791 
;     792 WORD eeprom_read_w(BYTE deviceID, WORD address)
;     793 {
_eeprom_read_w:
	PUSH R15
;     794     WORD result = 0;
;     795     result = eeprom_read(deviceID,address);
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
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	MOV  R16,R30
	CLR  R17
;     796     result = (result<<8) | eeprom_read(deviceID,address+1);
	MOV  R31,R16
	LDI  R30,LOW(0)
	PUSH R31
	PUSH R30
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
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
;     797     return result;
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
;     798 }
;     799 void eeprom_write_w(BYTE deviceID, WORD address, WORD data)
;     800 {
_eeprom_write_w:
	PUSH R15
;     801     eeprom_write(deviceID,address,data>>8);
;	deviceID -> Y+4
;	address -> Y+2
;	data -> Y+0
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _eeprom_write
;     802     eeprom_write(deviceID,address+1,data&0x0FF);    
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _eeprom_write
;     803 }
	ADIW R28,5
	RET
;     804 
;     805 #endif // __EEPROM_WRITE_BYTE
;     806 void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     807 {
_eeprom_read_page:
	PUSH R15
;     808     BYTE i = 0;
;     809     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;     810     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;     811     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     812     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     813     
;     814     i2c_start();
	CALL _i2c_start
;     815     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     816                                     
;     817     while ( i < page_size-1 )
_0x8C:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRLO PC+3
	JMP _0x8E
;     818     {
;     819         buffer[i++] = i2c_read(ACK);   // read at current
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
;     820     }
	RJMP _0x8C
_0x8E:
;     821     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
;     822          
;     823     i2c_stop();
	CALL _i2c_stop
;     824 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     825 
;     826 void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     827 {
_eeprom_write_page:
	PUSH R15
;     828     BYTE i = 0;
;     829     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;     830     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;     831     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     832     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     833                                         
;     834     while ( i < page_size )
_0x8F:
	LDD  R30,Y+1
	CP   R16,R30
	BRLO PC+3
	JMP _0x91
;     835     {
;     836         i2c_write(buffer[i++]);
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
;     837         #asm("nop");#asm("nop");
	nop
	nop
;     838     }          
	RJMP _0x8F
_0x91:
;     839     i2c_stop(); 
	CALL _i2c_stop
;     840     delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     841 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     842                                               
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

__ASRW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __ASRW12R
__ASRW12L:
	ASR  R31
	ROR  R30
	DEC  R0
	BRNE __ASRW12L
__ASRW12R:
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

__LSRW3:
	LSR  R31
	ROR  R30
__LSRW2:
	LSR  R31
	ROR  R30
	LSR  R31
	ROR  R30
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

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

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
