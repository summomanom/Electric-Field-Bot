@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout ht (c) 2010-2018 Jesus Calvino-Fraga "C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.c"
if not exist hex2mif.exe goto done
if exist irrecievertest.ihx hex2mif irrecievertest.ihx
if exist irrecievertest.hex hex2mif irrecievertest.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\apoll\Documents\2nd year uni\Project course\MagBot\EM-Robot\IR_Controller\irrecievertest.hex
