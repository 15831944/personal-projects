
;CodeVisionAVR C Compiler V1.25.2 Standard
;(C) Copyright 1998-2006 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega32
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 200 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : Yes
;Word align FLASH struct: No
;Enhanced core instructions    : On
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

	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70

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
	LDI  R28,LOW(0x128)
	LDI  R29,HIGH(0x128)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x128
;       1 /*****************************************************
;       2 This program was produced by the
;       3 CodeWizardAVR V1.24.8d Standard
;       4 Automatic Program Generator
;       5 © Copyright 1998-2006 Pavel Haiduc, HP InfoTech s.r.l.
;       6 http://www.hpinfotech.com
;       7 
;       8 Project : 
;       9 Version : 
;      10 Date    : 11/14/2006
;      11 Author  : Duong Dinh Cuong                
;      12 Company : Elcom Tech Center - ELCOM JSC   
;      13 Comments: 
;      14 
;      15 
;      16 Chip type           : ATmega32
;      17 Program type        : Application
;      18 Clock frequency     : 7.372800 MHz
;      19 Memory model        : Small
;      20 External SRAM size  : 0
;      21 Data Stack size     : 512
;      22 *****************************************************/
;      23 
;      24 #include "define.h"                 
;      25 #include "ethernet.h"    
;      26 
;      27 struct MAC_ADDRESS eth_mac_addr = {0x00,0x31,0x32,0x33,0x34,0x35};  
_eth_mac_addr:
_0eth_mac_addr:
	.BYTE 0x6
;      28 struct MAC_ADDRESS eth_src_addr = {0x00,0x00,0x00,0x00,0x00,0x00};
_eth_src_addr:
_0eth_src_addr:
	.BYTE 0x6
;      29 
;      30 unsigned char netBuffer[RTL8019_BUFSIZE];   
_netBuffer:
	.BYTE 0x5DC
;      31 unsigned char* netAppData = netBuffer;
_netAppData:
	.BYTE 0x2
;      32 unsigned int HOST_ADDRESS[2] ={ HTONS((NET_IPADDR0 << 8) | NET_IPADDR1), 
_HOST_ADDRESS:
;      33                                 HTONS((NET_IPADDR2 << 8) | NET_IPADDR3) };
	.BYTE 0x4
;      34 unsigned int SERVER_ADDRESS[2] ={ HTONS((SRV_IPADDR0 << 8) | SRV_IPADDR1), 
_SERVER_ADDRESS:
;      35                                 HTONS((SRV_IPADDR2 << 8) | SRV_IPADDR3) };       
	.BYTE 0x4
;      36 unsigned int SUBNET_MASK[2] ={HTONS(0xFFFF),HTONS(0xFF00)};                                
_SUBNET_MASK:
	.BYTE 0x4
;      37 unsigned int SERVER_PORT = 1980;
;      38 unsigned int CLIENT_PORT = 2201;
;      39                              
;      40 static unsigned int udp_id_num =0;
_udp_id_num_G1:
	.BYTE 0x2
;      41 
;      42 BYTE  rx_buffer[RX_BUFFER_SIZE];
_rx_buffer:
	.BYTE 0x8
;      43 BYTE  rx_message = UNKNOWN_MSG;
;      44 WORD  rx_wparam  = 0;
;      45 WORD  rx_lparam  = 0;
;      46 
;      47 extern void reset_serial();         
;      48 extern void send_echo_msg();  
;      49                                 
;      50 extern unsigned int ip_chksum(void);
;      51 extern unsigned int udp_chksum(void);
;      52 extern unsigned int process_arp_in(void);
;      53 extern unsigned int process_arp_out(void);
;      54 extern unsigned int process_ip_in(unsigned int rcv_len);
;      55 extern unsigned int nic_poll(unsigned char* buffer);    
;      56 extern void nic_send(unsigned char* buffer, unsigned int len);
;      57 
;      58 extern BYTE eeprom_read(BYTE deviceID, PBYTE address);
;      59 extern void eeprom_write(BYTE deviceID, PBYTE address, BYTE data);
;      60 extern WORD eeprom_read_w(BYTE deviceID, PBYTE address);
;      61 extern void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data);
;      62                                                 
;      63 #define RESET_WATCHDOG()    #asm("WDR");
;      64 
;      65 // External Interrupt 0 service routine
;      66 interrupt [EXT_INT0] void ext_int0_isr(void)
;      67 {   

	.CSEG
_ext_int0_isr:
;      68 #ifdef _USE_INTERRUPT
;      69     rtl8019ProcessInterrupt();    
;      70 #endif    
;      71 }
	RETI
;      72 
;      73 #define ETHE_BUF ((struct ETHERNET_HDR *)&netBuffer[0])
;      74 
;      75 int process_serial()
;      76 {            
_process_serial:
;      77     unsigned int len =0;  
;      78     unsigned int tmp16 =0;
;      79    	#asm("cli"); 
	CALL SUBOPT_0x0
;	len -> R16,R17
;	tmp16 -> R18,R19
	cli
;      80     RESET_WATCHDOG();
	WDR
;      81     len = NET_LLH_LEN + sizeof(UDPIP_HDR);
	__GETWRN 16,17,42
;      82     len += rx_lparam;
	__ADDWRR 16,17,11,12
;      83     
;      84     memcpy((unsigned char*)(&netBuffer[NET_LLH_LEN] + sizeof(UDPIP_HDR)),rx_buffer,rx_lparam);
	CALL SUBOPT_0x1
	LDI  R30,LOW(_rx_buffer)
	LDI  R31,HIGH(_rx_buffer)
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R12
	ST   -Y,R11
	CALL _memcpy
;      85     
;      86     UDPBUF->vhl =0x45;
	LDI  R30,LOW(69)
	__PUTB1MN _netBuffer,14
;      87     UDPBUF->tos =0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _netBuffer,15
;      88     UDPBUF->len[0] = 0x00;
	__PUTB1MN _netBuffer,16
;      89     UDPBUF->len[1] = 0x00;
	__PUTB1MN _netBuffer,17
;      90     UDPBUF->ipid[0] = ++udp_id_num>>8;
	LDS  R26,_udp_id_num_G1
	LDS  R27,_udp_id_num_G1+1
	ADIW R26,1
	STS  _udp_id_num_G1,R26
	STS  _udp_id_num_G1+1,R27
	MOVW R30,R26
	MOV  R30,R31
	LDI  R31,0
	__PUTB1MN _netBuffer,18
;      91     UDPBUF->ipid[1] = udp_id_num&0xFF;
	LDS  R30,_udp_id_num_G1
	__PUTB1MN _netBuffer,19
;      92     UDPBUF->ipoffset[0] =0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _netBuffer,20
;      93     UDPBUF->ipoffset[1] =0x00;
	__PUTB1MN _netBuffer,21
;      94     UDPBUF->ttl = 0x80;              
	LDI  R30,LOW(128)
	__PUTB1MN _netBuffer,22
;      95     UDPBUF->proto = IP_PROTO_UDP;
	LDI  R30,LOW(17)
	__PUTB1MN _netBuffer,23
;      96     UDPBUF->ipchksum =0;
	CALL SUBOPT_0x2
;      97     
;      98     /* Assign IP addresses. */
;      99     UDPBUF->destipaddr[0] = SERVER_ADDRESS[0];
	CALL SUBOPT_0x3
	CALL SUBOPT_0x4
;     100     UDPBUF->srcipaddr[0] = HOST_ADDRESS[0];
	CALL SUBOPT_0x5
	CALL SUBOPT_0x6
;     101     UDPBUF->destipaddr[1] = SERVER_ADDRESS[1];
	CALL SUBOPT_0x7
	CALL SUBOPT_0x8
;     102     UDPBUF->srcipaddr[1] = HOST_ADDRESS[1];  
;     103     /* Swap UDP port*/
;     104     tmp16 = UDPBUF->srcport;
	__GETWRMN 18,19,_netBuffer,34
;     105     UDPBUF->srcport = HTONS(CLIENT_PORT);  
	CALL SUBOPT_0x9
	__PUTW1MN _netBuffer,34
;     106     UDPBUF->destport = HTONS(SERVER_PORT);
	MOVW R30,R4
	CALL SUBOPT_0xA
	MOVW R30,R4
	CALL SUBOPT_0xB
	__PUTW1MN _netBuffer,36
;     107     UDPBUF->udplen = HTONS(len - (NET_LLH_LEN + 20));    
	CALL SUBOPT_0xC
;     108 
;     109     /* adjust ip header length*/                     
;     110     tmp16 = len - NET_LLH_LEN;
;     111     UDPBUF->len[0] = tmp16>>8;
;     112     UDPBUF->len[1] = tmp16&0xFF;
;     113 
;     114     UDPBUF->udpchksum =0;  
;     115     UDPBUF->udpchksum = ~udp_chksum();
;     116     
;     117     /* calc ip header checksum */
;     118     UDPBUF->ipchksum = 0;
;     119     UDPBUF->ipchksum = ~ip_chksum();
	CALL SUBOPT_0xD
;     120         
;     121     /* Build an ethernet header. */
;     122     memcpy(IPBUF->ethhdr.dest.addr,eth_src_addr.addr,6);    
	CALL SUBOPT_0xE
	CALL SUBOPT_0xF
;     123     memcpy(IPBUF->ethhdr.src.addr,eth_mac_addr.addr,6); 
	CALL SUBOPT_0x10
;     124     IPBUF->ethhdr.type =HTONS(NET_ETHTYPE_IP4);     
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CALL SUBOPT_0x11
;     125     
;     126     reset_serial();            
	CALL _reset_serial
;     127     #asm("sei");     
	sei
;     128     return len;
	MOVW R30,R16
	CALL __LOADLOCR4
	ADIW R28,4
	RET
;     129 }     
;     130  
;     131 void SaveConfig()
;     132 {
_SaveConfig:
;     133     BYTE i=0;                           
;     134     PBYTE address =0;
;     135     for (i=0; i<6; i++){
	CALL __SAVELOCR3
;	i -> R16
;	*address -> R17,R18
	LDI  R16,0
	LDI  R17,LOW(0x00)
	LDI  R18,HIGH(0x00)
	LDI  R16,LOW(0)
_0xB:
	CPI  R16,6
	BRSH _0xC
;     136         eeprom_write(EEPROM_DEVICE_BASE,address++,eth_mac_addr.addr[i]);    
	CALL SUBOPT_0x12
	CALL SUBOPT_0x13
	LD   R30,Z
	ST   -Y,R30
	CALL _eeprom_write
;     137     }
	SUBI R16,-1
	RJMP _0xB
_0xC:
;     138     eeprom_write_w(EEPROM_DEVICE_BASE,address++,SERVER_ADDRESS[0]);
	CALL SUBOPT_0x12
	CALL SUBOPT_0x3
	CALL SUBOPT_0x14
;     139     ++address;    
;     140     eeprom_write_w(EEPROM_DEVICE_BASE,address++,SERVER_ADDRESS[1]);
	CALL SUBOPT_0x7
	CALL SUBOPT_0x14
;     141     ++address;
;     142     eeprom_write_w(EEPROM_DEVICE_BASE,address++,HOST_ADDRESS[0]);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x14
;     143     ++address;    
;     144     eeprom_write_w(EEPROM_DEVICE_BASE,address++,HOST_ADDRESS[1]);
	CALL SUBOPT_0x15
	CALL SUBOPT_0x14
;     145     ++address;                                      
;     146     eeprom_write_w(EEPROM_DEVICE_BASE,address++,SUBNET_MASK[0]);
	CALL SUBOPT_0x16
	CALL SUBOPT_0x14
;     147     ++address;    
;     148     eeprom_write_w(EEPROM_DEVICE_BASE,address++,SUBNET_MASK[1]);
	CALL SUBOPT_0x17
	CALL SUBOPT_0x14
;     149     ++address; 
;     150     eeprom_write_w(EEPROM_DEVICE_BASE,address++,SERVER_PORT);
	ST   -Y,R5
	ST   -Y,R4
	CALL _eeprom_write_w
;     151     ++address;    
	CALL SUBOPT_0x18
;     152     eeprom_write_w(EEPROM_DEVICE_BASE,address++,CLIENT_PORT);
	ST   -Y,R7
	ST   -Y,R6
	CALL _eeprom_write_w
;     153     ++address;
	__ADDWRN 17,18,1
;     154 }
	RJMP _0x180
;     155  
;     156 void LoadConfig()
;     157 {
_LoadConfig:
;     158     BYTE i=0;                           
;     159     PBYTE address =0;
;     160     for (i=0; i<6; i++){
	CALL __SAVELOCR3
;	i -> R16
;	*address -> R17,R18
	LDI  R16,0
	LDI  R17,LOW(0x00)
	LDI  R18,HIGH(0x00)
	LDI  R16,LOW(0)
_0xE:
	CPI  R16,6
	BRSH _0xF
;     161         eth_mac_addr.addr[i] = eeprom_read(EEPROM_DEVICE_BASE,address++);    
	CALL SUBOPT_0x13
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x12
	CALL _eeprom_read
	POP  R26
	POP  R27
	ST   X,R30
;     162     }
	SUBI R16,-1
	RJMP _0xE
_0xF:
;     163     SERVER_ADDRESS[0] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
	CALL SUBOPT_0x12
	CALL _eeprom_read_w
	CALL SUBOPT_0x19
;     164     ++address;    
	CALL SUBOPT_0x18
;     165     SERVER_ADDRESS[1] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
	CALL _eeprom_read_w
	CALL SUBOPT_0x1A
;     166     ++address;
	CALL SUBOPT_0x18
;     167     HOST_ADDRESS[0] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
	CALL _eeprom_read_w
	CALL SUBOPT_0x1B
;     168     ++address;    
	CALL SUBOPT_0x18
;     169     HOST_ADDRESS[1] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
	CALL _eeprom_read_w
	CALL SUBOPT_0x1C
;     170     ++address;                                      
	CALL SUBOPT_0x18
;     171     SUBNET_MASK[0] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
	CALL _eeprom_read_w
	CALL SUBOPT_0x1D
;     172     ++address;    
	CALL SUBOPT_0x18
;     173     SUBNET_MASK[1] =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
	CALL _eeprom_read_w
	CALL SUBOPT_0x1E
;     174     ++address;                 
	CALL SUBOPT_0x18
;     175     SERVER_PORT =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
	CALL _eeprom_read_w
	MOVW R4,R30
;     176     ++address;    
	CALL SUBOPT_0x18
;     177     CLIENT_PORT =eeprom_read_w(EEPROM_DEVICE_BASE,address++);
	CALL _eeprom_read_w
	MOVW R6,R30
;     178     ++address;
	__ADDWRN 17,18,1
;     179 }
_0x180:
	CALL __LOADLOCR3
	ADIW R28,3
	RET
