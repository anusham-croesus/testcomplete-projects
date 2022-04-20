@pushd %~dp0
@echo off

echo:---------------------------------------------------------------------------------------
echo:MUST BE EXECUTED AS ADMINISTRATOR TO CREATE THE TASK : %~nx0
echo:---------------------------------------------------------------------------------------
echo:

Schtasks /Create /SC ONCE /TN %~nx0 /TR "CMD /C ECHO Waiting to kill TestExecute process & TIMEOUT 60 /NOBREAK & TASKKILL /F /IM TestExecute.exe /T" /ST 00:00 /F /RL HIGHEST

echo:
echo:To run the task, execute the following command line (no need to be run as Admin) :
echo:"Schtasks /Run /TN %~nx0"
echo:

pause
@popd
exit
