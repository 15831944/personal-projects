
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
;Data Stack size        : 128 byte(s)
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
	LDI  R28,LOW(0xE0)
	LDI  R29,HIGH(0xE0)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xE0
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
;      38 bit is_power_off         = 0;     
;      39 bit is_stopping          = 0;   
;      40 bit is_half_above        = 0;
;      41 bit is_half_below        = 0; 
;      42 
;      43 register UINT count_row  = 0;
;      44 register UINT count_col  = 0;     
;      45 register signed horiz_idx  = 0;
;      46 
;      47 static BYTE scroll_rate   = 0; 
_scroll_rate_G1:
	.BYTE 0x1
;      48 static BYTE scroll_type   = 0;    
_scroll_type_G1:
	.BYTE 0x1
;      49 static BYTE frame_index   = 0;                                 
_frame_index_G1:
	.BYTE 0x1
;      50 
;      51 static UINT  tick_count  = 0;      
_tick_count_G1:
	.BYTE 0x2
;      52 static UINT  char_count  = 0;
_char_count_G1:
	.BYTE 0x2
;      53 static UINT  text_length = 0;
_text_length_G1:
	.BYTE 0x2
;      54 static UINT  stopping_count = 0;
_stopping_count_G1:
	.BYTE 0x2
;      55 static UINT  flipping_count = 0;
_flipping_count_G1:
	.BYTE 0x2
;      56 static UINT  char_index = 0;
_char_index_G1:
	.BYTE 0x2
;      57 static UINT  next_char_width = 0;
_next_char_width_G1:
	.BYTE 0x2
;      58 static UINT  current_char_width = 0;      
_current_char_width_G1:
	.BYTE 0x2
;      59 #ifdef _MEGA162_INCLUDED_
;      60 static UINT  char_width[256];    
;      61 static UINT  columeH = 0;
;      62 static UINT  columeL = 0;
;      63 #endif
;      64 
;      65 flash char  szText[] = "** CuongQuay 0915651001 **";    

	.CSEG
;      66 #define DATE_FORMAT_STR "Bay gio la %02d gio %02d phut %02d giay. Ngay %02d thang %02d nam %0004d."
;      67 static char szDateStr[] = DATE_FORMAT_STR;

	.DSEG
_szDateStr_G1:
	.BYTE 0x4A
