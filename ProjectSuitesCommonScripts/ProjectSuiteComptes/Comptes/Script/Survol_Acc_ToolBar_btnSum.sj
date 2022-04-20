//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT Survol_Acc_MenuBar_EditSum
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Comptes » , afficher la fenêtre « Sommation des Comptes » 
en cliquant sur le bouton Sum de la barre d'outils. Vérifier la présence des contrôles et des étiquettes */

function Survol_Acc_ToolBar_btnSum()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
    
  Get_Toolbar_BtnSum().Click();
    
  //Check_Properties();
    
  Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_AltQ();
}