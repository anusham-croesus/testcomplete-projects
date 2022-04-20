//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CR1352_0613_Rel_Error_when_adding_a_fictitious_account_to_a_relationship_assigned_to_a_model



/**
    Description : Erreur lors de l'ajout d'un compte à une relation A si ce compte est deja associé à la relation B. Les relations A et B doivent être dans une relation groupée
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-614
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0614_Rel_Error_when_adding_account_to_relationship_B_if_account_is_already_assigned_to_relationship_A()
{
    
    try {
        var relationshipA_name = "REL_A0614";
        var relationshipB_name = "REL_B0614";
        var groupedRelationship_name = "GRP_REL0614";
        var realAccountNo = "800241-FS";
        
        Login(vServerRelations, userName, psw, language);
        
        
        //Créer les relations
        CreateRelationship(relationshipA_name);
        CreateRelationship(relationshipB_name);
        CreateGroupedRelationship(groupedRelationship_name);
        
        
        //Associer les relations à la relation groupée
        JoinToAGroupedRelationship(relationshipA_name, groupedRelationship_name);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        JoinToAGroupedRelationship(relationshipB_name, groupedRelationship_name);
        
        
        //Assigner le compte realAccountNo à la relation A
        JoinAccountToRelationship(realAccountNo, relationshipA_name);
        
        
        //Tenter d'assigner le compte realAccountNo à la relation B
        var errorMessage = GetData(filePath_Relations, "CR1352", 36, language);
        JoinAccountToRelationshipAndCheckErrorMessage(realAccountNo, relationshipB_name, errorMessage);
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(relationshipA_name);
        DeleteRelationship(relationshipB_name);
        DeleteRelationship(groupedRelationship_name);
        Terminate_CroesusProcess();
    }
    
}
