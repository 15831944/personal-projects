
;CodeVisionAVR C Compiler V1.25.2 Standard
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
;Data Stack size        : 160 byte(s)
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
	LDI  R28,LOW(0x1A0)
	LDI  R29,HIGH(0x1A0)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x1A0
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
;      42 static PBYTE bkgnd_mem;     
_bkgnd_mem_G1:
	.BYTE 0x2
;      43 static PBYTE org_mem;
_org_mem_G1:
	.BYTE 0x2
;      44 
;      45 bit is_show_bkgnd        = 0;
;      46 bit is_power_off         = 0;     
;      47 bit is_stopping          = 0;   
;      48 bit is_half_above        = 0;
;      49 bit is_half_below        = 0; 
;      50 
;      51 register UINT count_row  = 0;
;      52 register UINT count_col  = 0;     
;      53 register signed horiz_idx  = 0;
;      54 
;      55 static BYTE scroll_rate   = 0; 
_scroll_rate_G1:
	.BYTE 0x1
;      56 static BYTE scroll_type   = 0;    
_scroll_type_G1:
	.BYTE 0x1
;      57 static BYTE frame_index   = 0;                                 
_frame_index_G1:
	.BYTE 0x1
;      58 
;      59 static UINT  tick_count  = 0;      
_tick_count_G1:
	.BYTE 0x2
;      60 static UINT  char_count  = 0;
_char_count_G1:
	.BYTE 0x2
;      61 static UINT  text_length = 0;
_text_length_G1:
	.BYTE 0x2
;      62 static UINT  stopping_count = 0;
_stopping_count_G1:
	.BYTE 0x2
;      63 static UINT  flipping_count = 0;
_flipping_count_G1:
	.BYTE 0x2
;      64 
;      65 static UINT  char_width[256];    
_char_width_G1:
	.BYTE 0x200
;      66 static UINT  columeH = 0;
_columeH_G1:
	.BYTE 0x2
;      67 static UINT  columeL = 0;
_columeL_G1:
	.BYTE 0x2
;      68 static UINT  char_index = 0;    
_char_index_G1:
	.BYTE 0x2
;      69 static UINT  next_char_width = 0;
_next_char_width_G1:
	.BYTE 0x2
;      70 static UINT  current_char_width = 0;  
_current_char_width_G1:
	.BYTE 0x2
;      71 
;      72 flash char  szText[] = "** CuongQuay 0915651001 **";    

	.CSEG
;      73 #define DATE_FORMAT_STR "Bay gio la 00 gio 00 phut 00 giay. Ngay 00 thang 00 nam 0000."
;      74 static char szDateStr[] = DATE_FORMAT_STR;

	.DSEG
_szDateStr_G1:
	.BYTE 0x3E
;      75              
;      76 // Global variables for message control
;      77 BYTE  rx_message = UNKNOWN_MSG;
;      78 WORD  rx_wparam  = 0;
;      79 WORD  rx_lparam  = 0;
;      80 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;      81                             
;      82 extern void reset_serial();         
;      83 extern void send_echo_msg();    
;      84 extern BYTE eeprom_read(BYTE deviceID, PBYTE address);
;      85 extern void eeprom_write(BYTE deviceID, PBYTE address, BYTE data);
;      86 extern WORD eeprom_read_w(BYTE deviceID, PBYTE address);
;      87 extern void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data);
;      88 extern void eeprom_write_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size);
;      89 extern void eeprom_read_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size);
;      90 
;      91 static void _displayFrame();
;      92 static BOOL _doScroll(); 
;      93                                                                                  
;      94 extern void getLunarStr(char* sz, short h, short m, short dd, short mm, int yyyy);
;      95 
;      96 void LoadFrame();      
;      97 void BlankRAM(PBYTE start_addr,PBYTE end_addr);
;      98 ///////////////////////////////////////////////////////////////
;      99 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;     100 ///////////////////////////////////////////////////////////////
;     101 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;     102 {       

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     103     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     104     ++tick_count;    
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	ADIW R30,1
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R31
;     105 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;     106 
;     107 
;     108 ///////////////////////////////////////////////////////////////
;     109 // static function(s) for led matrix display panel
;     110 ///////////////////////////////////////////////////////////////
;     111 static void _setRow()
;     112 {
__setRow_G1:
;     113     BYTE i=0;        
;     114     SCAN_DAT = OFF; 
	ST   -Y,R16
;	i -> R16
	LDI  R16,0
	SBI  0x12,5
;     115     for (i=0; i<8; i++){            
	LDI  R16,LOW(0)
_0x4:
	CPI  R16,8
	BRSH _0x5
;     116         if (i==(7-count_row)){ 
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	SUB  R30,R4
	SBC  R31,R5
	MOV  R26,R16
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x6
;     117             SCAN_DAT = ON;        
	CBI  0x12,5
;     118         }
;     119         else{
	RJMP _0x7
_0x6:
;     120             SCAN_DAT = OFF;        
	SBI  0x12,5
;     121         }
_0x7:
;     122         SCAN_CLK = 1;
	SBI  0x12,3
;     123         SCAN_CLK = 0;            
	CBI  0x12,3
;     124     }
	SUBI R16,-1
	RJMP _0x4
_0x5:
;     125 }
	RJMP _0x179
;     126             
;     127 static void _powerOff()
;     128 {
__powerOff_G1:
;     129     BYTE i =0;               
;     130     SCAN_DAT = OFF;  // data scan low        
	ST   -Y,R16
;	i -> R16
	LDI  R16,0
	SBI  0x12,5
;     131     for (i=0; i<8; i++)    
	LDI  R16,LOW(0)
_0x9:
	CPI  R16,8
	BRSH _0xA
;     132     {                                              
;     133         SCAN_CLK = 1;    // clock scan high
	SBI  0x12,3
;     134         SCAN_CLK = 0;    // clock scan low            
	CBI  0x12,3
;     135     }                                         
	SUBI R16,-1
	RJMP _0x9
_0xA:
;     136     SCAN_STB = 1;    // strobe scan high
	SBI  0x12,4
;     137     SCAN_STB = 0;    // strobe scan low                    
	CBI  0x12,4
;     138 }
_0x179:
	LD   R16,Y+
	RET
;     139 
;     140 static void _displayFrame()
;     141 {                                   
__displayFrame_G1:
;     142     count_col = 0;
	CLR  R6
	CLR  R7
;     143     count_row = 0;         
	CLR  R4
	CLR  R5
;     144 
;     145     if (is_power_off ==1){
	SBRS R2,1
	RJMP _0xB
;     146         _powerOff();
	CALL __powerOff_G1
;     147         return;
	RET
;     148     }
;     149              
;     150     columeL = current_char_width + (START_RAM_TEXT + SCREEN_WIDTH) - (WORD)start_mem;
_0xB:
	LDS  R30,_current_char_width_G1
	LDS  R31,_current_char_width_G1+1
	SUBI R30,LOW(-2576)
	SBCI R31,HIGH(-2576)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	SUB  R30,R26
	SBC  R31,R27
	STS  _columeL_G1,R30
	STS  _columeL_G1+1,R31
;     151     columeH = next_char_width + (START_RAM_TEXT + SCREEN_WIDTH) - (WORD)start_mem;         	                                           
	LDS  R30,_next_char_width_G1
	LDS  R31,_next_char_width_G1+1
	SUBI R30,LOW(-2576)
	SBCI R31,HIGH(-2576)
	SUB  R30,R26
	SBC  R31,R27
	STS  _columeH_G1,R30
	STS  _columeH_G1+1,R31
;     152 
;     153     // display one frame in the screen at the specific time 
;     154     for (buffer = start_mem;buffer < (END_RAM); buffer++)  
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
	BRLO PC+3
	JMP _0xE
;     155     {      
;     156         if (scroll_type == FLYING_TEXT && current_char_width < SCREEN_WIDTH)
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x1)
	BRNE _0x10
	LDS  R26,_current_char_width_G1
	LDS  R27,_current_char_width_G1+1
	CPI  R26,LOW(0x90)
	LDI  R30,HIGH(0x90)
	CPC  R27,R30
	BRLO _0x11
_0x10:
	RJMP _0xF
_0x11:
;     157 		{                                  		        
;     158 			if (count_col < current_char_width){				
	LDS  R30,_current_char_width_G1
	LDS  R31,_current_char_width_G1+1
	CP   R6,R30
	CPC  R7,R31
	BRSH _0x12
;     159 				if (is_show_bkgnd){
	SBRS R2,0
	RJMP _0x13
;     160                     DATA_PORT = org_mem[count_row*DATA_LENGTH + SCREEN_WIDTH + count_col]&
;     161                             (bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);	
	MOVW R26,R4
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	CALL __MULW12U
	SUBI R30,LOW(-144)
	SBCI R31,HIGH(-144)
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_org_mem_G1
	LDS  R27,_org_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R22,X
	MOVW R30,R4
	LDI  R26,LOW(144)
	LDI  R27,HIGH(144)
	CALL __MULW12U
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_bkgnd_mem_G1
	LDS  R27,_bkgnd_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	AND  R30,R22
	RJMP _0x17A
;     162                 }                               
;     163                 else{
_0x13:
;     164                     DATA_PORT = org_mem[count_row*DATA_LENGTH + SCREEN_WIDTH + count_col];
	MOVW R26,R4
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	CALL __MULW12U
	SUBI R30,LOW(-144)
	SBCI R31,HIGH(-144)
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_org_mem_G1
	LDS  R27,_org_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
_0x17A:
	OUT  0x18,R30
;     165                 }
;     166 			}
;     167 			else if ((count_col > columeL) && (count_col < columeH)){				
	RJMP _0x15
_0x12:
	LDS  R30,_columeL_G1
	LDS  R31,_columeL_G1+1
	CP   R30,R6
	CPC  R31,R7
	BRSH _0x17
	LDS  R30,_columeH_G1
	LDS  R31,_columeH_G1+1
	CP   R6,R30
	CPC  R7,R31
	BRLO _0x18
_0x17:
	RJMP _0x16
_0x18:
;     168 				if (is_show_bkgnd){
	SBRS R2,0
	RJMP _0x19
;     169 				    DATA_PORT = (*buffer)&(bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);								
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	LD   R22,X
	MOVW R30,R4
	LDI  R26,LOW(144)
	LDI  R27,HIGH(144)
	CALL __MULW12U
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_bkgnd_mem_G1
	LDS  R27,_bkgnd_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	AND  R30,R22
	RJMP _0x17B
;     170 				}                                                    
;     171 				else{
_0x19:
;     172 				    DATA_PORT = (*buffer);
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	LD   R30,X
_0x17B:
	OUT  0x18,R30
;     173 				}
;     174 			}
;     175 			else{                  
	RJMP _0x1B
_0x16:
;     176 			    if (is_show_bkgnd){
	SBRS R2,0
	RJMP _0x1C
;     177     	    		DATA_PORT = (bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);                				
	MOVW R30,R4
	LDI  R26,LOW(144)
	LDI  R27,HIGH(144)
	CALL __MULW12U
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_bkgnd_mem_G1
	LDS  R27,_bkgnd_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	RJMP _0x17C
;     178     	        }
;     179     	        else{
_0x1C:
;     180     	            DATA_PORT = 0xFF;
	LDI  R30,LOW(255)
_0x17C:
	OUT  0x18,R30
;     181     	        }
;     182 			}                                                               			
_0x1B:
_0x15:
;     183         }
;     184         else{     	        
	RJMP _0x1E
_0xF:
;     185             if ( is_half_above ==1){                            
	SBRS R2,3
	RJMP _0x1F
;     186                 if (horiz_idx < 8){
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R8,R30
	CPC  R9,R31
	BRGE _0x20
;     187                     if (count_row > 7-horiz_idx){
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	SUB  R30,R8
	SBC  R31,R9
	CP   R30,R4
	CPC  R31,R5
	BRSH _0x21
;     188                         DATA_PORT = *(buffer+horiz_idx*DATA_LENGTH-8*DATA_LENGTH)>>2;
	MOVW R26,R8
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	CALL __MULW12
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	ADD  R26,R30
	ADC  R27,R31
	SUBI R26,LOW(30336)
	SBCI R27,HIGH(30336)
	LD   R30,X
	LSR  R30
	LSR  R30
	RJMP _0x17D
;     189                     }
;     190                     else{                             
_0x21:
;     191                         DATA_PORT = *(buffer+horiz_idx*DATA_LENGTH);
	MOVW R26,R8
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	CALL __MULW12
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
_0x17D:
	OUT  0x18,R30
;     192                     }  
;     193                 }
;     194                 else{                                                        
	RJMP _0x23
_0x20:
;     195                     if (count_row < (16-horiz_idx)){
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	SUB  R30,R8
	SBC  R31,R9
	CP   R4,R30
	CPC  R5,R31
	BRSH _0x24
;     196                         DATA_PORT = *(buffer+(horiz_idx-8)*DATA_LENGTH)>>2 | 0xCC;
	MOVW R26,R8
	SBIW R26,8
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	CALL __MULW12
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	LSR  R30
	LSR  R30
	ORI  R30,LOW(0xCC)
	RJMP _0x17E
;     197                     }
;     198                     else{
_0x24:
;     199                         DATA_PORT = 0xFF;
	LDI  R30,LOW(255)
_0x17E:
	OUT  0x18,R30
;     200                     }
;     201                 }                    
_0x23:
;     202             }
;     203             else if ( is_half_below ==1){         
	RJMP _0x26
_0x1F:
	SBRS R2,4
	RJMP _0x27
;     204                 if (horiz_idx < 8){
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R8,R30
	CPC  R9,R31
	BRGE _0x28
;     205                     if (count_row < horiz_idx){
	__CPWRR 4,5,8,9
	BRSH _0x29
;     206                         DATA_PORT = *(buffer+8*DATA_LENGTH-horiz_idx*DATA_LENGTH)<<2 | 0x33;
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	SUBI R30,LOW(-30336)
	SBCI R31,HIGH(-30336)
	MOVW R22,R30
	MOVW R26,R8
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	CALL __MULW12
	MOVW R26,R22
	SUB  R26,R30
	SBC  R27,R31
	LD   R30,X
	LSL  R30
	LSL  R30
	ORI  R30,LOW(0x33)
	RJMP _0x17F
;     207                     }
;     208                     else{
_0x29:
;     209                         DATA_PORT = *(buffer-horiz_idx*DATA_LENGTH);
	MOVW R26,R8
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	CALL __MULW12
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	SUB  R26,R30
	SBC  R27,R31
	LD   R30,X
_0x17F:
	OUT  0x18,R30
;     210                     }   
;     211                 }                    
;     212                 else{                                             
	RJMP _0x2B
_0x28:
;     213                     if (count_row > horiz_idx-8){
	MOVW R30,R8
	SBIW R30,8
	CP   R30,R4
	CPC  R31,R5
	BRSH _0x2C
;     214                         DATA_PORT = *(buffer+8*DATA_LENGTH-horiz_idx*DATA_LENGTH)<<2 | 0x33;
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	SUBI R30,LOW(-30336)
	SBCI R31,HIGH(-30336)
	MOVW R22,R30
	MOVW R26,R8
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	CALL __MULW12
	MOVW R26,R22
	SUB  R26,R30
	SBC  R27,R31
	LD   R30,X
	LSL  R30
	LSL  R30
	ORI  R30,LOW(0x33)
	RJMP _0x180
;     215                     }
;     216                     else{
_0x2C:
;     217                         DATA_PORT = 0xFF;
	LDI  R30,LOW(255)
_0x180:
	OUT  0x18,R30
;     218                     }
;     219                 }
_0x2B:
;     220             }                
;     221             else{
	RJMP _0x2E
_0x27:
;     222                 if (is_show_bkgnd){           
	SBRS R2,0
	RJMP _0x2F
;     223                     if (count_col < 32){     
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	CP   R6,R30
	CPC  R7,R31
	BRSH _0x30
;     224                         DATA_PORT = (bkgnd_mem[count_col+SCREEN_WIDTH*count_row]);
	MOVW R30,R4
	LDI  R26,LOW(144)
	LDI  R27,HIGH(144)
	CALL __MULW12U
	ADD  R30,R6
	ADC  R31,R7
	LDS  R26,_bkgnd_mem_G1
	LDS  R27,_bkgnd_mem_G1+1
	ADD  R26,R30
	ADC  R27,R31
	RJMP _0x181
;     225                     }
;     226                     else{
_0x30:
;     227                         DATA_PORT = (*buffer);
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
_0x181:
	LD   R30,X
	OUT  0x18,R30
;     228                     }
;     229                 }                     
;     230                 else{                     
	RJMP _0x32
_0x2F:
;     231                     DATA_PORT = (*buffer);
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	LD   R30,X
	OUT  0x18,R30
;     232                 }
_0x32:
;     233             }            
_0x2E:
_0x26:
;     234                          
;     235         }              
_0x1E:
;     236      
;     237         #ifdef ENABLE_MASK_ROW  
;     238             DATA_PORT |= ENABLE_MASK_ROW;
	IN   R30,0x18
	ORI  R30,LOW(0xF0)
	OUT  0x18,R30
;     239         #endif //ENABLE_MASK_ROW
;     240 
;     241         DATA_CLK = 1;    // clock high
	SBI  0x7,2
;     242         DATA_CLK = 0;    // clock low   
	CBI  0x7,2
;     243         if ( ++count_col >= SCREEN_WIDTH)
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	CPI  R30,LOW(0x90)
	LDI  R26,HIGH(0x90)
	CPC  R31,R26
	BRLO _0x33
;     244         {                                            
;     245             count_col = 0;      // reset for next                                                                                                                       
	CLR  R6
	CLR  R7
;     246             
;     247             _powerOff();        // turn all led off            
	CALL __powerOff_G1
;     248 #ifdef __CD4094_
;     249             SCAN_STB = 0;       // strobe low 
;     250 #endif            
;     251             _setRow();          // turn row-led on                                                           
	CALL __setRow_G1
;     252                                                                                               
;     253             SCAN_STB = 1;       // strobe high                                                    
	SBI  0x12,4
;     254 #ifndef __CD4094_            
;     255             SCAN_STB = 0;       // strobe low 
	CBI  0x12,4
;     256 #endif              
;     257             DATA_STB = 1;       // strobe high            
	SBI  0x7,0
;     258             DATA_STB = 0;       // strobe low                                                 
	CBI  0x7,0
;     259                                     
;     260             if (++count_row >= 8){ 
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	SBIW R30,8
	BRLO _0x34
;     261                 count_row = 0;
	CLR  R4
	CLR  R5
;     262             }                                             
;     263             delay_ms(1);                                            
_0x34:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     264             buffer += (DATA_LENGTH - SCREEN_WIDTH);                 
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	SUBI R30,LOW(-3648)
	SBCI R31,HIGH(-3648)
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
;     265         }                   
;     266     }                         	
_0x33:
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	ADIW R30,1
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
	RJMP _0xD
_0xE:
;     267 }     
	RET
