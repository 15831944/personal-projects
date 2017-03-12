
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
	BRLO PC+3
	JMP _0x6
;      86         data_bit = (start_mem[(y)/8 + 4*(x)]>>(y%8)) & 0x01; 					
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
;     127     if (scroll_type==SCROLLING){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x4)
	BREQ _0x1D
;     128         /*if (tick_count > scroll_rate){            
;     129             _putData();
;     130         	__DATA_CLK();					            
;     131             __DATA_STB();                  
;     132         }*/
;     133     }
;     134     else{
;     135 	    for (x=0; x< SCREEN_WIDTH; x++){
	CLR  R4
	CLR  R5
_0x1F:
	LDI  R30,LOW(160)
	LDI  R31,HIGH(160)
	CP   R4,R30
	CPC  R5,R31
	BRSH _0x20
;     136 		    _putData();					
	CALL __putData_G1
;     137         	__DATA_CLK();							    
	SBI  0x18,0
	CBI  0x18,0
;     138     	}   
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x1F
_0x20:
;     139         __DATA_STB();
	SBI  0x18,1
	CBI  0x18,1
;     140 	}   	                          	
_0x1D:
;     141 }     
	RET
;     142                                                                                   
;     143 static void _doScroll()
;     144 {
__doScroll_G1:
;     145 #ifdef KEY_PRESS                               
;     146   if (key_pressed==1){
	SBRS R2,3
	RJMP _0x21
;     147     is_stopping =1;
	SET
	BLD  R2,2
;     148     return;
	RET
;     149   }             
;     150 #endif //KEY_PRESS  
;     151   if (tick_count > scroll_rate){    
_0x21:
	LDS  R30,_scroll_rate_G1
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRLO PC+3
	JMP _0x22
;     152     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     153     {
;     154     case LEFT_RIGHT:                
	CPI  R30,0
	BREQ PC+3
	JMP _0x26
;     155         if (is_stopping==0){   
	SBRC R2,2
	RJMP _0x27
;     156             if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x28
;     157        	        start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	RJMP _0x105
;     158        	    else 
_0x28:
;     159        	        start_mem += 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
_0x105:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     160    	    }
;     161    	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
_0x27:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xA00)
	LDI  R30,HIGH(0xA00)
	CPC  R27,R30
	BRNE _0x2A
;     162    	        is_stopping = 1;
	SET
	BLD  R2,2
;     163    	    if (is_stopping ==1)
_0x2A:
	SBRS R2,2
	RJMP _0x2B
;     164    	    {
;     165    	        if (stopping_count++>MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x2C
;     166    	        {
;     167    	            is_stopping=0;
	CLT
	BLD  R2,2
;     168    	            stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     169    	        }
;     170    	    }                                  
_0x2C:
;     171        	if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
_0x2B:
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	CALL __LSLW2
	SUBI R30,LOW(-1920)
	SBCI R31,HIGH(-1920)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x2D
;     172    	    {                  
;     173    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     174        	}           
;     175    	    break;
_0x2D:
	RJMP _0x25
;     176     case RIGHT_LEFT:
_0x26:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x2E
;     177        	if (is_stopping==0){
	SBRC R2,2
	RJMP _0x2F
;     178    	        if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x30
;     179    	            start_mem -= 4;      
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SBIW R30,4
	RJMP _0x106
;     180    	        else
_0x30:
;     181    	            start_mem -= 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SBIW R30,8
_0x106:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     182    	        
;     183    	    }
;     184    	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
_0x2F:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xA00)
	LDI  R30,HIGH(0xA00)
	CPC  R27,R30
	BRNE _0x32
;     185    	        is_stopping = 1;
	SET
	BLD  R2,2
;     186    	    if (is_stopping ==1)
_0x32:
	SBRS R2,2
	RJMP _0x33
;     187    	    {
;     188    	        if (stopping_count++ >MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x34
;     189    	        {
;     190    	            is_stopping=0;
	CLT
	BLD  R2,2
;     191    	            stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     192    	        }
;     193    	    }
_0x34:
;     194    	    else if (start_mem < START_RAM_TEXT)             
	RJMP _0x35
_0x33:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0x780)
	LDI  R30,HIGH(0x780)
	CPC  R27,R30
	BRSH _0x36
;     195        	{
;     196        	    scroll_count = 0;             
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     197    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     198        	}
;     199        	break;
_0x36:
_0x35:
	RJMP _0x25
;     200     case BOTTOM_TOP:               
_0x2E:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x37
;     201         if (scroll_count >=0){        
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,0
	BRLT _0x38
;     202             scroll_count--;   
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     203         }
;     204         else{                      
	RJMP _0x39
_0x38:
;     205             stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     206             scroll_count = SCREEN_HEIGHT<<1;
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     207             start_mem += 4*SCREEN_WIDTH;                                  
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-640)
	SBCI R31,HIGH(-640)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     208             if (start_mem >= (START_RAM_TEXT +4*(text_length+SCREEN_WIDTH))){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-160)
	SBCI R31,HIGH(-160)
	CALL __LSLW2
	SUBI R30,LOW(-1920)
	SBCI R31,HIGH(-1920)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x3A
;     209                 LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     210             }  
;     211         }
_0x3A:
_0x39:
;     212         if (is_stopping==1)
	SBRS R2,2
	RJMP _0x3B
