;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1069 (Apr 23 2015) (MSVC)
; This file was generated Fri Mar 30 19:27:22 2018
;--------------------------------------------------------
$name irrecievertest
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
	public _sendOnes
	public _sendMessage
	public _sendCommand
	public _sendOne
	public _sendZero
	public _Timer0_ISR
	public _Timer2_ISR
	public _waitms
	public _Timer3us
	public __c51_external_startup
	public _on_off
	public _sendMessage_PARM_4
	public _sendMessage_PARM_3
	public _sendMessage_PARM_2
	public _overflow_count
	public _flag
	public _command
	public _counter2
	public _counter
	public _pwm_count
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
_pwm_count:
	ds 1
_counter:
	ds 1
_counter2:
	ds 1
_command:
	ds 1
_flag:
	ds 1
_overflow_count:
	ds 1
_sendMessage_PARM_2:
	ds 2
_sendMessage_PARM_3:
	ds 2
_sendMessage_PARM_4:
	ds 2
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
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:30: volatile unsigned char pwm_count=0;
	mov	_pwm_count,#0x00
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:39: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:42: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:43: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:44: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:46: VDM0CN |= 0x80;
	orl	_VDM0CN,#0x80
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:47: RSTSRC = 0x02;
	mov	_RSTSRC,#0x02
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:54: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:55: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:56: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:77: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:78: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:79: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:80: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:81: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:82: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:88: P2MDOUT|=0b_0000_0011;
	orl	_P2MDOUT,#0x03
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:89: P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	orl	_P0MDOUT,#0x10
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:90: XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)
	mov	_XBR0,#0x01
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:91: XBR1     = 0X10; // Enable T0 on P0.0
	mov	_XBR1,#0x10
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:92: XBR2     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:98: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:99: CKCON0 |= 0b_0000_0000 ; // Timer 1 uses the system clock divided by 12.
	mov	_CKCON0,_CKCON0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:100: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:101: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:102: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:103: TMOD |=  0x20;
	orl	_TMOD,#0x20
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:104: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:105: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:108: TR0=0;
	clr	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:109: TF0=0;
	clr	_TF0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:110: CKCON0|=0b_0000_0100; // Timer 0 uses the system clock
	orl	_CKCON0,#0x04
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:111: TMOD&=0xf0;
	anl	_TMOD,#0xF0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:112: TMOD|=0x01; // Timer 0 in mode 1: 16-bit timer
	orl	_TMOD,#0x01
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:114: TMR0=65536L-(SYSCLK/(2*TIMER_0_FREQ));
	mov	_TMR0,#0xF0
	mov	(_TMR0 >> 8),#0xF1
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:115: ET0=1;     // Enable Timer0 interrupts
	setb	_ET0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:119: TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	mov	_TMR2CN0,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:120: CKCON0|=0b_0001_0000;
	orl	_CKCON0,#0x10
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:121: TMR2RL=(-(SYSCLK/(2*DEFAULT_F))); // Initialize reload value
	mov	_TMR2RL,#0xEE
	mov	(_TMR2RL >> 8),#0xF6
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:122: TMR2=0xffff;   // Set to reload immediately
	mov	_TMR2,#0xFF
	mov	(_TMR2 >> 8),#0xFF
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:123: ET2=1;         // Enable Timer2 interrupts
	setb	_ET2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:124: TR2=0;         // Start Timer2
	clr	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:125: TR0=0;     // Start Timer0
	clr	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:126: EA=1; // Global interrupt enable
	setb	_EA
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:128: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:132: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:137: CKCON0|=0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:139: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:140: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:142: TMR3CN0 = 0x04;                 // Start Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:143: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L003006?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L003009?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:145: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L003001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L003001?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:146: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:147: if (TF0)
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:149: TF0=0;
	jbc	_TF0,L003019?
	sjmp	L003008?
L003019?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:150: overflow_count++;
	inc	_overflow_count
L003008?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:143: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L003006?
L003009?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:153: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:156: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:159: for(j=ms; j!=0; j--)
L004001?:
	cjne	r2,#0x00,L004010?
	cjne	r3,#0x00,L004010?
	ret
L004010?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:161: Timer3us(249);
	mov	dpl,#0xF9
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:162: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:163: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:164: Timer3us(250);
	mov	dpl,#0xFA
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:159: for(j=ms; j!=0; j--)
	dec	r2
	cjne	r2,#0xff,L004011?
	dec	r3
L004011?:
	sjmp	L004001?
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer2_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:168: void Timer2_ISR (void) interrupt INTERRUPT_TIMER2
;	-----------------------------------------
;	 function Timer2_ISR
;	-----------------------------------------
_Timer2_ISR:
	push	psw
	mov	psw,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:170: TF2H = 0; // Clear Timer2 interrupt flag
	clr	_TF2H
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:171: OUT0=!OUT0;
	cpl	_P2_0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:172: OUT1=!OUT0;
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
;Allocation info for local variables in function 'Timer0_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:175: void Timer0_ISR (void) interrupt INTERRUPT_TIMER0
;	-----------------------------------------
;	 function Timer0_ISR
;	-----------------------------------------
_Timer0_ISR:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:177: SFRPAGE=0x0;
	mov	_SFRPAGE,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:179: TMR0=0x10000L-(SYSCLK/(2*TIMER_0_FREQ));
	mov	_TMR0,#0xF0
	mov	(_TMR0 >> 8),#0xF1
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:180: counter2++;
	inc	_counter2
	reti
