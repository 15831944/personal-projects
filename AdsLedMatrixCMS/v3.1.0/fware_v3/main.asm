
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
;      36 bit is_half_top = 1;
;      37 
;      38 unsigned long temp[4];
_temp:
	.BYTE 0x10
;      39 unsigned long dw_temp; 
_dw_temp:
	.BYTE 0x4
;      40 
;      41 register UINT x=0;
;      42 register UINT y=0;   
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
;      47 static UINT  stopping_count = 0;       
_stopping_count_G1:
	.BYTE 0x2
;      48 static BYTE  frame_index = 0;   
_frame_index_G1:
	.BYTE 0x1
;      49 
;      50 static UINT  text_length = 0; 
_text_length_G1:
	.BYTE 0x2
;      51 static BYTE  scroll_step = 0;             
_scroll_step_G1:
	.BYTE 0x1
;      52 static BYTE  scroll_rate = 20;
_scroll_rate_G1:
	.BYTE 0x1
;      53 static BYTE  scroll_type = LEFT_RIGHT;            
_scroll_type_G1:
	.BYTE 0x1
;      54              
;      55 // Global variables for message control
;      56 BYTE  rx_message = UNKNOWN_MSG;
;      57 WORD  rx_wparam  = 0;
;      58 WORD  rx_lparam  = 0;
;      59 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;      60                             
;      61 extern void reset_serial();         
;      62 extern void send_echo_msg();    
;      63 extern BYTE eeprom_read(BYTE deviceID, WORD address);
;      64 extern void eeprom_write(BYTE deviceID, WORD address, BYTE data);
;      65 extern WORD eeprom_read_w(BYTE deviceID, WORD address);
;      66 extern void eeprom_write_w(BYTE deviceID, WORD address, WORD data);
;      67 extern void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      68 extern void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size);
;      69 
;      70 static void _displayFrame();
;      71 static void _doScroll();   
;      72 void LoadFrame(BYTE index);
;      73 void BlankRAM(PBYTE start_addr,PBYTE end_addr);
;      74 
;      75 ///////////////////////////////////////////////////////////////
;      76 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;      77 ///////////////////////////////////////////////////////////////
;      78 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;      79 {       

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;      80     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;      81     ++tick_count;    
	LDS  R30,_tick_count_G1
	LDS  R31,_tick_count_G1+1
	ADIW R30,1
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R31
;      82 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;      83 
;      84 ///////////////////////////////////////////////////////////////
;      85 // static function(s) for led matrix display panel
;      86 ///////////////////////////////////////////////////////////////
;      87 
;      88 #define __DATA_SHIFT()    \
;      89 {\
;      90     temp[0] = (unsigned long)start_mem[((unsigned int)4)*(x) + 0];\
;      91     temp[1] = (unsigned long)start_mem[((unsigned int)4)*(x) + 1];\
;      92     temp[2] = (unsigned long)start_mem[((unsigned int)4)*(x) + 2];\
;      93     temp[3] = (unsigned long)start_mem[((unsigned int)4)*(x) + 3];\
;      94     dw_temp = ~((temp[0]&0x000000FF) | ((temp[1]<<8)&0x0000FF00) | \
;      95               ((temp[2]<<16)&0x00FF0000) | ((temp[3]<<24)&0xFF000000));\
;      96     if (is_half_top){\
;      97         dw_temp = dw_temp>>scroll_updown;\
;      98     }\
;      99     else{\
;     100         dw_temp = dw_temp<<scroll_updown;\
;     101     }\
;     102 }
;     103 
;     104 static void _putData()
;     105 {                   
__putData_G1:
;     106     BYTE buff1 = 0;  
;     107     BYTE buff2 = 0;                               
;     108     __DATA_SHIFT();                     
	ST   -Y,R17
	ST   -Y,R16
;	buff1 -> R16
;	buff2 -> R17
	LDI  R16,0
	LDI  R17,0
	MOVW R30,R4
	CALL __LSLW2
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
	CALL __LSLW2
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
	CALL __LSLW2
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
	CALL __LSLW2
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
	CALL __LSLD12
	__ANDD1N 0xFF00
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1MN _temp,8
	CALL __LSLD16
	__ANDD1N 0xFF0000
	CALL __ORD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	__GETD2MN _temp,12
	LDI  R30,LOW(24)
	CALL __LSLD12
	__ANDD1N 0xFF000000
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	CALL __COMD1
	STS  _dw_temp,R30
	STS  _dw_temp+1,R31
	STS  _dw_temp+2,R22
	STS  _dw_temp+3,R23
	SBRS R2,3
	RJMP _0x4
	LDS  R30,_scroll_updown_G1
	LDS  R31,_scroll_updown_G1+1
	LDS  R26,_dw_temp
	LDS  R27,_dw_temp+1
	LDS  R24,_dw_temp+2
	LDS  R25,_dw_temp+3
	CLR  R22
	CLR  R23
	CALL __LSRD12
	RJMP _0x108
_0x4:
	LDS  R30,_scroll_updown_G1
	LDS  R31,_scroll_updown_G1+1
	LDS  R26,_dw_temp
	LDS  R27,_dw_temp+1
	LDS  R24,_dw_temp+2
	LDS  R25,_dw_temp+3
	CLR  R22
	CLR  R23
	CALL __LSLD12
_0x108:
	STS  _dw_temp,R30
	STS  _dw_temp+1,R31
	STS  _dw_temp+2,R22
	STS  _dw_temp+3,R23
;     109      
;     110     buff2 = ~(BYTE)(dw_temp>>24)&0x000000FF;        
	LDS  R26,_dw_temp
	LDS  R27,_dw_temp+1
	LDS  R24,_dw_temp+2
	LDS  R25,_dw_temp+3
	LDI  R30,LOW(24)
	CALL __LSRD12
	CALL __COMD1
	MOV  R17,R30
;     111     for (y=0; y< 8; y++){                      					
	CLR  R6
	CLR  R7
_0x7:
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R6,R30
	CPC  R7,R31
	BRSH _0x8
;     112         if (power_off) data_bit =OFF_LED;                            
	SBRS R2,1
	RJMP _0x9
	SET
	BLD  R2,0
;     113         data_bit = (buff2<<y) & 0x80;
_0x9:
	MOVW R30,R6
	MOV  R26,R17
	LDI  R27,0
	CALL __LSLW12
	BST  R30,7
	BLD  R2,0
;     114         DATA_OUT = data_bit;      
	BST  R2,0
	IN   R26,0x18
	BLD  R26,2
	OUT  0x18,R26
;     115         DATA_CLK = 1;
	SBI  0x18,0
;     116         DATA_CLK = 0;	    		
	CBI  0x18,0
;     117     }                           
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	RJMP _0x7
_0x8:
;     118     buff2 = ~(BYTE)(dw_temp>>16)&0x000000FF;
	LDS  R30,_dw_temp
	LDS  R31,_dw_temp+1
	LDS  R22,_dw_temp+2
	LDS  R23,_dw_temp+3
	CALL __LSRD16
	CALL __COMD1
	MOV  R17,R30
;     119     for (y=0; y< 8; y++){                     					
	CLR  R6
	CLR  R7
_0xB:
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R6,R30
	CPC  R7,R31
	BRSH _0xC
;     120         if (power_off) data_bit =OFF_LED; 
	SBRS R2,1
	RJMP _0xD
	SET
	BLD  R2,0
;     121         data_bit = (buff2<<y) & 0x80;                            
_0xD:
	MOVW R30,R6
	MOV  R26,R17
	LDI  R27,0
	CALL __LSLW12
	BST  R30,7
	BLD  R2,0
;     122         DATA_OUT = data_bit;  
	BST  R2,0
	IN   R26,0x18
	BLD  R26,2
	OUT  0x18,R26
;     123         DATA_CLK = 1;
	SBI  0x18,0
;     124         DATA_CLK = 0;	    		
	CBI  0x18,0
;     125     }             
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	RJMP _0xB
_0xC:
;     126              
;     127     buff1 = ~(BYTE)(dw_temp>>8)&0x000000FF;
	LDS  R26,_dw_temp
	LDS  R27,_dw_temp+1
	LDS  R24,_dw_temp+2
	LDS  R25,_dw_temp+3
	LDI  R30,LOW(8)
	CALL __LSRD12
	CALL __COMD1
	MOV  R16,R30
;     128     for (y=0; y< 8; y++){                      					
	CLR  R6
	CLR  R7
_0xF:
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R6,R30
	CPC  R7,R31
	BRSH _0x10
;     129         if (power_off) data_bit =OFF_LED;                            
	SBRS R2,1
	RJMP _0x11
	SET
	BLD  R2,0
;     130         data_bit = (buff1<<y) & 0x80;
_0x11:
	MOVW R30,R6
	MOV  R26,R16
	LDI  R27,0
	CALL __LSLW12
	BST  R30,7
	BLD  R2,0
;     131         DATA_OUT = data_bit;      
	BST  R2,0
	IN   R26,0x18
	BLD  R26,2
	OUT  0x18,R26
;     132         DATA_CLK = 1;
	SBI  0x18,0
;     133         DATA_CLK = 0;	    		
	CBI  0x18,0
;     134     }                           
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	RJMP _0xF
_0x10:
;     135     buff1 = ~(BYTE)(dw_temp)&0x000000FF;
	LDS  R30,_dw_temp
	CALL __COMD1
	MOV  R16,R30
;     136     for (y=0; y< 8; y++){                     					
	CLR  R6
	CLR  R7
_0x13:
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R6,R30
	CPC  R7,R31
	BRSH _0x14
;     137         if (power_off) data_bit =OFF_LED; 
	SBRS R2,1
	RJMP _0x15
	SET
	BLD  R2,0
;     138         data_bit = (buff1<<y) & 0x80;                            
_0x15:
	MOVW R30,R6
	MOV  R26,R16
	LDI  R27,0
	CALL __LSLW12
	BST  R30,7
	BLD  R2,0
;     139         DATA_OUT = data_bit;                         
	BST  R2,0
	IN   R26,0x18
	BLD  R26,2
	OUT  0x18,R26
;     140         DATA_CLK = 1;
	SBI  0x18,0
;     141         DATA_CLK = 0;	    		
	CBI  0x18,0
;     142     }
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	RJMP _0x13
_0x14:
;     143 }
	LD   R16,Y+
	LD   R17,Y+
	RET
;     144 
;     145 static void _displayFrame()
;     146 {                                    
__displayFrame_G1:
;     147     if (scroll_type==SCROLLING){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x4)
	BREQ _0x17
;     148 /*      if (tick_count > scroll_rate){            
;     149             _putData();
;     150             DATA_STB = 1;
;     151             DATA_STB = 0;                              
;     152         }
;     153 */        
;     154     }
;     155     else{
;     156 	    for (x=0; x< SCREEN_WIDTH; x++){
	CLR  R4
	CLR  R5
_0x19:
	LDI  R30,LOW(544)
	LDI  R31,HIGH(544)
	CP   R4,R30
	CPC  R5,R31
	BRSH _0x1A
;     157 		    _putData();					
	CALL __putData_G1
;     158     	}   
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x19
_0x1A:
;     159         DATA_STB = 1;
	SBI  0x18,1
;     160         DATA_STB = 0; 
	CBI  0x18,1
;     161 	}       
_0x17:
;     162 }     
	RET
