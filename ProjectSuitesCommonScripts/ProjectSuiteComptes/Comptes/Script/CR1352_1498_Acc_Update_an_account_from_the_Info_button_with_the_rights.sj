//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    Description : Modifier un compte à partir du bouton Info (avec les droits)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1498
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1498_Acc_Update_an_account_from_the_Info_button_with_the_rights()
{
    var userWithRights = "GP1859";
    var accountNo = "800066-GT";
    var actualName = "APPEL BERVERLY";
    var testName = "A. BERVERLY";
    
    try {
        //Activate_Inactivate_Pref(userWithRights, "PREF_EDIT_ACCOUNT", "YES", vServerAccounts);
        var niveauAcces = "SYSADM";
        if (client == "CIBC")
            niveauAcces = "FIRMADM";        // DANS LA BD CIBC GP1859 EST TJS FIRMADM
        Activate_Inactivate_PrefFirm("Firm_1", "PREF_EDIT_ACCOUNT",niveauAcces, vServerAccounts); //EM : 90.12.18 HF : Avant c'était FIRMADM. Mnt SYSADM car GP1859 n'est plus FIRMADM 
        Activate_Inactivate_Pref(userWithRights, "PREF_DISPLAY_WHATS_NEW", "NO", vServerAccounts);
        
        if(client == "US")
            Activate_Inactivate_PrefBranch("0", "PREF_EDIT_ACCOUNT", "SYSADM", vServerAccounts);
        RestartServices(vServerAccounts);
        
        Login(vServerAccounts, userWithRights, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(accountNo);
       //SelectAccounts(accountNo);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).Click();
        //Get_AccountsBar_BtnInfo().Click();
        Get_AccountsBar_BtnInfo().DblClick();
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["UniButton", "OK"]);
        
        displayedName = Get_WinAccountInfo_GrpAccount_TxtShortName().Text;
        Log.Message("The displayed short name is : " + displayedName);
        if (displayedName != actualName)
            Log.Error("The displayed name is not the expected one ; expecting " + actualName + ", got " + displayedName);
        
        //Update the short name
        Get_WinAccountInfo_GrpAccount_TxtShortName().Keys(testName);
        Get_WinAccountInfo_BtnOK().Click();
        
        //Validate the update
        Search_Account(accountNo);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).Click();
        Get_AccountsBar_BtnInfo().Click();        
        WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlText"], ["UniButton", "OK"]);
        Get_WinAccountInfo().WaitProperty("VisibleOnScreen",true,15000);
        
        displayedName = Get_WinAccountInfo_GrpAccount_TxtShortName().Text;
        Log.Message("The new displayed short name is : " + displayedName);
        if (displayedName == testName)
            Log.Checkpoint("The new displayed short name is the expected one.");
        else
            Log.Error("The displayed name is not the expected one ; expecting " + testName + ", got " + displayedName);
        
        Get_WinAccountInfo_BtnOK().Click();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Execute_SQLQuery("update b_compte set nom='" + actualName + "' where no_compte='" + accountNo + "'", vServerAccounts);
        
        if (client == "US")
            Activate_Inactivate_PrefBranch("0", "PREF_EDIT_ACCOUNT", "", vServerAccounts);
        Activate_Inactivate_PrefFirm("Firm_1", "PREF_EDIT_ACCOUNT","SYSADM", vServerAccounts);
        Terminate_CroesusProcess();
    }
}