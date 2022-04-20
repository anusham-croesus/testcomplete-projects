//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Performance_RCMBtn

/*
      Lignes 37-38 et 39 du fichier Performance N°24 25 et 26: Pour les plugin: DashboardRegenerator, RQSActivityBlotter et RQSAlertGenerator
      
      Analyste d'automatisation: Amine A. */

function Performance_RCM_Cfloader(){

            var SoughtFor_DashboardRegenerator = "Performance_RCM_DashboardRegenerator";
            var SoughtFor_RQSActivityBlotter   = "Performance_RCM_RQSActivityBlotter";
            var SoughtFor_RQSAlertGenerator    = "Performance_RCM_RQSAlertGenerator";
            var column = FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtFor_DashboardRegenerator);
                  
        try {

            var Performance_SSHFolder = folderPath_ProjectSuiteCommonScripts  + "ProjectSuitePerformance\\Performance\\SSH\\";
            var RQSAlertGenerator_PlinkFile     = "RQSAlertGenerator_Plink.bat";
            var RQSDashboardGenerator_PlinkFile = "RQSDashboardGenerator_Plink.bat";
            var RRQSActivityBlotter_PlinkFile   = "RQSActivityBlotter_Plink.bat";
            
            //cfLoader -DashboardRegenerator \"ForceRegen GenerateClientPortfolio=true\" 
            var timeSpotted = ExecuteBatchFile(Performance_SSHFolder + RQSDashboardGenerator_PlinkFile);            
            var Newrow      = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtFor_DashboardRegenerator);
            WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);
            
            //cfLoader -RQSActivityBlotter
            var timeSpotted = ExecuteBatchFile(Performance_SSHFolder + RRQSActivityBlotter_PlinkFile);            
            var Newrow      = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtFor_RQSActivityBlotter);
            WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);
            
            //cfLoader -RQSAlertGenerator
            var timeSpotted = ExecuteBatchFile(Performance_SSHFolder + RQSAlertGenerator_PlinkFile);            
            var Newrow      = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtFor_RQSAlertGenerator);
            WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);                      
        }
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
        }
}

function ExecuteBatchFile(batchFilePath){   
   
            Log.Message("Execute batch file : " + batchFilePath);
            var StopWatchObj         = HISUtils.StopWatch;
            var defaultCurrentFolder = aqFileSystem.GetCurrentFolder();
            var batchFileFolderPath  = aqFileSystem.GetFileInfo(batchFilePath).ParentFolder.Path;
    
            Log.Message("Set current folder to : " + batchFileFolderPath);
            aqFileSystem.SetCurrentFolder(batchFileFolderPath);
    
            batchFilePath = "\"" + batchFilePath + "\"";
    
//            Log.Message("Execute file : " + batchFilePath);
            var shellObj = (isJavaScript())? getActiveXObject("WScript.Shell"): Sys.OleObject("WScript.Shell");
            StopWatchObj.Start();
            shellObj.Run(batchFilePath, 1, true);
            var timeSpotted = StopWatchObj.Split()/1000;
            StopWatchObj.Stop();
            //2eme paramètre de Run : 0 = n'affiche pas de fenêtre DOS ; 1 = affiche une fenêtre DOS (défaut)
            //3eme paramètre de Run : true = attend la fin de l'exécution ; false = n'attend pas la fin de l'exécution (défaut)
    
            //Log.Message("Set current folder back to : " + defaultCurrentFolder);
            aqFileSystem.SetCurrentFolder(defaultCurrentFolder); 
            
            Log.Message(" finished. Execution time: " + StopWatchObj.ToString());
            return timeSpotted;
}