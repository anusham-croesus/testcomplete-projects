//USEUNIT Global_variables

//++++++++++++++++++++++++++++++++++MENU RAPPORTS (REPORTS MENU) +++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++ MENUBAR ++++++++++++++++++++++++++++++
function Get_CroesusApp(){return Aliases.CroesusApp}

function Get_MenuBar(){return Aliases.CroesusApp.winMain.barMenu}

function Get_SubMenus(){return Aliases.CroesusApp.subMenus}

function Get_MenuBar_Reports(){return Get_MenuBar().FindChild("Uid", "CustomizableMenu_7b5f", 10)} //ok

function Get_MenuBar_Reports_Relationships(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_8a79", 10)} //ok

function Get_MenuBar_Reports_Clients(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_c1c8", 10)} //ok

function Get_MenuBar_Reports_Accounts(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_f570", 10)} //ok

function Get_MenuBar_Reports_Portfolio(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_b053", 10)} //ok

function Get_MenuBar_Reports_Model(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_c985", 10)} //ok

function Get_MenuBar_Reports_Securities(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_706b", 10)} //ok

function Get_MenuBar_Reports_ExportToMSWord(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_c456", 10)} //ok

function Get_MenuBar_Reports_MutualFundsOrderReport(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_ba8a", 10)} 

function Get_MenuBar_Reports_FidessaOrderReport(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_f2fb", 10)}

function Get_MenuBar_Reports_ExchangeRateReport(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_6915", 10)}

//************************** REPORTS WINDOW (FENÊTRE RAPPORTS) *******************************************

function Get_WinReports(){return Aliases.CroesusApp.winReports}

function Get_WinReports_BtnOK(){return Get_WinReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)} //no uid

function Get_WinReports_BtnClose() //no uid
{
  if (language == "french"){return Get_WinReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Fermer"], 10)}
  else {return Get_WinReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Close"], 10)}
}

//Les fonctions relatives au groupbox Rapports (préfixées par Get_Reports_) sont communes aux fenêtres Rapports, Info Client/Relation et Info Compte

function Get_Reports_GrpReports() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Rapports"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Reports"], 10)}
}

function Get_Reports_GrpReports_TabReports() //no uid
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Rapports"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Reports"], 10)}
}

function Get_Reports_GrpReports_TabReports_LvwReports(){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"], 10)} //no uid

function Get_Reports_GrpReports_TabReports_TvwReports_TvwGlobal(){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTreeViewItem", 2], 10)} 

function Get_Reports_GrpReports_TabSavedReports() //no uid
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Rapports sauvegardés"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Saved Reports"], 10)}
}

//Pour la fenêtre Rapports
function Get_Reports_GrpReports_TabSavedReports_TvwSavedReports(){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeView", "1"], 10)} //no uid

function Get_Reports_GrpReports_TabSavedReports_TvwSavedReports_TvwFirm(){return Get_Reports_GrpReports_TabSavedReports_TvwSavedReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTreeViewItem", 1], 10)}

function Get_Reports_GrpReports_TabSavedReports_TvwSavedReports_TvwMySavedReports(){return Get_Reports_GrpReports_TabSavedReports_TvwSavedReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTreeViewItem", 2], 10)}


//Pour l'onglet Saved Reports créé le 09/08/2019 par A.M
function Get_Reports_GrpReports_TabSavedReports_DefaultReportsAndUnderlyingRelationships(){
   if (language == "french") return Get_Reports_GrpReports_TabSavedReports_TvwSavedReports().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", " Rapports par défaut et relations sous-jacentes"], 10)
   else return Get_Reports_GrpReports_TabSavedReports_TvwSavedReports().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Default reports and underlying relationships"], 10)
}


//Pour les fenêtres Info Client/Relation/Compte
function Get_Reports_GrpReports_TabSavedReports_LvwSavedReports(){
  return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"], 10)} //no uid

function Get_Reports_GrpReports_TabSavedReports_BtnDelete() //no uid
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"], 10)}
}


function Get_Reports_GrpReports_BtnAddAReport() //Ajouté ce 30/06/2016
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Ajouter un rapport"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Add a Report"], 10)}
}

function Get_Reports_GrpReports_BtnRemoveAReport() //Ajouté ce 30/06/2016
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Enlever un rapport"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Remove a Report"], 10)}
}

function Get_Reports_GrpReports_BtnRemoveAllReports() //Ajouté ce 30/06/2016
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Enlever tous les rapports"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Remove All Reports"], 10)}
}

function Get_Reports_GrpReports_BtnMoveTheReportUp() //Ajouté ce 30/06/2016
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Monter le rapport"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Move the Report Up"], 10)}
}

function Get_Reports_GrpReports_BtnMoveTheReportDown() //Ajouté ce 30/06/2016
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Descendre le rapport"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Move the Report Down"], 10)}
}


//Pour la fenêtre Rapports
function Get_Reports_GrpReports_LblCurrentReports() //ok
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Rapports courants"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Current Reports"], 10)}
}

//Pour les fenêtres Info Client/Relation/Compte
function Get_Reports_GrpReports_LblDefaultReports() //ok
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "Text"], ["UniLabel", "Rapports par défaut"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "Text"], ["UniLabel", "Default Reports"], 10)}
}

function Get_Reports_GrpReports_TabSavedReports_TvwReports_TvwGlobal(){
    return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTreeViewItem", 2], 10)}
    
function Get_Reports_GrpReports_TabSavedReports_TvwReports_TvwFirm(){
    return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTreeViewItem", 3], 10)}
    
function Get_Reports_GrpReports_TabSavedReports_TvwReports_TvwWorkgroup(){
    return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTreeViewItem", 4], 10)}
    
function Get_Reports_GrpReports_TabSavedReports_TvwReports_TvwUser(){
    return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTreeViewItem", 5], 10)}

function Get_Reports_GrpReports_LvwCurrentReports(){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"], 10)}//no uid

function Get_Reports_GrpReports_BtnSave() //no uid
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Sau_vegarder"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Sa_ve"], 10)}
}
function Get_Reports_GrpReports_LblPackageStartDate()
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Package Start Date:"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date de début du groupe de rapports :"], 10)}
}

function Get_Reports_GrpReports_DtpPackageStartDate(){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", 1], 10)}


function Get_Reports_GrpReports_LblPackageEndDate()
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Package End Date:"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date de fin du groupe de rapports :"], 10)}
}

function Get_Reports_GrpReports_DtpPackageEndDate(){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", 2], 10)}

//Pour la fenêtre Info Client/Relation
function Get_Reports_GrpReports_ChkConsolidatePositions()
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Consolider les positions"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Consolidate positions"], 10)}
}


