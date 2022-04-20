//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions



/**
    Description : Valider la recherche des relations avec raccourci clavier
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-584
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0584_Rel_Validate_the_relationships_search_with_keyboard_shortcut()
{
    
    try {
        var relationshipName;
        
//        if (client == "RJ"){ le script a été corrigé suite à la nouvelle BD de RJ
//            relationshipName = "CLIENTS RELATION";
//        }
//        else {
            relationshipName = "#3 TEST";
//        }
    
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Appuyer sur une touche texte aléatoire et vérifier que la fenêtre Rechercher est affichée avec l'option Nom sélectionné
        DisplayWinQuickSearchByHittingARandomAlphabeticalCharacter();

        //Valider la recherche d'une relation
        ValidateRelationshipNameSearch(relationshipName);

    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
    }
}




function DisplayWinQuickSearchByHittingARandomAlphabeticalCharacter()
{
    //Appuyer sur une touche texte aléatoire et vérifier que la fenêtre Rechercher est affichée avec l'option Nom sélectionné
        
    randomCharacter = Chr(Math.round(Math.random()*(122-97)+97));
    Log.Message("Hit a random alphabetical character : " + aqString.ToUpper(randomCharacter));
    Get_RelationshipsClientsAccountsGrid().Keys(randomCharacter);
      SetAutoTimeOut();  
    if (!(Get_WinQuickSearch().Exists)){
        Log.Error("The Quick Search window was not displayed.");
        return;
    }
      RestoreAutoTimeOut();  
    Log.Checkpoint("The Quick Search window was displayed.");
    
    if (!(Get_WinRelationshipsQuickSearch_RdoName().IsChecked)){
        Log.Error("The 'Name' option was not selected.");
        return;
    }
        
    Log.Checkpoint("The 'Name' option was selected.");
}




function ValidateRelationshipNameSearch(relationshipName)
{
    //Saisir le nom de la relation recherchée
    
    Log.Message("Hit the name of the relationship : " + relationshipName);
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(relationshipName);
    
    var displayedSearchText = Get_WinQuickSearch_TxtSearch().Text;
    if (displayedSearchText != relationshipName){
        Log.Error("The search textbox content was not " + relationshipName + ", got " + displayedSearchText);
        return;
    }
    
    Log.Checkpoint("The search textbox content was " + relationshipName);
    
    
    //Valider avec OK et vérifier le résultat de la recherche
    
    Get_WinQuickSearch_BtnOK().Click();
    
    var rowCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
    
    for (var i = 1; i <= rowCount; i++){
        var displayedRelationshipName = Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", i).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").DataContext.DataItem.get_ShortName();
        var isDisplayedRelationshipActive = Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("DataRecordPresenter", "", (i + 0)).WPFObject("RecordSelector", "", 1).IsActive;
        if (displayedRelationshipName == relationshipName && isDisplayedRelationshipActive){
            Log.Checkpoint("The arrow was positioned on '" + relationshipName + "' relationship.");
            return
        }
    }
        
    Log.Error("The arrow was not positioned on '" + relationshipName + "' relationship.");
}