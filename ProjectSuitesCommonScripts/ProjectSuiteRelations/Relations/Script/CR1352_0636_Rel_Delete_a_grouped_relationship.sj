//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions



/**
    Description : Supprimer une relation groupée
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-636
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0636_Rel_Delete_a_grouped_relationship()
{
    var randomRelationship;
    var nbOfRelationships = 5;
    var arrayOfRelationships = new Array();    
    
    try {
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Ajouter plusieurs relations groupées
        Log.Message("Add " + nbOfRelationships + " relationships.");
        for (var i = 0; i < nbOfRelationships; i++){
            relationshipName = "GROUP_RELATION_" + i;
            arrayOfRelationships.push(relationshipName);
            CreateGroupedRelationship(relationshipName);
        }
        
        //Choisir aléatoirement une relation groupée à supprimer
        var randomIndex = Math.round(Math.random()*(arrayOfRelationships.length - 1))
        randomRelationship = arrayOfRelationships[randomIndex];
        
        //Sélectionner la relation à supprimer puis cliquer sur le bouton Supprimer
        Log.Message("Select a random relationship : '" + randomRelationship + "' and click on the Delete button.");
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        //Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        //Delay(2000);
        SearchRelationshipByName(randomRelationship);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", randomRelationship, 10).Click();
        Get_Toolbar_BtnDelete().Click();
        
        //Vérifier que la fenêtre de confirmation de suppression est affichée
        Log.Message("Verify that The 'Confirm Action' dialog box is displayed.");
        SetAutoTimeOut();
		    if (!(Get_DlgConfirmation().Exists)){
            Log.Error("The 'Confirm Action' dialog box not displayed. This is not expected.");
            return;
        }
        RestoreAutoTimeOut();
        Log.Checkpoint("The 'Confirm Action' dialog box displayed.");
        
        //Confirmer avec OK
        Log.Message("Confirm the deletion action by clicking on OK button.");
        Log.Message("La fenêtre de confirmation de suppression de relation est différente entre BNC et US : CROES-7871");
		    var width = Get_DlgConfirmation().Get_Width();
			  Get_DlgConfirmation().Click((width*(1/3)),73); 
        
        //Vérifier si la suppression a été effectuée
        Log.Message("Verify that '" + randomRelationship + "' relationship was actually deleted.");
        SearchRelationshipByName(randomRelationship);
        var relationshipSearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", randomRelationship, 10);
        SetAutoTimeOut();
        if (relationshipSearchResult.Exists){
            Log.Error("'" + randomRelationship + "' relationship not deleted. This is not expected.");
        }
        else {
            Log.Checkpoint("'" + randomRelationship + "' relationship deleted.");
        }
        RestoreAutoTimeOut();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        
        for (var i = 0; i < arrayOfRelationships.length; i++){
            DeleteRelationship(arrayOfRelationships[i]);
        }
        
        Terminate_CroesusProcess();
    }
}