;     163                                                                                   
;     164 static void _doScroll()
;     165 {
__doScroll_G1:
;     166   if (tick_count > scroll_rate){    
	LDS  R30,_scroll_rate_G1
	LDS  R26,_tick_count_G1
	LDS  R27,_tick_count_G1+1
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRLO PC+3
	JMP _0x1B
;     167     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     168     {
;     169     case LEFT_RIGHT:                
	CPI  R30,0
	BREQ PC+3
	JMP _0x1F
;     170         if (is_stopping==0){   
	SBRC R2,2
	RJMP _0x20
;     171             if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x21
;     172        	        start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	RJMP _0x109
;     173        	    else 
_0x21:
;     174        	        start_mem += 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
_0x109:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     175    	    }
;     176    	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
_0x20:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xD80)
	LDI  R30,HIGH(0xD80)
	CPC  R27,R30
	BRNE _0x23
;     177    	        is_stopping = 1;
	SET
	BLD  R2,2
;     178    	    if (is_stopping ==1)
_0x23:
	SBRS R2,2
	RJMP _0x24
;     179    	    {
;     180    	        if (stopping_count++>MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x25
;     181    	        {
;     182    	            is_stopping=0;
	CLT
	BLD  R2,2
;     183    	            stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     184    	        }
;     185    	    }                                  
_0x25:
;     186        	if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
_0x24:
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-576)
	SBCI R31,HIGH(-576)
	CALL __LSLW2
	SUBI R30,LOW(-1280)
	SBCI R31,HIGH(-1280)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x26
;     187    	    {                  
;     188    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     189        	}           
;     190    	    break;
_0x26:
	RJMP _0x1E
;     191     case RIGHT_LEFT:
_0x1F:
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0x27
;     192        	if (is_stopping==0){
	SBRC R2,2
	RJMP _0x28
;     193    	        if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x29
;     194    	            start_mem -= 4;      
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SBIW R30,4
	RJMP _0x10A
;     195    	        else
_0x29:
;     196    	            start_mem -= 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SBIW R30,8
_0x10A:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     197    	        
;     198    	    }
;     199    	    if (start_mem == START_RAM_TEXT + (SCREEN_WIDTH<<2))
_0x28:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0xD80)
	LDI  R30,HIGH(0xD80)
	CPC  R27,R30
	BRNE _0x2B
;     200    	        is_stopping = 1;
	SET
	BLD  R2,2
;     201    	    if (is_stopping ==1)
_0x2B:
	SBRS R2,2
	RJMP _0x2C
;     202    	    {
;     203    	        if (stopping_count++ >MAX_STOP_TIME)
	LDS  R26,_stopping_count_G1
	LDS  R27,_stopping_count_G1+1
	ADIW R26,1
	STS  _stopping_count_G1,R26
	STS  _stopping_count_G1+1,R27
	SBIW R26,1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x2D
;     204    	        {
;     205    	            is_stopping=0;
	CLT
	BLD  R2,2
;     206    	            stopping_count = 0;
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     207    	        }
;     208    	    }
_0x2D:
;     209    	    else if (start_mem < START_RAM_TEXT)             
	RJMP _0x2E
_0x2C:
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CPI  R26,LOW(0x500)
	LDI  R30,HIGH(0x500)
	CPC  R27,R30
	BRSH _0x2F
;     210        	{
;     211        	    scroll_count = 0;             
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     212    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     213        	}
;     214        	break;
_0x2F:
_0x2E:
	RJMP _0x1E
;     215     case BOTTOM_TOP:               
_0x27:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x30
;     216          if (scroll_step==0){
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x31
;     217             if (--scroll_updown <= 0){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	SBIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,0
	BRNE _0x32
;     218                 scroll_step++;                
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     219                 is_half_top =1;   
	SET
	BLD  R2,3
;     220             }
;     221         }
_0x32:
;     222         else if (scroll_step==1){  
	RJMP _0x33
_0x31:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x34
;     223             if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x35
;     224                 scroll_step++;
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     225                 scroll_count = 0;               
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     226             }
;     227         } 
_0x35:
;     228         else if (scroll_step==2){
	RJMP _0x36
_0x34:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x2)
	BRNE _0x37
