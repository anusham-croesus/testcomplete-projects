//USEUNIT Common_Get_functions
//USEUNIT Global_variables


/**************************************** CLIENTS BAR BUTTONS *****************************************/
//Les boutons communs aux trois modules Relations/Clients/Comptes (mêmes Uids) sont dans Common_Get_functions
//(Get_RelationshipsClientsAccountsBar(), Get_RelationshipsClientsAccountsBar_BtnPerformance(), Get_RelationshipsAccountsBar_BtnRestrictions(), Get_RelationshipsClientsAccountsBar_BtnActivities())


function Get_ClientsBar_BtnInfo(){return Get_RelationshipsClientsAccountsBar().FindChild("Uid", "SplitDropDownButton_8022", 10)}


//Liste déroulante du bouton Info de la barre de Clients

function Get_ClientsBar_BtnInfo_ItemInfo(){return Get_CroesusApp().FindChild("Uid", "MenuItem_4d4d", 10)}

function Get_ClientsBar_BtnInfo_ItemNotes(){return Get_CroesusApp().FindChild("Uid", "MenuItem_34ca", 10)}

function Get_ClientsBar_BtnInfo_ItemAddresses(){return Get_CroesusApp().FindChild("Uid", "MenuItem_39da", 10)}

function Get_ClientsBar_BtnInfo_ItemTelephons(){return Get_CroesusApp().FindChild("Uid", "MenuItem_b6e8", 10)}

function Get_ClientsBar_BtnInfo_ItemEmail(){return Get_CroesusApp().FindChild("Uid", "MenuItem_ed44", 10)}

function Get_ClientsBar_BtnInfo_ItemAgenda(){return Get_CroesusApp().FindChild("Uid", "MenuItem_1871", 10)}

function Get_ClientsBar_BtnInfo_ItemProductsAndServices(){return Get_CroesusApp().FindChild("Uid", "MenuItem_9cf2", 10)}

function Get_ClientsBar_BtnInfo_ItemInvestmentObjective(){return Get_CroesusApp().FindChild("Uid", "MenuItem_5941", 10)}

function Get_ClientsBar_BtnInfo_ItemDefaultReports(){return Get_CroesusApp().FindChild("Uid", "MenuItem_4c93", 10)}

function Get_ClientsBar_BtnInfo_ItemDefaultIndices(){return Get_CroesusApp().FindChild("Uid", "MenuItem_3942", 10)}

function Get_ClientsBar_BtnInfo_ItemProfiles(){return Get_CroesusApp().FindChild("Uid", "MenuItem_b859", 10)}

function Get_ClientsBar_BtnInfo_ItemDocuments(){return Get_CroesusApp().FindChild("Uid", "MenuItem_c0ef", 10)}

function Get_ClientsBar_BtnInfo_ItemCostumerNetwork(){return Get_CroesusApp().FindChild("Uid", "MenuItem_1f65", 10)}

function Get_ClientsBar_BtnInfo_ItemCampaigns(){return Get_CroesusApp().FindChild("Uid", "MenuItem_8765", 10)}




/*************************************** CLIENTS GRID *******************************************/


//Entêtes de colonne de la grille des clients (Clients grid Column headers)

function Get_ClientsGrid_ChNoteIcon(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}

function Get_ClientsGrid_ChName()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_ClientsGrid_ChClientNo()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No client"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Client No."], 10)}
}

function Get_ClientsGrid_ChIACode()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_ClientsGrid_ChTelephone1()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 1"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 1"], 10)}
}

function Get_ClientsGrid_ChTelephone2()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 2"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 2"], 10)}
}

function Get_ClientsGrid_ChTelephone3()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 3"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 3"], 10)}
}

function Get_ClientsGrid_ChTelephone4()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Téléphone 4"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Telephone 4"], 10)}
}

function Get_ClientsGrid_ChBalance()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Solde"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Balance"], 10)}
}

function Get_ClientsGrid_ChCurrency()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Currency"], 10)}
}

function Get_ClientsGrid_ChMargin()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Marge"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Margin"], 10)}
}

function Get_ClientsGrid_ChLastContact()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dern. Communication"], 10)}//JIra: CROES-785 
  else { return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Communication"], 10)} //EM: 90-07-23-CO : selon Karima le Jira: CROES-785 est appliqué pour tous.
}

function Get_ClientsGrid_ChAge()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Âge"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Age"], 10)}
}

function Get_ClientsGrid_ChTotalValue()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value"], 10)}
}

function Get_ClientsGrid_ChCommunication(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Communication"], 10)}

function Get_ClientsGrid_ChCommission(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Commission"], 10)}

function Get_ClientsGrid_ChEmail1()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Courriel 1"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Email 1"], 10)}
}