function Get_Reports_GrpReports_GrpCurrentParameters() //no uid    
{
  if (language == "french"){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Paramètres courants"], 10)}
  else {return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Current Parameters"], 10)}
}

function Get_Reports_GrpReports_GrpCurrentParameters_TxtCurrentParameters(){return Get_Reports_GrpReports_GrpCurrentParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniScrollPane", "1"], 10)}//no uid

function Get_Reports_GrpReports_GrpCurrentParameters_BtnParameters() //no uid
{
  if (language == "french"){return Get_Reports_GrpReports_GrpCurrentParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Paramètres..."], 10)}
  else {return Get_Reports_GrpReports_GrpCurrentParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Parameters..."], 10)}
}
//Fin : fonctions communes aux fenêtres Rapports, Info Client/Relation et Info Compte


function Get_WinReports_GrpOptions(){return Get_WinReports().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Options"], 10)} //no uid

function Get_WinReports_GrpOptions_LblDestination(){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Destination:"], 10)} //no uid

function Get_WinReports_GrpOptions_CmbDestination(){return Get_WinReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)} //no uid

function Get_WinReports_GrpOptions_ChkPrintDuplex()
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Imprimer recto verso"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Print Duplex"], 10)}
}

function Get_WinReports_GrpOptions_LblSortBy()
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Trier par:"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Sort by:"], 10)}
}

function Get_WinReports_GrpOptions_CmbSortBy(){return Get_WinReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)} //no uid

function Get_WinReports_GrpOptions_LblCurrency()
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Devise:"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Currency:"], 10)}
}

function Get_WinReports_GrpOptions_CmbCurrency(){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)} //no uid

function Get_WinReports_GrpOptions_LblLanguage()
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Langue:"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Language:"], 10)}
}

function Get_WinReports_GrpOptions_CmbLanguage(){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)} //no uid

function Get_WinReports_GrpOptions_LblSource(){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Source:"], 10)}

function Get_WinReports_GrpOptions_CmbSource(){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10)} //no uid

function Get_WinReports_GrpOptions_LblCurrentSelection()
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Sélection courante:*"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Current Selection:*"], 10)}
}

//Disponible pour les modules Clients, Relations et Modèles
function Get_WinReports_GrpOptions_LblAccountCriteria()
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Critère compte:"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Account Criteria:"], 10)}
}

//Disponible pour les modules Clients, Relations et Modèles
function Get_WinReports_GrpOptions_CmbAccountCriteria(){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "6"], 10)}//no uid

//Disponible pour les modules Comptes, Clients, Relations et Modèles
function Get_WinReports_GrpOptions_ChkArchiveReports()//no uid
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Archiver les rapports"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Archive Reports"], 10)}
}

function Get_WinReports_GrpHeader(){
  if (language == "french"){return Get_WinReports().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "En-tête"], 10)}
    else {return Get_WinReports().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Header"], 10)}
}

function Get_WinReports_GrpHeader_ChkRemoveName(){
  if (language == "french"){return Get_WinReports_GrpHeader().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Enlever le nom"], 10)}
  else {return Get_WinReports_GrpHeader().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Remove Name"], 10)}
}

function Get_WinReports_GrpHeader_CmbTitle(){
      return Get_WinReports_GrpHeader().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}


function Get_WinReports_GrpOptions_ChkAddBranchAddress()//no uid
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Ajouter l'adresse de la succursale"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Add Branch Address"], 10)}
}

function Get_WinReports_GrpOptions_ChkGroupInTheSameReport()//no uid
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Grouper dans un même rapport"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Group in the Same Report"], 10)}
}

function Get_WinReports_GrpOptions_ChkConsolidatePositions()//no uid
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Consolider les positions"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Consolidate positions"], 10)}
}
// ajout de la fonction get pour le check box Display account/client/relationship numbers in full qui est spécifique pour la US (90-04-49)
function Get_WinReports_GrpOptions_ChkDisplayAccountClientRelationshipNumbersInFull()//no uid
{
  if (language == "french"){ Log.Warning("Le nom du check box Display account/client/relationship numbers in full n'existe pas en français puisque ce champ est spécifique a US et pour la US on se connecte juste en anglais ")}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Display account/client/relationship numbers in full"], 10)}
}
function Get_WinReports_GrpOptions_ChkUsePDFFileNamingConvention()//no uid
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Utiliser la norme pour les noms de fichiers PDF"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Use PDF File Naming Convention"], 10)}
}

//Disponible pour le module Clients
function Get_WinReports_GrpOptions_ChkGroupUnderlyingClients()//no uid
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Grouper les clients sous-jacents"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Group Underlying Clients"], 10)}
}

//N'existe pas dans le common (ref. Automation 8)
function Get_WinReports_GrpOptions_GrpHeader()
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "En-tête"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Header"], 10)}
}

