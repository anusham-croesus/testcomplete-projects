//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT CR1352_0584_Rel_Validate_the_relationships_search_with_keyboard_shortcut



/**
    Description : Valider la recherche des relations par le menu Edition
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-616
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0616_Rel_Validate_relationships_search_by_the_Edit_menu()
{
    
    try {
        var relationshipName;
        
//        if (client == "RJ"){le script a été corrigé suite à la nouvelle BD de RJ
//            relationshipName = "CLIENTS RELATION";
//        }
//        else {
            relationshipName = "#5 TEST";
//        }
        
        Login(vServerRelations, userName, psw, language);
        Get_ModulesBar_BtnRelationships().Click();
        
        
        //Cliquer sur menu Edition, puis Rechercher, vérifier que la fenêtre Rechercher est affichée et choisir l'option Nom
        Log.Message("Click the search button, check if the Quick Search window is dsplayed, and check the name option.");
        Get_MenuBar_Edit().Click();
        Get_MenuBar_Edit_Search().Click();
        
        if (!(Get_WinQuickSearch().Exists)){
            Log.Error("The Quick Search window was not displayed.");
            return;
        }
        
        Log.Checkpoint("The Quick Search window was displayed.");
        
        Get_WinRelationshipsQuickSearch_RdoName().set_IsChecked(true);
        
        
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