;     229             if (++scroll_updown >SCREEN_HEIGHT){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	ADIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,33
	BRLO _0x38
;     230                 scroll_step++;                
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     231                 is_half_top =0;   
	CLT
	BLD  R2,3
;     232             }
;     233         }
_0x38:
;     234         else{                   
	RJMP _0x39
_0x37:
;     235             is_half_top =0;
	CLT
	BLD  R2,3
;     236             scroll_step =0;
	LDI  R30,LOW(0)
	STS  _scroll_step_G1,R30
;     237             scroll_count =0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     238             scroll_updown = SCREEN_HEIGHT;  
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R31
;     239             start_mem += SCREEN_WIDTH;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-544)
	SBCI R31,HIGH(-544)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     240             if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE)){                  
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-576)
	SBCI R31,HIGH(-576)
	CALL __LSLW2
	SUBI R30,LOW(-1280)
	SBCI R31,HIGH(-1280)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x3A
;     241        	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     242            	}
;     243         }  
_0x3A:
_0x39:
_0x36:
_0x33:
;     244         break;
	RJMP _0x1E
;     245     case TOP_BOTTOM:
_0x30:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x3B
;     246         if (scroll_step==0){
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x3C
;     247             if (--scroll_updown <=0){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	SBIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,0
	BRNE _0x3D
;     248                 scroll_step++;                
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     249                 is_half_top =0;   
	CLT
	BLD  R2,3
;     250             }
;     251         }
_0x3D:
;     252         else if (scroll_step==1){                  
	RJMP _0x3E
_0x3C:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x3F
;     253             if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x40
;     254                 scroll_step++;   
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     255                 scroll_count = 0;             
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     256                 scroll_updown = 0;
	LDI  R30,0
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R30
;     257             }
;     258         }               
_0x40:
;     259         else if (scroll_step==2){
	RJMP _0x41
_0x3F:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x2)
	BRNE _0x42
;     260             if (++scroll_updown > SCREEN_HEIGHT){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	ADIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,33
	BRLO _0x43
;     261                 scroll_step++;                
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     262                 is_half_top =1;   
	SET
	BLD  R2,3
;     263             }
;     264         }                 
_0x43:
;     265         else{
	RJMP _0x44
_0x42:
;     266             is_half_top =1;
	SET
	BLD  R2,3
;     267             scroll_step =0;
	LDI  R30,LOW(0)
	STS  _scroll_step_G1,R30
;     268             scroll_count =0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     269             scroll_updown =SCREEN_HEIGHT; 
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R31
;     270             start_mem += SCREEN_WIDTH;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	SUBI R30,LOW(-544)
	SBCI R31,HIGH(-544)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     271             if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE)){                  
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-576)
	SBCI R31,HIGH(-576)
	CALL __LSLW2
	SUBI R30,LOW(-1280)
	SBCI R31,HIGH(-1280)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x45
;     272        	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     273            	}
;     274         }     
_0x45:
_0x44:
_0x41:
_0x3E:
;     275         break;  
	RJMP _0x1E
;     276     case SCROLLING:            
_0x3B:
	CPI  R30,LOW(0x4)
	BRNE _0x46
;     277         /* shift data out step by step */
;     278             _putData();
	CALL __putData_G1
;     279             DATA_STB = 1;
	SBI  0x18,1
;     280             DATA_STB = 0;    
	CBI  0x18,1
;     281             
;     282         if (scroll_rate > MIN_RATE)
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x47
;     283    	        start_mem += 4;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	RJMP _0x10B
;     284    	    else 
_0x47:
;     285    	        start_mem += 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
_0x10B:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     286         if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE))             
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-576)
	SBCI R31,HIGH(-576)
	CALL __LSLW2
	SUBI R30,LOW(-1280)
	SBCI R31,HIGH(-1280)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x49
;     287    	    {            
;     288    	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     289        	}       	  
;     290         break;     
_0x49:
	RJMP _0x1E
;     291     case TOP_SCROLL:
_0x46:
	CPI  R30,LOW(0x6)
	BREQ PC+3
	JMP _0x4A
;     292         if (scroll_step==0){
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x4B
;     293             if (--scroll_updown <=0){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	SBIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,0
	BRNE _0x4C
;     294                 scroll_step++;                
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     295                 is_half_top =0;   
	CLT
	BLD  R2,3
;     296             }
;     297         }
_0x4C:
;     298         else if (scroll_step==1){                  
	RJMP _0x4D
_0x4B:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x4E
;     299             if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x4F
;     300                 scroll_step++;   
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     301                 scroll_count = 0;             
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     302                 scroll_updown = 0;
	LDI  R30,0
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R30
;     303             }
;     304         }               
_0x4F:
;     305         else{            
	RJMP _0x50
_0x4E:
;     306             if (start_mem > START_RAM_TEXT +4*(text_length+SCREEN_WIDTH+SCREEN_HIDE)){                  
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	SUBI R30,LOW(-576)
	SBCI R31,HIGH(-576)
	CALL __LSLW2
	SUBI R30,LOW(-1280)
	SBCI R31,HIGH(-1280)
	LDS  R26,_start_mem_G1
	LDS  R27,_start_mem_G1+1
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x51
;     307        	        LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     308            	}
;     309         }    
_0x51:
_0x50:
_0x4D:
;     310         if (scroll_rate > MIN_RATE){
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x3)
	BRLO _0x52
;     311    	        start_mem += 4;         
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,4
	RJMP _0x10C
;     312    	    }
;     313    	    else{ 
_0x52:
;     314    	        start_mem += 8;
	LDS  R30,_start_mem_G1
	LDS  R31,_start_mem_G1+1
	ADIW R30,8
_0x10C:
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     315    	    }
;     316         break;        
	RJMP _0x1E
;     317     case NOT_USE:
_0x4A:
	CPI  R30,LOW(0x5)
	BRNE _0x55
