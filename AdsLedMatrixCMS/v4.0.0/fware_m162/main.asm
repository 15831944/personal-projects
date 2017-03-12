
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
;      35 bit power_off = 0;
;      36 bit is_stopping = 0;
;      37 
;      38 register UINT x=0;
;      39 register UINT y=0;   
;      40 static BYTE  mask = 0xFF;                              
_mask_G1:
	.BYTE 0x1
;      41 static UINT  scroll_count = 0;  
_scroll_count_G1:
	.BYTE 0x2
;      42 static UINT  scroll_updown = 0;    
_scroll_updown_G1:
	.BYTE 0x2
;      43 static UINT  stopping_count = 0;       
_stopping_count_G1:
	.BYTE 0x2
;      44 static BYTE  tick_count  = 0;       
_tick_count_G1:
	.BYTE 0x1
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
;      49 static BYTE  scroll_rate = FAST_RATE;
_scroll_rate_G1:
	.BYTE 0x1
;      50 static BYTE  scroll_temp = FAST_RATE;
_scroll_temp_G1:
	.BYTE 0x1
;      51 static BYTE  scroll_type = 0;            
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
;      72 void LoadToRAM(PBYTE address,WORD length,BYTE index);
;      73 ///////////////////////////////////////////////////////////////
;      74 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;      75 ///////////////////////////////////////////////////////////////
;      76 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;      77 {       

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
;      78     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;      79     ++tick_count;    
	LDS  R30,_tick_count_G1
	SUBI R30,-LOW(1)
	STS  _tick_count_G1,R30
;      80 }
	LD   R30,Y+
	OUT  SREG,R30
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
;      88     BYTE tempH = 0, tempL =0;          
;      89     BYTE temp_byte = 0;    
;      90     BYTE temp_bit = 0;
;      91     temp_byte = (scroll_updown/8);
	CALL __SAVELOCR4
;	tempH -> R16
;	tempL -> R17
;	temp_byte -> R18
;	temp_bit -> R19
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	LDS  R30,_scroll_updown_G1
	LDS  R31,_scroll_updown_G1+1
	CALL __LSRW3
	MOV  R18,R30
;      92     temp_bit = (scroll_updown%8);
	LDS  R30,_scroll_updown_G1
	LDS  R31,_scroll_updown_G1+1
	ANDI R30,LOW(0x7)
	ANDI R31,HIGH(0x7)
	MOV  R19,R30
