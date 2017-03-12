
;CodeVisionAVR C Compiler V1.25.2 Standard
;(C) Copyright 1998-2006 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega8515
;Program type           : Application
;Clock frequency        : 16.000000 MHz
;Memory model           : Small
;Optimize for           : Speed
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 60 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : Yes
;Word align FLASH struct: No
;Enhanced core instructions    : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega8515
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 512
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

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
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	RCALL __EEPROMRDW
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	LDI  R24,LOW(0x200)
	LDI  R25,HIGH(0x200)
	LDI  R26,0x60
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
	LDI  R30,LOW(0x25F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x25F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x9C)
	LDI  R29,HIGH(0x9C)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x9C
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
;      31 static PBYTE start_memR =NULL;         
_start_memR_G1:
	.BYTE 0x2
;      32 static PBYTE start_memG =NULL;         
_start_memG_G1:
	.BYTE 0x2
;      33 static PBYTE start_memB =NULL;         
_start_memB_G1:
	.BYTE 0x2
;      34 
;      35 bit data_bit = 0;       
;      36 bit power_off = 0;
;      37 bit is_stopping = 0;
;      38 
;      39 register UINT x=0;
;      40 register UINT y=0;   
;      41                                 
;      42 static int   scroll_count = 0;
_scroll_count_G1:
	.BYTE 0x2
;      43 static UINT  tick_count  = 0;       
_tick_count_G1:
	.BYTE 0x2
;      44 static UINT  stopping_count = 0;       
_stopping_count_G1:
	.BYTE 0x2
;      45 static BYTE  frame_index = 0;   
_frame_index_G1:
	.BYTE 0x1
;      46 static BYTE  scroll_step = 0;
_scroll_step_G1:
	.BYTE 0x1
;      47 
;      48 static UINT  text_length = 0;              
_text_length_G1:
	.BYTE 0x2
;      49 static BYTE  scroll_rate = 20;
_scroll_rate_G1:
	.BYTE 0x1
;      50 static BYTE  scroll_temp = 20;
_scroll_temp_G1:
	.BYTE 0x1
;      51 static BYTE  scroll_type = SCROLLING;            
_scroll_type_G1:
	.BYTE 0x1
;      52              
;      53 // Global variables for message control
;      54 BYTE  rx_message = UNKNOWN_MSG;
;      55 WORD  rx_wparam  = 0;
;      56 WORD  rx_lparam  = 0;
;      57 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;      58                             
;      59 extern void reset_serial();         
;      60 extern void send_echo_msg();    
;      61 extern BYTE eeprom_read(BYTE deviceID, WORD address);
;      62 extern void eeprom_write(BYTE deviceID, WORD address, BYTE data);
;      63 extern WORD eeprom_read_w(BYTE deviceID, WORD address);
;      64 extern void eeprom_write_w(BYTE deviceID, WORD address, WORD data);
;      65 extern void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      66 extern void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      67 
;      68 static void _displayFrame();
;      69 static void _doScroll();   
;      70 void LoadFrame(BYTE index);     
;      71 void BlankRAM(PBYTE start_addr,PBYTE end_addr);
;      72 
;      73 ///////////////////////////////////////////////////////////////
;      74 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;      75 ///////////////////////////////////////////////////////////////
;      76 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;      77 {       

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;      78     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;      79     ++tick_count;    
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	ADIW R30,1
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R31
;      80 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;      81 
;      82 ///////////////////////////////////////////////////////////////
;      83 // static function(s) for led matrix display panel
;      84 ///////////////////////////////////////////////////////////////
;      85 
;      86 static void putdata()
;      87 {                                    
_putdata_G1:
;      88 	for (x=0; x< SCREEN_WIDTH; x++){
	CLR  R4
	CLR  R5
_0xA:
	LDI  R30,LOW(240)
	LDI  R31,HIGH(240)
	CP   R4,R30
	CPC  R5,R31
	BRSH _0xB
;      89 		DATA_PORT = start_memR[(SCREEN_HEIGHT/8)*(x) +0];
	MOVW R30,R4
	RCALL __LSLW3
	ADIW R30,0
	LDS  R26,_start_memR_G1
	LDS  R27,_start_memR_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;      90 		DATA_CLK = 1;
	SBI  0x12,5
;      91 		DATA_CLK = 0;					         
	CBI  0x12,5
;      92 		DATA_PORT = start_memB[(SCREEN_HEIGHT/8)*(x) +0];
	MOVW R30,R4
	RCALL __LSLW3
	ADIW R30,0
	LDS  R26,_start_memB_G1
	LDS  R27,_start_memB_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;      93 		DATA_CLK = 1;
	SBI  0x12,5
;      94 		DATA_CLK = 0;				             
	CBI  0x12,5
;      95 		DATA_PORT = start_memG[(SCREEN_HEIGHT/8)*(x) +0];
	MOVW R30,R4
	RCALL __LSLW3
	ADIW R30,0
	LDS  R26,_start_memG_G1
	LDS  R27,_start_memG_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;      96 		DATA_CLK = 1;
	SBI  0x12,5
;      97 		DATA_CLK = 0;				
	CBI  0x12,5
;      98 	}         
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0xA
_0xB:
;      99 	  
;     100     DATA_STB0 = 1;
	SBI  0x7,0
;     101     delay_us(100);
	__DELAY_USW 400
;     102     DATA_STB0 = 0; 
	CBI  0x7,0
;     103     
;     104     
;     105     for (x=0; x< SCREEN_WIDTH; x++){
	CLR  R4
	CLR  R5
_0xD:
	LDI  R30,LOW(240)
	LDI  R31,HIGH(240)
	CP   R4,R30
	CPC  R5,R31
	BRSH _0xE
;     106 		DATA_PORT = start_memR[(SCREEN_HEIGHT/8)*(x) +1];
	MOVW R30,R4
	RCALL __LSLW3
	ADIW R30,1
	LDS  R26,_start_memR_G1
	LDS  R27,_start_memR_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;     107 		DATA_CLK = 1;
	SBI  0x12,5
;     108 		DATA_CLK = 0;				
	CBI  0x12,5
;     109 		DATA_PORT = start_memB[(SCREEN_HEIGHT/8)*(x) +1];
	MOVW R30,R4
	RCALL __LSLW3
	ADIW R30,1
	LDS  R26,_start_memB_G1
	LDS  R27,_start_memB_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;     110 		DATA_CLK = 1;
	SBI  0x12,5
;     111 		DATA_CLK = 0;               
	CBI  0x12,5
;     112 		DATA_PORT = start_memG[(SCREEN_HEIGHT/8)*(x) +1];
	MOVW R30,R4
	RCALL __LSLW3
	ADIW R30,1
	LDS  R26,_start_memG_G1
	LDS  R27,_start_memG_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;     113 		DATA_CLK = 1;
	SBI  0x12,5
;     114 		DATA_CLK = 0;					
	CBI  0x12,5
;     115 	}
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0xD
_0xE:
;     116 	           
;     117     DATA_STB1 = 1; 
	SBI  0x7,2
;     118     delay_us(100);      
	__DELAY_USW 400
;     119     DATA_STB1 = 0;     	         
	CBI  0x7,2
;     120 }
	RET
;     121     
;     122 static void _displayFrame()
;     123 {                                
__displayFrame_G1:
;     124     putdata();
	RCALL _putdata_G1
;     125 }     
	RET
;     126                                                                                   
;     127 static void _doScroll()
;     128 {                                        
__doScroll_G1:
;     129   if (tick_count > scroll_rate){    
	LDS  R30,_scroll_rate_G1
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRLO PC+2
	RJMP _0xF
;     130     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     131     {
;     132     case LEFT_RIGHT:                           
	CPI  R30,0
	BRNE _0x13
;     133    	    break;
	RJMP _0x12
;     134     case RIGHT_LEFT:       	
_0x13:
	CPI  R30,LOW(0x1)
	BRNE _0x14
;     135        	break;
	RJMP _0x12
;     136     case BOTTOM_TOP:                       
_0x14:
	CPI  R30,LOW(0x3)
	BRNE _0x15
;     137         break;
	RJMP _0x12
;     138     case TOP_BOTTOM:        
_0x15:
	CPI  R30,LOW(0x2)
	BRNE _0x16
;     139         break;  
	RJMP _0x12
;     140     case SCROLLING: 
_0x16:
	CPI  R30,LOW(0x4)
	BREQ PC+2
	RJMP _0x17
;     141         if (scroll_step ==0){                 
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x18
;     142             start_memR += (SCREEN_HEIGHT/8);  
	LDS  R30,_start_memR_G1
	LDS  R31,_start_memR_G1+1
	ADIW R30,8
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     143             start_memG += (SCREEN_HEIGHT/8);  
	LDS  R30,_start_memG_G1
	LDS  R31,_start_memG_G1+1
	ADIW R30,8
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     144             start_memB += (SCREEN_HEIGHT/8);  
	LDS  R30,_start_memB_G1
	LDS  R31,_start_memB_G1+1
	ADIW R30,8
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     145             if (++scroll_count > SCREEN_WIDTH){     
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0xF1)
	LDI  R30,HIGH(0xF1)
	CPC  R27,R30
	BRLT _0x19
;     146                 scroll_temp =scroll_rate;
	LDS  R30,_scroll_rate_G1
	STS  _scroll_temp_G1,R30
;     147                 scroll_rate =FAST_RATE;
	LDI  R30,LOW(10)
	STS  _scroll_rate_G1,R30
;     148                 scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     149                 scroll_count=0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     150             }
;     151         }                                      
_0x19:
;     152         else if (scroll_step ==1){
	RJMP _0x1A
_0x18:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x1B
;     153             start_memR -= (SCREEN_HEIGHT/8);   
	LDS  R30,_start_memR_G1
	LDS  R31,_start_memR_G1+1
	SBIW R30,8
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     154             if (++scroll_count > SCREEN_WIDTH){                
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0xF1)
	LDI  R30,HIGH(0xF1)
	CPC  R27,R30
	BRLT _0x1C
;     155                 scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     156                 scroll_count=0;                        
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     157             }
;     158         }    
_0x1C:
;     159         else if (scroll_step ==2){
	RJMP _0x1D
_0x1B:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x2)
	BRNE _0x1E
;     160             start_memG -= (SCREEN_HEIGHT/8);   
	LDS  R30,_start_memG_G1
	LDS  R31,_start_memG_G1+1
	SBIW R30,8
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     161             if (++scroll_count > SCREEN_WIDTH){
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0xF1)
	LDI  R30,HIGH(0xF1)
	CPC  R27,R30
	BRLT _0x1F
;     162                 scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     163                 scroll_count=0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     164             }
;     165         }
_0x1F:
;     166         else if (scroll_step ==3){
	RJMP _0x20
_0x1E:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x3)
	BRNE _0x21
