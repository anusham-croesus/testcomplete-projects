//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USENIT RunSimulator_TCVE_969



/*  
    Analyste d'assurance qualité: Karima Mouzaoui
    Analyste d'automatisation: Philippe Maurice
    Date: 25 février 2022
    Version: 90.28.2021.12-115
 */

 
function Performance_Sle_CR2431_Pluggin_UMATemplateAssignation(){
  
    try {  
      
        Log.Link("https://croesus-support.atlassian.net/browse/TCVE-6277","Lien X-Ray du scenario.");
        
        //PRÉPARATION DE L'ENVIRONNEMENT / ACTIVATION DES PREFS
        Activation_PREFS(userNamePerformance, vServerPerformance);
        Activation_PREFS("UNI00", vServerPerformance);
              
        
//ÉTAPE 1:  * Ajouter Template1 et Template2:*
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Ajouter Template1 et Template2");
        
        // * Ouvrir une session croesus avec DESLAUJE
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
        Add_Templates();
        
        
//ÉTAPE 2 et 3:  * Rouler le plugin pour 1000 comptes*

        Log.PopLogFolder();
        logEtape2_3 = Log.AppendFolder("Étapes 2 et 3: Rouler le plugin pour 1000 comptes");
        
        var remoteDestinationFolder="/root/";
        var localFolderPath = folderPath_Data + "BNC\\CR2431\\"    //L'emplacement de fichier qui contient les infos nécessaires
        var filename = "1000Comptes-UMA.csv";     
        
        //Copier le fichier de Data vers le vserveur  (root)
        Log.Message("Copier le fichier " + filename + " vers le vserveur " + vServerPerformance);
        CopyFileToVserverThroughWinSCP(vServerPerformance, remoteDestinationFolder, localFolderPath + filename);        
        
        
//ÉTAPE 4:  * Rouler le plugin pour 1000 comptes et mesurer le temps*

        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étapes 4: Lancer la commande et mesurer le temps");
        
        var soughtForValue1000 = "Performance_Sle_CR2431_Pluggin_UMATemplateAssignation_1000";
        
        Execute_UMATemplateAssignation_Plugin(filename, vServerPerformance, soughtForValue1000);
        
        
//ÉTAPE 5:  * Rouler le plugin pour 1000 comptes après modification du template de la date de gestion et les profils*

        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étapes 5: Lancer la commande et mesurer le temps après modification du template de la date de gestion et les profils ");
        var filenameMod = "1000Comptes-UMA-Modifie.csv"; 
        var soughtForValue1000 = "Performance_Sle_CR2431_Pluggin_UMATemplateAssignation_1000_Modified";
        
        //Copier le fichier de Data vers le vserveur  (root)
        Log.Message("Copier le fichier " + filenameMod + " vers le vserveur " + vServerPerformance);
        CopyFileToVserverThroughWinSCP(vServerPerformance, remoteDestinationFolder, localFolderPath + filenameMod);

        Execute_UMATemplateAssignation_Plugin(filenameMod, vServerPerformance, soughtForValue1000);
        
        
//ÉTAPE 6:  * Rouler le plugin pour 2000 comptes et mesurer le temps*

        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Rouler le plugin pour 2000 comptes et mesurer le temps");
        
        var soughtForValue2000 = "Performance_Sle_CR2431_Pluggin_UMATemplateAssignation_2000";
        var filename2 = "2000Comptes-UMA.csv";
        
        //Copier le fichier de Data vers le vserveur  (root)
        Log.Message("Copier le fichier " + filename2 + " vers le vserveur " + vServerPerformance);
        CopyFileToVserverThroughWinSCP(vServerPerformance, remoteDestinationFolder, localFolderPath + filename2);

        Execute_UMATemplateAssignation_Plugin(filename2, vServerPerformance, soughtForValue2000);
    }    
    catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
    }

}


function Activation_PREFS(username, vServer)
{
    /*Voici les PREFS à activer pour l'utilisateur désigné
    //PREF_ALLOW_SLEEVE_NONDISC=Oui
    //PREF_ENABLE_SLEEVES=Oui
    //PREF_SLEEVES_ALLOW_TEMPLATE_CREATION=Oui
    //PREF_SLEEVE_ALLOW_CREATE=Oui
    //PREF_SLEEVE_ALLOW_DELETE=Oui
    //PREF_SLEEVE_ALLOW_SYNC=Oui
    //PREF_SLEEVE_ALLOW_TRADE=Oui
    //PREF_SLEEVE_ALLOW_VIEW=Oui */

    Log.Message("Activation des PREFS pour l'utilisateur: " + username + ".");
    Activate_Inactivate_Pref(username, "PREF_ALLOW_SLEEVE_NONDISC", "YES", vServer);
    Activate_Inactivate_Pref(username, "PREF_ENABLE_SLEEVES", "YES", vServer);
    Activate_Inactivate_Pref(username, "PREF_SLEEVES_ALLOW_TEMPLATE_CREATION", "YES", vServer);
    
    Activate_Inactivate_Pref(username, "PREF_SLEEVE_ALLOW_CREATE", "YES", vServer);
    Activate_Inactivate_Pref(username, "PREF_SLEEVE_ALLOW_DELETE", "YES", vServer);
    Activate_Inactivate_Pref(username, "PREF_SLEEVE_ALLOW_SYNC", "YES", vServer);
    Activate_Inactivate_Pref(username, "PREF_SLEEVE_ALLOW_TRADE", "YES", vServer);
    Activate_Inactivate_Pref(username, "PREF_SLEEVE_ALLOW_VIEW", "YES", vServer);
}


