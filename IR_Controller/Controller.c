//  freq_gen.c: Uses timer 2 interrupt to generate a square wave at pins
//  P2.0 and P2.1.  The program allows the user to enter a frequency.
//  Copyright (c) 2010-2018 Jesus Calvino-Fraga
//  ~C51~

#include <EFM8LB1.h>
#include <stdlib.h>
#include <stdio.h>

#define SYSCLK    72000000L // SYSCLK frequency in Hz
#define BAUDRATE  115200L   // Baud rate of UART in bps
#define DEFAULT_F 15500L

#define OUT0 P2_0
#define OUT1 P2_1

#define FREQ 15500L

#define BITWIDTH 5
#define DELAY 16
#define VyMidLow 1.58
#define VyMidHigh 1.60
#define VxMidLow 1.66
#define VxMidHigh 1.68
#define VyMid 1.59
#define VxMid 1.67

#define MISO P0_1
#define MOSI P0_2
#define CSN P0_3
#define SCK P0_0
#define CE P2_0

#define F_SCK_MAX 1000000L  // Max SCK freq (Hz)

unsigned char overflow_count;

volatile unsigned bit on_off;

char _c51_external_startup (void)
{
	// Disable Watchdog with key sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; //First key
	WDTCN = 0xAD; //Second key
  
	VDM0CN |= 0x80;
	RSTSRC = 0x02;

	#if (SYSCLK == 48000000L)	
		SFRPAGE = 0x10;
		PFE0CN  = 0x10; // SYSCLK < 50 MHz.
		SFRPAGE = 0x00;
	#elif (SYSCLK == 72000000L)
		SFRPAGE = 0x10;
		PFE0CN  = 0x20; // SYSCLK < 75 MHz.
		SFRPAGE = 0x00;
	#endif
	
	#if (SYSCLK == 12250000L)
		CLKSEL = 0x10;
		CLKSEL = 0x10;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 24500000L)
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 48000000L)	
		// Before setting clock to 48 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x07;
		CLKSEL = 0x07;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 72000000L)
		// Before setting clock to 72 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x03;
		CLKSEL = 0x03;
		while ((CLKSEL & 0x80) == 0);
	#else
		#error SYSCLK must be either 12250000L, 24500000L, 48000000L, or 72000000L
	#endif
	
	P0MDOUT=0b_0001_1101;//SCK, MOSI, P0.3, TX0 are puspull, all others open-drain
	XBR0=0b_0000_0011;//SPI0E=1, URT0E=1
	XBR1=0b_0000_0000;
	XBR2=0b_0100_0000; // Enable crossbar and weak pull-ups

	#if (((SYSCLK/BAUDRATE)/(2L*12L))>0xFFL)
		#error Timer 0 reload value is incorrect because (SYSCLK/BAUDRATE)/(2L*12L) > 0xFF
	#endif
	// Configure Uart 0
	SCON0 = 0x10;
	CKCON0 |= 0b_0000_0000 ; // Timer 1 uses the system clock divided by 12.
	TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	TL1 = TH1;      // Init Timer1
	TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	TMOD |=  0x20;                       
	TR1 = 1; // START Timer1
	TI = 1;  // Indicate TX0 ready

	// Initialize timer 2 for periodic interrupts
	TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	CKCON0|=0b_0001_0000;
	TMR2RL=(-(SYSCLK/(2*DEFAULT_F))); // Initialize reload value
	TMR2=0xffff;   // Set to reload immediately
	ET2=1;         // Enable Timer2 interrupts
	TR2=1;         // Start Timer2
	EA=1; // Global interrupt enable
	
	// SPI inititialization
	SPI0CKR = (SYSCLK/(2*F_SCK_MAX))-1;
	SPI0CFG = 0b_0100_0000; //SPI in master mode
	SPI0CN0 = 0b_0000_0001; //SPI enabled and in three wire mode
	
	return 0;
}

