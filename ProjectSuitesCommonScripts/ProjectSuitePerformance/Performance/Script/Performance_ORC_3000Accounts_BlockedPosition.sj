//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT Performance_ORC_Common_functions

/**
    Description : 
    https://docs.google.com/spreadsheets/d/1rn-P_6hBwQIkSDSNih_H71u_j1eVNnH6/edit#gid=1560668979
    Analyste d'assurance qualité : 
    Analyste d'automatisation : Abdelm
    Version: 2020.09.87-24 (environnement NFR)
    Date: 2020-02-19
*/

function Performance_ORC_3000Accounts_BlockedPosition()
{
        var cmbTransactionBlockedPosition = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "cmbTransactionUnitsPerAccount", language+client);        
        var SoughtForValueBlockedPosition = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "SoughtForValueBlockedPosition", language+client);        
        
        Performance_ORC_3000Accounts(cmbTransactionBlockedPosition, SoughtForValueBlockedPosition)
        
}

function Performance_ORC_3000Accounts(cmbTransaction, SoughtForValue)
{
    try {
        //Lien de la story dans le drive
        Log.Link("https://docs.google.com/spreadsheets/d/1rn-P_6hBwQIkSDSNih_H71u_j1eVNnH6/edit#gid=1560668979","Lien de la story dans le drive");
           
        //-------------Declaration des Variables -------------//USEUNIT CommonCheckpoints
        var username = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "CHARTIF", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "CHARTIF", "psw");
        
        
        //Pour mesurer le temps
        var StopWatchObj   = HISUtils.StopWatch;
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        
        var curListCheckMarks = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "sourceTCVE3351", language+client);        
        var balance = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "balance", language+client);        
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "criterionName", language+client);        
        var qtySellORC3000 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "qtySellORC3000", language+client);        
        var symbolBCE = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "symbolBCE", language+client);        
        var symbolNBC181 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "symbolNBC181", language+client);        
        
                
//************************** Étape 1 *********************************************************************************
        //Se connecter à croesus avec CHARTIF
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec CHARTIF et sélectionner environ 3000 comptes");
        Log.Message("Se connecter à croesus avec CHARTIF");
        Login(vServerPerformance, username, password, language);
 
        //Préparation c'est-à-dire sélectionner environ 3000 comptes réels
        Get_ModulesBar_BtnAccounts().Click();
        selectAccountsBySearchCriterion(balance, criterionName);
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ProgressCroesusWindow_b5e1", waitTimeShort);
        
//************************** Étape 2 *********************************************************************************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Ajouter transactions de vente (Qté: 100 % de la position détenue, Titre: CM)");
        
        //Ajouter transaction vente (quantité 100 % de la position détenue, Titre CM, OK)
        Get_Toolbar_BtnSwitchBlock().Click();   //Cliquer sur ordres multiples et attendre la fenêtre
        WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
        
        //Cliquer sur Sources et choisir Liste courante (Crochets)
        Get_WinSwitchBlock_GrpParameters_CmbSources().Click();  
        Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock", curListCheckMarks],10).Click();
        
        AddASellBySymbol(qtySellORC3000,cmbTransaction,symbolBCE);
        
//************************** Étape 3 *********************************************************************************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Ajouter transactions équivalentes (Achat) (100% (NBC181))");
        
        PurchasequivalentTransactAddiction(qtySellORC3000, symbolNBC181);   //Répartition: 100% (NBC181)
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
        
//************************** Étape 4 *********************************************************************************       
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Cliquer sur 'Aperçu' afin de voir le temps que ça prend");
               
        Get_WinSwitchBlock_BtnPreview().Click();  //Cliquer sur Aperçu
        
        //Mesure la performance du clique sur le boutton 'Aperçue'
        StopWatchObj.Start();
        
        //Avertissement
        if(Get_DlgWarning().Exists)
                Get_DlgWarning_BtnOK().Click();
            
        //Message de confirmation pour inclure les comptes
        if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnInclude().Click();
            
        //Avertissement
        if(Get_DlgWarning().Exists) 
                Get_DlgWarning_BtnOK().Click();
        
        //Attendre que le boutton 'Generate' devient actif
        Get_WinSwitchBlock_BtnGenerate().WaitProperty("Enabled", true, waitTimeLong);
  
        //Arrêter le timer
        StopWatchObj.Stop();
        
        //Info
        if (Get_DlgInformation().Exists && Get_DlgInformation().IsActive){
            Get_DlgInformation().Keys("[Enter]");
        }
        Get_WinSwitchBlock_BtnCancel().Click();
        
//************************** Étape 5 *********************************************************************************       
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Écrire les résultats dans un fichier Excel");
        // Écrire le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());   
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //Cleanup (désactiver le critère de recherche et le supprimer)
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Cleanup en désactivant critère de recherche et le supprimer.");
        Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnRemove().Click();
        DeleteCriterion(criterionName);
        
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}