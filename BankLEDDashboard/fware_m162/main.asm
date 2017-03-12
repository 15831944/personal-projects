
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
;      54 static UINT  char_width[256];    
_char_width_G1:
	.BYTE 0x200
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
	RJMP _0xFF
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
_0xFF:
	LD   R16,Y+
	RET
;     129 #define _DELAY_BUS      1
;     130 static void _displayLED()
;     131 {                                  
__displayLED_G1:
;     132     UINT i=0;    
;     133     BYTE mask=0,k=0;       
;     134     PBYTE buffer =(PBYTE)START_RAM+SCREEN_WIDTH;
;     135     CTRL_CLK = 0;
	CALL __SAVELOCR6
;	i -> R16,R17
;	mask -> R18
;	k -> R19
;	*buffer -> R20,R21
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	LDI  R20,LOW(0x568)
	LDI  R21,HIGH(0x568)
	CBI  0x18,5
;     136     CTRL_STB = 0;
	CBI  0x18,7
;     137     CTRL_DAT = 0;
	CBI  0x18,6
;     138     for (i=0; i< MAX_LED; i++){      
	__GETWRN 16,17,0
_0xD:
	__CPWRN 16,17,317
	BRSH _0xE
;     139         mask = 0x01;                      
	LDI  R18,LOW(1)
;     140         for (k=0; k< 8; k++){
	LDI  R19,LOW(0)
_0x10:
	CPI  R19,8
	BRSH _0x11
;     141 #ifdef __TEST_LED_        
;     142             BYTE data = 0;     
;     143             data= _xtable[i%(page_index+1)];
;     144             if ((data&mask)>>(k)){
;     145                 CTRL_DAT = 1;delay_us(_DELAY_BUS);
;     146             }
;     147             else{
;     148                 CTRL_DAT = 0;delay_us(_DELAY_BUS);
;     149             }
;     150 #else        
;     151             if ((buffer[MAX_LED-i-1]&mask)>>(k)){
	LDI  R30,LOW(317)
	LDI  R31,HIGH(317)
	SUB  R30,R16
	SBC  R31,R17
	SBIW R30,1
	ADD  R30,R20
	ADC  R31,R21
	LD   R30,Z
	AND  R30,R18
	MOV  R26,R30
	MOV  R30,R19
	CALL __LSRB12
	CPI  R30,0
	BREQ _0x12
;     152                 CTRL_DAT = 1;delay_us(_DELAY_BUS);
	SBI  0x18,6
	RJMP _0x100
;     153             }
;     154             else{
_0x12:
;     155                 CTRL_DAT = 0;delay_us(_DELAY_BUS);
	CBI  0x18,6
_0x100:
	__DELAY_USB 5
;     156             }                
;     157 #endif                       
;     158             CTRL_CLK = 1;delay_us(_DELAY_BUS);
	SBI  0x18,5
	__DELAY_USB 5
;     159             CTRL_CLK = 0;delay_us(_DELAY_BUS);        
	CBI  0x18,5
	__DELAY_USB 5
;     160             mask = mask<<1;  
	LSL  R18
;     161         }                   
	SUBI R19,-1
	RJMP _0x10
_0x11:
;     162         RESET_WATCHDOG();
	WDR
;     163     }	             
	__ADDWRN 16,17,1
	JMP  _0xD
_0xE:
;     164     CTRL_STB = 1;delay_us(_DELAY_BUS);
	SBI  0x18,7
	__DELAY_USB 5
;     165     CTRL_STB = 0;delay_us(_DELAY_BUS);
	CBI  0x18,7
	__DELAY_USB 5
;     166 }        
	CALL __LOADLOCR6
	ADIW R28,6
	RET
;     167 
;     168 static void _displayFrame()
;     169 {                 
__displayFrame_G1:
;     170     BYTE data = 0;  
;     171     count_col = 0;
	ST   -Y,R16
;	data -> R16
	LDI  R16,0
	CLR  R6
	CLR  R7
;     172     count_row = 0;         
	CLR  R4
	CLR  R5
;     173 
;     174     if (is_power_off ==1){
	SBRS R2,0
	RJMP _0x14
;     175         _powerOff();
	CALL __powerOff_G1
;     176         return;
	RJMP _0xFE
;     177     }
;     178     // display one frame in the screen at the specific time 
;     179     for (buffer = start_mem;buffer < (END_RAM); buffer++)  
_0x14:
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
_0x16:
	LDS  R26,_buffer_G1
	LDS  R27,_buffer_G1+1
	CPI  R26,LOW(0x7FFF)
	LDI  R30,HIGH(0x7FFF)
	CPC  R27,R30
	BRSH _0x17
;     180     {                     
;     181         data = (*buffer);
	LD   R16,X
;     182         #ifdef ENABLE_MASK_ROW  
;     183         data &= ENABLE_MASK_ROW;
	ANDI R16,LOW(15)
;     184         #endif //ENABLE_MASK_ROW
;     185         DATA_PORT = data;
	OUT  0x18,R16
;     186         
;     187         DATA_CLK = 1;    // clock high
	SBI  0x7,2
;     188         DATA_CLK = 0;    // clock low   
	CBI  0x7,2
;     189         if ( ++count_col >= SCREEN_WIDTH)
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	CPI  R30,LOW(0x68)
	LDI  R26,HIGH(0x68)
	CPC  R31,R26
	BRLO _0x18
;     190         {                                            
;     191             count_col = 0;      // reset for next                                                                                                                       
	CLR  R6
	CLR  R7
;     192             _powerOff();        // turn all led off            
	CALL __powerOff_G1
;     193             
;     194             SCAN_STB = 0;       // strobe low   
	CBI  0x12,4
;     195             _setRow();          // turn row-led on                                                              
	CALL __setRow_G1
;     196             SCAN_STB = 1;       // strobe high            
	SBI  0x12,4
;     197                  
;     198             DATA_STB = 1;       // strobe high            
	SBI  0x7,0
;     199             DATA_STB = 0;       // strobe low            
	CBI  0x7,0
;     200                         
;     201             if (++count_row >= 8){ 
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	SBIW R30,8
	BRLO _0x19
;     202                 count_row = 0;
	CLR  R4
	CLR  R5
;     203             }                                                                                         
;     204             buffer += (DATA_LENGTH - SCREEN_WIDTH);                 
_0x19:
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	SUBI R30,LOW(-3728)
	SBCI R31,HIGH(-3728)
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
;     205         }                   
;     206     }                         	
_0x18:
	LDS  R30,_buffer_G1
	LDS  R31,_buffer_G1+1
	ADIW R30,1
	STS  _buffer_G1,R30
	STS  _buffer_G1+1,R31
	RJMP _0x16
_0x17:
;     207 }     
_0xFE:
	LD   R16,Y+
	RET
