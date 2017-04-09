@echo off

SET ServiceName=%1
SET NSSM=tools\nssm.exe

REM Stop service. In case of error do not show nssm error message by redirecting stderr
REM to sdtout and then to nul device
%NSSM% stop %ServiceName% /f >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	echo WARNING: Service '%ServiceName%' was not found.
	exit /b 0
) else (
	%NSSM% remove %ServiceName% confirm
)