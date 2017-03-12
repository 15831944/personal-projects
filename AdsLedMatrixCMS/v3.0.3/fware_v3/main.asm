
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
;      27 
;      28 // 1 Wire Bus functions
;      29 #asm
;      30    .equ __w1_port=0x12 ;PORTD
   .equ __w1_port=0x12 ;PORTD
;      31    .equ __w1_bit=5
   .equ __w1_bit=5
;      32 #endasm
;      33 #include <1wire.h>
;      34 // DS1820 Temperature Sensor functions
;      35 #include <ds18b20.h>
;      36 // DS1307 Real Time Clock functions
;      37 #include <ds1307.h>
;      38                                       
;      39 // Declare your global variables here     
;      40 static PBYTE start_mem;         
_start_mem_G1:
	.BYTE 0x2
;      41 
;      42 bit data_bit = 0;       
;      43 bit power_off = 0;
;      44 bit is_stopping = 0;    
;      45 
;      46 register UINT x=0;
;      47 register UINT y=0;   
;      48                                 
;      49 static int   scroll_count = 0;
_scroll_count_G1:
	.BYTE 0x2
;      50 static UINT  tick_count  = 0;       
_tick_count_G1:
	.BYTE 0x2
;      51 static UINT  stopping_count = 0;       
_stopping_count_G1:
	.BYTE 0x2
;      52 static BYTE  frame_index = 0;   
_frame_index_G1:
	.BYTE 0x1
;      53 
;      54 static UINT  text_length = 0;              
_text_length_G1:
	.BYTE 0x2
;      55 static BYTE  scroll_rate = 20;
_scroll_rate_G1:
	.BYTE 0x1
;      56 static BYTE  scroll_type = LEFT_RIGHT;            
_scroll_type_G1:
	.BYTE 0x1
;      57                                                                                                      
;      58 static char szBuff[50] = "0123456789:/'C";
_szBuff_G1:
	.BYTE 0x32
;      59                                
;      60 #ifdef _CLOCK_MODE_             
;      61 
;      62 #endif
;      63 // Global variables for message control
;      64 BYTE  rx_message = UNKNOWN_MSG;
;      65 WORD  rx_wparam  = 0;
;      66 WORD  rx_lparam  = 0;
;      67 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;      68                             
;      69 extern void reset_serial();         
;      70 extern void send_echo_msg();    
;      71 extern BYTE eeprom_read(BYTE deviceID, WORD address);
;      72 extern void eeprom_write(BYTE deviceID, WORD address, BYTE data);
;      73 extern WORD eeprom_read_w(BYTE deviceID, WORD address);
;      74 extern void eeprom_write_w(BYTE deviceID, WORD address, WORD data);
;      75 extern void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      76 extern void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      77 
;      78 static void _displayFrame();
;      79 static void _doScroll();   
;      80 void LoadFrame(BYTE index);
;      81 void BlankRAM(PBYTE start_addr,PBYTE end_addr);
;      82 void GetRTCClock();
;      83 ///////////////////////////////////////////////////////////////
;      84 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;      85 ///////////////////////////////////////////////////////////////
;      86 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;      87 {       

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;      88     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;      89     ++tick_count;    
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	ADIW R30,1
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R31
;      90 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;      91 
;      92 ///////////////////////////////////////////////////////////////
;      93 // static function(s) for led matrix display panel
;      94 ///////////////////////////////////////////////////////////////
;      95 
;      96 static void _putData()
;      97 {                                                
__putData_G1:
;      98     for (y=0; y< SCREEN_HEIGHT; y++){             
	CLR  R6
	CLR  R7
_0x5:
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	CP   R6,R30
	CPC  R7,R31
	BRLO PC+3
	JMP _0x6
;      99         data_bit = (start_mem[(y)/8 + 4*(x)]>>(y%8)) & 0x01; 					
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
;     100         if (power_off) data_bit =OFF_LED;
	SBRS R2,1
	RJMP _0x7
	SET
	BLD  R2,0
;     101                
;     102         if (scroll_type == BOTTOM_TOP){
_0x7:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x3)
	BRNE _0x8
;     103             if (SCREEN_HEIGHT -y > (SCREEN_HEIGHT<<1) -scroll_count)
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
;     104                 CTRL_OUT = OFF_LED;
	SBI  0x18,3
;     105             else                   
	RJMP _0xA
_0x9:
;     106                 CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;     107         }   
_0xA:
;     108         else if (scroll_type == TOP_BOTTOM){
	RJMP _0xB
_0x8:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x2)
	BRNE _0xC
;     109             if (y >= scroll_count -SCREEN_HEIGHT){
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,16
	CP   R6,R30
	CPC  R7,R31
	BRLO _0xD
;     110                 if (scroll_count >= SCREEN_HEIGHT)
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRLT _0xE
;     111                     CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;     112                 else                   
	RJMP _0xF
_0xE:
;     113                     CTRL_OUT = OFF_LED;
	SBI  0x18,3
;     114             }
_0xF:
;     115             else{                      
	RJMP _0x10
_0xD:
;     116                 if (scroll_count >= SCREEN_HEIGHT)
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRLT _0x11
;     117                     CTRL_OUT = OFF_LED;
	SBI  0x18,3
;     118                 else                   
	RJMP _0x12
_0x11:
;     119                     CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;     120             }
_0x12:
_0x10:
;     121         }
;     122         else{                   
	RJMP _0x13
_0xC:
;     123             CTRL_OUT = data_bit;
	BST  R2,0
	IN   R26,0x18
	BLD  R26,3
	OUT  0x18,R26
;     124         }                                 
_0x13:
_0xB:
;     125         __CTRL_CLK();	    		
	__DELAY_USB 5
	SBI  0x18,2
	__DELAY_USB 5
	CBI  0x18,2
;     126     }                           
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	RJMP _0x5
_0x6:
;     127     if (scroll_type==TOP_BOTTOM || scroll_type == BOTTOM_TOP){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x2)
	BREQ _0x15
	CPI  R26,LOW(0x3)
	BRNE _0x14
_0x15:
;     128         if (SCREEN_HEIGHT >= scroll_count){      
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,17
	BRGE _0x17
;     129             int i =0;               
;     130             CTRL_OUT = OFF_LED; // turn off the LED
	SBIW R28,2
	LDI  R24,2
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x18*2)
	LDI  R31,HIGH(_0x18*2)
	CALL __INITLOCB
;	i -> Y+0
	SBI  0x18,3
;     131             for (i =0; i< (SCREEN_HEIGHT-scroll_count);i++)
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
;     132                 __CTRL_CLK();                           
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
;     133         }
	ADIW R28,2
;     134     }               
_0x17:
;     135 	__CTRL_STB();
_0x14:
	__DELAY_USB 5
	SBI  0x18,4
	__DELAY_USB 5
	CBI  0x18,4
