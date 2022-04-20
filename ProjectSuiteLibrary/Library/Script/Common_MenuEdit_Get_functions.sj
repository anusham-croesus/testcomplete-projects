//USEUNIT Global_variables

//++++++++++++++++++++++++++++++++++ MENU EDITION (EDIT MENU) ++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++ MENUBAR ++++++++++++++++++++++++++++++
function Get_CroesusApp(){return Aliases.CroesusApp}

function Get_MenuBar(){return Aliases.CroesusApp.winMain.barMenu}

function Get_SubMenus(){return Aliases.CroesusApp.subMenus}

function Get_MenuBar_Edit(){return Get_MenuBar().FindChild("Uid", "CustomizableMenu_df61", 10)} //ok

function Get_MenuBar_Edit_Edit(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_3753", 10)} //ok

function Get_MenuBar_Edit_Detail(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_6334", 10)} //ok

function Get_MenuBar_Edit_Add(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_2119", 10)} //ok

function Get_MenuBar_Edit_Delete(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_876f", 10)} //ok

function Get_MenuBar_Edit_Copy(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_0367", 10)} //ok

function Get_MenuBar_Edit_CopyWithHeader(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_1556", 10)} //ok

function Get_MenuBar_Edit_ExportToFile(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_8c15", 10)} //ok

function Get_MenuBar_Edit_ExportToMsExcel(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_9042", 10)} //ok

function Get_MenuBar_Edit_Info(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_2820", 10)} //ok

//Non applicable au module Transactions
function Get_MenuBar_Edit_Functions(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_b359", 10)}

//Seulement applicable au module Transactions
function Get_MenuBar_Edit_FunctionsForTransactions(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_1e95")} 

//Non applicable au module Modèles
function Get_MenuBar_Edit_Relationship(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_7722", 10)} //ok

//Applicable aux modules Relations, Clients, Comptes, Portefeuille
function Get_MenuBar_Edit_AssignToAnExistingModel(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_2602", 10)} //ok

function Get_MenuBar_Edit_Search(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_5830", 10)} //ok

function Get_MenuBar_Edit_ChangeSortOrder(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_cf34", 10)} //ok

function Get_MenuBar_Edit_Sum(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_c4da", 10)} //ok

function Get_MenuBar_Edit_SelectAll(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_36d9", 10)} //ok

function Get_MenuBar_Edit_CancelSelection(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_2a03", 10)} //ok

//Applicable seulement aux modules Tableau de bord, Modèles, Relations, Clients, Comptes, Transactions
//Non applicable aux modules Titres et Ordres
function Get_MenuBar_Edit_URLandExternalPackages(){return Get_SubMenus().menuEditURLandExternalPackages} //Non disponible avec Automation 8

//Edition > Relations pour le module Relations
function Get_MenuBar_Edit_Relationship_CreateGroupedRelationship(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_db79", 10, true, 15000)}

function Get_MenuBar_Edit_Relationship_JoinToAGroupedRelationship(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_0bc7", 10, true, 15000)}

//Edition > Relations pour les modules Clients et Comptes
function Get_MenuBar_Edit_Relationship_CreateANewRelationship(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_1798", 10, true, 15000)}

function Get_MenuBar_Edit_Relationship_JoinToAnExistingRelationship(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_c7bc", 10, true, 15000)}


//Edition > Ajouter pour les modules Relations et Clients

function Get_MenuBar_Edit_AddForRelationshipsAndClients(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_cefe", 10)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_CreateFictitiousClient(){return Get_CroesusApp().FindChildEx("Uid", "MenuItem_19bd", 10, true, 15000)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_CreateExternalClient(){return Get_CroesusApp().FindChildEx("Uid", "MenuItem_91a1", 10, true, 15000)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_AddRelationship(){return Get_CroesusApp().FindChildEx("Uid", "MenuItem_f76c", 10, true, 15000)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinRelationshipTo(){return Get_CroesusApp().FindChildEx("Uid", "MenuItem_e3ad", 10, true, 15000)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinClientsToRelationship(){return Get_CroesusApp().FindChildEx("Uid", "MenuItem_2ec3", 10, true, 15000)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinAccountsToRelationship(){return Get_CroesusApp().FindChildEx("Uid", "MenuItem_e4b6", 10, true, 15000)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinToAGroupedRelationship(){return Get_CroesusApp().FindChildEx("Uid", "MenuItem_149b", 10, true, 15000)}


//Edition > Fonctions pour les modules Relations, Clients et Comptes

function Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["MenuItem", "_Info", "2"], 10, true, 15000)}

function Get_MenuBar_Edit_FunctionsForAccounts_Alarms()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Alarmes"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Alarms"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Performance()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Performa_nce..."], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Perf_ormance..."], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndAccounts_Restrictions()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Restric_tions..."], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Restri_ctions..."], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Activities()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "A_ctivités..."], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "A_ctivities..."], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_ButtonBar()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Barre de boutons"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Button Bar"], 10, true, 15000)}
}


function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Info(){return Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Info"], 10)}

function Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info_Notes(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Notes"], 10, true, 15000)}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Addresses()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Adresses"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Addresses"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Telephons()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Téléphones"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Telephones"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Email()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Courriel"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Email"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForClients_Info_Agenda(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Agenda"], 10, true, 15000)}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_ProductsAndServices()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Produits & services"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Products & Services"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_InvestmentObjective()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Objectif de placement"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Investment Objective"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_DefaultReports()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Rapports par défaut"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Default Reports"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_DefaultIndices()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Indices par défaut"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Default Indices"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Profiles()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Profils"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Profiles"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationships_Info_UnderlyingAccounts()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Comptes sous-jacents"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Underlying Accounts"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Documents(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Documents"], 10, true, 15000)}

function Get_MenuBar_Edit_FunctionsForClients_Info_CostumerNetwork()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Réseau d'influence"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Client Network"], 10, true, 15000)} //EM : 90-07-23-CO - Modifié selon le Jira CROES-1425
}

function Get_MenuBar_Edit_FunctionsForClients_Info_Campaigns()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Campagnes"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Campaigns"], 10, true, 15000)}
}



function Get_MenuBar_Edit_FunctionsForAccounts_Info_InvestmentObjective()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Objectif de placement"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Investment Objective"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_DefaultReports()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Rapports par défaut"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Default Reports"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_DefaultIndices()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Indices par défaut"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Default Indices"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_Profiles()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Profils"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Profiles"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_Dates(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Dates"], 10, true, 15000)}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_Holders()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Détenteurs"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Holders"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_PW1859()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "GP1859"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "PW1859"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_RegisteredAccounts()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Comptes enregistrés"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Registered Accounts"], 10, true, 15000)}
}



//Edition > Fonctions pour le module Transactions

function Get_MenuBar_Edit_FunctionsForTransactions_Info()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Info"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "I_nfo"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForTransactions_GainsLosses()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Gains/Pertes"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Gains/Losses"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForTransactions_Filter()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Fi_ltre"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "F_ilter"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForTransactions_Position(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Position"], 10, true, 15000)}

//Edition > Fonctions pour le module Modèles

function Get_MenuBar_Edit_FunctionsForModels_Info(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Info"], 10, true, 15000)} //no uid

function Get_MenuBar_Edit_FunctionsForModels_UnderlyingPerformance() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Perfo. sous-jacente"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Under. Performance"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForModels_Documents(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Documents"], 10, true, 15000)} //no uid

function Get_MenuBar_Edit_FunctionsForModels_Restrictions(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Restrictions"], 10, true, 15000)} //no uid

//Edition > Fonctions pour le module Titres

function Get_MenuBar_Edit_FunctionsForSecurities_Info() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Info"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "I_nfo"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForSecurities_HistoricalData() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Données historiques"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Historical _Data"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForSecurities_TotalHeld() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Total détenu"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "T_otal Held"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForSecurities_ExchangeRate() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "T_aux de change"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Exch_ange Rate"], 10, true, 15000)}
}

//Edition > Fonctions pour le module Portefeuille

function Get_MenuBar_Edit_FunctionsForPortfolio_Info() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Info"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "I_nfo"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_TradeDateBalance() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "So_lde date trans."], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Trade Date _Bal."], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_TotalValue() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Valeur _totale"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Total Value"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_CashFlowProject() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Pro_j. liquidités"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Cash Fl_ow Proj."], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_Save() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Sau_vegarder"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Sa_ve"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_All() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Tous"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_All"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_WhatIf() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Simulat_ion"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_What-If"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_Compare() //missing in Automation 8
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Comparaison"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "_Compare"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_Cancel() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Annuler"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Cancel"], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_ButtonBar() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Barre de boutons"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Button Bar"], 10, true, 15000)}
}

//Edition > Fonctions pour le module Ordres

function Get_MenuBar_Edit_FunctionsForOrders_CFO(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "CFO..."], 10, true, 15000)}

function Get_MenuBar_Edit_FunctionsForOrders_View()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Consulter..."], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "View..."], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForOrders_Fills()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Exécutions..."], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Fills..."], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForOrders_CXL(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "CXL"], 10, true, 15000)}

function Get_MenuBar_Edit_FunctionsForOrders_Replace()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Replacer..."], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Replace..."], 10, true, 15000)}
}

function Get_MenuBar_Edit_FunctionsForOrders_Refresh()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Rafraîchir"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Refresh"], 10, true, 15000)}
}


