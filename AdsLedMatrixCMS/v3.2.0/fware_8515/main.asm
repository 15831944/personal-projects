
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
;      33 
;      34 bit power_off = 0;
;      35 bit is_stopping = 0;    
;      36 bit key_pressed = 0;   
;      37 bit is_half_top = 1;
;      38 
;      39 unsigned long temp[4];
_temp:
	.BYTE 0x10
;      40 unsigned long dw_temp;         
_dw_temp:
	.BYTE 0x4
;      41     
;      42 register UINT x=0;
;      43 
;      44 static UINT  scroll_count = 0;  
_scroll_count_G1:
	.BYTE 0x2
;      45 static UINT  scroll_updown = 0;                                   
_scroll_updown_G1:
	.BYTE 0x2
;      46 static UINT  tick_count  = 0;       
_tick_count_G1:
	.BYTE 0x2
;      47 static BYTE  frame_index = 0;   
_frame_index_G1:
	.BYTE 0x1
;      48 static BYTE  scroll_step = 0;
_scroll_step_G1:
	.BYTE 0x1
;      49 static UINT  text_length = 0;              
_text_length_G1:
	.BYTE 0x2
;      50 static BYTE  scroll_rate = 20; 
_scroll_rate_G1:
	.BYTE 0x1
;      51 static BYTE  scroll_temp = MIN_RATE;
_scroll_temp_G1:
	.BYTE 0x1
;      52 static BYTE  scroll_type = SCROLLING;            
_scroll_type_G1:
	.BYTE 0x1
