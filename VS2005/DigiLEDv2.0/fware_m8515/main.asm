
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
;Data Stack size        : 100 byte(s)
;Heap size              : 20 byte(s)
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
	LDI  R24,LOW(0x1EC)
	LDI  R25,HIGH(0x1EC)
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
	LDI  R30,LOW(0x24B)
	OUT  SPL,R30
	LDI  R30,HIGH(0x24B)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0xC4)
	LDI  R29,HIGH(0xC4)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xC4
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
;      27 // 1 Wire Bus functions
;      28 #asm
;      29    .equ __w1_port=0x12 ;PORTD
   .equ __w1_port=0x12 ;PORTD
;      30    .equ __w1_bit=5
   .equ __w1_bit=5
;      31 #endasm
;      32 #include <1wire.h>
;      33 // DS1820 Temperature Sensor functions
;      34 #include <ds18b20.h>
;      35 // DS1307 Real Time Clock functions
;      36 #include <ds1307.h>
;      37                                       
;      38 // Declare your global variables here     
;      39 static PBYTE start_mem;
_start_mem_G1:
	.BYTE 0x2
;      40 static PBYTE end_mem;        
_end_mem_G1:
	.BYTE 0x2
;      41 static PBYTE buffer; 
_buffer_G1:
	.BYTE 0x2
;      42 static PBYTE org_mem;
_org_mem_G1:
	.BYTE 0x2
;      43 
;      44 bit is_power_off         = 0;     
;      45 
;      46 register UINT count_row  = 0;
;      47 register UINT count_col  = 0;     
;      48 
;      49 static BYTE scroll_rate   = 0; 
_scroll_rate_G1:
	.BYTE 0x1
;      50 static BYTE page_index   = 0;                                 
_page_index_G1:
	.BYTE 0x1
;      51 
;      52 static UINT  tick_count  = 0;      
_tick_count_G1:
	.BYTE 0x2
;      53 static UINT  text_length = 0;
_text_length_G1:
	.BYTE 0x2
;      54 //static UINT  char_width[256];    
;      55 
;      56 flash char  szText[] = "** CuongQuay 0915651001 **";    

	.CSEG
;      57 static char szTitle[MAX_PAGE][MAX_TITLE]={

	.DSEG
_szTitle_G1:
;      58 "TO CHUC KINH TE    ",
;      59 "DAN CU GUI GOP     ",
;      60 "DAN CU BAC THANG   ",
;      61 "DAN CU DU THUONG   ",
;      62 "DAN CU THONG THUONG"
;      63 };                               
	.BYTE 0x64
;      64 
;      65 BYTE _xtable[]= {
__xtable:
;      66                 0x11,0x9F,0x32,0x16,0x9C,0x54,0x50,0x1F,
;      67                 0x10,0x14,0xFE,0xEF,0xFF,0xFF,0xFF,0xFF
;      68                 };                                 
	.BYTE 0x10