function Add_Templates()
{
    var unifiedManagedAccountTemplates = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_6272_unifiedManagedAccountTemplates", language+client);
    var mediumTerm        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_6272_mediumTerm",     language+client);
//    var modelAmericanEqui = "CH AMERICAN EQUI";
//    var modelCanadianEqui = "CH CANADIAN EQUI";

    var model1 = "name ~M-00005-0";
    var model2 = "name ~M-00007-0";
    var levelFirm = "Firm";
  
    
    // * Aller dans OUTILS-> Configurations-> Comptes à gestion unifiée
    Log.Message("Aller dans OUTILS-> Configurations-> Comptes à gestion unifiée");
        
    Get_MenuBar_Tools().Click();
        
    SetAutoTimeOut();
    while (! Get_SubMenus().Exists)
        Get_MenuBar_Tools().Click();
    RestoreAutoTimeOut();
        
    Get_MenuBar_Tools_Configurations().Click();
    WaitObject(Get_CroesusApp(), "Uid", "ListView_bc90");
        
    // * Double cliquer sur Gabarit de compte à gestion unifiée
    Get_WinConfigurations_TvwTreeview_LlbUnifiedManagedAccounts().Click();
    Get_WinConfigurations_LvwListView_LlbItem(unifiedManagedAccountTemplates).DblCLick();
    WaitObject(Get_CroesusApp(),"Uid","ManagerWindow_730e");


    // * Ajouter les 2 gabarits: Template1, Template2
    Log.Message("Créer le gabarit Tempale1 Access: Firme");
    Get_WinUnifiedManagedAccountTemplates_BtnAdd().Click();
    WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");

    Get_WinAddUnifiedManagedAccountTemplate_TxtName().Keys("Template1");
    Get_WinAddUnifiedManagedAccountTemplate_CmbAccess().Click();  
    Get_SubMenus().FindChild("DataContext.Level", levelFirm, 10).Click();
        
    Log.Message("Cliquer sur le bouton 'Ajouter' et créer 1er segment: Sleeve1")
    Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();        
    Log.Message("Sleeve1: associer le modèle " + model1 + " et mettre cible:49, max: 51, min:49");
    AddEditSleeveWinSleevesManager("Sleeve1", "", 50, 49, 51, model1);
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
            
    Log.Message("Cliquer sur le bouton 'Ajouter' et créer 2eme segment: Sleeve2")
    Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();
    Log.Message("Sleeve2: associer le modèle " + model2 + " et mettre cible:50, max: 49, min:10");
    AddEditSleeveWinSleevesManager("Sleeve2", "", 50, 10, 50, model2);
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
            
    //Sauvegader le Gabarit
    Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();
       
    //Créer le gabarit Tempale2 
    Log.Message("Créer le gabarit Tempale2 Access: Firme");
    Get_WinUnifiedManagedAccountTemplates_BtnAdd().Click();
    WaitObject(Get_CroesusApp(),"Uid","SleevesManagerWindow_fbcd");
    Get_WinAddUnifiedManagedAccountTemplate_TxtName().Keys("Template2");
    Get_WinAddUnifiedManagedAccountTemplate_CmbAccess().Click();  
    Get_SubMenus().FindChild("DataContext.Level", levelFirm, 10).Click();
        
    Log.Message("Cliquer sur le bouton 'Ajouter' et créer 1er segment: Sleeve1")
    Get_WinAddUnifiedManagedAccountTemplate_BtnAdd().Click();
    Log.Message("Sleeve1: associer le modèle " + model1 + " et mettre cible:100, max: 100, min: 100");
    AddEditSleeveWinSleevesManager("Sleeve1", mediumTerm, 100, 100, 100, model1);
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SleeveWindow_e60f");
            
    //Sauvegader le Gabarit
    Get_WinAddUnifiedManagedAccountTemplate_BtnSave().Click();
            
    //Fermer la fenêtre de gestion unifiée
    Get_WinUnifiedManagedAccountTemplates().Close();
            
    //Fermer la fenêtre de config
    Get_WinConfigurations().Close();
}



