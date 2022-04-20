//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA



/**
    Description : Assigner des comptes réels à une relation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-549
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0549_Rel_Join_real_accounts_to_a_relationship()
{
    //var UniqueID = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
    var relationshipName = "REL0549";
    var accountNumber = "800303-NA";
    
    
    try {
        
        Login(vServerRelations, userName, psw, language);
        
        CreateRelationship(relationshipName);
        
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
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
        RestoreAutoTimeOut();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        
        searchClientInHierarchyPanel = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", GetData(filePath_Relations, "CR1352", 15, language), 10).Find("OriginalValue", accountNumber, 10);
        SetAutoTimeOut();
        if (searchClientInHierarchyPanel.Exists == false){
            Log.Error("The account number " + accountNumber + " was not found in the hierarchy panel of the relationship " + relationshipName + ".");
        }
        else {
            Log.Checkpoint("The account number " + accountNumber + " was found in the hierarchy panel of the relationship " + relationshipName + ".");
        }
        RestoreAutoTimeOut();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerRelations)
    }
    finally {
        Terminate_CroesusProcess();
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerRelations)
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(relationshipName);
        Terminate_CroesusProcess();
    }
        
}