;      53              
;      54 // Global variables for message control
;      55 BYTE  rx_message = UNKNOWN_MSG;
;      56 WORD  rx_wparam  = 0;
;      57 WORD  rx_lparam  = 0;
;      58 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;      59                             
;      60 extern void reset_serial();         
;      61 extern void send_echo_msg();    
;      62 extern BYTE eeprom_read(BYTE deviceID, WORD address);
;      63 extern void eeprom_write(BYTE deviceID, WORD address, BYTE data);
;      64 extern WORD eeprom_read_w(BYTE deviceID, WORD address);
;      65 extern void eeprom_write_w(BYTE deviceID, WORD address, WORD data);
;      66 extern void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      67 extern void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      68 
;      69 static void _displayFrame();
;      70 static void _doScroll();   
;      71 void LoadFrame(BYTE index);
;      72 void BlankRAM(PBYTE start_addr,PBYTE end_addr);
;      73 
;      74 ///////////////////////////////////////////////////////////////
;      75 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;      76 ///////////////////////////////////////////////////////////////
;      77 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;      78 {       

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;      79     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;      80     ++tick_count;    
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	ADIW R30,1
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R31
;      81 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;      82 
;      83 ///////////////////////////////////////////////////////////////
;      84 // static function(s) for led matrix display panel
;      85 ///////////////////////////////////////////////////////////////
;      86 
;      87 static void _putData_0()
;      88 {                                 
__putData_0_G1:
;      89     for (x=0; x< SCREEN_WIDTH; x++){         
	CLR  R4
	CLR  R5
_0x7:
	LDI  R30,LOW(160)
	LDI  R31,HIGH(160)
	CP   R4,R30
	CPC  R5,R31
	BRSH _0x8
;      90 		DATA_PORT = start_mem[(4)*(x) + 0];       		
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,0
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;      91 		DATA_CLK = 1;
	SBI  0x12,3
;      92 		DATA_CLK = 0;					         
	CBI  0x12,3
;      93 	}         
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x7
_0x8:
;      94 	  
;      95     DATA_STB0 = 1;
	SBI  0x12,4
;      96     DATA_STB0 = 0;     
	CBI  0x12,4
;      97          
;      98     for (x=0; x< SCREEN_WIDTH; x++){ 
	CLR  R4
	CLR  R5
_0xA:
	LDI  R30,LOW(160)
	LDI  R31,HIGH(160)
	CP   R4,R30
	CPC  R5,R31
	BRSH _0xB
;      99         DATA_PORT = start_mem[(4)*(x) + 1];       		
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,1
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;     100 		DATA_CLK = 1;
	SBI  0x12,3
;     101 		DATA_CLK = 0;	
	CBI  0x12,3
;     102 	}
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0xA
_0xB:
;     103 	           
;     104     DATA_STB1 = 1;       
	SBI  0x12,5
;     105     DATA_STB1 = 0;    
	CBI  0x12,5
;     106          
;     107     for (x=0; x< SCREEN_WIDTH; x++){ 
	CLR  R4
	CLR  R5
_0xD:
	LDI  R30,LOW(160)
	LDI  R31,HIGH(160)
	CP   R4,R30
	CPC  R5,R31
	BRSH _0xE
;     108         DATA_PORT = start_mem[(4)*(x) + 2];       		
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,2
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;     109 		DATA_CLK = 1;
	SBI  0x12,3
;     110 		DATA_CLK = 0;	
	CBI  0x12,3
;     111 	}
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0xD
_0xE:
;     112 	           
;     113     DATA_STB2 = 1;       
	SBI  0x7,2
;     114     DATA_STB2 = 0;                
	CBI  0x7,2
;     115 } 
	RET
;     116 
;     117 #define __DATA_SHIFT()    \
;     118 {\
;     119     temp[0] = (unsigned long)start_mem[((unsigned int)4)*(x) + 0];\
;     120     temp[1] = (unsigned long)start_mem[((unsigned int)4)*(x) + 1];\
;     121     temp[2] = (unsigned long)start_mem[((unsigned int)4)*(x) + 2];\
;     122     temp[3] = (unsigned long)start_mem[((unsigned int)4)*(x) + 3];\
;     123     dw_temp = ~((temp[0]&0x000000FF) | ((temp[1]<<8)&0x0000FF00) | \
;     124               ((temp[2]<<16)&0x00FF0000) | ((temp[3]<<24)&0xFF000000));\
;     125     if (is_half_top){\
;     126         dw_temp = dw_temp>>scroll_updown;\
;     127     }\
;     128     else{\
;     129         dw_temp = dw_temp<<scroll_updown;\
;     130     }\
;     131 }
;     132         
;     133 static void _putData_1()
;     134 {                                        	               
__putData_1_G1:
;     135     for (x=0; x< SCREEN_WIDTH; x++){  
	CLR  R4
	CLR  R5
_0x10:
	LDI  R30,LOW(160)
	LDI  R31,HIGH(160)
	CP   R4,R30
	CPC  R5,R31
	BRLO PC+2
	RJMP _0x11
;     136         __DATA_SHIFT();
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,0
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	STS  _temp,R30
	STS  _temp+1,R31
	STS  _temp+2,R22
	STS  _temp+3,R23
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,1
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	__PUTD1MN _temp,4
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,2
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	__PUTD1MN _temp,8
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,3
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	__PUTD1MN _temp,12
	LDS  R30,_temp
	LDS  R31,_temp+1
	LDS  R22,_temp+2
	LDS  R23,_temp+3
	__ANDD1N 0xFF
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	__GETD2MN _temp,4
	LDI  R30,LOW(8)
	RCALL __LSLD12
	__ANDD1N 0xFF00
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __ORD12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1MN _temp,8
	RCALL __LSLD16
	__ANDD1N 0xFF0000
	RCALL __ORD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	__GETD2MN _temp,12
	LDI  R30,LOW(24)
	RCALL __LSLD12
	__ANDD1N 0xFF000000
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __ORD12
	RCALL __COMD1
	STS  _dw_temp,R30
	STS  _dw_temp+1,R31
	STS  _dw_temp+2,R22
	STS  _dw_temp+3,R23
	SBRS R2,3
	RJMP _0x12
	LDS  R30,_scroll_updown_G1
	LDS  R31,_scroll_updown_G1+1
	LDS  R26,_dw_temp
	LDS  R27,_dw_temp+1
	LDS  R24,_dw_temp+2
	LDS  R25,_dw_temp+3
	CLR  R22
	CLR  R23
	RCALL __LSRD12
	RJMP _0x122
_0x12:
	LDS  R30,_scroll_updown_G1
	LDS  R31,_scroll_updown_G1+1
	LDS  R26,_dw_temp
	LDS  R27,_dw_temp+1
	LDS  R24,_dw_temp+2
	LDS  R25,_dw_temp+3
	CLR  R22
	CLR  R23
	RCALL __LSLD12
_0x122:
	STS  _dw_temp,R30
	STS  _dw_temp+1,R31
	STS  _dw_temp+2,R22
	STS  _dw_temp+3,R23
;     137 		DATA_PORT = ~(BYTE)(dw_temp & 0x000000ff);       		
	__ANDD1N 0xFF
	RCALL __COMD1
	OUT  0x18,R30
;     138 		DATA_CLK = 1;
	SBI  0x12,3
;     139 		DATA_CLK = 0;					         
	CBI  0x12,3
;     140 	}         
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x10
_0x11:
;     141 	  
;     142     DATA_STB0 = 1;
	SBI  0x12,4
;     143     DATA_STB0 = 0;     
	CBI  0x12,4
;     144          
;     145     for (x=0; x< SCREEN_WIDTH; x++){ 
	CLR  R4
	CLR  R5
_0x15:
	LDI  R30,LOW(160)
	LDI  R31,HIGH(160)
	CP   R4,R30
	CPC  R5,R31
	BRLO PC+2
	RJMP _0x16
;     146         __DATA_SHIFT();
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,0
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	STS  _temp,R30
	STS  _temp+1,R31
	STS  _temp+2,R22
	STS  _temp+3,R23
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,1
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	__PUTD1MN _temp,4
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,2
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	__PUTD1MN _temp,8
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,3
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	__PUTD1MN _temp,12
	LDS  R30,_temp
	LDS  R31,_temp+1
	LDS  R22,_temp+2
	LDS  R23,_temp+3
	__ANDD1N 0xFF
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	__GETD2MN _temp,4
	LDI  R30,LOW(8)
	RCALL __LSLD12
	__ANDD1N 0xFF00
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __ORD12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1MN _temp,8
	RCALL __LSLD16
	__ANDD1N 0xFF0000
	RCALL __ORD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	__GETD2MN _temp,12
	LDI  R30,LOW(24)
	RCALL __LSLD12
	__ANDD1N 0xFF000000
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __ORD12
	RCALL __COMD1
	STS  _dw_temp,R30
	STS  _dw_temp+1,R31
	STS  _dw_temp+2,R22
	STS  _dw_temp+3,R23
	SBRS R2,3
	RJMP _0x17
	LDS  R30,_scroll_updown_G1
	LDS  R31,_scroll_updown_G1+1
	LDS  R26,_dw_temp
	LDS  R27,_dw_temp+1
	LDS  R24,_dw_temp+2
	LDS  R25,_dw_temp+3
	CLR  R22
	CLR  R23
	RCALL __LSRD12
	RJMP _0x123
_0x17:
	LDS  R30,_scroll_updown_G1
	LDS  R31,_scroll_updown_G1+1
	LDS  R26,_dw_temp
	LDS  R27,_dw_temp+1
	LDS  R24,_dw_temp+2
	LDS  R25,_dw_temp+3
	CLR  R22
	CLR  R23
	RCALL __LSLD12
_0x123:
	STS  _dw_temp,R30
	STS  _dw_temp+1,R31
	STS  _dw_temp+2,R22
	STS  _dw_temp+3,R23
;     147 		DATA_PORT = ~(BYTE)(dw_temp>>8 & 0x000000ff);  
	LDS  R30,_dw_temp
	LDS  R31,_dw_temp+1
	MOV  R30,R31
	__ANDD1N 0xFF
	RCALL __COMD1
	OUT  0x18,R30
;     148 		DATA_CLK = 1;
	SBI  0x12,3
;     149 		DATA_CLK = 0;				
	CBI  0x12,3
;     150 	}
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x15
_0x16:
;     151 	           
;     152     DATA_STB1 = 1;       
	SBI  0x12,5
;     153     DATA_STB1 = 0;    
	CBI  0x12,5
;     154          
;     155     for (x=0; x< SCREEN_WIDTH; x++){ 
	CLR  R4
	CLR  R5
_0x1A:
	LDI  R30,LOW(160)
	LDI  R31,HIGH(160)
	CP   R4,R30
	CPC  R5,R31
	BRLO PC+2
	RJMP _0x1B
;     156         __DATA_SHIFT();
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,0
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	STS  _temp,R30
	STS  _temp+1,R31
	STS  _temp+2,R22
	STS  _temp+3,R23
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,1
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	__PUTD1MN _temp,4
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,2
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	__PUTD1MN _temp,8
	MOVW R30,R4
	RCALL __LSLW2
	ADIW R30,3
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	__PUTD1MN _temp,12
	LDS  R30,_temp
	LDS  R31,_temp+1
	LDS  R22,_temp+2
	LDS  R23,_temp+3
	__ANDD1N 0xFF
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	__GETD2MN _temp,4
	LDI  R30,LOW(8)
	RCALL __LSLD12
	__ANDD1N 0xFF00
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __ORD12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1MN _temp,8
	RCALL __LSLD16
	__ANDD1N 0xFF0000
	RCALL __ORD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	__GETD2MN _temp,12
	LDI  R30,LOW(24)
	RCALL __LSLD12
	__ANDD1N 0xFF000000
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	RCALL __ORD12
	RCALL __COMD1
	STS  _dw_temp,R30
	STS  _dw_temp+1,R31
	STS  _dw_temp+2,R22
	STS  _dw_temp+3,R23
	SBRS R2,3
	RJMP _0x1C
	LDS  R30,_scroll_updown_G1
	LDS  R31,_scroll_updown_G1+1
	LDS  R26,_dw_temp
	LDS  R27,_dw_temp+1
	LDS  R24,_dw_temp+2
	LDS  R25,_dw_temp+3
	CLR  R22
	CLR  R23
	RCALL __LSRD12
	RJMP _0x124
_0x1C:
	LDS  R30,_scroll_updown_G1
	LDS  R31,_scroll_updown_G1+1
	LDS  R26,_dw_temp
	LDS  R27,_dw_temp+1
	LDS  R24,_dw_temp+2
	LDS  R25,_dw_temp+3
	CLR  R22
	CLR  R23
	RCALL __LSLD12
_0x124:
	STS  _dw_temp,R30
	STS  _dw_temp+1,R31
	STS  _dw_temp+2,R22
	STS  _dw_temp+3,R23
;     157 		DATA_PORT = ~(BYTE)(dw_temp>>16 & 0x000000ff);  
	RCALL __LSRD16
	__ANDD1N 0xFF
	RCALL __COMD1
	OUT  0x18,R30
;     158 		DATA_CLK = 1;
	SBI  0x12,3
;     159 		DATA_CLK = 0;				
	CBI  0x12,3
;     160 	}
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x1A
_0x1B:
;     161 	           
;     162     DATA_STB2 = 1;       
	SBI  0x7,2
;     163     DATA_STB2 = 0;
	CBI  0x7,2
;     164     
;     165 }
	RET
;     166 
;     167 static void _displayFrame()
;     168 {   
__displayFrame_G1:
;     169     if (scroll_type == SCROLL_LEFT || 
;     170         scroll_type == SCROLL_RIGHT ||
;     171         scroll_type == SCROLLING){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x0)
	BREQ _0x1F
	CPI  R26,LOW(0x1)
	BREQ _0x1F
	CPI  R26,LOW(0x4)
	BRNE _0x1E
_0x1F:
;     172 	    _putData_0();	            	
	RCALL __putData_0_G1
;     173 	}
;     174 	else if (scroll_type == UP_LEFT ||
	RJMP _0x21
_0x1E:
;     175 	    scroll_type == DOWN_LEFT ||
;     176 	    scroll_type == SCROLL_UP ||
;     177 	    scroll_type == SCROLL_DOWN ){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x2)
	BREQ _0x23
	CPI  R26,LOW(0x3)
	BREQ _0x23
	CPI  R26,LOW(0x5)
	BREQ _0x23
	CPI  R26,LOW(0x6)
	BRNE _0x22
_0x23:
;     178 	    _putData_1();	            	
	RCALL __putData_1_G1
;     179 	}
;     180 }     
_0x22:
_0x21:
	RET
