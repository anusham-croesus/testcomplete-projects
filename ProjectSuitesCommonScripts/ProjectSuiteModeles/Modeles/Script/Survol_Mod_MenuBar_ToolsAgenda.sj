//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

 /* Description : A partir du module « Modeles » , afficher la fenêtre « Agenda » en cliquant sur MenuBar -Tools- btnAgenda. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements */

function Survol_Mod_MenuBar_ToolsAgenda()
{
  try {
        Login(vServerModeles, userName , psw ,language);
        Get_ModulesBar_BtnModels().Click();
  
        Get_MenuBar_Tools().OpenMenu();
        Get_MenuBar_Tools_Agenda().Click();
  
        //Check_WinAgenda_Properties(language);
  
      //  //Les points de vérification en français 
      //   if(language=="french"){Check_WinAgenda_Properties_French()} // la fonction est dans CommonCheckpoints
      //   //Les points de vérification en anglais 
      //   else {Check_WinAgenda_Properties_English()} // la fonction est dans CommonCheckpoints
      //   
      //  Check_WinAgenda_Existence_Of_Controls()
  
        Get_WinAgenda().Close();
        
      //  Delay(200)
      //  Get_MainWindow().SetFocus()
  
  
        if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniFrame", GetData(filePath_Agenda, "Survol_Age_Schedule", 2, language)])){
            Get_MainWindow().SetFocus();
            Close_Croesus_AltF4();
        }
        else
            Log.Error("La fenêtre Agenda n'était pas fermée.");
  }
  catch (e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
        Terminate_CroesusProcess();
        //Close_Croesus_AltF4()
  }
}