;     268                                   
;     269 static BOOL _doScroll()
;     270 {
__doScroll_G1:
;     271     // init state                         
;     272     DATA_STB = 0;
	CBI  0x7,0
;     273     DATA_CLK = 0;                
	CBI  0x7,2
;     274     // scroll left with shift_step bit(s)
;     275     if(tick_count >= scroll_rate)
	LDS  R30,_scroll_rate_G1
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	LDI  R31,0
	CP   R26,R30
	CPC  R27,R31
	BRSH PC+3
	JMP _0x35
;     276     {                             
;     277         tick_count = 0; 
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     278         is_show_bkgnd = 0;          
	CLT
	BLD  R2,0
;     279         switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     280         {
;     281         case FLYING_TEXT:        
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x39
;     282             if (current_char_width > SCREEN_WIDTH){
	LDS  R26,_current_char_width_G1
	LDS  R27,_current_char_width_G1+1
	CPI  R26,LOW(0x91)
	LDI  R30,HIGH(0x91)
	CPC  R27,R30
	BRLO _0x3A
;     283                 if (is_stopping==0){
	SBRC R2,2
	RJMP _0x3B
;     284                     if (stopping_count < MAX_STOP_TIME){
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRSH _0x3C
;     285                         is_stopping = 1;
	SET
	BLD  R2,2
;     286                         //start_mem = (PBYTE)(START_RAM_TEXT+SCREEN_WIDTH);
;     287                     }
;     288                     else{
	RJMP _0x3D
_0x3C:
;     289                         start_mem++;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,1
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     290                     }
_0x3D:
;     291                 }
;     292                 else{
	RJMP _0x3E
_0x3B:
;     293                     if (++stopping_count > MAX_STOP_TIME){
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x3F
;     294                         is_stopping = 0;
	CLT
	BLD  R2,2
;     295                     }
;     296                 }
_0x3F:
_0x3E:
;     297                                   
;     298             }
;     299 		    else{
	RJMP _0x40
_0x3A:
;     300 			    start_mem += (2);
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,2
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     301     			if (start_mem > (START_RAM_TEXT + SCREEN_WIDTH) - current_char_width){
	LDS  R26,_current_char_width_G1
	LDS  R27,_current_char_width_G1+1
	LDI  R30,LOW(2576)
	LDI  R31,HIGH(2576)
	SUB  R30,R26
	SBC  R31,R27
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x41
;     302 		    		char_index++;				 
	LDS  R30,_char_index_G1
	LDS  R31,_char_index_G1+1
	ADIW R30,1
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R31
;     303 			    	current_char_width = char_width[char_index];
	LDI  R26,LOW(_char_width_G1)
	LDI  R27,HIGH(_char_width_G1)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	STS  _current_char_width_G1,R30
	STS  _current_char_width_G1+1,R31
;     304 				    next_char_width = char_width[char_index+1];				
	LDS  R26,_char_index_G1
	LDS  R27,_char_index_G1+1
	LSL  R26
	ROL  R27
	__ADDW2MN _char_width_G1,2
	CALL __GETW1P
	STS  _next_char_width_G1,R30
	STS  _next_char_width_G1+1,R31
;     305     				start_mem = (PBYTE)START_RAM_TEXT + current_char_width;
	LDS  R30,_current_char_width_G1
	LDS  R31,_current_char_width_G1+1
	SUBI R30,LOW(-2432)
	SBCI R31,HIGH(-2432)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     306 	    		}
;     307 		    }  
_0x41:
_0x40:
;     308 		    if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-2592)
	SBCI R31,HIGH(-2592)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x42
;     309 		        LoadFrame();
	RCALL _LoadFrame
;     310 		    }
;     311             break;
_0x42:
	RJMP _0x38
;     312         case SCROLL_TEXT:
_0x39:
	CPI  R30,0
	BRNE _0x43
;     313             start_mem++;    
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,1
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
	SBIW R30,1
;     314             if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-2592)
	SBCI R31,HIGH(-2592)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x44
;     315 		        LoadFrame();
	RCALL _LoadFrame
;     316 		    }
;     317             break;
_0x44:
	RJMP _0x38
;     318         case FLIPPING_TEXT:                                  
_0x43:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x45
;     319             if (start_mem < (START_RAM_TEXT + SCREEN_WIDTH)){		    
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xA10)
	LDI  R30,HIGH(0xA10)
	CPC  R27,R30
	BRSH _0x46
;     320                 start_mem+=32;    
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,32
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     321             }
;     322             else {		    
	RJMP _0x47
_0x46:
;     323                 if (is_power_off==0){                
	SBRC R2,1
	RJMP _0x48
;     324                     if (++stopping_count > MAX_STOP_TIME/2){
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,51
	BRLO _0x49
;     325                         is_power_off=1;                    
	SET
	BLD  R2,1
;     326                         stopping_count=0;                
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     327                     }
;     328                 }
_0x49:
;     329                 else{                                     
	RJMP _0x4A
_0x48:
;     330                     if (++stopping_count > MAX_STOP_TIME){            
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x4B
;     331                         is_power_off=0;
	CLT
	BLD  R2,1
;     332                         stopping_count=0;                    
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     333                         if(++flipping_count > MAX_FLIP_TIME){
	LDS  R26,_flipping_count_G1
	LDS  R27,_flipping_count_G1+1
	ADIW R26,1
	STS  _flipping_count_G1,R26
	STS  _flipping_count_G1+1,R27
	SBIW R26,4
	BRLO _0x4C
;     334                             flipping_count=0;
	LDI  R30,0
	STS  _flipping_count_G1,R30
	STS  _flipping_count_G1+1,R30
;     335                             scroll_type = SCROLL_TEXT;
	LDI  R30,LOW(0)
	STS  _scroll_type_G1,R30
;     336                         }
;     337                     }
_0x4C:
;     338                 }
_0x4B:
_0x4A:
;     339             }  
_0x47:
;     340             break;
	RJMP _0x38
;     341         case SHOW_BKGND:      
_0x45:
	CPI  R30,LOW(0x3)
	BRNE _0x4D
;     342             start_mem++;    
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,1
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
	SBIW R30,1
;     343             is_show_bkgnd = 1;            
	SET
	BLD  R2,0
;     344             if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-2592)
	SBCI R31,HIGH(-2592)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x4E
;     345 		        LoadFrame();
	RCALL _LoadFrame
;     346 		    }
;     347             break;     
_0x4E:
	RJMP _0x38
;     348         case RIGHT_LEFT:
_0x4D:
	CPI  R30,LOW(0x4)
	BREQ PC+3
	JMP _0x4F
;     349             if (start_mem < (START_RAM_TEXT + SCREEN_WIDTH)){		    
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xA10)
	LDI  R30,HIGH(0xA10)
	CPC  R27,R30
	BRSH _0x50
;     350                 start_mem+=8;    
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
	RJMP _0x182
;     351             }   
;     352             else if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH) && start_mem < (START_RAM_TEXT + SCREEN_WIDTH)+8){
_0x50:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xA10)
	LDI  R30,HIGH(0xA10)
	CPC  R27,R30
	BRLO _0x53
	CPI  R26,LOW(0xA18)
	LDI  R30,HIGH(0xA18)
	CPC  R27,R30
	BRLO _0x54
_0x53:
	RJMP _0x52
_0x54:
;     353                 if (is_stopping==0){
	SBRC R2,2
	RJMP _0x55
;     354                     is_stopping =1;
	SET
	BLD  R2,2
;     355                 }
;     356                 else{
	RJMP _0x56
_0x55:
;     357                     if (++stopping_count > MAX_STOP_TIME){                       
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x57
;     358                         is_stopping = 0; 
	CLT
	BLD  R2,2
;     359                         start_mem +=8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     360                     }
;     361                 }
_0x57:
_0x56:
;     362             }
;     363             else{
	RJMP _0x58
_0x52:
;     364                 if (is_stopping==0){
	SBRC R2,2
	RJMP _0x59
;     365                     start_mem++; 
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,1
_0x182:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     366                 }
;     367             }                   
_0x59:
_0x58:
;     368             if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-2592)
	SBCI R31,HIGH(-2592)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x5A
;     369 		        LoadFrame();
	RCALL _LoadFrame
;     370 		    }
;     371             break;      
_0x5A:
	RJMP _0x38
;     372 #ifdef  __SCROLL_TOP_            
;     373         case SCROLL_TOP: 
_0x4F:
	CPI  R30,LOW(0x5)
	BREQ PC+3
	JMP _0x5B
;     374             if (is_half_above==1){ 
	SBRS R2,3
	RJMP _0x5C
;     375                 if (is_stopping ==0){            
	SBRC R2,2
	RJMP _0x5D
;     376                     if (++horiz_idx >=SCREEN_HEIGHT){                
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
	SBIW R30,16
	BRLT _0x5E
;     377                         is_half_above = 0;
	CLT
	BLD  R2,3
;     378                         is_half_below = 1;        
	SET
	BLD  R2,4
;     379                         horiz_idx  = SCREEN_HEIGHT;
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	MOVW R8,R30
;     380                         start_mem += SCREEN_WIDTH;                                  
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-144)
	SBCI R31,HIGH(-144)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     381                         if (start_mem >= (START_RAM_TEXT +(text_length+SCREEN_WIDTH))){ 
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-2576)
	SBCI R31,HIGH(-2576)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x5F
;     382                             is_half_above = 0;
	CLT
	BLD  R2,3
;     383                             is_half_below = 0;
	BLD  R2,4
;     384                             LoadFrame();
	RCALL _LoadFrame
;     385                         } 
;     386                     }
_0x5F:
;     387                 }
_0x5E:
;     388                 else{                  
	RJMP _0x60
_0x5D:
;     389                     if (++stopping_count > MAX_STOP_TIME){                       
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x61
;     390                         is_stopping = 0;
	CLT
	BLD  R2,2
;     391                     }
;     392                 }
_0x61:
_0x60:
;     393             }
;     394             else if (is_half_below==1){                
	RJMP _0x62
_0x5C:
	SBRS R2,4
	RJMP _0x63
;     395                 if (--horiz_idx <0){
	MOVW R30,R8
	SBIW R30,1
	MOVW R8,R30
	MOVW R26,R30
	SBIW R26,0
	BRGE _0x64
;     396                     horiz_idx =0; 
	CLR  R8
	CLR  R9
;     397                     is_half_below = 0;
	CLT
	BLD  R2,4
;     398                     is_half_above = 1;
	SET
	BLD  R2,3
;     399                     is_stopping =1;
	BLD  R2,2
;     400                     stopping_count = 0; 
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     401                 }   
;     402             }                                
_0x64:
;     403             break;        
_0x63:
_0x62:
	RJMP _0x38