;	eliminated unneeded push/pop psw
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;	eliminated unneeded push/pop acc
;------------------------------------------------------------
;Allocation info for local variables in function 'sendZero'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:184: void sendZero(void)
;	-----------------------------------------
;	 function sendZero
;	-----------------------------------------
_sendZero:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:186: TR2=0; // Stop timer 2
	clr	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:187: waitms(BITWIDTH);
	mov	dptr,#0x000A
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'sendOne'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:190: void sendOne(void)
;	-----------------------------------------
;	 function sendOne
;	-----------------------------------------
_sendOne:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:192: TR2=1; //Start timer 2
	setb	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:193: waitms(BITWIDTH);
	mov	dptr,#0x000A
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'sendCommand'
;------------------------------------------------------------
;number_send               Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:196: void sendCommand (int number_send)
;	-----------------------------------------
;	 function sendCommand
;	-----------------------------------------
_sendCommand:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:198: if(number_send>=8)
	clr	c
	mov	a,r2
	subb	a,#0x08
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jc	L009002?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:199: sendOne();
	push	ar2
	push	ar3
	lcall	_sendOne
	pop	ar3
	pop	ar2
	sjmp	L009003?
L009002?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:201: sendZero();
	push	ar2
	push	ar3
	lcall	_sendZero
	pop	ar3
	pop	ar2
L009003?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:202: if(number_send%8>=4)
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
	jc	L009005?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:203: sendOne();
	push	ar2
	push	ar3
	lcall	_sendOne
	pop	ar3
	pop	ar2
	sjmp	L009006?
L009005?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:205: sendZero();
	push	ar2
	push	ar3
	lcall	_sendZero
	pop	ar3
	pop	ar2
L009006?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:206: if(number_send%4>=2)
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
	jc	L009008?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:207: sendOne();
	push	ar2
	push	ar3
	lcall	_sendOne
	pop	ar3
	pop	ar2
	sjmp	L009009?
L009008?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:209: sendZero();
	push	ar2
	push	ar3
	lcall	_sendZero
	pop	ar3
	pop	ar2
L009009?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:210: if(number_send%2>=1)
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
	jc	L009011?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:211: sendOne();
	ljmp	_sendOne
L009011?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:213: sendZero();
	ljmp	_sendZero
