//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Rel_RelationshipsBar_BtnInfo


 /* Description : Dans le du module « Relationships », afficher la fenêtre «Info » en cliquant sur MenuBar_EditFunctions_Info.(Pour la relation qui est sélectionnée par default #1 TEST) 
Vérifier la présence des contrôles et des étiquetés dans tous les onglets */

 function Survol_Rel_MenuBar_EditFunctions_Info()
{
  var module="relationships";
  var btn="infoRel"
  
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click(); 
  
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().Click();
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().Click();
  Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Info().Click(); //Il a y une anomalie dans automation 10 , le menu est vide 
  
   //Vérification du titre de la fenêtre   
   //if (client == "BNC" ){
   // aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Relations,"WinInfo_TabInfo",34,language));
   //}
  
  //Les points de vérification
  //Check_Properties_RelationshipsInfo_TabInfo(language) 
  //Check_Properties_WinInfo_Notes(language,btn)
  //Check_Properties_DetailedInfo_TabAdresses(language,module)// la fonction est dans CommonCheckpoints 
  //Check_Properties_DetailedInfo_TabProduitsServices(language,module)// la fonction est dans CommonCheckpoints 
  //Check_Properties_DetailedInfo_TabProfile(language)// la fonction est dans CommonCheckpoints
  //Check_Properties_RelationshipsInfo_TabUnderlyingAccounts(language)
  //Check_Properties_DetailedInfo_TabDocuments(language,module) // la fonction est dans CommonCheckpoints  
  
  Get_WinDetailedInfo_BtnCancel().Keys("[Esc]");
  
  Close_Croesus_X();
}