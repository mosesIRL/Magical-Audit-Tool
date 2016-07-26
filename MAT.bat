REM https://github.com/mgiljum/MAT
@echo off
mode con: cols=100 lines=35
echo " ___  ___  ___  ______  __     ___  ___  ___    ___  __   ___  ___  __      
echo " ||\\//|| // \\ | || | (( \    ||\\//|| // \\  // \\ ||  //   // \\ ||      
echo " || \/ || ||=||   ||    \\     || \/ || ||=|| (( ___ || ((    ||=|| ||      
echo " ||    || || ||   ||   \_))    ||    || || ||  \\_|| ||  \\__ || || ||__|   
echo "                                                                            
echo "  ___  __ __ ____   __ ______    ______   ___     ___   __                  
echo " // \\ || || || \\  || | || |    | || |  // \\   // \\  ||                  
echo " ||=|| || || ||  )) ||   ||        ||   ((   )) ((   )) ||                  
echo " || || \\_// ||_//  ||   ||        ||    \\_//   \\_//  ||__|    (or "MAT" for short)           
echo "                                                                            
echo.
echo.
echo This tool grabs the user's name, PC name, Windows version, and a list of 
echo any Microsoft software (with version numbers) and plops it in a .csv file.
echo.
echo ONLY WORKS WITH WINDOWS VISTA / WINDOWS SERVER 2008 AND UP 
echo (WILL NOT WORK ON SERVER 2003 / XP OR BELOW)
echo.
echo.
echo If an audit CSV for this computer (or one with the same name) has already been created,
echo running the tool again will overwrite it.
echo.
echo.
PAUSE
cls
mode con: cols=100 lines=35
echo " ___  ___  ___  ______  __     ___  ___  ___    ___  __   ___  ___  __      
echo " ||\\//|| // \\ | || | (( \    ||\\//|| // \\  // \\ ||  //   // \\ ||      
echo " || \/ || ||=||   ||    \\     || \/ || ||=|| (( ___ || ((    ||=|| ||      
echo " ||    || || ||   ||   \_))    ||    || || ||  \\_|| ||  \\__ || || ||__|   
echo "                                                                            
echo "  ___  __ __ ____   __ ______    ______   ___     ___   __                  
echo " // \\ || || || \\  || | || |    | || |  // \\   // \\  ||                  
echo " ||=|| || || ||  )) ||   ||        ||   ((   )) ((   )) ||                  
echo " || || \\_// ||_//  ||   ||        ||    \\_//   \\_//  ||__|               
echo "                                                                            
echo.
echo.
echo Please wait, collecting data...
echo.
echo (This process may take up to 10 minutes on servers)
del /q "%~dp0%ComputerName%-Audit.csv" 2>nul
FOR /F "tokens=2*" %%A IN ('REG.EXE QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V "ProductName" 2^>NUL ^| Find "REG_SZ"') Do Set RegValuedata=%%B
echo User,PC Name,Windows Version >> "%~dp0%ComputerName%-Audit.csv"
echo %userdomain%\%username%,%ComputerName%,%RegValuedata%>> "%~dp0%ComputerName%-Audit.csv"
echo. >> "%~dp0%ComputerName%-Audit.csv"
echo. >> "%~dp0%ComputerName%-Audit.csv"
echo SOFTWARE >> "%~dp0%ComputerName%-Audit.csv"
setlocal enabledelayedexpansion
(For /F "tokens=2,3 delims=," %%A in ('"wmic product where "Vendor like '%%Microsoft%%'" get Name,Version /format:csv"') do (
set "line=%%A,%%B"
echo !line:~0,-1!
))>>"%~dp0%ComputerName%-Audit.csv"
cls
mode con: cols=100 lines=35
echo " ___  ___  ___  ______  __     ___  ___  ___    ___  __   ___  ___  __      
echo " ||\\//|| // \\ | || | (( \    ||\\//|| // \\  // \\ ||  //   // \\ ||      
echo " || \/ || ||=||   ||    \\     || \/ || ||=|| (( ___ || ((    ||=|| ||      
echo " ||    || || ||   ||   \_))    ||    || || ||  \\_|| ||  \\__ || || ||__|   
echo "                                                                            
echo "  ___  __ __ ____   __ ______    ______   ___     ___   __                  
echo " // \\ || || || \\  || | || |    | || |  // \\   // \\  ||                  
echo " ||=|| || || ||  )) ||   ||        ||   ((   )) ((   )) ||                  
echo " || || \\_// ||_//  ||   ||        ||    \\_//   \\_//  ||__|               
echo "                                                                            
echo.
echo Success^^!
echo.
echo Data saved to "%ComputerName%-Audit.csv"
echo.
echo Press any key to exit.
PAUSE>NUL
exit
