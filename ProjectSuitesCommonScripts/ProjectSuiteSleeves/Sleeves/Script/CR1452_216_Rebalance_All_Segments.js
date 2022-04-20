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


function CR1452_216_Rebalance_All_Segments()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");
        
        var account= GetData(filePath_Sleeves, "DataPool_WithModel", 2); //800045-FS
        var filter=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client);
        var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);
        var sleeveLongTerm = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
        var SleeveCanadianEquity = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        // sélectionner plusieurs comptes UMA
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click()
        Get_SubMenus().WPFObject("ContextMenu", "", 1).Find("WPFControlText",filter).Click();        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();  
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
             
        // Grouper par segments, sélectionner quelques segments et cliquer sur 'Rééquilibrer'  
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Set_Text(assetAllocation);      
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
         
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",sleeveLongTerm,10).Click()
         Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",SleeveCanadianEquity,10).Click(10,10,skCtrl);       
        
        // cliquer sur 'Rééquilibrer' et sélectionner la méthode 'Rééquilibrer tous les segments'.
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceSelectedSleeves().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click();
        Get_WinRebalance().Parent.Maximize(); 
               
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();
               
        //Les colonnes qui s'affichent au premier niveau.
        CheckColumnsStep2();
              
        //Un seule compte UMA s'affiche      
        var isChecked=Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll().IsChecked;
        if(isChecked==true){
            Log.Checkpoint("Le bouton 'Sélectionner tout' est actif")
            var count=Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Items.Count
            
            if(count==1){
              for (var i=1; i<=count;i++){
                aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i), "IsSelected", cmpEqual, true);
                aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).DataContext.DataItem, "Id", cmpEqual, account);
              } 
            }
            else{
              Log.Error("Il y a plus qu’un compte")
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
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", account,10).Click();
        aqObject.CheckProperty( Get_WinRebalance_LblSelectedItems(), "Content", cmpContains, "1"); 
        
        //************************************************************************CR1452_217********************************************************************** 
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true) 
        Get_WinRebalance().Refresh();
        
        //Validation des colonnes +
        CheckColumnsStep2AfterExpand();
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalancePlus_ChCashMgmt().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChCashMgmt", language+client)); 
        aqObject.CheckProperty(  Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem, "Description", cmpEqual, sleeveLongTerm)     
        aqObject.CheckProperty(  Get_WinRebalance().FindChild("ClrClassName", "ExpandableFieldRecordPresenter", 100).WPFObject("RecordListControl", "", 1).Items.Item(2).DataItem, "Description", cmpEqual, SleeveCanadianEquity)  
        
        //Fermer la fenêtre de rééquilibrage
        Get_WinRebalance_BtnClose().Click();
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

