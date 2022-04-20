﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT Survol_Cli_ClientsBar_BtnInfo_Agenda


/* Description : Dans le module « Clients », afficher l'onglet "Agenda" de la fenêtre « Info client » 
en cliquant sur MenuBar_EditFunctions_InfoAgenda. Vérifier que l'onglet "Agenda" est bien sélectionné. */

function Survol_Cli_MenuBar_EditFunctions_InfoAgenda()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();

  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().OpenMenu(); //Il a y une anomalie dans automation 10 , le menu est vide 
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info().OpenMenu();
  Get_MenuBar_Edit_FunctionsForClients_Info_Agenda().Click();
  
  Check_WinDetailedInfo_TabAgenda_IsSelected();// la fonction est dans CommonCheckpoints Survol_Cli_ClientsBar_BtnInfo_Agenda
  
  Get_WinDetailedInfo().Close();
  
  Close_Croesus_AltQ();
}