;     181                                                                                   
;     182 static void _doScroll()
;     183 {
__doScroll_G1:
;     184 #ifdef KEY_PRESS                               
;     185   if (key_pressed==1){
	SBRS R2,2
	RJMP _0x25
;     186     is_stopping =1;
	SET
	BLD  R2,1
;     187     return;
	RET
;     188   }             
;     189 #endif //KEY_PRESS  
;     190   if (tick_count > scroll_rate){    
_0x25:
	LDS  R30,_scroll_rate_G1
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRLO PC+2
	RJMP _0x26
;     191     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     192     {
;     193     case SCROLL_LEFT:    
	CPI  R30,0
	BREQ PC+2
	RJMP _0x2A
;     194         if (scroll_step==0){           
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x2B
;     195             if (scroll_rate> MIN_RATE){
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x2C
;     196                 scroll_temp = scroll_rate;
	LDS  R30,_scroll_rate_G1
	STS  _scroll_temp_G1,R30
;     197                 scroll_rate = MIN_RATE;
	LDI  R30,LOW(2)
	STS  _scroll_rate_G1,R30
;     198             }
;     199             start_mem += 4;
_0x2C:
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     200             if (start_mem ==START_RAM_TEXT +4*(SCREEN_WIDTH)){
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xA00)
	LDI  R30,HIGH(0xA00)
	CPC  R27,R30
	BRNE _0x2D
;     201                 scroll_step++;
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
;     202             }
;     203         }
_0x2D:
;     204         else if (scroll_step==1){  
	RJMP _0x2E
_0x2B:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x2F
;     205             if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x30
;     206                 scroll_step++;         
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     207                 scroll_rate = scroll_temp;         
	LDS  R30,_scroll_temp_G1
	STS  _scroll_rate_G1,R30
;     208             }
;     209         }  
_0x30:
;     210         else if (scroll_step==2){  
	RJMP _0x31
_0x2F:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x2)
	BRNE _0x32
;     211             start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     212             if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE)){                  
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	RCALL __LSLW2
	SUBI R30,LOW(-1920)
	SBCI R31,HIGH(-1920)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x33
;     213        	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     214            	}
;     215         }              
_0x33:
;     216         break;
_0x32:
_0x31:
_0x2E:
	RJMP _0x29
;     217     case SCROLL_RIGHT:
_0x2A:
	CPI  R30,LOW(0x1)
	BREQ PC+2
	RJMP _0x34
;     218         if (scroll_step==0){   
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x35
;     219             start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     220             if (start_mem ==START_RAM_TEXT +4*(SCREEN_WIDTH)){
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xA00)
	LDI  R30,HIGH(0xA00)
	CPC  R27,R30
	BRNE _0x36
;     221                 scroll_step++;
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
;     222             }
;     223         }
_0x36:
;     224         else if (scroll_step==1){  
	RJMP _0x37
_0x35:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x38
;     225             if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x39
;     226                 scroll_step++;  
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     227                 scroll_rate = MIN_RATE;                                
	LDI  R30,LOW(2)
	STS  _scroll_rate_G1,R30
;     228             }
;     229         }  
_0x39:
;     230         else if (scroll_step==2){  
	RJMP _0x3A
_0x38:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x2)
	BRNE _0x3B
;     231             start_mem -= 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SBIW R30,4
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     232             if (start_mem <= START_RAM_TEXT){                  
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0x781)
	LDI  R30,HIGH(0x781)
	CPC  R27,R30
	BRSH _0x3C
;     233        	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     234            	}
;     235         }  
_0x3C:
;     236         break;                
_0x3B:
_0x3A:
_0x37:
	RJMP _0x29
;     237     case UP_LEFT:                             
_0x34:
	CPI  R30,LOW(0x2)
	BREQ PC+2
	RJMP _0x3D
;     238        	if (scroll_step==0){
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x3E
;     239             if (--scroll_updown <=0){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	SBIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,0
	BRNE _0x3F
;     240                 scroll_step++;                
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     241                 is_half_top =1;   
	SET
	BLD  R2,3
;     242             }
;     243         }
_0x3F:
;     244         else if (scroll_step==1){  
	RJMP _0x40
_0x3E:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x41
;     245             if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x42
;     246                 scroll_step++;
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     247                 scroll_updown = 0;                  
	LDI  R30,0
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R30
;     248             }
;     249         }        
_0x42:
;     250         else{
	RJMP _0x43
_0x41:
;     251             start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     252             if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE)){                  
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	RCALL __LSLW2
	SUBI R30,LOW(-1920)
	SBCI R31,HIGH(-1920)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x44
;     253        	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     254            	}
;     255         }  	  
_0x44:
_0x43:
_0x40:
;     256         break;
	RJMP _0x29
;     257     case DOWN_LEFT:   
_0x3D:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x45
;     258         if (scroll_step==0){
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x46
;     259             if (--scroll_updown <=0){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	SBIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,0
	BRNE _0x47
;     260                 scroll_step++;                
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     261                 is_half_top =0;   
	CLT
	BLD  R2,3
;     262             }
;     263         }
_0x47:
;     264         else if (scroll_step==1){                  
	RJMP _0x48
_0x46:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x49
;     265             if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x4A
;     266                 scroll_step++;                
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     267                 scroll_updown = 0;
	LDI  R30,0
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R30
;     268             }
;     269         }
_0x4A:
;     270         else{
	RJMP _0x4B
_0x49:
;     271             start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     272             if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE)){                  
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	RCALL __LSLW2
	SUBI R30,LOW(-1920)
	SBCI R31,HIGH(-1920)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x4C
;     273        	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     274            	}
;     275         }  	  
_0x4C:
_0x4B:
_0x48:
;     276         break;   
	RJMP _0x29
;     277     case SCROLL_UP:
_0x45:
	CPI  R30,LOW(0x5)
	BREQ PC+2
	RJMP _0x4D
;     278         if (scroll_step==0){
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x4E
;     279             if (--scroll_updown <=0){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	SBIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,0
	BRNE _0x4F
;     280                 scroll_step++;                
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     281                 is_half_top =1;   
	SET
	BLD  R2,3
;     282             }
;     283         }
_0x4F:
;     284         else if (scroll_step==1){  
	RJMP _0x50
_0x4E:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x51
;     285             if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x52
;     286                 scroll_step++;                  
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     287             }
;     288         }        
_0x52:
;     289         else if (scroll_step==2){
	RJMP _0x53
_0x51:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x2)
	BRNE _0x54
;     290             if (++scroll_updown >=SCREEN_HEIGHT){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	ADIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,16
	BRLO _0x55
;     291                 scroll_step =0;
	LDI  R30,LOW(0)
	STS  _scroll_step_G1,R30
;     292                 scroll_count=0;                
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     293                 is_half_top =0; 
	CLT
	BLD  R2,3
;     294                 start_mem += 4*SCREEN_WIDTH;                                  
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-640)
	SBCI R31,HIGH(-640)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     295                 if (start_mem >= (START_RAM_TEXT +4*(text_length+SCREEN_WIDTH))){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-160)
	SBCI R31,HIGH(-160)
	RCALL __LSLW2
	SUBI R30,LOW(-1920)
	SBCI R31,HIGH(-1920)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x56
;     296                     LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     297                 }  
;     298             }
_0x56:
;     299         }
_0x55:
;     300         	  
;     301         break;        
_0x54:
_0x53:
_0x50:
	RJMP _0x29
;     302     case SCROLL_DOWN:    
_0x4D:
	CPI  R30,LOW(0x6)
	BREQ PC+2
	RJMP _0x57
