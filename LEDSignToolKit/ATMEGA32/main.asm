
;CodeVisionAVR C Compiler V1.25.9 Professional
;(C) Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega32
;Program type           : Boot Loader
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : Yes
;Word align FLASH struct: No
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega32
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
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
	.EQU MCUCR=0x35
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
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	LDI  R23,BYTE4(2*@0+@1)
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
	.ORG 0x3800

	.INCLUDE "main.vec"
	.INCLUDE "main.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF THE BOOT LOADER
	LDI  R31,1
	OUT  GICR,R31
	LDI  R31,2
	OUT  GICR,R31
	OUT  MCUCR,R30

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
	LDI  R24,LOW(0x800)
	LDI  R25,HIGH(0x800)
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
	LDI  R30,LOW(0x85F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x85F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x260)
	LDI  R29,HIGH(0x260)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260
;       1 /*****************************************************
;       2 This program was produced by the
;       3 CodeWizardAVR V1.25.9 Professional
;       4 Automatic Program Generator
;       5 © Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;       6 http://www.hpinfotech.com
;       7 
;       8 Project :
;       9 Version :
;      10 Date    : 11/17/2009
;      11 Author  : CuongQuay
;      12 Company : HOME
;      13 Comments:
;      14 
;      15 
;      16 Chip type           : ATmega32
;      17 Program type        : Boot Loader - Size:2048words
;      18 Clock frequency     : 8.000000 MHz
;      19 Memory model        : Small
;      20 External SRAM size  : 0
;      21 Data Stack size     : 512
;      22 *****************************************************/
;      23 
;      24 #include <stdio.h>
;      25 #include <delay.h>
;      26 #include <mega32.h>
;      27 	#ifndef __SLEEP_DEFINED__
	#ifndef __SLEEP_DEFINED__
;      28 	#define __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
;      29 	.EQU __se_bit=0x80
	.EQU __se_bit=0x80
;      30 	.EQU __sm_mask=0x70
	.EQU __sm_mask=0x70
;      31 	.EQU __sm_powerdown=0x20
	.EQU __sm_powerdown=0x20
;      32 	.EQU __sm_powersave=0x30
	.EQU __sm_powersave=0x30
;      33 	.EQU __sm_standby=0x60
	.EQU __sm_standby=0x60
;      34 	.EQU __sm_ext_standby=0x70
	.EQU __sm_ext_standby=0x70
;      35 	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_adc_noise_red=0x10
;      36 	.SET power_ctrl_reg=mcucr
	.SET power_ctrl_reg=mcucr
;      37 	#endif
	#endif
;      38 
;      39 #include "bootloader.h"
;      40 
;      41 // Declare your global variables here
;      42 void Initialize()
;      43 {

	.CSEG
_Initialize:
;      44     PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;      45     DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;      46     PORTB=0xF0;
	LDI  R30,LOW(240)
	OUT  0x18,R30
;      47     DDRB=0x0F;
	LDI  R30,LOW(15)
	OUT  0x17,R30
;      48     PORTC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x15,R30
;      49     DDRC=0xFF;
	OUT  0x14,R30
;      50     PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;      51     DDRD=0xF8;
	LDI  R30,LOW(248)
	OUT  0x11,R30
;      52 
;      53     GICR|=0x40;
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
;      54     MCUCR=0x03;
	LDI  R30,LOW(3)
	OUT  0x35,R30
;      55     MCUCSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x34,R30
;      56     GIFR=0x40;
	LDI  R30,LOW(64)
	OUT  0x3A,R30
;      57 
;      58     TIMSK=0x00;
	LDI  R30,LOW(0)
	OUT  0x39,R30
;      59 
;      60     UCSRA=0x00;
	OUT  0xB,R30
;      61     UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;      62     UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;      63     UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;      64     UBRRL=0x2F;
	LDI  R30,LOW(47)
	OUT  0x9,R30
;      65     UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
;      66 
;      67     ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;      68     SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
;      69 
;      70     OSCCAL=0xAD;
	LDI  R30,LOW(173)
	OUT  0x31,R30
;      71 
;      72     if (1){
;      73         printf("                                          \r\n");
	__POINTW1FN _0,0
	CALL SUBOPT_0x0
;      74         printf("|=========================================|\r\n");
	__POINTW1FN _0,45
	CALL SUBOPT_0x0
;      75         printf("|       LEDSign AVR Firmware v2.0.0       |\r\n");
	__POINTW1FN _0,91
	CALL SUBOPT_0x0
;      76         printf("|_________________________________________|\r\n");
	__POINTW1FN _0,137
	CALL SUBOPT_0x0
;      77     }
;      78 }
	RET
