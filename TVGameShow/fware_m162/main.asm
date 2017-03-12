
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
;      27 // Global variables for message control
;      28 BYTE  rx_message = UNKNOWN_MSG;
;      29 WORD  rx_wparam  = 0;
;      30 WORD  rx_lparam  = 0;                
;      31 
;      32 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;      33 
;      34 // display code area //
;      35 /* station 1 [ 888 ] */
;      36 /* station 2 [ 888 ] */
;      37 /* station 3 [ 888 ] */
;      38 /* station 4 [ 888 ] */
;      39 
;      40 BYTE  buffer[MAX_DIGIT] = {0x84,0xFC,0x91,0xB0,0xE8,0xA2,
_buffer:
;      41                            0x82,0xF4,0x80,0xA0,0xFB,0xFF};
	.BYTE 0xC
;      42                             
;      43 extern void reset_serial();         
;      44 extern void send_echo_msg();    
;      45 
;      46 static void _displayFrame();
;      47 static void _doScroll();   
;      48 
;      49 ///////////////////////////////////////////////////////////////
;      50 // Timer 0 overflow interrupt service routine , 40.5 us per tick                 
;      51 ///////////////////////////////////////////////////////////////
;      52 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;      53 {       

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
;      54     TCNT0 = 0x05;       // 1ms = 4*250 = 1000 us
	LDI  R30,LOW(5)
	OUT  0x32,R30
;      55 }
	LD   R30,Y+
	RETI
;      56 
;      57 ///////////////////////////////////////////////////////////////
;      58 // static function(s) for led matrix display panel
;      59 ///////////////////////////////////////////////////////////////
;      60 
;      61 static void _displayFrame()
;      62 {                
__displayFrame_G1:
;      63     BYTE mask=0;                  
;      64     BYTE i=0,k=0;     
;      65     CTRL_CLK = 0;
	CALL __SAVELOCR3
;	mask -> R16
;	i -> R17
;	k -> R18
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	CBI  0x18,5
;      66     CTRL_STB = 0;
	CBI  0x18,7
;      67     CTRL_DAT = 0;
	CBI  0x18,6
;      68     for (i=0; i< MAX_DIGIT; i++){      
	LDI  R17,LOW(0)
_0x5:
	CPI  R17,12
	BRSH _0x6
;      69         mask = 0x01;                      
	LDI  R16,LOW(1)
;      70         for (k=0; k< 8; k++){
	LDI  R18,LOW(0)
_0x8:
	CPI  R18,8
	BRSH _0x9
;      71             if ((buffer[i]&mask)>>(k)){
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_buffer)
	SBCI R31,HIGH(-_buffer)
	LD   R30,Z
	AND  R30,R16
	MOV  R26,R30
	MOV  R30,R18
	CALL __LSRB12
	CPI  R30,0
	BREQ _0xA
;      72                 CTRL_DAT = 1;
	SBI  0x18,6
;      73             }
;      74             else{
	RJMP _0xB
_0xA:
;      75                 CTRL_DAT = 0;
	CBI  0x18,6
;      76             }
_0xB:
;      77             CTRL_CLK = 1;delay_us(250);
	SBI  0x18,5
	__DELAY_USW 1000
;      78             CTRL_CLK = 0;delay_us(250);        
	CBI  0x18,5
	__DELAY_USW 1000
;      79             mask = mask<<1;  
	LSL  R16
;      80         }        
	SUBI R18,-1
	RJMP _0x8
_0x9:
;      81     }	             
	SUBI R17,-1
	RJMP _0x5
_0x6:
;      82     CTRL_STB = 1;delay_us(250);
	SBI  0x18,7
	__DELAY_USW 1000
;      83     CTRL_STB = 0;delay_us(250);
	CBI  0x18,7
	__DELAY_USW 1000
;      84 }                                                                                       
	CALL __LOADLOCR3
	ADIW R28,3
	RET
;      85 static void _doScroll()
;      86 {                          
__doScroll_G1:
;      87     delay_ms(1);
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;      88 }          
	RET
