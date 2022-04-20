//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/******************************************* RELATIONSHIPS GRID ************************************************/

//Entêtes de colonne de la grille des relations (Relationships grid Column headers)

function Get_RelationshipsGrid_ChNoteIcon(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}

function Get_RelationshipsGrid_ChName()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_RelationshipsGrid_ChRelationshipNo()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No relation"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Relationship No."], 10)}
}

function Get_RelationshipsGrid_ChIACode()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_RelationshipsGrid_ChBalance()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance"], 10)}
}

function Get_RelationshipsGrid_ChCurrency()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_RelationshipsGrid_ChMargin()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Marge"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Margin"], 10)}
}
// Ajout la fonction get pour Billable spécifique pour la US 90-04-50
function Get_RelationshipsGrid_ChBillable()
{
  if (language=="french"){Log.Warning("Le nom du champ Billable n'existe pas en français puisque ce champ est spécifique a US et pour la US on se connecte juste en anglais ")}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Billable"], 10)}
}

function Get_RelationshipsGrid_ChTotalValue()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value"], 10)}
}

function Get_RelationshipsGrid_ChAlternateName()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom substitutif"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Alternate Name"], 10)}
}

function Get_RelationshipsGrid_ChCommunication(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Communication"], 10)}

function Get_RelationshipsGrid_ChCreation()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de création"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creation"], 10)}
}

function Get_RelationshipsGrid_ChEmail1()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Courriel 1"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Email 1"], 10)}
}

function Get_RelationshipsGrid_ChEmail2()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Courriel 2"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Email 2"], 10)}
}

function Get_RelationshipsGrid_ChEmail3()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Courriel 3"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Email 3"], 10)}
}

function Get_RelationshipsGrid_ChFullName()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom complet"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Full Name"], 10)}
}

function Get_RelationshipsGrid_ChLanguage()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Langue"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Language"], 10)}
}

function Get_RelationshipsGrid_ChLastUpdate()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mise à jour"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Updated on"], 10)}
}

function Get_RelationshipsGrid_ChRepresentative()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interlocuteur"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Representative"], 10)}
}

function Get_RelationshipsGrid_ChSalutationName()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Formule d'appel"], 10)}//CROES-8307 
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Salutation"], 10)}
}

function Get_RelationshipsGrid_ChSegmentation(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Segmentation"], 10)}

function Get_RelationshipsGrid_ChType(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_RelationshipsGrid_ChModelName()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom modèle"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Model Name"], 10)}
}

function Get_RelationshipsGrid_ChModelNumber()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No modèle"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Model Number"], 10)}
}

function Get_RelationshipsGrid_ChFrequency()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fréquence"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Frequency"], 10)}
}

function Get_RelationshipsGrid_ChNextReview()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Proch. révision"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Next Review"], 10)}
}

function Get_RelationshipsGrid_ChClosingDate()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de fermeture"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Closing Date"], 10)}
}

function Get_RelationshipsGrid_ChLastReview()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dern. révision"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Review"], 10)}
}

function Get_RelationshipsGrid_ChDiscretionary()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discrétionnaire"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discretionary"], 10)}
}

function Get_RelationshipsGrid_ChEmployer()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Employeur"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Employer"], 10)}
}

function Get_RelationshipsGrid_ChCommission(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Commission"], 10)}

function Get_RelationshipsGrid_ChStatus()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "État"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

function Get_RelationshipsGrid_ChManagementLevel()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Niveau de gestion"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Management Level"], 10)}
}

//Menu contextuel des items des colonnes/champs

function Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Language(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "LanguageDescription"], 10)}

function Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Communication(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "CommunicationMethodDisplay"], 10)}

function Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_DateOfBirth(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "BirthDate"], 10)}

function Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_FullName(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "FullName"], 10)}

function Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_LastReview(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "ReviewDate"], 10)}
 
function Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_NextReview(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "NextReviewDate"], 10)}
  
