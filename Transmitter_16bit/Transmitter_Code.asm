;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1069 (Apr 23 2015) (MSVC)
; This file was generated Thu Mar 22 20:29:01 2018
;--------------------------------------------------------
$name Transmitter_Code
$optc51 --model-small
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _InitPinADC_PARM_2
	public _main
	public _sendMessage
	public _sendCommand
	public _sendOne
	public _sendZero
	public _Volts_at_Pin
	public _ADC_at_Pin
	public _InitPinADC
	public _InitADC
	public _Timer2_ISR
	public _waitms
	public _Timer3us
	public __c51_external_startup
	public _on_off
	public _sendMessage_PARM_4
	public _sendMessage_PARM_3
	public _sendMessage_PARM_2
	public _overflow_count
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_ADC0ASAH       DATA 0xb6
_ADC0ASAL       DATA 0xb5
_ADC0ASCF       DATA 0xa1
_ADC0ASCT       DATA 0xc7
_ADC0CF0        DATA 0xbc
_ADC0CF1        DATA 0xb9
_ADC0CF2        DATA 0xdf
_ADC0CN0        DATA 0xe8
_ADC0CN1        DATA 0xb2
_ADC0CN2        DATA 0xb3
_ADC0GTH        DATA 0xc4
_ADC0GTL        DATA 0xc3
_ADC0H          DATA 0xbe
_ADC0L          DATA 0xbd
_ADC0LTH        DATA 0xc6
_ADC0LTL        DATA 0xc5
_ADC0MX         DATA 0xbb
_B              DATA 0xf0
_CKCON0         DATA 0x8e
_CKCON1         DATA 0xa6
_CLEN0          DATA 0xc6
_CLIE0          DATA 0xc7
_CLIF0          DATA 0xe8
_CLKSEL         DATA 0xa9
_CLOUT0         DATA 0xd1
_CLU0CF         DATA 0xb1
_CLU0FN         DATA 0xaf
_CLU0MX         DATA 0x84
_CLU1CF         DATA 0xb3
_CLU1FN         DATA 0xb2
_CLU1MX         DATA 0x85
_CLU2CF         DATA 0xb6
_CLU2FN         DATA 0xb5
_CLU2MX         DATA 0x91
_CLU3CF         DATA 0xbf
_CLU3FN         DATA 0xbe
_CLU3MX         DATA 0xae
_CMP0CN0        DATA 0x9b
_CMP0CN1        DATA 0x99
_CMP0MD         DATA 0x9d
_CMP0MX         DATA 0x9f
_CMP1CN0        DATA 0xbf
_CMP1CN1        DATA 0xac
_CMP1MD         DATA 0xab
_CMP1MX         DATA 0xaa
_CRC0CN0        DATA 0xce
_CRC0CN1        DATA 0x86
_CRC0CNT        DATA 0xd3
_CRC0DAT        DATA 0xcb
_CRC0FLIP       DATA 0xcf
_CRC0IN         DATA 0xca
_CRC0ST         DATA 0xd2
_DAC0CF0        DATA 0x91
_DAC0CF1        DATA 0x92
_DAC0H          DATA 0x85
_DAC0L          DATA 0x84
_DAC1CF0        DATA 0x93
_DAC1CF1        DATA 0x94
_DAC1H          DATA 0x8a
_DAC1L          DATA 0x89
_DAC2CF0        DATA 0x95
_DAC2CF1        DATA 0x96
_DAC2H          DATA 0x8c
_DAC2L          DATA 0x8b
_DAC3CF0        DATA 0x9a
_DAC3CF1        DATA 0x9c
_DAC3H          DATA 0x8e
_DAC3L          DATA 0x8d
_DACGCF0        DATA 0x88
_DACGCF1        DATA 0x98
_DACGCF2        DATA 0xa2
_DERIVID        DATA 0xad
_DEVICEID       DATA 0xb5
_DPH            DATA 0x83
_DPL            DATA 0x82
_EIE1           DATA 0xe6
_EIE2           DATA 0xf3
_EIP1           DATA 0xbb
_EIP1H          DATA 0xee
_EIP2           DATA 0xed
_EIP2H          DATA 0xf6
_EMI0CN         DATA 0xe7
_FLKEY          DATA 0xb7
_HFO0CAL        DATA 0xc7
_HFO1CAL        DATA 0xd6
_HFOCN          DATA 0xef
_I2C0ADM        DATA 0xff
_I2C0CN0        DATA 0xba
_I2C0DIN        DATA 0xbc
_I2C0DOUT       DATA 0xbb
_I2C0FCN0       DATA 0xad
_I2C0FCN1       DATA 0xab
_I2C0FCT        DATA 0xf5
_I2C0SLAD       DATA 0xbd
_I2C0STAT       DATA 0xb9
_IE             DATA 0xa8
_IP             DATA 0xb8
_IPH            DATA 0xf2
_IT01CF         DATA 0xe4
_LFO0CN         DATA 0xb1
_P0             DATA 0x80
_P0MASK         DATA 0xfe
_P0MAT          DATA 0xfd
_P0MDIN         DATA 0xf1
_P0MDOUT        DATA 0xa4
_P0SKIP         DATA 0xd4
_P1             DATA 0x90
_P1MASK         DATA 0xee
_P1MAT          DATA 0xed
_P1MDIN         DATA 0xf2
_P1MDOUT        DATA 0xa5
_P1SKIP         DATA 0xd5
_P2             DATA 0xa0
_P2MASK         DATA 0xfc
_P2MAT          DATA 0xfb
_P2MDIN         DATA 0xf3
_P2MDOUT        DATA 0xa6
_P2SKIP         DATA 0xcc
_P3             DATA 0xb0
_P3MDIN         DATA 0xf4
_P3MDOUT        DATA 0x9c
_PCA0CENT       DATA 0x9e
_PCA0CLR        DATA 0x9c
_PCA0CN0        DATA 0xd8
_PCA0CPH0       DATA 0xfc
_PCA0CPH1       DATA 0xea
_PCA0CPH2       DATA 0xec
_PCA0CPH3       DATA 0xf5
_PCA0CPH4       DATA 0x85
_PCA0CPH5       DATA 0xde
_PCA0CPL0       DATA 0xfb
_PCA0CPL1       DATA 0xe9
_PCA0CPL2       DATA 0xeb
_PCA0CPL3       DATA 0xf4
_PCA0CPL4       DATA 0x84
_PCA0CPL5       DATA 0xdd
_PCA0CPM0       DATA 0xda
_PCA0CPM1       DATA 0xdb
_PCA0CPM2       DATA 0xdc
_PCA0CPM3       DATA 0xae
_PCA0CPM4       DATA 0xaf
_PCA0CPM5       DATA 0xcc
_PCA0H          DATA 0xfa
_PCA0L          DATA 0xf9
_PCA0MD         DATA 0xd9
_PCA0POL        DATA 0x96
_PCA0PWM        DATA 0xf7
_PCON0          DATA 0x87
_PCON1          DATA 0xcd
_PFE0CN         DATA 0xc1
_PRTDRV         DATA 0xf6
_PSCTL          DATA 0x8f
_PSTAT0         DATA 0xaa
_PSW            DATA 0xd0
_REF0CN         DATA 0xd1
_REG0CN         DATA 0xc9
_REVID          DATA 0xb6
_RSTSRC         DATA 0xef
_SBCON1         DATA 0x94
_SBRLH1         DATA 0x96
_SBRLL1         DATA 0x95
_SBUF           DATA 0x99
_SBUF0          DATA 0x99
_SBUF1          DATA 0x92
_SCON           DATA 0x98
_SCON0          DATA 0x98
_SCON1          DATA 0xc8
_SFRPAGE        DATA 0xa7
_SFRPGCN        DATA 0xbc
_SFRSTACK       DATA 0xd7
_SMB0ADM        DATA 0xd6
_SMB0ADR        DATA 0xd7
_SMB0CF         DATA 0xc1
_SMB0CN0        DATA 0xc0
_SMB0DAT        DATA 0xc2
_SMB0FCN0       DATA 0xc3
_SMB0FCN1       DATA 0xc4
_SMB0FCT        DATA 0xef
_SMB0RXLN       DATA 0xc5
_SMB0TC         DATA 0xac
_SMOD1          DATA 0x93
_SP             DATA 0x81
_SPI0CFG        DATA 0xa1
_SPI0CKR        DATA 0xa2
_SPI0CN0        DATA 0xf8
_SPI0DAT        DATA 0xa3
_SPI0FCN0       DATA 0x9a
_SPI0FCN1       DATA 0x9b
_SPI0FCT        DATA 0xf7
_SPI0PCF        DATA 0xdf
_TCON           DATA 0x88
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TMOD           DATA 0x89
_TMR2CN0        DATA 0xc8
_TMR2CN1        DATA 0xfd
_TMR2H          DATA 0xcf
_TMR2L          DATA 0xce
_TMR2RLH        DATA 0xcb
_TMR2RLL        DATA 0xca
_TMR3CN0        DATA 0x91
_TMR3CN1        DATA 0xfe
_TMR3H          DATA 0x95
_TMR3L          DATA 0x94
_TMR3RLH        DATA 0x93
_TMR3RLL        DATA 0x92
_TMR4CN0        DATA 0x98
_TMR4CN1        DATA 0xff
_TMR4H          DATA 0xa5
_TMR4L          DATA 0xa4
_TMR4RLH        DATA 0xa3
_TMR4RLL        DATA 0xa2
_TMR5CN0        DATA 0xc0
_TMR5CN1        DATA 0xf1
_TMR5H          DATA 0xd5
_TMR5L          DATA 0xd4
_TMR5RLH        DATA 0xd3
_TMR5RLL        DATA 0xd2
_UART0PCF       DATA 0xd9
_UART1FCN0      DATA 0x9d
_UART1FCN1      DATA 0xd8
_UART1FCT       DATA 0xfa
_UART1LIN       DATA 0x9e
_UART1PCF       DATA 0xda
_VDM0CN         DATA 0xff
_WDTCN          DATA 0x97
_XBR0           DATA 0xe1
_XBR1           DATA 0xe2
_XBR2           DATA 0xe3
_XOSC0CN        DATA 0x86
_DPTR           DATA 0x8382
_TMR2RL         DATA 0xcbca
_TMR3RL         DATA 0x9392
_TMR4RL         DATA 0xa3a2
_TMR5RL         DATA 0xd3d2
_TMR0           DATA 0x8c8a
_TMR1           DATA 0x8d8b
_TMR2           DATA 0xcfce
_TMR3           DATA 0x9594
_TMR4           DATA 0xa5a4
_TMR5           DATA 0xd5d4
_SBRL1          DATA 0x9695
_PCA0           DATA 0xfaf9
_PCA0CP0        DATA 0xfcfb
_PCA0CP1        DATA 0xeae9
_PCA0CP2        DATA 0xeceb
_PCA0CP3        DATA 0xf5f4
_PCA0CP4        DATA 0x8584
_PCA0CP5        DATA 0xdedd
_ADC0ASA        DATA 0xb6b5
_ADC0GT         DATA 0xc4c3
_ADC0           DATA 0xbebd
_ADC0LT         DATA 0xc6c5
_DAC0           DATA 0x8584
_DAC1           DATA 0x8a89
_DAC2           DATA 0x8c8b
_DAC3           DATA 0x8e8d
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_TEMPE          BIT 0xe8
_ADGN0          BIT 0xe9
_ADGN1          BIT 0xea
_ADWINT         BIT 0xeb
_ADBUSY         BIT 0xec
_ADINT          BIT 0xed
_IPOEN          BIT 0xee
_ADEN           BIT 0xef
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_C0FIF          BIT 0xe8
_C0RIF          BIT 0xe9
_C1FIF          BIT 0xea
_C1RIF          BIT 0xeb
_C2FIF          BIT 0xec
_C2RIF          BIT 0xed
_C3FIF          BIT 0xee
_C3RIF          BIT 0xef
_D1SRC0         BIT 0x88
_D1SRC1         BIT 0x89
_D1AMEN         BIT 0x8a
_D01REFSL       BIT 0x8b
_D3SRC0         BIT 0x8c
_D3SRC1         BIT 0x8d
_D3AMEN         BIT 0x8e
_D23REFSL       BIT 0x8f
_D0UDIS         BIT 0x98
_D1UDIS         BIT 0x99
_D2UDIS         BIT 0x9a
_D3UDIS         BIT 0x9b
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES0            BIT 0xac
_ET2            BIT 0xad
_ESPI0          BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS0            BIT 0xbc
_PT2            BIT 0xbd
_PSPI0          BIT 0xbe
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_7           BIT 0xb7
_CCF0           BIT 0xd8
_CCF1           BIT 0xd9
_CCF2           BIT 0xda
_CCF3           BIT 0xdb
_CCF4           BIT 0xdc
_CCF5           BIT 0xdd
_CR             BIT 0xde
_CF             BIT 0xdf
_PARITY         BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_CE             BIT 0x9d
_SMODE          BIT 0x9e
_RI1            BIT 0xc8
_TI1            BIT 0xc9
_RBX1           BIT 0xca
_TBX1           BIT 0xcb
_REN1           BIT 0xcc
_PERR1          BIT 0xcd
_OVR1           BIT 0xce
_SI             BIT 0xc0
_ACK            BIT 0xc1
_ARBLOST        BIT 0xc2
_ACKRQ          BIT 0xc3
_STO            BIT 0xc4
_STA            BIT 0xc5
_TXMODE         BIT 0xc6
_MASTER         BIT 0xc7
_SPIEN          BIT 0xf8
_TXNF           BIT 0xf9
_NSSMD0         BIT 0xfa
_NSSMD1         BIT 0xfb
_RXOVRN         BIT 0xfc
_MODF           BIT 0xfd
_WCOL           BIT 0xfe
_SPIF           BIT 0xff
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_T2XCLK0        BIT 0xc8
_T2XCLK1        BIT 0xc9
_TR2            BIT 0xca
_T2SPLIT        BIT 0xcb
_TF2CEN         BIT 0xcc
_TF2LEN         BIT 0xcd
_TF2L           BIT 0xce
_TF2H           BIT 0xcf
_T4XCLK0        BIT 0x98
_T4XCLK1        BIT 0x99
_TR4            BIT 0x9a
_T4SPLIT        BIT 0x9b
_TF4CEN         BIT 0x9c
_TF4LEN         BIT 0x9d
_TF4L           BIT 0x9e
_TF4H           BIT 0x9f
_T5XCLK0        BIT 0xc0
_T5XCLK1        BIT 0xc1
_TR5            BIT 0xc2
_T5SPLIT        BIT 0xc3
_TF5CEN         BIT 0xc4
_TF5LEN         BIT 0xc5
_TF5L           BIT 0xc6
_TF5H           BIT 0xc7
_RIE            BIT 0xd8
_RXTO0          BIT 0xd9
_RXTO1          BIT 0xda
_RFRQ           BIT 0xdb
_TIE            BIT 0xdc
_TXHOLD         BIT 0xdd
_TXNF1          BIT 0xde
_TFRQ           BIT 0xdf
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_overflow_count:
	ds 1