;     136 }
	RET
;     137 
;     138 static void _displayFrame()
;     139 {                                  
__displayFrame_G1:
;     140 	for (x=0; x< SCREEN_WIDTH; x++){
	CLR  R4
	CLR  R5
_0x1D:
	LDI  R30,LOW(48)
	LDI  R31,HIGH(48)
	CP   R4,R30
	CPC  R5,R31
	BRSH _0x1E
;     141 		_putData();
	CALL __putData_G1
;     142 		__DATA_CLK();					
	SBI  0x18,0
	CBI  0x18,0
;     143 	}           
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x1D
_0x1E:
;     144     __DATA_STB();             	
	SBI  0x18,1
	CBI  0x18,1
;     145 }     
	RET
;     146                                                                                   
;     147 static void _doScroll()
;     148 {
__doScroll_G1:
;     149   if (tick_count > scroll_rate){    
	LDS  R30,_scroll_rate_G1
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRLO PC+3
	JMP _0x1F
;     150     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     151     {
;     152     case LEFT_RIGHT:                
	CPI  R30,0
	BREQ PC+3
	JMP _0x23
;     153         if (is_stopping==0){   
	SBRC R2,2
	RJMP _0x24
;     154             if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x25
;     155        	        start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	RJMP _0x110
;     156        	    else 
_0x25:
;     157        	        start_mem += 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
_0x110:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     158    	    }
;     159    	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
_0x24:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0x5C0)
	LDI  R30,HIGH(0x5C0)
	CPC  R27,R30
	BRNE _0x27
;     160    	        is_stopping = 1;
	SET
	BLD  R2,2
;     161    	    if (is_stopping ==1)
_0x27:
	SBRS R2,2
	RJMP _0x28
;     162    	    {
;     163    	        if (stopping_count++>MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x29
;     164    	        {
;     165    	            is_stopping=0;
	CLT
	BLD  R2,2
;     166    	            stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     167    	        }
;     168    	    }                                  
_0x29:
;     169        	if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
_0x28:
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-80)
	SBCI R31,HIGH(-80)
	CALL __LSLW2
	SUBI R30,LOW(-1280)
	SBCI R31,HIGH(-1280)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x2A
;     170    	    {                  
;     171    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     172        	}           
;     173    	    break;
_0x2A:
	RJMP _0x22
;     174     case RIGHT_LEFT:
_0x23:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x2B
;     175        	if (is_stopping==0){
	SBRC R2,2
	RJMP _0x2C
;     176    	        if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x2D
;     177    	            start_mem -= 4;      
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SBIW R30,4
	RJMP _0x111
;     178    	        else
_0x2D:
;     179    	            start_mem -= 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SBIW R30,8
_0x111:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     180    	        
;     181    	    }
;     182    	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
_0x2C:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0x5C0)
	LDI  R30,HIGH(0x5C0)
	CPC  R27,R30
	BRNE _0x2F
;     183    	        is_stopping = 1;
	SET
	BLD  R2,2
;     184    	    if (is_stopping ==1)
_0x2F:
	SBRS R2,2
	RJMP _0x30
;     185    	    {
;     186    	        if (stopping_count++ >MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x31
;     187    	        {
;     188    	            is_stopping=0;
	CLT
	BLD  R2,2
;     189    	            stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     190    	        }
;     191    	    }
_0x31:
;     192    	    else if (start_mem < START_RAM_TEXT)             
	RJMP _0x32
_0x30:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0x500)
	LDI  R30,HIGH(0x500)
	CPC  R27,R30
	BRSH _0x33
;     193        	{
;     194        	    scroll_count = 0;             
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     195    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     196        	}
;     197        	break;
_0x33:
_0x32:
	RJMP _0x22
;     198     case BOTTOM_TOP:               
_0x2B:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x34
;     199         if (scroll_count >=0){        
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,0
	BRLT _0x35
;     200             scroll_count--;   
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     201         }
;     202         else{                      
	RJMP _0x36
_0x35:
;     203             stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     204             scroll_count = SCREEN_HEIGHT<<1;
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     205             start_mem += 4*SCREEN_WIDTH;                                  
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     206             if (start_mem >= (START_RAM_TEXT +4*(text_length+SCREEN_WIDTH))){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ADIW R30,48
	CALL __LSLW2
	SUBI R30,LOW(-1280)
	SBCI R31,HIGH(-1280)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x37
;     207                 LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     208             }  
;     209         }
_0x37:
_0x36:
;     210         if (is_stopping==1)
	SBRS R2,2
	RJMP _0x38
;     211         {               
;     212             if (stopping_count++ > MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x39
;     213             {
;     214                 is_stopping = 0;
	CLT
	BLD  R2,2
;     215                 stopping_count = 0; 
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     216             }
;     217             else{
	RJMP _0x3A
_0x39:
;     218                 scroll_count++;
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	ADIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     219             }
_0x3A:
;     220         }   
;     221         if (scroll_count == SCREEN_HEIGHT){
_0x38:
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRNE _0x3B
;     222             is_stopping = 1;
	SET
	BLD  R2,2
;     223         }
;     224         
;     225         break;
_0x3B:
	RJMP _0x22
;     226     case TOP_BOTTOM:
_0x34:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x3C
;     227         if (scroll_count == SCREEN_HEIGHT){
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,16
	BRNE _0x3D
;     228             is_stopping = 1;
	SET
	BLD  R2,2
;     229         }                   
;     230         if (scroll_count <= (SCREEN_HEIGHT<<1)){ 
_0x3D:
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	SBIW R26,33
	BRGE _0x3E
;     231             scroll_count++;                
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	ADIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     232         }
;     233         else {            
	RJMP _0x3F
_0x3E:
;     234             scroll_count = 0;  
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     235             stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     236             start_mem += 4*SCREEN_WIDTH;                                  
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     237             if (start_mem >= (START_RAM_TEXT +4*(text_length+SCREEN_WIDTH))){
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ADIW R30,48
	CALL __LSLW2
	SUBI R30,LOW(-1280)
	SBCI R31,HIGH(-1280)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x40
;     238                 LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     239             }                              
;     240         }  
_0x40:
_0x3F:
;     241         if (is_stopping==1)
	SBRS R2,2
	RJMP _0x41
;     242         {               
;     243             if (stopping_count++ > MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x42
;     244             {
;     245                 is_stopping = 0;
	CLT
	BLD  R2,2
;     246                 stopping_count = 0;      
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     247             }
;     248             else{
	RJMP _0x43
_0x42:
;     249                 scroll_count--;
	LDS  R30,_scroll_count_G1
	LDS  R31,_scroll_count_G1+1
	SBIW R30,1
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     250             }
_0x43:
;     251         }   
;     252         break;  
_0x41:
	RJMP _0x22
;     253     case SCROLLING:   
_0x3C:
	CPI  R30,LOW(0x4)
	BRNE _0x44
;     254         if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x45
;     255    	        start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	RJMP _0x112
;     256    	    else 
_0x45:
;     257    	        start_mem += 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
_0x112:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     258         if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-80)
	SBCI R31,HIGH(-80)
	CALL __LSLW2
	SUBI R30,LOW(-1280)
	SBCI R31,HIGH(-1280)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x47
;     259    	    {            
;     260    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     261        	}       	  
;     262         break;  
_0x47:
	RJMP _0x22
;     263     case NOT_USE:
_0x44:
	CPI  R30,LOW(0x5)
	BRNE _0x49
;     264         LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     265         break;  
;     266     default:
_0x49:
;     267         break;
;     268     }
_0x22:
;     269 	tick_count = 0;
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     270 	if (frame_index >= MAX_FRAME){
	LDS  R26,_frame_index_G1
	CPI  R26,LOW(0x8)
	BRLO _0x4A
;     271 	    frame_index=0;
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     272     }		              
;     273   }
_0x4A:
;     274              
;     275 }          
_0x1F:
	RET
