REM https://github.com/mgiljum/MAT
@echo off
mode con: cols=100 lines=35


:INTRO
type "%~dp0inc\header.txt"
echo.
echo.
type "%~dp0inc\intro.txt"
PAUSE >NUL
cls


:START
type "%~dp0inc\header.txt"
echo.
echo.
echo Please wait, collecting data...
echo.
echo (This process may take up to 10 minutes on servers)
REM Create results directory and delete identical results
if not exist "%~dp0results" (
	mkdir "%~dp0results"
	)
if exist "%~dp0results\%ComputerName%-Audit.csv" (
	del /q "%~dp0results\%ComputerName%-Audit.csv"
	)

REM Get Windows version
FOR /F "tokens=2*" %%A IN ('REG.EXE QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V "ProductName" 2^>NUL ^| Find "REG_SZ"') Do Set RegValuedata=%%B

REM Echo out User,PC Name,Windows Version to results
echo User,PC Name,Windows Version >> "%~dp0results\%ComputerName%-Audit.csv"
echo %userdomain%\%username%,%ComputerName%,%RegValuedata%>> "%~dp0results\%ComputerName%-Audit.csv"

REM Add some blank lines
echo. >> "%~dp0results\%ComputerName%-Audit.csv"
echo. >> "%~dp0results\%ComputerName%-Audit.csv"

REM Grab software and echo to results
echo SOFTWARE >> "%~dp0results\%ComputerName%-Audit.csv"
setlocal enabledelayedexpansion
(For /F "tokens=2,3 delims=," %%A in ('"wmic product where "Vendor like '%%Microsoft%%'" get Name,Version /format:csv"') do (
set "line=%%A,%%B"
echo !line:~0,-1!
))>>"%~dp0results\%ComputerName%-Audit.csv"
cls


:FINISHED
type "%~dp0inc\header.txt"
echo.
echo.
echo Success^^!
echo.
echo Data saved to "%ComputerName%-Audit.csv"
echo.
echo Press any key to exit.
PAUSE>NUL
exit