;------------------------------------------------------------
;Allocation info for local variables in function 'sendMessage'
;------------------------------------------------------------
;backward_R                Allocated with name '_sendMessage_PARM_2'
;forward_L                 Allocated with name '_sendMessage_PARM_3'
;forward_R                 Allocated with name '_sendMessage_PARM_4'
;backward_L                Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:216: void sendMessage (int backward_L, int backward_R, int forward_L, int forward_R)
;	-----------------------------------------
;	 function sendMessage
;	-----------------------------------------
_sendMessage:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:218: sendOne();
	push	ar2
	push	ar3
	lcall	_sendOne
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:219: sendOne();
	lcall	_sendOne
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:220: sendZero();
	lcall	_sendZero
	pop	ar3
	pop	ar2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:221: if (forward_L>0)
	clr	c
	clr	a
	subb	a,_sendMessage_PARM_3
	clr	a
	xrl	a,#0x80
	mov	b,(_sendMessage_PARM_3 + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L010002?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:223: sendOne();
	lcall	_sendOne
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:224: sendCommand(forward_L);
	mov	dpl,_sendMessage_PARM_3
	mov	dph,(_sendMessage_PARM_3 + 1)
	lcall	_sendCommand
	sjmp	L010003?
L010002?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:228: sendZero();
	push	ar2
	push	ar3
	lcall	_sendZero
	pop	ar3
	pop	ar2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:229: sendCommand(backward_L);
	mov	dpl,r2
	mov	dph,r3
	lcall	_sendCommand
L010003?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:231: if (forward_R>0)
	clr	c
	clr	a
	subb	a,_sendMessage_PARM_4
	clr	a
	xrl	a,#0x80
	mov	b,(_sendMessage_PARM_4 + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L010005?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:233: sendOne();
	lcall	_sendOne
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:234: sendCommand(forward_R);
	mov	dpl,_sendMessage_PARM_4
	mov	dph,(_sendMessage_PARM_4 + 1)
	lcall	_sendCommand
	sjmp	L010006?
L010005?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:238: sendZero();
	lcall	_sendZero
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:239: sendCommand(backward_R);
	mov	dpl,_sendMessage_PARM_2
	mov	dph,(_sendMessage_PARM_2 + 1)
	lcall	_sendCommand
L010006?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:241: sendZero();
	lcall	_sendZero
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:242: sendZero();
	lcall	_sendZero
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:243: sendOne();
	lcall	_sendOne
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:244: TR2=0;
	clr	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:245: waitms(DELAY*BITWIDTH);
	mov	dptr,#0x00A0
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'sendOnes'
;------------------------------------------------------------
;number                    Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:248: void sendOnes(int number)
;	-----------------------------------------
;	 function sendOnes
;	-----------------------------------------
_sendOnes:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:250: while(number>0)
L011001?:
	clr	c
	clr	a
	subb	a,r2
	clr	a
	xrl	a,#0x80
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	jnc	L011003?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:252: sendOne();
	push	ar2
	push	ar3
	lcall	_sendOne
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:253: sendZero();
	lcall	_sendZero
	pop	ar3
	pop	ar2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:254: number--;
	dec	r2
	cjne	r2,#0xff,L011001?
	dec	r3
	sjmp	L011001?
L011003?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:256: sendZero();
	lcall	_sendZero
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:257: sendZero();
	ljmp	_sendZero
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;backward_L                Allocated to registers 
;backward_R                Allocated to registers 
;forward_L                 Allocated to registers 
;forward_R                 Allocated to registers 
;------------------------------------------------------------
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:264: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:270: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
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
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:272: "Check pins P2.0 and P2.1 with the oscilloscope.\r\n");
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
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:273: command = 0;
	mov	_command,#0x00
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:274: TR2=0;
	clr	_TR2
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:276: while(1)
L012031?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:279: if(command == 2) //forward
	mov	a,#0x02
	cjne	a,_command,L012011?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:281: sendOnes(2);
	mov	dptr,#0x0002
	lcall	_sendOnes
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:282: command = 0;
	mov	_command,#0x00
	sjmp	L012012?
L012011?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:284: else if(command == 3) //backward
	mov	a,#0x03
	cjne	a,_command,L012008?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:286: sendOnes(3);
	mov	dptr,#0x0003
	lcall	_sendOnes
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:287: command = 0;
	mov	_command,#0x00
	sjmp	L012012?
L012008?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:289: else if(command ==4) // left
	mov	a,#0x04
	cjne	a,_command,L012005?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:291: sendOnes(4);
	mov	dptr,#0x0004
	lcall	_sendOnes
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:292: command = 0;
	mov	_command,#0x00
	sjmp	L012012?
L012005?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:294: else if(command == 5) // right
	mov	a,#0x05
	cjne	a,_command,L012002?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:296: sendOnes(5);
	mov	dptr,#0x0005
	lcall	_sendOnes
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:297: command = 0;
	mov	_command,#0x00
	sjmp	L012012?
L012002?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:301: sendOnes(1);
	mov	dptr,#0x0001
	lcall	_sendOnes
L012012?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:304: if(input == 0)
	jb	_P1_7,L012031?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:306: TR0=1;
	setb	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:307: while(input == 0);
L012013?:
	jnb	_P1_7,L012013?
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:308: TR0=0;
	clr	_TR0
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:309: printf("%d",counter2);
	mov	r2,_counter2
	mov	a,_counter2
	rlc	a
	subb	a,acc
	mov	r3,a
	push	ar2
	push	ar3
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xfb
	mov	sp,a
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:310: if(counter2 == 20 || counter2 == 21)
	mov	a,#0x14
	cjne	a,_counter2,L012057?
	sjmp	L012016?
L012057?:
	mov	a,#0x15
	cjne	a,_counter2,L012017?
L012016?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:311: command =2;
	mov	_command,#0x02
L012017?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:312: if(counter2 == 17 || counter2 == 18)
	mov	a,#0x11
	cjne	a,_counter2,L012060?
	sjmp	L012019?
L012060?:
	mov	a,#0x12
	cjne	a,_counter2,L012020?
L012019?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:313: command =3;
	mov	_command,#0x03
L012020?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:314: if(counter2 == 4 ||counter2 == 5)
	mov	a,#0x04
	cjne	a,_counter2,L012063?
	sjmp	L012022?
L012063?:
	mov	a,#0x05
	cjne	a,_counter2,L012023?
L012022?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:315: command =4;
	mov	_command,#0x04
L012023?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:316: if(counter2 == 2 || counter2 == 1)
	mov	a,#0x02
	cjne	a,_counter2,L012066?
	sjmp	L012025?
L012066?:
	mov	a,#0x01
	cjne	a,_counter2,L012026?
L012025?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:317: command =5;
	mov	_command,#0x05
L012026?:
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:318: printf("%d	",command);
	mov	r2,_command
	mov	a,_command
	rlc	a
	subb	a,acc
	mov	r3,a
	push	ar2
	push	ar3
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xfb
	mov	sp,a
;	C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c:319: counter2 = 0;
	mov	_counter2,#0x00
	ljmp	L012031?
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
__str_2:
	db '%d'
	db 0x00
__str_3:
	db '%d'
	db 0x09
	db 0x00

	CSEG

end
