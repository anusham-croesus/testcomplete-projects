//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      Dans le module client
                      Sélectionner un client 
                      Dans la section détails, sélectionner un client racine
                      Faire un click droit et choisir Associer 
                      Croesus Crash 
                      Note , Le meme crash est obtenu pour les détenteurs dans la section détails du module comptes 
                      et la meme chose aussi dans le module relations,


    Auteur : Sana Ayaz
    Anomalie:CROES-11731
    Version de scriptage:ref90-10-Fm-6--V9-croesus-co7x-1_5_565
*/
function CROES_11731_CompCrashApplicaWhenYouClickOnButtonApplyThenOkInTabCashManagement()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ACCOUNT_WITHDRAWAL_CASH", "YES", vServerAccounts);
        RestartServices(vServerAccounts);
        //Se connecter avec KEYNEJ
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
       
        var Comp800241GT=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "Comp800241GT", language+client);
        var frequenceMensuelleCROES11731=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "frequenceMensuelleCROES11731", language+client);
        var MontantCADCROES11731=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Anomalies", "MontantCADCROES11731", language+client);//MontantCADCROES11731
      
        /*Dans le module compte
        Sélectionner un compte 
        */
        Get_ModulesBar_BtnAccounts().Click();
        
        Search_Account(Comp800241GT);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", Comp800241GT, 10).Click();
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabCashManagement().Click();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_CmbFrequency1().set_Text(frequenceMensuelleCROES11731);
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_TxtAmountCAD1().set_Text(MontantCADCROES11731);
          if(language == "french")
          {
           var datDebutFrequence=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d")
           Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Click();
           Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Keys(VarToString(datDebutFrequence))
          } 
        else
          {
              var datDebutFrequence=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y")
              Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Click();
           Get_WinAccountInfo_TabCashManagement_GrpCashManagement_DtpStartDate1().Keys(VarToString(datDebutFrequence))
          } 
        //Click sur le bouton Appliquer 
        Get_WinAccountInfo_BtnApply().Click();
        //Click sur le bouton OK
        Get_WinAccountInfo_BtnOK().Click();
        
        //Les points de vérifications
        errorDialogBoxDisplayed = Get_DlgError().Exists;
       if (errorDialogBoxDisplayed){
            Log.Error("Croesus crashed.")
            Log.Error("CROES-11731");
            Get_DlgError_BtnOK().Click();
        }
        else
            Log.Checkpoint("No crash detected.")
        
     
       
     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(Comp800241GT);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", Comp800241GT, 10).Click();
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabCashManagement().Click();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_BtnClear1().Click()
        Get_WinAccountInfo_BtnOK().Click();
        Terminate_CroesusProcess(); //Fermer Croesus
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ACCOUNT_WITHDRAWAL_CASH", "NO", vServerAccounts);
        RestartServices(vServerAccounts);
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(Comp800241GT);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", Comp800241GT, 10).Click();
        Get_AccountsBar_BtnInfo().Click();
        Get_WinAccountInfo_TabCashManagement().Click();
        Get_WinAccountInfo_TabCashManagement_GrpCashManagement_BtnClear1().Click()
        Get_WinAccountInfo_BtnOK().Click();
        Terminate_CroesusProcess(); //Fermer Croesus
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ACCOUNT_WITHDRAWAL_CASH", "NO", vServerAccounts);
        RestartServices(vServerAccounts);
        
    }
}