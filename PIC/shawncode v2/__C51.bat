@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\oconn\Desktop\291\pic\Blinky\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\oconn\Desktop\291\pic\Blinky\Blinky.c"
if not exist hex2mif.exe goto done
if exist Blinky.ihx hex2mif Blinky.ihx
if exist Blinky.hex hex2mif Blinky.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\oconn\Desktop\291\pic\Blinky\Blinky.hex
