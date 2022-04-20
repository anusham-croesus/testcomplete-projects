//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Transactions » , afficher la fenêtre « Agenda » avec Ctl+Shift+L. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements */

function Survol_Tra_Agenda_Ctrl_Maj_L()
{
  Login(vServerTransactions, userName , psw ,language);
  Get_ModulesBar_BtnTransactions().Click();
  Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);
  Get_TransactionsBar().click();
  
  //afficher la fenêtre « Agenda » avec Ctl+Shift+L.
  Get_MainWindow().Keys("^L");
  
  //Les points de vérification
  Check_WinAgenda_Properties(language);
  
  //La fermeture de la fenêtre « Agenda »  
  Get_WinAgenda_BtnCancel().Click();
  
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
       Get_MainWindow().SetFocus()
  Close_Croesus_AltQ()
    }
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    }
  
  
  
  
  
  
}