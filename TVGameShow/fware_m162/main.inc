
	.DEF _rx_message=R4
	.DEF _rx_wparam=R5
	.DEF _rx_lparam=R7
_3:
	.DB  0x84,0xFC,0x91,0xB0,0xE8,0xA2,0x82,0xF4
	.DB  0x80,0xA0,0xFB,0xFF
	.DEF _rx_wr_index=R9
	.DEF _rx_counter=R10
_tbl10_G3:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G3:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0
_0:
	.DB  0xD,0xA,0x0,0x25,0x30,0x32,0x58,0x20
	.DB  0x0,0x47,0x61,0x6D,0x65,0x53,0x68,0x6F
	.DB  0x77,0x20,0x76,0x31,0x2E,0x30,0x30,0x20
	.DB  0x44,0x65,0x73,0x69,0x67,0x6E,0x65,0x64
	.DB  0x20,0x62,0x79,0x20,0x43,0x75,0x6F,0x6E
	.DB  0x67,0x51,0x75,0x61,0x79,0xD,0xA,0x0
	.DB  0x63,0x75,0x6F,0x6E,0x67,0x33,0x69,0x68
	.DB  0x75,0x74,0x40,0x79,0x61,0x68,0x6F,0x6F
	.DB  0x2E,0x63,0x6F,0x6D,0x20,0x2D,0x20,0x30
	.DB  0x39,0x31,0x35,0x36,0x35,0x31,0x30,0x30
	.DB  0x31,0xD,0xA,0x0,0x53,0x74,0x61,0x72
	.DB  0x74,0x65,0x64,0x20,0x6F,0x6E,0x3A,0x20
	.DB  0x30,0x36,0x2E,0x30,0x33,0x2E,0x32,0x30
	.DB  0x30,0x37,0xD,0xA,0x0

__GLOBAL_INI_TBL:
	.DW  0x0C
	.DW  _buffer
	.DW  _3*2

	.DW  0
_0x8B:
