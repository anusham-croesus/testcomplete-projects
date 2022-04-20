//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Description : 
    https://jira.croesus.com/browse/TCVE-8071
    Analyste d'assurance qualité : Abdel.m
    Analyste d'automatisation : Abdel.m
    Version: 2021.08-91 (environnement NFR)
    Date: 27 octobre 2021
*/

function Performance_Acc_CR2183_ImportManualList()
{
        Log.Link("https://jira.croesus.com/browse/TCVE-8071","Lien du cas de test dans Jira");
        Log.Link("https://jira.croesus.com/browse/TCVE-7749","Lien de la story dans Jira");
        
        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue1000 = ReadDataFromExcelByRowIDColumnID(filePath_Performance , "DataPerformanceNFR", "SoughtForValue1000", language+client);
        var SoughtForValue5000 = ReadDataFromExcelByRowIDColumnID(filePath_Performance , "DataPerformanceNFR", "SoughtForValue5000", language+client);
        var SoughtForValue10000 = ReadDataFromExcelByRowIDColumnID(filePath_Performance , "DataPerformanceNFR", "SoughtForValue10000", language+client);
        var folderPathCR1483 = folderPath_Data + "BNC\\CR2183\\"
        var filPath1000Account = folderPathCR1483 + "1000Account.csv";
        var filPath5000Account = folderPathCR1483 + "5000Account.csv";
        var filPath10000Account = folderPathCR1483 + "10000Account.csv";
        var name1000Account = ReadDataFromExcelByRowIDColumnID(filePath_Performance , "DataPerformanceNFR", "name1000Account", language+client);
        var name5000Account = ReadDataFromExcelByRowIDColumnID(filePath_Performance , "DataPerformanceNFR", "name5000Account", language+client);
        var name10000Account = ReadDataFromExcelByRowIDColumnID(filePath_Performance , "DataPerformanceNFR", "name10000Account", language+client);
        var moduleAccounts = ReadDataFromExcelByRowIDColumnID(filePath_Performance , "DataPerformanceNFR", "moduleAccounts", language+client);
      
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);

        
        try {
//        Activer la pref
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_CRITERIA_MANUAL_IMPORT", "YES", vServerPerformance);
        RestartServices(vServerPerformance); 
        
//         Se connecter à croesus
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);


        // Cliquer le module Comptes
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        // Vérifie le bouton est prêt
        Get_Toolbar_BtnManageSearchCriteria().WaitProperty("Enabled", true, 15000);
    
        // Cliquer le bouton gérer les critères de recherche
        Get_Toolbar_BtnManageSearchCriteria().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "Uid"], ["CriteriaManagerWindow", "ManagerWindow_efa9"]);
        
        //Mesurer le temps d'importation d'une liste manuelle de 1000 comptes
        Log.Message("Mesurer le temps d'importation d'une liste manuelle de 1000 comptes")
        Get_WinSearchCriteriaManager_BtnImportManualList().Click();
        
        ImportFile(filPath1000Account, moduleAccounts, name1000Account);
        Get_WinImportManualList_BtnImport().Click();
    
        // Mesuse la performance le critère de recherche
        StopWatchObj.Start();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "ManagerWindow_efa9",waitTimeShort);
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo","VisibleOnScreen"], ["ToggleButton", 1, true]);
        StopWatchObj.Stop();
    
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue1000 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue1000);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        //Fermer le critère de recherche     
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        //**************************************************************************************************
         // Cliquer le bouton gérer les critères de recherche
        Get_Toolbar_BtnManageSearchCriteria().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "Uid"], ["CriteriaManagerWindow", "ManagerWindow_efa9"]);
        
        //Mesurer le temps d'importation d'une liste manuelle de 5000 comptes
        Log.Message("Mesurer le temps d'importation d'une liste manuelle de 5000 comptes")
        Get_WinSearchCriteriaManager_BtnImportManualList().Click();
        
        ImportFile(filPath5000Account, moduleAccounts, name5000Account);
        Get_WinImportManualList_BtnImport().Click();
    
        // Mesuse la performance le critère de recherche
        StopWatchObj.Start();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "ManagerWindow_efa9",waitTimeShort);
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo","VisibleOnScreen"], ["ToggleButton", 1, true]);
        StopWatchObj.Stop();
    
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue5000 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue5000);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        //Fermer le critère de recherche     
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        //**************************************************************************************************
         // Cliquer le bouton gérer les critères de recherche
        Get_Toolbar_BtnManageSearchCriteria().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "Uid"], ["CriteriaManagerWindow", "ManagerWindow_efa9"]);
        
        //Mesurer le temps d'importation d'une liste manuelle de 10000 comptes
        Log.Message("Mesurer le temps d'importation d'une liste manuelle de 10000 comptes")
        Get_WinSearchCriteriaManager_BtnImportManualList().Click();
        
        ImportFile(filPath10000Account, moduleAccounts, name10000Account);
        Get_WinImportManualList_BtnImport().Click();
    
        // Mesuse la performance le critère de recherche
        StopWatchObj.Start();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "ManagerWindow_efa9",waitTimeShort);
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo","VisibleOnScreen"], ["ToggleButton", 1, true]);
        StopWatchObj.Stop();
    
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue10000 + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue10000);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        //Fermer le critère de recherche     
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        
        //Supprimer les filtres créés
        Delete_FilterCriterion(name1000Account, vServerPerformance);
        Delete_FilterCriterion(name5000Account, vServerPerformance);
        Delete_FilterCriterion(name10000Account, vServerPerformance);
       
        Log.Message("Remettre la pref à No");
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_CRITERIA_MANUAL_IMPORT", "NO", vServerPerformance);
        RestartServices(vServerPerformance); 
        }

}

function ImportFile(filePath, Module, Name){
    Log.Message("Remplir les champs dans la fenêtre 'Importer une liste manuelle'");
    Get_WinImportManualList_TxtName().Keys(Name);
    Get_WinImportManualList_CmbModule().Click();
    Get_SubMenus().Find("WPFControlText", Module, 10).Click();
    Get_WinImportManualList_BtnBrowse().Click();
    Get_DlgOpen_CmbFileName1().SetText(filePath);
    Get_DlgOpen_BtnOpen().Click()
}