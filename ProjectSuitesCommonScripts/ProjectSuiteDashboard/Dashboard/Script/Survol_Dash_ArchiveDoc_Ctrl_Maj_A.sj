//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord » , afficher la fenêtre « Documents personnels » avec Ctrl+Maj+A. 
  Vérifier la présence des contrôles et des étiquettes */

function Survol_Dash_ArchiveDoc_Ctrl_Maj_A()
{
  try {
      Login(vServerDashboard, userName, psw, language);
      Get_ModulesBar_BtnDashboard().Click();
      Add_PositiveCashBalanceSummaryBoard(); //Pour que la combinaison de touches suivante marche, le tableau de bord ne doit pas être vide
  
      Get_MainWindow().Keys("^A");
  
      Check_WinPersonalDocuments_Properties(language); //La fonction est dans Common_functions
  
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
