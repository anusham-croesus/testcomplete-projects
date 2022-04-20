//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition
//USEUNIT CR1452_2514_RebalancingAccount
//USEUNIT DBA


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_2515_RebalancingAllSleeves()
{
    try{  
    
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","YES",vServerSleeves)   
        RestartServices(vServerSleeves)
                     
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_NONRACHETABLE2", language+client);                
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800241JW", language+client); 
        var unallocated=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client);
        var securityPOW = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_POW", language+client);
        var sleeveAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCR1452_2514", language+client); 
        var target =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Target2514", language+client);        
        var messageAccount =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MessageAccount_2515", language+client);
        var messageAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "MessageAdhoc_2515", language+client);
        var errorMessage=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ErrorMessage", language+client);
                                         
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        
        ChangeNonRedeemable(securityPOW,true);
        //Pour rafraîchir les données   
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());       
        //Valider que la position est non-rachetable
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityPOW,10).DataContext.DataItem, "IsBlockedSecurity", cmpEqual,true);
           
        //convertir le compte en UMA 
        Get_PortfolioBar_BtnSleeves().Click();
        Get_WinManagerSleeves().Parent.Maximize();                                 
        //Ajouter un segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",target,"","",modelName)
                                                
        //transférer POW au segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",unallocated,100).Click();  
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Find("Value",securityPOW,10).Click();                
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();         
        Get_WinMoveSecurities_CmbToSleeve().Keys(sleeveAdhoc);         
        Get_WinMoveSecurities_BtnOk().Click();
        Get_WinManagerSleeves_BtnSave().Click();
        Delay(1500);
                                                                 
        //Rééquilibrer  tous les segments
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click(); 
                                                  
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();       
        // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        //Valider que le message ne contient pas le mot erreur     
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpNotContains, errorMessage);                
        /*Validation: Au niveau du compte:  232$ et qu'il y a eu une exclusion (ou exclusion) de 5500$ de POW.*/          
        var messageAc = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(messageAc,cmpContains, messageAccount)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
        Log.Error("Les valeurs ne sont pas bonnes ")
        }
        
        /*Au niveau du segment Adh:valeur = 0$ exclusion = 5500$ CAD de POW*/  
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc,10).Click(); 
        //Valider que le message ne contient pas le mot erreur     
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpNotContains, errorMessage); 
        //Validation du message         
        var messageAh = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(messageAh,cmpContains, messageAdhoc)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
        Log.Error("Les valeurs ne sont pas bonnes ")
        }
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les donnée*********************************************************    
        ResetData(account,securityPOW);       
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
        ResetData(account,securityPOW);

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","NO",vServerSleeves)   
      RestartServices(vServerSleeves)
    }
}

