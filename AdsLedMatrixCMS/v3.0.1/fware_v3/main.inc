
	.DEF _x=R4
	.DEF _y=R6
_3:
	.DB  0x14
	.DEF _rx_message=R8
	.DEF _rx_wparam=R9
	.DEF _rx_lparam=R11
_0x18:
	.DB  0x0,0x0
_0x64:
	.DB  0x0
	.DEF _rx_wr_index=R13
	.DEF _rx_counter=R14

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  _scroll_rate_G1
	.DW  _3*2

	.DW  0
_0x92:
