
#include <XC.h>
#include <sys/attribs.h>
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
#define FREQ 1219L // 1000Hz or 0.001 seconds interrupt rate
#define SIZE (17) /* amount of bits */


volatile	unsigned char command[SIZE] = { 0 };
volatile	double voltage = 0;
volatile	int i = 0;
volatile	char change =0;
volatile	enum motor_direction {reverse,forward}left_motor_direction,right_motor_direction;
volatile	char left_motor_duty_cycle, right_motor_duty_cycle=0;
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
void set_motor_speed(volatile unsigned char bitarray[])
{
	
	
	/*----------------set directions--------------------*/
	if(bitarray[3]==1)
		{
			left_motor_direction=forward;
		}
	else left_motor_direction=reverse;
		
	if(bitarray[8]==1)
		{
			right_motor_direction=forward;
		}
	else right_motor_direction=reverse;
	
	/*----------------set duty cycles--------------------*/
	
	/*-------------------LEFT---------------------------*/
	if(bitarray[4]==1 && bitarray[5]==0 && bitarray[6]==1 && bitarray[7]==0)
	{
		left_motor_duty_cycle=100;
	}
	else if(bitarray[4]==1 && bitarray[5]==0 && bitarray[6]==0 && bitarray[7]==1)
	{
		left_motor_duty_cycle=90;
	}
	else if(bitarray[4]==1 && bitarray[5]==0 && bitarray[6]==0 && bitarray[7]==0)
	{
		left_motor_duty_cycle=80;
	}
	else if(bitarray[4]==0 && bitarray[5]==1 && bitarray[6]==1 && bitarray[7]==1)
	{
		left_motor_duty_cycle=70;
	}
	else if(bitarray[4]==0 && bitarray[5]==1 && bitarray[6]==1 && bitarray[7]==0)
	{
		left_motor_duty_cycle=60;
	}
	else if(bitarray[4]==0 && bitarray[5]==1 && bitarray[6]==0 && bitarray[7]==1)
	{
		left_motor_duty_cycle=50;
	}
	else if(bitarray[4]==0 && bitarray[5]==1 && bitarray[6]==0 && bitarray[7]==0)
	{
		left_motor_duty_cycle=40;
	}
	else if(bitarray[4]==0 && bitarray[5]==0 && bitarray[6]==1 && bitarray[7]==1)
	{
		left_motor_duty_cycle=30;
	}
	else if(bitarray[4]==0 && bitarray[5]==0 && bitarray[6]==1 && bitarray[7]==0)
	{
		left_motor_duty_cycle=20;
	}
	else if(bitarray[4]==0 && bitarray[5]==0 && bitarray[6]==0 && bitarray[7]==1)
	{
		left_motor_duty_cycle=10;
	}
	else 
	{
		left_motor_duty_cycle=0;
	}

	/*-------------------RIGHT--------------------------*/
	if(bitarray[9]==1 && bitarray[10]==0 && bitarray[11]==1 && bitarray[12]==0)
	{
		left_motor_duty_cycle=100;
	}
	else if(bitarray[9]==1 && bitarray[10]==0 && bitarray[11]==0 && bitarray[12]==1)
	{
		left_motor_duty_cycle=90;
	}
	else if(bitarray[9]==1 && bitarray[10]==0 && bitarray[11]==0 && bitarray[12]==0)
	{
		left_motor_duty_cycle=80;
	}
	else if(bitarray[9]==0 && bitarray[10]==1 && bitarray[11]==1 && bitarray[12]==1)
	{
		left_motor_duty_cycle=70;
	}
	else if(bitarray[9]==0 && bitarray[10]==1 && bitarray[11]==1 && bitarray[12]==0)
	{
		left_motor_duty_cycle=60;
	}
	else if(bitarray[9]==0 && bitarray[10]==1 && bitarray[11]==0 && bitarray[12]==1)
	{
		left_motor_duty_cycle=50;
	}
	else if(bitarray[9]==0 && bitarray[10]==1 && bitarray[11]==0 && bitarray[12]==0)
	{
		left_motor_duty_cycle=40;
	}
	else if(bitarray[9]==0 && bitarray[10]==0 && bitarray[11]==1 && bitarray[12]==1)
	{
		left_motor_duty_cycle=30;
	}
	else if(bitarray[9]==0 && bitarray[10]==0 && bitarray[11]==1 && bitarray[12]==0)
	{
		left_motor_duty_cycle=20;
	}
	else if(bitarray[9]==0 && bitarray[10]==0 && bitarray[11]==0 && bitarray[12]==1)
	{
		left_motor_duty_cycle=10;
	}
	else 
	{
		left_motor_duty_cycle=0;
	}
}