;      68              
;      69 // Global variables for message control
;      70 BYTE  rx_message = UNKNOWN_MSG;
;      71 WORD  rx_wparam  = 0;
;      72 WORD  rx_lparam  = 0;
;      73 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;      74                             
;      75 extern void reset_serial();         
;      76 extern void send_echo_msg();    
;      77 extern BYTE eeprom_read(BYTE deviceID, PBYTE address);
;      78 extern void eeprom_write(BYTE deviceID, PBYTE address, BYTE data);
;      79 extern WORD eeprom_read_w(BYTE deviceID, PBYTE address);
;      80 extern void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data);
;      81 extern void eeprom_write_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size);
;      82 extern void eeprom_read_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size);
;      83 
;      84 static void _displayFrame();
;      85 static void _doScroll(); 
;      86                                                                                  
;      87 extern void getLunarStr(char* sz, short h, short m, short dd, short mm, int yyyy);
;      88 
;      89 void LoadFrame();      
;      90 void BlankRAM(PBYTE start_addr,PBYTE end_addr);
;      91 ///////////////////////////////////////////////////////////////
;      92 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;      93 ///////////////////////////////////////////////////////////////
;      94 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;      95 {       

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;      96     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;      97     ++tick_count;    
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	ADIW R30,1
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R31
;      98 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;      99 
;     100 
;     101 ///////////////////////////////////////////////////////////////
;     102 // static function(s) for led matrix display panel
;     103 ///////////////////////////////////////////////////////////////
;     104 static void _setRow()
;     105 {
__setRow_G1:
;     106     BYTE i=0;      
;     107     for (i=0; i<8; i++){            
	ST   -Y,R16
;	i -> R16
	LDI  R16,0
	LDI  R16,LOW(0)
_0x4:
	CPI  R16,8
	BRSH _0x5
;     108         if (i==(7-count_row)) SCAN_DAT = ON;        
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	SUB  R30,R4
	SBC  R31,R5
	MOV  R26,R16
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x6
	CBI  0x12,5
;     109         else SCAN_DAT = OFF;        
	RJMP _0x7
_0x6:
	SBI  0x12,5
;     110         SCAN_CLK = 1;
_0x7:
	SBI  0x12,3
;     111         SCAN_CLK = 0;            
	CBI  0x12,3
;     112     }
	SUBI R16,-1
	RJMP _0x4
_0x5:
;     113 }
	RJMP _0x118
;     114             
;     115 static void _powerOff()
;     116 {
__powerOff_G1:
;     117     BYTE i =0;               
;     118     SCAN_DAT = OFF;  // data scan low        
	ST   -Y,R16
;	i -> R16
	LDI  R16,0
	SBI  0x12,5
;     119     for (i=0; i< 8; i++)    
	LDI  R16,LOW(0)
_0x9:
	CPI  R16,8
	BRSH _0xA
;     120     {                                              
;     121         SCAN_CLK = 1;    // clock scan high
	SBI  0x12,3
;     122         SCAN_CLK = 0;    // clock scan low            
	CBI  0x12,3
;     123     }                                         
	SUBI R16,-1
	RJMP _0x9
_0xA:
;     124     SCAN_STB = 1;    // strobe scan high
	SBI  0x12,4
;     125     SCAN_STB = 0;    // strobe scan low                    
	CBI  0x12,4
;     126 }
_0x118:
	LD   R16,Y+
	RET
;     127 
;     128 static void _displayFrame()
;     129 {                   
__displayFrame_G1:
;     130     count_col = 0;
	CLR  R6
	CLR  R7
;     131     count_row = 0;         
	CLR  R4
	CLR  R5
;     132 
;     133     if (is_power_off ==1){
	SBRS R2,1
	RJMP _0xB
;     134         _powerOff();
	RCALL __powerOff_G1
;     135         return;
	RET
;     136     }
;     137 #ifdef _MEGA162_INCLUDED_             
;     138     columeL = current_char_width + (START_RAM_TEXT + SCREEN_WIDTH) - (WORD)start_mem;
;     139     columeH = next_char_width + (START_RAM_TEXT + SCREEN_WIDTH) - (WORD)start_mem;         	                                           
;     140 #endif
;     141     // display one frame in the screen at the specific time 
;     142     for (buffer = start_mem;buffer < (END_RAM); buffer++)  
_0xB:
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
_0xD:
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	CPI  R26,LOW(0x7FFF)
	LDI  R30,HIGH(0x7FFF)
	CPC  R27,R30
	BRLO PC+2
	RJMP _0xE
;     143     { 
;     144 #ifdef _MEGA162_INCLUDED_                                     
;     145         if (scroll_type == FLYING_TEXT && current_char_width < SCREEN_WIDTH)
;     146 		{                                  		        
;     147 			if (count_col < current_char_width){				
;     148 				if (is_show_bkgnd){
;     149                     DATA_PORT = org_mem[count_row*DATA_LENGTH + SCREEN_WIDTH + count_col]&
;     150                             (bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);	
;     151                 }                               
;     152                 else{
;     153                     DATA_PORT = org_mem[count_row*DATA_LENGTH + SCREEN_WIDTH + count_col];
;     154                 }
;     155 			}
;     156 			else if ((count_col > columeL) && (count_col < columeH)){				
;     157 				if (is_show_bkgnd){
;     158 				    DATA_PORT = (*buffer)&(bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);								
;     159 				}                                                    
;     160 				else{
;     161 				    DATA_PORT = (*buffer);
;     162 				}
;     163 			}
;     164 			else{                  
;     165 			    if (is_show_bkgnd){
;     166     	    		DATA_PORT = (bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);                				
;     167     	        }
;     168     	        else{
;     169     	            DATA_PORT = 0xFF;
;     170     	        }
;     171 			}                                                               			
;     172         }
;     173         else     	                  
;     174 #endif  //_MEGA162_INCLUDED_                     
;     175         {
;     176             if ( is_half_above ==1){                            
	SBRS R2,3
	RJMP _0xF
;     177                 if (horiz_idx < 8){
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R8,R30
	CPC  R9,R31
	BRGE _0x10
;     178                     if (count_row > 7-horiz_idx){
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	SUB  R30,R8
	SBC  R31,R9
	CP   R30,R4
	CPC  R31,R5
	BRSH _0x11
;     179                         DATA_PORT = *(buffer+horiz_idx*DATA_LENGTH-8*DATA_LENGTH)>>2;
	MOVW R26,R8
	LDI  R30,LOW(3776)
	LDI  R31,HIGH(3776)
	RCALL __MULW12
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	ADD  R26,R30
	ADC  R27,R31
	SUBI R26,LOW(30208)
	SBCI R27,HIGH(30208)
	LD   R30,X
	LSR  R30
	LSR  R30
	RJMP _0x119
;     180                     }
;     181                     else{                             
_0x11:
;     182                         DATA_PORT = *(buffer+horiz_idx*DATA_LENGTH);
	MOVW R26,R8
	LDI  R30,LOW(3776)
	LDI  R31,HIGH(3776)
	RCALL __MULW12
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
_0x119:
	OUT  0x18,R30
;     183                     }  
;     184                 }
;     185                 else{                                                        
	RJMP _0x13
_0x10:
;     186                     if (count_row < (16-horiz_idx)){
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	SUB  R30,R8
	SBC  R31,R9
	CP   R4,R30
	CPC  R5,R31
	BRSH _0x14
;     187                         DATA_PORT = *(buffer+(horiz_idx-8)*DATA_LENGTH)>>2 | 0xCC;
	MOVW R26,R8
	SBIW R26,8
	LDI  R30,LOW(3776)
	LDI  R31,HIGH(3776)
	RCALL __MULW12
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	LSR  R30
	LSR  R30
	ORI  R30,LOW(0xCC)
	RJMP _0x11A
;     188                     }
;     189                     else{
_0x14:
;     190                         DATA_PORT = 0xFF;
	LDI  R30,LOW(255)
_0x11A:
	OUT  0x18,R30
;     191                     }
;     192                 }                    
_0x13:
;     193             }
;     194             else if ( is_half_below ==1){         
	RJMP _0x16
_0xF:
	SBRS R2,4
	RJMP _0x17
;     195                 if (horiz_idx < 8){
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R8,R30
	CPC  R9,R31
	BRGE _0x18
;     196                     if (count_row < horiz_idx){
	__CPWRR 4,5,8,9
	BRSH _0x19
;     197                         DATA_PORT = *(buffer+8*DATA_LENGTH-horiz_idx*DATA_LENGTH)<<2 | 0x33;
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	SUBI R30,LOW(-30208)
	SBCI R31,HIGH(-30208)
	MOVW R22,R30
	MOVW R26,R8
	LDI  R30,LOW(3776)
	LDI  R31,HIGH(3776)
	RCALL __MULW12
	MOVW R26,R22
	SUB  R26,R30
	SBC  R27,R31
	LD   R30,X
	LSL  R30
	LSL  R30
	ORI  R30,LOW(0x33)
	RJMP _0x11B
;     198                     }
;     199                     else{
_0x19:
;     200                         DATA_PORT = *(buffer-horiz_idx*DATA_LENGTH);
	MOVW R26,R8
	LDI  R30,LOW(3776)
	LDI  R31,HIGH(3776)
	RCALL __MULW12
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	SUB  R26,R30
	SBC  R27,R31
	LD   R30,X
_0x11B:
	OUT  0x18,R30
;     201                     }   
;     202                 }                    
;     203                 else{                                             
	RJMP _0x1B
_0x18:
;     204                     if (count_row > horiz_idx-8){
	MOVW R30,R8
	SBIW R30,8
	CP   R30,R4
	CPC  R31,R5
	BRSH _0x1C
;     205                         DATA_PORT = *(buffer+8*DATA_LENGTH-horiz_idx*DATA_LENGTH)<<2 | 0x33;
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	SUBI R30,LOW(-30208)
	SBCI R31,HIGH(-30208)
	MOVW R22,R30
	MOVW R26,R8
	LDI  R30,LOW(3776)
	LDI  R31,HIGH(3776)
	RCALL __MULW12
	MOVW R26,R22
	SUB  R26,R30
	SBC  R27,R31
	LD   R30,X
	LSL  R30
	LSL  R30
	ORI  R30,LOW(0x33)
	RJMP _0x11C
;     206                     }
;     207                     else{
_0x1C:
;     208                         DATA_PORT = 0xFF;
	LDI  R30,LOW(255)
_0x11C:
	OUT  0x18,R30
;     209                     }
;     210                 }
_0x1B:
;     211             }                
;     212             else{
	RJMP _0x1E
_0x17:
;     213                 if (is_show_bkgnd){                
	SBRS R2,0
	RJMP _0x1F
;     214                     DATA_PORT = (*buffer)&(bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	LD   R22,X
	MOVW R30,R4
	LDI  R26,LOW(160)
	LDI  R27,HIGH(160)
	RCALL __MULW12U
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_bkgnd_mem_G1
	LDS  R27,_bkgnd_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	AND  R30,R22
	RJMP _0x11D
;     215                 }                     
;     216                 else{                     
_0x1F:
;     217                     DATA_PORT = (*buffer);
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	LD   R30,X
_0x11D:
	OUT  0x18,R30
;     218                 }
;     219             }            
_0x1E:
_0x16:
;     220                          
;     221         }              
;     222         #ifdef ENABLE_MASK_ROW  
;     223             DATA_PORT |= ENABLE_MASK_ROW;
	IN   R30,0x18
	ORI  R30,LOW(0xFA)
	OUT  0x18,R30
;     224         #endif //ENABLE_MASK_ROW
;     225 
;     226         DATA_CLK = 1;    // clock high
	SBI  0x7,2
;     227         DATA_CLK = 0;    // clock low   
	CBI  0x7,2
;     228         if ( ++count_col >= SCREEN_WIDTH)
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	CPI  R30,LOW(0xA0)
	LDI  R26,HIGH(0xA0)
	CPC  R31,R26
	BRLO _0x21
;     229         {                                            
;     230             count_col = 0;      // reset for next                                                                                                                       
	CLR  R6
	CLR  R7
;     231             _powerOff();        // turn all led off            
	RCALL __powerOff_G1
;     232             _setRow();          // turn row-led on
	RCALL __setRow_G1
;     233                                                               
;     234             SCAN_STB = 1;       // strobe high            
	SBI  0x12,4
;     235             SCAN_STB = 0;       // strobe low        
	CBI  0x12,4
;     236             DATA_STB = 1;       // strobe high            
	SBI  0x7,0
;     237             DATA_STB = 0;       // strobe low            
	CBI  0x7,0
;     238                         
;     239             if (++count_row >= 8){ 
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	SBIW R30,8
	BRLO _0x22
;     240                 count_row = 0;
	CLR  R4
	CLR  R5
;     241             }                                                                                         
;     242             buffer += (DATA_LENGTH - SCREEN_WIDTH);                 
_0x22:
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	SUBI R30,LOW(-3616)
	SBCI R31,HIGH(-3616)
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
;     243         }                   
;     244     }                         	
_0x21:
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	ADIW R30,1
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
	RJMP _0xD
_0xE:
;     245 }     
	RET
;     246                                   
;     247 static void _doScroll()
;     248 {
__doScroll_G1:
;     249     // init state                         
;     250     DATA_STB = 0;
	CBI  0x7,0
;     251     DATA_CLK = 0;   
	CBI  0x7,2
;     252                             
;     253     // scroll left with shift_step bit(s)
;     254     if(tick_count >= scroll_rate)
	LDS  R30,_scroll_rate_G1
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	LDI  R31,0
	CP   R26,R30
	CPC  R27,R31
	BRSH PC+2
	RJMP _0x23
;     255     {                             
;     256         tick_count = 0; 
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     257         is_show_bkgnd = 0;          
	CLT
	BLD  R2,0
;     258         switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     259         {
;     260         case FLYING_TEXT:        
	CPI  R30,LOW(0x1)
	BRNE _0x27
;     261 #ifdef _MEGA162_INCLUDED_                      
;     262             if (current_char_width > SCREEN_WIDTH){
;     263                 if (is_stopping==0){
;     264                     if (stopping_count < MAX_STOP_TIME){
;     265                         is_stopping = 1;
;     266                         start_mem = (PBYTE)(START_RAM_TEXT+SCREEN_WIDTH);
;     267                     }
;     268                     else{
;     269                         start_mem++;
;     270                     }
;     271                 }
;     272                 else{
;     273                     if (++stopping_count > MAX_STOP_TIME){
;     274                         is_stopping = 0;
;     275                     }
;     276                 }
;     277                                   
;     278             }
;     279 		    else{
;     280 			    start_mem += (8);
;     281     			if (start_mem > (START_RAM_TEXT + SCREEN_WIDTH) - current_char_width){
;     282 		    		char_index++;				 
;     283 			    	current_char_width = char_width[char_index];
;     284 				    next_char_width = char_width[char_index+1];				
;     285     				start_mem = (PBYTE)START_RAM_TEXT + current_char_width;
;     286 	    		}
;     287 		    }  
;     288 		    if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length){
;     289 		        LoadFrame();
;     290 		    }                         
;     291 #endif //_MEGA162_INCLUDED_             		    
;     292             break;
	RJMP _0x26
;     293         case SCROLL_TEXT:
_0x27:
	CPI  R30,0
	BRNE _0x28
;     294             start_mem++;    
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,1
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
	SBIW R30,1
;     295             if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-2736)
	SBCI R31,HIGH(-2736)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x29
;     296 		        LoadFrame();
	RCALL _LoadFrame
;     297 		    }
;     298             break;
_0x29:
	RJMP _0x26
;     299         case FLIPPING_TEXT:                                  
_0x28:
	CPI  R30,LOW(0x2)
	BREQ PC+2
	RJMP _0x2A
;     300             if (start_mem < (START_RAM_TEXT + SCREEN_WIDTH)){		    
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xAA0)
	LDI  R30,HIGH(0xAA0)
	CPC  R27,R30
	BRSH _0x2B
;     301                 start_mem+=32;    
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,32
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     302             }
;     303             else {		    
	RJMP _0x2C
_0x2B:
;     304                 if (is_power_off==0){                
	SBRC R2,1
	RJMP _0x2D
;     305                     if (++stopping_count > MAX_STOP_TIME/2){
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,51
	BRLO _0x2E
;     306                         is_power_off=1;                    
	SET
	BLD  R2,1
;     307                         stopping_count=0;                
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     308                     }
;     309                 }
_0x2E:
;     310                 else{                                     
	RJMP _0x2F
_0x2D:
;     311                     if (++stopping_count > MAX_STOP_TIME){            
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x30
;     312                         is_power_off=0;
	CLT
	BLD  R2,1
;     313                         stopping_count=0;                    
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     314                         if(++flipping_count > MAX_FLIP_TIME){
	LDS  R26,_flipping_count_G1
	LDS  R27,_flipping_count_G1+1
	ADIW R26,1
	STS  _flipping_count_G1,R26
	STS  _flipping_count_G1+1,R27
	SBIW R26,4
	BRLO _0x31
;     315                             flipping_count=0;
	LDI  R30,0
	STS  _flipping_count_G1,R30
	STS  _flipping_count_G1+1,R30
;     316                             LoadFrame();
	RCALL _LoadFrame
;     317                         }
;     318                     }
_0x31:
;     319                 }
_0x30:
_0x2F:
;     320             }
_0x2C:
;     321             break;
	RJMP _0x26
;     322         case SHOW_BKGND:      
_0x2A:
	CPI  R30,LOW(0x3)
	BRNE _0x32
;     323             start_mem++;    
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,1
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
	SBIW R30,1
;     324             is_show_bkgnd = 1;            
	SET
	BLD  R2,0
;     325             if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-2736)
	SBCI R31,HIGH(-2736)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x33
;     326 		        LoadFrame();
	RCALL _LoadFrame
;     327 		    }
;     328             break;     
_0x33:
	RJMP _0x26
;     329         case RIGHT_LEFT:
_0x32:
	CPI  R30,LOW(0x4)
	BREQ PC+2
	RJMP _0x34
;     330             if (start_mem < (START_RAM_TEXT + SCREEN_WIDTH)){		    
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xAA0)
	LDI  R30,HIGH(0xAA0)
	CPC  R27,R30
	BRSH _0x35
;     331                 start_mem+=8;    
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
	RJMP _0x11E
;     332             }   
;     333             else if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH) && start_mem < (START_RAM_TEXT + SCREEN_WIDTH)+8){
_0x35:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xAA0)
	LDI  R30,HIGH(0xAA0)
	CPC  R27,R30
	BRLO _0x38
	CPI  R26,LOW(0xAA8)
	LDI  R30,HIGH(0xAA8)
	CPC  R27,R30
	BRLO _0x39
_0x38:
	RJMP _0x37
_0x39:
;     334                 if (is_stopping==0){
	SBRC R2,2
	RJMP _0x3A
;     335                     is_stopping =1;
	SET
	BLD  R2,2
;     336                 }
;     337                 else{
	RJMP _0x3B
_0x3A:
;     338                     if (++stopping_count > MAX_STOP_TIME){                       
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x3C
;     339                         is_stopping = 0; 
	CLT
	BLD  R2,2
;     340                         start_mem +=8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     341                     }
;     342                 }
_0x3C:
_0x3B:
;     343             }
;     344             else{
	RJMP _0x3D
_0x37:
;     345                 if (is_stopping==0){
	SBRC R2,2
	RJMP _0x3E
;     346                     start_mem++; 
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,1
_0x11E:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     347                 }
;     348             }                   
_0x3E:
_0x3D:
;     349             if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-2736)
	SBCI R31,HIGH(-2736)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x3F
