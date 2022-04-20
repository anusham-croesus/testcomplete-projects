//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions


/* Description : Dans le module « Clients », afficher l'onglet "Addresses" de la fenêtre « Info client » 
en cliquant sur CLientsBar_Info > Addresses. Vérifier que l'onglet "Addresses" est bien sélectionné. */

function Survol_Cli_ClientsBar_BtnInfo_Addresses()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  Get_ClientsBar_BtnInfo().Click(61, 10);
  Get_ClientsBar_BtnInfo_ItemAddresses().Click();
  
  Check_WinDetailedInfo_TabAddresses_IsSelected();
  
  Get_WinDetailedInfo().Close();
  
  Close_Croesus_AltF4();
}


function Check_WinDetailedInfo_TabAddresses_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses(), "IsSelected", cmpEqual, true);
}