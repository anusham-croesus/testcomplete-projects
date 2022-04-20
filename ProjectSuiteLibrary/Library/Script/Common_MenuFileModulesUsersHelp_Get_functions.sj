//USEUNIT Global_variables

//++++++++++++++++++++++++++++++++++ MENU FICHIER (FILE MENU) +++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++ MENUBAR ++++++++++++++++++++++++++++++
function Get_CroesusApp(){return Aliases.CroesusApp}

function Get_MenuBar(){return Aliases.CroesusApp.winMain.barMenu}

function Get_SubMenus(){return Aliases.CroesusApp.subMenus}

function Get_MenuBar_File(){return Get_MenuBar().FindChild("Uid", "CustomizableMenu_bad4", 10)} 

function Get_MenuBar_File_Close(){return Get_CroesusApp().FindChildEx("Uid", "CFMenuItem_24b5", 10, true, -1)} 

function Get_MenuBar_File_Options(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_fe66", 10)} 

function Get_MenuBar_File_Preferences(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_d459", 10)} 

//Applicable aux modules Titres, Modèles, Relations, Clients, Comptes, Transactions
function Get_MenuBar_File_Print(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_2683", 10)}

function Get_MenuBar_File_Lock(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_9f4d", 10)}

//Traces de vérification (Audit trail) disponible seulement quand le module Modèle est activé
function Get_MenuBar_File_AuditTrail(){return Get_SubMenus().menuFileAuditTrail} // il faut modifier - non disponible dans Automation 8

//Imprimer pour le module Tableau de board
function Get_MenuBar_File_PrintForDashboard(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_d959", 10)}

function Get_MenuBar_File_PrintForDashboard_EveryBoard()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Tous les tableaux"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Every Board"], 10)}
}

function Get_MenuBar_File_PrintForDashboard_MyTasks()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Mes tâches"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "My Tasks"], 10)}
}

function Get_MenuBar_File_PrintForDashboard_MyOpenTasks()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Mes tâches ouvertes"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "My Open Tasks"], 10)}
}

//++++++++++++++++++++++++++++++++++ MENU MODULES (MODULES MENU) ++++++++++++++++++++++++++++++++++

function Get_MenuBar_Modules(){return Get_MenuBar().FindChild("Uid", "CustomizableMenu_853c", 10)} //ok