;     167             start_memB -= (SCREEN_HEIGHT/8);   
	LDS  R30,_start_memB_G1
	LDS  R31,_start_memB_G1+1
	SBIW R30,8
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     168             if (++scroll_count > SCREEN_WIDTH){
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0xF1)
	LDI  R30,HIGH(0xF1)
	CPC  R27,R30
	BRLT _0x22
;     169                 scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     170                 scroll_count=0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     171             }
;     172         }               
_0x22:
;     173         else if (scroll_step ==4){  
	RJMP _0x23
_0x21:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x4)
	BRNE _0x24
;     174             if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLT _0x25
;     175                 scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     176                 scroll_count=0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     177             }
;     178         }
_0x25:
;     179         else{
	RJMP _0x26
_0x24:
;     180             start_memR = (PBYTE)START_RAM + 0*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     181             start_memG = (PBYTE)START_RAM + 1*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(5120)
	LDI  R31,HIGH(5120)
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     182             start_memB = (PBYTE)START_RAM + 2*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(8960)
	LDI  R31,HIGH(8960)
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     183             scroll_rate =scroll_temp;            
	LDS  R30,_scroll_temp_G1
	STS  _scroll_rate_G1,R30
;     184             scroll_count=0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     185             scroll_step =0;   
	LDI  R30,LOW(0)
	STS  _scroll_step_G1,R30
;     186             reset_serial(); 
	RCALL _reset_serial
;     187         } 
_0x26:
_0x23:
_0x20:
_0x1D:
_0x1A:
;     188         break;  
	RJMP _0x12
;     189     case NOT_USE:
_0x17:
	CPI  R30,LOW(0x5)
	BRNE _0x28
;     190         frame_index++;
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	SUBI R30,LOW(1)
;     191         LoadFrame(frame_index);
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _LoadFrame
;     192         break;  
;     193     default:
_0x28:
;     194         break;
;     195     }
_0x12:
;     196 	tick_count = 0;
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     197 	if (frame_index >= MAX_FRAME) frame_index=0;
	LDS  R26,_frame_index_G1
	CPI  R26,LOW(0x4)
	BRLO _0x29
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     198     		
;     199   }
_0x29:
;     200              
;     201 }          
_0xF:
	RET