;     303         if (scroll_step==0){
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x58
;     304             if (--scroll_updown <=0){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	SBIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,0
	BRNE _0x59
;     305                 scroll_step++;                
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     306                 is_half_top =0;   
	CLT
	BLD  R2,3
;     307             }
;     308         }
_0x59:
;     309         else if (scroll_step==1){  
	RJMP _0x5A
_0x58:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x5B
;     310             if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x5C
;     311                 scroll_step++;                  
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     312             }
;     313         }        
_0x5C:
;     314         else if (scroll_step==2){
	RJMP _0x5D
_0x5B:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x2)
	BRNE _0x5E
;     315             if (++scroll_updown >=SCREEN_HEIGHT){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	ADIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,16
	BRLO _0x5F
;     316                 scroll_step =0;
	LDI  R30,LOW(0)
	STS  _scroll_step_G1,R30
;     317                 scroll_count=0;                
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     318                 is_half_top =1; 
	SET
	BLD  R2,3
;     319                 start_mem += 4*SCREEN_WIDTH;                                  
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-640)
	SBCI R31,HIGH(-640)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     320                 if (start_mem >= (START_RAM_TEXT +4*(text_length+SCREEN_WIDTH))){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-160)
	SBCI R31,HIGH(-160)
	RCALL __LSLW2
	SUBI R30,LOW(-1920)
	SBCI R31,HIGH(-1920)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x60
;     321                     LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     322                 }  
;     323             }
_0x60:
;     324         }       
_0x5F:
;     325         break;              
_0x5E:
_0x5D:
_0x5A:
	RJMP _0x29
;     326     case SCROLLING:   
_0x57:
	CPI  R30,LOW(0x4)
	BRNE _0x61
;     327         start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     328         if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	RCALL __LSLW2
	SUBI R30,LOW(-1920)
	SBCI R31,HIGH(-1920)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x62
;     329    	    {         
;     330    	        frame_index++;         
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
;     331    	        LoadFrame(frame_index);
	ST   -Y,R30
	RCALL _LoadFrame
;     332        	}            	
;     333         break;  
_0x62:
	RJMP _0x29
;     334     case NOT_USE:
_0x61:
	CPI  R30,LOW(0x7)
	BRNE _0x64
;     335         frame_index++;
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
;     336         LoadFrame(frame_index);
	ST   -Y,R30
	RCALL _LoadFrame
;     337         break;  
;     338     default:
_0x64:
;     339         break;
;     340     }
_0x29:
;     341 	tick_count = 0;
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     342 	if (frame_index >= MAX_FRAME) frame_index=0;
	LDS  R26,_frame_index_G1
	CPI  R26,LOW(0x2)
	BRLO _0x65
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     343     		
;     344   }
_0x65:
;     345              
;     346 }          
_0x26:
	RET
;     347 ////////////////////////////////////////////////////////////////////
;     348 // General functions
;     349 //////////////////////////////////////////////////////////////////// 
;     350 #define RESET_WATCHDOG()    #asm("WDR");
;     351                                                                             
;     352 void LoadConfig(BYTE index)
;     353 {
_LoadConfig:
;     354     BYTE devID = EEPROM_DEVICE_BASE;    
;     355     WORD base = 0;   // base address
;     356     devID += index<<1;                 
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
;     357     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x66
;     358         base = 0x8000;    
	__GETWRN 17,18,32768
;     359     }                 
;     360     devID &= 0xF7;      // clear bit A3 
_0x66:
	ANDI R16,LOW(247)
;     361     
;     362     // init I2C bus
;     363     i2c_init();
	RCALL _i2c_init
;     364     LED_STATUS = 1;
	SBI  0x18,4
;     365     scroll_rate = eeprom_read(devID, (WORD)base+0);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     366     scroll_type = eeprom_read(devID, (WORD)base+1);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read
	STS  _scroll_type_G1,R30
;     367     text_length = eeprom_read_w(devID, (WORD)base+2); 
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read_w
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     368     printf("line=%d rate=%d type=%d len=%d\r\n",index,scroll_rate,scroll_type,text_length);     
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
;     369 
;     370     if (text_length > DATA_LENGTH){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0xEC1)
	LDI  R30,HIGH(0xEC1)
	CPC  R27,R30
	BRLO _0x67
;     371         text_length= 0;            
	LDI  R30,0
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R30
;     372     }
;     373     if (scroll_type > NOT_USE){
_0x67:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x8)
	BRLO _0x68
;     374         scroll_type = NOT_USE;
	LDI  R30,LOW(7)
	STS  _scroll_type_G1,R30
;     375     }          
;     376     if (scroll_rate > MAX_RATE){
_0x68:
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x65)
	BRLO _0x69
;     377         scroll_rate = 0;
	LDI  R30,LOW(0)
	STS  _scroll_rate_G1,R30
;     378     }
;     379     LED_STATUS = 0;   
_0x69:
	CBI  0x18,4
;     380 }
	RJMP _0x121
;     381                        
;     382 void SaveTextLength(BYTE index)
;     383 {
_SaveTextLength:
;     384     BYTE devID = EEPROM_DEVICE_BASE;    
;     385     WORD base = 0;   // base address
;     386     devID += index<<1;                 
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
;     387     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x6A
;     388         base = 0x8000;    
	__GETWRN 17,18,32768
;     389     }                 
;     390     devID &= 0xF7;      // clear bit A3 
_0x6A:
	ANDI R16,LOW(247)
;     391     
;     392     i2c_init();
	RCALL _i2c_init
;     393     LED_STATUS = 1;   
	SBI  0x18,4
;     394     eeprom_write_w(devID, base+2,text_length); 
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
;     395     LED_STATUS = 0;   
	CBI  0x18,4
;     396 }
_0x121:
	RCALL __LOADLOCR3
	ADIW R28,4
	RET
;     397 
;     398 void SaveConfig(BYTE rate,BYTE type, BYTE index)
;     399 {                     
_SaveConfig:
;     400     BYTE devID = EEPROM_DEVICE_BASE;    
;     401     WORD base = 0;   // base address
;     402     devID += index<<1;                 
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
;     403     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x6B
;     404         base = 0x8000;    
	__GETWRN 17,18,32768
;     405     }                 
;     406     devID &= 0xF7;      // clear bit A3  
_0x6B:
	ANDI R16,LOW(247)
;     407     i2c_init();
	RCALL _i2c_init
;     408     LED_STATUS = 1;  
	SBI  0x18,4
;     409     eeprom_write(devID, base+0,rate);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	RCALL _eeprom_write
;     410     eeprom_write(devID, base+1,type);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	ST   -Y,R30
	RCALL _eeprom_write
;     411     LED_STATUS = 0;       
	CBI  0x18,4
;     412 }
	RCALL __LOADLOCR3
	ADIW R28,6
	RET
;     413 
;     414 void SaveToEEPROM(PBYTE address,WORD length,BYTE index)
;     415 {                             
_SaveToEEPROM:
;     416     PBYTE temp = 0;     
;     417     BYTE devID = EEPROM_DEVICE_BASE;
;     418     WORD base = 0;   // base address
;     419     devID += index<<1;                 
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
;     420     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x6C
;     421         base = 0x8000;    
	__GETWRN 19,20,32768
;     422     }         				
;     423     temp = address;         
_0x6C:
	__GETWRS 16,17,8
;     424         
;     425     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xEC1)
	LDI  R30,HIGH(0xEC1)
	CPC  R27,R30
	BRLO _0x6D
;     426         return; // invalid param 
	RCALL __LOADLOCR5
	ADIW R28,10
	RET
;     427     length = (WORD)address+4*(SCREEN_WIDTH+length);         
_0x6D:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-160)
	SBCI R31,HIGH(-160)
	RCALL __LSLW2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     428     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x6E
;     429         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     430     // init I2C bus
;     431     i2c_init();
_0x6E:
	RCALL _i2c_init
;     432     LED_STATUS = 1;        
	SBI  0x18,4