;     404 #endif
;     405 #ifdef  __SCROLL_BOTTOM_            
;     406         case SCROLL_BOTTOM:
_0x5B:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0x65
;     407             if (is_half_below==1){       
	SBRS R2,4
	RJMP _0x66
;     408                 if (is_stopping ==0){      
	SBRC R2,2
	RJMP _0x67
;     409                     if (++horiz_idx >=SCREEN_HEIGHT){                
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
	SBIW R30,16
	BRLT _0x68
;     410                         is_half_above = 1;
	SET
	BLD  R2,3
;     411                         is_half_below = 0;   
	CLT
	BLD  R2,4
;     412                         horiz_idx  = SCREEN_HEIGHT;                
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	MOVW R8,R30
;     413                         start_mem += SCREEN_WIDTH;                                  
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-144)
	SBCI R31,HIGH(-144)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     414                         if (start_mem >= (START_RAM_TEXT +(text_length+SCREEN_WIDTH))){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-2576)
	SBCI R31,HIGH(-2576)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x69
;     415                             is_half_above = 0;
	BLD  R2,3
;     416                             is_half_below = 0;
	BLD  R2,4
;     417                             LoadFrame();
	RCALL _LoadFrame
;     418                         }              
;     419                     }
_0x69:
;     420                 }
_0x68:
;     421                 else{
	RJMP _0x6A
_0x67:
;     422                     if (++stopping_count > MAX_STOP_TIME){                       
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x6B
;     423                         is_stopping = 0;
	CLT
	BLD  R2,2
;     424                     }
;     425                 }
_0x6B:
_0x6A:
;     426             }
;     427             else if (is_half_above==1){
	RJMP _0x6C
_0x66:
	SBRS R2,3
	RJMP _0x6D
;     428                 if (--horiz_idx <0){
	MOVW R30,R8
	SBIW R30,1
	MOVW R8,R30
	MOVW R26,R30
	SBIW R26,0
	BRGE _0x6E
;     429                     horiz_idx =0; 
	CLR  R8
	CLR  R9
;     430                     is_half_below = 1;
	SET
	BLD  R2,4
;     431                     is_half_above = 0;     
	CLT
	BLD  R2,3
;     432                     is_stopping =1;
	SET
	BLD  R2,2
;     433                     stopping_count = 0; 
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     434                 }  
;     435             }                       
_0x6E:
;     436             break;              
_0x6D:
_0x6C:
	RJMP _0x38
;     437 #endif                                
;     438         case TEARS_DROPPED:                        
_0x65:
	CPI  R30,LOW(0x7)
	BRNE _0x6F
;     439             if (is_half_above==1){
	SBRS R2,3
	RJMP _0x70
;     440                 if (--horiz_idx <0){
	MOVW R30,R8
	SBIW R30,1
	MOVW R8,R30
	MOVW R26,R30
	SBIW R26,0
	BRGE _0x71
;     441                     horiz_idx =0; 
	CLR  R8
	CLR  R9
;     442                     is_half_below = 0;
	CLT
	BLD  R2,4
;     443                     is_half_above = 0;     
	BLD  R2,3
;     444                     is_stopping =1;
	SET
	BLD  R2,2
;     445                     stopping_count = 0; 
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     446                 }  
;     447             }        
_0x71:
;     448             start_mem++;                  
_0x70:
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,1
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     449             if (start_mem >= (START_RAM_TEXT +(text_length+SCREEN_WIDTH))){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-2576)
	SBCI R31,HIGH(-2576)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x72
;     450                 is_half_above = 0;
	CLT
	BLD  R2,3
;     451                 is_half_below = 0;
	BLD  R2,4
;     452                 LoadFrame();
	RCALL _LoadFrame
;     453             }            
;     454             break;
_0x72:
	RJMP _0x38
;     455 #ifdef __SHOW_DATE_STR_            
;     456         case SHOW_DATE_STR:  
_0x6F:
	CPI  R30,LOW(0x8)
	BRNE _0x75
;     457         #ifdef __DIGITAL_CLOCK_  
;     458             if (is_half_below==1){       
;     459                 if (is_stopping ==0){      
;     460                     if (++horiz_idx >=SCREEN_HEIGHT){                
;     461                         is_half_above = 1;
;     462                         is_half_below = 0;                             
;     463                         char_index = 0xFF;        
;     464                         horiz_idx  = SCREEN_HEIGHT;
;     465                         start_mem+=SCREEN_WIDTH;    
;     466                         if (start_mem >= (START_RAM_TEXT + 4*SCREEN_WIDTH)){
;     467             		        is_half_below = 0;
;     468                             is_half_above = 0; 
;     469             		        LoadFrame();
;     470 		                }               
;     471                     }
;     472                 }
;     473                 else{
;     474                     if (++stopping_count > MAX_STOP_TIME){                       
;     475                         is_stopping = 0;
;     476                     }
;     477                 }
;     478             }
;     479             else if (is_half_above==1){
;     480                 if (--horiz_idx <0){
;     481                     horiz_idx =0; 
;     482                     is_half_below = 1;
;     483                     is_half_above = 0;     
;     484                     is_stopping =1;
;     485                     stopping_count = 0; 
;     486                 }  
;     487             }       
;     488         #else          
;     489             start_mem++;    
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,1
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
	SBIW R30,1
;     490             if (start_mem >= (START_RAM_TEXT + SCREEN_WIDTH + SCREEN_HIDE)+ text_length){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-2592)
	SBCI R31,HIGH(-2592)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x74
;     491 		        LoadFrame();
	RCALL _LoadFrame
;     492 		    }
;     493 		#endif            
;     494             break; 
_0x74:
;     495 #endif            
;     496         default:
_0x75:
;     497             break;
;     498         }          
_0x38:
;     499     } 
;     500     return TRUE;       
_0x35:
	LDI  R30,LOW(1)
	RET
;     501 }                 
;     502 
;     503                                           
;     504 ////////////////////////////////////////////////////////////////////
;     505 // General functions
;     506 //////////////////////////////////////////////////////////////////// 
;     507 #define RESET_WATCHDOG()    #asm("WDR");
;     508 
;     509 void SerialToRAM(PBYTE address,WORD length, BYTE type)                                             
;     510 {
_SerialToRAM:
;     511     PBYTE temp = 0;          
;     512     UINT i =0, row =0;     				
;     513     temp   = (PBYTE)address;    
	CALL __SAVELOCR6
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
;     514     LED_STATUS = 0;
	CBI  0x18,4
;     515     for (row =0; row < 8; row++)
	__GETWRN 20,21,0
_0x77:
	__CPWRN 20,21,8
	BRSH _0x78
;     516     {
;     517         for (i =0; i< length; i++) 
	__GETWRN 18,19,0
_0x7A:
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x7B
;     518         {
;     519             *temp++ = ~getchar();
	PUSH R17
	PUSH R16
	__ADDWRN 16,17,1
	CALL _getchar
	COM  R30
	POP  R26
	POP  R27
	ST   X,R30
;     520             RESET_WATCHDOG();
	WDR
;     521         }                               
	__ADDWRN 18,19,1
	JMP  _0x7A
_0x7B:
;     522         if (type == FRAME_TEXT)   
	LDD  R30,Y+6
	CPI  R30,0
	BRNE _0x7C
;     523             temp += DATA_LENGTH - length;        
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	SUB  R30,R26
	SBC  R31,R27
	__ADDWRR 16,17,30,31
;     524     }              
_0x7C:
	__ADDWRN 20,21,1
	JMP  _0x77
_0x78:
;     525     LED_STATUS = 1;
	SBI  0x18,4
;     526 }
	CALL __LOADLOCR6
	ADIW R28,11
	RET
;     527 
;     528 void LoadCharWidth(WORD length)
;     529 {                               
_LoadCharWidth:
;     530     UINT i =0;  
;     531     LED_STATUS = 0;   
	ST   -Y,R17
	ST   -Y,R16
;	length -> Y+2
;	i -> R16,R17
	LDI  R16,0
	LDI  R17,0
	CBI  0x18,4
;     532     for (i =0; i < length; i++)
	__GETWRN 16,17,0
_0x7E:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R16,R30
	CPC  R17,R31
	BRLO PC+3
	JMP _0x7F
;     533     {                           
;     534         WORD data = 0;
;     535         data = getchar();                       // LOBYTE 
	SBIW R28,2
	LDI  R24,2
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x80*2)
	LDI  R31,HIGH(_0x80*2)
	CALL __INITLOCB
;	length -> Y+4
;	data -> Y+0
	CALL _getchar
	LDI  R31,0
	ST   Y,R30
	STD  Y+1,R31
;     536         RESET_WATCHDOG();       
	WDR
;     537         char_width[i] = data;        
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
;     538         data = getchar();                       // HIBYTE
	CALL _getchar
	LDI  R31,0
	ST   Y,R30
	STD  Y+1,R31
;     539         RESET_WATCHDOG();
	WDR
;     540         char_width[i] |= (data<<8)&0xFF00;
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
;     541     }                  
	ADIW R28,2
	__ADDWRN 16,17,1
	JMP  _0x7E
_0x7F:
;     542     current_char_width = 0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _current_char_width_G1,R30
	STS  _current_char_width_G1+1,R31
;     543     
;     544     LED_STATUS = 1;
	SBI  0x18,4
;     545 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
;     546 
;     547 void SaveCharWidth(WORD length, BYTE index)
;     548 {
_SaveCharWidth:
;     549     UINT i =0;                 
;     550     BYTE devID = EEPROM_DEVICE_BASE;
;     551     PBYTE base  = 0x0A;   
;     552     devID += index<<1;
	CALL __SAVELOCR5
;	length -> Y+6
;	index -> Y+5
;	i -> R16,R17
;	devID -> R18
;	*base -> R19,R20
	LDI  R16,0
	LDI  R17,0
	LDI  R18,160
	LDI  R19,LOW(0x0A)
	LDI  R20,HIGH(0x0A)
	LDD  R30,Y+5
	LSL  R30
	ADD  R18,R30
;     553     i2c_init();
	CALL _i2c_init
;     554     LED_STATUS = 0;   
	CBI  0x18,4
;     555     for (i =0; i < length; i++)
	__GETWRN 16,17,0
_0x82:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x83
;     556     {                           
;     557         eeprom_write_w(devID,base+(i<<1),char_width[i]);
	ST   -Y,R18
	MOVW R30,R16
	LSL  R30
	ROL  R31
	ADD  R30,R19
	ADC  R31,R20
	ST   -Y,R31
	ST   -Y,R30
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
;     558         RESET_WATCHDOG();
	WDR
;     559     }              
	__ADDWRN 16,17,1
	JMP  _0x82
_0x83:
;     560     LED_STATUS = 1; 
	SBI  0x18,4
;     561     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     562     DDRD = 0x3F; 
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     563 }
	CALL __LOADLOCR5
	ADIW R28,8
	RET
;     564 
;     565 void GetCharWidth(WORD length, BYTE index)
;     566 {                               
_GetCharWidth:
;     567     UINT i =0;   
;     568     BYTE devID = EEPROM_DEVICE_BASE;
;     569     PBYTE base  = 0x0A;              
;     570     devID += index<<1;
	CALL __SAVELOCR5
;	length -> Y+6
;	index -> Y+5
;	i -> R16,R17
;	devID -> R18
;	*base -> R19,R20
	LDI  R16,0
	LDI  R17,0
	LDI  R18,160
	LDI  R19,LOW(0x0A)
	LDI  R20,HIGH(0x0A)
	LDD  R30,Y+5
	LSL  R30
	ADD  R18,R30
;     571     i2c_init();
	CALL _i2c_init
;     572     LED_STATUS = 0;              
	CBI  0x18,4
;     573 
;     574     for (i =0; i < length; i++)
	__GETWRN 16,17,0
_0x85:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x86
;     575     {                           
;     576         char_width[i] = eeprom_read_w(devID,base+(i<<1));    
	MOVW R30,R16
	LDI  R26,LOW(_char_width_G1)
	LDI  R27,HIGH(_char_width_G1)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	ST   -Y,R18
	MOVW R30,R16
	LSL  R30
	ROL  R31
	ADD  R30,R19
	ADC  R31,R20
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read_w
	POP  R26
	POP  R27
	ST   X+,R30
	ST   X,R31
;     577         RESET_WATCHDOG();
	WDR
;     578     }                      
	__ADDWRN 16,17,1
	JMP  _0x85
_0x86:
;     579     LED_STATUS = 1;
	SBI  0x18,4
;     580     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     581     DDRD = 0x3F; 
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     582 }
	CALL __LOADLOCR5
	ADIW R28,8
	RET
;     583 
;     584 void SaveToEEPROM(PBYTE address, BYTE type, BYTE index)
;     585 {                             
_SaveToEEPROM:
;     586     PBYTE temp = 0;    
;     587     PBYTE end  = START_RAM_TEXT;     
;     588     BYTE devID = EEPROM_DEVICE_BASE;      				
;     589     devID += index<<1;
	CALL __SAVELOCR5
;	*address -> Y+7
;	type -> Y+6
;	index -> Y+5
;	*temp -> R16,R17
;	*end -> R18,R19
;	devID -> R20
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,LOW(0x980)
	LDI  R19,HIGH(0x980)
	LDI  R20,160
	LDD  R30,Y+5
	LSL  R30
	ADD  R20,R30
;     590     temp   = address;         
	__GETWRS 16,17,7
;     591            
;     592     i2c_init();
	CALL _i2c_init
;     593     LED_STATUS = 0;        
	CBI  0x18,4
;     594     
;     595     if (type == FRAME_TEXT) end = (PBYTE)END_RAM;
	LDD  R30,Y+6
	CPI  R30,0
	BRNE _0x87
	__GETWRN 18,19,32767
;     596     
;     597     for (temp = address; temp < end; temp+= EEPROM_PAGE) 
_0x87:
	__GETWRS 16,17,7
_0x89:
	__CPWRR 16,17,18,19
	BRSH _0x8A
;     598     {   
;     599         RESET_WATCHDOG();               
	WDR
;     600         eeprom_write_page( devID, temp, temp, EEPROM_PAGE);	      
	ST   -Y,R20
	ST   -Y,R17
	ST   -Y,R16
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	CALL _eeprom_write_page
;     601     }       
	__ADDWRN 16,17,64
	JMP  _0x89
_0x8A:
;     602     LED_STATUS = 1;
	SBI  0x18,4
;     603     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     604     DDRD = 0x3F;    
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     605 }
	CALL __LOADLOCR5
	ADIW R28,9
	RET