;     318         LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     319         break;  
;     320     default:
_0x55:
;     321         break;
;     322     }
_0x1E:
;     323 	tick_count = 0;
	LDI  R30,0
	STS  _tick_count_G1,R30
	STS  _tick_count_G1+1,R30
;     324 	if (frame_index >= MAX_FRAME) frame_index=0;
	LDS  R26,_frame_index_G1
	CPI  R26,LOW(0x4)
	BRLO _0x56
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     325     		
;     326   }
_0x56:
;     327              
;     328 }          
_0x1B:
	RET
;     329 ////////////////////////////////////////////////////////////////////
;     330 // General functions
;     331 //////////////////////////////////////////////////////////////////// 
;     332 #define RESET_WATCHDOG()    #asm("WDR");
;     333                                                                             
;     334 void LoadConfig(BYTE index)
;     335 {
_LoadConfig:
;     336     BYTE devID = EEPROM_DEVICE_BASE;    
;     337     WORD base = 0;   // base address
;     338     devID += index<<1;                 
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
;     339     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x57
;     340         base = 0x8000;    
	__GETWRN 17,18,32768
;     341     }                 
;     342     devID &= 0xF7;      // clear bit A3 
_0x57:
	ANDI R16,LOW(247)
;     343     
;     344     // init I2C bus
;     345     i2c_init();
	CALL _i2c_init
;     346     LED_STATUS = 1;
	SBI  0x18,4
;     347     scroll_rate = eeprom_read(devID, (WORD)base+0);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     348     scroll_type = eeprom_read(devID, (WORD)base+1);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_type_G1,R30
;     349     text_length = eeprom_read_w(devID, (WORD)base+2); 
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read_w
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     350     printf("line=%d rate=%d type=%d len=%d\r\n",index,scroll_rate,scroll_type,text_length);
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
;     351     if (text_length > DATA_LENGTH){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0xD41)
	LDI  R30,HIGH(0xD41)
	CPC  R27,R30
	BRLO _0x58
;     352         text_length= 0;            
	LDI  R30,0
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R30
;     353     }
;     354     if (scroll_type > NOT_USE){
_0x58:
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x6)
	BRLO _0x59
;     355         scroll_type = NOT_USE;
	LDI  R30,LOW(5)
	STS  _scroll_type_G1,R30
;     356     }          
;     357     if (scroll_rate > MAX_RATE){
_0x59:
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x65)
	BRLO _0x5A
;     358         scroll_rate = 0;
	LDI  R30,LOW(0)
	STS  _scroll_rate_G1,R30
;     359     }
;     360     LED_STATUS = 0;   
_0x5A:
	CBI  0x18,4
;     361 }
	RJMP _0x107
;     362                        
;     363 void SaveTextLength(BYTE index)
;     364 {
_SaveTextLength:
;     365     BYTE devID = EEPROM_DEVICE_BASE;    
;     366     WORD base = 0;   // base address
;     367     devID += index<<1;                 
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
;     368     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x5B
;     369         base = 0x8000;    
	__GETWRN 17,18,32768
;     370     }                 
;     371     devID &= 0xF7;      // clear bit A3 
_0x5B:
	ANDI R16,LOW(247)
;     372     
;     373     i2c_init();
	CALL _i2c_init
;     374     LED_STATUS = 1;   
	SBI  0x18,4
;     375     eeprom_write_w(devID, base+2,text_length); 
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
;     376     LED_STATUS = 0;   
	CBI  0x18,4
;     377 }
_0x107:
	CALL __LOADLOCR3
	ADIW R28,4
	RET
;     378 
;     379 void SaveConfig(BYTE rate,BYTE type, BYTE index)
;     380 {                     
_SaveConfig:
;     381     BYTE devID = EEPROM_DEVICE_BASE;    
;     382     WORD base = 0;   // base address
;     383     devID += index<<1;                 
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
;     384     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x5C
;     385         base = 0x8000;    
	__GETWRN 17,18,32768
;     386     }                 
;     387     devID &= 0xF7;      // clear bit A3  
_0x5C:
	ANDI R16,LOW(247)
;     388     i2c_init();
	CALL _i2c_init
;     389     LED_STATUS = 1;  
	SBI  0x18,4
;     390     eeprom_write(devID, base+0,rate);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	CALL _eeprom_write
;     391     eeprom_write(devID, base+1,type);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	ST   -Y,R30
	CALL _eeprom_write
;     392     LED_STATUS = 0;       
	CBI  0x18,4
;     393 }
	CALL __LOADLOCR3
	ADIW R28,6
	RET
;     394 
;     395 void SaveToEEPROM(PBYTE address,WORD length,BYTE index)
;     396 {                             
_SaveToEEPROM:
;     397     PBYTE temp = 0;     
;     398     BYTE devID = EEPROM_DEVICE_BASE;
;     399     WORD base = 0;   // base address
;     400     devID += index<<1;                 
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
;     401     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x5D
;     402         base = 0x8000;    
	__GETWRN 19,20,32768
;     403     }         				
;     404     temp = address;         
_0x5D:
	__GETWRS 16,17,8
;     405         
;     406     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xD41)
	LDI  R30,HIGH(0xD41)
	CPC  R27,R30
	BRLO _0x5E
;     407         return; // invalid param 
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     408     length = (WORD)address+4*(SCREEN_WIDTH+length);         
_0x5E:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-544)
	SBCI R31,HIGH(-544)
	CALL __LSLW2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     409     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x5F
;     410         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     411     // init I2C bus
;     412     i2c_init();
_0x5F:
	CALL _i2c_init
;     413     LED_STATUS = 1;        
	SBI  0x18,4
;     414     
;     415     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x61:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x62
;     416     {   
;     417         RESET_WATCHDOG();                          	                                              
	WDR
;     418         eeprom_write_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE);	      
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
;     419     }       
	__ADDWRN 16,17,64
	JMP  _0x61
_0x62:
;     420         
;     421     LED_STATUS = 0;   
	CBI  0x18,4
;     422 }
	RJMP _0x106
;     423                       
;     424 void LoadToRAM(PBYTE address,WORD length,BYTE index)
;     425 {                         
_LoadToRAM:
;     426     PBYTE temp = 0;          
;     427     BYTE devID = EEPROM_DEVICE_BASE;
;     428     WORD base = 0;   // base address
;     429     devID += index<<1;                 
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
;     430     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x63
;     431         base = 0x8000;    
	__GETWRN 19,20,32768
;     432     }       				
;     433     temp = address;                 
_0x63:
	__GETWRS 16,17,8
;     434 
;     435     if (length > DATA_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xD41)
	LDI  R30,HIGH(0xD41)
	CPC  R27,R30
	BRLO _0x64
;     436         return; // invalid param
_0x106:
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     437     length = (WORD)address+4*(SCREEN_WIDTH+length);         
_0x64:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-544)
	SBCI R31,HIGH(-544)
	CALL __LSLW2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     438     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x65
;     439         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     440     // init I2C bus
;     441     i2c_init();
_0x65:
	CALL _i2c_init
;     442     LED_STATUS = 1;             
	SBI  0x18,4