;     180                  
;     181 void DoConfig()
;     182 {
_DoConfig:
;     183     char ch =''; 
;     184     unsigned char i=0;  
;     185     unsigned int temp[4];                       
;     186     printf("\r\nMAC ADDRESS: %02X-%02X-%02X-%02X-%02X-%02X [Y]/[N]?",
	SBIW R28,8
	CALL SUBOPT_0x1F
;	ch -> R16
;	i -> R17
;	temp -> Y+2
;     187         eth_mac_addr.addr[0],eth_mac_addr.addr[1],eth_mac_addr.addr[2],
;     188         eth_mac_addr.addr[3],eth_mac_addr.addr[4],eth_mac_addr.addr[5]);
	__POINTW1FN _0,0
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_eth_mac_addr
	CALL SUBOPT_0x20
	__GETB1MN _eth_mac_addr,1
	CALL SUBOPT_0x20
	__GETB1MN _eth_mac_addr,2
	CALL SUBOPT_0x20
	__GETB1MN _eth_mac_addr,3
	CALL SUBOPT_0x20
	__GETB1MN _eth_mac_addr,4
	CALL SUBOPT_0x20
	__GETB1MN _eth_mac_addr,5
	CALL SUBOPT_0x20
	LDI  R24,24
	CALL _printf
	ADIW R28,26
;     189     ch =getchar();
	CALL SUBOPT_0x21
;     190     if (ch=='N' || ch =='n'){
	BREQ _0x11
	CPI  R16,110
	BRNE _0x10
_0x11:
;     191         printf("\r\nENT ADDRESS: ");     
	CALL SUBOPT_0x22
;     192         for (i=0; i<5; i++){
_0x14:
	CPI  R17,5
	BRSH _0x15
;     193             scanf("%02x",&eth_mac_addr.addr[i]);
	__POINTW1FN _0,70
	CALL SUBOPT_0x23
	CALL SUBOPT_0x24
;     194             printf("%02X-",eth_mac_addr.addr[i]);
	__POINTW1FN _0,75
	CALL SUBOPT_0x23
	LD   R30,Z
	CALL SUBOPT_0x20
	CALL SUBOPT_0x25
;     195         }                                        
	SUBI R17,-1
	RJMP _0x14
_0x15:
;     196         scanf("%02x",&eth_mac_addr.addr[5]);
	__POINTW1FN _0,70
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1MN _eth_mac_addr,5
	CALL SUBOPT_0x24
;     197         printf("%02X",eth_mac_addr.addr[5]);
	__POINTW1FN _0,81
	ST   -Y,R31
	ST   -Y,R30
	__GETB1MN _eth_mac_addr,5
	CALL SUBOPT_0x20
	CALL SUBOPT_0x25
;     198     }
;     199     printf("\r\nSRV ADDRESS: %d.%d.%d.%d [Y]/[N]?",
_0x10:
;     200         SERVER_ADDRESS[0]&0xFF,SERVER_ADDRESS[0]>>8,
;     201         SERVER_ADDRESS[1]&0xFF,SERVER_ADDRESS[1]>>8);
	__POINTW1FN _0,86
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x3
	CALL SUBOPT_0x26
	LDS  R30,_SERVER_ADDRESS+1
	CALL SUBOPT_0x27
	CALL SUBOPT_0x7
	CALL SUBOPT_0x26
	__GETB1MN _SERVER_ADDRESS,3
	CALL SUBOPT_0x27
	CALL SUBOPT_0x28
;     202     ch =getchar();
;     203     if (ch=='N' || ch =='n'){
	BREQ _0x17
	CPI  R16,110
	BRNE _0x16
_0x17:
;     204         printf("\r\nENT ADDRESS: ");
	CALL SUBOPT_0x22
;     205         for (i=0; i<3; i++){ 
_0x1A:
	CPI  R17,3
	BRSH _0x1B
;     206             scanf("%d.",&temp[i]);
	CALL SUBOPT_0x29
	CALL SUBOPT_0x2A
;     207             printf("%d.",temp[i]);
	CALL SUBOPT_0x29
	CALL SUBOPT_0x2B
;     208         }                           
	SUBI R17,-1
	RJMP _0x1A
_0x1B:
;     209         scanf("%d",&temp[3]);
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x2D
;     210         printf("%d",temp[3]);  
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x2E
;     211         SERVER_ADDRESS[0] = HTONS((temp[0] << 8) | temp[1]); 
	CALL SUBOPT_0x2F
	CALL SUBOPT_0x30
	CALL SUBOPT_0x2F
	CALL SUBOPT_0x31
	CALL SUBOPT_0x19
;     212         SERVER_ADDRESS[1] = HTONS((temp[2] << 8) | temp[3]);
	CALL SUBOPT_0x32
	CALL SUBOPT_0x30
	CALL SUBOPT_0x32
	CALL SUBOPT_0x31
	CALL SUBOPT_0x1A
;     213     }    
;     214     printf("\r\nHST ADDRESS: %d.%d.%d.%d [Y]/[N]?",
_0x16:
;     215         HOST_ADDRESS[0]&0xFF,HOST_ADDRESS[0]>>8,
;     216         HOST_ADDRESS[1]&0xFF,HOST_ADDRESS[1]>>8);
	__POINTW1FN _0,129
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x5
	CALL SUBOPT_0x26
	LDS  R30,_HOST_ADDRESS+1
	CALL SUBOPT_0x27
	CALL SUBOPT_0x15
	CALL SUBOPT_0x26
	__GETB1MN _HOST_ADDRESS,3
	CALL SUBOPT_0x27
	CALL SUBOPT_0x28
;     217     ch =getchar();
;     218     if (ch=='N' || ch =='n'){
	BREQ _0x1D
	CPI  R16,110
	BRNE _0x1C
_0x1D:
;     219         printf("\r\nENT ADDRESS: ");
	CALL SUBOPT_0x22
;     220         for (i=0; i<3; i++){ 
_0x20:
	CPI  R17,3
	BRSH _0x21
;     221             scanf("%d.",&temp[i]);
	CALL SUBOPT_0x29
	CALL SUBOPT_0x2A
;     222             printf("%d.",temp[i]);
	CALL SUBOPT_0x29
	CALL SUBOPT_0x2B
;     223         }                           
	SUBI R17,-1
	RJMP _0x20
_0x21:
;     224         scanf("%d",&temp[3]);
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x2D
;     225         printf("%d",temp[3]);  
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x2E
;     226         HOST_ADDRESS[0] = HTONS((temp[0] << 8) | temp[1]); 
	CALL SUBOPT_0x2F
	CALL SUBOPT_0x30
	CALL SUBOPT_0x2F
	CALL SUBOPT_0x31
	CALL SUBOPT_0x1B
;     227         HOST_ADDRESS[1] = HTONS((temp[2] << 8) | temp[3]);
	CALL SUBOPT_0x32
	CALL SUBOPT_0x30
	CALL SUBOPT_0x32
	CALL SUBOPT_0x31
	CALL SUBOPT_0x1C
;     228     }    
;     229     printf("\r\nSUBNET MASK: %d.%d.%d.%d [Y]/[N]?",
_0x1C:
;     230         SUBNET_MASK[0]&0xFF,SUBNET_MASK[0]>>8,
;     231         SUBNET_MASK[1]&0xFF,SUBNET_MASK[1]>>8);
	__POINTW1FN _0,165
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x16
	CALL SUBOPT_0x26
	LDS  R30,_SUBNET_MASK+1
	CALL SUBOPT_0x27
	CALL SUBOPT_0x17
	CALL SUBOPT_0x26
	__GETB1MN _SUBNET_MASK,3
	CALL SUBOPT_0x27
	CALL SUBOPT_0x28
;     232     ch =getchar();
;     233     if (ch=='N' || ch =='n'){
	BREQ _0x23
	CPI  R16,110
	BRNE _0x22
_0x23:
;     234         printf("\r\nENT ADDRESS: ");
	CALL SUBOPT_0x22
;     235         for (i=0; i<3; i++){ 
_0x26:
	CPI  R17,3
	BRSH _0x27
;     236             scanf("%d.",&temp[i]);
	CALL SUBOPT_0x29
	CALL SUBOPT_0x2A
;     237             printf("%d.",temp[i]);
	CALL SUBOPT_0x29
	CALL SUBOPT_0x2B
;     238         }                           
	SUBI R17,-1
	RJMP _0x26
_0x27:
;     239         scanf("%d",&temp[3]);
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x2D
;     240         printf("%d",temp[3]);  
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x2E
;     241         SUBNET_MASK[0] = HTONS((temp[0] << 8) | temp[1]); 
	CALL SUBOPT_0x2F
	CALL SUBOPT_0x30
	CALL SUBOPT_0x2F
	CALL SUBOPT_0x31
	CALL SUBOPT_0x1D
;     242         SUBNET_MASK[1] = HTONS((temp[2] << 8) | temp[3]);
	CALL SUBOPT_0x32
	CALL SUBOPT_0x30
	CALL SUBOPT_0x32
	CALL SUBOPT_0x31
	CALL SUBOPT_0x1E
;     243     }    
;     244     printf("\r\nUDP SRVPORT: %d [Y]/[N]?",SERVER_PORT);
_0x22:
	__POINTW1FN _0,201
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x33
;     245     ch =getchar();
	CALL SUBOPT_0x21
;     246     if (ch=='N' || ch =='n'){        
	BREQ _0x29
	CPI  R16,110
	BRNE _0x28
_0x29:
;     247         printf("\r\nNEW SRVPORT: ");
	__POINTW1FN _0,228
	CALL SUBOPT_0x34
;     248         scanf("%4d",&SERVER_PORT);
	__GETD1N 0x4
	CALL SUBOPT_0x35
;     249         printf("%d",SERVER_PORT);
	CALL SUBOPT_0x33
;     250     }
;     251     printf("\r\nUDP HSTPORT: %d [Y]/[N]?",CLIENT_PORT); 
_0x28:
	__POINTW1FN _0,248
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x36
;     252     ch =getchar();
	CALL SUBOPT_0x21
;     253     if (ch=='N' || ch =='n'){        
	BREQ _0x2C
	CPI  R16,110
	BRNE _0x2B
_0x2C:
;     254         printf("\r\nNEW HSTPORT: ");
	__POINTW1FN _0,275
	CALL SUBOPT_0x34
;     255         scanf("%4d",&CLIENT_PORT);
	__GETD1N 0x6
	CALL SUBOPT_0x35
;     256         printf("%d",CLIENT_PORT);
	CALL SUBOPT_0x36
;     257     }        
;     258     SaveConfig();
_0x2B:
	CALL _SaveConfig
;     259     printf("\r\nSAVE CONFIGURATION DONE...\r\n");
	__POINTW1FN _0,291
	CALL SUBOPT_0x37
;     260 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,10
	RET
;     261                                                    
;     262 /////////////////////////////////////////////////////////////////////////////
;     263 // Main entry for application device
;     264 /////////////////////////////////////////////////////////////////////////////
;     265 
;     266 void main(void)
;     267 {
_main:
;     268 
;     269 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;     270 DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;     271 PORTB=0xF0;
	LDI  R30,LOW(240)
	OUT  0x18,R30
;     272 DDRB=0x0F;
	LDI  R30,LOW(15)
	OUT  0x17,R30
;     273 PORTC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x15,R30
;     274 DDRC=0xFF;
	OUT  0x14,R30
;     275 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     276 DDRD=0xF8;
	LDI  R30,LOW(248)
	OUT  0x11,R30
;     277 
;     278 GICR|=0x40;
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
;     279 MCUCR=0x03;
	LDI  R30,LOW(3)
	OUT  0x35,R30
;     280 MCUCSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x34,R30
;     281 GIFR=0x40;
	LDI  R30,LOW(64)
	OUT  0x3A,R30
;     282 
;     283 TIMSK=0x00;
	LDI  R30,LOW(0)
	OUT  0x39,R30
;     284 
;     285 UCSRA=0x00;
	OUT  0xB,R30
;     286 UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     287 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     288 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     289 UBRRL=0x2F;    
	LDI  R30,LOW(47)
	OUT  0x9,R30
;     290 UBRRL=0x33;    
	LDI  R30,LOW(51)
	OUT  0x9,R30
;     291 
;     292 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;     293 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
;     294 
;     295 OSCCAL=0xAD;
	LDI  R30,LOW(173)
	OUT  0x31,R30
;     296 
;     297 i2c_init();
	CALL _i2c_init
;     298 
;     299 if (RESET_MOD){                          
	SBIC 0x16,6
	RJMP _0x2E
;     300     printf("\r\nRESETTING DEVICE..\r\n");
	__POINTW1FN _0,322
	CALL SUBOPT_0x37
;     301     SaveConfig();
	CALL _SaveConfig
;     302     printf("\r\nMASTER RESET DONE!\r\n");
	__POINTW1FN _0,345
	CALL SUBOPT_0x37
;     303 }
;     304 else{      
	RJMP _0x2F
_0x2E:
;     305     LoadConfig();
	CALL _LoadConfig
;     306 }
_0x2F:
;     307 
;     308 if (CONFIG_MOD){
	SBIC 0x16,7
	RJMP _0x30
;     309     printf("                                          \r\n");
	CALL SUBOPT_0x38
;     310     printf("|=========================================|\r\n");
	__POINTW1FN _0,413
	CALL SUBOPT_0x37
;     311     printf("|      Ethernet AVR Firmware v1.0.0       |\r\n");
	__POINTW1FN _0,459
	CALL SUBOPT_0x37
;     312     printf("|_________________________________________|\r\n");
	__POINTW1FN _0,505
	CALL SUBOPT_0x37
;     313     printf("|        Copyright by CuongQuay           |\r\n");  
	__POINTW1FN _0,551
	CALL SUBOPT_0x37
;     314     printf("|    cuong3ihut@yahoo.com - 0915651001    |\r\n");
	__POINTW1FN _0,597
	CALL SUBOPT_0x37
;     315     printf("|       Started date: 22.07.2007          |\r\n");
	__POINTW1FN _0,643
	CALL SUBOPT_0x37
;     316     printf("|       Release date: --.--.2007          |\r\n");
	__POINTW1FN _0,689
	CALL SUBOPT_0x37
;     317     printf("|_________________________________________|\r\n");              
	__POINTW1FN _0,505
	CALL SUBOPT_0x37
;     318     printf("                                          \r\n");         
	CALL SUBOPT_0x38
;     319     DoConfig(); /////////////////////////////////////////////
	CALL _DoConfig
;     320     printf("                                          \r\n"); 
	CALL SUBOPT_0x38
;     321 }
;     322 
;     323     rtl8019Init();
_0x30:
	RCALL _rtl8019Init
;     324 #ifdef _DUMP_REG
;     325 if (CONFIG_MOD){
	SBIS 0x16,7
;     326     rtl8019DumpReg();
	RCALL _rtl8019DumpReg
;     327 }
;     328 #endif 
;     329 #ifdef __WATCH_DOG_
;     330     WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;     331     WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;     332 #endif 
;     333     #asm("sei");
	sei
;     334     while (1){             
_0x32:
;     335         unsigned int rcv_len = 0;
;     336         rcv_len = nic_poll(netBuffer);    
	CALL SUBOPT_0x39
	LDI  R30,LOW(_0x35*2)
	LDI  R31,HIGH(_0x35*2)
	CALL __INITLOCB
;	rcv_len -> Y+0
	CALL SUBOPT_0x3A
	RCALL _nic_poll
	CALL SUBOPT_0x3B
;     337         if(rcv_len == 0){ 
	BRNE _0x36
;     338             if (rx_message != UNKNOWN_MSG){ 
	TST  R8
	BREQ _0x37
;     339                 rcv_len = process_arp_out();
	RCALL _process_arp_out
	CALL SUBOPT_0x3B
;     340                 if (rcv_len){                   
	BREQ _0x38
;     341                     nic_send(netBuffer,rcv_len);
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x3C
;     342                 }
;     343                 else{   
	RJMP _0x39
_0x38:
;     344                     if (rx_lparam){               
	MOV  R0,R11
	OR   R0,R12
	BREQ _0x3A
;     345                         rcv_len = process_serial(); 
	CALL _process_serial
	CALL SUBOPT_0x3B
;     346                         if (rcv_len){
	BREQ _0x3B
;     347                             nic_send(netBuffer,rcv_len);
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x3C
;     348                         }                      
;     349                     }      
_0x3B:
;     350                     rx_message = UNKNOWN_MSG;
_0x3A:
	CLR  R8
;     351                 }                  
_0x39:
;     352             }    
;     353             delay_ms(1);
_0x37:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL SUBOPT_0x3D
;     354             if (++rx_wparam >COMM_TIMEOUT){
	__GETW1R 9,10
	ADIW R30,1
	__PUTW1R 9,10
	CPI  R30,LOW(0x3E9)
	LDI  R26,HIGH(0x3E9)
	CPC  R31,R26
	BRLO _0x3C
;     355                 rx_message = DATA_INCOMMING;
	LDI  R30,LOW(1)
	MOV  R8,R30
;     356                 rx_wparam =0;    
	CLR  R9
	CLR  R10
;     357             }  
;     358         }
_0x3C:
;     359         else{            
	RJMP _0x3D
_0x36:
;     360             unsigned int len = 0;                     
;     361             if(ETHE_BUF->type == HTONS(NET_ETHTYPE_IP4)){
	CALL SUBOPT_0x39
	LDI  R30,LOW(_0x3E*2)
	LDI  R31,HIGH(_0x3E*2)
	CALL __INITLOCB
;	rcv_len -> Y+2
;	len -> Y+0
	__GETW2MN _netBuffer,12
	SBIW R26,8
	BRNE _0x3F
;     362                 len = process_ip_in(rcv_len);
	CALL SUBOPT_0x3E
	RCALL _process_ip_in
	CALL SUBOPT_0x3F
;     363                 if (len >0 && len <=RTL8019_BUFSIZE){
	BRSH _0x41
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x5DD)
	LDI  R30,HIGH(0x5DD)
	CPC  R27,R30
	BRLO _0x42
_0x41:
	RJMP _0x40
_0x42:
;     364                     nic_send(netBuffer,len);  
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x3C
;     365                 }
;     366             }                     
_0x40:
;     367             else if(ETHE_BUF->type == HTONS(NET_ETHTYPE_ARP)){
	RJMP _0x43
_0x3F:
	__GETW2MN _netBuffer,12
	CPI  R26,LOW(0x608)
	LDI  R30,HIGH(0x608)
	CPC  R27,R30
	BRNE _0x44
;     368                 len = process_arp_in();
	RCALL _process_arp_in
	CALL SUBOPT_0x3F
;     369                 if (len >0 && len <=RTL8019_BUFSIZE){
	BRSH _0x46
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x5DD)
	LDI  R30,HIGH(0x5DD)
	CPC  R27,R30
	BRLO _0x47
_0x46:
	RJMP _0x45
_0x47:
;     370                     nic_send(netBuffer,len);                
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x3C
;     371                 }
;     372             }
_0x45:
;     373         }                  
_0x44:
_0x43:
	ADIW R28,2
_0x3D:
;     374         RESET_WATCHDOG();
	WDR
;     375     }
	ADIW R28,2
	JMP  _0x32
;     376 }
_0x48:
	RJMP _0x48
;     377 #include "rtl8019.h"
;     378 
;     379 
;     380 /*****************************************************************************
;     381 *  rtl8019Write( RTL_ADDRESS, RTL_DATA )
;     382 *  Args:        1. unsigned char RTL_ADDRESS - register offset of RTL register
;     383 *               2. unsigned char RTL_DATA - data to write to register
;     384 *  Created By:  Louis Beaudoin
;     385 *  Date:        September 21, 2002
;     386 *  Description: Writes byte to RTL8019 register.
;     387 *
;     388 *  Notes - If using the External SRAM Interface, performs a write to
;     389 *            address MEMORY_MAPPED_RTL8019_OFFSET + (RTL_ADDRESS<<8)
;     390 *            The address is sent in the non-multiplxed upper address port so
;     391 *            no latch is required.
;     392 *
;     393 *          If using general I/O ports, the data port is left in the input
;     394 *            state with pullups enabled
;     395 *
;     396 *****************************************************************************/
;     397 
;     398 void rtl8019Write(unsigned char address, unsigned char data)
;     399 {
_rtl8019Write:
;     400     // assert the address, leaving the non-address pins intact
;     401     address |= (RTL8019_ADDRESS_PORT & ~RTL8019_ADDRESS_MASK);
;	address -> Y+1
;	data -> Y+0
	CALL SUBOPT_0x40
;     402     RTL8019_ADDRESS_PORT = address;
;     403     
;     404 	// set data bus as output and place data on bus
;     405     RTL8019_DATA_DDR = 0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;     406     RTL8019_DATA_PORT = data;
	LD   R30,Y
	OUT  0x1B,R30
;     407     
;     408 	// toggle write pin
;     409     RTL8019_CONTROL_WRITEPIN = 0;
	CBI  0x12,7
;     410     #asm("NOP");
	NOP
;     411     RTL8019_CONTROL_WRITEPIN = 1;
	SBI  0x12,7
;     412 
;     413     
;     414 	// set data port back to input with pullups enabled
;     415     RTL8019_DATA_DDR = 0x00;
	LDI  R30,LOW(0)
	OUT  0x1A,R30
;     416     RTL8019_DATA_PORT = 0xFF;
	LDI  R30,LOW(255)
	OUT  0x1B,R30
;     417 }
	ADIW R28,2
	RET
