//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1917_Croes_4733_Acc_ValidateBehaviorForFictitiousAccounts


/**
    Assurer l’intégrité de l’information des comptes réels PREF=YES - Par la succursale
    Module      : Comptes
    CR          : 1917
    Cas de test : Croes-4735
    
    Préconditions: 
                PREF_EDIT_ACCOUNT : SYSADM, FIRMADM, HELPDSK, BRMAN, REP, ASSIST
                Succursale: Laval - COPERN (REP) : PREF_EDIT_REAL_ACCOUNT_ASC_CODE = YES
                Succursale: Toronto - ADAMSJ (ASSIST) : PREF_EDIT_REAL_ACCOUNT_ASC_CODE = NO

    Description : vérifier la visibilité du champs sous-type

    Auteur :                Abdel Matmat
    Version de scriptage:	90-08-Dy-2
    
*/


function CR1917_Croes_4735_Acc_EnsuringIntegrityOfRealAccount() {
         
          try {
              
                    //lien pour TestLink
                    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4735","Lien du Cas de test sur Testlink");
                    
                    //Mettre la pref PREF_EDIT_REAL_ACCOUNT_ASC_CODE = YES et PREF_EDIT_ACCOUNT : SYSADM, FIRMADM, HELPDSK, BRMAN, REP, ASSIST
                    Activate_Inactivate_PrefFirm("Firm_1", "PREF_EDIT_ACCOUNT","SYSADM,FIRMADM,HELPDSK,BRMAN,REP,ASSIST", vServerAccounts);
                    Activate_Inactivate_PrefBranch("BD","PREF_EDIT_REAL_ACCOUNT_ASC_CODE", "YES", vServerAccounts);
                    Activate_Inactivate_PrefBranch("AC","PREF_EDIT_REAL_ACCOUNT_ASC_CODE", "NO", vServerAccounts);
                    RestartServices(vServerAccounts);
          
                    var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
                    var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
                    var userNameDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
                    var passwordDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "psw");
                    var userNameADAMSJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ADAMSJ", "username");
                    var passwordADAMSJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ADAMSJ", "psw");
                    var account1 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4735_Account1", language+client);
                    var account2 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4735_Account2", language+client);
                    var account3 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4735_Account3", language+client);
                    var comboPosition = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4735_ComboPosition", language+client);
          
                    //Login avec COPERN et acceder au module compte
                    Login(vServerAccounts, userNameCOPERN, passwordCOPERN, language);
                    Get_ModulesBar_BtnAccounts().Click();
                    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Selectionner le compte 800217-SF
                    SelectAccounts(account1);
                    
                    //Cliquer sur le bouton Info
                    Get_AccountsBar_BtnInfo().Click();
                    WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]);
                    
                    //Valider le combo Sous-Type
                    validateComboSubType(comboPosition);
                    Get_WinDetailedInfo().Close(); 
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    
                    //Login avec DALTOJ et acceder au module compte
                    Login(vServerAccounts, userNameDALTOJ, passwordDALTOJ, language);
                    Get_ModulesBar_BtnAccounts().Click();
                    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Selectionner le compte 800232-FS
                    SelectAccounts(account2);
                    
                    //Cliquer sur le bouton Info
                    Get_AccountsBar_BtnInfo().Click();
                    WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]);
                    
                    //Valider le combo Sous-Type
                    validateComboSubType(comboPosition);
                    Get_WinDetailedInfo().Close(); 
                    
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    
                    //Login avec ADAMSJ et acceder au module compte
                    Login(vServerAccounts, userNameADAMSJ, passwordADAMSJ, language);
                    Get_ModulesBar_BtnAccounts().Click();
                    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
                    Get_MainWindow().Maximize();
                    
                    //Selectionner le compte 900051-NA
                    SelectAccounts(account3);
                    
                    //Cliquer sur le bouton Info
                    Get_AccountsBar_BtnInfo().Click();
                    WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]);
                    
                    // Valider que le combo Sous-Type box n'est pas disponible
                    Log.Message("Valider que le combo Sous-Type est inactif");
                    if (language == "french"){
                        aqObject.CheckProperty(Get_WinDetailedInfo().WPFObject("UniGroupBox", "Compte", 1).WPFObject("CFComboBox", "", comboPosition), "Enabled", cmpEqual, false);
                    }else{
                        aqObject.CheckProperty(Get_WinDetailedInfo().WPFObject("UniGroupBox", "Account", 1).WPFObject("CFComboBox", "", comboPosition), "Enabled", cmpEqual, false);
                    }
                    Get_WinDetailedInfo().Close(); 
                  
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 
                    // Close Croesus 
                    Terminate_CroesusProcess();
                    Terminate_IEProcess();
                    
                    //Mettre les prefs à l'état initial
                    Activate_Inactivate_PrefFirm("Firm_1", "PREF_EDIT_ACCOUNT","SYSADM", vServerAccounts);
                    Activate_Inactivate_PrefBranch("AC","PREF_EDIT_REAL_ACCOUNT_ASC_CODE", "YES", vServerAccounts);
                    RestartServices(vServerAccounts);
          }
}