// Uses Timer3 to delay <us> micro-seconds. 
void Timer3us(unsigned char us)
{
	unsigned char i;               // usec counter
	
	// The input for Timer 3 is selected as SYSCLK by setting T3ML (bit 6) of CKCON0:
	CKCON0|=0b_0100_0000;
	
	TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	
	TMR3CN0 = 0x04;                 // Start Timer3 and clear overflow flag
	for (i = 0; i < us; i++)       // Count <us> overflows
	{
		while (!(TMR3CN0 & 0x80));  // Wait for overflow
		TMR3CN0 &= ~(0x80);         // Clear overflow indicator
		if (TF0)
		{
		   TF0=0;
		   overflow_count++;
		}
	}
	TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
}

void waitms (unsigned int ms)
{
	unsigned int j;
	for(j=ms; j!=0; j--)
	{
		Timer3us(249);
		Timer3us(249);
		Timer3us(249);
		Timer3us(250);
	}
}

void Timer2_ISR (void) interrupt INTERRUPT_TIMER2
{
	TF2H = 0; // Clear Timer2 interrupt flag
	OUT0=!OUT0;
	OUT1=!OUT0;
}

void SPIWrite (unsigned char x)
{
   CSN = 0;
   SPI0DAT=x;
   while(!SPIF);
   SPIF=0;
   CSN = 1;
}

void InitADC (void)
{
	SFRPAGE = 0x00;
	ADC0CN1 = 0b_10_000_000; //14-bit,  Right justified no shifting applied, perform and Accumulate 1 conversion.
	ADC0CF0 = 0b_11111_0_00; // SYSCLK/32
	ADC0CF1 = 0b_0_0_011110; // Same as default for now
	ADC0CN0 = 0b_0_0_0_0_0_00_0; // Same as default for now
	ADC0CF2 = 0b_0_01_11111 ; // GND pin, Vref=VDD
	ADC0CN2 = 0b_0_000_0000;  // Same as default for now. ADC0 conversion initiated on write of 1 to ADBUSY.
	ADEN=1; // Enable ADC
}

#define VDD 3.3035 // The measured value of VDD in volts

void InitPinADC (unsigned char portno, unsigned char pinno)
{
	unsigned char mask;
	
	mask=1<<pinno;

	SFRPAGE = 0x20;
	switch (portno)
	{
		case 0:
			P0MDIN &= (~mask); // Set pin as analog input
			P0SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		case 1:
			P1MDIN &= (~mask); // Set pin as analog input
			P1SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		case 2:
			P2MDIN &= (~mask); // Set pin as analog input
			P2SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		default:
		break;
	}
	SFRPAGE = 0x00;
}

unsigned int ADC_at_Pin(unsigned char pin)
{
	ADC0MX = pin;   // Select input from pin
	ADBUSY=1;       // Dummy conversion first to select new pin
	while (ADBUSY); // Wait for dummy conversion to finish
	ADBUSY = 1;     // Convert voltage at the pin
	while (ADBUSY); // Wait for conversion to complete
	return (ADC0);
}

float Volts_at_Pin(unsigned char pin)
{
	 return ((ADC_at_Pin(pin)*VDD)/0b_0011_1111_1111_1111);
}

void sendMessage (int backward_L, int backward_R, int forward_L, int forward_R, unsigned char byte_1, unsigned char byte_2)
{
	if (forward_L>0)
	{
		byte_1+=16;
		if(forward_L>=8)
			byte_1+=8;
		if(forward_L%8>=4)
			byte_1+=4;
		if(forward_L%4>=2)
			byte_1+=2;
		if(forward_L%2>=1)
			byte_1+=1;
	}	
	else
	{
		if(backward_L>=8)
			byte_1+=8;
		if(backward_L%8>=4)
			byte_1+=4;
		if(backward_L%4>=2)
			byte_1+=2;
		if(backward_L%2>=1)
			byte_1+=1;
	}
	if (forward_R>0)
	{
		byte_2+=128;
		if(forward_R>=8)
			byte_2+=64;
		if(forward_R%8>=4)
			byte_2+=32;
		if(forward_R%4>=2)
			byte_2+=16;
		if(forward_R%2>=1)
			byte_2+=8;
	}	
	else
	{
		if(backward_R>=8)
			byte_2+=64;
		if(backward_R%8>=4)
			byte_2+=32;
		if(backward_R%4>=2)
			byte_2+=16;
		if(backward_R%2>=1)
			byte_2+=8;
	}
	SPIWrite(0b00100000);
	SPIWrite(0b00001010);
	SPIWrite(0b10100000);
	SPIWrite(0b01100010);
	CE = 1;
	Timer3us(250);
	CE = 0;
	//SPIWrite(byte_1);
	//SPIWrite(byte_2);
}

