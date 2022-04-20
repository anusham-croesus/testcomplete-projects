//USEUNIT Global_variables


//+++++++++++++++++++++++++ MENU RECHERCHE (SEARCH MENU) ++++++++++++++++++++++++++++
function Get_CroesusApp(){return Aliases.CroesusApp}

function Get_MenuBar(){return Aliases.CroesusApp.winMain.barMenu}

function Get_SubMenus(){return Aliases.CroesusApp.subMenus}

function Get_MenuBar_Search(){return Get_MenuBar().FindChild("Uid", "CustomizableMenu_450b", 10)}//ok

function Get_MenuBar_Search_SearchCriteria(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_d60d", 10)}//ok

function Get_MenuBar_Search_SearchCriteria_Manage(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_f7d9", 100)}//ok

function Get_MenuBar_Search_SearchCriteria_AddACriterion(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_7422", 100)}//ok

function Get_MenuBar_Search_SearchCriteria_EditTheActiveCriterionOrAddANewOne(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_18d3", 100)}//ok

function Get_MenuBar_Search_SearchCriteria_RedisplayAll(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_558e", 100)}//ok

function Get_MenuBar_Search_QuickFilters(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_79ff", 10)}//ok

function Get_MenuBar_Search_QuickFilters_Manage(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_4c89", 100)}//ok

function Get_MenuBar_Search_QuickFilters_AddAFilter(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_0bf5", 100)}//ok

function Get_MenuBar_Search_AllWithoutCheckmarks(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_73a5", 10)}//ok

//******************************************************* FENÊTRE CRÉER UN FILTRE (CREATE FILTER WINDOW) ****************************************************

function Get_WinCreateFilter(){return Aliases.CroesusApp.winCreateFilter}

function Get_WinCreateFilter_LblField(){return Get_WinCreateFilter().FindChild("Uid", "TextBlock_f3e1", 10)}

function Get_WinCreateFilter_TxtField(){return Get_WinCreateFilter().FindChild("Uid", "TextBlock_d65f", 10)}

function Get_WinCreateFilter_LblOperator(){return Get_WinCreateFilter().FindChild("Uid", "TextBlock_d543", 10)}

function Get_WinCreateFilter_CmbOperator(){return Get_WinCreateFilter().FindChild("Uid", "ComboBox_b9ca", 10)}

function Get_WinCreateFilter_LblValue(){return Get_WinCreateFilter().FindChild("Uid", "TextBlock_cbe9", 10)}

function Get_WinCreateFilter_TxtValue(){return Get_WinCreateFilter().FindChild("Uid", "TextBox_32fe", 10)}

function Get_WinCreateFilter_DtpValue(){return Get_WinCreateFilter().FindChild("Uid", "DateField_d5e1", 10)}

function Get_WinCreateFilter_DgvValue(){return Get_WinCreateFilter().FindChild("Uid", "DataGrid_9d05", 10)}

function Get_WinCreateFilter_LblAnd(){return Get_WinCreateFilter().FindChild("Uid", "TextBlock_8480", 10)}

function Get_WinCreateFilter_TxtAnd(){return Get_WinCreateFilter().FindChild("Uid", "TextBox_35d9", 10)}

function Get_WinCreateFilter_DtpAnd(){return Get_WinCreateFilter().FindChild("Uid", "DateField_b74f", 10)}

function Get_WinCreateFilter_TxtValueDouble(){return Get_WinCreateFilter().FindChild("Uid", "DoubleTextBox_897d", 10)}

function Get_WinCreateFilter_TxtAndDouble(){return Get_WinCreateFilter().FindChild("Uid", "DoubleTextBox_2a65", 10)}

function Get_WinCreateFilter_BtnSaveAndApply(){return Get_WinCreateFilter().FindChild("Uid", "Button_2ee7", 10)}

function Get_WinCreateFilter_BtnApply(){return Get_WinCreateFilter().FindChild("Uid", "Button_b19d", 10)}

function Get_WinCreateFilter_BtnCancel(){return Get_WinCreateFilter().FindChild("Uid", "ToggleButton_898f", 10)}


function Get_WinCreateFilter_CmbOperator_ItemContaining()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "contenant"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "containing"], 10)}
}

function Get_WinCreateFilter_CmbOperator_ItemNotContaining()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "ne contenant pas"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "not containing"], 10)}
}

//************ ÉLÉMENTS DU COMBOBOX OPERATEUR DES FENÊTRES CRÉER/AJOUTER/MODIFIER UN FILTRE (CREATE/ADD/EDIT FILTER WINDOW : COMBOBOX OPERATOR ITEMS) *************

function Get_WinCRUFilter_CmbOperator_ItemEqualTo()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "égal(e) à"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "equal to"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemIsNotEqualTo()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "n'égal(e) pas"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "is not equal to"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemContaining()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "contenant"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "containing"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemNotContaining()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "ne contenant pas"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "not containing"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemStartingWith()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "débutant par"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "starting with"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemNotStartingWith()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "ne débutant pas par"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "not starting with"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemEndingWith()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "se terminant par"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "ending with"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemNotEndingWith()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "ne se terminant pas par"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "not ending with"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemIsEmpty()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "est à blanc"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "is empty"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemIsNotEmpty()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "n'est pas à blanc"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "is not empty"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemBetween()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "entre"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "between"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemAmong()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "parmi"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "among"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemExcluding()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "excluant"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "excluding"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemAfterThe()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "est ultérieure au"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "after the"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemOnOrAfterThe()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "est égale ou ultérieure au"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "on or after the"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemIsPriorTo()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "est antérieure au"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "is prior to"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemOnOrPriorTo()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "est égal ou antérieur au"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "on or prior to"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "est plus grand que"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "is greater than"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemIsGreaterOrEqualTo()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "est plus grand ou égal à"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "is greater or equal to"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemIsLowerThan()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "est plus petit que"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "is lower than"], 10)}
}

function Get_WinCRUFilter_CmbOperator_ItemIsLowerOrEqualTo()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "est plus petit ou égal à"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "is lower or equal to"], 10)}
}

                                          
  function Get_WinCRUFilter_CmbOperator_ItemIsWithinTheLast()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "est parmi les derniers"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "is within the last"], 10)}
}

//************ ÉLÉMENTS DU COMBOBOX ACCÈS DES FENÊTRES AJOUTER/MODIFIER UN FILTRE (ADD/EDIT FILTER WINDOW : ACCESS COMBOBOX ITEMS) *************

function Get_WinCRUFilter_CmbAccess_ItemGlobal(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", "Global"], 10)}

function Get_WinCRUFilter_CmbAccess_ItemFirm()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", "Firme"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", "Firm"], 10)}
}