;     606                       
;     607 void LoadToRAM(PBYTE address, WORD length, BYTE type, BYTE index)
;     608 {                         
_LoadToRAM:
;     609     PBYTE temp = 0;          
;     610     UINT i =0, row =0;    
;     611     BYTE devID = EEPROM_DEVICE_BASE;
;     612     devID += index<<1;      				
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x8B*2)
	LDI  R31,HIGH(_0x8B*2)
	CALL __INITLOCB
	CALL __SAVELOCR6
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
;     613     temp   = address;                 
	__GETWRS 16,17,11
;     614     
;     615     if (length > DATA_LENGTH)    
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CPI  R26,LOW(0xED1)
	LDI  R30,HIGH(0xED1)
	CPC  R27,R30
	BRLO _0x8C
;     616         return; // invalid param
	CALL __LOADLOCR6
	ADIW R28,13
	RET
;     617     if (length%EEPROM_PAGE)
_0x8C:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ANDI R30,LOW(0x3F)
	BREQ _0x8D
;     618         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	LDI  R30,LOW(64)
	LDI  R31,HIGH(64)
	CALL __DIVW21U
	CALL __LSLW2
	CALL __LSLW4
	SUBI R30,LOW(-64)
	SBCI R31,HIGH(-64)
	STD  Y+9,R30
	STD  Y+9+1,R31
;     619 
;     620     i2c_init();
_0x8D:
	CALL _i2c_init
;     621     LED_STATUS = 0;             
	CBI  0x18,4
;     622 
;     623     for (row =0; row < 8; row++)            
	__GETWRN 20,21,0
_0x8F:
	__CPWRN 20,21,8
	BRSH _0x90
;     624     {                           
;     625         for (i =0; i< length; i+=EEPROM_PAGE) 
	__GETWRN 18,19,0
_0x92:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x93
;     626         {                                 
;     627             eeprom_read_page( devID, temp, temp, EEPROM_PAGE );	                                   
	LDD  R30,Y+6
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	CALL _eeprom_read_page
;     628             temp += EEPROM_PAGE;
	__ADDWRN 16,17,64
;     629             RESET_WATCHDOG();     
	WDR
;     630         }         
	__ADDWRN 18,19,64
	JMP  _0x92
_0x93:
;     631         if (type == FRAME_TEXT)  
	LDD  R30,Y+8
	CPI  R30,0
	BRNE _0x94
;     632             temp += DATA_LENGTH - length;  
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	SUB  R30,R26
	SBC  R31,R27
	__ADDWRR 16,17,30,31
;     633     }             
_0x94:
	__ADDWRN 20,21,1
	JMP  _0x8F
_0x90:
;     634     
;     635     LED_STATUS = 1; 
	SBI  0x18,4
;     636     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     637     DDRD = 0x3F;  
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     638 }
	CALL __LOADLOCR6
	ADIW R28,13
	RET
;     639 
;     640 
;     641 void LoadConfig(BYTE index)
;     642 {   
_LoadConfig:
;     643     BYTE devID = EEPROM_DEVICE_BASE;
;     644     devID += index<<1; 
	ST   -Y,R16
;	index -> Y+1
;	devID -> R16
	LDI  R16,160
	LDD  R30,Y+1
	LSL  R30
	ADD  R16,R30
;     645     i2c_init();
	CALL _i2c_init
;     646     LED_STATUS = 1;                  
	SBI  0x18,4
;     647     RESET_WATCHDOG();             
	WDR
;     648     scroll_type   = eeprom_read(devID,0);
	ST   -Y,R16
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_type_G1,R30
;     649     scroll_rate = eeprom_read(devID,(PBYTE)1);
	ST   -Y,R16
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     650     text_length =  eeprom_read_w(devID,(PBYTE)2); 
	ST   -Y,R16
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read_w
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     651     char_count =  eeprom_read_w(devID,(PBYTE)4);         
	ST   -Y,R16
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read_w
	STS  _char_count_G1,R30
	STS  _char_count_G1+1,R31
;     652     printf("line=%d rate=%d type=%d len=%d\r\n",index,scroll_rate,scroll_type,text_length);
	__POINTW1FN _0,62
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+3
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDS  R30,_scroll_rate_G1
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDS  R30,_scroll_type_G1
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,16
	CALL _printf
	ADIW R28,18
;     653     if (text_length > DATA_LENGTH){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0xED1)
	LDI  R30,HIGH(0xED1)
	CPC  R27,R30
	BRLO _0x95
;     654         text_length= 0;            
	LDI  R30,0
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R30
;     655     }
;     656     if (char_count > 255){
_0x95:
	LDS  R26,_char_count_G1
	LDS  R27,_char_count_G1+1
	CPI  R26,LOW(0x100)
	LDI  R30,HIGH(0x100)
	CPC  R27,R30
	BRLO _0x96
;     657         char_count = 0;
	LDI  R30,0
	STS  _char_count_G1,R30
	STS  _char_count_G1+1,R30
;     658     }
;     659     LED_STATUS = 0; 
_0x96:
	CBI  0x18,4
;     660     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     661     DDRD = 0x3F;   
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     662 }
	RJMP _0x178
;     663 
;     664 void SaveConfig(BYTE index)
;     665 {     
_SaveConfig:
;     666     BYTE devID = EEPROM_DEVICE_BASE;
;     667     devID += index<<1; 
	ST   -Y,R16
;	index -> Y+1
;	devID -> R16
	LDI  R16,160
	LDD  R30,Y+1
	LSL  R30
	ADD  R16,R30
;     668     i2c_init();
	CALL _i2c_init
;     669     LED_STATUS = 1;  
	SBI  0x18,4
;     670     eeprom_write(devID,(PBYTE)0,scroll_type);
	ST   -Y,R16
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_scroll_type_G1
	ST   -Y,R30
	CALL _eeprom_write
;     671     eeprom_write(devID,(PBYTE)1,scroll_rate);   
	ST   -Y,R16
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_scroll_rate_G1
	ST   -Y,R30
	CALL _eeprom_write
;     672     LED_STATUS = 0; 
	CBI  0x18,4
;     673     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     674     DDRD = 0x3F;   
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     675 }
_0x178:
	LDD  R16,Y+0
	ADIW R28,2
	RET
;     676 
;     677 void SaveTextLength(WORD length, BYTE index)
;     678 {
_SaveTextLength:
;     679     BYTE devID = EEPROM_DEVICE_BASE;
;     680     devID += index<<1; 
	ST   -Y,R16
;	length -> Y+2
;	index -> Y+1
;	devID -> R16
	LDI  R16,160
	LDD  R30,Y+1
	LSL  R30
	ADD  R16,R30
;     681     i2c_init();
	CALL _i2c_init
;     682     LED_STATUS = 1;   
	SBI  0x18,4
;     683     eeprom_write_w(devID, (PBYTE)2,length); 
	ST   -Y,R16
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_write_w
;     684     eeprom_write_w(devID, (PBYTE)4,char_count); 
	ST   -Y,R16
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_write_w
;     685     LED_STATUS = 0;
	CBI  0x18,4
;     686     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     687     DDRD = 0x3F;        
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     688 }
	LDD  R16,Y+0
	ADIW R28,4
	RET
;     689 
;     690 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     691 {        
_BlankRAM:
;     692     PBYTE temp = START_RAM;
;     693     for (temp = start_addr; temp<= end_addr; temp++)    
	ST   -Y,R17
	ST   -Y,R16
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*temp -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x98:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x99
;     694         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     695 }
	__ADDWRN 16,17,1
	RJMP _0x98
_0x99:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;     696 
;     697 void SetRTCDateTime()
;     698 {
_SetRTCDateTime:
;     699     i2c_init();
	CALL _i2c_init
;     700     LED_STATUS = 0;   
	CBI  0x18,4
;     701     rtc_set_time(0,0,0);    /* clear CH bit */
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	ST   -Y,R30
	CALL _rtc_set_time
;     702     rtc_set_date(getchar(),getchar(),getchar());
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _rtc_set_date
;     703     rtc_set_time(getchar(),getchar(),getchar());    
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _rtc_set_time
;     704     LED_STATUS = 1;
	SBI  0x18,4
;     705     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     706     DDRD = 0x3F; 
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     707 }
	RET
;     708 
;     709 static void TextFromFont(char *szText, BYTE nColor, BYTE bGradient, PBYTE pBuffer, BYTE index)
;     710 {
_TextFromFont_G1:
;     711 	int pos = 0,x=0,y=0;     
;     712 	BYTE i =0, len;
;     713 	BYTE ch = 0;
;     714 	UINT nWidth = 0;   
;     715 	UINT nCurWidth = 0, nNxtWidth = 0;		
;     716     BYTE mask = 0x00, data = 0;
;     717 	BYTE mask_clr[2] = {0x00};
;     718     BYTE devID = EEPROM_DEVICE_BASE;
;     719     devID += index<<1; 
	SBIW R28,14
	LDI  R24,14
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x9A*2)
	LDI  R31,HIGH(_0x9A*2)
	CALL __INITLOCB
	CALL __SAVELOCR6
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
	LDD  R30,Y+20
	LSL  R30
	LDD  R26,Y+6
	ADD  R30,R26
	STD  Y+6,R30
;     720     	
;     721 	switch (nColor)
	LDD  R30,Y+24
;     722 	{
;     723 	case 0:
	CPI  R30,0
	BRNE _0x9E
;     724 		mask = 0xFF;		// BLANK
	LDI  R30,LOW(255)
	STD  Y+10,R30
;     725 		mask_clr[0] = 0xFF;
	STD  Y+7,R30
;     726 		mask_clr[1] = 0xFF;
	STD  Y+8,R30
;     727 		break;
	RJMP _0x9D
;     728 	case 1:
_0x9E:
	CPI  R30,LOW(0x1)
	BRNE _0x9F
;     729 		mask = 0xAA;		// RED			RRRR	
	LDI  R30,LOW(170)
	STD  Y+10,R30
;     730 		mask_clr[0] = 0x99;	// GREEN		RGRG
	LDI  R30,LOW(153)
	STD  Y+7,R30
;     731 		mask_clr[1] = 0x88;	// YELLOW		RYRY
	LDI  R30,LOW(136)
	STD  Y+8,R30
;     732 		break;
	RJMP _0x9D
;     733 	case 2:
_0x9F:
	CPI  R30,LOW(0x2)
	BRNE _0xA0
;     734 		mask = 0x55;		// GREEN		GGGG
	LDI  R30,LOW(85)
	STD  Y+10,R30
;     735 		mask_clr[0] = 0x44;	// YELLOW		GYGY
	LDI  R30,LOW(68)
	STD  Y+7,R30
;     736 		mask_clr[1] = 0x66;	// RED			GRGR	
	LDI  R30,LOW(102)
	STD  Y+8,R30
;     737 		break;
	RJMP _0x9D
;     738 	case 3:
_0xA0:
	CPI  R30,LOW(0x3)
	BRNE _0xA2
;     739 		mask = 0x00;		// YELLOW		YYYY
	LDI  R30,LOW(0)
	STD  Y+10,R30
;     740 		mask_clr[0] = 0x22;	// RED			YRYR	
	LDI  R30,LOW(34)
	STD  Y+7,R30
;     741 		mask_clr[1] = 0x11;	// GREEN		YGYG
	LDI  R30,LOW(17)
	STD  Y+8,R30
;     742 		break;
;     743 	default:
_0xA2:
;     744 		break;
;     745 	}	
_0x9D:
;     746                            
;     747 	LED_STATUS = 0;
	CBI  0x18,4
;     748 	i2c_init();
	CALL _i2c_init
;     749 	len = strlen(szText);
	LDD  R30,Y+25
	LDD  R31,Y+25+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen
	STD  Y+18,R30
;     750 	for (i=0; i< len; i++){				                                     
	LDI  R30,LOW(0)
	STD  Y+19,R30
_0xA4:
	LDD  R30,Y+18
	LDD  R26,Y+19
	CP   R26,R30
	BRLO PC+3
	JMP _0xA5
;     751         ch = szText[i];             
	LDD  R30,Y+19
	LDD  R26,Y+25
	LDD  R27,Y+25+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	STD  Y+17,R30
;     752 		nCurWidth = char_width[ch];
	LDI  R26,LOW(_char_width_G1)
	LDI  R27,HIGH(_char_width_G1)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	STD  Y+13,R30
	STD  Y+13+1,R31
;     753 		nNxtWidth = char_width[ch+1];    		
	LDD  R26,Y+17
	LDI  R27,0
	LSL  R26
	ROL  R27
	__ADDW2MN _char_width_G1,2
	CALL __GETW1P
	STD  Y+11,R30
	STD  Y+11+1,R31
;     754 		nWidth = (nNxtWidth - nCurWidth); 		
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+15,R30
	STD  Y+15+1,R31
;     755 		if ((pos + nWidth) >= DATA_LENGTH)  break;		
	ADD  R30,R16
	ADC  R31,R17
	CPI  R30,LOW(0xED0)
	LDI  R26,HIGH(0xED0)
	CPC  R31,R26
	BRLO _0xA6
	JMP  _0xA5
;     756 		for (y=0; y< 8 ; y++){    		            
_0xA6:
	__GETWRN 20,21,0
_0xA8:
	__CPWRN 20,21,8
	BRLT PC+3
	JMP _0xA9
;     757 		    if (bGradient) {
	LDD  R30,Y+23
	CPI  R30,0
	BREQ _0xAA
;     758 				if (y >=0 && y <4)	mask = mask_clr[0];
	SUBI R20,0
	SBCI R21,0
	BRLT _0xAC
	__CPWRN 20,21,4
	BRLT _0xAD
_0xAC:
	RJMP _0xAB
_0xAD:
	LDD  R30,Y+7
	STD  Y+10,R30
;     759 				if (y >=4 && y <8)	mask = mask_clr[1];	
_0xAB:
	__CPWRN 20,21,4
	BRLT _0xAF
	__CPWRN 20,21,8
	BRLT _0xB0
_0xAF:
	RJMP _0xAE
_0xB0:
	LDD  R30,Y+8
	STD  Y+10,R30
;     760 			}			
_0xAE:
;     761 			for (x=0; x< nWidth; x++){                                 
_0xAA:
	__GETWRN 18,19,0
_0xB2:
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0xB3
;     762 			    RESET_WATCHDOG();       
	WDR
;     763 			    data = eeprom_read(devID, (PBYTE)(START_RAM_TEXT + SCREEN_WIDTH + y*DATA_LENGTH + nCurWidth + x));
	LDD  R30,Y+6
	ST   -Y,R30
	MOVW R26,R20
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	CALL __MULW12
	SUBI R30,LOW(-2576)
	SBCI R31,HIGH(-2576)
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	ADD  R30,R26
	ADC  R31,R27
	ADD  R30,R18
	ADC  R31,R19
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STD  Y+9,R30
;     764 			    data = (~data) & (~mask); 
	COM  R30
	MOV  R26,R30
	LDD  R30,Y+10
	COM  R30
	AND  R30,R26
	STD  Y+9,R30
;     765    				pBuffer[y*DATA_LENGTH + x + pos] = ~data;   				
	MOVW R26,R20
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	CALL __MULW12
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
;     766 			}					
	__ADDWRN 18,19,1
	JMP  _0xB2
_0xB3:
;     767 		}
	__ADDWRN 20,21,1
	JMP  _0xA8
_0xA9:
;     768 		pos += nWidth;	 		
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	__ADDWRR 16,17,30,31
;     769 	}	                           
	LDD  R30,Y+19
	SUBI R30,-LOW(1)
	STD  Y+19,R30
	JMP  _0xA4