;     350 		        LoadFrame();
	RCALL _LoadFrame
;     351 		    }
;     352             break;      
_0x3F:
	RJMP _0x26
;     353 #ifdef  __SCROLL_TOP_            
;     354         case SCROLL_TOP: 
_0x34:
	CPI  R30,LOW(0x5)
	BRNE _0x40
;     355             if (is_half_above==1){ 
	SBRS R2,3
	RJMP _0x41
;     356                 if (is_stopping ==0){            
	SBRC R2,2
	RJMP _0x42
;     357                     if (++horiz_idx >=SCREEN_HEIGHT){                
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
	SBIW R30,16
	BRLT _0x43
;     358                         is_half_below = 0;
	CLT
	BLD  R2,4
;     359                         is_half_above = 0;
	BLD  R2,3
;     360                         LoadFrame(); 
	RCALL _LoadFrame
;     361                     }
;     362                 }
_0x43:
;     363                 else{                  
	RJMP _0x44
_0x42:
;     364                     if (++stopping_count > MAX_STOP_TIME){                       
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x45
;     365                         is_stopping = 0;
	CLT
	BLD  R2,2
;     366                     }
;     367                 }
_0x45:
_0x44:
;     368             }
;     369             else if (is_half_below==1){                
	RJMP _0x46
_0x41:
	SBRS R2,4
	RJMP _0x47
;     370                 if (--horiz_idx <0){
	MOVW R30,R8
	SBIW R30,1
	MOVW R8,R30
	MOVW R26,R30
	SBIW R26,0
	BRGE _0x48
;     371                     horiz_idx =0; 
	CLR  R8
	CLR  R9
;     372                     is_half_below = 0;
	CLT
	BLD  R2,4
;     373                     is_half_above = 1;
	SET
	BLD  R2,3
;     374                     is_stopping =1;
	BLD  R2,2
;     375                     stopping_count = 0; 
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     376                 }   
;     377             }                                
_0x48:
;     378             break;        
_0x47:
_0x46:
	RJMP _0x26
;     379 #endif
;     380 #ifdef  __SCROLL_BOTTOM_            
;     381         case SCROLL_BOTTOM:
_0x40:
	CPI  R30,LOW(0x6)
	BRNE _0x52
;     382             if (is_half_below==1){       
	SBRS R2,4
	RJMP _0x4A
;     383                 if (is_stopping ==0){      
	SBRC R2,2
	RJMP _0x4B
;     384                     if (++horiz_idx >=SCREEN_HEIGHT){                
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
	SBIW R30,16
	BRLT _0x4C
;     385                         is_half_below = 0;
	CLT
	BLD  R2,4
;     386                         is_half_above = 0; 
	BLD  R2,3
;     387                         LoadFrame();                       
	RCALL _LoadFrame
;     388                     }
;     389                 }
_0x4C:
;     390                 else{
	RJMP _0x4D
_0x4B:
;     391                     if (++stopping_count > MAX_STOP_TIME){                       
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x4E
;     392                         is_stopping = 0;
	CLT
	BLD  R2,2
;     393                     }
;     394                 }
_0x4E:
_0x4D:
;     395             }
;     396             else if (is_half_above==1){
	RJMP _0x4F
_0x4A:
	SBRS R2,3
	RJMP _0x50
;     397                 if (--horiz_idx <0){
	MOVW R30,R8
	SBIW R30,1
	MOVW R8,R30
	MOVW R26,R30
	SBIW R26,0
	BRGE _0x51
;     398                     horiz_idx =0; 
	CLR  R8
	CLR  R9
;     399                     is_half_below = 1;
	SET
	BLD  R2,4
;     400                     is_half_above = 0;     
	CLT
	BLD  R2,3
;     401                     is_stopping =1;
	SET
	BLD  R2,2
;     402                     stopping_count = 0; 
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     403                 }  
;     404             }                       
_0x51:
;     405             break;              
_0x50:
_0x4F:
;     406 #endif
;     407 #ifdef __SHOW_DATE_STR_            
;     408         case SHOW_DATE_STR:            
;     409             start_mem++;    
;     410             if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length){
;     411 		        LoadFrame();
;     412 		    }            
;     413             break; 
;     414 #endif            
;     415         default:
_0x52:
;     416             break;
;     417         }
_0x26:
;     418     }        
;     419 
;     420 }                 
_0x23:
	RET
;     421 
;     422                                           
;     423 ////////////////////////////////////////////////////////////////////
;     424 // General functions
;     425 //////////////////////////////////////////////////////////////////// 
;     426 #define RESET_WATCHDOG()    #asm("WDR");
;     427 
;     428 void SerialToRAM(PBYTE address,WORD length, BYTE type)                                             
;     429 {
_SerialToRAM:
;     430     PBYTE temp = 0;          
;     431     UINT i =0, row =0;     				
;     432     temp   = (PBYTE)address;    
	RCALL __SAVELOCR6
;	*address -> Y+9
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
;     433     LED_STATUS = 0;
	CBI  0x18,4
;     434     for (row =0; row < 8; row++)
	__GETWRN 20,21,0
_0x54:
	__CPWRN 20,21,8
	BRSH _0x55
;     435     {
;     436         for (i =0; i< length; i++) 
	__GETWRN 18,19,0
_0x57:
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x58
;     437         {
;     438             *temp++ = ~getchar();
	PUSH R17
	PUSH R16
	__ADDWRN 16,17,1
	RCALL _getchar
	COM  R30
	POP  R26
	POP  R27
	ST   X,R30
;     439             RESET_WATCHDOG();
	WDR
;     440         }                               
	__ADDWRN 18,19,1
	RJMP _0x57
_0x58:
;     441         if (type == FRAME_TEXT)   
	LDD  R30,Y+6
	CPI  R30,0
	BRNE _0x59
;     442             temp += DATA_LENGTH - length;        
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LDI  R30,LOW(3776)
	LDI  R31,HIGH(3776)
	SUB  R30,R26
	SBC  R31,R27
	__ADDWRR 16,17,30,31
;     443     }              
_0x59:
	__ADDWRN 20,21,1
	RJMP _0x54
_0x55:
;     444     LED_STATUS = 1;
	SBI  0x18,4
;     445 }
	RCALL __LOADLOCR6
	ADIW R28,11
	RET
;     446 
;     447 void LoadCharWidth(WORD length)
;     448 {
_LoadCharWidth:
;     449 #ifdef _MEGA162_INCLUDED_                                            
;     450     UINT i =0;  
;     451     LED_STATUS = 0;   
;     452     for (i =0; i < length; i++)
;     453     {                           
;     454         WORD data = 0;
;     455         data = getchar();                       // LOBYTE 
;     456         RESET_WATCHDOG();       
;     457         char_width[i] = data;        
;     458         data = getchar();                       // HIBYTE
;     459         RESET_WATCHDOG();
;     460         char_width[i] |= (data<<8)&0xFF00;
;     461     }                  
;     462     current_char_width = 0xFFFF;
;     463     
;     464     LED_STATUS = 1;                   
;     465 #endif    
;     466 }
	ADIW R28,2
	RET
;     467 
;     468 void SaveCharWidth(WORD length, BYTE index)
;     469 {     
_SaveCharWidth:
;     470 #ifdef _MEGA162_INCLUDED_             
;     471     UINT i =0;                 
;     472     BYTE devID = EEPROM_DEVICE_BASE;
;     473     PBYTE base  = 0x0A;   
;     474     devID += index<<1;
;     475     i2c_init();
;     476     LED_STATUS = 0;   
;     477     for (i =0; i < length; i++)
;     478     {                           
;     479         eeprom_write_w(devID,base+i<<1,char_width[i]);
;     480         RESET_WATCHDOG();
;     481     }              
;     482     LED_STATUS = 1; 
;     483     PORTD = 0x00;
;     484     DDRD = 0x3F;                      
;     485 #endif    
;     486 }
;     487 
;     488 void GetCharWidth(WORD length, BYTE index)
;     489 {     
_GetCharWidth:
;     490 #ifdef _MEGA162_INCLUDED_                                       
;     491     UINT i =0;   
;     492     BYTE devID = EEPROM_DEVICE_BASE;
;     493     PBYTE base  = 0x0A;              
;     494     devID += index<<1;
;     495     i2c_init();
;     496     LED_STATUS = 0;   
;     497     for (i =0; i < length; i++)
;     498     {                           
;     499         char_width[i] = eeprom_read_w(devID,base+i<<1);        
;     500         RESET_WATCHDOG();
;     501     }                      
;     502     LED_STATUS = 1;
;     503     PORTD = 0x00;
;     504     DDRD = 0x3F;                      
;     505 #endif    
;     506 }
_0x117:
	ADIW R28,3
	RET
;     507 
;     508 void SaveToEEPROM(PBYTE address, BYTE type, BYTE index)
;     509 {                             
_SaveToEEPROM:
;     510     PBYTE temp = 0;    
;     511     PBYTE end  = START_RAM_TEXT;     
;     512     BYTE devID = EEPROM_DEVICE_BASE;      				
;     513     devID += index<<1;
	RCALL __SAVELOCR5
;	*address -> Y+7
;	type -> Y+6
;	index -> Y+5
;	*temp -> R16,R17
;	*end -> R18,R19
;	devID -> R20
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,LOW(0xA00)
	LDI  R19,HIGH(0xA00)
	LDI  R20,160
	LDD  R30,Y+5
	LSL  R30
	ADD  R20,R30
;     514     temp   = address;         
	__GETWRS 16,17,7
;     515            
;     516     i2c_init();
	RCALL _i2c_init
;     517     LED_STATUS = 0;        
	CBI  0x18,4
;     518     
;     519     if (type == FRAME_TEXT) end = (PBYTE)END_RAM;
	LDD  R30,Y+6
	CPI  R30,0
	BRNE _0x5A
	__GETWRN 18,19,32767
;     520     
;     521     for (temp = address; temp < end; temp+= EEPROM_PAGE) 
_0x5A:
	__GETWRS 16,17,7
_0x5C:
	__CPWRR 16,17,18,19
	BRSH _0x5D
;     522     {   
;     523         RESET_WATCHDOG();               
	WDR
;     524         eeprom_write_page( devID, temp, temp, EEPROM_PAGE);	      
	ST   -Y,R20
	ST   -Y,R17
	ST   -Y,R16
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	RCALL _eeprom_write_page
;     525     }       
	__ADDWRN 16,17,64
	RJMP _0x5C
_0x5D:
;     526     LED_STATUS = 1;
	SBI  0x18,4
;     527     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     528     DDRD = 0x3F;    
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     529 }
	RCALL __LOADLOCR5
	ADIW R28,9
	RET
