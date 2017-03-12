
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
;      32 
;      33 bit data_bit = 0;       
;      34 bit power_off = 0;
;      35 bit is_stopping = 0;    
;      36 bit key_pressed = 0;
;      37 
;      38 register UINT x=0;
;      39 register UINT y=0;   
;      40                                 
;      41 static int   scroll_count = 0;
_scroll_count_G1:
	.BYTE 0x2
;      42 static UINT  tick_count  = 0;       
_tick_count_G1:
	.BYTE 0x2
;      43 static UINT  stopping_count = 0;       
_stopping_count_G1:
	.BYTE 0x2
;      44 static BYTE  frame_index = 0;   
_frame_index_G1:
	.BYTE 0x1
;      45 
;      46 static UINT  text_length = 0;              
_text_length_G1:
	.BYTE 0x2
;      47 static BYTE  scroll_rate = 20;
_scroll_rate_G1:
	.BYTE 0x1
;      48 static BYTE  scroll_type = LEFT_RIGHT;            
_scroll_type_G1:
	.BYTE 0x1
;      49              
;      50 // Global variables for message control
;      51 BYTE  rx_message = UNKNOWN_MSG;
;      52 WORD  rx_wparam  = 0;
;      53 WORD  rx_lparam  = 0;
;      54 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;      55                             
;      56 extern void reset_serial();         
;      57 extern void send_echo_msg();    
;      58 extern BYTE eeprom_read(BYTE deviceID, WORD address);
;      59 extern void eeprom_write(BYTE deviceID, WORD address, BYTE data);
;      60 extern WORD eeprom_read_w(BYTE deviceID, WORD address);
;      61 extern void eeprom_write_w(BYTE deviceID, WORD address, WORD data);
;      62 extern void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      63 extern void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      64 
;      65 static void _displayFrame();
;      66 static void _doScroll();   
;      67 void LoadFrame(BYTE index);
;      68 void BlankRAM(PBYTE start_addr,PBYTE end_addr);
;      69 
;      70 ///////////////////////////////////////////////////////////////
;      71 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;      72 ///////////////////////////////////////////////////////////////
;      73 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;      74 {       

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;      75     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;      76     ++tick_count;    
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	ADIW R30,1
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R31
;      77 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;      78 
;      79 ///////////////////////////////////////////////////////////////
;      80 // static function(s) for led matrix display panel
;      81 ///////////////////////////////////////////////////////////////
;      82 
;      83 static void _putData()
;      84 {                                                
__putData_G1:
;      85     for (y=0; y< SCREEN_HEIGHT; y++){             
	CLR  R6
	CLR  R7
_0x5:
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	CP   R6,R30
	CPC  R7,R31
	BRLO PC+2
	RJMP _0x6
;      86         data_bit = (start_mem[(y)/8 + 4*(x)]>>(y%8)) & 0x01; 					
	MOVW R30,R6
	RCALL __LSRW3
	MOVW R26,R30
	MOVW R30,R4
	RCALL __LSLW2
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
	RCALL __ASRW12
	BST  R30,0
	BLD  R2,0
;      87         if (power_off) data_bit =OFF_LED;
	SBRS R2,1
	RJMP _0x7
	SET
	BLD  R2,0
;      88                
;      89         if (scroll_type == BOTTOM_TOP){
_0x7:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x3)
	BRNE _0x8
;      90             if (SCREEN_HEIGHT -y > (SCREEN_HEIGHT<<1) -scroll_count)
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
	BRSH _0x9
;      91                 CTRL_OUT = OFF_LED;
	SBI  0x18,3
;      92             else                   
	RJMP _0xA
_0x9:
;      93                 CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;      94         }   
_0xA:
;      95         else if (scroll_type == TOP_BOTTOM){
	RJMP _0xB
_0x8:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x2)
	BRNE _0xC
;      96             if (y >= scroll_count -SCREEN_HEIGHT){
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,16
	CP   R6,R30
	CPC  R7,R31
	BRLO _0xD
;      97                 if (scroll_count >= SCREEN_HEIGHT)
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRLT _0xE
;      98                     CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;      99                 else                   
	RJMP _0xF
_0xE:
;     100                     CTRL_OUT = OFF_LED;
	SBI  0x18,3
;     101             }
_0xF:
;     102             else{                      
	RJMP _0x10
_0xD:
;     103                 if (scroll_count >= SCREEN_HEIGHT)
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRLT _0x11
;     104                     CTRL_OUT = OFF_LED;
	SBI  0x18,3
;     105                 else                   
	RJMP _0x12
_0x11:
;     106                     CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;     107             }
_0x12:
_0x10:
;     108         }
;     109         else{                   
	RJMP _0x13
_0xC:
;     110             CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;     111         }                                 
_0x13:
_0xB:
;     112         __CTRL_CLK();	    		
	__DELAY_USB 5
	SBI  0x18,2
	__DELAY_USB 5
	CBI  0x18,2
;     113     }                           
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	RJMP _0x5
_0x6:
;     114     if (scroll_type==TOP_BOTTOM || scroll_type == BOTTOM_TOP){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x2)
	BREQ _0x15
	CPI  R26,LOW(0x3)
	BRNE _0x14
_0x15:
;     115         if (SCREEN_HEIGHT >= scroll_count){      
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,17
	BRGE _0x17
;     116             int i =0;               
;     117             CTRL_OUT = OFF_LED; // turn off the LED
	SBIW R28,2
	LDI  R24,2
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x18*2)
	LDI  R31,HIGH(_0x18*2)
	RCALL __INITLOCB
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
	BRGE _0x1B
;     119                 __CTRL_CLK();                           
	__DELAY_USB 5
	SBI  0x18,2
	__DELAY_USB 5
	CBI  0x18,2
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
;     122 	__CTRL_STB();
_0x14:
	__DELAY_USB 5
	SBI  0x18,4
	__DELAY_USB 5
	CBI  0x18,4
;     123 }
	RET
;     124 
;     125 static void _displayFrame()
;     126 {                                  
__displayFrame_G1:
;     127 	for (x=0; x< SCREEN_WIDTH; x++){
	CLR  R4
	CLR  R5
_0x1D:
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	CP   R4,R30
	CPC  R5,R31
	BRSH _0x1E
;     128 		_putData();
	RCALL __putData_G1
;     129 		__DATA_CLK();					
	SBI  0x18,0
	CBI  0x18,0
;     130 	}           
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x1D
_0x1E:
;     131     __DATA_STB();             	
	SBI  0x18,1
	CBI  0x18,1
;     132 }     
	RET
