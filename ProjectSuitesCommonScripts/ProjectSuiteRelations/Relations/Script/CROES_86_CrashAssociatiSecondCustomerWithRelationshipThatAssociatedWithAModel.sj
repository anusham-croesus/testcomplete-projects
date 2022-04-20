//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      1. Créer une nouvelle relation.
                      2. Associer un client à cette nouvelle relation.
                      4. Créer un nouveau modèle.
                      5. Associer cette nouvelle relation à ce nouveau modèle.
                      6. Associer un second client à cette nouvelle relation.
                      7. Vérifier qu’une fenêtre « Erreur » s’ouvre et que le message d’erreur suivant est affiché : 
                      « Une erreur est survenue. Veuillez communiquer avec votre centre d’assistance. L’application va se fermer. »
                      8. Cliquer sur le bouton OK de la fenêtre « Erreur » .
                      L’application se ferme (CRASH).

    Auteur : Sana Ayaz
    Anomalie:CROES-86
    Version de scriptage:ref90-05-13--V9-AT_1-co6x
*/
function CROES_86_CrashAssociatiSecondCustomerWithRelationshipThatAssociatedWithAModel()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Se connecter avec KEYNEJ
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        var IACodeCroes_86=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "IACodeCroes_86", language+client);
        var relationshipNameCroes_86=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationshipNameCroes_86", language+client);
        var TitleWinAddRelatioShip=GetData(filePath_Relations,"WinCreateRelationship",2,language)
        var ClientNoCroes_86=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "ClientNoCroes_86", language+client);
        var modelCROES_86=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "modelCROES_86", language+client);
        var IACodeCROES_86=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "IACodeCROES_86", language+client);
        var NumberRelationCROES_8527=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NumberRelationCROES_8527", language+client);
        var NuberClient800040CROES_86=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NuberClient800040CROES_86", language+client);
        
        
        Get_ModulesBar_BtnRelationships().Click();
        
        //1. Créer une nouvelle relation.
        Log.Message("Add the relationship \"" + relationshipNameCroes_86 + "\" with the 'Add' button.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_86, 10);
        SearchRelationshipByName(relationshipNameCroes_86);
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + relationshipNameCroes_86 + "\" already exists.");
            return;
        }
        else {
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["AddDropDownMenu", true, true]);
            
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]);         
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCroes_86);
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(IACodeCroes_86);
            Get_WinDetailedInfo_BtnOK().Click();
             WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WndCaption"],["HwndSource", TitleWinAddRelatioShip]);
     
        }
        
       
        //2. Associer un client à cette nouvelle relation.
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_86, 10).Click();
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_86, 10).ClickR();
         Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
         Get_RelationshipsGrid_ContextualMenu_Add_JoinClients().Click();
        
        
         Get_WinPickerWindow_DgvElements().Keys(ClientNoCroes_86.charAt(0));
         Get_WinQuickSearch_TxtSearch().SetText(ClientNoCroes_86);
         Get_WinQuickSearch_BtnOK().Click();
         Get_WinPickerWindow().FindChild("Value", ClientNoCroes_86, 10).Click();
         Get_WinPickerWindow_BtnOK().Click();
         Get_WinAssignToARelationship_BtnYes().Click();
         // 4. Créer un nouveau modèle.
         Get_ModulesBar_BtnModels().Click();
         Create_Model(modelCROES_86, "", IACodeCROES_86)
         SearchModelByName(modelCROES_86);
         Get_ModelsGrid().Find("Value",modelCROES_86,10).Click();
         //5. Associer cette nouvelle relation à ce nouveau modèle.
         Get_Models_Details_TabAssignedPortfolios().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click();
        Get_WinPickerWindow_DgvElements().Keys(NumberRelationCROES_8527.charAt(0));
        Get_WinQuickSearch_TxtSearch().keys(NumberRelationCROES_8527.slice(1));
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
        
         //6. Associer un second client à cette nouvelle relation.
         Get_ModulesBar_BtnRelationships().Click();
        
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_86, 10).Click();
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_86, 10).ClickR();
         Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
         Get_RelationshipsGrid_ContextualMenu_Add_JoinClients().Click();
         
         
          Get_WinPickerWindow_DgvElements().Keys(NuberClient800040CROES_86.charAt(0));
         Get_WinQuickSearch_TxtSearch().SetText(NuberClient800040CROES_86);
         Get_WinQuickSearch_BtnOK().Click();
         Get_WinPickerWindow().FindChild("Value", NuberClient800040CROES_86, 10).Click();
         Get_WinPickerWindow_BtnOK().Click();
         Get_WinAssignToARelationship_BtnYes().Click();
        //Les points de vérifications: vérifier que l'application crashe
        
         //Vérifier si le message d'erreur apparaît
        maxWaitTime = 1000;
        waitTime = 0;
        errorDialogBoxDisplayed = Get_DlgError().Exists;
        while (!errorDialogBoxDisplayed && waitTime < maxWaitTime){
            Delay(1000);
            waitTime += 1000;
            errorDialogBoxDisplayed = Get_DlgError().Exists;
        }
        
        Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");
        
        if (errorDialogBoxDisplayed){
            Log.Error("Croesus crashed.")
            Log.Error("Bug CROES-86");
            Get_DlgError_BtnOK().Click();
        }
        else
            Log.Checkpoint("No crash detected.")
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        DeleteRelationship(relationshipNameCroes_86);
        DeleteSubModel(modelCROES_86)
        Terminate_CroesusProcess(); 
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        DeleteRelationship(relationshipNameCroes_86);
        
        DeleteSubModel(modelCROES_86)
        Terminate_CroesusProcess(); 
        
    }
}


function DeleteSubModel(model){

         Get_ModulesBar_BtnModels().Click();
         Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
         if(!Get_ModelsGrid().Exists)
             Get_ModulesBar_BtnModels().Click();
         SearchModelByName(model);
         Get_ModelsGrid().Find("Value",model,10).Click();
         Get_Toolbar_BtnDelete().Click();
         if(Get_DlgConfirmation().Exists){
         var width =Get_DlgConfirmation().Get_Width()
         Get_DlgConfirmation().Click((width*(1/3)),73); 
      }    
  }
  
  