;     208                                   
;     209 static void _doPaging()
;     210 {
__doPaging_G1:
;     211     // init state                         
;     212     DATA_STB = 0;
	CBI  0x7,0
;     213     DATA_CLK = 0;               
	CBI  0x7,2
;     214     // scroll left with shift_step bit(s)
;     215     if(tick_count >= 1000){   
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRLO _0x1A
;     216         tick_count = 0; 
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     217         if (scroll_rate >0){           
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x1)
	BRLO _0x1B
;     218             scroll_rate--;             
	LDS  R30,_scroll_rate_G1
	SUBI R30,LOW(1)
	STS  _scroll_rate_G1,R30
;     219         }
;     220         else{                                 
	RJMP _0x1C
_0x1B:
;     221             LoadPage();                        
	RCALL _LoadPage
;     222         }
_0x1C:
;     223     }        
;     224 }                 
_0x1A:
	RET
;     225 
;     226                                           
;     227 ////////////////////////////////////////////////////////////////////
;     228 // General functions
;     229 //////////////////////////////////////////////////////////////////// 
;     230 BYTE GetLocalTime(BYTE hh, int offset)
;     231 {                          
_GetLocalTime:
;     232     int lval= 0;
;     233     if (offset){       
	ST   -Y,R17
	ST   -Y,R16
;	hh -> Y+4
;	offset -> Y+2
;	lval -> R16,R17
	LDI  R16,0
	LDI  R17,0
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BREQ _0x1D
;     234         lval = (int)hh+offset;    
	LDD  R30,Y+4
	LDI  R31,0
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADD  R30,R26
	ADC  R31,R27
	MOVW R16,R30
;     235         if (lval >= 24){
	__CPWRN 16,17,24
	BRLT _0x1E
;     236             lval = lval%24;
	MOVW R26,R16
	LDI  R30,LOW(24)
	LDI  R31,HIGH(24)
	CALL __MODW21
	MOVW R16,R30
;     237         }            
;     238         if (lval <0){
_0x1E:
	SUBI R16,0
	SBCI R17,0
	BRGE _0x1F
;     239             lval = 24 + lval;
	__ADDWRN 16,17,24
;     240         }
;     241     }               
_0x1F:
;     242     else{
	RJMP _0x20
_0x1D:
;     243         lval = hh;
	LDD  R16,Y+4
	CLR  R17
;     244     }    
_0x20:
;     245     return (BYTE)lval;
	MOV  R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
;     246 }                                    
;     247 
;     248 void GetRTCBuffer()
;     249 {
_GetRTCBuffer:
;     250     UINT nBuffSize =34;
;     251     BYTE pBuffer[34];              
;     252     BYTE hh=0,mm=0,ss=0,DD=0,MM=0,YY=0;  
;     253     i2c_init();   
	SBIW R28,36
	LDI  R24,2
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x21*2)
	LDI  R31,HIGH(_0x21*2)
	CALL __INITLOCB
	CALL __SAVELOCR6
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
	CALL _i2c_init
;     254     rtc_get_date(&DD,&MM,&YY);
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
	CALL _rtc_get_date
	POP  R21
;     255     rtc_get_time(&hh,&mm,&ss);                              
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
	CALL _rtc_get_time
	POP  R20
	POP  R19
	POP  R18
;     256 #ifdef __DUMP_LED_    
;     257     printf("GMT: %02d:%02d:%02d %02d-%02d-%02d\r\n",hh,mm,ss,DD,MM+1,YY);              
;     258 #endif    
;     259     if (DD> 99) DD =0;if (MM> 99) MM =0;if (YY> 99) YY =0;
	CPI  R21,100
	BRLO _0x22
	LDI  R21,LOW(0)
_0x22:
	LDD  R26,Y+7
	CPI  R26,LOW(0x64)
	BRLO _0x23
	LDI  R30,LOW(0)
	STD  Y+7,R30
_0x23:
	LDD  R26,Y+6
	CPI  R26,LOW(0x64)
	BRLO _0x24
	LDI  R30,LOW(0)
	STD  Y+6,R30
;     260     if (hh> 99) hh =0;if (mm> 99) mm =0;if (ss> 99) ss =0;                    
_0x24:
	CPI  R18,100
	BRLO _0x25
	LDI  R18,LOW(0)
_0x25:
	CPI  R19,100
	BRLO _0x26
	LDI  R19,LOW(0)
_0x26:
	CPI  R20,100
	BRLO _0x27
	LDI  R20,LOW(0)
;     261     sprintf(pBuffer,    "%02d-%02d-%4d"\
;     262                         "%02d%02d"\
;     263                         "%02d%02d"\
;     264                         "%02d%02d"\
;     265                         "%02d%02d"\
;     266                         "%02d%02d"\
;     267                         "%02d%02d",              
_0x27:
;     268                         DD,MM+1,2000+YY,                                  
;     269                         GetLocalTime(hh,+7),mm,     // HANOI
;     270                         GetLocalTime(hh,-6),mm,     // NEWYORK
;     271                         GetLocalTime(hh,+1),mm,     // PARIS
;     272                         GetLocalTime(hh,+0),mm,     // LONDON
;     273                         GetLocalTime(hh,+3),mm,     // MOSCOW
;     274                         GetLocalTime(hh,+8),mm      // BELJING                        
;     275                         );           
	MOVW R30,R28
	ADIW R30,8
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,100
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R21
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDD  R30,Y+15
	SUBI R30,-LOW(1)
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDD  R30,Y+18
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	CALL __CWD1
	CALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	ST   -Y,R31
	ST   -Y,R30
	CALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(65530)
	LDI  R31,HIGH(65530)
	ST   -Y,R31
	ST   -Y,R30
	CALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	CALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	CALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	CALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	ST   -Y,R18
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	ST   -Y,R31
	ST   -Y,R30
	CALL _GetLocalTime
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,60
	CALL _sprintf
	ADIW R28,63
	ADIW R28,1
;     276 #ifdef __DUMP_LED_    
;     277     printf("%s \r\n",pBuffer);
;     278 #endif    
;     279     FormatRTC(pBuffer,nBuffSize);   
	MOVW R30,R28
	ADIW R30,8
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	RCALL _FormatRTC
;     280     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     281     DDRD = 0x3F;  
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     282 }
	CALL __LOADLOCR6
	ADIW R28,42
	RET
;     283 
;     284 void FormatRTC(PBYTE pBuffer, UINT nBuffSize)
;     285 {                                                  
_FormatRTC:
;     286     UINT i =0;
;     287     BYTE code = 0;                                 
;     288     PBYTE pBuffOut =(PBYTE)START_RAM + SCREEN_WIDTH;                    
;     289 	for (i=0; i< nBuffSize; i++){		
	CALL __SAVELOCR5
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
_0x29:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x2A
;     290 		code = pBuffer[nBuffSize- i-1];		
	SUB  R30,R16
	SBC  R31,R17
	SBIW R30,1
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R18,X
;     291 		if (code >='0' && code <='9'){
	CPI  R18,48
	BRLO _0x2C
	CPI  R18,58
	BRLO _0x2D
_0x2C:
	RJMP _0x2B
_0x2D:
;     292 			code = code & 0x0F;
	ANDI R18,LOW(15)
;     293 		}
;     294 		else if (code ==' '){
	RJMP _0x2E
_0x2B:
	CPI  R18,32
	BRNE _0x2F
;     295 			code = 0x0F;	// blank
	RJMP _0x101
;     296 		}
;     297 		else if (code =='-'){
_0x2F:
	CPI  R18,45
	BRNE _0x31
;     298 			code = 0x0A;	// dash
	LDI  R18,LOW(10)
;     299 		}
;     300 		else if (code =='.'){
	RJMP _0x32
_0x31:
	CPI  R18,46
	BRNE _0x33
;     301 			code = 0x0B;	// dot
	LDI  R18,LOW(11)
;     302 		}
;     303 		else{
	RJMP _0x34
_0x33:
;     304 			code = 0x0F;	// blank	
_0x101:
	LDI  R18,LOW(15)
;     305 		}
_0x34:
_0x32:
_0x2E:
;     306 		pBuffOut[i] = _xtable[code];
	MOVW R26,R16
	ADD  R26,R19
	ADC  R27,R20
	MOV  R30,R18
	LDI  R31,0
	SUBI R30,LOW(-__xtable)
	SBCI R31,HIGH(-__xtable)
	LD   R30,Z
	ST   X,R30
;     307 	}
	__ADDWRN 16,17,1
	RJMP _0x29
_0x2A:
;     308 }
	CALL __LOADLOCR5
	ADIW R28,9
	RET
