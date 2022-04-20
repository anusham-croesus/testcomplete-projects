//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions

/*** Fonction communes au tests pour la fenêtre popup Client Info, invoquée via la barre de menus EDIT/Functions ***/

function Check_WinDetailedInfo_TabAddresses_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses(), "IsSelected", cmpEqual, true);
}

function Check_WinDetailedInfo_TabAgenda_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient(), "IsSelected", cmpEqual, true);
}

function Check_WinDetailedInfo_TabCampaigns_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient(), "IsSelected", cmpEqual, true);
}

function Check_WinDetailedInfo_TabClientNetwork_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient(), "IsSelected", cmpEqual, true);
}

function Check_WinDetailedInfo_TabDefaultIndices_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabDefaultIndices(), "IsSelected", cmpEqual, true);
}

function Check_WinDetailedInfo_TabDefaultReports_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports(), "IsSelected", cmpEqual, true);
}

function Check_WinDetailedInfo_TabDocuments_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabDocuments(), "IsSelected", cmpEqual, true);
}

function Check_WinDetailedInfo_TabInfo_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo(), "IsSelected", cmpEqual, true);
}

function Check_WinDetailedInfo_TabInvestmentObjective_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices(), "IsSelected", cmpEqual, true);
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective(), "IsSelected", cmpEqual, true);
}

function Check_WinDetailedInfo_TabProductsAndServices_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices(), "IsSelected", cmpEqual, true);
}

function Check_WinDetailedInfo_TabProfiles_IsSelected()
{
  aqObject.CheckProperty(Get_WinDetailedInfo_TabProfile(), "IsSelected", cmpEqual, true);
}