;      79 
;      80 extern BYTE ubPageBuffer[];
;      81 
;      82 void GetDataFromHost()
;      83 {
_GetDataFromHost:
;      84     WORD wFlashAddr = 0xFFFF;
;      85 
;      86     while (1)
	ST   -Y,R17
	ST   -Y,R16
;	wFlashAddr -> R16,R17
	LDI  R16,255
	LDI  R17,255
_0x4:
;      87     {
;      88         wFlashAddr = getchar() & 0x0F;     // get MSB address
	CALL _getchar
	ANDI R30,LOW(0xF)
	MOV  R16,R30
	CLR  R17
;      89         wFlashAddr = wFlashAddr<<8; // store into word
	MOV  R17,R16
	CLR  R16
;      90         wFlashAddr |= getchar() & 0x0F;    // get LSB address
	CALL _getchar
	ANDI R30,LOW(0xF)
	LDI  R31,0
	__ORWRR 16,17,30,31
;      91         printf("ADDRESS: %0004X", wFlashAddr);
	__POINTW1FN _0,183
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R16
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x1
;      92 
;      93         if (wFlashAddr == 0xFFFF)
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	CP   R30,R16
	CPC  R31,R17
	BREQ _0x6
;      94             break;
;      95 
;      96         if (GetPageBuffer())
	CALL _GetPageBuffer
	CPI  R30,0
	BREQ _0x8
;      97         {
;      98             int i =0;
;      99             for (i=0; i<128; i++)
	SBIW R28,2
	LDI  R24,2
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x9*2)
	LDI  R31,HIGH(_0x9*2)
	CALL __INITLOCB
;	i -> Y+0
	LDI  R30,0
	STD  Y+0,R30
	STD  Y+0+1,R30
_0xB:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x80)
	LDI  R30,HIGH(0x80)
	CPC  R27,R30
	BRGE _0xC
;     100             {
;     101                 printf("%02X ",ubPageBuffer[i]);
	__POINTW1FN _0,199
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SUBI R30,LOW(-_ubPageBuffer)
	SBCI R31,HIGH(-_ubPageBuffer)
	LD   R30,Z
	CLR  R31
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x1
;     102             }
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,1
	ST   Y,R30
	STD  Y+1,R31
	RJMP _0xB
_0xC:
;     103             FLWritePage(wFlashAddr);
	ST   -Y,R17
	ST   -Y,R16
	CALL _FLWritePage
;     104             if (FLCheckPage())
	CALL _FLCheckPage
	CPI  R30,0
	BREQ _0xD
;     105             {
;     106                 printf("Write successful");
	__POINTW1FN _0,205
	CALL SUBOPT_0x0
;     107             }
;     108         }
_0xD:
	ADIW R28,2
;     109     }
_0x8:
	RJMP _0x4
_0x6:
;     110 }
	LD   R16,Y+
	LD   R17,Y+
	RET
;     111 
;     112 void SendToDisplay()
;     113 {
;     114     BYTE ubTempData;
;     115     WORD wTempData = 0;
;     116     WORD wCurrentAddr = 0;
;     117     WORD wNumOfRow = 0;
;     118     WORD wNumOfPage = 0;
;     119 
;     120     wNumOfRow = FLReadWord(wCurrentAddr++);
;	ubTempData -> R17
;	wTempData -> R18,R19
;	wCurrentAddr -> R20,R21
;	wNumOfRow -> Y+8
;	wNumOfPage -> Y+6
;     121     wCurrentAddr++;//wNumOfCol = FLReadWord(wCurrentAddr++);
;     122     wNumOfPage = FLReadWord(wCurrentAddr++);
;     123 
;     124     while (1)
;     125     {
;     126         wTempData = FLReadWord(wCurrentAddr++);
;     127         delay_ms(wTempData);
;     128         wTempData = FLReadWord(wCurrentAddr++);
;     129 
;     130         ubTempData = wTempData & 0x00FF;
;     131 
;     132         PORTC.5 = (ubTempData&0x01)>>0;
;     133         PORTC.4 = (ubTempData&0x02)>>1;
;     134         PORTC.3 = (ubTempData&0x04)>>2;
;     135         PORTC.2 = (ubTempData&0x08)>>3;
;     136         PORTC.1 = (ubTempData&0x10)>>4;
;     137         PORTC.0 = (ubTempData&0x20)>>5;
;     138         PORTB.5 = (ubTempData&0x40)>>6;
;     139         PORTB.4 = (ubTempData&0x80)>>7;
;     140 
;     141         ubTempData = wTempData >> 8;
;     142 
;     143         PORTB.3 = (ubTempData&0x01)>>0;
;     144         PORTB.2 = (ubTempData&0x02)>>1;
;     145         PORTB.1 = (ubTempData&0x04)>>2;
;     146         PORTB.0 = (ubTempData&0x08)>>3;
;     147         PORTD.7 = (ubTempData&0x10)>>4;
;     148         PORTB.7 = (ubTempData&0x20)>>5;
;     149         PORTD.5 = (ubTempData&0x40)>>6;
;     150         PORTD.6 = (ubTempData&0x80)>>7;
;     151 
;     152         if (++wCurrentAddr > 2*wNumOfRow*wNumOfPage)
;     153         {
;     154             wCurrentAddr = 0;
;     155         }
;     156     }
;     157 }
;     158 
;     159 void main(void)
;     160 {
_main:
;     161     Initialize();
	CALL _Initialize
;     162     GetDataFromHost();
	CALL _GetDataFromHost
;     163 }
_0x33:
	RJMP _0x33
;     164 
;     165 #pragma promotechar+
;     166 #pragma uchar+
;     167 #pragma regalloc-
;     168 #pragma optsize+
;     169 
;     170 #include <stdio.h>
;     171 #include "bootloader.h"
;     172 	#ifndef __SLEEP_DEFINED__
	#ifndef __SLEEP_DEFINED__
;     173 	#define __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
;     174 	.EQU __se_bit=0x80
	.EQU __se_bit=0x80
;     175 	.EQU __sm_mask=0x70
	.EQU __sm_mask=0x70
;     176 	.EQU __sm_powerdown=0x20
	.EQU __sm_powerdown=0x20
;     177 	.EQU __sm_powersave=0x30
	.EQU __sm_powersave=0x30
;     178 	.EQU __sm_standby=0x60
	.EQU __sm_standby=0x60
;     179 	.EQU __sm_ext_standby=0x70
	.EQU __sm_ext_standby=0x70
;     180 	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_adc_noise_red=0x10
;     181 	.SET power_ctrl_reg=mcucr
	.SET power_ctrl_reg=mcucr
;     182 	#endif
	#endif
;     183 
;     184 #ifdef _CHIP_ATMEGA8_
;     185 #define PAGE_SIZE   64               // 64 bytes per page
;     186 #define PAGE_SHFL   6                // 2^6 = 64 bytes
;     187 #endif
;     188 
;     189 #ifdef _CHIP_ATMEGA32_
;     190 #define  PAGE_SIZE 	 128            // 128 Bytes
;     191 #define  PAGE_SHFL  7               // 2^7 = 128 bytes
;     192 #endif
;     193 
;     194 #asm(".EQU SPMCRAddr=0x57")          // SPMCR address definition
	.EQU SPMCRAddr=0x57
;     195 
;     196 register WORD wPageData @2;          // PageData at R2-R3
;     197 register WORD wPageAddress @4;       // PageAddress at R4-R5
;     198 register WORD wCurrentAddress @6;    // Current address of the current data -  PageAddress + loop counter
;     199 register BYTE ubSPMCRF @10;          // store SMPCR function at R10
;     200 
;     201 register unsigned int i @11;         //  loop counter at R11-R12
;     202 register unsigned int j @13;         //  loop counter at R13-R14
;     203 
;     204 BYTE ubPageBuffer[PAGE_SIZE];

	.DSEG
_ubPageBuffer:
	.BYTE 0x80
;     205 
;     206 BOOL GetPageBuffer(void)
;     207 {

	.CSEG
_GetPageBuffer:
;     208     //char localCheckSum = 0;
;     209     //char receivedCheckSum = 0;
;     210     for (j=0; j<PAGE_SIZE; j++)
	CLR  R13
	CLR  R14
_0x35:
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	CP   R13,R30
	CPC  R14,R31
	BRSH _0x36
;     211     {
;     212         ubPageBuffer[j]=getchar();
	__GETW1R 13,14
	SUBI R30,LOW(-_ubPageBuffer)
	SBCI R31,HIGH(-_ubPageBuffer)
	PUSH R31
	PUSH R30
	CALL _getchar
	POP  R26
	POP  R27
	ST   X,R30
;     213     //    localCheckSum += ubPageBuffer[j];
;     214     }
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 13,14,30,31
	RJMP _0x35
_0x36:
;     215     //    receivedCheckSum = getchar();
;     216     return TRUE; //(localCheckSum == receivedCheckSum)?TRUE:FALSE;
	LDI  R30,LOW(1)
	RET
;     217 }
;     218 
;     219 // CVAVR compiler allocate [address] @ R30-R31
;     220 // Return to @ R30-R31 for [WORD] in flash result
;     221 WORD FLReadWord(unsigned int address)
;     222 {
;     223     wCurrentAddress = address;
;	address -> Y+0
;     224 
;     225 #if defined _CHIP_ATMEGA128_
;     226     #asm
;     227     movw r30, r6        ;//move  CurrentAddress to Z pointer
;     228     elpm r2, Z+         ;//read LSB
;     229     elpm r3, Z          ;//read MSB
;     230     #endasm
;     231 #else
;     232     #asm
;     233     movw r30, r6        ;//move  CurrentAddress to Z pointer
;     234     lpm r2, Z+          ;//read LSB
;     235     lpm r3, Z           ;//read MSB
;     236     #endasm
;     237 #endif
;     238     return (ubPageBuffer[j] +(ubPageBuffer[j+1]<<8));
;     239 }
;     240 
;     241 BOOL FLCheckPage(void)
;     242 {
_FLCheckPage:
;     243     WORD wCheckData = 0xFFFF;
;     244     for (j=0; j<PAGE_SIZE; j+=2)
	ST   -Y,R17
	ST   -Y,R16
;	wCheckData -> R16,R17
	LDI  R16,255
	LDI  R17,255
	CLR  R13
	CLR  R14
_0x38:
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	CP   R13,R30
	CPC  R14,R31
	BRLO PC+3
	JMP _0x39
;     245     {
;     246         wCurrentAddress=wPageAddress+j;
	__GETW1R 13,14
	ADD  R30,R4
	ADC  R31,R5
	MOVW R6,R30
;     247     #if defined _CHIP_ATMEGA128_
;     248         #asm
;     249         movw r30, r6        ;//move  CurrentAddress to Z pointer
;     250         elpm r2, Z+         ;//read LSB
;     251         elpm r3, Z          ;//read MSB
;     252         #endasm
;     253     #else
;     254         #asm
;     255         movw r30, r6        ;//move  CurrentAddress to Z pointer
        movw r30, r6        ;//move  CurrentAddress to Z pointer  
;     256         lpm r2, Z+          ;//read LSB
        lpm r2, Z+          ;//read LSB
;     257         lpm r3, Z           ;//read MSB
        lpm r3, Z           ;//read MSB
;     258         #endasm
;     259     #endif
;     260         wCheckData = ubPageBuffer[j] +(ubPageBuffer[j+1]<<8);
	LDI  R26,LOW(_ubPageBuffer)
	LDI  R27,HIGH(_ubPageBuffer)
	ADD  R26,R13
	ADC  R27,R14
	LD   R26,X
	CLR  R27
	__GETW1R 13,14
	CALL SUBOPT_0x2
	MOVW R16,R30
;     261         if (wPageData != wCheckData)
	__CPWRR 16,17,2,3
	BREQ _0x3A
;     262             return FALSE;
	LDI  R30,LOW(0)
	RJMP _0x108
;     263     }
_0x3A:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	__ADDWRR 13,14,30,31
	JMP  _0x38
_0x39:
;     264     return TRUE;
	LDI  R30,LOW(1)
_0x108:
	LD   R16,Y+
	LD   R17,Y+
	RET
;     265 }
;     266 
;     267 void FLWritePage(unsigned int address)
;     268 {
_FLWritePage:
;     269     wPageAddress = address;
;	address -> Y+0
	__GETWRS 4,5,0
;     270 
;     271     #if defined _CHIP_ATMEGA128_
;     272     if (wPageAddress >> 8) RAMPZ =  1;
;     273     else RAMPZ=0;
;     274     #endif
;     275 
;     276     wPageAddress = wPageAddress << PAGE_SHFL;       // get next address = PageAddress* PAGE_SIZE
	MOVW R26,R4
	LDI  R30,LOW(7)
	CALL __LSLW12
	MOVW R4,R30
;     277 
;     278     for (i=0; i<PAGE_SIZE; i+=2)                    // fill temporary buffer in 2 byte chunks from PageBuffer
	CLR  R11
	CLR  R12
_0x3C:
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	CP   R11,R30
	CPC  R12,R31
	BRLO PC+3
	JMP _0x3D
;     279     {
;     280         wPageData=ubPageBuffer[i]+(ubPageBuffer[i+1]<<8);
	LDI  R26,LOW(_ubPageBuffer)
	LDI  R27,HIGH(_ubPageBuffer)
	ADD  R26,R11
	ADC  R27,R12
	LD   R26,X
	CLR  R27
	__GETW1R 11,12
	CALL SUBOPT_0x2
	MOVW R2,R30
;     281         wCurrentAddress=wPageAddress+i;
	__GETW1R 11,12
	ADD  R30,R4
	ADC  R31,R5
	MOVW R6,R30
;     282 
;     283         while (SPMCR&1);        //wait for spm complete
_0x3E:
	IN   R30,0x37
	SBRC R30,0
	RJMP _0x3E
;     284         ubSPMCRF=0x01;          //fill buffer page
	LDI  R30,LOW(1)
	MOV  R10,R30
;     285         #asm
;     286             movw r30, r6        ;//move CurrentAddress to Z pointer
            movw r30, r6        ;//move CurrentAddress to Z pointer   
;     287             mov r1, r3          ;//move Pagedata MSB reg 1
            mov r1, r3          ;//move Pagedata MSB reg 1
;     288             mov r0, r2          ;//move Pagedata LSB reg 1
            mov r0, r2          ;//move Pagedata LSB reg 1                
;     289             sts SPMCRAddr, r10  ;//move ubSPMCRF to SPM control register
            sts SPMCRAddr, r10  ;//move ubSPMCRF to SPM control register
;     290             spm                 ;//store program memory
            spm                 ;//store program memory
;     291         #endasm
;     292     }
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	__ADDWRR 11,12,30,31
	JMP  _0x3C
_0x3D:
;     293 
;     294     while (SPMCR&1);            //wait for spm complete
_0x41:
	IN   R30,0x37
	SBRC R30,0
	RJMP _0x41
;     295     ubSPMCRF=0x03;              //erase page
	LDI  R30,LOW(3)
	MOV  R10,R30
;     296     #asm
;     297     movw r30, r4                ;//move PageAddress to Z pointer
    movw r30, r4                ;//move PageAddress to Z pointer
;     298     sts SPMCRAddr, r10          ;//move ubSPMCRF to SPM control register
    sts SPMCRAddr, r10          ;//move ubSPMCRF to SPM control register              
;     299     spm                         ;//erase page
    spm                         ;//erase page
;     300     #endasm
;     301 
;     302     while (SPMCR&1);            //wait for spm complete
_0x44:
	IN   R30,0x37
	SBRC R30,0
	RJMP _0x44
;     303     ubSPMCRF=0x05;              //write page
	LDI  R30,LOW(5)
	MOV  R10,R30
;     304     #asm
;     305     movw r30, r4                ;//move PageAddress to Z pointer
    movw r30, r4                ;//move PageAddress to Z pointer
;     306     sts SPMCRAddr, r10          ;//move ubSPMCRF to SPM control register
    sts SPMCRAddr, r10          ;//move ubSPMCRF to SPM control register              
;     307     spm                         ;//write page
    spm                         ;//write page
;     308     #endasm
;     309 
;     310     while (SPMCR&1);            //wait for spm complete
_0x47:
	IN   R30,0x37
	SBRC R30,0
	RJMP _0x47
;     311     ubSPMCRF=0x11;              //enableRWW  see mega8 datasheet for explanation
	LDI  R30,LOW(17)
	MOV  R10,R30
;     312 
;     313     // P. 212 Section "Prevent reading the RWW section
;     314     // during self-programming
;     315     #asm
;     316     sts SPMCRAddr, r10          ;//move ubSPMCRF to SPMCR
    sts SPMCRAddr, r10          ;//move ubSPMCRF to SPMCR              
;     317     spm
    spm   
;     318     #endasm
;     319 }
	ADIW R28,2
	RET

	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
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
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x57
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x59
	__CPWRN 16,17,2
	BRLO _0x5A
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	ST   X+,R30
	ST   X,R31
