//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : Ouvrir l'application et  afficher la fenêtre « Agenda » par MenuBar_ToolsAgenda. 
 A partir de  l’onglet "Overdue" afficher la fenêtre Print en cliquant sur le btn Print. Vérifier le texte et la présence des contrôles */

function Survol_Age_Overdue_btnPrint()
{
  Login(vServerAgenda, userName , psw ,language);  
  Get_MenuBar_Tools().OpenMenu();
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["CFMenuItem_b500", true]);
  Get_MenuBar_Tools_Agenda().Click();
  
  Get_WinAgenda_ButtonBar_BtnOverdue().Click();
  WaitObject(Get_WinAgenda(), ["Uid", "Text", "VisibleOnScreen"], ["ItemsControl_ca1a", GetData(filePath_Agenda,"Survol_Age_Overdue",3,language), true]);
  Get_WinAgenda_PadHeaderBar_BtnPrint().Click();
  WaitObject(Get_CroesusApp(), ["WndCaption", "WndClass", "VisibleOnScreen"], ["Print", "#32770", true]);
  
 //Les points de vérification en français 
  if(language=="french"){Check_Print_Properties_French()} // la fonction est dans le script Common_functions
  //Les points de vérification en anglais 
  else{Check_Print_Properties_English()} // la fonction est dans le script Common_functions
  
  Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
  Get_WinAgenda_BtnCancel().Click();
   if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda,"Survol_Age_Schedule",2,language)])){
       Get_MainWindow().SetFocus();
       Close_Croesus_MenuBar();
   }
   else {
       Log.Error("La fenêtre Agenda n'était pas fermée.");
       Terminate_CroesusProcess();
   }
}