;     433     
;     434     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x70:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x71
;     435     {   
;     436         RESET_WATCHDOG();                          	                                              
	WDR
;     437         eeprom_write_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE);	      
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
;     438     }       
	__ADDWRN 16,17,64
	RJMP _0x70
_0x71:
;     439         
;     440     LED_STATUS = 0;   
	CBI  0x18,4
;     441 }
	RJMP _0x120
;     442                       
;     443 void LoadToRAM(PBYTE address,WORD length,BYTE index)
;     444 {                         
_LoadToRAM:
;     445     PBYTE temp = 0;          
;     446     BYTE devID = EEPROM_DEVICE_BASE;
;     447     WORD base = 0;   // base address
;     448     devID += index<<1;                 
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
;     449     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x72
;     450         base = 0x8000;    
	__GETWRN 19,20,32768
;     451     }       				
;     452     temp = address;                 
_0x72:
	__GETWRS 16,17,8
;     453 
;     454     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xEC1)
	LDI  R30,HIGH(0xEC1)
	CPC  R27,R30
	BRLO _0x73
;     455         return; // invalid param
_0x120:
	RCALL __LOADLOCR5
	ADIW R28,10
	RET
;     456     length = (WORD)address+4*(SCREEN_WIDTH+length);         
_0x73:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-160)
	SBCI R31,HIGH(-160)
	RCALL __LSLW2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     457     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x74
;     458         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     459     // init I2C bus
;     460     i2c_init();
_0x74:
	RCALL _i2c_init
;     461     LED_STATUS = 1;             
	SBI  0x18,4
;     462  
;     463     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x76:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x77
;     464     {
;     465         eeprom_read_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE );	                                   
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
;     466         RESET_WATCHDOG();     
	WDR
;     467     }             
	__ADDWRN 16,17,64
	RJMP _0x76
_0x77:
;     468 
;     469     LED_STATUS = 0;   
	CBI  0x18,4
;     470 }
	RCALL __LOADLOCR5
	ADIW R28,10
	RET
;     471 
;     472 void LoadFrame(BYTE index)
;     473 {                 
_LoadFrame:
;     474     if (index >= MAX_FRAME) index=0;  
;	index -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BRLO _0x78
	LDI  R30,LOW(0)
	ST   Y,R30
;     475 
;     476     LoadConfig(index);  
_0x78:
	LD   R30,Y
	ST   -Y,R30
	RCALL _LoadConfig
;     477     if (scroll_type >=NOT_USE){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x7)
	BRLO _0x79
;     478         return;           
	RJMP _0x11F
;     479     }                   
;     480     
;     481     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
_0x79:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     482     LoadToRAM((PBYTE)START_RAM_TEXT,text_length,index);
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	ST   -Y,R30
	RCALL _LoadToRAM
;     483     scroll_count = 0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     484     is_stopping = 0; 
	CLT
	BLD  R2,1
;     485     scroll_step = 0;
	LDI  R30,LOW(0)
	STS  _scroll_step_G1,R30
;     486     scroll_updown = 0;
	LDI  R30,0
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R30
;     487     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     488     {
;     489     case SCROLL_LEFT:
	CPI  R30,0
	BREQ _0x7E
;     490     case SCROLL_RIGHT:
	CPI  R30,LOW(0x1)
	BRNE _0x7F
_0x7E:
;     491         start_mem = (PBYTE)START_RAM_TEXT; 
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     492         break;     
	RJMP _0x7C
;     493     case SCROLL_UP:
_0x7F:
	CPI  R30,LOW(0x5)
	BREQ _0x81
;     494     case UP_LEFT: 
	CPI  R30,LOW(0x2)
	BRNE _0x82
_0x81:
;     495         is_half_top =0;
	CLT
	BLD  R2,3
;     496         scroll_updown = SCREEN_HEIGHT;                            
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R31
;     497         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     498         break;       
	RJMP _0x7C
;     499     case SCROLL_DOWN:
_0x82:
	CPI  R30,LOW(0x6)
	BREQ _0x84
;     500     case DOWN_LEFT:       
	CPI  R30,LOW(0x3)
	BRNE _0x85
_0x84:
;     501         is_half_top =1; 
	SET
	BLD  R2,3
;     502         scroll_updown = SCREEN_HEIGHT;                            
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R31
;     503         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     504         break;  
	RJMP _0x7C
;     505     case SCROLLING:
_0x85:
	CPI  R30,LOW(0x4)
	BRNE _0x87
;     506         start_mem = (PBYTE)START_RAM_TEXT;
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     507         break;
;     508     default: 
_0x87:
;     509         break;
;     510     }                   
_0x7C:
;     511 #ifdef KEY_PRESS    
;     512     if (key_pressed==1){
	SBRS R2,2
	RJMP _0x88
;     513         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2);
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     514     }           
;     515 #endif //KEY_PRESS
;     516     PORTD=0xFF;       
_0x88:
	LDI  R30,LOW(255)
	OUT  0x12,R30
;     517     DDRD=0x38;
	LDI  R30,LOW(56)
	OUT  0x11,R30
;     518 }
_0x11F:
	ADIW R28,1
	RET
;     519 
;     520 void SerialToRAM(PBYTE address,WORD length)                                             
;     521 {
_SerialToRAM:
;     522     PBYTE temp = 0;          
;     523     UINT i =0;     				
;     524     temp   = address;    
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
;     525     LED_STATUS = 1;
	SBI  0x18,4
;     526     for (i =0; i< (length<<2); i++)         
	__GETWRN 18,19,0
_0x8A:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	RCALL __LSLW2
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x8B
;     527     {                          
;     528         BYTE data = 0;
;     529         data = ~getchar();
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x8C*2)
	LDI  R31,HIGH(_0x8C*2)
	RCALL __INITLOCB
;	*address -> Y+7
;	length -> Y+5
;	data -> Y+0
	RCALL _getchar
	COM  R30
	ST   Y,R30
;     530         *temp = data;
	MOVW R26,R16
	ST   X,R30
;     531         temp++;
	__ADDWRN 16,17,1
;     532         RESET_WATCHDOG();                                     
	WDR
;     533     }              
	ADIW R28,1
	__ADDWRN 18,19,1
	RJMP _0x8A
_0x8B:
;     534     LED_STATUS = 0;
	CBI  0x18,4
;     535 }
	RCALL __LOADLOCR4
	ADIW R28,8
	RET
;     536                       
;     537 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     538 {        
_BlankRAM:
;     539     PBYTE temp = START_RAM;
;     540     for (temp = start_addr; temp<= end_addr; temp++)    
	RCALL __SAVELOCR2
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*temp -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x8E:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x8F
;     541         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     542 }
	__ADDWRN 16,17,1
	RJMP _0x8E
_0x8F:
	RCALL __LOADLOCR2
	ADIW R28,6
	RET