;     133                                                                                   
;     134 static void _doScroll()
;     135 {
__doScroll_G1:
;     136 #ifdef KEY_PRESS                               
;     137   if (key_pressed==1){
	SBRS R2,3
	RJMP _0x1F
;     138     is_stopping =1;
	SET
	BLD  R2,2
;     139     return;
	RET
;     140   }             
;     141 #endif //KEY_PRESS  
;     142   if (tick_count > scroll_rate){    
_0x1F:
	LDS  R30,_scroll_rate_G1
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRLO PC+2
	RJMP _0x20
;     143     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     144     {
;     145     case LEFT_RIGHT:                
	CPI  R30,0
	BREQ PC+2
	RJMP _0x24
;     146         if (is_stopping==0){   
	SBRC R2,2
	RJMP _0x25
;     147             if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x26
;     148        	        start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	RJMP _0x103
;     149        	    else 
_0x26:
;     150        	        start_mem += 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
_0x103:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     151    	    }
;     152    	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
_0x25:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0x900)
	LDI  R30,HIGH(0x900)
	CPC  R27,R30
	BRNE _0x28
;     153    	        is_stopping = 1;
	SET
	BLD  R2,2
;     154    	    if (is_stopping ==1)
_0x28:
	SBRS R2,2
	RJMP _0x29
;     155    	    {
;     156    	        if (stopping_count++>MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x2A
;     157    	        {
;     158    	            is_stopping=0;
	CLT
	BLD  R2,2
;     159    	            stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     160    	        }
;     161    	    }                                  
_0x2A:
;     162        	if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
_0x29:
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-160)
	SBCI R31,HIGH(-160)
	RCALL __LSLW2
	SUBI R30,LOW(-1792)
	SBCI R31,HIGH(-1792)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x2B
;     163    	    {                  
;     164    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     165        	}           
;     166    	    break;
_0x2B:
	RJMP _0x23
;     167     case RIGHT_LEFT:
_0x24:
	CPI  R30,LOW(0x1)
	BREQ PC+2
	RJMP _0x2C
;     168        	if (is_stopping==0){
	SBRC R2,2
	RJMP _0x2D
;     169    	        if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x2E
;     170    	            start_mem -= 4;      
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SBIW R30,4
	RJMP _0x104
;     171    	        else
_0x2E:
;     172    	            start_mem -= 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SBIW R30,8
_0x104:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     173    	        
;     174    	    }
;     175    	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
_0x2D:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0x900)
	LDI  R30,HIGH(0x900)
	CPC  R27,R30
	BRNE _0x30
;     176    	        is_stopping = 1;
	SET
	BLD  R2,2
;     177    	    if (is_stopping ==1)
_0x30:
	SBRS R2,2
	RJMP _0x31
;     178    	    {
;     179    	        if (stopping_count++ >MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x32
;     180    	        {
;     181    	            is_stopping=0;
	CLT
	BLD  R2,2
;     182    	            stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     183    	        }
;     184    	    }
_0x32:
;     185    	    else if (start_mem < START_RAM_TEXT)             
	RJMP _0x33
_0x31:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0x700)
	LDI  R30,HIGH(0x700)
	CPC  R27,R30
	BRSH _0x34
;     186        	{
;     187        	    scroll_count = 0;             
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     188    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     189        	}
;     190        	break;
_0x34:
_0x33:
	RJMP _0x23
;     191     case BOTTOM_TOP:               
_0x2C:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x35
;     192         if (scroll_count >=0){        
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,0
	BRLT _0x36
;     193             scroll_count--;   
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     194         }
;     195         else{                      
	RJMP _0x37
_0x36:
;     196             stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     197             scroll_count = SCREEN_HEIGHT<<1;
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     198             start_mem += 4*SCREEN_WIDTH;                                  
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-512)
	SBCI R31,HIGH(-512)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     199             if (start_mem >= (START_RAM_TEXT +4*(text_length+SCREEN_WIDTH))){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-128)
	SBCI R31,HIGH(-128)
	RCALL __LSLW2
	SUBI R30,LOW(-1792)
	SBCI R31,HIGH(-1792)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x38
;     200                 LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     201             }  
;     202         }
_0x38:
_0x37:
;     203         if (is_stopping==1)
	SBRS R2,2
	RJMP _0x39
;     204         {               
;     205             if (stopping_count++ > MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x3A
;     206             {
;     207                 is_stopping = 0;
	CLT
	BLD  R2,2
;     208                 stopping_count = 0; 
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     209             }
;     210             else{
	RJMP _0x3B
_0x3A:
;     211                 scroll_count++;
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	ADIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     212             }
_0x3B:
;     213         }   
;     214         if (scroll_count == SCREEN_HEIGHT){
_0x39:
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRNE _0x3C
;     215             is_stopping = 1;
	SET
	BLD  R2,2
;     216         }
;     217         
;     218         break;
_0x3C:
	RJMP _0x23
;     219     case TOP_BOTTOM:
_0x35:
	CPI  R30,LOW(0x2)
	BREQ PC+2
	RJMP _0x3D
;     220         if (scroll_count == SCREEN_HEIGHT){
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRNE _0x3E
;     221             is_stopping = 1;
	SET
	BLD  R2,2
;     222         }                   
;     223         if (scroll_count <= (SCREEN_HEIGHT<<1)){ 
_0x3E:
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,33
	BRGE _0x3F
;     224             scroll_count++;                
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	ADIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     225         }
;     226         else {            
	RJMP _0x40
_0x3F:
;     227             scroll_count = 0;  
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     228             stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     229             start_mem += 4*SCREEN_WIDTH;                                  
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-512)
	SBCI R31,HIGH(-512)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     230             if (start_mem >= (START_RAM_TEXT +4*(text_length+SCREEN_WIDTH))){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-128)
	SBCI R31,HIGH(-128)
	RCALL __LSLW2
	SUBI R30,LOW(-1792)
	SBCI R31,HIGH(-1792)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x41
;     231                 LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     232             }                              
;     233         }  
_0x41:
_0x40:
;     234         if (is_stopping==1)
	SBRS R2,2
	RJMP _0x42
