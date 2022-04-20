//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Correspond au jira Croes-9918 CLONE - Transaction de correction incohérente dans le compte 7N8162A
    
    Lien sur TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6603
    Lien sur Jira : https://jira.croesus.com/browse/CROES-9918
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-19
*/

function CROES_6531_RebalancingAnAccount_withMultipleSegmentsAndCashManagement()
{
    try {
                
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "DARWIC", "username");
        var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw");
        
        var account300001NA = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Anomalies", "Account300001NA", language+client);        
        var securityTML204 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Anomalies", "SecurityTML204", language+client);        
        var security986031 = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Anomalies", "Security986031", language+client);        
        var positionQuantity = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Anomalies", "PositionQuantity_6603", language+client); //1017831       
        var assetClassCashEquivalents = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "Anomalies", "AssetClassCashEquivalents", language+client); //Encaisse/quasi-espèces //Cash & Cash Equivalents       
        
              
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6603","Cas de test TestLink : Croes-6603")
        Log.Link("https://jira.croesus.com/browse/CROES-9918","Lien sur Jira : CROES-9918")
        
        Log.Message("** Rouler la requête SQL et valider que la quantity pour le compte "+account300001NA+"la position "+security986031+" est = "+positionQuantity)
        var detectedQuantity = Execute_SQLQuery_GetField("select QUANTITE from b_portef where no_compte = '"+account300001NA+"' and security in (select security from b_titre where secufirme = '"+security986031+"')", vServerTransactions, "QUANTITE")       
        CheckEquals(detectedQuantity,positionQuantity,"Position quantity");
                
        //Login
        Log.Message("************************************** Login *********************************************")
        Login(vServerTransactions, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
        
        //Mailler le compte 300001-NA vers module Portefeuille 
        Log.Message("** Mailler le compte "+account300001NA+" vers module Portefeuille") 
        Search_Account(account300001NA);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account300001NA,10), Get_ModulesBar_BtnPortfolio());
        
        Log.Message("** Cliquer sur Par classe d'actifs")
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["DataGrid_67cd","true"]);
        
        Log.Message("** Exploser l'asset classe "+assetClassCashEquivalents+" et sélectionner le titre "+securityTML204+" et faire un Right click")
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",assetClassCashEquivalents,10).Click();
        var index = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",assetClassCashEquivalents,10).DataContext.Index;
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true);                
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityTML204,10).ClickR(); 
        
        Log.Message("** Cliquer sur Gérer Proj. Liquidités --> Exclure de la projection de liquidités")
        Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome().Click();
        Get_PortfolioGrid_ContextualMenu_ManageProjectedIncome_ExcludeFromProjectedIncome().Click();
        
        Log.Message("** Refaire la requête SQL et valider que la quantity pour le compte "+account300001NA+"la position "+security986031+" est = "+positionQuantity)
        var detectedQuantity = Execute_SQLQuery_GetField("select QUANTITE from b_portef where no_compte = '"+account300001NA+"' and security in (select security from b_titre where secufirme = '"+security986031+"')", vServerTransactions, "QUANTITE")       
        CheckEquals(detectedQuantity,positionQuantity,"Position quantity");
        
        Log.Message("Toujours sur le même titre TML204 et faire un Right click -- Cliquer sur  Gérer les positions bloquées --> Bloquer la position")        
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityTML204,10).ClickR(); 
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        Log.Message("** Refaire la requête SQL et valider que la quantity pour le compte "+account300001NA+"la position "+security986031+" est = "+positionQuantity)
        var detectedQuantity = Execute_SQLQuery_GetField("select QUANTITE from b_portef where no_compte = '"+account300001NA+"' and security in (select security from b_titre where secufirme = '"+security986031+"')", vServerTransactions, "QUANTITE")       
        CheckEquals(detectedQuantity,positionQuantity,"Position quantity");
        
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
    finally {
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();  
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        Runner.Stop(true)
    }
}


