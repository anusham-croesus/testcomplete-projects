//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : Un seul login, a partir du module « Tableau de bord »
    1- Afficher la fenêtre « Documents personnels » avec Ctrl+Maj+A.
    2- Vérifier la présence des contrôles et des étiquettes    
    3- Afficher la fenêtre « Documents personnels » en cliquant sur Menubar - btnArchiveMyDocuments. 
    4- Afficher la fenêtre « Documents personnels » en cliquant sur Toolbar - btnArchiveMyDocuments.
*/

function Survol_Dash_ArchiveDoc_CombinedAccessMethods()
{
  try {
      Login(vServerDashboard, userName, psw, language);
      Get_ModulesBar_BtnDashboard().Click();
      
      Add_PositiveCashBalanceSummaryBoard(); //Pour que la combinaison de touches suivante marche, le tableau de bord ne doit pas être vide
      
      // 1- Ctrl+Maj+A
      
      Log.Message("Afficher la fenêtre « Documents personnels » avec Ctrl+Maj+A.");
      Get_MainWindow().Keys("^A");
      
      // 2- Points de contrôles
      
      Check_WinPersonalDocuments_Properties(language); //La fonction est dans Common_functions
      
      Get_WinPersonalDocuments_BtnOK().Click();
      
      // 3- Menubar - btnArchiveMyDocuments
      
      Log.Message("Afficher la fenêtre « Documents personnels » en cliquant sur Menubar - btnArchiveMyDocuments.");
      Get_MenuBar_Tools().OpenMenu();
      Get_MenuBar_Tools_ArchiveMyDocuments().Click();
      WaitObject(Get_CroesusApp(),["Uid","VisibleOnScreen"],["GroupBox_4d7f", true]);
      //Check_WinPersonalDocuments_Properties(language);
      
      Get_WinPersonalDocuments_BtnOK().Click();
      
      // 4- Toolbar - btnArchiveMyDocuments
      
      Log.Message("Afficher la fenêtre « Documents personnels » en cliquant sur Toolbar - btnArchiveMyDocuments.");
      Get_Toolbar_BtnArchiveMyDocuments().Click();
      WaitObject(Get_CroesusApp(),["Uid","VisibleOnScreen"],["GroupBox_4d7f", true]);
      
      Get_WinPersonalDocuments_BtnOK().Click();
  }
  catch (e) {
      Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();
  }
}
