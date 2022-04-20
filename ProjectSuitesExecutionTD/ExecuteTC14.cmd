CLS  
@PUSHD %~dp0  
@ECHO OFF  

set testExecutePath=C:\Program Files (x86)\SmartBear\TestExecute 14\Bin\TestExecute.exe
set testExecuteParameters=/r /e /ns /SilentMode

set testProjects=TCVE1 TCVE2 TCVE3
set nbExecutions=1
set currentExecutionPath=%cd%
set NomVserver=%~1
set VserverURL=%NomVserver: =%
if /i "%VserverURL:.croesus.local=%"=="%VserverURL%" set VserverURL=%VserverURL%.croesus.local/
if /i "%VserverURL:https://=%"=="%VserverURL%" (
    if "%VserverURL:http://=%"=="%VserverURL%" set VserverURL=http://%VserverURL%
)
set versionReference=%~2
set module3=%~3
set module4=%~4
set module5=%~5
set module6=%~6
set module7=%~7
set module8=%~8
set module9=%~9
set VariableVserver=vServer
set projectsuitesPath=%currentExecutionPath%
set GlobalVariablesPath=..\ProjectSuiteLibrary\Library\Script\Global_variables.sj
set GlobalVariablesBackupPath=%projectsuitesPath%\Global_variables_BAK.sj
echo:

::Start ProjectSuites Executions
echo:%0 %1 %2 %3 %4 %5 %6 %7 %8 %9
echo:------------------------------------------------------------

::Get Number of Arguments
SET /A ARGS_COUNT=0    
FOR %%A in (%*) DO SET /A ARGS_COUNT+=1    

::Check Number of Arguments, greater than 3
if %ARGS_COUNT% LSS 3 (
    echo:ERREUR, AU MOINS 3 PARAMETRES ATTENDUS DANS LA SYNTAXE : %~n0 NomVserver versionReference NomModule1 ... NomModule6
    echo:Exemple : %~n0 auto-VSERVER02 FM-13 Comptes Agenda
    echo:
    GOTO :END
)

::Check Number of Arguments, less than 10
if %ARGS_COUNT% GTR 9 (
    echo:ERREUR DE LA LIGNE DE COMMANDE, 9 PARAMETRES AU MAXIMUM ATTENDUS, PAS PLUS DE 7 MODULES A LA FOIS
    echo:Exemple : %~n0 auto-VSERVER02 FM-13 Comptes Agenda Clients Titres Relations General Portefeuille 
    echo:
    GOTO :END
)

:: Check if TestExecute.exe is running
tasklist /FI "IMAGENAME eq TestExecute.exe" 2>NUL | find /I /N "TestExecute.exe">NUL
if "%ERRORLEVEL%"=="0" (
	echo:
	echo:TestExecute est deja en cours d'execution.
	echo:Appuyer une touche pour arreter...
	echo:
    GOTO :END
)

:: Check if TestExecute.exe File exists
if not exist "%testExecutePath%" (
    echo:
    echo:ERREUR^! FICHIER EXECUTABLE DE TestExecute NON TROUVE :
    echo:"%testExecutePath%"
    GOTO :END
)

::Check all ProjectSuites Paths specified through Modules Names
for /L %%i in (3,1,%ARGS_COUNT%) do (
    SETLOCAL EnableDelayedExpansion 
    IF "%%i"=="3" SET module=%module3%
    IF "%%i"=="4" SET module=%module4%
    IF "%%i"=="5" SET module=%module5%
    IF "%%i"=="6" SET module=%module6%
    IF "%%i"=="7" SET module=%module7%
    IF "%%i"=="8" SET module=%module8%
    IF "%%i"=="9" SET module=%module9%
    
	::set projectSuitePath=%projectsuitesPath%\ProjectSuite!module!
    set projectPath=%projectsuitesPath%\ProjectSuite!module!\!module!
	cd "!projectPath!"
	for /f "usebackq delims=\" %%i in ('!projectPath!') do set projectFile=!projectPath!\%%~nxi.mds
    
	if not exist "!projectFile!" (
		echo:
		echo:ERREUR^! LE FICHIER DE PROJECT N'A PAS ETE TROUVE :
		echo:"!projectPath!\!module!.mds"
		echo:
		echo:Appuyer une touche pour arreter...
        GOTO :END
	)
    SETLOCAL DisableDelayedExpansion
)