;     235         {               
;     236             if (stopping_count++ > MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x43
;     237             {
;     238                 is_stopping = 0;
	CLT
	BLD  R2,2
;     239                 stopping_count = 0;      
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     240             }
;     241             else{
	RJMP _0x44
_0x43:
;     242                 scroll_count--;
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     243             }
_0x44:
;     244         }   
;     245         break;  
_0x42:
	RJMP _0x23
;     246     case SCROLLING:   
_0x3D:
	CPI  R30,LOW(0x4)
	BRNE _0x45
;     247         if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x46
;     248    	        start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	RJMP _0x105
;     249    	    else 
_0x46:
;     250    	        start_mem += 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
_0x105:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     251         if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-160)
	SBCI R31,HIGH(-160)
	RCALL __LSLW2
	SUBI R30,LOW(-1792)
	SBCI R31,HIGH(-1792)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x48
;     252    	    {            
;     253    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     254        	}       	  
;     255         break;  
_0x48:
	RJMP _0x23
;     256     case NOT_USE:
_0x45:
	CPI  R30,LOW(0x5)
	BRNE _0x4A
;     257         LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     258         break;  
;     259     default:
_0x4A:
;     260         break;
;     261     }
_0x23:
;     262 	tick_count = 0;
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     263 	if (frame_index >= MAX_FRAME) frame_index=0;
	LDS  R26,_frame_index_G1
	CPI  R26,LOW(0x4)
	BRLO _0x4B
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     264     		
;     265   }
_0x4B:
;     266              
;     267 }          
_0x20:
	RET
;     268 ////////////////////////////////////////////////////////////////////
;     269 // General functions
;     270 //////////////////////////////////////////////////////////////////// 
;     271 #define RESET_WATCHDOG()    #asm("WDR");
;     272                                                                             
;     273 void LoadConfig(BYTE index)
;     274 {
_LoadConfig:
;     275     BYTE devID = EEPROM_DEVICE_BASE;    
;     276     WORD base = 0;   // base address
;     277     devID += index<<1;                 
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
;     278     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x4C
;     279         base = 0x8000;    
	__GETWRN 17,18,32768
;     280     }                 
;     281     devID &= 0xF7;      // clear bit A3 
_0x4C:
	ANDI R16,LOW(247)
;     282     
;     283     // init I2C bus
;     284     i2c_init();
	RCALL _i2c_init
;     285     LED_STATUS = 1;
	SBI  0x18,4
;     286     scroll_rate = eeprom_read(devID, (WORD)base+0);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     287     scroll_type = eeprom_read(devID, (WORD)base+1);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read
	STS  _scroll_type_G1,R30
;     288     text_length = eeprom_read_w(devID, (WORD)base+2); 
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read_w
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     289     printf("line=%d rate=%d type=%d len=%d\r\n",index,scroll_rate,scroll_type,text_length);
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
;     290     if (text_length > DATA_LENGTH){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0xEE1)
	LDI  R30,HIGH(0xEE1)
	CPC  R27,R30
	BRLO _0x4D
;     291         text_length= 0;            
	LDI  R30,0
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R30
;     292     }
;     293     if (scroll_type > NOT_USE){
_0x4D:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x6)
	BRLO _0x4E
;     294         scroll_type = NOT_USE;
	LDI  R30,LOW(5)
	STS  _scroll_type_G1,R30
;     295     }          
;     296     if (scroll_rate > MAX_RATE){
_0x4E:
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x65)
	BRLO _0x4F
;     297         scroll_rate = 0;
	LDI  R30,LOW(0)
	STS  _scroll_rate_G1,R30
;     298     }
;     299     LED_STATUS = 0;   
_0x4F:
	CBI  0x18,4
;     300 }
	RJMP _0x102
;     301                        
;     302 void SaveTextLength(BYTE index)
;     303 {
_SaveTextLength:
;     304     BYTE devID = EEPROM_DEVICE_BASE;    
;     305     WORD base = 0;   // base address
;     306     devID += index<<1;                 
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
;     307     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x50
;     308         base = 0x8000;    
	__GETWRN 17,18,32768
;     309     }                 
;     310     devID &= 0xF7;      // clear bit A3 
_0x50:
	ANDI R16,LOW(247)
;     311     
;     312     i2c_init();
	RCALL _i2c_init
;     313     LED_STATUS = 1;   
	SBI  0x18,4
;     314     eeprom_write_w(devID, base+2,text_length); 
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
;     315     LED_STATUS = 0;   
	CBI  0x18,4
;     316 }
_0x102:
	RCALL __LOADLOCR3
	ADIW R28,4
	RET
;     317 
;     318 void SaveConfig(BYTE rate,BYTE type, BYTE index)
;     319 {                     
_SaveConfig:
;     320     BYTE devID = EEPROM_DEVICE_BASE;    
;     321     WORD base = 0;   // base address
;     322     devID += index<<1;                 
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
;     323     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x51
;     324         base = 0x8000;    
	__GETWRN 17,18,32768
;     325     }                 
;     326     devID &= 0xF7;      // clear bit A3  
_0x51:
	ANDI R16,LOW(247)
;     327     i2c_init();
	RCALL _i2c_init
;     328     LED_STATUS = 1;  
	SBI  0x18,4
;     329     eeprom_write(devID, base+0,rate);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	RCALL _eeprom_write
;     330     eeprom_write(devID, base+1,type);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	ST   -Y,R30
	RCALL _eeprom_write
;     331     LED_STATUS = 0;       
	CBI  0x18,4
;     332 }
	RCALL __LOADLOCR3
	ADIW R28,6
	RET
;     333 
;     334 void SaveToEEPROM(PBYTE address,WORD length,BYTE index)
;     335 {                             
_SaveToEEPROM:
;     336     PBYTE temp = 0;     
;     337     BYTE devID = EEPROM_DEVICE_BASE;
;     338     WORD base = 0;   // base address
;     339     devID += index<<1;                 
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
;     340     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x52
;     341         base = 0x8000;    
	__GETWRN 19,20,32768
;     342     }         				
;     343     temp = address;         
_0x52:
	__GETWRS 16,17,8
;     344         
;     345     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xEE1)
	LDI  R30,HIGH(0xEE1)
	CPC  R27,R30
	BRLO _0x53
;     346         return; // invalid param 
	RCALL __LOADLOCR5
	ADIW R28,10
	RET
;     347     length = (WORD)address+4*(SCREEN_WIDTH+length);         
_0x53:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-128)
	SBCI R31,HIGH(-128)
	RCALL __LSLW2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     348     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x54
