//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Relations » , afficher la fenêtre « Agenda » en cliquant sur Toolbar - btnAgenda. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements */

function Survol_Rel_ToolBar_btnAgenda()
{language=="english"
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click();
  Get_Toolbar_BtnAgenda().Click();
  
  //Les points de vérification
  Check_WinAgenda_Properties(language);
  
  Get_WinAgenda_BtnCancel().Click();  
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
      Get_MainWindow().SetFocus();
      Close_Croesus_AltQ();
  }
  else {
      Log.Error("La fenêtre Agenda n'était pas fermée.");
      Terminate_CroesusProcess();
  }  

}