;     276 ////////////////////////////////////////////////////////////////////
;     277 // General functions
;     278 //////////////////////////////////////////////////////////////////// 
;     279 #define RESET_WATCHDOG()    #asm("WDR");
;     280                                                                             
;     281 void LoadConfig(BYTE index)
;     282 {
_LoadConfig:
;     283     BYTE devID = EEPROM_DEVICE_BASE;    
;     284     WORD base = 0;   // base address
;     285     devID += index<<1;                 
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
;     286     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x4B
;     287         base = (WORD)index*4;
	LDD  R30,Y+3
	LDI  R31,0
	CALL __LSLW2
	__PUTW1R 17,18
;     288         devID = EEPROM_DEVICE_BASE+(3<<1);    
	LDI  R16,LOW(166)
;     289     }                     
;     290     
;     291     // init I2C bus
;     292     i2c_init();
_0x4B:
	CALL _i2c_init
;     293     LED_STATUS = 1;
	SBI  0x18,4
;     294     scroll_rate = eeprom_read(devID, (WORD)base+0);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     295     scroll_type = eeprom_read(devID, (WORD)base+1);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_type_G1,R30
;     296     text_length = eeprom_read_w(devID, (WORD)base+2); 
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read_w
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     297     printf("line=%d rate=%d type=%d len=%d\r\n",index,scroll_rate,scroll_type,text_length);
	__POINTW1FN _0,15
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
;     298     if (text_length > DATA_LENGTH){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0xF31)
	LDI  R30,HIGH(0xF31)
	CPC  R27,R30
	BRLO _0x4C
;     299         text_length= 0;            
	LDI  R30,0
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R30
;     300     }
;     301     if (scroll_type > NOT_USE){
_0x4C:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x6)
	BRLO _0x4D
;     302         scroll_type = NOT_USE;
	LDI  R30,LOW(5)
	STS  _scroll_type_G1,R30
;     303     }          
;     304     if (scroll_rate > MAX_RATE){
_0x4D:
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x65)
	BRLO _0x4E
;     305         scroll_rate = 0;
	LDI  R30,LOW(0)
	STS  _scroll_rate_G1,R30
;     306     }
;     307     LED_STATUS = 0;   
_0x4E:
	CBI  0x18,4
;     308 }
	RJMP _0x10F
;     309                        
;     310 void SaveTextLength(BYTE index)
;     311 {
_SaveTextLength:
;     312     BYTE devID = EEPROM_DEVICE_BASE;    
;     313     WORD base = 0;   // base address
;     314     devID += index<<1;                 
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
;     315     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x4F
;     316         base = (WORD)index*4;
	LDD  R30,Y+3
	LDI  R31,0
	CALL __LSLW2
	__PUTW1R 17,18
;     317         devID = EEPROM_DEVICE_BASE+(3<<1);    
	LDI  R16,LOW(166)
;     318     }                
;     319     
;     320     i2c_init();
_0x4F:
	CALL _i2c_init
;     321     LED_STATUS = 1;   
	SBI  0x18,4
;     322     eeprom_write_w(devID, base+2,text_length); 
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
;     323     LED_STATUS = 0;   
	CBI  0x18,4
;     324 }
_0x10F:
	CALL __LOADLOCR3
	ADIW R28,4
	RET
;     325 
;     326 void SaveConfig(BYTE rate,BYTE type, BYTE index)
;     327 {                     
_SaveConfig:
;     328     BYTE devID = EEPROM_DEVICE_BASE;    
;     329     WORD base = 0;   // base address
;     330     devID += index<<1;                 
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
;     331     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x50
;     332         base = (WORD)index*4;
	LDD  R30,Y+3
	LDI  R31,0
	CALL __LSLW2
	__PUTW1R 17,18
;     333         devID = EEPROM_DEVICE_BASE+(3<<1);    
	LDI  R16,LOW(166)
;     334     }                
;     335     
;     336     i2c_init();
_0x50:
	CALL _i2c_init
;     337     LED_STATUS = 1;  
	SBI  0x18,4
;     338     eeprom_write(devID, base+0,rate);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	CALL _eeprom_write
;     339     eeprom_write(devID, base+1,type);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	ST   -Y,R30
	CALL _eeprom_write
;     340     LED_STATUS = 0;       
	CBI  0x18,4
;     341 }
	CALL __LOADLOCR3
	ADIW R28,6
	RET
;     342 
;     343 void SaveToEEPROM(PBYTE address,WORD length,BYTE index)
;     344 {                             
_SaveToEEPROM:
;     345     PBYTE temp = 0;     
;     346     BYTE devID = EEPROM_DEVICE_BASE;
;     347     WORD base = 0;   // base address
;     348     devID += index<<1;                 
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
;     349     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x51
;     350         base = ((WORD)index-3)*(SMALL_SIZE);                       
	LDD  R30,Y+5
	LDI  R31,0
	SBIW R30,3
	LDI  R26,LOW(5120)
	LDI  R27,HIGH(5120)
	CALL __MULW12U
	__PUTW1R 19,20
;     351         devID = EEPROM_DEVICE_BASE+(3<<1);    
	LDI  R18,LOW(166)
;     352     }         				
;     353     temp = address;         
_0x51:
	__GETWRS 16,17,8
;     354         
;     355     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xF31)
	LDI  R30,HIGH(0xF31)
	CPC  R27,R30
	BRLO _0x52
;     356         return; // invalid param 
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     357     length = (WORD)address+4*(SCREEN_WIDTH+length);         
_0x52:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,48
	CALL __LSLW2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     358     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x53