//Edition > Module de saisie des ordres (Disponible pour tous les modules sauf Modèles)
function Get_MenuBar_Edit_OrderEntryModule(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_e0c0", 10)}

function Get_MenuBar_Edit_OrderEntryModule_CreateABuyOrder(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_f876", 10, true, 15000)}

function Get_MenuBar_Edit_OrderEntryModule_CreateASellOrder(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_e904", 10, true, 15000)}

function Get_MenuBar_Edit_OrderEntryModule_SwitchBlock(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_4a5b", 10, true, 15000)}

//*********************************************** SWITCH/BLOCK WINDOW (FENÊTRE ÉCHANGE/BLOC)*************************************************
//Edit--> Prder Entry Module --> Multiple, block and swich orders
function Get_WinSwitchBlock(){return Aliases.CroesusApp.winSwitchBlock}


function Get_WinSwitchBlock_GrpParameters(){return Get_WinSwitchBlock().FindChild("Uid", "GroupBox_8c44", 10)}

function Get_WinSwitchBlock_GrpParameters_LblSources(){return Get_WinSwitchBlock_GrpParameters().FindChild("Uid", "TextBlock_3d5e", 10)}

function Get_WinSwitchBlock_GrpParameters_LblElements(){return Get_WinSwitchBlock_GrpParameters().FindChild("Uid", "TextBlock_42e5", 10)}

function Get_WinSwitchBlock_GrpParameters_CmbSources(){return Get_WinSwitchBlock_GrpParameters().FindChild("Uid", "ComboBox_6e1e", 10)}

function Get_WinSwitchBlock_GrpParameters_LblTransactions(){return Get_WinSwitchBlock_GrpParameters().FindChild("Uid", "TextBlock_4c4f", 10)}

function Get_WinSwitchBlock_GrpParameters_CmbTransactions(){return Get_WinSwitchBlock_GrpParameters().FindChild("Uid", "ComboBox_07c1", 10)}

function Get_WinSwitchBlock_GrpParameters_LblMinimumAmountPerOrder(){return Get_WinSwitchBlock_GrpParameters().FindChild("Uid", "TextBlock_e99f", 10)}

function Get_WinSwitchBlock_GrpParameters_TxtMinimumAmountPerOrder(){return Get_WinSwitchBlock_GrpParameters().FindChild("Uid", "IntegerTextBox_e2f9", 10)}

function Get_WinSwitchBlock_GrpParameters_LblExchangeRate(){return Get_WinSwitchBlock_GrpParameters().FindChild("Uid", "TextBlock_48d3", 10)}

function Get_WinSwitchBlock_GrpParameters_TxtExchangeRate(){return Get_WinSwitchBlock_GrpParameters().FindChild("Uid", "DoubleTextBox_66bb", 10)}

function Get_WinSwitchBlock_GrpParameters_LblCurrency(){return Get_WinSwitchBlock_GrpParameters().FindChild("Uid", "TextBlock_5044", 10)}


function Get_WinSwitchBlock_GrpRoundingFactors(){return Get_WinSwitchBlock().FindChild("Uid", "GroupBox_b935", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_LblStocks(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "TextBlock_3923", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_TxtStocks(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "IntegerTextBox_a186", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_LblBonds(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "TextBlock_7d1e", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_TxtBonds(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "IntegerTextBox_9df1", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_LblOptions(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "TextBlock_40a2", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_TxtOptions(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "IntegerTextBox_f9b3", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_LblCoupons(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "TextBlock_b75d", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_TxtCoupons(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "IntegerTextBox_305f", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_LblMutualFunds(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "TextBlock_7c95", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_TxtMutualFunds(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "DoubleTextBox_8faf", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_LblDebentures(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "TextBlock_84b4", 10)}

function Get_WinSwitchBlock_GrpRoundingFactors_TxtDebentures(){return Get_WinSwitchBlock_GrpRoundingFactors().FindChild("Uid", "IntegerTextBox_2ee8", 10)}


function Get_WinSwitchBlock_GrpTransactions(){return Get_WinSwitchBlock().FindChild("Uid", "GroupBox_f255", 10)}

function Get_WinSwitchBlock_GrpTransactions_BtnAdd(){return Get_WinSwitchBlock_GrpTransactions().FindChild("Uid", "Button_9c7d", 10)}

function Get_WinSwitchBlock_GrpTransactions_BtnEdit(){return Get_WinSwitchBlock_GrpTransactions().FindChild("Uid", "Button_ba56", 10)}

function Get_WinSwitchBlock_GrpTransactions_BtnDelete(){return Get_WinSwitchBlock_GrpTransactions().FindChild("Uid", "Button_a113", 10)}

function Get_WinSwitchBlock_GrpTransactions_DgvTransactions(){return Get_WinSwitchBlock_GrpTransactions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}

function Get_WinSwitchBlock_GrpTransactions_ChQuantity()
{
  if (language == "french"){return Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity"], 10)}
}

function Get_WinSwitchBlock_GrpTransactions_ChDescription(){return Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_WinSwitchBlock_GrpTransactions_ChSymbol()
{
  if (language == "french"){return Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinSwitchBlock_GrpTransactions_ChPrice()
{
  if (language == "french"){return Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix"], 10)}
  else {return Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Price"], 10)}
}

function Get_WinSwitchBlock_GrpTransactions_ChCurrency()
{
  if (language == "french"){return Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_WinSwitchBlock_GrpTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}


function Get_WinSwitchBlock_GrpEquivalentTransactions(){return Get_WinSwitchBlock().FindChild("Uid", "GroupBox_889d", 10)}

function Get_WinSwitchBlock_GrpEquivalentTransactions_BtnAdd(){return Get_WinSwitchBlock_GrpEquivalentTransactions().FindChild("Uid", "Button_8ca7", 10)}

function Get_WinSwitchBlock_GrpEquivalentTransactions_BtnEdit(){return Get_WinSwitchBlock_GrpEquivalentTransactions().FindChild("Uid", "Button_f348", 10)}

function Get_WinSwitchBlock_GrpEquivalentTransactions_BtnDelete(){return Get_WinSwitchBlock_GrpEquivalentTransactions().FindChild("Uid", "Button_85de", 10)}

function Get_WinSwitchBlock_GrpEquivalentTransactions_DgvTransactions(){return Get_WinSwitchBlock_GrpEquivalentTransactions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}

function Get_WinSwitchBlock_GrpEquivalentTransactions_ChAllocationPercent()
{
  if (language == "french"){return Get_WinSwitchBlock_GrpEquivalentTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Répartition (%)"], 10)}
  else {return Get_WinSwitchBlock_GrpEquivalentTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Allocation (%)"], 10)}
}

function Get_WinSwitchBlock_GrpEquivalentTransactions_ChDescription(){return Get_WinSwitchBlock_GrpEquivalentTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_WinSwitchBlock_GrpEquivalentTransactions_ChSymbol()
{
  if (language == "french"){return Get_WinSwitchBlock_GrpEquivalentTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinSwitchBlock_GrpEquivalentTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinSwitchBlock_GrpEquivalentTransactions_ChPrice()
{
  if (language == "french"){return Get_WinSwitchBlock_GrpEquivalentTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix"], 10)}
  else {return Get_WinSwitchBlock_GrpEquivalentTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Price"], 10)}
}

function Get_WinSwitchBlock_GrpEquivalentTransactions_ChCurrency()
{
  if (language == "french"){return Get_WinSwitchBlock_GrpEquivalentTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_WinSwitchBlock_GrpEquivalentTransactions_DgvTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}


function Get_WinSwitchBlock_LblOrders(){return Get_WinSwitchBlock().FindChild("Uid", "TextBlock_6900", 10)}

function Get_WinSwitchBlock_DgvOrders(){return Get_WinSwitchBlock().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}

//À compléter avec les entêtes de colonne du tableau des ordres 
function Get_WinSwitchBlock_DgvOrders_ChInclude()
{
  if (language=="french"){return Get_WinSwitchBlock_DgvOrders().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Inclure"], 10)}
  else {return Get_WinSwitchBlock_DgvOrders().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Include"], 10)}
}

function Get_WinSwitchBlock_DgvOrders_ChPro(){return Get_WinSwitchBlock_DgvOrders().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Pro"], 10)}

function Get_WinSwitchBlock_DgvOrders_ChMessage(){return Get_WinSwitchBlock_DgvOrders().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Message"], 10) }

function Get_WinSwitchBlock_DgvOrders_ChErrorIcone(){return Get_WinSwitchBlock_DgvOrders().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}


function Get_WinSwitchBlock_BtnPreview(){return Get_WinSwitchBlock().FindChild("Uid", "Button_91b0", 10)}

function Get_WinSwitchBlock_BtnGenerate(){return Get_WinSwitchBlock().FindChild("Uid", "Button_6582", 10)}

function Get_WinSwitchBlock_BtnCancel(){return Get_WinSwitchBlock().FindChild("Uid", "Button_4f95", 10)}

//----> fin MenuEdit_Get_functions  ????


//---->  MenuEdit_Get_functions 

//****************************** FENÊTRE TRANSACTION SOURCE  -Source Transaction **********************************
// Win Multiple, block and swich orders --> btn Add (Sell)
function Get_WinSwitchSource(){return Aliases.CroesusApp.WinSwitchSource}

function Get_WinSwitchSource_btnOK(){return Get_WinSwitchSource().FindChild("Uid", "Button_9c25", 10)}

function Get_WinSwitchSource_btnCancel(){return Get_WinSwitchSource().FindChild("Uid", "Button_3dd8", 10)}

function Get_WinSwitchSource_TxtQuantity(){return Get_WinSwitchSource().FindChild("Uid", "DoubleTextBox_2f10", 10)}

function Get_WinSwitchSource_CmbQuantity(){return Get_WinSwitchSource().FindChild("Uid", "ComboBox_0a0e", 10)}

function Get_WinSwitchSource_GrpPosition(){return Get_WinSwitchSource().FindChild("Uid", "ListPickerCombo_ae94", 10)} //SA:J'ai changé UID pour la version ref90-07-Co-6--V9-Be_1-co6x UID d'avant était : GroupBox_fa45

function Get_WinSwitchSource_GrpPosition_TxtSecurity(){return Get_WinSwitchSource().FindChild("Uid", "TextBox_f1d5", 10)} 

function Get_WinSwitchSource_GrpPosition_TxtPrice(){return Get_WinSwitchSource().FindChild("Uid", "DoubleTextBox_453d", 10)} 

function Get_WinSwitchSource_CmbSecurity(){return Get_WinSwitchSource().FindChild("Uid", "ListPickerCombo_ae94", 10)}

//----> fin MenuEdit_Get_functions 



//---->  MenuEdit_Get_functions 
/************************************FENÊTRE TRANSACTION ÉQUIVALENTE  -Equivalent Transaction ***********************************/
// Win Multiple, block and swich orders --> btn Add (Buy)
function Get_WinSwitchEquivalent(){return Aliases.CroesusApp.winSwitchEquivalent}

function Get_WinSwitchEquivalent_btnOK(){return Get_WinSwitchEquivalent().FindChild("Uid", "Button_b7e6", 10)}

function Get_WinSwitchEquivalent_TxtAllocationPercent(){return Get_WinSwitchEquivalent().FindChild("Uid", "DoubleTextBox_199a", 10)}

function Get_WinSwitchEquivalent_CmbSecurity(){return Get_WinSwitchEquivalent().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinSwitchEquivalent_CmbSecurity_TxtSecurity(){return Get_WinSwitchEquivalent().FindChild("Uid", "TextBox_f1d5", 10)} 

function Get_WinSwitchEquivalent_TxtPrice(){return Get_WinSwitchEquivalent().FindChild("Uid", "DoubleTextBox_49e0", 10)}

function Get_WinSwitchEquivalent_BtnQuickSearchListPicker(){return Get_WinSwitchEquivalent().FindChild("Uid", "ListPickerExec_9344", 10)}

//----> fin  MenuEdit_Get_functions 


//----?? 
//****************************** FENÊTRE INFORMATION SUR LA POSITION - SOLDE (POSITION INFO WINDOW - BALANCE) **********************************
//Edit --> Functions --> Info 
function Get_WinPositionInfoBalance(){return Aliases.CroesusApp.winPositionInfo}

function Get_WinPositionInfoBalance_BtnOK(){return Get_WinPositionInfoBalance().FindChild("Uid", "Button_11da", 10)} //ok

function Get_WinPositionInfoBalance_BtnCancel(){return Get_WinPositionInfoBalance().FindChild("Uid", "Button_dee6", 10)} //ok


function Get_WinPositionInfoBalance_GrpSecurityInformation(){return Get_WinPositionInfoBalance().FindChild("Uid", "GroupBox_a19c", 10)} //ok

function Get_WinPositionInfoBalance_GrpSecurityInformation_LblSubcategory(){return Get_WinPositionInfoBalance_GrpSecurityInformation().FindChild("Uid", "TextBlock_33fb", 10)} //ok

function Get_WinPositionInfoBalance_GrpSecurityInformation_TxtSubcategory(){return Get_WinPositionInfoBalance_GrpSecurityInformation().FindChild("Uid", "ContentControl_2de4", 10)} //ok


function Get_WinPositionInfoBalance_GrpPositionInformation(){return Get_WinPositionInfoBalance().FindChild("Uid", "GroupBox_5fd3", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_LblQuantity(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "TextBlock_26d2", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtQuantity(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_8b5e", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_LblHeldIn(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "TextBlock_a3ac", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_LblInvestedCapital(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "TextBlock_6e6d", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_LblBookValue(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "TextBlock_2207", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_LblMarketValue(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "TextBlock_58f3", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_LblCost(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "TextBlock_692a", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_LblValue(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "TextBlock_47c9", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_LblTotalValuePercent(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "TextBlock_7ced", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtInvestedCapitalCost(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_34ef", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtBookValueCost(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_be57", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtMarketValueCost(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_02cf", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtInvestedCapitalValue(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_679e", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtBookValueValue(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_06e5", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtMarketValueValue(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_2a42", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtInvestedCapitalTotalValuePercent(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "CustomTextBox_16a1", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtBookValueTotalValuePercent(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "CustomTextBox_4622", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtMarketValueTotalValuePercent(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_dc13", 10)} //ok
// ajout de fonction get qui est spécifique pour la US 90-04-49 pour Cost Basis
function Get_WinPositionInfoBalance_GrpPositionInformation_TxtCostBasisCost(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_be57", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtCostBasisValue(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_06e5", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_TxtCostBasisTotalValuePercent(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "CustomTextBox_4622", 10)} //ok

function Get_WinPositionInfoBalance_GrpPositionInformation_LblCostBasis(){return Get_WinPositionInfoBalance_GrpPositionInformation().FindChild("Uid", "TextBlock_2207", 10)} //ok


function Get_WinPositionInfoBalance_GrpGainsLosses(){return Get_WinPositionInfoBalance().FindChild("Uid", "GroupBox_c6cf", 10)} //ok

function Get_WinPositionInfoBalance_GrpGainsLosses_LblInvestedCapital(){return Get_WinPositionInfoBalance_GrpGainsLosses().FindChild("Uid", "Label_e8d3", 10)} //ok

function Get_WinPositionInfoBalance_GrpGainsLosses_LblBookValue(){return Get_WinPositionInfoBalance_GrpGainsLosses().FindChild("Uid", "Label_e5fe", 10)} //ok

function Get_WinPositionInfoBalance_GrpGainsLosses_LblUnrealized(){return Get_WinPositionInfoBalance_GrpGainsLosses().FindChild("Uid", "Label_5e86", 10)} //ok

function Get_WinPositionInfoBalance_GrpGainsLosses_LblUnrealizedPercent(){return Get_WinPositionInfoBalance_GrpGainsLosses().FindChild("Uid", "Label_53b2", 10)} //ok

function Get_WinPositionInfoBalance_GrpGainsLosses_TxtInvestedCapitalUnrealized(){return Get_WinPositionInfoBalance_GrpGainsLosses().FindChild("Uid", "CustomTextBox_d050", 10)} //ok

function Get_WinPositionInfoBalance_GrpGainsLosses_TxtBookValueUnrealized(){return Get_WinPositionInfoBalance_GrpGainsLosses().FindChild("Uid", "CustomTextBox_037b", 10)} //ok

function Get_WinPositionInfoBalance_GrpGainsLosses_TxtInvestedCapitalUnrealizedPercent(){return Get_WinPositionInfoBalance_GrpGainsLosses().FindChild("Uid", "CustomTextBox_d762", 10)} //ok

function Get_WinPositionInfoBalance_GrpGainsLosses_TxtBookValueUnrealizedPercent(){return Get_WinPositionInfoBalance_GrpGainsLosses().FindChild("Uid", "CustomTextBox_55a8", 10)} //ok


function Get_WinPositionInfoBalance_GrpIncome(){return Get_WinPositionInfoBalance().FindChild("Uid", "GroupBox_9720", 10)} //ok

function Get_WinPositionInfoBalance_GrpIncome_LblAnnual(){return Get_WinPositionInfoBalance_GrpIncome().FindChild("Uid", "Label_05e8", 10)} //ok

function Get_WinPositionInfoBalance_GrpIncome_LblAccruedIntDiv(){return Get_WinPositionInfoBalance_GrpIncome().FindChild("Uid", "Label_97ab", 10)} //ok

function Get_WinPositionInfoBalance_GrpIncome_LblAccumIntDiv(){return Get_WinPositionInfoBalance_GrpIncome().FindChild("Uid", "Label_809a", 10)} //ok

function Get_WinPositionInfoBalance_GrpIncome_TxtAnnual(){return Get_WinPositionInfoBalance_GrpIncome().FindChild("Uid", "CustomTextBox_3ae9", 10)} //ok

function Get_WinPositionInfoBalance_GrpIncome_TxtAccruedIntDiv(){return Get_WinPositionInfoBalance_GrpIncome().FindChild("Uid", "CustomTextBox_12c8", 10)} //ok

function Get_WinPositionInfoBalance_GrpIncome_TxtAccumIntDiv(){return Get_WinPositionInfoBalance_GrpIncome().FindChild("Uid", "CustomTextBox_572b", 10)} //ok


function Get_WinPositionInfoBalance_GrpMiscellaneous(){return Get_WinPositionInfoBalance().FindChild("Uid", "GroupBox_97f8", 10)} //ok

function Get_WinPositionInfoBalance_GrpMiscellaneous_LblCommission(){return Get_WinPositionInfoBalance_GrpMiscellaneous().FindChild("Uid", "TextBlock_8d40", 10)} //ok

function Get_WinPositionInfoBalance_GrpMiscellaneous_LblLastBuy(){return Get_WinPositionInfoBalance_GrpMiscellaneous().FindChild("Uid", "TextBlock_ba66", 10)} //ok

function Get_WinPositionInfoBalance_GrpMiscellaneous_TxtCommission(){return Get_WinPositionInfoBalance_GrpMiscellaneous().FindChild("Uid", "CustomTextBox_ca23", 10)} //ok

function Get_WinPositionInfoBalance_GrpMiscellaneous_TxtLastBuy(){return Get_WinPositionInfoBalance_GrpMiscellaneous().FindChild("Uid", "DateField_12b2", 10)} //ok




//****************************** FENÊTRE INFORMATION SUR LA POSITION (POSITION INFO WINDOW) **********************************

function Get_WinPositionInfo(){return Aliases.CroesusApp.winPositionInfo}

function Get_WinPositionInfo_BtnOK(){return Get_WinPositionInfo().FindChild("Uid", "Button_11da", 10)} //ok

function Get_WinPositionInfo_BtnCancel(){return Get_WinPositionInfo().FindChild("Uid", "Button_dee6", 10)} //ok

function Get_WinPositionInfo_BtnEdit(){return Get_WinPositionInfo().FindChild("Uid", "Button_9141", 10)} //ok
//*****Les fonctions suivantes sont pour les positions, après avoir maillé le model vers le module Portefeuille*****

function Get_WinPositionInfo_GrpPositionInformationForModel(){return Get_WinPositionInfo().FindChild("Uid","GroupBox_87f3", 10)} 

function Get_WinPositionInfo_GrpPositionInformation_TxtTargetValue(){return Get_WinPositionInfo_GrpPositionInformationForModel().FindChild("Uid","DoubleTextBox_b119", 10)} 

function Get_WinPositionInfo_GrpPositionInformation_TxtMarketValue(){return Get_WinPositionInfo_GrpPositionInformationForModel().FindChild("Uid","DoubleTextBox_6ebb", 10)}

function Get_WinPositionInfo_GrpPositionInformation_TxtToleranceMin(){return Get_WinPositionInfo_GrpPositionInformationForModel().FindChild("Uid","DoubleTextBox_6ba1", 10)}

function Get_WinPositionInfo_GrpPositionInformation_TxtToleranceMax(){return Get_WinPositionInfo_GrpPositionInformationForModel().FindChild("Uid","DoubleTextBox_9d62", 10)}

function Get_WinPositionInfo_GrpSubstitutionSecurities(){return Get_WinPositionInfo().FindChild("Uid","GroupBox_5023", 10)}

function Get_WinPositionInfo_GrpSubstitutionSecurities_BtnEdit(){return Get_WinPositionInfo_GrpSubstitutionSecurities().FindChild("Uid","Button_9141", 10)}


function Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities(){return Get_WinPositionInfo().FindChild("Uid","SubstitutionDataGrid_087c", 10)}

function Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChRank()
{
  if (language=="french"){return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rang"], 10)}
  else {return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Rank"], 10)}
}

function Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChSubstitutionType()
{
  if (language=="french"){return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type de substitution"], 10)}
  else {return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Substitution type"], 10)}
}

function Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChSymbol()
{
  if (language=="french"){return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChDescription()
{
  if (language=="french"){return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}
  else {return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}
}

function Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities_ChFallbackSecurityReplacement()
{
  if (language=="french"){return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre de rechange d'un remplacement"], 10)}
  else {return Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fallback security of a replacement"], 10)}
}

//*********************************************************************************************************
function Get_WinPositionInfo_ExcessCash(){return Get_WinPositionInfo().Find("Uid", "GroupBox_081a", 10)} //

function Get_WinPositionInfo_ExcessCash_DlListPicker(){return Get_WinPositionInfo_ExcessCash().Find("Uid", "ListPickerExec_9344", 10)} //ok

function Get_WinPositionInfo_ExcessCash_CmbTypePicker(){return Get_WinPositionInfo_ExcessCash().Find("Uid", "ListPickerCombo_ae94", 10)} //ok

function Get_WinPositionInfo_ExcessCash_TxtQuickSearchKey(){return Get_WinPositionInfo_ExcessCash().Find("Uid", "TextBox_f1d5", 10)} //ok


//***********************************************************************************************************************

function Get_WinPositionInfo_TabInfo(){return Get_WinPositionInfo().FindChild("Uid", "TabItem_31b5", 10)} //ok

function Get_WinPositionInfo_TabNotes(){return Get_WinPositionInfo().FindChild("Uid", "TabItem_dca0", 10)} //ok

function Get_Toolbar_BtnQuickFilters_ContextMenu(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"] , 100, true, 15000)}

function Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_Note()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Note", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Note", 10)}
}


function Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_CreationDate()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Date de création", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText","Creation Date", 10)}
}
function Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_ModificationDate()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Date de modification", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText","Modification Date", 10)}
}

function Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_CreatedBy()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Créée par", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Created by", 10)}
}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation(){return Get_WinPositionInfo().FindChild(["Uid","IsVisible"], ["TabControl_9519",true], 10).FindChild(["Uid","IsVisible"], ["GroupBox_7f7d",true], 10)} //ok

// Les fonctions suivantes sont pour le type d'instrument financier Obligation (the following functions are related to Bond)

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSubcategoryForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d584", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSubcategoryForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_ae8a", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSecurityForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d1f1", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSecurityForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_4ec9", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblFrequencyForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_7c86", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtFrequencyForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_93fb", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblMaturityForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d9eb", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtMaturityForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_0caf", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCalculationFactorForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_7aed", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCalculationFactorForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_e22f", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblModifiedDurationForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_10a8", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtModifiedDurationForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_0ac9", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblPrincipalFactorForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_974c", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtPrincipalFactorForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_c5d1", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblUnderlyingSecurityForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_0948", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtUnderlyingSecurityForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_2f07", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCUSIPForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_412b", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCUSIPForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_2f8a", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblISINForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d7b8", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtISINForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_761a", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCallPriceForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_076c", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCallPriceForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_3e23", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_Lbl1stCouponForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_1a2b", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_Txt1stCouponForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_a01f", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCompoundInterestMethodForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_f9c9", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCompoundInterestMethodForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_8a68", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCallDateForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_4b3e", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCallDateForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_ccfa", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblIssueDateForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_3361", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtIssueDateForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_4867", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblInterestForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_ba53", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtInterestForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_bb40", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblInterestCurrencyForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_6dc5", 10)} //ok

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtInterestCurrencyForBond(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_5a95", 10)} //ok
//End Bond (Fin Obligation)

// Les fonctions suivantes sont pour le type d'instrument financier Action (the following functions are related to Equity)

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSubcategoryForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_6d2a", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSubcategoryForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_13f3", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSectorForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_bb14", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSectorForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_0987", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSymbolForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_4644", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSymbolForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_9094", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSecurityForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_f5f4", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSecurityForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_13bc", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblMarketForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_97dd", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtMarketForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_9be4", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCalculationFactorForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_6fa1", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCalculationFactorForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_b24a", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCUSIPForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_897a", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCUSIPForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_fe9f", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblISINForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_4a86", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtISINForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_5f5c", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblFrequencyForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_07ef", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtFrequencyForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_6dfd", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d418", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtDividendForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_c586", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_e3ef", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtDividendForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_9b36", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendCurrencyForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_6d6b", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtDividendCurrencyForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_b5e0", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_9d58", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtDividendDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_0757", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblRecordDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_5da3", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtRecordDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_5c2d", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblExDividendDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_302f", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtExDividendDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_24d1", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblIssueDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_23de", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtIssueDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_a2cc", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCallDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_f5a3", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCallDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_d92f", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblConversionDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_0ae4", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtConversionDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_6e2c", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblBetaForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_4b3b", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtBetaForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_35eb", 10)}
//End Equity (Fin Action)


// Les fonctions suivantes sont pour le type d'instrument financier Autre (the following functions are related to Other financial instrument)

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSubcategoryForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_5bf3", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSubcategoryForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_9dc1", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSymbolForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_ae23", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSymbolForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_a97a", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSecurityForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_bb47", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSecurityForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_4482", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCalculationFactorForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_4b23", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCalculationFactorForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_531b", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCUSIPForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_7926", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCUSIPForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_fbee", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblISINForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d2e2", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtISINForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_7f88", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_a274", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtDividendDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_495a", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblFrequencyForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_f1dc", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtFrequencyForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_a70e", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendCurrencyForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_1585", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtDividendCurrencyForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_c9e4", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblExDividendDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_5b18", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtExDividendDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_1f78", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblRecordDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_c404", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtRecordDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_7690", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblBetaForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d372", 10)}

function Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtBetaForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_a6f2", 10)}
//End Other (Fin Autre)


function Get_WinPositionInfo_TabDetails(){return Get_WinPositionInfo().FindChild("Uid", "TabItem_2011", 10)} //ok

function Get_WinPositionInfo_TabDetails_GrpTransactions(){return Get_WinPositionInfo().FindChild(["Uid","IsVisible"], ["TabControl_9519",true], 10).FindChild(["Uid","IsVisible"], ["GroupBox_fe09",true], 10)} //ok

function Get_WinPositionInfo_TabDetails_GrpTransactions_BtnSeparate(){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild("Uid", "Button_fce7", 10)} //ok

function Get_WinPositionInfo_TabDetails_GrpTransactions_BtnReassign(){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild("Uid", "Button_9df3", 10)} //ok

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChAsterisk(){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "*"], 10)} //no uid, missing in Automation 8

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChDate(){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date"], 10)} //no uid

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChSettlementDate() //no uid
{
  if (language == "french"){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de règlement"], 10)}
  else {return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Settlement Date"], 10)}
}

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChType(){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)} //no uid

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChQty() //no uid
{
  if (language == "french"){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qty"], 10)}
}

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChTotal(){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total"], 10)} //no uid

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChExchangeRate() //no uid
{
  if (language == "french"){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Taux de change"], 10)}
  else {return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Exchange Rate"], 10)}
}

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChPositionIC() //no uid
{
  if (language == "french"){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IU de position"], 10)}
  else {return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Position IC"], 10)}
}

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChPositionACB() //no uid
{
  if (language == "french"){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "PBR de position"], 10)}
  else {return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Position ACB"], 10)}
}

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChPosCYPercent() //no uid, (in Automation 4, it is "Pos. YTM-Cost (%)")
{
  if (language == "french"){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Pos. RE-Coût (%)"], 10)}
  else {return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Pos. YTM–Cost (%)"], 10)}
}

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChPosCYPercentForEquity() //no uid, (in Automation 4, it is "Pos. YTM-Cost (%)")
{
  if (language == "french"){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Pos. RA (%)"], 10)}
  else {return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Pos. CY (%)"], 10)}
}

function Get_WinPositionInfo_TabDetails_GrpTransactions_ChTransCYPercent() //no uid
{
  if (language == "french"){return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Trans.-RA (%)"], 10)}
  else {return Get_WinPositionInfo_TabDetails_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Trans.-CY (%)"], 10)}
}

function Get_WinPositionInfo_GrpPositionInformation(){return Get_WinPositionInfo().FindChild("Uid", "GroupBox_5fd3", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblQuantity(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_26d2", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_8b5e", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblHeldIn(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_a3ac", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblInvestedCapital(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_6e6d", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblBookValue(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_2207", 10)} //ok
//Ajout de la fonction get pour label de Cost Basis spécifique pour la US 90-04-49
function Get_WinPositionInfo_GrpPositionInformation_LblCostBasis(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_2207", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblMarketValue(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_58f3", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblCost(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_692a", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblValue(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_47c9", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblValuePercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_7ced", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblCurrentYieldPercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_fa3b", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblYieldPercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_0081", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblYTMNominalPercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_9e56", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_LblYTMEffectivePercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_a106", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalCost(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_34ef", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCost(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_be57", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCost(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_02cf", 10)} //ok


// ajout de Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisCost spécifique a la US
function Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisCost(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_be57", 10)} //

function Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValue(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_679e", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValue(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_06e5", 10)} //ok

// ajout de la fonction get Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisValue spécifique pour la US
function Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisValue(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_06e5", 10)}

function Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValue(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_2a42", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValuePercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_16a1", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValuePercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_4622", 10)} //ok

// ajout de la fonction get Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisValuePercent pour la US

function Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisValuePercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_4622", 10)} //ok


function Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValuePercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "DoubleTextBox_dc13", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCurrentYieldPercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_379f", 10)} //ok

// ajout de la fonction get Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisCurrentYieldPercent spécifique pour la US
function Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisCurrentYieldPercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_379f", 10)} //ok



function Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCurrentYieldPercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_b575", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtBookValueYieldPercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_f757", 10)} //ok

// ajout de la fonction get Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisYieldPercent spécifique pour la US 
function Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisYieldPercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_f757", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtBookValueYTMNominalPercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_5fa3", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueYTMNominalPercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_7aa8", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtBookValueYTMEffectivePercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_d512", 10)} //ok

function Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueYTMEffectivePercent(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_41d2", 10)} //ok

//Ajouté ce 22/06/2016
function Get_WinPositionInfo_GrpPositionInformation_LblExchangeRateToCAD(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "TextBlock_5cbb", 10)}

//Ajouté ce 22/06/2016
function Get_WinPositionInfo_GrpPositionInformation_TxtBookValueExchangeRateToCAD(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_7718", 10)}

//Ajouté ce 22/06/2016
function Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueExchangeRateToCAD(){return Get_WinPositionInfo_GrpPositionInformation().FindChild("Uid", "CustomTextBox_132e", 10)}


function Get_WinPositionInfo_GrpGainsLosses(){return Get_WinPositionInfo().FindChild("Uid", "GroupBox_c6cf", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_LblInvestedCapital(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "Label_e8d3", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_LblBookValue(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "Label_e5fe", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_LblUnrealized(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "Label_5e86", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_LblUnrealizedPercent(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "Label_53b2", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_LblYTDNominalPercent(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "Label_4a09", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_LblYTDEffectivePercent(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "Label_7f0f", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealized(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "CustomTextBox_d050", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealized(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "CustomTextBox_037b", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealizedPercent(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "CustomTextBox_d762", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealizedPercent(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "CustomTextBox_55a8", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalYTDNominalPercent(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "CustomTextBox_a7a5", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_TxtBookValueYTDNominalPercent(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "CustomTextBox_6205", 10)} //ok

// ajout de la fonction get Get_WinPositionInfo_GrpGainsLosses_TxtCostBasisYTDNominalPercent spécifique pour la US
function Get_WinPositionInfo_GrpGainsLosses_TxtCostBasisYTDNominalPercent(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "CustomTextBox_5fa3", 10)} //o

function Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalYTDEffectivePercent(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "CustomTextBox_d592", 10)} //ok

function Get_WinPositionInfo_GrpGainsLosses_TxtBookValueYTDEffectivePercent(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "CustomTextBox_0228", 10)} //ok

// ajout de la fonction get Get_WinPositionInfo_GrpGainsLosses_TxtCostBasisYTDEffectivePercent spécifique pour la US
function Get_WinPositionInfo_GrpGainsLosses_TxtCostBasisYTDEffectivePercent(){return Get_WinPositionInfo_GrpGainsLosses().FindChild("Uid", "CustomTextBox_d512", 10)}

function Get_WinPositionInfo_GrpIncome(){return Get_WinPositionInfo().FindChild("Uid", "GroupBox_9720", 10)} //ok

function Get_WinPositionInfo_GrpIncome_LblAnnual(){return Get_WinPositionInfo_GrpIncome().FindChild("Uid", "Label_05e8", 10)} //ok

function Get_WinPositionInfo_GrpIncome_LblAccruedIntDiv(){return Get_WinPositionInfo_GrpIncome().FindChild("Uid", "Label_97ab", 10)} //ok

function Get_WinPositionInfo_GrpIncome_LblAccumIntDiv(){return Get_WinPositionInfo_GrpIncome().FindChild("Uid", "Label_809a", 10)} //ok

function Get_WinPositionInfo_GrpIncome_TxtAnnual(){return Get_WinPositionInfo_GrpIncome().FindChild("Uid", "CustomTextBox_3ae9", 10)} //ok

function Get_WinPositionInfo_GrpIncome_TxtAccruedIntDiv(){return Get_WinPositionInfo_GrpIncome().FindChild("Uid", "CustomTextBox_12c8", 10)} //ok

function Get_WinPositionInfo_GrpIncome_TxtAccumIntDiv(){return Get_WinPositionInfo_GrpIncome().FindChild("Uid", "CustomTextBox_572b", 10)} //ok

//Ajouté ce 22/06/2016 (présent pour certains Achats du module Transaction - fenêtre Position)
function Get_WinPositionInfo_GrpIncome_LblInterestPortion(){return Get_WinPositionInfo_GrpIncome().FindChild("Uid", "Label_a333", 10)}

//Ajouté ce 22/06/2016 (présent pour certains Achats du module Transaction - fenêtre Position)
function Get_WinPositionInfo_GrpIncome_TxtInterestPortion(){return Get_WinPositionInfo_GrpIncome().FindChild("Uid", "CustomTextBox_24ff", 10)}


function Get_WinPositionInfo_GrpMiscellaneous(){return Get_WinPositionInfo().FindChild("Uid", "GroupBox_97f8", 10)} //ok

function Get_WinPositionInfo_GrpMiscellaneous_LblCommission(){return Get_WinPositionInfo_GrpMiscellaneous().FindChild("Uid", "TextBlock_8d40", 10)} //ok

function Get_WinPositionInfo_GrpMiscellaneous_LblLastBuy(){return Get_WinPositionInfo_GrpMiscellaneous().FindChild("Uid", "TextBlock_ba66", 10)} //ok

function Get_WinPositionInfo_GrpMiscellaneous_TxtCommission(){return Get_WinPositionInfo_GrpMiscellaneous().FindChild("Uid", "CustomTextBox_ca23", 10)} //ok

function Get_WinPositionInfo_GrpMiscellaneous_TxtLastBuy(){return Get_WinPositionInfo_GrpMiscellaneous().FindChild("Uid", "DateField_12b2", 10)} //ok


function Get_WinPositionInfo_GrpExclusion(){return Get_WinPositionInfo().FindChild("Uid", "GroupBox_add1", 10)} //ok

function Get_WinPositionInfo_GrpExclusion_ChkExcludeFromProjectedIncome(){return Get_WinPositionInfo_GrpExclusion().FindChild("Uid", "CheckBox_b499", 10)} //ok

function Get_WinPositionInfo_GrpExclusion_ChkLockedPosition(){return Get_WinPositionInfo_GrpExclusion().FindChild("Uid", "CheckBox_cad5", 10)} //ok

function Get_WinPositionInfo_GrpExclusion_ChkExcludeFromBilling(){return Get_WinPositionInfo_GrpExclusion().FindChild("Uid", "CheckBox_a0c3", 10)} 


//Ajouté ce 22/06/2016
function Get_WinPositionInfo_GrpOptionCost(){return Get_WinPositionInfo().FindChild("Uid", "GroupBox_d0c1", 10)}

//Ajouté ce 22/06/2016
function Get_WinPositionInfo_GrpOptionCost_LblPendingOptionValue(){return Get_WinPositionInfo_GrpOptionCost().FindChild("Uid", "TextBlock_7df1", 10)}

//Ajouté ce 22/06/2016
function Get_WinPositionInfo_GrpOptionCost_TxtPendingOptionValue(){return Get_WinPositionInfo_GrpOptionCost().FindChild("Uid", "CustomTextBox_e9e6", 10)}



//Pour le groupbox "Information sur le titre" de la fenêtre de la simulation

function Get_WinPositionInfo_GrpSecurityInformation(){return Get_WinPositionInfo().FindChild("Uid", "GroupBox_a19c", 10)} //ok

//Les fonctions suivantes sont pour le type d'instrument financier Obligation (the following functions are related to Bond)

function Get_WinPositionInfo_GrpSecurityInformation_LblSubcategory(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d584", 10)} //YR 90-04-44 CR1664

function Get_WinPositionInfo_GrpSecurityInformation_TxtSubcategory(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_ae8a", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblSecurity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d1f1", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtSecurity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_4ec9", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblFrequency(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_7c86", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtFrequency(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_93fb", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblMaturity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d9eb", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtMaturity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_0caf", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblCalculationFactor(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_7aed", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtCalculationFactor(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_e22f", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblModifiedDuration(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_10a8", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtModifiedDuration(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_0ac9", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblPrincipalFactor(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_974c", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtPrincipalFactor(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_c5d1", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblUnderlyingSecurity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_0948", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtUnderlyingSecurity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_2f07", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblCUSIP(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_412b", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtCUSIP(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_2f8a", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblISIN(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d7b8", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtISIN(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_761a", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblCallPrice(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_076c", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtCallPrice(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_3e23", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_Lbl1stCoupon(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_1a2b", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_Txt1stCoupon(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_a01f", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblCompoundInterestMethod(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_f9c9", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtCompoundInterestMethod(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_8a68", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblCallDate(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_4b3e", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtCallDate(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_ccfa", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblIssueDate(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_3361", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtIssueDate(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_4867", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblInterest(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_ba53", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtInterest(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_bb40", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_LblInterestCurrency(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_6dc5", 10)} //ok

function Get_WinPositionInfo_GrpSecurityInformation_TxtInterestCurrency(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_5a95", 10)} //ok
//Fin Obligation (End Bond)


//Les fonctions suivantes sont pour le type d'instrument financier Action (the following functions are related to Equity)

function Get_WinPositionInfo_GrpSecurityInformation_LblSubcategoryForEquity(){return  Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_6d2a", 10)} //YR 90-04-44 CR1664

function Get_WinPositionInfo_GrpSecurityInformation_TxtSubcategoryForEquity(){return  Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_13f3", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblSectorForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_bb14", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtSectorForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_0987", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblSymbolForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_4644", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtSymbolForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_9094", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblSecurityForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_f5f4", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtSecurityForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_13bc", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblMarketForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_97dd", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtMarketForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_9be4", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblCalculationFactorForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_6fa1", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtCalculationFactorForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_b24a", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblCUSIPForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_897a", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtCUSIPForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_fe9f", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblISINForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_4a86", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtISINForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_5f5c", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblFrequencyForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_07ef", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtFrequencyForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_6dfd", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblDividendForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d418", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtDividendForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_c586", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblDividendCurrencyForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_6d6b", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtDividendCurrencyForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_b5e0", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblDividendDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_9d58", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtDividendDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_0757", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblRecordDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_5da3", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtRecordDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_5c2d", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblExDividendDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_302f", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtExDividendDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_24d1", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblIssueDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_23de", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtIssueDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_a2cc", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblCallDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_f5a3", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtCallDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_d92f", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblConversionDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_0ae4", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtConversionDateForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_6e2c", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblBetaForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_4b3b", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtBetaForEquity(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_35eb", 10)}
//Fin Action (End Equity)


// Les fonctions suivantes sont pour le type d'instrument financier Autre (the following functions are related to Other financial instrument)

function Get_WinPositionInfo_GrpSecurityInformation_LblSubcategoryForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_5bf3", 10)} //YR 90-04-44 CR1664

function Get_WinPositionInfo_GrpSecurityInformation_TxtSubcategoryForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_9dc1", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblSymbolForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_ae23", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtSymbolForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_a97a", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblSecurityForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_bb47", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtSecurityForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_4482", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblCalculationFactorForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_4b23", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtCalculationFactorForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_531b", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblCUSIPForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_7926", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtCUSIPForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_fbee", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblISINForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d2e2", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtISINForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_7f88", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblDividendDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_a274", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtDividendDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_495a", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblFrequencyForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_f1dc", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtFrequencyForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_a70e", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblDividendForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_e3ef", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtDividendForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_9b36", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblDividendCurrencyForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_1585", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtDividendCurrencyForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_c9e4", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblExDividendDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_5b18", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtExDividendDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_1f78", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblRecordDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_c404", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtRecordDateForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_7690", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_LblBetaForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "TextBlock_d372", 10)}

function Get_WinPositionInfo_GrpSecurityInformation_TxtBetaForOther(){return Get_WinPositionInfo_TabInfo_GrpSecurityInformation().FindChild("Uid", "ContentControl_a6f2", 10)}

/******************************************** QUICK SEARCH WINDOW (FENÊTRE DE RECHERCHE RAPIDE) **************************************************/
//Ci-dessous les parties communes (même Uid) à tous les modules sauf Transactions (Modèles, Relations, Clients, Comptes, Portefeuille, Titres, Ordres) 
//Edit--> Search 
function Get_WinQuickSearch(){return Aliases.CroesusApp.winQuickSearch}

function Get_WinQuickSearch_BtnOK(){return Get_WinQuickSearch().FindChild("Uid", "Button_8b76", 10)}

function Get_WinQuickSearch_BtnCancel(){return Get_WinQuickSearch().FindChild("Uid", "Button_2b91", 10)}

function Get_WinQuickSearch_BtnFilter(){return Get_WinQuickSearch().FindChild("Uid", "Button_b2de", 10)}

function Get_WinQuickSearch_LblSearch(){return Get_WinQuickSearch().FindChild("Uid", "TextBlock_e02d", 10)}

function Get_WinQuickSearch_TxtSearch(){return Get_WinQuickSearch().FindChild("Uid", "TextBox_6a73", 10)}

function Get_WinQuickSearch_LblIn(){return Get_WinQuickSearch().FindChild("Uid", "TextBlock_9aa7", 10)}

function Get_WinFiltersAndSearchCriteriaQuickSearch_RdoName()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CRITERIADESCRIPTION - Nom"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CRITERIADESCRIPTION - Name"], 10)}
}

function Get_WinQuickSearch_RdoSymbol()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "SYMBOL - Symbole"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "SYMBOL - Symbol"], 10)}
}

function Get_WinQuickSearch_RdoSecuritySymbol()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "SECURITY_SYMBOL - Symbole"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "SECURITY_SYMBOL - Symbol"], 10)}
}

function Get_WinQuickSearch_RdoAccountNo()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "ACCOUNTNUMBER - No compte"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "ACCOUNTNUMBER - Account No."], 10)}
}

function Get_WinQuickSearch_RdoClientNo()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENTNUMBER - No client"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENTNUMBER - Client No."], 10)}
}

function Get_WinQuickSearch_RdoRelationshiptNo()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "LINKNUMBER - No relation"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "LINKNUMBER - Relationship No."], 10)}
}


function Get_WinQuickSearch_RdoIACode()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "RepresentativeNumber - Code de CP"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "RepresentativeNumber - IA Code"], 10)}
}

function Get_WinQuickSearch_RdoBranchName()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NOM - Nom de succursale"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NOM - Branch Name"], 10)}
}

function Get_WinQuickSearch_RdoBranchCode()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "BRANCHID - Code de succursale"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "BRANCHID - Branch Code"], 10)}
}

function Get_WinQuickSearch_RdoLastName()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "LASTNAME - Nom"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "LASTNAME - Last Name"], 10)}
}

function Get_WinQuickSearch_RdoFirstName()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "FIRSTNAME - Prénom"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "FIRSTNAME - First Name"], 10)}
}



//----->fin  MenuEdit_Get_functions


//----->  MenuEdit_Get_functions

//***************************************** FENÊTRE PERFORMANCE (PERFORMANCE WINDOW) ************************************************
//Fenêtre commune aux modules Modèles, Clients, Relations et Comptes
//Edit--> Functions -->Performqnce 
function Get_WinPerformance(){return Aliases.CroesusApp.winPerformance}

function Get_WinPerformance_BtnClose(){return Get_WinPerformance().FindChild("Uid", "Button_7f97", 10)} //ok

function Get_WinPerformance_ExcludeDataFromPrecedingManagementStartDate(){return Get_WinPerformance().FindChild("Uid", "CheckBox_aad3", 10)} //ok

function Get_WinPerformance_GrpPerformances(){return Get_WinPerformance().FindChild("Uid", "GroupBox_85f2", 10)} //ok

function Get_WinPerformance_GrpPerformances_GrpPeriod(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "GroupBox_0f6f", 10)} //ok

function Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(){return Get_WinPerformance_GrpPerformances_GrpPeriod().FindChild("Uid", "ComboBox_5a50", 10)} //ok

function Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "GroupBox_eee3", 10)} //ok

function Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(){return Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo().FindChild("Uid", "ComboBox_05a8", 10)} //ok

function Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_LblDefaultCurrency(){return Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo().FindChild("Uid", "Label_7d3e", 10)} //ok

function Get_WinPerformance_GrpPerformances_GrpPerformanceCalculations(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "GroupBox_dcce", 10)}

function Get_WinPerformance_GrpPerformances_GrpPerformanceCalculations_CmbPerformanceCalculations(){return Get_WinPerformance_GrpPerformances_GrpPerformanceCalculations().FindChild("Uid", "ComboBox_0b8d", 10)}

function Get_WinPerformance_GrpPerformances_GrpMethod(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "GroupBox_d2bf", 10)} //ok

function Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(){return Get_WinPerformance_GrpPerformances_GrpMethod().FindChild("Uid", "ComboBox_962e", 10)} //ok

function Get_WinPerformance_GrpPerformances_LblFrom(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "Label_c6ba", 10)} //ok

function Get_WinPerformance_GrpPerformances_LblTo(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "Label_a979", 10)} //ok  


function Get_WinPerformance_GrpPerformances_LblPeriod1(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod1From(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod1To(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //no uid for ListBoxItem and TextBlock


function Get_WinPerformance_GrpPerformances_LblPeriod2(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod2From(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod2To(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //no uid for ListBoxItem and TextBlock


function Get_WinPerformance_GrpPerformances_LblPeriod3(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod3From(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod3To(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //no uid for ListBoxItem and TextBlock


function Get_WinPerformance_GrpPerformances_LblPeriod4(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod4From(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod4To(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_da25", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //no uid for ListBoxItem and TextBlock


function Get_WinPerformance_GrpPerformances_LblPeriodOther(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "TextBlock_a269", 10)} //ok

function Get_WinPerformance_GrpPerformances_DtpPeriodOtherFrom(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "DateField_2693", 10)} //ok

function Get_WinPerformance_GrpPerformances_DtpPeriodOtherTo(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "DateField_cdd3", 10)} //ok


function Get_WinPerformance_GrpPerformances_LblNet(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "Label_fdab", 10)} //ok

function Get_WinPerformance_GrpPerformances_LblNetROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "Label_e884", 10)} //ok

function Get_WinPerformance_GrpPerformances_LblNetStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "Label_30cd", 10)} //ok

function Get_WinPerformance_GrpPerformances_LblNetSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "Label_28da", 10)} //ok


function Get_WinPerformance_GrpPerformances_TxtPeriod1NetROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod1NetStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod1NetSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //no uid for ListBoxItem and TextBlock


function Get_WinPerformance_GrpPerformances_TxtPeriod2NetROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod2NetStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod2NetSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //no uid for ListBoxItem and TextBlock


function Get_WinPerformance_GrpPerformances_TxtPeriod3NetROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod3NetStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod3NetSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //no uid for ListBoxItem and TextBlock


function Get_WinPerformance_GrpPerformances_TxtPeriod4NetROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod4NetStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriod4NetSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //no uid for ListBoxItem and TextBlock


function Get_WinPerformance_GrpPerformances_TxtPeriodOtherNetROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "5"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriodOtherNetStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "5"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //no uid for ListBoxItem and TextBlock

function Get_WinPerformance_GrpPerformances_TxtPeriodOtherNetSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_a95d", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "5"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //no uid for ListBoxItem and TextBlock


function Get_WinPerformance_GrpPerformances_LblGross(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "Label_8", 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_LblGrossROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "Label_9", 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_LblGrossStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "Label_10", 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_LblGrossSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "Label_11", 10)} //Missing in Automation 8 (pref??)


function Get_WinPerformance_GrpPerformances_TxtPeriod1GrossROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_TxtPeriod1GrossStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_TxtPeriod1GrossSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //Missing in Automation 8 (pref??)


function Get_WinPerformance_GrpPerformances_TxtPeriod2GrossROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_TxtPeriod2GrossStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_TxtPeriod2GrossSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //Missing in Automation 8 (pref??)


function Get_WinPerformance_GrpPerformances_TxtPeriod3GrossROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_TxtPeriod3GrossStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_TxtPeriod3GrossSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //Missing in Automation 8 (pref??)


function Get_WinPerformance_GrpPerformances_TxtPeriod4GrossROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_TxtPeriod4GrossStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_TxtPeriod4GrossSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "4"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //Missing in Automation 8 (pref??)


function Get_WinPerformance_GrpPerformances_TxtPeriodOtherGrossROIPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "5"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_TxtPeriodOtherGrossStandardDeviationPercent(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "5"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "2"], 10)} //Missing in Automation 8 (pref??)

function Get_WinPerformance_GrpPerformances_TxtPeriodOtherGrossSharpeIndex(){return Get_WinPerformance_GrpPerformances().FindChild("Uid", "ListBox_5", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "5"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "3"], 10)} //Missing in Automation 8 (pref??)


function Get_WinPerformance_TabPerformanceGraph(){return Get_WinPerformance().FindChild("Uid", "TabItem_3a40", 10)} //ok

function Get_WinPerformance_TabPerformanceGraph_LblGraphTitle(){return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild("Uid", "TextBlock_2f74", 10)} //ok


function Get_WinPerformance_TabPerformanceHistory(){return Get_WinPerformance().FindChild("Uid", "TabItem_8507", 10)} //ok

function Get_WinPerformance_TabPerformanceHistory_LblCurrencyMessage(){return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild("Uid", "Label_68bc", 10)} //ok

function Get_WinPerformance_TabPerformanceHistory_BtnCashFlow(){return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild("Uid", "Button_2b54", 10)} //ok

//Seulement pour le module Comptes
function Get_WinPerformance_TabPerformanceHistory_BtnDailyDataForAccount(){return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild("Uid", "Button_3b45", 10)} //Only for Accounts module

function Get_WinPerformance_TabPerformanceHistory_ChDate(){return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date"], 10)} //no uid

function Get_WinPerformance_TabPerformanceHistory_ChTotalValue() //no uid
{
  if (language == "french"){return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale"], 10)}
  else {return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value"], 10)}
}

function Get_WinPerformance_TabPerformanceHistory_ChCashFlow() //no uid
{
  if (language == "french"){return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mouv. encaisse"], 10)}
  else {return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cash Flow"], 10)}
}

function Get_WinPerformance_TabPerformanceHistory_ChNetROIPercent() //no uid
{
  if (language == "french"){return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "RCI net (%)"], 10)}
  else {return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Net ROI (%)"], 10)}
}

function Get_WinPerformance_TabPerformanceHistory_ChGrossROIPercent() //missing in Automation 8 (pref??)
{
  if (language == "french"){return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "RCI brut (%)"], 10)}
  else {return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Gross ROI (%)"], 10)}
}

function Get_WinPerformance_TabPerformanceHistory_ChFees() //missing in Automation 8 (pref??)
{
  if (language == "french"){return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Frais"], 10)}
  else {return Get_WinPerformance().FindChild("Uid", "TabControl_ecf2", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fees"], 10)}
}

function Get_WinPerformance_TabDefaultIndices(){return Get_WinPerformance().FindChild("Uid", "TabItem_4229", 10)} 

function Get_WinPerformance_TabPerformanceHistory_DgvHistoryData(){return Get_WinPerformance().FindChild("Uid", "DataGrid_74c4", 10)} 


//----->fin   MenuEdit_Get_functions


//----> MenuEdit_Get_functions
//*************************** GESTIONNAIRE DE RESTRICTIONS (RESTRICTIONS MANAGER) ****************************************
//Fenêtre commune aux modules : Modèles, Relations et Comptes
//Efit --> Functions --> Restrictions 
function Get_WinRestrictionsManager(){return Aliases.CroesusApp.winRestrictionsManager}

function Get_WinRestrictionsManager_BarPadHeader(){return Get_WinRestrictionsManager().FindChild("Uid", "PadHeader_1d27", 10)} //ok

function Get_WinRestrictionsManager_BarPadHeader_BtnAdd(){return Get_WinRestrictionsManager_BarPadHeader().FindChild("Uid", "Button_5a60", 10)} //ok

function Get_WinRestrictionsManager_BarPadHeader_BtnEdit(){return Get_WinRestrictionsManager_BarPadHeader().FindChild("Uid", "Button_70d1", 10)} //ok

function Get_WinRestrictionsManager_BarPadHeader_BtnDelete(){return Get_WinRestrictionsManager_BarPadHeader().FindChild("Uid", "Button_21b2", 10)} //ok

function Get_WinRestrictionsManager_BtnClose(){return Get_WinRestrictionsManager().FindChild("Uid", "Button_3006", 10)} //ok

function Get_WinRestrictionsManager_ChBreach(){return Get_WinRestrictionsManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)} //no uid

function Get_WinRestrictionsManager_ChType(){return Get_WinRestrictionsManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)} //no uid

function Get_WinRestrictionsManager_ChSeverity() //no uid
{
  if (language == "french"){return Get_WinRestrictionsManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sévérité"], 10)}
  else {return Get_WinRestrictionsManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Severity"], 10)}
}

function Get_WinRestrictionsManager_ChRestriction(){return Get_WinRestrictionsManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Restriction"], 10)} //no uid

function Get_WinRestrictionsManager_DgvRestriction(){return Get_WinRestrictionsManager().FindChild("Uid", "DataGrid_9865", 10)} 

//************************************* FENÊTRE AJOUTER/MODIFIER UNE RESTRICTION (ADD/EDIT A RESTRICTION WINDOW) ******************************************
//Efit --> Functions --> Restrictions  --> bnt ADD
function Get_WinCRURestriction(){return Aliases.CroesusApp.winCRURestriction}

function Get_WinCRURestriction_LblName(){return Get_WinCRURestriction().FindChild("Uid", "TextBlock_c993", 10)}

function Get_WinCRURestriction_TxtName(){return Get_WinCRURestriction().FindChild("Uid", "LocaleTextbox_62e7", 10)}

function Get_WinCRURestriction_LblRestriction(){return Get_WinCRURestriction().FindChild("Uid", "TextBlock_aa93", 10)}

function Get_WinCRURestriction_TxtRestriction(){return Get_WinCRURestriction().FindChild("Uid", "TextBox_dffc", 10)}

function Get_WinCRURestriction_LblSeverity(){return Get_WinCRURestriction().FindChild("Uid", "TextBlock_415e", 10)}

function Get_WinCRURestriction_CmbSeverity(){return Get_WinCRURestriction().FindChild("Uid", "UniComboBox_a876", 10)}

function Get_WinCRURestriction_BtnOK(){return Get_WinCRURestriction().FindChild("Uid", "Button_8212", 10)}

function Get_WinCRURestriction_BtnCancel(){return Get_WinCRURestriction().FindChild("Uid", "Button_d43e", 10)}


function Get_WinCRURestriction_GrpSecurity(){return Get_WinCRURestriction().FindChild("Uid", "GroupBox_199c", 10)}

function Get_WinCRURestriction_GrpSecurity_RdoSecurity(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "RadioButton_e0bd", 10)}

function Get_WinCRURestriction_GrpSecurity_CmbQuickSearchTypePicker(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinCRURestriction_GrpSecurity_BtnQuickSearchListPicker(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "ListPickerExec_9344", 10)}

function Get_WinCRURestriction_GrpSecurity_RdoPercentageOfTotalValue(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "RadioButton_11c4", 10)}

function Get_WinCRURestriction_GrpSecurity_LblPercentageOfTotalValueMinimum(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "TextBlock_794f", 10)}

function Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMinimum(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "DoubleTextBox_1c19", 10)}

function Get_WinCRURestriction_GrpSecurity_LblPercentageOfTotalValueMaximum(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "TextBlock_81fe", 10)}

function Get_WinCRURestriction_GrpSecurity_TxtPercentageOfTotalValueMaximum(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "DoubleTextBox_4587", 10)}

function Get_WinCRURestriction_GrpSecurity_LblPercentageOfTotalValueOn(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "TextBlock_89d8", 10)}

function Get_WinCRURestriction_GrpSecurity_CmbPercentageOfTotalValueOn(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "ComboBox_c50d", 10)}

function Get_WinCRURestriction_GrpSecurity_RdoModifiedDuration(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "RadioButton_522f", 10)}

function Get_WinCRURestriction_GrpSecurity_LblModifiedDurationMinimum(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "TextBlock_784f", 10)}

function Get_WinCRURestriction_GrpSecurity_TxtModifiedDurationMinimum(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "DoubleTextBox_b72a", 10)}

function Get_WinCRURestriction_GrpSecurity_LblModifiedDurationMaximum(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "TextBlock_470d", 10)}

function Get_WinCRURestriction_GrpSecurity_TxtModifiedDurationMaximum(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "DoubleTextBox_f16c", 10)}

function Get_WinCRURestriction_GrpSecurity_RdoPriceCurrency(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "RadioButton_0ff3", 10)}

function Get_WinCRURestriction_GrpSecurity_LblPriceCurrencyNotEqualTo(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "TextBlock_e27a", 10)}

function Get_WinCRURestriction_GrpSecurity_CmbPriceCurrencyNotEqualTo(){return Get_WinCRURestriction_GrpSecurity().FindChild("Uid", "ComboBox_2b16", 10)}


function Get_WinCRURestriction_GrpGroupClass(){return Get_WinCRURestriction().FindChild("Uid", "GroupBox_f3a1", 10)}

function Get_WinCRURestriction_GrpGroupClass_RdoGroupClass(){return Get_WinCRURestriction_GrpGroupClass().FindChild("Uid", "RadioButton_c2aa", 10)}

function Get_WinCRURestriction_GrpGroupClass_BtnClass(){return Get_WinCRURestriction_GrpGroupClass().FindChild("Uid", "Button_c000", 10)}

function Get_WinCRURestriction_GrpGroupClass_BtnClass_LblClass(){return Get_WinCRURestriction_GrpGroupClass_BtnClass().FindChild("Uid", "TextBlock_6ad3", 10)}

function Get_WinCRURestriction_GrpGroupClass_DgvClassificationClass(){return Get_SubMenus().FindChild("Uid", "DataGrid_9336", 10).WPFObject("RecordListControl", "", 1)}

function Get_WinCRURestriction_GrpGroupClass_LblPercentageOfTotalValue(){return Get_WinCRURestriction_GrpGroupClass().FindChild("Uid", "TextBlock_0989", 10)}

function Get_WinCRURestriction_GrpGroupClass_LblPercentageOfTotalValueMinimum(){return Get_WinCRURestriction_GrpGroupClass().FindChild("Uid", "TextBlock_ebd8", 10)}

function Get_WinCRURestriction_GrpGroupClass_TxtPercentageOfTotalValueMinimum(){return Get_WinCRURestriction_GrpGroupClass().FindChild("Uid", "DoubleTextBox_699c", 10)}

function Get_WinCRURestriction_GrpGroupClass_LblPercentageOfTotalValueMaximum(){return Get_WinCRURestriction_GrpGroupClass().FindChild("Uid", "TextBlock_b4c5", 10)}

function Get_WinCRURestriction_GrpGroupClass_TxtPercentageOfTotalValueMaximum(){return Get_WinCRURestriction_GrpGroupClass().FindChild("Uid", "DoubleTextBox_486e", 10)}

//*********************************** FENÊTRE INFO DÉTAILLÉE DU CLIENT ET DE LA RELATION (CLIENT AND RELATIONSHIP DETAILED INFO WINDOW) ************************************
//Edit --> Info 
function Get_WinDetailedInfo(){return Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient}

function Get_WinDetailedInfo_BtnOK(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinDetailedInfo_BtnCancel(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}

function Get_WinDetailedInfo_BtnApply(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "3"], 10)}


//*********************************** Onglet Info de la fenêtre Info détaillée (Info tab of the detailed info window) **********************************************

function Get_WinDetailedInfo_TabInfo(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Info"], 10)}


function Get_WinDetailedInfo_TabInfo_GrpGeneral(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblFullName(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblShortName(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblIACode(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblAlternateNameForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtAlternateNameForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblSalutationNameForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSalutationNameForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblTypeForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}//YR dans 90-04-32 "1" ; dans 90-04-44 "2"

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblLanguageForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblLanguageForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)} //YR 90-04-49

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)} 
function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblCreationForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpCreationForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblCurrencyForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblCurrencyForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "8"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)}//YR90-04-49

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblUpdateForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "9"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpUpdateForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpNextReviewForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblTypeForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "10"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship(){
//   if(userNameWinInfoCmbTypeForRelationship == "KEYNEJ")
//       return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)
//    else
      return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkIsJoint(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtStatus(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "7"], 10)}//module clients

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbStatusForRelatioship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblReadOnlyRelationshipForRelationship()
{
    if (Get_WinDetailedInfo_TabInfo_GrpGeneral_LblBillableRelationshipForBillingRelationship().Exists){return Get_WinDetailedInfo_TabInfo_GrpGeneral_LblReadOnlyRelationshipForBillingRelationship()}
    else {return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", 11], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship()
{
    if (Get_WinDetailedInfo_TabInfo_GrpGeneral_LblBillableRelationshipForBillingRelationship().Exists){return Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForBillingRelationship()}
    else {return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", 1], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblBillableRelationshipForBillingRelationship()
{
  if (language == "french"){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "Text"], ["UniLabel", "Relation facturable:"], 10)}
  else {return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "Text"], ["UniLabel", "Billable Relationship:"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpClosingDate(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbManagementlevel(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbManagementlevels(i){  //i=7 dans le module Clients; i=10 dans le module Comptes
            return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["Uid", "WPFControlOrdinalNo"], ["CustomTextBox_5194", i], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtManagementlevel(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "8"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkBillableRelationshipForBillingRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblReadOnlyRelationshipForBillingRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "12"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForBillingRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblGenderForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10)}//YR 90-04-67

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblSINForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "8"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblDateOfBirthForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "9"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblAgeForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "10"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblBNForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "11"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "5"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblFiscalYearForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "12"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFiscalYearForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblmmddForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "13"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblProvincialBNForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "14"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClient(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "6"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkProspectForClient(){
  var nb = 1;
  if (client == "CIBC")
      nb = 2;
  return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", nb], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblProspectForClient(){
  var nb = 15;
  if (client == "CIBC")
      nb = 19;
  return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", nb], 10)}


function Get_WinDetailedInfo_TabInfo_GrpGeneral_LblStatusForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild("Uid", "Label_f867", 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtStatusForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "7"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtClientRelationshipNo(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "9"], 10)}




//Si le code CP est un Textbox au lieu d'un Combobox (when IA Code is a Texbox instead of a Combobox)

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 3], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtAlternateNameForRelationshipWhenIACodeIsTextbox(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 4], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSalutationNameForRelationshipWhenIACodeIsTextbox(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 5], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationshipWhenIACodeIsTextbox(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationshipWhenIACodeIsTextbox(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 2], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationshipWhenIACodeIsTextbox(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 3], 10)}


//Items du combobox Type pour Relations (Items of Type for relationships combobox)

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemFamily()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Famille"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Family"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemSpecialRelation()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Relation spéciale"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Special Relation"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemFamilyFirm()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Famille-Firme"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Family-Firm"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemComposite()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Composée"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Composite"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemManaged()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Gérée"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Managed"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemGroupedRelation()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Relation groupée"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Grouped Relation"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemIPSRelation()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Relation IPS"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "IPS Relation"], 10)}
}


//Items du combobox Langue (Items of Language combobox)

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage_ItemEnglish()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Anglais"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "English"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage_ItemFrench()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Français"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "French"], 10)}
}

//Items du combobox Fréquence de révision
 function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency_ItemNone()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Aucune"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "None"], 10)}
}

 function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency_ItemAnnual()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Annuelle"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Annual"], 10)}
}
 

//Items du combobox Code de CP (Items of IA Code combobox)
function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_ItemAC42(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "AC42"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_Item0AED(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "0AED"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForRelationship_ItemBD88(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "BD88"], 10)}

//Items du combobox Devise (Items of Currency combobox)

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency_ItemCAD(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "CAD"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency_ItemEUR(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "EUR"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency_ItemNOK(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "NOK"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency_ItemSEK(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "SEK"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency_ItemUSD(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "USD"], 10)}


//Pour la fenêtre Ajout d'un client fictif ou externe

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbIACodeForClientCreation(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClientCreation(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}//YR 90-04-49

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForClientCreation(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForClientCreation(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForClientCreation(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClientCreation(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClientCreation(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "4"], 10)} // "3" dans 90-04-32

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClientCreation(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "5"], 10)}// "4" dans 90-04-32

function Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClientCreation(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "6"], 10)}// "5" dans 90-04-32

//Fin des fonctions propres à la fenêtre Ajout d'un client fictif ou externe


function Get_WinDetailedInfo_TabInfo_GrpAmounts(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpAmounts_LblBalance(){return Get_WinDetailedInfo_TabInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtBalance(){return Get_WinDetailedInfo_TabInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpAmounts_LblTotalValue(){return Get_WinDetailedInfo_TabInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtTotalValue(){return Get_WinDetailedInfo_TabInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpAmounts_LblMarginOrExcessMargin(){return Get_WinDetailedInfo_TabInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtMarginOrExcessMargin(){return Get_WinDetailedInfo_TabInfo_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "3"], 10)}


function Get_WinDetailedInfo_TabInfo_GrpFollowUp(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblSegmentation(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation_ItemA(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "A"], 10, true, 15000)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation_ItemB(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "B"], 10, true, 15000)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation_ItemC(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "C"], 10, true, 15000)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation_ItemD(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "D"], 10, true, 15000)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblContactPerson(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson_ItemNicolasCopernic(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Nicolas Copernic"], 10, true, 15000)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblAccountManager(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager_ItemNicolasCopernic(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Nicolas Copernic"], 10, true, 15000)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblCommunication(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication_ItemEmail()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Courriel"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Email"], 10, true, 15000)}
}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication_ItemInPerson()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "En personne"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "In person"], 10, true, 15000)}
}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication_ItemTelephone()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Téléphone"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Telephone"], 10, true, 15000)}
}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication_ItemWritten()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Écrit"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Written"], 10, true, 15000)}
}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblRepresentativeForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_TxtRepresentativeForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblReportVisualSupportForClient(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbReportVisualSupportForClient(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "1"], 10)}