function Get_ClientsGrid_ChEmail2()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Courriel 2"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Email 2"], 10)}
}

function Get_ClientsGrid_ChEmail3()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Courriel 3"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Email 3"], 10)}
}

function Get_ClientsGrid_ChDateOfBirth()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de naissance"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date of Birth"], 10)}
}

function Get_ClientsGrid_ChDiscretionary()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discrétionnaire"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discretionary"], 10)}
}

function Get_ClientsGrid_ChTotalNetValue()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Actif net"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Net Value"], 10)}
}

function Get_ClientsGrid_ChModelNumber()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No modèle"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Model Number"], 10)}
}

function Get_ClientsGrid_ChRepresentative()//"Interlocuteur" CROES-1742
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Interlocuteur"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Representative"], 10)}
}

function Get_ClientsGrid_ChLangue()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Langue"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Language"], 10)}
}

function Get_ClientsGrid_ChFullName()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom complet"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Full Name"], 10)}
}

function Get_ClientsGrid_ChSegmentation(){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Segmentation"], 10)}

function Get_ClientsGrid_ChTelType1()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type tél. 1"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Tel type 1"], 10)}
}

function Get_ClientsGrid_ChTelType2()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type tél. 2"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Tel type 2"], 10)}
}

function Get_ClientsGrid_ChTelType3()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type tél. 3"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Tel type 3"], 10)}
}

function Get_ClientsGrid_ChTelType4()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type tél. 4"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Tel type 4"], 10)}
}

function Get_ClientsGrid_ChModelName()//YR 90-04-44
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom modèle"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Model Name"], 10)}
}


function Get_ClientsGrid_ChClientRelationshipNo()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No relation client"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Client Relationship No."], 10)}
}

function Get_ClientsGrid_ChManagementLevel()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Niveau de gestion"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Management Level"], 10)}
}

function Get_ClientsGrid_ChStatus()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "État"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

//Menu contextuel sur le grid (Contextual menu on the grid)
//Les fonctions Get communes à Relations/Clients/Comptes sont dans Common_Get_functions

