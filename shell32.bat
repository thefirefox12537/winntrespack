@echo off
title Installing Windows NT Shell...

for %%p in ( ia64 x86_64 x64 AMD64 ) do if "%PROCESSOR_ARCHITECTURE%" == "%%p" set "64bitmode=yes"
if defined 64bitmode   set "programfiles=%programfiles(x86)%"

for /f "tokens=3 delims= " %%e in ('reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v EditionID') do set "edition=%%e"
for /f "tokens=4,5 delims=[.NT " %%a in ('ver') do set "version=%%a.%%b"
if "%version%" == "6.0" goto vista
if "%version%" == "6.1" goto win7
if "%version%" == "6.2" goto win8
if "%version%" == "6.3" goto win8.1
if "%version%" == "10.0" goto win10

goto error

:vista
if "%edition%" == "Starter"       copy "%programfiles%\Windows NT\Respack\shell32\vista\starter\shellwr.dll"      %SystemRoot%\System32> nul
if "%edition%" == "Home Basic"    copy "%programfiles%\Windows NT\Respack\shell32\vista\homebasic\shellwr.dll"    %SystemRoot%\System32> nul
if "%edition%" == "Home Premium"  copy "%programfiles%\Windows NT\Respack\shell32\vista\homepremium\shellwr.dll"  %SystemRoot%\System32> nul
if "%edition%" == "Business"      copy "%programfiles%\Windows NT\Respack\shell32\vista\business\shellwr.dll"     %SystemRoot%\System32> nul
if "%edition%" == "Ultimate"      copy "%programfiles%\Windows NT\Respack\shell32\vista\ultimate\shellwr.dll"     %SystemRoot%\System32> nul

goto check


:win7
if "%edition%" == "Starter"       copy "%programfiles%\Windows NT\Respack\shell32\win7\starter\shellwr.dll"       %SystemRoot%\System32> nul
if "%edition%" == "Home Basic"    copy "%programfiles%\Windows NT\Respack\shell32\win7\homebasic\shellwr.dll"     %SystemRoot%\System32> nul
if "%edition%" == "Home Premium"  copy "%programfiles%\Windows NT\Respack\shell32\win7\homepremium\shellwr.dll"   %SystemRoot%\System32> nul
if "%edition%" == "Professional"  copy "%programfiles%\Windows NT\Respack\shell32\win7\professional\shellwr.dll"  %SystemRoot%\System32> nul
if "%edition%" == "Enterprise"    copy "%programfiles%\Windows NT\Respack\shell32\win7\enterprise\shellwr.dll"    %SystemRoot%\System32> nul
if "%edition%" == "Ultimate"      copy "%programfiles%\Windows NT\Respack\shell32\win7\ultimate\shellwr.dll"      %SystemRoot%\System32> nul

goto check


:win8
if "%edition%" == "CoreSingleLanguage"   copy "%programfiles%\Windows NT\Respack\shell32\win8\home\shellwr.dll"          %SystemRoot%\System32> nul
if "%edition%" == "Professional"         copy "%programfiles%\Windows NT\Respack\shell32\win8\pro\shellwr.dll"           %SystemRoot%\System32> nul
if "%edition%" == "Enterprise"           copy "%programfiles%\Windows NT\Respack\shell32\win8\enterprise\shellwr.dll"    %SystemRoot%\System32> nul

goto check


:win8.1
if "%edition%" == "CoreSingleLanguage"   copy "%programfiles%\Windows NT\Respack\shell32\win8.1\home\shellwr.dll"        %SystemRoot%\System32> nul
if "%edition%" == "Professional"         copy "%programfiles%\Windows NT\Respack\shell32\win8.1\pro\shellwr.dll"         %SystemRoot%\System32> nul
if "%edition%" == "Enterprise"           copy "%programfiles%\Windows NT\Respack\shell32\win8.1\enterprise\shellwr.dll"  %SystemRoot%\System32> nul

goto check


:win10
if "%edition%" == "CoreSingleLanguage"   copy "%programfiles%\Windows NT\Respack\shell32\win10\home\shellwr.dll"         %SystemRoot%\System32> nul
if "%edition%" == "Professional"         copy "%programfiles%\Windows NT\Respack\shell32\win10\pro\shellwr.dll"          %SystemRoot%\System32> nul
if "%edition%" == "Enterprise"           copy "%programfiles%\Windows NT\Respack\shell32\win10\enterprise\shellwr.dll"   %SystemRoot%\System32> nul


:check
if defined 64bitmode   copy %SystemRoot%\System32\shellwr.dll  %SystemRoot%\SysWOW64\shellwr.dll
if not exist %SystemRoot%\System32\shellwr.dll   goto edition_noexist

echo.
echo Completed.
timeout /T 2 /NOBREAK > nul
goto end


:edition_noexist
cls
echo.
echo Your Windows edition unavailable in the Windows NT Shell Setup
echo but we must developed again on later build version.
echo.
echo Press any key to end install Windows NT Shell...
pause > nul
goto end


:error
echo.
echo This Windows version might been compatible the Windows Shell.
echo The uninstall application will skipping uninstall Windows NT
echo Shell, when there a console window.
echo.
echo Press any key to abort install Windows NT Shell...
pause > nul

:end