_sendMessage_PARM_2:
	ds 2
_sendMessage_PARM_3:
	ds 2
_sendMessage_PARM_4:
	ds 2
_main_Vx_1_75:
	ds 4
_main_backward_L_1_75:
	ds 2
_main_backward_R_1_75:
	ds 2
_main_forward_L_1_75:
	ds 2
_main_forward_R_1_75:
	ds 2
_main_sloc0_1_0:
	ds 4
_main_sloc1_1_0:
	ds 4
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
_InitPinADC_PARM_2:
	ds 1
	rseg	R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_on_off:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
	CSEG at 0x002b
	ljmp	_Timer2_ISR
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:32: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:35: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:36: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:37: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:39: VDM0CN |= 0x80;
	orl	_VDM0CN,#0x80
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:40: RSTSRC = 0x02;
	mov	_RSTSRC,#0x02
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:47: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:48: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:49: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:70: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:71: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:72: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:73: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:74: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:75: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:81: P2MDOUT|=0b_0000_0011;
	orl	_P2MDOUT,#0x03
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:82: P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	orl	_P0MDOUT,#0x10
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:83: XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	mov	_XBR0,#0x01
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:84: XBR1     = 0X10; // Enable T0 on P0.0
	mov	_XBR1,#0x10
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:85: XBR2     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:91: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:92: CKCON0 |= 0b_0000_0000 ; // Timer 1 uses the system clock divided by 12.
	mov	_CKCON0,_CKCON0
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:93: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:94: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:95: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:96: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:97: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:98: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:101: TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	mov	_TMR2CN0,#0x00
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:102: CKCON0|=0b_0001_0000;
	orl	_CKCON0,#0x10
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:103: TMR2RL=(-(SYSCLK/(2*DEFAULT_F))); // Initialize reload value
	mov	_TMR2RL,#0xEE
	mov	(_TMR2RL >> 8),#0xF6
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:104: TMR2=0xffff;   // Set to reload immediately
	mov	_TMR2,#0xFF
	mov	(_TMR2 >> 8),#0xFF
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:105: ET2=1;         // Enable Timer2 interrupts
	setb	_ET2
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:106: TR2=1;         // Start Timer2
	setb	_TR2
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:107: EA=1; // Global interrupt enable
	setb	_EA
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:109: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:113: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:118: CKCON0|=0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:120: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:121: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:123: TMR3CN0 = 0x04;                 // Start Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:124: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L003006?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L003009?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:126: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L003001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L003001?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:127: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:128: if (TF0)
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:130: TF0=0;
	jbc	_TF0,L003019?
	sjmp	L003008?