;     543 
;     544 
;     545 ///////////////////////////////////////////////////////////////
;     546 // END static function(s)
;     547 ///////////////////////////////////////////////////////////////
;     548 
;     549 ///////////////////////////////////////////////////////////////           
;     550 
;     551 void InitDevice()
;     552 {
_InitDevice:
;     553 // Declare your local variables here
;     554 // Crystal Oscillator division factor: 1  
;     555 #ifdef _MEGA162_INCLUDED_ 
;     556 #pragma optsize-
;     557 CLKPR=0x80;
;     558 CLKPR=0x00;
;     559 #ifdef _OPTIMIZE_SIZE_
;     560 #pragma optsize+
;     561 #endif                    
;     562 #endif
;     563 
;     564 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;     565 DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;     566 
;     567 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
;     568 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     569 
;     570 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     571 DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
;     572 
;     573 PORTD=0xFF;
	OUT  0x12,R30
;     574 DDRD=0x38; 
	LDI  R30,LOW(56)
	OUT  0x11,R30
;     575 
;     576 PORTE.0=1;
	SBI  0x7,0
;     577 DDRE.0=0;
	CBI  0x6,0
;     578 
;     579 PORTE.2=0;
	CBI  0x7,2
;     580 DDRE.2=1;
	SBI  0x6,2
;     581 
;     582 // Timer/Counter 0 initialization
;     583 // Clock source: System Clock
;     584 // Clock value: 250.000 kHz
;     585 // Mode: Normal top=FFh
;     586 // OC0 output: Disconnected
;     587 TCCR0=0x03;     // 4 us per tick
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     588 TCNT0=0x05;     // 1ms = 4*250
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     589 OCR0=0x00;      // 255 -250 = TCNT0
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     590 
;     591 #ifdef _MEGA162_INCLUDED_
;     592 UCSR0A=0x00;
;     593 UCSR0B=0x98;
;     594 UCSR0C=0x86;
;     595 UBRR0H=0x00;
;     596 UBRR0L=0x67;      //  16 MHz     
;     597 
;     598 #else // _MEGA8515_INCLUDE_     
;     599 UCSRA=0x00;
	OUT  0xB,R30
;     600 UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     601 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     602 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     603 UBRRL=0x67;       // 8 MHz
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     604 #endif
;     605 
;     606 // Lower page wait state(s): None
;     607 // Upper page wait state(s): None
;     608 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     609 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     610 
;     611 // Timer(s)/Counter(s) Interrupt(s) initialization
;     612 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     613 #ifdef _MEGA162_INCLUDED_
;     614 ETIMSK=0x00;
;     615 #endif            
;     616 
;     617 // I2C Bus initialization
;     618 // i2c_init();
;     619 
;     620 // DS1307 Real Time Clock initialization
;     621 // Square wave output on pin SQW/OUT: Off
;     622 // SQW/OUT pin state: 1
;     623 // rtc_init(3,0,1);
;     624 
;     625 //i2c_init(); // must be call before
;     626 //rtc_init(3,0,1); // init RTC DS1307  
;     627 //rtc_set_time(15,2,0);
;     628 //rtc_set_date(9,5,6);    
;     629                 
;     630 // Watchdog Timer initialization
;     631 // Watchdog Timer Prescaler: OSC/2048k     
;     632 #ifdef __WATCH_DOG_
;     633 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     634 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     635 #endif
;     636 }
	RET
;     637 
;     638 void PowerReset()
;     639 {      
_PowerReset:
;     640     start_mem = (PBYTE)START_RAM_TEXT;                    
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     641 
;     642     InitDevice();
	RCALL _InitDevice
;     643        
;     644     LED_STATUS = 0;
	CBI  0x18,4
;     645     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);  
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     646     
;     647     LED_STATUS = 0;  
	CBI  0x18,4
;     648     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     649     LED_STATUS = 1;
	SBI  0x18,4
;     650     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     651     LED_STATUS = 0;
	CBI  0x18,4
;     652     delay_ms(500);    
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     653     LED_STATUS = 1;
	SBI  0x18,4
;     654                 
;     655     frame_index= 0;
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     656     LoadFrame(frame_index);
	ST   -Y,R30
	RCALL _LoadFrame
;     657         
;     658 #ifdef _INIT_EEPROM_ 
;     659 {
;     660     BYTE i =0;
;     661     for (i =0; i< MAX_FRAME; i++){   
;     662         SaveConfig(10,0,i);
;     663         text_length = 160;
;     664         SaveTextLength(i);            
;     665     }
;     666 }
;     667 #endif  
;     668     printf("LCMS v3.05 Designed by CuongQuay\r\n");  
	__POINTW1FN _0,33
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     669     printf("cuong3ihut@yahoo.com - 0915651001\r\n");
	__POINTW1FN _0,68
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     670     printf("Release date: 09/02/2007");     
	__POINTW1FN _0,104
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     671     RESET_WATCHDOG();
	WDR
;     672 }
	RET
;     673 
;     674 void ProcessCommand()
;     675 {
_ProcessCommand:
;     676    	#asm("cli"); 
	cli
;     677     RESET_WATCHDOG();
	WDR
;     678 
;     679     // serial message processing     
;     680     switch (rx_message)
	MOV  R30,R6
;     681     {                  
;     682     case LOAD_TEXT_MSG:
	CPI  R30,LOW(0x2)
	BRNE _0x93
;     683         {                
;     684             text_length = rx_wparam;            
	__PUTWMRN _text_length_G1,0,7,8
;     685             frame_index = rx_lparam&0x0F;   
	__GETW1R 9,10
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	STS  _frame_index_G1,R30
;     686             BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     687             SerialToRAM((PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH),text_length);                
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _SerialToRAM
;     688 			start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);				
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     689 			SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R9
	RCALL _SaveToEEPROM
;     690 			SaveTextLength(rx_lparam);							  
	ST   -Y,R9
	RCALL _SaveTextLength
;     691         }				
;     692         break;           
	RJMP _0x92
;     693     case LOAD_BKGND_MSG:
_0x93:
	CPI  R30,LOW(0x3)
	BREQ _0x92
;     694         {
;     695         }
;     696         break;   
;     697     case SET_CFG_MSG: 
	CPI  R30,LOW(0xD)
	BRNE _0x95
;     698         {               
;     699             SaveConfig(rx_wparam&0x0FF,rx_wparam>>8,rx_lparam); 
	__GETW1R 7,8
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	MOV  R30,R8
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	ST   -Y,R9
	RCALL _SaveConfig
;     700         }
;     701         break;    
	RJMP _0x92
;     702     case EEPROM_SAVE_TEXT_MSG:     
_0x95:
	CPI  R30,LOW(0x7)
	BREQ _0x97
;     703     case EEPROM_SAVE_ALL_MSG:  
	CPI  R30,LOW(0xB)
	BRNE _0x98
_0x97:
;     704         {                                                          
;     705             SaveTextLength(rx_lparam);              
	ST   -Y,R9
	RCALL _SaveTextLength
;     706             SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R9
	RCALL _SaveToEEPROM
;     707         }
;     708         break;         
	RJMP _0x92
;     709     case EEPROM_LOAD_TEXT_MSG:    
_0x98:
	CPI  R30,LOW(0x6)
	BREQ _0x9A
;     710     case EEPROM_LOAD_ALL_MSG:
	CPI  R30,LOW(0xA)
	BRNE _0x9B
_0x9A:
;     711         {
;     712             LoadConfig(rx_lparam);                               
	ST   -Y,R9
	RCALL _LoadConfig
;     713             LoadToRAM((PBYTE)START_RAM_TEXT,text_length,rx_lparam); 
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R9
	RCALL _LoadToRAM
;     714             start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     715         }
;     716         break;  
	RJMP _0x92
;     717     case POWER_CTRL_MSG:
_0x9B:
	CPI  R30,LOW(0x10)
	BRNE _0x9D
;     718         power_off = rx_wparam&0x01;
	BST  R7,0
	BLD  R2,0
;     719         break;     
;     720     default:
_0x9D:
;     721         break;
;     722     }        
_0x92:
;     723     PORTD=0xFF;         
	LDI  R30,LOW(255)
	OUT  0x12,R30
;     724     DDRD=0x38;       
	LDI  R30,LOW(56)
	OUT  0x11,R30
;     725     send_echo_msg();            
	RCALL _send_echo_msg
;     726     rx_message = UNKNOWN_MSG;
	CLR  R6
;     727     #asm("sei");        
	sei
;     728 }           
	RET
;     729 ////////////////////////////////////////////////////////////////////////////////
;     730 // MAIN PROGRAM
;     731 ////////////////////////////////////////////////////////////////////////////////
;     732 void main(void)
;     733 {         
_main:
;     734     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x9E
;     735         // Watchdog Reset
;     736         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     737         reset_serial(); 
	RCALL _reset_serial
;     738     }
;     739     else {      
	RJMP _0x9F
_0x9E:
;     740         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     741     }                                     
_0x9F:
;     742      
;     743     PowerReset();                        
	RCALL _PowerReset
;     744     #asm("sei");     
	sei
