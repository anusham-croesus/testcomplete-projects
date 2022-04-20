//USEUNIT Common_functions
//USEUNIT CR1352_0613_Rel_Error_when_adding_a_fictitious_account_to_a_relationship_assigned_to_a_model



/**
    Description : Erreur lors de l'ajout d'un compte déjà assignée à un modèle
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-617
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0617_Rel_Error_when_adding_an_account_already_assigned_to_a_model()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-617", "CR1352_0617_Rel_Error_when_adding_an_account_already_assigned_to_a_model()");
    
    try {
        var realAccountNo_1 = "800241-GT";
        var realAccountNo_2 = "800241-JW";
        
        if (client == "BNC" ){        
            var modelNo_1 = "~M-00001-0";
            var modelNo_2 = "~M-00002-0";
        }
        else if (client == "US"){
            var modelNo_1 = "~M-0000A-0";
            var modelNo_2 = "~M-00008-0";
        }
        else if (client == "CIBC"){
            var modelNo_1 = "~M-00005-0";                   
            var modelNo_2 = "~M-00007-0";
        }
        else {
            var modelNo_1 = "~M-00003-0";
            var modelNo_2 = "~M-00002-0";
        }
        
        //var UniqueID = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
        var relationshipName = "REL0617";
        
        Login(vServerRelations, userName, psw, language);
        
        if (client == "CIBC"){
            var modelName_2 = "Model_0617";
            Log.Message("Créer le modèle  '" + modelName_2 + "'.");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            SearchModelByName(modelName_2);
            
            SetAutoTimeOut();
            if (Get_ModelsGrid().FindChild("Value", modelName_2, 10).Exists)
                Log.Warning("Il existait déjà au moins un modèle  '" + modelName_2 + "'.");
            Create_Model(modelName_2);
        }
            RestoreAutoTimeOut();
        //Créer une relation
        CreateRelationship(relationshipName);
        
        //Assigner le compte realAccountNo_1 à la relation
        JoinAccountToRelationship(realAccountNo_1, relationshipName);
        
        //Assigner la relation au modèle modelNo_1
        AssignRelationshipToModel(relationshipName, modelNo_1);
        
        //Assigner le compte realAccountNo_2 au modèle modelNo_2
        AssignAccountToModel(realAccountNo_2, modelNo_2);
        
        //Tenter d'assigner le compte realAccountNo_2 à la relation
        if (client == "BNC" ){
            var errorMessage = GetData(filePath_Relations, "CR1352", 39, language);
        }
        else if (client == "US" ){
            var errorMessage = GetData(filePath_Relations, "CR1352", 154, language);
        }
        else if (client == "CIBC" ){
            var errorMessage = GetData(filePath_Relations, "CR1352", 160, language);
        }
        else {
            var errorMessage = GetData(filePath_Relations, "CR1352", 139, language);
        }
        
        JoinAccountToRelationshipAndCheckErrorMessage(realAccountNo_2, relationshipName, errorMessage);
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.Message("*************** CLEANUP ***************");
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);
        DeleteRelationship(relationshipName);
        RemoveAccountFromModel(realAccountNo_2, modelNo_2);
        if (client == "CIBC")
            DeleteModelByName(modelName_2);
        Terminate_CroesusProcess();
    }
    
}



function RemoveAccountFromModel(accountNo, modelNo)
{
    Log.Message("Enlever le Compte No '" + accountNo + "' des comptes assignés au modèle No '" + modelNo + "'.");
    
    var nbOfTries = 0;
    do {
        nbOfTries++;
        Get_ModulesBar_BtnModels().Click();
    } while (!Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000) && nbOfTries <= 2);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Search_Model(modelNo);
    SetAutoTimeOut();
    if (!Get_ModelsGrid().FindChild("Value", modelNo, 10).Exists)
        Log.Message("Le modèle No '" + modelNo + "' n'a pas été trouvé.");
    else {
        Get_ModelsGrid().FindChild("Value", modelNo, 10).Click();
        if (!Get_Models_Details_DgvDetails().FindChildEx("Value", accountNo, 10, true, 30000).Exists)
            Log.Message("Compte No '" + accountNo + "' non trouvé dans la liste des comptes assignés au modèle No '" + modelNo + "'.");
        else {
            Get_Models_Details_DgvDetails().FindChild("Value", accountNo, 10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            Get_DlgConfirmation().Click(150, 70);
        }
    }
    RestoreAutoTimeOut();
}



function DeleteModelByName(modelName)
{
    Log.Message("Supprimer le modèle '" + modelName + "'.");
    
    var nbOfTries = 0;
    do {
        nbOfTries++;
        Get_ModulesBar_BtnModels().Click();
    } while (!Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000) && nbOfTries <= 2);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    SearchModelByName(modelName);
     SetAutoTimeOut();
    if (!Get_ModelsGrid().Find("Value", modelName, 10).Exists)
        Log.Message("Le modèle '" + modelName + "' n'a pas été trouvé.");
    else {
        Get_ModelsGrid().Find("Value", modelName, 10).Click();        
        Get_Toolbar_BtnDelete().Click();
       
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation().Click(Get_DlgConfirmation().Width *(1/3), 73);
        
        WaitObject(Get_CroesusApp(), "Uid", "ModelListView_6fed");
        SearchModelByName(modelName);
        if (Get_ModelsGrid().Find("Value",modelName,10).Exists)
            Log.Warning("Il existe encore au moins un modèle '" + modelName + "'.");
    }
    RestoreAutoTimeOut();
}