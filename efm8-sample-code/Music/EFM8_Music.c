//
// EFM8_Music.c: ANSI music interpreter
// By Jesus Calvino-Fraga (c) 2002-2018
//
// Attach a piezo-buzzer or speaker to pin P2_1 to hear the music
//
#include <stdio.h>
#include <EFM8LB1.h>
#include <ctype.h>
#include <string.h>
#include "Tunes.h"

#define SYSCLK 72000000L // System clock frequency in Hz
#define BAUDRATE 115200L

#define EQ(A,B) !strcmp((A),(B))

void ParseMDL(char * music);

#define BUFFSIZE 15
char buff[BUFFSIZE+1];
const char what[]="What?\n";

// timer 0 used for systemclock
#define TIMER0_RELOAD_VALUE (65536L-((SYSCLK/12L)/1000L))

#define SOUNDPIN P2_1

volatile int timer_count;

extern const float FTone[];

unsigned char _c51_external_startup()
{
	// Disable Watchdog with key sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; //First key
	WDTCN = 0xAD; //Second key
  
	VDM0CN=0x80;       // enable VDD monitor
	RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD

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

	#if ( ((SYSCLK/BAUDRATE)/(12L*2L)) > 0x100)
		#error Can not configure baudrate using timer 1 
	#endif
	// Configure Uart 0
	SCON0 = 0x10;
	TH1 = 0x100-((SYSCLK/BAUDRATE)/(12L*2L));
	TL1 = TH1;      // Init Timer1
	TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	TMOD |=  0x20;                       
	TR1 = 1; // START Timer1
	TI = 1;  // Indicate TX0 ready

	P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	XBR0 = 0b_0000_0001; // Enable UART pins P0.4(TX) and P0.5(RX)
	XBR1 = 0X00;
	XBR2 = 0x40; // Enable crossbar and weak pull-ups

	// initialize timer0 for system clock
	TR0=0; // stop timer 0
	TMOD =(TMOD&0xf0)|0x01; // T0=16bit timer
	TMR0=TIMER0_RELOAD_VALUE;
	TR0=1; // start timer 0
	ET0=1; // enable timer 0 interrupt

	// Initialize timer 2 for periodic interrupts
	TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	TMR2RL=0; // It will be changed in the music parser
	TMR2=0xffff;   // Set to reload immediately
	ET2=1;         // The music parsers enables/disables the timer
	
	EA=1; // enable global interrupt
	return 0;
}

void Timer0_ISR (void) interrupt INTERRUPT_TIMER0
{
    P2_2=!P2_2;
	TMR0=TIMER0_RELOAD_VALUE;
	timer_count++;
}

void Timer2_ISR (void) interrupt INTERRUPT_TIMER2
{
	TF2H = 0; // Clear Timer2 interrupt flag
	SOUNDPIN=!SOUNDPIN;
}

unsigned char AsciiToHex(char * buff)
{
	return ((buff[0]-'0')*0x10)+(buff[1]-'0');
}

void Menu (void)
{
    printf(
    "\n\nMenu:\n"
    "   1) Yesterday\n"
    "   2) Bethoven: Fur Elise\n"
    "   3) Chopin: ?\n"
    "   4) The William Tell Overture\n"
    "   5) Sonata IV in E Major, 1st Movement\n"
    "   6) Bach: Minuet 1\n"
    "   7) Bach: Gavotte\n"
    "   F) Frequency out\n"
    "   T) Note out\n"
    "Option:" );
}

void main(void)
{
	char c;
	float freq;
	int d;

	timer_count=0;
	while(timer_count<1000);
	
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
    printf("ANSI MUSIC V2.0: by Jesus Calvino-Fraga 2002-2018\n");

    while(1)
    {
        Menu();
        c=getchar();
        switch(c)
        {
        	case '1':
        	   ParseMDL(tune1);
        	   break;
        	case '2':
        	   ParseMDL(tune2);
        	   break;
        	case '3':
        	   ParseMDL(tune3);
        	   break;
        	case '4':
        	   ParseMDL(tune4);
        	   break;
        	case '5':
        	   ParseMDL(tune5);
        	   break;
        	case '6':
        	   ParseMDL(tune6);
        	   break;
        	case '7':
        	   ParseMDL(tune7);
        	   break;
        	case 'f':
        	case 'F':
	            printf("\nFrequency: ");
	            scanf("%f", &freq);
			    TMR2=TMR2RL=(unsigned int)(65536.0-(72.0e6/(freq*2*12.0)));
			    printf("\nTMR2RL=%04x\n", TMR2RL);
			    TR2=1;
			    while(RI==0);
			    getchar();
			    RI=0;
			    TR2=0;
			    break;
        	case 't':
        	case 'T':
	            printf("\nTone number: ");
	            scanf("%d", &d);
			    TMR2=TMR2RL=(unsigned int)(65536.0-(72.0e6/(FTone[d]*2*12.0)));
			    printf("\nTMR2RL=%04x\n", TMR2RL);
			    TR2=1;
			    while(RI==0);
			    getchar();
			    RI=0;
			    TR2=0;
			    break;
			default:
			    break;
        }
    }
}