L003019?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:131: overflow_count++;
	inc	_overflow_count
L003008?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:124: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L003006?
L003009?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:134: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:137: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:140: for(j=ms; j!=0; j--)
L004001?:
	cjne	r2,#0x00,L004010?
	cjne	r3,#0x00,L004010?
	ret
L004010?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:142: Timer3us(249);
	mov	dpl,#0xF9
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:143: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:144: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:145: Timer3us(250);
	mov	dpl,#0xFA
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:140: for(j=ms; j!=0; j--)
	dec	r2
	cjne	r2,#0xff,L004011?
	dec	r3
L004011?:
	sjmp	L004001?
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer2_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:149: void Timer2_ISR (void) interrupt INTERRUPT_TIMER2
;	-----------------------------------------
;	 function Timer2_ISR
;	-----------------------------------------
_Timer2_ISR:
	push	psw
	mov	psw,#0x00
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:151: TF2H = 0; // Clear Timer2 interrupt flag
	clr	_TF2H
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:152: OUT0=!OUT0;
	cpl	_P2_0
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:153: OUT1=!OUT0;
	mov	c,_P2_0
	cpl	c
	mov	_P2_1,c
	pop	psw
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;	eliminated unneeded push/pop acc
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:156: void InitADC (void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:158: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:159: ADC0CN1 = 0b_10_000_000; //14-bit,  Right justified no shifting applied, perform and Accumulate 1 conversion.
	mov	_ADC0CN1,#0x80
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:160: ADC0CF0 = 0b_11111_0_00; // SYSCLK/32
	mov	_ADC0CF0,#0xF8
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:161: ADC0CF1 = 0b_0_0_011110; // Same as default for now
	mov	_ADC0CF1,#0x1E
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:162: ADC0CN0 = 0b_0_0_0_0_0_00_0; // Same as default for now
	mov	_ADC0CN0,#0x00
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:163: ADC0CF2 = 0b_0_01_11111 ; // GND pin, Vref=VDD
	mov	_ADC0CF2,#0x3F
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:164: ADC0CN2 = 0b_0_000_0000;  // Same as default for now. ADC0 conversion initiated on write of 1 to ADBUSY.
	mov	_ADC0CN2,#0x00
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:165: ADEN=1; // Enable ADC
	setb	_ADEN
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitPinADC'
;------------------------------------------------------------
;pinno                     Allocated with name '_InitPinADC_PARM_2'
;portno                    Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:170: void InitPinADC (unsigned char portno, unsigned char pinno)
;	-----------------------------------------
;	 function InitPinADC
;	-----------------------------------------
_InitPinADC:
	mov	r2,dpl
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:174: mask=1<<pinno;
	mov	b,_InitPinADC_PARM_2
	inc	b
	mov	a,#0x01
	sjmp	L007013?
L007011?:
	add	a,acc
L007013?:
	djnz	b,L007011?
	mov	r3,a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:176: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:177: switch (portno)
	cjne	r2,#0x00,L007014?
	sjmp	L007001?
L007014?:
	cjne	r2,#0x01,L007015?
	sjmp	L007002?
L007015?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:179: case 0:
	cjne	r2,#0x02,L007005?
	sjmp	L007003?
L007001?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:180: P0MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P0MDIN,a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:181: P0SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P0SKIP,a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:182: break;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:183: case 1:
	sjmp	L007005?
L007002?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:184: P1MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P1MDIN,a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:185: P1SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P1SKIP,a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:186: break;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:187: case 2:
	sjmp	L007005?
L007003?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:188: P2MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P2MDIN,a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:189: P2SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P2SKIP,a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:193: }
L007005?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:194: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:197: unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_ADC0MX,dpl
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:200: ADBUSY=1;       // Dummy conversion first to select new pin
	setb	_ADBUSY
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:201: while (ADBUSY); // Wait for dummy conversion to finish
L008001?:
	jb	_ADBUSY,L008001?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:202: ADBUSY = 1;     // Convert voltage at the pin
	setb	_ADBUSY
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:203: while (ADBUSY); // Wait for conversion to complete
L008004?:
	jb	_ADBUSY,L008004?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:204: return (ADC0);
	mov	dpl,_ADC0
	mov	dph,(_ADC0 >> 8)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Volts_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:207: float Volts_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function Volts_at_Pin