function ExeSSHCommand(CRFolderOrSSHCommandId, vServerURL, sshCommand, username, outputSuccessRegEx)//work
{
    var hostname = GetVserverHostName(vServerURL);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    var executionDateTimeString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "_%Y%m%d_%H%M%S");
    var filesRootName = (CRFolderOrSSHCommandId != undefined)? CRFolderOrSSHCommandId: "ExecuteSSHCommand" + executionDateTimeString;
    
    var executionSSHCommands = "#!/bin/bash" + "\r\n";
    executionSSHCommands += "if [ -f '/home/tools/LOG_cfLoader.sh' ]; then sh /home/tools/LOG_cfLoader.sh; fi" + "\r\n" + "\r\n";
    
    if (CRFolderOrSSHCommandId != undefined && username != undefined){
        var filesRootName = CRFolderOrSSHCommandId + executionDateTimeString;
        var vserverFolder = username// + CRFolderOrSSHCommandId ;
        //executionSSHCommands += "mkdir -p " + vserverFolder + "\r\n";
        //executionSSHCommands += "cd " + vserverFolder + "\r\n\r\n";
    }
    
    executionSSHCommands += sshCommand + "\r\n";
    
    Log.Message("ExecuteSSHCommand() on " + hostname + " : " + sshCommand, executionSSHCommands);
    
    var SSHCmdFileName = filesRootName + ".sh";
    var SSHCmdFilePath =  folderPath_ProjectSuiteCommonScripts + SSHCmdFileName;
    var localOutputFileName = filesRootName + "_Output.txt"; 
    var localOutputFilePath =  folderPath_ProjectSuiteCommonScripts + localOutputFileName; 
    var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + filesRootName + "_Plink.bat";
    
    //Cleanup existing Files
    if (aqFileSystem.Exists(SSHCmdFilePath))
        aqFileSystem.DeleteFile(SSHCmdFilePath);
    
    if (aqFileSystem.Exists(plinkBatchFilePath))
        aqFileSystem.DeleteFile(plinkBatchFilePath);
    
    if (aqFileSystem.Exists(localOutputFilePath))
        aqFileSystem.DeleteFile(localOutputFilePath);
    
    //Create SSH file
    if (!aqFile.WriteToTextFile(SSHCmdFilePath, executionSSHCommands, aqFile.ctANSI, true))
        Log.Error("File creation was not successfull : " + SSHCmdFilePath, executionSSHCommands);
    
    //Create and Execute Plink batch file
    var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m " + SSHCmdFileName + " > " + localOutputFileName;
    if (!aqFile.WriteToTextFile(plinkBatchFilePath, batchCmdLine, aqFile.ctANSI, true))
        Log.Error("File creation was not successfull : " + plinkBatchFilePath, batchCmdLine);
    
    ExeBatchFile(plinkBatchFilePath);
}



function ExeBatchFile(batchFilePath)
{
    Log.Message("Execute batch file : " + batchFilePath);
    
    var defaultCurrentFolder = aqFileSystem.GetCurrentFolder();
    var batchFileFolderPath = aqFileSystem.GetFileInfo(batchFilePath).ParentFolder.Path;
    
    //Log.Message("Set current folder to : " + batchFileFolderPath);
    aqFileSystem.SetCurrentFolder(batchFileFolderPath);
    
    batchFilePath = "\"" + batchFilePath + "\"";
    
    //Log.Message("Execute file : " + batchFilePath);
    var shellObj = (isJavaScript())? getActiveXObject("WScript.Shell"): Sys.OleObject("WScript.Shell");
    shellObj.Run(batchFilePath, 1, false);
    //2eme paramètre de Run : 0 = n'affiche pas de fenêtre DOS ; 1 = affiche une fenêtre DOS (défaut)
    //3eme paramètre de Run : true = attend la fin de l'exécution ; false = n'attend pas la fin de l'exécution (défaut)
    
    //Log.Message("Set current folder back to : " + defaultCurrentFolder);
    aqFileSystem.SetCurrentFolder(defaultCurrentFolder);
}


function Execute_UMATemplateAssignation_Plugin(filename, vServer, SoughtForValue)
{
    var StopWatchObj = HISUtils.StopWatch;
    var waitTimeLong = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language + client);
        
    RestoreAutoTimeOut();
    StopWatchObj.Start();
    //ExeSSHCommand("CR2431", vServer, "cfLoader -UMATemplateAssignation --FileName=\"" + filename + "\" -firm=FIRM_1", "root");
    ExecuteSSHCommandCFLoader2("CR2431", vServer, "cfLoader -UMATemplateAssignation --FileName=\"" + filename + "\" -firm=FIRM_1", "root");
    StopWatchObj.Stop();
        
    Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString()); 
     
    var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
    WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString()); 

}




function ExecuteSSHCommandCFLoader2(CRFolder, vserverCommand, sshCommand, username)
{
    //Create SSH commands file
    SSHCmdlines = "#!/bin/bash" + "\r\n" + 
                "cd /root/" + "\r\n" +
                sshCommand;
    
    SSHCmdFilePath = aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.ParentFolder.Path + "ProjectSuitesCommonScripts\\ssh_script_" + CRFolder + ".txt";
    CreateFileAndWriteText(SSHCmdFilePath, SSHCmdlines);

    //Create PLINK batch file
    hostname = GetVserverHostName(vserverCommand);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_script_" + CRFolder + ".txt > ssh_script_output_" + CRFolder + ".txt";
    plinkBatchFilePath = aqFileSystem.GetFolderInfo(ProjectSuite.Path).ParentFolder.ParentFolder.Path + "ProjectSuitesCommonScripts\\plink_" + CRFolder + ".bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
  
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}