;      93 	for (x=0; x< SCREEN_WIDTH; x++){
	CLR  R4
	CLR  R5
_0xA:
	LDI  R30,LOW(240)
	LDI  R31,HIGH(240)
	CP   R4,R30
	CPC  R5,R31
	BRLO PC+3
	JMP _0xB
;      94 		tempL = ~start_memR[(SCREEN_HEIGHT/8)*(x) + temp_byte]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_start_memR_G1
	LDS  R27,_start_memR_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R17,R30
;      95 		tempH = ~start_memR[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	LDS  R26,_start_memR_G1
	LDS  R27,_start_memR_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R16,R30
;      96 		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
	MOV  R30,R19
	MOV  R26,R17
	CALL __LSRB12
	MOV  R1,R30
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R26,R16
	CALL __LSLB12
	OR   R30,R1
	MOV  R17,R30
;      97 		DATA_PORT = ~tempL & mask;                                  
	MOV  R30,R17
	COM  R30
	LDS  R26,_mask_G1
	AND  R30,R26
	OUT  0x18,R30
;      98 		DATA_CLK = 1;
	SBI  0x12,5
;      99 		DATA_CLK = 0;					         
	CBI  0x12,5
;     100 		tempL = ~start_memB[(SCREEN_HEIGHT/8)*(x) + temp_byte]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_start_memB_G1
	LDS  R27,_start_memB_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R17,R30
;     101 		tempH = ~start_memB[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	LDS  R26,_start_memB_G1
	LDS  R27,_start_memB_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R16,R30
;     102 		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
	MOV  R30,R19
	MOV  R26,R17
	CALL __LSRB12
	MOV  R1,R30
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R26,R16
	CALL __LSLB12
	OR   R30,R1
	MOV  R17,R30
;     103 		DATA_PORT = ~tempL & mask;
	MOV  R30,R17
	COM  R30
	LDS  R26,_mask_G1
	AND  R30,R26
	OUT  0x18,R30
;     104 		DATA_CLK = 1;
	SBI  0x12,5
;     105 		DATA_CLK = 0;				             
	CBI  0x12,5
;     106         tempL = ~start_memG[(SCREEN_HEIGHT/8)*(x) + temp_byte]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LDS  R26,_start_memG_G1
	LDS  R27,_start_memG_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R17,R30
;     107 		tempH = ~start_memG[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	LDS  R26,_start_memG_G1
	LDS  R27,_start_memG_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R16,R30
;     108 		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
	MOV  R30,R19
	MOV  R26,R17
	CALL __LSRB12
	MOV  R1,R30
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R26,R16
	CALL __LSLB12
	OR   R30,R1
	MOV  R17,R30
;     109 		DATA_PORT = ~tempL & mask;
	MOV  R30,R17
	COM  R30
	LDS  R26,_mask_G1
	AND  R30,R26
	OUT  0x18,R30
;     110 		DATA_CLK = 1;
	SBI  0x12,5
;     111 		DATA_CLK = 0;				
	CBI  0x12,5
;     112 	}         
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0xA
_0xB:
;     113 	  
;     114     DATA_STB0 = 1;
	SBI  0x7,0
;     115     DATA_STB0 = 0; 
	CBI  0x7,0
;     116     
;     117     
;     118     for (x=0; x< SCREEN_WIDTH; x++){ 
	CLR  R4
	CLR  R5
_0xD:
	LDI  R30,LOW(240)
	LDI  R31,HIGH(240)
	CP   R4,R30
	CPC  R5,R31
	BRLO PC+3
	JMP _0xE
;     119         tempL = ~start_memR[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	LDS  R26,_start_memR_G1
	LDS  R27,_start_memR_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R17,R30
;     120 		tempH = ~start_memR[(SCREEN_HEIGHT/8)*(x) + temp_byte+2]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,2
	LDS  R26,_start_memR_G1
	LDS  R27,_start_memR_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R16,R30
;     121 		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
	MOV  R30,R19
	MOV  R26,R17
	CALL __LSRB12
	MOV  R1,R30
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R26,R16
	CALL __LSLB12
	OR   R30,R1
	MOV  R17,R30
;     122 		DATA_PORT = ~tempL & mask;
	MOV  R30,R17
	COM  R30
	LDS  R26,_mask_G1
	AND  R30,R26
	OUT  0x18,R30
;     123 		DATA_CLK = 1;
	SBI  0x12,5
;     124 		DATA_CLK = 0;				
	CBI  0x12,5
;     125         tempL = ~start_memB[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	LDS  R26,_start_memB_G1
	LDS  R27,_start_memB_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R17,R30
;     126 		tempH = ~start_memB[(SCREEN_HEIGHT/8)*(x) + temp_byte+2]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,2
	LDS  R26,_start_memB_G1
	LDS  R27,_start_memB_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R16,R30
;     127 		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
	MOV  R30,R19
	MOV  R26,R17
	CALL __LSRB12
	MOV  R1,R30
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R26,R16
	CALL __LSLB12
	OR   R30,R1
	MOV  R17,R30
;     128 		DATA_PORT = ~tempL & mask;
	MOV  R30,R17
	COM  R30
	LDS  R26,_mask_G1
	AND  R30,R26
	OUT  0x18,R30
;     129 		DATA_CLK = 1;
	SBI  0x12,5
;     130 		DATA_CLK = 0;               
	CBI  0x12,5
;     131         tempL = ~start_memG[(SCREEN_HEIGHT/8)*(x) + temp_byte+1]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	LDS  R26,_start_memG_G1
	LDS  R27,_start_memG_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R17,R30
;     132 		tempH = ~start_memG[(SCREEN_HEIGHT/8)*(x) + temp_byte+2]; 
	MOVW R30,R4
	CALL __LSLW3
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,2
	LDS  R26,_start_memG_G1
	LDS  R27,_start_memG_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	COM  R30
	MOV  R16,R30
;     133 		tempL = (tempL >> temp_bit) | tempH<< (8 - temp_bit) ;
	MOV  R30,R19
	MOV  R26,R17
	CALL __LSRB12
	MOV  R1,R30
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R26,R16
	CALL __LSLB12
	OR   R30,R1
	MOV  R17,R30
;     134 		DATA_PORT = ~tempL & mask;
	MOV  R30,R17
	COM  R30
	LDS  R26,_mask_G1
	AND  R30,R26
	OUT  0x18,R30
;     135 		DATA_CLK = 1;
	SBI  0x12,5
;     136 		DATA_CLK = 0;					
	CBI  0x12,5
;     137 	}
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0xD
_0xE:
;     138 	           
;     139     DATA_STB1 = 1;       
	SBI  0x7,2
;     140     DATA_STB1 = 0;     	         
	CBI  0x7,2
;     141 }
	CALL __LOADLOCR4
	ADIW R28,4
	RET
;     142  
;     143 static void putdata0()
;     144 {                          
_putdata0_G1:
;     145 	for (x=0; x< SCREEN_WIDTH; x++){
	CLR  R4
	CLR  R5
_0x10:
	LDI  R30,LOW(240)
	LDI  R31,HIGH(240)
	CP   R4,R30
	CPC  R5,R31
	BRSH _0x11
;     146 		DATA_PORT = start_memR[(SCREEN_HEIGHT/8)*(x) ]; 
	MOVW R30,R4
	CALL __LSLW3
	LDS  R26,_start_memR_G1
	LDS  R27,_start_memR_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;     147 		DATA_CLK = 1;
	SBI  0x12,5
;     148 		DATA_CLK = 0;					         
	CBI  0x12,5
;     149 		DATA_PORT = start_memB[(SCREEN_HEIGHT/8)*(x) ]; 
	MOVW R30,R4
	CALL __LSLW3
	LDS  R26,_start_memB_G1
	LDS  R27,_start_memB_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;     150 		DATA_CLK = 1;
	SBI  0x12,5
;     151 		DATA_CLK = 0;				             
	CBI  0x12,5
;     152 		DATA_PORT = start_memG[(SCREEN_HEIGHT/8)*(x) ]; 
	MOVW R30,R4
	CALL __LSLW3
	LDS  R26,_start_memG_G1
	LDS  R27,_start_memG_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;     153 		DATA_CLK = 1;
	SBI  0x12,5
;     154 		DATA_CLK = 0;				
	CBI  0x12,5
;     155 	}         
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x10
_0x11:
;     156 	  
;     157     DATA_STB0 = 1;
	SBI  0x7,0
;     158     DATA_STB0 = 0; 
	CBI  0x7,0
;     159     
;     160     
;     161     for (x=0; x< SCREEN_WIDTH; x++){ 
	CLR  R4
	CLR  R5
_0x13:
	LDI  R30,LOW(240)
	LDI  R31,HIGH(240)
	CP   R4,R30
	CPC  R5,R31
	BRSH _0x14
;     162         DATA_PORT = start_memR[(SCREEN_HEIGHT/8)*(x) + 1]; 		  
	MOVW R30,R4
	CALL __LSLW3
	ADIW R30,1
	LDS  R26,_start_memR_G1
	LDS  R27,_start_memR_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;     163 		DATA_CLK = 1;
	SBI  0x12,5
;     164 		DATA_CLK = 0;				
	CBI  0x12,5
;     165         DATA_PORT = start_memB[(SCREEN_HEIGHT/8)*(x) + 1]; 
	MOVW R30,R4
	CALL __LSLW3
	ADIW R30,1
	LDS  R26,_start_memB_G1
	LDS  R27,_start_memB_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;     166     	DATA_CLK = 1;
	SBI  0x12,5
;     167 		DATA_CLK = 0;               
	CBI  0x12,5
;     168         DATA_PORT = start_memG[(SCREEN_HEIGHT/8)*(x) + 1];
	MOVW R30,R4
	CALL __LSLW3
	ADIW R30,1
	LDS  R26,_start_memG_G1
	LDS  R27,_start_memG_G1+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x18,R30
;     169         DATA_CLK = 1;
	SBI  0x12,5
;     170 		DATA_CLK = 0;					
	CBI  0x12,5
;     171 	}
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x13
_0x14:
;     172 	           
;     173     DATA_STB1 = 1;       
	SBI  0x7,2
;     174     DATA_STB1 = 0;     	         
	CBI  0x7,2
;     175 }
	RET
;     176    
;     177 static void _displayFrame()
;     178 {                                
__displayFrame_G1:
;     179     putdata();
	CALL _putdata_G1
;     180     putdata();
	CALL _putdata_G1
;     181     putdata();                
	CALL _putdata_G1
;     182     if (scroll_updown==0){
	LDS  R30,_scroll_updown_G1
	LDS  R31,_scroll_updown_G1+1
	SBIW R30,0
	BRNE _0x15
;     183         putdata0();            
	CALL _putdata0_G1
;     184     }             
;     185     else{
	RJMP _0x16
_0x15:
;     186         putdata();
	CALL _putdata_G1
;     187     }
_0x16:
;     188 }     
	RET
;     189                       
;     190 static void _doScript_0()
;     191 {
__doScript_0_G1:
;     192     if (scroll_step ==0){                 
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x17
;     193         start_memR += (SCREEN_HEIGHT/8);  
	LDS  R30,_start_memR_G1
	LDS  R31,_start_memR_G1+1
	ADIW R30,8
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     194         start_memG += (SCREEN_HEIGHT/8);  
	LDS  R30,_start_memG_G1
	LDS  R31,_start_memG_G1+1
	ADIW R30,8
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     195         start_memB += (SCREEN_HEIGHT/8);  
	LDS  R30,_start_memB_G1
	LDS  R31,_start_memB_G1+1
	ADIW R30,8
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     196         if (++scroll_count > SCREEN_WIDTH){     
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0xF1)
	LDI  R30,HIGH(0xF1)
	CPC  R27,R30
	BRLO _0x18
;     197             scroll_temp =scroll_rate;
	LDS  R30,_scroll_rate_G1
	STS  _scroll_temp_G1,R30
;     198             scroll_rate =FAST_RATE;
	LDI  R30,LOW(2)
	STS  _scroll_rate_G1,R30
;     199             scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     200             scroll_count=0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     201         }
;     202     }                                      
_0x18:
;     203     else if (scroll_step ==1){
	RJMP _0x19
_0x17:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x1A
;     204         start_memR -= (SCREEN_HEIGHT/8);   
	LDS  R30,_start_memR_G1
	LDS  R31,_start_memR_G1+1
	SBIW R30,8
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     205         if (++scroll_count > SCREEN_WIDTH){                
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0xF1)
	LDI  R30,HIGH(0xF1)
	CPC  R27,R30
	BRLO _0x1B
;     206             scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     207             scroll_count=0;                        
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     208         }
;     209     }    
_0x1B:
;     210     else if (scroll_step ==2){
	RJMP _0x1C
_0x1A:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x2)
	BRNE _0x1D
;     211         start_memG -= (SCREEN_HEIGHT/8);   
	LDS  R30,_start_memG_G1
	LDS  R31,_start_memG_G1+1
	SBIW R30,8
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     212         if (++scroll_count > SCREEN_WIDTH){
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0xF1)
	LDI  R30,HIGH(0xF1)
	CPC  R27,R30
	BRLO _0x1E
;     213             scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     214             scroll_count=0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     215         }
;     216     }
_0x1E:
;     217     else if (scroll_step ==3){
	RJMP _0x1F
_0x1D:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x3)
	BRNE _0x20
;     218         start_memB -= (SCREEN_HEIGHT/8);   
	LDS  R30,_start_memB_G1
	LDS  R31,_start_memB_G1+1
	SBIW R30,8
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     219         if (++scroll_count > SCREEN_WIDTH){
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0xF1)
	LDI  R30,HIGH(0xF1)
	CPC  R27,R30
	BRLO _0x21
;     220             scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     221             scroll_count=0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     222         }
;     223     }               
_0x21:
;     224     else if (scroll_step ==4){  
	RJMP _0x22
_0x20:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x4)
	BRNE _0x23