;     309 
;     310 void SerialToRAM(PBYTE address,WORD length)                                             
;     311 {
_SerialToRAM:
;     312     PBYTE temp = 0;          
;     313     UINT i =0;     				
;     314     temp   = (PBYTE)address;    
	CALL __SAVELOCR4
;	*address -> Y+6
;	length -> Y+4
;	*temp -> R16,R17
;	i -> R18,R19
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,0
	LDI  R19,0
	__GETWRS 16,17,6
;     315     LED_STATUS = 0;
	CBI  0x18,4
;     316     for (i =0; i< length; i++) {
	__GETWRN 18,19,0
_0x36:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x37
;     317         *temp++ = getchar();
	PUSH R17
	PUSH R16
	__ADDWRN 16,17,1
	CALL _getchar
	POP  R26
	POP  R27
	ST   X,R30
;     318         RESET_WATCHDOG();
	WDR
;     319     }                               
	__ADDWRN 18,19,1
	JMP  _0x36
_0x37:
;     320     LED_STATUS = 1;
	SBI  0x18,4
;     321 }
	CALL __LOADLOCR4
	ADIW R28,8
	RET
;     322 
;     323 void GetCharWidth(WORD length)
;     324 {                               
_GetCharWidth:
;     325     UINT i =0;   
;     326     BYTE devID = EEPROM_DEVICE_FONT;
;     327     PBYTE base  = 0x0A;
;     328     i2c_init();
	CALL __SAVELOCR5
;	length -> Y+5
;	i -> R16,R17
;	devID -> R18
;	*base -> R19,R20
	LDI  R16,0
	LDI  R17,0
	LDI  R18,160
	LDI  R19,LOW(0x0A)
	LDI  R20,HIGH(0x0A)
	CALL _i2c_init
;     329     LED_STATUS = 0;              
	CBI  0x18,4
;     330 
;     331     for (i =0; i < length; i++)
	__GETWRN 16,17,0
_0x39:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x3A
;     332     {                           
;     333         char_width[i] = eeprom_read_w(devID,(PBYTE)base+(i<<1));    
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
;     334         RESET_WATCHDOG();
	WDR
;     335     }                      
	__ADDWRN 16,17,1
	JMP  _0x39
_0x3A:
;     336     LED_STATUS = 1;
	SBI  0x18,4
;     337     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     338     DDRD = 0x3F; 
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     339 }
	CALL __LOADLOCR5
	ADIW R28,7
	RET
;     340 
;     341 void SaveToEEPROM(PBYTE address, WORD length, BYTE index)
;     342 {                             
_SaveToEEPROM:
;     343     PBYTE temp = 0; 
;     344     UINT i =0;     
;     345     BYTE devID = EEPROM_DEVICE_DATA;      				
;     346     temp   = address;   
	CALL __SAVELOCR5
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
;     347     if (length%EEPROM_PAGE){
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ANDI R30,LOW(0x3F)
	BREQ _0x3B
;     348         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
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
;     349     }                         
;     350     i2c_init();
_0x3B:
	CALL _i2c_init
;     351     LED_STATUS = 0;         
	CBI  0x18,4
;     352     for (i=0; i < length; i++) {           
	__GETWRN 18,19,0
_0x3D:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x3E
;     353         eeprom_write( devID, (PBYTE)temp+ index*PAGE_SIZE, (BYTE)(*temp));	                             
	ST   -Y,R20
	LDD  R30,Y+6
	LDI  R31,0
	LDI  R26,LOW(384)
	LDI  R27,HIGH(384)
	CALL __MULW12U
	ADD  R30,R16
	ADC  R31,R17
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R16
	LD   R30,X
	ST   -Y,R30
	CALL _eeprom_write
;     354         RESET_WATCHDOG();                                                       
	WDR
;     355         temp++;
	__ADDWRN 16,17,1
;     356     }                       
	__ADDWRN 18,19,1
	JMP  _0x3D
_0x3E:
;     357     LED_STATUS = 1;
	SBI  0x18,4
;     358     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     359     DDRD = 0x3F;    
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     360 }
	RJMP _0xFD
;     361                       
;     362 void LoadToRAM(PBYTE address, WORD length, BYTE index)
;     363 {                         
_LoadToRAM:
;     364     PBYTE temp = 0;  
;     365     UINT i=0;         
;     366     BYTE devID = EEPROM_DEVICE_DATA;		
;     367     temp   = address;                     
	CALL __SAVELOCR5
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
;     368     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xEF9)
	LDI  R30,HIGH(0xEF9)
	CPC  R27,R30
	BRLO _0x3F
;     369         return; // invalid param
_0xFD:
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     370     if (length%EEPROM_PAGE){
_0x3F:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ANDI R30,LOW(0x3F)
	BREQ _0x40
;     371         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;        
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
;     372     }
;     373     i2c_init();
_0x40:
	CALL _i2c_init
;     374     LED_STATUS = 0;             
	CBI  0x18,4
;     375     for (i =0; i <length; i+= EEPROM_PAGE) {                                 
	__GETWRN 18,19,0
_0x42:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x43
;     376         eeprom_read_page( devID, (PBYTE)temp+ index*PAGE_SIZE, temp, EEPROM_PAGE );        
	ST   -Y,R20
	LDD  R30,Y+6
	LDI  R31,0
	LDI  R26,LOW(384)
	LDI  R27,HIGH(384)
	CALL __MULW12U
	ADD  R30,R16
	ADC  R31,R17
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(64)
	ST   -Y,R30
	CALL _eeprom_read_page
;     377         temp += EEPROM_PAGE;                                
	__ADDWRN 16,17,64
;     378         RESET_WATCHDOG();     
	WDR
;     379     }   
	__ADDWRN 18,19,64
	JMP  _0x42
_0x43:
;     380     LED_STATUS = 1; 
	SBI  0x18,4
