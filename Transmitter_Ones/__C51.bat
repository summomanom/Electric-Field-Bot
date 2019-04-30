@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\Igor\Dropbox\Homework\UBC\Elec 291\EM-Tether-Robot\Transmitter_Ones\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\Igor\Dropbox\Homework\UBC\Elec 291\EM-Tether-Robot\Transmitter_Ones\Transmitter_Code.c"
if not exist hex2mif.exe goto done
if exist Transmitter_Code.ihx hex2mif Transmitter_Code.ihx
if exist Transmitter_Code.hex hex2mif Transmitter_Code.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\Igor\Dropbox\Homework\UBC\Elec 291\EM-Tether-Robot\Transmitter_Ones\Transmitter_Code.hex