;     349         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     350     // init I2C bus
;     351     i2c_init();
_0x54:
	RCALL _i2c_init
;     352     LED_STATUS = 1;        
	SBI  0x18,4
;     353     
;     354     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x56:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x57
;     355     {   
;     356         RESET_WATCHDOG();                          	                                              
	WDR
;     357         eeprom_write_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE);	      
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
;     358     }       
	__ADDWRN 16,17,64
	RJMP _0x56
_0x57:
;     359         
;     360     LED_STATUS = 0;   
	CBI  0x18,4
;     361 }
	RJMP _0x101
;     362                       
;     363 void LoadToRAM(PBYTE address,WORD length,BYTE index)
;     364 {                         
_LoadToRAM:
;     365     PBYTE temp = 0;          
;     366     BYTE devID = EEPROM_DEVICE_BASE;
;     367     WORD base = 0;   // base address
;     368     devID += index<<1;                 
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
;     369     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x58
;     370         base = 0x8000;    
	__GETWRN 19,20,32768
;     371     }       				
;     372     temp = address;                 
_0x58:
	__GETWRS 16,17,8
;     373 
;     374     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xEE1)
	LDI  R30,HIGH(0xEE1)
	CPC  R27,R30
	BRLO _0x59
;     375         return; // invalid param
_0x101:
	RCALL __LOADLOCR5
	ADIW R28,10
	RET
;     376     length = (WORD)address+4*(SCREEN_WIDTH+length);         
_0x59:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-128)
	SBCI R31,HIGH(-128)
	RCALL __LSLW2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     377     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x5A
;     378         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     379     // init I2C bus
;     380     i2c_init();
_0x5A:
	RCALL _i2c_init
;     381     LED_STATUS = 1;             
	SBI  0x18,4
;     382  
;     383     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x5C:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x5D
;     384     {
;     385         eeprom_read_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE );	                                   
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
;     386         RESET_WATCHDOG();     
	WDR
;     387     }             
	__ADDWRN 16,17,64
	RJMP _0x5C
_0x5D:
;     388 
;     389     LED_STATUS = 0;   
	CBI  0x18,4
;     390 }
	RCALL __LOADLOCR5
	ADIW R28,10
	RET
;     391 
;     392 void LoadFrame(BYTE index)
;     393 {                 
_LoadFrame:
;     394     if (index >= MAX_FRAME) index=0;  
;	index -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x4)
	BRLO _0x5E
	LDI  R30,LOW(0)
	ST   Y,R30
;     395 
;     396     LoadConfig(index);  
_0x5E:
	LD   R30,Y
	ST   -Y,R30
	RCALL _LoadConfig
;     397     if (scroll_type==NOT_USE){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x5)
	BRNE _0x5F
;     398         return;           
	RJMP _0x100
;     399     }                   
;     400     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
_0x5F:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     401     LoadToRAM((PBYTE)START_RAM_TEXT,text_length,index);
	LDI  R30,LOW(1792)
	LDI  R31,HIGH(1792)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	ST   -Y,R30
	RCALL _LoadToRAM
;     402     stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     403     scroll_count = 0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     404     is_stopping = 0;
	CLT
	BLD  R2,2
;     405     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     406     {
;     407     case LEFT_RIGHT:
	CPI  R30,0
	BRNE _0x63
;     408         start_mem = (PBYTE)START_RAM_TEXT; 
	LDI  R30,LOW(1792)
	LDI  R31,HIGH(1792)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     409         break;                
	RJMP _0x62
;     410     case RIGHT_LEFT:
_0x63:
	CPI  R30,LOW(0x1)
	BRNE _0x64
;     411         start_mem = (PBYTE)START_RAM_TEXT + (text_length<<2); 
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	RCALL __LSLW2
	SUBI R30,LOW(-1792)
	SBCI R31,HIGH(-1792)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     412         break;
	RJMP _0x62
;     413     case BOTTOM_TOP:                             
_0x64:
	CPI  R30,LOW(0x3)
	BRNE _0x65
;     414         scroll_count = SCREEN_HEIGHT<<1;
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     415         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(2304)
	LDI  R31,HIGH(2304)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     416         break;
	RJMP _0x62
;     417     case TOP_BOTTOM:   
_0x65:
	CPI  R30,LOW(0x2)
	BRNE _0x66
;     418         scroll_count = 0;                     
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     419         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(2304)
	LDI  R31,HIGH(2304)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     420         break;  
	RJMP _0x62
;     421     case SCROLLING:
_0x66:
	CPI  R30,LOW(0x4)
	BRNE _0x68
;     422         start_mem = (PBYTE)START_RAM_TEXT;
	LDI  R30,LOW(1792)
	LDI  R31,HIGH(1792)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     423         break;
;     424     default: 
_0x68:
;     425         break;
;     426     }                   
_0x62:
;     427 #ifdef KEY_PRESS    
;     428     if (key_pressed==1){                  
	SBRS R2,3
	RJMP _0x69
;     429         scroll_count = SCREEN_HEIGHT;
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     430         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2);
	LDI  R30,LOW(2304)
	LDI  R31,HIGH(2304)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     431     }           
;     432 #endif //KEY_PRESS    
;     433 }
_0x69:
_0x100:
	ADIW R28,1
	RET
;     434 
;     435 void SerialToRAM(PBYTE address,WORD length)                                             
;     436 {
_SerialToRAM:
;     437     PBYTE temp = 0;          
;     438     UINT i =0;     				
;     439     temp   = address;    
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
;     440     LED_STATUS = 1;
	SBI  0x18,4
;     441     for (i =0; i< (length<<2); i++)         
	__GETWRN 18,19,0
_0x6B:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	RCALL __LSLW2
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x6C
;     442     {                          
;     443         BYTE data = 0;
;     444         data = ~getchar();
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x6D*2)
	LDI  R31,HIGH(_0x6D*2)
	RCALL __INITLOCB
;	*address -> Y+7
;	length -> Y+5
;	data -> Y+0
	RCALL _getchar
	COM  R30
	ST   Y,R30
;     445         *temp = data;
	MOVW R26,R16
	ST   X,R30
;     446         temp++;
	__ADDWRN 16,17,1
;     447         RESET_WATCHDOG();                                     
	WDR
;     448     }              
	ADIW R28,1
	__ADDWRN 18,19,1
	RJMP _0x6B
_0x6C:
;     449     LED_STATUS = 0;
	CBI  0x18,4
