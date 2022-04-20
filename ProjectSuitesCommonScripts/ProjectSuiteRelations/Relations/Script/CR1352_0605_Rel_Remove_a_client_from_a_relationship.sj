//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions



/**
    Description : Supprimer un client d'une relation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-605
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0605_Rel_Remove_a_client_from_a_relationship()
{
    
    var relationshipName = "TEST_RELATION";
    var accountNo = "800228-FS";
    var clientNo = "800228"; 
    
    try {
        
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Créer une relation et y joindre un compte
        CreateRelationship(relationshipName);
        JoinAccountToRelationship(accountNo, relationshipName);
        
        //Sélectionner la relation
        Log.Message("Select '" + relationshipName + "' relationship.");
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        
        //Dans la hiérarchie de la relation, faire clic droit sur le client puis Retirer de la relation
        Log.Message("In the relationship hierarchy, right-click on the the account No " + accountNo + " and click on Remove from the relationship.");
        var accountsHierarchy = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Description", GetData(filePath_Relations, "CR1352", 85, language), 10).FindChild(["ClrClassName", "DataContext.DataItem.DisplayAccountNumber"], ["DataRecordPresenter", accountNo], 10);
        
        
        if (!(accountsHierarchy.IsExpanded)){
            accountsHierarchy.Click(4, 10); //Cliquer sur le +
        }
        
        var ownersHierarchy = accountsHierarchy.FindChild("Description", GetData(filePath_Relations, "CR1352", 86, language), 10).FindChild("DataContext.DataItem.ClientNumber", clientNo, 10);
        ownersHierarchy.ClickR();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click();
        
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        
        //Vérifier que le compte retiré ne figure plus dans la hiérarchie de la relation. Le cas échéant, le client a été retiré de la hiérarchie de la relation
        Log.Message("Check that the account No" + accountNo + " has been actually removed from the relationship hierarchy.");
        accountsHierarchy = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Description", GetData(filePath_Relations, "CR1352", 82, language), 10).FindChild(["ClrClassName", "DataContext.DataItem.DisplayAccountNumber"], ["DataRecordPresenter", accountNo], 10);
           SetAutoTimeOut();
        if (accountsHierarchy.Exists){
            Log.Error("Account No " + accountNo + " has not been removed from " + relationshipName + " relationship.");
        }
        else {
            Log.Checkpoint("Account No " + accountNo + " has been removed from " + relationshipName + " relationship. Consequently, the client No " + clientNo + " has been removed from the " + relationshipName + " relationship hierarchy");
        }
       RestoreAutoTimeOut(); 
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(relationshipName);
        Terminate_CroesusProcess();
    }
}