;     225         if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x24
;     226             scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     227             scroll_count=0; 
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     228             scroll_temp =scroll_rate;
	LDS  R30,_scroll_rate_G1
	STS  _scroll_temp_G1,R30
;     229             scroll_rate =SLOW_RATE;
	LDI  R30,LOW(100)
	STS  _scroll_rate_G1,R30
;     230         }
;     231     }
_0x24:
;     232     else if (scroll_step ==5){
	RJMP _0x25
_0x23:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x5)
	BRNE _0x26
;     233         if (++scroll_updown >=SCREEN_HEIGHT){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	ADIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	CPI  R26,LOW(0x40)
	LDI  R30,HIGH(0x40)
	CPC  R27,R30
	BRLO _0x27
;     234             scroll_step++;                
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     235             scroll_updown =0;  
	LDI  R30,0
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R30
;     236             scroll_rate =scroll_temp;     
	LDS  R30,_scroll_temp_G1
	STS  _scroll_rate_G1,R30
;     237         }
;     238     }
_0x27:
;     239     else if (scroll_step ==6){  
	RJMP _0x28
_0x26:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x6)
	BRNE _0x29
;     240         if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x2A
;     241             scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     242             scroll_count=0; 
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     243         }
;     244     }
_0x2A:
;     245     else{
	RJMP _0x2B
_0x29:
;     246         LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     247     }
_0x2B:
_0x28:
_0x25:
_0x22:
_0x1F:
_0x1C:
_0x19:
;     248 }
	RET
;     249                                            
;     250 static void _doScript_1()
;     251 {    
__doScript_1_G1:
;     252     if (scroll_step ==0){
	LDS  R30,_scroll_step_G1
	CPI  R30,0
	BRNE _0x2C
;     253         mask = 0x00; 
	LDI  R30,LOW(0)
	STS  _mask_G1,R30
;     254         scroll_step++;
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
;     255     }    
;     256     else if (scroll_step ==1){  
	RJMP _0x2D
_0x2C:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x1)
	BRNE _0x2E
;     257         if (++scroll_count > MIN_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	SBIW R26,3
	BRLO _0x2F
;     258             scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     259             scroll_count=0; 
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     260         }
;     261     }
_0x2F:
;     262     else if (scroll_step ==2){
	RJMP _0x30
_0x2E:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x2)
	BRNE _0x31
;     263         mask = 0xFF;  
	LDI  R30,LOW(255)
	STS  _mask_G1,R30
;     264         scroll_step++;
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
;     265     }
;     266     else if (scroll_step ==3){  
	RJMP _0x32
_0x31:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x3)
	BRNE _0x33
;     267         if (++scroll_count > MIN_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	SBIW R26,3
	BRLO _0x34
;     268             scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     269             scroll_count=0; 
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     270         }
;     271     }
_0x34:
;     272     else if (scroll_step ==4){  
	RJMP _0x35
_0x33:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x4)
	BRNE _0x36
;     273         if (++scroll_count > MAX_STOP_TIME){   
	LDS  R26,_scroll_count_G1
	LDS  R27,_scroll_count_G1+1
	ADIW R26,1
	STS  _scroll_count_G1,R26
	STS  _scroll_count_G1+1,R27
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLO _0x37
;     274             scroll_step++; 
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     275             scroll_count=0;                
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     276             scroll_temp =scroll_rate;
	LDS  R30,_scroll_rate_G1
	STS  _scroll_temp_G1,R30
;     277             scroll_rate =SLOW_RATE;
	LDI  R30,LOW(100)
	STS  _scroll_rate_G1,R30
;     278         }
;     279     }                  
_0x37:
;     280     else if (scroll_step ==5){
	RJMP _0x38
_0x36:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x5)
	BRNE _0x39
;     281         start_memR += (SCREEN_HEIGHT/8); 
	LDS  R30,_start_memR_G1
	LDS  R31,_start_memR_G1+1
	ADIW R30,8
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     282         start_memG += (SCREEN_HEIGHT/8); 
	LDS  R30,_start_memG_G1
	LDS  R31,_start_memG_G1+1
	ADIW R30,8
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     283         start_memB += (SCREEN_HEIGHT/8); 
	LDS  R30,_start_memB_G1
	LDS  R31,_start_memB_G1+1
	ADIW R30,8
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     284         if (++scroll_updown >=SCREEN_HEIGHT){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	ADIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	CPI  R26,LOW(0x40)
	LDI  R30,HIGH(0x40)
	CPC  R27,R30
	BRLO _0x3A
;     285             scroll_step++;       
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     286             scroll_rate =FAST_RATE;         
	LDI  R30,LOW(2)
	STS  _scroll_rate_G1,R30
;     287         }
;     288     }
_0x3A:
;     289     else if (scroll_step ==6){
	RJMP _0x3B
_0x39:
	LDS  R26,_scroll_step_G1
	CPI  R26,LOW(0x6)
	BRNE _0x3C
;     290         start_memR -= (SCREEN_HEIGHT/8); 
	LDS  R30,_start_memR_G1
	LDS  R31,_start_memR_G1+1
	SBIW R30,8
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     291         start_memG -= (SCREEN_HEIGHT/8); 
	LDS  R30,_start_memG_G1
	LDS  R31,_start_memG_G1+1
	SBIW R30,8
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     292         start_memB -= (SCREEN_HEIGHT/8); 
	LDS  R30,_start_memB_G1
	LDS  R31,_start_memB_G1+1
	SBIW R30,8
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     293         if (--scroll_updown <=0){                
	LDS  R26,_scroll_updown_G1
	LDS  R27,_scroll_updown_G1+1
	SBIW R26,1
	STS  _scroll_updown_G1,R26
	STS  _scroll_updown_G1+1,R27
	SBIW R26,0
	BRNE _0x3D
;     294             scroll_step++;                
	LDS  R30,_scroll_step_G1
	SUBI R30,-LOW(1)
	STS  _scroll_step_G1,R30
	SUBI R30,LOW(1)
;     295             scroll_updown =0;  
	LDI  R30,0
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R30
;     296             scroll_rate =scroll_temp;     
	LDS  R30,_scroll_temp_G1
	STS  _scroll_rate_G1,R30
;     297         }
;     298     }
_0x3D:
;     299     else{
	RJMP _0x3E
_0x3C:
;     300         LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     301     }
_0x3E:
_0x3B:
_0x38:
_0x35:
_0x32:
_0x30:
_0x2D:
;     302 }
	RET