function Get_ClientsGrid_ContextualMenu_Info(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_4a49", 10)}

function Get_ClientsGrid_ContextualMenu_Info_Info(){return Get_CroesusApp().FindChild("Uid", "MenuItem_8128", 10)}

function Get_ClientsGrid_ContextualMenu_Info_Notes(){return Get_CroesusApp().FindChild("Uid", "MenuItem_bd19", 10)}

function Get_ClientsGrid_ContextualMenu_Info_Addresses(){return Get_CroesusApp().FindChild("Uid", "MenuItem_fba5", 10)}

function Get_ClientsGrid_ContextualMenu_Info_Telephons(){return Get_CroesusApp().FindChild("Uid", "MenuItem_38d4", 10)}

function Get_ClientsGrid_ContextualMenu_Info_Email(){return Get_CroesusApp().FindChild("Uid", "MenuItem_aa67", 10)}

function Get_ClientsGrid_ContextualMenu_Info_Agenda(){return Get_CroesusApp().FindChild("Uid", "MenuItem_352c", 10)}

function Get_ClientsGrid_ContextualMenu_Info_ProductsAndServices(){return Get_CroesusApp().FindChild("Uid", "MenuItem_a32a", 10)}

function Get_ClientsGrid_ContextualMenu_Info_InvestmentObjective(){return Get_CroesusApp().FindChild("Uid", "MenuItem_f40e", 10)}

function Get_ClientsGrid_ContextualMenu_Info_DefaultReports(){return Get_CroesusApp().FindChild("Uid", "MenuItem_d199", 10)}

function Get_ClientsGrid_ContextualMenu_Info_DefaultIndices(){return Get_CroesusApp().FindChild("Uid", "MenuItem_62cd", 10)}

function Get_ClientsGrid_ContextualMenu_Info_Profiles(){return Get_CroesusApp().FindChild("Uid", "MenuItem_9e66", 10)}

function Get_ClientsGrid_ContextualMenu_Info_Documents(){return Get_CroesusApp().FindChild("Uid", "MenuItem_b888", 10)}

function Get_ClientsGrid_ContextualMenu_Info_CostumerNetwork(){return Get_CroesusApp().FindChild("Uid", "MenuItem_d94e", 10)}

function Get_ClientsGrid_ContextualMenu_Info_Campaigns(){return Get_CroesusApp().FindChild("Uid", "MenuItem_9814", 10)}


function Get_ClientsGrid_ContextualMenu_Add_CreateFictitiousClient(){return Get_CroesusApp().FindChild("Uid", "MenuItem_19bd", 10)}

function Get_ClientsGrid_ContextualMenu_Add_CreateExternalClient(){return Get_CroesusApp().FindChild("Uid", "MenuItem_91a1", 10)}


function Get_ClientsGrid_ContextualMenu_CopyClientInformation(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_abcf", 10)}


function Get_ClientsGrid_ContextualMenu_SortBy_ClientNo()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "No client"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Client No."], 10)}
}


function Get_ClientsGrid_ContextualMenu_Functions_Info(){return Get_CroesusApp().FindChild("Uid", "MenuItem_4686", 10)}




/****************************************** CLIENTS DETAILS ***************************************************/


//Info tab (Onglet Info)

function Get_ClientsDetails_TabInfo(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TabItem_0c0d", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "ScrollViewer_b83d", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewerForRootsAccounts(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "ScrollViewer_ad79", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_LblInvestmentObjective(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_800f", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_TxtInvestmentObjective(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_599a", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_LblFollowUp(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_d300", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_LblSegmentation(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_8eb7", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_TxtSegmentation(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_f860", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_LblContactPerson(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_4ef2", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_TxtContactPerson(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_fbfe", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_LblAccountManager(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_29ff", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_TxtAccountManager(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_cae3", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_LblCommunication(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_d403", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_TxtCommunication(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_599d", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_LblAmounts(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_0e66", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_LblBalance(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_8cd7", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_TxtBalance(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_be79", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_TxtBalanceForRootsAccounts(){return Get_ClientsDetails_TabInfo_ScrollViewerForRootsAccounts().FindChild("Uid", "TextBox_97b8", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_LblTotalValue(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_b869", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_TxtTotalValueForRootsAccounts(){return Get_ClientsDetails_TabInfo_ScrollViewerForRootsAccounts().FindChild("Uid", "TextBox_c657", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_TxtTotalValue(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_6bd6", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_LblMargin(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_0bc7", 10)}

function Get_ClientsDetails_TabInfo_ScrollViewer_TxtMargin(){return Get_ClientsDetails_TabInfo_ScrollViewer().FindChild("Uid", "TextBox_e6e2", 10)}

function Get_ClientsDetails_TabInfo_InfoPage(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "InfoPage_d606", 10)}

function Get_ClientsDetails_TabInfo_InfoPage_TxtClientFullName(){return Get_ClientsDetails_TabInfo_InfoPage().FindChild("Uid", "TextBox_03b6", 10)}

function Get_ClientsDetails_TabInfo_InfoPage_TxtStreet1(){return Get_ClientsDetails_TabInfo_InfoPage().FindChild("Uid", "TextBox_dc5c", 10)}

function Get_ClientsDetails_TabInfo_InfoPage_TxtStreet2(){return Get_ClientsDetails_TabInfo_InfoPage().FindChild("Uid", "TextBox_698f", 10)}

function Get_ClientsDetails_TabInfo_InfoPage_TxtPostalCode(){return Get_ClientsDetails_TabInfo_InfoPage().FindChild("Uid", "TextBox_7679", 10)}

//Agenda tab (Onglet Agenda)

function Get_ClientsDetails_TabAgenda(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TabItem_49fc", 10)}

function Get_ClientsDetails_TabAgenda_DgvContactsData(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "ContactsDataGrid_d932", 10)}

function Get_ClientsDetails_TabAgenda_DgvContactsData_ChDate(){return Get_ClientsDetails_TabAgenda_DgvContactsData().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date"], 10)}

function Get_ClientsDetails_TabAgenda_DgvContactsData_ChTime()
{
    if (language == "french"){return Get_ClientsDetails_TabAgenda_DgvContactsData().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Heure"], 10)}
    else {return Get_ClientsDetails_TabAgenda_DgvContactsData().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Time"], 10)}
}

function Get_ClientsDetails_TabAgenda_DgvContactsData_ChDuration()
{
    if (language == "french"){return Get_ClientsDetails_TabAgenda_DgvContactsData().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Durée"], 10)}
    else {return Get_ClientsDetails_TabAgenda_DgvContactsData().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Duration"], 10)}
}

function Get_ClientsDetails_TabAgenda_DgvContactsData_ChType(){return Get_ClientsDetails_TabAgenda_DgvContactsData().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_ClientsDetails_TabAgenda_DgvContactsData_ChStatus()
{
    if (language == "french"){return Get_ClientsDetails_TabAgenda_DgvContactsData().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Statut"], 10)}
    else {return Get_ClientsDetails_TabAgenda_DgvContactsData().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

function Get_ClientsDetails_TabAgenda_DgvContactsData_ChDescription(){return Get_ClientsDetails_TabAgenda_DgvContactsData().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_ClientsDetails_TabAgenda_DgvContactsData_ChFrequency()
{
    if (language == "french"){return Get_ClientsDetails_TabAgenda_DgvContactsData().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fréquence"], 10)}
    else {return Get_ClientsDetails_TabAgenda_DgvContactsData().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Frequency"], 10)}
}


//Products and Services tab (Onglet Produits et services)

function Get_ClientsDetails_TabProductsAndServices(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TabItem_0216", 10)}

function Get_ClientsDetails_TabProductsAndServices_TpProductsAndServices(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "ProductsPage_9edb", 10)}

function Get_ClientsDetails_TabProductsAndServices_TpProductsAndServices_LblProducts(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TextBox_11cf", 10)}

function Get_ClientsDetails_TabProductsAndServices_TpProductsAndServices_LblServices(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TextBox_3bfd", 10)}


//Profile tab (Onglet Profil)

function Get_ClientsDetails_TabProfile(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TabItem_b4bf", 10)}

function Get_ClientsDetails_TabProfile_ItemControl(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "ItemsControl_b25d", 10)}

function Get_ClientsDetails_TabProfile_TpProfile(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "CategorisedProfilesPage_69e5", 10)}

function Get_ClientsDetails_TabProfile_TpProfile_DefaultExpander()
{
    if (language == "french"){return Get_ClientsDetails_TabProfile_TpProfile().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "Defaut"], 10)}
    else {return Get_ClientsDetails_TabProfile_TpProfile().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "Default"], 10)}
}

function Get_ClientsDetails_TabProfile_TpProfile_ClientExpander(){return Get_ClientsDetails_TabProfile_TpProfile().FindChild(["ClrClassName", "WPFControlText"], ["Expander", "Client"], 10)}

function Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC(){return Get_ClientsDetails_TabProfile_TpProfile().FindChild(["ClrClassName", "WPFControlText"], ["GroupBox", "KYC"], 10)}

function Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC_LblInvRiskLow()
{
    if (language == "french"){return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Fact. risq. faible %"], 10)}
    else {return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Inv Risk Low %"], 10)}
}

function Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC_LblInvRiskMed()
{
    if (language == "french"){return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Fact. risq. moyen %"], 10)}
    else {return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Inv Risk Med %"], 10)}
}

function Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC_LblInvRiskHigh()
{
    if (language == "french"){return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Fact. risq. élevé %"], 10)}
    else {return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Inv Risk High %"], 10)}
}

function Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC_TxtInvRiskLow()
{
    if (language == "french"){return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Fact. risq. faible %"], 10)}
    else {return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Inv Risk Low %"], 10)}
}

function Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC_TxtInvRiskMed()
{
    if (language == "french"){return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Fact. risq. moyen %"], 10)}
    else {return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Inv Risk Med %"], 10)}
}

function Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC_TxtInvRiskHigh()
{
    if (language == "french"){return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Fact. risq. élevé %"], 10)}
    else {return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["DoubleTextBox", "Inv Risk High %"], 10)}
}

function Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC_TxtProductType(){
    if (language == "french"){return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["WrapingTextBox", "Type de produit"], 10)}
    else {return Get_ClientsDetails_TabProfile_TpProfile_ClientExpander_GrpKYC().FindChild(["ClrClassName", "DataContext.ProfilDescription"], ["WrapingTextBox", "Product Type"], 10)}
}

//Documents tab (Onglet Documents)

function Get_ClientsDetails_TabDocuments(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "TabItem_0ba9", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "DocumentsPage_9a82", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_LstDocuments(){return Get_ClientsDetails_TabDocuments_TpDocuments().FindChild("Uid", "ListBox_25ba", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties(){return Get_ClientsDetails_TabDocuments_TpDocuments().FindChild("Uid", "GroupBox_7880", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_LblName(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_fd9a", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_TxtName(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_c194", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_LblSize(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_e67b", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_TxtSize(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_a095", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_LblSizeUnits(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_317f", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_LblCreated(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_bb0d", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_TxtCreated(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_c71a", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_LblModified(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_6cba", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_TxtModified(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_c826", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_LblAccessedOn(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_a495", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_TxtAccessedOn(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_1565", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_LblPath(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_eb49", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_TxtPath(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_5e79", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_LblInsertedBy(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_01e3", 10)}

function Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties_TxtInsertedBy(){return Get_ClientsDetails_TabDocuments_TpDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_02fb", 10)}




/**************************************** CLIENTS SUM WINDOW (FENÊTRE SOMMATION CLIENTS) **********************************************/
//Les parties communes aux modules Clients, Relations et Comptes (même Uid) sont dans Common_Get_functions
//(Get_WinRelationshipsClientsAccountsSum(), Get_WinRelationshipsClientsAccountsSum_BtnClose())

function Get_WinClientsSum_LblAssetUnderManagement(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "TextBlock_3983", 10)}

function Get_WinClientsSum_LblClientsTotalValue(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "TextBlock_5933", 10)}

function Get_WinClientsSum_LblNumberOfClients(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "TextBlock_ea8d", 10)}

function Get_WinClientsSum_LblNumberOfClientRoots(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "TextBlock_ea1d", 10)}

function Get_WinClientsSum_LblAccountTotalValue(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "TextBlock_e5a8", 10)}

function Get_WinClientsSum_LblNumberOfAccounts(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "TextBlock_d9df", 10)}

function Get_WinClientsSum_LblTotal(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)}

function Get_WinClientsSum_LblTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "1"], 10)}


function Get_WinClientsSum_TxtClientsTotalValue(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo","VisibleOnScreen"], ["CFTextBlock", "2",true], 10)}

function Get_WinClientsSum_TxtNumberOfClients(){
        return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "3"], 10)}

function Get_WinClientsSum_TxtNumberOfClientRoots(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "4"], 10)}

function Get_WinClientsSum_TxtAccountTotalValue(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "6"], 10)}

function Get_WinClientsSum_TxtNumberOfAccounts(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "7"], 10)}


//Les fonctions Get suivantes sont pour la fenêtre sommation lorsque PREF_ENABLE_CLIENT_GROUPING=NO

function Get_WinClientsSumNoClientGrouping_LblClientsTotalValue(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "2"], 10)}

function Get_WinClientsSumNoClientGrouping_LblNumberOfClients(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "3"], 10)}


function Get_WinClientsSumNoClientGrouping_LblTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "1"], 10)}

function Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10)}

function Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10)}


function Get_WinClientsSumNoClientGrouping_LblCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "1"], 10)}

function Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10)}

function Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsCAD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10)}


function Get_WinClientsSumNoClientGrouping_LblUSD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "1"], 10)}