;      89 ////////////////////////////////////////////////////////////////////
;      90 // General functions
;      91 //////////////////////////////////////////////////////////////////// 
;      92 #define RESET_WATCHDOG()    #asm("WDR");
;      93                                                                             
;      94 void LoadConfig()
;      95 {
;      96  
;      97 }
;      98                        
;      99 void SaveConfig()
;     100 {                     
;     101 
;     102 }
;     103                
;     104 void SerialToBuffer(BYTE length)
;     105 {        
_SerialToBuffer:
;     106     BYTE i=0;
;     107     for (i=0; i< length; i++){
	ST   -Y,R16
;	length -> Y+1
;	i -> R16
	LDI  R16,0
	LDI  R16,LOW(0)
_0xD:
	LDD  R30,Y+1
	CP   R16,R30
	BRSH _0xE
;     108         buffer[i] = getchar();
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_buffer)
	SBCI R31,HIGH(-_buffer)
	PUSH R31
	PUSH R30
	RCALL _getchar
	POP  R26
	POP  R27
	ST   X,R30
;     109     }               
	SUBI R16,-1
	RJMP _0xD
_0xE:
;     110     
;     111     printf("\r\n");
	__POINTW1FN _0,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     112     for (i=0; i< MAX_DIGIT; i++){  
	LDI  R16,LOW(0)
_0x10:
	CPI  R16,12
	BRSH _0x11
;     113         printf("%02X ",buffer[i]);
	__POINTW1FN _0,3
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_buffer)
	SBCI R31,HIGH(-_buffer)
	LD   R30,Z
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
;     114     }
	SUBI R16,-1
	RJMP _0x10
_0x11:
;     115     printf("\r\n");         
	__POINTW1FN _0,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     116     
;     117 }
	LDD  R16,Y+0
	RJMP _0x87
;     118 
;     119 ///////////////////////////////////////////////////////////////
;     120 // END static function(s)
;     121 ///////////////////////////////////////////////////////////////
;     122 
;     123 ///////////////////////////////////////////////////////////////           
;     124 
;     125 void InitDevice()
;     126 {
_InitDevice:
;     127 // Declare your local variables here
;     128 // Crystal Oscillator division factor: 1  
;     129 #ifdef _MEGA162_INCLUDED_ 
;     130 #pragma optsize-
;     131 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     132 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     133 #ifdef _OPTIMIZE_SIZE_
;     134 #pragma optsize+
;     135 #endif                    
;     136 #endif
;     137 
;     138 PORTA=0x00;
	OUT  0x1B,R30
;     139 DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;     140 
;     141 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
;     142 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
;     143 
;     144 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;     145 DDRC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
;     146 
;     147 PORTD=0xFF;
	OUT  0x12,R30
;     148 DDRD=0x00; 
	LDI  R30,LOW(0)
	OUT  0x11,R30
;     149 
;     150 PORTE=0x00;
	OUT  0x7,R30
;     151 DDRE=0xFF;
	LDI  R30,LOW(255)
	OUT  0x6,R30
;     152 
;     153 // Timer/Counter 0 initialization
;     154 // Clock source: System Clock
;     155 // Clock value: 250.000 kHz
;     156 // Mode: Normal top=FFh
;     157 // OC0 output: Disconnected
;     158 TCCR0=0x03;     // 4 us per tick
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     159 TCNT0=0x05;     // 1ms = 4*250
	LDI  R30,LOW(5)
	OUT  0x32,R30
;     160 OCR0=0x00;      // 255 -250 = TCNT0
	LDI  R30,LOW(0)
	OUT  0x31,R30
;     161 
;     162 #ifdef _MEGA162_INCLUDED_
;     163 UCSR0A=0x00;
	OUT  0xB,R30
;     164 UCSR0B=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     165 UCSR0C=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     166 UBRR0H=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     167 UBRR0L=0x67;      //  16 MHz     
	LDI  R30,LOW(103)
	OUT  0x9,R30
;     168 
;     169 #else // _MEGA8515_INCLUDE_     
;     170 UCSRA=0x00;
;     171 UCSRB=0x98;
;     172 UCSRC=0x86;
;     173 UBRRH=0x00;
;     174 UBRRL=0x67;       // 16 MHz
;     175 #endif
;     176 
;     177 // Lower page wait state(s): None
;     178 // Upper page wait state(s): None
;     179 MCUCR=0x80;
	LDI  R30,LOW(128)
	OUT  0x35,R30
;     180 EMCUCR=0x00;     
	LDI  R30,LOW(0)
	OUT  0x36,R30
;     181 
;     182 // Timer(s)/Counter(s) Interrupt(s) initialization
;     183 TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x39,R30
;     184 ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
;     185 
;     186 // Watchdog Timer initialization
;     187 // Watchdog Timer Prescaler: OSC/2048k     
;     188 #ifdef __WATCH_DOG_
;     189 WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     190 WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     191 #endif
;     192 }
	RET
