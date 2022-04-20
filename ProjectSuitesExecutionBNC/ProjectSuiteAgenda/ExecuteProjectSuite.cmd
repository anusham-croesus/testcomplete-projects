set nbExecutions=1
set testExecutePath=C:\Program Files (x86)\SmartBear\TestExecute 14\Bin\TestExecute.exe
set testExecuteParameters=/r /e /ns /SilentMode
set projectSuitePath=%cd%

@pushd %~dp0
@echo OFF
cls

:: Verifier s'il y a une instance de TestExecute.exe en cours d'execution
tasklist /FI "IMAGENAME eq TestExecute.exe" 2>NUL | find /I /N "TestExecute.exe">NUL
if "%ERRORLEVEL%"=="0" (
	echo:
	echo:TestExecute est deja en cours d'execution
	echo:Appuyer une touche pour fermer ...
	echo:
	pause
	exit
)

:: Recuperer le chemin d'acces du fichier ProjectSuite
for /f "usebackq delims=" %%i in (`dir /b *.pjs`) do set projectSuiteFile=%projectSuitePath%\%%i

:: Executer le ProjectSuite autant de fois que specifie par la variable nbExecutions (1ere ligne)
SETLOCAL EnableDelayedExpansion
if exist "%projectSuiteFile%" (
	echo:Execution^(s^) du ProjectSuite "%projectSuiteFile%" en cours
	echo:
	for /L %%i in (1,1,%nbExecutions%) do (
		echo:!date! !time! : Execution No %%i commencee...
		"%testExecutePath%" "%projectSuiteFile%" %testExecuteParameters%
		echo:
	)
	echo:!date! !time! : Execution^(s^) terminee^(s^)
	echo:
	echo:Appuyer une touche pour fermer ...
	pause
) else (
	echo:
	echo:ERREUR. LE FICHIER DU PROJECTSUITE N'A PAS ETE TROUVE :
	echo:"%projectSuiteFile%"
	echo:Le fichier d'execution "ExecuteProjectSuite.cmd" doit se trouver dans le dossier du ProjectSuite
	echo:
	echo:Appuyer une touche pour fermer ...
	pause
)

SETLOCAL DisableDelayedExpansion
@popd
exit
