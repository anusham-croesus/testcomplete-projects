//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT DBA
//USEUNIT CR1958_2_6742_ValidateConcentrationAlertsClientRelationships


/**

https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6658
    Description :
                 Validate Manual ¦Logic Client_ID
                 
    Auteur :Alhassane Diallo
    Analyste de test manuels: Carole Turcotte
    Version de scriptage: ref90-12-Hf-46
    
    Revisé par Amine A.
**/
function CR1958_2_6658_Validate_Manual_Logic_Client_ID()
{
    try {

               //Variables
               var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
               var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");                   
               
               //Variables étape1                                
               var accountNumberFilter = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_AccountNumberFilter", language + client); 
               var accountNumber80027  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_AccountNumber80027", language + client);
               var operatorContaining  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_Operator", language + client);          
               var securityMB          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_MB_MID_TRM_GROWT1G02", language + client);
               var securityPepsico     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_PEPSICO_INC", language + client);
               var note80027           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_Note80027", language + client);
               var valueTest           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_ValueTest", language + client);
               
               var valueTest          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_ValueTest", language + client);
               var mgmtLevelCol       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_Ch_Mgmt_LevelColonne", language + client);
               var clientRelNameCol   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_Ch_Client_Rel_NameColonne", language + client);
               var clientRelNumberCol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6742_6020_ClientRelNumber", language + client);
                              
               var mgmtLevel    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_MgmtLevel", language + client);
               var clientRelNum = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_Client_Rel_Num", language + client);
               var totalValue   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_TotalValue", language + client);                                     
              
               var ClientRelNumName800272 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_ClientNumberName", language + client);              
               var totalNetWorth          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_TotalNetWorth", language + client);             
               var annualIncome           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_AnnualIncome", language + client);             
               var clientRelTotalValue    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_ClientRelTotalValue", language + client);              
               var nonResidentIndicator   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_NonResidentIndicator", language + client);
               var investmentKnowledge    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_InvestmentKnowledge", language + client); 
               var residentLocation       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_ResidentLocation", language + client); 
               
               var income           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_Income", language + client); 
               var shortTermInvest  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_ShortTermInvest", language + client); 
               var mediumTermInvest = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_MediumTermInvest", language + client);             
               var longTermeInvest  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_LongTermInvest", language + client);                                            
               
               var investmentRiskLow      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_InvestmentRiskLow", language + client); 
               var investmentRiskMedium   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_InvestmentRiskMedium", language + client);             
               var investmentRiskHigh     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_InvestmentRiskHigh", language + client);             
               var actualInvestRiskLow    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_ActualInvestRiskLow", language + client);
               var actualInvestRiskMedium = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_ActualInvestRiskMedium", language + client);
               var actualInvestRiskHigh   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_ActualInvestRiskHigh", language + client);                                 
               var brancheCode            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_BrancheCode", language + client); 
               var IACodeName             = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_IACodeDetails", language + client); 
               
               //variables etape2
               var account800249NA    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_account800249NA", language + client); 
               var account800266RE    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_account800266RE", language + client); 
               var netAmount800249NA  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_NetAmount800249NA", language + client);
               var noteGroupe144      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_144_NoteGroupe144", language + client);     
               var mgmtLevel144       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658__144_MgmtLevel", language + client); 
               var IACode144          = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_144_Iacode", language + client);  
               var alertStatuts144    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_144_AlertsStatus", language + client); 
               var clientRelNum144    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_144_Client_Rel_Num", language + client); 
               
               //variables etape3
               var account800238GT     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_account800238GT", language + client);
               var mgmtLevel145        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658__145_MgmtLevel", language + client);  
               var securityNBC100      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_securityNBC100", language + client);
               var clientRelName145    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_145_Client_Rel_Name", language + client); 
               var alertStatuts145     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_144_AlertsStatus", language + client); 
               var clientRelNum145     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_145_Client_Rel_Num", language + client); 
               var clientTotalValue145 =  ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_145_ClientTotalValue", language + client);
               var IAcodeName145       =  ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_145_IACodeName", language + client);  
               var note800238GT        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_145_Note800238GT", language + client);
                              
               //variables etape4
               var account800217SF    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_Account800217SF", language + client); 
               var account800211RE    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_Account800211RE", language + client); 
               var mgmtLevel146       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658__146_MgmtLevel", language + client);   
               var alertStatuts146    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_146_AlertsStatus", language + client); 
               var clientRelNum146    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_146_Client_Rel_Num", language + client); 
               var notegroupe146      =   ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_146_Note146", language + client);
               var operatorIsNotEmphy = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_OperatorIsNotEmphy", language + client); 
               var valueTestFiltreMgmtLevel  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6658_ValueFiltreMgmtLevel", language + client);
               
               //Filter Fields
               var accountNumberFF            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6658_FilterFieldAccountNumber", language + client);
               var ManagenmtLevelFF           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6658_FilterFieldManagenmtLevel", language + client);
               var ClientRelationshipNumberFF = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6658_FilterFieldClientRelationshipNumber", language + client);
       
               //Lien Testlink
               Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6658","Lien testlink - Croes-6658");
//Étape 1      
       
                //Se connecter avec Keynej
                Log.Message("******************** Login *******************");
                Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);                       
                
                //Accès à l'onglet Transaction Blotter
                transactionBlotterAccess();
                 
                //Faire un filtre sur Account Number   puis saisir le client 80027               
                Log.Message("******************** Faire un filtre sur Account Number   puis saisir le client 80027. *******************");
                Get_WinRQS_QuickFilterClick(); 
//                Get_WinRQS_TabTransactionBlotter_FilterAccountNumber().Click();
                Get_WinRQS_QuickFilter_FilterField(accountNumberFF).Click();
                                                 
                //Selectionner l'operateur contenant (containing), saisir le comerode compte 80027 puis cliquer sur Appliquer            
                 Log.Message("******************** Selectionner l'operateur contenant (containing), saisir le numero compte 80027 puis cliquer sur Appliquer  . *******************"); 
                 //SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), OperatorContaining);
                 SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), operatorContaining);
                 Get_WinCreateFilter_TxtValue().SetText(accountNumber80027);
      		       WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71");
      		       Get_WinCreateFilter_BtnApply().Click();
                 
                 //Sélectionner les deux transactions de vente (sell) Ajouter une note manuelle aux deux tranaction
                 Log.Message("******************** Sélectionner les deux transactions de vente (sell) et cliquer sur Review Selected. *******************");                 
                 Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild("Value", securityMB, 100).Click(-1, -1, skCtrl);
                 Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild("Value", securityPepsico, 100).Click(-1, -1, skCtrl); 
                 
                 //Ajout de la note manuelle
                 AjoutNoteTransaction(note80027);
                
                 //Faire un filtre sur le champ Test -->  Manual --> Apply 
                 AjoutFiltreTestManual(valueTest); 
                 
