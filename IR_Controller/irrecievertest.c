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
#define TIMER_0_FREQ 10000L

#define OUT0 P2_0
#define OUT1 P2_1
#define input P1_7
#define FREQ 15500L

#define BITWIDTH 10
#define DELAY 16
#define VyMidLow 1.58
#define VyMidHigh 1.60
#define VxMidLow 1.66
#define VxMidHigh 1.68
#define VyMid 1.59
#define VxMid 1.67
volatile unsigned char pwm_count=0;
volatile	char counter;
volatile	char counter2;
volatile char command;
volatile char flag;
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

	// Configure the pins used for square output
	P2MDOUT|=0b_0000_0011;
	P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)
	XBR1     = 0X10; // Enable T0 on P0.0
	XBR2     = 0x40; // Enable crossbar and weak pull-ups

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

		// Initialize timer 0 for periodic interrupts
	TR0=0;
	TF0=0;
	CKCON0|=0b_0000_0100; // Timer 0 uses the system clock
	TMOD&=0xf0;
	TMOD|=0x01; // Timer 0 in mode 1: 16-bit timer
	// Initialize reload value
	TMR0=65536L-(SYSCLK/(2*TIMER_0_FREQ));
	ET0=1;     // Enable Timer0 interrupts


	// Initialize timer 2 for periodic interrupts
	TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	CKCON0|=0b_0001_0000;
	TMR2RL=(-(SYSCLK/(2*DEFAULT_F))); // Initialize reload value
	TMR2=0xffff;   // Set to reload immediately
	ET2=1;         // Enable Timer2 interrupts
	TR2=0;         // Start Timer2
	TR0=0;     // Start Timer0
	EA=1; // Global interrupt enable

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

void Timer0_ISR (void) interrupt INTERRUPT_TIMER0
{
	SFRPAGE=0x0;
	// Timer 0 in 16-bit mode doesn't have auto reload
	TMR0=0x10000L-(SYSCLK/(2*TIMER_0_FREQ));
	counter2++;

}

void sendZero(void)
{
	TR2=0; // Stop timer 2
	waitms(BITWIDTH);
}

void sendOne(void)
{
	TR2=1; //Start timer 2
	waitms(BITWIDTH);
}

void sendCommand (int number_send)
{
	if(number_send>=8)
		sendOne();
	else
		sendZero();
	if(number_send%8>=4)
		sendOne();
	else
		sendZero();
	if(number_send%4>=2)
		sendOne();
	else
		sendZero();
	if(number_send%2>=1)
		sendOne();
	else
		sendZero();
}

void sendMessage (int backward_L, int backward_R, int forward_L, int forward_R)
{
	sendOne();
	sendOne();
	sendZero();
	if (forward_L>0)
	{
		sendOne();
		sendCommand(forward_L);
	}
	else
	{
		sendZero();
		sendCommand(backward_L);
	}
	if (forward_R>0)
	{
		sendOne();
		sendCommand(forward_R);
	}
	else
	{
		sendZero();
		sendCommand(backward_R);
	}
	sendZero();
	sendZero();
	sendOne();
	TR2=0;
	waitms(DELAY*BITWIDTH);
}

void sendOnes(int number)
{
	while(number>0)
	{
		sendOne();
		sendZero();
		number--;
	}
	sendZero();
	sendZero();
}





void main (void)
{
	unsigned int backward_L = 0;
	unsigned int backward_R = 0;
	unsigned int forward_L = 0;
	unsigned int forward_R = 0;
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	printf("Variable frequency generator for the EFM8LB1.\r\n"
	       "Check pins P2.0 and P2.1 with the oscilloscope.\r\n");
	command = 0;
			TR2=0;

	while(1)
	{

		if(command == 2) //forward
		{
			sendOnes(2);
			command = 0;
		}
		else if(command == 3) //backward
		{
			sendOnes(3);
			command = 0;
		}
		else if(command ==4) // left
		{
			sendOnes(4);
			command = 0;
		}
		else if(command == 5) // right
		{
			sendOnes(5);
			command = 0;
		}
		else
		{
			sendOnes(1);
		}

		if(input == 0)
		{
		TR0=1;
		while(input == 0);
		TR0=0;
		printf("%d",counter2);
		if(counter2 == 20 || counter2 == 21)
		command =2;
			if(counter2 == 17 || counter2 == 18)
		command =3;
			if(counter2 == 4 ||counter2 == 5)
		command =4;
			if(counter2 == 2 || counter2 == 1)
		command =5;
		printf("%d	",command);
		counter2 = 0;
		}
		//voltage/1.65
/*		if(Vx>VxMidHigh && Vy>VyMidHigh)  //forward right
		{\
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
*/
//		sendMessage(backward_L,backward_R,forward_L,forward_R);
	}
}
