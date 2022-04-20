//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions



/**
    Description : Supprimer un compte d'une relation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-604
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0604_Rel_Remove_an_account_from_a_relationship()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-604", "CR1352_0604_Rel_Remove_an_account_from_a_relationship()");
    
    try {
        var relationshipName = "TEST_RELATION";
        var accountNo = "800228-FS";
        
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        
        //Créer une relation et y joindre un compte
        CreateRelationship(relationshipName);
        JoinAccountToRelationship(accountNo, relationshipName);
        
        //Sélectionner la relation
        Log.Message("Select '" + relationshipName + "' relationship.");
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        
        //Dans la hiérarchie de la relation, faire clic droit sur le compte puis Retirer de la relation
        Log.Message("In the relationship hierarchy, right-click on the the account No " + accountNo + " and click on Remove from the relationship.");
        GetRelationshipAccountsHierarchyDataRecordPresenter(accountNo).ClickR();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
        Get_DlgConfirmation_BtnContinue().Click();
        
        //Vérifier que le compte retiré ne figure plus dans la hiérarchie de la relation
        Log.Message("Check that the account No" + accountNo + " has been actually removed from the relationship hierarchy.");
        var accountsHierarchy = GetRelationshipAccountsHierarchyDataRecordPresenter(accountNo);
        SetAutoTimeOut();
        if (accountsHierarchy.Exists && accountsHierarchy.IsVisible)
            Log.Error("Account No " + accountNo + " has not been removed from " + relationshipName + " relationship.");
        else
            Log.Checkpoint("Account No " + accountNo + " has been removed from " + relationshipName + " relationship.");
         RestoreAutoTimeOut();       
        DeleteRelationship(relationshipName);
        Close_Croesus_X();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(relationshipName);
        Terminate_CroesusProcess();
    }
    finally {
        Terminate_CroesusProcess();
    }
}



function GetRelationshipAccountsHierarchyDataRecordPresenter(accountNo)
{
    var accountDescription = GetData(filePath_Relations, "CR1352", 82, language);
    var nbTriesLeft = 3;
    do {
        nbTriesLeft--;
        var PnlHierarchyPanel = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel();
        Delay(3000);
    } while (!PnlHierarchyPanel.Exists && nbTriesLeft > 0)
    SetAutoTimeOut();
    if (PnlHierarchyPanel.Exists){
        var PnlDescriptionPanel = PnlHierarchyPanel.FindChild("Description", accountDescription, 10);
        if (PnlDescriptionPanel.Exists)
            return PnlDescriptionPanel.FindChild(["ClrClassName", "DataContext.DataItem.DisplayAccountNumber"], ["DataRecordPresenter", accountNo], 10);
    }
     RestoreAutoTimeOut();
    return Utils.CreateStubObject();
}