;     418 
;     419 /*****************************************************************************
;     420 *  rtl8019Read(RTL_ADDRESS)
;     421 *  Args:        unsigned char RTL_ADDRESS - register offset of RTL register
;     422 *  Created By:  Louis Beaudoin
;     423 *  Date:        September 21, 2002
;     424 *  Description: Reads byte from RTL8019 register
;     425 *
;     426 *  Notes - If using the External SRAM Interface, performs a read from
;     427 *            address MEMORY_MAPPED_RTL8019_OFFSET + (RTL_ADDRESS<<8)
;     428 *            The address is sent in the non-multiplxed upper address port so
;     429 *            no latch is required.
;     430 *
;     431 *          If using general I/O ports, the data port is assumed to already be
;     432 *            an input, and is left as an input port when done
;     433 *
;     434 *****************************************************************************/
;     435 
;     436 unsigned char rtl8019Read(unsigned char address)
;     437 {
_rtl8019Read:
;     438     unsigned char byte;
;     439    
;     440     // assert the address, leaving the non-address pins intact
;     441     address |= (RTL8019_ADDRESS_PORT & ~RTL8019_ADDRESS_MASK);
	ST   -Y,R16
;	address -> Y+1
;	byte -> R16
	CALL SUBOPT_0x40
;     442     RTL8019_ADDRESS_PORT = address;
;     443    
;     444     // assert read
;     445     RTL8019_CONTROL_READPIN = 0;
	CBI  0x12,6
;     446     #asm("NOP");
	NOP
;     447    
;     448     // read in the data
;     449     byte = RTL8019_DATA_PIN;
	IN   R16,25
;     450 
;     451     // negate read
;     452     RTL8019_CONTROL_READPIN = 1;
	SBI  0x12,6
;     453 
;     454     return byte;
	MOV  R30,R16
	LDD  R16,Y+0
	ADIW R28,2
	RET
;     455 }
;     456 
;     457 
;     458 /*****************************************************************************
;     459 *  rtl8019SetupPorts(void);
;     460 *
;     461 *  Created By:  Louis Beaudoin
;     462 *  Date:        September 21, 2002
;     463 *  Description: Sets up the ports used for communication with the RTL8019 NIC
;     464 *                 (data bus, address bus, read, write, and reset)
;     465 *****************************************************************************/
;     466 void rtl8019SetupPorts(void)
;     467 {
_rtl8019SetupPorts:
;     468     // make the address port output
;     469 	RTL8019_ADDRESS_DDR = RTL8019_ADDRESS_MASK;
	LDI  R30,LOW(31)
	OUT  0x17,R30
;     470     
;     471     // make the data port input with pull-ups
;     472     RTL8019_DATA_PORT = 0xFF;
	LDI  R30,LOW(255)
	OUT  0x1B,R30
;     473 	          
;     474 	RTL8019_CONTROL_READPIN = 1;
	SBI  0x12,6
;     475 	RTL8019_CONTROL_WRITEPIN = 1;	
	SBI  0x12,7
;     476 }
	RET
;     477 
;     478 
;     479 
;     480 /*****************************************************************************
;     481 *  HARD_RESET_RTL8019()
;     482 *
;     483 *  Created By:  Louis Beaudoin
;     484 *  Date:        September 21, 2002
;     485 *  Description: Simply toggles the pin that resets the NIC
;     486 *****************************************************************************/
;     487 #define HARD_RESET_RTL8019() do{  RTL8019_RESET_PIN = 1;\
;     488                                 delay_ms(10); \
;     489                                 RTL8019_RESET_PIN = 0;}\                                
;     490                                 while(0)
;     491 
;     492 
;     493 
;     494 /*****************************************************************************
;     495 *  rtl8019Overrun(void);
;     496 *
;     497 *  Created By:  Louis Beaudoin
;     498 *  Date:        September 21, 2002
;     499 *  Description: "Canned" receive buffer overrun function originally from
;     500 *                 a National Semiconductor appnote
;     501 *  Notes:       This function must be called before retreiving packets from
;     502 *                 the NIC if there is a buffer overrun
;     503 *****************************************************************************/
;     504 void rtl8019Overrun(void);
;     505 
;     506 
;     507 
;     508 
;     509 //******************************************************************
;     510 //*	REALTEK CONTROL REGISTER OFFSETS
;     511 //*   All offsets in Page 0 unless otherwise specified
;     512 //*	  All functions accessing CR must leave CR in page 0 upon exit
;     513 //******************************************************************
;     514 #define CR		 	0x00
;     515 #define PSTART		0x01
;     516 #define PAR0      	0x01    // Page 1
;     517 #define CR9346    	0x01    // Page 3
;     518 #define PSTOP		0x02
;     519 #define BNRY		0x03
;     520 #define TSR			0x04
;     521 #define TPSR		0x04
;     522 #define TBCR0		0x05
;     523 #define NCR			0x05
;     524 #define TBCR1		0x06
;     525 #define ISR			0x07
;     526 #define CURR		0x07   // Page 1
;     527 #define RSAR0		0x08
;     528 #define CRDA0		0x08
;     529 #define RSAR1		0x09
;     530 #define CRDA1		0x09
;     531 #define RBCR0		0x0A
;     532 #define RBCR1		0x0B
;     533 #define RSR			0x0C
;     534 #define RCR			0x0C
;     535 #define TCR			0x0D
;     536 #define CNTR0		0x0D
;     537 #define DCR			0x0E
;     538 #define CNTR1		0x0E
;     539 #define IMR			0x0F
;     540 #define CNTR2		0x0F
;     541 #define RDMAPORT  	0x10
;     542 #define RSTPORT   	0x18
;     543 #define CONFIG2     0x05    // page 3
;     544 #define CONFIG3     0x06    // page 3
;     545 #define RTL_EECR    0x01    // page 3
;     546 
;     547 
;     548 
;     549 /*****************************************************************************
;     550 *
;     551 * RTL ISR Register Bits
;     552 *
;     553 *****************************************************************************/
;     554 #define ISR_RST	7
;     555 #define ISR_OVW 4
;     556 #define ISR_PRX 0
;     557 #define ISR_RDC 6
;     558 #define ISR_PTX 1
;     559 
;     560 
;     561 /*****************************************************************************
;     562 *
;     563 *  RTL Register Initialization Values
;     564 *
;     565 *****************************************************************************/
;     566 // RCR : accept broadcast packets and packets destined to this MAC
;     567 //         drop short frames and receive errors
;     568 #define RCR_INIT		0x04
;     569 
;     570 // TCR : default transmit operation - CRC is generated 
;     571 #define TCR_INIT		0x00
;     572 
;     573 // DCR : allows send packet to be used for packet retreival
;     574 //         FIFO threshold: 8-bits (works)
;     575 //         8-bit transfer mode
;     576 #define DCR_INIT		0x58
;     577 
;     578 // IMR : interrupt enabled for receive and overrun events
;     579 #define IMR_INIT		0x11
;     580 
;     581 // buffer boundaries - transmit has 6 256-byte pages
;     582 //   receive has 26 256-byte pages
;     583 //   entire available packet buffer space is allocated
;     584 #define TXSTART_INIT   	0x40
;     585 #define RXSTART_INIT   	0x46
;     586 #define RXSTOP_INIT    	0x60
;     587 
;     588 
;     589 
;     590 void rtl8019BeginPacketSend(unsigned int packetLength)
;     591 {
_rtl8019BeginPacketSend:
;     592 	unsigned int sendPacketLength;
;     593 	sendPacketLength = (packetLength>=ETHERNET_MIN_PACKET_LENGTH) ?
	ST   -Y,R17
	ST   -Y,R16
;	packetLength -> Y+2
;	sendPacketLength -> R16,R17
;     594 	                 packetLength : ETHERNET_MIN_PACKET_LENGTH ;
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,60
	BRLO _0x49
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	RJMP _0x4A
_0x49:
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
_0x4A:
	MOVW R16,R30
;     595 	
;     596 	//start the NIC
;     597 	rtl8019Write(CR,0x22);
	CALL SUBOPT_0x41
;     598 	
;     599 	// still transmitting a packet - wait for it to finish
;     600 	while( rtl8019Read(CR) & 0x04 );
_0x4C:
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _rtl8019Read
	ANDI R30,LOW(0x4)
	BRNE _0x4C
;     601 
;     602 	//load beginning page for transmit buffer
;     603 	rtl8019Write(TPSR,TXSTART_INIT);
	CALL SUBOPT_0x42
;     604 	
;     605 	//set start address for remote DMA operation
;     606 	rtl8019Write(RSAR0,0x00);
	CALL SUBOPT_0x43
;     607 	rtl8019Write(RSAR1,0x40);
	CALL SUBOPT_0x44
;     608 	
;     609 	//clear the packet stored interrupt
;     610 	rtl8019Write(ISR,(1<<ISR_PTX));
	LDI  R30,LOW(7)
	CALL SUBOPT_0x45
;     611 
;     612 	//load data byte count for remote DMA
;     613 	rtl8019Write(RBCR0, (unsigned char)(packetLength));
	CALL SUBOPT_0x46
;     614 	rtl8019Write(RBCR1, (unsigned char)(packetLength>>8));
;     615 
;     616 	rtl8019Write(TBCR0, (unsigned char)(sendPacketLength));
	LDI  R30,LOW(5)
	ST   -Y,R30
	ST   -Y,R16
	CALL SUBOPT_0x47
;     617 	rtl8019Write(TBCR1, (unsigned char)((sendPacketLength)>>8));
	MOV  R30,R17
	CALL SUBOPT_0x48
;     618 	
;     619 	//do remote write operation
;     620 	rtl8019Write(CR,0x12);
	LDI  R30,LOW(18)
	ST   -Y,R30
	CALL _rtl8019Write
;     621 }
	RJMP _0x17B
;     622 
;     623 
;     624 
;     625 void rtl8019SendPacketData(unsigned char * localBuffer, unsigned int length)
;     626 {
_rtl8019SendPacketData:
;     627 	unsigned int i;
;     628 	
;     629 	for(i=0;i<length;i++){
	ST   -Y,R17
	ST   -Y,R16
;	*localBuffer -> Y+4
;	length -> Y+2
;	i -> R16,R17
	__GETWRN 16,17,0
_0x50:
	CALL SUBOPT_0x49
	BRSH _0x51
;     630 		rtl8019Write(RDMAPORT, netBuffer[i]);
	LDI  R30,LOW(16)
	ST   -Y,R30
	LDI  R26,LOW(_netBuffer)
	LDI  R27,HIGH(_netBuffer)
	ADD  R26,R16
	ADC  R27,R17
	LD   R30,X
	ST   -Y,R30
	CALL _rtl8019Write
;     631 	}
	__ADDWRN 16,17,1
	RJMP _0x50
_0x51:
;     632 }
	RJMP _0x17D
;     633 
;     634 
;     635 
;     636 void rtl8019EndPacketSend(void)
;     637 {
_rtl8019EndPacketSend:
;     638 	//send the contents of the transmit buffer onto the network
;     639 	rtl8019Write(CR,0x24);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(36)
	CALL SUBOPT_0x4A
;     640 	
;     641 	// clear the remote DMA interrupt
;     642 	rtl8019Write(ISR, (1<<ISR_RDC));
	CALL SUBOPT_0x44
;     643 }
	RET
;     644 
;     645 
;     646 
;     647 
;     648 // pointers to locations in the RTL8019 receive buffer
;     649 static unsigned char nextPage;

	.DSEG
_nextPage_G2:
	.BYTE 0x1
;     650 static unsigned int currentRetreiveAddress;
_currentRetreiveAddress_G2:
	.BYTE 0x2
;     651 
;     652 // location of items in the RTL8019's page header
;     653 #define  enetpacketstatus     0x00
;     654 #define  nextblock_ptr        0x01
;     655 #define	 enetpacketLenL		  0x02
;     656 #define	 enetpacketLenH		  0x03
;     657 
;     658 unsigned int rtl8019BeginPacketRetreive(void)
;     659 {

	.CSEG
_rtl8019BeginPacketRetreive:
;     660 	unsigned char i;
;     661 	unsigned char bnry;
;     662 	
;     663 	unsigned char pageheader[4];
;     664 	unsigned int rxlen;
;     665 	
;     666 	// check for and handle an overflow
;     667 	rtl8019ProcessInterrupt();
	SBIW R28,4
	CALL __SAVELOCR4
;	i -> R16
;	bnry -> R17
;	pageheader -> Y+4
;	rxlen -> R18,R19
	RCALL _rtl8019ProcessInterrupt
;     668 	
;     669 	// read CURR from page 1
;     670 	rtl8019Write(CR,0x62);
	CALL SUBOPT_0x4B
;     671 	i = rtl8019Read(CURR);
	CALL _rtl8019Read
	MOV  R16,R30
;     672 	
;     673 	// return to page 0
;     674 	rtl8019Write(CR,0x22);
	CALL SUBOPT_0x41
;     675 	
;     676 	// read the boundary register - pointing to the beginning of the packet
;     677 	bnry = rtl8019Read(BNRY) ;
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _rtl8019Read
	MOV  R17,R30
;     678 	
;     679 	// return if there is no packet in the buffer
;     680 	if( bnry == i ){
	CP   R16,R17
	BRNE _0x52
;     681 		return 0;   
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x17C
;     682 	}
;     683 	
;     684 
;     685 	// clear the packet received interrupt flag
;     686 	rtl8019Write(ISR, (1<<ISR_PRX));
_0x52:
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _rtl8019Write
;     687 	
;     688 	// the boundary pointer is invalid, reset the contents of the buffer and exit
;     689 	if( (bnry >= RXSTOP_INIT) || (bnry < RXSTART_INIT) )
	CPI  R17,96
	BRSH _0x54
	CPI  R17,70
	BRSH _0x53
_0x54:
;     690 	{
;     691 		rtl8019Write(BNRY, RXSTART_INIT);
	CALL SUBOPT_0x4C
;     692 		rtl8019Write(CR, 0x62);
;     693 		rtl8019Write(CURR, RXSTART_INIT);
	CALL SUBOPT_0x4D
;     694 		rtl8019Write(CR, 0x22);    	
;     695 		return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x17C
;     696 	}
;     697 
;     698 	// initiate DMA to transfer the RTL8019 packet header
;     699     rtl8019Write(RBCR0, 4);
_0x53:
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDI  R30,LOW(4)
	CALL SUBOPT_0x4E
;     700     rtl8019Write(RBCR1, 0);
;     701     rtl8019Write(RSAR0, 0);
	CALL SUBOPT_0x43
;     702     rtl8019Write(RSAR1, bnry);
	ST   -Y,R17
	CALL SUBOPT_0x4F
;     703     rtl8019Write(CR, 0x0A);
	LDI  R30,LOW(10)
	ST   -Y,R30
	CALL _rtl8019Write
;     704 	for(i=0;i<4;i++){
	LDI  R16,LOW(0)
_0x57:
	CPI  R16,4
	BRSH _0x58
;     705 		pageheader[i] = rtl8019Read(RDMAPORT);
	MOV  R30,R16
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,4
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	LDI  R30,LOW(16)
	ST   -Y,R30
	CALL _rtl8019Read
	POP  R26
	POP  R27
	ST   X,R30
;     706 	}
	SUBI R16,-1
	RJMP _0x57
_0x58:
;     707 	// end the DMA operation
;     708     rtl8019Write(CR, 0x22);
	CALL SUBOPT_0x41
;     709     for(i = 0; i <= 20; i++){
	LDI  R16,LOW(0)
_0x5A:
	CPI  R16,21
	BRSH _0x5B
;     710         if(rtl8019Read(ISR) & 1<<6){
	CALL SUBOPT_0x50
	BRNE _0x5B
;     711             break;                  
;     712         }
;     713     }
	SUBI R16,-1
	RJMP _0x5A
_0x5B:
;     714     rtl8019Write(ISR, 1<<6);
	CALL SUBOPT_0x51
;     715 
;     716 	
;     717 	//rxlen = (unsigned int)(pageheader[enetpacketLenH]<<8) + (unsigned int)pageheader[enetpacketLenL];
;     718 	rxlen = (unsigned int)(pageheader[enetpacketLenH]);
	LDD  R18,Y+7
	CLR  R19
;     719 	rxlen = (rxlen<<8) + pageheader[enetpacketLenL];
	MOV  R31,R18
	LDI  R30,LOW(0)
	MOVW R26,R30
	LDD  R30,Y+6
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R18,R30
;     720 	nextPage = pageheader[nextblock_ptr] ;
	LDD  R30,Y+5
	STS  _nextPage_G2,R30
;     721 	
;     722 	currentRetreiveAddress = (unsigned int)(bnry);
	MOV  R30,R17
	LDI  R31,0
	CALL SUBOPT_0x52
;     723 	currentRetreiveAddress = (currentRetreiveAddress<<8) + 4;
	LDS  R31,_currentRetreiveAddress_G2
	LDI  R30,LOW(0)
	ADIW R30,4
	CALL SUBOPT_0x52
;     724 	
;     725 	// if the nextPage pointer is invalid, the packet is not ready yet - exit
;     726 	if( (nextPage >= RXSTOP_INIT) || (nextPage < RXSTART_INIT) ){
	LDS  R26,_nextPage_G2
	CPI  R26,LOW(0x60)
	BRSH _0x5E
	CPI  R26,LOW(0x46)
	BRSH _0x5D
_0x5E:
;     727 		return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x17C
;     728     }
;     729     return rxlen-4;
_0x5D:
	MOVW R30,R18
	SBIW R30,4
	RJMP _0x17C
;     730 }
;     731 
;     732 void rtl8019RetreivePacketData(unsigned char * localBuffer, unsigned int length)
;     733 {
_rtl8019RetreivePacketData:
;     734 	unsigned int i;
;     735 	
;     736 	// initiate DMA to transfer the data
;     737     rtl8019Write(RBCR0, (unsigned char)length);
	ST   -Y,R17
	ST   -Y,R16
;	*localBuffer -> Y+4
;	length -> Y+2
;	i -> R16,R17
	CALL SUBOPT_0x46
;     738     rtl8019Write(RBCR1, (unsigned char)(length>>8));
;     739     rtl8019Write(RSAR0, (unsigned char)currentRetreiveAddress);
	LDI  R30,LOW(8)
	ST   -Y,R30
	LDS  R30,_currentRetreiveAddress_G2
	ST   -Y,R30
	CALL _rtl8019Write
;     740     rtl8019Write(RSAR1, (unsigned char)(currentRetreiveAddress>>8));
	LDI  R30,LOW(9)
	ST   -Y,R30
	LDS  R30,_currentRetreiveAddress_G2+1
	CALL SUBOPT_0x48
;     741     rtl8019Write(CR, 0x0A);
	LDI  R30,LOW(10)
	ST   -Y,R30
	CALL _rtl8019Write
;     742 	for(i=0;i<length;i++)
	__GETWRN 16,17,0
_0x61:
	CALL SUBOPT_0x49
	BRSH _0x62
;     743 		localBuffer[i] = rtl8019Read(RDMAPORT);
	MOVW R30,R16
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	LDI  R30,LOW(16)
	ST   -Y,R30
	CALL _rtl8019Read
	POP  R26
	POP  R27
	ST   X,R30
;     744 
;     745 	// end the DMA operation
;     746     rtl8019Write(CR, 0x22);
	__ADDWRN 16,17,1
	RJMP _0x61
_0x62:
	CALL SUBOPT_0x41
;     747     for(i = 0; i <= 20; i++)
	__GETWRN 16,17,0
_0x64:
	__CPWRN 16,17,21
	BRSH _0x65
;     748         if(rtl8019Read(ISR) & 1<<6)
	CALL SUBOPT_0x50
	BRNE _0x65
;     749             break;
;     750     rtl8019Write(ISR, 1<<6);
	__ADDWRN 16,17,1
	RJMP _0x64
_0x65:
	CALL SUBOPT_0x51
;     751     
;     752     currentRetreiveAddress += length;
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDS  R26,_currentRetreiveAddress_G2
	LDS  R27,_currentRetreiveAddress_G2+1
	ADD  R30,R26
	ADC  R31,R27
	CALL SUBOPT_0x52
;     753     if( currentRetreiveAddress >= 0x6000 )
	LDS  R26,_currentRetreiveAddress_G2
	LDS  R27,_currentRetreiveAddress_G2+1
	CPI  R26,LOW(0x6000)
	LDI  R30,HIGH(0x6000)
	CPC  R27,R30
	BRLO _0x67
;     754     	currentRetreiveAddress = currentRetreiveAddress - (0x6000-0x4600) ;
	LDS  R30,_currentRetreiveAddress_G2
	LDS  R31,_currentRetreiveAddress_G2+1
	SUBI R30,LOW(6656)
	SBCI R31,HIGH(6656)
	CALL SUBOPT_0x52
;     755 }
_0x67:
	RJMP _0x17D