;     193 
;     194 void PowerReset()
;     195 {      
_PowerReset:
;     196     InitDevice();    
	CALL _InitDevice
;     197     LED_STATUS = 0;  
	CBI  0x18,4
;     198     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     199     LED_STATUS = 1;
	SBI  0x18,4
;     200     delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     201     LED_STATUS = 0;
	CBI  0x18,4
;     202     delay_ms(500);    
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     203     LED_STATUS = 1;
	SBI  0x18,4
;     204                 
;     205     printf("GameShow v1.00 Designed by CuongQuay\r\n");  
	__POINTW1FN _0,9
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     206     printf("cuong3ihut@yahoo.com - 0915651001\r\n");
	__POINTW1FN _0,48
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
;     207     printf("Started on: 06.03.2007\r\n");
	__POINTW1FN _0,84
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
_0x87:
	ADIW R28,2
;     208 }
	RET
;     209 
;     210 void ProcessCommand()
;     211 {
_ProcessCommand:
;     212    	#asm("cli"); 
	cli
;     213     RESET_WATCHDOG();
	WDR
;     214 
;     215     // serial message processing     
;     216     switch (rx_message)
	MOV  R30,R4
;     217     {                  
;     218     case LOAD_DATA_MSG:
	CPI  R30,LOW(0x1)
	BRNE _0x16
;     219         {                
;     220             SerialToBuffer(rx_lparam);    
	ST   -Y,R7
	CALL _SerialToBuffer
;     221         }				
;     222         break;           
;     223     default:
_0x16:
;     224         break;
;     225     }                 
;     226     send_echo_msg();            
	RCALL _send_echo_msg
;     227     rx_message = UNKNOWN_MSG;
	CLR  R4
;     228     #asm("sei");        
	sei
;     229 }           
	RET
;     230 ////////////////////////////////////////////////////////////////////////////////
;     231 // MAIN PROGRAM
;     232 ////////////////////////////////////////////////////////////////////////////////
;     233 void main(void)
;     234 {         
_main:
;     235     if (MCUCSR & 8){
	IN   R30,0x34
	SBRS R30,3
	RJMP _0x17
;     236         // Watchdog Reset
;     237         MCUCSR&=0xE0;  
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     238         reset_serial(); 
	RCALL _reset_serial
;     239     }
;     240     else {      
	RJMP _0x18
_0x17:
;     241         MCUCSR&=0xE0;
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
;     242     }                                     
_0x18:
;     243      
;     244     PowerReset();                        
	CALL _PowerReset
;     245     #asm("sei");     
	sei
;     246 
;     247     while (1){         
_0x19:
;     248         if (rx_message != UNKNOWN_MSG){   
	TST  R4
	BREQ _0x1C
;     249             ProcessCommand();   
	CALL _ProcessCommand
;     250         }
;     251         else{           
	RJMP _0x1D
_0x1C:
;     252             _displayFrame();
	CALL __displayFrame_G1
;     253             _doScroll();            
	CALL __doScroll_G1
;     254         }
_0x1D:
;     255         RESET_WATCHDOG();
	WDR
;     256     };
	JMP  _0x19
;     257 
;     258 }
_0x1E:
	NOP
	RJMP _0x1E
;     259                          
;     260 #include "define.h"
;     261 
;     262 ///////////////////////////////////////////////////////////////
;     263 // serial interrupt handle - processing serial message ...
;     264 ///////////////////////////////////////////////////////////////
;     265 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;     266 ///////////////////////////////////////////////////////////////
;     267 BYTE rx_buffer[RX_BUFFER_SIZE];

	.DSEG
_rx_buffer:
	.BYTE 0x8
;     268 extern BYTE  rx_message;
;     269 extern WORD  rx_wparam;
;     270 extern WORD  rx_lparam;
;     271 
;     272 #if RX_BUFFER_SIZE<256
;     273 unsigned char rx_wr_index,rx_counter;
;     274 #else
;     275 unsigned int rx_wr_index,rx_counter;
;     276 #endif
;     277 
;     278 void send_echo_msg();
;     279 
;     280 // USART Receiver interrupt service routine
;     281 #ifdef _MEGA162_INCLUDED_                    
;     282 interrupt [USART0_RXC] void usart_rx_isr(void)
;     283 #else
;     284 interrupt [USART_RXC] void usart_rx_isr(void)
;     285 #endif
;     286 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     287 char status,data;
;     288 #ifdef _MEGA162_INCLUDED_  
;     289 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;     290 data=UDR0;
	IN   R17,12
;     291 #else     
;     292 status=UCSRA;
;     293 data=UDR;
;     294 #endif          
;     295     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BREQ PC+3
	JMP _0x1F