;      69 
;      70 // Global variables for message control
;      71 BYTE  rx_message = UNKNOWN_MSG;
;      72 WORD  rx_wparam  = 0;
;      73 WORD  rx_lparam  = 0;
;      74 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;      75                             
;      76 extern void reset_serial();         
;      77 extern void send_echo_msg();    
;      78 extern BYTE eeprom_read(BYTE deviceID, PBYTE address);
;      79 extern void eeprom_write(BYTE deviceID, PBYTE address, BYTE data);
;      80 extern WORD eeprom_read_w(BYTE deviceID, PBYTE address);
;      81 extern void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data);
;      82 extern void eeprom_write_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size);
;      83 extern void eeprom_read_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size);
;      84 
;      85 static void _displayFrame();
;      86 static void _displayLED();
;      87 static void _doPaging(); 
;      88                                                                                  
;      89 void LoadPage();                  
;      90 void GetRTCBuffer();      
;      91 void FormatRTC(PBYTE pBuffer, UINT nBuffSize);
;      92 void BlankRAM(PBYTE start_addr,PBYTE end_addr);
;      93 ///////////////////////////////////////////////////////////////
;      94 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;      95 ///////////////////////////////////////////////////////////////
;      96 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;      97 {       

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;      98     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;      99     ++tick_count;    
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	ADIW R30,1
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R31
;     100 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;     101 
;     102 #define RESET_WATCHDOG()    #asm("WDR");
;     103 ///////////////////////////////////////////////////////////////
;     104 // static function(s) for led matrix display panel
;     105 ///////////////////////////////////////////////////////////////
;     106 static void _setRow()
;     107 {
__setRow_G1:
;     108     BYTE i=0;      
;     109     for (i=0; i<8; i++){            
	ST   -Y,R16
;	i -> R16
	LDI  R16,0
	LDI  R16,LOW(0)
_0x5:
	CPI  R16,8
	BRSH _0x6
;     110         if (i==(7-count_row)) SCAN_DAT = ON;        
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
;     111         else SCAN_DAT = OFF;        
	RJMP _0x8
_0x7:
	SBI  0x12,5
;     112         SCAN_CLK = 1;
_0x8:
	SBI  0x12,3
;     113         SCAN_CLK = 0;            
	CBI  0x12,3
;     114     }
	SUBI R16,-1
	RJMP _0x5
_0x6:
;     115 }
	RJMP _0x10D
;     116             
;     117 static void _powerOff()
;     118 {
__powerOff_G1:
;     119     BYTE i =0;               
;     120     SCAN_DAT = OFF;  // data scan low        
	ST   -Y,R16
;	i -> R16
	LDI  R16,0
	SBI  0x12,5
;     121     for (i=0; i< 8; i++)    
	LDI  R16,LOW(0)
_0xA:
	CPI  R16,8
	BRSH _0xB
;     122     {                                              
;     123         SCAN_CLK = 1;    // clock scan high
	SBI  0x12,3
;     124         SCAN_CLK = 0;    // clock scan low            
	CBI  0x12,3
;     125     }                                         
	SUBI R16,-1
	RJMP _0xA
_0xB:
;     126     SCAN_STB = 1;    // strobe scan high
	SBI  0x12,4
;     127     SCAN_STB = 0;    // strobe scan low                    
	CBI  0x12,4
;     128 }
_0x10D:
	LD   R16,Y+
	RET
;     129 #define _DELAY_BUS      1
;     130 static void _displayLED()
;     131 {                                  
__displayLED_G1:
;     132     UINT i=0;        
;     133     BYTE data[6];
;     134     BYTE mask=0,k=0;       
;     135     PBYTE buffer =(PBYTE)START_RAM+SCREEN_WIDTH;
;     136     CTRL_CLK = 0;
	SBIW R28,6
	RCALL __SAVELOCR6
;	i -> R16,R17
;	data -> Y+6
;	mask -> R18
;	k -> R19
;	*buffer -> R20,R21
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	LDI  R20,LOW(0x568)
	LDI  R21,HIGH(0x568)
	CBI  0x18,6
;     137     CTRL_STB = 0;
	CBI  0x18,7
;     138     for (i=0; i< 60; i++){      
	__GETWRN 16,17,0
_0xD:
	__CPWRN 16,17,60
	BRLO PC+2
	RJMP _0xE
;     139         mask = 0x01;
	LDI  R18,LOW(1)
;     140 #ifdef __TEST_LED_        
;     141         data[0] = _xtable[i%(page_index+1)];
;     142         data[1] = data[0];
;     143         data[2] = data[0];
;     144         data[3] = data[0];
;     145         data[4] = data[0];
;     146         data[5] = data[0];
;     147 #else                                     
;     148         data[0] = buffer[60 -i-1];       
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	SUB  R30,R16
	SBC  R31,R17
	SBIW R30,1
	ADD  R30,R20
	ADC  R31,R21
	LD   R30,Z
	STD  Y+6,R30
;     149         data[1] = buffer[120-i-1];
	LDI  R30,LOW(120)
	LDI  R31,HIGH(120)
	SUB  R30,R16
	SBC  R31,R17
	SBIW R30,1
	ADD  R30,R20
	ADC  R31,R21
	LD   R30,Z
	STD  Y+7,R30
;     150         data[2] = buffer[180-i-1];
	LDI  R30,LOW(180)
	LDI  R31,HIGH(180)
	SUB  R30,R16
	SBC  R31,R17
	SBIW R30,1
	ADD  R30,R20
	ADC  R31,R21
	LD   R30,Z
	STD  Y+8,R30
;     151         data[3] = buffer[240-i-1];
	LDI  R30,LOW(240)
	LDI  R31,HIGH(240)
	SUB  R30,R16
	SBC  R31,R17
	SBIW R30,1
	ADD  R30,R20
	ADC  R31,R21
	LD   R30,Z
	STD  Y+9,R30
;     152         data[4] = buffer[300-i-1];
	LDI  R30,LOW(300)
	LDI  R31,HIGH(300)
	SUB  R30,R16
	SBC  R31,R17
	SBIW R30,1
	ADD  R30,R20
	ADC  R31,R21
	LD   R30,Z
	STD  Y+10,R30
;     153         data[5] = buffer[360-i-1];        
	LDI  R30,LOW(360)
	LDI  R31,HIGH(360)
	SUB  R30,R16
	SBC  R31,R17
	SBIW R30,1
	ADD  R30,R20
	ADC  R31,R21
	LD   R30,Z
	STD  Y+11,R30
;     154 #endif        
;     155         for (k=0; k< 8; k++){
	LDI  R19,LOW(0)
_0x10:
	CPI  R19,8
	BRLO PC+2
	RJMP _0x11
;     156             if ((data[0]&mask)>>(k)){
	MOV  R30,R18
	LDD  R26,Y+6
	AND  R30,R26
	MOV  R26,R30
	MOV  R30,R19
	RCALL __LSRB12
	CPI  R30,0
	BREQ _0x12
;     157                 DATA_01 = 1;delay_us(_DELAY_BUS);
	SBI  0x18,0
	RJMP _0x10E
;     158             }
;     159             else{
_0x12:
;     160                 DATA_01 = 0;delay_us(_DELAY_BUS);
	CBI  0x18,0
_0x10E:
	__DELAY_USB 5
;     161             }    
;     162             
;     163             if ((data[1]&mask)>>(k)){
	MOV  R30,R18
	LDD  R26,Y+7
	AND  R30,R26
	MOV  R26,R30
	MOV  R30,R19
	RCALL __LSRB12
	CPI  R30,0
	BREQ _0x14
;     164                 DATA_02 = 1;delay_us(_DELAY_BUS);
	SBI  0x18,1
	RJMP _0x10F
;     165             }
;     166             else{
_0x14:
;     167                 DATA_02 = 0;delay_us(_DELAY_BUS);
	CBI  0x18,1
_0x10F:
	__DELAY_USB 5
;     168             }
;     169             
;     170             if ((data[2]&mask)>>(k)){
	MOV  R30,R18
	LDD  R26,Y+8
	AND  R30,R26
	MOV  R26,R30
	MOV  R30,R19
	RCALL __LSRB12
	CPI  R30,0
	BREQ _0x16
;     171                 DATA_03 = 1;delay_us(_DELAY_BUS);
	SBI  0x18,2
	RJMP _0x110
;     172             }
;     173             else{
_0x16:
;     174                 DATA_03 = 0;delay_us(_DELAY_BUS);
	CBI  0x18,2
_0x110:
	__DELAY_USB 5
;     175             }
;     176             
;     177             if ((data[3]&mask)>>(k)){
	MOV  R30,R18
	LDD  R26,Y+9
	AND  R30,R26
	MOV  R26,R30
	MOV  R30,R19
	RCALL __LSRB12
	CPI  R30,0
	BREQ _0x18
;     178                 DATA_04 = 1;delay_us(_DELAY_BUS);
	SBI  0x18,3
	RJMP _0x111
;     179             }
;     180             else{
_0x18:
;     181                 DATA_04 = 0;delay_us(_DELAY_BUS);
	CBI  0x18,3
_0x111:
	__DELAY_USB 5
;     182             }
;     183             
;     184             if ((data[4]&mask)>>(k)){
	MOV  R30,R18
	LDD  R26,Y+10
	AND  R30,R26
	MOV  R26,R30
	MOV  R30,R19
	RCALL __LSRB12
	CPI  R30,0
	BREQ _0x1A
;     185                 DATA_05 = 1;delay_us(_DELAY_BUS);
	SBI  0x18,4
	RJMP _0x112
;     186             }
;     187             else{
_0x1A:
;     188                 DATA_05 = 0;delay_us(_DELAY_BUS);
	CBI  0x18,4
_0x112:
	__DELAY_USB 5
;     189             }
;     190                       
;     191             if ((data[5]&mask)>>(k)){
	MOV  R30,R18
	LDD  R26,Y+11
	AND  R30,R26
	MOV  R26,R30
	MOV  R30,R19
	RCALL __LSRB12
	CPI  R30,0
	BREQ _0x1C
;     192                 DATA_06 = 1;delay_us(_DELAY_BUS);
	SBI  0x18,5
	RJMP _0x113
;     193             }
;     194             else{
_0x1C:
;     195                 DATA_06 = 0;delay_us(_DELAY_BUS);
	CBI  0x18,5
_0x113:
	__DELAY_USB 5
;     196             }
;     197             
;     198             CTRL_CLK = 1;delay_us(_DELAY_BUS);
	SBI  0x18,6
	__DELAY_USB 5
;     199             CTRL_CLK = 0;delay_us(_DELAY_BUS);        
	CBI  0x18,6
	__DELAY_USB 5
;     200             mask = mask<<1;  
	LSL  R18
;     201         }                   
	SUBI R19,-1
	RJMP _0x10
_0x11:
;     202         RESET_WATCHDOG();
	WDR
;     203     }	             
	__ADDWRN 16,17,1
	RJMP _0xD
_0xE:
;     204     CTRL_STB = 1;delay_us(_DELAY_BUS);
	SBI  0x18,7
	__DELAY_USB 5
;     205     CTRL_STB = 0;delay_us(_DELAY_BUS);
	CBI  0x18,7
	__DELAY_USB 5
;     206 }        
	RCALL __LOADLOCR6
	ADIW R28,12
	RET
;     207 
;     208 static void _displayFrame()
;     209 {                 
__displayFrame_G1:
;     210     BYTE data = 0;  
;     211     count_col = 0;
	ST   -Y,R16
;	data -> R16
	LDI  R16,0
	CLR  R6
	CLR  R7
;     212     count_row = 0;         
	CLR  R4
	CLR  R5
;     213 
;     214     if (is_power_off ==1){
	SBRS R2,0
	RJMP _0x1E
;     215         _powerOff();
	RCALL __powerOff_G1
;     216         return;
	RJMP _0x10C
;     217     }
;     218     // display one frame in the screen at the specific time 
;     219     for (buffer = start_mem;buffer < (END_RAM); buffer++)  
_0x1E:
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
_0x20:
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	CPI  R26,LOW(0x7FFF)
	LDI  R30,HIGH(0x7FFF)
	CPC  R27,R30
	BRSH _0x21
;     220     {                     
;     221         data = (*buffer);
	LD   R16,X
;     222         #ifdef ENABLE_MASK_ROW  
;     223         data &= ENABLE_MASK_ROW;
	ANDI R16,LOW(15)
;     224         #endif //ENABLE_MASK_ROW
;     225         DATA_BIT = (data&0x01);
	BST  R16,0
	IN   R26,0x12
	BLD  R26,2
	OUT  0x12,R26
;     226         
;     227         DATA_CLK = 1;    // clock high
	SBI  0x7,2
;     228         DATA_CLK = 0;    // clock low   
	CBI  0x7,2
;     229         if ( ++count_col >= SCREEN_WIDTH)
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	CPI  R30,LOW(0x68)
	LDI  R26,HIGH(0x68)
	CPC  R31,R26
	BRLO _0x22
;     230         {                                            
;     231             count_col = 0;      // reset for next                                                                                                                       
	CLR  R6
	CLR  R7
;     232             _powerOff();        // turn all led off            
	RCALL __powerOff_G1
;     233             
;     234             SCAN_STB = 0;       // strobe low   
	CBI  0x12,4
;     235             _setRow();          // turn row-led on                                                              
	RCALL __setRow_G1
;     236             SCAN_STB = 1;       // strobe high            
	SBI  0x12,4
;     237                  
;     238             DATA_STB = 1;       // strobe high            
	SBI  0x7,0
;     239             DATA_STB = 0;       // strobe low            
	CBI  0x7,0
;     240                         
;     241             if (++count_row >= 8){ 
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	SBIW R30,8
	BRLO _0x23
;     242                 count_row = 0;
	CLR  R4
	CLR  R5
;     243             }                                                                                         
;     244             buffer += (DATA_LENGTH - SCREEN_WIDTH);                 
_0x23:
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	SUBI R30,LOW(-3728)
	SBCI R31,HIGH(-3728)
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
;     245         }                   
;     246     }                         	
_0x22:
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	ADIW R30,1
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
	RJMP _0x20
_0x21:
;     247 }     
_0x10C:
	LD   R16,Y+
	RET
;     248                                   
;     249 static void _doPaging()
;     250 {
__doPaging_G1:
;     251     // init state                         
;     252     DATA_STB = 0;
	CBI  0x7,0
;     253     DATA_CLK = 0;               
	CBI  0x7,2
;     254     // scroll left with shift_step bit(s)
;     255     if(tick_count >= 1000){   
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRLO _0x24
;     256         tick_count = 0; 
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     257         if (scroll_rate >0){           
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x1)
	BRLO _0x25
;     258             scroll_rate--;             
	LDS  R30,_scroll_rate_G1
	SUBI R30,LOW(1)
	STS  _scroll_rate_G1,R30
;     259         }
;     260         else{                                 
	RJMP _0x26
_0x25:
;     261             LoadPage();                        
	RCALL _LoadPage
;     262         }
_0x26:
;     263     }        
;     264 }                 
_0x24:
	RET
;     265 
;     266                                           
;     267 ////////////////////////////////////////////////////////////////////
;     268 // General functions
;     269 //////////////////////////////////////////////////////////////////// 
;     270 BYTE GetLocalTime(BYTE hh, int offset)
;     271 {                          
_GetLocalTime:
;     272     int lval= 0;
;     273     if (offset){       
	RCALL __SAVELOCR2
;	hh -> Y+4
;	offset -> Y+2
;	lval -> R16,R17
	LDI  R16,0
	LDI  R17,0
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BREQ _0x27
;     274         lval = (int)hh+offset;    
	LDD  R30,Y+4
	LDI  R31,0
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADD  R30,R26
	ADC  R31,R27
	MOVW R16,R30
;     275         if (lval >= 24){
	__CPWRN 16,17,24
	BRLT _0x28
;     276             lval = lval%24;
	MOVW R26,R16
	LDI  R30,LOW(24)
	LDI  R31,HIGH(24)
	RCALL __MODW21
	MOVW R16,R30
;     277         }            
;     278         if (lval <0){
_0x28:
	SUBI R16,0
	SBCI R17,0
	BRGE _0x29
;     279             lval = 24 + lval;
	__ADDWRN 16,17,24
;     280         }
;     281     }               
_0x29:
;     282     else{
	RJMP _0x2A
_0x27:
;     283         lval = hh;
	LDD  R16,Y+4
	CLR  R17
;     284     }    
_0x2A:
;     285     return (BYTE)lval;
	MOV  R30,R16
	RCALL __LOADLOCR2
	ADIW R28,5
	RET
;     286 }                                    
;     287 
;     288 void GetRTCBuffer()
;     289 {
_GetRTCBuffer:
;     290     UINT nBuffSize =34;
;     291     BYTE pBuffer[34];              
;     292     BYTE hh=0,mm=0,ss=0,DD=0,MM=0,YY=0;  
;     293     i2c_init();   
	SBIW R28,36
	LDI  R24,2
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x2B*2)
	LDI  R31,HIGH(_0x2B*2)
	RCALL __INITLOCB
	RCALL __SAVELOCR6