;     303                                                                                           
;     304 static void _doScroll()
;     305 {                                        
__doScroll_G1:
;     306   if (tick_count > scroll_rate){
	LDS  R30,_scroll_rate_G1
	LDS  R26,_tick_count_G1
	CP   R30,R26
	BRSH _0x3F
;     307     tick_count = 0;    
	LDI  R30,LOW(0)
	STS  _tick_count_G1,R30
;     308     switch (scroll_type)
	LDS  R30,_scroll_type_G1
;     309     {
;     310     case 0:                     
	CPI  R30,0
	BRNE _0x43
;     311         _doScript_0();             
	CALL __doScript_0_G1
;     312         break;  
	RJMP _0x42
;     313     case 1:                     
_0x43:
	CPI  R30,LOW(0x1)
	BRNE _0x45
;     314         _doScript_1();             
	CALL __doScript_1_G1
;     315         break; 
	RJMP _0x42
;     316     default:        
_0x45:
;     317         LoadFrame(++frame_index);
	LDS  R30,_frame_index_G1
	SUBI R30,-LOW(1)
	STS  _frame_index_G1,R30
	ST   -Y,R30
	RCALL _LoadFrame
;     318         break;
;     319     }	
_0x42:
;     320 	if (frame_index >= MAX_FRAME){
	LDS  R26,_frame_index_G1
	CPI  R26,LOW(0x4)
	BRLO _0x46
;     321 	    frame_index=0;
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     322 	}
;     323     		
;     324   }
_0x46:
;     325              
;     326 }          
_0x3F:
	RET
;     327 ////////////////////////////////////////////////////////////////////
;     328 // General functions
;     329 //////////////////////////////////////////////////////////////////// 
;     330 #define RESET_WATCHDOG()    #asm("WDR");
;     331                                                                             
;     332 void LoadConfig(BYTE index)
;     333 {
_LoadConfig:
;     334     BYTE devID = EEPROM_DEVICE_BASE;    
;     335     WORD base = 0;   // base address
;     336     devID += index<<1;                 
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
;     337     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x47
;     338         base = 0x8000;    
	__GETWRN 17,18,32768
;     339     }                 
;     340     devID &= 0xF7;      // clear bit A3 
_0x47:
	ANDI R16,LOW(247)
;     341     
;     342     // init I2C bus
;     343     i2c_init();
	CALL _i2c_init
;     344     LED_STATUS = 0;
	CBI  0x18,4
;     345     scroll_rate = eeprom_read(devID, (WORD)base+0);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_rate_G1,R30
;     346     scroll_type = eeprom_read(devID, (WORD)base+1);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	STS  _scroll_type_G1,R30
;     347     text_length = eeprom_read_w(devID, (WORD)base+2); 
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read_w
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     348     printf("index=%d scroll_rate=%d scroll_type=%d text_lenth=%d\r\n",
;     349             index,   scroll_rate,   scroll_type,   text_length); 
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
;     350     
;     351     if (text_length > MAX_LENGTH){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0xF61)
	LDI  R30,HIGH(0xF61)
	CPC  R27,R30
	BRLO _0x48
;     352         text_length= 0;            
	LDI  R30,0
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R30
;     353     }
;     354     if (scroll_rate > MAX_RATE){
_0x48:
	LDS  R26,_scroll_rate_G1
	CPI  R26,LOW(0x65)
	BRLO _0x49
;     355         scroll_rate = 0;
	LDI  R30,LOW(0)
	STS  _scroll_rate_G1,R30
;     356     }
;     357     LED_STATUS = 1;   
_0x49:
	SBI  0x18,4
;     358 }
	RJMP _0xEF
;     359 
;     360 void LoadFrame(BYTE index)
;     361 {                 
_LoadFrame:
;     362     if (index >= MAX_FRAME){
;	index -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x4)
	BRLO _0x4A
;     363         index=0;
	LDI  R30,LOW(0)
	ST   Y,R30
;     364     }      
;     365     LoadConfig(index);  
_0x4A:
	LD   R30,Y
	ST   -Y,R30
	CALL _LoadConfig
;     366     if (scroll_type==-1){
	LDS  R26,_scroll_type_G1
	CPI  R26,LOW(0xFF)
	BRNE _0x4B
;     367         return;           
	RJMP _0xF0
;     368     }                                                                     
;     369     reset_serial();
_0x4B:
	RCALL _reset_serial
;     370     is_stopping = 0;
	CLT
	BLD  R2,1
;     371     scroll_step = 0;
	LDI  R30,LOW(0)
	STS  _scroll_step_G1,R30
;     372     scroll_count = 0;
	LDI  R30,0
	STS  _scroll_count_G1,R30
	STS  _scroll_count_G1+1,R30
;     373     scroll_updown = 0;
	LDI  R30,0
	STS  _scroll_updown_G1,R30
	STS  _scroll_updown_G1+1,R30
;     374     stopping_count = 0;    
	LDI  R30,0
	STS  _stopping_count_G1,R30
	STS  _stopping_count_G1+1,R30
;     375                             
;     376     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _BlankRAM
;     377     LoadToRAM((PBYTE)START_RAM,text_length,index);    
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
;     378     start_memR = (PBYTE)START_RAM + 0*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     379     start_memG = (PBYTE)START_RAM + 1*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(5120)
	LDI  R31,HIGH(5120)
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     380     start_memB = (PBYTE)START_RAM + 2*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);             
	LDI  R30,LOW(8960)
	LDI  R31,HIGH(8960)
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     381 }
_0xF0:
	ADIW R28,1
	RET
;     382                        
;     383 void SaveTextLength(BYTE index)
;     384 {
_SaveTextLength:
;     385     BYTE devID = EEPROM_DEVICE_BASE;    
;     386     WORD base = 0;   // base address
;     387     devID += index<<1;                 
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
;     388     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x4C
;     389         base = 0x8000;    
	__GETWRN 17,18,32768
;     390     }                 
;     391     devID &= 0xF7;      // clear bit A3 
_0x4C:
	ANDI R16,LOW(247)
;     392     
;     393     i2c_init();
	CALL _i2c_init
;     394     LED_STATUS = 0;   
	CBI  0x18,4
;     395     eeprom_write_w(devID, base+2,text_length); 
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
;     396     LED_STATUS = 1;   
	SBI  0x18,4
;     397 }
_0xEF:
	CALL __LOADLOCR3
	ADIW R28,4
	RET
;     398 
;     399 void SaveConfig(BYTE rate,BYTE type, BYTE index)
;     400 {                     
_SaveConfig:
;     401     BYTE devID = EEPROM_DEVICE_BASE;    
;     402     WORD base = 0;   // base address
;     403     devID += index<<1;                 
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
;     404     if (index >=4){
	LDD  R26,Y+3
	CPI  R26,LOW(0x4)
	BRLO _0x4D
;     405         base = 0x8000;    
	__GETWRN 17,18,32768
;     406     }                 
;     407     devID &= 0xF7;      // clear bit A3  
_0x4D:
	ANDI R16,LOW(247)
;     408     i2c_init();
	CALL _i2c_init
;     409     LED_STATUS = 0;  
	CBI  0x18,4
;     410     eeprom_write(devID, base+0,rate);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,0
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	CALL _eeprom_write
;     411     eeprom_write(devID, base+1,type);    
	ST   -Y,R16
	__GETW1R 17,18
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	ST   -Y,R30
	CALL _eeprom_write
;     412     LED_STATUS = 1;       
	SBI  0x18,4
;     413 }
	CALL __LOADLOCR3
	ADIW R28,6
	RET
;     414 
;     415 void SaveToEEPROM(PBYTE address,WORD length,BYTE index)
;     416 {                             
_SaveToEEPROM:
;     417     PBYTE tempL = 0;     
;     418     BYTE devID = EEPROM_DEVICE_BASE;
;     419     WORD base = 0;   // base address
;     420     devID += index<<1;                 
	CALL __SAVELOCR5
;	*address -> Y+8
;	length -> Y+6
;	index -> Y+5
;	*tempL -> R16,R17
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
;     421     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x4E
;     422         base = 0x8000;    
	__GETWRN 19,20,32768
;     423     }         				
;     424     tempL = address;         
_0x4E:
	__GETWRS 16,17,8
;     425         
;     426     if (length > MAX_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xF61)
	LDI  R30,HIGH(0xF61)
	CPC  R27,R30
	BRLO _0x4F
