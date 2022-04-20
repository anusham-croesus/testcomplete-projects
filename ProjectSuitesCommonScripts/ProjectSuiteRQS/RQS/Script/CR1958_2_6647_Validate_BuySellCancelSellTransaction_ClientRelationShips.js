//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT DBA
//USEUNIT CR1958_2_6742_ValidateConcentrationAlertsClientRelationships


/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6647
    Description :
                 Validate Buy,Sell,Cancel Sell transaction & Client RelationShips (Client Profile)
                 
    Auteur :Alhassane Diallo
    Analyste de test manuels: Carole Turcotte
    Version de scriptage: ref90-12-Hf-46
    
    Révisé par Amine A.
**/
function CR1958_2_6647_Validate_BuySellCancelSellTransaction_ClientRelationShips()
{
    try {
      
               //Variables                           
               var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
               var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
               
               
               var valueTest_SuitabilityAlert = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "ValueTest_SuitabilityAlert", language + client);
               var account800024RE            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Account800024RE", language + client);
               var clientRelationNumber       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6647_ClientRelationNumber", language + client);
               var managementLevel            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6647_ManagementLevel", language + client);
               var cliRelTotalValue           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6647_CliRelTotalValue", language + client);
               
               var investRiskActualLow    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6647_InvestRiskActualLow", language + client);
               var investRiskActualMedium = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6647_InvestRiskActualMedium", language + client);
               var investRiskActualHigh   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6647_InvestRiskActualHigh", language + client);        
               var IACodeGrid             = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6647_IACodeGrid", language + client);
               var IACodeName             = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6647_IACodeName", language + client);
               var OperatorEqual          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6647_OpeEqual", language + client);
               var alerteStatus           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6647_AlertStatus", language + client);
               var shortClientRelationNumber       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6647_Short_ClientRelationNumber", language + client);
               
               var clientRelationshipNumberFF = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6647_FilterFieldClientRelationshipNumber", language + client);
            
               //Lien Testlink
               Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6647","Lien testlink - Croes-6647");
//Étape 1      
       
                //Se connecter avec Keynej
                Log.Message("******************** Login *******************");
                Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
       
       
                //Cliquer sur le bouton risque et gestionnaire de conformité pour ouvrir la fenêtre RQS 
                 Log.Message("******************** Cliquer sur le bouton risque et gestionnaire de conformité pour ouvrir la fenêtre RQS. *******************");
                 Get_Toolbar_BtnRQS().Click();
                 Get_WinRQS().Parent.Maximize();
                 
                 
                 // Cliquer sur l'onglet Alerte
                Log.Message("******************** Cliquer sur l'onglet Alerte. *******************");
                Get_WinRQS_TabAlerts().Click();  
                Get_WinRQS_TabAlerts().WaitProperty("IsChecked", true, 30000);  
                
                 //Faire un filtre Test puis selectionner Suitability alert
                Log.Message("******************** Faire un filtre Test puis selectionner Suitability alert. *******************");
                Get_WinRQS_QuickFilterClick();
                Get_SubMenus().FindChild("WPFControlText", "Test", 10).Click();
                Get_WinCreateFilter_DgvValue().Find("Value", valueTest_SuitabilityAlert, 10).Click();
                Get_WinCreateFilter_BtnApply().Click();  
                
                //Faire une recherche du compte 800024-RE              
//                Log.Message("Click on the keyboard to activate the quick search");                
//          		  Get_WinRQS_TabAlerts_DgvAlerts().Keys("h");
//          		  Get_WinQuickSearch_TxtSearch().SetText(account800024RE);
//          		  Get_WinRWS_QuickSearch().WPFObject("FieldSelector").WPFObject("ListBoxItem", "", 1).WPFObject("RadioButton", "", 1).ClickButton();
//          		  Get_WinQuickSearch_BtnOK().Click(); 
      
          
                Get_WinRQS_QuickFilterClick();

      //          Get_MenuBar_Filtres_TabReports_ClientRelNumber().Click();
                Get_WinRQS_QuickFilter_FilterField(clientRelationshipNumberFF).Click();
                WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71");
                SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), OperatorEqual);
                Get_WinCreateFilter_TxtValue().SetText(shortClientRelationNumber); 
                Get_WinCreateFilter_BtnApply().Click();
                
                //Noter le numéro de l'alerte 
                var alertID =  Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AlertId;
                Log.Message("L'ID de l'alerte est: "+ alertID);



                          
                //Prendre en note l'Alert no.  du compte no 800024-RE ( DANS NOTRE CAS LE NUMÉRO EST 104) et exécuter les requêtes suivantes: 
                Log.Message("Prendre en note l'Alert no.  du compte no 800024-RE ( DANS NOTRE CAS LE NUMÉRO EST 104) et exécuter les requêtes suivantes: ");
      		
           
                Log.Message("select * from B_RQS_ALERT where  ALERT_ID = 104");
            		var queryStringAlertID = "select * from B_RQS_ALERT where  ALERT_ID = " + alertID;
            		var resultAlert = Execute_SQLQuery_GetField(queryStringAlertID, vServerRQS, "ALERT_ID");
            		Log.Checkpoint("Alert " +resultAlert + " found it  on the table B_RQS_ALERT");
     		

            		Log.Message("  select * from B_RQS_ALERT_ACCOUNT where ALERT_ID = 104");
            		var queryStringAccAlertID = "select * from B_RQS_ALERT_ACCOUNT where  ALERT_ID = " + alertID;
            		var resultAlertAccount = Execute_SQLQuery_GetField(queryStringAccAlertID , vServerRQS, "ALERT_ID");
            		Log.Checkpoint("Alert " +resultAlertAccount + " found it  on the table B_RQS_ALERT_ACCOUNT");

                
            		Log.Message("  select * from B_RQS_ALERT_CLIENT where ALERT_ID = 104 ");
            		var queryStringCliAlertID = "select * from B_RQS_ALERT_CLIENT where  ALERT_ID = " + alertID;
            		var resultAlertClient = Execute_SQLQuery_GetField(queryStringCliAlertID , vServerRQS, "ALERT_ID");
            		Log.Checkpoint("Alert " +resultAlertClient + " found it  on the table B_RQS_ALERT_CLIENT");          
            
                
                Log.Message(" select * from  B_RQS_ALERT_TRANS where ALERT_ID =104");
            		var queryStringTransAlertID = "select * from B_RQS_ALERT_TRANS where  ALERT_ID =  " + alertID;
            		var resultAlertTrans = Execute_SQLQuery_GetField(queryStringTransAlertID , vServerRQS, "ALERT_ID");
            		Log.Checkpoint("Alert " +resultAlertTrans + " found it  on the table B_RQS_ALERT_TRANS");
                
                
                //Validation du statut de l'alerte numero 104
                Log.Message("******************** Validation du statut de l'alerte numero  *******************");
                var nbrAlertes = Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).items.Count 
                 
                for (i=0; i<nbrAlertes; i++) {
                    
                        if(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AlertId==alertID){      
                                               
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CurrentStatusDescription, alerteStatus, 'CurrentStatusDescription');
                         
                          }
                   }
             
            
            
          		
                
                
