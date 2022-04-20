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


function CR1452_243_Column_LockedPosition()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");   
        var filter=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client); 
        var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);    
        var account= GetData(filePath_Sleeves, "DataPool_WithModel",10); //800286-SF
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
        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();  
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
        if(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists){
           var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
           Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13)
        }        
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

 
