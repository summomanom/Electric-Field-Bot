//	Robot.c
//	Code for robot
//	The following functions were created by Jesus Calvino-Fraga
//	UART2Configure
//	ADCConf
//	ADCRead
//	SetupTimer1		//was modified
//	and all the surrounding definitions	

#include <sys/attribs.h>
#include <XC.h>
#include <stdio.h>
#include <stdlib.h>

#pragma config FNOSC = FRCPLL       // Internal Fast RC oscillator (8 MHz) w/ PLL
#pragma config FPLLIDIV = DIV_2     // Divide FRC before PLL (now 4 MHz)
#pragma config FPLLMUL = MUL_20     // PLL Multiply (now 80 MHz)
#pragma config FPLLODIV = DIV_2     // Divide After PLL (now 40 MHz) see figure 8.1 in datasheet for more info
#pragma config FPBDIV = DIV_1       // PBCLK = SYCLK
#pragma config FWDTEN = OFF         // Watchdog Timer Disabled

// Defines
#define SYSCLK 40000000L
#define Baud2BRG(desired_baud)( (SYSCLK / (16*desired_baud))-1)
#define FREQ1 2000L // 2000Hz interrupt rate
#define FREQ2 1000L // 1000Hz interrupt rate
#define SIZE (17) /* amount of bits */

// Initializing global variables
volatile unsigned int forward_L = 0;
volatile unsigned int forward_R = 0;
volatile unsigned int backward_L = 0;
volatile unsigned int backward_R = 0;
volatile unsigned char pwm_count=0;
volatile unsigned char command[SIZE] = { 0 };
volatile double voltage = 0;
volatile int i = 0;
volatile int counter = 0;
volatile char change =0;
volatile enum motor_direction {reverse = 0,forward = 1,off = 2}left_motor_direction,right_motor_direction;
volatile char left_motor_duty_cycle, right_motor_duty_cycle=0;
volatile char check = 0;
volatile char x = 0;
char flag = 1;

void UART2Configure(int baud_rate)
{
    // Peripheral Pin Select
    U2RXRbits.U2RXR = 4;    //SET RX to RB8
    RPB9Rbits.RPB9R = 2;    //SET RB9 to TX

    U2MODE = 0;         // disable autobaud, TX and RX enabled only, 8N1, idle=HIGH
    U2STA = 0x1400;     // enable TX and RX
    U2BRG = Baud2BRG(baud_rate); // U2BRG = (FPb / (16*baud)) - 1
    
    U2MODESET = 0x8000;     // enable UART2
}

//determines commands for individual motors when given one of 5 commands
void motor_speed(int command)
{
	/*----------------set directions--------------------*/
	if(command==5)
		{
			left_motor_direction=forward;
			right_motor_direction=off;
		}
	else if (command==4)
		{
			left_motor_direction=off;
			right_motor_direction=forward;
			
		}
	else if (command==3)
		{
			left_motor_direction=reverse;
			right_motor_direction=reverse;
			
		}
	else if (command==2)
		{
			left_motor_direction=forward;
			right_motor_direction=forward;
			
		}
	else if (command==1)
		{
			left_motor_direction=off;
			right_motor_direction=off;
			
		}
	else 
		{	
			left_motor_direction=off;
			right_motor_direction=off;
			
		}	
}

//calculates pwn variables
void pwm_calculator(void)
{
	if(right_motor_direction == 0)
	{
		forward_R = 0;
		backward_R = 100;
	}
	else if(right_motor_direction == 1)
	{
		forward_R = 100;
		backward_R = 0;
	}
	else if(right_motor_direction == 2)
	{
		forward_R = 100;
		backward_R = 100;
	}
	if(left_motor_direction == 0)
	{
		forward_L = 0;
		backward_L = 100;
	}
	else if(left_motor_direction == 1)
	{
		forward_L = 100;
		backward_L = 0;
	}
	else if(left_motor_direction == 2)
	{
		forward_L = 100;
		backward_L = 100;
	}
}

// Configures ADC
void ADCConf(void)
{
    AD1CON1CLR = 0x8000;    // disable ADC before configuration
    AD1CON1 = 0x00E0;       // internal counter ends sampling and starts conversion (auto-convert), manual sample
    AD1CON2 = 0;            // AD1CON2<15:13> set voltage reference to pins AVSS/AVDD
    AD1CON3 = 0x0f01;       // TAD = 4*TPB, acquisition time = 15*TAD 
    AD1CON1SET=0x8000;      // Enable ADC
}