;     530                       
;     531 void LoadToRAM(PBYTE address, WORD length, BYTE type, BYTE index)
;     532 {                         
_LoadToRAM:
;     533     PBYTE temp = 0;          
;     534     UINT i =0, row =0;    
;     535     BYTE devID = EEPROM_DEVICE_BASE;
;     536     devID += index<<1;      				
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x5E*2)
	LDI  R31,HIGH(_0x5E*2)
	RCALL __INITLOCB
	RCALL __SAVELOCR6
;	*address -> Y+11
;	length -> Y+9
;	type -> Y+8
;	index -> Y+7
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
	LDD  R30,Y+7
	LSL  R30
	LDD  R26,Y+6
	ADD  R30,R26
	STD  Y+6,R30
;     537     temp   = address;                 
	__GETWRS 16,17,11
;     538     
;     539     if (length > DATA_LENGTH)    
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0xEC1)
	LDI  R30,HIGH(0xEC1)
	CPC  R27,R30
	BRLO _0x5F
;     540         return; // invalid param
	RCALL __LOADLOCR6
	ADIW R28,13
	RET
;     541     if (length%EEPROM_PAGE)
_0x5F:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ANDI R30,LOW(0x3F)
	BREQ _0x60
;     542         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	RCALL __DIVW21U
	RCALL __LSLW2
	RCALL __LSLW4
	SUBI R30,LOW(-64)
	SBCI R31,HIGH(-64)
	STD  Y+9,R30
	STD  Y+9+1,R31
;     543 
;     544     i2c_init();
_0x60:
	RCALL _i2c_init
;     545     LED_STATUS = 0;             
	CBI  0x18,4
;     546 
;     547     for (row =0; row < 8; row++)            
	__GETWRN 20,21,0
_0x62:
	__CPWRN 20,21,8
	BRSH _0x63
;     548     {                           
;     549         for (i =0; i< length; i+=EEPROM_PAGE) 
	__GETWRN 18,19,0
_0x65:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x66
;     550         {                                 
;     551             eeprom_read_page( devID, temp, temp, EEPROM_PAGE );	                                   
	LDD  R30,Y+6
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	RCALL _eeprom_read_page
;     552             temp += EEPROM_PAGE;
	__ADDWRN 16,17,64
;     553             RESET_WATCHDOG();     
	WDR
;     554         }         
	__ADDWRN 18,19,64
	RJMP _0x65
_0x66:
;     555         if (type == FRAME_TEXT)  
	LDD  R30,Y+8
	CPI  R30,0
	BRNE _0x67
;     556             temp += DATA_LENGTH - length;  
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	LDI  R30,LOW(3776)
	LDI  R31,HIGH(3776)
	SUB  R30,R26
	SBC  R31,R27
	__ADDWRR 16,17,30,31
;     557     }             
_0x67:
	__ADDWRN 20,21,1
	RJMP _0x62
_0x63:
;     558     
;     559     LED_STATUS = 1; 
	SBI  0x18,4
;     560     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     561     DDRD = 0x3F;  
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     562 }
	RCALL __LOADLOCR6
	ADIW R28,13
	RET
;     563 
;     564 
;     565 void LoadConfig(BYTE index)
;     566 {   
_LoadConfig:
;     567     BYTE devID = EEPROM_DEVICE_BASE;
;     568     devID += index<<1; 
	ST   -Y,R16
;	index -> Y+1
;	devID -> R16
	LDI  R16,160
	LDD  R30,Y+1
	LSL  R30
	ADD  R16,R30
;     569     i2c_init();
	RCALL _i2c_init
;     570     LED_STATUS = 1;                               
	SBI  0x18,4
;     571     scroll_type   = eeprom_read(devID,0);
	ST   -Y,R16
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read
	STS  _scroll_type_G1,R30
;     572     scroll_rate = eeprom_read(devID,(PBYTE)1);
	ST   -Y,R16
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     573     text_length =  eeprom_read_w(devID,(PBYTE)2); 
	ST   -Y,R16
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read_w
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     574     char_count =  eeprom_read_w(devID,(PBYTE)4); 
	ST   -Y,R16
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read_w
	STS  _char_count_G1,R30
	STS  _char_count_G1+1,R31
;     575     if (text_length > DATA_LENGTH){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0xEC1)
	LDI  R30,HIGH(0xEC1)
	CPC  R27,R30
	BRLO _0x68
;     576         text_length= 0;            
	LDI  R30,0
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R30
;     577     }
;     578     if (char_count > 255){
_0x68:
	LDS  R26,_char_count_G1
	LDS  R27,_char_count_G1+1
	CPI  R26,LOW(0x100)
	LDI  R30,HIGH(0x100)
	CPC  R27,R30
	BRLO _0x69
;     579         char_count = 0;
	LDI  R30,0
	STS  _char_count_G1,R30
	STS  _char_count_G1+1,R30
;     580     }
;     581     LED_STATUS = 0; 
_0x69:
	CBI  0x18,4
;     582     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     583     DDRD = 0x3F;   
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     584 }
	LDD  R16,Y+0
	RJMP _0x116
;     585 
;     586 void SaveConfig(BYTE index)
;     587 {     
_SaveConfig:
;     588     BYTE devID = EEPROM_DEVICE_BASE;
;     589     devID += index<<1; 
	ST   -Y,R16
;	index -> Y+1
;	devID -> R16
	LDI  R16,160
	LDD  R30,Y+1
	LSL  R30
	ADD  R16,R30
;     590     i2c_init();
	RCALL _i2c_init
;     591     LED_STATUS = 1;  
	SBI  0x18,4
;     592     eeprom_write(devID,(PBYTE)0,scroll_type);
	ST   -Y,R16
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_scroll_type_G1
	ST   -Y,R30
	RCALL _eeprom_write
;     593     eeprom_write(devID,(PBYTE)1,scroll_rate);   
	ST   -Y,R16
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_scroll_rate_G1
	ST   -Y,R30
	RCALL _eeprom_write
;     594     LED_STATUS = 0; 
	CBI  0x18,4
;     595     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     596     DDRD = 0x3F;   
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     597 }
	LDD  R16,Y+0
	RJMP _0x116
;     598 
;     599 void SaveTextLength(WORD length, BYTE index)
;     600 {
_SaveTextLength:
;     601     BYTE devID = EEPROM_DEVICE_BASE;
;     602     devID += index<<1; 
	ST   -Y,R16
;	length -> Y+2
;	index -> Y+1
;	devID -> R16
	LDI  R16,160
	LDD  R30,Y+1
	LSL  R30
	ADD  R16,R30
;     603     i2c_init();
	RCALL _i2c_init
;     604     LED_STATUS = 1;   
	SBI  0x18,4
;     605     eeprom_write_w(devID, (PBYTE)2,length); 
	ST   -Y,R16
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_write_w
;     606     eeprom_write_w(devID, (PBYTE)4,char_count); 
	ST   -Y,R16
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_write_w
;     607     LED_STATUS = 0;
	CBI  0x18,4
;     608     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     609     DDRD = 0x3F;        
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     610 }
	LDD  R16,Y+0
	ADIW R28,4
	RET
;     611 
;     612 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     613 {        
_BlankRAM:
;     614     PBYTE temp = START_RAM;
;     615     for (temp = start_addr; temp<= end_addr; temp++)    
	RCALL __SAVELOCR2
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*temp -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x6B:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x6C
;     616         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     617 }
	__ADDWRN 16,17,1
	RJMP _0x6B
_0x6C:
	RCALL __LOADLOCR2
	ADIW R28,6
	RET
;     618 
;     619 void SetRTCDateTime()
;     620 {
_SetRTCDateTime:
;     621     i2c_init();
	RCALL _i2c_init
;     622     LED_STATUS = 0;   
	CBI  0x18,4
;     623     rtc_set_date(getchar(),getchar(),getchar());
	RCALL _getchar
	ST   -Y,R30
	RCALL _getchar
	ST   -Y,R30
	RCALL _getchar
	ST   -Y,R30
	RCALL _rtc_set_date
;     624     rtc_set_time(getchar(),getchar(),getchar());    
	RCALL _getchar
	ST   -Y,R30
	RCALL _getchar
	ST   -Y,R30
	RCALL _getchar
	ST   -Y,R30
	RCALL _rtc_set_time
;     625     LED_STATUS = 1;
	SBI  0x18,4
;     626     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     627     DDRD = 0x3F; 
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     628 }
	RET
;     629 
;     630 static void TextFromFont(char *szText, BYTE nColor, BYTE bGradient, PBYTE pBuffer, BYTE index)
;     631 {                                             
;     632 #ifdef _MEGA162_INCLUDED_             
;     633 	int pos = 0,x=0,y=0;     
;     634 	BYTE i =0, len;
;     635 	BYTE ch = 0;
;     636 	UINT nWidth = 0;   
;     637 	UINT nCurWidth = 0, nNxtWidth = 0;		
;     638     BYTE mask = 0x00, data = 0;
;     639 	BYTE mask_clr[2] = {0x00};
;     640     BYTE devID = EEPROM_DEVICE_BASE;
;     641     devID += index<<1; 
;     642     	
;     643 	switch (nColor)
;     644 	{
;     645 	case 0:
;     646 		mask = 0xFF;		// BLANK
;     647 		mask_clr[0] = 0xFF;
;     648 		mask_clr[1] = 0xFF;
;     649 		break;
;     650 	case 1:
;     651 		mask = 0xAA;		// RED			RRRR	
;     652 		mask_clr[0] = 0x99;	// GREEN		RGRG
;     653 		mask_clr[1] = 0x88;	// YELLOW		RYRY
;     654 		break;
;     655 	case 2:
;     656 		mask = 0x55;		// GREEN		GGGG
;     657 		mask_clr[0] = 0x44;	// YELLOW		GYGY
;     658 		mask_clr[1] = 0x66;	// RED			GRGR	
;     659 		break;
;     660 	case 3:
;     661 		mask = 0x00;		// YELLOW		YYYY
;     662 		mask_clr[0] = 0x22;	// RED			YRYR	
;     663 		mask_clr[1] = 0x11;	// GREEN		YGYG
;     664 		break;
;     665 	default:
;     666 		break;
;     667 	}	
;     668                            
;     669 	LED_STATUS = 0;
;     670 	i2c_init();
;     671 	len = strlen(szText);
;     672     
;     673 	for (i=0; i< len; i++){				                                     
;     674         ch = szText[i];             
;     675 		nCurWidth = char_width[ch];
;     676 		nNxtWidth = char_width[(WORD)ch+1];
;     677 		nWidth = (nNxtWidth - nCurWidth); 		
;     678 		if ((pos + nWidth) >= DATA_LENGTH)  break;		
;     679 		for (y=0; y< 8 ; y++){    		            
;     680 		    if (bGradient) {
;     681 				if (y >=0 && y <4)	mask = mask_clr[0];
;     682 				if (y >=4 && y <8)	mask = mask_clr[1];	
;     683 			}			
;     684 			for (x=0; x< nWidth; x++){                                 
;     685 			    RESET_WATCHDOG();       
;     686 			    data = eeprom_read(devID, (PBYTE)START_RAM_TEXT + SCREEN_WIDTH + y*DATA_LENGTH + nCurWidth + x);
;     687 			    data = (~data) & (~mask);
;     688    				pBuffer[y*DATA_LENGTH + x + pos] = ~data;   				
;     689 			}					
;     690 		}
;     691 		pos += nWidth;	 		
;     692 	}	                           
;     693     
;     694     text_length = pos;
;     695             
;     696     LED_STATUS = 1;
;     697     PORTD = 0x00;
;     698     DDRD = 0x3F;                      
;     699 #endif    
;     700 }
;     701 
;     702 void LoadFrame()
;     703 {  
_LoadFrame:
;     704     is_stopping = 0;
	CLT
	BLD  R2,2
;     705     stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     706     if (++frame_index >= MAX_FRAME){
	LDS  R26,_frame_index_G1
	SUBI R26,-LOW(1)
	STS  _frame_index_G1,R26
	CPI  R26,LOW(0x4)
	BRLO _0x6D
;     707         frame_index = 0;
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     708     }                   
;     709     _powerOff();
_0x6D:
	RCALL __powerOff_G1
;     710 
;     711     LoadConfig(frame_index);              
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _LoadConfig
;     712     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     713     GetCharWidth(char_count,frame_index);                               
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _GetCharWidth
;     714     if (scroll_type != SHOW_DATE_STR){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x8)
	BREQ _0x6E
;     715         LoadToRAM((PBYTE)START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND,frame_index);    	 
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(160)
	LDI  R31,HIGH(160)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _LoadToRAM
;     716         LoadToRAM((PBYTE)START_RAM_TEXT + SCREEN_WIDTH,text_length,FRAME_TEXT,frame_index);    
	LDI  R30,LOW(2720)
	LDI  R31,HIGH(2720)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _LoadToRAM
;     717     }
;     718     printf("index=%d \r\n",frame_index);
_0x6E:
	__POINTW1FN _0,74
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _printf
	ADIW R28,6