//Noter le numéro de l'alerte 
          var alertID =  Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.AlertId;
          Log.Message("L'ID de l'alerte est: "+ alertID);                                
                
                //Ajouter les colonnes  Mgmt level  Client rel. name  et  Client rel. no.
                Log.Message("******************** Ajouter les colonnes  Mgmt level  Client rel. name  et  Client rel. no. *******************");
                Get_WinRQS_TabAlerts_DgvAlerts_ChAlertNo().ClickR();
                Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                Add_ColumnByLabel(Get_WinRQS_TabAlerts_DgvAlerts_ChAlertNo(), clientRelNumberCol);
                Add_ColumnByLabel(Get_WinRQS_TabAlerts_DgvAlerts_ChAlertNo(), mgmtLevelCol);
                Add_ColumnByLabel(Get_WinRQS_TabAlerts_DgvAlerts_ChAlertNo(), clientRelNameCol);                
                
                 //Prendre en note le Alert no. (dans notre cas le no est 143) et Faire les requêtes suivantes pour valider que l'alerte manuelle est présente
                 Log.Message("****** Prendre en note le Alert no. (le no est 143), Faire les requêtes suivantes pour valider que l'alerte manuelle est présente*********");
            
                 
              Log.Message("select * from B_RQS_ALERT where ALERT_ID =143  and ALERT_TEST_ID = 8 ");
          		var queryStringAlertID = "select * from B_RQS_ALERT where ALERT_ID = " + alertID + " and ALERT_TEST_ID = 8";
          		var resultAlert = Execute_SQLQuery_GetField(queryStringAlertID, vServerRQS, "ALERT_ID");
          		Log.Checkpoint("Alert " +resultAlert + " found it  on the table B_RQS_ALERT");
     		

          		Log.Message("  select * from B_RQS_ALERT_ACCOUNT where ALERT_ID = 143");
          		var queryStringAccAlertID = "select * from B_RQS_ALERT_ACCOUNT where ALERT_ID = " + alertID ;
          		var resultAlertAccount = Execute_SQLQuery_GetField(queryStringAccAlertID , vServerRQS, "ALERT_ID");
          		Log.Checkpoint("Alert " +resultAlertAccount + " found it  on the table B_RQS_ALERT_ACCOUNT");

                
          		Log.Message("  select * from B_RQS_ALERT_CLIENT where ALERT_ID =143 ");
          		var queryStringCliAlertID = "select * from B_RQS_ALERT_CLIENT where  ALERT_ID = " + + alertID ;
          		var resultAlertClient = Execute_SQLQuery_GetField(queryStringCliAlertID , vServerRQS, "ALERT_ID");
          		Log.Checkpoint("Alert " +resultAlertClient + " found it  on the table B_RQS_ALERT_CLIENT");          
            
                
              Log.Message(" select * from  B_RQS_ALERT_TRANS where ALERT_ID =143");
          		var queryStringTransAlertID = "select * from B_RQS_ALERT_TRANS where  ALERT_ID = "+ alertID ;
          		var resultAlertTrans = Execute_SQLQuery_GetField(queryStringTransAlertID , vServerRQS, "ALERT_ID");
          		Log.Checkpoint("Alert " +resultAlertTrans + " found it  on the table B_RQS_ALERT_TRANS");
                
                 
              // Dans le Browser de l'onglet Alertes valider : Magement Level, Client Rel no et Total Value 
              Log.Message("******************Dans le Browser de l'onglet Alertes valider : Magement Level, Client Rel no et Total Value*******************");
              var nbrAlertes = Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).items.Count 
               for (i=0; i<nbrAlertes; i++) {
                    if(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AlertId == alertID){
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientRelationshipNumber, clientRelNum, 'ClientRelationshipNumber');    
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ManagementLevelDescription, mgmtLevel, 'ManagementLevelDescription');
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.TotalValue, totalValue, 'TotalValue');
                           break;
                    }                
                }
                        
                //Dans l'onglet Alertes Section details sous Client Relation info, Valider les element suivants 
                Log.Message("******************** Dans l'onglet Alertes Section details sous Client Relation info, Valider les element suivants *******************");
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtClientNumber(), "Text", cmpEqual, ClientRelNumName800272);
                Log.Message("The Client Relationship number (name) is: " + ClientRelNumName800272);
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtTotalNetWorth(), "Text", cmpEqual, totalNetWorth);
      		      Log.Message("The Total Net Worth is: " + totalNetWorth);
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtAnnualIncome(), "Text", cmpEqual, annualIncome);
      		      Log.Message("The Annual Income is: " + annualIncome);
                   
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtClientRelTotalValue(), "Text", cmpEqual, clientRelTotalValue);
      		      Log.Message("The Client Relationship Total  Value is: " + clientRelTotalValue);
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestKnowledge(), "Text", cmpEqual, investmentKnowledge);
      		      Log.Message("The Investment Knowledge is: " + investmentKnowledge);
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtNonResidentIndicator(), "Text", cmpEqual, nonResidentIndicator);
      		      Log.Message("The Non Resident Indicator is: " + nonResidentIndicator);
                                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtResidentLocation(), "Text", cmpEqual, residentLocation);
      		      Log.Message("The Resident Locatione is: " + residentLocation);
                
                
                 
                //Dans l'onglet Alertes Section details, Section details sous Objectif de placement (Investment Objective), Valider les éléments suivants 
                Log.Message("******************** Dans l'onglet Alertes Section details, Section details sous Objectif de placement (Investment Objective), Valider les éléments suivants*******************");
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtIncome(), "Text", cmpEqual, income);
      		      Log.Message("The Income is: " + income);
                                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtShortTerm(), "Text", cmpEqual, shortTermInvest);
      		      Log.Message("The Short Terme Investment  is: " + shortTermInvest);
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtMediumTerm(), "Text", cmpEqual, mediumTermInvest);
      		      Log.Message("The Medium Terme Investment is: " + mediumTermInvest);
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtLongTerm(), "Text", cmpEqual, longTermeInvest);
      		      Log.Message("The Long Terme Investment is: " + longTermeInvest);