function Get_WinReports_GrpOptions_ChkUsePrinpalAddress()
{
  if (language == "french"){return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Utiliser l'adresse principale"], 10)}
  else {return Get_WinReports_GrpOptions().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Use primary address"], 10)}
}

//N'existe pas dans le common (ref. Automation 8)
function Get_WinReports_GrpOptions_GrpHeader_LblName()
{
  if (language == "french"){return Get_WinReports_GrpOptions_GrpHeader().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Nom:"], 10)}
  else {return Get_WinReports_GrpOptions_GrpHeader().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Name:"], 10)}
}

//N'existe pas dans le common (ref. Automation 8)
function Get_WinReports_GrpOptions_GrpHeader_CmbName(){return Get_WinReports_GrpOptions_GrpHeader().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

//N'existe pas dans le common (ref. Automation 8)
function Get_WinReports_GrpOptions_GrpHeader_LblTitle()
{
  if (language == "french"){return Get_WinReports_GrpOptions_GrpHeader().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Titre:"], 10)}
  else {return Get_WinReports_GrpOptions_GrpHeader().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Title:"], 10)}
}

//N'existe pas dans le common (ref. Automation 8)
function Get_WinReports_GrpOptions_GrpHeader_CmbTitle()
{
    if (Get_WinReports_GrpOptions_GrpHeader_LblName().Exists){return Get_WinReports_GrpOptions_GrpHeader().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}
    else {return Get_WinReports_GrpOptions_GrpHeader().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}
}

function Get_WinReports_GrpOptions_GrpHeader_ChkRemoveName()
{
  if (language == "french"){return Get_WinReports_GrpOptions_GrpHeader().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Enlever le nom"], 10)}
  else {return Get_WinReports_GrpOptions_GrpHeader().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Remove Name"], 10)}
}

function Get_WinReports_GrpOptions_GrpMessage(){return Get_WinReports().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Message"], 10)} //no uid

function Get_WinReports_GrpOptions_GrpMessage_ChkInclude() //no uid
{
  if (language == "french"){return Get_WinReports_GrpOptions_GrpMessage().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure"], 10)}
  else {return Get_WinReports_GrpOptions_GrpMessage().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include"], 10)}
}

function Get_WinReports_GrpOptions_GrpMessage_BtnEdit() //no uid
{
  if (language == "french"){return Get_WinReports_GrpOptions_GrpMessage().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Mo_difier"], 10)}
  else {return Get_WinReports_GrpOptions_GrpMessage().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Edit"], 10)}
}

//************************************* FENÊTRE EXPORT VERS MS WORD DE RAPPORTS*****************************************************//
//Reports--> Export to MS Word
function Get_winExportToMSWord(){return Aliases.CroesusApp.winExportToMSWord}

function Get_winExportToMSWord_BtnOK(){return Get_winExportToMSWord().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_winExportToMSWord_BtnCancel()
{
  if (language == "french"){return Get_winExportToMSWord().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_winExportToMSWord().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_winExportToMSWord_GrpRecipientsFrom()
{
  if (language == "french"){return Get_winExportToMSWord().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Destinataires du module"], 10)}
  else {return Get_winExportToMSWord().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Recipients From"], 10)}
}

function Get_winExportToMSWord_GrpRecipientsFrom_Clients(){return Get_winExportToMSWord().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Clients"], 10)}

function Get_winExportToMSWord_GrpMailMergeFields()
{
  if (language == "french"){return Get_winExportToMSWord().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Champs de fusion"], 10)}
  else {return Get_winExportToMSWord().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Mail merge fields"], 10)}
}

function Get_winExportToMSWord_GrpMailMergeFields_BtnRemoveAll()
{
  if (language == "french"){return Get_winExportToMSWord().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Enlever _tout"], 10)}
  else {return Get_winExportToMSWord().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "R_emove All"], 10)}
}

//************************************* FENÊTRE SAUVEGARDE DE RAPPORTS (SAVE REPORTS WINDOW) ************************************
// winReports --> btn Save 
function Get_WinSaveReports(){return Aliases.CroesusApp.winSaveReports}

function Get_WinSaveReports_LblSaveAs()

{
  if (language == "french"){return Get_WinSaveReports().FindChild(["ClrClassName", "Text"], ["UniLabel", "Enregistrer sous:"], 10)}
  else {return Get_WinSaveReports().FindChild(["ClrClassName", "Text"], ["UniLabel", "Save As:"], 10)}
}

function Get_WinSaveReports_TxtSaveAs(){return Get_WinSaveReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 10)}

function Get_WinSaveReports_BtnOK(){return Get_WinSaveReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinSaveReports_BtnCancel()
{
  if (language == "french"){return Get_WinSaveReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinSaveReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

//---> MenuReports_Get_Functions
//******************************************** FENÊTRE PARAMÈTRES DU RAPPORT (REPORT PARAMETERS WINDOW) *******************************************
//Reports 
function Get_WinParameters(){return Aliases.CroesusApp.winParameters}

function Get_WinParameters_BtnOK(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinParameters_BtnCancel()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}


function Get_WinParameters_ChkExcludeDataPrecedingTheManagementStartDate()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Exclure les données précédant la date de début de gestion"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Exclude data preceding the management start date"], 10)}
}


function Get_WinParameters_GrpIndices_ChkDisplayDefaultIndices()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Afficher les indices par défaut"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Display default indices"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniScrollPane", "1"], 10)}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexNASDAQ()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "INDICE, NASDAQ"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "INDEX, NASDAQ"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexNASDAQCOMP()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "INDICE, NASDAQ COMP"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "INDEX, NASDAQ COMP"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexDJII()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, DJII"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, DJII"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexDJIN()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, DJIN"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, DJIN"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexMCLEODBONDUNI()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, MCLEOD BOND UNI"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, MCLEOD BOND UNI"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexMSEAFE()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, MS EAFE"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, MS EAFE"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexNASDAQ100()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, NASDAQ 100"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, NASDAQ 100"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexSP()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, S&P"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, S&P"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexSP500()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, S&P 500"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, S&P 500"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexSP60()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, S&P 60"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, S&P 60"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexTSE100()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, TSE 100"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, TSE 100"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexTSE300()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, TSE 300"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, TSE 300"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexTSE35()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, TSE 35"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, TSE 35"], 10)}
}

function Get_WinParameters_GrpIndices_ChklstIndices_ChkIndexTSE60()
{
  if (language == "french"){return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice, TSE 60"], 10)}
  else {return Get_WinParameters_GrpIndices_ChklstIndices().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Index, TSE 60"], 10)}
}

function Get_WinParameters_GrpIndices_ChkUseIndexBaseCurrency()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Utiliser la devise de base des indices"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Use index base currency"], 10)}
}

function Get_WinParameters_GrpGraph()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Graphique"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Graph"], 10)}
}

function Get_WinParameters_GrpGraph_ChkIncludeGraph()
{
  if (language == "french"){return Get_WinParameters_GrpGraph().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure le graphique"], 10)}
  else {return Get_WinParameters_GrpGraph().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include Graph"], 10)}
}


function Get_WinParameters_GrpGraphs()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Graphiques*"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Graphs*"], 10)}
  
  //Old
  /*
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Graphiques (maximum 2)"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Graphs (Maximum 2)"], 10)}
  */
}

function Get_WinParameters_GrpGraphs_ChkAssetAllocation()
{
  if (language == "french"){return Get_WinParameters_GrpGraphs().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Répartition d'actifs"], 10)}
  else {return Get_WinParameters_GrpGraphs().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Asset Allocation"], 10)}
}

function Get_WinParameters_GrpGraphs_ChkRegionAllocation()
{
  if (language == "french"){return Get_WinParameters_GrpGraphs().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Répartition par région"], 10)}
  else {return Get_WinParameters_GrpGraphs().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Region Allocation"], 10)}
}

function Get_WinParameters_GrpGraphs_ChkInvestmentObjective()
{
  if (language == "french"){return Get_WinParameters_GrpGraphs().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Objectif de placement"], 10)} //Avant: ["UniCheckBox", "Objectif d'investissement"] modifié par A.A
  else {return Get_WinParameters_GrpGraphs().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Investment Objective"], 10)}
}

function Get_WinParameters_GrpGraphs_ChkPortfolioPerformance()
{
  if (language == "french"){return Get_WinParameters_GrpGraphs().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Performance du portefeuille"], 10)}
  else {return Get_WinParameters_GrpGraphs().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Portfolio Performance"], 10)}
}


function Get_WinParameters_GrpRiskMeasurement()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Mesure du risque"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Risk Measurement"], 10)}
}

function Get_WinParameters_GrpRiskMeasurement_ChkStandardDeviation()
{
  if (language == "french"){return Get_WinParameters_GrpRiskMeasurement().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Écart type"], 10)}
  else {return Get_WinParameters_GrpRiskMeasurement().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Standard Deviation"], 10)}
}

function Get_WinParameters_GrpRiskMeasurement_Chk3YearStandardDeviation()
{
  if (language == "french"){return Get_WinParameters_GrpRiskMeasurement().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Écart type 3 ans"], 10)}
  else {return Get_WinParameters_GrpRiskMeasurement().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "3-year Standard Deviation"], 10)}
}

function Get_WinParameters_GrpRiskMeasurement_Chk3YearStandDevIndices()
{
  if (language == "french"){return Get_WinParameters_GrpRiskMeasurement().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Écart type 3 ans - Indices"], 10)}
  else {return Get_WinParameters_GrpRiskMeasurement().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "3-year Stand. Dev. - Indices"], 10)}
}

function Get_WinParameters_GrpRiskMeasurement_ChkSharpeIndex()
{
  if (language == "french"){return Get_WinParameters_GrpRiskMeasurement().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice de Sharpe"], 10)}
  else {return Get_WinParameters_GrpRiskMeasurement().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Sharpe Index"], 10)}
}

function Get_WinParameters_GrpRiskMeasurement_ChkQuartile(){return Get_WinParameters_GrpRiskMeasurement().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Quartile"], 10)}

function Get_WinParameters_GrpRiskMeasurement_ChkPerformanceOfIndex()
{
  if (language == "french"){return Get_WinParameters_GrpRiskMeasurement().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Performance de l'indice"], 10)}
  else {return Get_WinParameters_GrpRiskMeasurement().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Performance of index"], 10)}
}

function Get_WinParameters_GrpLevel()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Niveau"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Level"], 10)}
}

function Get_WinParameters_GrpLevel_RdoAllRelationships()
{
  if (language == "french"){return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Toutes les relations"], 10)}
  else {return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "All Relationships"], 10)}
}

function Get_WinParameters_GrpLevel_RdoAllClients()
{
  if (language == "french"){return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Tous les clients"], 10)}
  else {return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "All Clients"], 10)}
}

function Get_WinParameters_GrpLevel_RdoAllAccounts()
{
  if (language == "french"){return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Tous les comptes"], 10)}
  else {return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "All Accounts"], 10)}
}

function Get_WinParameters_GrpLevel_RdoInvestmentAdvisor()
{
  if (language == "french"){return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Conseiller en placement"], 10)}
  else {return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Investment Advisor"], 10)}
}

function Get_WinParameters_GrpLevel_BtnInvestmentAdvisor(){return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 1], 10)}

function Get_WinParameters_GrpLevel_RdoBranch()
{
  if (language == "french"){return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Succursale"], 10)}
  else {return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Branch"], 10)}
}

function Get_WinParameters_GrpLevel_BtnBranch(){return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 2], 10)}

function Get_WinParameters_GrpLevel_RdoRegion()
{
  if (language == "french"){return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Région"], 10)}
  else {return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Region"], 10)}
}

function Get_WinParameters_GrpLevel_BtnRegion(){return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 3], 10)}

function Get_WinParameters_GrpLevel_RdoFirm()
{
  if (language == "french"){return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Firme"], 10)}
  else {return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Firm"], 10)}
}

function Get_WinParameters_GrpLevel_BtnFirm(){return Get_WinParameters_GrpLevel().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 4], 10)}


function Get_WinParameters_GrpAssetAllocation()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Répartition d'actifs"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Asset Allocation"], 10)}
}

function Get_WinParameters_GrpAssetAllocation_RdoBasic()
{
  if (language == "french"){return Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "De base"], 10)}
  else {return Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Basic"], 10)}
}

function Get_WinParameters_GrpAssetAllocation_RdoFirm()
{
  if (language == "french"){return Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "De la firme"], 10)}
  else {return Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Firm"], 10)}
}

function Get_WinParameters_GrpAssetAllocation_RdoCustom()
{
  if (language == "french"){return Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Personnalisée"], 10)}
  else {return Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Custom"], 10)}
}

function Get_WinParameters_GrpAssetAllocation_CmbCustomAllocation(){return Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinParameters_GrpAssetAllocation_ChkUseTheSpecifiedInvestmentObjective()
{
  if (language == "french"){return Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Utiliser l'objectif de placement défini"], 10)}
  else {return Get_WinParameters_GrpAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Use the specified investment objective"], 10)}
}


function Get_WinParameters_GrpPerformanceFees()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Performance - Frais"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Performance - Fees"], 10)}
}

function Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedNetOfFees()
{
  if (language == "french"){return Get_WinParameters_GrpPerformanceFees().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Rendement pondéré dans le temps (net)"], 10)}
  else {return Get_WinParameters_GrpPerformanceFees().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Time-Weighted (net of fees)"], 10)}
}

function Get_WinParameters_GrpPerformanceFees_ChkTimeWeightedGrossOfFees()
{
  if (language == "french"){return Get_WinParameters_GrpPerformanceFees().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Rendement pondéré dans le temps (brut)"], 10)}
  else {return Get_WinParameters_GrpPerformanceFees().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Time-Weighted (gross of fees)"], 10)}
}

function Get_WinParameters_GrpPerformanceFees_ChkMoneyWeightedNetOfFees()
{
  if (language == "french"){return Get_WinParameters_GrpPerformanceFees().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Rendement pondéré en dollars (net)"], 10)}
  else {return Get_WinParameters_GrpPerformanceFees().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Money-Weighted (net of fees)"], 10)}
}


function Get_WinParameters_GrpPerformanceCalculations()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Performance - Calculs"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Performance - Calculations"], 10)}
}

function Get_WinParameters_GrpPerformanceCalculations_RdoTotalPerformance()
{
  if (language == "french"){return Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Performance totale"], 10)}
  else {return Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Total Performance"], 10)}
}

function Get_WinParameters_GrpPerformanceCalculations_RdoROIWithoutLeverage()
{
  if (language == "french"){return Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "RCI sans levier"], 10)}
  else {return Get_WinParameters_GrpPerformanceCalculations().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "ROI Without Leverage"], 10)}
}


function Get_WinParameters_GrpPeriod()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Période"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Period"], 10)}
}

function Get_WinParameters_GrpPeriod_LblEndDate()
{
  if (language == "french"){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Date de fin:"], 10)}
  else {return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "End Date:"], 10)}
}

function Get_WinParameters_GrpPeriod_DtpEndDate(){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinParameters_GrpPeriod_LblPeriod()
{
  if (language == "french"){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Période:"], 10)}
  else {return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Period:"], 10)}
}

function Get_WinParameters_GrpPeriod_CmbPeriod(){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinParameters_GrpPeriod_LblPeriod1()
{
  if (language == "french"){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Période 1:"], 10)}
  else {return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Period 1:"], 10)}
}

function Get_WinParameters_GrpPeriod_CmbPeriod1(){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinParameters_GrpPeriod_LblPeriod2()
{
  if (language == "french"){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Période 2:"], 10)}
  else {return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Period 2:"], 10)}
}

function Get_WinParameters_GrpPeriod_CmbPeriod2(){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinParameters_GrpPeriod_LblPeriod3()
{
  if (language == "french"){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Période 3:"], 10)}
  else {return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Period 3:"], 10)}
}

function Get_WinParameters_GrpPeriod_CmbPeriod3(){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)}

function Get_WinParameters_GrpPeriod_LblPeriod4()
{
  if (language == "french"){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Période 4:"], 10)}
  else {return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Period 4:"], 10)}
}

function Get_WinParameters_GrpPeriod_CmbPeriod4(){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10)}

function Get_WinParameters_GrpPeriod_LblPeriod5()
{
  if (language == "french"){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Période 5:"], 10)}
  else {return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Period 5:"], 10)}
}

function Get_WinParameters_GrpPeriod_CmbPeriod5(){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "6"], 10)}

function Get_WinParameters_GrpPeriod_LblPeriod6()
{
  if (language == "french"){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Période 6:"], 10)}
  else {return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Period 6:"], 10)}
}

function Get_WinParameters_GrpPeriod_CmbPeriod6(){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 7], 10)}

function Get_WinParameters_GrpPeriod_LblPeriod7()
{
  if (language == "french"){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Période 7:"], 10)}
  else {return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "Text"], ["UniLabel", "Period 7:"], 10)}
}

function Get_WinParameters_GrpPeriod_CmbPeriod7(){return Get_WinParameters_GrpPeriod().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 8], 10)}


function Get_WinParameters_LblNumbering()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Pagination:"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Numbering:"], 10)}
}

function Get_WinParameters_CmbNumbering1(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}

function Get_WinParameters_CmbDateOfDetention(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}

function Get_WinParameters_CmbNumbering2(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 2], 0)}

function Get_WinParameters_CmbNumbering3(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 3], 0)}

function Get_WinParameters_CmbNumberingForPortfolioPerformance(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 0)}

function Get_WinParameters_CmbNumberingForPortfolioPerformanceGraph(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 0)}

function Get_WinParameters_ChkDisplayDetails()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Afficher le détail"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Display Details"], 10)}
}

