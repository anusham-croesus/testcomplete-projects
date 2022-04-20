//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Clients_Get_functions
//USEUNIT ExcelUtils
//USEUNIT Performance_ORC_1331_LongTimeBeforePreview
//USEUNIT Performance_ORC_Over5000Accounts_UnitPerAccount

/**
    Description : [Lenteur] Fenêtre des ordres: délai trop long lorsqu’on clic sur aperçu

    ligne 14 du fichier:  https://docs.google.com/spreadsheets/d/1rn-P_6hBwQIkSDSNih_H71u_j1eVNnH6/edit#gid=1560668979
 
    Analyste d'automatisation : A.A
    Version: 2020.09-87-24 (environnement NFR)
    Date: 2021-02-11
*/

function Performance_ORC_Over16000Accounts_UnitPerAccount(){

        var StopWatchObj    = HISUtils.StopWatch;
        var userNamePELLETP = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "PELLETP", "username");
        var passwordPELLETP = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "PELLETP", "psw");
         
        var securityNBN1280 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over16000Acc_securityNBN1280", language+client);      
        var securityNBC100  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over16000Acc_securityNBC100", language+client);
        var securityNBC181  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over16000Acc_securityNBC181", language+client);
        var securityNBC200  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over16000Acc_securityNBC200", language+client);
        var securityLYZ801F = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over16000Acc_securityLYZ801F", language+client);
        var quantity100     = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over16000Acc_quantity100", language+client); 
        var quantity30      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over16000Acc_quantity30", language+client);
        var quantity10      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over16000Acc_quantity10", language+client);
        
        var unitsPerAccount = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "Over16000Acc_unitsPerAccount", language+client);           
        var waitTimeShort   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        
        var criterionName = "# A_ValeurTotale>1M";
        var totalValue1M = "1000000";
        
        try {
            // Se connecter avec PELLETP
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec PELLETP et sélectionner l'utilisateur 'Louis Khalil'");
            Log.Message("Se connecter à croesus avec PELLETP");
            Login(vServerPerformance, userNamePELLETP, passwordPELLETP, language);
 
            //Aller au module Comptes
            Get_ModulesBar_BtnAccounts().Click(); 
            WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
            
            //Enlever tous les filtres
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            
            //Créer un critère de recherche 'Comptes réels ayant valeur totale > 1M, résultat > 16000 comptes
            selectAccountsBySearchCriterion(totalValue1M, criterionName);
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ProgressCroesusWindow_b5e1", waitTimeShort);
    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 2: Créer des ordes d'achat et vente, mesurer la performance pour 'Aperçu' et 'Générer'");
            //Ouvrir la fenêtre 'Ordre multiple'
            Get_Toolbar_BtnSwitchBlock().Click();

            //Créer un ordre de vente unités par comptes quantité: 100, titre: NBN1280
            AddSellOrder(quantity100, unitsPerAccount, securityNBN1280);                      
           
            //Créer un ordre de vente quantité: 45, titre: NA 
            AddBuyOrder(quantity30, securityNBC200);
            AddBuyOrder(quantity10, securityLYZ801F);
            AddBuyOrder(quantity10, securityNBC181);
            AddBuyOrder(quantity10, securityNBC100);  
            
            //Mesure la performance du clique sur le boutton 'Aperçue'
            Get_WinSwitchBlock_BtnPreview().Click();
            
            //Lancer le timer
            StopWatchObj.Start();
            
            //Message de confirmation pour inclure des comptes
            if(Get_DlgInformation().Exists)
                Get_DlgInformation_BtnOK().Click();
                        
            //Attendre que le boutton 'Generate' devient actif       
            Get_WinSwitchBlock_BtnGenerate().WaitProperty("Enabled", true, waitTimeShort);          
            StopWatchObj.Stop();
            
            //Fermer la fenêtre d'information
            if(Get_DlgInformation().Exists) 
                  Get_DlgInformation_BtnOK().Click();            

            // Écrire le résultat dans le fichier excel
            var SoughtForValue = "Performance_ORC_Over16000Accounts_BtnPreview";
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
                         
            Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", securityNBN1280], 10).WaitProperty("IsLoaded", true, waitTimeShort);
            StopWatchObj.Stop();
            
            // Écrit le résultat dans le fichier excel
            SoughtForValue = "Performance_ORC_Over16000Accounts_BtnGenerate";
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());              
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 3: Supprimer les ordres, Supprimer le critère de recherche");
            
            //Supprimer les ordres
            Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", securityNBN1280], 10).Click();
            Get_OrderAccumulatorGrid().Keys("^a");
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
