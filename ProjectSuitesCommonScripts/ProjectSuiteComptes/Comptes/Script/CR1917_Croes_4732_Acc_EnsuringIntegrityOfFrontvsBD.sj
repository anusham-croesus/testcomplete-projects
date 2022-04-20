//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Assurer l’intégrité de l’information des comptes réels Front vs BD
    Module      : Comptes
    CR          : 1917
    Cas de test : Croes-4732
    
    Préconditions: 
                PREF_EDIT_REAL_ACCOUNT_ASC_CODE = YES
                PREF_EDIT_ACCOUNT : SYSADM, FIRMADM, HELPDSK, BRMAN, REP, ASSIST

    Acces:
                UNI00 (SYSADM)
                KEYNEJ (FIRMADM)
                DOWNERS (HELPDSK)
                DESOUST (BRMAN)
                COPERN (REP)
                ADAMSJ (ASSIST)

    Auteur :                Abdel Matmat
    Version de scriptage:	90-08-Dy-2
    
*/


function CR1917_Croes_4732_Acc_EnsuringIntegrityOfFrontvsBD() {
         
          try {
              
                    //lien pour TestLink
                    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4732","Lien du Cas de test sur Testlink");
                    
                    //Mettre la pref PREF_EDIT_REAL_ACCOUNT_ASC_CODE = YES et PREF_EDIT_ACCOUNT : SYSADM, FIRMADM, HELPDSK, BRMAN, REP, ASSIST
                    Activate_Inactivate_PrefFirm("Firm_1", "PREF_EDIT_REAL_ACCOUNT_ASC_CODE", "YES", vServerAccounts);
                    Activate_Inactivate_PrefFirm("Firm_1", "PREF_EDIT_ACCOUNT","SYSADM,FIRMADM,HELPDSK,BRMAN,REP,ASSIST", vServerAccounts);
                    RestartServices(vServerAccounts);
          
                    var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
                    var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
                    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
                    var passworKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    var userNameDOWNERS = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DOWNERS", "username");
                    var passwordDOWNERS = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DOWNERS", "psw");
                    var userNameDESOUST = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESOUST", "username");
                    var passwordDESOUST = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESOUST", "psw");
                    var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
                    var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
                    var userNameADAMSJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ADAMSJ", "username");
                    var passwordADAMSJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ADAMSJ", "psw");
                    var account1 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4732_Account1", language+client);
                    var comboPosition1 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4732_ComboPosition1", language+client);
                    var account2 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4732_Account2", language+client);
                    var comboPosition2 = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4732_ComboPosition2", language+client);
          
                    Acc_EnsuringIntegrityOfFrontvsBD(userNameUNI00,passwordUNI00,account1,comboPosition1);
                    Acc_EnsuringIntegrityOfFrontvsBD(userNameKEYNEJ,passworKEYNEJ,account1,comboPosition1);
                    Acc_EnsuringIntegrityOfFrontvsBD(userNameDOWNERS,passwordDOWNERS,account1,comboPosition1);
                    Acc_EnsuringIntegrityOfFrontvsBD(userNameDESOUST,passwordDESOUST,account1,comboPosition2);
                    Acc_EnsuringIntegrityOfFrontvsBD(userNameCOPERN,passwordCOPERN,account1,comboPosition2);
                    Acc_EnsuringIntegrityOfFrontvsBD(userNameADAMSJ,passwordADAMSJ,account2,comboPosition2);
                    
                    
          } 
          catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                            
          }         
          finally { 
                    
                    //Mettre les prefs à l'état initial
                    Activate_Inactivate_PrefFirm("Firm_1", "PREF_EDIT_ACCOUNT","SYSADM", vServerAccounts);
                    RestartServices(vServerAccounts);
          }
}

function Acc_EnsuringIntegrityOfFrontvsBD(user,password,account,comboPosition){
        
        var plan = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4732_Plan", language+client);
        var planValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4732_PlanValue", language+client);
        var SubType = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4732_SubType", language+client);
        var planValueInitial = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1917", "CR1917_Croes_4732_PlanValueInitial", language+client);

        //Login et acceder au module compte
        Login(vServerAccounts, user, password, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
        Get_MainWindow().Maximize();
        
        //Cliquer sur le bouton Info
        Get_AccountsBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]);
                    
        //Sélectionner un sous-type (Régime enregistré d'épargne retraite)
        if (language == "french") Get_WinDetailedInfo().WPFObject("UniGroupBox", "Compte", 1).WPFObject("CFComboBox", "", comboPosition).Click();
        else Get_WinDetailedInfo().WPFObject("UniGroupBox", "Account", 1).WPFObject("CFComboBox", "", comboPosition).Click();
                    
        Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",SubType],10).Click();
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]);
                    
        //Vérifier la colonne Régime affiche "RS"
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, plan ,cmpEqual, planValue);
        
        // Vérifier la valeur dans la BD
        var field = Execute_SQLQuery_GetField("select * from B_COMPTE where NO_COMPTE = '"+account+"'" ,vServerAccounts, plan );
        if (client == "CIBC") field = aqString.Trim(field)
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, plan ,cmpEqual, field);
        
        //Remettre le compte à son état initial
        //Cliquer sur le bouton Info
        Get_AccountsBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog","1"]);
                    
        //Sélectionner un sous-type (Régime enregistré d'épargne retraite)
        if (language == "french") Get_WinDetailedInfo().WPFObject("UniGroupBox", "Compte", 1).WPFObject("CFComboBox", "", comboPosition).Click();
        else Get_WinDetailedInfo().WPFObject("UniGroupBox", "Account", 1).WPFObject("CFComboBox", "", comboPosition).Click();
                    
        Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",planValueInitial],10).Click();
        Get_WinDetailedInfo_BtnOK().Click();
        //Fermer Croesus
        Terminate_CroesusProcess();
        Terminate_IEProcess(); 
}