;     202 ////////////////////////////////////////////////////////////////////
;     203 // General functions
;     204 //////////////////////////////////////////////////////////////////// 
;     205 #define RESET_WATCHDOG()    #asm("WDR");
;     206                                                                             
;     207 void LoadConfig(BYTE index)
;     208 {
_LoadConfig:
;     209     BYTE devID = EEPROM_DEVICE_BASE;    
;     210     WORD base = 0;   // base address
;     211     devID += index<<1;                 
	RCALL __SAVELOCR3
;	index -> Y+3
;	devID -> R16
;	base -> R17,R18
	LDI  R16,160
	LDI  R17,0
	LDI  R18,0
	LDD  R30,Y+3
	LSL  R30
	ADD  R16,R30
;     212     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x2A
;     213         base = 0x8000;    
	__GETWRN 17,18,32768
;     214     }                 
;     215     devID &= 0xF7;      // clear bit A3 
_0x2A:
	ANDI R16,LOW(247)
;     216     
;     217     // init I2C bus
;     218     i2c_init();
	RCALL _i2c_init
;     219     LED_STATUS = 0;
	CBI  0x18,4
;     220     scroll_rate = eeprom_read(devID, (WORD)base+0);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     221     scroll_type = eeprom_read(devID, (WORD)base+1);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read
	STS  _scroll_type_G1,R30
;     222     text_length = eeprom_read_w(devID, (WORD)base+2); 
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read_w
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     223     printf("index=%d scroll_rate=%d scroll_type=%d text_lenth=%d\r\n",
;     224             index,   scroll_rate,   scroll_type,   text_length); 
	__POINTW1FN _0,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+5
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDS  R30,_scroll_rate_G1
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDS  R30,_scroll_type_G1
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,16
	RCALL _printf
	ADIW R28,18
;     225     
;     226     if (text_length > MAX_LENGTH){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0xF61)
	LDI  R30,HIGH(0xF61)
	CPC  R27,R30
	BRLO _0x2B
;     227         text_length= 0;            
	LDI  R30,0
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R30
;     228     }
;     229     if (scroll_type > NOT_USE){
_0x2B:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x6)
	BRLO _0x2C
;     230         scroll_type = NOT_USE;
	LDI  R30,LOW(5)
	STS  _scroll_type_G1,R30
;     231     }          
;     232     if (scroll_rate > MAX_RATE){
_0x2C:
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x65)
	BRLO _0x2D
;     233         scroll_rate = 0;
	LDI  R30,LOW(0)
	STS  _scroll_rate_G1,R30
;     234     }
;     235     LED_STATUS = 1;   
_0x2D:
	SBI  0x18,4
;     236 }
	RJMP _0xDD
;     237                        
;     238 void SaveTextLength(BYTE index)
;     239 {
_SaveTextLength:
;     240     BYTE devID = EEPROM_DEVICE_BASE;    
;     241     WORD base = 0;   // base address
;     242     devID += index<<1;                 
	RCALL __SAVELOCR3
;	index -> Y+3
;	devID -> R16
;	base -> R17,R18
	LDI  R16,160
	LDI  R17,0
	LDI  R18,0
	LDD  R30,Y+3
	LSL  R30
	ADD  R16,R30
;     243     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x2E
;     244         base = 0x8000;    
	__GETWRN 17,18,32768
;     245     }                 
;     246     devID &= 0xF7;      // clear bit A3 
_0x2E:
	ANDI R16,LOW(247)
;     247     
;     248     i2c_init();
	RCALL _i2c_init
;     249     LED_STATUS = 0;   
	CBI  0x18,4
;     250     eeprom_write_w(devID, base+2,text_length); 
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_write_w
;     251     LED_STATUS = 1;   
	SBI  0x18,4
;     252 }
_0xDD:
	RCALL __LOADLOCR3
	ADIW R28,4
	RET
;     253 
;     254 void SaveConfig(BYTE rate,BYTE type, BYTE index)
;     255 {                     
_SaveConfig:
;     256     BYTE devID = EEPROM_DEVICE_BASE;    
;     257     WORD base = 0;   // base address
;     258     devID += index<<1;                 
	RCALL __SAVELOCR3
;	rate -> Y+5
;	type -> Y+4
;	index -> Y+3
;	devID -> R16
;	base -> R17,R18
	LDI  R16,160
	LDI  R17,0
	LDI  R18,0
	LDD  R30,Y+3
	LSL  R30
	ADD  R16,R30
;     259     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x2F
;     260         base = 0x8000;    
	__GETWRN 17,18,32768
;     261     }                 
;     262     devID &= 0xF7;      // clear bit A3  
_0x2F:
	ANDI R16,LOW(247)
;     263     i2c_init();
	RCALL _i2c_init
;     264     LED_STATUS = 0;  
	CBI  0x18,4
;     265     eeprom_write(devID, base+0,rate);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	RCALL _eeprom_write
;     266     eeprom_write(devID, base+1,type);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	ST   -Y,R30
	RCALL _eeprom_write
;     267     LED_STATUS = 1;       
	SBI  0x18,4
;     268 }
	RCALL __LOADLOCR3
	ADIW R28,6
	RET
;     269 
;     270 void SaveToEEPROM(PBYTE address,WORD length,BYTE index)
;     271 {                             
_SaveToEEPROM:
;     272     PBYTE temp = 0;     
;     273     BYTE devID = EEPROM_DEVICE_BASE;
;     274     WORD base = 0;   // base address
;     275     devID += index<<1;                 
	RCALL __SAVELOCR5
;	*address -> Y+8
;	length -> Y+6
;	index -> Y+5
;	*temp -> R16,R17
;	devID -> R18
;	base -> R19,R20
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,160
	LDI  R19,0
	LDI  R20,0
	LDD  R30,Y+5
	LSL  R30
	ADD  R18,R30
;     276     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x30
;     277         base = 0x8000;    
	__GETWRN 19,20,32768
;     278     }         				
;     279     temp = address;         
_0x30:
	__GETWRS 16,17,8
;     280         
;     281     if (length > MAX_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xF61)
	LDI  R30,HIGH(0xF61)
	CPC  R27,R30
	BRLO _0x31
;     282         return; // invalid param 
	RCALL __LOADLOCR5
	ADIW R28,10
	RET
;     283     length = (WORD)address+MAX_COLOR*(SCREEN_HEIGHT/8)*(length);         
_0x31:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDI  R26,LOW(24)
	LDI  R27,HIGH(24)
	RCALL __MULW12U
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     284     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x32
;     285         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	RCALL __DIVW21U
	RCALL __LSLW2
	RCALL __LSLW4
	SUBI R30,LOW(-64)
	SBCI R31,HIGH(-64)
	STD  Y+6,R30
	STD  Y+6+1,R31
