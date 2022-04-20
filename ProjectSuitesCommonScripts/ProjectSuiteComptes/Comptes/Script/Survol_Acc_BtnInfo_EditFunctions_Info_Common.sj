//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/*** Fonction communes au tests pour la fenêtre popup Comptes Info, invoquée via la barre de menus EDIT/Functions ou via le bouton Info***/
/* 
L'objectif est de rassembler toutes les fonctions communes dont le but d'optimiser les scripts
Date: 02/06/2020
Analyste testauto: Abdelm
*/

function Check_WinAccountInfo_TabRegisteredAccounts_IsSelected()
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts(), "IsSelected", cmpEqual, true);
}

function Check_WinAccountInfo_TabDates_IsSelected()
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabDates(), "IsSelected", cmpEqual, true);
}

function Check_WinAccountInfo_TabDefaultIndices_IsSelected()
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabDefaultIndices(), "IsSelected", cmpEqual, true);
}

function Check_WinAccountInfo_TabDefaultReports_IsSelected()
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabDefaultReports(), "IsSelected", cmpEqual, true);
}

function Check_WinAccountInfo_TabHolders_IsSelected()
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabHolders(), "IsSelected", cmpEqual, true);
}

function Check_WinAccountInfo_TabInvestmentObjective_IsSelected()
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabInvestmentObjective(), "IsSelected", cmpEqual, true);
}

function Check_WinAccountInfo_TabNotes_IsSelected()
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabNotes(), "IsSelected", cmpEqual, true);
}

function Check_WinAccountInfo_TabProfile_IsSelected()
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabProfile(), "IsSelected", cmpEqual, true);
}

function Check_WinAccountInfo_TabPW1859_IsSelected()
{
  aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859(), "IsSelected", cmpEqual, true);
}
