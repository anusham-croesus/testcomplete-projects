//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_271_Rebalance_Account_WithInactiveModel

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_278_Rebalance_WithInactiveModel()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
        var account= GetData(filePath_Sleeves, "DataPool_WithModel", 3); //800045-FS
        var columnLockedPosition= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChLockedPosition", language+client);   
        var message= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_271", language+client);
        var sleeveLongTerm=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        //rendre le modèle inactif
        ActivateDeactivateModel(model,false)
                
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account);        
        // cliquer sur 'Rééquilibrer tous les segments'
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
        
        //Validation du message 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpEqual, message);
        //Validation du (infobulle)
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().Find(["ClrClassName","WPFControlOrdinalNo"],["CellValuePresenter","2"],10).DataContext.DataItem, "RebalanceMessage", cmpEqual, message);
        
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveLongTerm,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0");
        
        if(client=="RJ"){
             if(language=="french"){ //Le fichier Excel n’a pas fonctionné dans ce cas 
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual,   "Un ou plusieurs modèles ou sous-modèles visés par cette opération sont inactifs:\r\nCH LONG TERM, ~M-00009-0\r\n\r\nIl est donc impossible de les rééquilibrer.");
              //Validation du (infobulle)
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Find("Value",sleeveLongTerm,10).DataContext.DataItem, "RebalanceMessage", cmpEqual,   "Un ou plusieurs modèles ou sous-modèles visés par cette opération sont inactifs:\r\nCH LONG TERM, ~M-00009-0\r\n\r\nIl est donc impossible de les rééquilibrer.");
            }
            else{
               aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual,  "One or more models or sub-models involved in this operation are inactive:\r\nCH LONG TERM, ~M-00009-0\r\n\r\nIt is therefore impossible to rebalance.");
              //Validation du (infobulle)
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Find("Value",sleeveLongTerm,10).DataContext.DataItem, "RebalanceMessage", cmpEqual, "One or more models or sub-models involved in this operation are inactive:\r\nCH LONG TERM, ~M-00009-0\r\n\r\nIt is therefore impossible to rebalance.");
            }
        }else{
            if(language=="french"){ //Le fichier Excel n’a pas fonctionné dans ce cas 
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual,   "Un ou plusieurs modèles ou sous-modèles visés par cette opération sont inactifs:\r\nCH LONG TERM, ~M-00005-0\r\n\r\nIl est donc impossible de les rééquilibrer.");
              //Validation du (infobulle)
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Find("Value",sleeveLongTerm,10).DataContext.DataItem, "RebalanceMessage", cmpEqual,   "Un ou plusieurs modèles ou sous-modèles visés par cette opération sont inactifs:\r\nCH LONG TERM, ~M-00005-0\r\n\r\nIl est donc impossible de les rééquilibrer.");
            }
            else{
               aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpEqual,  "One or more models or sub-models involved in this operation are inactive:\r\nCH LONG TERM, ~M-00005-0\r\n\r\nIt is therefore impossible to rebalance.");
              //Validation du (infobulle)
              aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Find("Value",sleeveLongTerm,10).DataContext.DataItem, "RebalanceMessage", cmpEqual, "One or more models or sub-models involved in this operation are inactive:\r\nCH LONG TERM, ~M-00005-0\r\n\r\nIt is therefore impossible to rebalance.");
            }
        }
        
        
        
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
        
        //Réinitialiser les données 
        //rendre le modèle actif
        Get_ModulesBar_BtnModels().Click();
        ActivateDeactivateModel(model,true)
                     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        //Réinitialiser les données 
        //rendre le modèle actif
        ActivateDeactivateModel(model,true)
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}