;     286     // init I2C bus
;     287     i2c_init();
_0x32:
	RCALL _i2c_init
;     288     LED_STATUS = 0;        
	CBI  0x18,4
;     289     
;     290     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x34:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x35
;     291     {   
;     292         RESET_WATCHDOG();                          	                                              
	WDR
;     293         eeprom_write_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE);	      
	ST   -Y,R18
	MOVW R30,R16
	ADD  R30,R19
	ADC  R31,R20
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	RCALL _eeprom_write_page
;     294     }       
	__ADDWRN 16,17,64
	RJMP _0x34
_0x35:
;     295         
;     296     LED_STATUS = 1;   
	SBI  0x18,4
;     297 }
	RJMP _0xDC
;     298                       
;     299 void LoadToRAM(PBYTE address,WORD length,BYTE index)
;     300 {                         
_LoadToRAM:
;     301     PBYTE temp = 0;          
;     302     BYTE devID = EEPROM_DEVICE_BASE;
;     303     WORD base = 0;   // base address
;     304     devID += index<<1;                 
	RCALL __SAVELOCR5
;	*address -> Y+8
;	length -> Y+6
;	index -> Y+5
;	*temp -> R16,R17
;	devID -> R18
;	base -> R19,R20
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,160
	LDI  R19,0
	LDI  R20,0
	LDD  R30,Y+5
	LSL  R30
	ADD  R18,R30
;     305     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x36
;     306         base = 0x8000;    
	__GETWRN 19,20,32768
;     307     }       				
;     308     temp = address;                 
_0x36:
	__GETWRS 16,17,8
;     309 
;     310     if (length > MAX_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xF61)
	LDI  R30,HIGH(0xF61)
	CPC  R27,R30
	BRLO _0x37
;     311         return; // invalid param
_0xDC:
	RCALL __LOADLOCR5
	ADIW R28,10
	RET
;     312     length = (WORD)address+MAX_COLOR*(SCREEN_HEIGHT/8)*(length);         
_0x37:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDI  R26,LOW(24)
	LDI  R27,HIGH(24)
	RCALL __MULW12U
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     313     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x38
;     314         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	RCALL __DIVW21U
	RCALL __LSLW2
	RCALL __LSLW4
	SUBI R30,LOW(-64)
	SBCI R31,HIGH(-64)
	STD  Y+6,R30
	STD  Y+6+1,R31
;     315     // init I2C bus
;     316     i2c_init();
_0x38:
	RCALL _i2c_init
;     317     LED_STATUS = 0;             
	CBI  0x18,4
;     318  
;     319     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x3A:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x3B
;     320     {
;     321         eeprom_read_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE );	                                   
	ST   -Y,R18
	MOVW R30,R16
	ADD  R30,R19
	ADC  R31,R20
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	RCALL _eeprom_read_page
;     322         RESET_WATCHDOG();     
	WDR
;     323     }             
	__ADDWRN 16,17,64
	RJMP _0x3A
_0x3B:
;     324 
;     325     LED_STATUS = 1;   
	SBI  0x18,4
;     326 }
	RCALL __LOADLOCR5
	ADIW R28,10
	RET
;     327 
;     328 void LoadFrame(BYTE index)
;     329 {                 
_LoadFrame:
;     330     if (index >= MAX_FRAME) index=0;  
;	index -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x4)
	BRLO _0x3C
	LDI  R30,LOW(0)
	ST   Y,R30
;     331                                    
;     332     index=0;
_0x3C:
	LDI  R30,LOW(0)
	ST   Y,R30
;     333     
;     334     LoadConfig(index);  
	ST   -Y,R30
	RCALL _LoadConfig
;     335     if (scroll_type==NOT_USE){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x5)
	BRNE _0x3D
;     336         return;           
	RJMP _0xDB
;     337     }                   
;     338     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
_0x3D:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     339     LoadToRAM((PBYTE)START_RAM,text_length,index);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	ST   -Y,R30
	RCALL _LoadToRAM
;     340     stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     341     scroll_count = 0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     342     scroll_step = 0;
	LDI  R30,LOW(0)
	STS  _scroll_step_G1,R30
;     343     is_stopping = 0;
	CLT
	BLD  R2,2
;     344     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     345     {
;     346     case LEFT_RIGHT:
	CPI  R30,0
	BREQ _0x40
;     347         break;                
;     348     case RIGHT_LEFT:
	CPI  R30,LOW(0x1)
	BREQ _0x40
;     349         break;
;     350     case BOTTOM_TOP:                             
	CPI  R30,LOW(0x3)
	BREQ _0x40
;     351         break;
;     352     case TOP_BOTTOM:   
	CPI  R30,LOW(0x2)
	BREQ _0x40
;     353         break;  
;     354     case SCROLLING:
	CPI  R30,LOW(0x4)
	BRNE _0x46
;     355         start_memR = (PBYTE)START_RAM + 0*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     356         start_memG = (PBYTE)START_RAM + 1*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(5120)
	LDI  R31,HIGH(5120)
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     357         start_memB = (PBYTE)START_RAM + 2*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(8960)
	LDI  R31,HIGH(8960)
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     358         break;
;     359     default: 
_0x46:
;     360         break;
;     361     }                   
_0x40:
;     362 }
_0xDB:
	ADIW R28,1
	RET
;     363 
;     364 void SerialToRAM(PBYTE address,WORD length)                                             
;     365 {
_SerialToRAM:
;     366     PBYTE temp = 0;          
;     367     UINT i =0;     				
;     368     temp   = address;    
	RCALL __SAVELOCR4
;	*address -> Y+6
;	length -> Y+4
;	*temp -> R16,R17
;	i -> R18,R19
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,0
	LDI  R19,0
	__GETWRS 16,17,6
;     369     LED_STATUS = 0;
	CBI  0x18,4
;     370     for (i =0; i< (length)*(SCREEN_HEIGHT/8)*MAX_COLOR; i++)         
	__GETWRN 18,19,0
_0x48:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	RCALL __LSLW3
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	RCALL __MULW12U
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x49
;     371     {                          
;     372         BYTE data = 0;
;     373         data = ~getchar();
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x4A*2)
	LDI  R31,HIGH(_0x4A*2)
	RCALL __INITLOCB
;	*address -> Y+7
;	length -> Y+5
;	data -> Y+0
	RCALL _getchar
	COM  R30
	ST   Y,R30
;     374         *temp = data;
	MOVW R26,R16
	ST   X,R30
;     375         temp++;
	__ADDWRN 16,17,1
;     376         RESET_WATCHDOG();                                     
	WDR
;     377     }              
	ADIW R28,1
	__ADDWRN 18,19,1
	RJMP _0x48