;     745 
;     746     while (1){         
_0xA0:
;     747 #ifdef KEY_PRESS       
;     748         if (KEY_PRESS==0){
	SBIC 0x5,0
	RJMP _0xA3
;     749             if (key_pressed==0){
	SBRC R2,2
	RJMP _0xA4
;     750                 delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     751                 if (KEY_PRESS==0){                           
	SBIC 0x5,0
	RJMP _0xA5
;     752                     printf("KEY PRESSED\r\n");                
	__POINTW1FN _0,129
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     753                     key_pressed =1; 
	SET
	BLD  R2,2
;     754                     LoadFrame(0);                             
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _LoadFrame
;     755                 }                                                       
;     756             }
_0xA5:
;     757         }
_0xA4:
;     758         else{   
	RJMP _0xA6
_0xA3:
;     759             if (key_pressed==1){                   
	SBRS R2,2
	RJMP _0xA7
;     760                 delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     761                 if (KEY_PRESS==1){                
	SBIS 0x5,0
	RJMP _0xA8
;     762                     key_pressed =0; 
	CLT
	BLD  R2,2
;     763                     LoadFrame(frame_index);       
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	RCALL _LoadFrame
;     764                 }
;     765             }     
_0xA8:
;     766         }       
_0xA7:
_0xA6:
;     767 #endif //KEY_PRESS                   
;     768         if (rx_message != UNKNOWN_MSG){   
	TST  R6
	BREQ _0xA9
;     769             ProcessCommand();   
	RCALL _ProcessCommand
;     770         }
;     771         else{                      
	RJMP _0xAA
_0xA9:
;     772             if (!is_stopping){
	SBRS R2,1
;     773                 _displayFrame();
	RCALL __displayFrame_G1
;     774             }
;     775             _doScroll();                         
	RCALL __doScroll_G1
;     776         }
_0xAA:
;     777         RESET_WATCHDOG();
	WDR
;     778     };
	RJMP _0xA0
;     779 
;     780 }
_0xAC:
	NOP
	RJMP _0xAC
;     781                          
;     782 #include "define.h"
;     783 
;     784 ///////////////////////////////////////////////////////////////
;     785 // serial interrupt handle - processing serial message ...
;     786 ///////////////////////////////////////////////////////////////
;     787 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     788 ///////////////////////////////////////////////////////////////
;     789 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     790 extern BYTE  rx_message;
;     791 extern WORD  rx_wparam;
;     792 extern WORD  rx_lparam;
;     793 
;     794 #if RX_BUFFER_SIZE<256
;     795 unsigned char rx_wr_index,rx_counter;
;     796 #else
;     797 unsigned int rx_wr_index,rx_counter;
;     798 #endif
;     799 
;     800 void send_echo_msg();
;     801 
;     802 // USART Receiver interrupt service routine
;     803 #ifdef _MEGA162_INCLUDED_                    
;     804 interrupt [USART0_RXC] void usart_rx_isr(void)
;     805 #else
;     806 interrupt [USART_RXC] void usart_rx_isr(void)
;     807 #endif
;     808 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     809 char status,data;
;     810 #ifdef _MEGA162_INCLUDED_  
;     811 status=UCSR0A;
;     812 data=UDR0;
;     813 #else     
;     814 status=UCSRA;
	RCALL __SAVELOCR2
;	status -> R16
;	data -> R17
	IN   R16,11
;     815 data=UDR;
	IN   R17,12
;     816 #endif          
;     817     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+2
	RJMP _0xAD
