//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_243_Column_LockedPosition

/* Description :Ce script regroupe les scripts :CR1452_241_Column_LockedPosition, CR1452_242_Column_LockedPosition, CR1452_243_Column_LockedPosition,
 CR1452_251_NonRedeemable, CR1452_253_NonRedeemable, CR1452_254_NonRedeemable
  Pour plus de details consulter le Fichier Excel 'Cas de test du CR1452 à automatiser
Analyste d'automatisation: Alhassane Diallo */



function CR1452_Validation_Column_LockedPosition_NonRedeemable()
{
    try{      
        
/*********************************************************Variables*****************************************************************/
        var user                 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");   
        var filter               = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client); 
        var assetAllocation      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);    
        var account              = GetData(filePath_Sleeves, "DataPool_WithModel", 2); //800045-FS
        var columnLockedPosition = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChLockedPosition", language+client);  
        var account1             = GetData(filePath_Sleeves, "DataPool_WithModel",10); //800286-SF
        var account2             = GetData(filePath_Sleeves, "DataPool_WithoutModel",7); //800054-FS
        var sleeveLongTerm       = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
        var position             = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionSymbol", language+client);
        var columnNonRedeemable  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_Portfolio_PositionsGrid_ChNonRedeemable", language+client);
       
        
        
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Etape 1: Se connecter avec GP1859'");

        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
         
//*********************************************************** CR1452_241_Column_LockedPosition: **************************************************************         
         
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Etape 2: CR1452_241_Column_LockedPosition:  Validation de la colonne Locked position'");

        // sélectionner plusieurs comptes UMA
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click()
        Get_SubMenus().WPFObject("ContextMenu", "", 1).Find("WPFControlText",filter).Click();        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();  
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        Get_Portfolio_AssetClassesGrid().Keys("[Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right]");           
    
         
        //Valider la presence de la colonne non rachetable
        Log.Message("Valider la presence de la colonne non rachetable")
        var columnNonRedeemableExists =Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find(["ClrClassName","WPFControlText"],["LabelPresenter",columnNonRedeemable],10).Exists
        if(columnNonRedeemableExists){
          Log.Checkpoint("la colonne" +columnNonRedeemableExists +" non rachetable existe par défaut ")
        } 
        else{
          Log.Error("la colonne " + columnNonRedeemableExists +"non rachetable n'existe pas par défaut ")
        }     
        // Grouper par segments, sélectionner quelques segments et cliquer sur 'Rééquilibrer'  
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Set_Text(assetAllocation);      
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        
        // exploser un segment
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).set_IsExpanded(true)
        Get_Portfolio_AssetClassesGrid().Keys("[Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right]");           
        var columnExists =Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).Find(["ClrClassName","WPFControlText"],["LabelPresenter",columnLockedPosition],10).Exists
        if(columnExists){
          Log.Checkpoint("la colonne" +columnLockedPosition +" existe par défaut ")
        } 
        else{
          Log.Error("la colonne " + columnLockedPosition +" n'existe pas par défaut ")
        } 
        
        //Validation de la colonne non rachetable
        Log.Message("Validation de la colonne non rachetable")
        if(columnNonRedeemableExists){
          Log.Checkpoint("la colonne" +columnNonRedeemableExists +" non rachetable existe par défaut ")
        } 
        else{
          Log.Error("la colonne " + columnNonRedeemableExists +" non rachetable n'existe pas par défaut ")
        }   
       

        Get_ModulesBar_BtnAccounts().Click();
        
//*********************************************************** CR1452_242_Column_LockedPosition: **************************************************************         
        
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Etape 3:CR1452_242_Column_LockedPosition Validation de la colonne Locked position'");
        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();  
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
             
        // Grouper par segments, sélectionner quelques segments   
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
        
         //Validation de la colonne non rachetable dans la fenetre gestionnaire de sleeve
        Log.Message("Validation de la colonne non rachetable dans la fenetre gestionnaire de sleeve")
        var columnNonRedeemableExists1 =Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Find(["ClrClassName","WPFControlText"],["LabelPresenter",columnNonRedeemable],10).Exists
        if(columnNonRedeemableExists){
          Log.Checkpoint("la colonne" +columnNonRedeemableExists +" existe par défaut ")
        } 
        else{
          Log.Error("la colonne " + columnNonRedeemableExists +" n'existe pas par défaut ")
        } 
       Get_WinManagerSleeves_BtnCancel().Click();

       Get_ModulesBar_BtnAccounts().Click();
       
      