void verify(volatile unsigned char bitarray[])
{
	if(bitarray[0]!= 1 || bitarray[1] != 1 || bitarray[2] != 0)
	{
		flag = 0;
		return;
	}
	if(bitarray[13] != 0 || bitarray[14] != 0 || bitarray[15] != 1)
	{
		flag = 0;
		return;
	}
}

void ADCConf(void)
{
    AD1CON1CLR = 0x8000;    // disable ADC before configuration
    AD1CON1 = 0x00E0;       // internal counter ends sampling and starts conversion (auto-convert), manual sample
    AD1CON2 = 0;            // AD1CON2<15:13> set voltage reference to pins AVSS/AVDD
    AD1CON3 = 0x0f01;       // TAD = 4*TPB, acquisition time = 15*TAD 
    AD1CON1SET=0x8000;      // Enable ADC
}

int ADCRead(char analogPIN)
{
    AD1CHS = analogPIN << 16;    // AD1CHS<16:19> controls which analog pin goes to the ADC
 
    AD1CON1bits.SAMP = 1;        // Begin sampling
    while(AD1CON1bits.SAMP);     // wait until acquisition is done
    while(!AD1CON1bits.DONE);    // wait until conversion done
 
    return ADC1BUF0;             // result stored in ADC1BUF0
}

void __ISR(_TIMER_1_VECTOR, IPL5SOFT) Timer1_Handler(void)
{
	IFS0CLR=_IFS0_T1IF_MASK;
	if(check<5)
	{
		if(ADCRead(5)*3.3/1023.0 > 0.4	)
 		x++;
		check++;
 		return;\
	}
	else if((x / 3) == 1)
//	if(ADCRead(5)*3.3/1023.0 > 0.40)
		command[i] = '1';
	else
		command[i] = '0';
	x = 0;
	check = 0;
	i++;
	if(i == 16)
 	{
 		IEC0bits.T1IE = 0;
 		i = 0;
 	}
}

void SetupTimer1 (void)
{
	// Explanation here:
	// https://www.youtube.com/watch?v=bu6TTZHnMPY
	__builtin_disable_interrupts();
	PR1 =(SYSCLK/(FREQ))-1; // since SYSCLK/FREQ = PS*(PR1+1)
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

void main (void)
{	
    //int adcval;
    //float voltage;

	CFGCON = 0;
	UART2Configure(115200); 
	DDPCON = 0;
	TRISBbits.TRISB5 = 0;	
	LATBbits.LATB5 = 0;	
	TRISBbits.TRISB6 = 1;
	INTCONbits.MVEC = 1;
	SetupTimer1();
	// Configure pins as analog inputs
    ANSELBbits.ANSB3 = 1;   // set RB3 (AN5, pin 7 of DIP28) as analog pin
    TRISBbits.TRISB3 = 1;   // set RB3 as an input
 
 	ADCConf(); // Configure ADC
 

	while (1)
	{
	
       //adcval = ADCRead(5)*3.3/1023.0; // note that we call pin AN5 (RB3) by it's analog number
       //voltage=adcval*3.3/1023.0;
      //printf("AN5=0x%04x, %.3fV\n", adcval, voltage);
      //	fflush(stdout);
	while(IEC0bits.T1IE ==0)
	{
		voltage = ADCRead(5)*3.3/1023.0;
		if(voltage>0.4)
		{
	//		command[0] = '1';
	//		i = 1;
			IEC0bits.T1IE = 1;
		}
	}
	while(IEC0bits.T1IE ==1);

	printf("\r %s \n", command);
//	if(flag == 1)
//	set_motor_speed(command);
//	flag = 1;
	}
}



	