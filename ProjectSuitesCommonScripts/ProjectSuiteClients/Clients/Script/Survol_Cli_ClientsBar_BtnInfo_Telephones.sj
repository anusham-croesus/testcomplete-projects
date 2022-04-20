//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Survol_Cli_ClientsBar_BtnInfo_Addresses

/* Description : Dans le module « Clients », afficher l'onglet "Info" de la fenêtre « Info client » 
en cliquant sur ClientsBar_Info > Notes. Vérifier que l'onglet "Info" est bien sélectionné. */

function Survol_Cli_ClientsBar_BtnInfo_Telephones()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  Get_ClientsBar_BtnInfo().Click(61, 10);
  Get_ClientsBar_BtnInfo_ItemTelephons().Click();
  
  Check_WinDetailedInfo_TabAddresses_IsSelected();// la fonction est dans  Survol_Cli_ClientsBar_BtnInfo_Addresses
  
  Get_WinDetailedInfo().Close();
  
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"])){
     Close_Croesus_AltF4();
  }
  else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }
}