;     213         {               
;     214             if (stopping_count++ > MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x3C
;     215             {
;     216                 is_stopping = 0;
	CLT
	BLD  R2,2
;     217                 stopping_count = 0; 
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     218             }
;     219             else{
	RJMP _0x3D
_0x3C:
;     220                 scroll_count++;
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	ADIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     221             }
_0x3D:
;     222         }   
;     223         if (scroll_count == SCREEN_HEIGHT){
_0x3B:
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRNE _0x3E
;     224             is_stopping = 1;
	SET
	BLD  R2,2
;     225         }
;     226         
;     227         break;
_0x3E:
	RJMP _0x25
;     228     case TOP_BOTTOM:
_0x37:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x3F
;     229         if (scroll_count == SCREEN_HEIGHT){
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRNE _0x40
;     230             is_stopping = 1;
	SET
	BLD  R2,2
;     231         }                   
;     232         if (scroll_count <= (SCREEN_HEIGHT<<1)){ 
_0x40:
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,33
	BRGE _0x41
;     233             scroll_count++;                
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	ADIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     234         }
;     235         else {            
	RJMP _0x42
_0x41:
;     236             scroll_count = 0;  
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     237             stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     238             start_mem += 4*SCREEN_WIDTH;                                  
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-640)
	SBCI R31,HIGH(-640)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     239             if (start_mem >= (START_RAM_TEXT +4*(text_length+SCREEN_WIDTH))){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-160)
	SBCI R31,HIGH(-160)
	CALL __LSLW2
	SUBI R30,LOW(-1920)
	SBCI R31,HIGH(-1920)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x43
;     240                 LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     241             }                              
;     242         }  
_0x43:
_0x42:
;     243         if (is_stopping==1)
	SBRS R2,2
	RJMP _0x44
;     244         {               
;     245             if (stopping_count++ > MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x45
;     246             {
;     247                 is_stopping = 0;
	CLT
	BLD  R2,2
;     248                 stopping_count = 0;      
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     249             }
;     250             else{
	RJMP _0x46
_0x45:
;     251                 scroll_count--;
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     252             }
_0x46:
;     253         }   
;     254         break;  
_0x44:
	RJMP _0x25
;     255     case SCROLLING:        
_0x3F:
	CPI  R30,LOW(0x4)
	BRNE _0x47
;     256         /* step by step with one column*/        
;     257             _putData();
	CALL __putData_G1
;     258             __DATA_CLK();					            
	SBI  0x18,0
	CBI  0x18,0
;     259             __DATA_STB();    
	SBI  0x18,1
	CBI  0x18,1
;     260         
;     261         if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x48
;     262    	        start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	RJMP _0x107
;     263    	    else 
_0x48:
;     264    	        start_mem += 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
_0x107:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     265         if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	CALL __LSLW2
	SUBI R30,LOW(-1920)
	SBCI R31,HIGH(-1920)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x4A
;     266    	    {            
;     267    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     268        	}       	  
;     269         break;  
_0x4A:
	RJMP _0x25
;     270     case NOT_USE:
_0x47:
	CPI  R30,LOW(0x5)
	BRNE _0x4C
;     271         LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     272         break;  
;     273     default:
_0x4C:
;     274         break;
;     275     }
_0x25:
;     276 	tick_count = 0;
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     277 	if (frame_index >= MAX_FRAME) frame_index=0;
	LDS  R26,_frame_index_G1
	CPI  R26,LOW(0x4)
	BRLO _0x4D
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     278     		
;     279   }
_0x4D:
;     280              
;     281 }          
_0x22:
	RET
;     282 ////////////////////////////////////////////////////////////////////
;     283 // General functions
;     284 //////////////////////////////////////////////////////////////////// 
;     285 #define RESET_WATCHDOG()    #asm("WDR");
;     286                                                                             
;     287 void LoadConfig(BYTE index)
;     288 {
_LoadConfig:
;     289     BYTE devID = EEPROM_DEVICE_BASE;    
;     290     WORD base = 0;   // base address
;     291     devID += index<<1;                 
	CALL __SAVELOCR3
;	index -> Y+3
;	devID -> R16
;	base -> R17,R18
	LDI  R16,160
	LDI  R17,0
	LDI  R18,0
	LDD  R30,Y+3
	LSL  R30
	ADD  R16,R30
;     292     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x4E
;     293         base = 0x8000;    
	__GETWRN 17,18,32768
;     294     }                 
;     295     devID &= 0xF7;      // clear bit A3 
_0x4E:
	ANDI R16,LOW(247)
;     296     
;     297     // init I2C bus
;     298     i2c_init();
	CALL _i2c_init
;     299     LED_STATUS = 1;
	SBI  0x18,4
;     300     scroll_rate = eeprom_read(devID, (WORD)base+0);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     301     scroll_type = eeprom_read(devID, (WORD)base+1);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_type_G1,R30
;     302     text_length = eeprom_read_w(devID, (WORD)base+2); 
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read_w
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     303     printf("line=%d rate=%d type=%d len=%d\r\n",index,scroll_rate,scroll_type,text_length);
	__POINTW1FN _0,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+5
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
;     304     if (text_length > DATA_LENGTH){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0xEC1)
	LDI  R30,HIGH(0xEC1)
	CPC  R27,R30
	BRLO _0x4F
;     305         text_length= 0;            
	LDI  R30,0
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R30
;     306     }
;     307     if (scroll_type > NOT_USE){
_0x4F:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x6)
	BRLO _0x50
;     308         scroll_type = NOT_USE;
	LDI  R30,LOW(5)
	STS  _scroll_type_G1,R30
;     309     }          
;     310     if (scroll_rate > MAX_RATE){
_0x50:
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x65)
	BRLO _0x51
;     311         scroll_rate = 0;
	LDI  R30,LOW(0)
	STS  _scroll_rate_G1,R30
;     312     }
;     313     LED_STATUS = 0;   
_0x51:
	CBI  0x18,4
;     314 }
	RJMP _0x104