;     359         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     360     // init I2C bus
;     361     i2c_init();
_0x53:
	CALL _i2c_init
;     362     LED_STATUS = 1;        
	SBI  0x18,4
;     363     
;     364     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x55:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x56
;     365     {   
;     366         RESET_WATCHDOG();                          	                                              
	WDR
;     367         eeprom_write_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE);	      
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
;     368     }       
	__ADDWRN 16,17,64
	JMP  _0x55
_0x56:
;     369         
;     370     LED_STATUS = 0;   
	CBI  0x18,4
;     371 }
	RJMP _0x10E
;     372                       
;     373 void LoadToRAM(PBYTE address,WORD length,BYTE index)
;     374 {                         
_LoadToRAM:
;     375     PBYTE temp = 0;                                                                  
;     376     BYTE devID = EEPROM_DEVICE_BASE;
;     377     WORD base = 0;   // base address
;     378     devID += index<<1;                 
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
;     379     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x57
;     380         base = ((WORD)index-3)*(SMALL_SIZE);                              
	LDD  R30,Y+5
	LDI  R31,0
	SBIW R30,3
	LDI  R26,LOW(5120)
	LDI  R27,HIGH(5120)
	CALL __MULW12U
	__PUTW1R 19,20
;     381         devID = EEPROM_DEVICE_BASE+(3<<1);    
	LDI  R18,LOW(166)
;     382     }       				
;     383     temp = address;                 
_0x57:
	__GETWRS 16,17,8
;     384 
;     385     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xF31)
	LDI  R30,HIGH(0xF31)
	CPC  R27,R30
	BRLO _0x58
;     386         return; // invalid param
_0x10E:
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     387     length = (WORD)address+4*(SCREEN_WIDTH+length);         
_0x58:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,48
	CALL __LSLW2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     388     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x59
;     389         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     390     // init I2C bus
;     391     i2c_init();
_0x59:
	CALL _i2c_init
;     392     LED_STATUS = 1;             
	SBI  0x18,4
;     393  
;     394     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x5B:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x5C
;     395     {
;     396         eeprom_read_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE );	                                   
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
;     397         RESET_WATCHDOG();     
	WDR
;     398     }             
	__ADDWRN 16,17,64
	JMP  _0x5B
_0x5C:
;     399 
;     400     LED_STATUS = 0;   
	CBI  0x18,4
;     401 }
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     402 
;     403 void LoadFrame(BYTE index)
;     404 {                 
_LoadFrame:
;     405     if (index >= MAX_FRAME) index=0;  
;	index -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x8)
	BRLO _0x5D
	LDI  R30,LOW(0)
	ST   Y,R30
;     406     #ifdef _CLOCK_MODE_
;     407      index=0;
;     408     #endif
;     409     
;     410     LoadConfig(index);  
_0x5D:
	LD   R30,Y
	ST   -Y,R30
	CALL _LoadConfig
;     411     if (scroll_type==NOT_USE){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x5)
	BRNE _0x5E
;     412         return;           
	RJMP _0x10D
;     413     }      
;     414                  
;     415     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
_0x5E:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     416     LoadToRAM((PBYTE)START_RAM_TEXT,text_length,index);
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
	CALL _LoadToRAM
;     417     stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     418     scroll_count = 0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     419     is_stopping = 0;
	CLT
	BLD  R2,2
;     420     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     421     {
;     422     case LEFT_RIGHT:
	CPI  R30,0
	BRNE _0x62
;     423         start_mem = (PBYTE)START_RAM_TEXT; 
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     424         break;                
	RJMP _0x61
;     425     case RIGHT_LEFT:
_0x62:
	CPI  R30,LOW(0x1)
	BRNE _0x63
;     426         start_mem = (PBYTE)START_RAM_TEXT + (text_length<<2); 
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	CALL __LSLW2
	SUBI R30,LOW(-1280)
	SBCI R31,HIGH(-1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     427         break;
	RJMP _0x61
;     428     case BOTTOM_TOP:                             
_0x63:
	CPI  R30,LOW(0x3)
	BRNE _0x64
;     429         scroll_count = SCREEN_HEIGHT<<1;
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R31
;     430         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(1472)
	LDI  R31,HIGH(1472)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     431         break;
	RJMP _0x61
;     432     case TOP_BOTTOM:   
_0x64:
	CPI  R30,LOW(0x2)
	BRNE _0x65
;     433         scroll_count = 0;                     
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     434         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(1472)
	LDI  R31,HIGH(1472)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     435         break;  
	RJMP _0x61
;     436     case SCROLLING:
_0x65:
	CPI  R30,LOW(0x4)
	BRNE _0x67
;     437         start_mem = (PBYTE)START_RAM_TEXT;
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     438         break;
;     439     default: 
_0x67:
;     440         break;
;     441     }
_0x61:
;     442 #ifdef _CLOCK_MODE_
;     443     GetRTCClock();
;     444 #endif     
;     445                        
;     446 }
_0x10D:
	ADIW R28,1
	RET
;     447 
;     448 void SerialToRAM(PBYTE address,WORD length)                                             
;     449 {
_SerialToRAM:
;     450     PBYTE temp = 0;          
;     451     UINT i =0;     				
;     452     temp   = address;    
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
;     453     LED_STATUS = 1;
	SBI  0x18,4
;     454     for (i =0; i< (length<<2); i++)         
	__GETWRN 18,19,0
_0x69:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL __LSLW2
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x6A
;     455     {                          
;     456         BYTE data = 0;
;     457         data = ~getchar();
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x6B*2)
	LDI  R31,HIGH(_0x6B*2)
	CALL __INITLOCB
;	*address -> Y+7
;	length -> Y+5
;	data -> Y+0
	CALL _getchar
	COM  R30
	ST   Y,R30
;     458         *temp = data;
	MOVW R26,R16
	ST   X,R30
;     459         temp++;
	__ADDWRN 16,17,1
;     460         RESET_WATCHDOG();                                     
	WDR
;     461     }              
	ADIW R28,1
	__ADDWRN 18,19,1
	JMP  _0x69
_0x6A:
;     462     LED_STATUS = 0;
	CBI  0x18,4
;     463 }
	CALL __LOADLOCR4
	ADIW R28,8
	RET
;     464                       
;     465 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     466 {        
_BlankRAM:
;     467     PBYTE temp = START_RAM;
;     468     for (temp = start_addr; temp<= end_addr; temp++)    
	ST   -Y,R17
	ST   -Y,R16
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*temp -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x6D:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x6E
;     469         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     470 }
	__ADDWRN 16,17,1
	RJMP _0x6D
