@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\EM-Tether-Robot\PIC\SHawns code\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\EM-Tether-Robot\PIC\SHawns code\Blinky.c"
if not exist hex2mif.exe goto done
if exist Blinky.ihx hex2mif Blinky.ihx
if exist Blinky.hex hex2mif Blinky.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\EM-Tether-Robot\PIC\SHawns code\Blinky.hex
