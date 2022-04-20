//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Comptes » , afficher la fenêtre « Documents personnels » avec Ctrl+Maj+A. 
  Vérifier la présence des contrôles et des étiquettes */

function Survol_Acc_ArchiveDoc_Ctrl_Maj_A()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_MainWindow().Keys("^A");
  
  Check_WinPersonalDocuments_Properties(language);
  
  Get_WinPersonalDocuments_BtnOK().Click();
  
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar();
}
