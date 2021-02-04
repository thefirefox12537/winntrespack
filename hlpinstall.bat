@echo off

for %%p in ( ia64 x86_64 x64 AMD64 ) do if "%PROCESSOR_ARCHITECTURE%" == "%%p" set "64bitmode=yes"
if defined 64bitmode   set "programfiles=%programfiles(x86)%"

for /f "tokens=4 delims=[.NT " %%a in ('ver') do set version=%%a
if "%version%" == "6" goto copy
if "%version%" == "10" goto copy
goto error

:copy
title Installing Windows Help...
cd /d %SystemRoot%

echo Taking ownership Windows Help...
takeown /f winhlp32.exe > nul
icacls winhlp32.exe /grant administrators:F

echo.
echo Backuping Windows Help...
if exist %SystemRoot%\winhlp32.exe   ren winhlp32.exe winhlp32.bak > nul

echo.
echo Copying Windows NT Help...
move "%programfiles%\Windows NT\Respack\help\winhlp32.exe"   .\ > nul
move "%programfiles%\Windows NT\Respack\help\winhelp.hlp"    System32 > nul
move "%programfiles%\Windows NT\Respack\help\winhlp32.bin"   System32\winhlp32.exe > nul

if defined 64bitmode (
    copy /y System32\winhelp.hlp    SysWOW64 > nul
    copy /y System32\winhlp32.exe   SysWOW64 > nul
)

echo.
echo Completed.
timeout /T 2 /NOBREAK > nul
goto end

:error
echo.
echo This Windows version might been compatible windows Help.
echo The uninstall application will skipping uninstall help,
echo when there a console window.
echo.
echo Press any key to abort installing Windows Help...
pause > nul

:end