//                
                //Dans l'onglet Alertes, Section details sous Risque d'Investissement (Investment Risk), Valider les éléments suivants 
                Log.Message("******************** Dans l'onglet Alertes, Section details sous Risque d'Investissement (Investment Risk), Valider les éléments suivants *******************");       
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestRiskLow(), "Text", cmpEqual, investmentRiskLow);
      		      Log.Message("The KYC Risck Low Investment  is: " + investmentRiskLow);
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestRiskMedium(), "Text", cmpEqual, investmentRiskMedium);
      		      Log.Message("The KYC Risck Medium Investment is: " + investmentRiskMedium);
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestRiskHigh(), "Text", cmpEqual, investmentRiskHigh);
      		      Log.Message("The KYC Risck High Investment is: " + investmentRiskHigh);                               
                
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtActualInvestRiskLow(), "Text", cmpEqual, actualInvestRiskLow);
      		      Log.Message("The Actual Risck Low Investment  is: " + actualInvestRiskLow);
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtActualInvestRiskMedium(), "Text", cmpEqual, actualInvestRiskMedium);
      		      Log.Message("The Actual Risck Medium Investment is: " + actualInvestRiskMedium);
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtActualInvestRiskHigh(), "Text", cmpEqual, actualInvestRiskHigh);
      		      Log.Message("The Actual Risck High Investment is: " + actualInvestRiskHigh);
                
                //Dans l'onglet Alertes, Section details sous Risque Info Succursale (Branche Info), Valider les éléments suivants 
                Log.Message("******************** Dans l'onglet Transaction Blotter Section details sous Risque Info Succursale (Branche Info), Valider les éléments suivants  *******************");                
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtBrancheCode(), "Text", cmpEqual, brancheCode);
      		      Log.Message("The Branche Code (name)  is: " + brancheCode);
                
                aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtIACode(), "Text", cmpEqual, IACodeName);
      		      Log.Message("The IA Code (name) is: " + IACodeName);
                