function Get_WinDetailedInfo_TabInfo_GrpDateForClient(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpDate_LblCreationForClient(){return Get_WinDetailedInfo_TabInfo_GrpDateForClient().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpDate_DtpCreationForClient(){return Get_WinDetailedInfo_TabInfo_GrpDateForClient().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpDate_LblUpdateForClient(){return Get_WinDetailedInfo_TabInfo_GrpDateForClient().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpDate_DtpUpdateForClient(){return Get_WinDetailedInfo_TabInfo_GrpDateForClient().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 10)}


//Pour la racine secondaire du client

function Get_WinDetailedInfo_TabInfo_GrpFollowUpForSecondaryRoot(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblSegmentationForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpFollowUpForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentationForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpFollowUpForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblContactPersonForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpFollowUpForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPersonForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpFollowUpForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblAccountManagerForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpFollowUpForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManagerForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpFollowUpForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblCommunicationForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpFollowUpForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunicationForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpFollowUpForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblReportVisualSupportForClientForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpFollowUpForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbReportVisualSupportForClientForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpFollowUpForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10)}



function Get_WinDetailedInfo_TabInfo_GrpDateForClientForSecondaryRoot(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpDate_LblCreationForClientForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpDateForClientForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpDate_DtpCreationForClientForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpDateForClientForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpDate_LblUpdateForClientForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpDateForClientForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpDate_DtpUpdateForClientForSecondaryRoot(){return Get_WinDetailedInfo_TabInfo_GrpDateForClientForSecondaryRoot().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 10)}


//Fin Pour la racine secondaire du client



function Get_WinDetailedInfo_TabInfo_GrpNotes(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Notes"], 10)}

//function Get_WinDetailedInfo_TabInfo_GrpNotes_TabGrid_BtnCopy()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabInfo_GrpNotes().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Copier"], 10)}
//  else {return Get_WinDetailedInfo_TabInfo_GrpNotes().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Copy"], 10)}
//}

function Get_WinDetailedInfo_TabInfo_GrpNotes_TabGrid_BtnCopy(){return Get_CroesusApp().FindChildEx("Uid", "Button_13b9", 10, true, 15000)} //YR 

//Les fonctions Get suivantes sont communes aux fenêtres Info Client/Relation et Info Compte (onglet Notes)
/*
function Get_WinInfo_Notes_TabSummary()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Sommaire"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Summary"], 10)}
}*/
function Get_WinInfo_Notes_TabSummary(){return Get_CroesusApp().FindChildEx("Uid", "TabItem_a26f", 10, true, 15000)};//Modification de la fonction suite qu'elle a un UID -version -39

//function Get_WinInfo_Notes_TabSummary_TxtSummary(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextArea", "1"], 10)}

function Get_WinInfo_Notes_TabSummary_TxtSummary(){return Get_CroesusApp().FindChildEx("Uid","NoteSectionControl_0e30",10, true, 15000).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}

/*
function Get_WinInfo_Notes_TabGrid()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Grille"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Grid"], 10)}
}*/
function Get_WinInfo_Notes_TabGrid(){return Get_CroesusApp().FindChildEx("Uid", "TabItem_fc72", 10, true, 15000)}//Modification de la fonction get suite qu'elle a un UID-version 39

function Get_WinInfo_Notes_TabGrid_TxtSearch(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10, true, 15000).FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10, true, 3000).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinInfo_Notes_TabGrid_BtnSearch(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10, true, 15000).FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10, true, 3000).FindChild("Uid", "Button_d168", 10)}