;     315                        
;     316 void SaveTextLength(BYTE index)
;     317 {
_SaveTextLength:
;     318     BYTE devID = EEPROM_DEVICE_BASE;    
;     319     WORD base = 0;   // base address
;     320     devID += index<<1;                 
	CALL __SAVELOCR3
;	index -> Y+3
;	devID -> R16
;	base -> R17,R18
	LDI  R16,160
	LDI  R17,0
	LDI  R18,0
	LDD  R30,Y+3
	LSL  R30
	ADD  R16,R30
;     321     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x52
;     322         base = 0x8000;    
	__GETWRN 17,18,32768
;     323     }                 
;     324     devID &= 0xF7;      // clear bit A3 
_0x52:
	ANDI R16,LOW(247)
;     325     
;     326     i2c_init();
	CALL _i2c_init
;     327     LED_STATUS = 1;   
	SBI  0x18,4
;     328     eeprom_write_w(devID, base+2,text_length); 
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_write_w
;     329     LED_STATUS = 0;   
	CBI  0x18,4
;     330 }
_0x104:
	CALL __LOADLOCR3
	ADIW R28,4
	RET
;     331 
;     332 void SaveConfig(BYTE rate,BYTE type, BYTE index)
;     333 {                     
_SaveConfig:
;     334     BYTE devID = EEPROM_DEVICE_BASE;    
;     335     WORD base = 0;   // base address
;     336     devID += index<<1;                 
	CALL __SAVELOCR3
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
;     337     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x53
;     338         base = 0x8000;    
	__GETWRN 17,18,32768
;     339     }                 
;     340     devID &= 0xF7;      // clear bit A3  
_0x53:
	ANDI R16,LOW(247)
;     341     i2c_init();
	CALL _i2c_init
;     342     LED_STATUS = 1;  
	SBI  0x18,4
;     343     eeprom_write(devID, base+0,rate);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	CALL _eeprom_write
;     344     eeprom_write(devID, base+1,type);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	ST   -Y,R30
	CALL _eeprom_write
;     345     LED_STATUS = 0;       
	CBI  0x18,4
;     346 }
	CALL __LOADLOCR3
	ADIW R28,6
	RET
;     347 
;     348 void SaveToEEPROM(PBYTE address,WORD length,BYTE index)
;     349 {                             
_SaveToEEPROM:
;     350     PBYTE temp = 0;     
;     351     BYTE devID = EEPROM_DEVICE_BASE;
;     352     WORD base = 0;   // base address
;     353     devID += index<<1;                 
	CALL __SAVELOCR5
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
;     354     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x54
;     355         base = 0x8000;    
	__GETWRN 19,20,32768
;     356     }         				
;     357     temp = address;         
_0x54:
	__GETWRS 16,17,8
;     358         
;     359     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xEC1)
	LDI  R30,HIGH(0xEC1)
	CPC  R27,R30
	BRLO _0x55
;     360         return; // invalid param 
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     361     length = (WORD)address+4*(SCREEN_WIDTH+length);         
_0x55:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-160)
	SBCI R31,HIGH(-160)
	CALL __LSLW2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     362     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x56
;     363         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     364     // init I2C bus
;     365     i2c_init();
_0x56:
	CALL _i2c_init
;     366     LED_STATUS = 1;        
	SBI  0x18,4
;     367     
;     368     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x58:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x59
;     369     {   
;     370         RESET_WATCHDOG();                          	                                              
	WDR
;     371         eeprom_write_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE);	      
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
	CALL _eeprom_write_page
;     372     }       
	__ADDWRN 16,17,64
	JMP  _0x58
_0x59:
;     373         
;     374     LED_STATUS = 0;   
	CBI  0x18,4
;     375 }
	RJMP _0x103
;     376                       
;     377 void LoadToRAM(PBYTE address,WORD length,BYTE index)
;     378 {                         
_LoadToRAM:
;     379     PBYTE temp = 0;          
;     380     BYTE devID = EEPROM_DEVICE_BASE;
;     381     WORD base = 0;   // base address
;     382     devID += index<<1;                 
	CALL __SAVELOCR5
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
;     383     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x5A
;     384         base = 0x8000;    
	__GETWRN 19,20,32768
;     385     }       				
;     386     temp = address;                 
_0x5A:
	__GETWRS 16,17,8
;     387 
;     388     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xEC1)
	LDI  R30,HIGH(0xEC1)
	CPC  R27,R30
	BRLO _0x5B
;     389         return; // invalid param
_0x103:
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     390     length = (WORD)address+4*(SCREEN_WIDTH+length);         
_0x5B:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-160)
	SBCI R31,HIGH(-160)
	CALL __LSLW2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     391     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x5C
;     392         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     393     // init I2C bus
;     394     i2c_init();
_0x5C:
	CALL _i2c_init
;     395     LED_STATUS = 1;             
	SBI  0x18,4
;     396  
;     397     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x5E:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x5F
;     398     {
;     399         eeprom_read_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE );	                                   
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
	CALL _eeprom_read_page
;     400         RESET_WATCHDOG();     
	WDR
;     401     }             
	__ADDWRN 16,17,64
	JMP  _0x5E
_0x5F:
;     402 
;     403     LED_STATUS = 0;   
	CBI  0x18,4
;     404 }
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     405 
;     406 void LoadFrame(BYTE index)
;     407 {                 
_LoadFrame:
;     408     if (index >= MAX_FRAME) index=0;  
;	index -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x4)
	BRLO _0x60
	LDI  R30,LOW(0)
	ST   Y,R30
;     409 
;     410     LoadConfig(index);  
_0x60:
	LD   R30,Y
	ST   -Y,R30
	CALL _LoadConfig