;     296     {
;     297         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R9
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;     298         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	INC  R9
	LDI  R30,LOW(8)
	CP   R30,R9
	BRNE _0x20
	CLR  R9
;     299         if (++rx_counter == RX_BUFFER_SIZE)
_0x20:
	INC  R10
	LDI  R30,LOW(8)
	CP   R30,R10
	BRNE _0x21
;     300         {
;     301             rx_counter=0;
	CLR  R10
;     302             if (
;     303                 rx_buffer[0]==WAKEUP_CHAR && rx_buffer[1]==WAKEUP_CHAR &&        
;     304                 rx_buffer[2]==WAKEUP_CHAR 
;     305                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0x55)
	BRNE _0x23
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0x55)
	BRNE _0x23
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0x55)
	BREQ _0x24
_0x23:
	RJMP _0x22
_0x24:
;     306             {
;     307                 rx_message  = rx_buffer[3];    // message value 
	__GETBRMN 4,_rx_buffer,3
;     308                 rx_wparam   = rx_buffer[4];    // wparam value
	__GETBRMN 5,_rx_buffer,4
	CLR  R6
;     309                 rx_wparam   = (rx_wparam<<8)|rx_buffer[5]; 
	MOV  R31,R5
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,5
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 5,6
;     310                 rx_lparam   = rx_buffer[6];    // lparam value
	__GETBRMN 7,_rx_buffer,6
	CLR  R8
;     311                 rx_lparam   = (rx_lparam<<8)|rx_buffer[7];                           
	MOV  R31,R7
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _rx_buffer,7
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	__PUTW1R 7,8
;     312             }
;     313             else if(
	RJMP _0x25
_0x22:
;     314                 rx_buffer[0]==ESCAPE_CHAR && rx_buffer[1]==ESCAPE_CHAR &&        
;     315                 rx_buffer[2]==ESCAPE_CHAR 
;     316                 )
	LDS  R26,_rx_buffer
	CPI  R26,LOW(0xFF)
	BRNE _0x27
	__GETB1MN _rx_buffer,1
	CPI  R30,LOW(0xFF)
	BRNE _0x27
	__GETB1MN _rx_buffer,2
	CPI  R30,LOW(0xFF)
	BREQ _0x28
_0x27:
	RJMP _0x26
_0x28:
;     317             {
;     318                 rx_wr_index=0;
	CLR  R9
;     319                 rx_counter =0;
	CLR  R10
;     320             }      
;     321         };
_0x26:
_0x25:
_0x21:
;     322     };
_0x1F:
;     323 }
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     324 
;     325 void send_echo_msg()
;     326 {
_send_echo_msg:
;     327     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     328     putchar(WAKEUP_CHAR);
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     329     putchar(WAKEUP_CHAR);                
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _putchar
;     330     putchar(rx_message);
	ST   -Y,R4
	CALL _putchar
;     331     putchar(rx_wparam>>8);
	MOV  R30,R6
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     332     putchar(rx_wparam&0x00FF);
	__GETW1R 5,6
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     333     putchar(rx_lparam>>8);        
	MOV  R30,R8
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _putchar
;     334     putchar(rx_lparam&0x00FF);
	__GETW1R 7,8
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _putchar
;     335 }  
	RET
;     336 
;     337 void reset_serial()
;     338 {
_reset_serial:
;     339     rx_wr_index=0;
	CLR  R9
;     340     rx_counter =0;
	CLR  R10
;     341     rx_message = UNKNOWN_MSG;
	CLR  R4
;     342 }
	RET
;     343 
;     344 ///////////////////////////////////////////////////////////////
;     345 // END serial interrupt handle
;     346 /////////////////////////////////////////////////////////////// 

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
__put_G3:
	LD   R26,Y
	LDD  R27,Y+1
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x29
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0x2A
_0x29:
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _putchar
_0x2A:
	ADIW R28,3
	RET
__print_G3:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R16,0
_0x2B:
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
	JMP _0x2D
	MOV  R30,R16
	CPI  R30,0
	BRNE _0x31
	CPI  R19,37
	BRNE _0x32
	LDI  R16,LOW(1)
	RJMP _0x33
_0x32:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G3
_0x33:
	RJMP _0x30
_0x31:
	CPI  R30,LOW(0x1)
	BRNE _0x34
	CPI  R19,37
	BRNE _0x35
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G3
	RJMP _0x88
_0x35:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0x36
	LDI  R17,LOW(1)
	RJMP _0x30
_0x36:
	CPI  R19,43
	BRNE _0x37
	LDI  R21,LOW(43)
	RJMP _0x30