;	nBuffSize -> R16,R17
;	pBuffer -> Y+8
;	hh -> R18
;	mm -> R19
;	ss -> R20
;	DD -> R21
;	MM -> Y+7
;	YY -> Y+6
	LDI  R16,34
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	LDI  R20,0
	LDI  R21,0
	RCALL _i2c_init
;     294     rtc_get_date(&DD,&MM,&YY);
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R21
	MOVW R30,R28
	ADIW R30,9
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,10
	ST   -Y,R31
	ST   -Y,R30
	RCALL _rtc_get_date
	POP  R21
;     295     rtc_get_time(&hh,&mm,&ss);                              
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R18
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R19
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	RCALL _rtc_get_time
	POP  R20
	POP  R19
	POP  R18
;     296 #ifdef __DUMP_LED_    
;     297     printf("GMT: %02d:%02d:%02d %02d-%02d-%02d\r\n",hh,mm,ss,DD,MM+1,YY);              
	__POINTW1FN _0,100
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R18
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	MOV  R30,R20
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	MOV  R30,R21
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDD  R30,Y+25
	SUBI R30,-LOW(1)
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDD  R30,Y+28
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,24
	RCALL _printf
	ADIW R28,26
;     298 #endif    
;     299     if (DD> 99) DD =0;if (MM> 99) MM =0;if (YY> 99) YY =0;
	CPI  R21,100
	BRLO _0x2C
	LDI  R21,LOW(0)
_0x2C:
	LDD  R26,Y+7
	CPI  R26,LOW(0x64)
	BRLO _0x2D
	LDI  R30,LOW(0)
	STD  Y+7,R30
_0x2D:
	LDD  R26,Y+6
	CPI  R26,LOW(0x64)
	BRLO _0x2E
	LDI  R30,LOW(0)
	STD  Y+6,R30
;     300     if (hh> 99) hh =0;if (mm> 99) mm =0;if (ss> 99) ss =0;                    
_0x2E:
	CPI  R18,100
	BRLO _0x2F
	LDI  R18,LOW(0)
_0x2F:
	CPI  R19,100
	BRLO _0x30
	LDI  R19,LOW(0)
_0x30:
	CPI  R20,100
	BRLO _0x31
	LDI  R20,LOW(0)
;     301     sprintf(pBuffer,    "%02d-%02d-%4d"\
;     302                         "%02d%02d"\
;     303                         "%02d%02d"\
;     304                         "%02d%02d"\
;     305                         "%02d%02d"\
;     306                         "%02d%02d"\
;     307                         "%02d%02d",              
_0x31:
;     308                         DD,MM+1,2000+YY,                                  
;     309                         GetLocalTime(hh,+7),mm,     // HANOI
;     310                         GetLocalTime(hh,-6),mm,     // NEWYORK
;     311                         GetLocalTime(hh,+1),mm,     // PARIS
;     312                         GetLocalTime(hh,+0),mm,     // LONDON
;     313                         GetLocalTime(hh,+3),mm,     // MOSCOW
;     314                         GetLocalTime(hh,+8),mm      // BELJING                        
;     315                         );           
	MOVW R30,R28
	ADIW R30,8
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,137
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R21
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDD  R30,Y+15
	SUBI R30,-LOW(1)
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDD  R30,Y+18
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	RCALL __CWD1
	RCALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(65530)
	LDI  R31,HIGH(65530)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,60
	RCALL _sprintf
	ADIW R28,63
	ADIW R28,1
;     316 #ifdef __DUMP_LED_    
;     317     printf("%s \r\n",pBuffer);
	__POINTW1FN _0,199
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,10
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _printf
	ADIW R28,6
;     318 #endif    
;     319     FormatRTC(pBuffer,nBuffSize);   
	MOVW R30,R28
	ADIW R30,8
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	RCALL _FormatRTC
;     320     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     321     DDRD = 0x3F;  
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     322 }
	RCALL __LOADLOCR6
	ADIW R28,42
	RET
;     323 
;     324 void FormatRTC(PBYTE pBuffer, UINT nBuffSize)
;     325 {                                                  
_FormatRTC:
;     326     UINT i =0;
;     327     BYTE code = 0;                                 
;     328     PBYTE pBuffOut =(PBYTE)START_RAM + SCREEN_WIDTH;                    
;     329 	for (i=0; i< nBuffSize; i++){		
	RCALL __SAVELOCR5
;	*pBuffer -> Y+7
;	nBuffSize -> Y+5
;	i -> R16,R17
;	code -> R18
;	*pBuffOut -> R19,R20
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,LOW(0x568)
	LDI  R20,HIGH(0x568)
	__GETWRN 16,17,0
_0x33:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x34
;     330 		code = pBuffer[nBuffSize- i-1];		
	SUB  R30,R16
	SBC  R31,R17
	SBIW R30,1
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R18,X
;     331 		if (code >='0' && code <='9'){
	CPI  R18,48
	BRLO _0x36
	CPI  R18,58
	BRLO _0x37
_0x36:
	RJMP _0x35
_0x37:
;     332 			code = code & 0x0F;
	ANDI R18,LOW(15)
;     333 		}
;     334 		else if (code ==' '){
	RJMP _0x38
_0x35:
	CPI  R18,32
	BRNE _0x39
;     335 			code = 0x0F;	// blank
	RJMP _0x114
;     336 		}
;     337 		else if (code =='-'){
_0x39:
	CPI  R18,45
	BRNE _0x3B
;     338 			code = 0x0A;	// dash
	LDI  R18,LOW(10)
;     339 		}
;     340 		else if (code =='.'){
	RJMP _0x3C
_0x3B:
	CPI  R18,46
	BRNE _0x3D
;     341 			code = 0x0B;	// dot
	LDI  R18,LOW(11)
;     342 		}
;     343 		else{
	RJMP _0x3E
_0x3D:
;     344 			code = 0x0F;	// blank	
_0x114:
	LDI  R18,LOW(15)
;     345 		}
_0x3E:
_0x3C:
_0x38:
;     346 		pBuffOut[i] = _xtable[code];
	MOVW R26,R16
	ADD  R26,R19
	ADC  R27,R20
	MOV  R30,R18
	LDI  R31,0
	SUBI R30,LOW(-__xtable)
	SBCI R31,HIGH(-__xtable)
	LD   R30,Z
	ST   X,R30
;     347 	}
	__ADDWRN 16,17,1
	RJMP _0x33
_0x34:
;     348 }
	RCALL __LOADLOCR5
	ADIW R28,9
	RET
;     349 
;     350 void SerialToRAM(PBYTE address,WORD length)                                             
;     351 {
_SerialToRAM:
;     352     PBYTE temp = 0;          
;     353     UINT i =0;     				
;     354     temp   = (PBYTE)address;    
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
;     355     LED_STATUS = 0;
	CBI  0x18,4
;     356     for (i =0; i< length; i++) {
	__GETWRN 18,19,0
_0x40:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x41
;     357         *temp++ = getchar();
	PUSH R17
	PUSH R16
	__ADDWRN 16,17,1
	RCALL _getchar
	POP  R26
	POP  R27
	ST   X,R30
;     358         RESET_WATCHDOG();
	WDR
;     359     }                               
	__ADDWRN 18,19,1
	RJMP _0x40
_0x41:
;     360     LED_STATUS = 1;
	SBI  0x18,4
;     361 }
	RCALL __LOADLOCR4
	ADIW R28,8
	RET
;     362 
;     363 void GetCharWidth(WORD length)
;     364 {                               
_GetCharWidth:
;     365     UINT i =0;   
;     366     BYTE devID = EEPROM_DEVICE_FONT;
;     367     PBYTE base  = 0x0A;
;     368     i2c_init();
	RCALL __SAVELOCR5
;	length -> Y+5
;	i -> R16,R17
;	devID -> R18
;	*base -> R19,R20
	LDI  R16,0
	LDI  R17,0
	LDI  R18,160
	LDI  R19,LOW(0x0A)
	LDI  R20,HIGH(0x0A)
	RCALL _i2c_init
;     369     LED_STATUS = 0;              
	CBI  0x18,4
;     370 
;     371     for (i =0; i < length; i++)
	__GETWRN 16,17,0
_0x43:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x44
;     372     {                           
;     373         //char_width[i] = eeprom_read_w(devID,(PBYTE)base+(i<<1));    
;     374         RESET_WATCHDOG();
	WDR
;     375     }                      
	__ADDWRN 16,17,1
	RJMP _0x43
_0x44:
;     376     LED_STATUS = 1;
	SBI  0x18,4
;     377     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     378     DDRD = 0x3F; 
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     379 }
	RCALL __LOADLOCR5
	ADIW R28,7
	RET