;     443  
;     444     for (temp = address; temp < length; temp+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x67:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x68
;     445     {
;     446         eeprom_read_page( devID, base+(WORD)temp, (PBYTE)temp, EEPROM_PAGE );	                                   
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
;     447         RESET_WATCHDOG();     
	WDR
;     448     }             
	__ADDWRN 16,17,64
	JMP  _0x67
_0x68:
;     449 
;     450     LED_STATUS = 0;   
	CBI  0x18,4
;     451 }
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     452 
;     453 void LoadFrame(BYTE index)
;     454 {                 
_LoadFrame:
;     455     if (index >= MAX_FRAME){
;	index -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x4)
	BRLO _0x69
;     456         index=0;  
	LDI  R30,LOW(0)
	ST   Y,R30
;     457     }
;     458     LoadConfig(index);  
_0x69:
	LD   R30,Y
	ST   -Y,R30
	CALL _LoadConfig
;     459     if (scroll_type==NOT_USE){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0x5)
	BRNE _0x6A
;     460         return;           
	RJMP _0x105
;     461     }                   
;     462     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
_0x6A:
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     463     LoadToRAM((PBYTE)START_RAM_TEXT,text_length,index);
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
;     464     scroll_count = 0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     465     is_stopping = 0; 
	CLT
	BLD  R2,2
;     466     scroll_step = 0;
	LDI  R30,LOW(0)
	STS  _scroll_step_G1,R30
;     467     scroll_updown = 0;
	LDI  R30,0
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R30
;     468     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     469     {
;     470     case LEFT_RIGHT:
	CPI  R30,0
	BRNE _0x6E
;     471         start_mem = (PBYTE)START_RAM_TEXT; 
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     472         break;                
	RJMP _0x6D
;     473     case RIGHT_LEFT:
_0x6E:
	CPI  R30,LOW(0x1)
	BRNE _0x6F
;     474         start_mem = (PBYTE)START_RAM_TEXT + (text_length<<2); 
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	CALL __LSLW2
	SUBI R30,LOW(-1280)
	SBCI R31,HIGH(-1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     475         break;
	RJMP _0x6D
;     476     case BOTTOM_TOP:  
_0x6F:
	CPI  R30,LOW(0x2)
	BRNE _0x70
;     477         is_half_top =0;
	CLT
	BLD  R2,3
;     478         scroll_updown = SCREEN_HEIGHT;                           
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R31
;     479         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(3456)
	LDI  R31,HIGH(3456)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     480         break;
	RJMP _0x6D
;     481     case TOP_BOTTOM:   
_0x70:
	CPI  R30,LOW(0x3)
	BRNE _0x71
;     482         is_half_top =1; 
	SET
	BLD  R2,3
;     483         scroll_updown = SCREEN_HEIGHT;                                           
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R31
;     484         start_mem = (PBYTE)START_RAM_TEXT + (SCREEN_WIDTH<<2); 
	LDI  R30,LOW(3456)
	LDI  R31,HIGH(3456)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     485         break;  
	RJMP _0x6D
;     486     case SCROLLING:
_0x71:
	CPI  R30,LOW(0x4)
	BRNE _0x72
;     487         start_mem = (PBYTE)START_RAM_TEXT;
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     488         break; 
	RJMP _0x6D
;     489     case TOP_SCROLL:
_0x72:
	CPI  R30,LOW(0x6)
	BRNE _0x74
;     490         is_half_top =1; 
	SET
	BLD  R2,3
;     491         scroll_updown = SCREEN_HEIGHT;                                           
	LDI  R30,LOW(32)
	LDI  R31,HIGH(32)
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R31
;     492         start_mem = (PBYTE)START_RAM_TEXT; 
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     493         break;
;     494     default: 
_0x74:
;     495         break;
;     496     }                   
_0x6D:
;     497 }
_0x105:
	ADIW R28,1
	RET
;     498 
;     499 void SerialToRAM(PBYTE address,WORD length)                                             
;     500 {
_SerialToRAM:
;     501     PBYTE temp = 0;          
;     502     UINT i =0;     				
;     503     temp   = address;    
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
;     504     LED_STATUS = 1;
	SBI  0x18,4
;     505     for (i =0; i< (length<<2); i++)         
	__GETWRN 18,19,0
_0x76:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL __LSLW2
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x77
;     506     {                          
;     507         BYTE data = 0;
;     508         data = ~getchar();
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x78*2)
	LDI  R31,HIGH(_0x78*2)
	CALL __INITLOCB
;	*address -> Y+7
;	length -> Y+5
;	data -> Y+0
	CALL _getchar
	COM  R30
	ST   Y,R30
;     509         *temp = data;
	MOVW R26,R16
	ST   X,R30
;     510         temp++;
	__ADDWRN 16,17,1
;     511         RESET_WATCHDOG();                                     
	WDR
;     512     }              
	ADIW R28,1
	__ADDWRN 18,19,1
	JMP  _0x76
_0x77:
;     513     LED_STATUS = 0;
	CBI  0x18,4
;     514 }
	CALL __LOADLOCR4
	ADIW R28,8
	RET
;     515                       
;     516 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     517 {        
_BlankRAM:
;     518     PBYTE temp = START_RAM;
;     519     for (temp = start_addr; temp<= end_addr; temp++)    
	ST   -Y,R17
	ST   -Y,R16
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*temp -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x7A:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x7B
;     520         *temp = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     521 }
	__ADDWRN 16,17,1
	RJMP _0x7A
_0x7B:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;     522 
;     523 
;     524 ///////////////////////////////////////////////////////////////
;     525 // END static function(s)
;     526 ///////////////////////////////////////////////////////////////
;     527 
;     528 ///////////////////////////////////////////////////////////////           
;     529 
;     530 void InitDevice()
;     531 {
_InitDevice:
;     532 // Declare your local variables here
;     533 // Crystal Oscillator division factor: 1  
;     534 #ifdef _MEGA162_INCLUDED_ 
;     535 #pragma optsize-
;     536 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     537 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     538 #ifdef _OPTIMIZE_SIZE_
;     539 #pragma optsize+
;     540 #endif                    
;     541 #endif
;     542 
;     543 PORTA=0x00;
	OUT  0x1B,R30
;     544 DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;     545 
;     546 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
;     547 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     548 
;     549 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     550 DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
;     551 
;     552 PORTD=0xFF;
	OUT  0x12,R30
;     553 DDRD=0x00; 
	LDI  R30,LOW(0)
	OUT  0x11,R30
;     554 
;     555 PORTE=0x00;
	OUT  0x7,R30
;     556 DDRE=0xFF;
	LDI  R30,LOW(255)
	OUT  0x6,R30
;     557 
;     558 // Timer/Counter 0 initialization
;     559 // Clock source: System Clock
;     560 // Clock value: 250.000 kHz
;     561 // Mode: Normal top=FFh
;     562 // OC0 output: Disconnected
;     563 TCCR0=0x03;     // 4 us per tick
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     564 TCNT0=0x05;     // 1ms = 4*250
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     565 OCR0=0x00;      // 255 -250 = TCNT0
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     566 
;     567 #ifdef _MEGA162_INCLUDED_
;     568 UCSR0A=0x00;
	OUT  0xB,R30
;     569 UCSR0B=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     570 UCSR0C=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     571 UBRR0H=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     572 UBRR0L=0x67;      //  16 MHz     
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     573 
;     574 #else // _MEGA8515_INCLUDE_     
;     575 UCSRA=0x00;
;     576 UCSRB=0x98;
;     577 UCSRC=0x86;
;     578 UBRRH=0x00;
;     579 UBRRL=0x33;       // 8 MHz
;     580 #endif
;     581 
;     582 // Lower page wait state(s): None
;     583 // Upper page wait state(s): None
;     584 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     585 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     586 
;     587 // Timer(s)/Counter(s) Interrupt(s) initialization
;     588 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     589 ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
;     590 
;     591 // Load calibration byte for osc.  
;     592 #ifdef _MEGA162_INCLUDED_
;     593 OSCCAL = 0x5E; 
	LDI  R30,LOW(94)
	OUT  0x4,R30
;     594 #else
;     595 OSCCAL = 0xA7; 
;     596 #endif            
;     597 
;     598 // I2C Bus initialization
;     599 // i2c_init();
;     600 
;     601 // DS1307 Real Time Clock initialization
;     602 // Square wave output on pin SQW/OUT: Off
;     603 // SQW/OUT pin state: 1
;     604 // rtc_init(3,0,1);
;     605 
;     606 //i2c_init(); // must be call before
;     607 //rtc_init(3,0,1); // init RTC DS1307  
;     608 //rtc_set_time(15,2,0);
;     609 //rtc_set_date(9,5,6);    
;     610                 
;     611 // Watchdog Timer initialization
;     612 // Watchdog Timer Prescaler: OSC/2048k     
;     613 #ifdef __WATCH_DOG_
;     614 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     615 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     616 #endif
;     617 }
	RET
