//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions



/**
    Description : Lier des clients fictifs à une relation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-580
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0580_Rel_Join_fictitious_clients_to_a_relationship()
{
    //var UniqueID = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
    var relationshipName = "REL0580";
    var clientName = "CLT_FIC0580";
    
    
    try {
        
        Login(vServerRelations, userName, psw, language);
        
        CreateRelationship(relationshipName);
        
        CreateFictitiousClient(clientName);
        
        
        //Créer un compte fictif
        
        Log.Message("Create a fictitious account (" + clientName + ").");
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
        
        
        //Associer le client fictif à la relation
        
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        Log.Message("Join the client " + clientName + " to the relationship " + relationshipName + ".");
        
        var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SetAutoTimeOut();
        if (searchResultRelationship.Exists == false){
            Log.Error("The relationship " + relationshipName + " was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        Get_Toolbar_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","ContextMenu_8804");
        Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship().Click();
        WaitObject(Get_CroesusApp(),"Uid","PickerBase_dcbf");
        
        //Vérifier que la fenêtre Clients est ouverte
        Log.Message("Verify that he picker window is displayed.");
         SetAutoTimeOut();
        if (!(Get_WinPickerWindow().Exists)){
            Log.Error("The picker window was not displayed.");
            return;
        }
         RestoreAutoTimeOut();
        aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 24, language));
        
        //Choisir un client et cliquer sur OK
        Sys.Keys(clientName);
        Get_WinQuickSearch_TxtSearch().SetText(clientName);
        Get_WinQuickSearch_BtnOK().Click();
    
        Get_WinPickerWindow_BtnOK().Click();
        
        //Vérifier que la fenêtre "Associer à une relation" est ouverte et cliquer le cas échéant sur "Oui"
        Log.Message("Verify that the 'Assign to a relationship' window is displayed.");
        SetAutoTimeOut();
        if (!(Get_WinAssignToARelationship().Exists)){
            Log.Error("The 'Assign to a relationship' window was not displayed.");
            return;
        }
         RestoreAutoTimeOut();
        Log.Message("CROES-8807")
        aqObject.CheckProperty(Get_WinAssignToARelationship(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 25, language)); //EM : le datapool a été modifié selon le Jira CROES-8807 - avant "Associer à une nouvelle relation"
        
        Get_WinAssignToARelationship_BtnYes().Click()
        
        
        //Vérifier que l'association a été faite
        
        Log.Message("Verify that the assignment was done");
        var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SetAutoTimeOut();
        if (searchResultRelationship.Exists == false){
            Log.Error("The grouped relationship " + relationshipName + " was not displayed.");
            return;
        }
         RestoreAutoTimeOut();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        
        searchClientInHierarchyPanel = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", GetData(filePath_Relations, "CR1352", 26, language), 10).Find("OriginalValue", clientName, 10);
        SetAutoTimeOut();
        if (searchClientInHierarchyPanel.Exists == false){
            Log.Error("The account " + clientName + " was not found in the hierarchy panel of the relationship " + relationshipName + ".");
        }
        else {
            Log.Checkpoint("The account " + clientName + " was found in the hierarchy panel of the relationship " + relationshipName + ".");
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
        DeleteClient(clientName);
        Terminate_CroesusProcess();
    }
        
}