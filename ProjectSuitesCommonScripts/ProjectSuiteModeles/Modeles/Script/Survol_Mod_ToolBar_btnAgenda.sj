//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Agenda_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Modeles » , afficher la fenêtre « Agenda » en cliquant sur Toolbar - btnAgenda. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements */

function Survol_Mod_ToolBar_btnAgenda()
{
  try {
        Login(vServerModeles, userName , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_Toolbar_BtnAgenda().Click();
  
        //Check_WinAgenda_Properties(language);
  
        //   //Les points de vérification en français 
        //   if(language=="french"){Check_WinAgenda_Properties_French()} // la fonction est dans CommonCheckpoints
        //   //Les points de vérification en anglais 
        //   else {Check_WinAgenda_Properties_English()} // la fonction est dans CommonCheckpoints
        //   
        //  Check_WinAgenda_Existence_Of_Controls()
  
          Get_WinAgenda_BtnCancel().Click();
          
        //  Get_MainWindow().SetFocus()
        //  Delay(200)
        if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
            Get_MainWindow().SetFocus();
            Close_Croesus_SysMenu();
        }
        else
            Log.Error("La fenêtre Agenda n'était pas fermée.");
  }
  catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
        Terminate_CroesusProcess(); //Fermer Croesus
      }
  

//  Close_Croesus_SysMenu()
}