::Update Global_variables.sj
cd "%currentExecutionPath%"
attrib -r "%GlobalVariablesPath%"
for /L %%i in (3,1,%ARGS_COUNT%) do (
    
    ::Backup Global_variables.sj
    cd "%currentExecutionPath%"
    COPY /Y "%GlobalVariablesPath%" "%GlobalVariablesBackupPath%" > nul 
    
    ::Get Module Name
    SETLOCAL EnableDelayedExpansion 
    IF "%%i"=="3" SET module=%module3%
    IF "%%i"=="4" SET module=%module4%
    IF "%%i"=="5" SET module=%module5%
    IF "%%i"=="6" SET module=%module6%
    IF "%%i"=="7" SET module=%module7%
    IF "%%i"=="8" SET module=%module8%
    IF "%%i"=="9" SET module=%module9%
    
    ::Update Global_variables.sj
    echo:>>"%GlobalVariablesPath%"
    echo:>>"%GlobalVariablesPath%"
	echo.//UPDATE THROUGH COMMAND LINE : %~n0 %*>>"%GlobalVariablesPath%"
    
    ::Variable for versionReference
    echo:var versionReference = '%versionReference%';>>"%GlobalVariablesPath%"
    
    ::Variable for the project
    CALL :GetVserverVariableName !module! VserverVariable
    echo:var !VserverVariable! = '%VserverURL%';>>"%GlobalVariablesPath%"
    
    ::Special case of ProjectSuite DataHub (If related items are enabled in other projects, need to properly find the DataHub vserver)
    if /i not "!module!"=="DataHub" (
        CALL :GetVserverVariableName DataHub VserverVariable
        echo:var !VserverVariable! = '%VserverURL%';>>"%GlobalVariablesPath%"
    )
    
    ::Special case of ProjectSuite GP1859 (it is based on ProjecSuite Rapports)
    if /i "!module!"=="GP1859" (
        CALL :GetVserverVariableName Rapports VserverVariable
        echo:var !VserverVariable! = '%VserverURL%';>>"%GlobalVariablesPath%"
    )
    
    ::Special case of testProjects=TCVE1 TCVE2 TCVE3 ...
    for %%t in (%testProjects%) do (
        set aTestProject=%%t
        if /i "!aTestProject!"=="!module!" (
            for /f "usebackq delims=" %%m in (`DIR "%projectsuitesPath%" /A:D /B`) do (
                set foundModule=%%m
                set foundModule=!foundModule:ProjectSuite=!
                if /i not "!foundModule!"=="DistributedTesting" (
                    if /i not "!foundModule!"=="CommonCheckpoints" (
                        if exist "%projectsuitesPath%\ProjectSuite!foundModule!\!foundModule!\!foundModule!.mds" (
                            set isATestProject=false
                            for %%u in (%testProjects%) do (
                                if /i "!foundModule!"=="%%u" set isATestProject=true
                            )
                            
                            if "!isATestProject!"=="false" (
                                CALL :GetVserverVariableName !foundModule! foundModuleVserverVariable
                                echo:var !foundModuleVserverVariable! = '%VserverURL%';>>"%GlobalVariablesPath%"
                            )
                        )
                    )
                )
            )
        )
    )
    
    ::Execute Project
    set projectPath=%projectsuitesPath%\ProjectSuite!module!\!module!
	cd "!projectPath!"
	for /f "usebackq delims=\" %%i in ('!projectPath!') do set projectFile=!projectPath!\%%~nxi.mds
	for /L %%i in (1,1,%nbExecutions%) do (
		echo:
		echo:!date! !time! : Execution de "!projectFile!" commencee...
		"%testExecutePath%" "!projectFile!" /p:!module! %testExecuteParameters%
	)
    SETLOCAL DisableDelayedExpansion
    
    ::Restore Global_variables.sj
    cd "%currentExecutionPath%"
    MOVE /Y "%GlobalVariablesBackupPath%" "%GlobalVariablesPath%" > nul 
)

echo:
echo:------------------------------------------------------------
echo:%date% %time% : Execution^(s^) terminee^(s^)
echo:


::End of script
:END
echo:
cd "%currentExecutionPath%"
echo:End of %~n0
pause
@POPD
ENDLOCAL
EXIT /B


::Get the variable name used for vServer in Global_variables.sj
:GetVserverVariableName
    SETLOCAL  
    set module=%~1
    IF /I not "%module:Performance=%"=="%module%" (SET VariableVserver=vServerPerformance)
    IF /I "%module%"=="Titres"         (SET VariableVserver=vServerTitre)
    IF /I "%module%"=="Portefeuille"   (SET VariableVserver=vServerPortefeuille)
    IF /I "%module%"=="Modeles"        (SET VariableVserver=vServerModeles)
    IF /I "%module%"=="Ordres"         (SET VariableVserver=vServerOrders)
    IF /I "%module%"=="Dashboard"      (SET VariableVserver=vServerDashboard)
    IF /I "%module%"=="Transactions"   (SET VariableVserver=vServerTransactions)
    IF /I "%module%"=="Agenda"         (SET VariableVserver=vServerAgenda)
    IF /I "%module%"=="Clients"        (SET VariableVserver=vServerClients)
    IF /I "%module%"=="Comptes"        (SET VariableVserver=vServerAccounts)
    IF /I "%module%"=="Relations"      (SET VariableVserver=vServerRelations)
    IF /I "%module%"=="Sleeves"        (SET VariableVserver=vServerSleeves)
    IF /I "%module%"=="Billing"        (SET VariableVserver=vServerBilling)
    IF /I "%module%"=="Rapports"       (SET VariableVserver=vServerReportsCR1485)
    IF /I "%module%"=="AideEnLigne"    (SET VariableVserver=vServerHelp)
    IF /I "%module%"=="RQS"            (SET VariableVserver=vServerRQS)
    IF /I "%module%"=="General"        (SET VariableVserver=vServerGeneral)
    IF /I "%module%"=="DataHub"        (SET VariableVserver=vServerDataHub)
    IF /I "%module%"=="TransitionWeb"  (SET VariableVserver=vServerCR1755)
    IF /I "%module%"=="PreExecution"   (SET VariableVserver=vServerMiniRegression)
    IF /I "%module%"=="GP1859"         (SET VariableVserver=vServerGP1859)
    IF /I "%module%"=="TCVE1"          (SET VariableVserver=vServerTCVE1)
    IF /I "%module%"=="TCVE2"          (SET VariableVserver=vServerTCVE2)
    IF /I "%module%"=="TCVE3"          (SET VariableVserver=vServerTCVE3)
    ENDLOCAL & SET %~2=%VariableVserver%
GOTO :EOF  
EXIT /B  