_0x49:
;     378     LED_STATUS = 1;
	SBI  0x18,4
;     379 }
	RCALL __LOADLOCR4
	ADIW R28,8
	RET
;     380                       
;     381 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     382 {        
_BlankRAM:
;     383     PBYTE temp = START_RAM;
;     384     for (temp = start_addr; temp<= end_addr; temp++)    
	RCALL __SAVELOCR2
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*temp -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x4C:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x4D
;     385         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     386 }
	__ADDWRN 16,17,1
	RJMP _0x4C
_0x4D:
	RCALL __LOADLOCR2
	ADIW R28,6
	RET
;     387 
;     388 
;     389 ///////////////////////////////////////////////////////////////
;     390 // END static function(s)
;     391 ///////////////////////////////////////////////////////////////
;     392 
;     393 ///////////////////////////////////////////////////////////////           
;     394 
;     395 void InitDevice()
;     396 {
_InitDevice:
;     397 // Declare your local variables here
;     398 // Crystal Oscillator division factor: 1  
;     399 #ifdef _MEGA162_INCLUDED_ 
;     400 #pragma optsize-
;     401 CLKPR=0x80;
;     402 CLKPR=0x00;
;     403 #ifdef _OPTIMIZE_SIZE_
;     404 #pragma optsize+
;     405 #endif                    
;     406 #endif
;     407 
;     408 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;     409 DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;     410 
;     411 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
;     412 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     413 
;     414 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     415 DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
;     416 
;     417 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     418 DDRD=0x30; 
	LDI  R30,LOW(48)
	OUT  0x11,R30
;     419 
;     420 PORTE=0x00;
	LDI  R30,LOW(0)
	OUT  0x7,R30
;     421 DDRE=0xFF;
	LDI  R30,LOW(255)
	OUT  0x6,R30
;     422 
;     423 // Timer/Counter 0 initialization
;     424 // Clock source: System Clock
;     425 // Clock value: 250.000 kHz
;     426 // Mode: Normal top=FFh
;     427 // OC0 output: Disconnected
;     428 TCCR0=0x03;     // 4 us per tick
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     429 TCNT0=0x05;     // 1ms = 4*250
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     430 OCR0=0x00;      // 255 -250 = TCNT0
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     431 
;     432 #ifdef _MEGA162_INCLUDED_
;     433 UCSR0A=0x00;
;     434 UCSR0B=0x98;
;     435 UCSR0C=0x86;
;     436 UBRR0H=0x00;
;     437 UBRR0L=0x67;      //  16 MHz     
;     438 
;     439 #else // _MEGA8515_INCLUDE_     
;     440 UCSRA=0x00;
	OUT  0xB,R30
;     441 UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     442 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     443 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     444 UBRRL=0x67;       // 16 MHz
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     445 #endif
;     446 
;     447 // Lower page wait state(s): None
;     448 // Upper page wait state(s): None
;     449 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     450 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     451 
;     452 // Timer(s)/Counter(s) Interrupt(s) initialization
;     453 TIMSK=0x02;              
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     454 #ifdef _MEGA162_INCLUDED_
;     455 ETIMSK=0x00;
;     456 #endif
;     457 // Load calibration byte for osc.  
;     458 #ifdef _MEGA162_INCLUDED_
;     459 OSCCAL = 0x5E; 
;     460 #else
;     461 OSCCAL = 0xA7; 
	LDI  R30,LOW(167)
	OUT  0x4,R30
;     462 #endif            
;     463 
;     464 // I2C Bus initialization
;     465 // i2c_init();
;     466 
;     467 // DS1307 Real Time Clock initialization
;     468 // Square wave output on pin SQW/OUT: Off
;     469 // SQW/OUT pin state: 1
;     470 // rtc_init(3,0,1);
;     471 
;     472 //i2c_init(); // must be call before
;     473 //rtc_init(3,0,1); // init RTC DS1307  
;     474 //rtc_set_time(15,2,0);
;     475 //rtc_set_date(9,5,6);    
;     476                 
;     477 // Watchdog Timer initialization
;     478 // Watchdog Timer Prescaler: OSC/2048k     
;     479 #ifdef __WATCH_DOG_
;     480 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     481 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     482 #endif
;     483 }
	RET
;     484 
;     485 void PowerReset()
;     486 {      
_PowerReset:
;     487     InitDevice();
	RCALL _InitDevice
;     488     
;     489     start_memR = (PBYTE)START_RAM;
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     490     start_memG = (PBYTE)START_RAM;
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     491     start_memB = (PBYTE)START_RAM;
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     492    
;     493     LED_STATUS = 0;
	CBI  0x18,4
;     494     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);  
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     495     
;     496     LED_STATUS = 0;  
	CBI  0x18,4
;     497     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     498     LED_STATUS = 1;
	SBI  0x18,4
;     499     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     500     LED_STATUS = 0;
	CBI  0x18,4
;     501     delay_ms(100);    
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     502     LED_STATUS = 1;
	SBI  0x18,4
;     503                 
;     504     frame_index= 0;
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     505     LoadFrame(frame_index);
	ST   -Y,R30
	RCALL _LoadFrame
;     506     start_memR = (PBYTE)START_RAM + 0*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     507     start_memG = (PBYTE)START_RAM + 1*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(5120)
	LDI  R31,HIGH(5120)
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     508     start_memB = (PBYTE)START_RAM + 2*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(8960)
	LDI  R31,HIGH(8960)
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     509                  
;     510     printf("LCMS v4.00 Designed by CuongQuay\r\n");  
	__POINTW1FN _0,55
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     511     printf("cuong3ihut@yahoo.com - 0915651001\r\n");
	__POINTW1FN _0,90
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     512     printf("Release date: 03.12.2006\r\n");
	__POINTW1FN _0,126
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     513 }
	RET
