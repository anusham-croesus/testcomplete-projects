//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions



/**
    Description : Modification d'informations de clients liés à une relation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-585
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0585_Rel_Update_client_bound_to_a_relationship()
{
    //var UniqueID = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
    var relationshipName = "REL0585";
    var clientName = "CLT_EXT0585";
    var accountName = clientName;
    var updatedFullName = "UPDATED_EXTCLT0585";
    
    
    try {
        
        Login(vServerRelations, userName, psw, language);
        
        CreateRelationship(relationshipName);
        
        CreateExternalClient(clientName);
        
        
        //Créer un compte externe
        
        Log.Message("Create an external account (" + clientName + ").");
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnAdd().Click();
        resultClientSearch = Get_WinPickerWindow().FindChild("Value", clientName, 10);
        SetAutoTimeOut();
        if (resultClientSearch.Exists == false){
            Log.Error("Client " + clientName + " not found in the picker window.");
            return;
        }
        RestoreAutoTimeOut();
        Get_WinPickerWindow().FindChild("Value", clientName, 10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAccountInfo_BtnOK().Click();
        
        
        //Associer le client externe à la relation
        
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        Log.Message("Join the client " + clientName + " to the relationship " + relationshipName + ".");
        SearchRelationshipByName(relationshipName);
        var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SetAutoTimeOut();
        if (searchResultRelationship.Exists == false){
            Log.Error("The relationship " + relationshipName + " was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        Get_Toolbar_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","ContextMenu_8804");
        Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship().Click();
        WaitObject(Get_CroesusApp(),"Uid","PickerBase_dcbf");
        Sys.Keys(clientName);
        Get_WinQuickSearch_TxtSearch().SetText(clientName);
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToARelationship_BtnYes().Click()
        
        
        //Accéder au module Relations et sélectionner le nom du client dans la hiérarchie d'une relation
        
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
        
        var accountsHierarchy = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Description", GetData(filePath_Relations, "CR1352", 29, language), 10).FindChild(["ClrClassName", "DataContext.DataItem.Name"], ["DataRecordPresenter", accountName], 10);
        
        if (!(accountsHierarchy.IsExpanded)){
            accountsHierarchy.Click(4, 10); //Cliquer sur le +
        }
        
        var ownersHierarchy = accountsHierarchy.FindChild("Description", GetData(filePath_Relations, "CR1352", 30, language), 10).FindChild("OriginalValue", clientName, 10);
        
        //Clic droit puis Info
        ownersHierarchy.ClickR();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Info().Click();
        
        //Vérifier que la fenêtre Info Client est ouverte et le cas échéant mettre à jour le nom complet
        Log.Message("Verify that the 'Client Info' window is displayed.");
        SetAutoTimeOut();
        if (!(Get_WinDetailedInfo().Exists)){
            Log.Error("The 'Client Info' window was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpStartsWith, clientName);
    
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(updatedFullName);
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog", 1]);
        
        
        //Vérifier que le client a été modifié
        ownersHierarchy.ClickR();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Info().Click();
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
        DeleteClient(clientName);
        Terminate_CroesusProcess();
    }
        
}