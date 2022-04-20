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


function CR1452_274_Rebalance_SeveralAccounts_WithInactiveModel()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
        var account= GetData(filePath_Sleeves, "DataPool_WithModel", 8); //800040-RE
        var account1= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800060NA", language+client); //800060-NA
        var columnLockedPosition= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChLockedPosition", language+client);   
        var message= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_271", language+client); 
        var filter=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "filter_UnifiedManagedAccounts", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        //rendre le modèle inactif
        ActivateDeactivateModel(model,false)
                
        Get_ModulesBar_BtnAccounts().Click();
                
        // sélectionner plusieurs comptes UMA
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click()
        Get_SubMenus().WPFObject("ContextMenu", "", 1).Find("WPFControlText",filter).Click();
        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();
        Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click(10,10,skCtrl);
                         
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
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        //Le compte 800040-RE avec un modèle inactif
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",account,10).Click();
        //valider qu'il n'y a pas d'orders 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0"); 
                
        //Validation du message 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpEqual, message);
        //Validation du (infobulle)
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().Find("Value",account,10).DataContext.DataItem, "RebalanceMessage", cmpEqual, message);
        
        //Le compte avec un modèle actif
         Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",account1,10).Click();
        //valider qu'il y a des orders 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpNotEqual, "0");   
        //Validation du (infobulle)
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().Find("Value",account1,10).DataContext.DataItem, "RebalanceMessage", cmpEqual, null);      
        
        Get_WinRebalance_BtnClose().Click(); 
        
        if (Get_DlgConfirmation().Exists) Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //if(Get_DlgWarning().Exists){ //CP : Changé pour CO
        //  var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //  Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
        //} //CP : Changé pour CO
              
        //Réinitialiser les données 
        //Annuler le filtre
        Get_ModulesBar_BtnAccounts().Click(); 
        if(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists){
           var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
           Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13)
        } 
        //rendre le modèle actif
        Get_ModulesBar_BtnModels().Click();
        ActivateDeactivateModel(model,true)
                    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
         //Annuler le filtre
        Get_ModulesBar_BtnAccounts().Click(); 
        if(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists){
           var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
           Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-15, 13)
        } 
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