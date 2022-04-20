 //USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT RQS_Get_functions
//USEUNIT CR1958_2_6742_ValidateConcentrationAlertsClientRelationships

/*
    Description :
                 Validate if the Client not Excluded via FD_COMPLIANCE_EXCLUDED_ACCOUNTS
                  The management level of the client is Client profile
                 
    Auteur :Jimenab (Terminer par Alhassaned)
    Analyste de test manuels:Carole Turcotte
    Version de scriptage: ref90-12-Hf-46
    
    Réviseé et Modifié par Amine A.  le 2/20/2020
*/
function CR1958_2_6646_ValidaDepoTransInAlertCliRela()
{
  
  Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6646");
  
  try
    {
          //Variables    
          var userNameKeynej       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKeynej       = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          var ClientRelNumber      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "ClientRelNumber", language + client);
          var depositAndTransferIn = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "ValueTest", language + client);
  		
          var ClientId             = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "ClientId", language + client);
          var OperatorEqual        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "OpeEqual", language + client); 
          var CliRelNumName        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CliRelNumName", language + client); 
          var ManagementLevel      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "ManagementLevel", language + client); 
          var CliRelTotalValue     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CliRelTotalValue", language + client); 
          var InvesKnowledge       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "InvesKnowledge", language + client); 
          var NonResidentIndicator = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "NonResidentIndicator", language + client); 
          var ResidenceLocation    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "ResidenceLocation", language + client); 
          var InvestRiskLow        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "InvestRiskLow", language + client); 
          var InvestRiskMedium     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "InvestRiskMedium", language + client); 
          var InvestRiskHigh       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "InvestRiskHigh", language + client); 
          var InvestRiskActualLow  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "InvestRiskActualLow", language + client);      
      
          var InvestRiskActualMedium = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "InvestRiskActualMedium", language + client); 
          var InvestRiskActualHigh   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "InvestRiskActualHigh", language + client);
          var BrancheCodeName        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "BrancheCodeName", language + client);
          var IACodeName             = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "IACodeName", language + client);
          var msg_WarningFilter      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "msg_WarningFilter", language + client);
      
          var accountNumberFF = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6646_FilterFieldAccountNumber", language + client);
          var clientRelationshipNumberFF = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6646_FilterFieldClientRelationshipNumber", language + client);
          var account800201NA = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6646_AccountNumber", language + client);
    
          //Se connecter avec Keynej
          Login(vServerRQS, userNameKeynej, passwordKeynej, language);

          //Etape1
          Log.Message("Go to RQS --> Reports Tab ");
          Get_Toolbar_BtnRQS().click();
          Get_WinRQS_TabReports().Click();
          Log.Message("Select Offside Accounts on the drawdown list Report Type");
          Get_WinRQS_TabReports_CmbReportType().Click();
          Get_WinRQS_TabReports_CmbReportType().ClickItem(3);
          Log.Message("Click sur le bouton Display Report");
          Get_WinRQS_TabReports_BtnDisplayReport().Click();
               
          Get_WinRQS_QuickFilterClick();

//          Get_MenuBar_Filtres_TabReports_ClientRelNumber().Click();
          Get_WinRQS_QuickFilter_FilterField(clientRelationshipNumberFF).Click();
          WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71");
          SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), OperatorEqual);
          Get_WinCreateFilter_TxtValue().SetText(ClientRelNumber); 
          Get_WinCreateFilter_BtnApply().Click();

          WaitObject(Get_CroesusApp(),"Uid", "AccountList_046f");

          var CountItem =  Get_WinRQS().WPFObject("TabControl", "", 1).WPFObject("ReportsControl", "", 1).WPFObject("offsideAccounts").WPFObject("RecordListControl", "", 1).Items.get_Count();
          Log.Message("Il y a " + CountItem + " registre dans le filtre"); 

          for (i=0 ; i<CountItem ; i++){
            var OpeEqualNum = Get_WinRQS().WPFObject("TabControl", "", 1).WPFObject("ReportsControl", "", 1).WPFObject("offsideAccounts").WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LinkNumber;

            if (OpeEqualNum == ClientRelNumber){
            	Log.Checkpoint("The relationship " + OpeEqualNum + " are available on the Offside accounts grille ");
            }
            else
            	Log.Message("The error do not correspond as expected  " + ClientRelNumber);
          }         
            