;     380 
;     381 void SaveToEEPROM(PBYTE address, WORD length, BYTE index)
;     382 {                             
_SaveToEEPROM:
;     383     PBYTE temp = 0; 
;     384     UINT i =0;     
;     385     BYTE devID = EEPROM_DEVICE_DATA;      				
;     386     temp   = address;   
	RCALL __SAVELOCR5
;	*address -> Y+8
;	length -> Y+6
;	index -> Y+5
;	*temp -> R16,R17
;	i -> R18,R19
;	devID -> R20
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,0
	LDI  R19,0
	LDI  R20,162
	__GETWRS 16,17,8
;     387     if (length%EEPROM_PAGE){
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ANDI R30,LOW(0x3F)
	BREQ _0x45
;     388         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
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
;     389     }                         
;     390     i2c_init();
_0x45:
	RCALL _i2c_init
;     391     LED_STATUS = 0;         
	CBI  0x18,4
;     392     for (i=0; i < length; i++) {           
	__GETWRN 18,19,0
_0x47:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x48
;     393         eeprom_write( devID, (PBYTE)temp+ index*PAGE_SIZE, (BYTE)(*temp));	                             
	ST   -Y,R20
	LDD  R30,Y+6
	LDI  R31,0
	LDI  R26,LOW(384)
	LDI  R27,HIGH(384)
	RCALL __MULW12U
	ADD  R30,R16
	ADC  R31,R17
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R16
	LD   R30,X
	ST   -Y,R30
	RCALL _eeprom_write
;     394         RESET_WATCHDOG();                                                       
	WDR
;     395         temp++;
	__ADDWRN 16,17,1
;     396     }                       
	__ADDWRN 18,19,1
	RJMP _0x47
_0x48:
;     397     LED_STATUS = 1;
	SBI  0x18,4
;     398     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     399     DDRD = 0x3F;    
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     400 }
	RJMP _0x10B
;     401                       
;     402 void LoadToRAM(PBYTE address, WORD length, BYTE index)
;     403 {                         
_LoadToRAM:
;     404     PBYTE temp = 0;  
;     405     UINT i=0;         
;     406     BYTE devID = EEPROM_DEVICE_DATA;		
;     407     temp   = address;                     
	RCALL __SAVELOCR5
;	*address -> Y+8
;	length -> Y+6
;	index -> Y+5
;	*temp -> R16,R17
;	i -> R18,R19
;	devID -> R20
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,0
	LDI  R19,0
	LDI  R20,162
	__GETWRS 16,17,8
;     408     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xEF9)
	LDI  R30,HIGH(0xEF9)
	CPC  R27,R30
	BRLO _0x49
;     409         return; // invalid param
_0x10B:
	RCALL __LOADLOCR5
	ADIW R28,10
	RET
;     410     if (length%EEPROM_PAGE){
_0x49:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ANDI R30,LOW(0x3F)
	BREQ _0x4A
;     411         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
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
;     412     }
;     413     i2c_init();
_0x4A:
	RCALL _i2c_init
;     414     LED_STATUS = 0;             
	CBI  0x18,4
;     415     for (i =0; i <length; i+= EEPROM_PAGE) {                                 
	__GETWRN 18,19,0
_0x4C:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x4D
;     416         eeprom_read_page( devID, (PBYTE)temp+ index*PAGE_SIZE, temp, EEPROM_PAGE );        
	ST   -Y,R20
	LDD  R30,Y+6
	LDI  R31,0
	LDI  R26,LOW(384)
	LDI  R27,HIGH(384)
	RCALL __MULW12U
	ADD  R30,R16
	ADC  R31,R17
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	RCALL _eeprom_read_page
;     417         temp += EEPROM_PAGE;                                
	__ADDWRN 16,17,64
;     418         RESET_WATCHDOG();     
	WDR
;     419     }   
	__ADDWRN 18,19,64
	RJMP _0x4C
_0x4D:
;     420     LED_STATUS = 1; 
	SBI  0x18,4
;     421     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     422     DDRD = 0x3F;  
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     423 }
	RCALL __LOADLOCR5
	ADIW R28,10
	RET
;     424 
;     425 void LoadConfig(BYTE index)
;     426 {   
_LoadConfig:
;     427     BYTE devID = EEPROM_DEVICE_DATA;
;     428     i2c_init();
	ST   -Y,R16
;	index -> Y+1
;	devID -> R16
	LDI  R16,162
	RCALL _i2c_init
;     429     LED_STATUS = 1;                               
	SBI  0x18,4
;     430     scroll_rate = eeprom_read(devID,(PBYTE)index);     
	ST   -Y,R16
	LDD  R30,Y+2
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     431 #ifdef __TEST_LED_
;     432     scroll_rate = 10;
;     433 #endif
;     434 #ifdef __DUMP_LED_
;     435     printf("line=%d rate=%d\r\n",index,scroll_rate);    
	__POINTW1FN _0,205
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+3
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDS  R30,_scroll_rate_G1
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,8
	RCALL _printf
	ADIW R28,10
;     436 #endif
;     437     LED_STATUS = 0; 
	CBI  0x18,4
;     438     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     439     DDRD = 0x3F;   
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     440 }
	RJMP _0x10A
;     441 
;     442 void SaveConfig(BYTE index)
;     443 {     
_SaveConfig:
;     444     BYTE devID = EEPROM_DEVICE_DATA;
;     445     i2c_init();
	ST   -Y,R16
;	index -> Y+1
;	devID -> R16
	LDI  R16,162
	RCALL _i2c_init
;     446     LED_STATUS = 1;  
	SBI  0x18,4
;     447     eeprom_write(devID,(PBYTE)index,scroll_rate);   
	ST   -Y,R16
	LDD  R30,Y+2
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_scroll_rate_G1
	ST   -Y,R30
	RCALL _eeprom_write
;     448     LED_STATUS = 0; 
	CBI  0x18,4
;     449     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     450     DDRD = 0x3F;   
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     451 }
_0x10A:
	LDD  R16,Y+0
	ADIW R28,2
	RET
;     452 
;     453 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     454 {        
_BlankRAM:
;     455     PBYTE temp = START_RAM;
;     456     for (temp = start_addr; temp<= end_addr; temp++)    
	RCALL __SAVELOCR2
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*temp -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x4F:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x50
;     457         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     458 }
	__ADDWRN 16,17,1
	RJMP _0x4F
_0x50:
	RCALL __LOADLOCR2
	ADIW R28,6
	RET
;     459 
;     460 void SetRTCDateTime()
;     461 {
_SetRTCDateTime:
;     462     i2c_init();
	RCALL _i2c_init
;     463     LED_STATUS = 0;   
	CBI  0x18,4
;     464     rtc_set_time(0,0,0);    /* clear CH bit */
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	ST   -Y,R30
	RCALL _rtc_set_time
;     465     rtc_set_date(getchar(),getchar(),getchar());
	RCALL _getchar
	ST   -Y,R30
	RCALL _getchar
	ST   -Y,R30
	RCALL _getchar
	ST   -Y,R30
	RCALL _rtc_set_date
;     466     rtc_set_time(getchar(),getchar(),getchar());    
	RCALL _getchar
	ST   -Y,R30
	RCALL _getchar
	ST   -Y,R30
	RCALL _getchar
	ST   -Y,R30
	RCALL _rtc_set_time
;     467     LED_STATUS = 1;
	SBI  0x18,4
;     468     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     469     DDRD = 0x3F; 
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     470 }
	RET
;     471 
;     472 static void TextFromFont(char *szText, BYTE nColor, BYTE bGradient, PBYTE pBuffer, BYTE index)
;     473 {
_TextFromFont_G1:
;     474 	int pos = 0,x=0,y=0;     
;     475 	BYTE i =0, len;
;     476 	BYTE ch = 0;
;     477 	UINT nWidth = 0;   
;     478 	UINT nCurWidth = 0, nNxtWidth = 0;		
;     479     BYTE mask = 0x00, data = 0;
;     480 	BYTE mask_clr[2] = {0x00};
;     481     BYTE devID = EEPROM_DEVICE_FONT;
;     482     	
;     483 	switch (nColor)
	SBIW R28,14
	LDI  R24,14
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x51*2)
	LDI  R31,HIGH(_0x51*2)
	RCALL __INITLOCB
	RCALL __SAVELOCR6
;	*szText -> Y+25
;	nColor -> Y+24
;	bGradient -> Y+23
;	*pBuffer -> Y+21
;	index -> Y+20
;	pos -> R16,R17
;	x -> R18,R19
;	y -> R20,R21
;	i -> Y+19
;	len -> Y+18
;	ch -> Y+17
;	nWidth -> Y+15
;	nCurWidth -> Y+13
;	nNxtWidth -> Y+11
;	mask -> Y+10
;	data -> Y+9
;	mask_clr -> Y+7
;	devID -> Y+6
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	LDI  R20,0
	LDI  R21,0
	LDD  R30,Y+24
;     484 	{
;     485 	case 0:
	CPI  R30,0
	BRNE _0x55
;     486 		mask = 0xFF;		// BLANK
	LDI  R30,LOW(255)
	STD  Y+10,R30
;     487 		mask_clr[0] = 0xFF;
	STD  Y+7,R30
;     488 		mask_clr[1] = 0xFF;
	STD  Y+8,R30
;     489 		break;
	RJMP _0x54
;     490 	case 1:
_0x55:
	CPI  R30,LOW(0x1)
	BRNE _0x56
;     491 		mask = 0xAA;		// RED			RRRR	
	LDI  R30,LOW(170)
	STD  Y+10,R30
;     492 		mask_clr[0] = 0x99;	// GREEN		RGRG
	LDI  R30,LOW(153)
	STD  Y+7,R30
;     493 		mask_clr[1] = 0x88;	// YELLOW		RYRY
	LDI  R30,LOW(136)
	STD  Y+8,R30
;     494 		break;
	RJMP _0x54
;     495 	case 2:
_0x56:
	CPI  R30,LOW(0x2)
	BRNE _0x57
;     496 		mask = 0x55;		// GREEN		GGGG
	LDI  R30,LOW(85)
	STD  Y+10,R30
;     497 		mask_clr[0] = 0x44;	// YELLOW		GYGY
	LDI  R30,LOW(68)
	STD  Y+7,R30
;     498 		mask_clr[1] = 0x66;	// RED			GRGR	
	LDI  R30,LOW(102)
	STD  Y+8,R30
;     499 		break;
	RJMP _0x54
;     500 	case 3:
_0x57:
	CPI  R30,LOW(0x3)
	BRNE _0x59
;     501 		mask = 0x00;		// YELLOW		YYYY
	LDI  R30,LOW(0)
	STD  Y+10,R30
;     502 		mask_clr[0] = 0x22;	// RED			YRYR	
	LDI  R30,LOW(34)
	STD  Y+7,R30
;     503 		mask_clr[1] = 0x11;	// GREEN		YGYG
	LDI  R30,LOW(17)
	STD  Y+8,R30
;     504 		break;
;     505 	default:
_0x59:
;     506 		break;
;     507 	}	
_0x54:
;     508                                
;     509 	LED_STATUS = 0;
	CBI  0x18,4
