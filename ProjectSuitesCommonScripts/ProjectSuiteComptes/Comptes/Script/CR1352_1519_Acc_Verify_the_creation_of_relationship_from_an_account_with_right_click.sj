//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions
//USEUNIT DBA


/**
    Description : Vérifier la création de relation à partir d'un compte avec clique droit
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1519
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_1519_Acc_Verify_the_creation_of_relationship_from_an_account_with_right_click()
{
    var accountNo = "800228-FS";
    var relationshipName = "TEST_RELATION"
    
    try {
        
        Login(vServerAccounts, userName, psw, language);
        
        //Créer une relation à partir du clic droit sur le compte
        Get_ModulesBar_BtnAccounts().Click();
        SelectAccounts(accountNo);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).ClickR();
        
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship().Click();
        
        Get_WinAssignToARelationship_BtnYes().Click();
        
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName);
        
        Get_WinDetailedInfo_BtnOK().Click();
        
        //WinCreateRelationship  
        var titreFenetreCreerRelation = GetData(filePath_Relations,"WinCreateRelationship",2,language)
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WndCaption"], ["HwndSource", titreFenetreCreerRelation]);
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13); //Fermer le filtre
        
        //Vérifier si la relation a été créée
        Get_ModulesBar_BtnRelationships().Click();

        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        if (SearchResult.Exists == true){
            Log.Checkpoint("The relationship " + relationshipName + " has been created.");
        }
        else {
            Log.Error("The relationship " + relationshipName + " was not created.");
        }
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Log.Message("Delete relationship " + relationshipName + " ...");
        Login(vServerAccounts, userName, psw, language);
        DeleteRelationship(relationshipName);
        Terminate_CroesusProcess();
    }
    
}