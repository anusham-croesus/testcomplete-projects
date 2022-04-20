﻿//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_271_Rebalance_Account_WithInactiveModel
//USEUNIT CR1452_264_BlockedRestriction

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
a) sélectionner le compte UMA (800060-NA), mettre la restriction bloquante
b) rééquilibrer un modèle assigné à l'un des segments du compte
Analyste d'automatisation: Youlia Raisper */


function CR1452_269_BlockedRestriction_RebalanceModel()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800060NA", language+client);
        var restriction = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Restriction_CR1452_264", language+client);
        var cmbSeverityHard = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CmbSeverityHard", language+client);
        var severityHard = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SeverityHard", language+client);
        var cmbSeveritySoft = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "CmbSeveritySoft", language+client);
        var severitySoft = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "severitySoft", language+client);
        var message = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_264", language+client);
        var modelTestRestriction=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelTestRestriction", language+client);
        var adhocSleeveDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinEditSleeveTxtSleeveDescription_For800060NA", language+client);
        
        Login(vServerSleeves, user, psw, language);      
        Get_ModulesBar_BtnAccounts().Click();
        
        Search_Account(account); 
        Get_RelationshipsAccountsBar_BtnRestrictions().Click();    
        EditRestriction(restriction,cmbSeverityHard,severityHard);
        
        //Aller au module modèle
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
          
        //rendre le modèle inactif
        SearchModelByName(modelTestRestriction)
                            
        // cliquer sur 'Rééquilibrer' et sélectionner la méthode 'Rééquilibrer le model'.
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalance().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }       
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();       
        // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();
        Get_WinRebalance_BtnNext().Click();      
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",adhocSleeveDescription,10).Click();         
        //Aucun ordre ne devrait s'afficher
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0");  
        
        //Cliquer sur le btn Grouper
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, "0");
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
       
        //Validation du  Message(s) du rééquilibrage
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblDescriptionMsg(), "WPFControlText", cmpContains, message);        
        
        Get_WinRebalance_BtnClose().Click();       
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
          
        //Remettre les données 
        Get_ModulesBar_BtnAccounts().Click();        
        Search_Account(account); 
        Get_RelationshipsAccountsBar_BtnRestrictions().Click();   
        EditRestriction(restriction,cmbSeveritySoft,severitySoft) 
                     
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
        EditRestriction(restriction,cmbSeveritySoft,severitySoft);
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}