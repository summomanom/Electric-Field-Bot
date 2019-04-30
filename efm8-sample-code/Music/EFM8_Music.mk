SHELL=cmd
CC=c51
COMPORT = $(shell type COMPORT.inc)
OBJS=EFM8_Music.obj Parser.obj
EFM8_Music.hex: $(OBJS)
	$(CC) $(OBJS)
	@del *.asm *.lst *.lkr 2> nul
	@echo Done!
	
EFM8_Music.obj: EFM8_Music.c Tunes.h
	$(CC) -c EFM8_Music.c

Parser.obj: Parser.c Tunes.h
	$(CC) -c Parser.c

clean:
	@del $(OBJS) *.asm *.lkr *.lst *.map *.hex *.map 2> nul

LoadFlash:
	@Taskkill /IM putty.exe /F 2>NUL | wait 500
	EFM8_prog -ft230 -r EFM8_Music.hex
	cmd /c start putty -serial $(COMPORT) -sercfg 115200,8,n,1,N -v

putty:
	@Taskkill /IM putty.exe /F 2>NUL | wait 500
	cmd /c start putty -serial $(COMPORT) -sercfg 115200,8,n,1,N -v

Dummy: EFM8_Music.hex EFM8_Music.Map
	@echo Nothing to see here!
	
explorer:
	cmd /c start explorer .
		