//function Get_WinInfo_Notes_TabGrid_BtnPrint(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinInfo_Notes_TabGrid_BtnPrint(){return Get_CroesusApp().FindChildEx("Uid", "Button_caf1", 10, true, 15000)} //YR 

//function Get_WinInfo_Notes_TabGrid_DgvNotes(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "FixedColumnListView_1b3e", 10)}//YR 90-04-32

function Get_WinInfo_Notes_TabGrid_DgvNotes(){return Get_CroesusApp().FindChildEx("Uid", "NoteDataGrid_ddf6", 10, true, 15000)}//YR 90-04-44

/*Les fonctions get pour le filtre************************************************************************/
function Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(WPFControlOrdinalNo){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", WPFControlOrdinalNo, true], 10)}


function Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilterByDescription(FilterDescription){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "DataContext.FilterDescription", "IsVisible"], ["ToggleButton", FilterDescription, true], 10)}


function Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilterByDescription_BtnEditView(FilterDescription)
{
  var tooltipText = (language == "french")? "Modifier/Consulter le filtre courant": "Edit/View current filter";
  return Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilterByDescription(FilterDescription).FindChild(["ClrClassName", "ToolTip.OleValue", "IsVisible"], ["Button", tooltipText, true], 10);
}


function Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilterByDescription_BtnRemove(FilterDescription)
{
  var tooltipText = (language == "french")? "Retirer le filtre courant": "Remove the current filter";
  return Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilterByDescription(FilterDescription).FindChild(["ClrClassName", "ToolTip.OleValue", "IsVisible"], ["Button", tooltipText, true], 10);
         
}