;     719     
;     720     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     721     {
;     722     case FLYING_TEXT: 
	CPI  R30,LOW(0x1)
	BRNE _0x72
;     723         {
;     724             char_index = 0;
	LDI  R30,0
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R30
;     725             start_mem = (PBYTE)START_RAM_TEXT;        
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     726         }
;     727         break;
	RJMP _0x71
;     728     case SCROLL_TEXT:
_0x72:
	CPI  R30,0
	BREQ _0x74
;     729     case FLIPPING_TEXT:
	CPI  R30,LOW(0x2)
	BRNE _0x75
_0x74:
;     730     case RIGHT_LEFT:
	RJMP _0x76
_0x75:
	CPI  R30,LOW(0x4)
	BRNE _0x77
_0x76:
;     731         {
;     732             char_index = 0xFF;                     
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R31
;     733             start_mem = (PBYTE)START_RAM_TEXT;        
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     734         }
;     735         break;     
	RJMP _0x71
;     736 #ifdef __SCROLL_TOP_                                      
;     737     case SCROLL_TOP:
_0x77:
	CPI  R30,LOW(0x5)
	BRNE _0x78
;     738         {
;     739             is_half_above = 0;
	CLT
	BLD  R2,3
;     740             is_half_below = 1;
	SET
	BLD  R2,4
;     741             char_index = 0xFF; 
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R31
;     742             horiz_idx  = SCREEN_HEIGHT;
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	MOVW R8,R30
;     743             start_mem = (PBYTE)START_RAM_TEXT + SCREEN_WIDTH;
	LDI  R30,LOW(2720)
	LDI  R31,HIGH(2720)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     744         }
;     745         break;   
	RJMP _0x71
;     746 #endif
;     747 #ifdef __SCROLL_BOTTOM_        
;     748     case SCROLL_BOTTOM:                                                       
_0x78:
	CPI  R30,LOW(0x6)
	BRNE _0x7A
;     749         {
;     750             is_half_above = 1;
	SET
	BLD  R2,3
;     751             is_half_below = 0;                             
	CLT
	BLD  R2,4
;     752             char_index = 0xFF;        
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R31
;     753             horiz_idx  = SCREEN_HEIGHT;
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	MOVW R8,R30
;     754             start_mem = (PBYTE)START_RAM_TEXT + SCREEN_WIDTH;        
	LDI  R30,LOW(2720)
	LDI  R31,HIGH(2720)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     755         }
;     756         break;         
;     757 #endif
;     758 #ifdef __SHOW_DATE_STR_        
;     759     case SHOW_DATE_STR:
;     760         {                                                                                            
;     761             BYTE hh=0,mm=0,ss=0,DD=0,MM=0,YY=00;
;     762             i2c_init();                           
;     763             rtc_get_date(&DD,&MM,&YY);
;     764             rtc_get_time(&hh,&mm,&ss);                                                                                                      
;     765             getLunarStr(szDateStr,hh,mm,DD,MM,2000+YY);                                 
;     766             BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
;     767             TextFromFont(szDateStr, 1, 0, (PBYTE)START_RAM_TEXT + SCREEN_WIDTH, frame_index);
;     768             char_index = 0xFF;
;     769             start_mem = (PBYTE)START_RAM_TEXT;                
;     770         }
;     771         break;         
;     772 #endif        
;     773     default:        
_0x7A:
;     774         break;
;     775     }       
_0x71:
;     776     reset_serial();    
	RCALL _reset_serial
;     777 #ifdef _MEGA162_INCLUDED_
;     778     current_char_width = char_width[char_index];
;     779     next_char_width = char_width[char_index+1];
;     780 #endif
;     781 }
	RET
;     782 
;     783 ///////////////////////////////////////////////////////////////
;     784 // END static function(s)
;     785 ///////////////////////////////////////////////////////////////
;     786 
;     787 ///////////////////////////////////////////////////////////////           
;     788 
;     789 void InitDevice()
;     790 {
_InitDevice:
;     791 // Declare your local variables here
;     792 // Crystal Oscillator division factor: 1  
;     793 #ifdef _MEGA162_INCLUDED_ 
;     794 #pragma optsize-
;     795 CLKPR=0x80;
;     796 CLKPR=0x00;
;     797 #ifdef _OPTIMIZE_SIZE_
;     798 #pragma optsize+
;     799 #endif                    
;     800 #endif
;     801 
;     802 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;     803 DDRA=0x00;
	OUT  0x1A,R30
;     804 
;     805 PORTB=0x00;
	OUT  0x18,R30
;     806 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     807 
;     808 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     809 DDRC=0x00;
	OUT  0x14,R30
;     810 
;     811 PORTD = 0x00;
	OUT  0x12,R30
;     812 DDRD = 0x00;
	OUT  0x11,R30
;     813 
;     814 PORTE=0x00;
	OUT  0x7,R30
;     815 DDRE=0x05;
	LDI  R30,LOW(5)
	OUT  0x6,R30
;     816 
;     817 TCCR0=0x03; 
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     818 TCNT0=0x05; 
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     819 OCR0=0x00;  
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     820 #ifdef _MEGA162_INCLUDED_
;     821  UCSR0A=0x00;
;     822  UCSR0B=0x98;
;     823  UCSR0C=0x86;
;     824  UBRR0H=0x00;
;     825  UBRR0L=0x67;
;     826 #else
;     827  UCSRA=0x00;
	OUT  0xB,R30
;     828  UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     829  UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     830  UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     831  UBRRL=0x67;
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     832 #endif
;     833 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     834 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     835 
;     836 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     837 #ifdef _MEGA162_INCLUDED_
;     838  ETIMSK=0x00;
;     839 #endif
;     840 // I2C Bus initialization
;     841 i2c_init();
	RCALL _i2c_init
;     842 
;     843 // DS1307 Real Time Clock initialization
;     844 // Square wave output on pin SQW/OUT: Off
;     845 // SQW/OUT pin state: 1
;     846 rtc_init(0,0,1);   
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _rtc_init
;     847 
;     848 #ifdef __WATCH_DOG_
;     849  WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     850  WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     851 #endif 
;     852 
;     853 #ifdef _TEST_RTC_
;     854 {                                
;     855     BYTE hh=0,mm=0,ss=0,DD=0,MM=0,YY=0;
;     856     rtc_get_date(&DD,&MM,&YY);
;     857     rtc_get_time(&hh,&mm,&ss);
;     858     printf("%02d:%02d:%02d %02d-%02d-%02d\r\n",hh,mm,ss,DD,MM,YY);
;     859 }           
;     860 #endif                   
;     861 }
	RET
;     862 
;     863 void PowerReset()
;     864 {   
_PowerReset:
;     865     start_mem = (PBYTE)START_RAM_TEXT;     
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     866     end_mem   = (PBYTE)END_RAM;
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	STS  _end_mem_G1,R30
	STS  _end_mem_G1+1,R31
;     867     bkgnd_mem = (PBYTE)START_RAM_BK;
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _bkgnd_mem_G1,R30
	STS  _bkgnd_mem_G1+1,R31
;     868     org_mem   = (PBYTE)START_RAM_TEXT;	                   
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _org_mem_G1,R30
	STS  _org_mem_G1+1,R31
;     869 
;     870     InitDevice();
	RCALL _InitDevice
;     871                      
;     872     LED_STATUS = 0;
	CBI  0x18,4
;     873     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);    
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     874     delay_ms(500);
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     875     LED_STATUS = 1;
	SBI  0x18,4
;     876     
;     877     current_char_width = 0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _current_char_width_G1,R30
	STS  _current_char_width_G1+1,R31
;     878     next_char_width = 0xFFFF;	 
	STS  _next_char_width_G1,R30
	STS  _next_char_width_G1+1,R31
;     879     
;     880     LED_STATUS = 0;  
	CBI  0x18,4
;     881     frame_index = 0; 
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     882     LoadFrame();        
	RCALL _LoadFrame
;     883     LED_STATUS = 1;             
	SBI  0x18,4
;     884                        
;     885     // reload configuration
;     886     LED_STATUS = 0;
	CBI  0x18,4
;     887     delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     888     LED_STATUS = 1;  
	SBI  0x18,4
;     889     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     890     DDRD = 0x3F;           
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     891     printf("LCMS v2.02 \r\n");
	__POINTW1FN _0,86
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
_0x116:
	ADIW R28,2
;     892 }
	RET
