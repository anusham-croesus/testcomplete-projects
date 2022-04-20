//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Erreur lors de l'ajout d'un compte fictif à une relation assignée à un modèle
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-613
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0613_Rel_Error_when_adding_a_fictitious_account_to_a_relationship_assigned_to_a_model()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-613", "CR1352_0613_Rel_Error_when_adding_a_fictitious_account_to_a_relationship_assigned_to_a_model()");

    try {
        var realAccountNo = "800241-GT";
        if (client == "BNC" ){
          var modelNo = "~M-00001-0";
        }
        else if(client == "US" ){
          var modelNo = "~M-00008-0";
        } 
        else if(client == "CIBC" ){
          var modelNo = "~M-00005-0";
        } 
        else{
          var modelNo = "~M-00002-0";
        }
        
        //var UniqueID = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
        var relationshipName = "REL0613";
        var fictitiousClientName = "FIC_CLT0613";
        
        Login(vServerRelations, userName, psw, language);
        
        
        //Créer une relation
        CreateRelationship(relationshipName);
        //Recupérer le numéro de la relation
        var relNo = Get_RelationshipNo(relationshipName);
        
        //Créer un client fictif
        CreateFictitiousClient(fictitiousClientName);
        
        //Créer un compte fictif
        Log.Message("Create a fictitious account (" + fictitiousClientName + ").");
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnAdd().Click();
        SetAutoTimeOut();

        //Choisir un client fictif et cliquer sur OK
        if (!(Get_WinPickerWindow().Exists))
            Log.Error("The picker window was not displayed.");
        RestoreAutoTimeOut();
        Delay(1000);
        Sys.Keys(fictitiousClientName);
        Get_WinQuickSearch_TxtSearch().SetText(fictitiousClientName);
        Get_WinQuickSearch_BtnOK().Click();
        SetAutoTimeOut();
        Delay(1000);
        if (!Get_WinPickerWindow().FindChild("Value", fictitiousClientName, 10).Exists){
            Log.Error("Client " + fictitiousClientName + " not found in the picker window.");
            return;
        }
        RestoreAutoTimeOut();
        Get_WinPickerWindow().FindChild("Value", fictitiousClientName, 10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAccountInfo_BtnOK().Click();
        //Recupérer le numéro du compte 
        var accNo = Get_AccountNO(fictitiousClientName);
                
        //Assigner le compte realAccountNo à la relation
        JoinAccountToRelationship(realAccountNo, relationshipName);        
        
        //Assigner la relation à un modèle
        AssignRelationshipToModel(relationshipName, modelNo);
        
        
        //Tenter d'assigner le compte fictif à la relation
        var errorMessage = GetData(filePath_Relations, "CR1352", 162, language)+" "+accNo+" "+GetData(filePath_Relations, "CR1352", 163, language)
                                +" "+relNo+" "+GetData(filePath_Relations, "CR1352", 164, language);
        
       /* if (client == "BNC" ){
          var errorMessage = GetData(filePath_Relations, "CR1352", 33, language);
        }
        else if(client == "TD" ){
          var errorMessage = GetData(filePath_Relations, "CR1352", 147, language);
        } 
        else if(client == "US" ){
          var errorMessage = GetData(filePath_Relations, "CR1352", 150, language);
          } 
          else if(client == "CIBC" ){
          var errorMessage = GetData(filePath_Relations, "CR1352", 157, language);
        } 
        else{//RJ
          var errorMessage = GetData(filePath_Relations, "CR1352", 136, language)
        }*/ //EM : 90.08-DY-2 : Remplacé par un message commun où on recupère le numéro de la relation et celui de compte dynamiquement.
        
        JoinAccountToRelationshipAndCheckErrorMessage(fictitiousClientName, relationshipName, errorMessage);
        
        Close_Croesus_X();
                
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(relationshipName);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        Get_CroesusApp().WaitProperty("CPUUsage", 10, 3000);
        Get_CroesusApp().WaitProperty("CPUUsage", 0, 30000);
        DeleteClient(fictitiousClientName);
        Close_Croesus_X();
        Terminate_CroesusProcess();
    }
    
}

function JoinAccountToRelationshipAndCheckErrorMessage(accountNo, relationshipName, errorMessage)
{

    Log.Message("Join " + accountNo + " account to " + relationshipName + " relationship.");
    Get_ModulesBar_BtnRelationships().Click();
    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
    Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
    
    SearchRelationshipByName(relationshipName);
    var searchResultRelationship = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
    if (searchResultRelationship.Exists == false){
        Log.Error("The relationship " + relationshipName + " was not displayed.");
        return;
    }
    
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
    Get_Toolbar_BtnAdd().Click();
    WaitObject(Get_CroesusApp(),"Uid","ContextMenu_8804");
    Get_Toolbar_BtnAdd_AddDropDownMenu_JoinAccountsToRelationship().Click();
    WaitObject(Get_CroesusApp(),"Uid","PickerBase_dcbf");
    
    //Vérifier que la fenêtre Comptes est ouverte
    Log.Message("Verify that he picker window is displayed.");
    if (!(Get_WinPickerWindow().Exists)){
        Log.Error("The picker window was not displayed.");
        return;
    }
    
    //Choisir un compte et cliquer sur OK
    Sys.Keys(accountNo);
    Get_WinQuickSearch_TxtSearch().SetText(accountNo);
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinPickerWindow().FindChild("Value", accountNo, 10).Click();
    Get_WinPickerWindow_BtnOK().Click();
        
    //Vérifier que la fenêtre "Associer à une relation" est ouverte et le cas échéant vérifier le message d'erreur et cliquer sur "Non"
    Log.Message("Verify that the 'Assign to a relationship' window is displayed.");
    if (!(Get_WinAssignToARelationship().Exists)){
        Log.Error("The 'Assign to a relationship' window was not displayed.");
        return;
    }
    WaitObject(Get_WinAssignToARelationship(),"Uid","DataGrid_1e6a");     
    aqObject.CheckProperty(Get_WinAssignToARelationship().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).DataContext.DataItem, "ConflictReason", cmpEqual, errorMessage);
    aqObject.CheckProperty(Get_WinAssignToARelationship_BtnYes(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_WinAssignToARelationship_BtnNo(), "IsEnabled", cmpEqual, true);
        
    Get_WinAssignToARelationship_BtnOk().Click();


}