//*********************************************************** CR1452_243_Column_LockedPosition: **************************************************************         

        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Etape 4: CR1452_241_Column_LockedPosition:  Validation de la colonne Locked position'");

        CR1452_243_Column_LockedPosition_Optimiser(account1);

        
        
//*********************************************************** Validation CR1452_245_Column_LockedPosition: **************************************************************         
          Get_ModulesBar_BtnAccounts().Click();
        CR1452_245_Column_LockedPosition(account2, assetAllocation, sleeveLongTerm, position)


         //Supprimer le filtre
        Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(1).Click();    
        
                         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        
        
        
        Get_ModulesBar_BtnAccounts().Click();
        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click();  
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(2).DataItem, "IsBlocked", cmpEqual,false);
        var positionsDesc=Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(2).DataItem.SecurityDescription 
        Get_Portfolio_AssetClassesGrid().FInd("Value",VarToString(positionsDesc),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();        
        //Valider que les positions ne sont pas  bloquées   
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(2).DataItem, "IsBlocked", cmpEqual,false);
        Get_ModulesBar_BtnAccounts().Click();
        //Annuler le filtre 
        Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(1).Click()
       
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}


function Scroll()
{
  var ControlWidth=Get_Portfolio_PositionsGrid().get_ActualWidth()
  var ControlHeight=Get_Portfolio_PositionsGrid().get_ActualHeight()
  for (i=1; i<=1; i++) {Get_Portfolio_PositionsGrid().Click(ControlWidth-40, ControlHeight-5)}
}



function CR1452_243_Column_LockedPosition_Optimiser(account1, columnLockedPosition){
    
        Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click();
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10), Get_ModulesBar_BtnPortfolio());
        
        
        
         //*************************************************************bloquer la position*****************************************************************
        //Valider que la position n'est pas bloquée   
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(2).DataItem, "IsBlocked", cmpEqual,false);
        var positionsDesc=Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(2).DataItem.SecurityDescription 
         
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionsDesc),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Valider que les positions sont bloquées   
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(2).DataItem, "IsBlocked", cmpEqual,true);
        //*************************************************************************************************************************************************
              
        // cliquer sur 'Rééquilibrer' et sélectionner la méthode 'Rééquilibrer le compte'.
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click();
        
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();       
        // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();  
        //Delay(2500);  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation    
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
        var columnExists =Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find(["ClrClassName","WPFControlText"],["LabelPresenter",columnLockedPosition],10).Exists
        if(columnExists){
          Log.Checkpoint("la colonne" +columnLockedPosition +" existe par défaut ")
        } 
        else{
          Log.Error("la colonne " + columnLockedPosition +" n'existe pas par défaut ")
        } 
       Get_WinRebalance_BtnClose().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
       
       //*********************************************************** Remettre les données **************************************************************         
       Get_Portfolio_AssetClassesGrid().FInd("Value",VarToString(positionsDesc),10).ClickR();
       Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
       Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
        
       //Valider que les positions ne sont pas  bloquées   
       aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Items.Item(2).DataItem, "IsBlocked", cmpEqual,false);
       
       Get_ModulesBar_BtnAccounts().Click();

}


function CR1452_245_Column_LockedPosition(account2, assetAllocation, sleeveLongTerm, position){
    

        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");   
        var filter=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client); 
        var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);    
        var account2= GetData(filePath_Sleeves, "DataPool_WithoutModel",7); //800054-FS
        var columnLockedPosition= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChLockedPosition", language+client);
        var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);
        var sleeveLongTerm = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
        var position= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionSymbol", language+client);
        
        // sélectionner plusieurs comptes UMA        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account2,10).Click();  
        // chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account2,10), Get_ModulesBar_BtnPortfolio());
        
        // Grouper par segments, sélectionner quelques segments et cliquer sur 'Rééquilibrer'  
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Set_Text(assetAllocation);      
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        
        var index = Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",sleeveLongTerm,10).DataContext.Index
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true); 
        
        //*************************************************************Validations *****************************************************************        
        //Clic droit
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 4).Find("Value",position,10).ClickR();  
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        //Valider que le btn positions bloquées n''est pas disponible 
        aqObject.CheckProperty(Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition(), "IsEnabled", cmpEqual,false);
        
        //Info
        //Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 4).Find("Value",position,10).Click();
        Get_PortfolioBar_BtnInfo().Click();
        aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkLockedPosition(), "IsEnabled", cmpEqual,false);
        Get_WinPositionInfo_BtnCancel().Click();
        //*************************************************************************************************************************************************
        //*********************************************************** Remettre les données ****************************************************************
        Get_ModulesBar_BtnAccounts().Click();
                      
}