;     510 	i2c_init();
	RCALL _i2c_init
;     511 	len = strlen(szText);      
	LDD  R30,Y+25
	LDD  R31,Y+25+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _strlen
	STD  Y+18,R30
;     512 	if (len > MAX_TITLE){
	LDD  R26,Y+18
	CPI  R26,LOW(0x15)
	BRLO _0x5A
;     513 	    len = MAX_TITLE;
	LDI  R30,LOW(20)
	STD  Y+18,R30
;     514 	}
;     515 	for (i=0; i< len; i++){				                                     
_0x5A:
	LDI  R30,LOW(0)
	STD  Y+19,R30
_0x5C:
	LDD  R30,Y+18
	LDD  R26,Y+19
	CP   R26,R30
	BRLO PC+2
	RJMP _0x5D
;     516         ch = szText[i];             
	LDD  R30,Y+19
	LDD  R26,Y+25
	LDD  R27,Y+25+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	STD  Y+17,R30
;     517 		//nCurWidth = char_width[ch];
;     518 		//nNxtWidth = char_width[ch+1];    		
;     519 		nCurWidth = eeprom_read_w(devID,(PBYTE)0x0A+(ch<<1));    
	LDD  R30,Y+6
	ST   -Y,R30
	LDD  R30,Y+18
	LSL  R30
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read_w
	STD  Y+13,R30
	STD  Y+13+1,R31
;     520 		nNxtWidth = eeprom_read_w(devID,(PBYTE)0x0A+((ch+1)<<1));    
	LDD  R30,Y+6
	ST   -Y,R30
	LDD  R26,Y+18
	SUBI R26,-LOW(1)
	MOV  R30,R26
	LSL  R30
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read_w
	STD  Y+11,R30
	STD  Y+11+1,R31
;     521 		nWidth = (nNxtWidth - nCurWidth); 		
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+15,R30
	STD  Y+15+1,R31
;     522 		if ((pos + nWidth) >= SCREEN_WIDTH)  break;		
	ADD  R30,R16
	ADC  R31,R17
	CPI  R30,LOW(0x68)
	LDI  R26,HIGH(0x68)
	CPC  R31,R26
	BRLO _0x5E
	RJMP _0x5D
;     523 		for (y=0; y< 8 ; y++){    		            
_0x5E:
	__GETWRN 20,21,0
_0x60:
	__CPWRN 20,21,8
	BRLT PC+2
	RJMP _0x61
;     524 		    if (bGradient) {
	LDD  R30,Y+23
	CPI  R30,0
	BREQ _0x62
;     525 				if (y >=0 && y <4)	mask = mask_clr[0];
	SUBI R20,0
	SBCI R21,0
	BRLT _0x64
	__CPWRN 20,21,4
	BRLT _0x65
_0x64:
	RJMP _0x63
_0x65:
	LDD  R30,Y+7
	STD  Y+10,R30
;     526 				if (y >=4 && y <8)	mask = mask_clr[1];	
_0x63:
	__CPWRN 20,21,4
	BRLT _0x67
	__CPWRN 20,21,8
	BRLT _0x68
_0x67:
	RJMP _0x66
_0x68:
	LDD  R30,Y+8
	STD  Y+10,R30
;     527 			}			
_0x66:
;     528 			for (x=0; x< nWidth; x++){                                 
_0x62:
	__GETWRN 18,19,0
_0x6A:
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x6B
;     529 			    RESET_WATCHDOG();       
	WDR
;     530 			    data = eeprom_read(devID, (PBYTE)(START_RAM + 8*SCREEN_WIDTH + SCREEN_WIDTH) + (y*DATA_LENGTH + nCurWidth + x));
	LDD  R30,Y+6
	ST   -Y,R30
	MOVW R26,R20
	LDI  R30,LOW(3832)
	LDI  R31,HIGH(3832)
	RCALL __MULW12
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	ADD  R30,R26
	ADC  R31,R27
	ADD  R30,R18
	ADC  R31,R19
	SUBI R30,LOW(-2216)
	SBCI R31,HIGH(-2216)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _eeprom_read
	STD  Y+9,R30
;     531 			    data = (~data) & (~mask); 
	COM  R30
	MOV  R26,R30
	LDD  R30,Y+10
	COM  R30
	AND  R30,R26
	STD  Y+9,R30
;     532    				pBuffer[y*DATA_LENGTH + x + pos] = ~data;   				
	MOVW R26,R20
	LDI  R30,LOW(3832)
	LDI  R31,HIGH(3832)
	RCALL __MULW12
	ADD  R30,R18
	ADC  R31,R19
	ADD  R30,R16
	ADC  R31,R17
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+9
	COM  R30
	ST   X,R30
;     533 			}					
	__ADDWRN 18,19,1
	RJMP _0x6A
_0x6B:
;     534 		}
	__ADDWRN 20,21,1
	RJMP _0x60
_0x61:
;     535 		pos += nWidth;	 		
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	__ADDWRR 16,17,30,31
;     536 	}
	LDD  R30,Y+19
	SUBI R30,-LOW(1)
	STD  Y+19,R30
	RJMP _0x5C
_0x5D:
;     537     
;     538     text_length = pos;    
	__PUTWMRN _text_length_G1,0,16,17
;     539     LED_STATUS = 1;
	SBI  0x18,4
;     540     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     541     DDRD = 0x3F;     
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     542 }
	RCALL __LOADLOCR6
	ADIW R28,27
	RET
;     543         
;     544 void LoadPage()
;     545 {                         
_LoadPage:
;     546     if (++page_index >= MAX_PAGE){
	LDS  R26,_page_index_G1
	SUBI R26,-LOW(1)
	STS  _page_index_G1,R26
	CPI  R26,LOW(0x5)
	BRLO _0x6C
;     547         page_index = 0;
	LDI  R30,LOW(0)
	STS  _page_index_G1,R30
;     548     }                   
;     549     _powerOff();          
_0x6C:
	RCALL __powerOff_G1
;     550     LoadConfig(page_index);       
	LDS  R30,_page_index_G1
	ST   -Y,R30
	RCALL _LoadConfig
;     551     if (scroll_rate ==0){
	LDS  R30,_scroll_rate_G1
	CPI  R30,0
	BRNE _0x6D
;     552         return;
	RET
;     553     } 
;     554     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);                
_0x6D:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     555     LoadToRAM((PBYTE)START_RAM+SCREEN_WIDTH,PAGE_SIZE,page_index);                 
	LDI  R30,LOW(1384)
	LDI  R31,HIGH(1384)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(384)
	LDI  R31,HIGH(384)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_page_index_G1
	ST   -Y,R30
	RCALL _LoadToRAM
;     556     GetCharWidth(255);                                            
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _GetCharWidth
;     557 #ifndef __OWN_TITLE_
;     558     TextFromFont((char*)szTitle[page_index],1,0,(PBYTE)START_RAM,0);
;     559 #else
;     560     TextFromFont((char*)(START_RAM+SCREEN_WIDTH+MAX_LED),1,0,(PBYTE)START_RAM,0);     
	LDI  R30,LOW(1701)
	LDI  R31,HIGH(1701)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R30
	RCALL _TextFromFont_G1
;     561 #endif                                                  
;     562     GetRTCBuffer();
	RCALL _GetRTCBuffer
;     563     _displayLED();                  
	RCALL __displayLED_G1
;     564         
;     565 #ifdef __DUMP_LED_     
;     566 {         
;     567     UINT i=0;
;     568     PBYTE temp = 0;
;     569     temp   =(PBYTE)START_RAM+SCREEN_WIDTH;
	SBIW R28,4
	LDI  R24,4
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x6E*2)
	LDI  R31,HIGH(_0x6E*2)
	RCALL __INITLOCB
;	i -> Y+2
;	*temp -> Y+0
	LDI  R30,LOW(1384)
	LDI  R31,HIGH(1384)
	ST   Y,R30
	STD  Y+1,R31
;     570     for (i =0; i <MAX_LED; i++) {
	LDI  R30,0
	STD  Y+2,R30
	STD  Y+2+1,R30
_0x70:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x13D)
	LDI  R30,HIGH(0x13D)
	CPC  R27,R30
	BRSH _0x71
;     571         printf("%02X ",*temp);
	__POINTW1FN _0,223
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R30,X
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _printf
	ADIW R28,6
;     572         temp++;
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,1
	ST   Y,R30
	STD  Y+1,R31
;     573     }               
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,1
	STD  Y+2,R30
	STD  Y+2+1,R31
	RJMP _0x70
_0x71:
;     574     printf("%s \r\n",(char*)(START_RAM+SCREEN_WIDTH+MAX_LED));
	__POINTW1FN _0,199
	ST   -Y,R31
	ST   -Y,R30
	__GETD1N 0x6A5
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _printf
	ADIW R28,6