;	-----------------------------------------
_Volts_at_Pin:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:209: return ((ADC_at_Pin(pin)*VDD)/0b_0011_1111_1111_1111);
	lcall	_ADC_at_Pin
	lcall	___uint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x6C8B
	mov	b,#0x53
	mov	a,#0x40
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0xFC
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x46
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'sendZero'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:212: void sendZero(void)
;	-----------------------------------------
;	 function sendZero
;	-----------------------------------------
_sendZero:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:214: TR2=0; // Stop timer 2
	clr	_TR2
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:215: waitms(BITWIDTH);
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'sendOne'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:218: void sendOne(void)
;	-----------------------------------------
;	 function sendOne
;	-----------------------------------------
_sendOne:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:220: TR2=1; //Start timer 2
	setb	_TR2
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:221: waitms(BITWIDTH);
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'sendCommand'
;------------------------------------------------------------
;number_send               Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:224: void sendCommand (int number_send)
;	-----------------------------------------
;	 function sendCommand
;	-----------------------------------------
_sendCommand:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:226: if(number_send>=8)
	clr	c
	mov	a,r2
	subb	a,#0x08
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jc	L012002?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:227: sendOne();
	push	ar2
	push	ar3
	lcall	_sendOne
	pop	ar3
	pop	ar2
	sjmp	L012003?
L012002?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:229: sendZero();
	push	ar2
	push	ar3
	lcall	_sendZero
	pop	ar3
	pop	ar2