//Étape 2

              //Rester sur l'alerte du no 114 du compte 800024-RE Valider la section details en bas 
              Log.Message("Rester sur l'alerte du no 114 du compte 800024-RE Valider la section details en bas");
                
               
              Log.Message("Client relationship  Info in Details section and Alerts tab");
              Log.Message("Client Relationship number (name):001C (MARTIN BRODEUR VIGNEUX)");

          		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtCliRelNumName(), "Text", cmpEqual, clientRelationNumber);
          		Log.Message("The Client Relationship number (name) is: " + clientRelationNumber);
			 
          		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtManagementLevel(),"Text", cmpEqual, managementLevel)
          		Log.Message("The Management level is: " +managementLevel);

          		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtClientRelTotalValue(), "Text", cmpEqual, cliRelTotalValue)
          		Log.Message("The Client relationship total value is: " +cliRelTotalValue);

          		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtActualInvestRiskLow(),"Text", cmpEqual, investRiskActualLow);
          		Log.Message("Investment risk - Low(%): " + investRiskActualLow);             
                
          		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtActualInvestRiskMedium(),"Text", cmpEqual, investRiskActualMedium);
          		Log.Message("Investment risk - Medium(%): " + investRiskActualMedium);

          		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtActualInvestRiskHigh(),"Text", cmpEqual, investRiskActualHigh);
          		Log.Message("Investment risk - High(%): " + investRiskActualHigh);

          		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtIACode(),"Text", cmpEqual,IACodeName);
          		Log.Message("IA code (Name): " + IACodeName);  

  
              //Validation de IAcode dans la grille Alerts (Haut) 
              Log.Message("******************** Validation de IAcode dans la grille Alerts (Haut) *******************");
               
                for (i=0; i<nbrAlertes; i++) {
                    
                        if(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AlertId==alertID){      
                            
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.RepresentativeNumber, IACodeGrid, 'RepresentativeNumber');                    
                          
                          }
                   }
             
             
                
                
 
                //Fermer la fenêtre RQS
       Log.Message("Fermer la fenêtre RQS");
  		 Get_WinRQS().Close();

 
             
       //Fermer Croesus
       Close_Croesus_X(); 
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    
        Terminate_CroesusProcess();
        
      
        
    }
}

    