//                
                //Desactiver le filtre actif
                Get_WinRQS_TabAlerts_DgvAlerts_DesActiverFiltre1().Click()
                Get_WinRQS().Close();
                 
               
//Étape2          
                //Accès à l'onglet Transaction Blotter
                transactionBlotterAccess();
                 
                //Faire une recherche du compte 800249-NA              
                Log.Message("Click on the keyboard to activate the quick search");                
            		Get_WinRQS_TabTransactionBlotter_DgvTransactions().Keys("h");
            		Get_WinQuickSearch_TxtSearch().SetText(account800266RE);
            		Get_WinRWS_QuickSearch().WPFObject("FieldSelector").WPFObject("ListBoxItem", "", 1).WPFObject("RadioButton", "", 1).ClickButton();
            		Get_WinQuickSearch_BtnOK().Click(); 
               
                //sélectionner la vente (sell) MANITOBA TELECOM SVCS INC de -300 (qty) Selectionner également la transaction suivante du  client suivant 800266-RE (symbol fid285 , -470.207 qty)
                Log.Message("****** //sélectionner la vente (sell) MANITOBA TELECOM SVCS INC de -300 (qty) Selectionner également la transaction suivante du  client suivant 800266-RE (symbol fid285 , -470.207 qty)******");
                Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild("Value", account800266RE, 10).Click(-1, -1, skCtrl)
                //Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild("Value", account800249NA, 10).Click(-1, -1, skCtrl)
                Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild("Text", netAmount800249NA, 10).Click(-1, -1, skCtrl)
                
                 //Ajout de la note manuelle
                 AjoutNoteTransaction(noteGroupe144);
                
                 //Faire un filtre sur le champ Test -->  Manual --> Apply 
                 AjoutFiltreTestManual(valueTest);                
                   
                 // Dans le Browser de l'onglet Alertes valider : Magement Level, Client Rel name ,lient Rel no et IA code 
                Log.Message("******************// Dans le Browser de l'onglet Alertes valider : Magement Level, Client Rel name ,lient Rel no et IA code *******************");
                var nbrAlertes = Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).items.Count 
                
                
                 for (i=0; i<nbrAlertes; i++) {
                    
//                      Get_WinRQS_TabAlerts_AlertList().FindChild("Text", alertId144, 10).Click();
                      if(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AlertId == alertID + 1){ 
                                        
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientRelationshipNumber, clientRelNum144, 'ClientRelationshipNumber');    
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ManagementLevelDescription, mgmtLevel144, 'ManagementLevelDescription');
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.RepresentativeNumber, IACode144, 'RepresentativeNumber');
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientRelationshipName, null, 'ClientRelationshipName');  
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CurrentStatusDescription, alertStatuts144, 'CurrentStatusDescription');                
                       }
                       break; 
                   }  
                  
                  //Desactiver le filtre actif
                  Log.Message("Desactiver le filtre actif");
                  Get_WinRQS_TabAlerts_DgvAlerts_DesActiverFiltre1().Click();
                  Get_WinRQS().Close();       
                
                
//Étape3               
                 
                //Accès à l'onglet Transaction Blotter
                 transactionBlotterAccess();
                
                
                 //Faire une recherche sur Account number = 800238-GT et sélectionner la transaction Buy ALT H/I CSH PRF/NL/N 
                 Log.Message("****** Faire une recherche sur Account number = 800238-GT et sélectionner la transaction Buy ALT H/I CSH PRF/NL/N ******");
                                               
            		Get_WinRQS_TabTransactionBlotter_DgvTransactions().Keys("h");
            		Get_WinQuickSearch_TxtSearch().SetText(account800238GT);
            		Get_WinRWS_QuickSearch().WPFObject("FieldSelector").WPFObject("ListBoxItem", "", 1).WPFObject("RadioButton", "", 1).ClickButton();
            		Get_WinQuickSearch_BtnOK().Click(); 
                 
                Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild("Value", securityNBC100, 10).Click();              
                
                //Ajout de la note manuelle
                AjoutNoteTransaction(note800238GT);
                
                 //Faire un filtre sur le champ Test -->  Manual --> Apply 
                 AjoutFiltreTestManual(valueTest);  
                                
                
                // Dans le Browser de l'onglet Alertes valider : Magement Level, Client Rel name ,lient Rel no et IA code 
                Log.Message("******************// Dans le Browser de l'onglet Alertes valider : Magement Level, Client Rel name ,lient Rel no et IA code *******************");
                var nbrAlertes = Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).items.Count 
              
                Get_WinRQS_TabAlerts_AlertList().FindChild("Text", alertID + 2, 10).Click();
                for (i=0; i<nbrAlertes; i++) {
                  
                    if(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AlertId == alertID + 2){  
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientRelationshipNumber, clientRelNum145, 'ClientRelationshipNumber');    
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ManagementLevelDescription, mgmtLevel145, 'ManagementLevelDescription');
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CurrentStatusDescription, alertStatuts145, 'CurrentStatusDescription');
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientRelationshipName, clientRelName145, 'ClientRelationshipName');                 
                       }
                      break;
                  }  
  
                // En bas,  section Details Valider : Client Total Value et IACode  (Name)
                 Log.Message("******************En bas,  section Details Valider : Client Total Value et IACode  (Name)***************************")
                 
                 aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtClientRelTotalValue(), "Text", cmpEqual, clientTotalValue145);
      		       Log.Message("The Client Relationship Total  Value is: " + clientTotalValue145);
                 
                 aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtIACode(), "Text", cmpEqual, IAcodeName145);
      		       Log.Message("The IA Code (name) is: " + IAcodeName145); 
                 
                 //Desactiver le seul filtre1 actif
                 Get_WinRQS_TabAlerts_DgvAlerts_DesActiverFiltre1().Click();
                 Get_WinRQS().Close();  
                
//Étape4
                //Accès à l'onglet Transaction Blotter
                transactionBlotterAccess();
                
                //Faire un filtre sur Management Level (Niveau de gestion) et selectionner induvual        
                Log.Message("******************** //Faire un filtre sur Management Level (Niveau de gestion) et selectionner induvual. *******************");
                Get_WinRQS_QuickFilterClick(); 
//                Get_WinRQS_TabTransactionBlotter_FilterManagenmtLevel().Click();
                Get_WinRQS_QuickFilter_FilterField(ManagenmtLevelFF).Click();
                Get_WinCreateFilter().FindChild("Text", valueTestFiltreMgmtLevel, 10).Click();
                Get_WinCreateFilter_BtnApply().Click(); 
                
                 //Faire un filtre sur Numéro de la relation client             
                 Log.Message("******************** Faire un filtre sur Numéro de la relation client . *******************");
                 Get_WinRQS_QuickFilterClick(); 
                 Get_WinRQS_QuickFilter_FilterField(ClientRelationshipNumberFF).Click();
//                 Get_WinRQS_TabTransactionBlotter_FilterClientRelNumber().Click();

                
                 //Selectionner l'operateur n'est pas à Blanc (is not emphy),  puis cliquer sur Appliquer            
                 Log.Message("******************** Selectionner l'operateur n'est pas à Blanc (is not emphy),  puis cliquer sur Appliquer . *******************"); 
                 SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), operatorIsNotEmphy);
      		       WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71");
      		       Get_WinCreateFilter_BtnApply().Click();                 
                  
                
                 //sélectionner la vente (sell) MANITOBA TELECOM SVCS INC de -300 (qty) Selectionner également la transaction suivante du  client suivant 800266-RE (symbol fid285 , -470.207 qty)
                 Log.Message("****** //sélectionner la vente (sell) MANITOBA TELECOM SVCS INC de -300 (qty) Selectionner également la transaction suivante du  client suivant 800266-RE (symbol fid285 , -470.207 qty)******");
                 Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild("Value", account800217SF, 10).Click(-1, -1, skCtrl)
                 Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild("Value", account800211RE, 10).Click(-1, -1, skCtrl)
                 Get_WinRQS_TabTransactionBlotter_DgvTransactions().FindChild("Value", account800238GT, 10).Click(-1, -1, skCtrl)
                 
                
                //Ajout de la note manuelle
                 AjoutNoteTransaction(notegroupe146);
                
                //Faire un filtre sur le champ Test--»Manual--»Apply
                Log.Message("******************Faire un filtre sur le champ Test--»Manual--»Apply *******************");
                AjoutFiltreTestManual(valueTest);
                
                // Dans le Browser de l'onglet Alertes valider : Magement Level, Client Rel name ,lient Rel no et IA code 
                Log.Message("******************// Dans le Browser de l'onglet Alertes valider : Magement Level, Client Rel name ,lient Rel no et IA code *******************");
                var nbrAlertes = Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).items.Count 
                
                
                for (i=0; i<nbrAlertes; i++) {
                    
//                      Get_WinRQS_TabAlerts_DgvAlerts_Filtres ().FindChild("Text", alertId146, 10).Click();
                      if(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AlertId == alertID + 3){                     
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientRelationshipNumber, clientRelNum146, 'ClientRelationshipNumber');    
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ManagementLevelDescription, mgmtLevel146, 'ManagementLevelDescription');                          
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientRelationshipName, null, 'ClientRelationshipName'); 
                           CheckEquals(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CurrentStatusDescription, alertStatuts146, 'CurrentStatusDescription');                
                       }
                      break;
                  }         
                                
                       
        //Fermer la fenêtre RQS
        Log.Message("Fermer la fenêtre RQS");
        Get_WinRQS().Close();

 
             
      
          
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
    
        Terminate_CroesusProcess();
        
      
        
    }
}

