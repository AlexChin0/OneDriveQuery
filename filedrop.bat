@echo off
set src= reference machines.txt here
set dst= reference output.txt here
set script= reference powershell script here

for /f "tokens=* usebackq" %%x in (%src%) do (

	echo Attempting to connect to %%x
	qwinsta /server:%%x

	if errorlevel 1 (
		echo connection to %%x failed >> %dst%
		echo "--------------------------------------">>%dst%
	) else (

		psexec \\%%x powershell Set-ExecutionPolicy RemoteSigned

		if exist "\\%%x\c$\programdata\Microsoft OneDrive Check\odcheck.ps1" (
			echo "Directory Found"
		) else (
		    echo "Creating Directory"
		    psexec \\%%x cmd /c mkdir "c:\programdata\Microsoft OneDrive Check"
		)
		xcopy /y %script% "\\%%x\c$\programdata\Microsoft OneDrive Check"
		echo %%x>>%dst%
		psexec \\%%x -w "C:\ProgramData\Microsoft OneDrive Check" -s powershell -file "odcheck.ps1">>%dst%
		echo "--------------------------------------">>%dst%
	)

)