function Get_WinCRUFilter_CmbAccess_ItemBranch()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", "Succursale"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", "Branch"], 10)}
}

function Get_WinCRUFilter_CmbAccess_ItemWorkgroup()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", "Équipe de travail"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", "Workgroup"], 10)}
}

function Get_WinCRUFilter_CmbAccess_ItemUser()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", "Utilisateur"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", "User"], 10)}
}

//******************************************************* FENÊTRE SAUVEGARDER LE FILTRE (SAVE FILTER WINDOW) ****************************************************

function Get_WinSaveFilter(){return Aliases.CroesusApp.winSaveFilter}

function Get_WinSaveFilter_LblName(){return Get_WinSaveFilter().FindChild("Uid", "TextBlock_d69f", 10)}

function Get_WinSaveFilter_TxtName(){return Get_WinSaveFilter().FindChild("Uid", "LocaleTextbox_fe73", 10)}

function Get_WinSaveFilter_LblAccess(){return Get_WinSaveFilter().FindChild("Uid", "TextBlock_ffe2", 10)}

function Get_WinSaveFilter_CmbAccess(){return Get_WinSaveFilter().FindChild("Uid", "PartyLevelComboBox_92f6", 10)}

function Get_WinSaveFilter_BtnOK(){return Get_WinSaveFilter().FindChild("Uid", "Button_4994", 10)}

function Get_WinSaveFilter_BtnCancel(){return Get_WinSaveFilter().FindChild("Uid", "Button_aecb", 10)}


function Get_WinCRUFilter_CmbField_ItemCurrency()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Devise"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Currency"], 10)}
}

function Get_WinCRUFilter_CmbField_ItemInvestmentObjectiveRootClient()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Objectif de placement (Client racine)"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Investment Objective (Root Client)"], 10)}
}

function Get_WinCRUFilter_CmbField_ItemProducts()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Produits"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Products"], 10)}
}

function Get_WinCRUFilter_CmbField_ItemLanguage()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Langue"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Language"], 10)}
}

function Get_WinCRUFilter_CmbField_ItemCommunication(){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Communication"], 10)}

function Get_WinCRUFilter_CmbField_ItemRootNo()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "No racine"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Root No."], 10)}
}

function Get_WinCRUFilter_CmbField_Item(FrenchLabel, EnglishLabel)
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", FrenchLabel], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", EnglishLabel], 10)}
}

//************************************* FENÊTRE GESTIONNAIRE DE CRITÈRES DE RECHERCHE (SEARCH CRITERIA MANAGER WINDOW) ********************************************* 
//Search-->Search Criteria -->Manage 

function Get_WinSearchCriteriaManager(){return Aliases.CroesusApp.winSearchCriteriaManager}//ok

//Pad Header
function Get_WinSearchCriteriaManager_PadHeaderBar(){return Get_WinSearchCriteriaManager().FindChild("Uid", "PadHeader_820d", 10)}//uid a été changé dans automation 10

function Get_WinSearchCriteriaManager_BtnAdd() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Aj_outer"], 10)}
  else {return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Add"], 10)}
}

function Get_WinSearchCriteriaManager_BtnAddAdvanced() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Ajouter (avancé)..."], 10)}
  else {return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Add (Advanced)..."], 10)}
}

//3rd button is "Edit..." when the citerion is created by a user and the checkbox Read Only is unchecked
//Le 3ème bouton est "Modifier..." si le critère est créé par un utilisateur et que sa case Lecture seule n'est pas cochée
function Get_WinSearchCriteriaManager_BtnEdit() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Mo_difier"], 10)}
  else {return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Edit"], 10)}
}

//3rd button is "Display" when the Type is Criteria and the Access is different from User and Branch
//Le 3ème bouton est "Consulter" si le Type est Critère et l'accès différent de Utilisateur ou de Succursale
function Get_WinSearchCriteriaManager_BtnDisplay() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Consulter"], 10)}
  else {return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Display"], 10)}
}

//3rd button is "Create from template..." when the Type is Template
//Le 3ème bouton est "Créer à partir de..." si le critere est de type Gabarit
function Get_WinSearchCriteriaManager_BtnCreateFromTemplate() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Créer à partir de..."], 10)}
  else {return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Cr_eate from template..."], 10)}
}

function Get_WinSearchCriteriaManager_BtnCopy() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Copier"], 10)} //UniButton in aitomation 9
  else {return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Copy"], 10)}
}

function Get_WinSearchCriteriaManager_BtnDelete() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "S_upprimer"], 10)}
  else {return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "De_lete"], 10)}
}

function Get_WinSearchCriteriaManager_BtnLoad() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Char_ger"], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "L_oad"], 10)}
}

function Get_WinSearchCriteriaManager_BtnRefresh() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Actualiser"], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Refresh"], 10)}
}

function Get_WinSearchCriteriaManager_BtnClose() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Fermer"], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Close"], 10)}
}

function Get_WinSearchCriteriaManager_chName() //Description in automation 9
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinSearchCriteriaManager_chAccess() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accès"], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Access"], 10)}
}

function Get_WinSearchCriteriaManager_chType(){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)} //no uid

function Get_WinSearchCriteriaManager_chCreation() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Création"], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creation"], 10)}
}

function Get_WinSearchCriteriaManager_chModule(){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Module"], 10)} //no uid

function Get_WinSearchCriteriaManager_chModified() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modifié"], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modified"], 10)}
}

function Get_WinSearchCriteriaManager_chGenerated() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Généré"], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Generated"], 10)}
}

function Get_WinSearchCriteriaManager_chNoOfRecords() //no uid CROES-5123
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nbre enreg."], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No. of Records"], 10)}
}

function Get_WinSearchCriteriaManager_chCreated()
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Créé"], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Created"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria(){return Get_WinSearchCriteriaManager().FindChild("Uid", "DataGrid_010e", 10)}

function Get_WinSearchCriteriaManager_BtnOK() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "OK"], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "OK"], 10)}
}

function Get_WinSearchCriteriaManager_BtnCancel() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Annuler"], 10)}
  else {return Get_WinSearchCriteriaManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Cancel"], 10)}
}