;     756 
;     757 
;     758 
;     759 void rtl8019EndPacketRetreive(void)
;     760 {
_rtl8019EndPacketRetreive:
;     761 	unsigned char i;
;     762 
;     763 	// end the DMA operation
;     764     rtl8019Write(CR, 0x22);
	ST   -Y,R16
;	i -> R16
	CALL SUBOPT_0x41
;     765     for(i = 0; i <= 20; i++)
	LDI  R16,LOW(0)
_0x69:
	CPI  R16,21
	BRSH _0x6A
;     766         if(rtl8019Read(ISR) & 1<<6)
	CALL SUBOPT_0x50
	BRNE _0x6A
;     767             break;
;     768     rtl8019Write(ISR, 1<<6);
	SUBI R16,-1
	RJMP _0x69
_0x6A:
	CALL SUBOPT_0x51
;     769 
;     770 	// set the boundary register to point to the start of the next packet
;     771     rtl8019Write(BNRY, nextPage);
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDS  R30,_nextPage_G2
	ST   -Y,R30
	CALL _rtl8019Write
;     772 }
	RJMP _0x17F
;     773 
;     774 
;     775 void rtl8019Overrun(void)
;     776 {
_rtl8019Overrun:
;     777 	unsigned char data_L, resend;	
;     778 
;     779 	data_L = rtl8019Read(CR);
	ST   -Y,R17
	ST   -Y,R16
;	data_L -> R16
;	resend -> R17
	LDI  R30,LOW(0)
	CALL SUBOPT_0x53
;     780 	rtl8019Write(CR, 0x21);
	CALL SUBOPT_0x54
;     781 	delay_ms(2);
	CALL SUBOPT_0x55
;     782 	rtl8019Write(RBCR0, 0x00);
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDI  R30,LOW(0)
	CALL SUBOPT_0x4E
;     783 	rtl8019Write(RBCR1, 0x00);
;     784 	if(!(data_L & 0x04))
	SBRC R16,2
	RJMP _0x6C
;     785 		resend = 0;
	LDI  R17,LOW(0)
;     786 	else if(data_L & 0x04)
	RJMP _0x6D
_0x6C:
	SBRS R16,2
	RJMP _0x6E
;     787 	{
;     788 		data_L = rtl8019Read(ISR);
	LDI  R30,LOW(7)
	CALL SUBOPT_0x53
;     789 		if((data_L & 0x02) || (data_L & 0x08))
	SBRC R16,1
	RJMP _0x70
	SBRS R16,3
	RJMP _0x6F
_0x70:
;     790 	    	resend = 0;
	LDI  R17,LOW(0)
;     791 	    else
	RJMP _0x72
_0x6F:
;     792 	    	resend = 1;
	LDI  R17,LOW(1)
;     793 	}
_0x72:
;     794 	
;     795 	rtl8019Write(TCR, 0x02);
_0x6E:
_0x6D:
	LDI  R30,LOW(13)
	CALL SUBOPT_0x45
;     796 	rtl8019Write(CR, 0x22);
	CALL SUBOPT_0x41
;     797 	rtl8019Write(BNRY, RXSTART_INIT);
	CALL SUBOPT_0x4C
;     798 	rtl8019Write(CR, 0x62);
;     799 	rtl8019Write(CURR, RXSTART_INIT);
	CALL SUBOPT_0x4D
;     800 	rtl8019Write(CR, 0x22);
;     801 	rtl8019Write(ISR, 0x10);
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R30,LOW(16)
	CALL SUBOPT_0x56
;     802 	rtl8019Write(TCR, TCR_INIT);
;     803 	
;     804     if(resend)
	CPI  R17,0
	BREQ _0x73
;     805         rtl8019Write(CR, 0x26);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(38)
	ST   -Y,R30
	CALL _rtl8019Write
;     806 
;     807     rtl8019Write(ISR, 0xFF);
_0x73:
	CALL SUBOPT_0x57
;     808 }
	RJMP _0x17E
