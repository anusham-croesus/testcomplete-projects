//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Clients_Get_functions
//USEUNIT ExcelUtils

/**
    Description : [Lenteur] Fenêtre des ordres: délai trop long lorsqu’on clic sur aperçu

    ligne 13 du fichier:  https://docs.google.com/spreadsheets/d/1rn-P_6hBwQIkSDSNih_H71u_j1eVNnH6/edit#gid=1560668979
 
    Analyste d'automatisation : A.A
    Version: 2020.09-87-24 (environnement NFR)
    Date: 2021-02-11
*/

function Performance_ORC_Over5000Accounts_UnitPerAccount(){

        var StopWatchObj    = HISUtils.StopWatch;
        var userNameCHARTIF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "CHARTIF", "username");
        var passwordCHARTIF = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "CHARTIF", "psw");
        
        var securityNBC100 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over5000Acc_securityNBC100", language+client);
        var securityNBC181 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over5000Acc_securityNBC181", language+client);
        var securityNA     = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over5000Acc_securityNA", language+client);
        var quantity100    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over5000Acc_quantity100", language+client); 
        var quantity45     = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over5000Acc_quantity45", language+client);
        var quantity50     = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over5000Acc_quantity50", language+client);
        
        var unitsPerAccount = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over5000Acc_unitsPerAccount", language+client);   
        
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);

        var criterionName = "# A_Comptes réels";
        
        try {
            // Se connecter avec CHARTIF
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec CHARTIF ");
            
            Log.Message("Se connecter à croesus avec CHARTIF");
            Login(vServerPerformance, userNameCHARTIF, passwordCHARTIF, language);
/* */
            //Aller au module Comptes
            Get_ModulesBar_BtnAccounts().Click(); 
            WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
            
            //Enlever tous les filtres
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            
            //Créer un critère de recherche 'Comptes réels'
            Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();    
            Get_WinAddSearchCriterion_TxtName().Clear();
            Get_WinAddSearchCriterion_TxtName().Keys(criterionName);
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
            Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
     
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 2: Créer des ordes d'achat et vente, mesurer la performance pour 'Aperçu' et 'Générer'");
            //Ouvrir la fenêtre 'Ordre multiple'
            Get_Toolbar_BtnSwitchBlock().Click();

            //Créer un ordre de vente unités par comptes quantité: 100, titre: NBC100 
            AddSellOrder(quantity100, unitsPerAccount, securityNBC100);                    
           
            //Créer un ordre de achat quantité: 45, titre: NA 
            AddBuyOrder(quantity45, securityNA);  
            
            //Créer un ordre de achat quantité: 50, titre: NBC181
            AddBuyOrder(quantity50, securityNBC181);
            
            //Mesure la performance du clique sur le boutton 'Aperçue'
            Get_WinSwitchBlock_BtnPreview().Click();
            
            //Lancer le timer
            StopWatchObj.Start();
            
            //Message de confirmation pour inclure des comptes
            if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnInclude().Click();
                        
            //Attendre que le boutton 'Generate' devient actif       
            Get_WinSwitchBlock_BtnGenerate().WaitProperty("Enabled", true, waitTimeShort);          
            StopWatchObj.Stop();
            
            //Fermer la fenêtre d'information
            if(Get_DlgInformation().Exists) 
                  Get_DlgInformation_BtnOK().Click();            

            // Écrit le résultat dans le fichier excel
            var SoughtForValue = "Performance_ORC_Over5000Accounts_BtnPreview";
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());              
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

            //Mesure la performance du clique sur le boutton 'Generate'           
            Get_WinSwitchBlock_BtnGenerate().Click();
            
            //Lancer le timer
            StopWatchObj.Start();
            
            //Fermer la fenêtre d'information
            if(Get_DlgConfirmation().Exists) 
                  Get_DlgConfirmation_BtnYes().Click();
                         
            Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", securityNBC100], 10).WaitProperty("IsLoaded", true, waitTimeShort);
            StopWatchObj.Stop();
            
            // Écrit le résultat dans le fichier excel
            SoughtForValue = "Performance_ORC_Over5000Accounts_BtnGenerate";
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());              
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 3: Supprimer les ordres, Supprimer le critère de recherche");
            //Supprimer les ordres
            Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", securityNBC100], 10).Click();
            Get_OrderAccumulatorGrid().Keys("^a")
            Get_OrderAccumulator_BtnDelete().Click();
            Get_DlgConfirmation_BtnYes().Click(); 
            
            //Supprimer le critère de recherche
            //Aller au module Comptes
            Get_ModulesBar_BtnAccounts().Click(); 
            WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");

            //Supprimer le critère de recherche 
            DeleteSearchCriterion(criterionName);         
        }
        catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
            Terminate_CroesusProcess(); //Fermer Croesus
            Terminate_IEProcess();
        }
}

function AddBuyOrder(quantity, securitySymbol){

        Log.Message("Créer un ordre d'achat pour le titre: " + securitySymbol);  
        Get_WinSwitchBlock_GrpEquivalentTransactions_BtnAdd().Click();
        Get_WinSwitchEquivalent_TxtAllocationPercent().Keys(quantity);
        Get_WinSwitchEquivalent_CmbSecurity_TxtSecurity().Keys(securitySymbol + " [Enter]");
        Get_WinSwitchEquivalent_btnOK().Click();
}

function AddSellOrder(quantity, typeSell, securitySymbol){
    
        Log.Message("Créer un ordre de vente pour le titre: " + securitySymbol);
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        Get_WinSwitchSource_TxtQuantity().Keys(quantity);
        SelectComboBoxItem(Get_WinSwitchSource_CmbQuantity(), typeSell);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securitySymbol + " [Enter]");
        Get_WinSwitchSource_btnOK().Click();
}

function DeleteSearchCriterion(searchCriterionName){
  
        Log.Message("Supprimer le critère de recherche: " + searchCriterionName);
        //Enlever tous les filtres
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_Toolbar_BtnManageSearchCriteria().Click(); 
        WaitObject(Get_CroesusApp(), ["ClrClassName", "Uid"], ["CriteriaManagerWindow", "ManagerWindow_efa9"], 30000);
        Get_WinSearchCriteriaManager().Parent.Maximize();
        
        // Clique le critère de recherche
        Get_WinSearchCriteriaManager_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", searchCriterionName], 10).Click();  
        Get_WinSearchCriteriaManager_BtnDelete().Click();
        Get_DlgConfirmation_BtnDelete().Click();
        Get_WinSearchCriteriaManager_BtnClose().Click();
}