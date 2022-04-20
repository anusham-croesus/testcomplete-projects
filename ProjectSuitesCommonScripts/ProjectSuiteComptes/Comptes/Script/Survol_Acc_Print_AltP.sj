//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Comptes » , afficher la fenêtre « Print » avec AltP. 
En cliquant sur le btnCancel, vérifier le message «Impression annulée» */

function Survol_Acc_Print_AltP()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();

  Get_MainWindow().Keys("~p");
  
  //Check_Print_Properties(); //la fonction est dans Common_functions
  
  Get_DlgInformation().Click(93, 66);
  
  Close_Croesus_MenuBar();
}