_0x59:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+6
	STD  Z+0,R26
_0x5A:
	RJMP _0x5B
_0x57:
	LDD  R30,Y+6
	ST   -Y,R30
	CALL _putchar
_0x5B:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,7
	RET
__print_G3:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
_0x5C:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x5E
	MOV  R30,R17
	LDI  R31,0
	SBIW R30,0
	BRNE _0x62
	CPI  R18,37
	BRNE _0x63
	LDI  R17,LOW(1)
	RJMP _0x64
_0x63:
	CALL SUBOPT_0x3
_0x64:
	RJMP _0x61
_0x62:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x65
	CPI  R18,37
	BRNE _0x66
	CALL SUBOPT_0x3
	RJMP _0x109
_0x66:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x67
	LDI  R16,LOW(1)
	RJMP _0x61
_0x67:
	CPI  R18,43
	BRNE _0x68
	LDI  R20,LOW(43)
	RJMP _0x61
_0x68:
	CPI  R18,32
	BRNE _0x69
	LDI  R20,LOW(32)
	RJMP _0x61
_0x69:
	RJMP _0x6A
_0x65:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x6B
_0x6A:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x6C
	ORI  R16,LOW(128)
	RJMP _0x61
_0x6C:
	RJMP _0x6D
_0x6B:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x61
_0x6D:
	CPI  R18,48
	BRLO _0x70
	CPI  R18,58
	BRLO _0x71