function Get_RelationshipsGrid_ColumnHeader_ContextualMenuItem_Frequency(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Name"], ["MenuItem", "ReviewFrequencyDescription"], 10)}


//Menu contextuel sur le grid (Contextual menu on the grid)
//Les fonctions Get communes à Relations/Clients/Comptes sont dans Common_Get_functions

function Get_RelationshipsGrid_ContextualMenu_Info(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_14bc", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_Info(){return Get_CroesusApp().FindChild("Uid", "MenuItem_82f4", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_Notes(){return Get_CroesusApp().FindChild("Uid", "MenuItem_e23a", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_Addresses(){return Get_CroesusApp().FindChild("Uid", "MenuItem_0338", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_Telephons(){return Get_CroesusApp().FindChild("Uid", "MenuItem_b1a2", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_Email(){return Get_CroesusApp().FindChild("Uid", "MenuItem_64c5", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_ProductsAndServices(){return Get_CroesusApp().FindChild("Uid", "MenuItem_b4aa", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_InvestmentObjective(){return Get_CroesusApp().FindChild("Uid", "MenuItem_0d57", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_DefaultReports(){return Get_CroesusApp().FindChild("Uid", "MenuItem_c71b", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_DefaultIndices(){return Get_CroesusApp().FindChild("Uid", "MenuItem_b29e", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_Profiles(){return Get_CroesusApp().FindChild("Uid", "MenuItem_a267", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_UnderlyingAccounts(){return Get_CroesusApp().FindChild("Uid", "MenuItem_ae2b", 10)}

function Get_RelationshipsGrid_ContextualMenu_Info_Documents(){return Get_CroesusApp().FindChild("Uid", "MenuItem_da34", 10)}


function Get_RelationshipsGrid_ContextualMenu_Add_AddNewRelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_f76c", 10)}

function Get_RelationshipsGrid_ContextualMenu_Add_JoinRelationships(){return Get_CroesusApp().FindChild("Uid", "MenuItem_e3ad", 10)}

function Get_RelationshipsGrid_ContextualMenu_Add_JoinClients(){return Get_CroesusApp().FindChild("Uid", "MenuItem_2ec3", 10)}

function Get_RelationshipsGrid_ContextualMenu_Add_JoinAccounts(){return Get_CroesusApp().FindChild("Uid", "MenuItem_e4b6", 10)}

function Get_RelationshipsGrid_ContextualMenu_Add_JoinToAGroupedRelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_149b", 10)}


function Get_RelationshipsAccountsGrid_ContextualMenu_Relationship_JoinToAGroupedRelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_01a3", 10)}


function Get_RelationshipsGrid_ContextualMenu_SortBy_RelationshipNo()
{
  if (language=="french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "No relation"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Relationship No."], 10)}
}

function Get_RelationshipsGrid_ContextualMenu_Functions_Info(){return Get_CroesusApp().FindChild("Uid", "MenuItem_2cbf", 10)}


//WIN Info : LISTVIEW CONTROL

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_BtnRepresentativeForRelationship_DgvListView(){return Get_WinClients().FindChild("Uid", "FixedColumnListView_1b3e", 10)}


/*********************************** RELATIONSHIPS DETAILS (DÉTAILS RELATIONS) ******************************************/

//Info tab (Onglet Info)

