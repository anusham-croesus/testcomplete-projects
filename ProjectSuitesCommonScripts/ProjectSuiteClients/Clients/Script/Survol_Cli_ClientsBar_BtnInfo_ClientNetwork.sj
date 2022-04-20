//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions


/* Description : Dans le module « Clients », afficher l'onglet "Client Network" de la fenêtre « Info client » 
en cliquant sur ClientsBar_Info > CostumerNetwork. Vérifier que l'onglet "Client Network" est bien sélectionné. */

function Survol_Cli_ClientsBar_BtnInfo_ClientNetwork()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  Get_ClientsBar_BtnInfo().Click(61, 10);
  Get_ClientsBar_BtnInfo_ItemCostumerNetwork().Click();
  
  Check_WinDetailedInfo_TabClientNetwork_IsSelected();
  
  Get_WinDetailedInfo().Close();
  
   if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"])){
     Close_Croesus_SysMenu();
  }
  else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }  
}


function Check_WinDetailedInfo_TabClientNetwork_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient(), "IsSelected", cmpEqual, true);
}


//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Probablement il y a une anomalie : le nom du bouton ne corresponde pas au nom d’onglet !!!!!!!!!!!!!!!!!!