;     381     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     382     DDRD = 0x3F;  
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     383 }
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     384 
;     385 void LoadConfig(BYTE index)
;     386 {   
_LoadConfig:
;     387     BYTE devID = EEPROM_DEVICE_DATA;
;     388     i2c_init();
	ST   -Y,R16
;	index -> Y+1
;	devID -> R16
	LDI  R16,162
	CALL _i2c_init
;     389     LED_STATUS = 1;                               
	SBI  0x18,4
;     390     scroll_rate = eeprom_read(devID,(PBYTE)index);     
	ST   -Y,R16
	LDD  R30,Y+2
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     391 #ifdef __TEST_LED_
;     392     scroll_rate = 10;
;     393 #endif
;     394 #ifdef __DUMP_LED_
;     395     printf("line=%d rate=%d\r\n",index,scroll_rate);    
;     396 #endif
;     397     LED_STATUS = 0; 
	CBI  0x18,4
;     398     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     399     DDRD = 0x3F;   
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     400 }
	RJMP _0xFC
;     401 
;     402 void SaveConfig(BYTE index)
;     403 {     
_SaveConfig:
;     404     BYTE devID = EEPROM_DEVICE_DATA;
;     405     i2c_init();
	ST   -Y,R16
;	index -> Y+1
;	devID -> R16
	LDI  R16,162
	CALL _i2c_init
;     406     LED_STATUS = 1;  
	SBI  0x18,4
;     407     eeprom_write(devID,(PBYTE)index,scroll_rate);   
	ST   -Y,R16
	LDD  R30,Y+2
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_scroll_rate_G1
	ST   -Y,R30
	CALL _eeprom_write
;     408     LED_STATUS = 0; 
	CBI  0x18,4
;     409     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     410     DDRD = 0x3F;   
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     411 }
_0xFC:
	LDD  R16,Y+0
	ADIW R28,2
	RET
;     412 
;     413 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     414 {        
_BlankRAM:
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
_0x45:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x46
;     417         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     418 }
	__ADDWRN 16,17,1
	RJMP _0x45
_0x46:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;     419 
;     420 void SetRTCDateTime()
;     421 {
_SetRTCDateTime:
;     422     i2c_init();
	CALL _i2c_init
;     423     LED_STATUS = 0;   
	CBI  0x18,4
;     424     rtc_set_time(0,0,0);    /* clear CH bit */
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	ST   -Y,R30
	CALL _rtc_set_time
;     425     rtc_set_date(getchar(),getchar(),getchar());
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _rtc_set_date
;     426     rtc_set_time(getchar(),getchar(),getchar());    
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _rtc_set_time
;     427     LED_STATUS = 1;
	SBI  0x18,4
;     428     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     429     DDRD = 0x3F; 
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     430 }
	RET
;     431 
;     432 static void TextFromFont(char *szText, BYTE nColor, BYTE bGradient, PBYTE pBuffer, BYTE index)
;     433 {
_TextFromFont_G1:
;     434 	int pos = 0,x=0,y=0;     
;     435 	BYTE i =0, len;
;     436 	BYTE ch = 0;
;     437 	UINT nWidth = 0;   
;     438 	UINT nCurWidth = 0, nNxtWidth = 0;		
;     439     BYTE mask = 0x00, data = 0;
;     440 	BYTE mask_clr[2] = {0x00};
;     441     BYTE devID = EEPROM_DEVICE_FONT;
;     442     	
;     443 	switch (nColor)
	SBIW R28,14
	LDI  R24,14
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x47*2)
	LDI  R31,HIGH(_0x47*2)
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
	LDD  R30,Y+24
;     444 	{
;     445 	case 0:
	CPI  R30,0
	BRNE _0x4B
;     446 		mask = 0xFF;		// BLANK
	LDI  R30,LOW(255)
	STD  Y+10,R30
;     447 		mask_clr[0] = 0xFF;
	STD  Y+7,R30
;     448 		mask_clr[1] = 0xFF;
	STD  Y+8,R30
;     449 		break;
	RJMP _0x4A
;     450 	case 1:
_0x4B:
	CPI  R30,LOW(0x1)
	BRNE _0x4C
;     451 		mask = 0xAA;		// RED			RRRR	
	LDI  R30,LOW(170)
	STD  Y+10,R30
;     452 		mask_clr[0] = 0x99;	// GREEN		RGRG
	LDI  R30,LOW(153)
	STD  Y+7,R30
;     453 		mask_clr[1] = 0x88;	// YELLOW		RYRY
	LDI  R30,LOW(136)
	STD  Y+8,R30
;     454 		break;
	RJMP _0x4A
;     455 	case 2:
_0x4C:
	CPI  R30,LOW(0x2)
	BRNE _0x4D
;     456 		mask = 0x55;		// GREEN		GGGG
	LDI  R30,LOW(85)
	STD  Y+10,R30
;     457 		mask_clr[0] = 0x44;	// YELLOW		GYGY
	LDI  R30,LOW(68)
	STD  Y+7,R30
;     458 		mask_clr[1] = 0x66;	// RED			GRGR	
	LDI  R30,LOW(102)
	STD  Y+8,R30
;     459 		break;
	RJMP _0x4A
;     460 	case 3:
_0x4D:
	CPI  R30,LOW(0x3)
	BRNE _0x4F
;     461 		mask = 0x00;		// YELLOW		YYYY
	LDI  R30,LOW(0)
	STD  Y+10,R30
;     462 		mask_clr[0] = 0x22;	// RED			YRYR	
	LDI  R30,LOW(34)
	STD  Y+7,R30
;     463 		mask_clr[1] = 0x11;	// GREEN		YGYG
	LDI  R30,LOW(17)
	STD  Y+8,R30
;     464 		break;
;     465 	default:
_0x4F:
;     466 		break;
;     467 	}	
_0x4A:
;     468                                
;     469 	LED_STATUS = 0;
	CBI  0x18,4
;     470 	i2c_init();
	CALL _i2c_init
;     471 	len = strlen(szText);      
	LDD  R30,Y+25
	LDD  R31,Y+25+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen
	STD  Y+18,R30
