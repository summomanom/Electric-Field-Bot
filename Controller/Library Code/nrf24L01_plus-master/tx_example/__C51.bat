@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\EM-Tether-Robot\Controller\Library Code\nrf24L01_plus-master\tx_example\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\EM-Tether-Robot\Controller\Library Code\nrf24L01_plus-master\tx_example\main.c"
if not exist hex2mif.exe goto done
if exist main.ihx hex2mif main.ihx
if exist main.hex hex2mif main.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\Grant\Documents\UBC\Year 2\Elec291\Project 2\EM-Tether-Robot\Controller\Library Code\nrf24L01_plus-master\tx_example\main.hex