;     411     if (scroll_type==NOT_USE){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x5)
	BRNE _0x61
;     412         return;           
	RJMP _0x102
;     413     }                   
;     414     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
_0x61:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     415     LoadToRAM((PBYTE)START_RAM_TEXT,text_length,index);
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
	CALL _LoadToRAM
;     416     stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     417     scroll_count = 0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     418     is_stopping = 0;
	CLT
	BLD  R2,2
;     419     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     420     {
;     421     case LEFT_RIGHT:
	CPI  R30,0
	BRNE _0x65
;     422         start_mem = (PBYTE)START_RAM_TEXT; 
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     423         break;                
	RJMP _0x64
;     424     case RIGHT_LEFT:
_0x65:
	CPI  R30,LOW(0x1)
	BRNE _0x66
;     425         start_mem = (PBYTE)START_RAM_TEXT + (text_length<<2); 
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	CALL __LSLW2
	SUBI R30,LOW(-1920)
	SBCI R31,HIGH(-1920)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     426         break;
	RJMP _0x64
;     427     case BOTTOM_TOP:                             
_0x66:
	CPI  R30,LOW(0x3)
	BRNE _0x67
;     428         scroll_count = SCREEN_HEIGHT<<1;
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     429         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     430         break;
	RJMP _0x64
;     431     case TOP_BOTTOM:   
_0x67:
	CPI  R30,LOW(0x2)
	BRNE _0x68
;     432         scroll_count = 0;                     
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     433         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     434         break;  
	RJMP _0x64
;     435     case SCROLLING:
_0x68:
	CPI  R30,LOW(0x4)
	BRNE _0x6A
;     436         start_mem = (PBYTE)START_RAM_TEXT;
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     437         break;
;     438     default: 
_0x6A:
;     439         break;
;     440     }                   
_0x64:
;     441 #ifdef KEY_PRESS    
;     442     if (key_pressed==1){                  
	SBRS R2,3
	RJMP _0x6B
;     443         scroll_count = SCREEN_HEIGHT;
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     444         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2);
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     445     }           
;     446 #endif //KEY_PRESS    
;     447 }
_0x6B:
_0x102:
	ADIW R28,1
	RET
;     448 
;     449 void SerialToRAM(PBYTE address,WORD length)                                             
;     450 {
_SerialToRAM:
;     451     PBYTE temp = 0;          
;     452     UINT i =0;     				
;     453     temp   = address;    
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
;     454     LED_STATUS = 1;
	SBI  0x18,4
;     455     for (i =0; i< (length<<2); i++)         
	__GETWRN 18,19,0
_0x6D:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL __LSLW2
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x6E
;     456     {                          
;     457         BYTE data = 0;
;     458         data = ~getchar();
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x6F*2)
	LDI  R31,HIGH(_0x6F*2)
	CALL __INITLOCB
;	*address -> Y+7
;	length -> Y+5
;	data -> Y+0
	CALL _getchar
	COM  R30
	ST   Y,R30
;     459         *temp = data;
	MOVW R26,R16
	ST   X,R30
;     460         temp++;
	__ADDWRN 16,17,1
;     461         RESET_WATCHDOG();                                     
	WDR
;     462     }              
	ADIW R28,1
	__ADDWRN 18,19,1
	JMP  _0x6D
_0x6E:
;     463     LED_STATUS = 0;
	CBI  0x18,4
;     464 }
	CALL __LOADLOCR4
	ADIW R28,8
	RET
;     465                       
;     466 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     467 {        
_BlankRAM:
;     468     PBYTE temp = START_RAM;
;     469     for (temp = start_addr; temp<= end_addr; temp++)    
	ST   -Y,R17
	ST   -Y,R16
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*temp -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x71:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x72
;     470         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     471 }
	__ADDWRN 16,17,1
	RJMP _0x71
_0x72:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;     472 
;     473 
;     474 ///////////////////////////////////////////////////////////////
;     475 // END static function(s)
;     476 ///////////////////////////////////////////////////////////////
;     477 
;     478 ///////////////////////////////////////////////////////////////           
;     479 
;     480 void InitDevice()
;     481 {
_InitDevice:
;     482 // Declare your local variables here
;     483 // Crystal Oscillator division factor: 1  
;     484 #ifdef _MEGA162_INCLUDED_ 
;     485 #pragma optsize-
;     486 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     487 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     488 #ifdef _OPTIMIZE_SIZE_
;     489 #pragma optsize+
;     490 #endif                    
;     491 #endif
;     492 
;     493 PORTA=0x00;
	OUT  0x1B,R30
;     494 DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;     495 
;     496 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
;     497 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     498 
;     499 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     500 DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
;     501 
;     502 PORTD=0xFF;
	OUT  0x12,R30
;     503 DDRD=0x00; 
	LDI  R30,LOW(0)
	OUT  0x11,R30
;     504 
;     505 PORTE=0x00;
	OUT  0x7,R30
;     506 DDRE=0xFF;
	LDI  R30,LOW(255)
	OUT  0x6,R30
;     507 
;     508 // Timer/Counter 0 initialization
;     509 // Clock source: System Clock
;     510 // Clock value: 250.000 kHz
;     511 // Mode: Normal top=FFh
;     512 // OC0 output: Disconnected
;     513 TCCR0=0x03;     // 4 us per tick
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     514 TCNT0=0x05;     // 1ms = 4*250
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     515 OCR0=0x00;      // 255 -250 = TCNT0
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     516 
;     517 #ifdef _MEGA162_INCLUDED_
;     518 UCSR0A=0x00;
	OUT  0xB,R30
;     519 UCSR0B=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     520 UCSR0C=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     521 UBRR0H=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     522 UBRR0L=0x67;      //  16 MHz     
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     523 UBRR0L=0x2F;      //  7.3728 MHz
	LDI  R30,LOW(47)
	OUT  0x9,R30
;     524   
;     525 #else // _MEGA8515_INCLUDE_     
;     526 UCSRA=0x00;
;     527 UCSRB=0x98;
;     528 UCSRC=0x86;
;     529 UBRRH=0x00;
;     530 UBRRL=0x33;       // 8 MHz  
;     531 
;     532 #endif
;     533 
;     534 // Lower page wait state(s): None
;     535 // Upper page wait state(s): None
;     536 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     537 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     538 
;     539 // Timer(s)/Counter(s) Interrupt(s) initialization
;     540 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     541 ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
;     542 
;     543 // Load calibration byte for osc.  
;     544 #ifdef _MEGA162_INCLUDED_
;     545 OSCCAL = 0x5E; 
	LDI  R30,LOW(94)
	OUT  0x4,R30
;     546 #else
;     547 OSCCAL = 0xA7; 
;     548 #endif            
;     549 
;     550 // I2C Bus initialization
;     551 // i2c_init();
;     552 
;     553 // DS1307 Real Time Clock initialization
;     554 // Square wave output on pin SQW/OUT: Off
;     555 // SQW/OUT pin state: 1
;     556 // rtc_init(3,0,1);
;     557 
;     558 //i2c_init(); // must be call before
;     559 //rtc_init(3,0,1); // init RTC DS1307  
;     560 //rtc_set_time(15,2,0);
;     561 //rtc_set_date(9,5,6);    
;     562                 
;     563 // Watchdog Timer initialization
;     564 // Watchdog Timer Prescaler: OSC/2048k     
;     565 #ifdef __WATCH_DOG_
;     566 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     567 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     568 #endif
;     569 }
	RET
