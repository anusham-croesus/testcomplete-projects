//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Modeles » :
    1- Afficher la fenêtre « Agenda » avec Ctrl + Shift + L.
    2- Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets
       Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements.
    3- Afficher la fenêtre « Agenda » en cliquant sur MenuBar -Tools- btnAgenda.
    4- Afficher la fenêtre « Agenda » en cliquant sur Toolbar - btnAgenda.
*/

function Survol_Mod_Agenda_CombinedAccessMethods()
{
  try {
        Login(vServerModeles, userName , psw ,language);
        Get_ModulesBar_BtnModels().Click();
        
        // Boucle des différents cas.        
        for (i = 1; i <= 3; i++)
        {
          if (i == 1) {
              // 1- Ctrl + Shift + L
        
              Log.Message("Afficher la fenêtre « Agenda » avec Ctrl + Shift + L.");
              Get_MainWindow().Keys("^L");
        
              // 2- Vérifications
        
              Check_WinAgenda_Properties(language);
              Get_WinAgenda_BtnCancel().Click();
          }
          if (i == 2) {
            // 3- MenuBar -Tools- btnAgenda
        
            Log.Message("Afficher la fenêtre « Agenda » en cliquant sur MenuBar -Tools- btnAgenda.");
            Get_MenuBar_Tools().OpenMenu();
            Get_MenuBar_Tools_Agenda().Click();
            Get_WinAgenda().Close();
          }
          if (i == 3) {
            // 4- Toolbar - btnAgenda
        
            Log.Message("Afficher la fenêtre « Agenda » en cliquant sur Toolbar - btnAgenda.");
            Get_ModulesBar_BtnSecurities().Click();
            Get_Toolbar_BtnAgenda().Click();
            Get_WinAgenda_BtnCancel().Click();
          }
          
          // Valider la fermeture de la fenêtre Agenda
          
          if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
              Get_MainWindow().SetFocus();
              Log.Checkpoint("La fenêtre Agenda s'est fermée correctement.");
          }
          else
              Log.Error("La fenêtre Agenda n'était pas fermée.");
        }
  }
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
        Terminate_CroesusProcess();
  }
}
