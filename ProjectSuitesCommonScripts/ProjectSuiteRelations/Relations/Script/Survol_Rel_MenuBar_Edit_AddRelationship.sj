//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Rel_RelationshipsBar_BtnInfo

 /* Description :Dans le du module « Relationship » ,afficher la fenêtre «Create Relationship» par MenuBar_Edit_AddRelationship. 
Vérifier la présence des contrôles et des étiquetés et et Cliquer sur chaque onglet pour vérifier le message qui apparaît*/

 function Survol_Rel_MenuBar_Edit_AddRelationship()
{
 
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click(); 
  var btn="AddRel"
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_AddForRelationshipsAndClients().Click();
  Get_MenuBar_Edit_AddForRelationshipsAndClients_AddRelationship().Click();
  
  //Vérification du titre de la fenêtre   
  aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Relations,"WinCreateRelationship",2,language));
     
  //Les points de vérification
  Check_Properties_RelationshipsInfo_TabInfo(language,btn) // la fonction est dans Survol_Rel_RelationshipsBar_BtnInfo
   //Grp Note
  Check_Properties_WinInfo_Notes(language)
  
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
     Close_Croesus_SysMenu();
  }
  else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }
  
 }
 