;     472 	if (len > MAX_TITLE){
	LDD  R26,Y+18
	CPI  R26,LOW(0x15)
	BRLO _0x50
;     473 	    len = MAX_TITLE;
	LDI  R30,LOW(20)
	STD  Y+18,R30
;     474 	}
;     475 	for (i=0; i< len; i++){				                                     
_0x50:
	LDI  R30,LOW(0)
	STD  Y+19,R30
_0x52:
	LDD  R30,Y+18
	LDD  R26,Y+19
	CP   R26,R30
	BRLO PC+3
	JMP _0x53
;     476         ch = szText[i];             
	LDD  R30,Y+19
	LDD  R26,Y+25
	LDD  R27,Y+25+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	STD  Y+17,R30
;     477 		nCurWidth = char_width[ch];
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
;     478 		nNxtWidth = char_width[ch+1];    		
	LDD  R26,Y+17
	LDI  R27,0
	LSL  R26
	ROL  R27
	__ADDW2MN _char_width_G1,2
	CALL __GETW1P
	STD  Y+11,R30
	STD  Y+11+1,R31
;     479 		nWidth = (nNxtWidth - nCurWidth); 		
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+15,R30
	STD  Y+15+1,R31
;     480 		if ((pos + nWidth) >= SCREEN_WIDTH)  break;		
	ADD  R30,R16
	ADC  R31,R17
	CPI  R30,LOW(0x68)
	LDI  R26,HIGH(0x68)
	CPC  R31,R26
	BRLO _0x54
	JMP  _0x53
;     481 		for (y=0; y< 8 ; y++){    		            
_0x54:
	__GETWRN 20,21,0
_0x56:
	__CPWRN 20,21,8
	BRLT PC+3
	JMP _0x57
;     482 		    if (bGradient) {
	LDD  R30,Y+23
	CPI  R30,0
	BREQ _0x58
;     483 				if (y >=0 && y <4)	mask = mask_clr[0];
	SUBI R20,0
	SBCI R21,0
	BRLT _0x5A
	__CPWRN 20,21,4
	BRLT _0x5B
_0x5A:
	RJMP _0x59
_0x5B:
	LDD  R30,Y+7
	STD  Y+10,R30
;     484 				if (y >=4 && y <8)	mask = mask_clr[1];	
_0x59:
	__CPWRN 20,21,4
	BRLT _0x5D
	__CPWRN 20,21,8
	BRLT _0x5E
_0x5D:
	RJMP _0x5C
_0x5E:
	LDD  R30,Y+8
	STD  Y+10,R30
;     485 			}			
_0x5C:
;     486 			for (x=0; x< nWidth; x++){                                 
_0x58:
	__GETWRN 18,19,0
_0x60:
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x61
;     487 			    RESET_WATCHDOG();       
	WDR
;     488 			    data = eeprom_read(devID, (PBYTE)(START_RAM + 8*SCREEN_WIDTH + SCREEN_WIDTH) + (y*DATA_LENGTH + nCurWidth + x));
	LDD  R30,Y+6
	ST   -Y,R30
	MOVW R26,R20
	LDI  R30,LOW(3832)
	LDI  R31,HIGH(3832)
	CALL __MULW12
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
	CALL _eeprom_read
	STD  Y+9,R30
;     489 			    data = (~data) & (~mask); 
	COM  R30
	MOV  R26,R30
	LDD  R30,Y+10
	COM  R30
	AND  R30,R26
	STD  Y+9,R30
;     490    				pBuffer[y*DATA_LENGTH + x + pos] = ~data;   				
	MOVW R26,R20
	LDI  R30,LOW(3832)
	LDI  R31,HIGH(3832)
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
;     491 			}					
	__ADDWRN 18,19,1
	JMP  _0x60
_0x61:
;     492 		}
	__ADDWRN 20,21,1
	JMP  _0x56
_0x57:
;     493 		pos += nWidth;	 		
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	__ADDWRR 16,17,30,31
;     494 	}
	LDD  R30,Y+19
	SUBI R30,-LOW(1)
	STD  Y+19,R30
	JMP  _0x52
_0x53:
;     495     
;     496     text_length = pos;    
	__PUTWMRN _text_length_G1,0,16,17
;     497     LED_STATUS = 1;
	SBI  0x18,4
;     498     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     499     DDRD = 0x3F;     
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     500 }
	CALL __LOADLOCR6
	ADIW R28,27
	RET
;     501         
;     502 void LoadPage()
;     503 {                         
_LoadPage:
;     504     if (++page_index >= MAX_PAGE){
	LDS  R26,_page_index_G1
	SUBI R26,-LOW(1)
	STS  _page_index_G1,R26
	CPI  R26,LOW(0x5)
	BRLO _0x62
;     505         page_index = 0;
	LDI  R30,LOW(0)
	STS  _page_index_G1,R30
;     506     }                   
;     507     _powerOff();          
_0x62:
	CALL __powerOff_G1
;     508     LoadConfig(page_index);       
	LDS  R30,_page_index_G1
	ST   -Y,R30
	CALL _LoadConfig
;     509     if (scroll_rate ==0){
	LDS  R30,_scroll_rate_G1
	CPI  R30,0
	BRNE _0x63
;     510         return;
	RET
;     511     } 
;     512     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);                
_0x63:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     513     LoadToRAM((PBYTE)START_RAM+SCREEN_WIDTH,PAGE_SIZE,page_index);                 
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
	CALL _LoadToRAM
;     514     GetCharWidth(255);                                            
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	ST   -Y,R31
	ST   -Y,R30
	CALL _GetCharWidth
;     515 #ifndef __OWN_TITLE_
;     516     TextFromFont((char*)szTitle[page_index],1,0,(PBYTE)START_RAM,0);
;     517 #else
;     518     TextFromFont((char*)(START_RAM+SCREEN_WIDTH+MAX_LED),1,0,(PBYTE)START_RAM,0);     
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
	CALL _TextFromFont_G1
;     519 #endif                                                  
;     520     GetRTCBuffer();
	CALL _GetRTCBuffer
;     521     _displayLED();                  
	CALL __displayLED_G1
;     522         
;     523 #ifdef __DUMP_LED_     
;     524 {         
;     525     UINT i=0;
;     526     PBYTE temp = 0;
;     527     temp   =(PBYTE)START_RAM+SCREEN_WIDTH;
;     528     for (i =0; i <MAX_LED; i++) {
;     529         printf("%02X ",*temp);
;     530         temp++;
;     531     }               
;     532     printf("%s \r\n",(char*)(START_RAM+SCREEN_WIDTH+MAX_LED));
;     533 }
;     534 #endif 
;     535     start_mem = (PBYTE)START_RAM;
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     536     reset_serial();    
	RCALL _reset_serial
;     537 }
	RET
