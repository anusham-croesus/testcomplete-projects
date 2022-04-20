//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
 Rééquilibrage d'un compte UMA qui est relié à un modèle qui ne détient pas la position bloquée du compte assigné. 
Méthode de rééquilibrage: Rééquilibrer le compte 

Analyste d'automatisation: Youlia Raisper */


function CR1452_2416_RebalancingAccount_BlockedPosition()
{
    try{ 
    
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","YES",vServerSleeves)   
        RestartServices(vServerSleeves)
                
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_TESTREEQ2", language+client);
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800086RE", language+client);
        var positionTD =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionTD", language+client);    
        var positionECA =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionECA", language+client);               
        var positionAEM =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionAEM", language+client);         
        var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Target_2416", language+client);        
        var positionCVE =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionCVE", language+client);
        var positionNA =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionNA", language+client); 
        var positionSAP =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionSAP", language+client); 
        var adhocSleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_2416", language+client);
        var quantityAEM= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityAEM", language+client); 
        var quantityNA= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityNA", language+client); 
        var quantitySAP= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantitySAP", language+client);         
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client); 
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_2416", language+client); 
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        //Sélectionner la position 'TD' et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(positionTD)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionTD),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Valider que la position est bloquée  
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionTD,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
        
        //Non rachetables :Car dans la BD, il y a deux positions Non rachetables pour lw compte utilisé dans le cas de test. Le cas demande de ne pas avoir les positions  Non rachetables.    
        ChangeNonRedeemable(positionECA,false)
        ChangeNonRedeemable(positionCVE,false)
        
        //Valider que non reedeemable a été enlevé
        Get_ModulesBar_BtnAccounts().Click()
        Search_Account(account);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        //chainer vers le module Portefeuille,
        Search_Position(positionECA)        
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionECA,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,false);
        Search_Position(positionCVE) 
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionCVE,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,false);
        
        //convertir le compte en UMA 
        Get_PortfolioBar_BtnSleeves().Click();           
        Get_WinManagerSleeves().Parent.Maximize(); 
        
        //ajouter un segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(adhocSleeveDescription,"",target,"","",model)   
        
        //Transférer toutes les positions du compte du segment Non-attribués vers le segment Adhoc
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Keys("^a"); 
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();
        
        Get_WinMoveSecurities_CmbToSleeve().Keys(adhocSleeveDescription);
        Get_WinMoveSecurities_BtnOk().Click();
        Get_WinManagerSleeves_BtnSave().Click(); 
        
        //Rééquilibrer le compte 
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
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        //Validation du message 
        var messageAccount = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(messageAccount,cmpContains, message)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
          Log.Error("Les valeurs ne sont pas bonnes ")
        }
              
        /*Validation: Achat Agnico: 550 (154418.66*1*0.2/56.1=550.51)
        Achat NA: 542 (154418.66*1*0.2/56.96=542.2)
        Achat Sap: 1083 (154418.66*1*0.2/28.5=1083.63)*/
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionAEM,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionAEM,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityAEM);
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionNA,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionNA,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityNA);
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionSAP,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionSAP,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantitySAP);
    
        CheckPresenceOfPosition(positionTD);
        
        //Cliquer sur le btn Grouper
        CheckPresenceOfPositionbtBlock(positionTD);
        
        Get_WinRebalance_BtnClose().Click();
        if (Get_DlgConfirmation().Exists) Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //if(Get_DlgWarning().Exists){ //CP : Changé pour CO
        //  var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //  Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
        //} //CP : Changé pour CO
        
        
        //*************************************************Réinitialiser les donnée*********************************************************
        ResetData2416(account,positionTD,positionECA,positionCVE);           
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
        ResetData2416(account,positionTD,positionECA,positionCVE);
    }
    finally {   
       Terminate_CroesusProcess(); //Fermer Croesus
       Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","NO",vServerSleeves)   
        RestartServices(vServerSleeves)
    }
}

function ChangeNonRedeemable(position,isChecked)
{
  Search_Position(position)
  Drag(Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(position),10), Get_ModulesBar_BtnSecurities());
  Get_SecuritiesBar_BtnInfo().Click();
  Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable().Set_IsChecked(isChecked);
  Get_WinInfoSecurity_BtnOK().Click(); 
  Get_ModulesBar_BtnPortfolio().Click();
  
} 

function ResetData2416(account,positionTD,positionECA,positionCVE){
       
    //*********************************************Réinitialiser les données*******************************************************
    //Débloquer la position    
    Search_Position(positionTD)
    Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionTD),10).ClickR();
    Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
    Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
    aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionTD,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
         
    //Remettre non reedeemable   
    ChangeNonRedeemable(positionECA,true)
    ChangeNonRedeemable(positionCVE,true)
                
    //Valider que non reedeemable a true
    Get_ModulesBar_BtnAccounts().Click()
    Search_Account(account);
    //chainer vers le module Portefeuille,           
    Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
    Search_Position(positionECA)   
    aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionECA,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,true);
    Search_Position(positionCVE)
    aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionCVE,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,true);
        
    //Supprimer des segments 
    Get_ModulesBar_BtnPortfolio().Click()
    Delete_AllSleeves_WinSleevesManager();
} 

function CheckPresenceOfPosition(position)
{
    Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Keys("F");
    WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(position);
    Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click()
        
    if(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",position,10).Exists){
      Log.Error("La position présente JIRA BNC-953")
    } else{
      Log.Checkpoint("La position ne présente pas")
    }
} 

function CheckPresenceOfPositionbtBlock(position)
{
    //Cliquer sur le btn Grouper
    Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
    Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().WaitProperty("IsEnabled",true,3000);
    //WaitObject(Get_CroesusApp(),"Uid", "");      
    Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Keys("F"); 
    WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(position);
    Get_WinQuickSearch_RdoSecuritySymbol().Set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click()
        
    if(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",position,10).Exists){
      Log.Error("La position présente : JIRA BNC-953")
    } else{
      Log.Checkpoint("La position ne présente pas")
    }         
    Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
} 