;     570 
;     571 void PowerReset()
;     572 {      
_PowerReset:
;     573     start_mem = (PBYTE)START_RAM_TEXT;                    
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     574 
;     575     InitDevice();
	CALL _InitDevice
;     576        
;     577     LED_STATUS = 0;
	CBI  0x18,4
;     578     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);  
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     579     
;     580     LED_STATUS = 0;  
	CBI  0x18,4
;     581     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     582     LED_STATUS = 1;
	SBI  0x18,4
;     583     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     584     LED_STATUS = 0;
	CBI  0x18,4
;     585     delay_ms(500);    
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     586     LED_STATUS = 1;
	SBI  0x18,4
;     587                 
;     588     frame_index= 0;
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     589     LoadFrame(frame_index);
	ST   -Y,R30
	CALL _LoadFrame
;     590         
;     591 #ifdef _INIT_EEPROM_ 
;     592 {
;     593     BYTE i =0;
;     594     for (i =0; i< MAX_FRAME; i++){   
;     595         SaveConfig(10,0,i);
;     596         text_length = 160;
;     597         SaveTextLength(i);            
;     598     }
;     599 }
;     600 #endif  
;     601     printf("LCMS v3.02 Designed by CuongQuay\r\n");  
	__POINTW1FN _0,33
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     602     printf("cuong3ihut@yahoo.com - 0915651001\r\n");
	__POINTW1FN _0,68
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     603     printf("Release date: 22.11.2006\r\n");
	__POINTW1FN _0,104
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     604 }
	RET
;     605 
;     606 void ProcessCommand()
;     607 {
_ProcessCommand:
;     608    	#asm("cli"); 
	cli
;     609     RESET_WATCHDOG();
	WDR
;     610 
;     611     // serial message processing     
;     612     switch (rx_message)
	MOV  R30,R8
;     613     {                  
;     614     case LOAD_TEXT_MSG:
	CPI  R30,LOW(0x2)
	BRNE _0x76
;     615         {                
;     616             text_length = rx_wparam;            
	__PUTWMRN _text_length_G1,0,9,10
;     617             frame_index = rx_lparam&0x0F;   
	__GETW1R 11,12
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	STS  _frame_index_G1,R30
;     618             BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     619             SerialToRAM((PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH),text_length);                
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _SerialToRAM
;     620 			start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);				
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     621 			SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	CALL _SaveToEEPROM
;     622 			SaveTextLength(rx_lparam);							  
	ST   -Y,R11
	CALL _SaveTextLength
;     623         }				
;     624         break;           
	RJMP _0x75
;     625     case LOAD_BKGND_MSG:
_0x76:
	CPI  R30,LOW(0x3)
	BRNE _0x77
;     626         {
;     627         }
;     628         break;   
	RJMP _0x75
;     629     case SET_CFG_MSG: 
_0x77:
	CPI  R30,LOW(0xD)
	BRNE _0x78
;     630         {               
;     631             SaveConfig(rx_wparam&0x0FF,rx_wparam>>8,rx_lparam); 
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	ST   -Y,R11
	CALL _SaveConfig
;     632         }
;     633         break;    
	RJMP _0x75
;     634     case EEPROM_SAVE_TEXT_MSG:     
_0x78:
	CPI  R30,LOW(0x7)
	BREQ _0x7A
;     635     case EEPROM_SAVE_ALL_MSG:  
	CPI  R30,LOW(0xB)
	BRNE _0x7B
_0x7A:
;     636         {                                                          
;     637             SaveTextLength(rx_lparam);              
	ST   -Y,R11
	CALL _SaveTextLength
;     638             SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	CALL _SaveToEEPROM
;     639         }
;     640         break;         
	RJMP _0x75
;     641     case EEPROM_LOAD_TEXT_MSG:    
_0x7B:
	CPI  R30,LOW(0x6)
	BREQ _0x7D
;     642     case EEPROM_LOAD_ALL_MSG:
	CPI  R30,LOW(0xA)
	BRNE _0x7E
_0x7D:
;     643         {
;     644             LoadConfig(rx_lparam);                               
	ST   -Y,R11
	CALL _LoadConfig
;     645             LoadToRAM((PBYTE)START_RAM_TEXT,text_length,rx_lparam); 
	LDI  R30,LOW(1920)
	LDI  R31,HIGH(1920)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	CALL _LoadToRAM
;     646             start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);
	LDI  R30,LOW(2560)
	LDI  R31,HIGH(2560)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     647         }