function Get_WinParameters_ChkPreviousCalendarYear()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Année civile précédente"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Previous Calendar Year"], 10)}
}

function Get_WinParameters_LblStartDate()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Date de début:"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Start Date:"], 10)}
}

function Get_WinParameters_DtpStartDate(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinParameters_LblEndDate()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Date de fin:"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "End Date:"], 10)}
}

function Get_WinParameters_DtpEndDate(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", 1], 10)}

function Get_WinParameters_DtpEndDate2(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", 2], 10)}

function Get_WinParameters_DtpEndDateForPortfolioPerformancePeriod(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", 2], 10)}

function Get_WinParameters_LblPeriod1()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Période 1:"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Period 1:"], 10)}
}

function Get_WinParameters_CmbPeriod1(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 0)}


function Get_WinParameters_GrpData()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Données"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Data"], 10)}
}

function Get_WinParameters_GrpData_RdoMonthly()
{
  if (language == "french"){return Get_WinParameters_GrpData().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Mensuelles"], 10)}
  else {return Get_WinParameters_GrpData().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Monthly"], 10)}
}

function Get_WinParameters_GrpData_RdoQuarterly()
{
  if (language == "french"){return Get_WinParameters_GrpData().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Trimestrielles"], 10)}
  else {return Get_WinParameters_GrpData().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Quarterly"], 10)}
}

function Get_WinParameters_GrpData_RdoAnnual()
{
  if (language == "french"){return Get_WinParameters_GrpData().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Annuelles"], 10)}
  else {return Get_WinParameters_GrpData().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Annual"], 10)}
}


function Get_WinParameters_GrpInclude()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Inclure"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Include"], 10)}
}

function Get_WinParameters_GrpInclude_ChkProfile()
{
  if (language == "french"){return Get_WinParameters_GrpInclude().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Profil"], 10)}
  else {return Get_WinParameters_GrpInclude().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Profile"], 10)}
}

function Get_WinParameters_GrpInclude_ChkNotes(){return Get_WinParameters_GrpInclude().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Notes"], 10)}

function Get_WinParameters_GrpInclude_ChkEventHistory()
{
  if (language == "french"){return Get_WinParameters_GrpInclude().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Historique des évènements"], 10)}
  else {return Get_WinParameters_GrpInclude().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Event History"], 10)}
}


function Get_WinParameters_LblAsOf()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Au:"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "As of:"], 10)}
}

function Get_WinParameters_DtpAsOf(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", 1], 10)}


function Get_WinParameters_ChkIncludeGraph()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure le graphique"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include Graph"], 10)}
}

function Get_WinParameters_CmbTitle(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}


function Get_WinParameters_GrpGroupBy()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Grouper par"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Group By"], 10)}
}

