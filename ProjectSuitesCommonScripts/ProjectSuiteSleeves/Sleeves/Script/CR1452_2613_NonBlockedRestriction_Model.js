//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_271_Rebalance_Account_WithInactiveModel
//USEUNIT CR1452_264_BlockedRestriction
//USEUNIT CR1452_2611_BlockedRestriction_Model


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_2613_NonBlockedRestriction_Model()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800236NA", language+client);
        var modelCR1075_MOD1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_MOD1", language+client);        
        var cmbSeverityHard = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CmbSeverityHard", language+client);
        var severityHard = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SeverityHard", language+client);
        var restriction = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Restriction_CR1452_2611", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        
        var sleeveLongTerm=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
        var sleeveAmericanEquity=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinEditSleeveCmbAssetClassAmericanEquity", language+client);
        
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_2611", language+client);
        var modelNumber=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelNumber", language+client);
            
        Login(vServerSleeves, user, psw, language);                               
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account);
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click(); 
        
        //cliquer sur 'Rééquilibrer'
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
        //Validation
        CheckPoints(cmpNotEqual,message,modelNumber)
              
        //************************************************************************CR1452_2612********************************************************************** 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
      
        //Valider que pour le segment sans restriction, le message ne s’affiche pas. 
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveLongTerm,10).Click();       
        if(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblDescriptionMsg().Exists){
         Log.Error("Un message bloquant s’affiche pour ce segment.On ne devrait pas avoir un message bloquant pour ce segment")
        }
        else{
         Log.Checkpoint("On ne devrait pas avoir un message bloquant pour ce segment")
        } 
       
        //Valider que pour le segment qui a une restriction, le message s’affiche.        
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAmericanEquity,10).Click();        
        //Validation
        CheckPoints(cmpEqual,message,modelNumber);
              
        //***********************************************************************************************************************************************************
        
        Get_WinRebalance_BtnClose().Click();       
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
                                       
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