;     575 }
	ADIW R28,4
;     576 #endif 
;     577     start_mem = (PBYTE)START_RAM;
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     578     reset_serial();    
	RCALL _reset_serial
;     579 }
	RET
;     580 
;     581 ///////////////////////////////////////////////////////////////
;     582 // END static function(s)
;     583 ///////////////////////////////////////////////////////////////
;     584 
;     585 ///////////////////////////////////////////////////////////////           
;     586 
;     587 void InitDevice()
;     588 {
_InitDevice:
;     589 // Declare your local variables here
;     590 // Crystal Oscillator division factor: 1  
;     591 #ifdef _MEGA162_INCLUDED_ 
;     592 #pragma optsize-
;     593 CLKPR=0x80;
;     594 CLKPR=0x00;
;     595 #ifdef _OPTIMIZE_SIZE_
;     596 #pragma optsize+
;     597 #endif                    
;     598 #endif
;     599 
;     600 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;     601 DDRA=0x00;
	OUT  0x1A,R30
;     602 
;     603 PORTB=0x00;
	OUT  0x18,R30
;     604 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     605 
;     606 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     607 DDRC=0x00;
	OUT  0x14,R30
;     608 
;     609 PORTD = 0x00;
	OUT  0x12,R30
;     610 DDRD = 0x00;
	OUT  0x11,R30
;     611 
;     612 PORTE=0x00;
	OUT  0x7,R30
;     613 DDRE=0x05;
	LDI  R30,LOW(5)
	OUT  0x6,R30
;     614 
;     615 TCCR0=0x03; 
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     616 TCNT0=0x05; 
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     617 OCR0=0x00;  
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     618 
;     619 UCSRA=0x00;
	OUT  0xB,R30
;     620 UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     621 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     622 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     623 UBRRL=0x67;
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     624 
;     625 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     626 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     627 
;     628 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     629 
;     630 // I2C Bus initialization
;     631 i2c_init();
	RCALL _i2c_init
;     632 
;     633 // DS1307 Real Time Clock initialization
;     634 // Square wave output on pin SQW/OUT: Off
;     635 // SQW/OUT pin state: 1
;     636 rtc_init(0,0,1);   
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _rtc_init
;     637 
;     638 #ifdef __WATCH_DOG_
;     639 //WDTCR=0x1F;
;     640 //WDTCR=0x0F;
;     641 #endif 
;     642     printf("                                          \r\n");
	__POINTW1FN _0,229
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     643     printf("|=========================================|\r\n");
	__POINTW1FN _0,274
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     644     printf("|      DigiLED AVR Firmware v1.0.0        |\r\n");
	__POINTW1FN _0,320
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     645     printf("|_________________________________________|\r\n");
	__POINTW1FN _0,366
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     646     printf("|        Copyright by CuongQuay           |\r\n");  
	__POINTW1FN _0,412
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     647     printf("|    cuong3ihut@yahoo.com - 0915651001    |\r\n");
	__POINTW1FN _0,458
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     648     printf("|       Started date: 24.05.2007          |\r\n");
	__POINTW1FN _0,504
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     649     printf("|       Release date: 23.06.2007          |\r\n");
	__POINTW1FN _0,550
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     650     printf("|_________________________________________|\r\n");              
	__POINTW1FN _0,366
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     651     printf("                                          \r\n");    
	__POINTW1FN _0,229
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
;     652     RESET_WATCHDOG();
	WDR
;     653 #ifdef __TEST_RTC_
;     654 {                                
;     655     BYTE hh=0,mm=0,ss=0,DD=0,MM=0,YY=0;
;     656     rtc_get_date(&DD,&MM,&YY);
	SBIW R28,6
	LDI  R24,6
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x72*2)
	LDI  R31,HIGH(_0x72*2)
	RCALL __INITLOCB
;	hh -> Y+5
;	mm -> Y+4
;	ss -> Y+3
;	DD -> Y+2
;	MM -> Y+1
;	YY -> Y+0
	MOVW R30,R28
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,3
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	RCALL _rtc_get_date
;     657     rtc_get_time(&hh,&mm,&ss);
	MOVW R30,R28
	ADIW R30,5
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,7
	ST   -Y,R31
	ST   -Y,R30
	RCALL _rtc_get_time
;     658     printf("DS1307 GMT: %02d:%02d:%02d %02d-%02d-%02d\r\n",hh,mm,ss,DD,MM,YY);
	__POINTW1FN _0,596
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDD  R30,Y+10
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDD  R30,Y+13
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDD  R30,Y+16
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDD  R30,Y+19
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDD  R30,Y+22
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,24
	RCALL _printf
	ADIW R28,26
;     659 }           
	ADIW R28,6
;     660 #endif    
;     661     RESET_WATCHDOG();               
	WDR
;     662 }
	RET
;     663 
;     664 void PowerReset()
;     665 {   
_PowerReset:
;     666     start_mem = (PBYTE)START_RAM;     
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     667     end_mem   = (PBYTE)END_RAM;
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	STS  _end_mem_G1,R30
	STS  _end_mem_G1+1,R31
;     668     org_mem   = (PBYTE)START_RAM;	                   
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _org_mem_G1,R30
	STS  _org_mem_G1+1,R31
;     669 
;     670     InitDevice();
	RCALL _InitDevice
;     671                      
;     672     LED_STATUS = 0;
	CBI  0x18,4
;     673     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);    
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     674     delay_ms(500);
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     675     LED_STATUS = 1;
	SBI  0x18,4
;     676         
;     677     LED_STATUS = 0;  
	CBI  0x18,4
;     678     page_index = 0; 
	LDI  R30,LOW(0)
	STS  _page_index_G1,R30
;     679     LoadPage();        
	RCALL _LoadPage
;     680     LED_STATUS = 1;             
	SBI  0x18,4
;     681                        
;     682     // reload configuration
;     683     LED_STATUS = 0;
	CBI  0x18,4
;     684     delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     685     LED_STATUS = 1;  
	SBI  0x18,4
;     686     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     687     DDRD = 0x3F;      
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     688 }
	RET
;     689 
;     690 void ProcessCommand()
;     691 {
_ProcessCommand:
;     692    	#asm("cli"); 
	cli
;     693     RESET_WATCHDOG();
	WDR
;     694     // Turn off the scan board           
;     695     _powerOff();
	RCALL __powerOff_G1
;     696     // serial message processing     
;     697     switch (rx_message)
	MOV  R30,R8
;     698     {                  
;     699     case LOAD_DATA_MSG:
	CPI  R30,LOW(0x1)
	BRNE _0x76
;     700         {       
;     701             if (rx_wparam > DATA_LENGTH) rx_wparam = DATA_LENGTH;
	LDI  R30,LOW(3832)
	LDI  R31,HIGH(3832)
	CP   R30,R9
	CPC  R31,R10
	BRSH _0x77
	__PUTW1R 9,10
;     702             BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
_0x77:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     703             page_index = rx_wparam>>8; 
	STS  _page_index_G1,R10
;     704             scroll_rate = rx_wparam&0x00FF;                                   
	__GETW1R 9,10
	STS  _scroll_rate_G1,R30
;     705             text_length = rx_lparam;                     
	__PUTWMRN _text_length_G1,0,11,12
;     706             SerialToRAM((PBYTE)START_RAM+SCREEN_WIDTH,text_length);                
	LDI  R30,LOW(1384)
	LDI  R31,HIGH(1384)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _SerialToRAM
;     707             start_mem = (PBYTE)START_RAM;
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     708             SaveConfig(page_index);					    		    		    	
	LDS  R30,_page_index_G1
	ST   -Y,R30
	RCALL _SaveConfig
;     709             SaveToEEPROM((PBYTE)START_RAM+SCREEN_WIDTH,PAGE_SIZE,page_index);            
	LDI  R30,LOW(1384)
	LDI  R31,HIGH(1384)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(384)
	LDI  R31,HIGH(384)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_page_index_G1
	ST   -Y,R30
	RCALL _SaveToEEPROM
;     710         }				
;     711         break;   
	RJMP _0x75
;     712     case LOAD_CONFIG_MSG:
_0x76:
	CPI  R30,LOW(0x2)
	BRNE _0x78
;     713         {    
;     714             page_index = rx_wparam>>8;
	STS  _page_index_G1,R10
;     715             scroll_rate = rx_wparam&0x00FF;             
	__GETW1R 9,10
	STS  _scroll_rate_G1,R30
;     716             SaveConfig(page_index);
	LDS  R30,_page_index_G1
	ST   -Y,R30
	RCALL _SaveConfig
;     717         }
;     718         break;       
	RJMP _0x75
;     719     case SET_RTC_MSG:
_0x78:
	CPI  R30,LOW(0x3)
	BRNE _0x7A
;     720         {                                
;     721             SetRTCDateTime();
	RCALL _SetRTCDateTime
;     722         }
;     723         break;    
;     724     default:
_0x7A:
;     725         break;
;     726     }                 
_0x75:
;     727     send_echo_msg();            
	RCALL _send_echo_msg
;     728     rx_message = UNKNOWN_MSG;
	CLR  R8
;     729     #asm("sei");
	sei
;     730     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     731     DDRD = 0x3F;     
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     732 
;     733 }          
	RET
;     734 ////////////////////////////////////////////////////////////////////////////////
;     735 // MAIN PROGRAM
;     736 ////////////////////////////////////////////////////////////////////////////////
;     737 void main(void)
;     738 {         
_main:
;     739     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x7B
;     740         // Watchdog Reset
;     741         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     742         reset_serial(); 
	RCALL _reset_serial
;     743     }
;     744     else {      
	RJMP _0x7C
_0x7B:
;     745         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     746     }                                     
_0x7C:
;     747      
;     748     PowerReset();                        
	RCALL _PowerReset