;     514 
;     515 void ProcessCommand()
;     516 {
_ProcessCommand:
;     517    	#asm("cli"); 
	cli
;     518     RESET_WATCHDOG();
	WDR
;     519 
;     520     // serial message processing     
;     521     switch (rx_message)
	MOV  R30,R8
;     522     {                  
;     523     case LOAD_TEXT_MSG:
	CPI  R30,LOW(0x2)
	BREQ PC+2
	RJMP _0x51
;     524         {                
;     525             text_length = rx_wparam;      
	__PUTWMRN _text_length_G1,0,9,10
;     526             if (text_length > SCREEN_WIDTH<<1){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0x1E1)
	LDI  R30,HIGH(0x1E1)
	CPC  R27,R30
	BRLO _0x52
;     527                 text_length = SCREEN_WIDTH<<1;
	LDI  R30,LOW(480)
	LDI  R31,HIGH(480)
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     528             }
;     529             frame_index = rx_lparam&0x0F;   
_0x52:
	__GETW1R 11,12
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	STS  _frame_index_G1,R30
;     530             BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     531             SerialToRAM((PBYTE)START_RAM,text_length);                		               				
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _SerialToRAM
;     532 			SaveToEEPROM((PBYTE)START_RAM,text_length,rx_lparam);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	RCALL _SaveToEEPROM
;     533 			SaveTextLength(rx_lparam);							      
	ST   -Y,R11
	RCALL _SaveTextLength
;     534 			
;     535 			start_memR = (PBYTE)START_RAM + 0*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     536             start_memG = (PBYTE)START_RAM + 1*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(5120)
	LDI  R31,HIGH(5120)
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     537             start_memB = (PBYTE)START_RAM + 2*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(8960)
	LDI  R31,HIGH(8960)
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     538 
;     539         }				
;     540         break;           
	RJMP _0x50
;     541     case LOAD_BKGND_MSG:
_0x51:
	CPI  R30,LOW(0x3)
	BREQ _0x50
;     542         break;   
;     543     case SET_CFG_MSG: 
	CPI  R30,LOW(0xD)
	BRNE _0x54
;     544         {               
;     545             SaveConfig(rx_wparam&0x0FF,rx_wparam>>8,rx_lparam); 
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	ST   -Y,R11
	RCALL _SaveConfig
;     546         }
;     547         break;    
	RJMP _0x50
;     548     case EEPROM_SAVE_TEXT_MSG:     
_0x54:
	CPI  R30,LOW(0x7)
	BREQ _0x56
;     549     case EEPROM_SAVE_ALL_MSG:  
	CPI  R30,LOW(0xB)
	BRNE _0x57
_0x56:
;     550         break;         
	RJMP _0x50
;     551     case EEPROM_LOAD_TEXT_MSG:    
_0x57:
	CPI  R30,LOW(0x6)
	BREQ _0x59
;     552     case EEPROM_LOAD_ALL_MSG:
	CPI  R30,LOW(0xA)
	BRNE _0x5A
_0x59:
;     553         break;  
	RJMP _0x50
;     554     case POWER_CTRL_MSG:    
_0x5A:
	CPI  R30,LOW(0x10)
	BRNE _0x5C
;     555         {
;     556             power_off = rx_wparam&0x01;
	BST  R9,0
	BLD  R2,1
;     557         }
;     558         break;     
;     559     default:
_0x5C:
;     560         break;
;     561     }                 
_0x50:
;     562     send_echo_msg();            
	RCALL _send_echo_msg
;     563     rx_message = UNKNOWN_MSG;
	CLR  R8
;     564     #asm("sei");        
	sei
;     565 }           
	RET
;     566 void DelayFrame(BYTE dly)
;     567 {
;     568     BYTE i =0;
;     569     for (i=0;i<dly;i++){
;	dly -> Y+1
;	i -> R16
;     570         if (rx_message != UNKNOWN_MSG){           
;     571             break;
;     572         }   
;     573         delay_ms(10);
;     574         RESET_WATCHDOG();
;     575     }
;     576 }
;     577 ////////////////////////////////////////////////////////////////////////////////
;     578 // MAIN PROGRAM
;     579 ////////////////////////////////////////////////////////////////////////////////
;     580 void main(void)
;     581 {         
_main:
;     582     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x61
;     583         // Watchdog Reset
;     584         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     585         reset_serial(); 
	RCALL _reset_serial
;     586     }
;     587     else {      
	RJMP _0x62
_0x61:
;     588         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     589     }                                     
_0x62:
;     590      
;     591     PowerReset();                        
	RCALL _PowerReset
;     592     #asm("sei");     
	sei
;     593 
;     594     while (1){                     
_0x63:
;     595         if (rx_message != UNKNOWN_MSG){   
	TST  R8
	BREQ _0x66
;     596             ProcessCommand();   
	RCALL _ProcessCommand
;     597         }
;     598         else{           
	RJMP _0x67
_0x66:
;     599             _displayFrame();
	RCALL __displayFrame_G1
;     600             _doScroll();            
	RCALL __doScroll_G1
;     601         }
_0x67:
;     602         RESET_WATCHDOG();
	WDR
;     603     };
	RJMP _0x63
;     604 
;     605 }
_0x68:
	NOP
	RJMP _0x68
;     606                          
;     607 #include "define.h"
;     608 
;     609 ///////////////////////////////////////////////////////////////
;     610 // serial interrupt handle - processing serial message ...
;     611 ///////////////////////////////////////////////////////////////
;     612 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     613 ///////////////////////////////////////////////////////////////
;     614 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     615 extern BYTE  rx_message;
;     616 extern WORD  rx_wparam;
;     617 extern WORD  rx_lparam;
;     618 
;     619 #if RX_BUFFER_SIZE<256
;     620 unsigned char rx_wr_index,rx_counter;
;     621 #else
;     622 unsigned int rx_wr_index,rx_counter;
;     623 #endif
;     624 
;     625 void send_echo_msg();
;     626 
;     627 // USART Receiver interrupt service routine
;     628 #ifdef _MEGA162_INCLUDED_                    
;     629 interrupt [USART0_RXC] void usart_rx_isr(void)
;     630 #else
;     631 interrupt [USART_RXC] void usart_rx_isr(void)
;     632 #endif
;     633 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     634 char status,data;
;     635 #ifdef _MEGA162_INCLUDED_  
;     636 status=UCSR0A;
;     637 data=UDR0;
;     638 #else     
;     639 status=UCSRA;
	RCALL __SAVELOCR2
;	status -> R16
;	data -> R17
	IN   R16,11
;     640 data=UDR;
	IN   R17,12
;     641 #endif          
;     642     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+2
	RJMP _0x69