;     618 
;     619 void PowerReset()
;     620 {      
_PowerReset:
;     621     start_mem = (PBYTE)START_RAM_TEXT;                    
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     622 
;     623     InitDevice();
	CALL _InitDevice
;     624        
;     625     LED_STATUS = 0;
	CBI  0x18,4
;     626     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);  
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     627     
;     628     LED_STATUS = 0;  
	CBI  0x18,4
;     629     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     630     LED_STATUS = 1;
	SBI  0x18,4
;     631     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     632     LED_STATUS = 0;
	CBI  0x18,4
;     633     delay_ms(500);    
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     634     LED_STATUS = 1;
	SBI  0x18,4
;     635                 
;     636     frame_index= 0;
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     637     LoadFrame(frame_index);
	ST   -Y,R30
	CALL _LoadFrame
;     638         
;     639 #ifdef _INIT_EEPROM_ 
;     640 {
;     641     BYTE i =0;
;     642     for (i =0; i< MAX_FRAME; i++){   
;     643         SaveConfig(10,0,i);
;     644         text_length = 160;
;     645         SaveTextLength(i);            
;     646     }
;     647 }
;     648 #endif  
;     649     printf("LCMS v3.10 Designed by CuongQuay\r\n");  
	__POINTW1FN _0,33
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     650     printf("cuong3ihut@yahoo.com - 0915651001\r\n");
	__POINTW1FN _0,68
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     651     printf("Started date: 04.04.2007\r\n");
	__POINTW1FN _0,104
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     652     printf("Release date: 07.04.2007\r\n");    
	__POINTW1FN _0,131
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     653 }
	RET
;     654 
;     655 void ProcessCommand()
;     656 {
_ProcessCommand:
;     657    	#asm("cli"); 
	cli
;     658     RESET_WATCHDOG();
	WDR
;     659 
;     660     // serial message processing     
;     661     switch (rx_message)
	MOV  R30,R8
;     662     {                  
;     663     case LOAD_TEXT_MSG:
	CPI  R30,LOW(0x2)
	BRNE _0x7F
;     664         {                
;     665             text_length = rx_wparam;            
	__PUTWMRN _text_length_G1,0,9,10
;     666             frame_index = rx_lparam&0x0F;   
	__GETW1R 11,12
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	STS  _frame_index_G1,R30
;     667             BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     668             SerialToRAM((PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH),text_length);                
	LDI  R30,LOW(3456)
	LDI  R31,HIGH(3456)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _SerialToRAM
;     669 			start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);				
	LDI  R30,LOW(3456)
	LDI  R31,HIGH(3456)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     670 			SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
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
;     671 			SaveTextLength(rx_lparam);							  
	ST   -Y,R11
	CALL _SaveTextLength
;     672         }				
;     673         break;           
	RJMP _0x7E
;     674     case LOAD_BKGND_MSG:
_0x7F:
	CPI  R30,LOW(0x3)
	BRNE _0x80
;     675         {
;     676         }
;     677         break;   
	RJMP _0x7E
;     678     case SET_CFG_MSG: 
_0x80:
	CPI  R30,LOW(0xD)
	BRNE _0x81
;     679         {               
;     680             SaveConfig(rx_wparam&0x0FF,rx_wparam>>8,rx_lparam); 
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	ST   -Y,R11
	CALL _SaveConfig
;     681         }
;     682         break;    
	RJMP _0x7E
;     683     case EEPROM_SAVE_TEXT_MSG:     
_0x81:
	CPI  R30,LOW(0x7)
	BREQ _0x83
;     684     case EEPROM_SAVE_ALL_MSG:  
	CPI  R30,LOW(0xB)
	BRNE _0x84
_0x83:
;     685         {                                                          
;     686             SaveTextLength(rx_lparam);              
	ST   -Y,R11
	CALL _SaveTextLength
;     687             SaveToEEPROM((PBYTE)START_RAM_TEXT,text_length,rx_lparam);
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
;     688         }
;     689         break;         
	RJMP _0x7E
;     690     case EEPROM_LOAD_TEXT_MSG:    
_0x84:
	CPI  R30,LOW(0x6)
	BREQ _0x86
;     691     case EEPROM_LOAD_ALL_MSG:
	CPI  R30,LOW(0xA)
	BRNE _0x87
_0x86:
;     692         {
;     693             LoadConfig(rx_lparam);                               
	ST   -Y,R11
	CALL _LoadConfig
;     694             LoadToRAM((PBYTE)START_RAM_TEXT,text_length,rx_lparam); 
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
;     695             start_mem = (PBYTE)START_RAM_TEXT+4*(SCREEN_WIDTH);
	LDI  R30,LOW(3456)
	LDI  R31,HIGH(3456)
	STS  _start_mem_G1,R30
	STS  _start_mem_G1+1,R31
;     696         }
;     697         break;  
	RJMP _0x7E
;     698     case POWER_CTRL_MSG:
_0x87:
	CPI  R30,LOW(0x10)
	BRNE _0x89
;     699         power_off = rx_wparam&0x01;
	BST  R9,0
	BLD  R2,1
;     700         break;     
;     701     default:
_0x89:
;     702         break;
;     703     }                 
_0x7E:
;     704     send_echo_msg();            
	RCALL _send_echo_msg
;     705     rx_message = UNKNOWN_MSG;
	CLR  R8
;     706     #asm("sei");        
	sei
;     707 }           
	RET