;     648         break;  
	RJMP _0x75
;     649     case POWER_CTRL_MSG:
_0x7E:
	CPI  R30,LOW(0x10)
	BRNE _0x80
;     650         power_off = rx_wparam&0x01;
	BST  R9,0
	BLD  R2,1
;     651         break;     
;     652     default:
_0x80:
;     653         break;
;     654     }                 
_0x75:
;     655     send_echo_msg();            
	RCALL _send_echo_msg
;     656     rx_message = UNKNOWN_MSG;
	CLR  R8
;     657     #asm("sei");        
	sei
;     658 }           
	RET
;     659 ////////////////////////////////////////////////////////////////////////////////
;     660 // MAIN PROGRAM
;     661 ////////////////////////////////////////////////////////////////////////////////
;     662 void main(void)
;     663 {         
_main:
;     664     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x81
;     665         // Watchdog Reset
;     666         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     667         reset_serial(); 
	RCALL _reset_serial
;     668     }
;     669     else {      
	RJMP _0x82
_0x81:
;     670         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     671     }                                     
_0x82:
;     672      
;     673     PowerReset();                        
	CALL _PowerReset
;     674     #asm("sei");     
	sei
;     675 
;     676     while (1){         
_0x83:
;     677 #ifdef KEY_PRESS       
;     678         if (KEY_PRESS==0){
	SBIC 0x10,5
	RJMP _0x86
;     679             if (key_pressed==0){
	SBRC R2,3
	RJMP _0x87
;     680                 delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     681                 if (KEY_PRESS==0){                           
	SBIC 0x10,5
	RJMP _0x88
;     682                     printf("KEY PRESSED\r\n");                
	__POINTW1FN _0,131
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     683                     key_pressed =1; 
	SET
	BLD  R2,3
;     684                     LoadFrame(0);                             
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _LoadFrame
;     685                 }                                                       
;     686             }
_0x88:
;     687         }
_0x87:
;     688         else{   
	RJMP _0x89
_0x86:
;     689             if (key_pressed==1){                   
	SBRS R2,3
	RJMP _0x8A
;     690                 delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     691                 if (KEY_PRESS==1){                
	SBIS 0x10,5
	RJMP _0x8B
;     692                     key_pressed =0; 
	CLT
	BLD  R2,3
;     693                     LoadFrame(frame_index);       
	LDS  R30,_frame_index_G1
	ST   -Y,R30
	CALL _LoadFrame
;     694                 }
;     695             }     
_0x8B:
;     696         }       
_0x8A:
_0x89:
;     697 #endif //KEY_PRESS                   
;     698         if (rx_message != UNKNOWN_MSG){   
	TST  R8
	BREQ _0x8C
;     699             ProcessCommand();   
	CALL _ProcessCommand
;     700         }
;     701         else{           
	RJMP _0x8D
_0x8C:
;     702             if (!is_stopping){
	SBRC R2,2
	RJMP _0x8E
;     703                 _displayFrame();
	CALL __displayFrame_G1
;     704             }
;     705             _doScroll();            
_0x8E:
	CALL __doScroll_G1
;     706         }
_0x8D:
;     707         RESET_WATCHDOG();
	WDR
;     708     };
	JMP  _0x83
;     709 
;     710 }
_0x8F:
	NOP
	RJMP _0x8F
;     711                          
;     712 #include "define.h"
;     713 
;     714 ///////////////////////////////////////////////////////////////
;     715 // serial interrupt handle - processing serial message ...
;     716 ///////////////////////////////////////////////////////////////
;     717 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     718 ///////////////////////////////////////////////////////////////
;     719 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     720 extern BYTE  rx_message;
;     721 extern WORD  rx_wparam;
;     722 extern WORD  rx_lparam;
;     723 
;     724 #if RX_BUFFER_SIZE<256
;     725 unsigned char rx_wr_index,rx_counter;
;     726 #else
;     727 unsigned int rx_wr_index,rx_counter;
;     728 #endif
;     729 
;     730 void send_echo_msg();
;     731 
;     732 // USART Receiver interrupt service routine
;     733 #ifdef _MEGA162_INCLUDED_                    
;     734 interrupt [USART0_RXC] void usart_rx_isr(void)
;     735 #else
;     736 interrupt [USART_RXC] void usart_rx_isr(void)
;     737 #endif
;     738 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     739 char status,data;
;     740 #ifdef _MEGA162_INCLUDED_  
;     741 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;     742 data=UDR0;
	IN   R17,12
;     743 #else     
;     744 status=UCSRA;
;     745 data=UDR;
;     746 #endif          
;     747     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+3
	JMP _0x90