;     818     {
;     819         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R11
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;     820         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R11
	LDI  R30,LOW(8)
	CP   R30,R11
	BRNE _0xAE
	CLR  R11
;     821         if (++rx_counter == RX_BUFFER_SIZE)
_0xAE:
	INC  R12
	LDI  R30,LOW(8)
	CP   R30,R12
	BRNE _0xAF
;     822         {
;     823             rx_counter=0;
	CLR  R12
;     824             if (
;     825                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;     826                 rx_buffer[2]==WAKEUP_CHAR 
;     827                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BRNE _0xB1
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BRNE _0xB1
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ _0xB2
_0xB1:
	RJMP _0xB0
_0xB2:
;     828             {
;     829                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 6,_rx_buffer,3
;     830                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 7,_rx_buffer,4
	CLR  R8
;     831                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R7
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 7,8
;     832                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 9,_rx_buffer,6
	CLR  R10
;     833                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R9
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 9,10
;     834             }
;     835             else if(
	RJMP _0xB3
_0xB0:
;     836                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;     837                 rx_buffer[2]==ESCAPE_CHAR 
;     838                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0xB5
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0xB5
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0xB6
_0xB5:
	RJMP _0xB4
_0xB6:
;     839             {
;     840                 rx_wr_index=0;
	CLR  R11
;     841                 rx_counter =0;
	CLR  R12
;     842             }      
;     843         };
_0xB4:
_0xB3:
_0xAF:
;     844     };
_0xAD:
;     845 }
	RCALL __LOADLOCR2P
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     846 
;     847 void send_echo_msg()
;     848 {
_send_echo_msg:
;     849     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;     850     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;     851     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL _putchar
;     852     putchar(rx_message);
	ST   -Y,R6
	RCALL _putchar
;     853     putchar(rx_wparam>>8);
	MOV  R30,R8
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _putchar
;     854     putchar(rx_wparam&0x00FF);
	__GETW1R 7,8
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _putchar
;     855     putchar(rx_lparam>>8);        
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _putchar
;     856     putchar(rx_lparam&0x00FF);
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _putchar
;     857 }  
	RET
;     858 
;     859 void reset_serial()
;     860 {
_reset_serial:
;     861     rx_wr_index=0;
	CLR  R11
;     862     rx_counter =0;
	CLR  R12
;     863     rx_message = UNKNOWN_MSG;
	CLR  R6
;     864 }
	RET
;     865 
;     866 ///////////////////////////////////////////////////////////////
;     867 // END serial interrupt handle
;     868 /////////////////////////////////////////////////////////////// 
;     869 /*****************************************************
;     870 This program was produced by the
;     871 CodeWizardAVR V1.24.4a Standard
;     872 Automatic Program Generator
;     873 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;     874 http://www.hpinfotech.com
;     875 e-mail:office@hpinfotech.com
;     876 
;     877 Project : 
;     878 Version : 
;     879 Date    : 19/5/2005
;     880 Author  : 3iGROUP                
;     881 Company : http://www.3ihut.net   
;     882 Comments: 
;     883 
;     884 
;     885 Chip type           : ATmega8515
;     886 Program type        : Application
;     887 Clock frequency     : 8.000000 MHz
;     888 Memory model        : Small
;     889 External SRAM size  : 32768
;     890 Ext. SRAM wait state: 0
;     891 Data Stack size     : 128
;     892 *****************************************************/
;     893 
;     894 #include "define.h"                                           
;     895 
;     896 #define     ACK                 1
;     897 #define     NO_ACK              0
;     898 
;     899 // I2C Bus functions
;     900 #asm
;     901    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;     902    .equ __sda_bit=3
   .equ __sda_bit=3
;     903    .equ __scl_bit=2
   .equ __scl_bit=2
;     904 #endasm                   
;     905 
;     906 #ifdef __EEPROM_WRITE_BYTE
;     907 BYTE eeprom_read(BYTE deviceID, WORD address) 
;     908 {
_eeprom_read:
;     909     BYTE data;
;     910     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	address -> Y+1
;	data -> R16
	RCALL _i2c_start
;     911     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	RCALL _i2c_write
;     912     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     913     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     914     
;     915     i2c_start();
	RCALL _i2c_start
;     916     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	RCALL _i2c_write
;     917     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _i2c_read
	MOV  R16,R30
;     918     i2c_stop();
	RCALL _i2c_stop
;     919     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0x11E
;     920 }
;     921 
;     922 void eeprom_write(BYTE deviceID, WORD address, BYTE data) 
;     923 {
_eeprom_write:
;     924     i2c_start();
;	deviceID -> Y+3
;	address -> Y+1
;	data -> Y+0
	RCALL _i2c_start
;     925     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	RCALL _i2c_write
;     926     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     927     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     928     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	RCALL _i2c_write
;     929     i2c_stop();
	RCALL _i2c_stop
;     930 
;     931     /* 10ms delay to complete the write operation */
;     932     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     933 }                                 
_0x11E:
	ADIW R28,4
	RET
;     934 
;     935 WORD eeprom_read_w(BYTE deviceID, WORD address)
;     936 {
_eeprom_read_w:
;     937     WORD result = 0;
;     938     result = eeprom_read(deviceID,address);
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
;     939     result = (result<<8) | eeprom_read(deviceID,address+1);
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
;     940     return result;
	MOVW R30,R16
	RCALL __LOADLOCR2
	RJMP _0x11D
;     941 }
;     942 void eeprom_write_w(BYTE deviceID, WORD address, WORD data)
;     943 {
_eeprom_write_w:
;     944     eeprom_write(deviceID,address,data>>8);
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
;     945     eeprom_write(deviceID,address+1,data&0x0FF);    
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
;     946 }
_0x11D:
	ADIW R28,5
	RET
;     947 
;     948 #endif // __EEPROM_WRITE_BYTE
;     949 void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     950 {
_eeprom_read_page:
;     951     BYTE i = 0;
;     952     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	RCALL _i2c_start
;     953     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	RCALL _i2c_write
;     954     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     955     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     956     
;     957     i2c_start();
	RCALL _i2c_start
;     958     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	RCALL _i2c_write
;     959                                     
;     960     while ( i < page_size-1 )
_0xB7:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0xB9
;     961     {
;     962         buffer[i++] = i2c_read(ACK);   // read at current
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
;     963     }
	RJMP _0xB7
_0xB9:
;     964     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
;     965          
;     966     i2c_stop();
	RCALL _i2c_stop
;     967 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     968 
;     969 void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     970 {
_eeprom_write_page:
;     971     BYTE i = 0;
;     972     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	RCALL _i2c_start
;     973     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	RCALL _i2c_write
;     974     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     975     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     976                                         
;     977     while ( i < page_size )
_0xBA:
	LDD  R30,Y+1
	CP   R16,R30
	BRSH _0xBC
;     978     {
;     979         i2c_write(buffer[i++]);
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
;     980         #asm("nop");#asm("nop");
	nop
	nop
;     981     }          
	RJMP _0xBA
_0xBC:
;     982     i2c_stop(); 
	RCALL _i2c_stop
;     983     delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     984 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     985                                               

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
	BREQ _0xBD
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0xBE
_0xBD:
	LDD  R30,Y+2
	ST   -Y,R30
	RCALL _putchar
_0xBE:
	ADIW R28,3
	RET
__print_G4:
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R16,0
_0xBF:
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
	RJMP _0xC1
	MOV  R30,R16
	CPI  R30,0
	BRNE _0xC5
	CPI  R19,37
	BRNE _0xC6
	LDI  R16,LOW(1)
	RJMP _0xC7
_0xC6:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
_0xC7:
	RJMP _0xC4
_0xC5:
	CPI  R30,LOW(0x1)
	BRNE _0xC8
	CPI  R19,37
	BRNE _0xC9
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0x125
_0xC9:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0xCA
	LDI  R17,LOW(1)
	RJMP _0xC4
_0xCA:
	CPI  R19,43
	BRNE _0xCB
	LDI  R21,LOW(43)
	RJMP _0xC4
_0xCB:
	CPI  R19,32
	BRNE _0xCC
	LDI  R21,LOW(32)
	RJMP _0xC4
_0xCC:
	RJMP _0xCD
_0xC8:
	CPI  R30,LOW(0x2)
	BRNE _0xCE
_0xCD:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0xCF
	ORI  R17,LOW(128)
	RJMP _0xC4
_0xCF:
	RJMP _0xD0
_0xCE:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0xC4
_0xD0:
	CPI  R19,48
	BRLO _0xD3
	CPI  R19,58
	BRLO _0xD4
_0xD3:
	RJMP _0xD2
_0xD4:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0xC4
_0xD2:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0xD8
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
	RJMP _0xD9
_0xD8:
	CPI  R30,LOW(0x73)
	BRNE _0xDB
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
	RJMP _0xDC
_0xDB:
	CPI  R30,LOW(0x70)
	BRNE _0xDE
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
_0xDC:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0xDF
_0xDE:
	CPI  R30,LOW(0x64)
	BREQ _0xE2
	CPI  R30,LOW(0x69)
	BRNE _0xE3
_0xE2:
	ORI  R17,LOW(4)
	RJMP _0xE4
_0xE3:
	CPI  R30,LOW(0x75)
	BRNE _0xE5
_0xE4:
	LDI  R30,LOW(_tbl10_G4*2)
	LDI  R31,HIGH(_tbl10_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0xE6
_0xE5:
	CPI  R30,LOW(0x58)
	BRNE _0xE8
	ORI  R17,LOW(8)
	RJMP _0xE9
_0xE8:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x11A
_0xE9:
	LDI  R30,LOW(_tbl16_G4*2)
	LDI  R31,HIGH(_tbl16_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0xE6:
	SBRS R17,2
	RJMP _0xEB
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
	BRGE _0xEC
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0xEC:
	CPI  R21,0
	BREQ _0xED
	SUBI R16,-LOW(1)
	RJMP _0xEE
_0xED:
	ANDI R17,LOW(251)
_0xEE:
	RJMP _0xEF
_0xEB:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0xEF:
_0xDF:
	SBRC R17,0
	RJMP _0xF0
_0xF1:
	CP   R16,R20
	BRSH _0xF3
	SBRS R17,7
	RJMP _0xF4
	SBRS R17,2
	RJMP _0xF5
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0xF6
_0xF5:
	LDI  R19,LOW(48)
_0xF6:
	RJMP _0xF7
_0xF4:
	LDI  R19,LOW(32)
_0xF7:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	SUBI R20,LOW(1)
	RJMP _0xF1
_0xF3:
_0xF0:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0xF8
_0xF9:
	CPI  R18,0
	BREQ _0xFB
	SBRS R17,3
	RJMP _0xFC
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x126
_0xFC:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x126:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xFE
	SUBI R20,LOW(1)
_0xFE:
	SUBI R18,LOW(1)
	RJMP _0xF9
_0xFB:
	RJMP _0xFF
_0xF8:
_0x101:
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
_0x103:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x105
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x103
_0x105:
	CPI  R19,58
	BRLO _0x106
	SBRS R17,3
	RJMP _0x107
	SUBI R19,-LOW(7)
	RJMP _0x108
_0x107:
	SUBI R19,-LOW(39)
_0x108:
_0x106:
	SBRC R17,4
	RJMP _0x10A
	CPI  R19,49
	BRSH _0x10C
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x10B
_0x10C:
	RJMP _0x127
_0x10B:
	CP   R20,R18
	BRLO _0x110
	SBRS R17,0
	RJMP _0x111
_0x110:
	RJMP _0x10F
_0x111:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0x112
	LDI  R19,LOW(48)
_0x127:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0x113
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0x114
	SUBI R20,LOW(1)
_0x114:
_0x113:
_0x112:
_0x10A:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0x115
	SUBI R20,LOW(1)
_0x115:
_0x10F:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x102
	RJMP _0x101
_0x102:
_0xFF:
	SBRS R17,0
	RJMP _0x116
_0x117:
	CPI  R20,0
	BREQ _0x119
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0x117
_0x119:
_0x116:
_0x11A:
_0xD9:
_0x125:
	LDI  R16,LOW(0)
_0xC4:
	RJMP _0xBF
_0xC1:
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

__ORD12:
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	RET

__ANEGW1:
	COM  R30
	COM  R31
	ADIW R30,1
	RET

__LSLD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSLD12R
__LSLD12L:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R0
	BRNE __LSLD12L
__LSLD12R:
	RET

__LSRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSRD12R
__LSRD12L:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRD12L
__LSRD12R:
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

__LSRD16:
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	RET

__LSLD16:
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	RET

__COMD1:
	COM  R30
	COM  R31
	COM  R22
	COM  R23
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