_0x6E:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;     471 
;     472 void SetRTCDateTime()
;     473 {
_SetRTCDateTime:
;     474     i2c_init();
	CALL _i2c_init
;     475     LED_STATUS = 0;   
	CBI  0x18,4
;     476     rtc_set_time(0,0,0);    /* clear CH bit */
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	ST   -Y,R30
	CALL _rtc_set_time
;     477     rtc_set_date(getchar(),getchar(),getchar());
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _rtc_set_date
;     478     rtc_set_time(getchar(),getchar(),getchar());    
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _getchar
	ST   -Y,R30
	CALL _rtc_set_time
;     479     LED_STATUS = 1;
	SBI  0x18,4
;     480     PORTD = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     481     DDRD = 0x3F; 
	LDI  R30,LOW(63)
	OUT  0x11,R30
;     482 }
	RET
;     483 
;     484 #ifdef _CLOCK_MODE_
;     485 void GetRTCClock()
;     486 {         
;     487     int temp=0;     
;     488     WORD ch=0,length=0;
;     489     WORD i=0,x=0,y=0,pos=0;                                                                               
;     490     PBYTE pClockBuff = START_RAM_TEXT+SCREEN_WIDTH*4;
;     491     PBYTE pClockDisp = START_RAM_TEXT+SCREEN_WIDTH*4+(14*CHAR_WIDTH*4);
;     492     BYTE hh=0,mm=0,ss=0;
;     493     BYTE DD=0,MM=0,YY=00;
;     494     i2c_init();          
;     495     RESET_WATCHDOG();                 
;     496     rtc_get_date(&DD,&MM,&YY);
;     497     rtc_get_time(&hh,&mm,&ss);                                                                                                                  
;     498     RESET_WATCHDOG();
;     499     if (!ds18b20_init(0,10,40,DS18B20_9BIT_RES)){
;     500         printf("INIT DS18B20 ERROR!! \r\n");
;     501     }
;     502     temp=(int)ds18b20_temperature(0);        
;     503     if (temp<0 || temp>100) temp = 0;       
;     504     sprintf(szBuff,"%02d:%02d%02d/%02d%02d'C",hh,mm,DD,MM,temp);
;     505     printf("%02d:%02d %02d/%02d %02d'C \r\n",hh,mm,DD,MM,temp);
;     506     
;     507     for (i=0; i<14; i++){    
;     508         ch = (WORD)szBuff[i]&0x0F;
;     509         length = CHAR_WIDTH;         
;     510         if (i==2 || i==7 || i==12){
;     511             length = SYMB_WIDTH;
;     512         }                         
;     513         if (i==2) ch = 0x0A;
;     514         if (i==7) ch = 0x0B;
;     515         if (i==12) ch = 0x0C;
;     516         if (i==13) ch = 0x0D;
;     517         for (x=0; x< length; x++){
;     518             for (y=0; y<4; y++){
;     519                 pClockDisp[pos+(x*4)+y]=pClockBuff[ch*(CHAR_WIDTH*4)+(x*4)+y];
;     520             }
;     521         }                             
;     522         if (i==2 || i==7 || i==12){
;     523             pos += (SYMB_WIDTH*4);
;     524         }        
;     525         else{                 
;     526             pos += (CHAR_WIDTH*4);
;     527         }
;     528         RESET_WATCHDOG();
;     529     }
;     530     start_mem = (PBYTE)START_RAM_TEXT+SCREEN_WIDTH*4+(14*CHAR_WIDTH*4);  
;     531     text_length += (11*CHAR_WIDTH+3*SYMB_WIDTH);                             
;     532 }
;     533 #endif
;     534 ///////////////////////////////////////////////////////////////
;     535 // END static function(s)
;     536 ///////////////////////////////////////////////////////////////
;     537 
;     538 ///////////////////////////////////////////////////////////////           
;     539 
;     540 void InitDevice()
;     541 {
_InitDevice:
;     542 // Declare your local variables here
;     543 // Crystal Oscillator division factor: 1  
;     544 #ifdef _MEGA162_INCLUDED_ 
;     545 #pragma optsize-
;     546 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     547 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     548 #ifdef _OPTIMIZE_SIZE_
;     549 #pragma optsize+
;     550 #endif                    
;     551 #endif
;     552 
;     553 PORTA=0x00;
	OUT  0x1B,R30
;     554 DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;     555 
;     556 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
;     557 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     558 
;     559 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     560 DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
;     561 
;     562 PORTD=0xFF;
	OUT  0x12,R30
;     563 DDRD=0x00; 
	LDI  R30,LOW(0)
	OUT  0x11,R30
;     564 
;     565 PORTE=0x00;
	OUT  0x7,R30
;     566 DDRE=0xFF;
	LDI  R30,LOW(255)
	OUT  0x6,R30
;     567 
;     568 // Timer/Counter 0 initialization
;     569 // Clock source: System Clock
;     570 // Clock value: 250.000 kHz
;     571 // Mode: Normal top=FFh
;     572 // OC0 output: Disconnected
;     573 TCCR0=0x03;     // 4 us per tick
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     574 TCNT0=0x05;     // 1ms = 4*250
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     575 OCR0=0x00;      // 255 -250 = TCNT0
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     576 
;     577 #ifdef _MEGA162_INCLUDED_
;     578 UCSR0A=0x00;
	OUT  0xB,R30
;     579 UCSR0B=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     580 UCSR0C=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     581 UBRR0H=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     582 UBRR0L=0x67;      //  16 MHz     
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     583 
;     584 #else // _MEGA8515_INCLUDE_     
;     585 UCSRA=0x00;
;     586 UCSRB=0x98;
;     587 UCSRC=0x86;
;     588 UBRRH=0x00;
;     589 UBRRL=0x33;       // 8 MHz
;     590 #endif
;     591 
;     592 // Lower page wait state(s): None
;     593 // Upper page wait state(s): None
;     594 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     595 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     596 
;     597 // Timer(s)/Counter(s) Interrupt(s) initialization
;     598 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     599 ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
;     600 
;     601 // Load calibration byte for osc.  
;     602 #ifdef _MEGA162_INCLUDED_
;     603 OSCCAL = 0x5E; 
	LDI  R30,LOW(94)
	OUT  0x4,R30
;     604 #else
;     605 OSCCAL = 0xA7; 
;     606 #endif            
;     607 
;     608 // I2C Bus initialization
;     609 i2c_init();
	CALL _i2c_init
;     610 
;     611 // DS1307 Real Time Clock initialization
;     612 // Square wave output on pin SQW/OUT: Off
;     613 // SQW/OUT pin state: 1
;     614 rtc_init(3,0,1);
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _rtc_init
;     615 // Watchdog Timer initialization
;     616 // Watchdog Timer Prescaler: OSC/2048k     
;     617 #ifdef __WATCH_DOG_
;     618 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     619 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     620 #endif
;     621 }
	RET
