//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions



/**
    Description : Supprimer plusieurs relations en même temps
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-634
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0634_Rel_Delete_multiple_relationships_at_once()
{
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
        
        //Sélectionner toutes les relations ajoutées puis cliquer sur le bouton Supprimer
        Log.Message("Select all the added relationships and click on the Delete button.");

        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
        for (var i = 0; i < count; i++){
            var displayedRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_ShortName();
            var found = false;
            for (var j = 0; j < arrayOfRelationships.length; j++){
                if (displayedRelationshipName == arrayOfRelationships[j]){ 
                    found = true;
                    break;
                }
            }
        
            if (found){
                Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true);
            }
            else {
                Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(false);
            }
        
        }
        
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
        Log.Message("La fenêtre de confirmation de suppression de relation est différente entre BNC et US, une anomalie en attente qui sera ouverte par Sofia");
		    var width = Get_DlgConfirmation().Get_Width();
			  Get_DlgConfirmation().Click((width*(1/3)),73); 
        
        //Vérifier si la suppression des relations a été effectuée
        Log.Message("Verify that all the added relationships were actually deleted.");
        SetAutoTimeOut();
        for (var j = 0; j < arrayOfRelationships.length; j++){
            var relationshipSearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", arrayOfRelationships[j], 10);
            Log.Message("CROES-7871")
            
            if (relationshipSearchResult.Exists){
                Log.Error("'" + arrayOfRelationships[j] + "' relationship not deleted. This is not expected.");
            }
            else {
                Log.Checkpoint("'" + arrayOfRelationships[j] + "' relationship deleted.");
            }
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