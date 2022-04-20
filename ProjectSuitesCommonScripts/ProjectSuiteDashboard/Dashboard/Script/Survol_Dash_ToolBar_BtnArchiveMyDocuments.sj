//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : À partir du module « Tableau de bord » , afficher la fenêtre « Documents personnels » en cliquant sur Toolbar - btnArchiveMyDocuments. 
  Vérifier la présence des contrôles et des étiquettes*/

function Survol_Dash_ToolBar_BtnArchiveMyDocuments()
{
  try {
      Login(vServerDashboard, userName, psw, language);
      Get_ModulesBar_BtnDashboard().Click();
  
      Get_Toolbar_BtnArchiveMyDocuments().Click();
      WaitObject(Get_CroesusApp(),["Uid","VisibleOnScreen"],["GroupBox_4d7f", true]);
      //Check_WinPersonalDocuments_Properties(language);
  
      Get_WinPersonalDocuments_BtnOK().Click();
  }
  catch (e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
      Get_MainWindow().SetFocus();
      Close_Croesus_AltQ();
  }
}