;     749     #asm("sei");     
	sei
;     750             
;     751     while (1){                     
_0x7D:
;     752         if (rx_message != UNKNOWN_MSG){   
	TST  R8
	BREQ _0x80
;     753             ProcessCommand();   
	RCALL _ProcessCommand
;     754         }
;     755         else{               
	RJMP _0x81
_0x80:
;     756             _doPaging();
	RCALL __doPaging_G1
;     757             _displayFrame();                        
	RCALL __displayFrame_G1
;     758         }
_0x81:
;     759         RESET_WATCHDOG();
	WDR
;     760     }
	RJMP _0x7D
;     761 }
_0x82:
	NOP
	RJMP _0x82
;     762                          
;     763 #include "define.h"
;     764 
;     765 ///////////////////////////////////////////////////////////////
;     766 // serial interrupt handle - processing serial message ...
;     767 ///////////////////////////////////////////////////////////////
;     768 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     769 ///////////////////////////////////////////////////////////////
;     770 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     771 extern BYTE  rx_message;
;     772 extern WORD  rx_wparam;
;     773 extern WORD  rx_lparam;
;     774 
;     775 #if RX_BUFFER_SIZE<256
;     776 unsigned char rx_wr_index,rx_counter;
;     777 #else
;     778 unsigned int rx_wr_index,rx_counter;
;     779 #endif
;     780 
;     781 void send_echo_msg();
;     782 
;     783 // USART Receiver interrupt service routine
;     784 #ifdef _MEGA162_INCLUDED_                    
;     785 interrupt [USART0_RXC] void usart_rx_isr(void)
;     786 #else
;     787 interrupt [USART_RXC] void usart_rx_isr(void)
;     788 #endif
;     789 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     790 char status,data;
;     791 #ifdef _MEGA162_INCLUDED_  
;     792 status=UCSR0A;
;     793 data=UDR0;
;     794 #else     
;     795 status=UCSRA;
	RCALL __SAVELOCR2
;	status -> R16
;	data -> R17
	IN   R16,11
;     796 data=UDR;
	IN   R17,12
;     797 #endif          
;     798     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+2
	RJMP _0x83
;     799     {
;     800         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R13
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;     801         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0x84
	CLR  R13
;     802         if (++rx_counter == RX_BUFFER_SIZE)
_0x84:
	INC  R14
	LDI  R30,LOW(8)
	CP   R30,R14
	BRNE _0x85
;     803         {
;     804             rx_counter=0;
	CLR  R14
;     805             if (
;     806                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;     807                 rx_buffer[2]==WAKEUP_CHAR 
;     808                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xAA)
	BRNE _0x87
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xAA)
	BRNE _0x87
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xAA)
	BREQ _0x88
_0x87:
	RJMP _0x86