_0x70:
	RJMP _0x6F
_0x71:
	MOV  R26,R21
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R21,R30
	MOV  R30,R18
	SUBI R30,LOW(48)
	LDI  R31,0
	ADD  R21,R30
	RJMP _0x61
_0x6F:
	MOV  R30,R18
	LDI  R31,0
	CPI  R30,LOW(0x63)
	LDI  R26,HIGH(0x63)
	CPC  R31,R26
	BRNE _0x75
	CALL SUBOPT_0x4
	LD   R30,X
	CALL SUBOPT_0x5
	RJMP _0x76
_0x75:
	CPI  R30,LOW(0x73)
	LDI  R26,HIGH(0x73)
	CPC  R31,R26
	BRNE _0x78
	CALL SUBOPT_0x4
	CALL SUBOPT_0x6
	CALL _strlen
	MOV  R17,R30
	RJMP _0x79
_0x78:
	CPI  R30,LOW(0x70)
	LDI  R26,HIGH(0x70)
	CPC  R31,R26
	BRNE _0x7B
	CALL SUBOPT_0x4
	CALL SUBOPT_0x6
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x79:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x7C
_0x7B:
	CPI  R30,LOW(0x64)
	LDI  R26,HIGH(0x64)
	CPC  R31,R26
	BREQ _0x7F
	CPI  R30,LOW(0x69)
	LDI  R26,HIGH(0x69)
	CPC  R31,R26
	BRNE _0x80
_0x7F:
	ORI  R16,LOW(4)
	RJMP _0x81
_0x80:
	CPI  R30,LOW(0x75)
	LDI  R26,HIGH(0x75)
	CPC  R31,R26
	BRNE _0x82