_0x37:
	CPI  R19,32
	BRNE _0x38
	LDI  R21,LOW(32)
	RJMP _0x30
_0x38:
	RJMP _0x39
_0x34:
	CPI  R30,LOW(0x2)
	BRNE _0x3A
_0x39:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0x3B
	ORI  R17,LOW(128)
	RJMP _0x30
_0x3B:
	RJMP _0x3C
_0x3A:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x30
_0x3C:
	CPI  R19,48
	BRLO _0x3F
	CPI  R19,58
	BRLO _0x40
_0x3F:
	RJMP _0x3E
_0x40:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x30
_0x3E:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0x44
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
	RCALL __put_G3
	RJMP _0x45
_0x44:
	CPI  R30,LOW(0x73)
	BRNE _0x47
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
	RJMP _0x48
_0x47:
	CPI  R30,LOW(0x70)
	BRNE _0x4A
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
_0x48:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0x4B
_0x4A:
	CPI  R30,LOW(0x64)
	BREQ _0x4E
	CPI  R30,LOW(0x69)
	BRNE _0x4F
_0x4E:
	ORI  R17,LOW(4)
	RJMP _0x50
_0x4F:
	CPI  R30,LOW(0x75)
	BRNE _0x51
_0x50:
	LDI  R30,LOW(_tbl10_G3*2)
	LDI  R31,HIGH(_tbl10_G3*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0x52
_0x51:
	CPI  R30,LOW(0x58)
	BRNE _0x54
	ORI  R17,LOW(8)
	RJMP _0x55
_0x54:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x86
_0x55:
	LDI  R30,LOW(_tbl16_G3*2)
	LDI  R31,HIGH(_tbl16_G3*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0x52:
	SBRS R17,2
	RJMP _0x57
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
	BRGE _0x58
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0x58:
	CPI  R21,0
	BREQ _0x59
	SUBI R16,-LOW(1)
	RJMP _0x5A
_0x59:
	ANDI R17,LOW(251)
_0x5A:
	RJMP _0x5B
_0x57:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0x5B:
_0x4B:
	SBRC R17,0
	RJMP _0x5C
_0x5D:
	CP   R16,R20
	BRSH _0x5F
	SBRS R17,7
	RJMP _0x60
	SBRS R17,2
	RJMP _0x61
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0x62
_0x61:
	LDI  R19,LOW(48)
_0x62:
	RJMP _0x63
_0x60:
	LDI  R19,LOW(32)
_0x63:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G3
	SUBI R20,LOW(1)
	RJMP _0x5D
_0x5F:
_0x5C:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0x64
_0x65:
	CPI  R18,0
	BREQ _0x67
	SBRS R17,3
	RJMP _0x68
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x89
_0x68:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x89:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G3
	CPI  R20,0
	BREQ _0x6A
	SUBI R20,LOW(1)
_0x6A:
	SUBI R18,LOW(1)
	RJMP _0x65
_0x67:
	RJMP _0x6B
_0x64:
_0x6D:
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
_0x6F:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x71
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x6F
_0x71:
	CPI  R19,58
	BRLO _0x72
	SBRS R17,3
	RJMP _0x73
	SUBI R19,-LOW(7)
	RJMP _0x74
_0x73:
	SUBI R19,-LOW(39)
_0x74:
_0x72:
	SBRC R17,4
	RJMP _0x76
	CPI  R19,49
	BRSH _0x78
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x77
_0x78:
	RJMP _0x8A
_0x77:
	CP   R20,R18
	BRLO _0x7C
	SBRS R17,0
	RJMP _0x7D
_0x7C:
	RJMP _0x7B
_0x7D:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0x7E
	LDI  R19,LOW(48)
_0x8A:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0x7F
	ANDI R17,LOW(251)
	ST   -Y,R21
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G3
	CPI  R20,0
	BREQ _0x80
	SUBI R20,LOW(1)
_0x80:
_0x7F:
_0x7E:
_0x76:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G3
	CPI  R20,0
	BREQ _0x81
	SUBI R20,LOW(1)
_0x81:
_0x7B:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x6E
	RJMP _0x6D
_0x6E:
_0x6B:
	SBRS R17,0
	RJMP _0x82
_0x83:
	CPI  R20,0
	BREQ _0x85
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RCALL __put_G3
	RJMP _0x83
_0x85:
_0x82:
_0x86:
_0x45:
_0x88:
	LDI  R16,LOW(0)
_0x30:
	RJMP _0x2B
_0x2D:
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
	RCALL __print_G3
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	POP  R15
	RET

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

;END OF CODE MARKER
__END_OF_CODE:
