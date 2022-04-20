//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord » , afficher la fenêtre « Documents personnels » en cliquant sur Menubar- btnArchiveMyDocuments. 
  Vérifier la présence des contrôles et des étiquettes*/

function Survol_Dash_MenuBar_btnArchiveMyDocuments()
{
  try {
      Login(vServerDashboard, userName, psw, language);
      Get_ModulesBar_BtnDashboard().Click();
  
      Get_MenuBar_Tools().OpenMenu();
      Get_MenuBar_Tools_ArchiveMyDocuments().Click();
      WaitObject(Get_CroesusApp(),["Uid","VisibleOnScreen"],["GroupBox_4d7f", true]);
      //Check_WinPersonalDocuments_Properties(language);
      
      Get_WinPersonalDocuments_BtnOK().Click();
  }
  catch (e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
      Get_MainWindow().SetFocus();
      Close_Croesus_X();
  }
}