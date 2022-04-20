//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_271_Rebalance_Account_WithInactiveModel
//USEUNIT CR1452_264_BlockedRestriction
//USEUNIT CR1452_2611_BlockedRestriction_Model
//USEUNIT DBA

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function CR1452_2622_NonBlockedRestrictionModel_BlockedRestrictionAccount()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800236NA", language+client);
        var modelCR1075_MOD1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_MOD1", language+client);        
        var restriction = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Restriction_CR1452_2622", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var message1= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message1_CR1452_2622", language+client); 
        var message2= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message2_CR1452_2622", language+client); 
        var message = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_2622", language+client);         
        var cmbSeverityHard = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CmbSeverityHard", language+client);
        var severityHard = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SeverityHard", language+client);       
        var security = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_BCE", language+client);
        var percentageOfTotalValueMin=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageOfTotalValueMSFTMin", language+client);
        var percentageOfTotalValueMax=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageOfTotalValueMSFTMAx", language+client);
           
        Login(vServerSleeves, user, psw, language);      
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(account);   
        
        //ajouter une restriction 
        Get_RelationshipsAccountsBar_BtnRestrictions().Click();
        AddRestriction(security,percentageOfTotalValueMin,percentageOfTotalValueMax)
        Get_RelationshipsAccountsBar_BtnRestrictions().Click();
        EditRestriction(restriction,cmbSeverityHard,severityHard);
                   
        Get_ModulesBar_BtnModels().Click();           
        SearchModelByName(modelCR1075_MOD1); 

         //cliquer sur 'Rééquilibrer'
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_DlgConfirmation().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        var width =  Get_DlgConfirmation().Get_Width();
        //Get_DlgWarning().Click((width*(1/4)),73); //CP : Changé pour CO
        Get_DlgConfirmation().Click((width*(1/4)),73); //CP : Changé la ligne précédente pour CO
        
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();       
        // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        
        //Aucun ordre ne devrait s'afficher
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0");   
        
        //Cliquer sur le btn Grouper
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0");
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
      
        //Validation du  Message(s) du rééquilibrage
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblDescriptionMsg(), "WPFControlText", cmpContains, message);        
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpContains, message1);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg(), "WPFControlText", cmpContains, message2);
        
        Get_WinRebalance_BtnClose().Click();       
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
          
        //Remettre les données 
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(account); 
        Get_RelationshipsAccountsBar_BtnRestrictions().Click();   
        DeleteRestriction(restriction);
                     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);  
         //Remettre les données 
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(account); 
        Get_RelationshipsAccountsBar_BtnRestrictions().Click();   
        DeleteRestriction(restriction);

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}