;     809 
;     810 
;     811 void rtl8019Init(void)
;     812 {
_rtl8019Init:
;     813 	rtl8019SetupPorts();
	CALL _rtl8019SetupPorts
;     814 	
;     815 	HARD_RESET_RTL8019();
	SBI  0x12,4
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL SUBOPT_0x3D
	CBI  0x12,4
;     816 	                    
;     817 	// do soft reset
;     818 	rtl8019Write( ISR, rtl8019Read(ISR) ) ;
	LDI  R30,LOW(7)
	ST   -Y,R30
	ST   -Y,R30
	CALL _rtl8019Read
	ST   -Y,R30
	CALL _rtl8019Write
;     819 	delay_ms(50);
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	CALL SUBOPT_0x3D
;     820 
;     821     // switch to page 3 to load config registers
;     822     rtl8019Write(CR, 0xE1);
	CALL SUBOPT_0x58
;     823 
;     824     // disable EEPROM write protect of config registers
;     825     rtl8019Write(RTL_EECR, 0xC0);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(192)
	ST   -Y,R30
	CALL _rtl8019Write
;     826 
;     827     // set network type to 10 Base-T link test
;     828     rtl8019Write(CONFIG2, 0x20);
	LDI  R30,LOW(5)
	ST   -Y,R30
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x47
;     829 
;     830     // disable powerdown and sleep
;     831     rtl8019Write(CONFIG3, 0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _rtl8019Write
;     832     delay_ms(255);
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	CALL SUBOPT_0x3D
;     833 
;     834     // reenable EEPROM write protect
;     835     rtl8019Write(RTL_EECR, 0);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL SUBOPT_0x4F
;     836 
;     837     // go back to page 0
;     838     rtl8019Write(CR, 0x21);
	LDI  R30,LOW(33)
	ST   -Y,R30
	CALL SUBOPT_0x4F
;     839 
;     840     rtl8019Write(CR,0x21);       // stop the NIC, abort DMA, page 0
	LDI  R30,LOW(33)
	ST   -Y,R30
	CALL _rtl8019Write
;     841 	delay_ms(2);                 // make sure nothing is coming in or going out
	CALL SUBOPT_0x55
;     842 	rtl8019Write(DCR, DCR_INIT);    // 0x58
	CALL SUBOPT_0x59
;     843 	rtl8019Write(RBCR0,0x00);
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDI  R30,LOW(0)
	CALL SUBOPT_0x4E
;     844 	rtl8019Write(RBCR1,0x00);
;     845 	rtl8019Write(RCR,0x04);
	LDI  R30,LOW(12)
	ST   -Y,R30
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL _rtl8019Write
;     846 	rtl8019Write(TPSR, TXSTART_INIT);
	CALL SUBOPT_0x42
;     847 	rtl8019Write(TCR,0x02);
	LDI  R30,LOW(13)
	CALL SUBOPT_0x45
;     848 	rtl8019Write(PSTART, RXSTART_INIT);
	LDI  R30,LOW(1)
	CALL SUBOPT_0x5A
;     849 	rtl8019Write(BNRY, RXSTART_INIT);
	LDI  R30,LOW(3)
	CALL SUBOPT_0x5A
;     850 	rtl8019Write(PSTOP, RXSTOP_INIT);
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R30,LOW(96)
	ST   -Y,R30
	CALL SUBOPT_0x4F
;     851 	rtl8019Write(CR, 0x61);
	LDI  R30,LOW(97)
	ST   -Y,R30
	CALL _rtl8019Write
;     852 	delay_ms(2);
	CALL SUBOPT_0x55
;     853 	rtl8019Write(CURR, RXSTART_INIT);
	LDI  R30,LOW(7)
	CALL SUBOPT_0x5A
;     854 	
;     855 	rtl8019Write(PAR0+0, eth_mac_addr.addr[0]);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDS  R30,_eth_mac_addr
	ST   -Y,R30
	CALL _rtl8019Write
;     856 	rtl8019Write(PAR0+1, eth_mac_addr.addr[1]);
	LDI  R30,LOW(2)
	ST   -Y,R30
	__GETB1MN _eth_mac_addr,1
	ST   -Y,R30
	CALL _rtl8019Write
;     857 	rtl8019Write(PAR0+2, eth_mac_addr.addr[2]);
	LDI  R30,LOW(3)
	ST   -Y,R30
	__GETB1MN _eth_mac_addr,2
	ST   -Y,R30
	CALL _rtl8019Write
;     858 	rtl8019Write(PAR0+3, eth_mac_addr.addr[3]);
	LDI  R30,LOW(4)
	ST   -Y,R30
	__GETB1MN _eth_mac_addr,3
	ST   -Y,R30
	CALL _rtl8019Write
;     859 	rtl8019Write(PAR0+4, eth_mac_addr.addr[4]);
	LDI  R30,LOW(5)
	ST   -Y,R30
	__GETB1MN _eth_mac_addr,4
	ST   -Y,R30
	CALL SUBOPT_0x47
;     860 	rtl8019Write(PAR0+5, eth_mac_addr.addr[5]);
	__GETB1MN _eth_mac_addr,5
	ST   -Y,R30
	CALL SUBOPT_0x4F
;     861      	  
;     862 	rtl8019Write(CR,0x21);
	LDI  R30,LOW(33)
	ST   -Y,R30
	CALL _rtl8019Write
;     863 	rtl8019Write(DCR, DCR_INIT);
	CALL SUBOPT_0x59
;     864 	rtl8019Write(CR,0x22);
	CALL SUBOPT_0x41
;     865 	rtl8019Write(ISR,0xFF);
	CALL SUBOPT_0x57
;     866 	rtl8019Write(IMR, IMR_INIT);
	LDI  R30,LOW(15)
	ST   -Y,R30
	LDI  R30,LOW(17)
	CALL SUBOPT_0x56
;     867 	rtl8019Write(TCR, TCR_INIT);
;     868 	
;     869 	rtl8019Write(CR, 0x22);	// start the NIC
	CALL SUBOPT_0x41
;     870 }
	RET
;     871 
;     872 
;     873 void rtl8019ProcessInterrupt(void)
;     874 {
_rtl8019ProcessInterrupt:
;     875 	unsigned char byte = 0;
;     876 	byte = rtl8019Read(ISR);	
	ST   -Y,R16
;	byte -> R16
	LDI  R16,0
	LDI  R30,LOW(7)
	CALL SUBOPT_0x53
;     877 	if( byte & (1<<ISR_OVW) )
	SBRS R16,4
	RJMP _0x77
;     878 		rtl8019Overrun();
	CALL _rtl8019Overrun
;     879 }
_0x77:
_0x17F:
	LD   R16,Y+
	RET
;     880 
;     881 void rtl8019DumpReg(void)
;     882 {       
_rtl8019DumpReg:
;     883     unsigned char byte =0, i=0;  
;     884     printf("\r\nREG PAGE0 PAGE1 PAGE2 PAGE3\r\n");
	CALL SUBOPT_0x1F
;	byte -> R16
;	i -> R17
	__POINTW1FN _0,735
	CALL SUBOPT_0x37
;     885     for (i=0; i< 16; i++){      
	LDI  R17,LOW(0)
_0x79:
	CPI  R17,16
	BRSH _0x7A
;     886         printf("%02X  ",i);
	__POINTW1FN _0,767
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R17
	CALL SUBOPT_0x20
	CALL SUBOPT_0x25
;     887              
;     888         rtl8019Write(CR,0x21);
	CALL SUBOPT_0x54
;     889         byte = rtl8019Read(i);	
	CALL SUBOPT_0x5B
;     890         printf("%02X    ",byte);   
	CALL SUBOPT_0x25
;     891         
;     892         rtl8019Write(CR,0x61);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(97)
	ST   -Y,R30
	CALL _rtl8019Write
;     893         byte = rtl8019Read(i);	
	CALL SUBOPT_0x5B
;     894         printf("%02X    ",byte);   
	CALL SUBOPT_0x25
;     895         
;     896         rtl8019Write(CR,0xA1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(161)
	ST   -Y,R30
	CALL _rtl8019Write
;     897         byte = rtl8019Read(i);	
	CALL SUBOPT_0x5B
;     898         printf("%02X    ",byte);   
	CALL SUBOPT_0x25
;     899         
;     900         rtl8019Write(CR,0xE1);
	CALL SUBOPT_0x58
;     901         byte = rtl8019Read(i);	
	CALL SUBOPT_0x5B
;     902         printf("%02X    ",byte);   
	CALL SUBOPT_0x25
;     903         
;     904         printf("\r\n");                
	__POINTW1FN _0,319
	CALL SUBOPT_0x37
;     905     }
	SUBI R17,-1
	RJMP _0x79
_0x7A:
;     906 }
	RJMP _0x17E
;     907 
;     908 void nic_send(unsigned char* buffer, unsigned int len)
;     909 {
_nic_send:
;     910 	rtl8019BeginPacketSend(len);
;	*buffer -> Y+2
;	len -> Y+0
	LD   R30,Y
	LDD  R31,Y+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _rtl8019BeginPacketSend
;     911     rtl8019SendPacketData((unsigned char *)buffer, len);	
	CALL SUBOPT_0x3E
	CALL SUBOPT_0x3E
	CALL _rtl8019SendPacketData
;     912 	rtl8019EndPacketSend();
	CALL _rtl8019EndPacketSend
;     913 }
	ADIW R28,4
	RET
;     914 
;     915 unsigned int nic_poll(unsigned char* buffer)
;     916 {
_nic_poll:
;     917 	unsigned int packetLength;
;     918 	
;     919 	packetLength = rtl8019BeginPacketRetreive();
	ST   -Y,R17
	ST   -Y,R16
;	*buffer -> Y+2
;	packetLength -> R16,R17
	CALL _rtl8019BeginPacketRetreive
	MOVW R16,R30
;     920 
;     921 	// if there's no packet or an error - exit without ending the operation
;     922 	if( !packetLength ){
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x7B
;     923 	    return 0;                      
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x17B
;     924 	}                 
;     925 	if (packetLength==-1){
_0x7B:
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x7C
;     926         rtl8019EndPacketRetreive(); 
	CALL _rtl8019EndPacketRetreive
;     927         return 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x17B
;     928 	}
;     929 
;     930 	// drop anything too big for the buffer
;     931 	if( packetLength > RTL8019_BUFSIZE )
_0x7C:
	__CPWRN 16,17,1501
	BRLO _0x7D
;     932 	{
;     933 	    rtl8019EndPacketRetreive();       
	CALL _rtl8019EndPacketRetreive
;     934         return 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x17B
;     935 	}
;     936 	
;     937 	// copy the packet data into the uIP packet buffer
;     938 	rtl8019RetreivePacketData( buffer, packetLength );
_0x7D:
	CALL SUBOPT_0x3E
	ST   -Y,R17
	ST   -Y,R16
	CALL _rtl8019RetreivePacketData
;     939 	rtl8019EndPacketRetreive();
	CALL _rtl8019EndPacketRetreive
;     940 		
;     941 	return packetLength;		
	MOVW R30,R16
	RJMP _0x17B
;     942 }
;     943 #include "ethernet.h"            
;     944    
;     945 #define ARP_BUF ((struct ARP_HDR *)&netBuffer[0])
;     946 
;     947 #define ARP_REQUEST 1
;     948 #define ARP_REPLY   2
;     949 
;     950 #define ARP_HWTYPE_ETH 1
;     951                                    
;     952 extern struct MAC_ADDRESS eth_src_addr;
;     953 
;     954 unsigned int process_arp_in(void)
;     955 {          
_process_arp_in:
;     956     unsigned int len = 0;
;     957     if(HOST_ADDRESS[0]!=ARP_BUF->dipaddr[0] || HOST_ADDRESS[1]!=ARP_BUF->dipaddr[1]){
	CALL SUBOPT_0x1F
;	len -> R16,R17
	CALL SUBOPT_0x5C
	CALL SUBOPT_0x5D
	BRNE _0x7F
	CALL SUBOPT_0x5E
	__GETW1MN _netBuffer,40
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x7E
_0x7F:
;     958         return 0;   // ivalid IP address
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x17E
;     959     }
;     960     switch(ARP_BUF->opcode) 
_0x7E:
	__GETW1MN _netBuffer,20
;     961     {
;     962     case HTONS(ARP_REQUEST):
	CPI  R30,LOW(0x100)
	LDI  R26,HIGH(0x100)
	CPC  R31,R26
	BRNE _0x84
;     963         {
;     964           ARP_BUF->opcode = HTONS(2);   /* reply code */
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	__PUTW1MN _netBuffer,20
;     965           /* update source mac address....................*/            
;     966           memcpy(eth_src_addr.addr,ARP_BUF->shwaddr.addr,6);
	CALL SUBOPT_0xE
	CALL SUBOPT_0x5F
;     967           
;     968           memcpy(ARP_BUF->dhwaddr.addr, ARP_BUF->shwaddr.addr, 6);
	CALL SUBOPT_0x60
	CALL SUBOPT_0x5F
;     969           memcpy(ARP_BUF->shwaddr.addr, eth_mac_addr.addr, 6);
	CALL SUBOPT_0x61
;     970           memcpy(ARP_BUF->ethhdr.src.addr, eth_mac_addr.addr, 6);
	CALL SUBOPT_0x10
;     971           memcpy(ARP_BUF->ethhdr.dest.addr, ARP_BUF->dhwaddr.addr, 6); 
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x60
	CALL SUBOPT_0xF
;     972           
;     973       
;     974           ARP_BUF->dipaddr[0] = ARP_BUF->sipaddr[0];
	CALL SUBOPT_0x62
	__PUTW1MN _netBuffer,38
;     975           ARP_BUF->dipaddr[1] = ARP_BUF->sipaddr[1];
	CALL SUBOPT_0x63
	CALL SUBOPT_0x64
;     976           ARP_BUF->sipaddr[0] = HOST_ADDRESS[0];
;     977           ARP_BUF->sipaddr[1] = HOST_ADDRESS[1];
	CALL SUBOPT_0x4
;     978 
;     979           ARP_BUF->ethhdr.type = HTONS(NET_ETHTYPE_ARP);   
	CALL SUBOPT_0x65
;     980           len = sizeof(struct ARP_HDR);   
	__GETWRN 16,17,42
;     981         }      
;     982         break;
	RJMP _0x83
;     983     case HTONS(ARP_REPLY):           
_0x84:
	CPI  R30,LOW(0x200)
	LDI  R26,HIGH(0x200)
	CPC  R31,R26
	BRNE _0x83
;     984         /* update source mac address....................*/            
;     985         memcpy(eth_src_addr.addr,ARP_BUF->shwaddr.addr,6);
	CALL SUBOPT_0xE
	CALL SUBOPT_0x5F
;     986         break;
;     987     }    
_0x83:
;     988     
;     989     return (unsigned int)len;
	MOVW R30,R16
_0x17E:
	LD   R16,Y+
	LD   R17,Y+
	RET
;     990 }                                                
;     991 
;     992 unsigned int process_arp_out(void)
;     993 {    
_process_arp_out:
;     994     unsigned char i =0;
;     995     unsigned int len =0;
;     996         
;     997     for (i=0;i<6;i++){
	CALL __SAVELOCR3
;	i -> R16
;	len -> R17,R18
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R16,LOW(0)
_0x87:
	CPI  R16,6
	BRSH _0x88
;     998         if (eth_src_addr.addr[i]!=0){
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_eth_src_addr)
	SBCI R31,HIGH(-_eth_src_addr)
	LD   R30,Z
	CPI  R30,0
	BRNE _0x88
;     999             break;
;    1000         }
;    1001     }    
	SUBI R16,-1
	RJMP _0x87
_0x88:
;    1002     if (i>=6){               
	CPI  R16,6
	BRLO _0x8A
;    1003         memcpy(ARP_BUF->ethhdr.src.addr, eth_mac_addr.addr, 6);
	CALL SUBOPT_0x10
;    1004         memset(ARP_BUF->ethhdr.dest.addr, 0xFF, 6); 
	CALL SUBOPT_0x3A
	LDI  R30,LOW(255)
	CALL SUBOPT_0x66
;    1005         ARP_BUF->ethhdr.type = HTONS(NET_ETHTYPE_ARP);  
	CALL SUBOPT_0x65
;    1006 
;    1007         ARP_BUF->hwtype = HTONS(0x0001);
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	__PUTW1MN _netBuffer,14
;    1008         ARP_BUF->protocol = HTONS(0x0800);
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	__PUTW1MN _netBuffer,16
;    1009         ARP_BUF->hwlen = (0x06);
	LDI  R30,LOW(6)
	__PUTB1MN _netBuffer,18
;    1010         ARP_BUF->protolen = (0x04);
	LDI  R30,LOW(4)
	__PUTB1MN _netBuffer,19
;    1011         ARP_BUF->opcode = HTONS(1);   
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	__PUTW1MN _netBuffer,20
;    1012                     
;    1013         memset(ARP_BUF->dhwaddr.addr, 0x00, 6);
	CALL SUBOPT_0x60
	LDI  R30,LOW(0)
	CALL SUBOPT_0x66
;    1014         memcpy(ARP_BUF->shwaddr.addr, eth_mac_addr.addr, 6);            
	CALL SUBOPT_0x61
;    1015                 
;    1016         ARP_BUF->dipaddr[0] = SERVER_ADDRESS[0];
	CALL SUBOPT_0x3
	__PUTW1MN _netBuffer,38
;    1017         ARP_BUF->dipaddr[1] = SERVER_ADDRESS[1];
	CALL SUBOPT_0x7
	CALL SUBOPT_0x64
;    1018         ARP_BUF->sipaddr[0] = HOST_ADDRESS[0];
;    1019         ARP_BUF->sipaddr[1] = HOST_ADDRESS[1];
	CALL SUBOPT_0x4
;    1020 
;    1021         ARP_BUF->ethhdr.type = HTONS(NET_ETHTYPE_ARP);   
	CALL SUBOPT_0x65
;    1022         len = sizeof(struct ARP_HDR);              
	__GETWRN 17,18,42
;    1023     }
;    1024     return (unsigned int)len;
_0x8A:
	__GETW1R 17,18
	CALL __LOADLOCR3
	ADIW R28,3
	RET
;    1025 }
;    1026 #include "ethernet.h"
;    1027 
;    1028 unsigned int process_icmp(unsigned int rcv_len);
;    1029 unsigned int process_tcp(unsigned int rcv_len);
;    1030 unsigned int process_udp(unsigned int rcv_len);
;    1031                                               
;    1032 extern unsigned int process_udp_data(unsigned char* udpdata, unsigned int rcv_len);
;    1033 extern unsigned int process_udp_conf(unsigned char* udpdata, unsigned int rcv_len);
;    1034 
;    1035 unsigned int cal_chksum(unsigned int *sdata, unsigned int len)
;    1036 {
_cal_chksum:
;    1037     unsigned int acc;
;    1038   
;    1039     for(acc = 0; len > 1; len -= 2) {
	ST   -Y,R17
	ST   -Y,R16
;	*sdata -> Y+4
;	len -> Y+2
;	acc -> R16,R17
	__GETWRN 16,17,0
_0x8C:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,2
	BRLO _0x8D
;    1040         acc += *sdata;
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	__ADDWRR 16,17,30,31
;    1041         if(acc < *sdata) {
	CALL __GETW1P
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x8E
;    1042             ++acc;
	__ADDWRN 16,17,1
;    1043         }
;    1044         ++sdata;
_0x8E:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,2
	STD  Y+4,R30
	STD  Y+4+1,R31
;    1045     }
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,2
	STD  Y+2,R30
	STD  Y+2+1,R31
	RJMP _0x8C
_0x8D:
;    1046     if(len == 1) {
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,1
	BRNE _0x8F
;    1047         acc += HTONS(((unsigned int)(*(unsigned char *)sdata)) << 8);
	CALL SUBOPT_0x67
	CALL SUBOPT_0x68
	__ADDWRR 16,17,30,31
;    1048         if(acc < HTONS(((unsigned int)(*(unsigned char *)sdata)) << 8)) {
	CALL SUBOPT_0x67
	CALL SUBOPT_0x68
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x90
;    1049             ++acc;
	__ADDWRN 16,17,1
;    1050         }
;    1051     }
_0x90:
;    1052 
;    1053     return acc;
_0x8F:
	MOVW R30,R16
_0x17D:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;    1054 }
;    1055 
;    1056 unsigned int ip_chksum(void)
;    1057 {                               
_ip_chksum:
;    1058     return cal_chksum(&netBuffer[NET_LLH_LEN],20);
	__POINTW1MN _netBuffer,14
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	CALL SUBOPT_0x69
	RET
;    1059 }
;    1060 
;    1061 unsigned int icmp_chksum(void)
;    1062 {                               
_icmp_chksum:
;    1063     return cal_chksum(&netBuffer[NET_LLH_LEN+20],40);
	__POINTW1MN _netBuffer,34
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(40)
	LDI  R31,HIGH(40)
	CALL SUBOPT_0x69
	RET
;    1064 }                                                                
;    1065 
;    1066 unsigned int trans_chksum(unsigned int hdr_len, unsigned int proto)
;    1067 {                
_trans_chksum:
;    1068     unsigned int hsum, sum;
;    1069   
;    1070   /* Compute the checksum of the UDP header. */
;    1071     hsum = cal_chksum((unsigned int *)&netBuffer[20 + NET_LLH_LEN], hdr_len);
	CALL __SAVELOCR4
;	hdr_len -> Y+6
;	proto -> Y+4
;	hsum -> R16,R17
;	sum -> R18,R19
	__POINTW1MN _netBuffer,34
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	CALL SUBOPT_0x69
	MOVW R16,R30
;    1072 
;    1073   /* Compute the checksum of the data in the UDP packet and add it to
;    1074      the UDP header checksum. */
;    1075     sum = cal_chksum((unsigned int *)&netBuffer[20 + NET_LLH_LEN + hdr_len],
;    1076 		   (unsigned int)(((((unsigned int)(BUF->len[0]) << 8) + BUF->len[1]) - (20+hdr_len))));
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	__ADDW1MN _netBuffer,34
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x6A
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,20
	SUB  R26,R30
	SBC  R27,R31
	ST   -Y,R27
	ST   -Y,R26
	CALL _cal_chksum
	MOVW R18,R30
;    1077 
;    1078     if((sum += hsum) < hsum) {
	CALL SUBOPT_0x6B
	BRSH _0x91
;    1079         ++sum;
	__ADDWRN 18,19,1
;    1080     }
;    1081   
;    1082     if((sum += BUF->srcipaddr[0]) < BUF->srcipaddr[0]) {
_0x91:
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x6C
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x92
;    1083         ++sum;
	__ADDWRN 18,19,1
;    1084     }
;    1085     if((sum += BUF->srcipaddr[1]) < BUF->srcipaddr[1]) {
_0x92:
	CALL SUBOPT_0x62
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x62
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x93
;    1086         ++sum;
	__ADDWRN 18,19,1
;    1087     }
;    1088     if((sum += BUF->destipaddr[0]) < BUF->destipaddr[0]) {
_0x93:
	CALL SUBOPT_0x63
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x63
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x94
;    1089         ++sum;
	__ADDWRN 18,19,1
;    1090     }
;    1091     if((sum += BUF->destipaddr[1]) < BUF->destipaddr[1]) {
_0x94:
	CALL SUBOPT_0x6E
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x6E
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x95
;    1092         ++sum;
	__ADDWRN 18,19,1
;    1093     }
;    1094     if((sum += (unsigned int)HTONS(proto)) < (unsigned int)HTONS(proto)) {
_0x95:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0xA
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0xB
	ADD  R30,R18
	ADC  R31,R19
	MOVW R18,R30
	MOVW R0,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0xA
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0xB
	CP   R0,R30
	CPC  R1,R31
	BRSH _0x96
;    1095         ++sum;
	__ADDWRN 18,19,1
;    1096     }
;    1097 
;    1098     hsum = (unsigned int)HTONS((((unsigned int)(BUF->len[0]) << 8) + BUF->len[1]) - 20);
_0x96:
	CALL SUBOPT_0x6A
	SBIW R26,20
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	AND  R30,R26
	AND  R31,R27
	MOV  R31,R30
	LDI  R30,0
	MOVW R0,R30
	CALL SUBOPT_0x6A
	SBIW R26,20
	LDI  R30,LOW(65280)
	LDI  R31,HIGH(65280)
	AND  R30,R26
	AND  R31,R27
	MOV  R30,R31
	LDI  R31,0
	OR   R30,R0
	OR   R31,R1
	MOVW R16,R30
;    1099   
;    1100     if((sum += hsum) < hsum) {
	CALL SUBOPT_0x6B
	BRSH _0x97
;    1101         ++sum;
	__ADDWRN 18,19,1
;    1102     }
;    1103   
;    1104     return sum;
_0x97:
	MOVW R30,R18
_0x17C:
	CALL __LOADLOCR4
	ADIW R28,8
	RET
;    1105 }
;    1106 
;    1107 unsigned int udp_chksum(void)
;    1108 {
_udp_chksum:
;    1109      return trans_chksum(8,IP_PROTO_UDP);                
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(17)
	LDI  R31,HIGH(17)
	ST   -Y,R31
	ST   -Y,R30
	CALL _trans_chksum
	RET
;    1110 }
;    1111 
;    1112 unsigned int tcp_chksum(void)
;    1113 {
_tcp_chksum:
;    1114      return trans_chksum(20,IP_PROTO_TCP);
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	CALL _trans_chksum
	RET
;    1115 }
;    1116  
;    1117 unsigned int process_ip_in(unsigned int rcv_len)
;    1118 {
_process_ip_in:
;    1119     unsigned int len = 0;
;    1120     switch(BUF->proto)
	CALL SUBOPT_0x1F
;	rcv_len -> Y+2
;	len -> R16,R17
	__GETB1MN _netBuffer,23
;    1121     {
;    1122     case IP_PROTO_ICMP:
	CPI  R30,LOW(0x1)
	BRNE _0x9B
;    1123         len = process_icmp(rcv_len);
	CALL SUBOPT_0x3E
	RCALL _process_icmp
	RJMP _0x181
;    1124         break;
;    1125     case IP_PROTO_TCP:             
_0x9B:
	CPI  R30,LOW(0x6)
	BRNE _0x9C
;    1126         len = process_tcp(rcv_len);
	CALL SUBOPT_0x3E
	RCALL _process_tcp
	RJMP _0x181
;    1127         break;
;    1128     case IP_PROTO_UDP:             
_0x9C:
	CPI  R30,LOW(0x11)
	BRNE _0x9A
;    1129         len = process_udp(rcv_len);
	CALL SUBOPT_0x3E
	RCALL _process_udp
_0x181:
	MOVW R16,R30
;    1130         break;
;    1131     }
_0x9A:
;    1132     return (unsigned int)len;
	MOVW R30,R16
_0x17B:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
;    1133 }
;    1134 
;    1135 unsigned int process_icmp(unsigned int rcv_len)
;    1136 {        
_process_icmp:
;    1137     unsigned char i =0; 
;    1138     unsigned int tmp16 =0;
;    1139                           
;    1140     if (ICMPBUF->type != ICMP_ECHO){
	CALL __SAVELOCR3
;	rcv_len -> Y+3
;	i -> R16
;	tmp16 -> R17,R18
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	__GETB1MN _netBuffer,34
	CPI  R30,LOW(0x8)
	BREQ _0x9E
;    1141         return 0;   // process PING only
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x17A
;    1142     } 
;    1143     if(HOST_ADDRESS[0]!=ICMPBUF->destipaddr[0] || HOST_ADDRESS[1]!=ICMPBUF->destipaddr[1]){
_0x9E:
	CALL SUBOPT_0x63
	CALL SUBOPT_0x5D
	BRNE _0xA0
	CALL SUBOPT_0x5E
	CALL SUBOPT_0x6E
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x9F
_0xA0:
;    1144         return 0;   // ivalid IP address
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x17A
;    1145     }
;    1146     if (SERVER_ADDRESS[0]!=ICMPBUF->srcipaddr[0] || SERVER_ADDRESS[1]!=ICMPBUF->srcipaddr[1]){
_0x9F:
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6F
	BRNE _0xA3
	CALL SUBOPT_0x70
	CP   R30,R26
	CPC  R31,R27
	BREQ _0xA2
_0xA3:
;    1147         return 0;   // ip banned!!!
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x17A
;    1148     }                 
;    1149     if (icmp_chksum()!=0xFFFF){
_0xA2:
	CALL _icmp_chksum
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BREQ _0xA5
;    1150         return 0;      
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x17A
;    1151     }
;    1152                 
;    1153     ICMPBUF->type = ICMP_ECHO_REPLY;
_0xA5:
	LDI  R30,LOW(0)
	__PUTB1MN _netBuffer,34
;    1154     
;    1155     if(ICMPBUF->icmpchksum >= HTONS(0xffff - (ICMP_ECHO << 8))) {
	__GETW2MN _netBuffer,36
	CPI  R26,LOW(0xFFF7)
	LDI  R30,HIGH(0xFFF7)
	CPC  R27,R30
	BRLO _0xA6
;    1156         ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8) + 1;
	__POINTW2MN _netBuffer,36
	LD   R30,X+
	LD   R31,X+
	ADIW R30,9
	RJMP _0x182
;    1157     } else {
_0xA6:
;    1158         ICMPBUF->icmpchksum += HTONS(ICMP_ECHO << 8);
	__POINTW2MN _netBuffer,36
	LD   R30,X+
	LD   R31,X+
	ADIW R30,8
_0x182:
	ST   -X,R31
	ST   -X,R30
;    1159     }
;    1160     
;    1161     /* Swap IP addresses. */
;    1162     tmp16 = BUF->destipaddr[0];
	__GETWRMN 17,18,_netBuffer,30
;    1163     ICMPBUF->destipaddr[0] = ICMPBUF->srcipaddr[0];
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x4
;    1164     ICMPBUF->srcipaddr[0] = HOST_ADDRESS[0];
	CALL SUBOPT_0x5
	CALL SUBOPT_0x6
;    1165     tmp16 = ICMPBUF->destipaddr[1];
	__GETWRMN 17,18,_netBuffer,32
;    1166     ICMPBUF->destipaddr[1] = ICMPBUF->srcipaddr[1];
	CALL SUBOPT_0x62
	CALL SUBOPT_0x8
;    1167     ICMPBUF->srcipaddr[1] = HOST_ADDRESS[1];    
;    1168     
;    1169     /* Build an ethernet header. */
;    1170     memcpy(IPBUF->ethhdr.dest.addr,IPBUF->ethhdr.src.addr,6);    
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x71
;    1171     memcpy(IPBUF->ethhdr.src.addr,eth_mac_addr.addr,6);                                       
	CALL SUBOPT_0x10
;    1172     
;    1173     return (unsigned int)rcv_len;
	LDD  R30,Y+3
	LDD  R31,Y+3+1
_0x17A:
	CALL __LOADLOCR3
	ADIW R28,5
	RET
;    1174 }
;    1175                               
;    1176 unsigned int process_tcp(unsigned int rcv_len)
;    1177 {
_process_tcp:
;    1178     if(HOST_ADDRESS[0]!=TCPBUF->destipaddr[0] || HOST_ADDRESS[1]!=TCPBUF->destipaddr[1]){
;	rcv_len -> Y+0
	CALL SUBOPT_0x63
	CALL SUBOPT_0x5D
	BRNE _0xA9
	CALL SUBOPT_0x5E
	CALL SUBOPT_0x6E
	CP   R30,R26
	CPC  R31,R27
	BREQ _0xA8
_0xA9:
;    1179         return 0;   // ivalid IP address
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x179
;    1180     }
;    1181     if (SERVER_ADDRESS[0]!=TCPBUF->srcipaddr[0] || SERVER_ADDRESS[1]!=TCPBUF->srcipaddr[1]){
_0xA8:
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6F
	BRNE _0xAC
	CALL SUBOPT_0x70
	CP   R30,R26
	CPC  R31,R27
	BREQ _0xAB
_0xAC:
;    1182         return 0;   // ip banned!!!
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x179
;    1183     }                    
;    1184     if (tcp_chksum()!=0xFFFF){
_0xAB:
	CALL _tcp_chksum
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BREQ _0xAE
;    1185         return 0; // drop packet
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x179
;    1186     }       
;    1187     TCPBUF->tcpchksum =0;                                                      
_0xAE:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _netBuffer,50
;    1188     return (unsigned int)rcv_len;                                         
	LD   R30,Y
	LDD  R31,Y+1
_0x179:
	ADIW R28,2
	RET
;    1189 }
;    1190 
;    1191 unsigned int process_udp(unsigned int rcv_len)
;    1192 {
_process_udp:
;    1193     unsigned int len =0;  
;    1194     unsigned int tmp16 =0;  
;    1195     
;    1196     if((HOST_ADDRESS[0])!=(UDPBUF->destipaddr[0]) || (HOST_ADDRESS[1])!=(UDPBUF->destipaddr[1])){
	CALL SUBOPT_0x0
;	rcv_len -> Y+4
;	len -> R16,R17
;	tmp16 -> R18,R19
	CALL SUBOPT_0x63
	CALL SUBOPT_0x5D
	BRNE _0xB0
	CALL SUBOPT_0x5E
	CALL SUBOPT_0x6E
	CP   R30,R26
	CPC  R31,R27
	BREQ _0xAF
_0xB0:
;    1197         if ((0xFFFF) != (UDPBUF->destipaddr[0]) || (0xFFFF) != (UDPBUF->destipaddr[1])){
	CALL SUBOPT_0x63
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0xB3
	CALL SUBOPT_0x6E
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BREQ _0xB2
_0xB3:
;    1198             return 0;                                                                      
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x178
;    1199         }
;    1200     }
_0xB2:
;    1201     if (udp_chksum()!=0xFFFF){     
_0xAF:
	CALL _udp_chksum
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BREQ _0xB5
;    1202         return 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x178
;    1203     }                 
;    1204     len = NET_LLH_LEN + sizeof(UDPIP_HDR);                                     
_0xB5:
	__GETWRN 16,17,42
;    1205     if (UDPBUF->destport == HTONS(CONFIG_PORT)){  
	__GETW1MN _netBuffer,36
	CPI  R30,LOW(0xFE03)
	LDI  R26,HIGH(0xFE03)
	CPC  R31,R26
	BRNE _0xB6
;    1206         len += UDP_CONFIG((unsigned char*)(&netBuffer[NET_LLH_LEN]+sizeof(UDPIP_HDR)),HTONS(UDPBUF->udplen)-8);
	CALL SUBOPT_0x1
	CALL SUBOPT_0x5C
	CALL SUBOPT_0xA
	CALL SUBOPT_0x5C
	CALL SUBOPT_0xB
	SBIW R30,8
	ST   -Y,R31
	ST   -Y,R30
	CALL _process_udp_conf
	__ADDWRR 16,17,30,31
;    1207         tmp16 = UDPBUF->destipaddr[0];
	__GETWRMN 18,19,_netBuffer,30
;    1208         UDPBUF->destipaddr[0] = UDPBUF->srcipaddr[0];
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x4
;    1209         UDPBUF->srcipaddr[0] = HOST_ADDRESS[0];
	CALL SUBOPT_0x5
	CALL SUBOPT_0x6
;    1210         tmp16 = UDPBUF->destipaddr[1];
	__GETWRMN 18,19,_netBuffer,32
;    1211         UDPBUF->destipaddr[1] = UDPBUF->srcipaddr[1];
	CALL SUBOPT_0x62
	CALL SUBOPT_0x8
;    1212         UDPBUF->srcipaddr[1] = HOST_ADDRESS[1];  
;    1213         tmp16 = UDPBUF->srcport;
	__GETWRMN 18,19,_netBuffer,34
;    1214         UDPBUF->srcport = UDPBUF->destport;  
	__GETW1MN _netBuffer,36
	__PUTW1MN _netBuffer,34
;    1215         UDPBUF->destport = tmp16;        
	__PUTWMRN _netBuffer,36,18,19
;    1216         UDPBUF->udplen = HTONS(len - (NET_LLH_LEN + 20));    
	CALL SUBOPT_0xC
;    1217                
;    1218         tmp16 = len - NET_LLH_LEN;
;    1219         UDPBUF->len[0] = tmp16>>8;
;    1220         UDPBUF->len[1] = tmp16&0xFF;
;    1221 
;    1222         UDPBUF->udpchksum =0;  
;    1223         UDPBUF->udpchksum = ~udp_chksum();    
;    1224         UDPBUF->ipchksum = 0;
;    1225         UDPBUF->ipchksum = ~ip_chksum();
	CALL SUBOPT_0xD
;    1226         
;    1227         memcpy(IPBUF->ethhdr.dest.addr,IPBUF->ethhdr.src.addr,6);    
	CALL SUBOPT_0x71
;    1228         memcpy(IPBUF->ethhdr.src.addr,eth_mac_addr.addr,6);   
	CALL SUBOPT_0x10
;    1229     }
;    1230     else if (UDPBUF->destport == HTONS(CLIENT_PORT)){        
	RJMP _0xB7
_0xB6:
	CALL SUBOPT_0x9
	__GETW2MN _netBuffer,36
	CP   R30,R26
	CPC  R31,R27
	BRNE _0xB8
;    1231         if (SERVER_ADDRESS[0]!=UDPBUF->srcipaddr[0] || SERVER_ADDRESS[1]!=UDPBUF->srcipaddr[1]){
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6F
	BRNE _0xBA
	CALL SUBOPT_0x70
	CP   R30,R26
	CPC  R31,R27
	BREQ _0xB9
_0xBA:
;    1232             return 0;   // ip banned!!!
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x178
;    1233         }                            
;    1234         len += UDP_APPCALL((unsigned char*)(&netBuffer[NET_LLH_LEN]+sizeof(UDPIP_HDR)),HTONS(UDPBUF->udplen)-8);
_0xB9:
	CALL SUBOPT_0x1
	CALL SUBOPT_0x5C
	CALL SUBOPT_0xA
	CALL SUBOPT_0x5C
	CALL SUBOPT_0xB
	SBIW R30,8
	ST   -Y,R31
	ST   -Y,R30
	CALL _process_udp_data
	__ADDWRR 16,17,30,31
;    1235         len =0; // drop all data, don't echo to host   
;    1236     }            
;    1237     else{
_0xB8:
;    1238         len =0; // drop all data, don't echo to host   
_0x183:
	__GETWRN 16,17,0
;    1239     }
_0xB7:
;    1240     return (unsigned int)len;    
	MOVW R30,R16
_0x178:
	CALL __LOADLOCR4
	ADIW R28,6
	RET
;    1241 }    
;    1242 #include "define.h"
;    1243 
;    1244 ///////////////////////////////////////////////////////////////
;    1245 // serial interrupt handle - processing serial message ...
;    1246 ///////////////////////////////////////////////////////////////
;    1247 // [0x55][0x55][0x55][rx_message][rx_wparam][rx_lparam]
;    1248 ///////////////////////////////////////////////////////////////
;    1249 extern BYTE rx_buffer[RX_BUFFER_SIZE];
;    1250 extern BYTE  rx_message;
;    1251 extern WORD  rx_wparam;
;    1252 extern WORD  rx_lparam;
;    1253 
;    1254 #if RX_BUFFER_SIZE<256
;    1255 unsigned char rx_wr_index,rx_counter;
;    1256 #else
;    1257 unsigned int rx_wr_index,rx_counter;
;    1258 #endif
;    1259 
;    1260 void send_echo_msg();
;    1261 
;    1262 // USART Receiver interrupt service routine
;    1263 #ifdef _MEGA162_INCLUDED_                    
;    1264 interrupt [USART0_RXC] void usart_rx_isr(void)
;    1265 #else
;    1266 interrupt [USART_RXC] void usart_rx_isr(void)
;    1267 #endif
;    1268 {
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
;    1269 char status,data;
;    1270 #ifdef _MEGA162_INCLUDED_  
;    1271 status=UCSR0A;
;    1272 data=UDR0;
;    1273 #else     
;    1274 status=UCSRA;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;    1275 data=UDR;
	IN   R17,12
;    1276 #endif          
;    1277     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BRNE _0xBD
;    1278     {
;    1279         rx_buffer[rx_wr_index]=data; 
	MOV  R26,R13
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer)
	SBCI R27,HIGH(-_rx_buffer)
	ST   X,R17
;    1280         if (++rx_wr_index == RX_BUFFER_SIZE){
	INC  R13
	LDI  R30,LOW(8)
	CP   R30,R13
	BRNE _0xBE
;    1281             rx_wr_index=0;
	CLR  R13
;    1282         }                         
;    1283         rx_wparam = 0;    
_0xBE:
	CLR  R9
	CLR  R10
;    1284         rx_lparam = ++rx_counter; 
	INC  R14
	MOV  R11,R14
	CLR  R12
;    1285         if (rx_counter == RX_BUFFER_SIZE)
	LDI  R30,LOW(8)
	CP   R30,R14
	BRNE _0xBF
;    1286         {            
;    1287             rx_message=DATA_INCOMMING;              
	LDI  R30,LOW(1)
	MOV  R8,R30
;    1288             rx_counter=0;
	CLR  R14
;    1289         }       
;    1290     }
_0xBF:
;    1291 }
_0xBD:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;    1292 
;    1293 void send_echo_msg()
;    1294 {
;    1295     putchar(WAKEUP_CHAR);
;    1296     putchar(WAKEUP_CHAR);
;    1297     putchar(WAKEUP_CHAR);                
;    1298     putchar(rx_message);
;    1299     putchar(rx_wparam>>8);
;    1300     putchar(rx_wparam&0x00FF);
;    1301     putchar(rx_lparam>>8);        
;    1302     putchar(rx_lparam&0x00FF);
;    1303 }  
;    1304 
;    1305 void reset_serial()
;    1306 {
_reset_serial:
;    1307     rx_wr_index =0;
	CLR  R13
;    1308     rx_counter  =0;
	CLR  R14
;    1309     rx_wparam   =0;
	CLR  R9
	CLR  R10
;    1310     rx_lparam   =0;
	CLR  R11
	CLR  R12
;    1311     rx_message  =UNKNOWN_MSG;
	CLR  R8
;    1312 }
	RET