_0xA5:
;     770     
;     771     text_length = pos;    
	__PUTWMRN _text_length_G1,0,16,17
;     772     LED_STATUS = 1;
	SBI  0x18,4
;     773     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     774     DDRD = 0x3F;     
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     775 }
	CALL __LOADLOCR6
	ADIW R28,27
	RET
;     776 
;     777 void LoadFrame()
;     778 {  
_LoadFrame:
;     779     is_stopping = 0;
	CLT
	BLD  R2,2
;     780     stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     781     if (++frame_index >= MAX_FRAME){
	LDS  R26,_frame_index_G1
	SUBI R26,-LOW(1)
	STS  _frame_index_G1,R26
	CPI  R26,LOW(0x4)
	BRLO _0xB4
;     782         frame_index = 0;
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     783     }                   
;     784     _powerOff();
_0xB4:
	CALL __powerOff_G1
;     785 #ifdef __DIGITAL_CLOCK_ 
;     786     frame_index = 0;
;     787 #endif 
;     788     LoadConfig(frame_index);              
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	CALL _LoadConfig
;     789     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     790     GetCharWidth(char_count,frame_index);                               
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	CALL _GetCharWidth
;     791     if (scroll_type != SHOW_DATE_STR){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x8)
	BREQ _0xB5
;     792         LoadToRAM((PBYTE)START_RAM_BK,SCREEN_WIDTH,FRAME_BKGND,frame_index);    	 
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(144)
	LDI  R31,HIGH(144)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	CALL _LoadToRAM
;     793         LoadToRAM((PBYTE)START_RAM_TEXT + SCREEN_WIDTH,text_length,FRAME_TEXT,frame_index);    
	LDI  R30,LOW(2576)
	LDI  R31,HIGH(2576)
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
	CALL _LoadToRAM
;     794     }
;     795 
;     796     switch (scroll_type)
_0xB5:
	LDS  R30,_scroll_type_G1
;     797     {
;     798     case FLYING_TEXT: 
	CPI  R30,LOW(0x1)
	BRNE _0xB9
;     799         {
;     800             char_index = 0;
	LDI  R30,0
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R30
;     801             start_mem = (PBYTE)START_RAM_TEXT;        
	LDI  R30,LOW(2432)
	LDI  R31,HIGH(2432)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     802         }
;     803         break;   
	RJMP _0xB8
;     804     case SHOW_BKGND:     
_0xB9:
	CPI  R30,LOW(0x3)
	BRNE _0xBA
;     805         is_show_bkgnd = 1;
	SET
	BLD  R2,0
;     806     case FLIPPING_TEXT:          
	RJMP _0xBB
_0xBA:
	CPI  R30,LOW(0x2)
	BRNE _0xBC
_0xBB:
;     807     case SCROLL_TEXT:            
	RJMP _0xBD
_0xBC:
	CPI  R30,0
	BRNE _0xBE
_0xBD:
;     808     case RIGHT_LEFT:
	RJMP _0xBF
_0xBE:
	CPI  R30,LOW(0x4)
	BRNE _0xC0
_0xBF:
;     809         {
;     810             char_index = 0xFF;                     
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R31
;     811             start_mem = (PBYTE)START_RAM_TEXT;        
	LDI  R30,LOW(2432)
	LDI  R31,HIGH(2432)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     812         }
;     813         break;     
	RJMP _0xB8
;     814 #ifdef __SCROLL_TOP_                                      
;     815     case SCROLL_TOP:
_0xC0:
	CPI  R30,LOW(0x5)
	BRNE _0xC1
;     816         {
;     817             is_half_above = 0;
	CLT
	BLD  R2,3
;     818             is_half_below = 1;
	SET
	BLD  R2,4
;     819             char_index = 0xFF; 
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R31
;     820             horiz_idx  = SCREEN_HEIGHT;
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	MOVW R8,R30
;     821             start_mem = (PBYTE)START_RAM_TEXT + SCREEN_WIDTH;
	LDI  R30,LOW(2576)
	LDI  R31,HIGH(2576)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     822         }
;     823         break;   
	RJMP _0xB8
;     824 #endif
;     825 #ifdef __SCROLL_BOTTOM_        
;     826     case SCROLL_BOTTOM:                                                       
_0xC1:
	CPI  R30,LOW(0x6)
	BRNE _0xC2
;     827         {
;     828             is_half_above = 1;
	SET
	BLD  R2,3
;     829             is_half_below = 0;                             
	CLT
	BLD  R2,4
;     830             char_index = 0xFF;        
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R31
;     831             horiz_idx  = SCREEN_HEIGHT;
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	MOVW R8,R30
;     832             start_mem = (PBYTE)START_RAM_TEXT + SCREEN_WIDTH;        
	LDI  R30,LOW(2576)
	LDI  R31,HIGH(2576)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     833         }
;     834         break;         
	RJMP _0xB8
;     835 #endif
;     836         case TEARS_DROPPED:            
_0xC2:
	CPI  R30,LOW(0x7)
	BRNE _0xC3
;     837         {
;     838             is_half_above = 1;
	SET
	BLD  R2,3
;     839             is_half_below = 0;                             
	CLT
	BLD  R2,4
;     840             char_index = 0xFF;        
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R31
;     841             horiz_idx  = SCREEN_HEIGHT;
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	MOVW R8,R30
;     842             start_mem = (PBYTE)START_RAM_TEXT;                
	LDI  R30,LOW(2432)
	LDI  R31,HIGH(2432)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     843         }
;     844         break;
	RJMP _0xB8
;     845 #ifdef __SHOW_DATE_STR_        
;     846     case SHOW_DATE_STR:
_0xC3:
	CPI  R30,LOW(0x8)
	BREQ PC+3
	JMP _0xC6
;     847         {        
;     848             int temp=0;                                                                                    
;     849             BYTE hh=0,mm=0,ss=0;
;     850             BYTE DD=0,MM=0,YY=00;
;     851             i2c_init();                           
	SBIW R28,8
	LDI  R24,8
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0xC5*2)
	LDI  R31,HIGH(_0xC5*2)
	CALL __INITLOCB
;	temp -> Y+6
;	hh -> Y+5
;	mm -> Y+4
;	ss -> Y+3
;	DD -> Y+2
;	MM -> Y+1
;	YY -> Y+0
	CALL _i2c_init
;     852             rtc_get_date(&DD,&MM,&YY);
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
	CALL _rtc_get_date
;     853             rtc_get_time(&hh,&mm,&ss);                                                                                                                  
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
	CALL _rtc_get_time
;     854         #ifdef __DIGITAL_CLOCK_     
;     855             if (!ds18b20_init(0,10,40,DS18B20_9BIT_RES)){
;     856                 printf("INIT DS18B20 ERROR!! \r\n");
;     857             }
;     858             temp=(int)ds18b20_temperature(0);        
;     859             if (temp<0 || temp>100) temp = 0;
;     860             sprintf(szDateStr,"%02d:%02d%02d/%02d%02d'C",hh,mm,DD,MM,temp);              
;     861         #else       
;     862             getLunarStr(szDateStr,hh,mm,DD,MM,2000+YY);                                      
	LDI  R30,LOW(_szDateStr_G1)
	LDI  R31,HIGH(_szDateStr_G1)
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+9
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	CALL _getLunarStr
;     863         #endif            
;     864             BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     865             TextFromFont(szDateStr, 1, 0, (PBYTE)START_RAM_TEXT + SCREEN_WIDTH, frame_index);
	LDI  R30,LOW(_szDateStr_G1)
	LDI  R31,HIGH(_szDateStr_G1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(2576)
	LDI  R31,HIGH(2576)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	CALL _TextFromFont_G1
;     866             char_index = 0xFF;      
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	STS  _char_index_G1,R30
	STS  _char_index_G1+1,R31
;     867         #ifdef __DIGITAL_CLOCK_      
;     868             is_half_above = 1;
;     869             is_half_below = 0;                             
;     870             char_index = 0xFF;        
;     871             horiz_idx  = SCREEN_HEIGHT;
;     872             start_mem = (PBYTE)START_RAM_TEXT + SCREEN_WIDTH; 
;     873         #else           
;     874             start_mem = (PBYTE)START_RAM_TEXT;                            
	LDI  R30,LOW(2432)
	LDI  R31,HIGH(2432)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     875         #endif
;     876         }
	ADIW R28,8
;     877         break;         
;     878 #endif        
;     879     default:        
_0xC6:
;     880         break;
;     881     }       
_0xB8:
;     882     reset_serial();    
	RCALL _reset_serial
;     883     current_char_width = char_width[char_index];
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
;     884     next_char_width = char_width[char_index+1];
	LDS  R26,_char_index_G1
	LDS  R27,_char_index_G1+1
	LSL  R26
	ROL  R27
	__ADDW2MN _char_width_G1,2
	CALL __GETW1P
	STS  _next_char_width_G1,R30
	STS  _next_char_width_G1+1,R31
;     885 }
	RET
;     886 
;     887 ///////////////////////////////////////////////////////////////
;     888 // END static function(s)
;     889 ///////////////////////////////////////////////////////////////
;     890 
;     891 ///////////////////////////////////////////////////////////////           
;     892 
;     893 void InitDevice()
;     894 {
_InitDevice:
;     895 // Declare your local variables here
;     896 // Crystal Oscillator division factor: 1  
;     897 #ifdef _MEGA162_INCLUDED_ 
;     898 #pragma optsize-
;     899 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     900 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     901 #ifdef _OPTIMIZE_SIZE_
;     902 #pragma optsize+
;     903 #endif                    
;     904 #endif
;     905 
;     906 PORTA=0x00;
	OUT  0x1B,R30
;     907 DDRA=0x00;
	OUT  0x1A,R30
;     908 
;     909 PORTB=0x00;
	OUT  0x18,R30
;     910 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     911 
;     912 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     913 DDRC=0x00;
	OUT  0x14,R30
;     914 
;     915 PORTD = 0x00;
	OUT  0x12,R30
;     916 DDRD = 0x00;
	OUT  0x11,R30
;     917 
;     918 PORTE=0x00;
	OUT  0x7,R30
;     919 DDRE=0x05;
	LDI  R30,LOW(5)
	OUT  0x6,R30
;     920 
;     921 TCCR0=0x03; 
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     922 TCNT0=0x05; 
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     923 OCR0=0x00;  
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     924 
;     925 UCSR0A=0x00;
	OUT  0xB,R30
;     926 UCSR0B=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     927 UCSR0C=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     928 UBRR0H=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     929 UBRR0L=0x67;
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     930 
;     931 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     932 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     933 
;     934 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     935 ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
;     936 
;     937 // I2C Bus initialization
;     938 i2c_init();
	CALL _i2c_init
;     939 
;     940 // DS1307 Real Time Clock initialization
;     941 // Square wave output on pin SQW/OUT: Off
;     942 // SQW/OUT pin state: 1
;     943 rtc_init(0,0,1);   
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _rtc_init
;     944 
;     945 #ifdef __WATCH_DOG_
;     946 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     947 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     948 #endif 
;     949 
;     950     printf("LCMS v2.02 Designed by CuongQuay\r\n");  
	__POINTW1FN _0,95
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     951     printf("cuong3ihut@yahoo.com - 0915651001\r\n");
	__POINTW1FN _0,130
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     952     printf("Release date: 09.01.2007\r\n");
	__POINTW1FN _0,166
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     953 #ifdef _TEST_RTC_
;     954 {                                
;     955     BYTE hh=0,mm=0,ss=0,DD=0,MM=0,YY=0;
;     956     rtc_get_date(&DD,&MM,&YY);
;     957     rtc_get_time(&hh,&mm,&ss);
;     958     printf("%02d:%02d:%02d %02d-%02d-%02d\r\n",hh,mm,ss,DD,MM,YY);
;     959 }           
;     960 #endif                   
;     961 }
	RET
;     962 
;     963 void PowerReset()
;     964 {   
_PowerReset:
;     965     start_mem = (PBYTE)START_RAM_TEXT;     
	LDI  R30,LOW(2432)
	LDI  R31,HIGH(2432)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     966     end_mem   = (PBYTE)END_RAM;
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	STS  _end_mem_G1,R30
	STS  _end_mem_G1+1,R31
;     967     bkgnd_mem = (PBYTE)START_RAM_BK;
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _bkgnd_mem_G1,R30
	STS  _bkgnd_mem_G1+1,R31
;     968     org_mem   = (PBYTE)START_RAM_TEXT;	                   
	LDI  R30,LOW(2432)
	LDI  R31,HIGH(2432)
	STS  _org_mem_G1,R30
	STS  _org_mem_G1+1,R31
;     969 
;     970     InitDevice();
	CALL _InitDevice
;     971                      
;     972     LED_STATUS = 0;
	CBI  0x18,4
;     973     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);    
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     974     delay_ms(500);
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     975     LED_STATUS = 1;
	SBI  0x18,4
