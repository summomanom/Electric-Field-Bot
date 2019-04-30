@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\oconn\OneDrive\Documents\GitHub\EM-Robot\efm8-sample-code\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\oconn\OneDrive\Documents\GitHub\EM-Robot\efm8-sample-code\square.c"
if not exist hex2mif.exe goto done
if exist square.ihx hex2mif square.ihx
if exist square.hex hex2mif square.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\oconn\OneDrive\Documents\GitHub\EM-Robot\efm8-sample-code\square.hex
