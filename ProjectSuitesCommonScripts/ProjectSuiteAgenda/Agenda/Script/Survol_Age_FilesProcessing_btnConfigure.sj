//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Age_Schedule_btnConfigure
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par btnConfigure 
 A partir de  l’onglet "FilesProcessing" afficher la fenêtre  "Work As" (btnConfigure). Vérifier le texte et la présence des contrôles*/

function Survol_Age_FilesProcessing_btnConfigure()
{
  Login(vServerAgenda, userName , psw ,language);
  
  //afficher la fenêtre « Agenda »
  Get_MenuBar_Tools().OpenMenu();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
  Get_MenuBar_Tools_Agenda().Click();
  
  Get_WinAgenda_ButtonBar_BtnFilesProcessing().Click();  
  WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda,"Survol_Age_FilesProcessing",3,language), true]);
  //Delay(150);
  Get_WinAgenda_BtnConfigure().Click();
  WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["UserSelectionWindow_f6ea",true]);
  //Delay(150);
  
  //Les points de vérifications 
  Check_btnConfigure_Properties(language); // la fonction est dans le script Survol_Age_Schedule_btnConfigure
      
  Get_WinUserSelection().Close();
  Get_WinAgenda_BtnCancel().Keys("[Esc]");
  
   if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda,"Survol_Age_Schedule",2,language)])){
       Get_MainWindow().SetFocus();
       Close_Croesus_MenuBar();
   }
   else {
       Log.Error("La fenêtre Agenda n'était pas fermée.");
       Terminate_CroesusProcess();
   }
  
  //Get_MainWindow().SetFocus()
  //Close_Croesus_AltQ()
}