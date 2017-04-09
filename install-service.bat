@echo off

REM get full path to application in case when relative path is passed
SET AppPath="%~dp0%~1"
SET ServiceName=%2
SET Description=%3

SET NSSM=tools\nssm.exe

%NSSM% install %ServiceName% %AppPath%

%NSSM% set %ServiceName% Description %Description%

REM No console app
%NSSM% set %ServiceName% AppNoConsole 1

REM use WM_QUIT message to monitor service stop
%NSSM% set %ServiceName% AppStopMethodSkip 11

REM 30s time for WM_QUIT
%NSSM% set %ServiceName% AppStopMethodThreads 30000

%NSSM% start %ServiceName%