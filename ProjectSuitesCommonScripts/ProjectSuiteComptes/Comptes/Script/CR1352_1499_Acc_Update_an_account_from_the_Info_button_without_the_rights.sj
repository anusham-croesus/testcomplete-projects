//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    Description : Modifier un compte à partir du bouton Info (sans les droits)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1499
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1499_Acc_Update_an_account_from_the_Info_button_without_the_rights()
{
    var userWithoutRights = userName;
    
    try {
    
        //Activate_Inactivate_Pref(userWithoutRights, "PREF_EDIT_ACCOUNT", "NO", vServerAccounts);
    
        Login(vServerAccounts, userWithoutRights, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_AccountsBar_BtnInfo().Click();
        
        if (Get_WinAccountInfo_GrpAccount_TxtShortName().IsReadOnly){
            Log.Checkpoint("The short name field is read only.");
        }
        else {
            Log.Error("The short name field is not read only.");
        }

        Get_WinAccountInfo_BtnOK().Click();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}