;     427         return; // invalid param 
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     428     length = (WORD)address+MAX_COLOR*(SCREEN_HEIGHT/8)*(length);         
_0x4F:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDI  R26,LOW(24)
	LDI  R27,HIGH(24)
	CALL __MULW12U
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     429     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x50
;     430         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     431     // init I2C bus
;     432     i2c_init();
_0x50:
	CALL _i2c_init
;     433     LED_STATUS = 0;        
	CBI  0x18,4
;     434     
;     435     for (tempL = address; tempL < length; tempL+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x52:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x53
;     436     {   
;     437         RESET_WATCHDOG();                          	                                              
	WDR
;     438         eeprom_write_page( devID, base+(WORD)tempL, (PBYTE)tempL, EEPROM_PAGE);	      
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
;     439     }       
	__ADDWRN 16,17,64
	JMP  _0x52
_0x53:
;     440         
;     441     LED_STATUS = 1;   
	SBI  0x18,4
;     442 }
	RJMP _0xEE
;     443                       
;     444 void LoadToRAM(PBYTE address,WORD length,BYTE index)
;     445 {                         
_LoadToRAM:
;     446     PBYTE tempL = 0;          
;     447     BYTE devID = EEPROM_DEVICE_BASE;
;     448     WORD base = 0;   // base address
;     449     devID += index<<1;                 
	CALL __SAVELOCR5
;	*address -> Y+8
;	length -> Y+6
;	index -> Y+5
;	*tempL -> R16,R17
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
;     450     if (index >=4){
	LDD  R26,Y+5
	CPI  R26,LOW(0x4)
	BRLO _0x54
;     451         base = 0x8000;    
	__GETWRN 19,20,32768
;     452     }       				
;     453     tempL = address;                 
_0x54:
	__GETWRS 16,17,8
;     454 
;     455     if (length > MAX_LENGTH)    
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0xF61)
	LDI  R30,HIGH(0xF61)
	CPC  R27,R30
	BRLO _0x55
;     456         return; // invalid param
_0xEE:
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     457     length = (WORD)address+MAX_COLOR*(SCREEN_HEIGHT/8)*(length);         
_0x55:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDI  R26,LOW(24)
	LDI  R27,HIGH(24)
	CALL __MULW12U
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;     458     if (length%EEPROM_PAGE)
	ANDI R30,LOW(0x3F)
	BREQ _0x56
;     459         length = EEPROM_PAGE*(length/EEPROM_PAGE) + EEPROM_PAGE;  
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
;     460     // init I2C bus
;     461     i2c_init();
_0x56:
	CALL _i2c_init
;     462     LED_STATUS = 0;             
	CBI  0x18,4
;     463  
;     464     for (tempL = address; tempL < length; tempL+= EEPROM_PAGE) 
	__GETWRS 16,17,8
_0x58:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x59
;     465     {
;     466         eeprom_read_page( devID, base+(WORD)tempL, (PBYTE)tempL, EEPROM_PAGE );	                                   
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
;     467         RESET_WATCHDOG();     
	WDR
;     468     }             
	__ADDWRN 16,17,64
	JMP  _0x58
_0x59:
;     469 
;     470     LED_STATUS = 1;   
	SBI  0x18,4
;     471 }
	CALL __LOADLOCR5
	ADIW R28,10
	RET
;     472 
;     473 void SerialToRAM(PBYTE address,WORD length)                                             
;     474 {
_SerialToRAM:
;     475     PBYTE tempL = 0;          
;     476     UINT i =0;     				
;     477     tempL   = address;    
	CALL __SAVELOCR4
;	*address -> Y+6
;	length -> Y+4
;	*tempL -> R16,R17
;	i -> R18,R19
	LDI  R16,LOW(0x00)
	LDI  R17,HIGH(0x00)
	LDI  R18,0
	LDI  R19,0
	__GETWRS 16,17,6
;     478     LED_STATUS = 0;
	CBI  0x18,4
;     479     for (i =0; i< (length)*(SCREEN_HEIGHT/8)*MAX_COLOR; i++)         
	__GETWRN 18,19,0
_0x5B:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL __LSLW3
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12U
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x5C
;     480     {                          
;     481         BYTE data = 0;
;     482         data = ~getchar();
	SBIW R28,1
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x5D*2)
	LDI  R31,HIGH(_0x5D*2)
	CALL __INITLOCB
;	*address -> Y+7
;	length -> Y+5
;	data -> Y+0
	CALL _getchar
	COM  R30
	ST   Y,R30
;     483         *tempL = data;
	MOVW R26,R16
	ST   X,R30
;     484         tempL++;
	__ADDWRN 16,17,1
;     485         RESET_WATCHDOG();                                     
	WDR
;     486     }              
	ADIW R28,1
	__ADDWRN 18,19,1
	JMP  _0x5B
_0x5C:
;     487     LED_STATUS = 1;
	SBI  0x18,4
;     488 }
	CALL __LOADLOCR4
	ADIW R28,8
	RET
;     489                       
;     490 void BlankRAM(PBYTE start_addr,PBYTE end_addr)
;     491 {        
_BlankRAM:
;     492     PBYTE tempL = START_RAM;
;     493     for (tempL = start_addr; tempL<= end_addr; tempL++)    
	ST   -Y,R17
	ST   -Y,R16
;	*start_addr -> Y+4
;	*end_addr -> Y+2
;	*tempL -> R16,R17
	LDI  R16,LOW(0x500)
	LDI  R17,HIGH(0x500)
	__GETWRS 16,17,4
_0x5F:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R30,R16
	CPC  R31,R17
	BRLO _0x60
;     494         *tempL = 0xFF;             
	MOVW R26,R16
	LDI  R30,LOW(255)
	ST   X,R30
;     495 }
	__ADDWRN 16,17,1
	RJMP _0x5F
_0x60:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;     496 
;     497 
;     498 ///////////////////////////////////////////////////////////////
;     499 // END static function(s)
;     500 ///////////////////////////////////////////////////////////////
;     501 
;     502 ///////////////////////////////////////////////////////////////           
;     503 
;     504 void InitDevice()
;     505 {
_InitDevice:
;     506 // Declare your local variables here
;     507 // Crystal Oscillator division factor: 1  
;     508 #ifdef _MEGA162_INCLUDED_ 
;     509 #pragma optsize-
;     510 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     511 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     512 #ifdef _OPTIMIZE_SIZE_
;     513 #pragma optsize+
;     514 #endif                    
;     515 #endif
;     516 
;     517 PORTA=0x00;
	OUT  0x1B,R30
;     518 DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;     519 
;     520 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
;     521 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     522 
;     523 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     524 DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
;     525 
;     526 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     527 DDRD=0x30; 
	LDI  R30,LOW(48)
	OUT  0x11,R30
;     528 
;     529 PORTE=0x00;
	LDI  R30,LOW(0)
	OUT  0x7,R30
;     530 DDRE=0xFF;
	LDI  R30,LOW(255)
	OUT  0x6,R30
;     531 
;     532 // Timer/Counter 0 initialization
;     533 // Clock source: System Clock
;     534 // Clock value: 250.000 kHz
;     535 // Mode: Normal top=FFh
;     536 // OC0 output: Disconnected
;     537 TCCR0=0x03;     // 4 us per tick
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     538 TCNT0=0x05;     // 1ms = 4*250
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     539 OCR0=0x00;      // 255 -250 = TCNT0
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     540 
;     541 #ifdef _MEGA162_INCLUDED_
;     542 UCSR0A=0x00;
	OUT  0xB,R30
;     543 UCSR0B=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     544 UCSR0C=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     545 UBRR0H=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     546 UBRR0L=0x67;      //  16 MHz     
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     547 
;     548 #else // _MEGA8515_INCLUDE_     
;     549 UCSRA=0x00;
;     550 UCSRB=0x98;
;     551 UCSRC=0x86;
;     552 UBRRH=0x00;
;     553 UBRRL=0x67;       // 16 MHz
;     554 #endif
;     555 
;     556 // Lower page wait state(s): None
;     557 // Upper page wait state(s): None
;     558 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     559 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     560 
;     561 // Timer(s)/Counter(s) Interrupt(s) initialization
;     562 TIMSK=0x02;              
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     563 #ifdef _MEGA162_INCLUDED_
;     564 ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
;     565 #endif
;     566 // Load calibration byte for osc.  
;     567 #ifdef _MEGA162_INCLUDED_
;     568 OSCCAL = 0x5E; 
	LDI  R30,LOW(94)
	OUT  0x4,R30
;     569 #else
;     570 OSCCAL = 0xA7; 
;     571 #endif            
;     572 
;     573 // I2C Bus initialization
;     574 // i2c_init();
;     575 
;     576 // DS1307 Real Time Clock initialization
;     577 // Square wave output on pin SQW/OUT: Off
;     578 // SQW/OUT pin state: 1
;     579 // rtc_init(3,0,1);
;     580 
;     581 //i2c_init(); // must be call before
;     582 //rtc_init(3,0,1); // init RTC DS1307  
;     583 //rtc_set_time(15,2,0);
;     584 //rtc_set_date(9,5,6);    
;     585                 
;     586 // Watchdog Timer initialization
;     587 // Watchdog Timer Prescaler: OSC/2048k     
;     588 #ifdef __WATCH_DOG_
;     589 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     590 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     591 #endif
;     592 }
	RET
