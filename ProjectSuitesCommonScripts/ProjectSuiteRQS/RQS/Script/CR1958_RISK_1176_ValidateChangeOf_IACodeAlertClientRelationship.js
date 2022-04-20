//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/*
      https://jira.croesus.com/browse/RISK-1176

      Analyste d'assurance qualité: Taous A.
      Analyste d'automatisation: Amine A. 
      Version de scriptage : ref90.15.2020.3-37 */

function CR1958_RISK_1176_ValidateChangeOf_IACodeAlertClientRelationship(){

            var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
            var waitTime = 5000;
                   
            //Champs de filtre/Filter Fields
            var changeOfIACode = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_changeOfIACode", language + client);
            var testFF         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_testFF", language + client);
            var operatorAmong  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_operatorAmong", language + client);
            //Variables  
            var branchInfo        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_branchInfo", language + client);
            var clientInfo        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_clientInfo", language + client);
            
            var clientProfile                = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_clientProfile", language + client);
            var accountNumberName            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_accountNumberName", language + client);
            var clientNameShort              = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_clientNameShort", language + client);
            var clientNumberName             = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_clientNumberName", language + client);
            var clientRelationshipNumberName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_clientRelationshipNumberName", language + client);
            var clientRelationshipTotalValue = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_clientRelationshipTotalValue", language + client);
            
            var totalNetWorth        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_totalNetWorth", language + client);
            var annualIncome         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_annualIncome", language + client);
            var proIndicator         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_proIndicator", language + client);            
            var investementKnowledge = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_investementKnowledge", language + client);
            var nonResidentIndicator = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_nonResidentIndicator", language + client);
            var residenceLocation    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_residenceLocation", language + client);
            var incomePourcentage    = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_incomePourcentage", language + client);
            
            var shortTerm      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_shortTerm", language + client);
            var mediumTerm     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_mediumTerm", language + client);
            var longTerm       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_longTerm", language + client);
            var low            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_low", language + client);
            var medium         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_medium", language + client);
            var high           = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_high", language + client);
            var actualLow      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_actualLow", language + client);
            var actualMedium   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_actualMedium", language + client);
            var actualHigh     = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_actualHigh", language + client);
            var branchCodeName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_branchCodeName", language + client);
            var newIACodeName  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_newIACodeName", language + client);
            var oldIACodeName  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1176_oldIACodeName", language + client);

            try {
              // Se connecter
              Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
            
              // Attendre le boutton RQS présent et actif
              WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
              Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
              Get_Toolbar_BtnRQS().Click();
              Get_WinRQS().Parent.Maximize();
          
              // Attendre l'onglet 'Alerts' présent et actif dans la fenêtre RQS
              WaitObject(Get_CroesusApp(), "Uid", "TabItem_a70d", waitTime);
              Get_WinRQS_TabAlerts().WaitProperty("Enabled", true, waitTime)          
          
              Get_WinRQS_TabAlerts().Click();
              Get_WinRQS_TabAlerts().WaitProperty("IsSelected", true, waitTime);
              
              //Appliquer le filtre: Operator = among, value = "Change of IA code";
              Get_WinRQS_QuickFilterClick();
              Get_WinRQS_QuickFilter_FilterField(testFF).Click();
              WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71");
              SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), operatorAmong);
              Get_WinCreateFilter_DgvValue().Find("Value", changeOfIACode, 10).Click();
              Get_WinCreateFilter_BtnApply().Click();
              
              //Cliquer sur l'alerte avec Nom Client = "1 Calcul Score"
              Get_WinRQS_TabAlerts_AlertList().FindChild("Value", clientNameShort, 10).Click();
              
              //Valider les titres des 2 zones "info succursale" et "info relation client"
              aqObject.CheckProperty(Get_WinRQS_AlertDetailSection_BranchInfoTxt(), "Text", cmpEqual, branchInfo);
              aqObject.CheckProperty(Get_WinRQS_AlertDetailSection_ClientInfoTxt(), "Text", cmpEqual, clientInfo)
              
              //Valider les champs: ClientProfil, ClientNumberName, AccountNumberName et clientRelationshipNumberName
              Log.Message("Valider les champs: ClientProfil, ClientNumberName, AccountNumberName et clientRelationshipNumberName")
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtManagementLevel(),  "Text", cmpEqual, clientProfile)
              aqObject.CheckProperty(Get_WinRQS_AlertDetailSection_ClientNumberName(),  "Text", cmpEqual, clientNumberName)             
              aqObject.CheckProperty(Get_WinRQS_AlertDetailSection_AccountNumberName(), "Text", cmpEqual, accountNumberName)
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtCliRelNumName(),    "Text", cmpEqual, clientRelationshipNumberName)
              
              Log.Message("Valider les champs: clientRelationshipTotalValue, totalNetWorth, annualIncome, proIndicator, investementKnowledge, nonResidentIndicator, residenceLocation")
              // clientRelationshipTotalValue est trouvée en maillant l'alerte dans le module relation           
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtClientRelTotalValue(),        "Text", cmpEqual, clientRelationshipTotalValue)
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtTotalNetWorth(),              "Text", cmpEqual, totalNetWorth)
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtAnnualIncome(),               "Text", cmpEqual, annualIncome);
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtProIndicor(),                 "Text", cmpEqual, proIndicator);                  
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestKnowledge(),            "Text", cmpEqual, investementKnowledge)
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtNonResidentIndicator(),       "Text", cmpEqual, nonResidentIndicator)
              aqObject.CheckProperty(Get_WinRQS_AlertDetailSection_TxtResidenceLocation(), "Text", cmpEqual, residenceLocation);
              
              Log.Message("Valider les champs: incomePourcentage, shortTerm, mediumTerm et longTerm");
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtIncome(),     "Text", cmpEqual, incomePourcentage);  
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtShortTerm(),  "Text", cmpEqual, shortTerm)
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtMediumTerm(), "Text", cmpEqual, mediumTerm)
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtLongTerm(),   "Text", cmpEqual, longTerm);
              
              Log.Message("Valider les champs: low, medium et high");
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestRiskLow(),    "Text", cmpEqual, low);               
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestRiskMedium(), "Text", cmpEqual, medium)
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtInvestRiskHigh(),   "Text", cmpEqual, high)
              
              Log.Message("Valider les champs: actualLow, actualMedium et actualHigh");
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtActualInvestRiskLow(),   "Text", cmpEqual, actualLow);
              aqObject.CheckProperty(Get_WinRQS_AlertDetailSection_TxtActualMedium(), "Text", cmpEqual, actualMedium);
              aqObject.CheckProperty(Get_WinRQS_AlertDetailSection_TxtActualHigh(),   "Text", cmpEqual, actualHigh);
              
              Log.Message("Valider les champs: branchCodeName, newIACodeName et oldIACodeName");
              //newIACodeName est trouvée en maillant l'alerte dans le module Comptes
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtBrancheCode(),            "Text", cmpEqual, branchCodeName);
              aqObject.CheckProperty(Get_WinRQS_PadAlerts_TxtIACode(),                 "Text", cmpEqual, newIACodeName);
              aqObject.CheckProperty(Get_WinRQS_AlertDetailSection_TxtOldIACodeName(), "Text", cmpEqual, oldIACodeName);                
                       
            }
            catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
              //Fermer Croesus
              Terminate_CroesusProcess(); 
              Terminate_IEProcess();
            }
}              