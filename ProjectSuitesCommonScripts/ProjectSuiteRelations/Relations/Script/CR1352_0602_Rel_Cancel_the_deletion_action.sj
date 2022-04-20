//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions



/**
    Description : Annuler l'action de suppression
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-602
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0602_Rel_Cancel_the_deletion_action()
{
    var randomRelationship;
    var nbOfRelationships = 5;
    var arrayOfRelationships = new Array();    
    
    try {
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Ajouter plusieurs relations
        Log.Message("Add " + nbOfRelationships + " relationships.");
        for (var i = 0; i < nbOfRelationships; i++){
            relationshipName = "TEST_RELATION_" + i;
            arrayOfRelationships.push(relationshipName);
            CreateRelationship(relationshipName);
        }
        
        //Choisir aléatoirement une relation à supprimer
        var randomIndex = Math.round(Math.random()*(arrayOfRelationships.length - 1))
        randomRelationship = arrayOfRelationships[randomIndex];
        
        //Sélectionner la relation à supprimer puis cliquer sur le bouton Supprimer
        Log.Message("Select a random relationship : '" + randomRelationship + "' and click on the Delete button.");
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        //Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        //Delay(2000);
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
        
        //Annuler la suppression en cliquant sur Annuler
        Log.Message("Cancel the deletion action by clicking on the Cancel button.");
        Log.Message("La fenêtre de confirmation de suppression de relation est différente entre BNC et US: CROES-7871");
		    var width = Get_DlgConfirmation().Get_Width();
			  Get_DlgConfirmation().Click((width*(2/3)),73); 
        
        //Vérifier que la suppression n'a pas été effectuée
        Log.Message("Verify that '" + randomRelationship + "' relationship was not deleted.");
        var relationshipSearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", randomRelationship, 10);
        SetAutoTimeOut();
        if (relationshipSearchResult.Exists){
            Log.Checkpoint("'" + randomRelationship + "' relationship not deleted. This is expected.");
        }
        else {
            Log.Error("'" + randomRelationship + "' relationship deleted. This is not expected.");
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