;     593 
;     594 void PowerReset()
;     595 {      
_PowerReset:
;     596     InitDevice();
	CALL _InitDevice
;     597     
;     598     start_memR = (PBYTE)START_RAM;
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     599     start_memG = (PBYTE)START_RAM;
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     600     start_memB = (PBYTE)START_RAM;
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     601    
;     602     LED_STATUS = 0;
	CBI  0x18,4
;     603     BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);  
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     604     
;     605     LED_STATUS = 0;  
	CBI  0x18,4
;     606     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     607     LED_STATUS = 1;
	SBI  0x18,4
;     608     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     609     LED_STATUS = 0;
	CBI  0x18,4
;     610     delay_ms(100);    
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     611     LED_STATUS = 1;
	SBI  0x18,4
;     612                 
;     613     frame_index= 0;
	LDI  R30,LOW(0)
	STS  _frame_index_G1,R30
;     614     LoadFrame(frame_index);
	ST   -Y,R30
	CALL _LoadFrame
;     615     start_memR = (PBYTE)START_RAM + 0*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     616     start_memG = (PBYTE)START_RAM + 1*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(5120)
	LDI  R31,HIGH(5120)
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     617     start_memB = (PBYTE)START_RAM + 2*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(8960)
	LDI  R31,HIGH(8960)
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     618                  
;     619     printf("LCMS v4.00 Designed by CuongQuay\r\n");  
	__POINTW1FN _0,55
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     620     printf("cuong3ihut@yahoo.com - 0915651001\r\n");
	__POINTW1FN _0,90
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     621     printf("Release date: 03.12.2006\r\n");
	__POINTW1FN _0,126
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     622 }
	RET
;     623 
;     624 void ProcessCommand()
;     625 {
_ProcessCommand:
;     626    	#asm("cli"); 
	cli
;     627     RESET_WATCHDOG();
	WDR
;     628 
;     629     // serial message processing     
;     630     switch (rx_message)
	MOV  R30,R8
;     631     {                  
;     632     case LOAD_TEXT_MSG:
	CPI  R30,LOW(0x2)
	BREQ PC+3
	JMP _0x64
;     633         {                
;     634             text_length = rx_wparam;      
	__PUTWMRN _text_length_G1,0,9,10
;     635             if (text_length > SCREEN_WIDTH<<1){
	LDS  R26,_text_length_G1
	LDS  R27,_text_length_G1+1
	CPI  R26,LOW(0x1E1)
	LDI  R30,HIGH(0x1E1)
	CPC  R27,R30
	BRLO _0x65
;     636                 text_length = SCREEN_WIDTH<<1;
	LDI  R30,LOW(480)
	LDI  R31,HIGH(480)
	STS  _text_length_G1,R30
	STS  _text_length_G1+1,R31
;     637             }
;     638             frame_index = rx_lparam&0x0F;   
_0x65:
	__GETW1R 11,12
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	STS  _frame_index_G1,R30
;     639             BlankRAM((PBYTE)START_RAM,(PBYTE)END_RAM);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32768)
	LDI  R31,HIGH(32768)
	ST   -Y,R31
	ST   -Y,R30
	CALL _BlankRAM
;     640             SerialToRAM((PBYTE)START_RAM,text_length);                		               				
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_text_length_G1
	LDS  R31,_text_length_G1+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _SerialToRAM
;     641 			SaveToEEPROM((PBYTE)START_RAM,text_length,rx_lparam);
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
;     642 			SaveTextLength(rx_lparam);							      
	ST   -Y,R11
	CALL _SaveTextLength
;     643 			
;     644 			start_memR = (PBYTE)START_RAM + 0*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(1280)
	LDI  R31,HIGH(1280)
	STS  _start_memR_G1,R30
	STS  _start_memR_G1+1,R31
;     645             start_memG = (PBYTE)START_RAM + 1*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(5120)
	LDI  R31,HIGH(5120)
	STS  _start_memG_G1,R30
	STS  _start_memG_G1+1,R31
;     646             start_memB = (PBYTE)START_RAM + 2*(SCREEN_WIDTH<<1)*(SCREEN_HEIGHT/8);
	LDI  R30,LOW(8960)
	LDI  R31,HIGH(8960)
	STS  _start_memB_G1,R30
	STS  _start_memB_G1+1,R31
;     647 
;     648         }				
;     649         break;           
	RJMP _0x63
;     650     case LOAD_BKGND_MSG:
_0x64:
	CPI  R30,LOW(0x3)
	BREQ _0x63
;     651         break;   
;     652     case SET_CFG_MSG: 
	CPI  R30,LOW(0xD)
	BRNE _0x67
;     653         {               
;     654             SaveConfig(rx_wparam&0x0FF,rx_wparam>>8,rx_lparam); 
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	ST   -Y,R11
	CALL _SaveConfig
;     655         }
;     656         break;    
	RJMP _0x63
;     657     case EEPROM_SAVE_TEXT_MSG:     
_0x67:
	CPI  R30,LOW(0x7)
	BREQ _0x69
;     658     case EEPROM_SAVE_ALL_MSG:  
	CPI  R30,LOW(0xB)
	BRNE _0x6A
_0x69:
;     659         break;         
	RJMP _0x63
;     660     case EEPROM_LOAD_TEXT_MSG:    
_0x6A:
	CPI  R30,LOW(0x6)
	BREQ _0x6C
;     661     case EEPROM_LOAD_ALL_MSG:
	CPI  R30,LOW(0xA)
	BRNE _0x6D
_0x6C:
;     662         break;  
	RJMP _0x63
;     663     case POWER_CTRL_MSG:    
_0x6D:
	CPI  R30,LOW(0x10)
	BRNE _0x6F
;     664         {
;     665             power_off = rx_wparam&0x01;
	BST  R9,0
	BLD  R2,0
;     666         }
;     667         break;     
;     668     default:
_0x6F:
;     669         break;
;     670     }                 
_0x63:
;     671     send_echo_msg();            
	RCALL _send_echo_msg
;     672     rx_message = UNKNOWN_MSG;
	CLR  R8
;     673     #asm("sei");        
	sei
;     674 }           
	RET
