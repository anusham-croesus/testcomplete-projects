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
//USEUNIT CR1452_2811_CashManagement_USAccount
//USEUNIT CR1452_222_RebalancingAllSleeves
//USEUNIT DBA


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_223_RebalancingAccount()
{
    try{       
                     
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_800214GT", language+client);          
        var sleeveAdhoc= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescription1CR1452_223", language+client); 
        var targetAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetSleeveAdhoc_223", language+client);
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800214JW", language+client); 
        var securityQ70791 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecurityQ70791", language+client);
        var sleeveCash =ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCash", language+client);
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderTypeSell", language+client);
        var quantityQ70791=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityQ70791", language+client);
        var securitySymbolQ70791=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecuritySymbolQ70791", language+client);         
                                       
        Login(vServerSleeves, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        
        //convertir le compte en UMA 
        CreateSleeveByAssetClass();  
                                               
        //Ajouter un segment Adhoc
        Get_PortfolioBar_BtnSleeves().Click(); 
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",targetAdhoc,"","",modelName) 
        CheckThatModelBindedToSleeve( sleeveAdhoc,modelName)      
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
        
        //Vérifier les ordres et s'assurer qu'aucun ordre ne s'en va sur le marché pour le titre St-Sauveur mais qu'il y en a d'autres ordres pour autres titres
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpNotEqual, "0");
        CheckPresenceOfPosition(securitySymbolQ70791);        
        //Cliquer sur le btn Grouper        
        CheckPresenceOfPositionbtBlock(securitySymbolQ70791);
        Log.Message( "Anomalie: aucun ordre ne devrait s'afficher dans ce niveau") 
                                    
        /* Sleeve encaisse: ordre de vente St-Sauveur -18000; */
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveCash,10).Click();  
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securitySymbolQ70791,10).DataContext.DataItem, "orderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securitySymbolQ70791,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityQ70791);  
        
        /*Sleeve Adhoc ordre de achat St-Sauveur 18000*/
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc,10).Click();  
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securitySymbolQ70791,10).DataContext.DataItem, "orderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securitySymbolQ70791,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityQ70791); 
         
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
              
        //*************************************************Réinitialiser les données*********************************************************  
        Get_ModulesBar_BtnPortfolio().Click()
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
        //Supprimer des segments 
        Get_ModulesBar_BtnPortfolio().Click()
        Delete_AllSleeves_WinSleevesManager();

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}


