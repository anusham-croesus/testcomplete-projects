//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions



/**
    Description : Modifier une relation avec un double-clic
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-547
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0547_Rel_Edit_a_relationship_with_a_double_click()
{
    //var UniqueID = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
    var relationshipName = "REL0547";
    var updatedFullName = "UPDATED_REL0547";
    
    try {
        
        Login(vServerRelations, userName, psw, language);
        
        //Créer une relation
        CreateRelationship(relationshipName);
        
        //Sélectionner une relation et double cliquer dessus
        Log.Message("Select a relationship and double click on it.");
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        SearchRelationshipByName(relationshipName);
        var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SetAutoTimeOut();
        if (!searchResult.Exists){
            Log.Error("The relationship " + relationshipName + " was not displayed.");
            return;
        }
         RestoreAutoTimeOut();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).DblClick();
        
        Log.Message("Verify that the 'Relationship Info' window is displayed.");
        SetAutoTimeOut(30000);
        if (!(Get_WinDetailedInfo().Exists)){
            Log.Error("The 'Relationship Info' window was not displayed.");
            return;
        }
        RestoreAutoTimeOut();
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpStartsWith, GetData(filePath_Relations, "CR1352", 7, language));
        
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
            Log.Error("The Language profile was notpresent.");
        }
         RestoreAutoTimeOut();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        Login(vServerRelations, userName, psw, language);

        Log.Message("Restore products, services and profile initial values for " + relationshipName + " relationship");
        Get_ModulesBar_BtnRelationships().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        SetAutoTimeOut();
        if (!searchResult.Exists){
            Log.Message("The relationship " + relationshipName + " was not displayed.");
        }
        else {
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).DblClick();
         RestoreAutoTimeOut();   
            //Restaurer les produits et services
            Log.Message("Restore the products and services.");
            Get_WinDetailedInfo_TabProductsAndServices().Click();
            
            Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", "True", 30000);
            Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_BtnSetup().Click();
            Set_IsCheckedForAllUniCheckBoxes(Get_WinProductSetup(), false);
            Get_WinProductSetup_BtnOK().Click();
        
            Get_WinDetailedInfo_TabProductsAndServices_GrpServices_BtnSetup().Click();
            Set_IsCheckedForAllUniCheckBoxes(Get_WinServiceSetup(), false);
            Get_WinServiceSetup_BtnOK().Click();
        
            //Restaurer le profil
            Log.Message("Restore the profile.");
            Get_WinDetailedInfo_TabProfile().Click();
            Get_WinInfo_TabProfile_BtnSetup().Click();
            Set_IsCheckedForAllXamCheckEditors(Get_WinVisibleProfilesConfiguration(), false);
            Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        
            //Cliquer sur OK
            Log.Message("Save the updates by clicking on OK button.");
            
            var WinDetailedInfoClrClassName = VarToStr(Get_WinDetailedInfo().ClrClassName);
            var WinDetailedInfoTitle = VarToStr(Get_WinDetailedInfo().Title);
            
            Get_WinDetailedInfo_BtnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], [WinDetailedInfoClrClassName, WinDetailedInfoTitle]);
        }

        DeleteRelationship(relationshipName);
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