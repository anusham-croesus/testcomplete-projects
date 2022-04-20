//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables




/**
    Description : Valider l'association d'une relation à une relation groupée
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-534
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0534_Rel_Join_to_a_Grouped_relationship()
{
    //var UniqueID = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
    var relationshipName = "REL0534";
    var groupedRelationshipName = "GRP_REL0534";
    
  //  var relationshipName = "REL0547";
    var updatedFullName = "UPDATED_REL0547";
    
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-534", "Lien vers Jira");
        Log.Message("***************************** L'étape 1 *************************************************")
        /*le script a été révisé et remplace les scripts suivants: CCroes-6892, Croes-531, Croes-532, Croes-533
           Croes-603, Croes-2469*/  
    
        Login(vServerRelations, userName, psw, language);
        Log.Message("Création d'une relation")
        CreateRelationship(relationshipName);
        Log.Message("***************************** L'étape 2 *************************************************")
        Log.Message("Création d'une relation groupée")
        CreateGroupedRelationship(groupedRelationshipName);
        Log.Message("Sélectionner une relation et Cliquer sur le bouton Ajouter + puis Associer à une relation groupée") 
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        Log.Message("Join the relationship " + relationshipName + " to the grouped relationship " + groupedRelationshipName + ".");
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        Get_Toolbar_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","ContextMenu_8804");
        Get_Toolbar_BtnAdd_AddDropDownMenu_JoinToAGroupedRelationship().Click();
        WaitObject(Get_CroesusApp(),"Uid","PickerBase_dcbf");
        
        //Vérifier que la fenêtre Relations est ouverte
        Log.Message("Vérifier que la fenêtre Relations est ouverte")
        Log.Message("Verify that he picker window is displayed.");
        SetAutoTimeOut(30000);
        if (!(Get_WinPickerWindow().Exists)){
            Log.Error("The picker window was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        aqObject.CheckProperty(Get_WinPickerWindow(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 3, language));
        Log.Message("***************************** L'étape 3 *************************************************")
        
        Log.Message("Choisir une relation groupée et cliquer sur OK")
        //Choisir une relation groupée et cliquer sur OK
        Sys.Keys(groupedRelationshipName);
        Get_WinQuickSearch_TxtSearch().SetText(groupedRelationshipName);
        Get_WinQuickSearch_BtnOK().Click();
        Log.Message("Cliquer sur le bouton OK")
        Get_WinPickerWindow_BtnOK().Click();
        
        //Vérifier que la fenêtre "Associer à une relation" est ouverte et cliquer le cas échéant sur "Oui"
        Log.Message("Vérification que la fenêtre :Associer à une relation ouverte")
        Log.Message("Verify that the 'Assign to a relationship' window is displayed.");
        SetAutoTimeOut(30000);
        if (!(Get_WinAssignToARelationship().Exists)){
            Log.Error("The 'Assign to a relationship' window was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        aqObject.CheckProperty(Get_WinAssignToARelationship(), "Title", cmpEqual, GetData(filePath_Relations, "CR1352", 4, language));
        Log.Message("***************************** L'étape 4 *************************************************")
        Log.Message("Confirmer l'association avec Oui")
        Get_WinAssignToARelationship_BtnYes().Click()
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "RelationshipAssignationResults_5ddd");
        Log.Message("Vérifier que l'association a été faite")
        //Vérifier que l'association a été faite
        Log.Message("Verify that the assignment was done");
        SearchRelationshipByName(groupedRelationshipName);
        var searchResultGroupedRelation = Get_RelationshipsClientsAccountsGrid().FindChild("Value", groupedRelationshipName, 10);
        SetAutoTimeOut(10000);
        if (searchResultGroupedRelation.Exists == false){
            Log.Error("The grouped relationship " + groupedRelationshipName + " was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", groupedRelationshipName, 10).Click();
        
        searchRelationshipInHierarchyPanel = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", GetData(filePath_Relations, "CR1352", 3, language), 10).Find("OriginalValue", relationshipName, 10);
        SetAutoTimeOut(10000);
        if (searchRelationshipInHierarchyPanel.Exists == false){
            Log.Error("The relationship " + relationshipName + " was not found in the hierarchy panel of the grouped relationship " + groupedRelationshipName + ".");
        }
        else {
            Log.Checkpoint("The relationship " + relationshipName + " was found in the hierarchy panel of the grouped relationship " + groupedRelationshipName + ".");
        }
         RestoreAutoTimeOut();
        Log.Message("***************************** L'étape 5 *************************************************")
        Log.Message("Sélectioner la relation crée dans étape2 ")
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        Log.Message("Clic sur le bouton Info")
        Get_RelationshipsBar_BtnInfo().Click();
        Log.Message("Verify that the 'Relationship Info' window is displayed.");
        SetAutoTimeOut(30000);
          if (!(Get_WinDetailedInfo().Exists)){
              Log.Error("The 'Relationship Info' window was not displayed.");
              return;
          }
        RestoreAutoTimeOut();
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpStartsWith, GetData(filePath_Relations, "CR1352", 7, language));
       Log.Message("***************************** L'étape 6 *************************************************")
       //Modifier les informations et clic sur OK
       Log.Message("Modifier les informations")
        
        
        //Modifier le nom complet de la relation
        Log.Message("Update the full name.");
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(updatedFullName);
        
        //Modifier les produits et services
        Log.Message("Update the products and services.");
        Get_WinDetailedInfo_TabProductsAndServices().Click();
        Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", "True", 30000);
        
        Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_BtnSetup().Click();
        Set_IsCheckedForAllUniCheckBoxes(Get_WinProductSetup(), false);
        Get_WinProductSetup_ChkProduct("Obl. convertibles", "Bonds-Convertible").set_IsChecked(true);
        Get_WinProductSetup_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlName"],["UniDialog", "basedialog6"]);
        
        Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. convertibles", "Bonds-Convertible").set_IsChecked(true);
        
        Get_WinDetailedInfo_TabProductsAndServices_GrpServices_BtnSetup().Click();
        Set_IsCheckedForAllUniCheckBoxes(Get_WinServiceSetup(), false);
        Get_WinServiceSetup_ChkService("Séminaires", "Seminars").set_IsChecked(true);
        Get_WinServiceSetup_BtnOK().Click();
        Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars").set_IsChecked(false);
        
        //Modifier le profil
        Log.Message("Update profile.");
        Get_WinDetailedInfo_TabProfile().Click();
        Get_WinInfo_TabProfile_BtnSetup().Click();
        Set_IsCheckedForAllXamCheckEditors(Get_WinVisibleProfilesConfiguration(), false);
        Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkLanguage().Click();
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        
        //Cliquer sur OK
        Log.Message("Save the updates by clicking on OK button.");
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["UniDialog", 1]);
        
        //Vérifier dans la partie Détail que la relation a été modifiée
        Log.Message("Verify that the relationship " + relationshipName + " was updated");
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        
        
        //Vérifier le nom complet de la relation
        Log.Message("Verify the full name.");
        Get_RelationshipsDetails_TabInfo().Click();
        aqObject.CheckProperty(Get_RelationshipsDetails_TabInfo_TxtFullName(), "Text", cmpEqual, updatedFullName);
        
        //Vérifier les produits et services
        Log.Message("Verify the products and services.");
        Get_RelationshipsDetails_TabProductsAndServices().Click();
        
        //Vérifier que le produit "Obl. Convertibles" est présent dans la partie Détails du grid
        Log.Message("Verify the Bonds-Convertible product is displayed in the relationship grid details, and is checked.");
        
        var productsCount = Get_RelationshipsDetails_TabProductsAndServices_DgvProducts().WPFObject("RecordListControl", "", 1).Items.get_Count();
        var expectedProductName = GetData(filePath_Relations, "CR1352", 142, language);
        var isFound = false;
        var isChecked = false;
        for (var i = 0; i < productsCount; i++){
            var currentProductName = Get_RelationshipsDetails_TabProductsAndServices_DgvProducts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Name();
            if (VarToStr(currentProductName) == VarToStr(expectedProductName)){
                isChecked = Get_RelationshipsDetails_TabProductsAndServices_DgvProducts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Value();
                isFound = true;
                break;
            }
        }
        
        if (isFound){
            Log.Checkpoint("The " + expectedProductName + " was found in the  relationship grid detail. This is expected.");
            CheckEquals(isChecked, true, "The " + expectedProductName + " IsChecked value");
        }
        else {
            Log.Error("The " + expectedProductName + " was not found in the  relationship grid detail. This is not expected.");
        }
        
        //Vérifier que le service "Séminaires" est présent dans la partie Détails du grid
        Log.Message("Verify the Seminars service is displayed in the relationship grid details, and is not checked.");
        
        var servicesCount = Get_RelationshipsDetails_TabProductsAndServices_DgvServices().WPFObject("RecordListControl", "", 1).Items.get_Count();
        var expectedServiceName = GetData(filePath_Relations, "CR1352", 143, language);
        var isFound = false;
        var isChecked = false;
        for (var i = 0; i < productsCount; i++){
            var currentServiceName = Get_RelationshipsDetails_TabProductsAndServices_DgvServices().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Name();
            if (VarToStr(currentServiceName) == VarToStr(expectedServiceName)){
                isChecked = Get_RelationshipsDetails_TabProductsAndServices_DgvServices().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Value();
                isFound = true;
                break;
            }
        }
        
        if (isFound){
            Log.Checkpoint("The " + expectedServiceName + " was found in the  relationship grid detail. This is expected.");
            CheckEquals(isChecked, false, "The " + expectedServiceName + " IsChecked value");
        }
        else {
            Log.Error("The " + expectedServiceName + " was not found in the  relationship grid detail. This is not expected.");
        }
        
        //Vérifier le profil
        Log.Message("Verify the profile. Check that the Language label is present and visible.");
        Get_RelationshipsDetails_TabProfile().Click();
        Get_RelationshipsDetails_TabProfile().WaitProperty("IsSelected", "True", 30000);
        SetAutoTimeOut(10000);
        if (Get_RelationshipsDetails_TabProfile_DefaultExpander_LblLanguage().Exists && Get_RelationshipsDetails_TabProfile_DefaultExpander_LblLanguage().IsVisible ){
            Log.Checkpoint("The Language profile was present.");
            aqObject.CheckProperty(Get_RelationshipsDetails_TabProfile_DefaultExpander_LblLanguage(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 144, language));
        }
        else {
            Log.Error("The Language profile was not present.");
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
        DeleteRelationship(groupedRelationshipName);
        DeleteRelationship(updatedFullName);//updatedFullName
        Terminate_CroesusProcess();
    }
        
}
function Set_IsCheckedForAllUniCheckBoxes(parentComponentObject, booleanValue)
{
    var arrayOfCheckboxes = parentComponentObject.FindAllChildren("ClrClassName", "UniCheckBox", 100).toArray();
    for (var i = 0; i < arrayOfCheckboxes.length; i++){
        arrayOfCheckboxes[i].set_IsChecked(booleanValue);
    }
}



function Set_IsCheckedForAllXamCheckEditors(parentComponentObject, booleanValue)
{
    var arrayOfCheckboxes = parentComponentObject.FindAllChildren(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100).toArray();
    for (var i = 0; i < arrayOfCheckboxes.length; i++){
        if (booleanValue != arrayOfCheckboxes[i].get_IsChecked()){
            arrayOfCheckboxes[i].Click();
        }
    }
}