function Get_WinParameters_GrpGroupBy_ChkRegion()
{
  if (language == "french"){return Get_WinParameters_GrpGroupBy().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Région"], 10)}
  else {return Get_WinParameters_GrpGroupBy().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Region"], 10)}
}

function Get_WinParameters_GrpGroupBy_ChkIndustryCode()
{
  if (client == "RJ"){
    if (language == "french"){return Get_WinParameters_GrpGroupBy().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Secteur"], 10)}
    else {return Get_WinParameters_GrpGroupBy().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Sector"], 10)}
  }
  else {
    if (language == "french"){return Get_WinParameters_GrpGroupBy().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Secteur d'activité"], 10)}
    else {return Get_WinParameters_GrpGroupBy().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Industry Code"], 10)}
  }
}

function Get_WinParameters_GrpGroupBy_CmbIndustryCode(){return Get_WinParameters_GrpGroupBy().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinParameters_GrpGroupBy_ChkAccountCurrency()
{
  if (language == "french"){return Get_WinParameters_GrpGroupBy().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Devise du compte"], 10)}
  else {return Get_WinParameters_GrpGroupBy().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Account Currency"], 10)}
}


function Get_WinParameters_ChkIncludePortfolioValue()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure la valeur du portefeuille (%)"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include portfolio (%) value"], 10)}
}


function Get_WinParameters_GrpCostCalculation()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Calcul du coût"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Cost Calculation"], 10)}
}

function Get_WinParameters_GrpCostCalculation_RdoInvestedCapital()
{
  if (language == "french"){return Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Capital investi"], 10)}
  else {return Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Invested Capital"], 10)}
}

function Get_WinParameters_GrpCostCalculation_RdoBookValue()
{
  if (language == "french"){return Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Valeur comptable"], 10)}
  else {return Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Book Value"], 10)}
}

function Get_WinParameters_GrpCostCalculation_RdoCostBasis()
{
  if (language == "english" && client == "US"){return Get_WinParameters_GrpCostCalculation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Cost Basis"], 10)}
  else {Log.Error("The 'Cost Basis' radio button is only available for US client")}
}

function Get_WinParameters_GrpCostDisplayed()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Coût affiché"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Cost Displayed"], 10)}
}

function Get_WinParameters_GrpCostDisplayed_ChkTheoreticalValue()
{
  if (language == "french"){return Get_WinParameters_GrpCostDisplayed().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Valeur théorique"], 10)}
  else {return Get_WinParameters_GrpCostDisplayed().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Theoretical Value"], 10)}
}


function Get_WinParameters_GrpFundBreakdown()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Ventilation des fonds"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Fund Breakdown"], 10)}
}