;     538 
;     539 ///////////////////////////////////////////////////////////////
;     540 // END static function(s)
;     541 ///////////////////////////////////////////////////////////////
;     542 
;     543 ///////////////////////////////////////////////////////////////           
;     544 
;     545 void InitDevice()
;     546 {
_InitDevice:
;     547 // Declare your local variables here
;     548 // Crystal Oscillator division factor: 1  
;     549 #ifdef _MEGA162_INCLUDED_ 
;     550 #pragma optsize-
;     551 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     552 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     553 #ifdef _OPTIMIZE_SIZE_
;     554 #pragma optsize+
;     555 #endif                    
;     556 #endif
;     557 
;     558 PORTA=0x00;
	OUT  0x1B,R30
;     559 DDRA=0x00;
	OUT  0x1A,R30
;     560 
;     561 PORTB=0x00;
	OUT  0x18,R30
;     562 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     563 
;     564 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     565 DDRC=0x00;
	OUT  0x14,R30
;     566 
;     567 PORTD = 0x00;
	OUT  0x12,R30
;     568 DDRD = 0x00;
	OUT  0x11,R30
;     569 
;     570 PORTE=0x00;
	OUT  0x7,R30
;     571 DDRE=0x05;
	LDI  R30,LOW(5)
	OUT  0x6,R30
;     572 
;     573 TCCR0=0x03; 
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     574 TCNT0=0x05; 
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     575 OCR0=0x00;  
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     576 
;     577 UCSR0A=0x00;
	OUT  0xB,R30
;     578 UCSR0B=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     579 UCSR0C=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     580 UBRR0H=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     581 UBRR0L=0x67;
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     582 
;     583 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     584 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     585 
;     586 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     587 ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
;     588 
;     589 // I2C Bus initialization
;     590 i2c_init();
	CALL _i2c_init
;     591 
;     592 // DS1307 Real Time Clock initialization
;     593 // Square wave output on pin SQW/OUT: Off
;     594 // SQW/OUT pin state: 1
;     595 rtc_init(0,0,1);   
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _rtc_init
;     596 
;     597 #ifdef __WATCH_DOG_
;     598 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     599 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     600 #endif 
;     601     printf("                                          \r\n");
	__POINTW1FN _0,162
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     602     printf("|=========================================|\r\n");
	__POINTW1FN _0,207
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     603     printf("|      DigiLED AVR Firmware v1.0.0        |\r\n");
	__POINTW1FN _0,253
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     604     printf("|_________________________________________|\r\n");
	__POINTW1FN _0,299
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     605     printf("|        Copyright by CuongQuay           |\r\n");  
	__POINTW1FN _0,345
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     606     printf("|    cuong3ihut@yahoo.com - 0915651001    |\r\n");
	__POINTW1FN _0,391
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     607     printf("|       Started date: 24.05.2007          |\r\n");
	__POINTW1FN _0,437
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     608     printf("|       Release date: 23.06.2007          |\r\n");
	__POINTW1FN _0,483
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     609     printf("|_________________________________________|\r\n");              
	__POINTW1FN _0,299
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     610     printf("                                          \r\n");    
	__POINTW1FN _0,162
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     611 
;     612 #ifdef __TEST_RTC_
;     613 {                                
;     614     BYTE hh=0,mm=0,ss=0,DD=0,MM=0,YY=0;
;     615     rtc_get_date(&DD,&MM,&YY);
	SBIW R28,6
	LDI  R24,6
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x64*2)
	LDI  R31,HIGH(_0x64*2)
	CALL __INITLOCB
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
	CALL _rtc_get_date
;     616     rtc_get_time(&hh,&mm,&ss);
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
;     617     printf("DS1307 GMT: %02d:%02d:%02d %02d-%02d-%02d\r\n",hh,mm,ss,DD,MM,YY);
	__POINTW1FN _0,529
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDD  R30,Y+10
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDD  R30,Y+13
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDD  R30,Y+16
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDD  R30,Y+19
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDD  R30,Y+22
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,24
	CALL _printf
	ADIW R28,26
;     618 }           
	ADIW R28,6
;     619 #endif    
;     620                
;     621 }
	RET
;     622 
;     623 void PowerReset()
;     624 {   
_PowerReset:
;     625     start_mem = (PBYTE)START_RAM;     
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     626     end_mem   = (PBYTE)END_RAM;
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	STS  _end_mem_G1,R30
	STS  _end_mem_G1+1,R31
;     627     org_mem   = (PBYTE)START_RAM;	                   
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _org_mem_G1,R30
	STS  _org_mem_G1+1,R31
;     628 
;     629     InitDevice();
	CALL _InitDevice
;     630                      
;     631     LED_STATUS = 0;
	CBI  0x18,4
;     632     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);    
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     633     delay_ms(500);
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     634     LED_STATUS = 1;
	SBI  0x18,4
;     635         
;     636     LED_STATUS = 0;  
	CBI  0x18,4
;     637     page_index = 0; 
	LDI  R30,LOW(0)
	STS  _page_index_G1,R30
;     638     LoadPage();        
	CALL _LoadPage
;     639     LED_STATUS = 1;             
	SBI  0x18,4
;     640                        
;     641     // reload configuration
;     642     LED_STATUS = 0;
	CBI  0x18,4
;     643     delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     644     LED_STATUS = 1;  
	SBI  0x18,4
;     645     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     646     DDRD = 0x3F;      
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     647 }
	RET
;     648 
;     649 void ProcessCommand()
;     650 {
_ProcessCommand:
;     651    	#asm("cli"); 
	cli
;     652     RESET_WATCHDOG();
	WDR
;     653     // Turn off the scan board           
;     654     _powerOff();
	CALL __powerOff_G1
;     655     // serial message processing     
;     656     switch (rx_message)
	MOV  R30,R8
;     657     {                  
;     658     case LOAD_DATA_MSG:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x68
;     659         {       
;     660             if (rx_wparam > DATA_LENGTH) rx_wparam = DATA_LENGTH;
	LDI  R30,LOW(3832)
	LDI  R31,HIGH(3832)
	CP   R30,R9
	CPC  R31,R10
	BRSH _0x69
	__PUTW1R 9,10
;     661             BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
_0x69:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32767)
	LDI  R31,HIGH(32767)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     662             page_index = rx_wparam>>8; 
	STS  _page_index_G1,R10
;     663             scroll_rate = rx_wparam&0x00FF;                                   
	__GETW1R 9,10
	STS  _scroll_rate_G1,R30
;     664             text_length = rx_lparam;                     
	__PUTWMRN _text_length_G1,0,11,12
;     665             SerialToRAM((PBYTE)START_RAM+SCREEN_WIDTH,text_length);                
	LDI  R30,LOW(1384)
	LDI  R31,HIGH(1384)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _SerialToRAM
;     666             start_mem = (PBYTE)START_RAM;
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     667             SaveConfig(page_index);					    		    		    	
	LDS  R30,_page_index_G1
	ST   -Y,R30
	CALL _SaveConfig
;     668             SaveToEEPROM((PBYTE)START_RAM+SCREEN_WIDTH,PAGE_SIZE,page_index);            
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
	CALL _SaveToEEPROM
;     669         }				
;     670         break;   
	RJMP _0x67
;     671     case LOAD_CONFIG_MSG:
_0x68:
	CPI  R30,LOW(0x2)
	BRNE _0x6A
;     672         {    
;     673             page_index = rx_wparam>>8;
	STS  _page_index_G1,R10
;     674             scroll_rate = rx_wparam&0x00FF;             
	__GETW1R 9,10
	STS  _scroll_rate_G1,R30
;     675             SaveConfig(page_index);
	LDS  R30,_page_index_G1
	ST   -Y,R30
	CALL _SaveConfig
;     676         }
;     677         break;       
	RJMP _0x67
;     678     case SET_RTC_MSG:
_0x6A:
	CPI  R30,LOW(0x3)
	BRNE _0x6C
;     679         {                                
;     680             SetRTCDateTime();
	CALL _SetRTCDateTime
;     681         }
;     682         break;    
;     683     default:
_0x6C:
;     684         break;
;     685     }                 
_0x67:
;     686     send_echo_msg();            
	RCALL _send_echo_msg
;     687     rx_message = UNKNOWN_MSG;
	CLR  R8
;     688     #asm("sei");
	sei
;     689     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     690     DDRD = 0x3F;     
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     691 
;     692 }          
	RET
;     693 ////////////////////////////////////////////////////////////////////////////////
;     694 // MAIN PROGRAM
;     695 ////////////////////////////////////////////////////////////////////////////////
;     696 void main(void)
;     697 {         
_main:
;     698     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x6D
;     699         // Watchdog Reset
;     700         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     701         reset_serial(); 
	RCALL _reset_serial
;     702     }
;     703     else {      
	RJMP _0x6E
_0x6D:
;     704         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     705     }                                     
_0x6E:
;     706      
;     707     PowerReset();                        
	CALL _PowerReset
;     708     #asm("sei");     
	sei
