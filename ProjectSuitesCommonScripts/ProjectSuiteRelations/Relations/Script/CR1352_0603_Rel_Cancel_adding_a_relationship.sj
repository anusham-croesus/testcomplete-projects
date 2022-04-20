//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables




/**
    Description : Annuler l'ajout d'une relation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-603
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0603_Rel_Cancel_adding_a_relationship()
{
    var relationshipName = "TEST_RELATION";
    
    
    try {
        var TitleWinAddRelatioShip=GetData(filePath_Relations,"WinCreateRelationship",2,language)
        
        Login(vServerRelations, userName, psw, language);
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        
        //Ajouter une relation par le bouton "+" puis cliquer sur Annuler
        Log.Message("Add the relationship \"" + relationshipName + "\" with the 'Add' button.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SetAutoTimeOut();
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + relationshipName + "\" already exists.");
            return;
        }
        else {
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["AddDropDownMenu", true, true]);
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]); 
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName);
            Get_WinDetailedInfo_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniButton", 2]);	
        }
        
        
        //Vérifier que la relation n'a pas été ajoutée
        Log.Message("Verify that the relationship \"" + relationshipName + "\" was not added.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
       
        if (SearchResult.Exists == true){
            Log.Error("The relationship \"" + relationshipName + "\" was added. This is not expected.");
        }
        else {
            Log.Checkpoint("The relationship \"" + relationshipName + "\" was not added.");
        }
        RestoreAutoTimeOut();
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