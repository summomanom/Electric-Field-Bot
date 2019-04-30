//
// Parser.c: MML music parser
// By Jesus Calvino-Fraga 2002
//
// Music Music Language player.
// 
#include <stdio.h>
#include <ctype.h>
#include <EFM8LB1.h>

#define	PAUSE	0
#define	BASE_C	1
#define	BASE_Cs	2
#define	BASE_D	3
#define	BASE_Ds	4
#define	BASE_E	5
#define	BASE_F	6
#define	BASE_Fs	7
#define	BASE_G	8
#define	BASE_Gs	9
#define	BASE_A	10
#define	BASE_As	11
#define	BASE_B	12

#define	NORMAL		7
#define	LEGATO		8
#define	STACCATO	3

#define SYSCLK 72000000L // System clock frequency in Hz

unsigned char style, octave, note, tempo;
int actLen, defLen, cur;
extern volatile int timer_count;

// Frequencies for equal-tempered scale, A4 = 440 Hz
// http://pages.mtu.edu/~suits/notefreqs.html
const float FTone[] = {
	   61.74,   65.41,   69.30,   73.42,   77.78,   82.41,   87.31,   92.50,
	   98.00,  103.83,  110.00,  116.54,  123.47,  130.81,  138.59,  146.83,
	  155.56,  164.81,  174.61,  185.00,  196.00,  207.65,  220.00,  233.08,
	  246.94,  261.62,  277.18,  293.66,  311.13,  329.63,  349.23,  369.99,
	  391.99,  415.30,  440.00,  466.16,  493.88,  523.25,  554.36,  587.33,
	  622.25,  659.25,  698.45,  739.98,  783.99,  830.60,  879.99,  932.32,
	  987.76, 1046.50, 1108.72, 1174.65, 1244.50, 1318.50, 1396.90, 1479.97,
	 1567.97, 1661.21, 1759.99, 1864.64, 1975.52, 2092.99, 2217.45, 2349.30,
	 2489.00, 2637.00, 2793.81, 2959.94, 3135.94, 3322.42, 3519.98, 3729.29,
	 3951.04, 4185.98, 4434.90, 4698.61, 4978.00, 5274.01, 5587.62, 5919.88,
	 6271.89, 6644.84, 7039.96, 7458.58, 7902.09  };

//Use timer 2 to play the note.
void PlayNote(void)
{
	int tmsec, toff;
	
	// Compute in milliseconds the duration of a note or silence using:
	tmsec= ( (60000L/tempo)*400L ) / actLen;

	// Set the time when the sound will be turned off:
	toff=(tmsec*style)/8L;

	// Start the sound
	if (note!=0)
	{
		TMR2=TMR2RL=(unsigned int)(65536.0-((72.0e6)/(FTone[note]*2*12.0)));
		TR2=1;
    }
    else //It is a silence...
    {
    	TR2=0; //Turn off timer 2
    }

	//Count the milliseconds for the note or silence
	timer_count=0;
	while(timer_count<tmsec)
	{
		if(timer_count>toff) TR2=0; //Turn off timer 2
	}
	TR2=0; //Turn off timer 2
}

int GetNumber(char * music)
{
	int n=0;
	/*Get the number*/
	while (isdigit(music[cur]) && music[cur]) n=(n*10)+(music[cur++]-'0');
	return n;
}

void ParseMDL(char * music)
{
	bit getout;
	
	cur=0;
	style=NORMAL;
	TR2=0;		
	
	while(music[cur] && (RI==0))
	{
	    //putchar(music[cur]);
		switch (toupper(music[cur]))
		{
			case '>':
				cur++;
				octave++;
			break;
	
			case '<':
				cur++;
				octave--;
			break;
	
			case 'O':
				cur++;
				octave=GetNumber(music);
			break;
	
			/*Choose a note or pause*/
			case 'A': case 'B': case 'C': case 'D':
			case 'E': case 'F': case 'G': case 'P':
	
				/*Select the note number from name and octave*/
				note=(octave*12);
				switch (toupper(music[cur])-'A')
				{
					case 0:  note+=BASE_A; break;
					case 1:  note+=BASE_B; break;
					case 2:  note+=BASE_C; break;
					case 3:  note+=BASE_D; break;
					case 4:  note+=BASE_E; break;
					case 5:  note+=BASE_F; break;
					case 6:  note+=BASE_G; break;
					default: note =PAUSE ; break;
				}
		
				cur++;
				actLen=defLen;
				
				getout=0;
				while(!getout)
				{
					switch (toupper(music[cur]))
					{
						case '+': case '#':
							cur++;
							note++;
						break;
	
						case '-':
							cur++;
							note--;
						break;
	
						case '.':
							cur++;
							actLen=(actLen*2)/3;
						break;
						
						/*Get note duration*/
						case '0': case '1': case '2': case '3': case '4': 
						case '5': case '6': case '7': case '8': case '9': 
							actLen=GetNumber(music)*100;/*Increase resolution*/
						break;
	
						default:
							/*Play note and continue*/
							PlayNote();
							getout=1;
						break;
					}
				}
			break;
	
			/*Play a note by its number*/
			case 'N':
				cur++;
				note=GetNumber(music);
				actLen=defLen;
				PlayNote();
			break;
			
			/*Set the default note duration*/
			case 'L':
				cur++;
				defLen=GetNumber(music)*100;/*Increase resolution*/
			break;
	
			/*Choose the playing style. Ignore foreground and
			background commands, since only background works here*/
			case 'M':
				cur++; 
				switch (toupper(music[cur]))
				{
					case 'N': style=NORMAL;   break;
					case 'L': style=LEGATO;   break;
					case 'S': style=STACCATO; break;
				}
				cur++;
			break;
	
			/*Select the tempo*/
			case 'T':
				cur++;
				tempo=GetNumber(music);
			break;
	
			/*Ignore and discard substrings.*/
			case 'X':
				cur++;
				/*Discard substring*/
				while ((music[cur]!='$') && music[cur]) cur++;
				cur++;/*Discard also the "$"*/
			break;
			
			/*Unknown commands and blanks are just ignored and discarded*/
			default:
				cur++;
			break;
		}
	}
}
