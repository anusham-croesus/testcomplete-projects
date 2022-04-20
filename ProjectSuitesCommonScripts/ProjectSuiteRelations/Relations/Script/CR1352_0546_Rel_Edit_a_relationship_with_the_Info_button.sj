//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions



/**
    Description : Valider la modification d'une relation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-546
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0546_Rel_Edit_a_relationship_with_the_Info_button()
{
    //var UniqueID = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
    var relationshipName = "REL0546";
    var updatedFullName = "UPDATED_REL0546";
    
    
    try {
        
        Login(vServerRelations, userName, psw, language);
        
        //Créer une relation
        CreateRelationship(relationshipName);
        
        //Mettre à jour le nom complet de la relation
        Log.Message("Update the full name of the relationship " + relationshipName);
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        SearchRelationshipByName(relationshipName);
        var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "QuickSearchWindow_b326");
        SetAutoTimeOut();
        if (searchResult.Exists == false){
            Log.Error("The relationship " + relationshipName + " was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        Get_RelationshipsBar_BtnInfo().Click();
        
        Log.Message("Verify that the 'Relationship Info' window is displayed.");
        SetAutoTimeOut(30000);
        if (!(Get_WinDetailedInfo().Exists)){
            Log.Error("The 'Relationship Info' window was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpStartsWith, GetData(filePath_Relations, "CR1352", 7, language));
        
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(updatedFullName);
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog", 1]);
        
        //Vérifier que la relation a été modifiée
        Log.Message("Verify that the relationship " + relationshipName + " was updated");
        Get_ModulesBar_BtnRelationships().Click();
        
        
        var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SearchRelationshipByName(relationshipName);
        SetAutoTimeOut();
        if (searchResult.Exists == false){
            Log.Error("The relationship " + relationshipName + " was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsBar_BtnInfo().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "Text", cmpEqual, updatedFullName);
        Get_WinDetailedInfo_BtnOK().Click();
        
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