//******** ÉLÉMENTS DU MENU CONTEXTUEL DE LA GRILLE DU GESTIONNAIRE DE CRITÈRES DE RECHERCHE (SEARCH CRITERIA MANAGER GRID CONTEXTUAL MENU ITEMS) ***********

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"], 10)}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Add()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Aj_outer"], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Add"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_AddForRestrictions()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Ajouter..."], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Add..."], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_AddAdvanced()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Ajouter (avancé)..."], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Add (Advanced)..."], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Edit()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Mo_difier"], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Edit"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_EditForRestrictions()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Modifier..."], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Edit..."], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Display()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Consulter"], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Display"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Copy()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Copier"], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Copy"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_CreateFromTemplate()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Créer à partir de..."], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Cr_eate from template..."], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Delete()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "S_upprimer"], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "De_lete"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Load()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Char_ger"], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "L_oad"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Refresh()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Actualiser"], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Refresh"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Close()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Fermer"], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Close"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_CopyWithoutHeader()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Co_pier"], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Copy"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_CopyWithHeader()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Cop_ier avec en-tête"], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Copy with _Header"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_ExportToFile()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Exporter vers fichier..."], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Export to File..."], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_ExportToMSExcel()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Exporter vers MS Excel..."], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Export to _MS Excel..."], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Help()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Aide"], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Help"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Help_ContextSensitiveHelp()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Aide contextuelle"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Context-Sensitive Help"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Help_ContentsAndIndex()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Sommaire et index"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Contents and Index"], 10)}
}

function Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Print()
{
  if (language == "french"){return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Imprimer..."], 10)}
  else {return Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Print..."], 10)}
}

//----> fin MenuSearch_Get_functions

//---->  MenuSearch_Get_functions
//*************************** FENÊTRE AJOUTER UN CRITÈRE DE RECHERCHE (ADD SEARCH CRITERION WINDOW) ***************************************
//Search-->Search Criteria --> Add a criterion 

function Get_WinAddSearchCriterion(){return Aliases.CroesusApp.winAddSearchCriterion}

function Get_WinAddSearchCriterion_LblName(){return Get_WinAddSearchCriterion().FindChild("Uid", "TextBlock_a483", 10)}

function Get_WinAddSearchCriterion_TxtName(){return Get_WinAddSearchCriterion().FindChild("Uid", "LocaleTextbox_a093", 10)}

function Get_WinAddSearchCriterion_LblDescription(){return Get_WinAddSearchCriterion().FindChild("Uid", "TextBlock_3278", 10)}

function Get_WinAddSearchCriterion_TxtDescription(){return Get_WinAddSearchCriterion().FindChild("Uid", "LocaleTextbox_3eaa", 10)}

function Get_WinAddSearchCriterion_LblAccess(){return Get_WinAddSearchCriterion().FindChild("Uid", "TextBlock_badf", 10)}

function Get_WinAddSearchCriterion_CmbAccess(){return Get_WinAddSearchCriterion().FindChild("Uid", "ComboBox_8274", 10)}

function Get_WinAddSearchCriterion_ChkReadOnly(){return Get_WinAddSearchCriterion().FindChild("Uid", "CheckBox_9d98", 10)}

function Get_WinAddSearchCriterion_LblModule(){return Get_WinAddSearchCriterion().FindChild("Uid", "TextBlock_ee90", 10)}

function Get_WinAddSearchCriterion_CmbModule(){return Get_WinAddSearchCriterion().FindChild("Uid", "ComboBox_ccee", 10)}

function Get_WinAddSearchCriterion_ChkAddParentheses(){return Get_WinAddSearchCriterion().FindChild("Uid", "CheckBox_9053", 10)}

function Get_WinAddSearchCriterion_LblDefinition(){return Get_WinAddSearchCriterion().FindChild("Uid", "TextBlock_f4e5", 10)}

function Get_WinAddSearchCriterion_LvwDefinition(){return Get_WinAddSearchCriterion().FindChild("Uid", "ListBox_3457", 10)}

function Get_WinAddSearchCriterion_BtnSaveAndRegenerate(){return Get_WinAddSearchCriterion().FindChild("Uid", "Button_6fdf", 10)}

function Get_WinAddSearchCriterion_BtnSave(){return Get_WinAddSearchCriterion().FindChild("Uid", "Button_68a8", 10)}

function Get_WinAddSearchCriterion_BtnCancel(){return Get_WinAddSearchCriterion().FindChild("Uid", "Button_b132", 10)}


function Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(partControlName)//Generic
{
  return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", partControlName], 10);
}

function Get_WinAddSearchCriterion_LvwDefinition_Item(itemName) //Generic
{
  return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", itemName], 10);
}
function Get_WinAddSearchCriterion_LvwDefinition_ItemNo(i){
        return Get_WinAddSearchCriterion().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["PartControl", i], 10)}


function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb()
{
  if (language == "french"){return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verbe>"], 10)}
  else {return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verb>"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "."], 10)}

function Get_WinAddSearchCriterion_LvwDefinition_LlbClientsRealClient()
{
  if (language == "french"){return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "clients (Client réel)"], 10)}
  else {return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "clients (Real Client)"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbClientsRealClientItem()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "clients (Client réel)"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "clients (Real Client)"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbClientsFictitiousClientItem()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "clients (Client fictif)"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "clients (Fictitious Client)"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbClientsExternalClientItem()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "clients (Client externe)"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "clients (External Client)"], 10)}
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbClientsFamilyRepresentativeItem()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "clients (Représentants de la famille)"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "clients (Family contacts)"], 10)} //La valeur de WPFControlText n'est pas correcte, devrait être "Clients (Family Representative)"
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbClientsFamilyRepresentative()
{
  if (language == "french"){return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "clients (Représentants de la famille)"], 10)}
  else {return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "clients (Family contacts)"], 10)} //La valeur de WPFControlText n'est pas correcte, devrait être "Clients (Family Representative)"
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "ayant"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "having"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemNotHaving()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "n'ayant pas"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "not having"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField()
{
  if (language == "french"){return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Champ>"], 10)}
  else {return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Field>"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Date"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Date"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate_ItemNextWithdrawalDate()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "date du prochain retrait"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "next withdrawal date"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Calcul"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Calculation"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemTotalValue()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "valeur totale"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "total value"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemBalance()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "solde"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "balance"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Informatif"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Informative"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_nonDeterminablePrice()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "prix non déterminé"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "non determinable price"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSide()
{
  if (language == "french") {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "côté"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "side"], 10)}
}

	
function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemCurrency()
{    
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "devise"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "currency"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemIACode()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "code de CP"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "IA code"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemLanguage()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "langue"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "language"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemAccountNumber()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "numéro de compte"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "account number"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemTypeClass()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "type/classe (sous-catégorie)"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "type/class (subcategory)"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemTypeStatus()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "état"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "status"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemLanguage_Anglais()
{    
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Anglais"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "English"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemDiscretionary()
{    
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "discrétionnaire"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "discretionary"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemManagementLevel()
{    
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "niveau de gestion"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "management level"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemIsJoint()
{    
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "est conjoint"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "is joint"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemOffside(){    
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "hors tolérance"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "offside"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Profil"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Profile"], 10)}
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil_ItemDefaut()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Défaut"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Default"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil_ItemPrivateWealth1859()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Gestion Privée 1859"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Private Wealth 1859"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil_ItemPrivateWealth1859_ItemAdministration()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Administration Spécialisée"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Administration"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil_ItemPrivateWealth1859_ItemAdministration_Partnership()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Partenariat"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Partnership"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSubcategory()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "sous-catégorie"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "subcategory"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil_ItemDefaut_ItemHENRY()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "HENRY"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "HENRY"], 10)}
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSleeves()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "segments"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "sleeves"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemStatus()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "État"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "status"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemLockedPosition()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "position bloquée"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "locked position"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemCountry()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "pays"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "country"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemType()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "type"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "type"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemTypeClassSubCategory()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "type/classe (sous-catégorie)"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "type/class (subcategory)"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator()
{
  if (language == "french"){return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Opérateur>"], 10)}
  else {return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Operator>"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "supérieur(e) à"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "greater than"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItempriorTo()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "antérieure au"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "prior to"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "égal(e) à"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "equal to"], 10)}
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemNotEqualTo()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "différent(e) de"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "not equal to"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemOnOrPriorTo()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "égale ou antérieure au"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "on or prior to"], 10)}
}


