;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1069 (Apr 23 2015) (MSVC)
; This file was generated Fri Mar 30 18:27:00 2018
;--------------------------------------------------------
$name irtransmit
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
	public _main
	public _Timer0_ISR
	public _Timer2_ISR
	public _Timer3us
	public __c51_external_startup
	public _transmitting_flag
	public _flag
	public _command
	public _counter2
	public _counter
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
; overlayable bit register bank
;--------------------------------------------------------
	rseg BIT_BANK
bits:
	ds 1
	b0 equ  bits.0 
	b1 equ  bits.1 
	b2 equ  bits.2 
	b3 equ  bits.3 
	b4 equ  bits.4 
	b5 equ  bits.5 
	b6 equ  bits.6 
	b7 equ  bits.7 
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_overflow_count:
	ds 1
_counter:
	ds 1
_counter2:
	ds 1
_command:
	ds 1
_flag:
	ds 1
_transmitting_flag:
	ds 1
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
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
	CSEG at 0x000b
	ljmp	_Timer0_ISR
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
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:27: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:30: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:31: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:32: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:34: VDM0CN |= 0x80;
	orl	_VDM0CN,#0x80
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:35: RSTSRC = 0x02;
	mov	_RSTSRC,#0x02
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:42: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:43: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:44: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:65: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:66: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:67: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:68: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:69: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:70: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:75: P2MDOUT|=0b_0000_0001;
	orl	_P2MDOUT,#0x01
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:76: P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	orl	_P0MDOUT,#0x10
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:77: XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	mov	_XBR0,#0x01
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:78: XBR1     = 0X10; // Enable T0 on P0.0
	mov	_XBR1,#0x10
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:79: XBR2     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:85: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:86: CKCON0 |= 0b_0000_0000 ; // Timer 1 uses the system clock divided by 12.
	mov	_CKCON0,_CKCON0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:87: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:88: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:89: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:90: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:91: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:92: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:95: TR0=0;
	clr	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:96: TF0=0;
	clr	_TF0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:97: CKCON0|=0b_0000_0100; // Timer 0 uses the system clock
	orl	_CKCON0,#0x04
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:98: TMOD&=0xf0;
	anl	_TMOD,#0xF0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:99: TMOD|=0x01; // Timer 0 in mode 1: 16-bit timer
	orl	_TMOD,#0x01
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:101: TMR0=65536L-(SYSCLK/(2*TIMER_0_FREQ));
	mov	_TMR0,#0xF0
	mov	(_TMR0 >> 8),#0xF1
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:102: ET0=1;     // Enable Timer0 interrupts
	setb	_ET0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:108: TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	mov	_TMR2CN0,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:109: CKCON0|=0b_0001_0000;
	orl	_CKCON0,#0x10
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:110: TMR2RL=(-(SYSCLK/(2*DEFAULT_F))); // Initialize reload value
	mov	_TMR2RL,#0x4D
	mov	(_TMR2RL >> 8),#0xFC
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:111: TMR2=0xffff;   // Set to reload immediately
	mov	_TMR2,#0xFF
	mov	(_TMR2 >> 8),#0xFF
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:112: ET2=1;         // Enable Timer2 interrupts
	setb	_ET2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:113: TR2=0;         // Start Timer2
	clr	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:114: TR0=0;     // Start Timer0
	clr	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:115: EA=1; // Global interrupt enable
	setb	_EA
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:117: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:119: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:124: CKCON0|=0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:126: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:127: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:129: TMR3CN0 = 0x04;                 // Start Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:130: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L003006?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L003009?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:132: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L003001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L003001?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:133: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:134: if (TF0)
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:136: TF0=0;
	jbc	_TF0,L003019?
	sjmp	L003008?
L003019?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:137: overflow_count++;
	inc	_overflow_count
L003008?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:130: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L003006?
L003009?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:140: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer2_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:143: void Timer2_ISR (void) interrupt INTERRUPT_TIMER2
;	-----------------------------------------
;	 function Timer2_ISR
;	-----------------------------------------
_Timer2_ISR:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:145: TF2H = 0; // Clear Timer2 interrupt flag
	clr	_TF2H
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:147: OUT0= !OUT0;   	
	cpl	_P2_0
	reti
;	eliminated unneeded push/pop psw
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;	eliminated unneeded push/pop acc
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer0_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:149: void Timer0_ISR (void) interrupt INTERRUPT_TIMER0
;	-----------------------------------------
;	 function Timer0_ISR
;	-----------------------------------------
_Timer0_ISR:
	push	bits
	push	acc
	push	b
	push	dpl
	push	dph
	push	(0+2)
	push	(0+3)
	push	(0+4)
	push	(0+5)
	push	(0+6)
	push	(0+7)
	push	(0+0)
	push	(0+1)
	push	psw
	mov	psw,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:151: SFRPAGE=0x0;
	mov	_SFRPAGE,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:153: TMR0=0x10000L-(SYSCLK/(2*TIMER_0_FREQ));
	mov	_TMR0,#0xF0
	mov	(_TMR0 >> 8),#0xF1
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:154: counter++;
	inc	_counter
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:155: if(command == 2 && counter == 26)
	mov	a,#0x02
	cjne	a,_command,L005002?
	mov	a,#0x1A
	cjne	a,_counter,L005002?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:157: TMR2CN0=0x00;
	mov	_TMR2CN0,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:158: command = 0;
	mov	_command,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:159: counter = 0;
	mov	_counter,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:160: TR0=0; 
	clr	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:161: TR2=0;
	clr	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:162: OUT0= 0;
	clr	_P2_0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:163: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:164: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:165: transmitting_flag = 0; 
	mov	_transmitting_flag,#0x00