function Get_RelationshipsDetails_TabInfo(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TabItem_b8a0", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "ScrollViewer_8118", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_LblInvestmentObjective(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_39fe", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_LblFollowUp(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_b56b", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_LblSegmentation(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_f547", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_LblContactPerson(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_d3e4", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_LblAccountManager(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_71dc", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_LblCommunication(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_335f", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_LblAmounts(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_c453", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_LblBalance(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_bc0d", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_LblTotalValue(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_e186", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_LblMargin(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_89c1", 10)}


function Get_RelationshipsDetails_TabInfo_TxtFullName(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "InfoPage_f5b9", 10).FindChild("Uid", "TextBox_33ab", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtInvestmentObjective(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_d904", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtSegmentation(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_56aa", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtContactPerson(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_741e", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtAccountManager(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_697f", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtCommunication(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_9149", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtBalance(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_0506", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtTotalValue(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_0dab", 10)}

function Get_RelationshipsDetails_TabInfo_ScrollViewer_TxtMargin(){return Get_RelationshipsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_94a8", 10)}


//Products and Services tab (Onglet Produits et services)

function Get_RelationshipsDetails_TabProductsAndServices(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TabItem_8f62", 10)}

function Get_RelationshipsDetails_TabProductsAndServices_DgvProducts(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "ProductsDataGrid_f561", 10)}

function Get_RelationshipsDetails_TabProductsAndServices_DgvServices(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "ServicesDataGrid_90f4", 10)}


//Profile tab (Onglet Profil)

function Get_RelationshipsDetails_TabProfile(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TabItem_561e", 10)}

function Get_RelationshipsDetails_TabProfile_DefaultExpander()
{
    if (language == "french"){return Get_RelationshipsClientsAccountsDetails().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "Défaut"], 10)}
    else {return Get_RelationshipsClientsAccountsDetails().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "Default"], 10)}
}

function Get_RelationshipsDetails_TabProfile_DefaultExpander_LblLanguage()
{
    if (language == "french"){return Get_RelationshipsDetails_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Langue"], 10)}
    else {return Get_RelationshipsDetails_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Language"], 10)}
}

function Get_RelationshipsDetails_TabProfile_DefaultExpander_LblHENRY()
{
    if (language == "french"){return Get_RelationshipsDetails_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "HENRY"], 10)}
    else {return Get_RelationshipsDetails_TabProfile_DefaultExpander().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "HENRY"], 10)}
}


//Documents tab (Onglet Documents)

function Get_RelationshipsDetails_TabDocuments(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TabItem_2cf8", 10)}


/**************************************** RELATIONSHIPS BAR BUTTONS *****************************************/
//Les boutons communs aux trois modules Relations/Clients/Comptes (mêmes Uids) sont dans Common_Get_functions
//(Get_RelationshipsClientsAccountsBar(), Get_RelationshipsClientsAccountsBar_BtnPerformance(), Get_RelationshipsAccountsBar_BtnRestrictions(), Get_RelationshipsClientsAccountsBar_BtnActivities())

function Get_RelationshipsBar_BtnInfo(){return Get_RelationshipsClientsAccountsBar().FindChild("Uid", "SplitDropDownButton_2a09", 10)}


//Liste déroulante du bouton Info de la barre de Relations

function Get_RelationshipsBar_BtnInfo_ItemInfo(){return Get_CroesusApp().FindChild("Uid", "MenuItem_64a4", 10)}

function Get_RelationshipsBar_BtnInfo_ItemNotes(){return Get_CroesusApp().FindChild("Uid", "MenuItem_09e1", 10)}

function Get_RelationshipsBar_BtnInfo_ItemAddresses(){return Get_CroesusApp().FindChild("Uid", "MenuItem_0a1d", 10)}

function Get_RelationshipsBar_BtnInfo_ItemTelephons(){return Get_CroesusApp().FindChild("Uid", "MenuItem_08d0", 10)}

function Get_RelationshipsBar_BtnInfo_ItemEmail(){return Get_CroesusApp().FindChild("Uid", "MenuItem_dd40", 10)}

function Get_RelationshipsBar_BtnInfo_ItemProductsAndServices(){return Get_CroesusApp().FindChild("Uid", "MenuItem_893d", 10)}

function Get_RelationshipsBar_BtnInfo_ItemInvestmentObjective(){return Get_CroesusApp().FindChild("Uid", "MenuItem_2d92", 10)}

function Get_RelationshipsBar_BtnInfo_ItemDefaultReports(){return Get_CroesusApp().FindChild("Uid", "MenuItem_90a9", 10)}

function Get_RelationshipsBar_BtnInfo_ItemDefaultIndices(){return Get_CroesusApp().FindChild("Uid", "MenuItem_bf9e", 10)}

function Get_RelationshipsBar_BtnInfo_ItemProfiles(){return Get_CroesusApp().FindChild("Uid", "MenuItem_01fe", 10)}

function Get_RelationshipsBar_BtnInfo_ItemUnderlyingAccounts(){return Get_CroesusApp().FindChild("Uid", "MenuItem_e5b5", 10)}

function Get_RelationshipsBar_BtnInfo_ItemDocuments(){return Get_CroesusApp().FindChild("Uid", "MenuItem_49ba", 10)}


//********************* RELATIONSHIPS QUICK SEARCH (RELATIONS - RECHERCHER) ***********************************

//Les parties communes aux différents modules (même Uid) sont dans Common_Get_functions
//(Get_WinQuickSearch(), Get_WinQuickSearch_BtnOK(), Get_WinQuickSearch_BtnCancel(), Get_WinQuickSearch_LblSearch(), Get_WinQuickSearch_TxtSearch(), Get_WinQuickSearch_LblIn())

function Get_WinRelationshipsQuickSearch_RdoRelationshipNo()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "LINKNUMBER - No relation"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "LINKNUMBER - Relationship No."], 10)}
}

function Get_WinRelationshipsQuickSearch_RdoName()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "SHORTNAME - Nom"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "SHORTNAME - Name"], 10)}
}

