//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA

 /* Description :Ce script regroupe les scripts :CR1452_211_Rebalancing_Account, CR1452_214_Rebalance_All_Segments, CR1452_216_Rebalance_All_Segments et CR1452_218_Rebalance_Model
  Pour plus de details consulter le Fichier Excel 'Cas de test du CR1452 à automatiser
Analyste d'automatisation: Alhassane Diallo */


function CR1452_211_214_215_218_Rebalancing_Sleeves_WithAllMethodes()
{
    try{   
        
    
    /*******************************************Variables********************************************************/
    
        
        //Variables  CR1452_214_Rebalance_All_Segments et CR1452_211_Rebalancing_Account
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");        
        var account1= GetData(filePath_Sleeves, "DataPool_WithModel", 3); //800045-FS
        var account2= GetData(filePath_Sleeves, "DataPool_WithModel", 4); //800291-GT
        var account3= GetData(filePath_Sleeves, "DataPool_WithModel", 5); //800022-HU
        var filter=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client);
        var filter=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client);
       
        //Variables  CR1452_216_Rebalance_All_Segments
        var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);
        var sleeveLongTerm = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
        var SleeveCanadianEquity = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
        
        //Variables CR1452_218_Rebalance_Model
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
        var account= GetData(filePath_Sleeves, "DataPool_WithModel", 8); //800040-RE
        var columnLockedPosition= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChLockedPosition", language+client);   
        
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Etape 1:Se connecter à croesus avec le user GP1859 ");

        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        // sélectionner plusieurs comptes UMA
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click()
        Get_SubMenus().WPFObject("ContextMenu", "", 1).Find("WPFControlText",filter).Click();

        //Selectionner les trois comptes 
        select_Accounts(account1,account2,account3 );
        
/****************************************Validation du script CR1452_211_Rebalancing_Account**************************************/        
        
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Etape 2: Validation du script CR1452_211_Rebalancing_Account 'Rééquilibrer le compte'");

        
        
        // cliquer sur 'Rééquilibrer' et sélectionner la méthode 'Rééquilibrer le compte'.
        Get_Toolbar_BtnRebalance().Click();
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click();
        Get_WinRebalance().Parent.Maximize(); 
        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();
        
        //C) Les colonnes qui s'affichent à ce niveau.
        CheckColumnsStep2();
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChCashMgmt().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChCashMgmt", language+client));
        
        //B) On peut sélectionner un ou plusieurs comptes        
        var isChecked=Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll().IsChecked;
        if(isChecked==true){
            Log.Checkpoint("Le bouton 'Sélectionner tout' est actif")
            var count=Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Items.Count
            
            for (var i=1; i<=count;i++){
              //A) Les comptes sélectionnés s'affichent correctement dans l'écran 'Portefeuilles à rééquilibrer'.
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
        //Sélectionner 2 comptes 
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", account1,10).Click();
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value",account2,10).Click(10,10,skCtrl); 
        aqObject.CheckProperty( Get_WinRebalance_LblSelectedItems(), "Content", cmpContains, "2"); 

        
        //************************************************************************CR1452_212********************************************************************** 
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true) 
        Get_WinRebalance().Refresh();
        CheckColumnsStep2AfterExpand();
        
        //Fermer la fenêtre de rééquilibrage
        Get_WinRebalance_BtnClose().Click();
      
/****************************************Validation du script CR1452_211_Rebalancing_Account**************************************/        
        
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Etape 3: Validation du script CR1452_214_Rebalance_All_Segments 'Rééquilibrer tous les segments' ");        
        
       

        //Selectionner les trois comptes 
        select_Accounts(account1,account2,account3 )
        
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
       
/****************************************Validation du script CR1452_216_Rebalance_All_Segments**************************************/        
        
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Etape 4: Validation du script CR1452_216_Rebalance_All_Segments 'Grouper par segments, sélectionner quelques segments et cliquer sur 'Rééquilibrer' ");        
                  
        Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click();  
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10), Get_ModulesBar_BtnPortfolio());
             
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
                aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).DataContext.DataItem, "Id", cmpEqual, account1);
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
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value", account1,10).Click();
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
        Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(1).Click() 
        
        
/********************************************Validation du script CR1452_218_Rebalance_Model********************************************/        
 
        
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Etape 5: Validation du script CR1452_218_Rebalance_Model 'Rééquilibrer le modele' ");        
         
        
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        
        SearchModelByName(model)
        Get_ModelsGrid().Find("Value",model,10).Click()
                                    
        // cliquer sur 'Rééquilibrer' 
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalance().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
          
        CheckColumnsStep2();
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChSleeveDescription().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChSleeveDescription", language+client));
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChCashMgmt().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChCashMgmt", language+client));
        Get_WinRebalance_BtnClose().Click();     
  
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        //Annuler le filtre 
        Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(1).Click()

        
    }
    finally {    
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}


function CheckColumnsStep2(){
    
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChName().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChName", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChNumber().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChNumber", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChIACode().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChIACode", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChAssignedModel().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChAssignedModel", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChBalance().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChBalance", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChCurrency().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChCurrency", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChMargin().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChMargin", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChTotalValue().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChTotalValue", language+client));
} 

function CheckColumnsStep2AfterExpand(){
    
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChSleeveDescriptionPlus().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChSleeveDescription", language+client));
    Log.Message("CROES-8632")
    Log.Message("CROES-3484")
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChAssetAllocation().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChAssetAllocation", language+client)); //EM: 90-06-Be-17  datapool modifié selon le Jira CROES-3484 - avant "Répartition de l'actif"
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChMinPercent().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChMinPercent ", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChTargePercent().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChTargePercent ", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChMaxPercent().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChMaxPercent ", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChActualPercent().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChActualPercent ", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChModel().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChModel", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChMarketValue().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChMarketValue", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChCashBalance().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChCashBalance", language+client));
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChNoOfPositions().Content, "OleValue", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChNoOfPositions", language+client));
   
} 
function select_Accounts(compte1,compte2,compte3 ){
    

        Get_RelationshipsClientsAccountsGrid().Find("Value",compte1,10).Click();
        Get_RelationshipsClientsAccountsGrid().Find("Value",compte2,10).Click(10,10,skCtrl);
        Get_RelationshipsClientsAccountsGrid().Find("Value",compte3,10).Click(10,10,skCtrl);
        

}