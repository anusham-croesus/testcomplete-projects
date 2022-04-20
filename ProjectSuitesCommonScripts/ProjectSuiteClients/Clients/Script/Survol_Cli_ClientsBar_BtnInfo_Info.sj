//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions


/* Description : Dans le module « Clients », afficher l'onglet "Info" de la fenêtre « Info client » 
en cliquant sur ClientsBar_Info > Info. Vérifier que l'onglet "Info" est bien sélectionné. */

function Survol_Cli_ClientsBar_BtnInfo_Info()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  Get_ClientsBar_BtnInfo().Click(61, 10);
  Get_ClientsBar_BtnInfo_ItemInfo().Click();
  
  Check_WinDetailedInfo_TabInfo_IsSelected();
  
  Get_WinDetailedInfo().Close();
  
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"])){
     Close_Croesus_AltF4();
  }
  else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }

}


function Check_WinDetailedInfo_TabInfo_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo(), "IsSelected", cmpEqual, true);
}