;     708 ////////////////////////////////////////////////////////////////////////////////
;     709 // MAIN PROGRAM
;     710 ////////////////////////////////////////////////////////////////////////////////
;     711 void main(void)
;     712 {         
_main:
;     713     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x8A
;     714         // Watchdog Reset
;     715         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     716         reset_serial(); 
	RCALL _reset_serial
;     717     }
;     718     else {      
	RJMP _0x8B
_0x8A:
;     719         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     720     }                                     
_0x8B:
;     721      
;     722     PowerReset();                        
	CALL _PowerReset
;     723     #asm("sei");     
	sei
;     724 
;     725     while (1){         
_0x8C:
;     726         if (rx_message != UNKNOWN_MSG){   
	TST  R8
	BREQ _0x8F
;     727             ProcessCommand();   
	CALL _ProcessCommand
;     728         }
;     729         else{           
	RJMP _0x90
_0x8F:
;     730             if (!is_stopping){
	SBRC R2,2
	RJMP _0x91
;     731                 _displayFrame();
	CALL __displayFrame_G1
;     732             }
;     733             _doScroll();            
_0x91:
	CALL __doScroll_G1
;     734         }
_0x90:
;     735         RESET_WATCHDOG();
	WDR
;     736     };
	JMP  _0x8C
;     737 
;     738 }
_0x92:
	NOP
	RJMP _0x92
;     739                          
;     740 #include "define.h"
;     741 
;     742 ///////////////////////////////////////////////////////////////
;     743 // serial interrupt handle - processing serial message ...
;     744 ///////////////////////////////////////////////////////////////
;     745 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     746 ///////////////////////////////////////////////////////////////
;     747 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     748 extern BYTE  rx_message;
;     749 extern WORD  rx_wparam;
;     750 extern WORD  rx_lparam;
;     751 
;     752 #if RX_BUFFER_SIZE<256
;     753 unsigned char rx_wr_index,rx_counter;
;     754 #else
;     755 unsigned int rx_wr_index,rx_counter;
;     756 #endif
;     757 
;     758 void send_echo_msg();
;     759 
;     760 // USART Receiver interrupt service routine
;     761 #ifdef _MEGA162_INCLUDED_                    
;     762 interrupt [USART0_RXC] void usart_rx_isr(void)
;     763 #else
;     764 interrupt [USART_RXC] void usart_rx_isr(void)
;     765 #endif
;     766 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     767 char status,data;
;     768 #ifdef _MEGA162_INCLUDED_  
;     769 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;     770 data=UDR0;
	IN   R17,12
;     771 #else     
;     772 status=UCSRA;
;     773 data=UDR;
;     774 #endif          
;     775     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+3
	JMP _0x93