;     675 void DelayFrame(BYTE dly)
;     676 {
;     677     BYTE i =0;
;     678     for (i=0;i<dly;i++){
;	dly -> Y+1
;	i -> R16
;     679         if (rx_message != UNKNOWN_MSG){           
;     680             break;
;     681         }   
;     682         delay_ms(10);
;     683         RESET_WATCHDOG();
;     684     }
;     685 }
;     686 ////////////////////////////////////////////////////////////////////////////////
;     687 // MAIN PROGRAM
;     688 ////////////////////////////////////////////////////////////////////////////////
;     689 void main(void)
;     690 {         
_main:
;     691     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x74
;     692         // Watchdog Reset
;     693         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     694         reset_serial(); 
	RCALL _reset_serial
;     695     }
;     696     else {      
	RJMP _0x75
_0x74:
;     697         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     698     }                                     
_0x75:
;     699      
;     700     PowerReset();                        
	CALL _PowerReset
;     701     #asm("sei");     
	sei
;     702 
;     703     while (1){                     
_0x76:
;     704         if (rx_message != UNKNOWN_MSG){   
	TST  R8
	BREQ _0x79
;     705             ProcessCommand();   
	CALL _ProcessCommand
;     706         }
;     707         else{           
	RJMP _0x7A
_0x79:
;     708             _displayFrame();
	CALL __displayFrame_G1
;     709             _doScroll();            
	CALL __doScroll_G1
;     710         }
_0x7A:
;     711         RESET_WATCHDOG();
	WDR
;     712     };
	JMP  _0x76
;     713 
;     714 }
_0x7B:
	NOP
	RJMP _0x7B
;     715                          
;     716 #include "define.h"
;     717 
;     718 ///////////////////////////////////////////////////////////////
;     719 // serial interrupt handle - processing serial message ...
;     720 ///////////////////////////////////////////////////////////////
;     721 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     722 ///////////////////////////////////////////////////////////////
;     723 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     724 extern BYTE  rx_message;
;     725 extern WORD  rx_wparam;
;     726 extern WORD  rx_lparam;
;     727 
;     728 #if RX_BUFFER_SIZE<256
;     729 unsigned char rx_wr_index,rx_counter;
;     730 #else
;     731 unsigned int rx_wr_index,rx_counter;
;     732 #endif
;     733 
;     734 void send_echo_msg();
;     735 
;     736 // USART Receiver interrupt service routine
;     737 #ifdef _MEGA162_INCLUDED_                    
;     738 interrupt [USART0_RXC] void usart_rx_isr(void)
;     739 #else
;     740 interrupt [USART_RXC] void usart_rx_isr(void)
;     741 #endif
;     742 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     743 char status,data;
;     744 #ifdef _MEGA162_INCLUDED_  
;     745 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;     746 data=UDR0;
	IN   R17,12
;     747 #else     
;     748 status=UCSRA;
;     749 data=UDR;
;     750 #endif          
;     751     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+3
	JMP _0x7C
