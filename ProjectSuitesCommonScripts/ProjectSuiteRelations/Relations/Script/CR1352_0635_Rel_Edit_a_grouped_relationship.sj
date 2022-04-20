//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions



/**
    Description : Modifier une relation groupée
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-635
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0635_Rel_Edit_a_grouped_relationship()
{
    
    try {
        var groupedRelationship_name = "GRP_REL0635";
        var updatedFullName = "UPDATED_GRPREL0635";
        
        Login(vServerRelations, userName, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        
        //Créer la relation groupée
        CreateGroupedRelationship(groupedRelationship_name);
        
        
        //Vérifier dans l'onglet Détails du grid principal des valeurs par défaut de la relation groupée
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);        
        
        WaitObject(Get_barToolbar(),"Uid", "Uid", "ToolbarButton_9b3d", 10);
        SearchRelationshipByName(groupedRelationship_name);
        
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", groupedRelationship_name, 10);
        SetAutoTimeOut();
        if (searchResultRelationship.Exists == false){
            Log.Error("The relationship " + groupedRelationship_name + " was not displayed.");
            return false;
        }
        RestoreAutoTimeOut();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", groupedRelationship_name, 10).Click();
        
        aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_TxtFullName(), "Text", cmpEqual, groupedRelationship_name);
        aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtSegmentation(), "Text", cmpEqual, "");
        aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtContactPerson(), "Text", cmpEqual, " ");
        aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtAccountManager(), "Text", cmpEqual, " ");
        aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtCommunication(), "Text", cmpEqual, "");
        
        
        //Modifier des informations de la relation groupée
        
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", groupedRelationship_name, 10).DblClick();
        
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(updatedFullName);
        
        Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation().set_IsDropDownOpen(true);
        Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation_ItemA().Click();
        
        Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson().set_IsDropDownOpen(true);
        Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson_ItemNicolasCopernic().Click();
        
        Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager().set_IsDropDownOpen(true);
        Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager_ItemNicolasCopernic().Click();
        
        Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication().set_IsDropDownOpen(true);
        Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication_ItemEmail().Click();
        
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog", 1]);
        
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        
        //Vérifier dans l'onglet Détails du grid principal que les modifications ont été prises en compte
        
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", groupedRelationship_name, 10).Click();
        
        aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_TxtFullName(), "Text", cmpEqual, updatedFullName);
        aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtSegmentation(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 42, language));
        aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtContactPerson(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 43, language));
        aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtAccountManager(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 44, language));
        aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtCommunication(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 45, language));
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        Get_MainWindow().Maximize();
        DeleteRelationship(groupedRelationship_name);
        Terminate_CroesusProcess();
    }
    
}