;     622 
;     623 void PowerReset()
;     624 {      
_PowerReset:
;     625     start_mem = (PBYTE)START_RAM_TEXT;                    
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     626 
;     627     InitDevice();
	CALL _InitDevice
;     628        
;     629     LED_STATUS = 0;
	CBI  0x18,4
;     630     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);  
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     631     
;     632     LED_STATUS = 0;  
	CBI  0x18,4
;     633     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     634     LED_STATUS = 1;
	SBI  0x18,4
;     635     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     636     LED_STATUS = 0;
	CBI  0x18,4
;     637     delay_ms(500);    
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     638     LED_STATUS = 1;
	SBI  0x18,4
;     639                 
;     640     frame_index= 0;
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     641     LoadFrame(frame_index);
	ST   -Y,R30
	CALL _LoadFrame
;     642         
;     643 #ifdef _INIT_EEPROM_ 
;     644 {
;     645     BYTE i =0;
;     646     for (i =0; i< MAX_FRAME; i++){   
;     647         SaveConfig(10,0,i);
;     648         text_length = 160;
;     649         SaveTextLength(i);            
;     650     }
;     651 }
;     652 #endif  
;     653     printf("LCMS v3.03 Designed by CuongQuay\r\n");  
	__POINTW1FN _0,48
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     654     printf("cuong3ihut@yahoo.com - 0915651001\r\n");
	__POINTW1FN _0,83
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     655     printf("Started date: 31.03.2007\r\n");
	__POINTW1FN _0,119
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     656     
;     657 #ifdef _CLOCK_MODE_
;     658 GetRTCClock();
;     659 #endif    
;     660 }
	RET
;     661 
;     662 void ProcessCommand()
;     663 {
_ProcessCommand:
;     664    	#asm("cli"); 
	cli
;     665     RESET_WATCHDOG();
	WDR
;     666 
;     667     // serial message processing     
;     668     switch (rx_message)
	MOV  R30,R8
;     669     {                  
;     670     case LOAD_TEXT_MSG:
	CPI  R30,LOW(0x2)
	BRNE _0x72
;     671         {                
;     672             text_length = rx_wparam;            
	__PUTWMRN _text_length_G1,0,9,10
;     673             frame_index = rx_lparam&0x0F;   
	__GETW1R 11,12
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	STS  _frame_index_G1,R30
;     674             BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     675             SerialToRAM((PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH),text_length);                
	LDI  R30,LOW(1472)
	LDI  R31,HIGH(1472)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _SerialToRAM
;     676 			start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);				
	LDI  R30,LOW(1472)
	LDI  R31,HIGH(1472)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     677 			SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	CALL _SaveToEEPROM
;     678 			SaveTextLength(rx_lparam);							  
	ST   -Y,R11
	CALL _SaveTextLength
;     679         }				
;     680         break;           
	RJMP _0x71
;     681     case LOAD_BKGND_MSG:
_0x72:
	CPI  R30,LOW(0x3)
	BRNE _0x73
;     682         {
;     683         }
;     684         break; 
	RJMP _0x71
;     685     case SET_RTC_MSG:
_0x73:
	CPI  R30,LOW(0xC)
	BRNE _0x74
;     686         {     
;     687             SetRTCDateTime();
	CALL _SetRTCDateTime
;     688         }
;     689         break;  
	RJMP _0x71
;     690     case SET_CFG_MSG: 
_0x74:
	CPI  R30,LOW(0xD)
	BRNE _0x75
;     691         {               
;     692             SaveConfig(rx_wparam&0x0FF,rx_wparam>>8,rx_lparam); 
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	ST   -Y,R11
	CALL _SaveConfig
;     693         }
;     694         break;    
	RJMP _0x71
;     695     case EEPROM_SAVE_TEXT_MSG:     
_0x75:
	CPI  R30,LOW(0x7)
	BREQ _0x77
;     696     case EEPROM_SAVE_ALL_MSG:  
	CPI  R30,LOW(0xB)
	BRNE _0x78
_0x77:
;     697         {                                                          
;     698             SaveTextLength(rx_lparam);              
	ST   -Y,R11
	CALL _SaveTextLength
;     699             SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	CALL _SaveToEEPROM
;     700         }
;     701         break;         
	RJMP _0x71
;     702     case EEPROM_LOAD_TEXT_MSG:    
_0x78:
	CPI  R30,LOW(0x6)
	BREQ _0x7A
;     703     case EEPROM_LOAD_ALL_MSG:
	CPI  R30,LOW(0xA)
	BRNE _0x7B
_0x7A:
;     704         {
;     705             LoadConfig(rx_lparam);                               
	ST   -Y,R11
	CALL _LoadConfig
;     706             LoadToRAM((PBYTE)START_RAM_TEXT,text_length,rx_lparam); 
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R11
	CALL _LoadToRAM
;     707             start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);
	LDI  R30,LOW(1472)
	LDI  R31,HIGH(1472)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     708         }
;     709         break;  
	RJMP _0x71
;     710     case POWER_CTRL_MSG:
_0x7B:
	CPI  R30,LOW(0x10)
	BRNE _0x7D
;     711         power_off = rx_wparam&0x01;
	BST  R9,0
	BLD  R2,1
;     712         break;     
;     713     default:
_0x7D:
;     714         break;
;     715     }                 
_0x71:
;     716     send_echo_msg();            
	RCALL _send_echo_msg
;     717     rx_message = UNKNOWN_MSG;
	CLR  R8
;     718     #asm("sei");        
	sei
;     719 }           
	RET
;     720 ////////////////////////////////////////////////////////////////////////////////
;     721 // MAIN PROGRAM
;     722 ////////////////////////////////////////////////////////////////////////////////
;     723 void main(void)
;     724 {         
_main:
;     725     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x7E
;     726         // Watchdog Reset
;     727         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     728         reset_serial(); 
	RCALL _reset_serial
;     729     }
;     730     else {      
	RJMP _0x7F
_0x7E:
;     731         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     732     }                                     
_0x7F:
;     733      
;     734     PowerReset();                        
	CALL _PowerReset
;     735     #asm("sei");     
	sei
;     736 
;     737     while (1){          
_0x80:
;     738         if (rx_message != UNKNOWN_MSG){   
	TST  R8
	BREQ _0x83
;     739             ProcessCommand();   
	CALL _ProcessCommand
;     740         }
;     741         else{           
	RJMP _0x84
_0x83:
;     742             if (!is_stopping){
	SBRC R2,2
	RJMP _0x85
;     743                 _displayFrame();
	CALL __displayFrame_G1
;     744             }
;     745             _doScroll();            
_0x85:
	CALL __doScroll_G1
;     746         }
_0x84:
;     747         RESET_WATCHDOG();
	WDR
;     748     };
	JMP  _0x80