_0x88:
;     809             {
;     810                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 8,_rx_buffer,3
;     811                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 9,_rx_buffer,4
	CLR  R10
;     812                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R9
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 9,10
;     813                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 11,_rx_buffer,6
	CLR  R12
;     814                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;     815             }
;     816             else if(
	RJMP _0x89
_0x86:
;     817                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;     818                 rx_buffer[2]==ESCAPE_CHAR 
;     819                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0x8B
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0x8B
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0x8C
_0x8B:
	RJMP _0x8A
_0x8C:
;     820             {
;     821                 rx_wr_index=0;
	CLR  R13
;     822                 rx_counter =0;
	CLR  R14
;     823             }      
;     824         };
_0x8A:
_0x89:
_0x85:
;     825     };
_0x83:
;     826 }
	RCALL __LOADLOCR2P
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     827 
;     828 void send_echo_msg()
;     829 {
_send_echo_msg:
;     830     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(170)
	ST   -Y,R30
	RCALL _putchar
;     831     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(170)
	ST   -Y,R30
	RCALL _putchar
;     832     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(170)
	ST   -Y,R30
	RCALL _putchar
;     833     putchar(rx_message);
	ST   -Y,R8
	RCALL _putchar
;     834     putchar(rx_wparam>>8);
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _putchar
;     835     putchar(rx_wparam&0x00FF);
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _putchar
;     836     putchar(rx_lparam>>8);        
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _putchar
;     837     putchar(rx_lparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _putchar
;     838 }  
	RET
;     839 
;     840 void reset_serial()
;     841 {
_reset_serial:
;     842     rx_wr_index=0;
	CLR  R13
;     843     rx_counter =0;
	CLR  R14
;     844     rx_message = UNKNOWN_MSG;
	CLR  R8
;     845 }
	RET
;     846 
;     847 ///////////////////////////////////////////////////////////////
;     848 // END serial interrupt handle
;     849 /////////////////////////////////////////////////////////////// 
;     850 /*****************************************************
;     851 This program was produced by the
;     852 CodeWizardAVR V1.24.4a Standard
;     853 Automatic Program Generator
;     854 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;     855 http://www.hpinfotech.com
;     856 e-mail:office@hpinfotech.com
;     857 
;     858 Project : 
;     859 Version : 
;     860 Date    : 19/5/2005
;     861 Author  : 3iGROUP                
;     862 Company : http://www.3ihut.net   
;     863 Comments: 
;     864 
;     865 
;     866 Chip type           : ATmega8515
;     867 Program type        : Application
;     868 Clock frequency     : 8.000000 MHz
;     869 Memory model        : Small
;     870 External SRAM size  : 32768
;     871 Ext. SRAM wait state: 0
;     872 Data Stack size     : 128
;     873 *****************************************************/
;     874 
;     875 #include "define.h"                                           
;     876 
;     877 #define     ACK                 1
;     878 #define     NO_ACK              0
;     879 
;     880 // I2C Bus functions
;     881 #asm
;     882    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;     883    .equ __sda_bit=3
   .equ __sda_bit=3
;     884    .equ __scl_bit=2
   .equ __scl_bit=2
;     885 #endasm                   
;     886 
;     887 #ifdef __EEPROM_WRITE_BYTE
;     888 BYTE eeprom_read(BYTE deviceID, PBYTE address) 
;     889 {
_eeprom_read:
;     890     BYTE data;
;     891     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	*address -> Y+1
;	data -> R16
	RCALL _i2c_start
;     892     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	RCALL _i2c_write
;     893     i2c_write((WORD)address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     894     i2c_write((WORD)address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     895     
;     896     i2c_start();
	RCALL _i2c_start
;     897     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	RCALL _i2c_write
;     898     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _i2c_read
	MOV  R16,R30
;     899     i2c_stop();
	RCALL _i2c_stop
;     900     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0x109
;     901 }
;     902 
;     903 void eeprom_write(BYTE deviceID, PBYTE address, BYTE data) 
;     904 {
_eeprom_write:
;     905     i2c_start();
;	deviceID -> Y+3
;	*address -> Y+1
;	data -> Y+0
	RCALL _i2c_start
;     906     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	RCALL _i2c_write
;     907     i2c_write((WORD)address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     908     i2c_write((WORD)address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     909     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	RCALL _i2c_write
;     910     i2c_stop();
	RCALL _i2c_stop
;     911 
;     912     /* 10ms delay to complete the write operation */
;     913     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
;     914 }                                 
_0x109:
	ADIW R28,4
	RET
;     915 
;     916 WORD eeprom_read_w(BYTE deviceID, PBYTE address)
;     917 {
_eeprom_read_w:
;     918     WORD result = 0;
;     919     result = eeprom_read(deviceID,address);
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
;     920     result = (result<<8) | eeprom_read(deviceID,address+1);
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
;     921     return result;
	MOVW R30,R16
	RCALL __LOADLOCR2
	ADIW R28,5
	RET
;     922 }
;     923 void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data)
;     924 {
;     925     eeprom_write(deviceID,address,data>>8);
;	deviceID -> Y+4
;	*address -> Y+2
;	data -> Y+0
;     926     eeprom_write(deviceID,address+1,data&0x0FF);    
;     927 }
;     928 
;     929 #endif // __EEPROM_WRITE_BYTE
;     930 void eeprom_read_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
;     931 {
_eeprom_read_page:
;     932     BYTE i = 0;
;     933     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	*address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	RCALL _i2c_start
;     934     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	RCALL _i2c_write
;     935     i2c_write((WORD)address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	RCALL _i2c_write
;     936     i2c_write((WORD)address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	RCALL _i2c_write
;     937     
;     938     i2c_start();
	RCALL _i2c_start
;     939     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	RCALL _i2c_write
;     940                                     
;     941     while ( i < page_size-1 )
_0x8D:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0x8F
;     942     {
;     943         buffer[i++] = i2c_read(ACK);   // read at current
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
;     944     }
	RJMP _0x8D
_0x8F:
;     945     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
;     946          
;     947     i2c_stop();
	RCALL _i2c_stop
;     948 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     949 
;     950 void eeprom_write_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
;     951 {
;     952     BYTE i = 0;
;     953     i2c_start();
;	deviceID -> Y+6
;	*address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
;     954     i2c_write(deviceID);            // issued R/W = 0
;     955     i2c_write((WORD)address>>8);          // high word address
;     956     i2c_write((WORD)address&0xFF);        // low word address
;     957                                         
;     958     while ( i < page_size )
;     959     {
;     960         i2c_write(buffer[i++]);
;     961         #asm("nop");#asm("nop");
;     962     }          
;     963     i2c_stop(); 
;     964     delay_ms(10);
;     965 }
;     966                                               

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
	BREQ _0x93
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0x94
_0x93:
	LDD  R30,Y+2
	ST   -Y,R30
	RCALL _putchar
_0x94:
	RJMP _0x106
__print_G4:
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R16,0
_0x95:
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
	RJMP _0x97
	MOV  R30,R16
	CPI  R30,0
	BRNE _0x9B
	CPI  R19,37
	BRNE _0x9C
	LDI  R16,LOW(1)
	RJMP _0x9D
_0x9C:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
_0x9D:
	RJMP _0x9A
_0x9B:
	CPI  R30,LOW(0x1)
	BRNE _0x9E
	CPI  R19,37
	BRNE _0x9F
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0x115
_0x9F:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0xA0
	LDI  R17,LOW(1)
	RJMP _0x9A
_0xA0:
	CPI  R19,43
	BRNE _0xA1
	LDI  R21,LOW(43)
	RJMP _0x9A
_0xA1:
	CPI  R19,32
	BRNE _0xA2
	LDI  R21,LOW(32)
	RJMP _0x9A
_0xA2:
	RJMP _0xA3
_0x9E:
	CPI  R30,LOW(0x2)
	BRNE _0xA4
_0xA3:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0xA5
	ORI  R17,LOW(128)
	RJMP _0x9A
_0xA5:
	RJMP _0xA6
_0xA4:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x9A
_0xA6:
	CPI  R19,48
	BRLO _0xA9
	CPI  R19,58
	BRLO _0xAA
_0xA9:
	RJMP _0xA8
_0xAA:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x9A
_0xA8:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0xAE
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
	RJMP _0xAF
_0xAE:
	CPI  R30,LOW(0x73)
	BRNE _0xB1
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
	RJMP _0xB2
_0xB1:
	CPI  R30,LOW(0x70)
	BRNE _0xB4
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
_0xB2:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0xB5
_0xB4:
	CPI  R30,LOW(0x64)
	BREQ _0xB8
	CPI  R30,LOW(0x69)
	BRNE _0xB9
_0xB8:
	ORI  R17,LOW(4)
	RJMP _0xBA
_0xB9:
	CPI  R30,LOW(0x75)
	BRNE _0xBB
_0xBA:
	LDI  R30,LOW(_tbl10_G4*2)
	LDI  R31,HIGH(_tbl10_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0xBC
_0xBB:
	CPI  R30,LOW(0x58)
	BRNE _0xBE
	ORI  R17,LOW(8)
	RJMP _0xBF
_0xBE:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0xF0
_0xBF:
	LDI  R30,LOW(_tbl16_G4*2)
	LDI  R31,HIGH(_tbl16_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0xBC:
	SBRS R17,2
	RJMP _0xC1
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
	BRGE _0xC2
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0xC2:
	CPI  R21,0
	BREQ _0xC3
	SUBI R16,-LOW(1)
	RJMP _0xC4
_0xC3:
	ANDI R17,LOW(251)
_0xC4:
	RJMP _0xC5
_0xC1:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0xC5:
_0xB5:
	SBRC R17,0
	RJMP _0xC6
_0xC7:
	CP   R16,R20
	BRSH _0xC9
	SBRS R17,7
	RJMP _0xCA
	SBRS R17,2
	RJMP _0xCB
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0xCC
_0xCB:
	LDI  R19,LOW(48)
_0xCC:
	RJMP _0xCD
_0xCA:
	LDI  R19,LOW(32)
_0xCD:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	SUBI R20,LOW(1)
	RJMP _0xC7
_0xC9:
_0xC6:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0xCE
_0xCF:
	CPI  R18,0
	BREQ _0xD1
	SBRS R17,3
	RJMP _0xD2
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x116
_0xD2:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x116:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xD4
	SUBI R20,LOW(1)
_0xD4:
	SUBI R18,LOW(1)
	RJMP _0xCF
_0xD1:
	RJMP _0xD5
_0xCE:
_0xD7:
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
_0xD9:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0xDB
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0xD9
_0xDB:
	CPI  R19,58
	BRLO _0xDC
	SBRS R17,3
	RJMP _0xDD
	SUBI R19,-LOW(7)
	RJMP _0xDE
_0xDD:
	SUBI R19,-LOW(39)
_0xDE:
_0xDC:
	SBRC R17,4
	RJMP _0xE0
	CPI  R19,49
	BRSH _0xE2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0xE1
_0xE2:
	RJMP _0x117
_0xE1:
	CP   R20,R18
	BRLO _0xE6
	SBRS R17,0
	RJMP _0xE7
_0xE6:
	RJMP _0xE5
_0xE7:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0xE8
	LDI  R19,LOW(48)
_0x117:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0xE9
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xEA
	SUBI R20,LOW(1)
_0xEA:
_0xE9:
_0xE8:
_0xE0:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xEB
	SUBI R20,LOW(1)
_0xEB:
_0xE5:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0xD8
	RJMP _0xD7
_0xD8:
_0xD5:
	SBRS R17,0
	RJMP _0xEC
_0xED:
	CPI  R20,0
	BREQ _0xEF
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0xED
_0xEF:
_0xEC:
_0xF0:
_0xAF:
_0x115:
	LDI  R16,LOW(0)
_0x9A:
	RJMP _0x95
_0x97:
	RCALL __LOADLOCR6
	ADIW R28,18
	RET
_sprintf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,2
	RCALL __SAVELOCR2
	MOVW R26,R28
	RCALL __ADDW2R15
	MOVW R16,R26
	MOVW R26,R28
	ADIW R26,6
	RCALL __ADDW2R15
	RCALL __GETW1P
	STD  Y+2,R30
	STD  Y+2+1,R31
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
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x108
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
_0x108:
	RCALL __LOADLOCR2
	ADIW R28,4
	POP  R15
	RET

	.DSEG
___ds18b20_scratch_pad:
	.BYTE 0x9

	.CSEG
_rtc_init:
	LDD  R30,Y+2
	ANDI R30,LOW(0x3)
	STD  Y+2,R30
	LDD  R30,Y+1
	CPI  R30,0
	BREQ _0x104
	LDD  R30,Y+2
	ORI  R30,0x10
	STD  Y+2,R30
_0x104:
	LD   R30,Y
	CPI  R30,0
	BREQ _0x105
	LDD  R30,Y+2
	ORI  R30,0x80
	STD  Y+2,R30
_0x105:
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
	RJMP _0x106
_rtc_get_time:
	RCALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	RCALL _i2c_write
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _i2c_write
	RCALL _i2c_start
	LDI  R30,LOW(209)
	ST   -Y,R30
	RCALL _i2c_write
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _i2c_read
	ST   -Y,R30
	RCALL _bcd2bin
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _i2c_read
	ST   -Y,R30
	RCALL _bcd2bin
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _i2c_read
	ST   -Y,R30
	RCALL _bcd2bin
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	RCALL _i2c_stop
	RJMP _0x107
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
	RJMP _0x106
_rtc_get_date:
	RCALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	RCALL _i2c_write
	LDI  R30,LOW(4)
	ST   -Y,R30
	RCALL _i2c_write
	RCALL _i2c_start
	LDI  R30,LOW(209)
	ST   -Y,R30
	RCALL _i2c_write
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _i2c_read
	ST   -Y,R30
	RCALL _bcd2bin
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RCALL _i2c_read
	ST   -Y,R30
	RCALL _bcd2bin
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _i2c_read
	ST   -Y,R30
	RCALL _bcd2bin
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
	RCALL _i2c_stop
_0x107:
	ADIW R28,6
	RET
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
_0x106:
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

_w1_init:
	clr  r30
	cbi  __w1_port,__w1_bit
	sbi  __w1_port-1,__w1_bit
	__DELAY_USW 0x780
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x4B
	sbis __w1_port-2,__w1_bit
	ret
	__DELAY_USW 0x130
	sbis __w1_port-2,__w1_bit
	inc  r30
	__DELAY_USW 0x618
	ret

__w1_read_bit:
	sbi  __w1_port-1,__w1_bit
	__DELAY_USB 0xB
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x3B
	clc
	sbic __w1_port-2,__w1_bit
	sec
	ror  r30
	__DELAY_USW 0x140
	ret

__w1_write_bit:
	clt
	sbi  __w1_port-1,__w1_bit
	__DELAY_USB 0xB
	sbrc r23,0
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x45
	sbic __w1_port-2,__w1_bit
	rjmp __w1_write_bit0
	sbrs r23,0
	rjmp __w1_write_bit1
	ret
__w1_write_bit0:
	sbrs r23,0
	ret
__w1_write_bit1:
	__DELAY_USW 0x12C
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x1B
	set
	ret

_w1_read:
	ldi  r22,8
	__w1_read0:
	rcall __w1_read_bit
	dec  r22
	brne __w1_read0
	ret

_w1_write:
	ldi  r22,8
	ld   r23,y+
	clr  r30
__w1_write0:
	rcall __w1_write_bit
	brtc __w1_write1
	ror  r23
	dec  r22
	brne __w1_write0
	inc  r30
__w1_write1:
	ret

_w1_dow_crc8:
	clr  r30
	ld   r24,y
	tst  r24
	breq __w1_dow_crc83
	ldi  r22,0x18
	ldd  r26,y+1
	ldd  r27,y+2
__w1_dow_crc80:
	ldi  r25,8
	ld   r31,x+
__w1_dow_crc81:
	mov  r23,r31
	eor  r23,r30
	ror  r23
	brcc __w1_dow_crc82
	eor  r30,r22
__w1_dow_crc82:
	ror  r30
	lsr  r31
	dec  r25
	brne __w1_dow_crc81
	dec  r24
	brne __w1_dow_crc80
__w1_dow_crc83:
	adiw r28,3
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

__LSRB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSRB12R
__LSRB12L:
	LSR  R30
	DEC  R0
	BRNE __LSRB12L
__LSRB12R:
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

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
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

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
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
