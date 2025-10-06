@echo off
setlocal enabledelayedexpansion
if "%~1"=="" (
echo Usage: %~n0 [hostname] [switches]
echo Help:  %~n0 help
exit /b
)
if /i "%~1"=="help" (
echo %~nx0 - Simple domain IPv4 lookup
echo Usage: %~n0 [hostname] [switches]
echo Switches:
echo -open       Open IP in browser
echo -opensecure Open IP with HTTPS
exit /b
)
set "host=%~1"
set "host=%host:*://=%"
for /f "delims=/ tokens=1" %%A in ("%host%") do set "host=%%A"
set "ip="
for /f "tokens=2 delims=:" %%A in ('nslookup %host% 2^>nul ^| findstr /r /c:"Address:[ ]*[0-9]"') do (
set "ip=%%A"
set "ip=!ip: =!"
goto :found
)
for /f "tokens=2 delims=[]" %%A in ('ping -4 -n 1 %host% ^| findstr /i "Pinging"') do (
set "ip=%%A"
goto :found
)
:found
if not defined ip (
echo Error: Could not resolve hostname "%host%"
exit /b 1
)
echo %host% = %ip%
if /i "%2"=="-open" (
start "" "http://%ip%"
)
if /i "%2"=="-opensecure" (
start "" "https://%ip%"
)