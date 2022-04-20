//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_2410_Rebalancing_Message_BlockedPosition

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_2412_Rebalancing_Message_BlockedPosition()
{
    try{ 
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","YES",vServerSleeves)   
        RestartServices(vServerSleeves)
               
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800280RE", language+client);
        var positionTRP=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionTRP", language+client);
        var adhocSleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinEditSleeveTxtSleeveDescription_For800060NA", language+client);
        var modelCanadianEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelCanadianEqui", language+client);
        var sleeveCanadianEquity =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client);
        var percentageTRP = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageTRP", language+client);
        var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Target", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_2411", language+client);
        var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        //Sélectionner la position 'TRP' (Transcanada) et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(positionTRP)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionTRP),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Valider que les positions sont bloquées   
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionTRP,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
        
        //convertir le compte en UMA en créant tous les segments
        CreateSleeveByAssetClass();
        Get_PortfolioBar_BtnSleeves().Click();           
        Get_WinManagerSleeves().Parent.Maximize(); 
        
        //ajouter un segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(adhocSleeveDescription,"",target,"","","")   
        
        //Transférer 60% de TRP du segment 'Actions Canadiennes' vers le segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveCanadianEquity,100).Click();   
        Scroll(positionTRP);
        //Selectioner le TRP
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",positionTRP,10).Click();  
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();
        Get_WinMoveSecurities_CmbToSleeve().Keys(adhocSleeveDescription);
        Get_WinMoveSecurities_GrpSecurities_DgvListView().Items.Item(0).set_PercentageToMove(percentageTRP)                    
        Get_WinMoveSecurities().Click();
        Get_WinMoveSecurities_BtnOk().WaitProperty("IsEnabled",true,1500);
        Get_WinMoveSecurities_BtnOk().Click();
                  
        //Relier le modèle 'CH Canadian Equities' au segment Actions Canadiennes et mettre une cible 30% 
        SelectSleeveWinSleevesManager(sleeveCanadianEquity)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","",target,"","",modelCanadianEqui)            
        CheckThatModelBindedToSleeve(sleeveCanadianEquity,modelCanadianEqui)
                
        //Mettre une cible de 30% pour le segment Adhoc
        SelectSleeveWinSleevesManager(sleeveCanadianEquity)
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
        AddEditSleeveWinSleevesManager("","",target,"","","") 
        Get_WinManagerSleeves_BtnSave().Click();
        
        //Grouper par classe d'actifs
        //Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();  
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Set_Text(assetAllocation); 
        Delay(2000);         
        //sélectionner tous les regroupement
        Get_Portfolio_Tab(1).Click();
        Get_Portfolio_Tab(1).Keys("^a");    
                                                         
        //Rééquilibrer les segments sélectionnés
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
        // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        //Validation du message 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpContains, message);
        //Validation du (infobulle)
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().Find(["ClrClassName","WPFControlOrdinalNo"],["CellValuePresenter","2"],10).DataContext.DataItem, "RebalanceMessage", cmpContains, message);
       
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
        
        //Réinitialiser les données
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click(); 
        Search_Position(positionTRP)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionTRP),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionTRP,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
        //Supprimer des segments 
        Delete_AllSleeves_WinSleevesManager(); 
                    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        //Réinitialiser les données 
        Search_Position(positionTRP)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionTRP),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionTRP,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
        //Supprimer des segments 
        Delete_AllSleeves_WinSleevesManager();

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","NO",vServerSleeves)   
      RestartServices(vServerSleeves)
    }
}