function Get_WinParameters_GrpFundBreakdown_ChkClassBreakdown()
{
  if (language == "french"){return Get_WinParameters_GrpFundBreakdown().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Répartir entre les classes"], 10)}
  else {return Get_WinParameters_GrpFundBreakdown().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Class Breakdown"], 10)}
}

function Get_WinParameters_GrpFundBreakdown_ChkAppendix()
{
  if (language == "french"){return Get_WinParameters_GrpFundBreakdown().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Annexe"], 10)}
  else {return Get_WinParameters_GrpFundBreakdown().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Appendix"], 10)}
}


function Get_WinParameters_ChkIncludeAmortizedIncome()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure l'amortissement du revenu"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include Amortized Income"], 10)}
}


function Get_WinParameters_ChkComparative()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Comparatif"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Comparative"], 10)}
}


function Get_WinParameters_LblSortBy()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Trier par:"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Sort by:"], 10)}
}

function Get_WinParameters_CmbSortBy1(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}

function Get_WinParameters_CmbSortBy2(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 2], 0)}


function Get_WinParameters_ChkIncludeInterestAndDividends()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure intérêts et dividendes"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include Interest and Dividends"], 10)}
}

function Get_WinParameters_ChkIncludeTotalGainAndLossBreakdown()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure la répartition des gains et pertes"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include Total Gain and Loss Breakdown"], 10)}
}

function Get_WinParameters_ChkIncludeNonregisteredAccountsOnly()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure uniquement les comptes non enregistrés"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include Non-registered Accounts Only"], 10)}
}



function Get_WinParameters_ChkExcludeClientAddress()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Exclure l'adresse du client"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Exclude Client Address"], 10)}
}

function Get_WinParameters_ChkExcludeRelationshipAddress()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Exclure l'adresse de la relation"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Exclude Relationship Address"], 10)}
}




function Get_WinParameters_ChkGroupBySecurity()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Grouper par titre"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Group by Security"], 10)}
}

function Get_WinParameters_ChkOneReportPerAccount()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Un rapport par compte"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "One Report per Account"], 10)}
}


function Get_WinParameters_GrpTransactionDate()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Date de transaction"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Transaction Date"], 10)}
}

function Get_WinParameters_GrpTransactionDate_RdoTradeDate()
{
  if (language == "french"){return Get_WinParameters_GrpTransactionDate().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Date de transaction"], 10)}
  else {return Get_WinParameters_GrpTransactionDate().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Trade Date"], 10)}
}

function Get_WinParameters_GrpTransactionDate_RdoSettlementDate()
{
  if (language == "french"){return Get_WinParameters_GrpTransactionDate().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Date de règlement"], 10)}
  else {return Get_WinParameters_GrpTransactionDate().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Settlement Date"], 10)}
}


function Get_WinParameters_LblIndustryCode()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Secteur d'activité:"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Industry Code:"], 10)}
}

function Get_WinParameters_CmbIndustryCode(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}


function Get_WinParameters_GrpType(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Type"], 10)}

function Get_WinParameters_GrpType_RdoHistogram()
{
  if (language == "french"){return Get_WinParameters_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Histogramme"], 10)}
  else {return Get_WinParameters_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Histogram"], 10)}
}

function Get_WinParameters_GrpType_RdoPieGraph()
{
  if (language == "french"){return Get_WinParameters_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Graphique circulaire"], 10)}
  else {return Get_WinParameters_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Pie Graph"], 10)}
}

function Get_WinParameters_GrpType_CmbType(){return Get_WinParameters_GrpType().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinParameters_GrpType_ChkComparative()
{
  if (language == "french"){return Get_WinParameters_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Comparatif"], 10)}
  else {return Get_WinParameters_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Comparative"], 10)}
}


function Get_WinParameters_GrpTransactionTypes()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Types de transactions"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Transaction Types"], 10)}
}

function Get_WinParameters_GrpTransactionTypes_ChklstTransactionTypes(){return Get_WinParameters_GrpTransactionTypes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniScrollPane", 1], 10)}

function Get_WinParameters_GrpTransactionTypes_BtnSelectAll()
{
  if (language == "french"){return Get_WinParameters_GrpTransactionTypes().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Sélectionner tout"], 10)}
  else {return Get_WinParameters_GrpTransactionTypes().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Selec_t All"], 10)}
}

function Get_WinParameters_GrpTransactionTypes_BtnRemoveAll()
{
  if (language == "french"){return Get_WinParameters_GrpTransactionTypes().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Enlever _tout"], 10)}
  else {return Get_WinParameters_GrpTransactionTypes().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "R_emove All"], 10)}
}


function Get_WinParameters_ChkGroupByRecord()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Grouper par enregistrement (compte, client, relation)"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Group by Record (Client, Account, Relationship)"], 10)}
}

function Get_WinParameters_ChkGroupByTransactionType()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Grouper par type de transaction"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Group by Transaction Type"], 10)}
}


function Get_WinParameters_GrpSectionsToInclude()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Sections à inclure"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Sections to Include"], 10)}
}