;    1313 
;    1314 ///////////////////////////////////////////////////////////////
;    1315 // END serial interrupt handle
;    1316 /////////////////////////////////////////////////////////////// 
;    1317 /*****************************************************
;    1318 This program was produced by the
;    1319 CodeWizardAVR V1.24.4a Standard
;    1320 Automatic Program Generator
;    1321 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;    1322 http://www.hpinfotech.com
;    1323 e-mail:office@hpinfotech.com
;    1324 
;    1325 Project : 
;    1326 Version : 
;    1327 Date    : 19/5/2005
;    1328 Author  : 3iGROUP                
;    1329 Company : http://www.3ihut.net   
;    1330 Comments: 
;    1331 
;    1332 
;    1333 Chip type           : ATmega8515
;    1334 Program type        : Application
;    1335 Clock frequency     : 8.000000 MHz
;    1336 Memory model        : Small
;    1337 External SRAM size  : 32768
;    1338 Ext. SRAM wait state: 0
;    1339 Data Stack size     : 128
;    1340 *****************************************************/
;    1341 
;    1342 #include "define.h"                                           
;    1343 
;    1344 #define     ACK                 1
;    1345 #define     NO_ACK              0
;    1346 
;    1347 // I2C Bus functions
;    1348 #asm
;    1349    .equ __i2c_port=0x15 ;PORTC
   .equ __i2c_port=0x15 ;PORTC
;    1350    .equ __sda_bit=1
   .equ __sda_bit=1
;    1351    .equ __scl_bit=0
   .equ __scl_bit=0
;    1352 #endasm                   
;    1353 
;    1354 #ifdef __EEPROM_WRITE_BYTE
;    1355 BYTE eeprom_read(BYTE deviceID, PBYTE address) 
;    1356 {
_eeprom_read:
;    1357     BYTE data;
;    1358     i2c_start();
	ST   -Y,R16
;	deviceID -> Y+3
;	*address -> Y+1
;	data -> R16
	CALL SUBOPT_0x72
;    1359     i2c_write(deviceID);        // issued R/W = 0
;    1360 #ifdef _24C256    
;    1361     i2c_write((WORD)address>>8);      // high word address
;    1362 #endif    
;    1363     i2c_write((WORD)address&0x0FF);   // low word address
;    1364     
;    1365     i2c_start();
	CALL _i2c_start
;    1366     i2c_write(deviceID | 1);    // issued R/W = 1
	LDD  R30,Y+3
	ORI  R30,1
	ST   -Y,R30
	CALL _i2c_write
;    1367     data=i2c_read(NO_ACK);      // read at current
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _i2c_read
	MOV  R16,R30
;    1368     i2c_stop();
	CALL _i2c_stop
;    1369     return data;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0x176
;    1370 }
;    1371 
;    1372 void eeprom_write(BYTE deviceID, PBYTE address, BYTE data) 
;    1373 {
_eeprom_write:
;    1374     i2c_start();
;	deviceID -> Y+3
;	*address -> Y+1
;	data -> Y+0
	CALL SUBOPT_0x72
;    1375     i2c_write(deviceID);        // device address
;    1376 #ifdef _24C256    
;    1377     i2c_write((WORD)address>>8);      // high word address
;    1378 #endif    
;    1379     i2c_write((WORD)address&0x0FF);   // low word address
;    1380     i2c_write(data);
	LD   R30,Y
	ST   -Y,R30
	CALL _i2c_write
;    1381     i2c_stop();
	CALL _i2c_stop
;    1382 
;    1383     /* 10ms delay to complete the write operation */
;    1384     delay_ms(10);               // 2 ticks : 5x2 = 10 ms        
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL SUBOPT_0x3D
;    1385 }                                 
	RJMP _0x176
;    1386 
;    1387 WORD eeprom_read_w(BYTE deviceID, PBYTE address)
;    1388 {
_eeprom_read_w:
;    1389     WORD result = 0;
;    1390     result = eeprom_read(deviceID,address);
	CALL SUBOPT_0x1F
;	deviceID -> Y+4
;	*address -> Y+2
;	result -> R16,R17
	CALL SUBOPT_0x73
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_read
	MOV  R16,R30
	CLR  R17
;    1391     result = (result<<8) | eeprom_read(deviceID,address+1);
	MOV  R31,R16
	LDI  R30,LOW(0)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x73
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
;    1392     return result;
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x177
;    1393 }
;    1394 void eeprom_write_w(BYTE deviceID, PBYTE address, WORD data)
;    1395 {
_eeprom_write_w:
;    1396     eeprom_write(deviceID,address,data>>8);
;	deviceID -> Y+4
;	*address -> Y+2
;	data -> Y+0
	CALL SUBOPT_0x73
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _eeprom_write
;    1397     eeprom_write(deviceID,address+1,data&0x0FF);    
	CALL SUBOPT_0x73
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	CALL _eeprom_write
;    1398 }
_0x177:
	ADIW R28,5
	RET
