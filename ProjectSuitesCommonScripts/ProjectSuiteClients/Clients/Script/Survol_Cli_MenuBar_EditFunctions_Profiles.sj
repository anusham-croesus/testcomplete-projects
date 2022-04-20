﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Survol_Cli_ClientsBar_BtnInfo_Profiles

/* Description : Dans le module « Clients », afficher l'onglet "Profiles" de la fenêtre « Info client » 
en cliquant sur MenuBar_EditFunctions_Profiles. Vérifier que l'onglet "Profiles" est bien sélectionné. */

function Survol_Cli_MenuBar_EditFunctions_Profiles()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().OpenMenu(); //Il a y une anomalie dans automation 10 , le menu est vide 
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().OpenMenu();
  Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Profiles().Click();
  
  Check_WinDetailedInfo_TabProfiles_IsSelected();// la fonction est dans  Survol_Cli_ClientsBar_BtnInfo_Profiles
  
  Get_WinDetailedInfo().Close();
  
  if (WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlName"], ["UniDialog", "basedialog1"])){
     Close_Croesus_AltF4();
  }
  else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }
}