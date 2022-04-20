//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Comptes » , afficher la fenêtre « Documents personnels » en cliquant sur Menubar - btnArchiveMyDocuments. 
  Vérifier la présence des contrôles et des étiquettes*/

function Survol_Acc_MenuBar_btnArchiveMyDocuments()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_MenuBar_Tools().OpenMenu();
  Get_MenuBar_Tools_ArchiveMyDocuments().Click();
  
  Check_WinPersonalDocuments_Properties(language);
      
  Get_WinPersonalDocuments_BtnOK().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_X();
}