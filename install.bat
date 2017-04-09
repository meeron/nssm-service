@echo off

SET ServiceName=NssmService

call remove-service.bat %ServiceName%

if %ERRORLEVEL% NEQ 0 (
	echo Cannot install '%ServiceName%' due to remove errors.
	exit /b 1
)

call install-service.bat NssmService\NssmService\bin\Debug\NssmService.exe %ServiceName% "Nssm service"