function Get_WinRelationshipsQuickSearch_RdoIACode()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "REPRESENTATIVENUMBER - Code de CP"], 10)} //Yr: Avant REPRESENTATIVEID
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "REPRESENTATIVENUMBER - IA Code"], 10)}
}

function Get_WinRelationshipsQuickSearch_RdoCurrency()
{
  if (language=="french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CURRENCY - Devise"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CURRENCY - Currency"], 10)}
}


/**************************************** RELATIONSHIPS SUM WINDOW (FENÊTRE SOMMATION RELATIONS) **********************************************/
//Les parties communes aux modules Clients, Relations et Comptes (même Uid) sont dans Common_Get_functions
//(Get_WinRelationshipsClientsAccountsSum(), Get_WinRelationshipsClientsAccountsSum_BtnClose())

function Get_WinRelationshipsSum_DgvDataGrid(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "DataGrid_a8c2", 10)}

function Get_WinRelationshipsSum_LblAssetUnderManagement(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "TextBlock_cb35", 10)}

function Get_WinRelationshipsSum_LblWarningMessage(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "TextBlock_f6cb", 10)}

function Get_WinRelationshipsSum_LblTotalValueForRelationships(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "2"], 10)}

function Get_WinRelationshipsSum_LblNumberOfRelationships(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "3"], 10)}

function Get_WinRelationshipsSum_LblTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "1"], 10)}

function Get_WinRelationshipsSum_TxtTotalValueForRelationshipsTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10)}

function Get_WinRelationshipsSum_TxtNumberOfRelationshipsTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10)}

/****************************** RELATIONSHIPS INFO WINDOW ******************************/

function Get_WinRelationshipInfo(){return Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient}

function Get_WinRelationshipInfo_GrpFollowUp()
{
  if (language=="french"){return Get_WinRelationshipInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Suivi"], 10)}
  else {return Get_WinRelationshipInfo().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Follow up"], 10)}
}

function Get_WinRelationshipInfo_GrpFollowUp_LblSegmentation(){return Get_WinRelationshipInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Label", "1"], 10)}

function Get_WinRelationshipInfo_GrpFollowUp_CmbSegmentation(){return Get_WinRelationshipInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinRelationshipInfo_GrpFollowUp_LblContactPerson(){return Get_WinRelationshipInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinRelationshipInfo_GrpFollowUp_CmbContactPerson(){return Get_WinRelationshipInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinRelationshipInfo_GrpFollowUp_LblAccountManager(){return Get_WinRelationshipInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinRelationshipInfo_GrpFollowUp_CmbAccountManager(){return Get_WinRelationshipInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinRelationshipInfo_GrpFollowUp_LblCommunication(){return Get_WinRelationshipInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinRelationshipInfo_GrpFollowUp_CmbCommunication(){return Get_WinRelationshipInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)}

function Get_WinRelationshipInfo_GrpFollowUp_CmbBoxItemNo(nbOrdrer){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBoxItem", nbOrdrer], 10)}

function Get_WinRelationshipInfo_GrpFollowUp_CheckBoxRepresentative(){return Get_WinRelationshipInfo_GrpFollowUp().FindChild("ClrClassName", "UniCheckBox", 10)}

function Get_WinRelationshipInfo_GrpFollowUp_TextFieldRepresentative(){return Get_WinRelationshipInfo_GrpFollowUp().FindChild("ClrClassName", "UniTextField", 10)}

function Get_WinRelationshipInfo_GrpFollowUp_ButtonRepresentative(){return Get_WinRelationshipInfo_GrpFollowUp().FindChild("ClrClassName", "UniButton", 10)}

/*************************************************************************************************/
/*************** Ajout de cette fonction car cette fonction a changé de info,2 à info,1 **********/
/*************** L'original de cette fonction est dans Common_Get_functions **********************/
function Get_MenuBar_Edit_FunctionsForRelationships_Info(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["MenuItem", "_Info", "1"], 100)}