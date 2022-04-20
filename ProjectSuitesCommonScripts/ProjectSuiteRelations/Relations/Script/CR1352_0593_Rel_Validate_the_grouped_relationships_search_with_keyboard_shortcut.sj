//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT CR1352_0584_Rel_Validate_the_relationships_search_with_keyboard_shortcut



/**
    Description : Valider la recherche des relations groupées par raccourci clavier
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-593
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0593_Rel_Validate_the_grouped_relationships_search_with_keyboard_shortcut()
{
    var groupedRelationshipName;
    var nbOfGroupedRelationships = 5;
    var arrayOfGroupedRelationships = new Array();    
    
    try {
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        //Ajouter plusieurs relations groupées
        for (var i = 0; i < nbOfGroupedRelationships; i++){
            groupedRelationshipName = "GROUP_RELATION_" + i;
            arrayOfGroupedRelationships.push(groupedRelationshipName);
            CreateGroupedRelationship(groupedRelationshipName);
        }
        
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["UniDialog",1]);
        //Choisir aléatoirement une relation groupée à rechercher
        var randomIndex = Math.round(Math.random()*(arrayOfGroupedRelationships.length - 1))
        groupedRelationshipName = arrayOfGroupedRelationships[randomIndex];
        
        //Appuyer sur une touche texte aléatoire et vérifier que la fenêtre Rechercher est affichée avec l'option Nom sélectionné
        DisplayWinQuickSearchByHittingARandomAlphabeticalCharacter();
        
        //Valider la recherche d'une relation groupée
        ValidateRelationshipNameSearch(groupedRelationshipName);
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        
        for (var i = 0; i < arrayOfGroupedRelationships.length; i++){
            DeleteRelationship(arrayOfGroupedRelationships[i]);
        }
        
        Terminate_CroesusProcess();
    }
}