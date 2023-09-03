@echo off
title 
set var1=%1

if exist "C:\\windows-registry-mods\wrm.cmd" ( goto wrm-exists ) else ( goto installation )
goto barrier

:installation
curl -s https://raw.githubusercontent.com/jolly-exe/wrm/main/data/wrm.zip -o %temp%\wrm.zip
cls
if not exist "C:\\windows-registry-mods" ( md C:\\windows-registry-mods )

powershell Expand-Archive -Path "%temp%\wrm.zip" -DestinationPath "C:\\windows-registry-mods"
curl -s https://raw.githubusercontent.com/jolly-exe/wrm/main/data/latest-version -o C:\\windows-registry-mods\data\version.txt
del /q /f %temp%\wrm.zip
goto wrm-exists

goto barrier

:wrm-exists
curl -s https://raw.githubusercontent.com/jolly-exe/wrm/main/data/latest-version -o C:\\windows-registry-mods\data\latest-version.txt
cls
set /p version= < C:\\windows-registry-mods\data\version.txt
set /p latest-version= < C:\\windows-registry-mods\data\latest-version.txt
if "%version%" == "%latest-version%" ( goto launch ) else ( goto update )

:launch
start "" "cmd" /c C:\\windows-registry-mods\wrm.cmd
exit

goto barrier

:update

rd /s /q "C:\\windows-registry-mods"

goto installation

:barrier