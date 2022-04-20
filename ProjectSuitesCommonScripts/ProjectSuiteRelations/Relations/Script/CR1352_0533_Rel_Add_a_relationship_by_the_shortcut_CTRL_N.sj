//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT CR1352_0530_Rel_Add_a_relationship_with_the_plus_button




/**
    Description : Valider l'ajout d'une relation en utilisant le raccourci "CTRL + N"
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-533
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0533_Rel_Add_a_relationship_by_the_shortcut_CTRL_N()
{
    var relationshipName = "TEST_RELATION";
    
    
    try {
        
        Login(vServerRelations, userName, psw, language);
        var TitleWinAddRelatioShip=GetData(filePath_Relations,"WinCreateRelationship",2,language)
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        
        
        //Ajouter une relation en utilisant le raccourci "CTRL + N"
        Log.Message("Add the relationship \"" + relationshipName + "\" by the shortcut CTRL + N.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SearchRelationshipByName(relationshipName);
         SetAutoTimeOut();
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + relationshipName + "\" already exists.");
            return;
        }
        else {
            Get_RelationshipsClientsAccountsGrid().Keys("^n");
           WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]); 
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName);
            Get_WinDetailedInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniButton", 2]);
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