;    1399 
;    1400 #endif // __EEPROM_WRITE_BYTE
;    1401 void eeprom_read_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
;    1402 {
;    1403     BYTE i = 0;
;    1404     i2c_start();
;	deviceID -> Y+6
;	*address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
;    1405     i2c_write(deviceID);                  // issued R/W = 0  
;    1406 #ifdef _24C256        
;    1407     i2c_write((WORD)address>>8);          // high word address
;    1408 #endif    
;    1409     i2c_write((WORD)address&0xFF);        // low word address
;    1410     
;    1411     i2c_start();
;    1412     i2c_write(deviceID | 1);        // issued R/W = 1
;    1413                                     
;    1414     while ( i < page_size-1 )
;    1415     {
;    1416         buffer[i++] = i2c_read(ACK);   // read at current
;    1417     }
;    1418     buffer[page_size-1] = i2c_read(NO_ACK); // read last byte
;    1419          
;    1420     i2c_stop();
;    1421 }
;    1422 
;    1423 void eeprom_write_page(BYTE deviceID, PBYTE address, PBYTE buffer, BYTE page_size)
;    1424 {
;    1425     BYTE i = 0;
;    1426     i2c_start();
;	deviceID -> Y+6
;	*address -> Y+4
;	*buffer -> Y+2
;	page_size -> Y+1
;	i -> R16
;    1427     i2c_write(deviceID);            // issued R/W = 0
;    1428 #ifdef _24C256        
;    1429     i2c_write((WORD)address>>8);          // high word address
;    1430 #endif    
;    1431     i2c_write((WORD)address&0xFF);        // low word address
;    1432                                         
;    1433     while ( i < page_size )
;    1434     {
;    1435         i2c_write(buffer[i++]);
;    1436         #asm("nop");#asm("nop");
;    1437     }          
;    1438     i2c_stop(); 
;    1439     delay_ms(10);
;    1440 }
;    1441                                               
;    1442 #include "ethernet.h"
;    1443 
;    1444 typedef struct _CONFIG_MSG
;    1445 {
;    1446     unsigned int type;
;    1447     unsigned char mac_addr[6];
;    1448     unsigned int HOST_ADDRESS[2];
;    1449     unsigned int SERVER_ADDRESS[2];
;    1450     unsigned int SUBNET_MASK[2];
;    1451     unsigned int CLIENT_PORT;    
;    1452     unsigned int SERVER_PORT;
;    1453         
;    1454 } CONFIG_MSG;
;    1455                 
;    1456 extern void SaveConfig();
;    1457 
;    1458 unsigned int process_udp_conf(unsigned char* udpdata, unsigned int rcv_len)
;    1459 {                         
_process_udp_conf:
;    1460     if (rcv_len ==sizeof(CONFIG_MSG)){                       
;	*udpdata -> Y+2
;	rcv_len -> Y+0
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,24
	BREQ PC+3
	JMP _0xC6
;    1461         CONFIG_MSG* msg = NULL;
;    1462         msg = (CONFIG_MSG*)udpdata;
	CALL SUBOPT_0x39
	LDI  R30,LOW(_0xC7*2)
	LDI  R31,HIGH(_0xC7*2)
	CALL __INITLOCB
;	*udpdata -> Y+4
;	rcv_len -> Y+2
;	*msg -> Y+0
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   Y,R30
	STD  Y+1,R31
;    1463         if (msg->type ==0){  // set config           
	LD   R26,Y
	LDD  R27,Y+1
	CALL __GETW1P
	SBIW R30,0
	BREQ PC+3
	JMP _0xC8
;    1464             memcpy(eth_mac_addr.addr,msg->mac_addr,6); 
	LDI  R30,LOW(_eth_mac_addr)
	LDI  R31,HIGH(_eth_mac_addr)
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xF
;    1465             HOST_ADDRESS[0] = msg->HOST_ADDRESS[0];
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,8
	CALL __GETW1P
	CALL SUBOPT_0x1B
;    1466             HOST_ADDRESS[1] = msg->HOST_ADDRESS[1];
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,10
	CALL __GETW1P
	CALL SUBOPT_0x1C
;    1467             SERVER_ADDRESS[0] = msg->SERVER_ADDRESS[0];
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,12
	CALL __GETW1P
	CALL SUBOPT_0x19
;    1468             SERVER_ADDRESS[1] = msg->SERVER_ADDRESS[1];            
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,14
	CALL __GETW1P
	CALL SUBOPT_0x1A
;    1469             SUBNET_MASK[0] = msg->SUBNET_MASK[0];
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,16
	CALL __GETW1P
	CALL SUBOPT_0x1D
;    1470             SUBNET_MASK[1] = msg->SUBNET_MASK[1];
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,18
	CALL __GETW1P
	CALL SUBOPT_0x1E
;    1471             CLIENT_PORT = msg->CLIENT_PORT;
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,20
	LD   R6,X+
	LD   R7,X
;    1472             SERVER_PORT = msg->SERVER_PORT;  
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,22
	LD   R4,X+
	LD   R5,X
;    1473             SaveConfig();     
	CALL _SaveConfig
;    1474         }
;    1475         else{               // get config
	RJMP _0xC9
_0xC8:
;    1476             memcpy(msg->mac_addr,eth_mac_addr.addr,6); 
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_eth_mac_addr)
	LDI  R31,HIGH(_eth_mac_addr)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xF
;    1477             msg->HOST_ADDRESS[0] = HOST_ADDRESS[0];
	CALL SUBOPT_0x5
	__PUTW1SNS 0,8
;    1478             msg->HOST_ADDRESS[1] = HOST_ADDRESS[1];
	CALL SUBOPT_0x15
	__PUTW1SNS 0,10
;    1479             msg->SERVER_ADDRESS[0] = SERVER_ADDRESS[0];
	CALL SUBOPT_0x3
	__PUTW1SNS 0,12
;    1480             msg->SERVER_ADDRESS[1] = SERVER_ADDRESS[1];            
	CALL SUBOPT_0x7
	__PUTW1SNS 0,14
;    1481             msg->SUBNET_MASK[0] = SUBNET_MASK[0];
	CALL SUBOPT_0x16
	__PUTW1SNS 0,16
;    1482             msg->SUBNET_MASK[1] = SUBNET_MASK[1];
	CALL SUBOPT_0x17
	__PUTW1SNS 0,18
;    1483             msg->CLIENT_PORT = CLIENT_PORT;
	MOVW R30,R6
	__PUTW1SNS 0,20
;    1484             msg->SERVER_PORT = SERVER_PORT;                    
	MOVW R30,R4
	__PUTW1SNS 0,22
;    1485         }
_0xC9:
;    1486     }                            
	ADIW R28,2
;    1487     else{
_0xC6:
;    1488     }
;    1489     return (rcv_len);                                                 
	LD   R30,Y
	LDD  R31,Y+1
_0x176:
	ADIW R28,4
	RET
;    1490 }
;    1491 #include "ethernet.h"
;    1492 
;    1493 
;    1494 unsigned int process_udp_data(unsigned char* udpdata, unsigned int rcv_len)
;    1495 {           
_process_udp_data:
;    1496     unsigned int i = 0;  
;    1497     for (i=0; i< rcv_len; i++){
	CALL SUBOPT_0x1F
;	*udpdata -> Y+4
;	rcv_len -> Y+2
;	i -> R16,R17
	__GETWRN 16,17,0
_0xCC:
	CALL SUBOPT_0x49
	BRSH _0xCD
;    1498         putchar(udpdata[i]);
	MOVW R30,R16
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	ST   -Y,R30
	CALL _putchar
;    1499         delay_us(100); 
	__DELAY_USW 200
;    1500         #asm("WDR");
	WDR
;    1501     }    
	__ADDWRN 16,17,1
	JMP  _0xCC
_0xCD:
;    1502     return (0);                                                 
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;    1503 }

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
__put_G9:
	LD   R26,Y
	LDD  R27,Y+1
	CALL __GETW1P
	SBIW R30,0
	BREQ _0xCE
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0xCF
_0xCE:
	LDD  R30,Y+2
	ST   -Y,R30
	CALL _putchar
_0xCF:
	ADIW R28,3
	RET
__print_G9:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R16,0
_0xD0:
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
	JMP _0xD2
	MOV  R30,R16
	CPI  R30,0
	BRNE _0xD6
	CPI  R19,37
	BRNE _0xD7
	LDI  R16,LOW(1)
	RJMP _0xD8
_0xD7:
	RCALL SUBOPT_0x74
_0xD8:
	RJMP _0xD5
_0xD6:
	CPI  R30,LOW(0x1)
	BRNE _0xD9
	CPI  R19,37
	BRNE _0xDA
	RCALL SUBOPT_0x74
	RJMP _0x184
_0xDA:
	LDI  R16,LOW(2)
	LDI  R21,LOW(0)
	LDI  R17,LOW(0)
	CPI  R19,45
	BRNE _0xDB
	LDI  R17,LOW(1)
	RJMP _0xD5
_0xDB:
	CPI  R19,43
	BRNE _0xDC
	LDI  R21,LOW(43)
	RJMP _0xD5
_0xDC:
	CPI  R19,32
	BRNE _0xDD
	LDI  R21,LOW(32)
	RJMP _0xD5
_0xDD:
	RJMP _0xDE
_0xD9:
	CPI  R30,LOW(0x2)
	BRNE _0xDF
_0xDE:
	LDI  R20,LOW(0)
	LDI  R16,LOW(3)
	CPI  R19,48
	BRNE _0xE0
	ORI  R17,LOW(128)
	RJMP _0xD5
_0xE0:
	RJMP _0xE1
_0xDF:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0xD5
_0xE1:
	CPI  R19,48
	BRLO _0xE4
	CPI  R19,58
	BRLO _0xE5
_0xE4:
	RJMP _0xE3
_0xE5:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0xD5
_0xE3:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0xE9
	RCALL SUBOPT_0x75
	LD   R30,X
	RCALL SUBOPT_0x76
	RJMP _0xEA
_0xE9:
	CPI  R30,LOW(0x73)
	BRNE _0xEC
	RCALL SUBOPT_0x75
	RCALL SUBOPT_0x77
	CALL _strlen
	MOV  R16,R30
	RJMP _0xED
_0xEC:
	CPI  R30,LOW(0x70)
	BRNE _0xEF
	RCALL SUBOPT_0x75
	RCALL SUBOPT_0x77
	CALL _strlenf
	MOV  R16,R30
	ORI  R17,LOW(8)
_0xED:
	ORI  R17,LOW(2)
	ANDI R17,LOW(127)
	LDI  R18,LOW(0)
	RJMP _0xF0
_0xEF:
	CPI  R30,LOW(0x64)
	BREQ _0xF3
	CPI  R30,LOW(0x69)
	BRNE _0xF4
_0xF3:
	ORI  R17,LOW(4)
	RJMP _0xF5
_0xF4:
	CPI  R30,LOW(0x75)
	BRNE _0xF6
