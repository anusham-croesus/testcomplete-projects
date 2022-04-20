//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    Description : Modifier un compte externe
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1613
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1613_Acc_Update_an_external_account()
{
    var clientName = "CLIENT_EXTERNE";
    var clientFullNameUpdated = "CLIENT_EXTERNE EDITED";
    
    
    try {
    
        Login(vServerAccounts, userName, psw, language);
        
        
        //Créer un client externe
        
        CreateExternalClient(clientName);
        
        
        //Créer un compte externe
        
        Log.Message("Create an external account (" + clientName + ").");
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnAdd().Click();
        resultClientSearch = Get_WinPickerWindow().FindChild("Value", clientName, 10);
        if (resultClientSearch.Exists == false){
            Log.Error("Client " + clientName + " not found in the picker window.");
            return;
        }
        
        Get_WinPickerWindow().FindChild("Value", clientName, 10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAccountInfo_BtnOK().Click();
        
        
        //Modifier le nom complet du compte externe
        
        Log.Message("Update the full name of the external account (" + clientName + ").");
        Get_ModulesBar_BtnAccounts().Click();
        Search_AccountByName(clientName);
        resultAccountSearch = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10);
        if (resultAccountSearch.Exists == false){
            Log.Error("Account " + clientName + " not found in the accounts grid.");
            return;
        }
        
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).DblClick();
        Get_WinAccountInfo_GrpAccount_TxtFullName().set_Text(clientFullNameUpdated);
        Get_WinAccountInfo_BtnOK().Click();
        
        
        //Vérifier que la modification a été prise en compte
        
        Log.Message("Verify that the full name of the external account (" + clientName + ") was updated.");
        Get_ModulesBar_BtnAccounts().Click();
        resultAccountSearch = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10);
        if (resultAccountSearch.Exists == false){
            Log.Error("Account " + clientName + " not found in the accounts grid.");
            return;
        }
        
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientName, 10).DblClick();
        var displayedFullName = Get_WinAccountInfo_GrpAccount_TxtFullName().Text;
        if (displayedFullName == clientFullNameUpdated){
            Log.Checkpoint("Full name updated : " + displayedFullName);
        }
        else {
            Log.Error("Full name not correctly updated. Expecting '" + clientFullNameUpdated + "', got '" + displayedFullName + "'.");
        }
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerAccounts, userName, psw, language);
        DeleteClient(clientName);
        Terminate_CroesusProcess();
    }
    
}