function Get_WinAddSearchCriterion_LvwDefinition_DateValue()
{
  return Get_CroesusApp().FindChild(["DataContext.PartType", "ClrClassName"], ["DateValue", "PartControl"], 10)
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue()
{
  if (language == "french"){return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Valeur>"], 10)}
  else {return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Value>"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemExchange()
{
  if (language == "french") {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Échange"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Switch"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemUSD()
{
  return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "USD"], 10)
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemCAD()
{
  return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "CAD"], 10)
}
  
function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Oui"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Yes"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemClientProfile()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Profil client"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Client Profile"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemIndividual()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Individuel"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Individual"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemOpen()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Ouvert"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Open"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemOpen_1()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Ouverte"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Open"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemDiscretionaryBG()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Discrétionnaire BG"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Discretionary BG"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemNo()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Non"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "No"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemExecuted()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Exécuté"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Executed"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue()
{
  if (language == "french"){return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Valeur>"], 10)}
  else {return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Value>"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemFamilyFirm()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Famille-Firme"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Family-Firm"], 10)}
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbNext()
{
  if (language == "french"){return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Suivant>"], 10)}
  else {return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Next>"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "."], 10)}

function Get_WinAddSearchCriterion_LvwDefinition_LlbDot(){return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "."], 10)}

function Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemOr(){
    if (language == "french")   return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "ou"], 10);
    else return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "or"], 10);
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd(){
    if (language == "french")   return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "et"], 10);
    else return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "and"], 10);
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate_LblReviewPastDue()
{
  if (language == "french"){return Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "révision en retard"], 10)}
  else {return Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "review past due"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ForOver()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "depuis plus de"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "for over"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_Days()
{
  return Get_WinAddSearchCriterion().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["PartControl", 6],10);
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate_LblReview()
{
  if (language == "french"){return Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "une révision prévue"], 10)}
  else {return Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "review"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_InTheNext()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "dans les prochains"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "in the next"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemDate_LblNextReviewDate()
{
  if (language == "french"){return Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "date de la prochaine révision"], 10)}
  else {return Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "next review date"], 10)}
} 

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_AfterThe()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "ultérieure au"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "after the"], 10)}
}


//Items du combobox Module

function Get_WinAddSearchCriterion_CmbModule_ItemRelationships()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.OleValue"], ["ComboBoxItem", "Relations"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "DataContext.OleValue"], ["ComboBoxItem", "Relationships"], 10)}
}

//Items du combobox Accès (Access combobox items)

function Get_WinAddSearchCriterion_CmbAccess_ItemFirm()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.DisplayValue"], ["ComboBoxItem", "Firme"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "DataContext.DisplayValue"], ["ComboBoxItem", "Firm"], 10)}
}

function Get_WinAddSearchCriterion_CmbAccess_ItemBranch()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.DisplayValue"], ["ComboBoxItem", "Succursale"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "DataContext.DisplayValue"], ["ComboBoxItem", "Branch"], 10)}
}

function Get_WinAddSearchCriterion_CmbAccess_ItemWorkgroup()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.DisplayValue"], ["ComboBoxItem", "Équipe de travail"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "DataContext.DisplayValue"], ["ComboBoxItem", "Workgroup"], 10)}
}

function Get_WinAddSearchCriterion_CmbAccess_ItemMyCriterion()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.DisplayValue"], ["ComboBoxItem", "Mon critère"], 10)}
  else {if(client == "TD" || client == "CIBC" || client == "RJ"){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.DisplayValue"], ["ComboBoxItem", "My Criteria"], 10)}//SA: Modifié suite a la demande d'Isabelle
  else {return Get_SubMenus().FindChild(["ClrClassName", "DataContext.DisplayValue"], ["ComboBoxItem", "My Criterion"], 10)}}
}

function Get_WinAddSearchCriterion_CmbAccess_ItemGlobal()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.DisplayValue"], ["ComboBoxItem", "Global"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "DataContext.DisplayValue"], ["ComboBoxItem", "Global"], 10)}
}
//----> fin  MenuSearch_Get_functions



//----> MenuSearch_Get_functions

//********************** FENÊTRE AJOUTER UN CRITÈRE DE RECHERCHE - AVANCÉ (ADD SEARCH CRITERION WINDOW - ADVANCED) ************************
//Cliquer le btn "Add search criterion -advanced" dans la fenêtre `Serach Criteria manager`

function Get_WinCRUSearchCriterionAdvanced(){return Aliases.CroesusApp.winCRUSearchCriterionAdvanced}

function Get_WinCRUSearchCriterionAdvanced_BtnSaveAndRefresh()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Sauvegarder et _actualiser"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Save and Refresh"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_BtnSave()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Sau_vegarder"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Sa_ve"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_BtnCancel()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}