;     450 }
	RCALL __LOADLOCR4
	ADIW R28,8
	RET
;     451                       
;     452 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     453 {        
_BlankRAM:
;     454     PBYTE temp = START_RAM;
;     455     for (temp = start_addr; temp<= end_addr; temp++)    
	RCALL __SAVELOCR2
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*temp -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x6F:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x70
;     456         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     457 }
	__ADDWRN 16,17,1
	RJMP _0x6F
_0x70:
	RCALL __LOADLOCR2
	ADIW R28,6
	RET
;     458 
;     459 
;     460 ///////////////////////////////////////////////////////////////
;     461 // END static function(s)
;     462 ///////////////////////////////////////////////////////////////
;     463 
;     464 ///////////////////////////////////////////////////////////////           
;     465 
;     466 void InitDevice()
;     467 {
_InitDevice:
;     468 // Declare your local variables here
;     469 // Crystal Oscillator division factor: 1  
;     470 #ifdef _MEGA162_INCLUDED_ 
;     471 #pragma optsize-
;     472 CLKPR=0x80;
;     473 CLKPR=0x00;
;     474 #ifdef _OPTIMIZE_SIZE_
;     475 #pragma optsize+
;     476 #endif                    
;     477 #endif
;     478 
;     479 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;     480 DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;     481 
;     482 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
;     483 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     484 
;     485 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     486 DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
;     487 
;     488 PORTD=0xFF;
	OUT  0x12,R30
;     489 DDRD=0x00; 
	LDI  R30,LOW(0)
	OUT  0x11,R30
;     490 
;     491 PORTE=0x00;
	OUT  0x7,R30
;     492 DDRE=0xFF;
	LDI  R30,LOW(255)
	OUT  0x6,R30
;     493 
;     494 // Timer/Counter 0 initialization
;     495 // Clock source: System Clock
;     496 // Clock value: 250.000 kHz
;     497 // Mode: Normal top=FFh
;     498 // OC0 output: Disconnected
;     499 TCCR0=0x03;     // 4 us per tick
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     500 TCNT0=0x05;     // 1ms = 4*250
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     501 OCR0=0x00;      // 255 -250 = TCNT0
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     502 
;     503 #ifdef _MEGA162_INCLUDED_
;     504 UCSR0A=0x00;
;     505 UCSR0B=0x98;
;     506 UCSR0C=0x86;
;     507 UBRR0H=0x00;
;     508 UBRR0L=0x67;      //  16 MHz     
;     509 
;     510 #else // _MEGA8515_INCLUDE_     
;     511 UCSRA=0x00;
	OUT  0xB,R30
;     512 UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     513 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     514 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     515 UBRRL=0x67;       // 16 MHz
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     516 #endif
;     517 
;     518 // Lower page wait state(s): None
;     519 // Upper page wait state(s): None
;     520 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     521 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     522 
;     523 // Timer(s)/Counter(s) Interrupt(s) initialization
;     524 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     525 #ifdef _MEGA162_INCLUDED_
;     526 ETIMSK=0x00;
;     527 #endif
;     528 
;     529 // Load calibration byte for osc.  
;     530 #ifdef _MEGA162_INCLUDED_
;     531 OSCCAL = 0x5E; 
;     532 #else
;     533 OSCCAL = 0xA7; 
	LDI  R30,LOW(167)
	OUT  0x4,R30
;     534 #endif            
;     535 
;     536 // I2C Bus initialization
;     537 // i2c_init();
;     538 
;     539 // DS1307 Real Time Clock initialization
;     540 // Square wave output on pin SQW/OUT: Off
;     541 // SQW/OUT pin state: 1
;     542 // rtc_init(3,0,1);
;     543 
;     544 //i2c_init(); // must be call before
;     545 //rtc_init(3,0,1); // init RTC DS1307  
;     546 //rtc_set_time(15,2,0);
;     547 //rtc_set_date(9,5,6);    
;     548                 
;     549 // Watchdog Timer initialization
;     550 // Watchdog Timer Prescaler: OSC/2048k     
;     551 #ifdef __WATCH_DOG_
;     552 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     553 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     554 #endif
;     555 }
	RET
;     556 
;     557 void PowerReset()
;     558 {      
_PowerReset:
;     559     start_mem = (PBYTE)START_RAM_TEXT;                    
	LDI  R30,LOW(1792)
	LDI  R31,HIGH(1792)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     560 
;     561     InitDevice();
	RCALL _InitDevice
;     562        
;     563     LED_STATUS = 0;
	CBI  0x18,4
;     564     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);  
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     565     
;     566     LED_STATUS = 0;  
	CBI  0x18,4
;     567     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     568     LED_STATUS = 1;
	SBI  0x18,4
;     569     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     570     LED_STATUS = 0;
	CBI  0x18,4
;     571     delay_ms(500);    
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     572     LED_STATUS = 1;
	SBI  0x18,4
;     573                 
;     574     frame_index= 0;
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     575     LoadFrame(frame_index);
	ST   -Y,R30
	RCALL _LoadFrame
;     576         
;     577 #ifdef _INIT_EEPROM_ 
;     578 {
;     579     BYTE i =0;
;     580     for (i =0; i< MAX_FRAME; i++){   
;     581         SaveConfig(10,0,i);
;     582         text_length = 160;
;     583         SaveTextLength(i);            
;     584     }
;     585 }
;     586 #endif  
;     587     printf("LCMS v3.02 Designed by CuongQuay\r\n");  
	__POINTW1FN _0,33
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     588     printf("cuong3ihut@yahoo.com - 0915651001\r\n");
	__POINTW1FN _0,68
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     589     printf("Release date: 22.11.2006\r\n");
	__POINTW1FN _0,104
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     590 }
	RET
