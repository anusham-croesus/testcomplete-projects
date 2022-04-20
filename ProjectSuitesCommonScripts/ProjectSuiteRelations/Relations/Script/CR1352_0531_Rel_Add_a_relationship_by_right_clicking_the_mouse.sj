//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT CR1352_0530_Rel_Add_a_relationship_with_the_plus_button




/**
    Description : Valider l'ajout d'une relation par le menu droit de la souris
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-531
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0531_Rel_Add_a_relationship_by_right_clicking_the_mouse()
{
    var relationshipName = "TEST_RELATION";
    
    
    try {
        
        Login(vServerRelations, userName, psw, language);
        var TitleWinAddRelatioShip=GetData(filePath_Relations,"WinCreateRelationship",2,language)
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        
        //Ajouter une relation par le clic droit de la souris
        Log.Message("Add the relationship \"" + relationshipName + "\" by right-clicking the mouse.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SearchRelationshipByName(relationshipName);
        SetAutoTimeOut();
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + relationshipName + "\" already exists.");
            return;
        }
        else {
            Get_RelationshipsClientsAccountsGrid().ClickR();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["ContextMenu", true, true]);
               
            Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
           WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["ContextMenu", true, true]);
               
            Get_RelationshipsGrid_ContextualMenu_Add_AddNewRelationship().Click();
             WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]);         
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName);
            Get_WinDetailedInfo_BtnOK().Click();
             WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WndCaption"],["HwndSource", TitleWinAddRelatioShip]);
  
        }
        RestoreAutoTimeOut();
        
        //Vérifier que la relation a été correctement ajoutée
        CheckExistenceOfRelationship(relationshipName);
        
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