﻿//UNIT Common_functions
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
    Date: 2020-02-16
*/

function Performance_ORC_3000Accounts_PercentOfBalance_negative()
{
        var cmbTransactionPercentOfBalanceNegative = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "cmbTransactionPercentOfBalanceNegative", language+client);        
        var SoughtForValuePercentOfBalanceNegative = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "SoughtForValuePercentOfBalanceNegative", language+client);        
        
        Performance_ORC_3000Accounts(cmbTransactionPercentOfBalanceNegative, SoughtForValuePercentOfBalanceNegative)
        
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
//        var SoughtForValue = "Performance_ORC_3000Accounts_%OfSecurityHeld_BtnPreview";
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        
        var curListCheckMarks = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "sourceTCVE3351", language+client);        
        var balance = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "balance", language+client);        
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "criterionName", language+client);        
        var qtySellORC3000 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "qtySellORC3000", language+client);        
//        var cmbTransactionSellORC3000 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "cmbTransactionSellORC3000", language+client);        
        var symbolCM = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "symbolCM", language+client);        
        var qtyBuyORC3000 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "qtyBuyORC3000", language+client);        
        var symbolNA = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "symbolNA", language+client);        
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
        
        AddASellBySymbol(qtySellORC3000,cmbTransaction,symbolCM);
        
//************************** Étape 3 *********************************************************************************
//        Log.PopLogFolder();
//        logEtape3 = Log.AppendFolder("Étape 3: Ajouter transactions équivalentes (Achat) (50% (NA) et 50% (NBC181))");
//        
//        PurchasequivalentTransactAddiction(qtyBuyORC3000, symbolNA);  //Répartition: 50% (NA) et 
//        PurchasequivalentTransactAddiction(qtyBuyORC3000, symbolNBC181);   //Répartition: 50% (NBC181)
//        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
//        
//************************** Étape 3 *********************************************************************************       
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Cliquer sur 'Aperçu' afin de voir le temps que ça prend");
               
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
        
//************************** Étape 4 *********************************************************************************       
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Écrire les résultats dans un fichier Excel");
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
        logEtape5 = Log.AppendFolder("Étape 5: Cleanup en désactivant critère de recherche et le supprimer.");
        Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnRemove().Click();
        DeleteCriterion(criterionName);
        
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}

function selectAccountsBySearchCriterion(balance,  criterionName) {
    
    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click(); 
    
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(criterionName);
        
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemCurrency().Click();
   
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemCAD().Click();
   
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemBalancePercent().Click();
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemLowerThan().Click();
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys(balance +"[Enter]");
    Delay(1000);
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
}