function test(){
        
        var ClientRelationshipNumberFF = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "6658_FilterFieldClientRelationshipNumber", language + client);
        Get_WinRQS_QuickFilterClick(); 
                 Get_WinRQS_QuickFilter_FilterField(ClientRelationshipNumberFF).Click();//"Client relationship number").Click();
}

//fonction qui permets de desactiver le premier filtre dans l'onglet Alertes
function Get_WinRQS_TabAlerts_DgvAlerts_DesActiverFiltre1(){
    return Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], 10);}

// Fonction qui permet d'ouvrir la fenêtre RQS et accéder à l'onglet "Transaction Blotter"
function transactionBlotterAccess(){
              //Cliquer sur le bouton risque et gestionnaire de conformité pour ouvrir la fenêtre RQS 
                Log.Message("******************** Cliquer sur le bouton risque et gestionnaire de conformité pour ouvrir la fenêtre RQS. *******************");
                Get_Toolbar_BtnRQS().Click();
                Get_WinRQS().Parent.Maximize();
                
                //Cliquer sur le bouton RQS et Aller dans l'onglet Transaction Blotter
                Log.Message("***************Cliquer sur le bouton RQS et Aller dans l'onglet Transaction Blotter****************");
                Get_WinRQS_TabTransactionBlotter().Click();
}

//Fonction qui permet d'jouter une note manuelle à une ou plusieurs transactions
function AjoutNoteTransaction(manualnote){
                //Cliquer sur le bouton Review Selected et cocher la case Manual alert -- taper dans la note 'groupe' --> validate
                Log.message("**********************Cliquer sur le bouton Review Selected et cocher la case Manual alert -- taper dans la note 'groupe' --> validate.**************************");
                Get_WinRQS_TabTransactionBlotter_BtnReviewSelected().Click();                
                Get_WinTransactionReview_RdBManualAlerte().Click();
                Get_WinTransactionReview_GrpNoteTextBox().Settext(manualnote);
                WaitObject(Get_CroesusApp(), "Uid", "Button_c9dd");
                Get_WinTransactionReview_BtnValidate().Click();
                Get_WinTransactionReview_BtnValidate().Click();     

}

// Fonction qui permet d'jouter un filtre sur les notes manuelles
function AjoutFiltreTestManual(valueTest){
 
                //Cliquer sur l'onglet Alerts et Faire un filtre sur le champ Test --> Manual --> Apply
                Log.Message("******************Cliquer sur l'onglet Alerts et Faire un filtre sur le champ Test --> Manual --> Apply***************************")
                Get_WinRQS_TabAlerts().Click();
                Get_WinRQS_QuickFilterClick();
                Get_SubMenus().FindChild("WPFControlText", "Test", 10).Click();
                Get_WinCreateFilter().FindChild("Text", valueTest, 10).Click();
                Get_WinCreateFilter_BtnApply().Click();       

}