;     591 
;     592 void ProcessCommand()
;     593 {
_ProcessCommand:
;     594    	#asm("cli"); 
	cli
;     595     RESET_WATCHDOG();
	WDR
;     596 
;     597     // serial message processing     
;     598     switch (rx_message)
	MOV  R30,R8
;     599     {                  
;     600     case LOAD_TEXT_MSG:
	CPI  R30,LOW(0x2)
	BRNE _0x74
;     601         {                
;     602             text_length = rx_wparam;            
	__PUTWMRN _text_length_G1,0,9,10
;     603             frame_index = rx_lparam&0x0F;   
	__GETW1R 11,12
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	STS  _frame_index_G1,R30
;     604             BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     605             SerialToRAM((PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH),text_length);                
	LDI  R30,LOW(2304)
	LDI  R31,HIGH(2304)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _SerialToRAM
;     606 			start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);				
	LDI  R30,LOW(2304)
	LDI  R31,HIGH(2304)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     607 			SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
	LDI  R30,LOW(1792)
	LDI  R31,HIGH(1792)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	RCALL _SaveToEEPROM
;     608 			SaveTextLength(rx_lparam);							  
	ST   -Y,R11
	RCALL _SaveTextLength
;     609         }				
;     610         break;           
	RJMP _0x73
;     611     case LOAD_BKGND_MSG:
_0x74:
	CPI  R30,LOW(0x3)
	BREQ _0x73
;     612         {
;     613         }
;     614         break;   
;     615     case SET_CFG_MSG: 
	CPI  R30,LOW(0xD)
	BRNE _0x76
;     616         {               
;     617             SaveConfig(rx_wparam&0x0FF,rx_wparam>>8,rx_lparam); 
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	ST   -Y,R11
	RCALL _SaveConfig
;     618         }
;     619         break;    
	RJMP _0x73
;     620     case EEPROM_SAVE_TEXT_MSG:     
_0x76:
	CPI  R30,LOW(0x7)
	BREQ _0x78
;     621     case EEPROM_SAVE_ALL_MSG:  
	CPI  R30,LOW(0xB)
	BRNE _0x79
_0x78:
;     622         {                                                          
;     623             SaveTextLength(rx_lparam);              
	ST   -Y,R11
	RCALL _SaveTextLength
;     624             SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
	LDI  R30,LOW(1792)
	LDI  R31,HIGH(1792)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	RCALL _SaveToEEPROM
;     625         }
;     626         break;         
	RJMP _0x73
;     627     case EEPROM_LOAD_TEXT_MSG:    
_0x79:
	CPI  R30,LOW(0x6)
	BREQ _0x7B
;     628     case EEPROM_LOAD_ALL_MSG:
	CPI  R30,LOW(0xA)
	BRNE _0x7C
_0x7B:
;     629         {
;     630             LoadConfig(rx_lparam);                               
	ST   -Y,R11
	RCALL _LoadConfig
;     631             LoadToRAM((PBYTE)START_RAM_TEXT,text_length,rx_lparam); 
	LDI  R30,LOW(1792)
	LDI  R31,HIGH(1792)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	RCALL _LoadToRAM
;     632             start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);
	LDI  R30,LOW(2304)
	LDI  R31,HIGH(2304)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     633         }
;     634         break;  
	RJMP _0x73
;     635     case POWER_CTRL_MSG:
_0x7C:
	CPI  R30,LOW(0x10)
	BRNE _0x7E
;     636         power_off = rx_wparam&0x01;
	BST  R9,0
	BLD  R2,1
;     637         break;     
;     638     default:
_0x7E:
;     639         break;
;     640     }                 
_0x73:
;     641     send_echo_msg();            
	RCALL _send_echo_msg
;     642     rx_message = UNKNOWN_MSG;
	CLR  R8
;     643     #asm("sei");        
	sei
;     644 }           
	RET
;     645 ////////////////////////////////////////////////////////////////////////////////
;     646 // MAIN PROGRAM
;     647 ////////////////////////////////////////////////////////////////////////////////
;     648 void main(void)
;     649 {         
_main:
;     650     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x7F
;     651         // Watchdog Reset
;     652         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     653         reset_serial(); 
	RCALL _reset_serial
;     654     }
;     655     else {      
	RJMP _0x80
_0x7F:
;     656         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     657     }                                     
_0x80:
;     658      
;     659     PowerReset();                        
	RCALL _PowerReset
;     660     #asm("sei");     
	sei
;     661 
;     662     while (1){         
_0x81:
;     663 #ifdef KEY_PRESS       
;     664         if (KEY_PRESS==0){
	SBIC 0x10,5
	RJMP _0x84
;     665             if (key_pressed==0){
	SBRC R2,3
	RJMP _0x85
;     666                 delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     667                 if (KEY_PRESS==0){                           
	SBIC 0x10,5
	RJMP _0x86
;     668                     printf("KEY PRESSED\r\n");                
	__POINTW1FN _0,131
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     669                     key_pressed =1; 
	SET
	BLD  R2,3
;     670                     LoadFrame(0);                             
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _LoadFrame
;     671                 }                                                       
;     672             }
_0x86:
;     673         }
_0x85:
;     674         else{   
	RJMP _0x87
_0x84:
;     675             if (key_pressed==1){                   
	SBRS R2,3
	RJMP _0x88
;     676                 delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     677                 if (KEY_PRESS==1){                
	SBIS 0x10,5
	RJMP _0x89
;     678                     key_pressed =0; 
	CLT
	BLD  R2,3
;     679                     LoadFrame(frame_index);       
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _LoadFrame
;     680                 }
;     681             }     
_0x89:
;     682         }       
_0x88:
_0x87:
;     683 #endif //KEY_PRESS                   
;     684         if (rx_message != UNKNOWN_MSG){   
	TST  R8
	BREQ _0x8A
;     685             ProcessCommand();   
	RCALL _ProcessCommand
;     686         }
;     687         else{           
	RJMP _0x8B
_0x8A:
;     688             if (!is_stopping){
	SBRS R2,2
;     689                 _displayFrame();
	RCALL __displayFrame_G1
;     690             }
;     691             _doScroll();            
	RCALL __doScroll_G1
;     692         }
_0x8B:
;     693         RESET_WATCHDOG();
	WDR
;     694     };
	RJMP _0x81
;     695 
;     696 }
_0x8D:
	NOP
	RJMP _0x8D
;     697                          
;     698 #include "define.h"
;     699 
;     700 ///////////////////////////////////////////////////////////////
;     701 // serial interrupt handle - processing serial message ...
;     702 ///////////////////////////////////////////////////////////////
;     703 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     704 ///////////////////////////////////////////////////////////////
;     705 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     706 extern BYTE  rx_message;
;     707 extern WORD  rx_wparam;
;     708 extern WORD  rx_lparam;
;     709 
;     710 #if RX_BUFFER_SIZE<256
;     711 unsigned char rx_wr_index,rx_counter;
;     712 #else
;     713 unsigned int rx_wr_index,rx_counter;
;     714 #endif
;     715 
;     716 void send_echo_msg();
;     717 
;     718 // USART Receiver interrupt service routine
;     719 #ifdef _MEGA162_INCLUDED_                    
;     720 interrupt [USART0_RXC] void usart_rx_isr(void)
;     721 #else
;     722 interrupt [USART_RXC] void usart_rx_isr(void)
;     723 #endif
;     724 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     725 char status,data;
;     726 #ifdef _MEGA162_INCLUDED_  
;     727 status=UCSR0A;
;     728 data=UDR0;
;     729 #else     
;     730 status=UCSRA;
	RCALL __SAVELOCR2