;     709             
;     710     while (1){                     
_0x6F:
;     711         if (rx_message != UNKNOWN_MSG){   
	TST  R8
	BREQ _0x72
;     712             ProcessCommand();   
	CALL _ProcessCommand
;     713         }
;     714         else{               
	RJMP _0x73
_0x72:
;     715             _doPaging();
	CALL __doPaging_G1
;     716             _displayFrame();                        
	CALL __displayFrame_G1
;     717         }
_0x73:
;     718         RESET_WATCHDOG();
	WDR
;     719     }
	JMP  _0x6F
;     720 }
_0x74:
	NOP
	RJMP _0x74
;     721                          
;     722 #include "define.h"
;     723 
;     724 ///////////////////////////////////////////////////////////////
;     725 // serial interrupt handle - processing serial message ...
;     726 ///////////////////////////////////////////////////////////////
;     727 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     728 ///////////////////////////////////////////////////////////////
;     729 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     730 extern BYTE  rx_message;
;     731 extern WORD  rx_wparam;
;     732 extern WORD  rx_lparam;
;     733 
;     734 #if RX_BUFFER_SIZE<256
;     735 unsigned char rx_wr_index,rx_counter;
;     736 #else
;     737 unsigned int rx_wr_index,rx_counter;
;     738 #endif
;     739 
;     740 void send_echo_msg();
;     741 
;     742 // USART Receiver interrupt service routine
;     743 #ifdef _MEGA162_INCLUDED_                    
;     744 interrupt [USART0_RXC] void usart_rx_isr(void)
;     745 #else
;     746 interrupt [USART_RXC] void usart_rx_isr(void)
;     747 #endif
;     748 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     749 char status,data;
;     750 #ifdef _MEGA162_INCLUDED_  
;     751 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;     752 data=UDR0;
	IN   R17,12
;     753 #else     
;     754 status=UCSRA;
;     755 data=UDR;
;     756 #endif          
;     757     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+3
	JMP _0x75
;     758     {
;     759         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R13
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;     760         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0x76
	CLR  R13
;     761         if (++rx_counter == RX_BUFFER_SIZE)
_0x76:
	INC  R14
	LDI  R30,LOW(8)
	CP   R30,R14
	BRNE _0x77
;     762         {
;     763             rx_counter=0;
	CLR  R14
;     764             if (
;     765                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;     766                 rx_buffer[2]==WAKEUP_CHAR 
;     767                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xAA)
	BRNE _0x79
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xAA)
	BRNE _0x79
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xAA)
	BREQ _0x7A
_0x79:
	RJMP _0x78
