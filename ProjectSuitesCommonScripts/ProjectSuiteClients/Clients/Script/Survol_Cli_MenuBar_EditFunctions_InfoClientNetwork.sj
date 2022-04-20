//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Survol_Cli_ClientsBar_BtnInfo_ClientNetwork

/* Description : Dans le module « Clients », afficher l'onglet "Client Network" de la fenêtre « Info client » 
en cliquant sur EditFunctions_InfoClientNetwork. Vérifier que l'onglet "Client Network" est bien sélectionné. */

function Survol_Cli_MenuBar_EditFunctions_InfoClientNetwork()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().OpenMenu(); //Il a y une anomalie dans automation 10 , le menu est vide 
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().OpenMenu();
  Get_MenuBar_Edit_FunctionsForClients_Info_CostumerNetwork().Click();
  
  Check_WinDetailedInfo_TabClientNetwork_IsSelected();// la fonction est dans Survol_Cli_ClientsBar_BtnInfo_ClientNetwork
  
  Get_WinDetailedInfo().Close();
  
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"])){
     Close_Croesus_SysMenu();
  }
  else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  } 
}