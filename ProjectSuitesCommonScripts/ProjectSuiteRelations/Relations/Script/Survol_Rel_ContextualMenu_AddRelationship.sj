//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Rel_RelationshipsBar_BtnInfo

 /* Description :Dans le du module « Relationship » ,afficher la fenêtre «Create Relationship» par ClickR ContextualMenu_AddExternal. 
Vérifier la présence des contrôles et des étiquetés et et Cliquer sur chaque onglet pour vérifier le message qui apparaît*/

 function Survol_Rel_ContextualMenu_AddRelationship()
{
  
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click(); 
  var btn="AddRel"
  
  Get_RelationshipsClientsAccountsGrid().ClickR();
  Get_RelationshipsClientsGrid_ContextualMenu_Add().Click();
  Get_RelationshipsGrid_ContextualMenu_Add_AddNewRelationship().Click();
  
  //Vérification du titre de la fenêtre   
  aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",2,language));
     
  //Les points de vérification
  Check_Properties_RelationshipsInfo_TabInfo(language,btn) // la fonction est dans Survol_Rel_RelationshipsBar_BtnInfo
  //Grp Note
  Check_Properties_WinInfo_Notes(language);
  
  Get_WinDetailedInfo_TabAddresses().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",3,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",4,language));
  var width = Get_DlgInformation().Get_Width();
  Get_DlgInformation().Click((width*(1/2)),73);  

  Get_WinDetailedInfo_TabProductsAndServices().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",3,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",4,language));
  var width = Get_DlgInformation().Get_Width();
  Get_DlgInformation().Click((width*(1/2)),73);  
  
  Get_WinDetailedInfo_TabProfile().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",3,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",4,language));
  var width = Get_DlgInformation().Get_Width();
  Get_DlgInformation().Click((width*(1/2)),73);  
  
  Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click();
  //aqObject.CheckProperty(Get_DlgCroesus(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",3,language));
  //aqObject.CheckProperty(Get_DlgCroesus_LblMessage1(), "Content", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",4,language));
  //Get_DlgCroesus_BtnOK().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",3,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",4,language));
  var width = Get_DlgInformation().Get_Width();
  Get_DlgInformation().Click((width*(1/2)),73);  
  
  Get_WinDetailedInfo_TabDocuments().Click();
  aqObject.CheckProperty(Get_DlgInformation(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",3,language));
  aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",4,language));
  var width = Get_DlgInformation().Get_Width();
  Get_DlgInformation().Click((width*(1/2)),73);  
  
  Get_WinDetailedInfo().Close();
  
    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", 1])){
     Close_Croesus_MenuBar();
  }
  else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }

 }
 