function Get_WinCRUSearchCriterionAdvanced_GrpInformation(){return Get_WinCRUSearchCriterionAdvanced().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Information"], 10)}

function Get_WinCRUSearchCriterionAdvanced_GrpInformation_LblName()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpInformation().FindChild(["ClrClassName", "Text"], ["UniLabel", "Nom:"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpInformation().FindChild(["ClrClassName", "Text"], ["UniLabel", "Name:"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName(){return Get_WinCRUSearchCriterionAdvanced_GrpInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinCRUSearchCriterionAdvanced_GrpInformation_BtnProperties(){return Get_WinCRUSearchCriterionAdvanced_GrpInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}


function Get_WinCRUSearchCriterionAdvanced_GrpDefinition()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Définition"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Definition"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_LblFind()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition().FindChild(["ClrClassName", "Text"], ["UniLabel", "Rechercher des:"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition().FindChild(["ClrClassName", "Text"], ["UniLabel", "Find:"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_CmbFind(){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_TvwTreeView(){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeView", "1"], 10)}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_TvwTreeView_ItemClientClassEqualsRealClient()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_TvwTreeView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Classe du client égale Client réel"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_TvwTreeView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Client Class equals Real Client"], 10)}
}


function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpLogicalOperators()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Opérateurs logiques"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Logical Operators"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_BtnAdd()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpLogicalOperators().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Aj_outer..."], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpLogicalOperators().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "A_dd..."], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_BtnEdit()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpLogicalOperators().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Mo_difier..."], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpLogicalOperators().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Edit..."], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_BtnDelete()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpLogicalOperators().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpLogicalOperators().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_BtnDeleteAll()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpLogicalOperators().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Supprimer _tout"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpLogicalOperators().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Delete _All"], 10)}
}


function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition(){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Condition"], 10)}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_LblField()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "Text"], ["UniLabel", "Champ:"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "Text"], ["UniLabel", "Field:"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_TxtField(){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField(){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}



function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField_ContextualMenu_Clients()
{
 return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Clients"], 10)// WPFControlText est pareil en français est en anglais : Clients
  
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField_ContextualMenu_Clients_Informative()
{
 if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Informatif"], 10)}

 else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Informative"], 10)}
 
 
 }
 
 
function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField_ContextualMenu_Clients_Informative_BasicFields()
{
 if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Champs de base"], 10)}

 else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Basic Fields"], 10)}
 
 
 }
 
function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseField_ContextualMenu_Clients_Informative_BasicFields_ContactPersonClient()
{
 if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Personne-ressource (Client)"], 10)}

 else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Contact person (Client)"], 10)}
 
 
 }

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_LblOperator()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "Text"], ["UniLabel", "Opérateur:"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "Text"], ["UniLabel", "Operator:"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbOperator(){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_LblValue()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "Text"], ["UniLabel", "Valeur:"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "Text"], ["UniLabel", "Value:"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbValue(){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_DtpValue(){return Get_WinCRUSearchCriterionAdvanced().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnChooseValue(){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "4"], 10)}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnAddACondition()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Ajouter _condition"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Add a _Condition"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnEditACondition()
{
  if (language == "french"){return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Modifier condition"], 10)}
  else {return Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Edit a Conditio_n"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbOperator_ItemEquals()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "égale"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "equals"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbOperator_ItemIsNotEqualTo()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "n'égale pas"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "is not equal to"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbOperator_ItemIsEmpty()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "est à blanc"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "is empty"], 10)}
}

function Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbOperator_ItemIsNotEmpty()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "n'est pas à blanc"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "is not empty"], 10)}
}

//----> fin  MenuSearch_Get_functions


//---->   MenuSearch_Get_functions

//************************** FENÊTRE PROPRIÉTÉS DU CRITÈRE DE RECHERCHE (SEARCH CRITERION PROPERTIES WINDOW) ******************************
//Cliquer le btn "Add search criterion -advanced" dans la fenêtre Serach "Criteria manager" , puis cliquer sur le btn "properties"  

function Get_WinSearchCriterionProperties(){return Aliases.CroesusApp.winSearchCriterionProperties}

function Get_WinSearchCriterionProperties_GrpName()
{
  if (language == "french"){return Get_WinSearchCriterionProperties().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Nom"], 10)}
  else {return Get_WinSearchCriterionProperties().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Name"], 10)}
}

function Get_WinSearchCriterionProperties_GrpName_LblLanguage()
{
  if (language == "french"){return Get_WinSearchCriterionProperties_GrpName().FindChild(["ClrClassName", "Text"], ["UniLabel", "Langue:"], 10)}
  else {return Get_WinSearchCriterionProperties_GrpName().FindChild(["ClrClassName", "Text"], ["UniLabel", "Language:"], 10)}
}

function Get_WinSearchCriterionProperties_GrpName_CmbLanguage(){return Get_WinSearchCriterionProperties_GrpName().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinSearchCriterionProperties_GrpName_Lbl2LanguagesDefined()
{
  if (language == "french"){return Get_WinSearchCriterionProperties_GrpName().FindChild(["ClrClassName", "Text"], ["UniLabel", "(2 langues définies)"], 10)}
  else {return Get_WinSearchCriterionProperties_GrpName().FindChild(["ClrClassName", "Text"], ["UniLabel", "(2 languages defined)"], 10)}
}

function Get_WinSearchCriterionProperties_GrpName_LblName()
{
  if (language == "french"){return Get_WinSearchCriterionProperties_GrpName().FindChild(["ClrClassName", "Text"], ["UniLabel", "Nom:"], 10)}
  else {return Get_WinSearchCriterionProperties_GrpName().FindChild(["ClrClassName", "Text"], ["UniLabel", "Name:"], 10)}
}

function Get_WinSearchCriterionProperties_GrpName_TxtName(){return Get_WinSearchCriterionProperties_GrpName().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}


function Get_WinSearchCriterionProperties_GrpOrder()
{
  if (language == "french"){return Get_WinSearchCriterionProperties().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Ordre"], 10)}
  else {return Get_WinSearchCriterionProperties().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Order"], 10)}
}

function Get_WinSearchCriterionProperties_GrpOrder_ChkKeepSortOrder()
{
  if (language == "french"){return Get_WinSearchCriterionProperties_GrpOrder().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Conserver l'ordre de tri"], 10)}
  else {return Get_WinSearchCriterionProperties_GrpOrder().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Keep Sort Order"], 10)}
}

function Get_WinSearchCriterionProperties_GrpOrder_LblField()
{
  if (language == "french"){return Get_WinSearchCriterionProperties_GrpOrder().FindChild(["ClrClassName", "Text"], ["UniLabel", "Champ:"], 10)}
  else {return Get_WinSearchCriterionProperties_GrpOrder().FindChild(["ClrClassName", "Text"], ["UniLabel", "Field:"], 10)}
}

function Get_WinSearchCriterionProperties_GrpOrder_CmbField(){return Get_WinSearchCriterionProperties_GrpOrder().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinSearchCriterionProperties_GrpOrder_RdoAscending()
{
  if (language == "french"){return Get_WinSearchCriterionProperties_GrpOrder().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Croissant"], 10)}
  else {return Get_WinSearchCriterionProperties_GrpOrder().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Ascending"], 10)}
}

function Get_WinSearchCriterionProperties_GrpOrder_RdoDescending()
{
  if (language == "french"){return Get_WinSearchCriterionProperties_GrpOrder().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Décroissant"], 10)}
  else {return Get_WinSearchCriterionProperties_GrpOrder().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Descending"], 10)}
}


function Get_WinSearchCriterionProperties_GrpAccess()
{
  if (language == "french"){return Get_WinSearchCriterionProperties().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Accès"], 10)}
  else {return Get_WinSearchCriterionProperties().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Access"], 10)}
}

function Get_WinSearchCriterionProperties_GrpAccess_RdoFirm()
{
  if (language == "french"){return Get_WinSearchCriterionProperties_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Firme"], 10)}
  else {return Get_WinSearchCriterionProperties_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Firm"], 10)}
}

function Get_WinSearchCriterionProperties_GrpAccess_RdoBranch()
{
  if (language == "french"){return Get_WinSearchCriterionProperties_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Succursale"], 10)}
  else {return Get_WinSearchCriterionProperties_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Branch"], 10)}
}

function Get_WinSearchCriterionProperties_GrpAccess_RdoWorkgroup()
{
  if (language == "french"){return Get_WinSearchCriterionProperties_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Équipe de travail"], 10)}
  else {return Get_WinSearchCriterionProperties_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Workgroup"], 10)}
}

function Get_WinSearchCriterionProperties_GrpAccess_RdoMyCriterion()
{
  if (language == "french"){return Get_WinSearchCriterionProperties_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Mon critère"], 10)}
  else {return Get_WinSearchCriterionProperties_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "My Criterion"], 10)}
}

function Get_WinSearchCriterionProperties_ChkReadOnly()
{
  if (language == "french"){return Get_WinSearchCriterionProperties().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Lecture seulement"], 10)}
  else {return Get_WinSearchCriterionProperties().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Read-Only"], 10)}
}

function Get_WinSearchCriterionProperties_BtnOK(){return Get_WinSearchCriterionProperties().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinSearchCriterionProperties_BtnCancel()
{
  if (language == "french"){return Get_WinSearchCriterionProperties().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinSearchCriterionProperties().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinSearchCriterionProperties_GrpOrder_CmbField_ItemClientNumber()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Numéro de client"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Client Number"], 10)}
}

//********************************************* FENÊTRE AJOUTER UN FILTRE (ADD A FILTER WINDOW) ***********************************************************

function Get_WinAddFilter(){return Aliases.CroesusApp.WinAddFilter}

function Get_WinAddFilter_LblName() //Description dans automation 9
{
  if (language == "french"){return Get_WinAddFilter().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Nom"], 10)}
  else {return Get_WinAddFilter().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Name"], 10)}
}

function Get_WinAddFilter_TxtName(){return Get_WinAddFilter().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)} //Description dans automation 9

function Get_WinAddFilter_BtnLanguages(){return Get_WinAddFilter().FindChild("Uid", "Button_d168", 10)} //ok

function Get_WinAddFilter_GrpCondition(){return Get_WinAddFilter().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Condition"], 10)} //no uid

function Get_WinAddFilter_GrpCondition_LblField() //Uid is not unique
{
  if (language == "french"){return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Champ:"], 10)}
  else {return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Field:"] ,10)}
}

function Get_WinAddFilter_GrpCondition_LblOperator() //Uid is not unique
{
  if (language == "french"){return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Opérateur:"], 10)}
  else {return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Operator:"] ,10)}
}

function Get_WinAddFilter_GrpCondition_LblValue() //Uid is not unique
{
  if (language == "french"){return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Valeur:"], 10)}
  else {return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Value:"] ,10)}
}

function Get_WinAddFilter_GrpCondition_CmbField(){return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}//no uid

function Get_WinAddFilter_GrpCondition_CmbOperator(){return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}//no uid

function Get_WinAddFilter_GrpCondition_CmbValue(){return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 3], 10)}

function Get_WinAddFilter_GrpCondition_TxtValue(){return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["UniTextField", "1"], 10)} //Uid is not unique

function Get_WinAddFilter_GrpCondition_TxtValueDouble(){return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)} //no uid

function Get_WinAddFilter_GrpCondition_DateValue(){return Get_WinAddFilter_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}//no uid

function Get_WinAddFilter_BtnOK(){return Get_WinAddFilter().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)} //no uid

function Get_WinAddFilter_BtnCancel() //no uid
{
  if (language == "french"){return Get_WinAddFilter().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinAddFilter().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"] ,10)}
}

//------> fin  MenuSearch_Get_functions


//------> MenuSearch_Get_functions

//************************** FENÊTRE AJOUTER UN FILTRE POUR RELATIONS/CLIENTS/COMPTES(ADD A FILTER WINDOW FOR RELATIONSHIPS/CLIENTS/ACCOUNTS) ***********************

function Get_WinCRUFilter(){return Aliases.CroesusApp.winAddFilterForRelationshipsClientsAccounts}

function Get_WinCRUFilter_BtnOK(){return Get_WinCRUFilter().FindChild("Uid", "Button_ed99", 10)}

function Get_WinCRUFilter_BtnCancel(){return Get_WinCRUFilter().FindChild("Uid", "ToggleButton_f759", 10)}

function Get_WinCRUFilter_BtnClose(){return Get_WinCRUFilter().FindChild("Uid", "Button_6328", 10)} //Pour la fenêtre Consulter un filtre


function Get_WinCRUFilter_GrpDefinition(){return Get_WinCRUFilter().FindChild("Uid", "GroupBox_f25b", 10)}

function Get_WinCRUFilter_GrpDefinition_LblName(){return Get_WinCRUFilter_GrpDefinition().FindChild("Uid", "TextBlock_d69f", 10)}

function Get_WinCRUFilter_GrpDefinition_TxtName(){return Get_WinCRUFilter_GrpDefinition().FindChild("Uid", "LocaleTextbox_fe73", 10)}

function Get_WinCRUFilter_GrpDefinition_LblAccess(){return Get_WinCRUFilter_GrpDefinition().FindChild("Uid", "TextBlock_ffe2", 10)}

function Get_WinCRUFilter_GrpDefinition_CmbAccess(){return Get_WinCRUFilter_GrpDefinition().FindChild("Uid", "PartyLevelComboBox_92f6", 10)}


function Get_WinCRUFilter_GrpCondition(){return Get_WinCRUFilter().FindChild("Uid", "GroupBox_fc58", 10)}

function Get_WinCRUFilter_GrpCondition_LblField(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "TextBlock_f3e1", 10)}

function Get_WinCRUFilter_GrpCondition_CmbField(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "ComboBox_f9c9", 10)}

function Get_WinCRUFilter_GrpCondition_LblOperator(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "TextBlock_d543", 10)}

function Get_WinCRUFilter_GrpCondition_CmbOperator(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "ComboBox_b9ca", 10)}

function Get_WinCRUFilter_GrpCondition_LblValue(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "TextBlock_cbe9", 10)}

function Get_WinCRUFilter_GrpCondition_DgvValue(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "DataGrid_9d05", 10)}

function Get_WinCRUFilter_GrpCondition_TxtValue(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "TextBox_32fe", 10)}

function Get_WinCRUFilter_GrpCondition_DtpValue(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "DateField_d5e1", 10)}

function Get_WinCRUFilter_GrpCondition_LblAnd(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "TextBlock_8480", 10)}

function Get_WinCRUFilter_GrpCondition_TxtAnd(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "TextBox_35d9", 10)}

function Get_WinCRUFilter_GrpCondition_DtpAnd(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "DateField_b74f", 10)}

function Get_WinCRUFilter_GrpCondition_TxtValueDouble(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "DoubleTextBox_897d", 10)}

function Get_WinCRUFilter_GrpCondition_TxtAndDouble(){return Get_WinCRUFilter_GrpCondition().FindChild("Uid", "DoubleTextBox_2a65", 10)}

//************************** FENÊTRE D'AFFICHAGE OU DE MISE À JOUR DE FILTRE POUR TITRES/ORDRES (FILTER UPDATE WINDOW FOR SECURITIES/ORDERS) ***********************
// Dans la fenetre "Filters Manager" cliquer sur le btn Edit"
function Get_WinCRUFilterForSecuritiesOrders(){return Aliases.CroesusApp.winCRUFilterForSecuritiesOrders}

function Get_WinCRUFilterForSecuritiesOrders_TxtName(){return Get_WinCRUFilterForSecuritiesOrders().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinCRUFilterForSecuritiesOrders_GrpAccess()
{
  if (language == "french"){return Get_WinCRUFilterForSecuritiesOrders().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Accès"], 10)}
  else {return Get_WinCRUFilterForSecuritiesOrders().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Access"], 10)}
}

function Get_WinCRUFilterForSecuritiesOrders_GrpCondition(){return Get_WinCRUFilterForSecuritiesOrders().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Condition"], 10)}

function Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbField(){return Get_WinCRUFilterForSecuritiesOrders_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbOperator(){return Get_WinCRUFilterForSecuritiesOrders_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 2], 10)}

function Get_WinCRUFilterForSecuritiesOrders_GrpCondition_CmbValue(){return Get_WinCRUFilterForSecuritiesOrders_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 3], 10)}

function Get_WinCRUFilterForSecuritiesOrders_GrpCondition_TxtValue(){return Get_WinCRUFilterForSecuritiesOrders_GrpCondition().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinCRUFilterForSecuritiesOrders_GrpCondition_TxtValueDouble(){return Get_WinCRUFilterForSecuritiesOrders_GrpCondition().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)}

function Get_WinCRUFilterForSecuritiesOrders_GrpCondition_DateValue(){return Get_WinCRUFilterForSecuritiesOrders_GrpCondition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinCRUFilterForSecuritiesOrders_BtnOK(){return Get_WinCRUFilterForSecuritiesOrders().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinCRUFilterForSecuritiesOrders_BtnCancel()
{
  if (language == "french"){return Get_WinCRUFilterForSecuritiesOrders().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinCRUFilterForSecuritiesOrders().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"] ,10)}
}

//************************** FENÊTRE DE SÉLECTION D'UN FILTRE POUR TITRES/ORDRES/TRANSACTIONS (FILTER SELECTION WINDOW FOR SECURITIES/ORDERS/TRANSACTIONS) ***********************

function Get_WinFilterSelection(){return Aliases.CroesusApp.winFilterSelection}

function Get_WinFilterSelection_GrpView()
{
  if (language == "french"){return Get_WinFilterSelection().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Affichage"], 10)}
  else {return Get_WinFilterSelection().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "View"] ,10)}
}

function Get_WinFilterSelection_GrpView_RdoAllFilters()
{
  if (language == "french"){return Get_WinFilterSelection_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_Tous les filtres"], 10)}
  else {return Get_WinFilterSelection_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_All Filters"] ,10)}
}

function Get_WinFilterSelection_GrpView_RdoFirmFilters()
{
  if (language == "french"){return Get_WinFilterSelection_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Filtres _firme"], 10)}
  else {return Get_WinFilterSelection_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_Firm Filters"] ,10)}
}

function Get_WinFilterSelection_GrpView_RdoMyFilters()
{
  if (language == "french"){return Get_WinFilterSelection_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_Mes filtres"], 10)}
  else {return Get_WinFilterSelection_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_My Filters"] ,10)}
}

function Get_WinFilterSelection_LstFilters(){return Get_WinFilterSelection().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"], 10)}

function Get_WinFilterSelection_LstFilters_Item(filterName){return Get_WinFilterSelection_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", filterName], 10)}

function Get_WinFilterSelection_BtnOK(){return Get_WinFilterSelection().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinFilterSelection_BtnCancel()
{
  if (language == "french"){return Get_WinFilterSelection().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinFilterSelection().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"] ,10)}
}

//---> ??


// ----> MenuSearch_Get_functions
//***************************************** FENÊTRE GESTIONNAIRE DE FILTRES RAPIDES (QUICK FILTERS MANAGER WINDOW) *************************************************
// Serach --> FILTERS -->manage
function Get_WinQuickFiltersManager(){return Aliases.CroesusApp.WinQuickFiltersManager} //Quick Filters Manager/Gestionnaire de filtres rapides in automation 9

function Get_WinQuickFiltersManager_BtnClose() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Fermer"], 10)}
  else {return Get_WinQuickFiltersManager().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Close"] ,10)}
}


function Get_WinQuickFiltersManager_PadHeaderBar(){return Get_WinQuickFiltersManager().FindChild("Uid", "ItemsControl_ca1a", 10)} //ok

function Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Ajouter..."], 10)}
  else {return Get_WinQuickFiltersManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "A_dd..."] ,10)}
}

function Get_WinQuickFiltersManager_PadHeaderBar_BtnDisplay() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Co_nsulter"], 10)}
  else {return Get_WinQuickFiltersManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "D_isplay"] ,10)}
}

function Get_WinQuickFiltersManager_PadHeaderBar_BtnEdit() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "M_odifier..."], 10)}
  else {return Get_WinQuickFiltersManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Edit..."] ,10)}
}

function Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
  else {return Get_WinQuickFiltersManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"] ,10)}
}


function Get_WinQuickFiltersManager_GrpView() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Affichage"], 10)}
  else {return Get_WinQuickFiltersManager().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "View"] ,10)}
}

function Get_WinQuickFiltersManager_GrpView_RdoAllFilters() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_Tous les filtres"], 10)}
  else {return Get_WinQuickFiltersManager_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_All Filters"] ,10)}
}

function Get_WinQuickFiltersManager_GrpView_RdoGlobalFilters() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Filtres _globaux"], 10)}
  else {return Get_WinQuickFiltersManager_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_Global Filters"] ,10)}
}

function Get_WinQuickFiltersManager_GrpView_RdoMyFilters() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_Mes filtres"], 10)}
  else {return Get_WinQuickFiltersManager_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_My Filters"] ,10)}
}

function Get_WinQuickFiltersManager_GrpView_RdoFirmFilters() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Filtres _firme"], 10)}
  else {return Get_WinQuickFiltersManager_GrpView().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_Firm Filters"] ,10)}
}

function Get_WinQuickFiltersManager_LstFilters(){return Get_WinQuickFiltersManager().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"], 10)} //no uid

function Get_WinQuickFiltersManager_LstFilters_Baskets(){return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Baskets"], 10)}

function Get_WinQuickFiltersManager_LstFilters_CommonStocks() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Actions ordinaires"], 10)}
  else {return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Common Stocks"], 10)}
}

function Get_WinQuickFiltersManager_LstFilters_Currencies() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Devises"], 10)}
  else {return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Currencies"], 10)}
}

function Get_WinQuickFiltersManager_LstFilters_GestDiscr(){return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Gest. discr"], 10)}

function Get_WinQuickFiltersManager_LstFilters_Gestionnaire(){return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Gestionnaire"], 10)}

function Get_WinQuickFiltersManager_LstFilters_Indices(){return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Indices"], 10)} // no uid

function Get_WinQuickFiltersManager_LstFilters_MutualFunds() //no uid
{
  if (language == "french"){return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Fonds d'investissement"], 10)}
  else {return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Mutual Funds"], 10)}
}

function Get_WinQuickFiltersManager_LstFilters_Obligation(){return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Obligation"], 10)}

function Get_WinQuickFiltersManager_LstFilters_Panier(){return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Panier"], 10)}


function Get_WinQuickFiltersManager_LblInfo(){return Get_WinQuickFiltersManager().FindChild("Uid", "Label_f867", 10)} //ok
// ajout de la fonction get pour Get_WinQuickFiltersManager_LstFilters_Indexes 
function Get_WinQuickFiltersManager_LstFilters_Indexes(){return Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", "Indexes"], 10)}

// ----> fin MenuSearch_Get_functions


// ----> MenuSearch_Get_functions
//***************** FENÊTRE GESTIONNAIRE DE FILTRES RAPIDES POUR RELATIONS/CLIENTS/COMPTES (QUICK FILTERS MANAGER WINDOW FOR RELATIONSHIPS/CLIENTS/ACCOUNTS) **************

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts(){return Aliases.CroesusApp.winQuickFiltersManagerForRelationshipsClientsAccounts} //Quick Filters Manager/Gestionnaire de filtres rapides in automation 9

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DataGrid(){
    return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild("Uid", "DataGrid_010e", 10)}
    
function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Appliquer"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Apply"] ,10)}
}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Fermer"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Close"] ,10)}
}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnDelete()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild(["ClrClassName", "WPFControlText"], ["Button", "S_upprimer"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild(["ClrClassName", "WPFControlText"], ["Button", "De_lete"] ,10)}
}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar(){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild("Uid", "PadHeader_820d", 10)}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Aj_outer"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Add"] ,10)}
}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDisplay()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Consulter"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Display"] ,10)}
}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Mo_difier"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Edit"] ,10)}
}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "S_upprimer"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "De_lete"] ,10)}
}


function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters(){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild("Uid", "DataGrid_010e", 10)}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChName()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"] ,10)}
}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChModified()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modifié"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modified"] ,10)}
}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreated()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Créé"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Created"] ,10)}
}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChAccess()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accès"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Access"] ,10)}
}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreation()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Création"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creation"] ,10)}
}
// ----> fin MenuSearch_Get_functions


