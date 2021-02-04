@echo off

for %%p in ( ia64 x86_64 x64 AMD64 ) do if "%PROCESSOR_ARCHITECTURE%" == "%%p" set "64bitmode=yes"

for /f "tokens=4 delims=[.NT " %%a in ('ver') do set version=%%a
if "%version%" == "6" goto unins
if "%version%" == "10" goto unins
goto end

:unins
title Uninstalling Windows Help...
echo Uninstalling Windows Help...

cd /d %SystemRoot%

if exist %SystemRoot%\winhlp32.bak   del winhlp32.exe > nul

attrib -s -h -r System32\*.GID > nul
del System32\*.GID > nul
if exist %SystemRoot%\System32\winhelp.hlp    del System32\winhelp.hlp > nul
if exist %SystemRoot%\System32\winhlp32.exe   del System32\winhlp32.exe > nul

if defined 64bitmode (
    attrib -s -h -r SysWOW64\*.GID > nul
    del SysWOW64\*.GID > nul
    if exist %SystemRoot%\SysWOW64\winhelp.hlp    del SysWOW64\winhelp.hlp > nul
    if exist %SystemRoot%\SysWOW64\winhlp32.exe   del SysWOW64\winhlp32.exe > nul
)

if exist %SystemRoot%\Help\*.hlp (
    attrib -s -h -r Help\*.GID > nul
    del /q Help\*.hlp > nul
    del /q Help\*.GID > nul
)

ren winhlp32.bak winhlp32.exe > nul
timeout /T 2 /NOBREAK > nul

:end
