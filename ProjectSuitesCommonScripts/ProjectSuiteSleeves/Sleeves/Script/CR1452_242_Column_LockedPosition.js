//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_242_Column_LockedPosition()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");   
        var filter=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client); 
        var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);    
        var account= GetData(filePath_Sleeves, "DataPool_WithModel", 2); //800045-FS
        var columnLockedPosition= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChLockedPosition", language+client);
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        // sélectionner plusieurs comptes UMA
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click()
        Get_SubMenus().WPFObject("ContextMenu", "", 1).Find("WPFControlText",filter).Click();        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();  
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
             
        // Grouper par segments, sélectionner quelques segments et cliquer sur 'Rééquilibrer'  
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Set_Text(assetAllocation);      
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        
        // Cliquer sur le bouton 'Segment'
        Get_PortfolioBar_BtnSleeves().Click();
        Get_WinManagerSleeves().Parent.Maximize();
        var columnExists =Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Find(["ClrClassName","WPFControlText"],["LabelPresenter",columnLockedPosition],10).Exists
        if(columnExists){
          Log.Checkpoint("la colonne" +columnLockedPosition +" existe par défaut ")
        } 
        else{
          Log.Error("la colonne " + columnLockedPosition +" n'existe pas par défaut ")
        } 
       Get_WinManagerSleeves_BtnCancel().Click();

       Get_ModulesBar_BtnAccounts().Click();
       //Annuler le filtre   
       if(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists){
          var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
          Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13)
       }            
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        //Annuler le filtre 
        if(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists){
           var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
           Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13)
        }        
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}


