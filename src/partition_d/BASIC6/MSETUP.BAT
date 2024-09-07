echo off
Rem			    Microsoft Editor Setup
Rem

Rem Display Header

echo Microsoft Editor Setup.
echo Copyright (C) Microsoft Corp 1987,1988.  All rights reserved
echo.

Rem Check for help wanted or bad syntax.

if "%1"=="help" goto HELP
if "%1"=="" goto HELP

if "%2"=="" goto GETPATH
set s1=%2
goto GOTPATH

:GETPATH
set s1=%INIT%

:GOTPATH

Rem Check for files.

if "%1"=="quick" goto NAMEOK
if "%1"=="epsilon" goto NAMEOK
if not "%1"=="brief" goto HELP
:NAMEOK

if not exist %1.ini goto PLACE

rem Install/Update TOOLS.INI
if not exist %s1%\tools.ini goto PUTTOOLS

echo Appending %1.INI to %s1%\TOOLS.INI
pause
copy %s1%\tools.ini + %1.ini %s1%\tools.ini >nul
goto END

:PUTTOOLS
echo Copying %1.INI to %s1%\TOOLS.INI
pause
copy %1.ini %s1%\tools.ini >nul
goto END


:HELP
echo USAGE: MSETUP {QUICK, BRIEF, EPSILON} [TOOLS.INI path]
echo	Path defaults to value of the INIT environment variable.
echo.
echo	Examples:  MSETUP QUICK C:\INIT
echo		   MSETUP BRIEF
echo.


:PLACE
echo SETUP must be executed from the disk containing:
echo.
echo	QUICK.INI, BRIEF.INI, and EPSILON.INI.


:END
set s1=
