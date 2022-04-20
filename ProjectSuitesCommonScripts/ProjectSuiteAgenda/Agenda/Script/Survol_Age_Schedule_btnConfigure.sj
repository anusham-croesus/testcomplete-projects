//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par btnConfigure 
 A partir de  l’onglet "Horaire" afficher la fenêtre  "Work As" (btnConfigure). Vérifier le texte et la présence des contrôles*/

function Survol_Age_Schedule_btnConfigure()
{
  Login(vServerAgenda, userName , psw ,language);
  
  //afficher la fenêtre « Agenda »
  Get_MenuBar_Tools().OpenMenu();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
  Get_MenuBar_Tools_Agenda().Click();
  
  Get_WinAgenda_ButtonBar_BtnSchedule().Click(); 
//  Delay(1000); 

WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda, "Survol_Age_Schedule",7, language), true]);
    
  Get_WinAgenda_BtnConfigure().Click();
//  Delay(150);
WaitObject(Get_CroesusApp(), ["Title", "VisibleOnScreen"], [GetData(filePath_Agenda, "Survol_Age_btnConfigure",2, language), true]);
  
  //Les points de vérifications 
  Check_btnConfigure_Properties(language)
  // Fermeture de la fenêtre "Work as" (Laquelle on ouvre en cliquant sur le bouton Configure...)   
  Get_WinUserSelection_BtnCancel().Click();

  
//  Delay(150);

   Get_WinAgenda_BtnCancel().Keys("[Esc]");
    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
        Get_MainWindow().SetFocus();
        Close_Croesus_AltQ()
    }
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    }


//  Get_MainWindow().SetFocus()
//  Close_Croesus_AltQ()
}

function Check_btnConfigure_Properties(language)
{
  aqObject.CheckProperty(Get_WinUserSelection(), "Title", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",2,language));
  
  aqObject.CheckProperty(Get_WinUserSelection_BtnOK(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",3,language));
  aqObject.CheckProperty(Get_WinUserSelection_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinUserSelection_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinUserSelection_BtnCancel(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",4,language));
  aqObject.CheckProperty(Get_WinUserSelection_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinUserSelection_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinUserSelection_DgvAvailableUsers(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinUserSelection_DgvSelectedUsers(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinUserSelection_BtnAddCurrentAvailableUserToSelectionList(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinUserSelection_BtnAddCurrentAvailableUserToSelectionList(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinUserSelection_BtnRemoveTheSelectedUserFromTheSelectionList(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinUserSelection_BtnRemoveTheSelectedUserFromTheSelectionList(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinUserSelection_LblAvailableUsers(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",6,language));
  Log.Message("Anomalie  CROES-6460 ");
  aqObject.CheckProperty(Get_WinUserSelection_DgvAvailableUsers_ChLastName(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",7,language));
  aqObject.CheckProperty(Get_WinUserSelection_DgvAvailableUsers_ChFirstName(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",8,language));
  
  aqObject.CheckProperty(Get_WinUserSelection_LblSelectedUsers(), "Text", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",10,language));
  Log.Message("Anomalie  CROES-6460 ");
  aqObject.CheckProperty(Get_WinUserSelection_DgvSelectedUsers_ChLastName(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",11,language));
  aqObject.CheckProperty(Get_WinUserSelection_DgvSelectedUsers_ChFirstName(), "Content", cmpEqual, GetData(filePath_Agenda,"Survol_Age_btnConfigure",12,language));
  
}