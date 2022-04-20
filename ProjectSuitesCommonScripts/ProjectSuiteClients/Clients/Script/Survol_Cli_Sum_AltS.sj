//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Cli_MenuBar_EditSum

/* Description : A partir du module « Clients » , afficher la fenêtre « Sommation des titres » avec AltS . 
 Vérifier la présence des contrôles et des étiquetés */ 

function Survol_Cli_MenuBar_EditSum()
{
  Login(vServerClients,userName,psw,language);
  Get_ModulesBar_BtnClients().Click();
    
  Get_MainWindow().Keys("~s")
   Log.Message("L'anomalie ouverte par Karima- CROES-8310")
  //Les points de vérification 
  //Check_Properties(language) //la fonction est dans Survol_Cli_MenuBar_EditSum
    
  Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_AltF4();
}