_0x81:
	LDI  R30,LOW(_tbl10_G3*2)
	LDI  R31,HIGH(_tbl10_G3*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x83
_0x82:
	CPI  R30,LOW(0x58)
	LDI  R26,HIGH(0x58)
	CPC  R31,R26
	BRNE _0x85
	ORI  R16,LOW(8)
	RJMP _0x86
_0x85:
	CPI  R30,LOW(0x78)
	LDI  R26,HIGH(0x78)
	CPC  R31,R26
	BREQ PC+3
	JMP _0xB7
_0x86:
	LDI  R30,LOW(_tbl16_G3*2)
	LDI  R31,HIGH(_tbl16_G3*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x83:
	SBRS R16,2
	RJMP _0x88
	CALL SUBOPT_0x4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	SBIW R26,0
	BRGE _0x89
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x89:
	CPI  R20,0
	BREQ _0x8A
	SUBI R17,-LOW(1)
	RJMP _0x8B
_0x8A:
	ANDI R16,LOW(251)
_0x8B:
	RJMP _0x8C
_0x88:
	CALL SUBOPT_0x4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0x8C:
_0x7C:
	SBRC R16,0
	RJMP _0x8D
_0x8E:
	CP   R17,R21
	BRSH _0x90
	SBRS R16,7
	RJMP _0x91
	SBRS R16,2
	RJMP _0x92
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x93
_0x92:
	LDI  R18,LOW(48)
_0x93:
	RJMP _0x94
_0x91:
	LDI  R18,LOW(32)
_0x94:
	CALL SUBOPT_0x3
	SUBI R21,LOW(1)
	RJMP _0x8E
_0x90:
_0x8D:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x95
_0x96:
	CPI  R19,0
	BREQ _0x98
	SBRS R16,3
	RJMP _0x99
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x10A
_0x99:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x10A:
	ST   -Y,R30
	CALL SUBOPT_0x7
	CPI  R21,0
	BREQ _0x9B
	SUBI R21,LOW(1)
_0x9B:
	SUBI R19,LOW(1)
	RJMP _0x96
_0x98:
	RJMP _0x9C
_0x95:
_0x9E:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,2
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
_0xA0:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0xA2
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0xA0
_0xA2:
	CPI  R18,58
	BRLO _0xA3
	SBRS R16,3
	RJMP _0xA4
	SUBI R18,-LOW(7)
	RJMP _0xA5
_0xA4:
	SUBI R18,-LOW(39)
_0xA5:
_0xA3:
	SBRC R16,4
	RJMP _0xA7
	CPI  R18,49
	BRSH _0xA9
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0xA8
_0xA9:
	RJMP _0x10B
_0xA8:
	CP   R21,R19
	BRLO _0xAD
	SBRS R16,0
	RJMP _0xAE
_0xAD:
	RJMP _0xAC
_0xAE:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0xAF
	LDI  R18,LOW(48)
_0x10B:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0xB0
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x7
	CPI  R21,0
	BREQ _0xB1
	SUBI R21,LOW(1)
_0xB1:
_0xB0:
_0xAF:
_0xA7:
	CALL SUBOPT_0x3
	CPI  R21,0
	BREQ _0xB2
	SUBI R21,LOW(1)
_0xB2:
_0xAC:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x9F
	RJMP _0x9E
_0x9F:
_0x9C:
	SBRS R16,0
	RJMP _0xB3
_0xB4:
	CPI  R21,0
	BREQ _0xB6
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	CALL SUBOPT_0x5
	RJMP _0xB4
_0xB6:
_0xB3:
_0xB7:
_0x76:
_0x109:
	LDI  R17,LOW(0)
_0x61:
	RJMP _0x5C
_0x5E:
	CALL __LOADLOCR6
	ADIW R28,20
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
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	CALL __print_G3
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
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
    lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret

	.DSEG
_p_S4B:
	.BYTE 0x2

	.CSEG

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x0:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	CALL __PUTPARD1
	LDI  R24,4
	CALL _printf
	ADIW R28,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	__ADDW1MN _ubPageBuffer,1
	LD   R31,Z
	LDI  R30,LOW(0)
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:24 WORDS
SUBOPT_0x3:
	ST   -Y,R18
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,15
	ST   -Y,R31
	ST   -Y,R30
	JMP  __put_G3

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x4:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	SBIW R26,4
	STD  Y+16,R26
	STD  Y+16+1,R27
	ADIW R26,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x5:
	ST   -Y,R30
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,15
	ST   -Y,R31
	ST   -Y,R30
	JMP  __put_G3

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6:
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7:
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,15
	ST   -Y,R31
	ST   -Y,R30
	JMP  __put_G3

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
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
	NEG  R31
	NEG  R30
	SBCI R31,0
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