;     749 
;     750 }
_0x86:
	NOP
	RJMP _0x86
;     751                          
;     752 #include "define.h"
;     753 
;     754 ///////////////////////////////////////////////////////////////
;     755 // serial interrupt handle - processing serial message ...
;     756 ///////////////////////////////////////////////////////////////
;     757 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     758 ///////////////////////////////////////////////////////////////
;     759 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     760 extern BYTE  rx_message;
;     761 extern WORD  rx_wparam;
;     762 extern WORD  rx_lparam;
;     763 
;     764 #if RX_BUFFER_SIZE<256
;     765 unsigned char rx_wr_index,rx_counter;
;     766 #else
;     767 unsigned int rx_wr_index,rx_counter;
;     768 #endif
;     769 
;     770 void send_echo_msg();
;     771 
;     772 // USART Receiver interrupt service routine
;     773 #ifdef _MEGA162_INCLUDED_                    
;     774 interrupt [USART0_RXC] void usart_rx_isr(void)
;     775 #else
;     776 interrupt [USART_RXC] void usart_rx_isr(void)
;     777 #endif
;     778 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     779 char status,data;
;     780 #ifdef _MEGA162_INCLUDED_  
;     781 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;     782 data=UDR0;
	IN   R17,12
;     783 #else     
;     784 status=UCSRA;
;     785 data=UDR;
;     786 #endif          
;     787     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+3
	JMP _0x87
