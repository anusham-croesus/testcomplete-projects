//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_2418_RebalancingAccount_WithModel()
{
    try{
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","YES",vServerSleeves)   
        RestartServices(vServerSleeves)
                         
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_TESTREEQ2", language+client);
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800049RE", language+client);       
        var positionTD =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PositionTD", language+client);  
        var target=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetAdhoc_2418", language+client); 
        var adhocSleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_2416", language+client);
        var unallocated =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client); 
        
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
        
        //b) Transférer la quantité de TD du segment Adhoc vers Non-attribués
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",adhocSleeveDescription,100).Click();         
        if(!Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",positionTD,10).Exists){
          Scroll();  
        } 
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",positionTD,10).Click(); 
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();                    
        Get_WinMoveSecurities_CmbToSleeve().Keys(unallocated);
        Get_WinMoveSecurities_BtnOk().Click();       
        Get_WinManagerSleeves_BtnSave().Click();       
        Delay(1500) 
        
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
               		              
        /*Validation: aucun ordre pour la position bloquée à partir du segment 'Non-attribués', */
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",unallocated,10).Click(); 
                       
        //aucun ordre pour la position bloquée à partir du segment 'Non-attribués'        
        CheckPresenceOfPosition(positionTD);
        
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les donnée*********************************************************
        ResetData(account,positionTD);           
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
        ResetData(account,positionTD);
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","NO",vServerSleeves)   
      RestartServices(vServerSleeves)
    }
}


function ResetData(account,positionTD){
       
      //*********************************************Réinitialiser les données*******************************************************
      //Débloquer la position    
      Search_Position(positionTD)
      Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionTD),10).ClickR();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
      Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
      aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionTD,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
         
      //Supprimer des segments 
      Get_ModulesBar_BtnPortfolio().Click()
      Delete_AllSleeves_WinSleevesManager();
}

function Scroll()
{
  var ControlWidth=Get_WinManagerSleeves_GrpUnderlyingSecurities().get_ActualWidth()
  var ControlHeight=Get_WinManagerSleeves_GrpUnderlyingSecurities().get_ActualHeight()
  Get_WinManagerSleeves_GrpUnderlyingSecurities().Click(ControlWidth-5, ControlHeight-25)
}