;     752     {
;     753         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R13
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;     754         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0x7D
	CLR  R13
;     755         if (++rx_counter == RX_BUFFER_SIZE)
_0x7D:
	INC  R14
	LDI  R30,LOW(8)
	CP   R30,R14
	BRNE _0x7E
;     756         {
;     757             rx_counter=0;
	CLR  R14
;     758             if (
;     759                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;     760                 rx_buffer[2]==WAKEUP_CHAR 
;     761                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BRNE _0x80
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BRNE _0x80
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ _0x81
_0x80:
	RJMP _0x7F
_0x81:
;     762             {
;     763                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 8,_rx_buffer,3
;     764                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 9,_rx_buffer,4
	CLR  R10
;     765                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R9
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 9,10
;     766                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 11,_rx_buffer,6
	CLR  R12
;     767                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R11
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 11,12
;     768             }
;     769             else if(
	RJMP _0x82
_0x7F:
;     770                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;     771                 rx_buffer[2]==ESCAPE_CHAR 
;     772                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0x84
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0x84
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0x85
_0x84:
	RJMP _0x83
_0x85:
;     773             {
;     774                 rx_wr_index=0;
	CLR  R13
;     775                 rx_counter =0;
	CLR  R14
;     776             }      
;     777         };
_0x83:
_0x82:
_0x7E:
;     778     };
_0x7C:
;     779 }
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     780 
;     781 void send_echo_msg()
;     782 {
_send_echo_msg:
;     783     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     784     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     785     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     786     putchar(rx_message);
	ST   -Y,R8
	CALL _putchar
;     787     putchar(rx_wparam>>8);
	MOV  R30,R10
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     788     putchar(rx_wparam&0x00FF);
	__GETW1R 9,10
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     789     putchar(rx_lparam>>8);        
	MOV  R30,R12
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     790     putchar(rx_lparam&0x00FF);
	__GETW1R 11,12
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     791 }  
	RET
;     792 
;     793 void reset_serial()
;     794 {
_reset_serial:
;     795     rx_wr_index=0;
	CLR  R13
;     796     rx_counter =0;
	CLR  R14
;     797     rx_message = UNKNOWN_MSG;
	CLR  R8
;     798 }
	RET
;     799 
;     800 ///////////////////////////////////////////////////////////////
;     801 // END serial interrupt handle
;     802 /////////////////////////////////////////////////////////////// 
;     803 /*****************************************************
;     804 This program was produced by the
;     805 CodeWizardAVR V1.24.4a Standard
;     806 Automatic Program Generator
;     807 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;     808 http://www.hpinfotech.com
;     809 e-mail:office@hpinfotech.com
;     810 
;     811 Project : 
;     812 Version : 
;     813 Date    : 19/5/2005
;     814 Author  : 3iGROUP                
;     815 Company : http://www.3ihut.net   
;     816 Comments: 
;     817 
;     818 
;     819 Chip type           : ATmega8515
;     820 Program type        : Application
;     821 Clock frequency     : 8.000000 MHz
;     822 Memory model        : Small
;     823 External SRAM size  : 32768
;     824 Ext. SRAM wait state: 0
;     825 Data Stack size     : 128
;     826 *****************************************************/
;     827 
;     828 #include "define.h"                                           
;     829 
;     830 #define     ACK                 1
;     831 #define     NO_ACK              0
;     832 
;     833 // I2C Bus functions
;     834 #asm
;     835    .equ __i2c_port=0x12 ;PORTD
   .equ __i2c_port=0x12 ;PORTD
;     836    .equ __sda_bit=3
   .equ __sda_bit=3
;     837    .equ __scl_bit=2
   .equ __scl_bit=2
;     838 #endasm                   
;     839 
;     840 #ifdef __EEPROM_WRITE_BYTE
;     841 BYTE eeprom_read(BYTE deviceID, WORD address) 
;     842 {
_eeprom_read:
;     843     BYTE data;
;     844     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	address -> Y+1
;	data -> R16
	CALL _i2c_start
;     845     i2c_write(deviceID);        // issued R/W = 0
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     846     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     847     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     848     
;     849     i2c_start();
	CALL _i2c_start
;     850     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     851     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R16,R30
;     852     i2c_stop();
	CALL _i2c_stop
;     853     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0xED
;     854 }
;     855 
;     856 void eeprom_write(BYTE deviceID, WORD address, BYTE data) 
;     857 {
_eeprom_write:
;     858     i2c_start();
;	deviceID -> Y+3
;	address -> Y+1
;	data -> Y+0
	CALL _i2c_start
;     859     i2c_write(deviceID);        // device address
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
;     860     i2c_write(address>>8);      // high word address
	LDD  R30,Y+2
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     861     i2c_write(address&0x0FF);   // low word address
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     862     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	CALL _i2c_write
;     863     i2c_stop();
	CALL _i2c_stop
;     864 
;     865     /* 10ms delay to complete the write operation */
;     866     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     867 }                                 
_0xED:
	ADIW R28,4
	RET
;     868 
;     869 WORD eeprom_read_w(BYTE deviceID, WORD address)
;     870 {
_eeprom_read_w:
;     871     WORD result = 0;
;     872     result = eeprom_read(deviceID,address);
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
;     873     result = (result<<8) | eeprom_read(deviceID,address+1);
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
;     874     return result;
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0xEC
;     875 }
;     876 void eeprom_write_w(BYTE deviceID, WORD address, WORD data)
;     877 {
_eeprom_write_w:
;     878     eeprom_write(deviceID,address,data>>8);
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
;     879     eeprom_write(deviceID,address+1,data&0x0FF);    
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
;     880 }
_0xEC:
	ADIW R28,5
	RET
;     881 
;     882 #endif // __EEPROM_WRITE_BYTE
;     883 void eeprom_read_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     884 {
_eeprom_read_page:
;     885     BYTE i = 0;
;     886     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;     887     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;     888     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     889     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     890     
;     891     i2c_start();
	CALL _i2c_start
;     892     i2c_write(deviceID | 1);        // issued R/W = 1
	LDD  R30,Y+6
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;     893                                     
;     894     while ( i < page_size-1 )
_0x86:
	LDD  R30,Y+1
	SUBI R30,LOW(1)
	CP   R16,R30
	BRSH _0x88
;     895     {
;     896         buffer[i++] = i2c_read(ACK);   // read at current
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
;     897     }
	RJMP _0x86
_0x88:
;     898     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
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
;     899          
;     900     i2c_stop();
	CALL _i2c_stop
;     901 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     902 
;     903 void eeprom_write_page(BYTE deviceID, WORD address, PBYTE buffer, BYTE page_size)
;     904 {
_eeprom_write_page:
;     905     BYTE i = 0;
;     906     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+6
;	address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
	LDI  R16,0
	CALL _i2c_start
;     907     i2c_write(deviceID);            // issued R/W = 0
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _i2c_write
;     908     i2c_write(address>>8);          // high word address
	LDD  R30,Y+5
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _i2c_write
;     909     i2c_write(address&0xFF);        // low word address
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _i2c_write
;     910                                         
;     911     while ( i < page_size )
_0x89:
	LDD  R30,Y+1
	CP   R16,R30
	BRSH _0x8B
;     912     {
;     913         i2c_write(buffer[i++]);
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
;     914         #asm("nop");#asm("nop");
	nop
	nop
;     915     }          
	JMP  _0x89
_0x8B:
;     916     i2c_stop(); 
	CALL _i2c_stop
;     917     delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     918 }
	LDD  R16,Y+0
	ADIW R28,7
	RET
;     919                                               

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
	BREQ _0x8C
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0x8D
_0x8C:
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _putchar
_0x8D:
	ADIW R28,3
	RET
__print_G4:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R16,0
_0x8E:
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
	JMP _0x90
	MOV  R30,R16
	CPI  R30,0
	BRNE _0x94
	CPI  R19,37
	BRNE _0x95
	LDI  R16,LOW(1)
	RJMP _0x96
_0x95:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
_0x96:
	RJMP _0x93
_0x94:
	CPI  R30,LOW(0x1)
	BRNE _0x97
	CPI  R19,37
	BRNE _0x98
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0xF1
_0x98:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0x99
	LDI  R17,LOW(1)
	RJMP _0x93
_0x99:
	CPI  R19,43
	BRNE _0x9A
	LDI  R21,LOW(43)
	RJMP _0x93
_0x9A:
	CPI  R19,32
	BRNE _0x9B
	LDI  R21,LOW(32)
	RJMP _0x93
_0x9B:
	RJMP _0x9C
_0x97:
	CPI  R30,LOW(0x2)
	BRNE _0x9D
_0x9C:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0x9E
	ORI  R17,LOW(128)
	RJMP _0x93
_0x9E:
	RJMP _0x9F
_0x9D:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x93
_0x9F:
	CPI  R19,48
	BRLO _0xA2
	CPI  R19,58
	BRLO _0xA3
_0xA2:
	RJMP _0xA1
_0xA3:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x93
_0xA1:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0xA7
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
	RJMP _0xA8
_0xA7:
	CPI  R30,LOW(0x73)
	BRNE _0xAA
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
	RJMP _0xAB
_0xAA:
	CPI  R30,LOW(0x70)
	BRNE _0xAD
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
_0xAB:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0xAE
_0xAD:
	CPI  R30,LOW(0x64)
	BREQ _0xB1
	CPI  R30,LOW(0x69)
	BRNE _0xB2
_0xB1:
	ORI  R17,LOW(4)
	RJMP _0xB3
_0xB2:
	CPI  R30,LOW(0x75)
	BRNE _0xB4
_0xB3:
	LDI  R30,LOW(_tbl10_G4*2)
	LDI  R31,HIGH(_tbl10_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0xB5
_0xB4:
	CPI  R30,LOW(0x58)
	BRNE _0xB7
	ORI  R17,LOW(8)
	RJMP _0xB8
_0xB7:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0xE9
_0xB8:
	LDI  R30,LOW(_tbl16_G4*2)
	LDI  R31,HIGH(_tbl16_G4*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0xB5:
	SBRS R17,2
	RJMP _0xBA
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
	BRGE _0xBB
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0xBB:
	CPI  R21,0
	BREQ _0xBC
	SUBI R16,-LOW(1)
	RJMP _0xBD
_0xBC:
	ANDI R17,LOW(251)
_0xBD:
	RJMP _0xBE
_0xBA:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0xBE:
_0xAE:
	SBRC R17,0
	RJMP _0xBF
_0xC0:
	CP   R16,R20
	BRSH _0xC2
	SBRS R17,7
	RJMP _0xC3
	SBRS R17,2
	RJMP _0xC4
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0xC5
_0xC4:
	LDI  R19,LOW(48)
_0xC5:
	RJMP _0xC6
_0xC3:
	LDI  R19,LOW(32)
_0xC6:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	SUBI R20,LOW(1)
	RJMP _0xC0
_0xC2:
_0xBF:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0xC7
_0xC8:
	CPI  R18,0
	BREQ _0xCA
	SBRS R17,3
	RJMP _0xCB
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0xF2
_0xCB:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0xF2:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xCD
	SUBI R20,LOW(1)
_0xCD:
	SUBI R18,LOW(1)
	RJMP _0xC8
_0xCA:
	RJMP _0xCE
_0xC7:
_0xD0:
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
_0xD2:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0xD4
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0xD2
_0xD4:
	CPI  R19,58
	BRLO _0xD5
	SBRS R17,3
	RJMP _0xD6
	SUBI R19,-LOW(7)
	RJMP _0xD7
_0xD6:
	SUBI R19,-LOW(39)
_0xD7:
_0xD5:
	SBRC R17,4
	RJMP _0xD9
	CPI  R19,49
	BRSH _0xDB
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0xDA
_0xDB:
	RJMP _0xF3
_0xDA:
	CP   R20,R18
	BRLO _0xDF
	SBRS R17,0
	RJMP _0xE0
_0xDF:
	RJMP _0xDE
_0xE0:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0xE1
	LDI  R19,LOW(48)
_0xF3:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0xE2
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xE3
	SUBI R20,LOW(1)
_0xE3:
_0xE2:
_0xE1:
_0xD9:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	CPI  R20,0
	BREQ _0xE4
	SUBI R20,LOW(1)
_0xE4:
_0xDE:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0xD1
	RJMP _0xD0
_0xD1:
_0xCE:
	SBRS R17,0
	RJMP _0xE5
_0xE6:
	CPI  R20,0
	BREQ _0xE8
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G4
	RJMP _0xE6
_0xE8:
_0xE5:
_0xE9:
_0xA8:
_0xF1:
	LDI  R16,LOW(0)
_0x93:
	RJMP _0x8E
_0x90:
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

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
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