// Reads from ADC
int ADCRead(char analogPIN)
{
    AD1CHS = analogPIN << 16;    // AD1CHS<16:19> controls which analog pin goes to the ADC
 
    AD1CON1bits.SAMP = 1;        // Begin sampling
    while(AD1CON1bits.SAMP);     // wait until acquisition is done
    while(!AD1CON1bits.DONE);    // wait until conversion done
 
    return ADC1BUF0;             // result stored in ADC1BUF0
}

// Timer 1 ISR
void __ISR(_TIMER_1_VECTOR, IPL5SOFT) Timer1_Handler(void)
{
	IFS0CLR=_IFS0_T1IF_MASK;
	counter++;
}

// Initialize Timer 1
void SetupTimer1 (void)
{
	// Explanation here:
	// https://www.youtube.com/watch?v=bu6TTZHnMPY
	__builtin_disable_interrupts();
	PR1 =(SYSCLK/(FREQ1))-1; // since SYSCLK/FREQ = PS*(PR1+1)
	TMR1 = 0;
	T1CONbits.TCKPS =0; // Pre-scaler: 256
	T1CONbits.TCS = 0; // Clock source
	T1CONbits.ON = 1;
	IPC1bits.T1IP = 5;
	IPC1bits.T1IS = 0;
	IFS0bits.T1IF = 0;
	IEC0bits.T1IE = 0;
	
	INTCONbits.MVEC = 1; //Int multi-vector
	__builtin_enable_interrupts();
}

//Timer 2 ISR
//based on Timer 1 ISR
void __ISR(_TIMER_2_VECTOR, IPL6SOFT) Timer2_Handler(void)
{
	IFS0CLR=_IFS0_T2IF_MASK; // Clear timer 1 interrupt flag, bit 4 of IFS0
	
	pwm_count++;
	if(pwm_count>100) pwm_count=1;
	
	LATBbits.LATB15=pwm_count>forward_L?0:1;
	LATBbits.LATB14=pwm_count>backward_L?0:1;
	LATBbits.LATB13=pwm_count>forward_R?0:1;
	LATBbits.LATB12=pwm_count>backward_R?0:1;
}

// Initialize Timer 2
// based on Timer 1 initialization
void SetupTimer2 (void)
{
	// Explanation here:
	// https://www.youtube.com/watch?v=bu6TTZHnMPY
	__builtin_disable_interrupts();
	PR2 =(SYSCLK/(FREQ2))-1; // since SYSCLK/FREQ = PS*(PR1+1)
	TMR2 = 0;
	T2CONbits.TCKPS = 0; // Pre-scaler: 256
	T2CONbits.TCS = 0; // Clock source
	T2CONbits.ON = 1;
	IPC2bits.T2IP = 6;
	IPC2bits.T2IS = 0;
	IFS0bits.T2IF = 0;
	IEC0bits.T2IE = 1;
	
	INTCONbits.MVEC = 1; //Int multi-vector
	__builtin_enable_interrupts();
}

void main (void)
{	
	//initialize variables
	int ones = 0;
	int last_command = 0;
	CFGCON = 0;
	//configure UART
	UART2Configure(115200); 
	DDPCON = 0;
	TRISBbits.TRISB5 = 0;	
	LATBbits.LATB5 = 0;	
	TRISBbits.TRISB6 = 1;
	INTCONbits.MVEC = 1;
	TRISBbits.TRISB15 = 0;
	TRISBbits.TRISB14 = 0;
	TRISBbits.TRISB13 = 0;
	TRISBbits.TRISB12 = 0;
	LATBbits.LATB15 = 1;
	LATBbits.LATB14 = 1;
	LATBbits.LATB13 = 1;
	LATBbits.LATB12 = 1;
	//set up timers
	SetupTimer1();
	SetupTimer2();
	// Configure pins as analog inputs
	ANSELBbits.ANSB3 = 1;	// set RB3 (AN5, pin 7 of DIP28) as analog pin
	TRISBbits.TRISB3 = 1;	// set RB3 as an input

 	ADCConf(); // Configure ADC

	while (1)
	{
		while(ADCRead(5)*3.3/1023.0>1.0);	//wait for pin to go low
		IEC0bits.T1IE=1;					//initialize timer 1
		while(ADCRead(5)*3.3/1023.0<1.5);	//wait for pin to go high
		IEC0bits.T1IE=0;					//initialize timer 2
		if(counter>30)						//check time low
		{
			ones++;							//increment command variable
			if (ones == last_command)		//compare with previous command
			{
				//printf("%d \n \r", ones);	//used for testing
				//finds correct
				motor_speed(ones);
				pwm_calculator();
			}
			last_command = ones;			//remembers last command
			ones = 0;						//reset command variable
		}
		else
		{
			ones++;							//increment command variable
		}
		counter = 0;						//reset counter
	}
}

