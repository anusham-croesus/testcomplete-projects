//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_2811_CashManagement_USAccount

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_2812_RebalanceCROES3112()
{
    try{              
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");       
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account_2", language+client);
        var cashMgmtCheck= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Get_WinCashManagement_CashMgmtCheck1", language+client);
        var sleeveDescription=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveCanadianEquity", language+client); 
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        //sélectionner un compte 
        Search_Account(account);        
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();
        
         // cliquer sur 'Rééquilibrer' et sélectionner la méthode 'Rééquilibrer tous les segments'.
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
        
        // retourner à l'étape précédente 2
        Get_WinRebalance_BtnPrevious().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_7456"); 
        
        //cliquer sur le bouton 'Gestion encaisse', mettre une valeur pour un des segments et ok
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();                  
        ChangeCashMgmt(sleeveDescription,cashMgmtCheck);
        Get_WinCashManagement_BtnOk().Click();
        Log.Message("L'anomalie présente sur CX: CROES-7848")     
        
        //Validation
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveDescription,10).Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveDescription,10).DataContext.DataItem, "DepositWithdrawalAmount", cmpEqual, cashMgmtCheck);   
        
        Get_WinRebalance_BtnClose().Click();   
                                   
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
    }
    finally {    
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}