;	status -> R16
;	data -> R17
	IN   R16,11
;     731 data=UDR;
	IN   R17,12
;     732 #endif          
;     733     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+2
	RJMP _0x8E
;     734     {
;     735         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R13
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;     736         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0x8F
	CLR  R13
;     737         if (++rx_counter == RX_BUFFER_SIZE)
_0x8F:
	INC  R14
	LDI  R30,LOW(8)
	CP   R30,R14
	BRNE _0x90
;     738         {
;     739             rx_counter=0;
	CLR  R14
;     740             if (
;     741                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;     742                 rx_buffer[2]==WAKEUP_CHAR 
;     743                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BRNE _0x92
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BRNE _0x92
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ _0x93
_0x92:
	RJMP _0x91
_0x93:
;     744             {
;     745                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 8,_rx_buffer,3
;     746                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 9,_rx_buffer,4
	CLR  R10
;     747                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R9
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 9,10
;     748                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 11,_rx_buffer,6
	CLR  R12
;     749                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;     750             }
;     751             else if(
	RJMP _0x94
_0x91:
;     752                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;     753                 rx_buffer[2]==ESCAPE_CHAR 
;     754                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0x96
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0x96
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0x97
_0x96:
	RJMP _0x95
_0x97:
;     755             {
;     756                 rx_wr_index=0;
	CLR  R13
;     757                 rx_counter =0;
	CLR  R14
;     758             }      
;     759         };
_0x95:
_0x94:
_0x90:
;     760     };
_0x8E:
;     761 }
	RCALL __LOADLOCR2P
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     762 
;     763 void send_echo_msg()
;     764 {
_send_echo_msg:
;     765     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;     766     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;     767     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;     768     putchar(rx_message);
	ST   -Y,R8
	RCALL _putchar
;     769     putchar(rx_wparam>>8);
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _putchar
;     770     putchar(rx_wparam&0x00FF);
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _putchar
;     771     putchar(rx_lparam>>8);        
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _putchar
;     772     putchar(rx_lparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _putchar
;     773 }  
	RET
;     774 
;     775 void reset_serial()
;     776 {
_reset_serial:
;     777     rx_wr_index=0;
	CLR  R13
;     778     rx_counter =0;
	CLR  R14
;     779     rx_message = UNKNOWN_MSG;
	CLR  R8
;     780 }
	RET
;     781 
;     782 ///////////////////////////////////////////////////////////////
;     783 // END serial interrupt handle
;     784 /////////////////////////////////////////////////////////////// 
;     785 /*****************************************************
;     786 This program was produced by the
;     787 CodeWizardAVR V1.24.4a Standard
;     788 Automatic Program Generator
;     789 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;     790 http://www.hpinfotech.com
;     791 e-mail:office@hpinfotech.com
;     792 
;     793 Project : 
;     794 Version : 
;     795 Date    : 19/5/2005
;     796 Author  : 3iGROUP                
;     797 Company : http://www.3ihut.net   
;     798 Comments: 
;     799 
;     800 
;     801 Chip type           : ATmega8515
;     802 Program type        : Application
;     803 Clock frequency     : 8.000000 MHz
;     804 Memory model        : Small
;     805 External SRAM size  : 32768
;     806 Ext. SRAM wait state: 0
;     807 Data Stack size     : 128
;     808 *****************************************************/
;     809 
;     810 #include "define.h"                                           
;     811 
;     812 #define     ACK                 1
;     813 #define     NO_ACK              0
;     814 
;     815 // I2C Bus functions
;     816 #asm
;     817    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;     818    .equ __sda_bit=3
   .equ __sda_bit=3
;     819    .equ __scl_bit=2
   .equ __scl_bit=2
;     820 #endasm                   
;     821 
;     822 #ifdef __EEPROM_WRITE_BYTE
;     823 BYTE eeprom_read(BYTE deviceID, WORD address) 
;     824 {
_eeprom_read:
;     825     BYTE data;
;     826     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	address -> Y+1
;	data -> R16
	RCALL _i2c_start
;     827     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	RCALL _i2c_write
;     828     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     829     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     830     
;     831     i2c_start();
	RCALL _i2c_start
;     832     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	RCALL _i2c_write
;     833     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _i2c_read
	MOV  R16,R30
;     834     i2c_stop();
	RCALL _i2c_stop
;     835     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0xFF
;     836 }
;     837 
;     838 void eeprom_write(BYTE deviceID, WORD address, BYTE data) 
;     839 {
_eeprom_write:
;     840     i2c_start();
;	deviceID -> Y+3
;	address -> Y+1
;	data -> Y+0
	RCALL _i2c_start
;     841     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	RCALL _i2c_write
;     842     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     843     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     844     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	RCALL _i2c_write
;     845     i2c_stop();
	RCALL _i2c_stop
;     846 
;     847     /* 10ms delay to complete the write operation */
;     848     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     849 }                                 
_0xFF:
	ADIW R28,4
	RET
;     850 
;     851 WORD eeprom_read_w(BYTE deviceID, WORD address)
;     852 {
_eeprom_read_w:
;     853     WORD result = 0;
;     854     result = eeprom_read(deviceID,address);
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
;     855     result = (result<<8) | eeprom_read(deviceID,address+1);
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
;     856     return result;
	MOVW R30,R16
	RCALL __LOADLOCR2
	RJMP _0xFE
;     857 }
;     858 void eeprom_write_w(BYTE deviceID, WORD address, WORD data)
;     859 {
_eeprom_write_w:
;     860     eeprom_write(deviceID,address,data>>8);
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
;     861     eeprom_write(deviceID,address+1,data&0x0FF);    
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
;     862 }
_0xFE:
	ADIW R28,5
	RET
;     863 
;     864 #endif // __EEPROM_WRITE_BYTE
;     865 void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     866 {
_eeprom_read_page:
;     867     BYTE i = 0;
;     868     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	RCALL _i2c_start
;     869     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	RCALL _i2c_write
;     870     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     871     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     872     
;     873     i2c_start();
	RCALL _i2c_start
;     874     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	RCALL _i2c_write
;     875                                     
;     876     while ( i < page_size-1 )
_0x98:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0x9A
;     877     {
;     878         buffer[i++] = i2c_read(ACK);   // read at current
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
;     879     }
	RJMP _0x98
_0x9A:
;     880     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
;     881          
;     882     i2c_stop();
	RCALL _i2c_stop
;     883 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     884 
;     885 void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     886 {
_eeprom_write_page:
;     887     BYTE i = 0;
;     888     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	RCALL _i2c_start
;     889     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	RCALL _i2c_write
;     890     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     891     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     892                                         
;     893     while ( i < page_size )
_0x9B:
	LDD  R30,Y+1
	CP   R16,R30
	BRSH _0x9D
;     894     {
;     895         i2c_write(buffer[i++]);
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
;     896         #asm("nop");#asm("nop");
	nop
	nop
;     897     }          
	RJMP _0x9B
_0x9D:
;     898     i2c_stop(); 
	RCALL _i2c_stop
;     899     delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     900 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     901                                               

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
	BREQ _0x9E
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0x9F
_0x9E:
	LDD  R30,Y+2
	ST   -Y,R30
	RCALL _putchar
_0x9F:
	ADIW R28,3
	RET
__print_G4:
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R16,0
_0xA0:
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
	RJMP _0xA2
	MOV  R30,R16
	CPI  R30,0
	BRNE _0xA6
	CPI  R19,37
	BRNE _0xA7
	LDI  R16,LOW(1)
	RJMP _0xA8
_0xA7:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
_0xA8:
	RJMP _0xA5
_0xA6:
	CPI  R30,LOW(0x1)
	BRNE _0xA9
	CPI  R19,37
	BRNE _0xAA
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0x106
_0xAA:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0xAB
	LDI  R17,LOW(1)
	RJMP _0xA5
_0xAB:
	CPI  R19,43
	BRNE _0xAC
	LDI  R21,LOW(43)
	RJMP _0xA5
_0xAC:
	CPI  R19,32
	BRNE _0xAD
	LDI  R21,LOW(32)
	RJMP _0xA5
_0xAD:
	RJMP _0xAE
_0xA9:
	CPI  R30,LOW(0x2)
	BRNE _0xAF
_0xAE:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0xB0
	ORI  R17,LOW(128)
	RJMP _0xA5
_0xB0:
	RJMP _0xB1
_0xAF:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0xA5
_0xB1:
	CPI  R19,48
	BRLO _0xB4
	CPI  R19,58
	BRLO _0xB5
_0xB4:
	RJMP _0xB3
_0xB5:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0xA5
_0xB3:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0xB9
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
	RJMP _0xBA
_0xB9:
	CPI  R30,LOW(0x73)
	BRNE _0xBC
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
	RJMP _0xBD
_0xBC:
	CPI  R30,LOW(0x70)
	BRNE _0xBF
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
_0xBD:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0xC0
_0xBF:
	CPI  R30,LOW(0x64)
	BREQ _0xC3
	CPI  R30,LOW(0x69)
	BRNE _0xC4
_0xC3:
	ORI  R17,LOW(4)
	RJMP _0xC5
_0xC4:
	CPI  R30,LOW(0x75)
	BRNE _0xC6
_0xC5:
	LDI  R30,LOW(_tbl10_G4*2)
	LDI  R31,HIGH(_tbl10_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0xC7
_0xC6:
	CPI  R30,LOW(0x58)
	BRNE _0xC9
	ORI  R17,LOW(8)
	RJMP _0xCA
_0xC9:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0xFB
_0xCA:
	LDI  R30,LOW(_tbl16_G4*2)
	LDI  R31,HIGH(_tbl16_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0xC7:
	SBRS R17,2
	RJMP _0xCC
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
	BRGE _0xCD
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0xCD:
	CPI  R21,0
	BREQ _0xCE
	SUBI R16,-LOW(1)
	RJMP _0xCF
_0xCE:
	ANDI R17,LOW(251)
_0xCF:
	RJMP _0xD0
_0xCC:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0xD0:
_0xC0:
	SBRC R17,0
	RJMP _0xD1
_0xD2:
	CP   R16,R20
	BRSH _0xD4
	SBRS R17,7
	RJMP _0xD5
	SBRS R17,2
	RJMP _0xD6
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0xD7
_0xD6:
	LDI  R19,LOW(48)
_0xD7:
	RJMP _0xD8
_0xD5:
	LDI  R19,LOW(32)
_0xD8:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	SUBI R20,LOW(1)
	RJMP _0xD2
_0xD4:
_0xD1:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0xD9
_0xDA:
	CPI  R18,0
	BREQ _0xDC
	SBRS R17,3
	RJMP _0xDD
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x107
_0xDD:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x107:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xDF
	SUBI R20,LOW(1)
_0xDF:
	SUBI R18,LOW(1)
	RJMP _0xDA
_0xDC:
	RJMP _0xE0
_0xD9:
_0xE2:
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
_0xE4:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0xE6
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0xE4
_0xE6:
	CPI  R19,58
	BRLO _0xE7
	SBRS R17,3
	RJMP _0xE8
	SUBI R19,-LOW(7)
	RJMP _0xE9
_0xE8:
	SUBI R19,-LOW(39)
_0xE9:
_0xE7:
	SBRC R17,4
	RJMP _0xEB
	CPI  R19,49
	BRSH _0xED
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0xEC
_0xED:
	RJMP _0x108
_0xEC:
	CP   R20,R18
	BRLO _0xF1
	SBRS R17,0
	RJMP _0xF2
_0xF1:
	RJMP _0xF0
_0xF2:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0xF3
	LDI  R19,LOW(48)
_0x108:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0xF4
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xF5
	SUBI R20,LOW(1)
_0xF5:
_0xF4:
_0xF3:
_0xEB:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xF6
	SUBI R20,LOW(1)
_0xF6:
_0xF0:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0xE3
	RJMP _0xE2
_0xE3:
_0xE0:
	SBRS R17,0
	RJMP _0xF7
_0xF8:
	CPI  R20,0
	BREQ _0xFA
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0xF8
_0xFA:
_0xF7:
_0xFB:
_0xBA:
_0x106:
	LDI  R16,LOW(0)
_0xA5:
	RJMP _0xA0
_0xA2:
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
