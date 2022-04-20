//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/**
    Description : Création d'une relation temporaire
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2549
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_2549_Rel_Create_a_temporary_relationship()
{
    var relationshipName = "#7 TEST";
    var relationshipAlternateName = "Test7";
    if (client == "BNC" ){
        var expectedIACode = "0AED";
    }
    else{//RJ
        var expectedIACode = "BD88";
    }
    
    try {
        Login(vServerRelations, userName, psw, language);
        
        Create_a_temporary_relationship(relationshipName, relationshipAlternateName);
        
        //Vérifier que les informations ont été bien enregistrées
        //Delay(3000);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).DblClick();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "Text", cmpEqual, relationshipName);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName(), "Text", cmpEqual, relationshipName);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtAlternateNameForRelationship(), "Text", cmpEqual, relationshipAlternateName);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship(), "Text", cmpEqual, expectedIACode);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 89, language));
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationship(), "Text", cmpEqual, "USD");
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 90, language));
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation(), "Text", cmpEqual, "A");
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 91, language));
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(), "Text", cmpEqual, "Rappellera la semaine prochaine.");
        Get_WinDetailedInfo_TabAddresses().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem, "Email", cmpEqual, "test@test.com");
        Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit().Click();
        aqObject.CheckProperty(Get_WinCRUTelephone_CmbType(), "Text", cmpEqual, "Maison");
        aqObject.CheckProperty(Get_WinCRUTelephone_TxtNumber(), "Text", cmpEqual, "5144128563");
        Get_WinCRUTelephone_BtnCancel().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType(), "Text", cmpEqual, GetData(filePath_Relations, "CR1352", 92, language));
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1(), "Text", cmpEqual, "503, boulevard saint laurent");
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCityProv(), "Text", cmpEqual, "Montreal");
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtPostalCode(), "Text", cmpEqual, "3G92PF");
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCountry(), "Text", cmpEqual, "Canada");
        Get_WinDetailedInfo_BtnCancel().Click();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerRelations, userName, psw, language);
    }
    finally {
       
        
        DeleteRelationship(relationshipName);
        Terminate_CroesusProcess();
    }
}


function Create_a_temporary_relationship(relationshipName, relationshipAlternateName)
{
    CreateRelationship(relationshipName);
    //Delay(2000);
    SearchRelationshipByName(relationshipName)
    //Delay(800)
    
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
    Get_RelationshipsBar_BtnInfo().Click();
    
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtAlternateNameForRelationship().set_Text(relationshipAlternateName);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship().set_IsDropDownOpen(true);
    if (client == "BNC" ){
      Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_Item0AED().Click();
    }
    else{//RJ
      Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_ItemBD88().Click();    
    }
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationship().set_IsDropDownOpen(true);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage_ItemEnglish().Click();
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationship().set_IsDropDownOpen(true);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency_ItemUSD().Click();
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship().set_IsDropDownOpen(true);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemFamily().Click();
    Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation().set_IsDropDownOpen(true);
    Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation_ItemA().Click();
    Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication().set_IsDropDownOpen(true);
    Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication_ItemTelephone().Click();
    Get_WinInfo_Notes_TabGrid().Click();
    Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
    Get_WinCRUANote_GrpNote_TxtNote().set_Text("Rappellera la semaine prochaine.")
    
    Get_WinCRUANote_GrpNote_TxtNote().Click();
    Get_WinCRUANote_BtnSave().Click();
    
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
    //Delay(2000);
    
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.set_Email("test@test.com");
    
    Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd().Click();
    Get_WinCRUTelephone_CmbType().set_Text("Maison");
    Get_WinCRUTelephone_TxtNumber().set_Text("5144128563");
    Get_WinCRUTelephone_BtnOK().Click();
    
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
    Get_WinCRUAddress_CmbType().set_IsDropDownOpen(true);
    Get_WinCRUAddress_CmbType_ItemHome().Click();
    Get_WinCRUAddress_TxtStreet1().set_Text("503, boulevard saint laurent");
    Get_WinCRUAddress_TxtCityProv().set_Text("Montreal");
    Get_WinCRUAddress_TxtPostalCode().set_Text("3G92PF");
    Get_WinCRUAddress_TxtCountry().set_Text("Canada");
    Get_WinCRUAddress_BtnOK().Click();
    
	var WinDetailedInfoClrClassName = VarToStr(Get_WinDetailedInfo().ClrClassName);
    var WinDetailedInfoTitle = VarToStr(Get_WinDetailedInfo().Title);
    
    Get_WinDetailedInfo_BtnOK().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], [WinDetailedInfoClrClassName, WinDetailedInfoTitle]);
}