L012003?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:230: if(number_send%8>=4)
	mov	__modsint_PARM_2,#0x08
	clr	a
	mov	(__modsint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	__modsint
	mov	r4,dpl
	mov	r5,dph
	pop	ar3
	pop	ar2
	clr	c
	mov	a,r4
	subb	a,#0x04
	mov	a,r5
	xrl	a,#0x80
	subb	a,#0x80
	jc	L012005?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:231: sendOne();
	push	ar2
	push	ar3
	lcall	_sendOne
	pop	ar3
	pop	ar2
	sjmp	L012006?
L012005?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:233: sendZero();
	push	ar2
	push	ar3
	lcall	_sendZero
	pop	ar3
	pop	ar2
L012006?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:234: if(number_send%4>=2)
	mov	__modsint_PARM_2,#0x04
	clr	a
	mov	(__modsint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	__modsint
	mov	r4,dpl
	mov	r5,dph
	pop	ar3
	pop	ar2
	clr	c
	mov	a,r4
	subb	a,#0x02
	mov	a,r5
	xrl	a,#0x80
	subb	a,#0x80
	jc	L012008?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:235: sendOne();
	push	ar2
	push	ar3
	lcall	_sendOne
	pop	ar3
	pop	ar2
	sjmp	L012009?
L012008?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:237: sendZero();
	push	ar2
	push	ar3
	lcall	_sendZero
	pop	ar3
	pop	ar2
L012009?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:238: if(number_send%2>=1)
	mov	__modsint_PARM_2,#0x02
	clr	a
	mov	(__modsint_PARM_2 + 1),a
	mov	dpl,r2
	mov	dph,r3
	lcall	__modsint
	mov	r2,dpl
	mov	r3,dph
	clr	c
	mov	a,r2
	subb	a,#0x01
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jc	L012011?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:239: sendOne();
	ljmp	_sendOne
L012011?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:241: sendZero();
	ljmp	_sendZero
;------------------------------------------------------------
;Allocation info for local variables in function 'sendMessage'
;------------------------------------------------------------
;backward_R                Allocated with name '_sendMessage_PARM_2'
;forward_L                 Allocated with name '_sendMessage_PARM_3'
;forward_R                 Allocated with name '_sendMessage_PARM_4'
;backward_L                Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:244: void sendMessage (int backward_L, int backward_R, int forward_L, int forward_R)
;	-----------------------------------------
;	 function sendMessage
;	-----------------------------------------
_sendMessage:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:247: sendOne();
	push	ar2
	push	ar3
	lcall	_sendOne
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:248: sendOne();
	lcall	_sendOne
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:249: sendZero();
	lcall	_sendZero
	pop	ar3
	pop	ar2
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:250: if (forward_L>0)
	clr	c
	clr	a
	subb	a,_sendMessage_PARM_3
	clr	a
	xrl	a,#0x80
	mov	b,(_sendMessage_PARM_3 + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L013002?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:252: sendOne();
	lcall	_sendOne
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:253: sendCommand(forward_L);
	mov	dpl,_sendMessage_PARM_3
	mov	dph,(_sendMessage_PARM_3 + 1)
	lcall	_sendCommand
	sjmp	L013003?
L013002?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:257: sendZero();
	push	ar2
	push	ar3
	lcall	_sendZero
	pop	ar3
	pop	ar2
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:258: sendCommand(backward_L);
	mov	dpl,r2
	mov	dph,r3
	lcall	_sendCommand
L013003?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:260: if (forward_R>0)
	clr	c
	clr	a
	subb	a,_sendMessage_PARM_4
	clr	a
	xrl	a,#0x80
	mov	b,(_sendMessage_PARM_4 + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L013005?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:262: sendOne();
	lcall	_sendOne
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:263: sendCommand(forward_R);
	mov	dpl,_sendMessage_PARM_4
	mov	dph,(_sendMessage_PARM_4 + 1)
	lcall	_sendCommand
	sjmp	L013006?
L013005?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:267: sendZero();
	lcall	_sendZero
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:268: sendCommand(backward_R);
	mov	dpl,_sendMessage_PARM_2
	mov	dph,(_sendMessage_PARM_2 + 1)
	lcall	_sendCommand
L013006?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:270: sendZero();
	lcall	_sendZero
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:271: sendZero();
	lcall	_sendZero
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:272: sendOne();
	lcall	_sendOne
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:274: TR2=0;
	clr	_TR2
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:275: waitms(DELAY*BITWIDTH);
	mov	dptr,#0x0050
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;Vx                        Allocated with name '_main_Vx_1_75'
;Vy                        Allocated to registers r4 r5 r2 r3 
;backward_L                Allocated with name '_main_backward_L_1_75'
;backward_R                Allocated with name '_main_backward_R_1_75'
;forward_L                 Allocated with name '_main_forward_L_1_75'
;forward_R                 Allocated with name '_main_forward_R_1_75'
;sloc0                     Allocated with name '_main_sloc0_1_0'
;sloc1                     Allocated with name '_main_sloc1_1_0'
;------------------------------------------------------------
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:278: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:282: unsigned int backward_L = 0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:283: unsigned int backward_R = 0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:284: unsigned int forward_L = 0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:285: unsigned int forward_R = 0;
	clr	a
	mov	_main_backward_L_1_75,a
	mov	(_main_backward_L_1_75 + 1),a
	mov	_main_backward_R_1_75,a
	mov	(_main_backward_R_1_75 + 1),a
	mov	_main_forward_L_1_75,a
	mov	(_main_forward_L_1_75 + 1),a
	mov	_main_forward_R_1_75,a
	mov	(_main_forward_R_1_75 + 1),a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:287: InitADC();
	lcall	_InitADC
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:288: InitPinADC(0,1);
	mov	_InitPinADC_PARM_2,#0x01
	mov	dpl,#0x00
	lcall	_InitPinADC
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:289: InitPinADC(0,2);
	mov	_InitPinADC_PARM_2,#0x02
	mov	dpl,#0x00
	lcall	_InitPinADC
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:291: TMR2RL=0x10000L-(SYSCLK/(2L*FREQ));
	mov	_TMR2RL,#0xEE
	mov	(_TMR2RL >> 8),#0xF6
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:292: TR2=0; // Stop timer 2
	clr	_TR2
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:294: while(1)
L014051?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:296: Vx = Volts_at_Pin(QFP32_MUX_P0_1);
	mov	dpl,#0x00
	lcall	_Volts_at_Pin
	mov	_main_Vx_1_75,dpl
	mov	(_main_Vx_1_75 + 1),dph
	mov	(_main_Vx_1_75 + 2),b
	mov	(_main_Vx_1_75 + 3),a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:297: Vy = Volts_at_Pin(QFP32_MUX_P0_2);
	mov	dpl,#0x01
	lcall	_Volts_at_Pin
	mov	r4,dpl
	mov	r5,dph
	mov	r2,b
	mov	r3,a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:299: if(Vx>VxMidHigh && Vy>VyMidHigh)  //forward right
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#0x3D
	push	acc
	mov	a,#0x0A
	push	acc
	mov	a,#0xD7
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_Vx_1_75
	mov	dph,(_main_Vx_1_75 + 1)
	mov	b,(_main_Vx_1_75 + 2)
	mov	a,(_main_Vx_1_75 + 3)
	lcall	___fsgt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jnz	L014084?
	ljmp	L014039?
L014084?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	mov	a,#0xCD
	push	acc
	mov	a,#0xCC
	push	acc
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fsgt
	mov	r7,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r7
	jnz	L014085?
	ljmp	L014039?
L014085?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:301: backward_L=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:302: backward_R=0;
	clr	a
	mov	_main_backward_L_1_75,a
	mov	(_main_backward_L_1_75 + 1),a
	mov	_main_backward_R_1_75,a
	mov	(_main_backward_R_1_75 + 1),a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:303: forward_L=(int)(((Vx-VxMid)/VxMid)*10);
	mov	a,#0x8F
	push	acc
	mov	a,#0xC2
	push	acc
	mov	a,#0xD5
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_Vx_1_75
	mov	dph,(_main_Vx_1_75 + 1)
	mov	b,(_main_Vx_1_75 + 2)
	mov	a,(_main_Vx_1_75 + 3)
	lcall	___fssub
	mov	_main_sloc0_1_0,dpl
	mov	(_main_sloc0_1_0 + 1),dph
	mov	(_main_sloc0_1_0 + 2),b
	mov	(_main_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x8F
	push	acc
	mov	a,#0xC2
	push	acc
	mov	a,#0xD5
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fsdiv
	mov	_main_sloc0_1_0,dpl
	mov	(_main_sloc0_1_0 + 1),dph
	mov	(_main_sloc0_1_0 + 2),b
	mov	(_main_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_main_sloc0_1_0
	push	(_main_sloc0_1_0 + 1)
	push	(_main_sloc0_1_0 + 2)
	push	(_main_sloc0_1_0 + 3)
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	_main_sloc0_1_0,dpl
	mov	(_main_sloc0_1_0 + 1),dph
	mov	(_main_sloc0_1_0 + 2),b
	mov	(_main_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fs2sint
	mov	_main_forward_L_1_75,dpl
	mov	(_main_forward_L_1_75 + 1),dph
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:304: forward_R=(int)((((Vx-VxMid)/VxMid)*10)/2.0);
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0x40
	push	acc
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fsdiv
	mov	_main_sloc0_1_0,dpl
	mov	(_main_sloc0_1_0 + 1),dph
	mov	(_main_sloc0_1_0 + 2),b
	mov	(_main_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fs2sint
	mov	_main_forward_R_1_75,dpl
	mov	(_main_forward_R_1_75 + 1),dph
	ljmp	L014040?
L014039?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:306: else if(Vx>VxMidHigh && Vy<VyMidLow) //forward left
	mov	a,r6
	jnz	L014086?
	ljmp	L014035?
L014086?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	mov	a,#0x71
	push	acc
	mov	a,#0x3D
	push	acc
	mov	a,#0xCA
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fslt
	mov	r7,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r7
	jnz	L014087?
	ljmp	L014035?
L014087?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:308: backward_L=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:309: backward_R=0;
	clr	a
	mov	_main_backward_L_1_75,a
	mov	(_main_backward_L_1_75 + 1),a
	mov	_main_backward_R_1_75,a
	mov	(_main_backward_R_1_75 + 1),a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:310: forward_L=(int)((((Vx-VxMid)/VxMid)*10)/2.0);
	mov	a,#0x8F
	push	acc
	mov	a,#0xC2
	push	acc
	mov	a,#0xD5
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_Vx_1_75
	mov	dph,(_main_Vx_1_75 + 1)
	mov	b,(_main_Vx_1_75 + 2)
	mov	a,(_main_Vx_1_75 + 3)
	lcall	___fssub
	mov	_main_sloc0_1_0,dpl
	mov	(_main_sloc0_1_0 + 1),dph
	mov	(_main_sloc0_1_0 + 2),b
	mov	(_main_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x8F
	push	acc
	mov	a,#0xC2
	push	acc
	mov	a,#0xD5
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fsdiv
	mov	_main_sloc0_1_0,dpl
	mov	(_main_sloc0_1_0 + 1),dph
	mov	(_main_sloc0_1_0 + 2),b
	mov	(_main_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_main_sloc0_1_0
	push	(_main_sloc0_1_0 + 1)
	push	(_main_sloc0_1_0 + 2)
	push	(_main_sloc0_1_0 + 3)
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	_main_sloc0_1_0,dpl
	mov	(_main_sloc0_1_0 + 1),dph
	mov	(_main_sloc0_1_0 + 2),b
	mov	(_main_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0x40
	push	acc
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fsdiv
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fs2sint
	mov	_main_forward_L_1_75,dpl
	mov	(_main_forward_L_1_75 + 1),dph
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:311: forward_R=(int)(((Vx-VxMid)/VxMid)*10);	
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fs2sint
	mov	_main_forward_R_1_75,dpl
	mov	(_main_forward_R_1_75 + 1),dph
	ljmp	L014040?
L014035?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:313: else if(Vx>VxMidHigh && Vy>VyMidLow && Vy<VyMidHigh) //forward
	mov	a,r6
	jnz	L014088?
	ljmp	L014030?
L014088?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#0x71
	push	acc
	mov	a,#0x3D
	push	acc
	mov	a,#0xCA
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fsgt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jnz	L014089?
	ljmp	L014030?
L014089?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#0xCD
	push	acc
	mov	a,#0xCC
	push	acc
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fslt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jnz	L014090?
	ljmp	L014030?
L014090?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:315: backward_L=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:316: backward_R=0;
	clr	a
	mov	_main_backward_L_1_75,a
	mov	(_main_backward_L_1_75 + 1),a
	mov	_main_backward_R_1_75,a
	mov	(_main_backward_R_1_75 + 1),a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:317: forward_L=(int)(((Vx-VxMid)/VxMid)*10);
	mov	a,#0x8F
	push	acc
	mov	a,#0xC2
	push	acc
	mov	a,#0xD5
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_Vx_1_75
	mov	dph,(_main_Vx_1_75 + 1)
	mov	b,(_main_Vx_1_75 + 2)
	mov	a,(_main_Vx_1_75 + 3)
	lcall	___fssub
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x8F
	push	acc
	mov	a,#0xC2
	push	acc
	mov	a,#0xD5
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fs2sint
	mov	r6,dpl
	mov	r7,dph
	mov	_main_forward_L_1_75,r6
	mov	(_main_forward_L_1_75 + 1),r7
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:318: forward_R=(int)(((Vx-VxMid)/VxMid)*10);
	mov	_main_forward_R_1_75,r6
	mov	(_main_forward_R_1_75 + 1),r7
	ljmp	L014040?
L014030?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:320: else if(Vx<VxMidLow && Vy>VyMidHigh) //back right
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#0xE1
	push	acc
	mov	a,#0x7A
	push	acc
	mov	a,#0xD4
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_Vx_1_75
	mov	dph,(_main_Vx_1_75 + 1)
	mov	b,(_main_Vx_1_75 + 2)
	mov	a,(_main_Vx_1_75 + 3)
	lcall	___fslt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jnz	L014091?
	ljmp	L014026?
L014091?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	mov	a,#0xCD
	push	acc
	mov	a,#0xCC
	push	acc
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fsgt
	mov	r7,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r7
	jnz	L014092?
	ljmp	L014026?
L014092?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:322: backward_L=(int)(((VxMid-Vx)/VxMid)*10);
	push	_main_Vx_1_75
	push	(_main_Vx_1_75 + 1)
	push	(_main_Vx_1_75 + 2)
	push	(_main_Vx_1_75 + 3)
	mov	dptr,#0xC28F
	mov	b,#0xD5
	mov	a,#0x3F
	lcall	___fssub
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x8F
	push	acc
	mov	a,#0xC2
	push	acc
	mov	a,#0xD5
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fsdiv
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_main_sloc1_1_0
	push	(_main_sloc1_1_0 + 1)
	push	(_main_sloc1_1_0 + 2)
	push	(_main_sloc1_1_0 + 3)
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fs2sint
	mov	_main_backward_L_1_75,dpl
	mov	(_main_backward_L_1_75 + 1),dph
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:323: backward_R=(int)((((VxMid-Vx)/VxMid)*10)/2.0);
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0x40
	push	acc
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fsdiv
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fs2sint
	mov	_main_backward_R_1_75,dpl
	mov	(_main_backward_R_1_75 + 1),dph
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:324: forward_L=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:325: forward_R=0;	
	clr	a
	mov	_main_forward_L_1_75,a
	mov	(_main_forward_L_1_75 + 1),a
	mov	_main_forward_R_1_75,a
	mov	(_main_forward_R_1_75 + 1),a
	ljmp	L014040?
L014026?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:327: else if(Vx<VxMidLow && Vy<VyMidLow)  //back left
	mov	a,r6
	jnz	L014093?
	ljmp	L014022?
L014093?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	mov	a,#0x71
	push	acc
	mov	a,#0x3D
	push	acc
	mov	a,#0xCA
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fslt
	mov	r7,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r7
	jnz	L014094?
	ljmp	L014022?
L014094?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:329: backward_L=(int)((((VxMid-Vx)/VxMid)*10)/2.0);
	push	_main_Vx_1_75
	push	(_main_Vx_1_75 + 1)
	push	(_main_Vx_1_75 + 2)
	push	(_main_Vx_1_75 + 3)
	mov	dptr,#0xC28F
	mov	b,#0xD5
	mov	a,#0x3F
	lcall	___fssub
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x8F
	push	acc
	mov	a,#0xC2
	push	acc
	mov	a,#0xD5
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fsdiv
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_main_sloc1_1_0
	push	(_main_sloc1_1_0 + 1)
	push	(_main_sloc1_1_0 + 2)
	push	(_main_sloc1_1_0 + 3)
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	push	acc
	push	acc
	mov	a,#0x40
	push	acc
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fsdiv
	mov	_main_sloc0_1_0,dpl
	mov	(_main_sloc0_1_0 + 1),dph
	mov	(_main_sloc0_1_0 + 2),b
	mov	(_main_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fs2sint
	mov	_main_backward_L_1_75,dpl
	mov	(_main_backward_L_1_75 + 1),dph
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:330: backward_R=(int)(((VxMid-Vx)/VxMid)*10);
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fs2sint
	mov	_main_backward_R_1_75,dpl
	mov	(_main_backward_R_1_75 + 1),dph
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:331: forward_L=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:332: forward_R=0;
	clr	a
	mov	_main_forward_L_1_75,a
	mov	(_main_forward_L_1_75 + 1),a
	mov	_main_forward_R_1_75,a
	mov	(_main_forward_R_1_75 + 1),a
	ljmp	L014040?
L014022?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:334: else if(Vx<VxMidLow && Vy>VyMidLow && Vy<VyMidHigh) //backward
	mov	a,r6
	jnz	L014095?
	ljmp	L014017?
L014095?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#0x71
	push	acc
	mov	a,#0x3D
	push	acc
	mov	a,#0xCA
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fsgt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jnz	L014096?
	ljmp	L014017?
L014096?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#0xCD
	push	acc
	mov	a,#0xCC
	push	acc
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fslt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jnz	L014097?
	ljmp	L014017?
L014097?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:336: backward_L=(int)(((VxMid-Vx)/VxMid)*10);
	push	_main_Vx_1_75
	push	(_main_Vx_1_75 + 1)
	push	(_main_Vx_1_75 + 2)
	push	(_main_Vx_1_75 + 3)
	mov	dptr,#0xC28F
	mov	b,#0xD5
	mov	a,#0x3F
	lcall	___fssub
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x8F
	push	acc
	mov	a,#0xC2
	push	acc
	mov	a,#0xD5
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fs2sint
	mov	r6,dpl
	mov	r7,dph
	mov	_main_backward_L_1_75,r6
	mov	(_main_backward_L_1_75 + 1),r7
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:337: backward_R=(int)(((VxMid-Vx)/VxMid)*10);
	mov	_main_backward_R_1_75,r6
	mov	(_main_backward_R_1_75 + 1),r7
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:338: forward_L=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:339: forward_R=0;		
	clr	a
	mov	_main_forward_L_1_75,a
	mov	(_main_forward_L_1_75 + 1),a
	mov	_main_forward_R_1_75,a
	mov	(_main_forward_R_1_75 + 1),a
	ljmp	L014040?
L014017?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:341: else if(Vx<VxMidHigh && Vx>VxMidLow && Vy>VyMidHigh) // right
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#0x3D
	push	acc
	mov	a,#0x0A
	push	acc
	mov	a,#0xD7
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_Vx_1_75
	mov	dph,(_main_Vx_1_75 + 1)
	mov	b,(_main_Vx_1_75 + 2)
	mov	a,(_main_Vx_1_75 + 3)
	lcall	___fslt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jnz	L014098?
	ljmp	L014012?
L014098?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	mov	a,#0xE1
	push	acc
	mov	a,#0x7A
	push	acc
	mov	a,#0xD4
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_Vx_1_75
	mov	dph,(_main_Vx_1_75 + 1)
	mov	b,(_main_Vx_1_75 + 2)
	mov	a,(_main_Vx_1_75 + 3)
	lcall	___fsgt
	mov	r7,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r7
	jnz	L014099?
	ljmp	L014012?
L014099?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	mov	a,#0xCD
	push	acc
	mov	a,#0xCC
	push	acc
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fsgt
	mov	r7,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r7
	jnz	L014100?
	ljmp	L014012?
L014100?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:343: backward_L=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:344: backward_R=0;
	clr	a
	mov	_main_backward_L_1_75,a
	mov	(_main_backward_L_1_75 + 1),a
	mov	_main_backward_R_1_75,a
	mov	(_main_backward_R_1_75 + 1),a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:345: forward_L=(int)(((Vy-VyMid)/VyMid)*10);
	mov	a,#0x1F
	push	acc
	mov	a,#0x85
	push	acc
	mov	a,#0xCB
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fssub
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x1F
	push	acc
	mov	a,#0x85
	push	acc
	mov	a,#0xCB
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fsdiv
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_main_sloc1_1_0
	push	(_main_sloc1_1_0 + 1)
	push	(_main_sloc1_1_0 + 2)
	push	(_main_sloc1_1_0 + 3)
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fs2sint
	mov	_main_forward_L_1_75,dpl
	mov	(_main_forward_L_1_75 + 1),dph
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:346: forward_R=0;
	clr	a
	mov	_main_forward_R_1_75,a
	mov	(_main_forward_R_1_75 + 1),a
	ljmp	L014040?
L014012?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:348: else if(Vx<VxMidHigh && Vx>VxMidLow && Vy<VyMidLow) // left
	mov	a,r6
	jnz	L014101?
	ljmp	L014007?
L014101?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	mov	a,#0xE1
	push	acc
	mov	a,#0x7A
	push	acc
	mov	a,#0xD4
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_Vx_1_75
	mov	dph,(_main_Vx_1_75 + 1)
	mov	b,(_main_Vx_1_75 + 2)
	mov	a,(_main_Vx_1_75 + 3)
	lcall	___fsgt
	mov	r7,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r7
	jnz	L014102?
	ljmp	L014007?
L014102?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	mov	a,#0x71
	push	acc
	mov	a,#0x3D
	push	acc
	mov	a,#0xCA
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fslt
	mov	r7,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r7
	jnz	L014103?
	ljmp	L014007?
L014103?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:350: backward_L=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:351: backward_R=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:352: forward_L=0;
	clr	a
	mov	_main_backward_L_1_75,a
	mov	(_main_backward_L_1_75 + 1),a
	mov	_main_backward_R_1_75,a
	mov	(_main_backward_R_1_75 + 1),a
	mov	_main_forward_L_1_75,a
	mov	(_main_forward_L_1_75 + 1),a
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:353: forward_R=(int)(((VyMid-Vy)/VyMid)*10);		
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	mov	dptr,#0x851F
	mov	b,#0xCB
	mov	a,#0x3F
	lcall	___fssub
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x1F
	push	acc
	mov	a,#0x85
	push	acc
	mov	a,#0xCB
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fsdiv
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	_main_sloc1_1_0
	push	(_main_sloc1_1_0 + 1)
	push	(_main_sloc1_1_0 + 2)
	push	(_main_sloc1_1_0 + 3)
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	_main_sloc1_1_0,dpl
	mov	(_main_sloc1_1_0 + 1),dph
	mov	(_main_sloc1_1_0 + 2),b
	mov	(_main_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_main_sloc1_1_0
	mov	dph,(_main_sloc1_1_0 + 1)
	mov	b,(_main_sloc1_1_0 + 2)
	mov	a,(_main_sloc1_1_0 + 3)
	lcall	___fs2sint
	mov	_main_forward_R_1_75,dpl
	mov	(_main_forward_R_1_75 + 1),dph
	ljmp	L014040?
L014007?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:355: else if(Vx<VxMidHigh && Vx>VxMidLow && Vy>VyMidLow && Vy<VyMidHigh) // stop
	mov	a,r6
	jnz	L014104?
	ljmp	L014040?
L014104?:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#0xE1
	push	acc
	mov	a,#0x7A
	push	acc
	mov	a,#0xD4
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,_main_Vx_1_75
	mov	dph,(_main_Vx_1_75 + 1)
	mov	b,(_main_Vx_1_75 + 2)
	mov	a,(_main_Vx_1_75 + 3)
	lcall	___fsgt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jz	L014040?
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#0x71
	push	acc
	mov	a,#0x3D
	push	acc
	mov	a,#0xCA
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fsgt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jz	L014040?
	mov	a,#0xCD
	push	acc
	mov	a,#0xCC
	push	acc
	push	acc
	mov	a,#0x3F
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r2
	mov	a,r3
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	L014040?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:357: backward_L=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:358: backward_R=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:359: forward_L=0;
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:360: forward_R=0;		
	clr	a
	mov	_main_backward_L_1_75,a
	mov	(_main_backward_L_1_75 + 1),a
	mov	_main_backward_R_1_75,a
	mov	(_main_backward_R_1_75 + 1),a
	mov	_main_forward_L_1_75,a
	mov	(_main_forward_L_1_75 + 1),a
	mov	_main_forward_R_1_75,a
	mov	(_main_forward_R_1_75 + 1),a
L014040?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:362: if (backward_L>10)
	clr	c
	mov	a,#0x0A
	subb	a,_main_backward_L_1_75
	clr	a
	subb	a,(_main_backward_L_1_75 + 1)
	jnc	L014043?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:363: backward_L = 10;
	mov	_main_backward_L_1_75,#0x0A
	clr	a
	mov	(_main_backward_L_1_75 + 1),a
L014043?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:364: if (backward_R>10)
	clr	c
	mov	a,#0x0A
	subb	a,_main_backward_R_1_75
	clr	a
	subb	a,(_main_backward_R_1_75 + 1)
	jnc	L014045?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:365: backward_R = 10;
	mov	_main_backward_R_1_75,#0x0A
	clr	a
	mov	(_main_backward_R_1_75 + 1),a
L014045?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:366: if (forward_L>10)
	clr	c
	mov	a,#0x0A
	subb	a,_main_forward_L_1_75
	clr	a
	subb	a,(_main_forward_L_1_75 + 1)
	jnc	L014047?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:367: forward_L = 10;
	mov	_main_forward_L_1_75,#0x0A
	clr	a
	mov	(_main_forward_L_1_75 + 1),a
L014047?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:368: if (forward_R>10)
	clr	c
	mov	a,#0x0A
	subb	a,_main_forward_R_1_75
	clr	a
	subb	a,(_main_forward_R_1_75 + 1)
	jnc	L014049?
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:369: forward_R = 10;
	mov	_main_forward_R_1_75,#0x0A
	clr	a
	mov	(_main_forward_R_1_75 + 1),a
L014049?:
;	C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\Transmitter_Code.c:370: sendMessage(backward_L,backward_R,forward_L,forward_R);
	mov	_sendMessage_PARM_2,_main_backward_R_1_75
	mov	(_sendMessage_PARM_2 + 1),(_main_backward_R_1_75 + 1)
	mov	_sendMessage_PARM_3,_main_forward_L_1_75
	mov	(_sendMessage_PARM_3 + 1),(_main_forward_L_1_75 + 1)
	mov	_sendMessage_PARM_4,_main_forward_R_1_75
	mov	(_sendMessage_PARM_4 + 1),(_main_forward_R_1_75 + 1)
	mov	dpl,_main_backward_L_1_75
	mov	dph,(_main_backward_L_1_75 + 1)
	lcall	_sendMessage
	ljmp	L014051?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST

	CSEG

end
