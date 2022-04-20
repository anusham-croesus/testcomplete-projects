//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions



/**
    Description : Valider le fonctionnement de l'icône Info
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-581
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0581_Rel_Validate_operation_of_the_Info_icon()
{
    
    try {
        //var UniqueID = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
        var relationshipName = "REL0581";
        
        Login(vServerRelations, userName, psw, language);
        
        
        //Créer la relation
        CreateRelationship(relationshipName);
        
        
        //Sélectionner la relation et cliquer le bouton Info
        
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        SearchRelationshipByName(relationshipName);
        var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SetAutoTimeOut();
        if (searchResultRelationship.Exists == false){
            Log.Error("The relationship " + relationshipName + " was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        
        Get_RelationshipsBar_BtnInfo().Click();
        
        Log.Message("Verify that the 'Relationship Info' window is displayed.");
        SetAutoTimeOut(30000);
        if (!(Get_WinDetailedInfo().Exists)){
            Log.Error("The 'Relationship Info' window was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpStartsWith, GetData(filePath_Relations, "CR1352", 48, language));
        
        
        //Verifier que les informations sur la fenêtre Info concernent la relation sélectionnée
        
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "Text", cmpEqual, relationshipName);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName(), "Text", cmpEqual, relationshipName);
        
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