@echo off
title 
set var1=%1

if exist "%appdata%\windows-registry-mods\wrm.cmd" ( goto wrm-exists ) else ( goto installation )
goto barrier

:installation
curl -s https://raw.githubusercontent.com/xXJollyHAKERXx/wrm/main/data/wrm.zip -o %temp%\wrm.zip
cls
if not exist "%appdata%\windows-registry-mods" ( md %appdata%\windows-registry-mods )

powershell Expand-Archive -Path "%temp%\wrm.zip" -DestinationPath "%appdata%\windows-registry-mods"
curl -s https://raw.githubusercontent.com/xXJollyHAKERXx/wrm/main/data/latest-version -o %appdata%\windows-registry-mods\data\version.txt
del /q /f %temp%\wrm.zip
goto wrm-exists

goto barrier

:wrm-exists
curl -s https://raw.githubusercontent.com/xXJollyHAKERXx/wrm/main/data/latest-version -o %appdata%\windows-registry-mods\data\latest-version.txt
cls
set /p version= < %appdata%\windows-registry-mods\data\version.txt
set /p latest-version= < %appdata%\windows-registry-mods\data\latest-version.txt
if "%version%" == "%latest-version%" ( goto launch ) else ( goto update )

:launch
start "" "cmd" /c %appdata%\windows-registry-mods\wrm.cmd launch
exit

goto barrier

:update

rd /s /q "%appdata%\windows-registry-mods"

goto installation

:barrier