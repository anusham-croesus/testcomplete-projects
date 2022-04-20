//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/**
    Description : Assigner un modèle à un compte
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1621
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/
 
function CR1352_1621_Acc_Assign_a_model_to_an_account()
{
    var accountNo = "800241-FS";
   
    if(client == "US" ){ var modelNo = "~M-00008-0";}
    else if(client == "RJ" || client == "CIBC"){ var modelNo = "~M-00005-0";}
    else { var modelNo = "~M-00002-0";}
    
    Login(vServerAccounts, userName, psw, language);
    
    //Assign Account to model
    Log.Message("Assign account No '" + accountNo + "' to model No '" + modelNo + "'.");
    SelectAccounts(accountNo);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).ClickR();
    Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel().Click();
    
    var modelSearchResult = Get_WinPickerWindow().FindChild("Value", modelNo, 10);
    if (!(modelSearchResult.Exists)){
        Log.Error("Model No '" + modelNo + "' does not exist.");
        Terminate_CroesusProcess();
        return;
    }
    
    Get_WinPickerWindow().FindChild("Value", modelNo, 10).Click();
    Get_WinPickerWindow_BtnOK().Click();
    
    if (Get_WinAssignToModel_BtnClose().IsVisible){
        Log.Error("Unable to assign account No '" + accountNo + "' to model No '" + modelNo + "'.");
        Get_WinAssignToModel_BtnClose().Click();
    }
    else {
        Get_WinAssignToModel_BtnYes().Click();
        
        //Verify that the account is correctly assigned to the model
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_ModelsGrid().FindChild("Value", modelNo, 10).Click();
        FindResult = Get_Models_Details_DgvDetails().FindChild("Value", accountNo, 10);
        if (FindResult.Exists == true){
            Log.Checkpoint("Account No '" + accountNo + "' correctly assigned to model No '" + modelNo + "'.");
            Get_Models_Details_DgvDetails().FindChild("Value", accountNo, 10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click(); //CleanUp
            //Get_DlgCroesus().Click(150, 70);
            if(Get_DlgConfirmation().Exists){ 
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73);         
         }

        }
        else {
            Log.Error("Account No '" + accountNo + "' not assigned to model No '" + modelNo + "'.");
        }
    }
    
    Close_Croesus_SysMenu(); //Close Croesus
}