/********************************Fin Fonctions get Filtre**************************************************/
function Get_WinInfo_Notes_TabGrid_DgvNotes_ContextMenu_CreatedBy()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Créée par" , 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Created by" , 10)}
}

function Get_WinInfo_Notes_TabGrid_DgvNotes_ContextMenu_ModificationDate()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Date de modification" , 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Modification Date" , 10)}
}

//function Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate()//YR 90-04-32
//{
//  if (language == "french"){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Date de création"], 10)}
//  else {return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Creation Date"], 10)}
//}

function Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate()//YR 90-04-44
{
  if (language == "french"){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de création"], 10)}
  else {return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creation Date"], 10)}
}

//function Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreatedBy()//YR 90-04-32
//{
//  if (language == "french"){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Créée par"], 10)}
//  else {return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Created By"], 10)}
//}

function Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreatedBy()//YR 90-04-44
{
  if (language == "french"){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Créée par"], 10)}
  else {return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Created By"], 10)}
}

//function Get_WinInfo_Notes_TabGrid_DgvNotes_ChNote(){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Note"], 10)}//YR 90-04-32

function Get_WinInfo_Notes_TabGrid_DgvNotes_ChNote(){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Note"], 10)}//YR 90-04-32

//function Get_WinInfo_Notes_TabGrid_DgvNotes_ChModificationDate()//YR 90-04-32
//{
//  if (language == "french"){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Date de modification"], 10)}
//  else {return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Modification Date"], 10)}
//}

function Get_WinInfo_Notes_TabGrid_DgvNotes_ChModificationDate()//YR 90-04-32
{
  if (language == "french"){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de modification"], 10)}
  else {return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modification Date"], 10)}
}

function Get_WinInfo_Notes_TabGrid_DgvNotes_ChDeclareAsReview()//AM:90-07-23
{
  if (language == "french"){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Révision"], 10)}
  else {return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Review"], 10)}
}

function Get_WinInfo_Notes_TabGrid_DgvNotes_ChEffectiveDate()
{
  if (language == "french"){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de référence"], 10)}
  else {return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Effective Date"], 10)}
}

//function Get_WinInfo_Notes_TabGrid_TxtNote(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextArea", "1"], 10)}

function Get_WinInfo_Notes_TabGrid_TxtNote(){return Get_CroesusApp().FindChildEx("Uid","TextBox_b0b6",10, true, 15000)}//YR 90-04-44

/*
function Get_WinInfo_Notes_TabGrid_BtnAdd()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Aj_outer"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "A_dd"], 10)}
}*/
function Get_WinInfo_Notes_TabGrid_BtnAdd(){return Get_CroesusApp().FindChildEx("Uid", "Button_ddd2", 10, true, 15000)};
/*
function Get_WinInfo_Notes_TabGrid_BtnDisplay()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Co_nsulter"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "D_isplay"], 10)}
}*/
function Get_WinInfo_Notes_TabGrid_BtnDisplay(){return Get_CroesusApp().FindChildEx("Uid", "Button_309d", 10, true, 15000)}

//function Get_WinInfo_Notes_TabGrid_BtnEdit()
//{
//  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Mo_difier"], 10)}
//  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Edit"], 10)}
//}

function Get_WinInfo_Notes_TabGrid_BtnEdit(){return Get_CroesusApp().FindChildEx("Uid", "Button_5de5", 10, true, 15000)}// YR 90-04-49

function Get_WinInfo_Notes_TabGrid_BtnDelete(){return Get_CroesusApp().FindChildEx("Uid", "Button_8b6a", 10, true, 15000)}


/*
function Get_WinInfo_Notes_TabGrid_BtnDelete()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"], 10)}
}*/
//Fin : Fonctions communes aux fenêtres Info Client/Relation et Info Compte (onglet Notes) 

//*********************************** Onglet Note -CR1664 *********************************************************************************************************************
function Get_WinInfo_Notes_TabNote(){
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["TabItem", "Notes"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["TabItem", "Notes"], 10, true, 15000)} //uid n’a pas été utilisé pour que la fonctionne sera réutilisée dans plusieurs modules  YR 90-04-44
} 


//*********************************** Onglet Adresses de la fenêtre Info détaillée (Addresses tab of the detailed info window) **********************************************

function Get_WinDetailedInfo_TabAddresses()
{
  if (language == "french"){return Get_WinDetailedInfo().FindChildEx(["ClrClassName", "WPFControlText"], ["TabItem", "Adresses"], 10, true, -1)}
  else {return Get_WinDetailedInfo().FindChildEx(["ClrClassName", "WPFControlText"], ["TabItem", "Addresses"], 10, true, -1)}
}


function Get_WinDetailedInfo_TabAddresses_GrpAddresses(){return Get_WinDetailedInfo().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "1"], 10, true, -1)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd()
{
  //Log.Message(Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10, true, 1000).Exists);
  return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 0, true, 2000);
}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "3"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblType(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblStreet(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet3(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblCityProv(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCityProv(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "4"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblPostalCode(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtPostalCode(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "5"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblCountry(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCountry(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "6"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkMailingAddress(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "1"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblRelevantFrom(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtRelevantFrom(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "7"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblFromMmDd(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblTo(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "8"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtTo(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "8"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblToMmDd(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "9"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_LblTheRelevantPeriodHasPrecedenceOverTheMailingAddress(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "10"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_ChkUseTheRepresentativeInformationForRelationship(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "2"], 10)}


function Get_WinDetailedInfo_TabAddresses_GrpAddresses_GrpRepresentativeInformationForRelationship(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses().FindChild("Uid", "GroupBox_cf41", 10)}

function Get_WinDetailedInfo_TabAddresses_GrpAddresses_GrpRepresentativeInformation_TxtRepresentativeInformationForRelationship(){return Get_WinDetailedInfo_TabAddresses_GrpAddresses_GrpRepresentativeInformationForRelationship().FindChild("Uid", "AddressEmailPhoneSection_c0eb", 10)}


function Get_WinDetailedInfo_TabAddresses_GrpTelephones(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "2"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnAdd(){return Get_WinDetailedInfo_TabAddresses_GrpTelephones().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnEdit(){return Get_WinDetailedInfo_TabAddresses_GrpTelephones().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnDelete(){return Get_WinDetailedInfo_TabAddresses_GrpTelephones().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "3"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnMoveUp(){return Get_WinDetailedInfo_TabAddresses_GrpTelephones().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "4"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpTelephones_BtnMoveDown(){return Get_WinDetailedInfo_TabAddresses_GrpTelephones().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "5"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones(){return Get_WinDetailedInfo_TabAddresses_GrpTelephones().FindChild("Uid", "FixedColumnListView_1b3e", 10)}

function Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones_ChType(){return Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Type"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones_ChNumber()
{
  if (language == "french"){return Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Numéro"], 10)}
  else {return Get_WinDetailedInfo_TabAddresses_GrpTelephones_DgvTelephones().FindChild(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Number"], 10)}
}


function Get_WinDetailedInfo_TabAddresses_GrpEmails(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "3"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpEmails_BtnSend(){return Get_WinDetailedInfo_TabAddresses_GrpEmails().FindChild("Uid", "Button_5a3f", 10)}

function Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails(){return Get_WinDetailedInfo_TabAddresses_GrpEmails().FindChild("Uid", "DataGrid_9b70", 10)}

function Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChType(){return Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChEmail()
{
  if (language == "french"){return Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Courriel"], 10)}
  else {return Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Email"], 10)}
}

function Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChDefault()
{
  if (language == "french"){return Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Défaut"], 10)}
  else {return Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Default"], 10)}
}

function Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChConsent()
{
  if (language == "french"){return Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Consentement"], 10)}
  else {return Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Consent"], 10)}
}

function Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChEffectiveDate()
{
  if (language == "french"){return Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Entrée en vigueur"], 10)}
  else {return Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Effective Date"], 10)}
}

function Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails_ChExpirationDate()
{
  if (language == "french"){return Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Expiration"], 10)}
  else {return Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Expiration Date"], 10)}
}



//*********************************** Onglet Agenda de la fenêtre Info détaillée (Agenda tab of the detailed info window) **********************************************

function Get_WinDetailedInfo_TabAgendaForClient(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Agenda"], 10)}

function Get_WinDetailedInfo_TabAgendaForClient_BtnPrint(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}


function Get_WinDetailedInfo_TabAgendaForClient_GrpFilters(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "1"], 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_LblStatus(){return Get_WinDetailedInfo_TabAgendaForClient_GrpFilters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_CmbStatus(){return Get_WinDetailedInfo_TabAgendaForClient_GrpFilters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_LblType(){return Get_WinDetailedInfo_TabAgendaForClient_GrpFilters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_CmbType(){return Get_WinDetailedInfo_TabAgendaForClient_GrpFilters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_LblAssignee(){return Get_WinDetailedInfo_TabAgendaForClient_GrpFilters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_CmbAssignee(){return Get_WinDetailedInfo_TabAgendaForClient_GrpFilters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_LblSearchDescription(){return Get_WinDetailedInfo_TabAgendaForClient_GrpFilters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_TxtSearchDescription(){return Get_WinDetailedInfo_TabAgendaForClient_GrpFilters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_BtnPrevious(){return Get_WinDetailedInfo_TabAgendaForClient_GrpFilters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpFilters_BtnNext(){return Get_WinDetailedInfo_TabAgendaForClient_GrpFilters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}


function Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList(){return Get_WinDetailedInfo().FindChild("Uid", "BrokerDiaryListView_e8cc", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList_ChDateTime()
{
  if (language == "french"){return Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Date\nHeure"], 10)}
  else {return Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Date\nTime"], 10)}
}

function Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList_ChTypeDuration()
{
  if (language == "french"){return Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Type\nDurée"], 10)}
  else {return Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Type\nDuration"], 10)}
}

function Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList_ChFrequencyDescription()
{
  if (language == "french"){return Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Fréquence\nDescription"], 10)}
  else {return Get_WinDetailedInfo_TabAgendaForClient_DgvDiaryList().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Frequency\nDescription"], 10)}
}


function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation(){return Get_WinDetailedInfo().FindChild("Uid", "GroupBox_82f6", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblType(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_b142", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtType(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_73d7", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblStatus(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_372c", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtStatus(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_46a3", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblFrequency(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_9847", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtFrequency(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_239b", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblDate(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_c30a", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtDate(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_2f62", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblTime(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_0c06", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtTime(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_5711", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblDuration(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_6de5", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtDuration(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_59e0", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblPriority(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_841d", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtPriority(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_a984", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblReminder(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_22de", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtReminder(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_d7f8", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblLastUpdate(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_c86c", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtLastUpdate(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_7274", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblClient(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_d32b", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtClient(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_17d5", 10)} 

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblAccountNo(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_284d", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtAccountNo(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_61f1", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblAssignee(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_9e40", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtAssignee(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_c5de", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_LblDescription(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Label_5af5", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_TxtDescription(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "TextBox_26b3", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Button_7f1b", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnEdit(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Button_a95d", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Button_f83f", 10)}

function Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnLastCommunication(){return Get_WinDetailedInfo_TabAgendaForClient_GrpInformation().FindChild("Uid", "Button_81d7", 10)}

function Get_WinAddEditAnEvent_CmbType(){return Get_WinAddEditAnEvent().FindChild(["ClrClassName","WPFControlOrdinalNo"],["UniComboBroker","1"],10)}
 
function Get_WinAddEditAnEvent_CmbTime(){return Get_WinAddEditAnEvent().FindChild(["ClrClassName","WPFControlOrdinalNo"],["UniComboBroker","4"],10)}
 
function Get_WinAddEditAnEvent_BtnAccountNo(){return Get_WinAddEditAnEvent().FindChild(["ClrClassName","WPFControlOrdinalNo"],["Button","4"],10);}
 
function Get_WinAddEditAnEvent_TxtDescription(){return Get_WinAddEditAnEvent().FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBox","1"],10);}
 
function Get_WinAccount(){
  if (language == "french") {return Get_CroesusApp().FindChildEx(["ClrClassName","WndCaption"],["HwndSource","Comptes"],10, true, 30000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName","WndCaption"],["HwndSource","Accounts"],10, true, 30000)}
}
      
function Get_WinAccount_BtnOK(){return Get_WinAccount().FindChild(["ClrClassName","WPFControlText"],["UniButton","OK"],10)}
 


//*********************************** Onglet Produits & Services de la fenêtre Info détaillée (Products & Services tab of the detailed info window) **********************************************

function Get_WinDetailedInfo_TabProductsAndServices()
{
  if (language == "french"){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Produits & services"], 10)}
  else {return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Products & Services"], 10)}
}


function Get_WinDetailedInfo_TabProductsAndServices_GrpProducts(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "1"], 10)}

function Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_BtnSetup()
{
  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_GrpProducts().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Configurer..."], 10)}
  else { if( client == "US" ){return Get_WinDetailedInfo_TabProductsAndServices_GrpProducts().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Setup"], 10)}
  else{
  return Get_WinDetailedInfo_TabProductsAndServices_GrpProducts().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Set_up..."], 10)}
  }
}

function Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct(productFrenchName, productEnglishName)
{
  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_GrpProducts().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", productFrenchName], 10)}
  else {return Get_WinDetailedInfo_TabProductsAndServices_GrpProducts().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", productEnglishName], 10)}
}


function Get_WinDetailedInfo_TabProductsAndServices_GrpServices(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "2"], 10)}

function Get_WinDetailedInfo_TabProductsAndServices_GrpServices_BtnSetup()
{
  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_GrpServices().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Co_nfigurer..."], 10)}
  else {return Get_WinDetailedInfo_TabProductsAndServices_GrpServices().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Se_tup..."], 10)}
}

function Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService(serviceFrenchName, serviceEnglishName)
{
  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_GrpServices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", serviceFrenchName], 10)}
  else {return Get_WinDetailedInfo_TabProductsAndServices_GrpServices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", serviceEnglishName], 10)}
}


//Onglet Objectif de placement (Investment Objective tab)

function Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TabItem", "1"], 10)}

//Les fonctions suivantes sont communes aux fenêtres Info Client et Info Compte
function Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["UniCheckBox", "", "1"], 10, true, 15000)}

function Get_WinInfo_TabInvestmentObjective_TxtInvestmentObjectiveForClientAndAccount(){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10, true, 15000)}

function Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount(){return Get_CroesusApp().FindChildEx("Uid", "Button_d168", 10, true, 15000)}

function Get_WinInfo_TabInvestmentObjective_TvwAssetAllocationsForClientAndAccount(){return Get_CroesusApp().FindChildEx("Uid", "TreeView_f006", 10, true, 15000)}
//Fin : fonctions communes aux fenêtres Info Client et Info Compte

function Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_ChkInvestmentObjectiveForRelationship(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "CheckBox_fa4c", 10)}

function Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_BtnInvestmentObjectiveForRelationship(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "Button_d21d", 10)}

function Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_LblInvestmentObjectiveForRelationship(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "Label_9e48", 10)}

function Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_LblAssetIndexForRelationship(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "TextBlock_1f82", 10)}

function Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_LstAssetAllocationsForRelationship(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "ListBox_1bc5", 10)}


function Get_LstInvestmentObjectivesForRelationship_ItemBasic_Balanced()
{
  if (client == "US"){
    if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Equilibre"], 10)}
    else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Balanced"], 10)}
  }
  else {
    if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Equilibre"], 10)}
    else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Balanced"], 10)}
  }
}

function Get_LstInvestmentObjectivesForRelationship_ItemBasic_Growth()
{
  if (client == "US"){
    if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Croissance"], 10)}
    else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Growth"], 10)}
  }
  else {
    if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Croissance"], 10)}
    else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Growth"], 10)}
  }
}

function Get_LstInvestmentObjectivesForRelationship_ItemFirm_Balanced()
{
  if (client == "US"){
    if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 3], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Equilibre"], 10)}
    else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 3], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Balanced"], 10)}
  }
  else {
    if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Equilibre"], 10)}
    else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Balanced"], 10)}
  }
}

function Get_LstInvestmentObjectivesForRelationship_ItemFirm_Growth()
{
  if (client == "US"){
    if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 3], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Croissance"], 10)}
    else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 3], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Growth"], 10)}
  }
  else {
    if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Croissance"], 10)}
    else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 2], 10).FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", "Growth"], 10)}
  }
}


//Onglet Rapports par défaut (Default Reports tab)

function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TabItem", "2"], 10)}

//Les fonctions Get de cet onglet sont dans Common_Get_functions


function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports()
{
  if (language == "french"){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Rapports"], 10)}
  else {return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Reports"] ,10)}
}
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_TabReports()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Rapports"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Reports"] ,10)}
//}
//
function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_TabReports_LvwReports(){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"], 10)}

//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_TabSavedReports()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Rapports sauvegardés"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Saved Reports"] ,10)}
//}
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_TabSavedReports_TvwSavedReports(){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"], 10)}
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_TabSavedReports_BtnDelete()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"], 10)}
//}
//
//
function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnAddAReport()
{
  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Ajouter un rapport"], 10)}
  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Add a Report"] ,10)}
}

function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnRemoveAReport()
{
  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Enlever un rapport"], 10)}
  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Remove a Report"] ,10)}
}

function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnRemoveAllReports()
{
  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Enlever tous les rapports"], 10)}
  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Remove All Reports"] ,10)}
}

//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnMoveTheReportUp()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Monter le rapport"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Move the Report Up"] ,10)}
//}
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnMoveTheReportDown()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Descendre le rapport"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Move the Report Down"] ,10)}
//}
//
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_LblDefaultReports()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Rapports par défaut"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Default Reports"] ,10)}
//}
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_LvwDefaultReports(){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"], 10)}//no uid
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_ChkConsolidatePositions()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Consolider les positions"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Consolidate positions"] ,10)}
//}
//
function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnSave()
{
  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Sau_vegarder"], 10)}
  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Sa_ve"] ,10)}
}
//
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_GrpCurrentParameters()    
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Paramètres courants"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Current Parameters"] ,10)}
//}
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_GrpCurrentParameters_TxtCurrentParameters(){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_GrpCurrentParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniScrollPane", "1"], 10)}
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_GrpCurrentParameters_BtnParameters()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_GrpCurrentParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Paramètres..."], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_GrpCurrentParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Parameters..."] ,10)}
//}



//Onglet Indices par défaut (Default Indices tab)
//Les fonctions Get de cet onglet, sont communes aux fenêtres Info Client/Relation et Info Compte

function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultIndices(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TabItem", "3"], 10)}

function Get_WinInfo_TabDefaultIndices_LblTargetReturn(){return Get_CroesusApp().FindChildEx("Uid", "TextBlock_be22", 10, true, 15000)}

function Get_WinInfo_TabDefaultIndices_TxtTargetReturn(){return Get_CroesusApp().FindChildEx("Uid", "DoubleTextBox_e059", 10, true, 15000)}

function Get_WinInfo_TabDefaultIndices_LblPercent(){return Get_CroesusApp().FindChildEx("Uid", "TextBlock_2e07", 10, true, 15000)}

function Get_WinInfo_TabDefaultIndices_BtnAddIndices(){return Get_CroesusApp().FindChildEx("Uid", "Button_2c9f", 10, true, 15000)}

function Get_WinInfo_TabDefaultIndices_BtnRemoveIndices(){return Get_CroesusApp().FindChildEx("Uid", "Button_acce", 10, true, 15000)}


function Get_WinInfo_TabDefaultIndices_GrpAvailableIndices(){return Get_CroesusApp().FindChildEx("Uid", "GroupBox_bda6", 10, true, 15000)}

function Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices(){return Get_WinInfo_TabDefaultIndices_GrpAvailableIndices().FindChild("Uid", "DataGrid_758e", 10)}

function Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices_ChDescription(){return Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices_ChSecurity()
{
  if (language == "french"){return Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

function Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices_ChCurrency()
{
  if (language == "french"){return Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices_ChSymbol()
{
  if (language == "french"){return Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}


function Get_WinInfo_TabDefaultIndices_GrpSelectedIndices(){return Get_CroesusApp().FindChildEx("Uid", "GroupBox_7a0b", 10, true, 15000)}

function Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_BtnMoveTheIndiceUp(){return Get_WinInfo_TabDefaultIndices_GrpSelectedIndices().FindChild("Uid", "Button_bdf6", 10)}

function Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_BtnMoveTheIndiceDown(){return Get_WinInfo_TabDefaultIndices_GrpSelectedIndices().FindChild("Uid", "Button_c058", 10)}

function Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices(){return Get_WinInfo_TabDefaultIndices_GrpSelectedIndices().FindChild("Uid", "DataGrid_71d2", 10)}

function Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices_ChDescription(){return Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices_ChSecurity()
{
  if (language == "french"){return Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

function Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices_ChCurrency()
{
  if (language == "french"){return Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices_ChSymbol()
{
  if (language == "french"){return Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinInfo_TabDefaultIndices_GrpSelectedIndices_DgvSelectedIndices().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

//*********************************** Onglet Profil de la fenêtre Info détaillée (Profile tab of the detailed info window) **********************************************

function Get_WinDetailedInfo_TabProfile()
{
  if (language == "french"){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Profil"], 10)}
  else {return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Profile"], 10)}
}
function Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC(){
    return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["GroupBox", "KYC", 1], 10)}     

function Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC_TxtInvRiskLow()
{
    if (language == "french"){return Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Fact. risq. faible %"], 10)}
    else {return Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Inv Risk Low %"], 10)}
}

function Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC_TxtInvRiskMed()
{
    if (language == "french"){return Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Fact. risq. moyen %"], 10)}
    else {return Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Inv Risk Med %"], 10)}
}

function Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC_TxtInvRiskHigh()
{
    if (language == "french"){return Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Fact. risq. élevé %"], 10)}
    else {return Get_WinDetailedInfo_TabProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Inv Risk High %"], 10)}
}

function Get_WinInfo_TabProfile_ItemControl_ChkHENRY()
{
 return Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CheckBox", "1"], 10)
}

function Get_WinInfo_TabProfile_ItemControl_LblHENRY()
{
 return Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "HENRY"], 10)
}


function Get_WinInfo_TabProfile_ItemControl(){return Get_CroesusApp().FindChildEx("Uid", "ItemsControl_b25d", 10, true, 15000)}

//Les trois fonctions suivantes sont communes aux fenêtres Info Client/Relation et Info Compte
 
function Get_WinInfo_TabProfile_ChkHideEmptyProfiles(){return Get_CroesusApp().FindChildEx("Uid", "CheckBox_9862", 10, true, 15000)}

function Get_WinInfo_TabProfile_BtnSetup(){return Get_CroesusApp().FindChildEx("Uid", "Button_06f8", 10, true, 15000)}

function Get_WinInfo_TabProfile_LblNoDataAvailable(){return Get_CroesusApp().FindChildEx("Uid", "TextBlock_bff6", 10, true, 15000)}


//*********************************** Onglet Clients sous-jacents de la fenêtre Info détaillée de la relation (Underlying Clients tab of the relationship's detailed info window) **********************************************

function Get_WinDetailedInfo_TabUnderlyingClientsForRelationship()
{
  if (language == "french"){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Clients sous-jacents"], 10)}
  else {return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Underlying Clients"], 10)}
}

function Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients(){return Get_WinDetailedInfo().FindChild("Uid", "DataGrid_6d48", 10)}

function Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients_ChLinkWithTheRepresentative()
{
  if (language == "french"){return Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Lien avec l'interlocuteur"], 10)}
  else {return Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Link with the representative"], 10)}
}

function Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients_ChBalance()
{
  if (language == "french"){return Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_WinDetailedInfo_TabUnderlyingClientsForRelationship_DgvUnderlyingClients().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance"], 10)}
}


//*********************************** Onglet Comptes sous-jacents de la fenêtre Info détaillée de la relation (Underlying Accounts tab of the relationship's detailed info window) **********************************************

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship()
{
  if (language == "french"){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Comptes sous-jacents"], 10)}
  else {return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Underlying Accounts"], 10)}
}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnEdit(){return Get_WinDetailedInfo().FindChild("Uid", "Button_94b5", 10)}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd(){return Get_WinDetailedInfo().FindChild("Uid", "Button_e7f0", 10)}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete(){return Get_WinDetailedInfo().FindChild("Uid", "Button_a4c6", 10)}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts(){return Get_WinDetailedInfo().FindChild("Uid", "DataGrid_2d13", 10)}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChAccountNo()
{
  if (language == "french"){return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No de compte"], 10)}
  else {return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChEntryDate()
{
  if (language == "french"){return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date d'entrée"], 10)}
  else {return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Entry Date"], 10)}
}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChRemovalDate()
{
  if (language == "french"){return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de sortie"], 10)}
  else {return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Removal Date"], 10)}
}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChPerformanceDate()
{
  if (language == "french"){return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de performance"], 10)}
  else {return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Performance Date"], 10)}
}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChAccountManagementStartDate()
{
  if (language == "french"){return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de début de gestion du compte"], 10)}
  else {return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account Management Start Date"], 10)}
}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChCreationDate()
{
  if (language == "french"){return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de création"], 10)}
  else {return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creation Date"], 10)}
}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts_ChClosingDate()
{
  if (language == "french"){return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de fermeture"], 10)}
  else {return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Closing Date"], 10)}
}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WndCaption"], ["HwndSource", "Modifier le compte sous-jacent"], 10, true, 15000)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WndCaption"], ["HwndSource", "Edit Underlying Account"], 10, true, 15000)}
}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount_TxtEntryDate(){return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount().FindChild("Uid", "DateField_c007", 10)}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount_TxtRemovalDate(){return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount().FindChild("Uid", "DateField_a027", 10)}


function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount_BtnOK(){return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount().FindChild("Uid", "Button_f90d", 10)}

function Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount_BtnCancel(){return Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_EditUnderlyingAccount().FindChild("Uid", "Button_3725", 10)}

//*********************************** Onglet Documents de la fenêtre Info détaillée (Documents tab of the detailed info window) **********************************************

function Get_WinDetailedInfo_TabDocuments(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Documents"], 10)}


//function Get_WinDetailedInfo_TabDocuments_Toolbar(){return Get_WinDetailedInfo().FindChild("Uid", "ToolBarTray_536b", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnShowHideFolderView(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "ToggleButton_4ecd", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnAddAFile(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "Button_7d78", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnRemove(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "Button_25cf", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnRefresh(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "Button_c153", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnCut(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "Button_1f07", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnCopy(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "Button_7b0f", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnPaste(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "Button_4c55", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_TxtSearch(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "TextBox_dafe", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnSearch(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "Button_3e39", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnFilterAll(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "ToggleButton_4b62", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnFilterEmail(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "ToggleButton_9796", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnFilterPdf(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "ToggleButton_5b0c", 10)}

//function Get_WinDetailedInfo_TabDocuments_Toolbar_BtnFilterFile(){return Get_WinDetailedInfo_TabDocuments_Toolbar().FindChild("Uid", "ToggleButton_ca4f", 10)}


//function Get_WinDetailedInfo_TabDocuments_GrpComments(){return Get_WinDetailedInfo().FindChild("Uid", "GroupBox_4d7f", 10)}

//function Get_WinDetailedInfo_TabDocuments_GrpComments_TxtComment(){return Get_WinDetailedInfo_TabDocuments_GrpComments().FindChild("Uid", "TextBox_a547", 10)}

//function Get_WinDetailedInfo_TabDocuments_GrpComments_BtnEdit(){return Get_WinDetailedInfo_TabDocuments_GrpComments().FindChild("Uid", "Button_b3e0", 10)}


function Get_WinDetailedInfo_TabDocuments_TvwDocumentsForRelationship(){return Get_WinDetailedInfo().FindChild("Uid", "TreeView_8107", 10)}

//function Get_WinDetailedInfo_TabDocuments_LstDocuments(){return Get_WinDetailedInfo().FindChild("Uid", "ListBox_25ba", 10)}

//Les fonctions Get pour les autres composants de l'onglet Documents, sont dans Common_Get_functions partie fenêtre Documents personnels




//*********************************** Onglet Réseau du client de la fenêtre Info détaillée (Client Network tab of the detailed info window) **********************************************

function Get_WinDetailedInfo_TabClientNetworkForClient()
{
  if (language == "french"){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Réseau d'influence"], 10)}
  else {return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Client Network"], 10)}//EM : Modifié selon le Jira CROES-1425 depuis CO-90-07-23 (Appliqué pour tous les clients)
}

function Get_WinDetailedInfo_TabClientNetworkForClient_BtnAdd(){return Get_WinDetailedInfo().FindChild("Uid", "Button_4ae8", 10)}

function Get_WinDetailedInfo_TabClientNetworkForClient_BtnEdit(){return Get_WinDetailedInfo().FindChild("Uid", "Button_9355", 10)}

function Get_WinDetailedInfo_TabClientNetworkForClient_BtnDelete(){return Get_WinDetailedInfo().FindChild("Uid", "Button_b556", 10)}

function Get_WinDetailedInfo_TabClientNetworkForClient_BtnPotential(){return Get_WinDetailedInfo().FindChild("Uid", "ToggleButton_4cb3", 10)}


function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork(){return Get_WinDetailedInfo().FindChild("Uid", "DataGrid_45a7", 10)}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChName()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChClientNo()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No client"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Client No."], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChFamily()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Familial"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Family"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChSocial(){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Social"], 10)}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChProfessionnal()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Professionnel"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Professionnal"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTotalValue()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale*"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value*"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChSource(){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Source"], 10)}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChNumber()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Number"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChDateOfBirth()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de naissance"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date of Birth"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChAge()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Âge"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Age"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChIACode()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChFullName()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom complet"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Full Name"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChBalance()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChEmail1()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Courriel 1"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Email 1"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChEmail2()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Courriel 2"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Email 2"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChEmail3()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Courriel 3"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Email 3"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTelephone1()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 1"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 1"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTelephone2()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 2"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 2"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTelephone3()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 3"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 3"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChTelephone4()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 4"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 4"], 10)}
}

//Pour le client RJ
function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChType()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork_ChLink()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Lien"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_DgvClientNetwork().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Link"], 10)}
}

//Groupbox Sommaire du réseau du client (Client network summary groupbox)

function Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary(){return Get_WinDetailedInfo().FindChild("Uid", "GroupBox_99c7", 10)}

function Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary_ChType(){return Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary_ChNoOfClients()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nbre de clients"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No. of Clients"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary_ChTotalValue()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale *"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_GrpClientNetworkSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value *"], 10)}
}


//Groupbox Sommaire des relations (Relationships summary groupbox)

function Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary(){return Get_WinDetailedInfo().FindChild("Uid", "GroupBox_10ea", 10)}

function Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary_ChName()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary_ChRelationshipNo()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No relation"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Relationship No."], 10)}
}

function Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary_ChType(){return Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary_ChTotalValue()
{
  if (language == "french"){return Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale *"], 10)}
  else {return Get_WinDetailedInfo_TabClientNetworkForClient_GrpRelationshipsSummary().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value *"], 10)}
}



//*********************************** Onglet Campagnes de la fenêtre Info détaillée (Campaigns tab of the detailed info window) **********************************************

function Get_WinDetailedInfo_TabCampaignsForClient()
{
  if (language == "french"){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Campagnes"], 10)}
  else {return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Campaigns"], 10)}
}


function Get_WinDetailedInfo_TabCampaignsForClient_BtnAdd(){return Get_WinDetailedInfo().FindChild("Uid", "Button_bc1c", 10)}

function Get_WinDetailedInfo_TabCampaignsForClient_BtnEdit(){return Get_WinDetailedInfo().FindChild("Uid", "Button_ee04", 10)}


function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns(){return Get_WinDetailedInfo().FindChild("Uid", "CampaignControlGrid_4619", 10)}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChName()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChAccess()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accès"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Access"], 10)}
}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChCampaign()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Campagne"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Campaign"], 10)}
}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChStart()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Début"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Start"], 10)}
}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChEnd()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fin"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "End"], 10)}
}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChResults()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Résultats"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Results"], 10)}
}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChUnitOfMeasure()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Unité de mesure"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Unit of Measure"], 10)}
}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChStatus()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "État"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChComments()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Commentaires"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Comments"], 10)}
}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChCampaignSalutation()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Appel de la campagne"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Campaign Salutation"], 10)}
}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChLastContact()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dern. contact"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Contact"], 10)}
}

function Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns_ChAddressee()
{
  if (language == "french"){return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Destinataire"], 10)}
  else {return Get_WinDetailedInfo_TabCampaignsForClient_DgvCampaigns().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Addressee"], 10)}
}



//*********************************** Onglet Gouvernance EPP de la fenêtre Info détaillée (IPS Governance tab of the detailed info window) **********************************************

function Get_WinDetailedInfo_TabIPSGovernanceForRelationship(){           //EM : Depuis 90-08-DY-2 Avant était "CRESUS_secur_ips_tit_IPSGovernance""
    if (language == "french") return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Gouvernance IPS"], 10);
    else 
        return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "IPS Governance"], 10)
} 

//*********************************** Onglet Facturation de la fenêtre Info détaillée (Billing tab of the detailed info window) **********************************************

function Get_WinDetailedInfo_TabBillingForRelationship()
{
  if (language == "french"){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Facturation"], 10)}
  else {return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Billing"], 10)}
}


function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters(){return Get_WinDetailedInfo().FindChild("Uid", "GroupBox_c011", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_LblFrequency(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "TextBlock_4a70", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "ComboBox_9c31", 10)}
function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbFrequency_Month(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "ComboBox_d0cf", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_LblPeriod(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "TextBlock_37c1", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_CmbPeriod(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "ComboBox_e765", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_ChkInAdvance(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "CheckBox_2e8b", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_LblFeeSchedule(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "TextBlock_c560", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtFeeSchedule(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "TextBox_c00b", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_BtnFeeSchedule(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "Button_9217", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_LblCalculationMethod(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "TextBlock_866b", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtCalculationMethod(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "TextBox_19b7", 10)}
//Ajout de la fonction get pour la partie texte du Amount/Inflow et Amount/Outflow percentage/Amount et Percentage/Outflow
function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountInflow(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "DoubleTextBox_f076", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtAmountOutflow(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "DoubleTextBox_9855", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageInflow(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "DoubleTextBox_4166", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters_TxtPercentageOutflow(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpParameters().FindChild("Uid", "DoubleTextBox_6ecf", 10)}


function Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation(){return Get_WinDetailedInfo().FindChild("Uid", "GroupBox_1d37", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_LblCurrentAUM(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation().FindChild("Uid", "TextBlock_d38e", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_LlbCalculate(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation().FindChild("Uid", "TextBlock_aadd", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_LblLastBillingAUM(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation().FindChild("Uid", "TextBlock_02e7", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_TxtLastBillingAUM(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation().FindChild("Uid", "TextBlock_ad15", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_LblLastBillingDate(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation().FindChild("Uid", "TextBlock_7f7d", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_TxtLastBillingDate(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation().FindChild("Uid", "TextBlock_c4cd", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnHistory(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation().FindChild("Uid", "Button_2e68", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation_BtnBillNow(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpBillingInformation().FindChild("Uid", "Button_f0aa", 10)}


//S'affiche quand on choisit une Grille tarifaire
function Get_WinDetailedInfo_TabBillingForRelationship_GrpFeeSchedule(){return Get_WinDetailedInfo().FindChild("Uid", "GroupBox_5965", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpFeeSchedule_DgvFeeTemplate(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpFeeSchedule().FindChild("Uid", "DataGrid_611f", 10)}


function Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts(){return Get_WinDetailedInfo().FindChild("Uid", "GroupBox_ad11", 10)}

function Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts_DgvAccounts(){return Get_WinDetailedInfo_TabBillingForRelationship_GrpAccounts().FindChild("Uid", "DataGrid_9b9f", 10)}

//********************************************* FENÊTRE AJOUTER ADRESSE (INFO/ADRESSE/AJOUTER) **************************************************

function Get_WinAddAddress(){
    var winTitle = (language == "french")? "Ajouter une adresse": "Add Address";
    return Get_CroesusApp().FindchildEx(["Uid", "WPFControlText"], ["BaseDialog_136b", winTitle], 10, true, 15000);
}

function Get_WinAddAddress_CmbType(){return Get_WinAddAddress().Findchild(["ClrClassName", "WPFControlOrdinalNo"],["CFComboBox", 1], 10)}

function Get_WinAddAddress_TxtStreet(){return Get_WinAddAddress().Findchild(["Uid", "WPFControlOrdinalNo"],["CustomTextBox_5194", 1], 10)}
        
function Get_WinAddAddress_TxtCity(){return Get_WinAddAddress().Findchild(["Uid", "WPFControlOrdinalNo"],["CustomTextBox_5194", 4], 10)}  
        
function Get_WinAddAddress_TxtZipCode(){return Get_WinAddAddress().Findchild(["Uid", "WPFControlOrdinalNo"],["CustomTextBox_5194", 5], 10)} 
        
function Get_WinAddAddress_TxtCountry(){return Get_WinAddAddress().Findchild(["Uid", "WPFControlOrdinalNo"],["CustomTextBox_5194", 6], 10)}
        
function Get_WinAddAddress_ChkBoxMailingAddress(){return Get_WinAddAddress().Findchild(["ClrClassName", "WPFControlOrdinalNo"],["UniCheckBox", 1], 10)}

function Get_WinAddAddress_BtnOK(){return Get_WinAddAddress().Findchild(["ClrClassName", "WPFControlText"],["UniButton", "OK"], 10)}

//********************************************* FENÊTRE HISTORIQUE DE FACTURATION (BILLING HISTORY WINDOW) **************************************************
//TabBillling dans le fenêtre Info 
function Get_WinBillingHistory(){return Aliases.CroesusApp.winBillingHistory}

function Get_WinBillingHistory_BtnClose(){return Get_WinBillingHistory().FindChild("Uid", "Button_d5cb", 10)}


function Get_WinBillingHistory_GrpBilling(){return Get_WinBillingHistory().FindChild("Uid", "GroupBox_660f", 10)}

function Get_WinBillingHistory_GrpBilling_DgvBilling(){return Get_WinBillingHistory_GrpBilling().FindChild("Uid", "DataGrid_3610", 10)}


function Get_WinBillingHistory_GrpAccounts(){return Get_WinBillingHistory().FindChild("Uid", "GroupBox_2e22", 10)}

function Get_WinBillingHistory_GrpAccounts_BtnView(){return Get_WinBillingHistory_GrpAccounts().FindChild("Uid", "Button_9ddc", 10)}

function Get_WinBillingHistory_GrpAccounts_DgvAccounts(){return Get_WinBillingHistory_GrpAccounts().FindChild("Uid", "DataGrid_3ea8", 10)}


function Get_WinBillingHistory_GrpSummary(){return Get_WinBillingHistory().FindChild("Uid", "GroupBox_9d14", 10)}

function Get_WinBillingHistory_GrpSummary_LblCurrentAUM(){return Get_WinBillingHistory_GrpSummary().FindChild("Uid", "TextBlock_0169", 10)}

function Get_WinBillingHistory_GrpSummary_LlbCalculate(){return Get_WinBillingHistory_GrpSummary().FindChild("Uid", "TextBlock_289f", 10)}

function Get_WinBillingHistory_GrpSummary_LblLastBillingAUM(){return Get_WinBillingHistory_GrpSummary().FindChild("Uid", "TextBlock_f4f2", 10)}

function Get_WinBillingHistory_GrpSummary_TxtLastBillingAUM(){return Get_WinBillingHistory_GrpSummary().FindChild("Uid", "TextBlock_e7f8", 10)}

function Get_WinBillingHistory_GrpSummary_LblLastBillingDate(){return Get_WinBillingHistory_GrpSummary().FindChild("Uid", "TextBlock_4afa", 10)}

function Get_WinBillingHistory_GrpSummary_TxtLastBillingDate(){return Get_WinBillingHistory_GrpSummary().FindChild("Uid", "TextBlock_adf0", 10)}

function Get_WinBillingHistory_GrpSummary_LblFeesSinceTheBeginning(){return Get_WinBillingHistory_GrpSummary().FindChild("Uid", "TextBlock_54c2", 10)}

function Get_WinBillingHistory_GrpSummary_TxtFeesSinceTheBeginning(){return Get_WinBillingHistory_GrpSummary().FindChild("Uid", "TextBlock_1364", 10)}

function Get_WinBillingHistory_GrpSummary_LblFeesSinceTheBeginningOfTheYear(){return Get_WinBillingHistory_GrpSummary().FindChild("Uid", "TextBlock_4038", 10)}

function Get_WinBillingHistory_GrpSummary_TxtFeesSinceTheBeginningOfTheYear(){return Get_WinBillingHistory_GrpSummary().FindChild("Uid", "TextBlock_000b", 10)}

function Get_WinBillingHistory_GrpSummary_LblMessage(){return Get_WinBillingHistory_GrpSummary().FindChild("Uid", "Label_9910", 10)}

//**************************************** FENÊTRE PARAMÈTRES DE FACTURATION INSTANTANÉE (INSTANT BILLING PARAMETERS WINDOW) ******************************************
//Edit --> Info --> Tab Billing --> Cliquer sur le btn "Bill Now"
function Get_WinInstantBillingParameters(){return Aliases.CroesusApp.winInstantBillingParameters}

function Get_WinInstantBillingParameters_BtnOK(){return Get_WinInstantBillingParameters().FindChild("Uid", "Button_1a4a", 10)}

function Get_WinInstantBillingParameters_BtnCancel(){return Get_WinInstantBillingParameters().FindChild("Uid", "Button_e8d0", 10)}

function Get_WinInstantBillingParameters_LblSelectABillingDate(){return Get_WinInstantBillingParameters().FindChild("Uid", "TextBlock_30af", 10)}

//********************************************* FENÊTRE AJOUTER/MODIFIER UNE ADRESSE (ADD/EDIT ADDRESS WINDOW) **************************************************
//Edit --> Info --> Tab Adresse --> Add/Edit
function Get_WinCRUAddress(){return Aliases.CroesusApp.winCRUAddress}

function Get_WinCRUAddress_LblType(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinCRUAddress_CmbType(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinCRUAddress_LblStreet(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinCRUAddress_TxtStreet1(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinCRUAddress_TxtStreet2(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}

function Get_WinCRUAddress_TxtStreet3(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}

function Get_WinCRUAddress_LblCityProv(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinCRUAddress_TxtCityProv(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "4"], 10)}

function Get_WinCRUAddress_LblPostalCode(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinCRUAddress_TxtPostalCode(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "5"], 10)}

function Get_WinCRUAddress_LblCountry(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_WinCRUAddress_TxtCountry(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "6"], 10)}

function Get_WinCRUAddress_ChkMailingAddress(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "1"], 10)}

function Get_WinCRUAddress_LblRelevantFrom(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}

function Get_WinCRUAddress_TxtRelevantFrom(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinCRUAddress_LblRelevantFromMmDd(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 10)}

function Get_WinCRUAddress_LblTo(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "8"], 10)}

function Get_WinCRUAddress_TxtTo(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 10)}

function Get_WinCRUAddress_LblToMmDd(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "9"], 10)}

function Get_WinCRUAddress_LblPrecedenceMessage(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "10"], 10)}

function Get_WinCRUAddress_BtnOK(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinCRUAddress_BtnCancel(){return Get_WinCRUAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}

//Items du combobox Type (Items of Type combobox)

function Get_WinCRUAddress_CmbType_ItemHome()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Maison"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Home"], 10)}
}

function Get_WinCRUAddress_CmbType_ItemOffice()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Bureau"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Office"], 10)}
}

function Get_WinCRUAddress_CmbType_ItemSecondHome()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Résidence secondaire"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Second Home"], 10)}
}

function Get_WinCRUAddress_CmbType_ItemHMSHousehold()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Relations HMS"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "HMS Household"], 10)}
}
//--->  fin MenuEdit_Get_functions



//--->  MenuEdit_Get_functions
//************************************** FENÊTRE AJOUTER/MODIFIER UN NUMÉRO DE TÉLÉPHONE (ADD/EDIT A TELEPHONE NUMBER) ******************************************
//Edit --> Info --> Tad Adresse
function Get_WinCRUTelephone(){return Aliases.CroesusApp.winCRUTelephone}

function Get_WinCRUTelephone_LblType(){return Get_WinCRUTelephone().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinCRUTelephone_CmbType(){return Get_WinCRUTelephone().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinCRUTelephone_LblNumber(){return Get_WinCRUTelephone().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinCRUTelephone_TxtNumber(){return Get_WinCRUTelephone().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinCRUTelephone_BtnOK(){return Get_WinCRUTelephone().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinCRUTelephone_BtnCancel(){return Get_WinCRUTelephone().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}
//--->  fin MenuEdit_Get_functions




//--->   MenuEdit_Get_functions
////************************************** FENÊTRE AJOUTER/MODIFIER/CONSULTER UNE NOTE (ADD/EDIT/DISPLAY A NOTE WINDOW) ***********************************
//Edit --> Info --> TabInfo --> Add (note) 
function Get_WinCRUANote(){return Aliases.CroesusApp.winCRUANote}

function Get_WinCRUANote_GrpNote(){return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Notes"], 10)}

function Get_WinCRUANote_TabGrid_DgvPredefinedSentences(){return Get_WinCRUANote().FindChild("Uid", "NoteSentenceDataGrid_ae74", 10)}

function Get_WinCRUANote_GrpNote_TxtNote(){return Get_WinCRUANote().FindChild("Uid", "TextBox_e970", 10)}// modification suite aux changements de UID-39

function Get_WinCRUANote_BtnAddPredefinedSentences(){return Get_WinCRUANote().FindChild("Uid", "Button_f802", 10)}

function Get_WinCRUANote_BtnCopyPredefinedSentences(){return Get_WinCRUANote().FindChild("Uid", "Button_017b", 10)}

function Get_WinCRUANote_BtnEditPredefinedSentences(){return Get_WinCRUANote().FindChild("Uid", "Button_4cfb", 10)}

function Get_WinCRUANote_BtnDeletePredefinedSentences(){return Get_WinCRUANote().FindChild("Uid", "Button_eadf", 10)}

function  Get_WinCRUANote_GrpNote_RdoSelectedPositions(){return Get_WinCRUANote().FindChild("Uid", "RadioButton_19b4", 10)} //ok

function  Get_WinCRUANote_GrpNote_ChkReview(){return Get_WinCRUANote().FindChild("Uid", "CheckBox_5af6", 10)} //ok

function  Get_WinCRUANote_GrpNote_BtnAddSentence(){return Get_WinCRUANote().FindChild("Uid", "Button_d629", 10)} //ok

function  Get_WinCRUANote_GrpNote_BtnDateTime(){return Get_WinCRUANote().FindChild("Uid", "Button_4da0", 10)} //ok

/**  Fenêtre Add New Sentence    ***/
function Get_WinAddNewSentence(){return Aliases.CroesusApp.winAddNewSentence}

function Get_WinAddNewSentence_TxtName(){return Get_WinAddNewSentence().FindChild("Uid", "LocaleTextbox_4985", 10)}

function Get_WinAddNewSentence_TxtSentence(){return Get_WinAddNewSentence().FindChild("Uid", "LocaleTextbox_cabb", 10)}

function Get_WinAddNewSentence_BtnSave(){return Get_WinAddNewSentence().FindChild("Uid", "Button_6e0f", 10)}

function Get_WinAddNewSentence_BtnCancel(){return Get_WinAddNewSentence().FindChild("Uid", "Button_8134", 10)}

/***** Fenêtre  Edit Sentence***/
function Get_WinEditSentence(){return Aliases.CroesusApp.winEditSentence}

function Get_WinEditSentence_TxtName(){return Get_WinEditSentence().FindChild("Uid", "LocaleTextbox_4985", 10)}

function Get_WinEditSentence_TxtSentence(){return Get_WinEditSentence().FindChild("Uid", "LocaleTextbox_cabb", 10)}

function Get_WinEditSentence_BtnSave(){return Get_WinEditSentence().FindChild("Uid", "Button_6e0f", 10)}

function Get_WinEditSentence_BtnCancel(){return Get_WinEditSentence().FindChild("Uid", "Button_8134", 10)}

/*******************************Consulter une note View a note********************************************************************************/
//Edit --> Info --> TabInfo --> Cliquer sur le btn Display
function Get_WinNoteDetail(){return Aliases.CroesusApp.winNoteDetail}

function Get_WinNoteDetail_TxtCreationDateForPositionAndSecurity(){return Get_WinNoteDetail().FindChild("Uid", "TextBox_20b4", 10)}

function Get_WinNoteDetail_TxtPositionForPositionAndSecurity(){return Get_WinNoteDetail().FindChild("Uid", "TextBox_a079", 10)}

function Get_WinNoteDetail_TxtCreatedByForPositionAndSecurity(){return Get_WinNoteDetail().FindChild("Uid", "TextBox_053b", 10)}

/*********************************************************************************************************************************************/
function Get_WinCRUANote_LblClient()
{
  if (language == "french"){return Get_WinCRUANote().FindChild(["ClrClassName", "Text"], ["UniLabel", "Client :"], 10)}
  else {return Get_WinCRUANote().FindChild(["ClrClassName", "Text"], ["UniLabel", "Client:"], 10)}
}

function Get_WinCRUANote_LblAccount()
{
  if (language == "french"){return Get_WinCRUANote().FindChild(["ClrClassName", "Text"], ["UniLabel", "Compte:"], 10)}
  else {return Get_WinCRUANote().FindChild(["ClrClassName", "Text"], ["UniLabel", "Account:"], 10)}
}

function Get_WinCRUANote_TxtClientOrAccount(){return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinCRUANote_LblCreationDate()
{
  if (language == "french"){return Get_WinCRUANote().FindChild(["ClrClassName", "Text"], ["UniLabel", "Date de création :"], 10)}
  else {return Get_WinCRUANote().FindChild(["ClrClassName", "Text"], ["UniLabel", "Creation Date:"], 10)}
}

function Get_WinCRUANote_TxtCreationDate(){return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}

function Get_WinCRUANote_LblCreatedBy()
{
  if (language == "french"){return Get_WinCRUANote().FindChild(["ClrClassName", "Text"], ["UniLabel", "Créée par :"], 10)}
  else {return Get_WinCRUANote().FindChild(["ClrClassName", "Text"], ["UniLabel", "Created By:"], 10)}
}

function Get_WinCRUANote_TxtCreatedBy(){return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}

//function Get_WinCRUANote_BtnOK(){return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinCRUANote_BtnSave(){return Get_WinCRUANote().FindChild("Uid", "Button_eb1f", 10)}//Modification du fonction get suite changements de UID et aussi le nom du bouton a changé avant c'étais OK et maintenant c'est Save'

function Get_WinCRUANote_BtnClose(){return Get_WinCRUANote().FindChild("Uid", "Button_284a", 10)}

function Get_WinCRUANote_BtnCancel()
{
  if (language == "french"){return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinCRUANote_BtnCancel1()
{
  if (language == "french"){return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Annuler"], 10)}
  else {return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Cancel"], 10)}
}

function Get_WinCRUANote_GrpPredefinedSentences()
{
  if (language == "french"){return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Phrases prédéfinies"], 10)}
  else {return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Predefined Sentences"], 10)}
}


function Get_WinCRUANote_GrpPredefinedSentences1()
{
  if (language == "french"){return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlText"], ["GroupBox", "Phrases prédéfinies"], 10)}
  else {return Get_WinCRUANote().FindChild(["ClrClassName", "WPFControlText"], ["GroupBox", "Predefined Sentences"], 10)}
}

function Get_WinCRUANote_LvwPredefinedSentences(){return Get_WinCRUANote_GrpPredefinedSentences().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"], 10)}

function Get_WinCRUANote_TxtNewPredefinedSentence(){return Get_WinCRUANote_GrpPredefinedSentences().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinCRUANote_GrpPredefinedSentences_BtnAdd()
{
  if (language == "french"){return Get_WinCRUANote_GrpPredefinedSentences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Aj_outer"], 10)}
  else {return Get_WinCRUANote_GrpPredefinedSentences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "A_dd"], 10)}
}

function Get_WinCRUANote_GrpPredefinedSentences_BtnEdit()
{
  if (language == "french"){return Get_WinCRUANote_GrpPredefinedSentences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Mo_difier"], 10)}
  else {return Get_WinCRUANote_GrpPredefinedSentences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Edit"], 10)}
}

function Get_WinCRUANote_GrpPredefinedSentences_BtnDelete()
{
  if (language == "french"){return Get_WinCRUANote_GrpPredefinedSentences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
  else {return Get_WinCRUANote_GrpPredefinedSentences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"], 10)}
}


function Get_WinCRUANote_GrpPredefinedSentences_BtnDelete1()
{
  if (language == "french"){return Get_WinCRUANote_GrpPredefinedSentences1().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Supprimer"], 10)}
  else {return Get_WinCRUANote_GrpPredefinedSentences1().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Delete"], 10)}
}

function Get_WinCRUANote_BtnAddSentence()
{
  if (language == "french"){return Get_WinCRUANote().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Ajouter la phrase"], 10)}
  else {return Get_WinCRUANote().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Add Sentence"], 10)}
}

function Get_WinCRUANote_TxtCreationDateForPositionAndSecurity(){return Get_WinCRUANote().FindChild("Uid", "TextBox_20b4", 10)}

function Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(){return Get_WinCRUANote().FindChild("Uid", "DateField_da48", 10)}

function Get_WinCRUANote_TxtPositionForPositionAndSecurity(){return Get_WinCRUANote().FindChild("Uid", "TextBox_a079", 10)}

function Get_WinCRUANote_TxtCreatedByForPositionAndSecurity(){return Get_WinCRUANote().FindChild("Uid", "TextBox_053b", 10)}
//---> fin  MenuEdit_Get_functions




//--->  MenuEdit_Get_functions
/************************ FENÊTRE ACTIVITÉS DU CLIENT, DU COMPTE ET DE LA RELATION (CLIENT/ACCOUNT/RELATIONSHIP ACTIVITIES WINDOW) ************************/
//Fenêtre commune aux modules : Clients, Comptes et Relations
//Edit --> Functions --> Acrivities 

function Get_WinActivities(){return Aliases.CroesusApp.winActivities}

function Get_WinActivities_BtnClose(){return Get_WinActivities().FindChild("Uid", "Button_24bb", 10)}

function Get_WinActivities_GrpActivities(){return Get_WinActivities().FindChild("Uid", "GroupBox_d06b", 10)}

function Get_WinActivities_GrpActivities_BtnClearFilters(){return Get_WinActivities_GrpActivities().FindChild("Uid", "Button_0fd4", 10)}


function Get_WinActivities_GrpActivities_GrpDate(){return Get_WinActivities_GrpActivities().FindChild("Uid", "GroupBox_49a0", 10)}

function Get_WinActivities_GrpActivities_GrpDate_DtpFrom(){return Get_WinActivities_GrpActivities_GrpDate().FindChild("Uid", "DateField_589a", 10)}

function Get_WinActivities_GrpActivities_GrpDate_DtpTo(){return Get_WinActivities_GrpActivities_GrpDate().FindChild("Uid", "DateField_3019", 10)}

function Get_WinActivities_GrpActivities_GrpDate_CmbPeriodSelector(){return Get_WinActivities_GrpActivities_GrpDate().FindChild("Uid", "ComboBox_e90b", 10)}


function Get_WinActivities_GrpActivities_GrpKeywords(){return Get_WinActivities_GrpActivities().FindChild("Uid", "GroupBox_84fc", 10)}

function Get_WinActivities_GrpActivities_GrpKeywords_TxtKeywords(){return Get_WinActivities_GrpActivities_GrpKeywords().FindChild("Uid", "TextBox_6cc3", 10)}


function Get_WinActivities_GrpActivities_GrpActivityType(){return Get_WinActivities_GrpActivities().FindChild("Uid", "GroupBox_df21", 10)}

function Get_WinActivities_GrpActivities_GrpActivityType_CmbActivityType(){return Get_WinActivities_GrpActivities_GrpActivityType().FindChild("Uid", "ComboBox_2d33", 10)}


function Get_WinActivities_GrpActivities_GrpCurrentContext(){return Get_WinActivities_GrpActivities().FindChild("Uid", "GroupBox_877e", 10)}

function Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems(){return Get_WinActivities_GrpActivities_GrpCurrentContext().FindChild("Uid", "CheckBox_d00c", 10)}


function Get_WinActivities_GrpActivities_ChDate(){return Get_WinActivities_GrpActivities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date"], 10)}

function Get_WinActivities_GrpActivities_ChType(){return Get_WinActivities_GrpActivities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_WinActivities_GrpActivities_ChSource(){return Get_WinActivities_GrpActivities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Source"], 10)}

function Get_WinActivities_GrpActivities_ChName()
{
  if (language == "french"){return Get_WinActivities_GrpActivities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinActivities_GrpActivities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinActivities_GrpActivities_ChCreatedBy()
{
  if (language == "french"){return Get_WinActivities_GrpActivities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Créée par"], 10)}
  else {return Get_WinActivities_GrpActivities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Created by"], 10)}
}

function Get_WinActivities_GrpActivities_ChDescription(){return Get_WinActivities_GrpActivities().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_WinActivities_LstActivities(){return Get_WinActivities().FindChild("Uid", "ActivitiesList_e025", 10)}

function Get_WinActivities_DetailsExpander(){return Get_WinActivities().FindChild("Uid", "Expander_067a", 10)}

function Get_WinActivities_DetailsExpander_TxtSource(){return Get_WinActivities_DetailsExpander().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox", "1"], 10)} //no uid

function Get_WinActivities_DetailsExpander_TxtEffectiveDate(){return Get_WinActivities_DetailsExpander().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox", "2"], 10)} //no uid

function Get_WinActivities_DetailsExpander_TxtCreationDate(){return Get_WinActivities_DetailsExpander().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox", "3"], 10)} //no uid

function Get_WinActivities_DetailsExpander_TxtUpdateDate(){return Get_WinActivities_DetailsExpander().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox", "4"], 10)} //no uid

function Get_WinActivities_DetailsExpander_TxtCreatedByDate(){return Get_WinActivities_DetailsExpander().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox", "5"], 10)} //no uid

function Get_WinActivities_DetailsExpander_TxtDescription(){return Get_WinActivities_DetailsExpander().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox", "6"], 10)} //no uid


function Get_WinActivities_DetailsExpander_LlbSource()
{
  if (language == "french"){return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Source:"], 10)}
  else {return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Source:"], 10)}
}

function Get_WinActivities_DetailsExpander_LlbEffectiveDate()
{
  if (language == "french"){return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Effective Date:"], 10)}
  else {return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Effective Date:"], 10)}
}


function Get_WinActivities_DetailsExpander_LlbCreationDate()
{
  if (language == "french"){return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Date de création:"], 10)}
  else {return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Creation Date:"], 10)}
}


function Get_WinActivities_DetailsExpander_LlbUpdateDate()
{
  if (language == "french"){return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Date de mise à jour:"], 10)}
  else {return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Update Date:"], 10)}//
}

function Get_WinActivities_DetailsExpander_LlbCreatedBy()
{
  if (language == "french"){return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Crée par:"], 10)}
  else {return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Created by:"], 10)}
}

function Get_WinActivities_DetailsExpander_LlbDescription()
{
  if (language == "french"){return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Description:"], 10)}
  else {return DetailsExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Description:"], 10)}
}

/************************* CLIENTS/RELATIONSHIPS/ACCOUNTS SUM WINDOW (FENÊTRE SOMMATION CLIENTS/RELATIONS/COMPTES) *****************************/
//Ci-dessous les parties communes (même Uid) aux modules Clients, Relations et Comptes 
//Edit --> Sum
function Get_WinRelationshipsClientsAccountsSum(){return Aliases.CroesusApp.winRelationshipsClientsAccountsSum}

function Get_WinRelationshipsClientsAccountsSum_BtnClose(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "Button_8845", 10)}

/******************************** MODULE MODELES BTN ASSIGN, MODULE RELATIONSHIPS BTN JOIN, MODULES CLIENTS/ACCOUNTS JOIN TO RELATIONSHIPS *****************************************/
//La fenêtre où on choisit les relations, les clients ou les comptes à assigner au modèle/à la relation
//Edit--> Assign

function Get_WinPickerWindow(){return Aliases.CroesusApp.winPickerWindow} 

function Get_WinPickerWindow_DgvElements(){return Get_WinPickerWindow().FindChild("Uid", "DataGrid_f076", 10)}

function Get_WinPickerWindow_BtnOK(){return Get_WinPickerWindow().FindChild("Uid", "Button_8685", 10)}

function Get_WinPickerWindow_BtnCancel(){return Get_WinPickerWindow().FindChild("Uid", "Button_a877", 10)}

function Get_WinPickerWindow_ChName()
{
  if (language == "french"){return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinPickerWindow_ChFullName()
{
  if (language == "french"){return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom complet"], 10)}
  else {return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Full Name"], 10)}
}

function Get_WinPickerWindow_ChType(){return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

//Pour l'assignation de relations à un modèle
function Get_WinPickerWindow_ChRelationshipNo()
{
  if (language == "french"){return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No relation"], 10)}
  else {return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Relationship No."], 10)}
}

//Pour l'assignation de clients à un modèle
function Get_WinPickerWindow_ChRootNo()
{
  if (language == "french"){return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No Racine"], 10)}
  else {return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Root No."], 10)}
}

function Get_WinPickerWindow_ChClientNo()
{
  if (language == "french"){return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No client"], 10)}
  else {return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Client No."], 10)}
}

//Pour l'assignation de comptes à un modèle
function Get_WinPickerWindow_ChAccountNo()
{
  if (language == "french"){return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No compte"], 10)}
  else {return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

//Pour l'association de comptes à un modèle
function Get_WinPickerWindow_ChModelNo()
{
  if (language == "french"){return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No de modèle"], 10)}
  else {return Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Model No."], 10)}
}

//************************************ FENÊTRE SÉLECTION D'UN OBJECTIF (SELECT AN OBJECTIVE WINDOW) *********************************
//Edit--> Funtions--> Info --> Tab Investment objective --> icon btn
function Get_WinSelectAnObjective(){return Aliases.CroesusApp.winSelectAnObjective}

function Get_WinSelectAnObjective_BtnOK(){return Get_WinSelectAnObjective().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinSelectAnObjective_BtnCancel()
{
  if (language == "french"){return Get_WinSelectAnObjective().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinSelectAnObjective().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}


function Get_WinSelectAnObjective_TvwObjectives(){return Get_WinSelectAnObjective().FindChild("Uid", "TreeView_f006", 10)}

//RÉPARTITIONS GLOBALES

function Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations(){return Get_WinSelectAnObjective_TvwObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "1"], 10)}

//De base

function Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic(){return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "1"], 10)}

function Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal(){return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "1"], 10)}

function Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_Balanced()
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "3"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Equilibre"], 10)}
  else {return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Balanced"], 10)}
}

function Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_Growth()
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Croissance"], 10)}
  else {return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "2"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Growth"], 10)}
}

function Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_IncomeAndGrowth()
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "4"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Revenu et croissance"], 10)}
  else {return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "3"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Income and Growth"], 10)}
}

function Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_MaximumGrowth()
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "2"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Croissance maximale"], 10)}
  else {return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "4"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Maximum Growth"], 10)}
}

function Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_MaximumIncome()
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "5"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Revenu maximum"], 10)}
  else {return Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "5"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Maximum Income"], 10)}
}

//RÉPARTITIONS Firm Asset Allocations
//De la firme

function Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations(){return Get_WinSelectAnObjective_TvwObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "2"], 10)}//YR: Adaptation pour AT 

function Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm()
{
    if (client == "US"){return  Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", 3], 10)}//YR: il faut valider pour US
    else {return  Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", 1], 10)}
}

function Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives(){return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "1"], 10)}

function Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_Balanced()
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "4"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Equilibre"], 10)}
  else {return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Balanced"], 10)}
}

function Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_CroissancePlus() //Terme "Croissance PLus" non traduit ; rectifier une fois fixé.
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "2"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Croissance Plus"], 10)}
  else {return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "2"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Croissance Plus"], 10)}
}

function Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_Growth()
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Croissance"], 10)}
  else {return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "3"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Growth"], 10)}
}

function Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_IncomeAndGrowth()
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "5"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Revenu et croissance"], 10)}
  else {return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "4"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Income and Growth"], 10)}
}

function Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_MaximumGrowth()
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "3"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Croissance maximale"], 10)}
  else {return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "5"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Maximum Growth"], 10)}
}

function Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives_MaximumIncome()
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "6"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Revenu maximum"], 10)}
  else {return Get_WinSelectAnObjective_TvwObjectives_ItemFirmAssetAllocations_ItemFirm_ItemFirmObjectives().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeViewItem", "6"], 10).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Maximum Income"], 10)}
}



function Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations()
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives().FindChild(["ClrClassName", "IsVisible", "DataContext.Text"], ["TreeViewItem", true, "Mes répartitions"])}
  else {return Get_WinSelectAnObjective_TvwObjectives().FindChild(["ClrClassName", "IsVisible", "DataContext.Text"], ["TreeViewItem", true, "My Asset Allocations"])}
}

function Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem(myAssetAllocationsItemName){return Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations().FindChild(["ClrClassName", "IsVisible", "DataContext.Text"], ["TreeViewItem", true, myAssetAllocationsItemName])}

function Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem_TvwMyObjectives(myAssetAllocationsItemName)
{
  if (language == "french"){return Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem(myAssetAllocationsItemName).FindChild(["ClrClassName", "IsVisible", "DataContext.Text"], ["TreeViewItem", true, "Mes objectifs"])}
  else {return Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem(myAssetAllocationsItemName).FindChild(["ClrClassName", "IsVisible", "DataContext.Text"], ["TreeViewItem", true, "My objectives"])}
}

function Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem_TvwMyObjectives_TvwMyObjectivesItem(myAssetAllocationsItemName, myObjectivesItemName){
    return Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem_TvwMyObjectives(myAssetAllocationsItemName).FindChild(["ClrClassName", "IsVisible", "DataContext.Text"], ["TreeViewItem", true, myObjectivesItemName])}
//--> fin  MenuEdit_Get_Functions

//****************************************** EDIT SEGMENTATION WINDOW (FENÊTRE MODIFIER LA SEGMENTATION) ******************************************
//Edit--> Functions--> Edit segmentation 
function Get_WinEditSegmentation(){return Aliases.CroesusApp.winEditSegmentation}

function Get_WinEditSegmentation_BtnOK(){return Get_WinEditSegmentation().FindChild("Uid", "Button_2805", 10)}

function Get_WinEditSegmentation_BtnCancel(){return Get_WinEditSegmentation().FindChild("Uid", "Button_0234", 10)}

function Get_WinEditSegmentation_LblSegmentation(){return Get_WinEditSegmentation().FindChild("Uid", "TextBlock_fbf2", 10)}

function Get_WinEditSegmentation_CmbSegmentation(){return Get_WinEditSegmentation().FindChild("Uid", "ComboBox_d92b", 10)}

function Get_WinEditSegmentation_GrpApplyOn(){return Get_WinEditSegmentation().FindChild("Uid", "GroupBox_5ea7", 10)}

function Get_WinEditSegmentation_GrpApplyOn_RdoActiveRelationshipOrClient(){return Get_WinEditSegmentation_GrpApplyOn().FindChild("Uid", "RadioButton_768a", 10)}

function Get_WinEditSegmentation_GrpApplyOn_RdoSelectedRelationshipsOrClients(){return Get_WinEditSegmentation_GrpApplyOn().FindChild("Uid", "RadioButton_bb78", 10)}

//--> fin  MenuEdit_Get_Functions