void main (void)
{
	double Vx = 0;
	double Vy = 0;
	unsigned int backward_L = 0;
	unsigned int backward_R = 0;
	unsigned int forward_L = 0;
	unsigned int forward_R = 0;
	unsigned char byte_1 = 0;
	unsigned char byte_2 = 0;
	
	CSN = 1;
	CE = 0;

	byte_1 = 192;
	byte_2 = 1;
	
	InitADC();
	InitPinADC(0,1);
	InitPinADC(0,2);
	
	TMR2RL=0x10000L-(SYSCLK/(2L*FREQ));
	TR2=0; // Stop timer 2
	//TR2=1; // Start timer 2
	while(1)
	{
		Vx = Volts_at_Pin(QFP32_MUX_P0_1);
		Vy = Volts_at_Pin(QFP32_MUX_P0_2);
		//voltage/1.65
		if(Vx>VxMidHigh && Vy>VyMidHigh)  //forward right
		{
			backward_L=0;
			backward_R=0;
			forward_L=(int)(((Vx-VxMid)/VxMid)*10)+1;
			forward_R=(int)((((Vx-VxMid)/VxMid)*10+1)/2.0);
		}
		else if(Vx>VxMidHigh && Vy<VyMidLow) //forward left
		{
			backward_L=0;
			backward_R=0;
			forward_L=(int)((((Vx-VxMid)/VxMid)*10+1)/2.0);
			forward_R=(int)(((Vx-VxMid)/VxMid)*10)+1;	
		}
		else if(Vx>VxMidHigh && Vy>VyMidLow && Vy<VyMidHigh) //forward
		{
			backward_L=0;
			backward_R=0;
			forward_L=(int)(((Vx-VxMid)/VxMid)*10)+1;
			forward_R=(int)(((Vx-VxMid)/VxMid)*10)+1;
		}
		else if(Vx<VxMidLow && Vy>VyMidHigh) //back right
		{
			backward_L=(int)(((VxMid-Vx)/VxMid)*10)+1;
			backward_R=(int)((((VxMid-Vx)/VxMid)*10+1)/2.0);
			forward_L=0;
			forward_R=0;	
		}
		else if(Vx<VxMidLow && Vy<VyMidLow)  //back left
		{
			backward_L=(int)((((VxMid-Vx)/VxMid)*10+1)/2.0);
			backward_R=(int)(((VxMid-Vx)/VxMid)*10)+1;
			forward_L=0;
			forward_R=0;
		}
		else if(Vx<VxMidLow && Vy>VyMidLow && Vy<VyMidHigh) //backward
		{
			backward_L=(int)(((VxMid-Vx)/VxMid)*10)+1;
			backward_R=(int)(((VxMid-Vx)/VxMid)*10)+1;
			forward_L=0;
			forward_R=0;		
		}
		else if(Vx<VxMidHigh && Vx>VxMidLow && Vy>VyMidHigh) // right
		{
			backward_L=0;
			backward_R=0;
			forward_L=(int)(((Vy-VyMid)/VyMid)*10);
			forward_R=0;
		}
		else if(Vx<VxMidHigh && Vx>VxMidLow && Vy<VyMidLow) // left
		{
			backward_L=0;
			backward_R=0;
			forward_L=0;
			forward_R=(int)(((VyMid-Vy)/VyMid)*10)+1;
		}
		else if(Vx<VxMidHigh && Vx>VxMidLow && Vy>VyMidLow && Vy<VyMidHigh) // stop
		{
			backward_L=0;
			backward_R=0;
			forward_L=0;
			forward_R=0;		
		}
		if (backward_L>10)
			backward_L = 10;
		if (backward_R>10)
			backward_R = 10;
		if (forward_L>10)
			forward_L = 10;
		if (forward_R>10)
			forward_R = 10;

		sendMessage(backward_L,backward_R,forward_L,forward_R,byte_1,byte_2);
	}
}