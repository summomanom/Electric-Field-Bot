//  freq_gen.c: Uses timer 2 interrupt to generate a square wave at pins
//  P2.0 and P2.1.  The program allows the user to enter a frequency.
//  Copyright (c) 2010-2018 Jesus Calvino-Fraga
//  ~C51~

#include <EFM8LB1.h>
#include <stdlib.h>
#include <stdio.h>

#define SYSCLK    72000000L // SYSCLK frequency in Hz
#define BAUDRATE  115200L   // Baud rate of UART in bps
#define DEFAULT_F 38000L
#define TIMER_0_FREQ 10000L

#define command1 P2_1
#define command2 P2_2
#define command3 P2_3
#define command4 P2_4
#define input P1_7
#define OUT0 P2_0
volatile	char counter;
volatile	char counter2;
volatile char command;
volatile char flag;
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
	
		P2MDOUT|=0b_0000_0001;
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

void Timer2_ISR (void) interrupt INTERRUPT_TIMER2
{
	TF2H = 0; // Clear Timer2 interrupt flag

	OUT0= !OUT0;   	
}
void Timer0_ISR (void) interrupt INTERRUPT_TIMER0
{
	SFRPAGE=0x0;
	// Timer 0 in 16-bit mode doesn't have auto reload
	TMR0=0x10000L-(SYSCLK/(2*TIMER_0_FREQ));
	counter++;
	if(command == 2 && counter == 26)
	{
	TMR2CN0=0x00;
	command = 0;
	counter = 0;
	TR0=0; 
		TR2=0; 
	}
	if(command == 3 && counter == 23)
	{
	TMR2CN0=0x00;
	command = 0;
	counter = 0;
	TR0=0; 
		TR2=0; 
	}
	if(command == 4 && counter == 20)
	{
	TMR2CN0=0x00;
	command = 0;
	counter = 0;
	TR0=0; 
		TR2=0; 
	}
	if(command == 5 && counter == 17)
	{
	TMR2CN0=0x00;
	command = 0;
	counter = 0;
	TR0=0; 
	TR2=0; 
	}
	
	
}

void main (void)
{
		command1 = 1;
		command2 = 1;
		command3 = 1;
		command4 = 1;
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	printf("Variable frequency generator for the EFM8LB1.\r\n"
	       "Check pins P2.0 and P2.1 with the oscilloscope.\r\n");

			TR2=0; 
			
	while(1)
	{

		if(command1 == 0)
		{
	//	while(command1 == 0);
		command = 2;
				counter2 =0;
				counter =0;
			TR2=1;
		TR0=1; 
		}
		if(command2 == 0)
		{
	//	while(command2 == 0);
		command = 3;
		counter =0;
				counter2 =0;
			TR2=1;
		TR0=1; 
		}
		if(command3 == 0)
		{
	//	while(command3 == 0);
		command = 4;
		counter =0;
			counter2 =0;
			TR2=1;
		TR0=1; 
		}
		if(command4 == 0)
		{
	//	while(command4 == 0);
		command = 5;
		counter =0;
			counter2 =0;
			TR2=1;
		TR0=1; 
		}
		if(input == 0)

	}
}