function Get_MenuBar_Modules_Dashboard(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_944c", 10)} //ok

function Get_MenuBar_Modules_Models(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_0ab8", 10)} //ok

function Get_MenuBar_Modules_Models_GoTo(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_a6ac", 10)} //ok

function Get_MenuBar_Modules_Models_DragSelection(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_aba8", 10)} //ok

function Get_MenuBar_Modules_Relationships(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_d6a9", 10)} //ok

function Get_MenuBar_Modules_Relationships_GoTo(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_656b", 10)} //ok

function Get_MenuBar_Modules_Relationships_DragSelection(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_2435", 10)} //ok

function Get_MenuBar_Modules_Clients(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_4e8b", 10)} //ok

function Get_MenuBar_Modules_Clients_GoTo(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_d302", 10)} //ok

function Get_MenuBar_Modules_Clients_DragSelection(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_0d83", 10)} //ok

function Get_MenuBar_Modules_Accounts(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_8159", 10)} //ok

function Get_MenuBar_Modules_Accounts_GoTo(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_ced5", 10)} //ok

function Get_MenuBar_Modules_Accounts_DragSelection(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_e9d6", 10)} //ok

function Get_MenuBar_Modules_Portfolio(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_85b4", 10)} //ok

function Get_MenuBar_Modules_Portfolio_GoTo(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_8a7c", 10)} //ok

function Get_MenuBar_Modules_Portfolio_DragSelection(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_edd3", 10)} //ok

function Get_MenuBar_Modules_Transactions(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_95e1", 10)} //ok

function Get_MenuBar_Modules_Transactions_GoTo(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_369d", 10)} //ok

function Get_MenuBar_Modules_Transactions_DragSelection(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_92ff", 10)} //ok

function Get_MenuBar_Modules_Securities(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_aef0", 10)} //ok

function Get_MenuBar_Modules_Securities_GoTo(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_7926", 10)} //ok

function Get_MenuBar_Modules_Securities_DragSelection(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_088b", 10)} //ok

//+++++++++++++++++++++++++++ MENU UTILISATEURS (USERS MENU) +++++++++++++++++++++++++++++++++

function Get_MenuBar_Users(){return Get_MenuBar().FindChild("Uid", "CustomizableMenu_b7fb", 10)}

function Get_MenuBar_Users_Selection()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Sélection..."], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Selection..."], 10)}
}

function Get_MenuBar_Users_Firm()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Firme"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Firm"], 10)}
}

function Get_MenuBar_Users_Branch()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Succursale"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Branch"], 10)}
}

function Get_MenuBar_Users_UserName(username){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", username], 10)}

function Get_MenuBar_Users_UserName_All()
{
  if (language == "french"){return Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Tous"], 10)}
  else {return Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "All"], 10)}
}

function Get_MenuBar_Users_UserName_BD88(){return Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "BD88"], 10)}

function Get_MenuBar_Users_RememberMySelection(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_477d", 10)}

function Get_MenuBar_Users_RememberMySelection_CheckboxImage(){return Get_MenuBar_Users_RememberMySelection().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", 1], 10)}

//+++++++++++++++++++++++++++++ MENU AIDE (HELP MENU) ++++++++++++++++++++++++++++++++++++++++++++

function Get_MenuBar_Help(){return Get_MenuBar().FindChild("Uid", "CustomizableMenu_3049", 10)}//ok

function Get_MenuBar_Help_ContentsAndIndex(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_5c52", 10)}//ok

function Get_MenuBar_Help_WhatsNew(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_35df", 10)}//ok

function Get_MenuBar_Help_ShortcutKeys(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_5110", 10)}//ok

function Get_MenuBar_Help_AboutCroesus(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_cf20", 10)}//ok

//+++++++++++++++++++++++++++++ MENU DEBUG ++++++++++++++++++++++++++++++++++++++++++++

function Get_MenuBar_Debug(){return Get_MenuBar().FindChild("Uid", "CustomizableMenu_ed9d", 10)}

//Dev
function Get_MenuBar_Debug_Dev(){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["CustomizableMenu","Dev"], 10)}

//{return Get_SubMenus().FindChild("Uid", "CustomizableMenu_26e3", 10)}//Même UID que le menu open folder

//Open Folder
function  Get_MenuBar_Debug_OpenFolder(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_26e3", 10)}//Même UID que le menu Dev

//Show Gdo Tool
function  Get_MenuBar_Debug_ShowGdoTool(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_ec04", 10)}

//Show Investigation Tools
function  Get_MenuBar_Debug_ShowInvestigationTools(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_976a", 10)}

//Gestionnaire de retraitement  /Reprocessing Manager
function Get_MenuBar_Debug_ReprocessingManager(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_5783", 10)}

/******************************************************************************************************/

//Fenêtre de gestionnaire de retraitement/ Reprocessing Manager
function Get_WinReprocessingManager(){return Aliases.CroesusApp.winReprocessingManager}

function Get_WinReprocessingManager_DgvReprocessingManager(){return Get_WinReprocessingManager().FindChild("Uid", "DataGrid_010e", 20)}  


//Fenêtre de résultat de retraitement/ Reprocess Result

function Get_WinReprocessResult(){return Aliases.CroesusApp.winReprocessResult}

function Get_WinReprocessResult_DgvReprocessTransactions(){return Get_WinReprocessResult().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ReprocessTransactionsGrid", 1], 10)}//DataGrid_7f45 même UID que la Grid Get_WinReprocessParameters_DgvReprocessPositions


//Bouton Lancer retraitement /Start Reprocessing

function Get_WinUserMultiSelection_BtnStartReprocessing()
  {
     if (language == "french"){return Get_WinReprocessingManager().FindChild(["ClrClassName", "WPFControlText"], ["Button","Lancer retraitement"], 10)}
     else {return Get_WinReprocessingManager().FindChild(["ClrClassName", "WPFControlText"], ["Button","Start Reprocessing"], 10)}
  }

  
//Bouton Résultat du retraitement /Result Reprocessing

function Get_WinUserMultiSelection_BtnReprocessingResult()
  {
     if (language == "french"){return Get_WinReprocessingManager().FindChild(["ClrClassName", "WPFControlText"], ["Button","Résultat du retraitement"], 10)}
     else {return Get_WinReprocessingManager().FindChild(["ClrClassName", "WPFControlText"], ["Button","Reprocessing Result"], 10)}
  }  
//Fenêtre de Paramètres de retraitement /Reprocess Parameters

function Get_WinReprocessParameters(){return Aliases.CroesusApp.winReprocessParameters}

function Get_WinReprocessParameters_CmbAccountNumberTypePicker(){return Get_WinReprocessParameters().FindChild("Uid", "ListPickerCombo_ae94", 10)} 

function Get_WinReprocessParameters_TxtAccountPicker(){return Get_WinReprocessParameters().FindChild("Uid", "TextBox_f1d5", 10)} 

function Get_WinReprocessParameters_BtnSearch(){return Get_WinReprocessParameters().FindChild("Uid", "ListPickerExec_9344", 10)} 

function Get_WinReprocessParameters_DgvReprocessPositions(){return Get_WinReprocessParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ReprocessPositionsGrid", 1], 10)}//DataGrid_7f45 même UID que la Grid Get_WinReprocessParameters_DgvReprocessTransactions()

function Get_WinReprocessParameters_DgvReprocessTransactions(){return Get_WinReprocessParameters().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ReprocessTransactionsGrid", 1], 10)}//DataGrid_7f45 même UID que la Grid Get_WinReprocessParameters_DgvReprocessPositions

function Get_WinReprocessParameters_DtpValueReprocessingDate(){return Get_WinReprocessParameters().FindChild("Uid", "DatePicker_4b2f", 10)}

function Get_WinReprocessParameters_TxtNote(){return Get_WinReprocessParameters().FindChild("Uid", "TextBox_26cf", 10)} 

function Get_WinReprocessParameters_BtnStartReprocessing(){return Get_WinReprocessParameters().FindChild("Uid", "Button_b9f6", 10)} 

function Get_WinReprocessParameters_ChkDeleteCorrectiveTransactions(){return Get_WinReprocessParameters().FindChild("Uid", "CheckBox_75cf", 10)}		 



//********************************** FENÊTRE PROTÉGER LES DONNÉES DE L'APPLICATION (LOCK THE APPLICATION WINDOW) ***************************************************
//File--> Lock
function Get_WinLockTheApplication(){return Aliases.CroesusApp.winLockTheApplication}

function Get_WinLockTheApplication_LblPassword(){return Get_WinLockTheApplication().FindChild("Uid", "TextBlock_1ce1", 10)} 

function Get_WinLockTheApplication_TxtPassword(){return Get_WinLockTheApplication().FindChild("Uid", "PasswordBox_094f", 10)} 

function Get_WinLockTheApplication_BtnOK(){return Get_WinLockTheApplication().FindChild("Uid", "Button_36ba", 10)} 

function Get_WinLockTheApplication_BtnQuit(){return Get_WinLockTheApplication().FindChild("Uid", "Button_80a0", 10)}


//******************************** User Multi Selection window - "Work As" window (Fenêtre Multi Sélection Utilisateurs - fenêtre "Travailler en tant que") ***************************

function Get_WinUserMultiSelection(){return Aliases.CroesusApp.winUserMultiSelection}


function Get_WinUserMultiSelection_TabBranches(){return Get_WinUserMultiSelection().FindChild("Uid", "TabItem_d643", 10)}

function Get_WinUserMultiSelection_TabBranches_DgvBranches(){return Get_WinUserMultiSelection().FindChild("Uid", "DataGrid_97ea", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)}

function Get_WinUserMultiSelection_TxtNumberOfSelectedBranches(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_b911", 10)}

function Get_WinUserMultiSelection_TabIACodes(){return Get_WinUserMultiSelection().FindChild("Uid", "TabItem_44f2", 10)}

function Get_WinUserMultiSelection_TabIACodes_DgvBranches(){return Get_WinUserMultiSelection().FindChild("Uid", "DataGrid_09db", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)}

function Get_WinUserMultiSelection_TxtNumberOfSelectedIACodes(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_a264", 10)}

function Get_WinUserMultiSelection_BtnApply(){return Get_WinUserMultiSelection().FindChild("Uid", "Button_62f8", 10)}

function Get_WinUserMultiSelection_BtnCancel(){return Get_WinUserMultiSelection().FindChild("Uid", "Button_c483", 10)}


//        Fonctions pour gérer le CR1483 (Utilisateurs/Selection)
//        Fenêtre "Travailler en tant que" / "Work As"
//        Description : Créer toutes les fonctions qui gèrent les objets de cette fenêtre
//        Analyste: Abdel Matmat
//        Tache jira: DAS-4286 Automatiser le CR 1483 (section Menu utilisateurs)


function Get_Win_WorkAs(){return Aliases.CroesusApp.WPFObject("HwndSource: _currentWindow")}

function Get_WinUserMultiSelection_TabBranches_DgBranches(){return Get_WinUserMultiSelection().FindChild("Uid", "DataGrid_97ea", 10)}

function Get_WinUserMultiSelection_TabUsers(){return Get_WinUserMultiSelection().FindChild("Uid", "TabItem_0e3e", 10)}

function Get_WinUserMultiSelection_TabUsers_DgvUsers(){return Get_WinUserMultiSelection().FindChild("Uid", "DataGrid_e796", 10)}

function Get_WinUserMultiSelection_TabIACodes_DgvIACodes(){return Get_WinUserMultiSelection().FindChild("Uid", "DataGrid_09db", 10)}

function Get_WinUserMultiSelection_ClickButtonFilter(){return Get_WinUserMultiSelection().Click(10,45)}

function Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid(){return Aliases.CroesusApp.subMenus.WPFObject("ContextMenu", "", 1)}

function Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_Copy()
  {
     if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Co_pier"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","_Copy"], 10)}
  }

function Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_CopyWithHeader()
  {
     if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Cop_ier avec en-tête"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Copy with _Header"], 10)}
  }

function Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_ExportToFile()
  {
     if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Exporter vers fichier..."], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Export to File..."], 10)}
  }
  
function Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid_ExportToExcel()
  {
     if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_ClickRightOnGrid().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Exporter vers MS Excel..."], 10)}
    else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Export to _MS Excel..."], 10)}
  }


//Fonctions communes Menu Filter pour les trois onglets (Succursales, Utilisateurs, Codes de CP)***********************************************************

function Get_WinUserMultiSelection_ContextualMenu_Filter(){return Aliases.CroesusApp.subMenus.WPFObject("ContextMenu", "", 1)}

function Get_WinUserMultiSelection_ContextualMenu_Filter_AddFilter()
{
    if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Ajouter un filtre..."], 10)}
    else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Add a Filter..."], 10)}
}

function Get_WinUserMultiSelection_ContextualMenu_Filter_ManageFilters()
{
     if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Gérer les filtres..."], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Manage Filters..."], 10)}
}

function Get_WinUserMultiSelection_ContextualMenu_Filter_FilterFields()
{
     if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "Tag"], ["Separator","Champs de filtre"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "Tag"], ["Separator","Filter Fields"], 10)}
}

// Fenêtre Add a Filter **********************************************************************************************************************
function Get_WinUserMultiSelection_Win_AddFilter(){return Aliases.CroesusApp.WPFObject("HwndSource: QuickFilterEditionWindow", "Add a Filter")}

function Get_WinUserMultiSelection_Win_AddFilter_Definition(){return Get_WinUserMultiSelection_Win_AddFilter().FindChild("Uid", "GroupBox_f25b", 10)}

function Get_WinUserMultiSelection_Win_AddFilter_Condition(){return Get_WinUserMultiSelection_Win_AddFilter().FindChild("Uid", "GroupBox_fc58", 10)}

function Get_WinUserMultiSelection_Win_AddFilter_BtnOK(){return Get_WinUserMultiSelection_Win_AddFilter().FindChild("Uid", "Button_ed99", 10)}

function Get_WinUserMultiSelection_Win_AddFilter_BtnCancel(){return Get_WinUserMultiSelection_Win_AddFilter().FindChild("Uid", "ToggleButton_f759", 10)}

function Get_WinUserMultiSelection_Win_AddFilter_Definition_TxtName(){return Get_WinUserMultiSelection_Win_AddFilter_Definition().FindChild("Uid", "TextBlock_d69f", 10)}

function Get_WinUserMultiSelection_Win_AddFilter_Definition_FieldName(){return Get_WinUserMultiSelection_Win_AddFilter_Definition().FindChild("Uid", "LocaleTextbox_fe73", 10)}

function Get_WinUserMultiSelection_Win_AddFilter_Definition_TxtAccess(){return Get_WinUserMultiSelection_Win_AddFilter_Definition().FindChild("Uid", "TextBlock_ffe2", 10)}

function Get_WinUserMultiSelection_Win_AddFilter_Definition_FieldAccess(){return Get_WinUserMultiSelection_Win_AddFilter_Definition().FindChild("Uid", "PartyLevelComboBox_92f6", 10)}

function Get_WinUserMultiSelection_Win_AddFilter_Condition_TxtField(){return Get_WinUserMultiSelection_Win_AddFilter_Condition().FindChild("Uid", "TextBlock_f3e1", 10)}
function Get_WinUserMultiSelection_Win_AddFilter_Condition_FieldField(){return Get_WinUserMultiSelection_Win_AddFilter_Condition().FindChild("Uid", "ComboBox_f9c9", 10)}

function Get_WinUserMultiSelection_Win_AddFilter_Condition_TxtOperator(){return Get_WinUserMultiSelection_Win_AddFilter_Condition().FindChild("Uid", "TextBlock_d543", 10)}
function Get_WinUserMultiSelection_Win_AddFilter_Condition_FieldOperator(){return Get_WinUserMultiSelection_Win_AddFilter_Condition().FindChild("Uid", "ComboBox_b9ca", 10)}

function Get_WinUserMultiSelection_Win_AddFilter_Condition_TxtValue(){return Get_WinUserMultiSelection_Win_AddFilter_Condition().FindChild("Uid", "TextBlock_cbe9", 10)}
function Get_WinUserMultiSelection_Win_AddFilter_Condition_FieldValue(){return Get_WinUserMultiSelection_Win_AddFilter_Condition().FindChild("Uid", "TextBox_32fe", 10)}

//Fenêtre Filter Manager ********************************************************************************************************************************
function Get_WinUserMultiSelection_Win_ManageFilter(){return Aliases.CroesusApp.WPFObject("HwndSource: QuickFilterManager")}

function Get_WinUserMultiSelection_Win_ManageFilter_PadFilters(){return Get_WinUserMultiSelection_Win_ManageFilter().FindChild("Uid", "PadHeader_820d", 10)}

function Get_WinUserMultiSelection_Win_ManageFilter_BtnAdd()
  {
      if (language == "french"){return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["Button","Aj_outer"], 10)}
      else {return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["Button","_Add"], 10)}
  }
  
function Get_WinUserMultiSelection_Win_ManageFilter_BtnDisplay()
  {
      if (language == "french"){return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["Button","Consulter"], 10)}
      else {return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["Button","Display"], 10)}
  }
  
function Get_WinUserMultiSelection_Win_ManageFilter_BtnDelete()
  {
      if (language == "french"){return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["Button","S_upprimer"], 10)}
      else {return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["Button","De_lete"], 10)}
  }
  
function Get_WinUserMultiSelection_Win_ManageFilter_ChName()
  {
      if (language == "french"){return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Nom"], 10)}
      else {return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Name"], 10)}
  }
  
function Get_WinUserMultiSelection_Win_ManageFilter_ChModified()
  {
      if (language == "french"){return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Modifié"], 10)}
      else {return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Modified"], 10)}
  }
  
function Get_WinUserMultiSelection_Win_ManageFilter_ChCreated()
  {
      if (language == "french"){return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Créé"], 10)}
      else {return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Created"], 10)}
  }
  
function Get_WinUserMultiSelection_Win_ManageFilter_ChAccess()
  {
      if (language == "french"){return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Accès"], 10)}
      else {return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Access"], 10)}
  }
  
function Get_WinUserMultiSelection_Win_ManageFilter_ChCreation()
  {
      if (language == "french"){return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Création"], 10)}
      else {return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Creation"], 10)}
  }
  
function Get_WinUserMultiSelection_Win_ManageFilter_BtnApply()
  {
      if (language == "french"){return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["Button","_Appliquer"], 10)}
      else {return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["Button","_Apply"], 10)}
  }
  
function Get_WinUserMultiSelection_Win_ManageFilter_BtnClose()
  {
      if (language == "french"){return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["Button","_Fermer"], 10)}
      else {return Get_WinUserMultiSelection_Win_ManageFilter().FindChild(["ClrClassName", "WPFControlText"], ["Button","_Close"], 10)}
  }


//Fenêtre Create Filter *******************************************************************************************************************************************
function Get_WinUserMultiSelection_Win_CreateFilter(){return Aliases.CroesusApp.WPFObject("HwndSource: FilterWindow", "Create Filter")}

function Get_WinUserMultiSelection_Win_CreateFilter_TxtField(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild("Uid", "TextBlock_f3e1", 10)}
function Get_WinUserMultiSelection_Win_CreateFilter_FieldField(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild("Uid", "TextBlock_d65f", 10)}

function Get_WinUserMultiSelection_Win_CreateFilter_TxtOperator(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild("Uid", "TextBlock_d543", 10)}
function Get_WinUserMultiSelection_Win_CreateFilter_FieldOperator(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild("Uid", "ComboBox_b9ca", 10)}

function Get_WinUserMultiSelection_Win_CreateFilter_TxtValue(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild("Uid", "TextBlock_cbe9", 10)}
function Get_WinUserMultiSelection_Win_CreateFilter_FieldValue(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild("Uid", "TextBox_32fe", 10)}

function Get_WinUserMultiSelection_Win_CreateFilter_BtnSaveAndApply(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild("Uid", "Button_2ee7", 10)}
function Get_WinUserMultiSelection_Win_CreateFilter_BtnApply(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild("Uid", "Button_b19d", 10)}
function Get_WinUserMultiSelection_Win_CreateFilter_BtnCancel(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild("Uid", "ToggleButton_898f", 10)}

//fonctions pour récupérer les valeurs possibles pour Branch Name
function Get_WinUserMultiSelection_Win_CreateFilter_BranchName_HeadOffice(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild(["ClrClassName", "Text"], ["XamTextEditor","Head-Office"], 10)}
function Get_WinUserMultiSelection_Win_CreateFilter_BranchName_Laval(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild(["ClrClassName", "Text"], ["XamTextEditor","Laval"], 10)}
function Get_WinUserMultiSelection_Win_CreateFilter_BranchName_Quebec(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild(["ClrClassName", "Text"], ["XamTextEditor","Québec"], 10)}
function Get_WinUserMultiSelection_Win_CreateFilter_BranchName_Sherbrooke(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild(["ClrClassName", "Text"], ["XamTextEditor","Sherbrooke"], 10)}
function Get_WinUserMultiSelection_Win_CreateFilter_BranchName_Toronto(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild(["ClrClassName", "Text"], ["XamTextEditor","Toronto"], 10)}

//Fonctions pour récupérer les valeurs possibles pour Full Name des users
function Get_WinUserMultiSelection_Win_CreateFilter_GridFullName(){return Get_WinUserMultiSelection_Win_CreateFilter().FindChild("Uid", "DataGrid_9d05", 10)}
//function Get_WinUserMultiSelection_Win_CreateFilter_FullName_AbrahamLincoln(){return Get_WinUserMultiSelection_Win_CreateFilter_GridFullName().FindChild("DataContext.DataItem.Value","Abraham Lincoln",100)}
function Get_WinUserMultiSelection_Win_CreateFilter_FullName_AbrahamLincoln(){return Get_WinUserMultiSelection_Win_CreateFilter_GridFullName().DataGridQuickFilter.DataContext.ParentDataGrid.DataItems.Item(10)}//FindChild("DataItems.Item.count",0,10)}


  
  

//Tab succursales *******************************************************************************************************************************************************

function Get_WinUserMultiSelection_TabBranches_ChBranchName()
  {
      if (language == "french"){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Nom de succursale"], 10)}
      else {return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Branch Name"], 10)}
  }

function Get_WinUserMultiSelection_TabBranches_ChBranchCode()
  {
      if (language == "french"){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Code de succursale"], 10)}
      else {return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Branch Code"], 10)}
  }

function Get_WinUserMultiSelection_TabBranches_ChCity()
  {
      if (language == "french"){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Ville"], 10)}
      else {return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","City"], 10)}
  }

function Get_WinUserMultiSelection_TabBranches_ChProvince(){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Province"], 10)}

function Get_WinUserMultiSelection_ValueNumberOfSelectedBranches(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_b911", 10)}

function Get_WinUserMultiSelection_TextNumberOfSelectedBranches(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_5552", 10)}

function Get_WinUserMultiSelection_TxtImpossibleToSelectMoreThen30Branches(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_cdbb", 10)}

//Modification de cette fonction par A.M suite à l'ajout d'un nouveau bouton avant le bouton Export Excel avec la version HF
//function Get_WinUserMultiSelection_TabBranches_ButtonExportExcel(){return Get_WinUserMultiSelection_TabBranches_DgBranches().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button",1], 10)}
function Get_WinUserMultiSelection_TabBranches_ButtonExportExcel(){return Get_WinUserMultiSelection_TabBranches_DgBranches().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button",2], 10)}


//Fonctions menu contextuel filtre Tab Succursales***********************************************************************************************

function Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_BranchCode()
{
     if (language == "english"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Branch Code"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Code de succursale"], 10)}
}

function Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_BranchName()
{
     if (language == "english"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Branch Name"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Nom de succursale"], 10)}
}

function Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_City()
{
     if (language == "english"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","City"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Ville"], 10)}
} 

function Get_WinUserMultiSelection_TabBranches_ContextualMenu_Filter_Province(){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Province"], 10)}


     

//Tab Utilisateurs ********************************************************************************************************************************

function Get_WinUserMultiSelection_TabUsers_ChFirstName()
  {
      if (language == "french"){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Prénom"], 10)}
      else {return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","First Name"], 10)}
  }
function Get_WinUserMultiSelection_TabUsers_ChLastName()
  {
      if (language == "french"){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Nom"], 10)}
      else {return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Last Name"], 10)}
  }
  
function Get_WinUserMultiSelection_TabUsers_ChBranchName()
  {
      if (language == "french"){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Nom de succursale"], 10)}
      else {return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Branch Name"], 10)}
  }

function Get_WinUserMultiSelection_TabUsers_ChBranchCode()
  {
      if (language == "french"){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Code de succursale"], 10)}
      else {return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Branch Code"], 10)}
  }

function Get_WinUserMultiSelection_TabUsers_TxtNumberOfSelectedUsers(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_624f", 10)}

function Get_WinUserMultiSelection_TabUsers_ValueNumberOfSelectedUsers(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_c812", 10)}

function Get_WinUserMultiSelection_TabUsers_TxtNumberOfSelectedIACodes(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_0330", 10)}

function Get_WinUserMultiSelection_TabUsers_ValueNumberOfSelectedIACodes(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_d1e7", 10)}

function Get_WinUserMultiSelection_TabUsers_TxtImpossibleToSelectMoreThan30Users(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_e54e", 10)}

//Modification de la fonction par A.M suite à l'ajout d'un nouveau bouton sur la version HF
//function Get_WinUserMultiSelection_TabUsers_ButtonExportExcel(){return Get_WinUserMultiSelection_TabUsers_DgvUsers().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button","1"], 10)}
function Get_WinUserMultiSelection_TabUsers_ButtonExportExcel(){return Get_WinUserMultiSelection_TabUsers_DgvUsers().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button","2"], 10)}
    
//Fonctions menu contextuel filtre Tab Utilisateurs ************************************************************************************************

function Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_BranchCode()
{
     if (language == "english"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Branch Code"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Code de succursale"], 10)}
}

function Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_BranchName()
{
     if (language == "english"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Branch Name"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Nom de succursale"], 10)}
}

function Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_FirstName()
{
     if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Prénom"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","First Name"], 10)}
}

function Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_LastName()
{
     if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Nom"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Last Name"], 10)}
}

function Get_WinUserMultiSelection_TabUsers_ContextualMenu_Filter_FullName()
{
     if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Nom complet"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Full Name"], 10)}
}


//Tab IA Codes ********************************************************************************************************************************

function Get_WinUserMultiSelection_TabIACodes_ChIACode()
  {
      if (language == "french"){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Code de CP"], 10)}
      else {return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","IA Code"], 10)}
  }

function Get_WinUserMultiSelection_TabIACodes_ChBranchCode()
  {
      if (language == "french"){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Code de succursale"], 10)}
      else {return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Branch Code"], 10)}
  }
  
function Get_WinUserMultiSelection_TabIACodes_ChName()
  {
      if (language == "french"){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Nom"], 10)}
      else {return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Name"], 10)}
  }
  
function Get_WinUserMultiSelection_TabIACodes_ChBranchName()
  {
      if (language == "french"){return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Nom de succursale"], 10)}
      else {return Get_WinUserMultiSelection().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter","Branch Name"], 10)}
  }
  
function Get_WinUserMultiSelection_TabIACodes_TxtNumberOfSelectedIACodes(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_1575", 10)}

function Get_WinUserMultiSelection_TabIACodes_ValueNumberOfSelectedIACodes(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_a264", 10)}

function Get_WinUserMultiSelection_TabIACodes_TxtImpossibleToSelectMoreThan30IACodes(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_4e7c", 10)}

// Modification de la fonction par A.M suite à l'ajout d'un nouveau bouton avec la version HF
//function Get_WinUserMultiSelection_TabIACodes_ButtonExportExcel(){return Get_WinUserMultiSelection_TabIACodes_DgvIACodes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button","1"], 10)}
function Get_WinUserMultiSelection_TabIACodes_ButtonExportExcel(){return Get_WinUserMultiSelection_TabIACodes_DgvIACodes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button","2"], 10)}

//Fonctions menu contextuel filtre Tab Codes de CP **************************************************************************************************

function Get_WinUserMultiSelection_TabIACodes_ContextualMenu_Filter_BranchCode()
{
     if (language == "english"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Branch Code"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Code de succursale"], 10)}
}

function Get_WinUserMultiSelection_TabIACodes_ContextualMenu_Filter_BranchName()
{
     if (language == "english"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Branch Name"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Nom de succursale"], 10)}
}

function Get_WinUserMultiSelection_TabIACodes_ContextualMenu_Filter_IACode()
{
     if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Code de CP"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","IA Code"], 10)}
}

function Get_WinUserMultiSelection_TabIACodes_ContextualMenu_Filter_Name()
{
     if (language == "french"){return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Nom"], 10)}
     else {return Get_WinUserMultiSelection_ContextualMenu_Filter().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem","Name"], 10)}
}

// ***************** ********************************    FENETRE  PREFERENCES  (FILE/PEFERENCES )            *************************/
function Get_WinPreferences(){	return Aliases.CroesusApp.winDetailedInfoPreferences  }

//Tab Utilisateur - Fenêtre de Préférences 
function Get_WinPrefe_TadUser(){	
	if (language == "english") {
	    return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "User"], 10)}
	else{
    	return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Utilisateur"], 10)}
}
//Tab Secteurs d'activité - Fenêtre de Préférences 
function Get_WinPrefe_TabInduCode(){
	if (language == "english"){
		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Industry Codes"], 10)}
	else {
		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Secteurs d'activité"], 10)}
}
//OK bouton Preferences 
function Get_WinPrefe_BtnOK(){

	if (language == "french")
	{
		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)
	}
	else 
	{
		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)
	}
	
}

//Cancel- Annuler bouton Preferences 
function Get_WinPrefe_BtnCancel(){
	
	if (language == "french")
	{
		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)
	}
	else 
	{
		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)
	}
	
}
function Get_WinPreferences_CmbBranch(){
        return Get_WinPreferences().Findchild(["ClrClassName", "WPFControlOrdinalNo"],["CFComboBox", 1], 10)}

function Get_WinPreferences_CmbName(){
        return Get_WinPreferences().Findchild(["ClrClassName", "WPFControlOrdinalNo"],["CFComboBox", 2], 10)}  

function Get_WinPreferences_CmbIACode(){
        return Get_WinPreferences().WPFObject("ClassicTabControl", "", 1).WPFObject("ClassicTabControl", "", 1).WPFObject("CFComboBox", "", 1)}                  
        
function Get_WinPreferences_TabIACode(){	
	var labelIACode = (language == "french")? "Code de CP:": "IA Code:";
	return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", labelIACode], 10)} 
    
function Get_WinPreferences_TabIACode_TxtFrenchAddress1(){
        return Get_WinPreferences().Findchild(["Uid", "WPFControlOrdinalNo"],["CustomTextBox_5194", 3], 10)}  
 
function Get_WinPreferences_TabIACode_TxtFrenchAddress2(){
        return Get_WinPreferences().Findchild(["Uid", "WPFControlOrdinalNo"],["CustomTextBox_5194", 5], 10)}  
        
function Get_WinPreferences_TabIACode_TxtEnglishAddress1(){
        return Get_WinPreferences().Findchild(["Uid", "WPFControlOrdinalNo"],["CustomTextBox_5194", 4], 10)}  
 
function Get_WinPreferences_TabIACode_TxtEnglishAddress2(){
        return Get_WinPreferences().Findchild(["Uid", "WPFControlOrdinalNo"],["CustomTextBox_5194", 6], 10)} 