;     893 
;     894 void ProcessCommand()
;     895 {
_ProcessCommand:
;     896    	#asm("cli"); 
	cli
;     897     RESET_WATCHDOG();
	WDR
;     898     // Turn off the scan board           
;     899     _powerOff();
	RCALL __powerOff_G1
;     900     // serial message processing     
;     901     switch (rx_message)
	MOV  R30,R10
;     902     {                  
;     903     case LOAD_TEXT_MSG:
	CPI  R30,LOW(0x1)
	BREQ PC+2
	RJMP _0x7E
;     904         {
;     905             if (rx_wparam > DATA_LENGTH) rx_wparam = DATA_LENGTH;
	LDI  R30,LOW(3776)
	LDI  R31,HIGH(3776)
	CP   R30,R11
	CPC  R31,R12
	BRSH _0x7F
	__PUTW1R 11,12
;     906             BlankRAM((PBYTE)START_RAM_TEXT,(PBYTE)END_RAM);
_0x7F:
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     907             frame_index = rx_lparam>>8;                       
	STS  _frame_index_G1,R14
;     908             char_count  = rx_lparam&0x00FF;                   
	__GETW1R 13,14
	ANDI R31,HIGH(0xFF)
	STS  _char_count_G1,R30
	STS  _char_count_G1+1,R31
;     909             text_length = rx_wparam;   
	__PUTWMRN _text_length_G1,0,11,12
;     910             SerialToRAM((PBYTE)START_RAM_TEXT + SCREEN_WIDTH,text_length,FRAME_TEXT);                
	LDI  R30,LOW(2720)
	LDI  R31,HIGH(2720)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _SerialToRAM
;     911             LoadCharWidth(char_count);                                                              
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _LoadCharWidth
;     912 			start_mem = (PBYTE)START_RAM_TEXT + SCREEN_WIDTH;				
	LDI  R30,LOW(2720)
	LDI  R31,HIGH(2720)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     913 	    	bkgnd_mem = (PBYTE)START_RAM_BK;		    		    		    	
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _bkgnd_mem_G1,R30
	STS  _bkgnd_mem_G1+1,R31
;     914                         
;     915             SaveCharWidth(char_count,frame_index);                           
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _SaveCharWidth
;     916             SaveToEEPROM((PBYTE)START_RAM_TEXT,FRAME_TEXT,frame_index);
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _SaveToEEPROM
;     917             SaveTextLength(text_length,frame_index);
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _SaveTextLength
;     918             current_char_width = next_char_width = 0xFFFF;								  
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _next_char_width_G1,R30
	STS  _next_char_width_G1+1,R31
	STS  _current_char_width_G1,R30
	STS  _current_char_width_G1+1,R31
;     919         }				
;     920         break;
	RJMP _0x7D
;     921     case LOAD_BKGND_MSG:
_0x7E:
	CPI  R30,LOW(0x2)
	BRNE _0x80
;     922         {
;     923             if (rx_wparam > SCREEN_WIDTH) rx_wparam = SCREEN_WIDTH;
	LDI  R30,LOW(160)
	LDI  R31,HIGH(160)
	CP   R30,R11
	CPC  R31,R12
	BRSH _0x81
	__PUTW1R 11,12
;     924             frame_index = rx_lparam>>8;  
_0x81:
	STS  _frame_index_G1,R14
;     925             BlankRAM((PBYTE)START_RAM_BK,(PBYTE)START_RAM_TEXT);                    
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     926             SerialToRAM((PBYTE)START_RAM_BK,rx_wparam,FRAME_BKGND);                                               
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R12
	ST   -Y,R11
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _SerialToRAM
;     927 		    start_mem = (PBYTE)START_RAM_TEXT + SCREEN_WIDTH;				
	LDI  R30,LOW(2720)
	LDI  R31,HIGH(2720)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     928 		    bkgnd_mem = (PBYTE)START_RAM_BK;	
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _bkgnd_mem_G1,R30
	STS  _bkgnd_mem_G1+1,R31
;     929 		    
;     930 		    SaveToEEPROM((PBYTE)START_RAM_BK,FRAME_BKGND,frame_index);			    
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _SaveToEEPROM
;     931 		}
;     932         break; 
	RJMP _0x7D
;     933     case SET_CFG_MSG:
_0x80:
	CPI  R30,LOW(0x5)
	BRNE _0x82
;     934         {    
;     935             frame_index = rx_lparam>>8;
	STS  _frame_index_G1,R14
;     936             scroll_type  = rx_wparam&0x00FF;
	__GETW1R 11,12
	STS  _scroll_type_G1,R30
;     937             scroll_rate = rx_wparam>>8;             
	STS  _scroll_rate_G1,R12
;     938             SaveConfig(frame_index);
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _SaveConfig
;     939         }
;     940         break;   
	RJMP _0x7D
;     941     case SET_RTC_MSG:
_0x82:
	CPI  R30,LOW(0x4)
	BRNE _0x84
;     942         {                                
;     943             SetRTCDateTime();
	RCALL _SetRTCDateTime
;     944         }
;     945         break;    
;     946     default:
_0x84:
;     947         break;
;     948     }                 
_0x7D:
;     949     send_echo_msg();            
	RCALL _send_echo_msg
;     950     rx_message = UNKNOWN_MSG;
	CLR  R10
;     951     #asm("sei");
	sei
;     952     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     953     DDRD = 0x3F;     
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     954 
;     955 }          
	RET
;     956 ////////////////////////////////////////////////////////////////////////////////
;     957 // MAIN PROGRAM
;     958 ////////////////////////////////////////////////////////////////////////////////
;     959 void main(void)
;     960 {         
_main:
;     961     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x85
;     962         // Watchdog Reset
;     963         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     964         reset_serial(); 
	RCALL _reset_serial
;     965     }
;     966     else {      
	RJMP _0x86
_0x85:
;     967         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     968     }                                     
_0x86:
;     969      
;     970     PowerReset();                        
	RCALL _PowerReset
;     971     #asm("sei");     
	sei
;     972             
;     973     while (1){                     
_0x87:
;     974         if (rx_message != UNKNOWN_MSG){   
	TST  R10
	BREQ _0x8A
;     975             ProcessCommand();   
	RCALL _ProcessCommand
;     976         }
;     977         else{               
	RJMP _0x8B
_0x8A:
;     978             _doScroll();
	RCALL __doScroll_G1
;     979             _displayFrame();            
	RCALL __displayFrame_G1
;     980         }
_0x8B:
;     981         RESET_WATCHDOG();
	WDR
;     982     }
	RJMP _0x87
;     983 }
_0x8C:
	NOP
	RJMP _0x8C
;     984                          
;     985 #include "define.h"
;     986 
;     987 ///////////////////////////////////////////////////////////////
;     988 // serial interrupt handle - processing serial message ...
;     989 ///////////////////////////////////////////////////////////////
;     990 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     991 ///////////////////////////////////////////////////////////////
;     992 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     993 extern BYTE  rx_message;
;     994 extern WORD  rx_wparam;
;     995 extern WORD  rx_lparam;
;     996 
;     997 #if RX_BUFFER_SIZE<256
;     998 unsigned char rx_wr_index,rx_counter;
_rx_wr_index:
	.BYTE 0x1
_rx_counter:
	.BYTE 0x1
;     999 #else
;    1000 unsigned int rx_wr_index,rx_counter;
;    1001 #endif
;    1002 
;    1003 void send_echo_msg();
;    1004 
;    1005 // USART Receiver interrupt service routine
;    1006 #ifdef _MEGA162_INCLUDED_                    
;    1007 interrupt [USART0_RXC] void usart_rx_isr(void)
;    1008 #else
;    1009 interrupt [USART_RXC] void usart_rx_isr(void)
;    1010 #endif
;    1011 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;    1012 char status,data;
;    1013 #ifdef _MEGA162_INCLUDED_  
;    1014 status=UCSR0A;
;    1015 data=UDR0;
;    1016 #else     
;    1017 status=UCSRA;
	RCALL __SAVELOCR2
;	status -> R16
;	data -> R17
	IN   R16,11
;    1018 data=UDR;
	IN   R17,12
;    1019 #endif          
;    1020     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+2
	RJMP _0x8D
