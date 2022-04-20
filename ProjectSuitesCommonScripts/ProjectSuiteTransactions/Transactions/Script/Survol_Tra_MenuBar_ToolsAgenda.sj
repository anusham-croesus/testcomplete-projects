//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

 /* Description : A partir du module « Transactions » , afficher la fenêtre « Agenda » en cliquant sur MenuBar -Tools- btnAgenda. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements */

 function Survol_Tra_MenuBar_ToolsAgenda()
{
  Login(vServerTransactions, userName , psw ,language);
  Get_ModulesBar_BtnTransactions().Click();
  
  WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
  WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
  Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000); 
  
  //afficher la fenêtre « Agenda » en cliquant sur MenuBar -Tools- btnAgenda.
  Get_MenuBar_Tools().OpenMenu();
  Get_MenuBar_Tools_Agenda().Click();
  
   var numberOftries=0;  
   while ( numberOftries < 5 && !Get_WinAgenda().Exists){
    Get_MenuBar_Tools_Agenda().Click();  
    numberOftries++;
   }
  
  //Les points de vérification
  Check_WinAgenda_Properties(language);
   
  //La fermeture de la fenêtre 
  Get_WinAgenda_BtnCancel().Click();
  
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
     Get_MainWindow().SetFocus();
     Close_Croesus_AltF4();
  }
  else {
    Log.Error("La fenêtre Agenda n'était pas fermée.");
    Terminate_CroesusProcess();
  } 
}