;     748     {
;     749         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R13
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;     750         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0x91
	CLR  R13
;     751         if (++rx_counter == RX_BUFFER_SIZE)
_0x91:
	INC  R14
	LDI  R30,LOW(8)
	CP   R30,R14
	BRNE _0x92
;     752         {
;     753             rx_counter=0;
	CLR  R14
;     754             if (
;     755                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;     756                 rx_buffer[2]==WAKEUP_CHAR 
;     757                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BRNE _0x94
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BRNE _0x94
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ _0x95
_0x94:
	RJMP _0x93
_0x95:
;     758             {
;     759                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 8,_rx_buffer,3
;     760                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 9,_rx_buffer,4
	CLR  R10
;     761                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R9
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 9,10
;     762                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 11,_rx_buffer,6
	CLR  R12
;     763                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;     764             }
;     765             else if(
	RJMP _0x96
_0x93:
;     766                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;     767                 rx_buffer[2]==ESCAPE_CHAR 
;     768                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0x98
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0x98
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0x99
_0x98:
	RJMP _0x97
_0x99:
;     769             {
;     770                 rx_wr_index=0;
	CLR  R13
;     771                 rx_counter =0;
	CLR  R14
;     772             }      
;     773         };
_0x97:
_0x96:
_0x92:
;     774     };
_0x90:
;     775 }
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     776 
;     777 void send_echo_msg()
;     778 {
_send_echo_msg:
;     779     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     780     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     781     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     782     putchar(rx_message);
	ST   -Y,R8
	CALL _putchar
;     783     putchar(rx_wparam>>8);
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     784     putchar(rx_wparam&0x00FF);
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     785     putchar(rx_lparam>>8);        
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     786     putchar(rx_lparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     787 }  
	RET
;     788 
;     789 void reset_serial()
;     790 {
_reset_serial:
;     791     rx_wr_index=0;
	CLR  R13
;     792     rx_counter =0;
	CLR  R14
;     793     rx_message = UNKNOWN_MSG;
	CLR  R8
;     794 }
	RET
;     795 
;     796 ///////////////////////////////////////////////////////////////
;     797 // END serial interrupt handle
;     798 /////////////////////////////////////////////////////////////// 
;     799 /*****************************************************
;     800 This program was produced by the
;     801 CodeWizardAVR V1.24.4a Standard
;     802 Automatic Program Generator
;     803 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;     804 http://www.hpinfotech.com
;     805 e-mail:office@hpinfotech.com
;     806 
;     807 Project : 
;     808 Version : 
;     809 Date    : 19/5/2005
;     810 Author  : 3iGROUP                
;     811 Company : http://www.3ihut.net   
;     812 Comments: 
;     813 
;     814 
;     815 Chip type           : ATmega8515
;     816 Program type        : Application
;     817 Clock frequency     : 8.000000 MHz
;     818 Memory model        : Small
;     819 External SRAM size  : 32768
;     820 Ext. SRAM wait state: 0
;     821 Data Stack size     : 128
;     822 *****************************************************/
;     823 
;     824 #include "define.h"                                           
;     825 
;     826 #define     ACK                 1
;     827 #define     NO_ACK              0
;     828 
;     829 // I2C Bus functions
;     830 #asm
;     831    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;     832    .equ __sda_bit=3
   .equ __sda_bit=3
;     833    .equ __scl_bit=2
   .equ __scl_bit=2
;     834 #endasm                   
;     835 
;     836 #ifdef __EEPROM_WRITE_BYTE
;     837 BYTE eeprom_read(BYTE deviceID, WORD address) 
;     838 {
_eeprom_read:
;     839     BYTE data;
;     840     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	address -> Y+1
;	data -> R16
	CALL _i2c_start
;     841     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     842     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     843     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     844     
;     845     i2c_start();
	CALL _i2c_start
;     846     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     847     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R16,R30
;     848     i2c_stop();
	CALL _i2c_stop
;     849     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0x101
;     850 }
;     851 
;     852 void eeprom_write(BYTE deviceID, WORD address, BYTE data) 
;     853 {
_eeprom_write:
;     854     i2c_start();
;	deviceID -> Y+3
;	address -> Y+1
;	data -> Y+0
	CALL _i2c_start
;     855     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     856     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     857     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     858     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	CALL _i2c_write
;     859     i2c_stop();
	CALL _i2c_stop
;     860 
;     861     /* 10ms delay to complete the write operation */
;     862     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     863 }                                 
_0x101:
	ADIW R28,4
	RET
;     864 
;     865 WORD eeprom_read_w(BYTE deviceID, WORD address)
;     866 {
_eeprom_read_w:
;     867     WORD result = 0;
;     868     result = eeprom_read(deviceID,address);
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
;     869     result = (result<<8) | eeprom_read(deviceID,address+1);
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
;     870     return result;
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x100
;     871 }
;     872 void eeprom_write_w(BYTE deviceID, WORD address, WORD data)
;     873 {
_eeprom_write_w:
;     874     eeprom_write(deviceID,address,data>>8);
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
;     875     eeprom_write(deviceID,address+1,data&0x0FF);    
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
;     876 }
_0x100:
	ADIW R28,5
	RET
;     877 
;     878 #endif // __EEPROM_WRITE_BYTE
;     879 void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     880 {
_eeprom_read_page:
;     881     BYTE i = 0;
;     882     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;     883     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;     884     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     885     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     886     
;     887     i2c_start();
	CALL _i2c_start
;     888     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     889                                     
;     890     while ( i < page_size-1 )
_0x9A:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0x9C
;     891     {
;     892         buffer[i++] = i2c_read(ACK);   // read at current
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
;     893     }
	RJMP _0x9A
_0x9C:
;     894     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
;     895          
;     896     i2c_stop();
	CALL _i2c_stop
;     897 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     898 
;     899 void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     900 {
_eeprom_write_page:
;     901     BYTE i = 0;
;     902     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;     903     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;     904     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     905     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     906                                         
;     907     while ( i < page_size )
_0x9D:
	LDD  R30,Y+1
	CP   R16,R30
	BRSH _0x9F
;     908     {
;     909         i2c_write(buffer[i++]);
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
;     910         #asm("nop");#asm("nop");
	nop
	nop
;     911     }          
	JMP  _0x9D
_0x9F:
;     912     i2c_stop(); 
	CALL _i2c_stop
;     913     delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     914 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     915                                               

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
	BREQ _0xA0
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0xA1
_0xA0:
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _putchar
_0xA1:
	ADIW R28,3
	RET
__print_G4:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R16,0
_0xA2:
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
	JMP _0xA4
	MOV  R30,R16
	CPI  R30,0
	BRNE _0xA8
	CPI  R19,37
	BRNE _0xA9
	LDI  R16,LOW(1)
	RJMP _0xAA
_0xA9:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
_0xAA:
	RJMP _0xA7
_0xA8:
	CPI  R30,LOW(0x1)
	BRNE _0xAB
	CPI  R19,37
	BRNE _0xAC
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0x108
_0xAC:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0xAD
	LDI  R17,LOW(1)
	RJMP _0xA7
_0xAD:
	CPI  R19,43
	BRNE _0xAE
	LDI  R21,LOW(43)
	RJMP _0xA7
_0xAE:
	CPI  R19,32
	BRNE _0xAF
	LDI  R21,LOW(32)
	RJMP _0xA7
_0xAF:
	RJMP _0xB0
_0xAB:
	CPI  R30,LOW(0x2)
	BRNE _0xB1
_0xB0:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0xB2
	ORI  R17,LOW(128)
	RJMP _0xA7
_0xB2:
	RJMP _0xB3
_0xB1:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0xA7
_0xB3:
	CPI  R19,48
	BRLO _0xB6
	CPI  R19,58
	BRLO _0xB7
_0xB6:
	RJMP _0xB5
_0xB7:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0xA7
_0xB5:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0xBB
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
	RJMP _0xBC
_0xBB:
	CPI  R30,LOW(0x73)
	BRNE _0xBE
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
	RJMP _0xBF
_0xBE:
	CPI  R30,LOW(0x70)
	BRNE _0xC1
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
_0xBF:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0xC2
_0xC1:
	CPI  R30,LOW(0x64)
	BREQ _0xC5
	CPI  R30,LOW(0x69)
	BRNE _0xC6
_0xC5:
	ORI  R17,LOW(4)
	RJMP _0xC7
_0xC6:
	CPI  R30,LOW(0x75)
	BRNE _0xC8
_0xC7:
	LDI  R30,LOW(_tbl10_G4*2)
	LDI  R31,HIGH(_tbl10_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0xC9
_0xC8:
	CPI  R30,LOW(0x58)
	BRNE _0xCB
	ORI  R17,LOW(8)
	RJMP _0xCC
_0xCB:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0xFD
_0xCC:
	LDI  R30,LOW(_tbl16_G4*2)
	LDI  R31,HIGH(_tbl16_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0xC9:
	SBRS R17,2
	RJMP _0xCE
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
	BRGE _0xCF
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0xCF:
	CPI  R21,0
	BREQ _0xD0
	SUBI R16,-LOW(1)
	RJMP _0xD1
_0xD0:
	ANDI R17,LOW(251)
_0xD1:
	RJMP _0xD2
_0xCE:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0xD2:
_0xC2:
	SBRC R17,0
	RJMP _0xD3
_0xD4:
	CP   R16,R20
	BRSH _0xD6
	SBRS R17,7
	RJMP _0xD7
	SBRS R17,2
	RJMP _0xD8
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0xD9
_0xD8:
	LDI  R19,LOW(48)
_0xD9:
	RJMP _0xDA
_0xD7:
	LDI  R19,LOW(32)
_0xDA:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	SUBI R20,LOW(1)
	RJMP _0xD4
_0xD6:
_0xD3:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0xDB
_0xDC:
	CPI  R18,0
	BREQ _0xDE
	SBRS R17,3
	RJMP _0xDF
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x109
_0xDF:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x109:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xE1
	SUBI R20,LOW(1)
_0xE1:
	SUBI R18,LOW(1)
	RJMP _0xDC
_0xDE:
	RJMP _0xE2
_0xDB:
_0xE4:
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
_0xE6:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0xE8
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0xE6
_0xE8:
	CPI  R19,58
	BRLO _0xE9
	SBRS R17,3
	RJMP _0xEA
	SUBI R19,-LOW(7)
	RJMP _0xEB
_0xEA:
	SUBI R19,-LOW(39)
_0xEB:
_0xE9:
	SBRC R17,4
	RJMP _0xED
	CPI  R19,49
	BRSH _0xEF
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0xEE
_0xEF:
	RJMP _0x10A
_0xEE:
	CP   R20,R18
	BRLO _0xF3
	SBRS R17,0
	RJMP _0xF4
_0xF3:
	RJMP _0xF2
_0xF4:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0xF5
	LDI  R19,LOW(48)
_0x10A:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0xF6
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xF7
	SUBI R20,LOW(1)
_0xF7:
_0xF6:
_0xF5:
_0xED:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xF8
	SUBI R20,LOW(1)
_0xF8:
_0xF2:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0xE5
	RJMP _0xE4
_0xE5:
_0xE2:
	SBRS R17,0
	RJMP _0xF9
_0xFA:
	CPI  R20,0
	BREQ _0xFC
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0xFA
_0xFC:
_0xF9:
_0xFD:
_0xBC:
_0x108:
	LDI  R16,LOW(0)
_0xA7:
	RJMP _0xA2
_0xA4:
	CALL __LOADLOCR6
	ADIW R28,18
	RET
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
	LDD  R17,Y+1
	LDD  R16,Y+0
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
