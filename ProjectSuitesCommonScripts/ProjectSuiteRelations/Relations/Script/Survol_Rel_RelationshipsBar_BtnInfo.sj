//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Relations_Get_functions
//USEUNIT CommonCheckpoints

 /* Description :Dans le du module « Relationships », afficher la fenêtre «Info » en cliquant sur RelationshipsBar_BtnInfo. (Pour la relation qui est sélectionnée par default #1 TEST) 
Vérifier la présence des contrôles et des étiquetés dans tous les onglets*/

 function Survol_Rel_RelationshipsBar_BtnInfo()
{ 
  var module="relationships";
  var btn="infoRel"
  
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click(); 
  
  Get_RelationshipsBar_BtnInfo().Click();
  
   //Vérification du titre de la fenêtre   
   //if (client == "BNC" ){
   // aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Relations,"WinInfo_TabInfo",34,language));
   //}
       
  //Les points de vérification
  //Check_Properties_RelationshipsInfo_TabInfo(language,btn) 
  //Check_Properties_WinInfo_Notes(language,btn)
  //Check_Properties_DetailedInfo_TabAdresses(language,module)// la fonction est dans CommonCheckpoints 
  //Check_Properties_DetailedInfo_TabProduitsServices(language,module)// la fonction est dans CommonCheckpoints 
  //Check_Properties_DetailedInfo_TabProfile(language)// la fonction est dans CommonCheckpoints
  //Check_Properties_RelationshipsInfo_TabUnderlyingAccounts(language)
  //Check_Properties_DetailedInfo_TabDocuments(language,module) // la fonction est dans CommonCheckpoints 
  
  Get_WinDetailedInfo().Close();
      
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", 1])){
      Close_Croesus_MenuBar();
  }
  else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }
  
 }
 
  
//***********************************************************  WIN RELATIOSHIP INFO   ************************************************************************
//********************************************************************************************************************************************************
 //Fonctions  (les points de vérification pour les scripts qui testent RELATIOSHIP INFO)
 
 // WIN RELATIOSHIP INFO - L'ONGLET INFO 
function Check_Properties_RelationshipsInfo_TabInfo(language,btn)
{
  Get_WinDetailedInfo().set_Width(1056);
  Get_WinDetailedInfo().set_Height(816);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 2, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 3, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 4, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsVisible", cmpEqual, true);
   
  Get_WinDetailedInfo_TabInfo().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo(), "Header", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 5, language));
  
  //Grp General 
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral(), "Header", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 6, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblFullName(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 7, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblShortName(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 8, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName(), "IsReadOnly", cmpEqual, false);
  if(client == "US" ){
  Log.Message("USDEV-341")}
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblIACode(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 9, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblAlternateNameForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 10, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtAlternateNameForRelationship(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtAlternateNameForRelationship(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblSalutationNameForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 11, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSalutationNameForRelationship(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSalutationNameForRelationship(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblLanguageForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 12, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblCurrencyForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 14, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblCreationForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 13, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpCreationForRelationship(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpCreationForRelationship(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblUpdateForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 15, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpUpdateForRelationship(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpUpdateForRelationship(), "IsReadOnly", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblTypeForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 16, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship(), "IsReadOnly", cmpEqual, false);
  
  // Dans notre environnement le PREF_RELATIONSHIP_READ_ONLY est a No "CROES-4818"
//  if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){ //n'existe pas dans la version BNC -14, A valider 
//  Log.Message("CROES-4818")
//    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblReadOnlyRelationshipForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 17, language));
//    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship(), "IsVisible", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship(), "IsEnabled", cmpEqual, true);
//    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship(), "IsChecked", cmpEqual, false);
//  }
  
  //Grp Amounts
 if(client == "US" && btn=="AddRel" ){
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts(), "Header", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 39, language));
  } 
 else{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts(), "Header", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 19, language));}
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_LblBalance(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 20, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtBalance(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtBalance(), "IsReadOnly", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_LblTotalValue(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 21, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtTotalValue(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtTotalValue(), "IsReadOnly", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_LblMarginOrExcessMargin(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 22, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtMarginOrExcessMargin(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtMarginOrExcessMargin(), "IsReadOnly", cmpEqual, true);
  
  //Grp Follow up
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp(), "Header", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 24, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblSegmentation(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 25, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblContactPerson(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 26, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblAccountManager(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 27, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblCommunication(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 28, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication(), "IsReadOnly", cmpEqual, false);
  if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblRepresentativeForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 29, language));
  }
  else{ //RJ
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblRepresentativeForRelationship(), "Text", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 37, language));
  }
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_TxtRepresentativeForRelationship(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_TxtRepresentativeForRelationship(), "IsReadOnly", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship(), "IsEnabled", cmpEqual, true);
    
  //Grp Summary
  aqObject.CheckProperty(Get_WinInfo_Notes_TabSummary(), "Header", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 32, language));
  
  Get_WinInfo_Notes_TabSummary().Click();
  aqObject.CheckProperty(Get_WinInfo_Notes_TabSummary(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_WinInfo_Notes_TabSummary_TxtSummary(), "IsVisible", cmpEqual, true);
  
}

// WIN RELATIOSHIP INFO - L'ONGLET INFO 
function Check_Properties_RelationshipsInfo_TabUnderlyingAccounts(language)
{
  Get_WinDetailedInfo().set_Width(1056);
  Get_WinDetailedInfo().set_Height(816);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 2, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 3, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
   
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "WPFControlText", cmpEqual, GetData(filePath_Relations, "WinInfo_TabInfo", 4, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_BtnApply(), "IsVisible", cmpEqual, true);
   
  Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click();
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship(), "Header", cmpEqual, GetData(filePath_Relations, "WinInfo_TabUnderlyingAcc", 2, language));
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd(), "Content", cmpEqual, GetData(filePath_Relations, "WinInfo_TabUnderlyingAcc", 3, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd(), "IsVisible", cmpEqual,true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd(), "IsEnabled", cmpEqual,true);
      
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit(), "Content", cmpEqual, GetData(filePath_Relations, "WinInfo_TabUnderlyingAcc", 4, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit(), "IsVisible", cmpEqual,true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit(), "IsEnabled", cmpEqual,true);
    
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete(), "Content", cmpEqual, GetData(filePath_Relations, "WinInfo_TabUnderlyingAcc", 5, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete(), "IsVisible", cmpEqual,true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete(), "IsEnabled", cmpEqual,true);
  
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Relations, "WinInfo_TabUnderlyingAcc", 8, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChEntryDate(), "Content", cmpEqual, GetData(filePath_Relations, "WinInfo_TabUnderlyingAcc", 9, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChRemovalDate(), "Content", cmpEqual, GetData(filePath_Relations, "WinInfo_TabUnderlyingAcc", 10, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChPerformanceDate(), "Content", cmpEqual, GetData(filePath_Relations, "WinInfo_TabUnderlyingAcc", 11, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChAccountManagementStartDate(), "Content", cmpEqual, GetData(filePath_Relations, "WinInfo_TabUnderlyingAcc", 12, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChCreationDate(), "Content", cmpEqual, GetData(filePath_Relations, "WinInfo_TabUnderlyingAcc", 13, language));
  aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChClosingDate(), "Content", cmpEqual, GetData(filePath_Relations, "WinInfo_TabUnderlyingAcc", 14, language));

}

  