;     976     
;     977     current_char_width = 0xFFFF;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _current_char_width_G1,R30
	STS  _current_char_width_G1+1,R31
;     978     next_char_width = 0xFFFF;	 
	STS  _next_char_width_G1,R30
	STS  _next_char_width_G1+1,R31
;     979     
;     980     LED_STATUS = 0;  
	CBI  0x18,4
;     981     frame_index = 0; 
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     982     LoadFrame();        
	CALL _LoadFrame
;     983     LED_STATUS = 1;             
	SBI  0x18,4
;     984                        
;     985     // reload configuration
;     986     LED_STATUS = 0;
	CBI  0x18,4
;     987     delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     988     LED_STATUS = 1;  
	SBI  0x18,4
;     989     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     990     DDRD = 0x3F;      
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     991 }
	RET
;     992 
;     993 void ProcessCommand()
;     994 {
_ProcessCommand:
;     995    	#asm("cli"); 
	cli
;     996     RESET_WATCHDOG();
	WDR
;     997     // Turn off the scan board           
;     998     _powerOff();
	CALL __powerOff_G1
;     999     // serial message processing     
;    1000     switch (rx_message)
	MOV  R30,R10
;    1001     {                  
;    1002     case LOAD_TEXT_MSG:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0xCA
;    1003         {
;    1004             if (rx_wparam > DATA_LENGTH) rx_wparam = DATA_LENGTH;
	LDI  R30,LOW(3792)
	LDI  R31,HIGH(3792)
	CP   R30,R11
	CPC  R31,R12
	BRSH _0xCB
	__PUTW1R 11,12
;    1005             BlankRAM((PBYTE)START_RAM_TEXT,(PBYTE)END_RAM);
_0xCB:
	LDI  R30,LOW(2432)
	LDI  R31,HIGH(2432)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;    1006             frame_index = rx_lparam>>8;                       
	STS  _frame_index_G1,R14
;    1007             char_count  = rx_lparam&0x00FF;                   
	__GETW1R 13,14
	ANDI R31,HIGH(0xFF)
	STS  _char_count_G1,R30
	STS  _char_count_G1+1,R31
;    1008             text_length = rx_wparam;   
	__PUTWMRN _text_length_G1,0,11,12
;    1009             SerialToRAM((PBYTE)START_RAM_TEXT + SCREEN_WIDTH,text_length,FRAME_TEXT);                
	LDI  R30,LOW(2576)
	LDI  R31,HIGH(2576)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _SerialToRAM
;    1010             LoadCharWidth(char_count);                                                              
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _LoadCharWidth
;    1011 			start_mem = (PBYTE)START_RAM_TEXT + SCREEN_WIDTH;				
	LDI  R30,LOW(2576)
	LDI  R31,HIGH(2576)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;    1012 	    	bkgnd_mem = (PBYTE)START_RAM_BK;		    		    		    	
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _bkgnd_mem_G1,R30
	STS  _bkgnd_mem_G1+1,R31
;    1013 
;    1014             SaveCharWidth(char_count,frame_index);                           
	LDS  R30,_char_count_G1
	LDS  R31,_char_count_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	CALL _SaveCharWidth
;    1015             SaveTextLength(text_length,frame_index);
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	CALL _SaveTextLength
;    1016             SaveToEEPROM((PBYTE)START_RAM_TEXT,FRAME_TEXT,frame_index);            
	LDI  R30,LOW(2432)
	LDI  R31,HIGH(2432)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	CALL _SaveToEEPROM
;    1017             current_char_width = next_char_width = 0xFFFF;								  
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _next_char_width_G1,R30
	STS  _next_char_width_G1+1,R31
	STS  _current_char_width_G1,R30
	STS  _current_char_width_G1+1,R31
;    1018         }				
;    1019         break;
	RJMP _0xC9
;    1020     case LOAD_BKGND_MSG:
_0xCA:
	CPI  R30,LOW(0x2)
	BRNE _0xCC
;    1021         {
;    1022             if (rx_wparam > SCREEN_WIDTH) rx_wparam = SCREEN_WIDTH;
	LDI  R30,LOW(144)
	LDI  R31,HIGH(144)
	CP   R30,R11
	CPC  R31,R12
	BRSH _0xCD
	__PUTW1R 11,12
;    1023             frame_index = rx_lparam>>8;  
_0xCD:
	STS  _frame_index_G1,R14
;    1024             BlankRAM((PBYTE)START_RAM_BK,(PBYTE)START_RAM_TEXT);                    
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2432)
	LDI  R31,HIGH(2432)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;    1025             SerialToRAM((PBYTE)START_RAM_BK,rx_wparam,FRAME_BKGND);                                               
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R12
	ST   -Y,R11
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _SerialToRAM
;    1026 		    start_mem = (PBYTE)START_RAM_TEXT + SCREEN_WIDTH;				
	LDI  R30,LOW(2576)
	LDI  R31,HIGH(2576)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;    1027 		    bkgnd_mem = (PBYTE)START_RAM_BK;	
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _bkgnd_mem_G1,R30
	STS  _bkgnd_mem_G1+1,R31
;    1028 		    
;    1029 		    SaveToEEPROM((PBYTE)START_RAM_BK,FRAME_BKGND,frame_index);			    
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	CALL _SaveToEEPROM
;    1030 		}
;    1031         break; 
	RJMP _0xC9
;    1032     case SET_CFG_MSG:
_0xCC:
	CPI  R30,LOW(0x5)
	BRNE _0xCE
;    1033         {    
;    1034             frame_index = rx_lparam>>8;
	STS  _frame_index_G1,R14
;    1035             scroll_type  = rx_wparam&0x00FF;
	__GETW1R 11,12
	STS  _scroll_type_G1,R30
;    1036             scroll_rate = rx_wparam>>8;             
	STS  _scroll_rate_G1,R12
;    1037             SaveConfig(frame_index);
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	CALL _SaveConfig
;    1038         }
;    1039         break;   
	RJMP _0xC9
;    1040     case SET_RTC_MSG:
_0xCE:
	CPI  R30,LOW(0x4)
	BRNE _0xD0
;    1041         {                                
;    1042             SetRTCDateTime();
	CALL _SetRTCDateTime
;    1043         }
;    1044         break;    
;    1045     default:
_0xD0:
;    1046         break;
;    1047     }                 
_0xC9:
;    1048     send_echo_msg();            
	RCALL _send_echo_msg
;    1049     rx_message = UNKNOWN_MSG;
	CLR  R10
;    1050     #asm("sei");
	sei
;    1051     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;    1052     DDRD = 0x3F;     
	LDI  R30,LOW(63)
	OUT  0x11,R30
;    1053 
;    1054 }          
	RET
;    1055 ////////////////////////////////////////////////////////////////////////////////
;    1056 // MAIN PROGRAM
;    1057 ////////////////////////////////////////////////////////////////////////////////
;    1058 void main(void)
;    1059 {         
_main:
;    1060     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0xD1
;    1061         // Watchdog Reset
;    1062         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;    1063         reset_serial(); 
	RCALL _reset_serial
;    1064     }
;    1065     else {      
	RJMP _0xD2
_0xD1:
;    1066         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;    1067     }                                     
_0xD2:
;    1068      
;    1069     PowerReset();                        
	CALL _PowerReset
;    1070     #asm("sei");     
	sei
;    1071             
;    1072     while (1){                     
_0xD3:
;    1073         if (rx_message != UNKNOWN_MSG){   
	TST  R10
	BREQ _0xD6
;    1074             ProcessCommand();   
	CALL _ProcessCommand
;    1075         }
;    1076         else{                     
	RJMP _0xD7
_0xD6:
;    1077             _doScroll();
	CALL __doScroll_G1
;    1078             _displayFrame();         
	CALL __displayFrame_G1
;    1079         }
_0xD7:
;    1080         RESET_WATCHDOG();
	WDR
;    1081     }
	JMP  _0xD3
;    1082 }
_0xD8:
	NOP
	RJMP _0xD8
;    1083                          
;    1084 #include "define.h"
;    1085 
;    1086 ///////////////////////////////////////////////////////////////
;    1087 // serial interrupt handle - processing serial message ...
;    1088 ///////////////////////////////////////////////////////////////
;    1089 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;    1090 ///////////////////////////////////////////////////////////////
;    1091 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;    1092 extern BYTE  rx_message;
;    1093 extern WORD  rx_wparam;
;    1094 extern WORD  rx_lparam;
;    1095 
;    1096 #if RX_BUFFER_SIZE<256
;    1097 unsigned char rx_wr_index,rx_counter;
_rx_wr_index:
	.BYTE 0x1
_rx_counter:
	.BYTE 0x1
;    1098 #else
;    1099 unsigned int rx_wr_index,rx_counter;
;    1100 #endif
;    1101 
;    1102 void send_echo_msg();
;    1103 
;    1104 // USART Receiver interrupt service routine
;    1105 #ifdef _MEGA162_INCLUDED_                    
;    1106 interrupt [USART0_RXC] void usart_rx_isr(void)
;    1107 #else
;    1108 interrupt [USART_RXC] void usart_rx_isr(void)
;    1109 #endif
;    1110 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;    1111 char status,data;
;    1112 #ifdef _MEGA162_INCLUDED_  
;    1113 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;    1114 data=UDR0;
	IN   R17,12
;    1115 #else     
;    1116 status=UCSRA;
;    1117 data=UDR;
;    1118 #endif          
;    1119     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+3
	JMP _0xD9
