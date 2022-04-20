//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Survol_Cli_ClientsBar_BtnInfo_Addresses


/* Description : Dans le module « Clients », afficher l'onglet "Addresses" de la fenêtre « Info client » 
en cliquant sur MenuBar_EditFunctions_InfoAddresses. Vérifier que l'onglet "Addresses" est bien sélectionné. */

function Survol_Cli_MenuBar_EditFunctions_InfoAddresses()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();

  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().OpenMenu(); ////Il a y une anomalie dans automation 10 , le menu est vide 
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().OpenMenu();
  Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Addresses().Click();
  
  Check_WinDetailedInfo_TabAddresses_IsSelected();// la fonction est dans CommonCheckpoints Survol_Cli_ClientsBar_BtnInfo_Addresses
  
  Get_WinDetailedInfo().Close();
  
  Close_Croesus_MenuBar();
}


