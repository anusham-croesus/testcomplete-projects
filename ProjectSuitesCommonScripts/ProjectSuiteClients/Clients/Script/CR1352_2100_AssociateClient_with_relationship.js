//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA

/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2100
    Analyste d'assurance qualité : Karima
    Analyste d'automatisation : Youlia Raisper 
*/

function CR1352_2100_AssociateClient_with_relationship()
{
    var relationshipName = "TEST_2100";
    var relationship="#5 TEST";
    var client800303="800303"
    var account800303NA="800303-NA"
        
    try {       
        Activate_Inactivate_Pref("COPERN","PREF_RELATIONSHIP_READ_ONLY","YES",vServerClients);//PREF_RELATIONSHIP_READ_ONLY=YES
        RestartServices(vServerClients);  
        Login(vServerClients, userName, psw, language);        
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);        
        //Ajouter une relation par le bouton "+"
        Log.Message("Add the relationship \"" + relationshipName + "\" with the 'Add' button.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SearchRelationshipByName(relationshipName);
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + relationshipName + "\" already exists.");
            return;
        }
        else {
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), "Uid", "ContextMenu_8804", 2000)            
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
            WaitObject(Get_CroesusApp(), "WindowMetricTag", "LINK_NOTEBOOK", 2000)
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipName);
            if(client == "CIBC"){Log.Message("croes-6808")}
            Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().set_IsChecked(true);
            Get_WinDetailedInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"]);
        }
                
        //Vérifier que la relation a été correctement ajoutée
        //CheckExistenceOfRelationship(relationshipName);
        
        //Dans le module client , sélectionner un client.Faire un Click droit 
        Get_ModulesBar_BtnClients().Click();
        Search_Client(client800303);
        Get_RelationshipsClientsAccountsGrid().Find("Value",client800303,10).ClickR();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship().Click();
        Get_ClientsAccountsGrid_ContextualMenu_Relationship_JoinToARelationship().Click();
        
        Get_WinPickerWindow_DgvElements().Keys("F");
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(relationshipName);
        Get_WinQuickSearch_BtnOK().Click();
        
        if(Get_WinPickerWindow_DgvElements().Find("Value",relationshipName,10).Exists){
          Log.Error("La relation est visible ")
        }else{
          Log.Checkpoint("La relation n’est pas visible ")
        }
        
        Get_WinPickerWindow_DgvElements().Keys("F");
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);   
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(relationship);
        Get_WinQuickSearch_BtnOK().Click();
        
        Get_WinPickerWindow_DgvElements().Find("Value",relationship,10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToARelationship_BtnYes().Click();
        aqObject.CheckProperty(Get_ModulesBar_BtnRelationships(), "IsChecked", cmpEqual, true);
        aqObject.CheckProperty(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items,"Count",cmpEqual,"1");
        if(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Find("Value",relationship,10).Exists){
          Log.Checkpoint("La relation est visible ")
        }else{
          Log.Error("La relation n’est pas visible ")
        }
       
        if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Value",account800303NA,10).Exists){
          Log.Checkpoint("Le compte est visible")
        }else{
          Log.Error("Le compte n'est pas visible")
        }
        
        //Remettre les données 
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Value",account800303NA,10).ClickR();
        Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship().Click(); 
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        SearchRelationshipByName(relationshipName);
        if(client == "CIBC"){Log.Message("croes-6808")}
        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Find("Value",relationshipName,10).DblClick();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().set_IsChecked(false);
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"])
        Get_Toolbar_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(2.5/7), Get_DlgConfirmation().get_ActualHeight()-45);
                
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Activate_Inactivate_Pref("COPERN","PREF_RELATIONSHIP_READ_ONLY","NO",vServerClients);
        RestartServices(vServerClients);  
        
    }
        
}