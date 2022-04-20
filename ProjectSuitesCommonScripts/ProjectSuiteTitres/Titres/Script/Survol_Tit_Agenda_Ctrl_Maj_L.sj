//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Titre » , afficher la fenêtre « Agenda » avec Ctl+Shift+L. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements */
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-341

function Survol_Tit_Agenda_Ctrl_Maj_L()
{
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
  
  //afficher la fenêtre « Agenda » avec Ctl+Shift+L
  Get_SecurityGrid().Keys("^L");
  
  //Les points de vérification
  Check_WinAgenda_Properties(language); // la fonction est dans le script CommonCheckpoints
      
 
//  Delay(150);
  
  
//////////////////////////////////////////////////////////////////////////////////////  
 Get_WinAgenda_BtnCancel().Click();
    if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
        Get_MainWindow().SetFocus();
          Close_Croesus_AltQ();
    }
    else {
        Log.Error("La fenêtre Agenda n'était pas fermée.");
        Terminate_CroesusProcess();
    } 
  
  
  
//////////////////////////////////////////////////////////////////////////////////////  
  
//  Get_MainWindow().SetFocus()
//  Close_Croesus_AltQ()
}