function Get_WinParameters_GrpSectionsToInclude_RdoProductMappings()
{
  if (language == "french"){return Get_WinParameters_GrpSectionsToInclude().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Correspondances de produit"], 10)}
  else {return Get_WinParameters_GrpSectionsToInclude().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Product Mappings"], 10)}
}

function Get_WinParameters_GrpSectionsToInclude_RdoSecondaryProductMappings()
{
  if (language == "french"){return Get_WinParameters_GrpSectionsToInclude().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Correspondances de produit secondaire"], 10)}
  else {return Get_WinParameters_GrpSectionsToInclude().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Secondary Product Mappings"], 10)}
}

function Get_WinParameters_GrpSectionsToInclude_RdoBoth()
{
  if (language == "french"){return Get_WinParameters_GrpSectionsToInclude().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Les deux"], 10)}
  else {return Get_WinParameters_GrpSectionsToInclude().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Both"], 10)}
}


function Get_WinParameters_LblYear()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Année:"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Year:"], 10)}
}

function Get_WinParameters_CmbYear(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}


function Get_WinParameters_ChkUntilMaturity()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Jusqu'à échéance"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Until Maturity"], 10)}
}


function Get_WinParameters_ChkAllRecords()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Tous les enregistrements"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "All Records"], 10)}
}


function Get_WinParameters_ChkDisplayCheckDigit()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Chiffre vérificateur"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Display check digit"], 10)}
}


function Get_WinParameters_ChkSeparateTheContributionsMadeInTheFirst60Days()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Séparer les cotisations des 60 premiers jours"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Separate the contributions made in the first 60 days"], 10)}
}


function Get_WinParameters_LblLimit()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Limite:"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Limit:"], 10)}
}

function Get_WinParameters_CmbLimit(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}


function Get_WinParameters_LblPositionState()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "État des positions:"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Position State:"], 10)}
}

function Get_WinParameters_CmbPositionState(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}


function Get_WinParameters_GrpTransactions(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Transactions"], 10)}

function Get_WinParameters_GrpTransactions_RdoSummary()
{
  if (language == "french"){return Get_WinParameters_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Sommaire"], 10)}
  else {return Get_WinParameters_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Summary"], 10)}
}

function Get_WinParameters_GrpTransactions_RdoDetailed()
{
  if (language == "french"){return Get_WinParameters_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Détaillé"], 10)}
  else {return Get_WinParameters_GrpTransactions().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Detailed"], 10)}
}


function Get_WinParameters_Grp(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", ""], 10)}

function Get_WinParameters_Grp_RdoName()
{
  if (language == "french"){return Get_WinParameters_Grp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Nom"], 10)}
  else {return Get_WinParameters_Grp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Name"], 10)}
}

function Get_WinParameters_Grp_RdoFullName()
{
  if (language == "french"){return Get_WinParameters_Grp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Nom complet"], 10)}
  else {return Get_WinParameters_Grp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Full Name"], 10)}
}


function Get_WinParameters_GrpOrder()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Ordre"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Order"], 10)}
}

function Get_WinParameters_GrpOrder_LblSortBy()
{
  if (language == "french"){return Get_WinParameters_GrpOrder().FindChild(["ClrClassName", "Text"], ["UniLabel", "Trier par:"], 10)}
  else {return Get_WinParameters_GrpOrder().FindChild(["ClrClassName", "Text"], ["UniLabel", "Sort by:"], 10)}
}

function Get_WinParameters_GrpOrder_CmbSortBy(){return Get_WinParameters_GrpOrder().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinParameters_GrpOrder_GrpAscendingDescending(){return Get_WinParameters_GrpOrder().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", ""], 10)}

function Get_WinParameters_GrpOrder_GrpAscendingDescending_RdoAscending()
{
  if (language == "french"){return Get_WinParameters_GrpOrder_GrpAscendingDescending().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Croissant"], 10)}
  else {return Get_WinParameters_GrpOrder_GrpAscendingDescending().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Ascending"], 10)}
}

function Get_WinParameters_GrpOrder_GrpAscendingDescending_RdoDescending()
{
  if (language == "french"){return Get_WinParameters_GrpOrder_GrpAscendingDescending().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Décroissant"], 10)}
  else {return Get_WinParameters_GrpOrder_GrpAscendingDescending().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Descending"], 10)}
}

function Get_WinParameters_GrpWeight()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Pondération"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Weight"], 10)}
}

function Get_WinParameters_GrpWeight_ChkAccountsNotWeighted()
{
  if (language == "french"){return Get_WinParameters_GrpWeight().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Comptes non pondérés"], 10)}
  else {return Get_WinParameters_GrpWeight().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Accounts not Weighted"], 10)}
}

function Get_WinParameters_GrpWeight_ChkIACodesNotWeighted()
{
  if (language == "french"){return Get_WinParameters_GrpWeight().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Codes de CP non pondérés"], 10)}
  else {return Get_WinParameters_GrpWeight().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "IA Codes not Weighted"], 10)}
}


function Get_WinParameters_ChkIncludeTheSourceColumn()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure la colonne Source"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include the Source Column"], 10)}
}


function Get_WinParameters_ChkPerfStartEndValues()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Perf. + valeurs de dép/fin"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Perf. + start/end values"], 10)}
}


function Get_WinParameters_GrpComparative()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Comparatif"], 10)} //Sur Neo-59, c'est "Écart"
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Comparative"], 10)} //Sur Neo-59, c'est "Difference"
}

