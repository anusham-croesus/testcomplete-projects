//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA



/**
    Description : Assigner des clients réels à une relation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-548
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0548_Rel_Join_real_clients_to_a_relationship()
{
    //var UniqueID = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
    var relationshipName = "REL0548";
    var clientNumber     = "800303";
    var accountNumber    = "800303-NA";
    var clientName       = "CLT_EXT0550";
    
   // var relationshipName = "REL0549";
    var accountName      = clientName;
    var updatedFullName  = "UPDATED_EXTCLT0585";
  
    
    
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-548", "Lien vers Jira");
        Log.Message("***************************** L'étape 1 *************************************************")
        /*le script a été révisé et remplace les scripts suivants: Croes-549, Croes-550, Croes-580
           Croes-585*/  
        Login(vServerRelations, userName, psw, language);
        
        CreateRelationship(relationshipName);
        
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        Log.Message("Join the client " + clientNumber + " to the relationship " + relationshipName + ".");
        SearchRelationshipByName(relationshipName);
        var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SetAutoTimeOut();
        if (searchResultRelationship.Exists == false){
            Log.Error("The relationship " + relationshipName + " was not displayed.");
            return;
        }
         RestoreAutoTimeOut();
        Log.Message("***************************** L'étape 2 *************************************************")
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
        aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 10, language));
        Log.Message("***************************** L'étape 3 *************************************************")
        //Choisir un client et cliquer sur OK
        Sys.Keys(clientNumber);
        Get_WinQuickSearch_TxtSearch().SetText(clientNumber);
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
        aqObject.CheckProperty(Get_WinAssignToARelationship(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 11, language)); //EM : le datapool a été modifié selon le Jira CROES-8807 - avant "Associer à une nouvelle relation"

        Log.Message("***************************** L'étape 4 *************************************************")  
        Log.Message("Dans la fenêtre Association avec une relation valider avec OUI")
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
        
        searchClientInHierarchyPanel = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", GetData(filePath_Relations, "CR1352", 12, language), 10).Find("OriginalValue", accountNumber, 10);
         SetAutoTimeOut();
        if (searchClientInHierarchyPanel.Exists == false){
            Log.Error("The account number " + accountNumber + " was not found in the hierarchy panel of the relationship " + relationshipName + ".");
        }
        else {
            Log.Checkpoint("The account number " + accountNumber + " was found in the hierarchy panel of the relationship " + relationshipName + ".");
        }
        RestoreAutoTimeOut();
        Log.Message("***************************** L'étape 5 *************************************************")
        //Cas de test : Croes-549
        
        Log.Message("Join the account " + accountNumber + " to the relationship " + relationshipName + ".");
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
        Get_Toolbar_BtnAdd_AddDropDownMenu_JoinAccountsToRelationship().Click();
        WaitObject(Get_CroesusApp(),"Uid","PickerBase_dcbf");
        
        //Vérifier que la fenêtre Comptes est ouverte
        Log.Message("Verify that he picker window is displayed.");
        SetAutoTimeOut();
        if (!(Get_WinPickerWindow().Exists)){
            Log.Error("The picker window was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 15, language));
        
        //Choisir un compte et cliquer sur OK
        Sys.Keys(accountNumber);
        Get_WinQuickSearch_TxtSearch().SetText(accountNumber);
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
        aqObject.CheckProperty(Get_WinAssignToARelationship(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 16, language)); //EM : le datapool a été modifié selon le Jira CROES-8807 - avant "Associer à une nouvelle relation"
        
        Get_WinAssignToARelationship_BtnYes().Click();
        
        
        //Vérifier que l'association a été faite
        Log.Message("Verify that the assignment was done");
        var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SetAutoTimeOut();
        if (searchResultRelationship.Exists == false){
            Log.Error("The grouped relationship " + relationshipName + " was not displayed.");
            return;
        }
       
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        
        searchClientInHierarchyPanel = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", GetData(filePath_Relations, "CR1352", 15, language), 10).Find("OriginalValue", accountNumber, 10);
        if (searchClientInHierarchyPanel.Exists == false){
            Log.Error("The account number " + accountNumber + " was not found in the hierarchy panel of the relationship " + relationshipName + ".");
        }
        else {
            Log.Checkpoint("The account number " + accountNumber + " was found in the hierarchy panel of the relationship " + relationshipName + ".");
        }
        RestoreAutoTimeOut(); 
        Log.Message("***************************** L'étape 6 *************************************************") 
        
        
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
        
        //Vérifier que la fenêtre Clients est ouverte
        Log.Message("Verify that he picker window is displayed.");
        SetAutoTimeOut();
        if (!(Get_WinPickerWindow().Exists)){
            Log.Error("The picker window was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 19, language));
        
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
        aqObject.CheckProperty(Get_WinAssignToARelationship(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 20, language)); //EM : le datapool a été modifié selon le Jira CROES-8807 - avant "Associer à une nouvelle relation"
        
        Get_WinAssignToARelationship_BtnYes().Click()
        
        
        //Vérifier que l'association a été faite
        
        Log.Message("Verify that the assignment was done");
        var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SetAutoTimeOut();
        if (searchResultRelationship.Exists == false){
            Log.Error("The grouped relationship " + relationshipName + " was not displayed.");
            return;
        }
        
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        
        searchClientInHierarchyPanel = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", GetData(filePath_Relations, "CR1352", 21, language), 10).Find("OriginalValue", clientName, 10);
        if (searchClientInHierarchyPanel.Exists == false){
            Log.Error("The account " + clientName + " was not found in the hierarchy panel of the relationship " + relationshipName + ".");
        }
        else {
            Log.Checkpoint("The account " + clientName + " was found in the hierarchy panel of the relationship " + relationshipName + ".");
        }
        RestoreAutoTimeOut();
        Log.Message("***************************** L'étape 7 *************************************************")
       //  CreateExternalClient(clientName);
        
        
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
        Log.Message("***************************** L'étape 8 *************************************************")
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
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        //Execute_SQLQuery("update b_compte set lock_id = null", vServerRelations)
    }
    finally {
        Terminate_CroesusProcess();
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerRelations);
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(relationshipName);
        DeleteClient(clientName);
        Terminate_CroesusProcess();
    }
        
}