// Etape2
          Log.Message("Go on Alerts tab");
          Get_WinRQS_TabAlerts().Click();
               
          //Ajouter le filtre Test 
          Get_WinRQS_QuickFilterClick();
          Get_SubMenus().FindChild("WPFControlText", "Test", 10).Click();
          Get_WinCreateFilter_DgvValue().Find("Value", depositAndTransferIn, 10).Click();
          Get_WinCreateFilter_BtnApply().Click();
 
          //Ajouter le filtre Account 'number = 800201-NA' 
          Log.Message("Ajouter le filtre Account 'number = 800201-NA'");        
          Get_WinRQS_QuickFilterClick(); 
          Get_WinRQS_QuickFilter_FilterField(accountNumberFF).Click();
          WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71");
          SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), OperatorEqual);
          Get_WinCreateFilter_TxtValue().SetText(account800201NA);          
          Get_WinCreateFilter_BtnApply().Click();
          
          //Noter le numéro de l'alerte 
          var alertID =  Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AlertId;
          Log.Message("L'ID de l'alerte est: "+ alertID);
           
          Log.Message(" 1. select * from B_RQS_ALERT where ALERT_ID = "+ alertID +" and ALERT_TEST_ID =2")
          var queryStringAlertID = "select * from B_RQS_ALERT where ALERT_ID ="+ alertID +" and ALERT_TEST_ID =2";
          var resuAlert = Execute_SQLQuery_GetField(queryStringAlertID, vServerRQS, "ALERT_ID");
          Log.Checkpoint("Alert " +resuAlert + " found it  on the table B_RQS_ALERT");

          Log.Message(" 2. select * from  B_RQS_ALERT_TRANS where ALERT_ID = "+ alertID)
          var queryStringTransAlertID = "select * from  B_RQS_ALERT_TRANS where ALERT_ID =" + alertID;
          var resuAlertTrans = Execute_SQLQuery_GetField(queryStringTransAlertID , vServerRQS, "ALERT_ID");
          Log.Checkpoint("Alert " +resuAlertTrans + " found it  on the table B_RQS_ALERT_TRANS");

          Log.Message(" 3. select * from B_RQS_ALERT_ACCOUNT where ALERT_ID = "+ alertID);
          var queryStringAccAlertID = "select * from B_RQS_ALERT_ACCOUNT where ALERT_ID = " + alertID;
          var resuAlertAcc = Execute_SQLQuery_GetField(queryStringAccAlertID , vServerRQS, "ALERT_ID");
          Log.Checkpoint("Alert " +resuAlertAcc + " found it  on the table B_RQS_ALERT_ACCOUNT");

          Log.Message(" 4. select * from B_RQS_ALERT_CLIENT where ALERT_ID = "+ alertID);
          var queryStringCliAlertID = "select * from B_RQS_ALERT_CLIENT where ALERT_ID =" + alertID;
          var resuAlertCli = Execute_SQLQuery_GetField(queryStringCliAlertID , vServerRQS, "ALERT_ID");
          Log.Checkpoint("Alert " +resuAlertCli + " found it  on the table B_RQS_ALERT_CLIENT");

          Get_WinRQS_TabAlerts_DgvAlerts().Keys("h");
          Get_WinQuickSearch_TxtSearch().SetText(alertID);
          Get_WinRWS_QuickSearch().WPFObject("FieldSelector").WPFObject("ListBoxItem", "", 10).WPFObject("RadioButton", "", 1).ClickButton();
          Get_WinQuickSearch_BtnOK().Click();
          
          Get_WinRQS_TabAlerts_AlertList().FindChild("Value", alertID, 10).Click();

//Etape3
      		Log.Message("Client relationship  Info in Details section and Alerts tab");
      		Log.Message("Client Relationship number (name):80020 (AMIR CELLARD)");

      		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtCliRelNumName(), "Text", cmpEqual, CliRelNumName);
      		Log.Message("The Client Relationship number (name) is: " + CliRelNumName);
			 
      		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtManagementLevel(),"Text", cmpEqual, ManagementLevel);
      		Log.Message("The Management level is: " +ManagementLevel);

      		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtClientRelTotalValue(), "Text", cmpEqual, CliRelTotalValue);
      		Log.Message("The Client relationship total value is: " +CliRelTotalValue);

      		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestKnowledge(), "Text", cmpEqual,InvesKnowledge);
      		Log.Message("The Client relationship total value is: " +InvesKnowledge);

      		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtNonResidentIndicator(), "Text", cmpEqual,NonResidentIndicator);
      		Log.Message("The Non-Resident Indicator is: " +NonResidentIndicator);

      		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtResidentLocation(), "Text", cmpEqual,ResidenceLocation);
      		Log.Message("The Non-Resident Indicator is: " +ResidenceLocation);

      		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestRiskLow(),"Text", cmpEqual,InvestRiskLow);
      		Log.Message("Investment risk - Low(%): " + InvestRiskLow);

      		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestRiskMedium(),"Text", cmpEqual,InvestRiskMedium);
      		Log.Message("Investment risk - Medium(%): " + InvestRiskMedium);

      		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestRiskHigh(),"Text", cmpEqual,InvestRiskHigh);
      		Log.Message("Investment risk - High(%): " + InvestRiskHigh);

      		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtBrancheCode(),"Text", cmpEqual,BrancheCodeName);
      		Log.Message("Branch code (name): " + BrancheCodeName);

      		aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtIACode(),"Text", cmpEqual,IACodeName);
      		Log.Message("IA code (Name): " + IACodeName);  


 //Etape 4 
      		Log.Message("Stay on the Alerts tab and test filtre on");
      		Log.Message("Click on the (Y+) quickly filters button and filter  a second filter by  Client Number equal to 800206");
      		Get_WinRQS_QuickFilterClick(); 

      		Get_WinRQS_QuickFilter_FilterField(accountNumberFF).Click(); 
      		Get_WinCreateFilter_TxtValue().SetText("800206");
      		WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71");
      		SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), OperatorEqual);
      		Get_WinCreateFilter_BtnApply().Click();

      		Log.Message("A warning message is display it")
      		aqObject.CheckProperty(Get_DlgWarning(), "Enabled", cmpEqual, true);
      		aqObject.CheckProperty(Get_DlgWarning(), "Visible", cmpEqual, true);
          
      		//Capturer le label - popUp
          if( Get_DlgWarning().Exists){       
             aqObject.CheckProperty(Get_DlgWarning().FindChild("ClrClassName", "TextBlock", 10), "WPFControlText", cmpEqual, msg_WarningFilter);
             Get_DlgWarning_BtnOK().Click();
            }         
           else
              Log.Error("Voir Anomalie RISK-782");
           //Fermer la fenêtre RQS
      		 Get_WinRQS().Close();
		}
		catch(e) 
			{
				Log.Error("Exception: " + e.message, VarToStr(e.stack));
			}
		finally
			{
				Terminate_CroesusProcess();
			}
	}
function  Get_WinRQS_QuickFilterClick(){ Get_WinRQS().Click(7,100);}