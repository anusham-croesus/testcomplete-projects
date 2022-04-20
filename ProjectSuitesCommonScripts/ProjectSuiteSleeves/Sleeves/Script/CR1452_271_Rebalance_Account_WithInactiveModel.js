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


function CR1452_271_Rebalance_Account_WithInactiveModel()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
        var account= GetData(filePath_Sleeves, "DataPool_WithModel", 8); //800040-RE
        var columnLockedPosition= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChLockedPosition", language+client);   
        var message= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_271", language+client); 
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        //rendre le modèle inactif
        ActivateDeactivateModel(model,false)
        
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account)
         // cliquer sur 'Rééquilibrer' et sélectionner la méthode ''Rééquilibrer le compte'.
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
        
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",account,10).Click()
        //valider qu'il n'y pas a d'orders 
         aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0"); 
         //Validation du message 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpEqual, message);
        
        Get_WinRebalance_BtnClose().Click(); 
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
        
        //Réinitialiser les données 
        Get_ModulesBar_BtnModels().Click();
        //rendre le modèle actif
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

function ActivateDeactivateModel(model,boolean){
    Get_ModelsGrid().Find("Value",model,10).Click()
    Get_ModelsBar_BtnInfo().Click();
    Get_WinModelInfo_GrpModel_ChkActive().set_IsChecked(boolean);
    Get_WinModelInfo_BtnOK().Click();                              
} 
