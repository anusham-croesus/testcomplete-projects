//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par MenuBar_ToolsAgenda. 
 A partir de  l’onglet "Birthdays" afficher la fenêtre Print en cliquant sur le btn Print. Vérifier le texte et la présence des contrôles */

function Survol_Age_Birthdays_btnPrint()
{
  var birthdays=GetData(filePath_Agenda,"Survol_Age_Birthdays",3,language);
  var winTitle=GetData(filePath_Agenda,"Survol_Age_Schedule",2,language);
  
  Login(vServerAgenda, userName , psw ,language);  
  Get_MenuBar_Tools().OpenMenu();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
  Get_MenuBar_Tools_Agenda().Click();
  
  Get_WinAgenda_ButtonBar_BtnBirthdays().Click();
  WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", birthdays, true]);
  
  if(Get_WinAgenda_DgvListView().Items.Count > 0){
      Get_WinAgenda_PadHeaderBar_BtnPrint().Click();
      WaitObject(Get_CroesusApp(), ["WndCaption", "WndClass", "VisibleOnScreen"], ["Print", "#32770", true]);
  
     //Les points de vérification en français 
      if(language=="french"){Check_Print_Properties_French()} // la fonction est dans le script Common_functions
      //Les points de vérification en anglais 
      else{Check_Print_Properties_English()} // la fonction est dans le script Common_functions
      Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  }  
    
  //Fermeture de la fenêtre Agenda
  Get_WinAgenda().Close();
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", winTitle])){
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
  }
  else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
  }
}