function Get_WinClientsSumNoClientGrouping_TxtClientsTotalValueUSD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10)}

function Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsUSD(){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10)}




//********************* CLIENTS QUICK SEARCH (CLIENTS - RECHERCHER) ***********************************

//Les parties communes aux différents modules (même Uid) sont dans Common_Get_functions
//(Get_WinQuickSearch(), Get_WinQuickSearch_BtnOK(), Get_WinQuickSearch_BtnCancel(), Get_WinQuickSearch_LblSearch(), Get_WinQuickSearch_TxtSearch(), Get_WinQuickSearch_LblIn())

function Get_WinClientsQuickSearch_RdoClientNo()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENTNUMBER - No client"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENTNUMBER - Client No."], 10)}
}

function Get_WinClientsQuickSearch_RdoName()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NAME - Nom"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NAME - Name"], 10)}
}

function Get_WinClientsQuickSearch_RdoIACode()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "REPRESENTATIVENUMBER - Code de CP"], 10)}//Yr: Avant REPRESENTATIVEID
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "REPRESENTATIVENUMBER - IA Code"], 10)}
}

function Get_WinClientsQuickSearch_RdoCurrency()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CURRENCY - Devise"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CURRENCY - Currency"], 10)}
}

function Get_WinClientsQuickSearch_RdoTelephone1()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "PHONENUMBER1 - Téléphone 1"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "PHONENUMBER1 - Telephone 1"], 10)}
}

function Get_WinClientsQuickSearch_RdoTelephone2()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "PHONENUMBER2 - Téléphone 2"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "PHONENUMBER2 - Telephone 2"], 10)}
}

function Get_WinClientsQuickSearch_RdoTelephone3()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "PHONENUMBER3 - Téléphone 3"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "PHONENUMBER3 - Telephone 3"], 10)}
}

function Get_WinClientsQuickSearch_RdoTelephone4()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "PHONENUMBER4 - Téléphone 4"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "PHONENUMBER4 - Telephone 4"], 10)}
}

function Get_WinClientsQuickSearch_RdoRootNo()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENTNUMBER - No racine"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENTNUMBER - Root No."], 10)}
}


function Get_WinClientsQuickSearch_RdoClientRelationshipNo()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NOLINK - No relation client"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "NOLINK - Client Relationship No."], 10)}
}