// ----> MenuSearch_Get_functions
//************************ MENU CONTEXTUEL SUR LA GRILLE DE LA FENÊTRE GESTION DES FILTRES (CONTEXTUAL MENU ON THE FILTER MANAGER WINDOW GRID) **********************

function Get_WinFilterManager_DgvFilters_ContextualMenu(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"], 10)}

function Get_WinFilterManager_DgvFilters_ContextualMenu_Edit()
{
  if (language == "french"){return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Modifier..."], 10)}
  else {return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Edit..."] ,10)}
}

function Get_WinFilterManager_DgvFilters_ContextualMenu_Add()
{
  if (language == "french"){return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Ajouter..."], 10)}
  else {return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Add..."] ,10)}
}

function Get_WinFilterManager_DgvFilters_ContextualMenu_Delete()
{
  if (language == "french"){return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "S_upprimer"], 10)}
  else {return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "De_lete"] ,10)}
}

function Get_WinFilterManager_DgvFilters_ContextualMenu_Copy()
{
  if (language == "french"){return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Co_pier"], 10)}
  else {return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Copy"] ,10)}
}

function Get_WinFilterManager_DgvFilters_ContextualMenu_CopyWithHeader()
{
  if (language == "french"){return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Cop_ier avec en-tête"], 10)}
  else {return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Copy with _Header"] ,10)}
}

function Get_WinFilterManager_DgvFilters_ContextualMenu_ExportToFile()
{
  if (language == "french"){return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Exporter vers fichier..."], 10)}
  else {return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Export to File..."] ,10)}
}

function Get_WinFilterManager_DgvFilters_ContextualMenu_ExportToMSExcel()
{
  if (language == "french"){return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Exporter vers MS Excel..."], 10)}
  else {return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Export to _MS Excel..."] ,10)}
}

function Get_WinFilterManager_DgvFilters_ContextualMenu_Help()
{
  if (language == "french"){return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Aide"], 10)}
  else {return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Help"] ,10)}
}

function Get_WinFilterManager_DgvFilters_ContextualMenu_Help_ContextSensitiveHelp()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Aide contextuelle"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Context-Sensitive Help"] ,10)}
}

function Get_WinFilterManager_DgvFilters_ContextualMenu_Help_ContentsAndIndex()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Sommaire et index"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Contents and Index"] ,10)}
}

function Get_WinFilterManager_DgvFilters_ContextualMenu_Print()
{
  if (language == "french"){return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Imprimer..."], 10)}
  else {return Get_WinFilterManager_DgvFilters_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Print..."] ,10)}
}