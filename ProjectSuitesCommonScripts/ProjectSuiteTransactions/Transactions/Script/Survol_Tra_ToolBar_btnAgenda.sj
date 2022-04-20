﻿//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Titre » , afficher la fenêtre « Agenda » en cliquant sur Toolbar - btnAgenda. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements */

function Survol_Tra_ToolBar_btnAgenda()
{
  Login(vServerTransactions, userName , psw ,language);
  Get_ModulesBar_BtnTransactions().Click();
  Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);
  
  //afficher la fenêtre « Agenda » en cliquant sur Toolbar - btnAgenda.
  
  
  
  Get_Toolbar_BtnAgenda().Click();
  
  
   var numberOftries=0;  
  while ( numberOftries < 5 && !Get_WinAgenda().Exists){
     Get_Toolbar_BtnAgenda().Click();
    numberOftries++;
  } 
  
  //Les points de vérification
  Check_WinAgenda_Properties(language);
  
  //La fermeture de la fenêtre « Agenda »
  Get_WinAgenda_BtnCancel().Click(); 
  
  
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
       Get_MainWindow().SetFocus();
       Close_Croesus_X();
    }
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    }
  
  
  
  
}