;     776     {
;     777         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R13
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;     778         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0x94
	CLR  R13
;     779         if (++rx_counter == RX_BUFFER_SIZE)
_0x94:
	INC  R14
	LDI  R30,LOW(8)
	CP   R30,R14
	BRNE _0x95
;     780         {
;     781             rx_counter=0;
	CLR  R14
;     782             if (
;     783                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;     784                 rx_buffer[2]==WAKEUP_CHAR 
;     785                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BRNE _0x97
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BRNE _0x97
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ _0x98
_0x97:
	RJMP _0x96
_0x98:
;     786             {
;     787                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 8,_rx_buffer,3
;     788                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 9,_rx_buffer,4
	CLR  R10
;     789                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R9
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 9,10
;     790                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 11,_rx_buffer,6
	CLR  R12
;     791                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;     792             }
;     793             else if(
	RJMP _0x99
_0x96:
;     794                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;     795                 rx_buffer[2]==ESCAPE_CHAR 
;     796                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0x9B
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0x9B
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0x9C
_0x9B:
	RJMP _0x9A
_0x9C:
;     797             {
;     798                 rx_wr_index=0;
	CLR  R13
;     799                 rx_counter =0;
	CLR  R14
;     800             }      
;     801         };
_0x9A:
_0x99:
_0x95:
;     802     };
_0x93:
;     803 }
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     804 
;     805 void send_echo_msg()
;     806 {
_send_echo_msg:
;     807     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     808     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     809     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     810     putchar(rx_message);
	ST   -Y,R8
	CALL _putchar
;     811     putchar(rx_wparam>>8);
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     812     putchar(rx_wparam&0x00FF);
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     813     putchar(rx_lparam>>8);        
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     814     putchar(rx_lparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     815 }  
	RET
;     816 
;     817 void reset_serial()
;     818 {
_reset_serial:
;     819     rx_wr_index=0;
	CLR  R13
;     820     rx_counter =0;
	CLR  R14
;     821     rx_message = UNKNOWN_MSG;
	CLR  R8
;     822 }
	RET
;     823 
;     824 ///////////////////////////////////////////////////////////////
;     825 // END serial interrupt handle
;     826 /////////////////////////////////////////////////////////////// 
;     827 /*****************************************************
;     828 This program was produced by the
;     829 CodeWizardAVR V1.24.4a Standard
;     830 Automatic Program Generator
;     831 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;     832 http://www.hpinfotech.com
;     833 e-mail:office@hpinfotech.com
;     834 
;     835 Project : 
;     836 Version : 
;     837 Date    : 19/5/2005
;     838 Author  : 3iGROUP                
;     839 Company : http://www.3ihut.net   
;     840 Comments: 
;     841 
;     842 
;     843 Chip type           : ATmega8515
;     844 Program type        : Application
;     845 Clock frequency     : 8.000000 MHz
;     846 Memory model        : Small
;     847 External SRAM size  : 32768
;     848 Ext. SRAM wait state: 0
;     849 Data Stack size     : 128
;     850 *****************************************************/
;     851 
;     852 #include "define.h"                                           
;     853 
;     854 #define     ACK                 1
;     855 #define     NO_ACK              0
;     856 
;     857 // I2C Bus functions
;     858 #asm
;     859    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;     860    .equ __sda_bit=3
   .equ __sda_bit=3
;     861    .equ __scl_bit=2
   .equ __scl_bit=2
;     862 #endasm                   
;     863 
;     864 #ifdef __EEPROM_WRITE_BYTE
;     865 BYTE eeprom_read(BYTE deviceID, WORD address) 
;     866 {
_eeprom_read:
;     867     BYTE data;
;     868     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	address -> Y+1
;	data -> R16
	CALL _i2c_start
;     869     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     870     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     871     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     872     
;     873     i2c_start();
	CALL _i2c_start
;     874     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     875     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R16,R30
;     876     i2c_stop();
	CALL _i2c_stop
;     877     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0x104
;     878 }
;     879 
;     880 void eeprom_write(BYTE deviceID, WORD address, BYTE data) 
;     881 {
_eeprom_write:
;     882     i2c_start();
;	deviceID -> Y+3
;	address -> Y+1
;	data -> Y+0
	CALL _i2c_start
;     883     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     884     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     885     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     886     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	CALL _i2c_write
;     887     i2c_stop();
	CALL _i2c_stop
;     888 
;     889     /* 10ms delay to complete the write operation */
;     890     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     891 }                                 
_0x104:
	ADIW R28,4
	RET
;     892 
;     893 WORD eeprom_read_w(BYTE deviceID, WORD address)
;     894 {
_eeprom_read_w:
;     895     WORD result = 0;
;     896     result = eeprom_read(deviceID,address);
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
;     897     result = (result<<8) | eeprom_read(deviceID,address+1);
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
;     898     return result;
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x103
;     899 }
;     900 void eeprom_write_w(BYTE deviceID, WORD address, WORD data)
;     901 {
_eeprom_write_w:
;     902     eeprom_write(deviceID,address,data>>8);
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
;     903     eeprom_write(deviceID,address+1,data&0x0FF);    
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
;     904 }
_0x103:
	ADIW R28,5
	RET
;     905 
;     906 #endif // __EEPROM_WRITE_BYTE
;     907 void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     908 {
_eeprom_read_page:
;     909     BYTE i = 0;
;     910     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;     911     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;     912     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     913     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     914     
;     915     i2c_start();
	CALL _i2c_start
;     916     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     917                                     
;     918     while ( i < page_size-1 )
_0x9D:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0x9F
;     919     {
;     920         buffer[i++] = i2c_read(ACK);   // read at current
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
;     921     }
	RJMP _0x9D
_0x9F:
;     922     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
;     923          
;     924     i2c_stop();
	CALL _i2c_stop
;     925 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     926 
;     927 void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     928 {
_eeprom_write_page:
;     929     BYTE i = 0;
;     930     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;     931     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;     932     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     933     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     934                                         
;     935     while ( i < page_size )
_0xA0:
	LDD  R30,Y+1
	CP   R16,R30
	BRSH _0xA2
;     936     {
;     937         i2c_write(buffer[i++]);
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
;     938         #asm("nop");#asm("nop");
	nop
	nop
;     939     }          
	JMP  _0xA0
_0xA2:
;     940     i2c_stop(); 
	CALL _i2c_stop
;     941     delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     942 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     943                                               

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
	BREQ _0xA3
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0xA4
_0xA3:
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _putchar
_0xA4:
	ADIW R28,3
	RET
__print_G4:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R16,0
_0xA5:
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
	JMP _0xA7
	MOV  R30,R16
	CPI  R30,0
	BRNE _0xAB
	CPI  R19,37
	BRNE _0xAC
	LDI  R16,LOW(1)
	RJMP _0xAD
_0xAC:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
_0xAD:
	RJMP _0xAA
_0xAB:
	CPI  R30,LOW(0x1)
	BRNE _0xAE
	CPI  R19,37
	BRNE _0xAF
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0x10D
_0xAF:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0xB0
	LDI  R17,LOW(1)
	RJMP _0xAA
_0xB0:
	CPI  R19,43
	BRNE _0xB1
	LDI  R21,LOW(43)
	RJMP _0xAA
_0xB1:
	CPI  R19,32
	BRNE _0xB2
	LDI  R21,LOW(32)
	RJMP _0xAA
_0xB2:
	RJMP _0xB3
_0xAE:
	CPI  R30,LOW(0x2)
	BRNE _0xB4
_0xB3:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0xB5
	ORI  R17,LOW(128)
	RJMP _0xAA
_0xB5:
	RJMP _0xB6
_0xB4:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0xAA
_0xB6:
	CPI  R19,48
	BRLO _0xB9
	CPI  R19,58
	BRLO _0xBA
_0xB9:
	RJMP _0xB8
_0xBA:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0xAA
_0xB8:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0xBE
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
	RJMP _0xBF
_0xBE:
	CPI  R30,LOW(0x73)
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
	CALL _strlen
	MOV  R16,R30
	RJMP _0xC2
_0xC1:
	CPI  R30,LOW(0x70)
	BRNE _0xC4
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
_0xC2:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0xC5
_0xC4:
	CPI  R30,LOW(0x64)
	BREQ _0xC8
	CPI  R30,LOW(0x69)
	BRNE _0xC9
_0xC8:
	ORI  R17,LOW(4)
	RJMP _0xCA
_0xC9:
	CPI  R30,LOW(0x75)
	BRNE _0xCB
_0xCA:
	LDI  R30,LOW(_tbl10_G4*2)
	LDI  R31,HIGH(_tbl10_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0xCC
_0xCB:
	CPI  R30,LOW(0x58)
	BRNE _0xCE
	ORI  R17,LOW(8)
	RJMP _0xCF
_0xCE:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x100
_0xCF:
	LDI  R30,LOW(_tbl16_G4*2)
	LDI  R31,HIGH(_tbl16_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0xCC:
	SBRS R17,2
	RJMP _0xD1
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
	BRGE _0xD2
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0xD2:
	CPI  R21,0
	BREQ _0xD3
	SUBI R16,-LOW(1)
	RJMP _0xD4
_0xD3:
	ANDI R17,LOW(251)
_0xD4:
	RJMP _0xD5
_0xD1:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0xD5:
_0xC5:
	SBRC R17,0
	RJMP _0xD6
_0xD7:
	CP   R16,R20
	BRSH _0xD9
	SBRS R17,7
	RJMP _0xDA
	SBRS R17,2
	RJMP _0xDB
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0xDC
_0xDB:
	LDI  R19,LOW(48)
_0xDC:
	RJMP _0xDD
_0xDA:
	LDI  R19,LOW(32)
_0xDD:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	SUBI R20,LOW(1)
	RJMP _0xD7
_0xD9:
_0xD6:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0xDE
_0xDF:
	CPI  R18,0
	BREQ _0xE1
	SBRS R17,3
	RJMP _0xE2
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x10E
_0xE2:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x10E:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xE4
	SUBI R20,LOW(1)
_0xE4:
	SUBI R18,LOW(1)
	RJMP _0xDF
_0xE1:
	RJMP _0xE5
_0xDE:
_0xE7:
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
_0xE9:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0xEB
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0xE9
_0xEB:
	CPI  R19,58
	BRLO _0xEC
	SBRS R17,3
	RJMP _0xED
	SUBI R19,-LOW(7)
	RJMP _0xEE
_0xED:
	SUBI R19,-LOW(39)
_0xEE:
_0xEC:
	SBRC R17,4
	RJMP _0xF0
	CPI  R19,49
	BRSH _0xF2
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0xF1
_0xF2:
	RJMP _0x10F
_0xF1:
	CP   R20,R18
	BRLO _0xF6
	SBRS R17,0
	RJMP _0xF7
_0xF6:
	RJMP _0xF5
_0xF7:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0xF8
	LDI  R19,LOW(48)
_0x10F:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0xF9
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xFA
	SUBI R20,LOW(1)
_0xFA:
_0xF9:
_0xF8:
_0xF0:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xFB
	SUBI R20,LOW(1)
_0xFB:
_0xF5:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0xE8
	RJMP _0xE7
_0xE8:
_0xE5:
	SBRS R17,0
	RJMP _0xFC
_0xFD:
	CPI  R20,0
	BREQ _0xFF
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0xFD
_0xFF:
_0xFC:
_0x100:
_0xBF:
_0x10D:
	LDI  R16,LOW(0)
_0xAA:
	RJMP _0xA5
_0xA7:
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

__LSLW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSLW12R
__LSLW12L:
	LSL  R30
	ROL  R31
	DEC  R0
	BRNE __LSLW12L
__LSLW12R:
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
