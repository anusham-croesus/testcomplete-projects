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


function CR1452_214_Rebalance_All_Segments()
{
    try{   
           
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        
        var account1= GetData(filePath_Sleeves, "DataPool_WithModel", 3); //800045-FS
        var account2= GetData(filePath_Sleeves, "DataPool_WithModel", 4); //800291-GT
        var account3= GetData(filePath_Sleeves, "DataPool_WithModel", 5); //800022-HU
        var filter=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        // sélectionner plusieurs comptes UMA
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click()
        Get_SubMenus().WPFObject("ContextMenu", "", 1).Find("WPFControlText",filter).Click();
        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click();
        Get_RelationshipsClientsAccountsGrid().Find("Value",account2,10).Click(10,10,skCtrl);
        Get_RelationshipsClientsAccountsGrid().Find("Value",account3,10).Click(10,10,skCtrl);
        
        // cliquer sur 'Rééquilibrer' et sélectionner la méthode 'Rééquilibrer tous les segments'.
        Get_Toolbar_BtnRebalance().Click();
        if(!Get_WinRebalancingMethod().Exists){
          Get_Toolbar_BtnRebalance().Click();
        } 
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click();
        Get_WinRebalance().Parent.Maximize(); 
        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();
        
        //Les colonnes qui s'affichent au premier niveau 
        CheckColumnsStep2();
              
        var isChecked=Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll().IsChecked;
        if(isChecked==true){
            Log.Checkpoint("Le bouton 'Sélectionner tout' est actif")
            var count=Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Items.Count
            
            for (var i=1; i<=count;i++){
              //Les comptes sélectionnés s'affichent correctement dans l'écran 'Portefeuilles à rééquilibrer'.
              aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i), "IsSelected", cmpEqual, true);
              aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).DataContext.DataItem, "Id", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account_"+ i, language+client));
              
            } 
        } 
        else{        
          Log.Error("Le bouton 'Sélectionner tout' est actif")
        } 
         
        //Annuler la sélection              
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll().Click();
        Get_WinRebalance().Refresh();
            
        var isChecked=Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll().IsChecked;
        if(isChecked==true){
           Log.Error("Le bouton 'Sélectionner tout' est actif")
        }
        else{             
           for (var i=1; i<=count;i++){
              aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i), "IsSelected", cmpEqual, false);
            } 
        }
        
        //On peut sélectionner un ou plusieurs comptes   
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", account1,10).Click();
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value",account2,10).Click(10,10,skCtrl); 
        aqObject.CheckProperty( Get_WinRebalance_LblSelectedItems(), "Content", cmpContains, "2"); 

        
        //************************************************************************CR1452_215********************************************************************** 
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true) 
        Get_WinRebalance().Refresh();
        
        //Validation des colonnes +
        CheckColumnsStep2AfterExpand();
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalancePlus_ChCashMgmt().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChCashMgmt", language+client));
        
        //Fermer la fenêtre de rééquilibrage
        Get_WinRebalance_BtnClose().Click();
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