;     788     {
;     789         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R13
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;     790         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0x88
	CLR  R13
;     791         if (++rx_counter == RX_BUFFER_SIZE)
_0x88:
	INC  R14
	LDI  R30,LOW(8)
	CP   R30,R14
	BRNE _0x89
;     792         {
;     793             rx_counter=0;
	CLR  R14
;     794             if (
;     795                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;     796                 rx_buffer[2]==WAKEUP_CHAR 
;     797                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BRNE _0x8B
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BRNE _0x8B
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ _0x8C
_0x8B:
	RJMP _0x8A
_0x8C:
;     798             {
;     799                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 8,_rx_buffer,3
;     800                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 9,_rx_buffer,4
	CLR  R10
;     801                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R9
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 9,10
;     802                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 11,_rx_buffer,6
	CLR  R12
;     803                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;     804             }
;     805             else if(
	RJMP _0x8D
_0x8A:
;     806                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;     807                 rx_buffer[2]==ESCAPE_CHAR 
;     808                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0x8F
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0x8F
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0x90
_0x8F:
	RJMP _0x8E
_0x90:
;     809             {
;     810                 rx_wr_index=0;
	CLR  R13
;     811                 rx_counter =0;
	CLR  R14
;     812             }      
;     813         };
_0x8E:
_0x8D:
_0x89:
;     814     };
_0x87:
;     815 }
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     816 
;     817 void send_echo_msg()
;     818 {
_send_echo_msg:
;     819     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     820     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     821     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     822     putchar(rx_message);
	ST   -Y,R8
	CALL _putchar
;     823     putchar(rx_wparam>>8);
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     824     putchar(rx_wparam&0x00FF);
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     825     putchar(rx_lparam>>8);        
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     826     putchar(rx_lparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     827 }  
	RET
;     828 
;     829 void reset_serial()
;     830 {
_reset_serial:
;     831     rx_wr_index=0;
	CLR  R13
;     832     rx_counter =0;
	CLR  R14
;     833     rx_message = UNKNOWN_MSG;
	CLR  R8
;     834 }
	RET
;     835 
;     836 ///////////////////////////////////////////////////////////////
;     837 // END serial interrupt handle
;     838 /////////////////////////////////////////////////////////////// 
;     839 /*****************************************************
;     840 This program was produced by the
;     841 CodeWizardAVR V1.24.4a Standard
;     842 Automatic Program Generator
;     843 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;     844 http://www.hpinfotech.com
;     845 e-mail:office@hpinfotech.com
;     846 
;     847 Project : 
;     848 Version : 
;     849 Date    : 19/5/2005
;     850 Author  : 3iGROUP                
;     851 Company : http://www.3ihut.net   
;     852 Comments: 
;     853 
;     854 
;     855 Chip type           : ATmega8515
;     856 Program type        : Application
;     857 Clock frequency     : 8.000000 MHz
;     858 Memory model        : Small
;     859 External SRAM size  : 32768
;     860 Ext. SRAM wait state: 0
;     861 Data Stack size     : 128
;     862 *****************************************************/
;     863 
;     864 #include "define.h"                                           
;     865 
;     866 #define     ACK                 1
;     867 #define     NO_ACK              0
;     868 
;     869 // I2C Bus functions
;     870 #asm
;     871    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;     872    .equ __sda_bit=3
   .equ __sda_bit=3
;     873    .equ __scl_bit=2
   .equ __scl_bit=2
;     874 #endasm                   
;     875 
;     876 #ifdef __EEPROM_WRITE_BYTE
;     877 BYTE eeprom_read(BYTE deviceID, WORD address) 
;     878 {
_eeprom_read:
;     879     BYTE data;
;     880     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	address -> Y+1
;	data -> R16
	CALL _i2c_start
;     881     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     882     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     883     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     884     
;     885     i2c_start();
	CALL _i2c_start
;     886     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     887     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R16,R30
;     888     i2c_stop();
	CALL _i2c_stop
;     889     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0x10C
;     890 }
;     891 
;     892 void eeprom_write(BYTE deviceID, WORD address, BYTE data) 
;     893 {
_eeprom_write:
;     894     i2c_start();
;	deviceID -> Y+3
;	address -> Y+1
;	data -> Y+0
	CALL _i2c_start
;     895     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     896     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     897     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     898     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	CALL _i2c_write
;     899     i2c_stop();
	CALL _i2c_stop
;     900 
;     901     /* 10ms delay to complete the write operation */
;     902     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     903 }                                 
_0x10C:
	ADIW R28,4
	RET
;     904 
;     905 WORD eeprom_read_w(BYTE deviceID, WORD address)
;     906 {
_eeprom_read_w:
;     907     WORD result = 0;
;     908     result = eeprom_read(deviceID,address);
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
;     909     result = (result<<8) | eeprom_read(deviceID,address+1);
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
;     910     return result;
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x10B
;     911 }
;     912 void eeprom_write_w(BYTE deviceID, WORD address, WORD data)
;     913 {
_eeprom_write_w:
;     914     eeprom_write(deviceID,address,data>>8);
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
;     915     eeprom_write(deviceID,address+1,data&0x0FF);    
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
;     916 }
_0x10B:
	ADIW R28,5
	RET
;     917 
;     918 #endif // __EEPROM_WRITE_BYTE
;     919 void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     920 {
_eeprom_read_page:
;     921     BYTE i = 0;
;     922     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;     923     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;     924     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     925     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     926     
;     927     i2c_start();
	CALL _i2c_start
;     928     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     929                                     
;     930     while ( i < page_size-1 )
_0x91:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0x93
;     931     {
;     932         buffer[i++] = i2c_read(ACK);   // read at current
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
;     933     }
	RJMP _0x91
_0x93:
;     934     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
;     935          
;     936     i2c_stop();
	CALL _i2c_stop
;     937 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     938 
;     939 void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     940 {
_eeprom_write_page:
;     941     BYTE i = 0;
;     942     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;     943     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;     944     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     945     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     946                                         
;     947     while ( i < page_size )
_0x94:
	LDD  R30,Y+1
	CP   R16,R30
	BRSH _0x96
;     948     {
;     949         i2c_write(buffer[i++]);
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
;     950         #asm("nop");#asm("nop");
	nop
	nop
;     951     }          
	JMP  _0x94
_0x96:
;     952     i2c_stop(); 
	CALL _i2c_stop
;     953     delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     954 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     955                                               

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
	BREQ _0x97
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0x98
_0x97:
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _putchar
_0x98:
	RJMP _0x10A
__print_G4:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R16,0
_0x99:
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
	JMP _0x9B
	MOV  R30,R16
	CPI  R30,0
	BRNE _0x9F
	CPI  R19,37
	BRNE _0xA0
	LDI  R16,LOW(1)
	RJMP _0xA1
_0xA0:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
_0xA1:
	RJMP _0x9E
_0x9F:
	CPI  R30,LOW(0x1)
	BRNE _0xA2
	CPI  R19,37
	BRNE _0xA3
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0x113
_0xA3:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0xA4
	LDI  R17,LOW(1)
	RJMP _0x9E
_0xA4:
	CPI  R19,43
	BRNE _0xA5
	LDI  R21,LOW(43)
	RJMP _0x9E
_0xA5:
	CPI  R19,32
	BRNE _0xA6
	LDI  R21,LOW(32)
	RJMP _0x9E
_0xA6:
	RJMP _0xA7
_0xA2:
	CPI  R30,LOW(0x2)
	BRNE _0xA8
_0xA7:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0xA9
	ORI  R17,LOW(128)
	RJMP _0x9E
_0xA9:
	RJMP _0xAA
_0xA8:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x9E
_0xAA:
	CPI  R19,48
	BRLO _0xAD
	CPI  R19,58
	BRLO _0xAE
_0xAD:
	RJMP _0xAC
_0xAE:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x9E
_0xAC:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0xB2
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
	RJMP _0xB3
_0xB2:
	CPI  R30,LOW(0x73)
	BRNE _0xB5
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
	RJMP _0xB6
_0xB5:
	CPI  R30,LOW(0x70)
	BRNE _0xB8
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
_0xB6:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0xB9
_0xB8:
	CPI  R30,LOW(0x64)
	BREQ _0xBC
	CPI  R30,LOW(0x69)
	BRNE _0xBD
_0xBC:
	ORI  R17,LOW(4)
	RJMP _0xBE
_0xBD:
	CPI  R30,LOW(0x75)
	BRNE _0xBF
_0xBE:
	LDI  R30,LOW(_tbl10_G4*2)
	LDI  R31,HIGH(_tbl10_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0xC0
_0xBF:
	CPI  R30,LOW(0x58)
	BRNE _0xC2
	ORI  R17,LOW(8)
	RJMP _0xC3
_0xC2:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0xF4
_0xC3:
	LDI  R30,LOW(_tbl16_G4*2)
	LDI  R31,HIGH(_tbl16_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0xC0:
	SBRS R17,2
	RJMP _0xC5
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
	BRGE _0xC6
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0xC6:
	CPI  R21,0
	BREQ _0xC7
	SUBI R16,-LOW(1)
	RJMP _0xC8
_0xC7:
	ANDI R17,LOW(251)
_0xC8:
	RJMP _0xC9
_0xC5:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0xC9:
_0xB9:
	SBRC R17,0
	RJMP _0xCA
_0xCB:
	CP   R16,R20
	BRSH _0xCD
	SBRS R17,7
	RJMP _0xCE
	SBRS R17,2
	RJMP _0xCF
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0xD0
_0xCF:
	LDI  R19,LOW(48)
_0xD0:
	RJMP _0xD1
_0xCE:
	LDI  R19,LOW(32)
_0xD1:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	SUBI R20,LOW(1)
	RJMP _0xCB
_0xCD:
_0xCA:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0xD2
_0xD3:
	CPI  R18,0
	BREQ _0xD5
	SBRS R17,3
	RJMP _0xD6
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x114
_0xD6:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x114:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xD8
	SUBI R20,LOW(1)
_0xD8:
	SUBI R18,LOW(1)
	RJMP _0xD3
_0xD5:
	RJMP _0xD9
_0xD2:
_0xDB:
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
_0xDD:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0xDF
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0xDD
_0xDF:
	CPI  R19,58
	BRLO _0xE0
	SBRS R17,3
	RJMP _0xE1
	SUBI R19,-LOW(7)
	RJMP _0xE2
_0xE1:
	SUBI R19,-LOW(39)
_0xE2:
_0xE0:
	SBRC R17,4
	RJMP _0xE4
	CPI  R19,49
	BRSH _0xE6
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0xE5
_0xE6:
	RJMP _0x115
_0xE5:
	CP   R20,R18
	BRLO _0xEA
	SBRS R17,0
	RJMP _0xEB
_0xEA:
	RJMP _0xE9
_0xEB:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0xEC
	LDI  R19,LOW(48)
_0x115:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0xED
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xEE
	SUBI R20,LOW(1)
_0xEE:
_0xED:
_0xEC:
_0xE4:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xEF
	SUBI R20,LOW(1)
_0xEF:
_0xE9:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0xDC
	RJMP _0xDB
_0xDC:
_0xD9:
	SBRS R17,0
	RJMP _0xF0
_0xF1:
	CPI  R20,0
	BREQ _0xF3
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0xF1
_0xF3:
_0xF0:
_0xF4:
_0xB3:
_0x113:
	LDI  R16,LOW(0)
_0x9E:
	RJMP _0x99
_0x9B:
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
	BREQ _0x108
	LDD  R30,Y+2
	ORI  R30,0x10
	STD  Y+2,R30
_0x108:
	LD   R30,Y
	CPI  R30,0
	BREQ _0x109
	LDD  R30,Y+2
	ORI  R30,0x80
	STD  Y+2,R30
_0x109:
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
	RJMP _0x10A
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
	RJMP _0x10A
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
_0x10A:
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