_0x7A:
;     768             {
;     769                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 8,_rx_buffer,3
;     770                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 9,_rx_buffer,4
	CLR  R10
;     771                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R9
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 9,10
;     772                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 11,_rx_buffer,6
	CLR  R12
;     773                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;     774             }
;     775             else if(
	RJMP _0x7B
_0x78:
;     776                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;     777                 rx_buffer[2]==ESCAPE_CHAR 
;     778                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0x7D
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0x7D
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0x7E
_0x7D:
	RJMP _0x7C
_0x7E:
;     779             {
;     780                 rx_wr_index=0;
	CLR  R13
;     781                 rx_counter =0;
	CLR  R14
;     782             }      
;     783         };
_0x7C:
_0x7B:
_0x77:
;     784     };
_0x75:
;     785 }
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     786 
;     787 void send_echo_msg()
;     788 {
_send_echo_msg:
;     789     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(170)
	ST   -Y,R30
	CALL _putchar
;     790     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(170)
	ST   -Y,R30
	CALL _putchar
;     791     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(170)
	ST   -Y,R30
	CALL _putchar
;     792     putchar(rx_message);
	ST   -Y,R8
	CALL _putchar
;     793     putchar(rx_wparam>>8);
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     794     putchar(rx_wparam&0x00FF);
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     795     putchar(rx_lparam>>8);        
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     796     putchar(rx_lparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     797 }  
	RET
;     798 
;     799 void reset_serial()
;     800 {
_reset_serial:
;     801     rx_wr_index=0;
	CLR  R13
;     802     rx_counter =0;
	CLR  R14
;     803     rx_message = UNKNOWN_MSG;
	CLR  R8
;     804 }
	RET
;     805 
;     806 ///////////////////////////////////////////////////////////////
;     807 // END serial interrupt handle
;     808 /////////////////////////////////////////////////////////////// 
;     809 /*****************************************************
;     810 This program was produced by the
;     811 CodeWizardAVR V1.24.4a Standard
;     812 Automatic Program Generator
;     813 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;     814 http://www.hpinfotech.com
;     815 e-mail:office@hpinfotech.com
;     816 
;     817 Project : 
;     818 Version : 
;     819 Date    : 19/5/2005
;     820 Author  : 3iGROUP                
;     821 Company : http://www.3ihut.net   
;     822 Comments: 
;     823 
;     824 
;     825 Chip type           : ATmega8515
;     826 Program type        : Application
;     827 Clock frequency     : 8.000000 MHz
;     828 Memory model        : Small
;     829 External SRAM size  : 32768
;     830 Ext. SRAM wait state: 0
;     831 Data Stack size     : 128
;     832 *****************************************************/
;     833 
;     834 #include "define.h"                                           
;     835 
;     836 #define     ACK                 1
;     837 #define     NO_ACK              0
;     838 
;     839 // I2C Bus functions
;     840 #asm
;     841    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;     842    .equ __sda_bit=3
   .equ __sda_bit=3
;     843    .equ __scl_bit=2
   .equ __scl_bit=2
;     844 #endasm                   
;     845 
;     846 #ifdef __EEPROM_WRITE_BYTE
;     847 BYTE eeprom_read(BYTE deviceID, PBYTE address) 
;     848 {
_eeprom_read:
;     849     BYTE data;
;     850     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	*address -> Y+1
;	data -> R16
	CALL _i2c_start
;     851     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     852     i2c_write((WORD)address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     853     i2c_write((WORD)address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     854     
;     855     i2c_start();
	CALL _i2c_start
;     856     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     857     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R16,R30
;     858     i2c_stop();
	CALL _i2c_stop
;     859     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0xFB
;     860 }
;     861 
;     862 void eeprom_write(BYTE deviceID, PBYTE address, BYTE data) 
;     863 {
_eeprom_write:
;     864     i2c_start();
;	deviceID -> Y+3
;	*address -> Y+1
;	data -> Y+0
	CALL _i2c_start
;     865     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     866     i2c_write((WORD)address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     867     i2c_write((WORD)address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     868     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	CALL _i2c_write
;     869     i2c_stop();
	CALL _i2c_stop
;     870 
;     871     /* 10ms delay to complete the write operation */
;     872     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     873 }                                 
_0xFB:
	ADIW R28,4
	RET
;     874 
;     875 WORD eeprom_read_w(BYTE deviceID, PBYTE address)
;     876 {
_eeprom_read_w:
;     877     WORD result = 0;
;     878     result = eeprom_read(deviceID,address);
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
;     879     result = (result<<8) | eeprom_read(deviceID,address+1);
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
;     880     return result;
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
;     881 }
;     882 void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data)
;     883 {
;     884     eeprom_write(deviceID,address,data>>8);
;	deviceID -> Y+4
;	*address -> Y+2
;	data -> Y+0
;     885     eeprom_write(deviceID,address+1,data&0x0FF);    
;     886 }
;     887 
;     888 #endif // __EEPROM_WRITE_BYTE
;     889 void eeprom_read_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
;     890 {
_eeprom_read_page:
;     891     BYTE i = 0;
;     892     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	*address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;     893     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;     894     i2c_write((WORD)address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     895     i2c_write((WORD)address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     896     
;     897     i2c_start();
	CALL _i2c_start
;     898     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     899                                     
;     900     while ( i < page_size-1 )
_0x7F:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0x81
;     901     {
;     902         buffer[i++] = i2c_read(ACK);   // read at current
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
;     903     }
	RJMP _0x7F
_0x81:
;     904     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
;     905          
;     906     i2c_stop();
	CALL _i2c_stop
;     907 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     908 
;     909 void eeprom_write_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
;     910 {
;     911     BYTE i = 0;
;     912     i2c_start();
;	deviceID -> Y+6
;	*address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
;     913     i2c_write(deviceID);            // issued R/W = 0
;     914     i2c_write((WORD)address>>8);          // high word address
;     915     i2c_write((WORD)address&0xFF);        // low word address
;     916                                         
;     917     while ( i < page_size )
;     918     {
;     919         i2c_write(buffer[i++]);
;     920         #asm("nop");#asm("nop");
;     921     }          
;     922     i2c_stop(); 
;     923     delay_ms(10);
;     924 }
;     925                                               

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
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x85
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0x86
_0x85:
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _putchar
_0x86:
	RJMP _0xF8
__print_G4:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R16,0
_0x87:
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
	JMP _0x89
	MOV  R30,R16
	CPI  R30,0
	BRNE _0x8D
	CPI  R19,37
	BRNE _0x8E
	LDI  R16,LOW(1)
	RJMP _0x8F
_0x8E:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
_0x8F:
	RJMP _0x8C
_0x8D:
	CPI  R30,LOW(0x1)
	BRNE _0x90
	CPI  R19,37
	BRNE _0x91
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0x102
_0x91:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0x92
	LDI  R17,LOW(1)
	RJMP _0x8C
_0x92:
	CPI  R19,43
	BRNE _0x93
	LDI  R21,LOW(43)
	RJMP _0x8C
_0x93:
	CPI  R19,32
	BRNE _0x94
	LDI  R21,LOW(32)
	RJMP _0x8C
_0x94:
	RJMP _0x95
_0x90:
	CPI  R30,LOW(0x2)
	BRNE _0x96
_0x95:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0x97
	ORI  R17,LOW(128)
	RJMP _0x8C
_0x97:
	RJMP _0x98
_0x96:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x8C
_0x98:
	CPI  R19,48
	BRLO _0x9B
	CPI  R19,58
	BRLO _0x9C
_0x9B:
	RJMP _0x9A
_0x9C:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x8C
_0x9A:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0xA0
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
	RJMP _0xA1
_0xA0:
	CPI  R30,LOW(0x73)
	BRNE _0xA3
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
	RJMP _0xA4
_0xA3:
	CPI  R30,LOW(0x70)
	BRNE _0xA6
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
_0xA4:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0xA7
_0xA6:
	CPI  R30,LOW(0x64)
	BREQ _0xAA
	CPI  R30,LOW(0x69)
	BRNE _0xAB
_0xAA:
	ORI  R17,LOW(4)
	RJMP _0xAC
_0xAB:
	CPI  R30,LOW(0x75)
	BRNE _0xAD
_0xAC:
	LDI  R30,LOW(_tbl10_G4*2)
	LDI  R31,HIGH(_tbl10_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0xAE
_0xAD:
	CPI  R30,LOW(0x58)
	BRNE _0xB0
	ORI  R17,LOW(8)
	RJMP _0xB1
_0xB0:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0xE2
_0xB1:
	LDI  R30,LOW(_tbl16_G4*2)
	LDI  R31,HIGH(_tbl16_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0xAE:
	SBRS R17,2
	RJMP _0xB3
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
	BRGE _0xB4
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0xB4:
	CPI  R21,0
	BREQ _0xB5
	SUBI R16,-LOW(1)
	RJMP _0xB6
_0xB5:
	ANDI R17,LOW(251)
_0xB6:
	RJMP _0xB7
_0xB3:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0xB7:
_0xA7:
	SBRC R17,0
	RJMP _0xB8
_0xB9:
	CP   R16,R20
	BRSH _0xBB
	SBRS R17,7
	RJMP _0xBC
	SBRS R17,2
	RJMP _0xBD
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0xBE
_0xBD:
	LDI  R19,LOW(48)
_0xBE:
	RJMP _0xBF
_0xBC:
	LDI  R19,LOW(32)
_0xBF:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	SUBI R20,LOW(1)
	RJMP _0xB9
_0xBB:
_0xB8:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0xC0
_0xC1:
	CPI  R18,0
	BREQ _0xC3
	SBRS R17,3
	RJMP _0xC4
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x103
_0xC4:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x103:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xC6
	SUBI R20,LOW(1)
_0xC6:
	SUBI R18,LOW(1)
	RJMP _0xC1
_0xC3:
	RJMP _0xC7
_0xC0:
_0xC9:
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
_0xCB:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0xCD
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0xCB
_0xCD:
	CPI  R19,58
	BRLO _0xCE
	SBRS R17,3
	RJMP _0xCF
	SUBI R19,-LOW(7)
	RJMP _0xD0
_0xCF:
	SUBI R19,-LOW(39)
_0xD0:
_0xCE:
	SBRC R17,4
	RJMP _0xD2
	CPI  R19,49
	BRSH _0xD4
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0xD3
_0xD4:
	RJMP _0x104
_0xD3:
	CP   R20,R18
	BRLO _0xD8
	SBRS R17,0
	RJMP _0xD9
_0xD8:
	RJMP _0xD7
_0xD9:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0xDA
	LDI  R19,LOW(48)
_0x104:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0xDB
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xDC
	SUBI R20,LOW(1)
_0xDC:
_0xDB:
_0xDA:
_0xD2:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xDD
	SUBI R20,LOW(1)
_0xDD:
_0xD7:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0xCA
	RJMP _0xC9
_0xCA:
_0xC7:
	SBRS R17,0
	RJMP _0xDE
_0xDF:
	CPI  R20,0
	BREQ _0xE1
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0xDF
_0xE1:
_0xDE:
_0xE2:
_0xA1:
_0x102:
	LDI  R16,LOW(0)
_0x8C:
	RJMP _0x87
_0x89:
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
	RCALL __print_G4
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0xFA
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
	RCALL __print_G4
_0xFA:
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
	BREQ _0xF6
	LDD  R30,Y+2
	ORI  R30,0x10
	STD  Y+2,R30
_0xF6:
	LD   R30,Y
	CPI  R30,0
	BREQ _0xF7
	LDD  R30,Y+2
	ORI  R30,0x80
	STD  Y+2,R30
_0xF7:
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
	RJMP _0xF8
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
	RJMP _0xF9
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
	RJMP _0xF8
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
_0xF9:
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
_0xF8:
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
