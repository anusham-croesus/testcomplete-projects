//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Rel_RelationshipsBar_BtnInfo

 /* Description :Dans le du module « Relationships  »,afficher la fenêtre «Info» par Ctrl_L .(Pour la relation qui est sélectionnée par default #1 TEST) 
Vérifier la présence des contrôles et des étiquetés dans tous les onglets*/

function Survol_Rel_i_Ctrl_L()
{
  var module="relationships";
  var btn="infoRel"
  
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click(); 
  Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
  
  Get_MainWindow().Keys("^l");
  
  //Vérification du titre de la fenêtre   
  //if (client == "BNC" ){
  //  aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpEqual, GetData(filePath_Relations,"WinInfo_TabInfo",34,language));
  //}

  //Les points de vérification
  //Check_Properties_RelationshipsInfo_TabInfo(language) 
  //Grp Note
  //Check_Properties_WinInfo_Notes(language,btn);
  //Check_Properties_DetailedInfo_TabAdresses(language,module)// la fonction est dans CommonCheckpoints 
  //Check_Properties_DetailedInfo_TabProduitsServices(language,module)// la fonction est dans CommonCheckpoints 
  //Check_Properties_DetailedInfo_TabProfile(language)// la fonction est dans CommonCheckpoints
  //Check_Properties_RelationshipsInfo_TabUnderlyingAccounts(language)
  //Check_Properties_DetailedInfo_TabDocuments(language,module) // la fonction est dans CommonCheckpoints 
  
  Get_WinDetailedInfo().Close();
  
    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", 1])){
      Close_Croesus_AltQ();
  }
  else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }
}