;    1120     {
;    1121         rx_buffer[rx_wr_index]=data; 
	LDS  R26,_rx_wr_index
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;    1122         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	LDS  R26,_rx_wr_index
	SUBI R26,-LOW(1)
	STS  _rx_wr_index,R26
	CPI  R26,LOW(0x8)
	BRNE _0xDA
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
;    1123         if (++rx_counter == RX_BUFFER_SIZE)
_0xDA:
	LDS  R26,_rx_counter
	SUBI R26,-LOW(1)
	STS  _rx_counter,R26
	CPI  R26,LOW(0x8)
	BREQ PC+3
	JMP _0xDB
;    1124         {
;    1125             rx_counter=0;
	LDI  R30,LOW(0)
	STS  _rx_counter,R30
;    1126             if (
;    1127                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;    1128                 rx_buffer[2]==WAKEUP_CHAR 
;    1129                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BRNE _0xDD
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BRNE _0xDD
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ _0xDE
_0xDD:
	RJMP _0xDC
_0xDE:
;    1130             {
;    1131                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 10,_rx_buffer,3
;    1132                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 11,_rx_buffer,4
	CLR  R12
;    1133                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;    1134                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 13,_rx_buffer,6
	CLR  R14
;    1135                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R13
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 13,14
;    1136             }
;    1137             else if(
	RJMP _0xDF
_0xDC:
;    1138                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;    1139                 rx_buffer[2]==ESCAPE_CHAR 
;    1140                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0xE1
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0xE1
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0xE2
_0xE1:
	RJMP _0xE0
_0xE2:
;    1141             {
;    1142                 rx_wr_index=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
;    1143                 rx_counter =0;
	STS  _rx_counter,R30
;    1144             }      
;    1145         };
_0xE0:
_0xDF:
_0xDB:
;    1146     };
_0xD9:
;    1147 }
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;    1148 
;    1149 void send_echo_msg()
;    1150 {
_send_echo_msg:
;    1151     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;    1152     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;    1153     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;    1154     putchar(rx_message);
	ST   -Y,R10
	CALL _putchar
;    1155     putchar(rx_wparam>>8);
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;    1156     putchar(rx_wparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;    1157     putchar(rx_lparam>>8);        
	MOV  R30,R14
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;    1158     putchar(rx_lparam&0x00FF);
	__GETW1R 13,14
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;    1159 }  
	RET
;    1160 
;    1161 void reset_serial()
;    1162 {
_reset_serial:
;    1163     rx_wr_index=0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
;    1164     rx_counter =0;
	STS  _rx_counter,R30
;    1165     rx_message = UNKNOWN_MSG;
	CLR  R10
;    1166 }
	RET
;    1167 
;    1168 ///////////////////////////////////////////////////////////////
;    1169 // END serial interrupt handle
;    1170 /////////////////////////////////////////////////////////////// 
;    1171 /*****************************************************
;    1172 This program was produced by the
;    1173 CodeWizardAVR V1.24.4a Standard
;    1174 Automatic Program Generator
;    1175 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;    1176 http://www.hpinfotech.com
;    1177 e-mail:office@hpinfotech.com
;    1178 
;    1179 Project : 
;    1180 Version : 
;    1181 Date    : 19/5/2005
;    1182 Author  : 3iGROUP                
;    1183 Company : http://www.3ihut.net   
;    1184 Comments: 
;    1185 
;    1186 
;    1187 Chip type           : ATmega8515
;    1188 Program type        : Application
;    1189 Clock frequency     : 8.000000 MHz
;    1190 Memory model        : Small
;    1191 External SRAM size  : 32768
;    1192 Ext. SRAM wait state: 0
;    1193 Data Stack size     : 128
;    1194 *****************************************************/
;    1195 
;    1196 #include "define.h"                                           
;    1197 
;    1198 #define     ACK                 1
;    1199 #define     NO_ACK              0
;    1200 
;    1201 // I2C Bus functions
;    1202 #asm
;    1203    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;    1204    .equ __sda_bit=3
   .equ __sda_bit=3
;    1205    .equ __scl_bit=2
   .equ __scl_bit=2
;    1206 #endasm                   
;    1207 
;    1208 #ifdef __EEPROM_WRITE_BYTE
;    1209 BYTE eeprom_read(BYTE deviceID, PBYTE address) 
;    1210 {
_eeprom_read:
;    1211     BYTE data;
;    1212     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	*address -> Y+1
;	data -> R16
	CALL _i2c_start
;    1213     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;    1214     i2c_write((WORD)address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;    1215     i2c_write((WORD)address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;    1216     
;    1217     i2c_start();
	CALL _i2c_start
;    1218     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;    1219     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R16,R30
;    1220     i2c_stop();
	CALL _i2c_stop
;    1221     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0x177
;    1222 }
;    1223 
;    1224 void eeprom_write(BYTE deviceID, PBYTE address, BYTE data) 
;    1225 {
_eeprom_write:
;    1226     i2c_start();
;	deviceID -> Y+3
;	*address -> Y+1
;	data -> Y+0
	CALL _i2c_start
;    1227     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;    1228     i2c_write((WORD)address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;    1229     i2c_write((WORD)address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;    1230     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	CALL _i2c_write
;    1231     i2c_stop();
	CALL _i2c_stop
;    1232 
;    1233     /* 10ms delay to complete the write operation */
;    1234     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;    1235 }                                 
_0x177:
	ADIW R28,4
	RET
;    1236 
;    1237 WORD eeprom_read_w(BYTE deviceID, PBYTE address)
;    1238 {
_eeprom_read_w:
;    1239     WORD result = 0;
;    1240     result = eeprom_read(deviceID,address);
	ST   -Y,R17
	ST   -Y,R16
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
	CALL _eeprom_read
	MOV  R16,R30
	CLR  R17
;    1241     result = (result<<8) | eeprom_read(deviceID,address+1);
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
;    1242     return result;
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x176
;    1243 }
;    1244 void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data)
;    1245 {
_eeprom_write_w:
;    1246     eeprom_write(deviceID,address,data>>8);
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
	CALL _eeprom_write
;    1247     eeprom_write(deviceID,address+1,data&0x0FF);    
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
;    1248 }
_0x176:
	ADIW R28,5
	RET
;    1249 
;    1250 #endif // __EEPROM_WRITE_BYTE
;    1251 void eeprom_read_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
;    1252 {
_eeprom_read_page:
;    1253     BYTE i = 0;
;    1254     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	*address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;    1255     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;    1256     i2c_write((WORD)address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;    1257     i2c_write((WORD)address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;    1258     
;    1259     i2c_start();
	CALL _i2c_start
;    1260     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;    1261                                     
;    1262     while ( i < page_size-1 )
_0xE3:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0xE5
;    1263     {
;    1264         buffer[i++] = i2c_read(ACK);   // read at current
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
;    1265     }
	RJMP _0xE3
_0xE5:
;    1266     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
;    1267          
;    1268     i2c_stop();
	CALL _i2c_stop
;    1269 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;    1270 
;    1271 void eeprom_write_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
;    1272 {
_eeprom_write_page:
;    1273     BYTE i = 0;
;    1274     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	*address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;    1275     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;    1276     i2c_write((WORD)address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;    1277     i2c_write((WORD)address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;    1278                                         
;    1279     while ( i < page_size )
_0xE6:
	LDD  R30,Y+1
	CP   R16,R30
	BRSH _0xE8
;    1280     {
;    1281         i2c_write(buffer[i++]);
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
;    1282         #asm("nop");#asm("nop");
	nop
	nop
;    1283     }          
	JMP  _0xE6
_0xE8:
;    1284     i2c_stop(); 
	CALL _i2c_stop
;    1285     delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;    1286 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;    1287                                               
;    1288 #include "define.h"
;    1289 
;    1290 #define DWORD long int
;    1291 
;    1292 const DWORD TK21[] ={
;    1293 	0x46c960, 0x2ed954, 0x54d4a0, 0x3eda50, 0x2a7552, 0x4e56a0, 0x38a7a7, 0x5ea5d0, 0x4a92b0, 0x32aab5,
;    1294 	0x58a950, 0x42b4a0, 0x2cbaa4, 0x50ad50, 0x3c55d9, 0x624ba0, 0x4ca5b0, 0x375176, 0x5c5270, 0x466930,
;    1295 	0x307934, 0x546aa0, 0x3ead50, 0x2a5b52, 0x504b60, 0x38a6e6, 0x5ea4e0, 0x48d260, 0x32ea65, 0x56d520,
;    1296 	0x40daa0, 0x2d56a3, 0x5256d0, 0x3c4afb, 0x6249d0, 0x4ca4d0, 0x37d0b6, 0x5ab250, 0x44b520, 0x2edd25,
;    1297 	0x54b5a0, 0x3e55d0, 0x2a55b2, 0x5049b0, 0x3aa577, 0x5ea4b0, 0x48aa50, 0x33b255, 0x586d20, 0x40ad60,
;    1298 	0x2d4b63, 0x525370, 0x3e49e8, 0x60c970, 0x4c54b0, 0x3768a6, 0x5ada50, 0x445aa0, 0x2fa6a4, 0x54aad0,
;    1299 	0x4052e0, 0x28d2e3, 0x4ec950, 0x38d557, 0x5ed4a0, 0x46d950, 0x325d55, 0x5856a0, 0x42a6d0, 0x2c55d4,
;    1300 	0x5252b0, 0x3ca9b8, 0x62a930, 0x4ab490, 0x34b6a6, 0x5aad50, 0x4655a0, 0x2eab64, 0x54a570, 0x4052b0,
;    1301 	0x2ab173, 0x4e6930, 0x386b37, 0x5e6aa0, 0x48ad50, 0x332ad5, 0x582b60, 0x42a570, 0x2e52e4, 0x50d160,
;    1302 	0x3ae958, 0x60d520, 0x4ada90, 0x355aa6, 0x5a56d0, 0x462ae0, 0x30a9d4, 0x54a2d0, 0x3ed150, 0x28e952
;    1303 }; /* Years 2000-2099 */
;    1304 
;    1305 //char CAN[10][10] = {"Giap", "At", "Binh", "Dinh", "Mau", "Ky", "Canh", "Tan", "Nham", "Quy"};
;    1306 //char CHI[12][10] = {"Ty'", "Suu", "Dan", "Mao", "Thin", "Ty.", "Ngo", "Mui", "Than", "Dau", "Tuat", "Hoi"};
;    1307 //char TUAN[7][10] = {"Chu Nhat", "Thu Hai", "Thu Ba", "Thu Tu", "Thu Nam", "Thu Sau", "Thu Bay"};
;    1308 
;    1309 typedef struct _LunarDate{
;    1310     BYTE day;
;    1311     BYTE month;
;    1312     WORD year;
;    1313     BYTE leap;
;    1314     DWORD jd; 
;    1315 } LUNAR_DATE;
;    1316               
;    1317 LUNAR_DATE ld;

	.DSEG
_ld:
	.BYTE 0x9
;    1318 LUNAR_DATE ly[14];
_ly:
	.BYTE 0x7E
;    1319 
;    1320 DWORD jdn(int dd, int mm, int yy) {

	.CSEG
_jdn:
;    1321 	int a=0, y=0, m=0;
;    1322 	a = ((14 - mm) / 12);
	CALL __SAVELOCR6
;	dd -> Y+10
;	mm -> Y+8
;	yy -> Y+6
;	a -> R16,R17
;	y -> R18,R19
;	m -> R20,R21
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	LDI  R20,0
	LDI  R21,0
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(14)
	LDI  R31,HIGH(14)
	SUB  R30,R26
	SBC  R31,R27
	MOVW R26,R30
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	CALL __DIVW21
	MOVW R16,R30
;    1323 	y = yy+4800-a;
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-4800)
	SBCI R31,HIGH(-4800)
	SUB  R30,R16
	SBC  R31,R17
	MOVW R18,R30
;    1324 	m = mm+12*a-3;	
	MOVW R30,R16
	LDI  R26,LOW(12)
	LDI  R27,HIGH(12)
	CALL __MULW12
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R26,R30
	ADC  R27,R31
	SBIW R26,3
	MOVW R20,R26
;    1325 	return (DWORD)((153*m+2)/5  + 365*y - (y/100) - 32045 + dd + (y/4)  + (y/400));
	MOVW R30,R20
	LDI  R26,LOW(153)
	LDI  R27,HIGH(153)
	CALL __MULW12
	ADIW R30,2
	MOVW R26,R30
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CALL __DIVW21
	MOVW R22,R30
	MOVW R30,R18
	LDI  R26,LOW(365)
	LDI  R27,HIGH(365)
	CALL __MULW12
	__ADDWRR 22,23,30,31
	MOVW R26,R18
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21
	MOVW R26,R22
	SUB  R26,R30
	SBC  R27,R31
	LDI  R30,LOW(32045)
	LDI  R31,HIGH(32045)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	MOVW R26,R18
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CALL __DIVW21
	__ADDWRR 22,23,30,31
	MOVW R26,R18
	LDI  R30,LOW(400)
	LDI  R31,HIGH(400)
	CALL __DIVW21
	ADD  R30,R22
	ADC  R31,R23
	CALL __CWD1
	CALL __LOADLOCR6
	RJMP _0x175
;    1326 }
;    1327 
;    1328 void decodeLunarYear(int yy, DWORD k) {	
_decodeLunarYear:
;    1329 	int regularMonths[12];
;    1330 	int monthLengths[2]={29,30};
;    1331 	DWORD offsetOfTet=0,currentJD=0,solarNY=0;
;    1332 	int leapMonth=0,leapMonthLength=0;
;    1333 	int i=0, j=0,mm=0;
;    1334 	offsetOfTet = k >> 17;
	SBIW R28,44
	LDI  R24,20
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0xE9*2)
	LDI  R31,HIGH(_0xE9*2)
	CALL __INITLOCB
	CALL __SAVELOCR6
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
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	LDI  R20,0
	LDI  R21,0
	__GETD2S 50
	LDI  R30,LOW(17)
	CALL __ASRD12
	__PUTD1S 18
;    1335 	leapMonth = k & 0xf;
	__GETD1S 50
	__ANDD1N 0xF
	MOVW R16,R30
;    1336 	leapMonthLength = monthLengths[k >> 16 & 0x1];
	LDI  R30,LOW(16)
	CALL __ASRD12
	__ANDD1N 0x1
	MOVW R26,R28
	ADIW R26,22
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R18,X+
	LD   R19,X
;    1337 	solarNY = jdn(1, 1, yy);
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+58
	LDD  R31,Y+58+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _jdn
	__PUTD1S 10
;    1338 	currentJD = (DWORD)(solarNY+offsetOfTet);
	__GETD1S 18
	__GETD2S 10
	CALL __ADDD12
	__PUTD1S 14
;    1339 	j = k >> 4;
	__GETD2S 50
	LDI  R30,LOW(4)
	CALL __ASRD12
	STD  Y+8,R30
	STD  Y+8+1,R31
;    1340 	for(i = 0; i < 12; i++) {
	__GETWRN 20,21,0
_0xEB:
	__CPWRN 20,21,12
	BRGE _0xEC
;    1341 		regularMonths[12 - i - 1] = monthLengths[j & 0x1];
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	SUB  R30,R20
	SBC  R31,R21
	SBIW R30,1
	MOVW R26,R28
	ADIW R26,26
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ANDI R30,LOW(0x1)
	ANDI R31,HIGH(0x1)
	MOVW R26,R28
	ADIW R26,22
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	MOVW R26,R0
	ST   X+,R30
	ST   X,R31
;    1342 		j >>= 1;
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ASR  R31
	ROR  R30
	STD  Y+8,R30
	STD  Y+8+1,R31
;    1343 	}
	__ADDWRN 20,21,1
	RJMP _0xEB
_0xEC:
;    1344 	if (leapMonth == 0) {
	MOV  R0,R16
	OR   R0,R17
	BREQ PC+3
	JMP _0xED
;    1345 		for(mm = 1; mm <= 12; mm++) {
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STD  Y+6,R30
	STD  Y+6+1,R31
_0xEF:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SBIW R26,13
	BRLT PC+3
	JMP _0xF0
;    1346 			ly[mm].day = 1;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	SUBI R30,LOW(-_ly)
	SBCI R31,HIGH(-_ly)
	MOVW R26,R30
	LDI  R30,LOW(1)
	ST   X,R30
;    1347 			ly[mm].month = mm;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__POINTW2MN _ly,1
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+6
	ST   X,R30
;    1348 			ly[mm].year = yy;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__ADDW1MN _ly,2
	LDD  R26,Y+54
	LDD  R27,Y+54+1
	STD  Z+0,R26
	STD  Z+1,R27
;    1349 			ly[mm].leap = 0;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__POINTW2MN _ly,4
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	ST   X,R30
;    1350 			ly[mm].jd = currentJD;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__ADDW1MN _ly,5
	__GETD2S 14
	__PUTDZ2 0
;    1351 			currentJD += regularMonths[mm-1];
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,1
	MOVW R26,R28
	ADIW R26,26
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	__GETD2S 14
	CALL __CWD1
	CALL __ADDD12
	__PUTD1S 14
;    1352 		}
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0xEF
_0xF0:
;    1353 	} else {
	RJMP _0xF1
_0xED:
;    1354 		for(mm = 1; mm <= leapMonth; mm++) {
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STD  Y+6,R30
	STD  Y+6+1,R31
_0xF3:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R16,R26
	CPC  R17,R27
	BRGE PC+3
	JMP _0xF4
;    1355 			ly[mm].day = 1;
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	SUBI R30,LOW(-_ly)
	SBCI R31,HIGH(-_ly)
	MOVW R26,R30
	LDI  R30,LOW(1)
	ST   X,R30
;    1356 			ly[mm].month = mm;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__POINTW2MN _ly,1
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+6
	ST   X,R30
;    1357 			ly[mm].year = yy;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__ADDW1MN _ly,2
	LDD  R26,Y+54
	LDD  R27,Y+54+1
	STD  Z+0,R26
	STD  Z+1,R27
;    1358 			ly[mm].leap = 0;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__POINTW2MN _ly,4
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	ST   X,R30
;    1359 			ly[mm].jd = currentJD;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__ADDW1MN _ly,5
	__GETD2S 14
	__PUTDZ2 0
;    1360 			currentJD += regularMonths[mm-1];
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,1
	MOVW R26,R28
	ADIW R26,26
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	__GETD2S 14
	CALL __CWD1
	CALL __ADDD12
	__PUTD1S 14
;    1361 		}		
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0xF3
_0xF4:
;    1362 		ly[mm].day = 1;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	SUBI R30,LOW(-_ly)
	SBCI R31,HIGH(-_ly)
	MOVW R26,R30
	LDI  R30,LOW(1)
	ST   X,R30
;    1363 			ly[mm].month = leapMonth;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__POINTW2MN _ly,1
	ADD  R26,R30
	ADC  R27,R31
	ST   X,R16
;    1364 			ly[mm].year = yy;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__ADDW1MN _ly,2
	LDD  R26,Y+54
	LDD  R27,Y+54+1
	STD  Z+0,R26
	STD  Z+1,R27
;    1365 			ly[mm].leap = 0;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__POINTW2MN _ly,4
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	ST   X,R30
;    1366 			ly[mm].jd = currentJD;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__ADDW1MN _ly,5
	__GETD2S 14
	__PUTDZ2 0
;    1367 		currentJD += leapMonthLength;
	MOVW R30,R18
	CALL __CWD1
	CALL __ADDD12
	__PUTD1S 14
;    1368 		for(mm = leapMonth+2; mm <= 13; mm++) {
	MOVW R30,R16
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0xF6:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SBIW R26,14
	BRLT PC+3
	JMP _0xF7
;    1369 			ly[mm].day = 1;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	SUBI R30,LOW(-_ly)
	SBCI R31,HIGH(-_ly)
	MOVW R26,R30
	LDI  R30,LOW(1)
	ST   X,R30
;    1370 			ly[mm].month = mm-1;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__POINTW2MN _ly,1
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,1
	ST   X,R30
;    1371 			ly[mm].year = yy;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__ADDW1MN _ly,2
	LDD  R26,Y+54
	LDD  R27,Y+54+1
	STD  Z+0,R26
	STD  Z+1,R27
;    1372 			ly[mm].leap = 0;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__POINTW2MN _ly,4
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	ST   X,R30
;    1373 			ly[mm].jd = currentJD;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(9)
	CALL __MULB1W2U
	__ADDW1MN _ly,5
	__GETD2S 14
	__PUTDZ2 0
;    1374 			currentJD += regularMonths[mm-2];
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,2
	MOVW R26,R28
	ADIW R26,26
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	__GETD2S 14
	CALL __CWD1
	CALL __ADDD12
	__PUTD1S 14
;    1375 		}
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0xF6
_0xF7:
;    1376 	}	
_0xF1:
;    1377 }
	CALL __LOADLOCR6
	ADIW R28,56
	RET
;    1378 
;    1379 void getYearInfo(int yyyy) {
_getYearInfo:
;    1380 	DWORD yearCode = 0;
;    1381 	yearCode = TK21[yyyy - 2000];
	SBIW R28,4
	LDI  R24,4
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0xF8*2)
	LDI  R31,HIGH(_0xF8*2)
	CALL __INITLOCB
;	yyyy -> Y+4
;	yearCode -> Y+0
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SUBI R30,LOW(2000)
	SBCI R31,HIGH(2000)
	LDI  R26,LOW(_TK21*2)
	LDI  R27,HIGH(_TK21*2)
	CALL __LSLW2
	ADD  R30,R26
	ADC  R31,R27
	CALL __GETD1PF
	__PUTD1S 0
;    1382 	decodeLunarYear(yyyy, yearCode);
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 2
	CALL __PUTPARD1
	CALL _decodeLunarYear
;    1383 }
	ADIW R28,6
	RET
;    1384 
;    1385 void getLunarDate(int dd, int mm, int yyyy) {
_getLunarDate:
;    1386 	int i =13;
;    1387 	DWORD jd =0;	
;    1388 	getYearInfo(yyyy);
	SBIW R28,4
	LDI  R24,4
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0xF9*2)
	LDI  R31,HIGH(_0xF9*2)
	CALL __INITLOCB
	ST   -Y,R17
	ST   -Y,R16
;	dd -> Y+10
;	mm -> Y+8
;	yyyy -> Y+6
;	i -> R16,R17
;	jd -> Y+2
	LDI  R16,13
	LDI  R17,0
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _getYearInfo
;    1389 	jd = jdn(dd, mm, yyyy);
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _jdn
	__PUTD1S 2
;    1390 	if (jd < ly[1].jd) {
	__GETD1MN _ly,14
	__GETD2S 2
	CALL __CPD21
	BRGE _0xFA
;    1391 		getYearInfo(yyyy - 1);
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	CALL _getYearInfo
;    1392 	}	
;    1393 	if (ly[13].jd==0) i=12;
_0xFA:
	__GETD1MN _ly,122
	CALL __CPD10
	BRNE _0xFB
	__GETWRN 16,17,12
;    1394 	while (jd < ly[i].jd) {
_0xFB:
_0xFC:
	__MULBNWRU 16,17,9
	__POINTW2MN _ly,5
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	__GETD2S 2
	CALL __CPD21
	BRGE _0xFE
;    1395 		i--;
	__SUBWRN 16,17,1
;    1396 	}	
	RJMP _0xFC
_0xFE:
;    1397 	ld.day = ly[i].day + jd - ly[i].jd;	
	__MULBNWRU 16,17,9
	SUBI R30,LOW(-_ly)
	SBCI R31,HIGH(-_ly)
	LD   R30,Z
	MOV  R26,R30
	__GETD1S 2
	CLR  R27
	CLR  R24
	CLR  R25
	CALL __ADDD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	__MULBNWRU 16,17,9
	__POINTW2MN _ly,5
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __SWAPD12
	CALL __SUBD12
	STS  _ld,R30
;    1398 	ld.month = ly[i].month;
	__MULBNWRU 16,17,9
	__POINTW2MN _ly,1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	__PUTB1MN _ld,1
;    1399 	ld.year = ly[i].year;
	__MULBNWRU 16,17,9
	__POINTW2MN _ly,2
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	__PUTW1MN _ld,2
;    1400 	ld.leap = ly[i].leap;
	__MULBNWRU 16,17,9
	__POINTW2MN _ly,4
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	__PUTB1MN _ld,4
;    1401 	ld.jd = jd;
	__GETD1S 2
	__PUTD1MN _ld,5
;    1402 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x175
;    1403 
;    1404 void getLunarStr(char* sz, short h, short m, short dd, short mm, int yyyy){	
_getLunarStr:
;    1405 	getLunarDate(dd, mm, yyyy);	
;	*sz -> Y+10
;	h -> Y+8
;	m -> Y+6
;	dd -> Y+4
;	mm -> Y+2
;	yyyy -> Y+0
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _getLunarDate
;    1406 	
;    1407 	sprintf(sz,"B©y giê lµ %02d:%02d ngµy %d/%d/%d (%d/%d ¢m lÞch)",	            
;    1408                 h,m,dd,mm,yyyy,
;    1409                 ld.day,ld.month);
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,193
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	CALL __CWD1
	CALL __PUTPARD1
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	CALL __CWD1
	CALL __PUTPARD1
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	CALL __CWD1
	CALL __PUTPARD1
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	CALL __CWD1
	CALL __PUTPARD1
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	CALL __CWD1
	CALL __PUTPARD1
	LDS  R30,_ld
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	__GETB1MN _ld,1
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,28
	CALL _sprintf
	ADIW R28,32
;    1410              
;    1411 /*	sprintf(sz,"%s %s,%s,%s",
;    1412 	    TUAN[(ld[4] + 1)%7],
;    1413 	    CAN[(ld[4] + 9)%10],CHI[(ld[4]+1)%12],
;    1414 	    CAN[(ld[2]*12+ld[1]+3)%10],CHI[(ld[1]+1)%12],
;    1415 	    CAN[(ld[2]+6)%10],CHI[(ld[2]+8)%12]);
;    1416 */	    
;    1417 }
_0x175:
	ADIW R28,12
	RET

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
	CALL __GETW1P
	SBIW R30,0
	BREQ _0xFF
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0x100
_0xFF:
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _putchar
_0x100:
	RJMP _0x172
__print_G5:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R16,0
_0x101:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	ADIW R30,1
	STD  Y+16,R30
	STD  Y+16+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R19,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x103
	MOV  R30,R16
	CPI  R30,0
	BRNE _0x107
	CPI  R19,37
	BRNE _0x108
	LDI  R16,LOW(1)
	RJMP _0x109
_0x108:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
_0x109:
	RJMP _0x106
_0x107:
	CPI  R30,LOW(0x1)
	BRNE _0x10A
	CPI  R19,37
	BRNE _0x10B
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	RJMP _0x183
_0x10B:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0x10C
	LDI  R17,LOW(1)
	RJMP _0x106
_0x10C:
	CPI  R19,43
	BRNE _0x10D
	LDI  R21,LOW(43)
	RJMP _0x106
_0x10D:
	CPI  R19,32
	BRNE _0x10E
	LDI  R21,LOW(32)
	RJMP _0x106
_0x10E:
	RJMP _0x10F
_0x10A:
	CPI  R30,LOW(0x2)
	BRNE _0x110
_0x10F:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0x111
	ORI  R17,LOW(128)
	RJMP _0x106
_0x111:
	RJMP _0x112
_0x110:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x106
_0x112:
	CPI  R19,48
	BRLO _0x115
	CPI  R19,58
	BRLO _0x116
_0x115:
	RJMP _0x114
_0x116:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x106
_0x114:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0x11A
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
	RJMP _0x11B
_0x11A:
	CPI  R30,LOW(0x73)
	BRNE _0x11D
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen
	MOV  R16,R30
	RJMP _0x11E
_0x11D:
	CPI  R30,LOW(0x70)
	BRNE _0x120
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlenf
	MOV  R16,R30
	ORI  R17,LOW(8)
_0x11E:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0x121
_0x120:
	CPI  R30,LOW(0x64)
	BREQ _0x124
	CPI  R30,LOW(0x69)
	BRNE _0x125
_0x124:
	ORI  R17,LOW(4)
	RJMP _0x126
_0x125:
	CPI  R30,LOW(0x75)
	BRNE _0x127
_0x126:
	LDI  R30,LOW(_tbl10_G5*2)
	LDI  R31,HIGH(_tbl10_G5*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0x128
_0x127:
	CPI  R30,LOW(0x58)
	BRNE _0x12A
	ORI  R17,LOW(8)
	RJMP _0x12B
_0x12A:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x15C
_0x12B:
	LDI  R30,LOW(_tbl16_G5*2)
	LDI  R31,HIGH(_tbl16_G5*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0x128:
	SBRS R17,2
	RJMP _0x12D
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	SBIW R26,0
	BRGE _0x12E
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0x12E:
	CPI  R21,0
	BREQ _0x12F
	SUBI R16,-LOW(1)
	RJMP _0x130
_0x12F:
	ANDI R17,LOW(251)
_0x130:
	RJMP _0x131
_0x12D:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0x131:
_0x121:
	SBRC R17,0
	RJMP _0x132
_0x133:
	CP   R16,R20
	BRSH _0x135
	SBRS R17,7
	RJMP _0x136
	SBRS R17,2
	RJMP _0x137
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0x138
_0x137:
	LDI  R19,LOW(48)
_0x138:
	RJMP _0x139
_0x136:
	LDI  R19,LOW(32)
_0x139:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	SUBI R20,LOW(1)
	RJMP _0x133
_0x135:
_0x132:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0x13A
_0x13B:
	CPI  R18,0
	BREQ _0x13D
	SBRS R17,3
	RJMP _0x13E
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x184
_0x13E:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x184:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	CPI  R20,0
	BREQ _0x140
	SUBI R20,LOW(1)
_0x140:
	SUBI R18,LOW(1)
	RJMP _0x13B
_0x13D:
	RJMP _0x141
_0x13A:
_0x143:
	LDI  R19,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,2
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
_0x145:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x147
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x145
_0x147:
	CPI  R19,58
	BRLO _0x148
	SBRS R17,3
	RJMP _0x149
	SUBI R19,-LOW(7)
	RJMP _0x14A
_0x149:
	SUBI R19,-LOW(39)
_0x14A:
_0x148:
	SBRC R17,4
	RJMP _0x14C
	CPI  R19,49
	BRSH _0x14E
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x14D
_0x14E:
	RJMP _0x185
_0x14D:
	CP   R20,R18
	BRLO _0x152
	SBRS R17,0
	RJMP _0x153
_0x152:
	RJMP _0x151
_0x153:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0x154
	LDI  R19,LOW(48)
_0x185:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0x155
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	CPI  R20,0
	BREQ _0x156
	SUBI R20,LOW(1)
_0x156:
_0x155:
_0x154:
_0x14C:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	CPI  R20,0
	BREQ _0x157
	SUBI R20,LOW(1)
_0x157:
_0x151:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x144
	RJMP _0x143
_0x144:
_0x141:
	SBRS R17,0
	RJMP _0x158
_0x159:
	CPI  R20,0
	BREQ _0x15B
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G5
	RJMP _0x159
_0x15B:
_0x158:
_0x15C:
_0x11B:
_0x183:
	LDI  R16,LOW(0)
_0x106:
	RJMP _0x101
_0x103:
	CALL __LOADLOCR6
	ADIW R28,18
	RET
_sprintf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,2
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	CALL __ADDW2R15
	MOVW R16,R26
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	CALL __GETW1P
	STD  Y+2,R30
	STD  Y+2+1,R31
	MOVW R26,R28
	ADIW R26,4
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	RCALL __print_G5
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x174
_printf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,2
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	CALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,0
	STD  Y+2,R30
	STD  Y+2+1,R30
	MOVW R26,R28
	ADIW R26,4
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	RCALL __print_G5
_0x174:
	LDD  R17,Y+1
	LDD  R16,Y+0
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
	BREQ _0x170
	LDD  R30,Y+2
	ORI  R30,0x10
	STD  Y+2,R30
_0x170:
	LD   R30,Y
	CPI  R30,0
	BREQ _0x171
	LDD  R30,Y+2
	ORI  R30,0x80
	STD  Y+2,R30
_0x171:
	CALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	CALL _i2c_write
	LDI  R30,LOW(7)
	ST   -Y,R30
	CALL _i2c_write
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _i2c_write
	CALL _i2c_stop
	RJMP _0x172
_rtc_get_time:
	CALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	CALL _i2c_write
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_write
	CALL _i2c_start
	LDI  R30,LOW(209)
	ST   -Y,R30
	CALL _i2c_write
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_read
	ST   -Y,R30
	CALL _bcd2bin
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_read
	ST   -Y,R30
	CALL _bcd2bin
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	ST   -Y,R30
	CALL _bcd2bin
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	CALL _i2c_stop
	RJMP _0x173
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
	RJMP _0x172
_rtc_get_date:
	CALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	CALL _i2c_write
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL _i2c_write
	CALL _i2c_start
	LDI  R30,LOW(209)
	ST   -Y,R30
	CALL _i2c_write
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_read
	ST   -Y,R30
	CALL _bcd2bin
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _i2c_read
	ST   -Y,R30
	CALL _bcd2bin
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	ST   -Y,R30
	CALL _bcd2bin
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
	CALL _i2c_stop
_0x173:
	ADIW R28,6
	RET
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
_0x172:
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

__ADDD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	RET

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	RET

__ANEGW1:
	COM  R30
	COM  R31
	ADIW R30,1
	RET

__ASRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __ASRD12R
__ASRD12L:
	ASR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __ASRD12L
__ASRD12R:
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

__MULB1W2U:
	MOV  R22,R30
	MUL  R22,R26
	MOVW R30,R0
	MUL  R22,R27
	ADD  R31,R0
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

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
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

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__GETD1PF:
	LPM  R0,Z+
	LPM  R1,Z+
	LPM  R22,Z+
	LPM  R23,Z
	MOVW R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__CPD21:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
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