;    1021     {
;    1022         rx_buffer[rx_wr_index]=data; 
	LDS  R26,_rx_wr_index
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;    1023         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	LDS  R26,_rx_wr_index
	SUBI R26,-LOW(1)
	STS  _rx_wr_index,R26
	CPI  R26,LOW(0x8)
	BRNE _0x8E
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
;    1024         if (++rx_counter == RX_BUFFER_SIZE)
_0x8E:
	LDS  R26,_rx_counter
	SUBI R26,-LOW(1)
	STS  _rx_counter,R26
	CPI  R26,LOW(0x8)
	BREQ PC+2
	RJMP _0x8F
;    1025         {
;    1026             rx_counter=0;
	LDI  R30,LOW(0)
	STS  _rx_counter,R30
;    1027             if (
;    1028                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;    1029                 rx_buffer[2]==WAKEUP_CHAR 
;    1030                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BRNE _0x91
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BRNE _0x91
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ _0x92
_0x91:
	RJMP _0x90
_0x92:
;    1031             {
;    1032                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 10,_rx_buffer,3
;    1033                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 11,_rx_buffer,4
	CLR  R12
;    1034                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;    1035                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 13,_rx_buffer,6
	CLR  R14
;    1036                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R13
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 13,14
;    1037             }
;    1038             else if(
	RJMP _0x93
_0x90:
;    1039                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;    1040                 rx_buffer[2]==ESCAPE_CHAR 
;    1041                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0x95
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0x95
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0x96
_0x95:
	RJMP _0x94
_0x96:
;    1042             {
;    1043                 rx_wr_index=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
;    1044                 rx_counter =0;
	STS  _rx_counter,R30
;    1045             }      
;    1046         };
_0x94:
_0x93:
_0x8F:
;    1047     };
_0x8D:
;    1048 }
	RCALL __LOADLOCR2P
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;    1049 
;    1050 void send_echo_msg()
;    1051 {
_send_echo_msg:
;    1052     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;    1053     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;    1054     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;    1055     putchar(rx_message);
	ST   -Y,R10
	RCALL _putchar
;    1056     putchar(rx_wparam>>8);
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _putchar
;    1057     putchar(rx_wparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _putchar
;    1058     putchar(rx_lparam>>8);        
	MOV  R30,R14
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _putchar
;    1059     putchar(rx_lparam&0x00FF);
	__GETW1R 13,14
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _putchar
;    1060 }  
	RET
;    1061 
;    1062 void reset_serial()
;    1063 {
_reset_serial:
;    1064     rx_wr_index=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
;    1065     rx_counter =0;
	STS  _rx_counter,R30
;    1066     rx_message = UNKNOWN_MSG;
	CLR  R10
;    1067 }
	RET
;    1068 
;    1069 ///////////////////////////////////////////////////////////////
;    1070 // END serial interrupt handle
;    1071 /////////////////////////////////////////////////////////////// 
;    1072 /*****************************************************
;    1073 This program was produced by the
;    1074 CodeWizardAVR V1.24.4a Standard
;    1075 Automatic Program Generator
;    1076 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;    1077 http://www.hpinfotech.com
;    1078 e-mail:office@hpinfotech.com
;    1079 
;    1080 Project : 
;    1081 Version : 
;    1082 Date    : 19/5/2005
;    1083 Author  : 3iGROUP                
;    1084 Company : http://www.3ihut.net   
;    1085 Comments: 
;    1086 
;    1087 
;    1088 Chip type           : ATmega8515
;    1089 Program type        : Application
;    1090 Clock frequency     : 8.000000 MHz
;    1091 Memory model        : Small
;    1092 External SRAM size  : 32768
;    1093 Ext. SRAM wait state: 0
;    1094 Data Stack size     : 128
;    1095 *****************************************************/
;    1096 
;    1097 #include "define.h"                                           
;    1098 
;    1099 #define     ACK                 1
;    1100 #define     NO_ACK              0
;    1101 
;    1102 // I2C Bus functions
;    1103 #asm
;    1104    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;    1105    .equ __sda_bit=3
   .equ __sda_bit=3
;    1106    .equ __scl_bit=2
   .equ __scl_bit=2
;    1107 #endasm                   
;    1108 
;    1109 #ifdef __EEPROM_WRITE_BYTE
;    1110 BYTE eeprom_read(BYTE deviceID, PBYTE address) 
;    1111 {
_eeprom_read:
;    1112     BYTE data;
;    1113     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	*address -> Y+1
;	data -> R16
	RCALL _i2c_start
;    1114     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	RCALL _i2c_write
;    1115     i2c_write((WORD)address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;    1116     i2c_write((WORD)address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;    1117     
;    1118     i2c_start();
	RCALL _i2c_start
;    1119     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	RCALL _i2c_write
;    1120     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _i2c_read
	MOV  R16,R30
;    1121     i2c_stop();
	RCALL _i2c_stop
;    1122     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0x115
;    1123 }
;    1124 
;    1125 void eeprom_write(BYTE deviceID, PBYTE address, BYTE data) 
;    1126 {
_eeprom_write:
;    1127     i2c_start();
;	deviceID -> Y+3
;	*address -> Y+1
;	data -> Y+0
	RCALL _i2c_start
;    1128     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	RCALL _i2c_write
;    1129     i2c_write((WORD)address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;    1130     i2c_write((WORD)address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;    1131     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	RCALL _i2c_write
;    1132     i2c_stop();
	RCALL _i2c_stop
;    1133 
;    1134     /* 10ms delay to complete the write operation */
;    1135     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;    1136 }                                 
_0x115:
	ADIW R28,4
	RET
;    1137 
;    1138 WORD eeprom_read_w(BYTE deviceID, PBYTE address)
;    1139 {
_eeprom_read_w:
;    1140     WORD result = 0;
;    1141     result = eeprom_read(deviceID,address);
	RCALL __SAVELOCR2
;	deviceID -> Y+4
;	*address -> Y+2
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
;    1142     result = (result<<8) | eeprom_read(deviceID,address+1);
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
;    1143     return result;
	MOVW R30,R16
	RCALL __LOADLOCR2
	RJMP _0x114
;    1144 }
;    1145 void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data)
;    1146 {
_eeprom_write_w:
;    1147     eeprom_write(deviceID,address,data>>8);
;	deviceID -> Y+4
;	*address -> Y+2
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
;    1148     eeprom_write(deviceID,address+1,data&0x0FF);    
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
;    1149 }
_0x114:
	ADIW R28,5
	RET
;    1150 
;    1151 #endif // __EEPROM_WRITE_BYTE
;    1152 void eeprom_read_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
;    1153 {
_eeprom_read_page:
;    1154     BYTE i = 0;
;    1155     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	*address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	RCALL _i2c_start
;    1156     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	RCALL _i2c_write
;    1157     i2c_write((WORD)address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;    1158     i2c_write((WORD)address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;    1159     
;    1160     i2c_start();
	RCALL _i2c_start
;    1161     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	RCALL _i2c_write
;    1162                                     
;    1163     while ( i < page_size-1 )
_0x97:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0x99
;    1164     {
;    1165         buffer[i++] = i2c_read(ACK);   // read at current
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
;    1166     }
	RJMP _0x97
_0x99:
;    1167     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
;    1168          
;    1169     i2c_stop();
	RCALL _i2c_stop
;    1170 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;    1171 
;    1172 void eeprom_write_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
;    1173 {
_eeprom_write_page:
;    1174     BYTE i = 0;
;    1175     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	*address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	RCALL _i2c_start
;    1176     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	RCALL _i2c_write
;    1177     i2c_write((WORD)address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;    1178     i2c_write((WORD)address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;    1179                                         
;    1180     while ( i < page_size )
_0x9A:
	LDD  R30,Y+1
	CP   R16,R30
	BRSH _0x9C
;    1181     {
;    1182         i2c_write(buffer[i++]);
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
;    1183         #asm("nop");#asm("nop");
	nop
	nop
;    1184     }          
	RJMP _0x9A
_0x9C:
;    1185     i2c_stop(); 
	RCALL _i2c_stop
;    1186     delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;    1187 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;    1188                                               
;    1189 #include "define.h"
;    1190 
;    1191 #define DWORD long int
;    1192 
;    1193 const DWORD TK21[] ={
;    1194 	0x46c960, 0x2ed954, 0x54d4a0, 0x3eda50, 0x2a7552, 0x4e56a0, 0x38a7a7, 0x5ea5d0, 0x4a92b0, 0x32aab5,
;    1195 	0x58a950, 0x42b4a0, 0x2cbaa4, 0x50ad50, 0x3c55d9, 0x624ba0, 0x4ca5b0, 0x375176, 0x5c5270, 0x466930,
;    1196 	0x307934, 0x546aa0, 0x3ead50, 0x2a5b52, 0x504b60, 0x38a6e6, 0x5ea4e0, 0x48d260, 0x32ea65, 0x56d520,
;    1197 	0x40daa0, 0x2d56a3, 0x5256d0, 0x3c4afb, 0x6249d0, 0x4ca4d0, 0x37d0b6, 0x5ab250, 0x44b520, 0x2edd25,
;    1198 	0x54b5a0, 0x3e55d0, 0x2a55b2, 0x5049b0, 0x3aa577, 0x5ea4b0, 0x48aa50, 0x33b255, 0x586d20, 0x40ad60,
;    1199 	0x2d4b63, 0x525370, 0x3e49e8, 0x60c970, 0x4c54b0, 0x3768a6, 0x5ada50, 0x445aa0, 0x2fa6a4, 0x54aad0,
;    1200 	0x4052e0, 0x28d2e3, 0x4ec950, 0x38d557, 0x5ed4a0, 0x46d950, 0x325d55, 0x5856a0, 0x42a6d0, 0x2c55d4,
;    1201 	0x5252b0, 0x3ca9b8, 0x62a930, 0x4ab490, 0x34b6a6, 0x5aad50, 0x4655a0, 0x2eab64, 0x54a570, 0x4052b0,
;    1202 	0x2ab173, 0x4e6930, 0x386b37, 0x5e6aa0, 0x48ad50, 0x332ad5, 0x582b60, 0x42a570, 0x2e52e4, 0x50d160,
;    1203 	0x3ae958, 0x60d520, 0x4ada90, 0x355aa6, 0x5a56d0, 0x462ae0, 0x30a9d4, 0x54a2d0, 0x3ed150, 0x28e952
;    1204 }; /* Years 2000-2099 */
;    1205 
;    1206 //char CAN[10][10] = {"Giap", "At", "Binh", "Dinh", "Mau", "Ky", "Canh", "Tan", "Nham", "Quy"};
;    1207 //char CHI[12][10] = {"Ty'", "Suu", "Dan", "Mao", "Thin", "Ty.", "Ngo", "Mui", "Than", "Dau", "Tuat", "Hoi"};
;    1208 //char TUAN[7][10] = {"Chu Nhat", "Thu Hai", "Thu Ba", "Thu Tu", "Thu Nam", "Thu Sau", "Thu Bay"};
;    1209 
;    1210 typedef struct _LunarDate{
;    1211     BYTE day;
;    1212     BYTE month;
;    1213     WORD year;
;    1214     BYTE leap;
;    1215     DWORD jd; 
;    1216 } LUNAR_DATE;
;    1217               
;    1218 LUNAR_DATE ld;

	.DSEG
_ld:
	.BYTE 0x9
;    1219 LUNAR_DATE ly[14];
_ly:
	.BYTE 0x7E
;    1220 
;    1221 DWORD jdn(int dd, int mm, int yy) {

	.CSEG
;    1222 	int a=0, y=0, m=0;
;    1223 	a = ((14 - mm) / 12);
;	dd -> Y+10
;	mm -> Y+8
;	yy -> Y+6
;	a -> R16,R17
;	y -> R18,R19
;	m -> R20,R21
;    1224 	y = yy+4800-a;
;    1225 	m = mm+12*a-3;	
;    1226 	return (DWORD)((153*m+2)/5  + 365*y - (y/100) - 32045 + dd + (y/4)  + (y/400));
;    1227 }
;    1228 
;    1229 void decodeLunarYear(int yy, DWORD k) {	
;    1230 	int regularMonths[12];
;    1231 	int monthLengths[2]={29,30};
;    1232 	DWORD offsetOfTet=0,currentJD=0,solarNY=0;
;    1233 	int leapMonth=0,leapMonthLength=0;
;    1234 	int i=0, j=0,mm=0;
;    1235 	offsetOfTet = k >> 17;
;	yy -> Y+54
;	k -> Y+50
;	regularMonths -> Y+26
;	monthLengths -> Y+22
;	offsetOfTet -> Y+18
;	currentJD -> Y+14
;	solarNY -> Y+10
;	leapMonth -> R16,R17
;	leapMonthLength -> R18,R19
;	i -> R20,R21
;	j -> Y+8
;	mm -> Y+6
;    1236 	leapMonth = k & 0xf;
;    1237 	leapMonthLength = monthLengths[k >> 16 & 0x1];
;    1238 	solarNY = jdn(1, 1, yy);
;    1239 	currentJD = (DWORD)(solarNY+offsetOfTet);
;    1240 	j = k >> 4;
;    1241 	for(i = 0; i < 12; i++) {
;    1242 		regularMonths[12 - i - 1] = monthLengths[j & 0x1];
;    1243 		j >>= 1;
;    1244 	}
;    1245 	if (leapMonth == 0) {
;    1246 		for(mm = 1; mm <= 12; mm++) {
;    1247 			ly[mm].day = 1;
;    1248 			ly[mm].month = mm;
;    1249 			ly[mm].year = yy;
;    1250 			ly[mm].leap = 0;
;    1251 			ly[mm].jd = currentJD;
;    1252 			currentJD += regularMonths[mm-1];
;    1253 		}
;    1254 	} else {
;    1255 		for(mm = 1; mm <= leapMonth; mm++) {
;    1256 			ly[mm].day = 1;
;    1257 			ly[mm].month = mm;
;    1258 			ly[mm].year = yy;
;    1259 			ly[mm].leap = 0;
;    1260 			ly[mm].jd = currentJD;
;    1261 			currentJD += regularMonths[mm-1];
;    1262 		}		
;    1263 		ly[mm].day = 1;
;    1264 			ly[mm].month = leapMonth;
;    1265 			ly[mm].year = yy;
;    1266 			ly[mm].leap = 0;
;    1267 			ly[mm].jd = currentJD;
;    1268 		currentJD += leapMonthLength;
;    1269 		for(mm = leapMonth+2; mm <= 13; mm++) {
;    1270 			ly[mm].day = 1;
;    1271 			ly[mm].month = mm-1;
;    1272 			ly[mm].year = yy;
;    1273 			ly[mm].leap = 0;
;    1274 			ly[mm].jd = currentJD;
;    1275 			currentJD += regularMonths[mm-2];
;    1276 		}
;    1277 	}	
;    1278 }
;    1279 
;    1280 void getYearInfo(int yyyy) {
;    1281 	DWORD yearCode = 0;
;    1282 	yearCode = TK21[yyyy - 2000];
;	yyyy -> Y+4
;	yearCode -> Y+0
;    1283 	decodeLunarYear(yyyy, yearCode);
;    1284 }
;    1285 
;    1286 void getLunarDate(int dd, int mm, int yyyy) {
;    1287 	int i =13;
;    1288 	DWORD jd =0;	
;    1289 	getYearInfo(yyyy);
;	dd -> Y+10
;	mm -> Y+8
;	yyyy -> Y+6
;	i -> R16,R17
;	jd -> Y+2
;    1290 	jd = jdn(dd, mm, yyyy);
;    1291 	if (jd < ly[1].jd) {
;    1292 		getYearInfo(yyyy - 1);
;    1293 	}	
;    1294 	if (ly[13].jd==0) i=12;
;    1295 	while (jd < ly[i].jd) {
;    1296 		i--;
;    1297 	}	
;    1298 	ld.day = ly[i].day + jd - ly[i].jd;	
;    1299 	ld.month = ly[i].month;
;    1300 	ld.year = ly[i].year;
;    1301 	ld.leap = ly[i].leap;
;    1302 	ld.jd = jd;
;    1303 }
;    1304 
;    1305 void getLunarStr(char* sz, short h, short m, short dd, short mm, int yyyy){	
;    1306 	getLunarDate(dd, mm, yyyy);	
;	*sz -> Y+10
;	h -> Y+8
;	m -> Y+6
;	dd -> Y+4
;	mm -> Y+2
;	yyyy -> Y+0
;    1307 	
;    1308 	sprintf(sz,"B©y giê lµ %02d:%02d ngµy %d/%d/%d (%d/%d ¢m lÞch)",	            
;    1309                 h,m,dd,mm,yyyy,
;    1310                 ld.day,ld.month);
;    1311              
;    1312 /*	sprintf(sz,"%s %s,%s,%s",
;    1313 	    TUAN[(ld[4] + 1)%7],
;    1314 	    CAN[(ld[4] + 9)%10],CHI[(ld[4]+1)%12],
;    1315 	    CAN[(ld[2]*12+ld[1]+3)%10],CHI[(ld[1]+1)%12],
;    1316 	    CAN[(ld[2]+6)%10],CHI[(ld[2]+8)%12]);
;    1317 */	    
;    1318 }

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
__put_G5:
	LD   R26,Y
	LDD  R27,Y+1
	RCALL __GETW1P
	SBIW R30,0
	BREQ _0xB3
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0xB4
_0xB3:
	LDD  R30,Y+2
	ST   -Y,R30
	RCALL _putchar
_0xB4:
	RJMP _0x113
__print_G5:
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R16,0
_0xB5:
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
	RJMP _0xB7
	MOV  R30,R16
	CPI  R30,0
	BRNE _0xBB
	CPI  R19,37
	BRNE _0xBC
	LDI  R16,LOW(1)
	RJMP _0xBD
_0xBC:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
_0xBD:
	RJMP _0xBA
_0xBB:
	CPI  R30,LOW(0x1)
	BRNE _0xBE
	CPI  R19,37
	BRNE _0xBF
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	RJMP _0x11F
_0xBF:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0xC0
	LDI  R17,LOW(1)
	RJMP _0xBA
_0xC0:
	CPI  R19,43
	BRNE _0xC1
	LDI  R21,LOW(43)
	RJMP _0xBA
_0xC1:
	CPI  R19,32
	BRNE _0xC2
	LDI  R21,LOW(32)
	RJMP _0xBA
_0xC2:
	RJMP _0xC3
_0xBE:
	CPI  R30,LOW(0x2)
	BRNE _0xC4
_0xC3:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0xC5
	ORI  R17,LOW(128)
	RJMP _0xBA
_0xC5:
	RJMP _0xC6
_0xC4:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0xBA
_0xC6:
	CPI  R19,48
	BRLO _0xC9
	CPI  R19,58
	BRLO _0xCA
_0xC9:
	RJMP _0xC8
_0xCA:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0xBA
_0xC8:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0xCE
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
	RCALL __put_G5
	RJMP _0xCF
_0xCE:
	CPI  R30,LOW(0x73)
	BRNE _0xD1
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
	RJMP _0xD2
_0xD1:
	CPI  R30,LOW(0x70)
	BRNE _0xD4
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
_0xD2:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0xD5
_0xD4:
	CPI  R30,LOW(0x64)
	BREQ _0xD8
	CPI  R30,LOW(0x69)
	BRNE _0xD9
_0xD8:
	ORI  R17,LOW(4)
	RJMP _0xDA
_0xD9:
	CPI  R30,LOW(0x75)
	BRNE _0xDB
_0xDA:
	LDI  R30,LOW(_tbl10_G5*2)
	LDI  R31,HIGH(_tbl10_G5*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0xDC
_0xDB:
	CPI  R30,LOW(0x58)
	BRNE _0xDE
	ORI  R17,LOW(8)
	RJMP _0xDF
_0xDE:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x110
_0xDF:
	LDI  R30,LOW(_tbl16_G5*2)
	LDI  R31,HIGH(_tbl16_G5*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0xDC:
	SBRS R17,2
	RJMP _0xE1
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
	BRGE _0xE2
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0xE2:
	CPI  R21,0
	BREQ _0xE3
	SUBI R16,-LOW(1)
	RJMP _0xE4
_0xE3:
	ANDI R17,LOW(251)
_0xE4:
	RJMP _0xE5
_0xE1:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0xE5:
_0xD5:
	SBRC R17,0
	RJMP _0xE6
_0xE7:
	CP   R16,R20
	BRSH _0xE9
	SBRS R17,7
	RJMP _0xEA
	SBRS R17,2
	RJMP _0xEB
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0xEC
_0xEB:
	LDI  R19,LOW(48)
_0xEC:
	RJMP _0xED
_0xEA:
	LDI  R19,LOW(32)
_0xED:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	SUBI R20,LOW(1)
	RJMP _0xE7
_0xE9:
_0xE6:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0xEE
_0xEF:
	CPI  R18,0
	BREQ _0xF1
	SBRS R17,3
	RJMP _0xF2
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x120
_0xF2:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x120:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	CPI  R20,0
	BREQ _0xF4
	SUBI R20,LOW(1)
_0xF4:
	SUBI R18,LOW(1)
	RJMP _0xEF
_0xF1:
	RJMP _0xF5
_0xEE:
_0xF7:
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
_0xF9:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0xFB
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0xF9
_0xFB:
	CPI  R19,58
	BRLO _0xFC
	SBRS R17,3
	RJMP _0xFD
	SUBI R19,-LOW(7)
	RJMP _0xFE
_0xFD:
	SUBI R19,-LOW(39)
_0xFE:
_0xFC:
	SBRC R17,4
	RJMP _0x100
	CPI  R19,49
	BRSH _0x102
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x101
_0x102:
	RJMP _0x121
_0x101:
	CP   R20,R18
	BRLO _0x106
	SBRS R17,0
	RJMP _0x107
_0x106:
	RJMP _0x105
_0x107:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0x108
	LDI  R19,LOW(48)
_0x121:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0x109
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	CPI  R20,0
	BREQ _0x10A
	SUBI R20,LOW(1)
_0x10A:
_0x109:
_0x108:
_0x100:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	CPI  R20,0
	BREQ _0x10B
	SUBI R20,LOW(1)
_0x10B:
_0x105:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0xF8
	RJMP _0xF7
_0xF8:
_0xF5:
	SBRS R17,0
	RJMP _0x10C
_0x10D:
	CPI  R20,0
	BREQ _0x10F
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	RJMP _0x10D
_0x10F:
_0x10C:
_0x110:
_0xCF:
_0x11F:
	LDI  R16,LOW(0)
_0xBA:
	RJMP _0xB5
_0xB7:
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
	RCALL __print_G5
	RCALL __LOADLOCR2
	ADIW R28,4
	POP  R15
	RET
_rtc_init:
	LDD  R30,Y+2
	ANDI R30,LOW(0x3)
	STD  Y+2,R30
	LDD  R30,Y+1
	CPI  R30,0
	BREQ _0x111
	LDD  R30,Y+2
	ORI  R30,0x10
	STD  Y+2,R30
_0x111:
	LD   R30,Y
	CPI  R30,0
	BREQ _0x112
	LDD  R30,Y+2
	ORI  R30,0x80
	STD  Y+2,R30
_0x112:
	RCALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	RCALL _i2c_write
	LDI  R30,LOW(7)
	ST   -Y,R30
	RCALL _i2c_write
	LDD  R30,Y+2
	ST   -Y,R30
	RCALL _i2c_write
	RCALL _i2c_stop
	RJMP _0x113
_rtc_set_time:
	RCALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	RCALL _i2c_write
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _i2c_write
	LD   R30,Y
	ST   -Y,R30
	RCALL _bin2bcd
	ST   -Y,R30
	RCALL _i2c_write
	LDD  R30,Y+1
	ST   -Y,R30
	RCALL _bin2bcd
	ST   -Y,R30
	RCALL _i2c_write
	LDD  R30,Y+2
	ST   -Y,R30
	RCALL _bin2bcd
	ST   -Y,R30
	RCALL _i2c_write
	RCALL _i2c_stop
	RJMP _0x113
_rtc_set_date:
	RCALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	RCALL _i2c_write
	LDI  R30,LOW(4)
	ST   -Y,R30
	RCALL _i2c_write
	LDD  R30,Y+2
	ST   -Y,R30
	RCALL _bin2bcd
	ST   -Y,R30
	RCALL _i2c_write
	LDD  R30,Y+1
	ST   -Y,R30
	RCALL _bin2bcd
	ST   -Y,R30
	RCALL _i2c_write
	LD   R30,Y
	ST   -Y,R30
	RCALL _bin2bcd
	ST   -Y,R30
	RCALL _i2c_write
	RCALL _i2c_stop
_0x113:
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
