//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT CR1352_0530_Rel_Add_a_relationship_with_the_plus_button




/**
    Description : Valider l'ajout d'une relation groupée
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2469
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_2469_Rel_Add_a_grouped_relationship()
{
    var groupedRelationshipName = "GROUPED_RELATION";
    
    
    try {
        
        Login(vServerRelations, userName, psw, language);
         var TitleWinAddRelatioShip=GetData(filePath_Relations,"WinCreateRelationship",2,language)
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        
        
        //Ajouter une relation groupée par le bouton "+"
        Log.Message("Add the grouped relationship \"" + groupedRelationshipName + "\" with the 'Add' button.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", groupedRelationshipName, 10);
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + groupedRelationshipName + "\" already exists.");
            return;
        }
        else {
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["AddDropDownMenu", true, true]);
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
           WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]);       
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(groupedRelationshipName);
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().Click();
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemGroupedRelation().Click();
            Get_WinDetailedInfo_BtnOK().Click();
        }
        
        
        //Vérifier que la relation groupée a été correctement ajoutée
        CheckExistenceOfRelationship(groupedRelationshipName);
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(groupedRelationshipName);
        Terminate_CroesusProcess();
    }
        
}