;     643     {
;     644         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R13
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;     645         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0x6A
	CLR  R13
;     646         if (++rx_counter == RX_BUFFER_SIZE)
_0x6A:
	INC  R14
	LDI  R30,LOW(8)
	CP   R30,R14
	BRNE _0x6B
;     647         {
;     648             rx_counter=0;
	CLR  R14
;     649             if (
;     650                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;     651                 rx_buffer[2]==WAKEUP_CHAR 
;     652                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BRNE _0x6D
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BRNE _0x6D
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ _0x6E
_0x6D:
	RJMP _0x6C
_0x6E:
;     653             {
;     654                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 8,_rx_buffer,3
;     655                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 9,_rx_buffer,4
	CLR  R10
;     656                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R9
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 9,10
;     657                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 11,_rx_buffer,6
	CLR  R12
;     658                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;     659             }
;     660             else if(
	RJMP _0x6F
_0x6C:
;     661                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;     662                 rx_buffer[2]==ESCAPE_CHAR 
;     663                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0x71
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0x71
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0x72
_0x71:
	RJMP _0x70
_0x72:
;     664             {
;     665                 rx_wr_index=0;
	CLR  R13
;     666                 rx_counter =0;
	CLR  R14
;     667             }      
;     668         };
_0x70:
_0x6F:
_0x6B:
;     669     };
_0x69:
;     670 }
	RCALL __LOADLOCR2P
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     671 
;     672 void send_echo_msg()
;     673 {
_send_echo_msg:
;     674     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;     675     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;     676     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;     677     putchar(rx_message);
	ST   -Y,R8
	RCALL _putchar
;     678     putchar(rx_wparam>>8);
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _putchar
;     679     putchar(rx_wparam&0x00FF);
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _putchar
;     680     putchar(rx_lparam>>8);        
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _putchar
;     681     putchar(rx_lparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _putchar
;     682 }  
	RET
;     683 
;     684 void reset_serial()
;     685 {
_reset_serial:
;     686     rx_wr_index=0;
	CLR  R13
;     687     rx_counter =0;
	CLR  R14
;     688     rx_message = UNKNOWN_MSG;
	CLR  R8
;     689 }
	RET
;     690 
;     691 ///////////////////////////////////////////////////////////////
;     692 // END serial interrupt handle
;     693 /////////////////////////////////////////////////////////////// 
;     694 /*****************************************************
;     695 This program was produced by the
;     696 CodeWizardAVR V1.24.4a Standard
;     697 Automatic Program Generator
;     698 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;     699 http://www.hpinfotech.com
;     700 e-mail:office@hpinfotech.com
;     701 
;     702 Project : 
;     703 Version : 
;     704 Date    : 19/5/2005
;     705 Author  : 3iGROUP                
;     706 Company : http://www.3ihut.net   
;     707 Comments: 
;     708 
;     709 
;     710 Chip type           : ATmega8515
;     711 Program type        : Application
;     712 Clock frequency     : 8.000000 MHz
;     713 Memory model        : Small
;     714 External SRAM size  : 32768
;     715 Ext. SRAM wait state: 0
;     716 Data Stack size     : 128
;     717 *****************************************************/
;     718 
;     719 #include "define.h"                                           
;     720 
;     721 #define     ACK                 1
;     722 #define     NO_ACK              0
;     723 
;     724 // I2C Bus functions
;     725 #asm
;     726    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;     727    .equ __sda_bit=3
   .equ __sda_bit=3
;     728    .equ __scl_bit=2
   .equ __scl_bit=2
;     729 #endasm                   
;     730 
;     731 #ifdef __EEPROM_WRITE_BYTE
;     732 BYTE eeprom_read(BYTE deviceID, WORD address) 
;     733 {
_eeprom_read:
;     734     BYTE data;
;     735     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	address -> Y+1
;	data -> R16
	RCALL _i2c_start
;     736     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	RCALL _i2c_write
;     737     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     738     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     739     
;     740     i2c_start();
	RCALL _i2c_start
;     741     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	RCALL _i2c_write
;     742     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _i2c_read
	MOV  R16,R30
;     743     i2c_stop();
	RCALL _i2c_stop
;     744     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0xDA
;     745 }
;     746 
;     747 void eeprom_write(BYTE deviceID, WORD address, BYTE data) 
;     748 {
_eeprom_write:
;     749     i2c_start();
;	deviceID -> Y+3
;	address -> Y+1
;	data -> Y+0
	RCALL _i2c_start
;     750     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	RCALL _i2c_write
;     751     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     752     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     753     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	RCALL _i2c_write
;     754     i2c_stop();
	RCALL _i2c_stop
;     755 
;     756     /* 10ms delay to complete the write operation */
;     757     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     758 }                                 
_0xDA:
	ADIW R28,4
	RET
;     759 
;     760 WORD eeprom_read_w(BYTE deviceID, WORD address)
;     761 {
_eeprom_read_w:
;     762     WORD result = 0;
;     763     result = eeprom_read(deviceID,address);
	RCALL __SAVELOCR2
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
	RCALL _eeprom_read
	MOV  R16,R30
	CLR  R17
;     764     result = (result<<8) | eeprom_read(deviceID,address+1);
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
	RCALL _eeprom_read
	POP  R26
	POP  R27
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	MOVW R16,R30
;     765     return result;
	MOVW R30,R16
	RCALL __LOADLOCR2
	RJMP _0xD9
;     766 }
;     767 void eeprom_write_w(BYTE deviceID, WORD address, WORD data)
;     768 {
_eeprom_write_w:
;     769     eeprom_write(deviceID,address,data>>8);
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
	RCALL _eeprom_write
;     770     eeprom_write(deviceID,address+1,data&0x0FF);    
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
	RCALL _eeprom_write
;     771 }
_0xD9:
	ADIW R28,5
	RET
;     772 
;     773 #endif // __EEPROM_WRITE_BYTE
;     774 void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     775 {
_eeprom_read_page:
;     776     BYTE i = 0;
;     777     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	RCALL _i2c_start
;     778     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	RCALL _i2c_write
;     779     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     780     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     781     
;     782     i2c_start();
	RCALL _i2c_start
;     783     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	RCALL _i2c_write
;     784                                     
;     785     while ( i < page_size-1 )
_0x73:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0x75
;     786     {
;     787         buffer[i++] = i2c_read(ACK);   // read at current
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
	RCALL _i2c_read
	POP  R26
	POP  R27
	ST   X,R30
;     788     }
	RJMP _0x73
_0x75:
;     789     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
	RCALL _i2c_read
	POP  R26
	POP  R27
	ST   X,R30
;     790          
;     791     i2c_stop();
	RCALL _i2c_stop
;     792 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     793 
;     794 void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     795 {
_eeprom_write_page:
;     796     BYTE i = 0;
;     797     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	RCALL _i2c_start
;     798     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	RCALL _i2c_write
;     799     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     800     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     801                                         
;     802     while ( i < page_size )
_0x76:
	LDD  R30,Y+1
	CP   R16,R30
	BRSH _0x78
;     803     {
;     804         i2c_write(buffer[i++]);
	MOV  R30,R16
	SUBI R16,-1
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	ST   -Y,R30
	RCALL _i2c_write
;     805         #asm("nop");#asm("nop");
	nop
	nop
;     806     }          
	RJMP _0x76
_0x78:
;     807     i2c_stop(); 
	RCALL _i2c_stop
;     808     delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     809 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     810                                               

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
__put_G4:
	LD   R26,Y
	LDD  R27,Y+1
	RCALL __GETW1P
	SBIW R30,0
	BREQ _0x79
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0x7A
_0x79:
	LDD  R30,Y+2
	ST   -Y,R30
	RCALL _putchar
_0x7A:
	ADIW R28,3
	RET
__print_G4:
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R16,0
_0x7B:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	ADIW R30,1
	STD  Y+16,R30
	STD  Y+16+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R19,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x7D
	MOV  R30,R16
	CPI  R30,0
	BRNE _0x81
	CPI  R19,37
	BRNE _0x82
	LDI  R16,LOW(1)
	RJMP _0x83
_0x82:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
_0x83:
	RJMP _0x80
_0x81:
	CPI  R30,LOW(0x1)
	BRNE _0x84
	CPI  R19,37
	BRNE _0x85
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0xDE
_0x85:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0x86
	LDI  R17,LOW(1)
	RJMP _0x80
_0x86:
	CPI  R19,43
	BRNE _0x87
	LDI  R21,LOW(43)
	RJMP _0x80
_0x87:
	CPI  R19,32
	BRNE _0x88
	LDI  R21,LOW(32)
	RJMP _0x80
_0x88:
	RJMP _0x89
_0x84:
	CPI  R30,LOW(0x2)
	BRNE _0x8A
_0x89:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0x8B
	ORI  R17,LOW(128)
	RJMP _0x80
_0x8B:
	RJMP _0x8C
_0x8A:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x80
_0x8C:
	CPI  R19,48
	BRLO _0x8F
	CPI  R19,58
	BRLO _0x90
_0x8F:
	RJMP _0x8E
_0x90:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x80
_0x8E:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0x94
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	LD   R30,X
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0x95
_0x94:
	CPI  R30,LOW(0x73)
	BRNE _0x97
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	RCALL _strlen
	MOV  R16,R30
	RJMP _0x98
_0x97:
	CPI  R30,LOW(0x70)
	BRNE _0x9A
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	RCALL _strlenf
	MOV  R16,R30
	ORI  R17,LOW(8)
_0x98:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0x9B
_0x9A:
	CPI  R30,LOW(0x64)
	BREQ _0x9E
	CPI  R30,LOW(0x69)
	BRNE _0x9F
_0x9E:
	ORI  R17,LOW(4)
	RJMP _0xA0
_0x9F:
	CPI  R30,LOW(0x75)
	BRNE _0xA1
_0xA0:
	LDI  R30,LOW(_tbl10_G4*2)
	LDI  R31,HIGH(_tbl10_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0xA2
_0xA1:
	CPI  R30,LOW(0x58)
	BRNE _0xA4
	ORI  R17,LOW(8)
	RJMP _0xA5
_0xA4:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0xD6
_0xA5:
	LDI  R30,LOW(_tbl16_G4*2)
	LDI  R31,HIGH(_tbl16_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0xA2:
	SBRS R17,2
	RJMP _0xA7
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	SBIW R26,0
	BRGE _0xA8
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0xA8:
	CPI  R21,0
	BREQ _0xA9
	SUBI R16,-LOW(1)
	RJMP _0xAA
_0xA9:
	ANDI R17,LOW(251)
_0xAA:
	RJMP _0xAB
_0xA7:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0xAB:
_0x9B:
	SBRC R17,0
	RJMP _0xAC
_0xAD:
	CP   R16,R20
	BRSH _0xAF
	SBRS R17,7
	RJMP _0xB0
	SBRS R17,2
	RJMP _0xB1
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0xB2
_0xB1:
	LDI  R19,LOW(48)
_0xB2:
	RJMP _0xB3
_0xB0:
	LDI  R19,LOW(32)
_0xB3:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	SUBI R20,LOW(1)
	RJMP _0xAD
_0xAF:
_0xAC:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0xB4
_0xB5:
	CPI  R18,0
	BREQ _0xB7
	SBRS R17,3
	RJMP _0xB8
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0xDF
_0xB8:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0xDF:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xBA
	SUBI R20,LOW(1)
_0xBA:
	SUBI R18,LOW(1)
	RJMP _0xB5
_0xB7:
	RJMP _0xBB
_0xB4:
_0xBD:
	LDI  R19,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,2
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
_0xBF:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0xC1
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0xBF
_0xC1:
	CPI  R19,58
	BRLO _0xC2
	SBRS R17,3
	RJMP _0xC3
	SUBI R19,-LOW(7)
	RJMP _0xC4
_0xC3:
	SUBI R19,-LOW(39)
_0xC4:
_0xC2:
	SBRC R17,4
	RJMP _0xC6
	CPI  R19,49
	BRSH _0xC8
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0xC7
_0xC8:
	RJMP _0xE0
_0xC7:
	CP   R20,R18
	BRLO _0xCC
	SBRS R17,0
	RJMP _0xCD
_0xCC:
	RJMP _0xCB
_0xCD:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0xCE
	LDI  R19,LOW(48)
_0xE0:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0xCF
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xD0
	SUBI R20,LOW(1)
_0xD0:
_0xCF:
_0xCE:
_0xC6:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xD1
	SUBI R20,LOW(1)
_0xD1:
_0xCB:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0xBE
	RJMP _0xBD
_0xBE:
_0xBB:
	SBRS R17,0
	RJMP _0xD2
_0xD3:
	CPI  R20,0
	BREQ _0xD5
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0xD3
_0xD5:
_0xD2:
_0xD6:
_0x95:
_0xDE:
	LDI  R16,LOW(0)
_0x80:
	RJMP _0x7B
_0x7D:
	RCALL __LOADLOCR6
	ADIW R28,18
	RET
_printf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,2
	RCALL __SAVELOCR2
	MOVW R26,R28
	RCALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,0
	STD  Y+2,R30
	STD  Y+2+1,R30
	MOVW R26,R28
	ADIW R26,4
	RCALL __ADDW2R15
	RCALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	RCALL __print_G4
	RCALL __LOADLOCR2
	ADIW R28,4
	POP  R15
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

_strlenf:
	clr  r26
	clr  r27
	ld   r30,y+
	ld   r31,y+
__strlenf0:
	lpm  r0,z+
	tst  r0
	breq __strlenf1
	adiw r26,1
	rjmp __strlenf0
__strlenf1:
	movw r30,r26
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

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

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

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
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

__LOADLOCR2P:
	LD   R16,Y+
	LD   R17,Y+
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
