//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

 
/* Description : Aller au module "Comptes" en cliquant sur BarModules-btnAccounts. 
 Afficher la fenêtre « Agenda » en cliquant sur ToolBar_btnAgenda. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Tâches, Activités échues, Anniversaires, Alarmes, Traitements. Fermer la fenêtre avec Esc */
function Survol_Acc_ToolBar_btnAgenda()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_Toolbar_BtnAgenda().Click();
  
  Check_WinAgenda_Properties(language);
  
  Get_WinAgenda_BtnCancel().Keys("[Esc]");

    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
        Get_MainWindow().SetFocus();
        Close_Croesus_MenuBar();
    }
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    }
}