_0xF5:
	LDI  R30,LOW(_tbl10_G9*2)
	LDI  R31,HIGH(_tbl10_G9*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(5)
	RJMP _0xF7
_0xF6:
	CPI  R30,LOW(0x58)
	BRNE _0xF9
	ORI  R17,LOW(8)
	RJMP _0xFA
_0xF9:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x12B
_0xFA:
	LDI  R30,LOW(_tbl16_G9*2)
	LDI  R31,HIGH(_tbl16_G9*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R16,LOW(4)
_0xF7:
	SBRS R17,2
	RJMP _0xFC
	RCALL SUBOPT_0x75
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	SBIW R26,0
	BRGE _0xFD
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R21,LOW(45)
_0xFD:
	CPI  R21,0
	BREQ _0xFE
	SUBI R16,-LOW(1)
	RJMP _0xFF
_0xFE:
	ANDI R17,LOW(251)
_0xFF:
	RJMP _0x100
_0xFC:
	RCALL SUBOPT_0x75
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0x100:
_0xF0:
	SBRC R17,0
	RJMP _0x101
_0x102:
	CP   R16,R20
	BRSH _0x104
	SBRS R17,7
	RJMP _0x105
	SBRS R17,2
	RJMP _0x106
	ANDI R17,LOW(251)
	MOV  R19,R21
	SUBI R16,LOW(1)
	RJMP _0x107
_0x106:
	LDI  R19,LOW(48)
_0x107:
	RJMP _0x108
_0x105:
	LDI  R19,LOW(32)
_0x108:
	RCALL SUBOPT_0x74
	SUBI R20,LOW(1)
	RJMP _0x102
_0x104:
_0x101:
	MOV  R18,R16
	SBRS R17,1
	RJMP _0x109
_0x10A:
	CPI  R18,0
	BREQ _0x10C
	SBRS R17,3
	RJMP _0x10D
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x185
_0x10D:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x185:
	ST   -Y,R30
	RCALL SUBOPT_0x78
	CPI  R20,0
	BREQ _0x10F
	SUBI R20,LOW(1)
_0x10F:
	SUBI R18,LOW(1)
	RJMP _0x10A
_0x10C:
	RJMP _0x110
_0x109:
_0x112:
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
_0x114:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x116
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x114
_0x116:
	CPI  R19,58
	BRLO _0x117
	SBRS R17,3
	RJMP _0x118
	SUBI R19,-LOW(7)
	RJMP _0x119
_0x118:
	SUBI R19,-LOW(39)
_0x119:
_0x117:
	SBRC R17,4
	RJMP _0x11B
	CPI  R19,49
	BRSH _0x11D
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x11C
_0x11D:
	RJMP _0x186
_0x11C:
	CP   R20,R18
	BRLO _0x121
	SBRS R17,0
	RJMP _0x122
_0x121:
	RJMP _0x120
_0x122:
	LDI  R19,LOW(32)
	SBRS R17,7
	RJMP _0x123
	LDI  R19,LOW(48)
_0x186:
	ORI  R17,LOW(16)
	SBRS R17,2
	RJMP _0x124
	ANDI R17,LOW(251)
	ST   -Y,R21
	RCALL SUBOPT_0x78
	CPI  R20,0
	BREQ _0x125
	SUBI R20,LOW(1)
_0x125:
_0x124:
_0x123:
_0x11B:
	RCALL SUBOPT_0x74
	CPI  R20,0
	BREQ _0x126
	SUBI R20,LOW(1)
_0x126:
_0x120:
	SUBI R18,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x113
	RJMP _0x112
_0x113:
_0x110:
	SBRS R17,0
	RJMP _0x127
_0x128:
	CPI  R20,0
	BREQ _0x12A
	SUBI R20,LOW(1)
	LDI  R30,LOW(32)
	RCALL SUBOPT_0x76
	RJMP _0x128
_0x12A:
_0x127:
_0x12B:
_0xEA:
_0x184:
	LDI  R16,LOW(0)
_0xD5:
	RJMP _0xD0
_0xD2:
	CALL __LOADLOCR6
	ADIW R28,18
	RET
_printf:
	PUSH R15
	RCALL SUBOPT_0x79
	RCALL __print_G9
	RJMP _0x174
__get_G9:
	ST   -Y,R16
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LD   R30,X
	MOV  R16,R30
	CPI  R30,0
	BREQ _0x12C
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x12D
_0x12C:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x12E
	CALL __GETW1P
	LD   R30,Z
	MOV  R16,R30
	CPI  R30,0
	BREQ _0x12F
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x12F:
	RJMP _0x130
_0x12E:
	CALL _getchar
	MOV  R16,R30
_0x130:
_0x12D:
	MOV  R30,R16
	LDD  R16,Y+0
	ADIW R28,5
	RET
__scanf_G9:
	SBIW R28,4
	CALL __SAVELOCR6
	LDI  R30,LOW(0)
	STD  Y+9,R30
	MOV  R21,R30
_0x131:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	ADIW R30,1
	STD  Y+14,R30
	STD  Y+14+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x133
	RCALL SUBOPT_0x7A
	BREQ _0x134
_0x135:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R21
	RCALL SUBOPT_0x7B
	POP  R21
	MOV  R18,R30
	CPI  R30,0
	BREQ _0x138
	RCALL SUBOPT_0x7A
	BRNE _0x139
_0x138:
	RJMP _0x137
_0x139:
	RJMP _0x135
_0x137:
	MOV  R21,R18
	RJMP _0x13A
_0x134:
	CPI  R18,37
	BREQ PC+3
	JMP _0x13B
	LDI  R20,LOW(0)
_0x13C:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	LPM  R18,Z+
	STD  Y+14,R30
	STD  Y+14+1,R31
	CPI  R18,48
	BRLO _0x140
	CPI  R18,58
	BRLO _0x13F
_0x140:
	RJMP _0x13E
_0x13F:
	MOV  R26,R20
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOV  R20,R30
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x13C
_0x13E:
	CPI  R18,0
	BRNE _0x142
	RJMP _0x133
_0x142:
_0x143:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R21
	RCALL SUBOPT_0x7B
	POP  R21
	MOV  R19,R30
	ST   -Y,R30
	CALL _isspace
	CPI  R30,0
	BRNE _0x143
	CPI  R19,0
	BRNE _0x146
	RJMP _0x147
_0x146:
	MOV  R21,R19
	CPI  R20,0
	BRNE _0x148
	LDI  R20,LOW(255)
_0x148:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x14C
	RCALL SUBOPT_0x7C
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R21
	RCALL SUBOPT_0x7B
	POP  R21
	MOVW R26,R16
	ST   X,R30
	RJMP _0x14B
_0x14C:
	CPI  R30,LOW(0x73)
	BRNE _0x154
	RCALL SUBOPT_0x7C
_0x14E:
	MOV  R30,R20
	SUBI R20,1
	CPI  R30,0
	BREQ _0x150
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R21
	RCALL SUBOPT_0x7B
	POP  R21
	MOV  R18,R30
	CPI  R30,0
	BREQ _0x152
	RCALL SUBOPT_0x7A
	BREQ _0x151
_0x152:
	RJMP _0x150
_0x151:
	PUSH R17
	PUSH R16
	__ADDWRN 16,17,1
	MOV  R30,R18
	POP  R26
	POP  R27
	ST   X,R30
	RJMP _0x14E
_0x150:
	MOVW R26,R16
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x14B
_0x154:
	LDI  R30,LOW(1)
	STD  Y+8,R30
	MOV  R30,R18
	CPI  R30,LOW(0x64)
	BREQ _0x159
	CPI  R30,LOW(0x69)
	BRNE _0x15A
_0x159:
	LDI  R30,LOW(0)
	STD  Y+8,R30
	RJMP _0x15B
_0x15A:
	CPI  R30,LOW(0x75)
	BRNE _0x15C
_0x15B:
	LDI  R19,LOW(10)
	RJMP _0x157
_0x15C:
	CPI  R30,LOW(0x78)
	BRNE _0x15D
	LDI  R19,LOW(16)
	RJMP _0x157
_0x15D:
	CPI  R30,LOW(0x25)
	BRNE _0x160
	RJMP _0x15F
_0x160:
	LDD  R30,Y+9
	RJMP _0x175
_0x157:
	LDI  R30,0
	STD  Y+6,R30
	STD  Y+6+1,R30
_0x161:
	MOV  R30,R20
	SUBI R20,1
	CPI  R30,0
	BREQ _0x163
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R21
	RCALL SUBOPT_0x7B
	POP  R21
	MOV  R18,R30
	CPI  R30,LOW(0x21)
	BRLO _0x165
	LDD  R30,Y+8
	CPI  R30,0
	BRNE _0x166
	CPI  R18,45
	BRNE _0x167
	LDI  R30,LOW(255)
	STD  Y+8,R30
	RJMP _0x161
_0x167:
	LDI  R30,LOW(1)
	STD  Y+8,R30
_0x166:
	CPI  R19,16
	BRNE _0x169
	ST   -Y,R18
	CALL _isxdigit
	CPI  R30,0
	BREQ _0x165
	RJMP _0x16B
_0x169:
	ST   -Y,R18
	CALL _isdigit
	CPI  R30,0
	BRNE _0x16C
_0x165:
	MOV  R21,R18
	RJMP _0x163
_0x16C:
_0x16B:
	CPI  R18,97
	BRLO _0x16D
	SUBI R18,LOW(87)
	RJMP _0x16E
_0x16D:
	CPI  R18,65
	BRLO _0x16F
	SUBI R18,LOW(55)
	RJMP _0x170
_0x16F:
	SUBI R18,LOW(48)
_0x170:
_0x16E:
	MOV  R30,R19
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R31,0
	CALL __MULW12U
	MOVW R26,R30
	MOV  R30,R18
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x161
_0x163:
	RCALL SUBOPT_0x7C
	LDD  R30,Y+8
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R31,0
	SBRC R30,7
	SER  R31
	CALL __MULW12U
	MOVW R26,R16
	ST   X+,R30
	ST   X,R31
_0x14B:
	LDD  R30,Y+9
	SUBI R30,-LOW(1)
	STD  Y+9,R30
	RJMP _0x171
_0x13B:
_0x15F:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R21
	RCALL SUBOPT_0x7B
	POP  R21
	CP   R30,R18
	BREQ _0x172
_0x147:
	LDD  R30,Y+9
	CPI  R30,0
	BRNE _0x173
	LDI  R30,LOW(255)
	RJMP _0x175
_0x173:
	RJMP _0x133
_0x172:
_0x171:
_0x13A:
	RJMP _0x131
_0x133:
	LDD  R30,Y+9
_0x175:
	CALL __LOADLOCR6
	ADIW R28,16
	RET
_scanf:
	PUSH R15
	RCALL SUBOPT_0x79
	RCALL __scanf_G9
_0x174:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	POP  R15
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	CALL __SAVELOCR4
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	__POINTW1MN _netBuffer,42
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _netBuffer,24
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	LDS  R30,_SERVER_ADDRESS
	LDS  R31,_SERVER_ADDRESS+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	__PUTW1MN _netBuffer,30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x5:
	LDS  R30,_HOST_ADDRESS
	LDS  R31,_HOST_ADDRESS+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	__PUTW1MN _netBuffer,26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7:
	__GETW1MN _SERVER_ADDRESS,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x8:
	__PUTW1MN _netBuffer,32
	__GETW1MN _HOST_ADDRESS,2
	__PUTW1MN _netBuffer,28
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x9:
	MOVW R30,R6
	ANDI R31,HIGH(0xFF)
	MOV  R31,R30
	LDI  R30,0
	MOVW R26,R30
	MOVW R30,R6
	ANDI R30,LOW(0xFF00)
	MOV  R30,R31
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xA:
	ANDI R31,HIGH(0xFF)
	MOV  R31,R30
	LDI  R30,0
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xB:
	ANDI R30,LOW(0xFF00)
	MOV  R30,R31
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:48 WORDS
SUBOPT_0xC:
	MOVW R26,R16
	SBIW R26,34
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	AND  R30,R26
	AND  R31,R27
	MOV  R31,R30
	LDI  R30,0
	MOVW R0,R30
	MOVW R26,R16
	SBIW R26,34
	LDI  R30,LOW(65280)
	LDI  R31,HIGH(65280)
	AND  R30,R26
	AND  R31,R27
	MOV  R30,R31
	LDI  R31,0
	OR   R30,R0
	OR   R31,R1
	__PUTW1MN _netBuffer,38
	MOVW R30,R16
	SBIW R30,14
	MOVW R18,R30
	__PUTBMRN _netBuffer,16,19
	MOVW R30,R18
	__PUTB1MN _netBuffer,17
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _netBuffer,40
	CALL _udp_chksum
	COM  R30
	COM  R31
	__PUTW1MN _netBuffer,40
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xD:
	CALL _ip_chksum
	COM  R30
	COM  R31
	__PUTW1MN _netBuffer,24
	LDI  R30,LOW(_netBuffer)
	LDI  R31,HIGH(_netBuffer)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	LDI  R30,LOW(_eth_src_addr)
	LDI  R31,HIGH(_eth_src_addr)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:57 WORDS
SUBOPT_0xF:
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _memcpy

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0x10:
	__POINTW1MN _netBuffer,6
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_eth_mac_addr)
	LDI  R31,HIGH(_eth_mac_addr)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xF

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	__PUTW1MN _netBuffer,12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:99 WORDS
SUBOPT_0x12:
	LDI  R30,LOW(160)
	ST   -Y,R30
	__GETW1R 17,18
	__ADDWRN 17,18,1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_eth_mac_addr)
	SBCI R31,HIGH(-_eth_mac_addr)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x14:
	ST   -Y,R31
	ST   -Y,R30
	CALL _eeprom_write_w
	__ADDWRN 17,18,1
	RJMP SUBOPT_0x12

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x15:
	__GETW1MN _HOST_ADDRESS,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x16:
	LDS  R30,_SUBNET_MASK
	LDS  R31,_SUBNET_MASK+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	__GETW1MN _SUBNET_MASK,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x18:
	__ADDWRN 17,18,1
	RJMP SUBOPT_0x12

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	STS  _SERVER_ADDRESS,R30
	STS  _SERVER_ADDRESS+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	__PUTW1MN _SERVER_ADDRESS,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1B:
	STS  _HOST_ADDRESS,R30
	STS  _HOST_ADDRESS+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1C:
	__PUTW1MN _HOST_ADDRESS,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1D:
	STS  _SUBNET_MASK,R30
	STS  _SUBNET_MASK+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	__PUTW1MN _SUBNET_MASK,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1F:
	ST   -Y,R17
	ST   -Y,R16
	LDI  R16,0
	LDI  R17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x20:
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x21:
	CALL _getchar
	MOV  R16,R30
	CPI  R16,78
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x22:
	__POINTW1FN _0,54
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
	LDI  R17,LOW(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x23:
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_eth_mac_addr)
	SBCI R31,HIGH(-_eth_mac_addr)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x24:
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	RCALL _scanf
	ADIW R28,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 17 TIMES, CODE SIZE REDUCTION:29 WORDS
SUBOPT_0x25:
	LDI  R24,4
	RCALL _printf
	ADIW R28,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x26:
	ANDI R31,HIGH(0xFF)
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x27:
	ANDI R31,HIGH(0x0)
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x28:
	LDI  R24,16
	RCALL _printf
	ADIW R28,18
	RJMP SUBOPT_0x21

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:47 WORDS
SUBOPT_0x29:
	__POINTW1FN _0,122
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R17
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,4
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2A:
	ADD  R30,R26
	ADC  R31,R27
	RJMP SUBOPT_0x24

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x2B:
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RJMP SUBOPT_0x25

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x2C:
	__POINTW1FN _0,126
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2D:
	MOVW R30,R28
	ADIW R30,10
	RJMP SUBOPT_0x24

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x2E:
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RJMP SUBOPT_0x25

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x2F:
	LDD  R31,Y+2
	LDI  R30,LOW(0)
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	OR   R30,R26
	OR   R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x30:
	ANDI R31,HIGH(0xFF)
	MOV  R31,R30
	LDI  R30,0
	MOVW R0,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x31:
	ANDI R30,LOW(0xFF00)
	MOV  R30,R31
	LDI  R31,0
	OR   R30,R0
	OR   R31,R1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x32:
	LDD  R31,Y+6
	LDI  R30,LOW(0)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	OR   R30,R26
	OR   R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x33:
	MOVW R30,R4
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RJMP SUBOPT_0x25

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x34:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
	__POINTW1FN _0,244
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x35:
	CALL __PUTPARD1
	LDI  R24,4
	RCALL _scanf
	ADIW R28,6
	RJMP SUBOPT_0x2C

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x36:
	MOVW R30,R6
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RJMP SUBOPT_0x25

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:57 WORDS
SUBOPT_0x37:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x38:
	__POINTW1FN _0,368
	RJMP SUBOPT_0x37

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x39:
	SBIW R28,2
	LDI  R24,2
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x3A:
	LDI  R30,LOW(_netBuffer)
	LDI  R31,HIGH(_netBuffer)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3B:
	ST   Y,R30
	STD  Y+1,R31
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3C:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R31
	ST   -Y,R30
	JMP  _nic_send

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x3D:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3E:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3F:
	ST   Y,R30
	STD  Y+1,R31
	LD   R26,Y
	LDD  R27,Y+1
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x40:
	IN   R30,0x18
	ANDI R30,LOW(0xE0)
	LDD  R26,Y+1
	OR   R30,R26
	STD  Y+1,R30
	OUT  0x18,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x41:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(34)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x42:
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R30,LOW(64)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x43:
	LDI  R30,LOW(8)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _rtl8019Write
	LDI  R30,LOW(9)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x44:
	LDI  R30,LOW(64)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x45:
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x46:
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _rtl8019Write
	LDI  R30,LOW(11)
	ST   -Y,R30
	LDD  R30,Y+4
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x47:
	CALL _rtl8019Write
	LDI  R30,LOW(6)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x48:
	ANDI R31,HIGH(0x0)
	ST   -Y,R30
	CALL _rtl8019Write
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x49:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R16,R30
	CPC  R17,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x4A:
	ST   -Y,R30
	CALL _rtl8019Write
	LDI  R30,LOW(7)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4B:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(98)
	RJMP SUBOPT_0x4A

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4C:
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R30,LOW(70)
	ST   -Y,R30
	CALL _rtl8019Write
	RJMP SUBOPT_0x4B

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4D:
	LDI  R30,LOW(70)
	ST   -Y,R30
	CALL _rtl8019Write
	RJMP SUBOPT_0x41

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x4E:
	ST   -Y,R30
	CALL _rtl8019Write
	LDI  R30,LOW(11)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4F:
	CALL _rtl8019Write
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x50:
	LDI  R30,LOW(7)
	ST   -Y,R30
	CALL _rtl8019Read
	ANDI R30,LOW(0x40)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x51:
	LDI  R30,LOW(7)
	ST   -Y,R30
	RJMP SUBOPT_0x44

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x52:
	STS  _currentRetreiveAddress_G2,R30
	STS  _currentRetreiveAddress_G2+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x53:
	ST   -Y,R30
	CALL _rtl8019Read
	MOV  R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x54:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(33)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x55:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RJMP SUBOPT_0x3D

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x56:
	ST   -Y,R30
	CALL _rtl8019Write
	LDI  R30,LOW(13)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x57:
	LDI  R30,LOW(7)
	ST   -Y,R30
	LDI  R30,LOW(255)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x58:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(225)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x59:
	LDI  R30,LOW(14)
	ST   -Y,R30
	LDI  R30,LOW(88)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5A:
	ST   -Y,R30
	LDI  R30,LOW(70)
	ST   -Y,R30
	JMP  _rtl8019Write

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:24 WORDS
SUBOPT_0x5B:
	ST   -Y,R17
	CALL _rtl8019Read
	MOV  R16,R30
	__POINTW1FN _0,774
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R16
	RJMP SUBOPT_0x20

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5C:
	__GETW1MN _netBuffer,38
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x5D:
	LDS  R26,_HOST_ADDRESS
	LDS  R27,_HOST_ADDRESS+1
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5E:
	__GETW2MN _HOST_ADDRESS,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5F:
	__POINTW1MN _netBuffer,22
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xF

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x60:
	__POINTW1MN _netBuffer,32
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x61:
	__POINTW1MN _netBuffer,22
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_eth_mac_addr)
	LDI  R31,HIGH(_eth_mac_addr)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xF

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x62:
	__GETW1MN _netBuffer,28
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x63:
	__GETW1MN _netBuffer,30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x64:
	__PUTW1MN _netBuffer,40
	RCALL SUBOPT_0x5
	__PUTW1MN _netBuffer,28
	RJMP SUBOPT_0x15

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x65:
	LDI  R30,LOW(1544)
	LDI  R31,HIGH(1544)
	RJMP SUBOPT_0x11

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x66:
	ST   -Y,R30
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _memset

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x67:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R30,X
	MOV  R26,R30
	MOV  R31,R30
	LDI  R30,0
	RJMP SUBOPT_0x30

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x68:
	MOV  R30,R26
	MOV  R31,R30
	LDI  R30,0
	MOV  R30,R31
	LDI  R31,0
	OR   R30,R0
	OR   R31,R1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x69:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _cal_chksum

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x6A:
	__GETBRMN 27,_netBuffer,16
	LDI  R26,LOW(0)
	__GETB1MN _netBuffer,17
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6B:
	MOVW R30,R16
	ADD  R30,R18
	ADC  R31,R19
	MOVW R18,R30
	CP   R30,R16
	CPC  R31,R17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x6C:
	__GETW1MN _netBuffer,26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x6D:
	ADD  R30,R18
	ADC  R31,R19
	MOVW R18,R30
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x6E:
	__GETW1MN _netBuffer,32
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6F:
	LDS  R26,_SERVER_ADDRESS
	LDS  R27,_SERVER_ADDRESS+1
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x70:
	__GETW2MN _SERVER_ADDRESS,2
	RJMP SUBOPT_0x62

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x71:
	__POINTW1MN _netBuffer,6
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xF

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x72:
	CALL _i2c_start
	LDD  R30,Y+3
	ST   -Y,R30
	CALL _i2c_write
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ANDI R31,HIGH(0xFF)
	ST   -Y,R30
	JMP  _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x73:
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x74:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RJMP __put_G9

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x75:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x76:
	ST   -Y,R30
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RJMP __put_G9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x77:
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x78:
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	RJMP __put_G9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x79:
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
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7A:
	ST   -Y,R18
	CALL _isspace
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x7B:
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	ST   -Y,R31
	ST   -Y,R30
	RJMP __get_G9

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x7C:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SBIW R26,4
	STD  Y+12,R26
	STD  Y+12+1,R27
	ADIW R26,4
	LD   R16,X+
	LD   R17,X
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
	ldi  r22,13
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir,__sda_bit
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
__i2c_delay2:
	ldi  r22,27
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

_isdigit:
	ldi  r30,1
	ld   r31,y+
	cpi  r31,'0'
	brlo __isdigit0
	cpi  r31,'9'+1
	brlo __isdigit1
__isdigit0:
	clr  r30
__isdigit1:
	ret

_isspace:
	ldi  r30,1
	ld   r31,y+
	cpi  r31,' '
	breq __isspace1
	cpi  r31,9
	brlo __isspace0
	cpi  r31,14
	brlo __isspace1
__isspace0:
	clr  r30
__isspace1:
	ret

_isxdigit:
	ldi  r30,1
	ld   r31,y+
	subi r31,0x30
	brcs __isxdigit0
	cpi  r31,10
	brcs __isxdigit1
	andi r31,0x5f
	subi r31,7
	cpi  r31,10
	brcs __isxdigit0
	cpi  r31,16
	brcs __isxdigit1
__isxdigit0:
	clr  r30
__isxdigit1:
	ret

_memcpy:
	ldd  r25,y+1
	ld   r24,y
	adiw r24,0
	breq __memcpy1
	ldd  r27,y+5
	ldd  r26,y+4
	ldd  r31,y+3
	ldd  r30,y+2
__memcpy0:
	ld   r22,z+
	st   x+,r22
	sbiw r24,1
	brne __memcpy0
__memcpy1:
	ldd  r31,y+5
	ldd  r30,y+4
	adiw r28,6
	ret

_memset:
	ldd  r27,y+1
	ld   r26,y
	adiw r26,0
	breq __memset1
	ldd  r31,y+4
	ldd  r30,y+3
	ldd  r22,y+2
__memset0:
	st   z+,r22
	sbiw r26,1
	brne __memset0
__memset1:
	ldd  r30,y+3
	ldd  r31,y+4
	adiw r28,5
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
	COM  R30
	COM  R31
	ADIW R30,1
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

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
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