function Get_WinParameters_GrpComparative_ChkPerformance(){return Get_WinParameters_GrpComparative().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Performance"], 10)}

function Get_WinParameters_GrpComparative_ChkStandardDeviation()
{
  if (language == "french"){return Get_WinParameters_GrpComparative().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Écart type"], 10)}
  else {return Get_WinParameters_GrpComparative().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Standard Deviation"], 10)}
}

function Get_WinParameters_GrpComparative_ChkSharpeIndex()
{
  if (language == "french"){return Get_WinParameters_GrpComparative().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Indice de Sharpe"], 10)}
  else {return Get_WinParameters_GrpComparative().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Sharpe Index"], 10)}
}

function Get_WinParameters_GrpComparative_LblReferentialIndex()
{
  if (language == "french"){return Get_WinParameters_GrpComparative().FindChild(["ClrClassName", "Text"], ["UniLabel", "Indice de référence:"], 10)}
  else {return Get_WinParameters_GrpComparative().FindChild(["ClrClassName", "Text"], ["UniLabel", "Referential Index:"], 10)}
}

function Get_WinParameters_GrpComparative_CmbReferentialIndex(){return Get_WinParameters_GrpComparative().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}


function Get_WinParameters_GrpSeverity()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Sévérité"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Severity"], 10)}
}

function Get_WinParameters_GrpSeverity_ChkHard()
{
  if (language == "french"){return Get_WinParameters_GrpSeverity().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Bloquante"], 10)}
  else {return Get_WinParameters_GrpSeverity().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Hard"], 10)}
}

function Get_WinParameters_GrpSeverity_ChkSoft()
{
  if (language == "french"){return Get_WinParameters_GrpSeverity().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Non bloquante"], 10)}
  else {return Get_WinParameters_GrpSeverity().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Soft"], 10)}
}


function Get_WinParameters_GrpAccess()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Accès"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Access"], 10)}
}

function Get_WinParameters_GrpAccess_ChkFirm()
{
  if (language == "french"){return Get_WinParameters_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Firme"], 10)}
  else {return Get_WinParameters_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Firm"], 10)}
}

function Get_WinParameters_GrpAccess_ChkIA()
{
  if (language == "french"){return Get_WinParameters_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "CP"], 10)}
  else {return Get_WinParameters_GrpAccess().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "IA"], 10)}
}


function Get_WinParameters_GrpStatus()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "État"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Status"], 10)}
}

function Get_WinParameters_GrpStatus_ChkTriggered()
{
  if (language == "french"){return Get_WinParameters_GrpStatus().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Déclenchée (ou déclenchée par une note)"], 10)}
  else {return Get_WinParameters_GrpStatus().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Triggered (or triggered by a note)"], 10)}
}

function Get_WinParameters_GrpStatus_ChkNotTriggered()
{
  if (language == "french"){return Get_WinParameters_GrpStatus().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Non déclenchée"], 10)}
  else {return Get_WinParameters_GrpStatus().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Not Triggered"], 10)}
}


function Get_WinParameters_LblCodes(){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Codes:"], 10)}

function Get_WinParameters_CmbCodes(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}


function Get_WinParameters_LblDateType()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Type de date:"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Date Type:"], 10)}
}

function Get_WinParameters_CmbDateType(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}


function Get_WinParameters_CmbStartDateMonth(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}

function Get_WinParameters_CmbStartDateYear(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 2], 0)}


function Get_WinParameters_GrpDetailedSectionValue()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Valeur pour la section détaillée"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Detailed Section Value"], 10)}
}

function Get_WinParameters_GrpDetailedSectionValue_RdoMarketValue()
{
  if (language == "french"){return Get_WinParameters_GrpDetailedSectionValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Valeur de marché"], 10)}
  else {return Get_WinParameters_GrpDetailedSectionValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Market value"], 10)}
}

function Get_WinParameters_GrpDetailedSectionValue_RdoBookValue()
{
  if (language == "french"){return Get_WinParameters_GrpDetailedSectionValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Valeur comptable"], 10)}
  else {return Get_WinParameters_GrpDetailedSectionValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Book value"], 10)}
}

function Get_WinParameters_ChkIncludeSummaryTable()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure un tableau sommaire"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include Summary Table"], 10)}
}


function Get_WinParameters_GrpSummaryTableValue()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Valeur pour le tableau sommaire"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Summary Table Value"], 10)}
}

function Get_WinParameters_GrpSummaryTableValue_SameValueAsDetailedSection()
{
  if (language == "french"){return Get_WinParameters_GrpSummaryTableValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Même valeur que la section détaillée"], 10)}
  else {return Get_WinParameters_GrpSummaryTableValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Same value as detailed section"], 10)}
}

function Get_WinParameters_GrpSummaryTableValue_MarketAndBookValue()
{
  if (language == "french"){return Get_WinParameters_GrpSummaryTableValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Valeur de marché et comptable"], 10)}
  else {return Get_WinParameters_GrpSummaryTableValue().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Market and book value"], 10)}
}


function Get_WinParameters_ChkReportUnidentifiedSecurities()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Rapporter les titres non-reconnus"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Report Unidentified Securities"], 10)}
}

function Get_WinParameters_ChkMorningstarDisclaimer()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Avis de non-responsabilité Morningstar"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Morningstar Disclaimer"], 10)}
}


function Get_WinParameters_GrpNonAnnualizedReturns()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Rendement non annualisé"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Non-annualized Returns"], 10)}
}

function Get_WinParameters_GrpNonAnnualizedReturns_ChkIncludeNonAnnualizedReturns()
{
  if (language == "french"){return Get_WinParameters_GrpNonAnnualizedReturns().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure rendement non annualisé"], 10)}
  else {return Get_WinParameters_GrpNonAnnualizedReturns().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include Non-annualized Returns"], 10)}
}

function Get_WinParameters_ChkOneFilePerLanguage()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Un fichier par langue"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "One File per Language"], 10)}
}

function Get_WinParameters_CmbLanguage(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}

function Get_WinParameters_TxtFileName(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 0)}

function Get_WinParameters_TxtReportTitle(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 2], 0)}

function Get_WinParameters_ChkUseDefaultTheme()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Utiliser le thème par défaut"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Use Default Theme"], 10)}
}


//***** Paramètres du rapport Frais de gestion (Management Fees report parameters) *****

function Get_WinParameters_ChkIncludeGrid()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Inclure la grille"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Include Grid"], 10)}
}

function Get_WinParameters_LblBillingDate()
{
  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Date de facturation"], 10)}
  else {return Get_WinParameters().FindChild(["ClrClassName", "Text"], ["UniLabel", "Billing Date"], 10)}
}

function Get_WinParameters_CmbBillingDateMonth(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 0)}

function Get_WinParameters_CmbBillingDateMonth_Item(monthNameInFrench, monthNameInEnglish)
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", monthNameInFrench], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", monthNameInEnglish], 10)}
}

function Get_WinParameters_CmbBillingDateYear(){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 2], 0)}

function Get_WinParameters_CmbBillingDateYear_Item(year){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", year], 10)}

//--->fin  Menu Reports_Get_Functions