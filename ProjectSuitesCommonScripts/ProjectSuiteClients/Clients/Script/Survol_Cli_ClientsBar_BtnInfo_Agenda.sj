//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions


/* Description : Dans le module « Clients », afficher l'onglet "Agenda" de la fenêtre « Info client » 
en cliquant sur ClientsBar_Info > Agenda. Vérifier que l'onglet "Agenda" est bien sélectionné. */

function Survol_Cli_ClientsBar_BtnInfo_Agenda()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  Get_ClientsBar_BtnInfo().Click(61, 10);
  Get_ClientsBar_BtnInfo_ItemAgenda().Click();
  
  Check_WinDetailedInfo_TabAgenda_IsSelected();
  
  Get_WinDetailedInfo().Close();
  
  Close_Croesus_X();
}


function Check_WinDetailedInfo_TabAgenda_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient(), "IsSelected", cmpEqual, true);
}