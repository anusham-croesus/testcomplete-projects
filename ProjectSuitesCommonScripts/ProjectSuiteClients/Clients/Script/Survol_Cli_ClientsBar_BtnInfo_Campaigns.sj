//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions


/* Description : Dans le module « Clients », afficher l'onglet "Campaigns" de la fenêtre « Info client » 
en cliquant sur ClientsBar_Info > Campaigns. Vérifier que l'onglet "Campaigns" est bien sélectionné. */

function Survol_Cli_ClientsBar_BtnInfo_Campaigns()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  Get_ClientsBar_BtnInfo().Click(61, 10);
  Get_ClientsBar_BtnInfo_ItemCampaigns().Click();
  
  Check_WinDetailedInfo_TabCampaigns_IsSelected();
  
  Get_WinDetailedInfo().Close();
  
  Close_Croesus_X();
}


function Check_WinDetailedInfo_TabCampaigns_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient(), "IsSelected", cmpEqual, true);
}