L005002?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:167: if(command == 3 && counter == 23)
	mov	a,#0x03
	cjne	a,_command,L005005?
	mov	a,#0x17
	cjne	a,_counter,L005005?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:169: TMR2CN0=0x00;
	mov	_TMR2CN0,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:170: command = 0;
	mov	_command,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:171: counter = 0;
	mov	_counter,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:172: TR0=0; 
	clr	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:173: TR2=0;
	clr	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:174: OUT0= 0;
	clr	_P2_0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:175: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:176: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:177: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:178: Timer3us(100); 
	mov	dpl,#0x64
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:179: transmitting_flag = 0;
	mov	_transmitting_flag,#0x00
L005005?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:181: if(command == 4 && counter == 20)
	mov	a,#0x04
	cjne	a,_command,L005008?
	mov	a,#0x14
	cjne	a,_counter,L005008?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:183: TMR2CN0=0x00;
	mov	_TMR2CN0,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:184: command = 0;
	mov	_command,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:185: counter = 0;
	mov	_counter,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:186: TR0=0; 
	clr	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:187: TR2=0; 
	clr	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:188: OUT0= 0;
	clr	_P2_0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:189: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:190: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:191: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:192: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:193: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:194: transmitting_flag = 0;
	mov	_transmitting_flag,#0x00
L005008?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:196: if(command == 5 && counter == 17)
	mov	a,#0x05
	cjne	a,_command,L005013?
	mov	a,#0x11
	cjne	a,_counter,L005013?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:198: TMR2CN0=0x00;
	mov	_TMR2CN0,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:199: command = 0;
	mov	_command,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:200: counter = 0;
	mov	_counter,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:201: TR0=0; 
	clr	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:202: TR2=0;
	clr	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:203: OUT0= 0; 
	clr	_P2_0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:204: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:205: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:206: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:207: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:208: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:209: Timer3us(200);
	mov	dpl,#0xC8
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:210: Timer3us(100);	
	mov	dpl,#0x64
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:211: transmitting_flag = 0; 			
	mov	_transmitting_flag,#0x00
L005013?:
	pop	psw
	pop	(0+1)
	pop	(0+0)
	pop	(0+7)
	pop	(0+6)
	pop	(0+5)
	pop	(0+4)
	pop	(0+3)
	pop	(0+2)
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	pop	bits
	reti
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:217: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:219: command1 = 1;
	setb	_P2_1
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:220: command2 = 1;
	setb	_P2_2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:221: command3 = 1;
	setb	_P2_3
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:222: command4 = 1;
	setb	_P2_4
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:223: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:225: "Check pins P2.0 and P2.1 with the oscilloscope.\r\n");
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:227: TR2=0; 
	clr	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:229: while(1)
L006013?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:232: if(command1 == 0)
	jb	_P2_1,L006002?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:235: command = 2;
	mov	_command,#0x02
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:236: counter2 =0;
	mov	_counter2,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:237: counter =0;
	mov	_counter,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:238: TR2=1;
	setb	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:239: TR0=1;
	setb	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:240: transmitting_flag = 1; 
	mov	_transmitting_flag,#0x01
L006002?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:242: if(command2 == 0)
	jb	_P2_2,L006004?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:245: command = 3;
	mov	_command,#0x03
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:246: counter =0;
	mov	_counter,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:247: counter2 =0;
	mov	_counter2,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:248: TR2=1;
	setb	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:249: TR0=1; 
	setb	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:250: transmitting_flag = 1;
	mov	_transmitting_flag,#0x01
L006004?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:252: if(command3 == 0)
	jb	_P2_3,L006006?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:255: command = 4;
	mov	_command,#0x04
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:256: counter =0;
	mov	_counter,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:257: counter2 =0;
	mov	_counter2,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:258: TR2=1;
	setb	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:259: TR0=1; 
	setb	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:260: transmitting_flag = 1;
	mov	_transmitting_flag,#0x01
L006006?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:262: if(command4 == 0)
	jb	_P2_4,L006009?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:265: command = 5;
	mov	_command,#0x05
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:266: counter =0;
	mov	_counter,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:267: counter2 =0;
	mov	_counter2,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:268: TR2=1;
	setb	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:269: TR0=1;
	setb	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:270: transmitting_flag = 1; 
	mov	_transmitting_flag,#0x01
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irtransmit.c:272: while(transmitting_flag==1);
L006009?:
	mov	a,#0x01
	cjne	a,_transmitting_flag,L006013?
	sjmp	L006009?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 0x1B
	db '[2J'
	db 0x00
__str_1:
	db 'Variable frequency generator for the EFM8LB1.'
	db 0x0D
	db 0x0A
	db 'Check pins P2'
	db '.0 and P2.1 with the oscilloscope.'
	db 0x0D
	db 0x0A
	db 0x00

	CSEG

end
