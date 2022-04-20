//USEUNIT Global_variables

//USEUNIT Common_MenuEdit_Get_functions
//USEUNIT Common_MenuFileModulesUsersHelp_Get_functions
//USEUNIT Common_MenuReports_Get_functions
//USEUNIT Common_MenuSearch_Get_functions
//USEUNIT Common_MenuTools_Get_functions


//----> Common_functions 

/**
    Description : Permet d'attendre qu'un object soit chargé avant de poursuivre l'exécution du script
    Paramètres :
        - parentObject : référence de l'objet parent dans lequel la recherche de l'objet cible est effectuée
        - properties : nom(s) du ou des propriétés dont les valeurs seront recherchées (string ou tableau de strings)
        - propertiesValues : valeur des propriétés de l'objet recherché (types variés ou tableau de types variés)
        - maxWaitTime : temps maximum d'attente, en millisecondes (facultatif, valeur par défaut : 30000)
    Résultat : Affichage de message indiquant le temps d'attente
               - true si l'objet a été trouvé
               - false si l'objet n'a pas été trouvé
    Auteur : Christophe Paring
*/
function WaitObject(parentObject, properties, propertiesValues, maxWaitTime, showWaitTime)
{
    Log.CallStackSettings.EnableStackOnMessage = true;
    
    if (maxWaitTime == undefined)
        maxWaitTime = 15000; //Réduction à 15 sec. au lieu de 30 sec. On peut déjà dire qu'il y a un problème si le système ne réponds pas au delà de 10 sec.
    
    var timer = HISUtils.StopWatch;
    var waitTime = 0;
    do {
        timer.Start();
        Delay(100); //Idle pour une raison de stabilisation avant la détection d'un object.
        isFound = parentObject.FindChild(properties, propertiesValues, 200).Exists;
        waitTime = timer.Stop();
        
        if (isFound)
            break;
    } while (waitTime < maxWaitTime)
    
    timer.Reset();
    
    if (showWaitTime || showWaitTime == undefined){
      if (isFound)
          Log.Message("Object having properties '" + properties + "=" + propertiesValues + "' found after " + waitTime + " ms.");
      else
          Log.Message("Object having properties '" + properties + "=" + propertiesValues + "' not found after " + waitTime + " ms.");
    }
    
    Log.CallStackSettings.EnableStackOnMessage = false;
    
    return isFound;
}
//----> Common_functions 


//******************************* CROESUS APPLICATION ******************************

function Get_CroesusApp(){return Aliases.CroesusApp}



//******************************* WHAT'S NEW (QUOI DE NEUF) ******************************

function Get_WinWhatsNew(){return Get_CroesusApp().FindChild("Uid", "Window_e96b", 10)}

function Get_WinWhatsNew_ChkDoNotShowThisDialogBoxAgain(){return Get_WinWhatsNew().FindChild("Uid", "CheckBox_5944", 10)}

function Get_WinWhatsNew_BtnClose(){return Get_WinWhatsNew().FindChild("Uid", "Button_f95b", 10)}



//********************************** MAIN WINDOW ***************************************

function Get_MainWindow(){return NameMapping.Sys.CroesusClient.HwndSource_MainWindow}


//Barre d'état (Status bar)

function Get_MainWindow_StatusBar(){return Get_MainWindow().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicStatusBar", "1"], 10)}

function Get_MainWindow_StatusBar_DetailedInfo(){return Get_MainWindow_StatusBar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicStatusBarContent", "8"], 10)}

function Get_MainWindow_StatusBar_ProgressBar(){return Get_MainWindow_StatusBar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicStatusBarContent", 7], 10)}

function Get_MainWindow_StatusBar_ProgressBarPercentValue100(){return Get_MainWindow_StatusBar_ProgressBar().FindEx(["IsVisible", "ProgressBarValue"], [true, 100], 0, true, -1)}

function Get_MainWindow_StatusBar_Alarms(){return Get_MainWindow_StatusBar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicStatusBarContent", "5"], 10)}

function Get_MainWindow_StatusBar_Schedule(){return Get_MainWindow_StatusBar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicStatusBarContent", "4"], 10)}

function Get_MainWindow_StatusBar_NbOfSelectedElements(){return Get_MainWindow_StatusBar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicStatusBarContent", "3"], 10)}

function Get_MainWindow_StatusBar_NbOfcheckedElements(){return Get_MainWindow_StatusBar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicStatusBarContent", "2"], 10)}

function Get_MainWindow_StatusBar_ProcessingDate(){return Get_MainWindow_StatusBar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicStatusBarContent", "1"], 10)}

//Boards sur la fenêtre principale



//********************* MENU CONTEXTUEL SUR ENTÊTES DE COLONNE DU GRID (CONTEXTUAL MENU ON THE GRID HEADERS) ***************************

function Get_GridHeader_ContextualMenu(){return Get_SubMenus().FindChild("Uid", "ColumnPickerMenu_eaa1", 10)} //ok

function Get_GridHeader_ContextualMenu_AddColumn(){return Get_GridHeader_ContextualMenu().FindChild("Uid", "MenuItem_587c", 10)} //ok

function Get_GridHeader_ContextualMenu_AddColumn_Dividend(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: Dividend"], 10)}

function Get_GridHeader_ContextualMenu_AddColumn_SecurityDividend(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: SecurityDividend"], 10)}

function Get_GridHeader_ContextualMenu_ReplaceColumnWith(){return Get_GridHeader_ContextualMenu().FindChild("Uid", "MenuItem_15d5", 10)} //ok

function Get_GridHeader_ContextualMenu_RemoveThisColumn(){return Get_GridHeader_ContextualMenu().FindChild("Uid", "MenuItem_bbe4", 10)} //ok

function Get_GridHeader_ContextualMenu_ColumnStatus(){return Get_GridHeader_ContextualMenu().FindChild("Uid", "MenuItem_7f14", 10)} //ok

function Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheLeft(){return Get_CroesusApp().FindChild("Uid", "MenuItem_132c", 10)}

function Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight(){return Get_CroesusApp().FindChild("Uid", "MenuItem_1ae8", 10)}

function Get_GridHeader_ContextualMenu_ColumnStatus_Movable(){return Get_CroesusApp().FindChild("Uid", "MenuItem_15ea", 10)}

function Get_GridHeader_ContextualMenu_InsertField(){return Get_GridHeader_ContextualMenu().FindChild("Uid", "MenuItem_6d3a", 10)} //ok

function Get_GridHeader_ContextualMenu_RemoveThisField(){return Get_GridHeader_ContextualMenu().FindChild("Uid", "MenuItem_8f3c", 10)} //ok

function Get_GridHeader_ContextualMenu_DefaultConfiguration(){return Get_GridHeader_ContextualMenu().FindChild("Uid", "MenuItem_c549", 10)} //ok

function Get_GridHeader_ContextualMenu_AddColumn_Type(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: Type3Description"], 10)}

function Get_GridHeader_ContextualMenu_AddColumn_Pro(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: AccountProStatus"], 10)}

function Get_GridHeader_ContextualMenu_AddColumn_Status(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: ClientRelationshipStatusDescription"], 10)}

function Get_GridHeader_ContextualMenu_AddColumn_StatusForClients(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: StatusForDisplay"], 10)} //pour le module 'Clients'

function Get_GridHeader_ContextualMenu_AddColumn_ManagementLevel(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: ManagementLevelDescription"], 10)}

function Get_GridHeader_ContextualMenu_AddColumn_Subcategory(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: SubCategoryDescription"], 10)}

function Get_GridHeader_ContextualMenu_AddColumn_Segmentation(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: SegmentationDisplay"], 10)}

function Get_GridHeader_ContextualMenu_AddColumn_ClosingDate(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: ClosingDate"], 10)}

function Get_GridHeader_ContextualMenu_AddColumn_Rate(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: Rate"], 10)}

function Get_GridHeader_ContextualMenu_AddColumn_Profiles(){return Get_CroesusApp().FindChild("Uid", "MenuItem_f1ba", 10)}

function Get_GridHeader_ContextualMenu_AddColumn_ClientRelationshipNo(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: ClientRelationshipLinkNumber"], 10)}

function Get_GridHeader_ContextualMenu_InsertField_Profiles(){return Get_CroesusApp().FindChild("Uid", "MenuItem_2d30", 10)}

function Get_GridHeader_ContextualMenu_AddColumnOrInsertField_Profiles_ProfileName(FrenchName, EnglishName)
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.FormatedName"], ["MenuItem", FrenchName], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.FormatedName"], ["MenuItem", EnglishName], 10)}
}

function Get_GridHeader_ContextualMenu_AddColumnOrInsertField_ColumnOrFieldName(FrenchName, EnglishName)
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Label"], ["MenuItem", FrenchName], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Label"], ["MenuItem", EnglishName], 10)}
}

function Get_GridHeader_ContextualMenu_AddColumn_Market(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: Market"], 10)}

function Get_GridHeader_ContextualMenu_AddColumn_Discretionary(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: isDiscretionary"], 10)}


//Fonctionne pour le module Transactions et l'onglet Info de la fenêtre Info détaillée de Clients/Relations

function Get_GridHeader_ContextualMenu_AddColumn1()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Ajouter une colonne"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Add Column"], 10)}
}

//Fonctionne pour le module Transactions et l'onglet Info de la fenêtre Info détaillée de Clients/Relations
function Get_GridHeader_ContextualMenu_DefaultConfiguration1()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Configuration par défaut"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Use Default Configuration"], 10)}
}



//++++++++++++++++++++++++++++++++++++++++++++ MENUBAR ++++++++++++++++++++++++++++++

function Get_MenuBar(){return Aliases.CroesusApp.winMain.barMenu}

function Get_SubMenus(){return Aliases.CroesusApp.subMenus}


//++++++++++++++++++++++++++++++++++++++++++++ SUBMENUS TOOLTIP ++++++++++++++++++++++++++++++

function Get_SubMenus_Tooltip(){return Get_SubMenus().FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["ToolTip", true, 1], 10)}

function Get_SubMenus_Tooltip_GrpRiskAllocationLevel(){return Get_SubMenus_Tooltip().FindChild(["Uid"], ["GroupBox_265e"], 10)}

function Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblRiskAllocationLevel(){return Get_SubMenus_Tooltip_GrpRiskAllocationLevel().FindChild(["IsVisible", "Uid"], [true, "TextBlock_be56"], 10)}

function Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtRiskAllocationLevel(){return Get_SubMenus_Tooltip_GrpRiskAllocationLevel().FindChild(["IsVisible", "Uid"], [true, "TextBlock_fa9b"], 10)}

function Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblCurrentMarketValue(){return Get_SubMenus_Tooltip_GrpRiskAllocationLevel().FindChild(["IsVisible", "Uid"], [true, "TextBlock_4eeb"], 10)}

function Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtCurrentMarketValue(){return Get_SubMenus_Tooltip_GrpRiskAllocationLevel().FindChild(["IsVisible", "Uid"], [true, "TextBlock_837b"], 10)}

function Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblCurrentMarketValuePercent(){return Get_SubMenus_Tooltip_GrpRiskAllocationLevel().FindChild(["IsVisible", "Uid"], [true, "TextBlock_0d66"], 10)}

function Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtCurrentMarketValuePercent(){return Get_SubMenus_Tooltip_GrpRiskAllocationLevel().FindChild(["IsVisible", "Uid"], [true, "TextBlock_24fd"], 10)}

function Get_SubMenus_Tooltip_GrpRiskAllocationLevel_LblClientRiskObjectiveOrTargetMarketValue(){return Get_SubMenus_Tooltip_GrpRiskAllocationLevel().FindChild(["IsVisible", "Uid"], [true, "TextBlock_8937"], 10)}

function Get_SubMenus_Tooltip_GrpRiskAllocationLevel_TxtClientRiskObjectiveOrTargetMarketValue(){return Get_SubMenus_Tooltip_GrpRiskAllocationLevel().FindChild(["IsVisible", "Uid"], [true, "TextBlock_9bcd"], 10)}

function Get_SubMenus_Tooltip_GrpRiskAllocationLevel_DgvAllocations(){return Get_SubMenus_Tooltip_GrpRiskAllocationLevel().FindChild("Uid", "DataGrid_a688", 10)}

function Get_SubMenus_Tooltip_RectangleForRiskAllocation(){return Get_SubMenus_Tooltip().FindChild(["ClrClassName", "IsVisible"], ["Rectangle", true], 10)}

function Get_SubMenus_ByDescription(description) {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", description], 10)}

//---->MenuFileModulesUsers_Get_functions
/*
//++++++++++++++++++++++++++++++++++ MENU FICHIER (FILE MENU) +++++++++++++++++++++++

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

//----->MenuFileModulesUsers_Get_functions


//----->MenuEdit_Get_functions

//++++++++++++++++++++++++++++++++++ MENU EDITION (EDIT MENU) ++++++++++++++++++++++++++

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
function Get_MenuBar_Edit_Relationship_CreateGroupedRelationship(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_db79", 10)}

function Get_MenuBar_Edit_Relationship_JoinToAGroupedRelationship(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_0bc7", 10)}

//Edition > Relations pour les modules Clients et Comptes
function Get_MenuBar_Edit_Relationship_CreateANewRelationship(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_1798", 10)}

function Get_MenuBar_Edit_Relationship_JoinToAnExistingRelationship(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_c7bc", 10)}


//Edition > Ajouter pour les modules Relations et Clients

function Get_MenuBar_Edit_AddForRelationshipsAndClients(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_cefe", 10)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_CreateFictitiousClient(){return Get_CroesusApp().FindChild("Uid", "MenuItem_19bd", 10)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_CreateExternalClient(){return Get_CroesusApp().FindChild("Uid", "MenuItem_91a1", 10)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_AddRelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_f76c", 10)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinRelationshipTo(){return Get_CroesusApp().FindChild("Uid", "MenuItem_e3ad", 10)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinClientsToRelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_2ec3", 10)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinAccountsToRelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_e4b6", 10)}

function Get_MenuBar_Edit_AddForRelationshipsAndClients_JoinToAGroupedRelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_149b", 10)}


//Edition > Fonctions pour les modules Relations, Clients et Comptes

function Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["MenuItem", "_Info", "2"], 10)}

function Get_MenuBar_Edit_FunctionsForAccounts_Alarms()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Alarmes"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Alarms"], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Performance()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Performa_nce..."], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Perf_ormance..."], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndAccounts_Restrictions()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Restric_tions..."], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Restri_ctions..."], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Activities()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "A_ctivités..."], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "A_ctivities..."], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_ButtonBar()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Barre de boutons"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Button Bar"], 10)}
}


function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Info(){return Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Info"], 10)}

function Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Info_Notes(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Notes"], 10)}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Addresses()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Adresses"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Addresses"], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Telephons()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Téléphones"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Telephones"], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Email()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Courriel"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Email"], 10)}
}

function Get_MenuBar_Edit_FunctionsForClients_Info_Agenda(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Agenda"], 10)}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_ProductsAndServices()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Produits & services"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Products & Services"], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_InvestmentObjective()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Objectif de placement"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Investment Objective"], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_DefaultReports()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Rapports par défaut"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Default Reports"], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_DefaultIndices()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Indices par défaut"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Default Indices"], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Profiles()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Profils"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Profiles"], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationships_Info_UnderlyingAccounts()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Comptes sous-jacents"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Underlying Accounts"], 10)}
}

function Get_MenuBar_Edit_FunctionsForRelationshipsAndClients_Info_Documents(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Documents"], 10)}

function Get_MenuBar_Edit_FunctionsForClients_Info_CostumerNetwork()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Réseau d'influence"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Client Network"], 10)} //EM : 90-07-23-CO - Modifié selon le Jira CROES-1425
}

function Get_MenuBar_Edit_FunctionsForClients_Info_Campaigns()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Campagnes"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Campaigns"], 10)}
}



function Get_MenuBar_Edit_FunctionsForAccounts_Info_InvestmentObjective()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Objectif de placement"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Investment Objective"], 10)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_DefaultReports()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Rapports par défaut"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Default Reports"], 10)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_DefaultIndices()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Indices par défaut"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Default Indices"], 10)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_Profiles()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Profils"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Profiles"], 10)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_Dates(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Dates"], 10)}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_Holders()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Détenteurs"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Holders"], 10)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_PW1859()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "GP1859"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "PW1859"], 10)}
}

function Get_MenuBar_Edit_FunctionsForAccounts_Info_RegisteredAccounts()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Comptes enregistrés"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Registered Accounts"], 10)}
}



//Edition > Fonctions pour le module Transactions

function Get_MenuBar_Edit_FunctionsForTransactions_Info()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Info"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "I_nfo"], 10)}
}

function Get_MenuBar_Edit_FunctionsForTransactions_GainsLosses()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Gains/Pertes"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Gains/Losses"], 10)}
}

function Get_MenuBar_Edit_FunctionsForTransactions_Filter()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Fi_ltre"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "F_ilter"], 10)}
}

function Get_MenuBar_Edit_FunctionsForTransactions_Position(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Position"], 10)}

//Edition > Fonctions pour le module Modèles

function Get_MenuBar_Edit_FunctionsForModels_Info(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Info"], 10)} //no uid

function Get_MenuBar_Edit_FunctionsForModels_UnderlyingPerformance() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Perfo. sous-jacente"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Under. Performance"], 10)}
}

function Get_MenuBar_Edit_FunctionsForModels_Documents(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Documents"], 10)} //no uid

function Get_MenuBar_Edit_FunctionsForModels_Restrictions(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Restrictions"], 10)} //no uid

//Edition > Fonctions pour le module Titres

function Get_MenuBar_Edit_FunctionsForSecurities_Info() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Info"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "I_nfo"], 10)}
}

function Get_MenuBar_Edit_FunctionsForSecurities_HistoricalData() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Données historiques"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Historical _Data"], 10)}
}

function Get_MenuBar_Edit_FunctionsForSecurities_TotalHeld() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Total détenu"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "T_otal Held"], 10)}
}

function Get_MenuBar_Edit_FunctionsForSecurities_ExchangeRate() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "T_aux de change"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Exch_ange Rate"], 10)}
}

//Edition > Fonctions pour le module Portefeuille

function Get_MenuBar_Edit_FunctionsForPortfolio_Info() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Info"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "I_nfo"], 10)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_TradeDateBalance() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "So_lde date trans."], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Trade Date _Bal."], 10)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_TotalValue() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Valeur _totale"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Total Value"], 10)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_CashFlowProject() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Pro_j. liquidités"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Cash Fl_ow Proj."], 10)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_Save() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Sau_vegarder"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Sa_ve"], 10)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_All() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Tous"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_All"], 10)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_WhatIf() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Simulat_ion"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_What-If"], 10)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_Compare() //missing in Automation 8
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Comparaison"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Compare"], 10)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_Cancel() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Annuler"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Cancel"], 10)}
}

function Get_MenuBar_Edit_FunctionsForPortfolio_ButtonBar() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Barre de boutons"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Button Bar"], 10)}
}

//Edition > Fonctions pour le module Ordres

function Get_MenuBar_Edit_FunctionsForOrders_CFO(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "CFO..."], 10)}

function Get_MenuBar_Edit_FunctionsForOrders_View()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Consulter..."], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "View..."], 10)}
}

function Get_MenuBar_Edit_FunctionsForOrders_Fills()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Exécutions..."], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Fills..."], 10)}
}

function Get_MenuBar_Edit_FunctionsForOrders_CXL(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "CXL"], 10)}

function Get_MenuBar_Edit_FunctionsForOrders_Replace()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Replacer..."], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Replace..."], 10)}
}

function Get_MenuBar_Edit_FunctionsForOrders_Refresh()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Rafraîchir"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Refresh"], 10)}
}


//Edition > Module de saisie des ordres (Disponible pour tous les modules sauf Modèles)
function Get_MenuBar_Edit_OrderEntryModule(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_e0c0", 10)}

function Get_MenuBar_Edit_OrderEntryModule_CreateABuyOrder(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_f876", 10)}

function Get_MenuBar_Edit_OrderEntryModule_CreateASellOrder(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_e904", 10)}

function Get_MenuBar_Edit_OrderEntryModule_SwitchBlock(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_4a5b", 10)}


//----->fin   MenuEdit_Get_functions



//----->MenuFileModulesUsers_Get_functions

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
//----->fin   MenuFileModulesUsers_Get_functions





//----->MenuReports_Get_functions
//++++++++++++++++++++++++++++++++++MENU RAPPORTS (REPORTS MENU) +++++++++++++++++++++++++++++++++++++++++

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

//----->fin MenuReports_Get_functions


//------> MenuTools_Get_functions
//++++++++++++++++++++++++++++++++ MENU OUTILS (TOOLS MENU) ++++++++++++++++++++++++++++++++

function Get_MenuBar_Tools(){return Get_MenuBar().FindChild("Uid", "CustomizableMenu_fcd0", 10)} //ok

function Get_MenuBar_Tools_ArchiveMyDocuments(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_0dde", 10)} //ok

function Get_MenuBar_Tools_Agenda(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_b500", 10)} //ok

function Get_MenuBar_Tools_BondCalculator(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_2528", 10)} //ok

//For Orders and Models
function Get_MenuBar_Tools_OrderBook(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_8de9", 10)} 

function Get_MenuBar_Tools_ManageCampaigns(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_eb52", 10)} //ok

function Get_MenuBar_Tools_Configurations(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_9f7c", 10)} //ok

function Get_MenuBar_Tools_Billing(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_aefb", 10)}

//For Relationships, Clients, Accounts, Transactions
function Get_MenuBar_Tools_Internet(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_5998", 10)} //ok

//For Dashboard, Models, Portfolio, Securities, Orders
function Get_MenuBar_Tools_InternetAdresses(){return Get_SubMenus().FindChild("Uid", "CustomizableMenu_fb60", 10)} //ok

function Get_MenuBar_Tools_PlanPlus(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_c468", 10)}

function Get_MenuBar_Tools_NaviPlan(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_7940", 10)} //ok

function Get_MenuBar_Tools_ExportTheAgenda(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_d1e4", 10)} //ok

function Get_MenuBar_Tools_SynchronizeTheAgenda(){return Get_SubMenus().FindChild("Uid", "w:CFMenuItem_47", 10)} //missing in Automation 8


//Sous-menu Internet

function Get_MenuBar_Tools_Internet_Quotes() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Cotes"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Quotes"], 10)}
}

function Get_MenuBar_Tools_Internet_Graphs() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Graphiques"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Graphs"], 10)}
}

function Get_MenuBar_Tools_Internet_Analysis() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Analyse"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Analysis"], 10)}
}

function Get_MenuBar_Tools_Internet_News() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Nouvelles"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "News"], 10)}
}

function Get_MenuBar_Tools_Internet_Company() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Compagnie"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Company"], 10)}
}

function Get_MenuBar_Tools_Internet_AccessWebPage(WebPageAdress){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", WebPageAdress] , 10)} //no uid

function Get_MenuBar_Tools_Internet_AccessYourBrowserHomePage() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Aller à la page d'accueil de votre navigateur..."], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Access your browser home page..."], 10)}
}

function Get_MenuBar_Tools_Internet_AccessYourBrowserHomePageForTransactions() //no uid
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Aller à la page d'accueil de votre navigateur..."], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Access the H_ome Page of Your Browser..."], 10)}
}

//function Get_MenuBar_Tools_Internet_ComposeAddress() //no uid
//{
//  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Composer une adresse..."], 10)}
//  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Compose Address..."], 10)}
//}

function Get_MenuBar_Tools_Internet_ComposeAddress() //no uid
{
  if (language == "french"){return Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Composer une adresse..."], 10)}
  else {return Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Compose Address..."], 10)}
}

function Get_MenuBar_Tools_Internet_ComposeAddressForTransactions() //no uid
{
  if (language == "french"){return Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Composer une adresse..."], 10)}
  else {return Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Compose Address..."], 10)}
}
//-----> fin  MenuTools_Get_functions
*/


//----------------------> MenuSearch_Get_functions 

//+++++++++++++++++++++++++ MENU RECHERCHE (SEARCH MENU) ++++++++++++++++++++++++++++

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

//----------------------> fin MenuSearch_Get_functions 


/*
//----------------------> MenuFileModulesUsersHelp_Get_functions
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


function Get_MenuBar_Users_RememberMySelection(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_477d", 10)}

function Get_MenuBar_Users_RememberMySelection_CheckboxImage(){return Get_MenuBar_Users_RememberMySelection().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", 1], 10)}



//+++++++++++++++++++++++++++++ MENU AIDE (HELP MENU) ++++++++++++++++++++++++++++++++++++++++++++

function Get_MenuBar_Help(){return Get_MenuBar().FindChild("Uid", "CustomizableMenu_3049", 10)}//ok

function Get_MenuBar_Help_ContentsAndIndex(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_5c52", 10)}//ok

function Get_MenuBar_Help_WhatsNew(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_35df", 10)}//ok

function Get_MenuBar_Help_ShortcutKeys(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_5110", 10)}//ok

function Get_MenuBar_Help_AboutCroesus(){return Get_SubMenus().FindChild("Uid", "CFMenuItem_cf20", 10)}//ok

//----------------------> fin  MenuFileModulesUsersHelp_Get_functions
*/



//++++++++++++++++++++++++++++++ MODULES BAR ++++++++++++++++++++++++++++++++++++++++

function Get_ModulesBar_BtnAccounts(){return Aliases.CroesusApp.winMain.barModules.btnAccounts}

function Get_ModulesBar_BtnClients(){return Aliases.CroesusApp.winMain.barModules.btnClients}

function Get_ModulesBar_BtnDashboard(){return Aliases.CroesusApp.winMain.barModules.btnDashboard}

function Get_ModulesBar_BtnModels(){return Aliases.CroesusApp.winMain.barModules.btnModels}

function Get_ModulesBar_BtnOrders(){return Aliases.CroesusApp.winMain.barModules.btnOrders}

function Get_ModulesBar_BtnPortfolio(){return Aliases.CroesusApp.winMain.barModules.btnPortfolio}

function Get_ModulesBar_BtnRelationships(){return Aliases.CroesusApp.winMain.barModules.btnRelationships}

function Get_ModulesBar_BtnSecurities(){return Aliases.CroesusApp.winMain.barModules.btnSecurities}

function Get_ModulesBar_BtnTransactions(){return Aliases.CroesusApp.winMain.barModules.btnTransactions}


//+++++++++++++++++++++++++++++++ Login ++++++++++++++++++++++++++++++++++++++++++++++ 
function Get_winLogin(){return Aliases.CroesusApp.winLogin}

function Get_WinLogin_LblUserName(){return Get_winLogin().FindChild("Uid", "TextBlock_a985", 10)} //ok

function Get_WinLogin_TxtUserName(){return Get_winLogin().FindChild("Uid", "TextBox_9c52", 10)} //ok

function Get_WinLogin_LblPassword(){return Get_winLogin().FindChild("Uid", "TextBlock_2a26", 10)} //ok

function Get_WinLogin_TxtPassword(){return Get_winLogin().FindChild("Uid", "PasswordBox_56e7", 10)} //ok

function Get_WinLogin_ChkMemorize(){return Get_winLogin().FindChild("Uid", "CheckBox_1c74", 10)} //ok

function Get_WinLogin_BtnOk(){return Get_winLogin().FindChild("Uid", "Button_31af", 10)} //ok

function Get_WinLogin_BtnClose(){return Get_winLogin().FindChild("Uid", "Button_3d4a", 10)} //ok

function Get_WinLogin_LblLegalText(){return Get_winLogin().FindChild("Uid", "TextBlock_0558", 10)} //ok




//****************************************************************** BARRE D'OUTILS (TOOLBAR) **********************************************************************
function Get_barToolbar(){return Aliases.CroesusApp.winMain.barToolbar}

//BtnPrintBoardsSelector accessible à partir du module Tableau de bord
function Get_Toolbar_BtnPrintBoardsSelector(){return Get_barToolbar().FindChild("Uid","DropDownMenuButtonItemSelector_65c6",10)}//ok

function Get_Toolbar_BtnPrintBoardsSelector_EveryBoard()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Tous les tableaux"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Every Board"], 10)}
}

function Get_Toolbar_BtnPrintBoardsSelector_MyTasks()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Mes tâches"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "My Tasks"], 10)}
}

function Get_Toolbar_BtnPrintBoardsSelector_MyOpenTasks()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Mes tâches ouvertes"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "My Open Tasks"], 10)}
}

//BtnPrint accessible à partir des modules  Modeles, Relation,Clients, Comptes, Portefeuille, Transactions, Titres, Ordres
function Get_Toolbar_BtnPrint(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_0ff7", 10)}//ok

function Get_Toolbar_BtnSum(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_a2b7", 10)}//ok

function Get_Toolbar_BtnManageSearchCriteria(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_c34c", 10)}//ok

function Get_Toolbar_BtnAddOrDisplayAnActiveCriterion(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_d20a", 10)}

function Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_18b1", 10)}

function Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_3449", 10)}

function Get_Toolbar_BtnSearch(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_9b3d", 10)}//ok

function Get_Toolbar_BtnAdd(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_a5ac", 10)}//ok

function Get_Toolbar_BtnDelete(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_8edd", 10)}//ok

function Get_Toolbar_BtnReportsAndGraphs(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_da44", 10)}//ok

function Get_Toolbar_BtnBondCalculator(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_f8b5", 10)}//ok

function Get_Toolbar_BtnAgenda(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_de96", 10)}//ok

function Get_Toolbar_BtnArchiveMyDocuments(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_efc4", 10)}//ok

function Get_Toolbar_BtnRebalance(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_3cb2", 10)}//ok

function Get_Toolbar_BtnCreateABuyOrder(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_9527", 10)}

function Get_Toolbar_BtnCreateASellOrder(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_c253", 10)}

function Get_Toolbar_BtnSwitchBlock(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_2446", 10)}

//BtnInternetAddresses accessible à partir des modules Ordres, Titres, Portefeuille, Comptes, Modeles, Tableau de bord, Clients, Relations
function Get_Toolbar_BtnInternetAddresses(){return Get_barToolbar().FindChild("Uid", "UrlSelector_bdb5", 10)}//ok

//BtnInternet accessible à partir du module Transactions
function Get_Toolbar_BtnInternet(){return Get_barToolbar().FindChild("Uid", "ToolbarDropDownButton_d90b", 10)}//ok

//BtnAccessTheFinancialPlanningTool accessible à partir des modules Portefeuille, Comptes, Clients, Relations
function Get_Toolbar_BtnAccessTheFinancialPlanningTool(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_aa62", 10)}

//BtnNaviPlan accessible à partir du module Relations
function Get_Toolbar_BtnNaviPlan(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_47ed", 10)}

function Get_Toolbar_BtnRQS(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_2005", 10)}

//Applicable aux modules Tableau de bord, Modeles, Portefeuille et Transactions
function Get_Toolbar_BtnQuickFilters(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_1956", 10)}//ok

//Applicable aux modules Relations, Clients, Comptes
function Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_b675", 10)}//ok

//Applicable aux modules Titres et Ordres
function Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_3d82", 10)}//ok

function Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders(){return Get_barToolbar().FindChild("Uid", "QuickFiltersControl_5f0c", 10).FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["ClickBox", true, 1] , 10)}

function Get_Toolbar_BtnDetailedInfo(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_ddc2", 10)}//ok

function Get_Toolbar_BtnLockTheApplication(){return Get_barToolbar().FindChild("Uid", "ToolbarButton_db70", 10)}//ok


//Menu du bouton Ajouter pour le module Clients

function Get_Toolbar_BtnAdd_AddDropDownMenu(){return Get_SubMenus().FindChild("Uid", "ContextMenu_8804", 10)} //Commune à Clients et Relations

function Get_Toolbar_BtnAdd_AddDropDownMenu_CreateFictitiousClient(){return Get_Toolbar_BtnAdd_AddDropDownMenu().FindChild("Uid", "MenuItem_19bd", 10)}

function Get_Toolbar_BtnAdd_AddDropDownMenu_CreateExternalClient(){return Get_Toolbar_BtnAdd_AddDropDownMenu().FindChild("Uid", "MenuItem_91a1", 10)}


//Menu du bouton Ajouter pour le module Relations

function Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship(){return Get_Toolbar_BtnAdd_AddDropDownMenu().FindChild("Uid", "MenuItem_f76c", 10)}

function Get_Toolbar_BtnAdd_AddDropDownMenu_JoinRelationship(){return Get_Toolbar_BtnAdd_AddDropDownMenu().FindChild("Uid", "MenuItem_e3ad", 10)}

function Get_Toolbar_BtnAdd_AddDropDownMenu_JoinRootClientsToRelationship(){return Get_Toolbar_BtnAdd_AddDropDownMenu().FindChild("Uid", "MenuItem_886e", 10)}

function Get_Toolbar_BtnAdd_AddDropDownMenu_JoinClientsToRelationship(){return Get_Toolbar_BtnAdd_AddDropDownMenu().FindChild("Uid", "MenuItem_2ec3", 10)}

function Get_Toolbar_BtnAdd_AddDropDownMenu_JoinAccountsToRelationship(){return Get_Toolbar_BtnAdd_AddDropDownMenu().FindChild("Uid", "MenuItem_e4b6", 10)}

function Get_Toolbar_BtnAdd_AddDropDownMenu_JoinToAGroupedRelationship(){return Get_Toolbar_BtnAdd_AddDropDownMenu().FindChild("Uid", "MenuItem_149b", 10)}


//Menu du bouton Internet

function Get_Toolbar_BtnInternetAddresses_ContextMenu(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"] , 10)}//no uid

function Get_Toolbar_BtnInternetAddresses_ContextMenu_Item1(){return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "1"] , 10)}

function Get_Toolbar_BtnInternetAddresses_ContextMenu_Quotes() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Cotes"] , 10)}
  else {return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Quotes"] , 10)}
}

function Get_Toolbar_BtnInternetAddresses_ContextMenu_Graphs() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Graphiques"] , 10)}
  else {return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Graphs"] , 10)}
}

function Get_Toolbar_BtnInternetAddresses_ContextMenu_Analysis() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Analyse"] , 10)}
  else {return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Analysis"] , 10)}
}

function Get_Toolbar_BtnInternetAddresses_ContextMenu_News() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Nouvelles"] , 10)}
  else {return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "News"] , 10)}
}

function Get_Toolbar_BtnInternetAddresses_ContextMenu_Company() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Compagnie"] , 10)}
  else {return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Company"] , 10)}
}

function Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessWebPage(WebPageAdress){return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", WebPageAdress] , 10)}//no uid

function Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePage()//no uid
{
  if (language == "french"){return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Aller à la page d'accueil de votre navigateur..."] , 10)}
  else {return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Access your browser home page..."] , 10)}
}

function Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePageForTransactions()//no uid
{
  if (language == "french"){return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Aller à la page d'accueil de votre navigateur..."] , 10)}
  else {return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Access the H_ome Page of Your Browser..."] , 10)}
}

function Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress()//no uid
{
  if (language == "french"){return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Composer une adresse..."] , 10)}
  else {return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Compose Address..."] , 10)} 
}

function Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddressForTransactions()//no uid
{
  if (language == "french"){return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Composer une adresse..."] , 10)}
  else {return Get_Toolbar_BtnInternetAddresses_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Compose Address..."] , 10)}
}

//Menu du bouton Filtres rapides

function Get_Toolbar_BtnQuickFilters_ContextMenu(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"] , 100)} 

function Get_Toolbar_BtnQuickFilters_ContextMenu_Item(FilterName){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", FilterName], 10)}

function Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Ajouter un filtre..." , 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Add a Filter..." , 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Gérer les filtres...", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Manage Filters...", 10)}
}


function Get_Toolbar_BtnQuickFilters_ContextMenu_PredefinedFiltersSeparator()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "Tag"], ["Separator", "Filtres prédéfinis"], 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "Tag"], ["Separator", "Predefined Filters"], 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_FicticiousClients()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Clients fictifs", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Ficticious Clients", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_ExternalClients()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Clients externes", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "External Clients", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_RealClients()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Clients réels", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Real Clients", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_MoreFilters() //Apparaît seulement lorsqu'il y a plus de dix filtres prédéfinis
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Autres filtres...", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "More Filters...", 10)}
}


function Get_Toolbar_BtnQuickFilters_ContextMenu_FilterFieldsSeparator()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "Tag"], ["Separator", "Champs de filtre"], 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "Tag"], ["Separator", "Filter Fields"], 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Address()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Adresse", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Address", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Address_PostalCode()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Code postal"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Postal Code"], 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Address_CityAndProvince()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Ville et province"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "City and Province"], 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Address_Address()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Adresse"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Address"], 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Address_Country()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Pays"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Country"], 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_FiscalYear()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Année financière", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Fiscal Year", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_AccountManager()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Chargé de comptes", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Account Manager", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_IACode()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Code de CP", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "IA Code", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Communication(){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Communication", 10)}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Email1()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Courriel 1", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Email 1", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Email2()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Courriel 2", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Email 2", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Email3()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Courriel 3", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Email 3", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Date(){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Date", 10)}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Date_LastUpdate()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Mise à jour"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Last Update"], 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Date_DateOfBirth()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Date de naissance"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Date of Birth"], 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Date_LastContact()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Dern. contact"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Last Contact"], 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Date_CreationDate()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Création"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Creation Date"], 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Currency()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Devise", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Currency", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_DefaultIndices()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Indices par défaut", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Default Indices", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Language()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Langue", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Language", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Margin()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Marge", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Margin", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_SIN()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "NAS", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "SIN", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_ClientNo()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "No client", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Client No.", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_RootNo()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "No racine", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Root No.", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Name()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Nom", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Name", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_FullName()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Nom complet", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Full Name", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Note(){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Note", 10)}

function Get_Toolbar_BtnQuickFilters_ContextMenu_FederalCorporationNumber()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Numéro corporation fédéral", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Federal Corporation Number", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_ProvincialCorporationNumber()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Numéro corporation provincial", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Provincial Corporation Number", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_InvestmentObjectiveRootClient()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Objectif de placement (Client racine)", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Investment Objective (Root Client)", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_InvestmentObjective()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Objectif de placement", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Investment Objective", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_ContactPerson()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Personne-ressource", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Contact Person", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Products()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Produits", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Products", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Profiles()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Profils", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Profiles", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Profiles_Default()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Défaut"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Default"], 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Profiles_Default_Profile(ProfileName){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", ProfileName], 10)}

function Get_Toolbar_BtnQuickFilters_ContextMenu_TargetReturn()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Rendement ciblé", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Target Return", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Segmentation(){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Segmentation", 10)}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Services(){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Services", 10)}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Gender()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Sexe", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Gender", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Balance()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Solde", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Balance", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Telephone()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Téléphone", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Telephone", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_ClientRelationshipNo()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "No relation client", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Client Relationship No.", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_Type(){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Type", 10)}

function Get_Toolbar_BtnQuickFilters_ContextMenu_TotalValue()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Valeur totale", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Total Value", 10)}
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_HasSleeves()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "A des segments", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Has sleeves", 10)}
}

function Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"] , 100)} //no uid

function Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_Item(filterName){return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", filterName] , 10)}

function Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_AddAFilter() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Ajouter un filtre..."] , 10)}
  else {return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Add a Filter..."] , 10)}
}

function Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_ManageFilters() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Gérer les filtres..."] , 10)}
  else {return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Manage Filters..."] , 10)}
}

function Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_NoFilter() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "< Aucun filtre >"] , 10)}
  else {return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "< No Filter >"] , 10)}
}

function Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_CommonStocks() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Actions ordinaires"] , 10)}
  else {return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Common Stocks"] , 10)}
}

function Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_Currencies() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Devises"] , 10)}
  else {return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Currencies"] , 10)}
}

function Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_Indices(){return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Indices"] , 10)} //no uid

function Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_MutualFunds() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Fonds d'investissement"] , 10)}
  else {return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Mutual Funds"] , 10)}
}

//---???

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



//*********************************** INDEX DES DEVISES DANS COMBOBOX (CURRENCIES INDEXES IN COMBOBOX)**************************************

function Get_IndexForCurrencyCAD(){return 0}

function Get_IndexForCurrencyEUR(){return 1}

function Get_IndexForCurrencyNOK(){return 2}

function Get_IndexForCurrencySEK(){return 3}

function Get_IndexForCurrencyUSD(){return 4}



//**************** ÉLÉMENTS DU COMBOBOX CHAMP DE LA FENÊTRE AJOUTER OU MODIFIER UN FILTRE (ADD OR EDIT FILTER FIELD COMBOBOX ITEMS) *******************
/*
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
//---> fin ??
*/

//******************************************************* BOUTON EXPORTER VERS MSEXCEL (EXPORT TO EXCEL BUTTON) ****************************************************

function Get_RelationshipsClientsAccountsGrid_BtnExportToMSExcel()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "ToolTip"], ["Button", "Exporter vers MS Excel..."], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "ToolTip"], ["Button", "Export to MS Excel..."], 10)}
}



//******************************************************* FILTRES PAR POSITION (FILTERS BY POSITION) ****************************************************

function Get_RelationshipsClientsAccountsGrid_BtnFilter(WPFControlOrdinalNo){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", WPFControlOrdinalNo, true], 10)}

function Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnTextBlock(WPFControlOrdinalNo){return Get_RelationshipsClientsAccountsGrid_BtnFilter(WPFControlOrdinalNo).FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["TextBlock", 1, true], 10)}

function Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnEditView(WPFControlOrdinalNo){return Get_RelationshipsClientsAccountsGrid_BtnFilter(WPFControlOrdinalNo).FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["Button", 1, true], 10)}

function Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(WPFControlOrdinalNo){return Get_RelationshipsClientsAccountsGrid_BtnFilter(WPFControlOrdinalNo).FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["Button", 2, true], 10)}



//******************************************************* FILTRES PAR DESCRIPTION (FILTERS BY DESCRIPTION) ****************************************************

function Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription(FilterDescription){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "DataContext.FilterDescription", "IsVisible"], ["ToggleButton", FilterDescription, true], 10)}

function Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription_BtnTextBlock(FilterDescription){return Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription(FilterDescription).FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["TextBlock", 1, true], 10)}

function Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription_BtnEditView(FilterDescription)
{
  var tooltipText = (language == "french")? "Modifier/Consulter le filtre courant": "Edit/View current filter";
  return Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription(FilterDescription).FindChild(["ClrClassName", "ToolTip.OleValue", "IsVisible"], ["Button", tooltipText, true], 10);
}

function Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription_BtnRemove(FilterDescription)
{
  var tooltipText = (language == "french")? "Retirer le filtre courant": "Remove the current filter";
  return Get_RelationshipsClientsAccountsGrid_BtnFilterByDescription(FilterDescription).FindChild(["ClrClassName", "ToolTip.OleValue", "IsVisible"], ["Button", tooltipText, true], 10);
}



//******************************************************* CRITÈRES (CRITERIA) ****************************************************

function Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria(){return Get_RelationshipsClientsAccountsGrid().FindChild("Uid", "ToggleButton_5139", 10)}

function Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnRedCheck(){return Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["Image", 1, true], 10)}

function Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnTextBlock(){return Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["TextBlock", 1, true], 10)}

function Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnEditView()
{
  var tooltipText = (language == "french")? "Modifier/Consulter le critère courant": "Edit/View current criteria";
  return Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria().FindChild(["ClrClassName", "ToolTip.OleValue", "IsVisible"], ["Button", tooltipText, true], 10);
}

function Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnRemove()
{
  var tooltipText = (language == "french")? "Retirer le critère courant de la grille": "Remove the current criteria from grid";
  return Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria().FindChild(["ClrClassName", "ToolTip.OleValue", "IsVisible"], ["Button", tooltipText, true], 10);
}


//-----MenuTools_Get_functions
//*************************************************** FENÊTRE COMPOSER UNE ADRESSE (COMPOSE ADDRESS WINDOW) *************************************************
//Tools--> Internet--> COMPOSE ADDRESS
/*
function Get_WinComposeAddress(){return Aliases.CroesusApp.winComposeAddress}

function Get_WinComposeAddress_LblAddress(){return Get_WinComposeAddress().FindChild("Uid", "TextBlock_7056", 10)}

function Get_WinComposeAddress_TxtAddress(){return Get_WinComposeAddress().FindChild("Uid", "TextBox_5a7f", 10)}

function Get_WinComposeAddress_BtnLaunch(){return Get_WinComposeAddress().FindChild("Uid", "Button_71ad", 10)}

function Get_WinComposeAddress_BtnCancel(){return Get_WinComposeAddress().FindChild("Uid", "Button_329d", 10)}


//Les fonctions Get pour la fenêtre Composer une adresse du module Transactions

function Get_WinComposeAddress_LblAddressForTransactions(){return Get_WinComposeAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinComposeAddress_TxtAddressForTransactions(){return Get_WinComposeAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinComposeAddress_BtnLaunchForTransactions(){return Get_WinComposeAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinComposeAddress_BtnCancelForTransactions(){return Get_WinComposeAddress().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}

//-----  fin MenuTools_Get_functions


//----> MenuSearch_Get_functions
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
//----> fin  MenuSearch_Get_functions
*/


//************************************************** IMPRESSION (PRINTING) ****************************************************************

function Get_DlgPrint(){return Aliases.CroesusApp.dlgPrint}

function Get_DlgPrint_BtnApply(){return Aliases.CroesusApp.dlgPrint.btnApply}

function Get_DlgPrint_BtnCancel(){return Aliases.CroesusApp.dlgPrint.btnCancel}

function Get_DlgPrint_BtnPrint(){return Aliases.CroesusApp.dlgPrint.btnPrint}

function Get_DlgPrinting(){return Aliases.CroesusApp.dlgPrinting}

function Get_DlgPrinting_LblMessage(){return Aliases.CroesusApp.dlgPrinting.lblPrintingCancelled} // CP : Retour à la version d'avant CX-78

function Get_DlgPrinting_LblMessageForPrintEveryBoard(){return Aliases.CroesusApp.dlgPrinting.lblPrintingCancelledForPrintEveryBoard} 

function Get_DlgPrinting_BtnOK(){return Get_DlgPrinting().FindChild(["WndClass", "WndCaption"], ["Button", "OK"], 10)}

function Get_DlgPrinting_BtnOKForTransactionsAndAgenda(){return Get_DlgPrinting().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_DlgPrint_SelectPrinter(){return Get_DlgPrint().FindChild(["WndClass", "WndCaption"], ["SysListView32", "FolderView"], 10)}

/*
//----------> MenuTools_Get_functions
//****************************************** FENÊTRE CALCULATRICE D'OBLIGATIONS (BOND CALCULATOR) *****************************************
//Tools --> Bons Calculator 
function Get_WinBondCalculator(){return Aliases.CroesusApp.winBondCalculator}

function Get_WinBondCalculator_BtnClose() //no uid
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Fermer"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Close"], 10)}
}

function Get_WinBondCalculator_BtnDaysBetweenDates() //no uid
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Jours entre les dates"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Days Between Dates"], 10)}
}

function Get_WinBondCalculator_BtnCalculate() //no uid
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Calculer"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Calculate"], 10)}
}

function Get_WinBondCalculator_BtnCopyBond() //no uid
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Copier l'obligation..."], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Copy _Bond..."], 10)}
}

function Get_WinBondCalculator_BtnReset() //no uid
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Réi_nitialiser"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Reset"], 10)}
}


function Get_WinBondCalculator_LblBondType()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Type d'obligation:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Bond Type:"], 10)}
}

function Get_WinBondCalculator_LblInterestRate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Taux d'intérêt:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Interest Rate:"], 10)}
}

function Get_WinBondCalculator_LblFirstCouponDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date premier coupon:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "First Coupon Date:"], 10)}
}

function Get_WinBondCalculator_LblPurchaseDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date d'achat:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Purchase Date:"], 10)}
}

function Get_WinBondCalculator_LblMaturityDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date d'échéance:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Maturity Date:"], 10)}
}

function Get_WinBondCalculator_LblIssueDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date d'émission:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Issue date:"], 10)}
}

function Get_WinBondCalculator_LblCurrentDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date courante:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Current Date:"], 10)}
}

function Get_WinBondCalculator_LblConversionDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Date de conversion:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Conversion Date:"], 10)}
}

function Get_WinBondCalculator_LblDayCount()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Format de calendrier:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Day Count:"], 10)}
}

function Get_WinBondCalculator_LblCompounding()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Composition:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Compounding:"], 10)}
}

function Get_WinBondCalculator_LblPurchasePrice()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Prix d'achat:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Purchase Price:"], 10)}
}

function Get_WinBondCalculator_LblMarketPrice()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Prix au marché:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Market Price:"], 10)}
}

function Get_WinBondCalculator_LblParValue()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Valeur au pair:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Par Value:"], 10)}
}

function Get_WinBondCalculator_LblCostYield()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Rend. achat (%):"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Cost Yield (%):"], 10)}
}

function Get_WinBondCalculator_LblMarketYield()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Rend. au marché (%):"], 10)}//La modification a été faite selon le fichier Excel Modification_Documentation 
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Market Yield (%):"], 10)}
}

function Get_WinBondCalculator_LblYieldToDate()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Rend. à jour (%):"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Yld-to-Date (%):"], 10)}
}

function Get_WinBondCalculator_LblModifiedDuration()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Durée modifiée:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Modified Duration:"], 10)}
}

function Get_WinBondCalculator_LblAccInterest()//uid is not unique
{
  if (language == "french"){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Int.courus/1000:"], 10)}
  else {return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlText"], ["Label", "Acc. Int /1000:"], 10)}
}


function Get_WinBondCalculator_CmbBondABondType(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinBondCalculator_CmbBondBBondType(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinBondCalculator_CmbBondCBondType(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinBondCalculator_CmbBondDBondType(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)}

function Get_WinBondCalculator_CmbBondADayCount(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10)}

function Get_WinBondCalculator_CmbBondBDayCount(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "6"], 10)}

function Get_WinBondCalculator_CmbBondCDayCount(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "7"], 10)}

function Get_WinBondCalculator_CmbBondDDayCount(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "8"], 10)}

function Get_WinBondCalculator_CmbBondACompounding(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "9"], 10)}

function Get_WinBondCalculator_CmbBondBCompounding(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "10"], 10)}

function Get_WinBondCalculator_CmbBondCCompounding(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "11"], 10)}

function Get_WinBondCalculator_CmbBondDCompounding(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "12"], 10)}


function Get_WinBondCalculator_TxtBondAInterestRate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)}

function Get_WinBondCalculator_TxtBondBInterestRate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}

function Get_WinBondCalculator_TxtBondCInterestRate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "3"], 10)}

function Get_WinBondCalculator_TxtBondDInterestRate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "4"], 10)}

function Get_WinBondCalculator_TxtBondAPurchasePrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "5"], 10)}

function Get_WinBondCalculator_TxtBondBPurchasePrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "6"], 10)}

function Get_WinBondCalculator_TxtBondCPurchasePrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "7"], 10)}

function Get_WinBondCalculator_TxtBondDPurchasePrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "8"], 10)}

function Get_WinBondCalculator_TxtBondAMarketPrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "9"], 10)}

function Get_WinBondCalculator_TxtBondBMarketPrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "10"], 10)}

function Get_WinBondCalculator_TxtBondCMarketPrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "11"], 10)}

function Get_WinBondCalculator_TxtBondDMarketPrice(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "12"], 10)}

function Get_WinBondCalculator_TxtBondAParValue(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "13"], 10)}

function Get_WinBondCalculator_TxtBondBParValue(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "14"], 10)}

function Get_WinBondCalculator_TxtBondCParValue(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "15"], 10)}

function Get_WinBondCalculator_TxtBondDParValue(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "16"], 10)}

function Get_WinBondCalculator_TxtBondACostYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "17"], 10)}

function Get_WinBondCalculator_TxtBondBCostYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "18"], 10)}

function Get_WinBondCalculator_TxtBondCCostYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "19"], 10)}

function Get_WinBondCalculator_TxtBondDCostYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "20"], 10)}

function Get_WinBondCalculator_TxtBondAMarketYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "21"], 10)}

function Get_WinBondCalculator_TxtBondBMarketYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "22"], 10)}

function Get_WinBondCalculator_TxtBondCMarketYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "23"], 10)}

function Get_WinBondCalculator_TxtBondDMarketYieldPercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "24"], 10)}

function Get_WinBondCalculator_TxtBondAYieldToDatePercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "25"], 10)}

function Get_WinBondCalculator_TxtBondBYieldToDatePercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "26"], 10)}

function Get_WinBondCalculator_TxtBondCYieldToDatePercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "27"], 10)}

function Get_WinBondCalculator_TxtBondDYieldToDatePercent(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "28"], 10)}

function Get_WinBondCalculator_TxtBondAModifiedDuration(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "29"], 10)}

function Get_WinBondCalculator_TxtBondBModifiedDuration(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "30"], 10)}

function Get_WinBondCalculator_TxtBondCModifiedDuration(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "31"], 10)}

function Get_WinBondCalculator_TxtBondDModifiedDuration(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "32"], 10)}

function Get_WinBondCalculator_TxtBondAAccInt(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "33"], 10)}

function Get_WinBondCalculator_TxtBondBAccInt(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "34"], 10)}

function Get_WinBondCalculator_TxtBondCAccInt(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "35"], 10)}

function Get_WinBondCalculator_TxtBondDAccInt(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "36"], 10)}


function Get_WinBondCalculator_DtpBondAFirstCouponDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinBondCalculator_DtpBondBFirstCouponDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 10)}

function Get_WinBondCalculator_DtpBondCFirstCouponDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "3"], 10)}

function Get_WinBondCalculator_DtpBondDFirstCouponDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "4"], 10)}

function Get_WinBondCalculator_DtpBondAPurchaseDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "5"], 10)}

function Get_WinBondCalculator_DtpBondBPurchaseDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "6"], 10)}

function Get_WinBondCalculator_DtpBondCPurchaseDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "7"], 10)}

function Get_WinBondCalculator_DtpBondDPurchaseDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "8"], 10)}

function Get_WinBondCalculator_DtpBondAMaturityDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "9"], 10)}

function Get_WinBondCalculator_DtpBondBMaturityDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "10"], 10)}

function Get_WinBondCalculator_DtpBondCMaturityDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "11"], 10)}

function Get_WinBondCalculator_DtpBondDMaturityDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "12"], 10)}

function Get_WinBondCalculator_DtpBondAIssueDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "13"], 10)}

function Get_WinBondCalculator_DtpBondBIssueDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "14"], 10)}

function Get_WinBondCalculator_DtpBondCIssueDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "15"], 10)}

function Get_WinBondCalculator_DtpBondDIssueDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "16"], 10)}

function Get_WinBondCalculator_DtpBondACurrentDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "17"], 10)}

function Get_WinBondCalculator_DtpBondBCurrentDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "18"], 10)}

function Get_WinBondCalculator_DtpBondCCurrentDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "19"], 10)}

function Get_WinBondCalculator_DtpBondDCurrentDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "20"], 10)}

function Get_WinBondCalculator_DtpBondAConversionDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "21"], 10)}

function Get_WinBondCalculator_DtpBondBConversionDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "22"], 10)}

function Get_WinBondCalculator_DtpBondCConversionDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "23"], 10)}

function Get_WinBondCalculator_DtpBondDConversionDate(){return Get_WinBondCalculator().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "24"], 10)}

//----------> fin  MenuTools_Get_functions


//---------->   MenuTools_Get_functions
//************************************** FENÊTRE DOCUMENTS PERSONNELS (PERSONAL DOCUMENTS WINDOW) *********************************************
//Tools --> Archive me documents
function Get_WinPersonalDocuments(){return Aliases.CroesusApp.winPersonalDocuments}

function Get_WinPersonalDocuments_BtnOK(){return Get_WinPersonalDocuments().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}//no uid

//Les fonctions suivantes sont aussi communes aux fenêtres Info Client/Relation (onglet Documents) et Info modèle (onglet Documents)

function Get_PersonalDocuments_Toolbar(){return Get_CroesusApp().FindChild("Uid", "ToolBarTray_536b", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnShowHideFolderView(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "ToggleButton_4ecd", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnAddAFile(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_7d78", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnRemove(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_25cf", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnRefresh(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_c153", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnCut(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_1f07", 10)}

function Get_PersonalDocuments_Toolbar_BtnCopy(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_7b0f", 10)}

function Get_PersonalDocuments_Toolbar_BtnPaste(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_4c55", 10)}//ok

function Get_PersonalDocuments_Toolbar_TxtSearch(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "TextBox_dafe", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnSearch(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "Button_3e39", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnFilterAll(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "ToggleButton_4b62", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnFilterEmail(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "ToggleButton_9796", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnFilterPdf(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "ToggleButton_5b0c", 10)}//ok

function Get_PersonalDocuments_Toolbar_BtnFilterFile(){return Get_PersonalDocuments_Toolbar().FindChild("Uid", "ToggleButton_ca4f", 10)}//ok


function Get_PersonalDocuments_GrpComments(){return Get_CroesusApp().FindChild("Uid", "GroupBox_4d7f", 10)}//ok

function Get_PersonalDocuments_GrpComments_TxtComment(){return Get_PersonalDocuments_GrpComments().FindChild("Uid", "TextBox_a547", 10)}//ok

function Get_PersonalDocuments_GrpComments_BtnEdit(){return Get_PersonalDocuments_GrpComments().FindChild("Uid", "Button_b3e0", 10)}//ok

function Get_PersonalDocuments_GrpComments_BtnSave(){return Get_PersonalDocuments_GrpComments().FindChild("Uid", "Button_d631", 10)}

function Get_PersonalDocuments_GrpDocumentProperties(){return Get_CroesusApp().FindChild("Uid", "GroupBox_efd1", 10)}

function Get_PersonalDocuments_GrpDocumentProperties_TxtPath(){return Get_PersonalDocuments_GrpDocumentProperties().FindChild("Uid", "TextBlock_5e79", 10)}

function Get_WinPersonalDocuments_TvwDocuments(){return Get_WinPersonalDocuments().FindChild("Uid", "TreeView_bc22", 10)}//ok

function Get_WinPersonalDocuments_TvwDocuments_TviUser(){return Get_WinPersonalDocuments().FindChild("Uid", "TreeViewItem_5e70", 10)}

function Get_WinPersonalDocuments_TvwDocuments_TvReport(){return Get_CroesusApp().FindChild("Uid", "TreeViewItem_a6b2", 10)}

function Get_PersonalDocuments_TvwDocumentsForClientAndModel(){return Get_CroesusApp().FindChild("Uid", "TreeView_856c", 10)}

function Get_PersonalDocuments_LstDocuments(){return Get_CroesusApp().FindChild("Uid", "ListBox_25ba", 10)}//ok

function Get_PersonalDocuments_LstDocuments_ItemTopDocument(){return Get_PersonalDocuments_LstDocuments().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", "2"], 10)}

function Get_PersonalDocuments_LstDocuments_ContextMenu_NewFolder()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Nouveau dossier", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "New Folder", 10)}
}

function Get_PersonalDocuments_LstDocuments_ContextMenu(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", "1"] , 100)} 
//----------> fin  MenuTools_Get_functions



//------> MenuSearch_Get_functions
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

//------> fin  MenuSearch_Get_functions

//------> MenuSearch_Get_functions

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

//------> fin MenuSearch_Get_functions


//---->??
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

// ----> fin MenuSearch_Get_functions



//----> MenuFileModulesUsersHelp_Get_functions
//********************************** FENÊTRE PROTÉGER LES DONNÉES DE L'APPLICATION (LOCK THE APPLICATION WINDOW) ***************************************************
//File--> Lock
function Get_WinLockTheApplication(){return Aliases.CroesusApp.winLockTheApplication}

function Get_WinLockTheApplication_LblPassword(){return Get_WinLockTheApplication().FindChild("Uid", "TextBlock_1ce1", 10)} 

function Get_WinLockTheApplication_TxtPassword(){return Get_WinLockTheApplication().FindChild("Uid", "PasswordBox_094f", 10)} 

function Get_WinLockTheApplication_BtnOK(){return Get_WinLockTheApplication().FindChild("Uid", "Button_36ba", 10)} 

function Get_WinLockTheApplication_BtnQuit(){return Get_WinLockTheApplication().FindChild("Uid", "Button_80a0", 10)} 

//----> fin MenuFileModulesUsersHelp_Get_functions

*/

//************** Boite de dialogue "Le nom d'utilisateur ou le mot de passe est incorrect" (User name or password is not valid dialogbox) **************************

function Get_DlgUserNameOrPasswordIsNotValid(){return Aliases.CroesusApp.dlgUserNameOrPasswordIsNotValid}

function Get_DlgUserNameOrPasswordIsNotValid_LblUserNameOrPasswordIsNotValid(){return Get_DlgUserNameOrPasswordIsNotValid().FindChild("Uid", "Label_f867", 10)}//ok

function Get_DlgUserNameOrPasswordIsNotValid_BtnOK(){return Get_DlgUserNameOrPasswordIsNotValid().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}//no uid

/*
//---->MenuReports_Get_functions
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
//---->fin MenuReports_Get_functions


//----> MenuReports_Get_functions
//************************************* FENÊTRE EXPORT VERS MS WORD DE RAPPORTS*****************************************************
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
//---->fin MenuReports_Get_functions

//----> MenuReports_Get_functions
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
//---->fin  MenuReports_Get_functions
*/

//********************************** BOITE DE DIALOGUE DE PROGRESSION CROESUS (PROGRESS CROESUS DIALOG BOX) ****************************

function Get_DlgProgressCroesus(){return Get_CroesusApp().FindChild("Uid", "ProgressCroesusWindow_b5e1", 10)}

function Get_DlgProgressCroesus_LblPercentage(){return Get_DlgProgressCroesus().FindChild("Uid", "Label_814f", 10)}

function Get_DlgProgressCroesus_BtnStopExporting(){return Get_CroesusApp().FindChild("Uid", "Button_ba8c", 10)}



//************************************** BOITE DE DIALOGUE CROESUS (CROESUS DIALOG BOX) *********************************************

function Get_DlgCroesus(){return Aliases.CroesusApp.dlgCroesus}

function Get_DlgCroesus_LblMessage(){return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "1"], 10)} // YR modif pour BNC 78-CX avant TextBlock



function Get_DlgCroesus_LblMessage1(){return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlOrdinalNo", "VisibleOnScreen"], ["Label", "1", true], 10)}

function Get_DlgCroesus_BtnOK(){return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_DlgCroesus_RdoCreateANewCriterion() //Gestion des critères de recherche pour les restrictions
{
  if (language == "french"){return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Créer un nouveau critère?"], 10)}
  else {return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Create a new criterion?"], 10)}
}

function Get_DlgCroesus_RdoChangeTheCurrentCriterion() //Gestion des critères de recherche pour les restrictions
{
  if (language == "french"){return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Modifier le critère courant?"], 10)}
  else {return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Change the current criterion?"], 10)}
}

function Get_DlgCroesus_BtnYes()
{
  if (language == "french"){return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Oui"], 10)}
  else {return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Yes"], 10)}
}

function Get_DlgCroesus_BtnNo()
{
  if (language == "french"){return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Non"], 10)}
  else {return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_No"], 10)}
}

function Get_DlgCroesus_BtnCancel()
{
  if (language == "french"){return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_DlgCroesus().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_DlgCroesus_TxtReason(){return Get_DlgCroesus().FindChild("Uid","TextBox_a93e", 10)}


//********************************** BOITE DE DIALOGUE CONFIRMATION DE L'ACTION (CONFIRM ACTION DIALOG BOX) *********************************

function Get_DlgConfirmAction(){return Aliases.CroesusApp.dlgConfirmAction}

function Get_DlgConfirmAction_LblMessage(){return Get_DlgConfirmAction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_DlgConfirmAction_BtnYes()
{
  if (language == "french"){return Get_DlgConfirmAction().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Oui"], 10)}
  else {return Get_DlgConfirmAction().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Yes"], 10)}
}

function Get_DlgConfirmAction_BtnNo()
{
  if (language == "french"){return Get_DlgConfirmAction().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Non"], 10)}
  else {return Get_DlgConfirmAction().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_No"], 10)}
}

function Get_DlgConfirmAction_BtnCancel()
{
  if (language == "french"){return Get_DlgConfirmAction().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_DlgConfirmAction().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_DlgConfirmAction_BtnOK(){return Get_DlgConfirmAction().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_DlgConfirmAction_BtnDelete()
{
  if (language == "french"){return Get_DlgConfirmAction().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
  else {return Get_DlgConfirmAction().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"], 10)}
}

function Get_DlgConfirmAction_TxtRiskIndexPasswordBox(){return Get_DlgConfirmAction().FindChild("Uid", "PasswordBox_3e96", 10)}





//********************************** BOITE DE DIALOGUE CONFIRMATION (CONFIRMATION DIALOG BOX) *********************************

function Get_DlgConfirmation(){return Aliases.CroesusApp.dlgConfirmation}

function Get_DlgConfirmation_LblMessageCF(){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "1"], 10)}
function Get_DlgConfirmation_LblMessage(){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MessageWindow", 1], 10)} //CP: Modifié pour CO-90-07-22

function Get_DlgConfirmation_LblMessage1(){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}

function Get_DlgConfirmation_RdoCreateANewCriterion() //Gestion des critères de recherche pour les restrictions
{
  if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Créer un nouveau critère?"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Create a new criterion?"], 10)}
}

function Get_DlgConfirmation_RdoChangeTheCurrentCriterion() //Gestion des critères de recherche pour les restrictions
{
  if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Modifier le critère courant?"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Change the current criterion?"], 10)}
}

function Get_DlgConfirmation_TxtReason(){return Get_DlgConfirmation().FindChild("Uid", "TextBox_a93e", 10)}


function Get_DlgConfirmation_BtnCopy(){
if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button","Copier" ], 10)}
else{ return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button","Copy" ], 10)}
}

function Get_DlgConfirmation_BtnDelete(){
if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button","Supprimer" ], 10)}
else{ return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button","Delete" ], 10)}
}


function Get_DlgConfirmation_TxtRiskIndexPasswordBox(){return Get_DlgConfirmation().FindChild("Uid", "PasswordBox_3e96", 10)}

function Get_DlgConfirmation_BtnRemove(){
if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button","S_upprimer" ], 10)}
else{ return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button","De_lete" ], 10)}
}


function Get_DlgConfirmation_BtnOk(){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlName"], ["Button", "PART_OK"], 10)} //retirer la relation dans la partie détails module Relations

function Get_DlgConfirmation_BtnYes(){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlName"], ["Button", "PART_Yes"], 10)}

function Get_DlgConfirmation_BtnCancel(){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlName"], ["Button", "PART_No"], 10)} //Btn Annuler

function Get_DlgConfirmation_Btncancel(){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlName"], ["Button", "PART_Cancel"], 10)}

function Get_DlgConfirmation_BtnReinitialize()
{
  if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Réinitialiser"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Reinitialize"], 10)}
}


function Get_DlgConfirmation_BtnConfirm()
{
  if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Confirmer"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Confirm"], 10)}
}


function Get_DlgConfirmation_BtnContinue()
{
  if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Continuer"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Continue"], 10)}
}

function Get_DlgConfirmation_BtnYes1()
{
  if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Oui"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Yes"], 10)}
}

function Get_DlgConfirmation_BtnNo()
{
  if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Non"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "No"], 10)}
}

function Get_DlgConfirmation_BtnRemoveSelection()
{
  if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Retirer la sélection"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Remove Selection"], 10)}
}

function Get_DlgConfirmation_BtnInclude(){
    if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button","Inclure" ], 10)}
    else{ return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button","Include" ], 10)}
}

//********************************** BOITE DE DIALOGUE ERREUR (ERROR DIALOG BOX) *********************************

function Get_DlgError(){return Aliases.CroesusApp.dlgError}

//function Get_DlgError_LblMessage(){return Get_DlgError().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)}

function Get_DlgError_LblMessage1(){return Get_DlgError().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)}

function Get_DlgError_LblMessage(){return Get_DlgError().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MessageWindow", "1"], 10)}//EM: Modifié pour CO-90-07-22

function Get_DlgError_BtnOK(){return Get_DlgError().FindChild(["WndClass", "WndCaption"], ["Button", "OK"], 10)}

function Get_DlgError_Btn_OK(){return Get_DlgError().FindChild(["ClrClassName", "WPFControlName"], ["Button", "PART_OK"], 10)}


//************************************** BOITE DE DIALOGUE AVERTISSEMENT (WARNING DIALOG BOX) *********************************************

function Get_DlgWarning(){return Aliases.CroesusApp.dlgWarning}

function Get_DlgWarning_LblMessage1(){return Get_DlgWarning().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}
function Get_DlgWarning_LblMessage(){return Get_DlgWarning().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MessageWindow", 1], 10)} //CP : Modifiée pour versions CO

function Get_DlgWarning_BtnOK(){return Get_DlgWarning().FindChild(["ClrClassName", "WPFControlText"], ["Button", "OK"], 10)}

function Get_DlgWarning_LblTheFilterYouHaveAppliedContainsNoData()
{
    var noDataMessage = (language == "french")? "Le filtre que vous avez appliqué ne contient aucune donnée.": "The filter you have applied contains no data.";
    return Get_DlgWarning().FindChild(["ClrClassName", "WPFControlOrdinalNo", "Message"], ["MessageWindow", 1, noDataMessage], 10)
} 


//**************************************** BOÎTE DE DIALOGUE INFORMATION (INFORMATION DIALOG BOX) ********************************************

function Get_DlgInformation(){return Aliases.CroesusApp.dlgInformation}

//function Get_DlgInformation_LblMessage(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "1"], 10)}
function Get_DlgInformation_LblMessage(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["MessageWindow", 1], 10)} //EM: Modifié pour CO-90-07-22

function Get_DlgInformation_BtnOK(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlText"], ["Button", "OK"], 10)}


function Get_DlgInformation_LblMessage1(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)}//Sa:j'ai pas supprimé la fonction Get_DlgInformation_BtnOK aprce que je sais pas s'il y a des scripts qui l'utilisent

//**************************************** BOÎTE DE DIALOGUE EXPORTER VERS (EXPORT TO DIALOG BOX) ********************************************

function Get_DlgExportTo(){return Aliases.CroesusApp.dlgExportTo}

function Get_DlgExportTo_LblMessage(){return Get_DlgExportTo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_DlgExportTo_BtnOK(){return Get_DlgExportTo().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}



//********************************* BOÎTE DE DIALOGUE SÉLECTIONNER LE NOM DU FICHIER (SELECT THE FILE NAME DIALOG BOX) ***********************************

function Get_DlgSelectTheFileName(){return Aliases.CroesusApp.dlgSelectTheFileName}

function Get_DlgSelectTheFileName_CmbFileName(){return Get_DlgSelectTheFileName().FindChild(["WndClass", "Index"], ["ComboBox", 1], 10)}

function Get_DlgSelectTheFileName_CmbFileName_TxtFileName(){return Get_DlgSelectTheFileName_CmbFileName().FindChild(["WndClass", "Index"], ["Edit", 1], 10)}

function Get_DlgSelectTheFileName_BtnSave(){
          if (Get_DlgSelectTheFileName().FindChild(["WndClass", "WndCaption"], ["Button", "&Save"], 10).Exists)
              return Get_DlgSelectTheFileName().FindChild(["WndClass", "WndCaption"], ["Button", "&Save"], 10)
          else                        
              return Get_DlgSelectTheFileName().FindChild(["WndClass", "WndCaption"], ["Button", "&Enregistrer"], 10)}

function Get_DlgSelectTheFileName_BtnCancel(){return Get_DlgSelectTheFileName().FindChild(["WndClass", "WndCaption"], ["Button", "Cancel"], 10)}


//********************************* BOÎTE DE DIALOGUE Enregistrer la sortie d'impression sous (Save Print Output As) ***********************************

function Get_DlgSavePrintOutputAs(){return Aliases.CroesusApp.Window("#32770", "Save Print Output As", 1)}

function Get_DlgSavePrintOutputAs_CmbFileName(){return Get_DlgSavePrintOutputAs().FindChild(["WndClass", "Index"], ["ComboBox", 1], 10)}

function Get_DlgSavePrintOutputAs_CmbFileName_TxtFileName(){return Get_DlgSavePrintOutputAs_CmbFileName().FindChild(["WndClass", "Index"], ["Edit", 1], 10)}

function Get_DlgSavePrintOutputAs_BtnSave(){return Get_DlgSavePrintOutputAs().FindChild(["WndClass", "WndCaption"], ["Button", "&Save"], 10)}

function Get_DlgSavePrintOutputAs_BtnCancel(){return Get_DlgSavePrintOutputAs().FindChild(["WndClass", "WndCaption"], ["Button", "Cancel"], 10)}




//********************************* BOÎTE DE DIALOGUE OUVRIR (OPEN DIALOG BOX) ***********************************

function Get_DlgOpen(){return Aliases.CroesusApp.dlgOpen}

function Get_DlgOpen_CmbFileName(){return Get_DlgOpen().FindChild(["WndClass", "Index"], ["ComboBox", "1"], 10)}

function Get_DlgOpen_CmbFileName_TxtFileName(){return Get_DlgOpen_CmbFileName().FindChild(["WndClass", "Index"], ["Edit", "1"], 10)}

function Get_DlgOpen_BtnOpen(){return Get_DlgOpen().FindChild(["WndClass", "Index"], ["Button", "1"], 10)}

function Get_DlgOpen_BtnCancel(){return Get_DlgOpen().FindChild(["WndClass", "Index"], ["Button", "2"], 10)}



//********************************* BOÎTE DE DIALOGUE LOCATION NOT AVAILABLE (LOCATION NOT AVAILABLE DIALOG BOX) ***********************************

function Get_DlgLocationNotAvailable(){return Sys.FindChild(["WndClass", "WndCaption"], ["#32770", "Location Not Available"], 100)}

function Get_DlgLocationNotAvailable_BtnOK(){return Get_DlgLocationNotAvailable().FindChild(["WndClass", "WndCaption"], ["Button", "OK"], 10)}



//*********************************** FINANCIAL INSTRUMENT SELECTOR WINDOW (BUY OR SELL AN ORDER) **********************************************

function Get_WinFinancialInstrumentSelector(){return Aliases.CroesusApp.winFinancialInstrumentSelector}

function Get_WinFinancialInstrumentSelector_BtnOK(){return Get_WinFinancialInstrumentSelector().FindChild("Uid", "Button_f44c", 10)}

function Get_WinFinancialInstrumentSelector_BtnCancel(){return Get_WinFinancialInstrumentSelector().FindChild("Uid", "Button_b055", 10)}

function Get_WinFinancialInstrumentSelector_RdoStocks(){return Get_WinFinancialInstrumentSelector().FindChild("Uid", "RadioButton_87ff", 10)}

function Get_WinFinancialInstrumentSelector_RdoFixedIncome(){return Get_WinFinancialInstrumentSelector().FindChild("Uid", "RadioButton_e6c0", 10)}

function Get_WinFinancialInstrumentSelector_RdoMutualFunds(){return Get_WinFinancialInstrumentSelector().FindChild("Uid", "RadioButton_cc03", 10)}


//----> Ordres_get_functions

//*********************** DÉTAIL DE L'ORDRE - ACHAT OU VENTE : COMPOSANTS COMMUNS AUX TROIS TYPES D'INSTRUMENT FINANCIER ***************************  
//**************************** ORDER DETAIL - BUY OR SELL : COMMON COMPONENTS FOR ALL THE THREE FINANCIAL INSTRUMENT *******************************

function Get_WinOrderDetail(){return Aliases.CroesusApp.winOrderDetail}


function Get_WinOrderDetail_CmbAccount(){return Get_WinOrderDetail().FindChild("Uid", "ComboBox_e32e", 10)} //ok

function Get_WinOrderDetail_GrpAccount(){return Get_WinOrderDetail().FindChild("Uid", "AccountPart_f371", 10)} //ok

function Get_WinOrderDetail_GrpAccount_DlListPicker(){return Get_WinOrderDetail_GrpAccount().FindChild("Uid", "ListPicker_f818", 10)} //ok

function Get_WinOrderDetail_GrpAccount_CmbTypePicker(){return Get_WinOrderDetail_GrpAccount().FindChild("Uid", "ListPickerCombo_ae94", 10)} //ok

function Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey(){return Get_WinOrderDetail_GrpAccount().FindChild("Uid", "TextBox_f1d5", 10)} //ok

function Get_WinOrderDetail_GrpAccount_ChkPro(){return Get_WinOrderDetail_GrpAccount().FindChild("WPFControlText", "Pro:", 10)} 

function Get_WinOrderDetail_GrpAccount_BtnSearch(){return Get_WinOrderDetail_GrpAccount().FindChild("Uid", "ListPickerExec_9344", 10)} //ok

function Get_WinOrderDetail_GrpAccount_TxtName(){return Get_WinOrderDetail_GrpAccount().FindChild("Uid", "TextBlock_a9b0", 10)} //ok

function Get_WinOrderDetail_GrpAccount_LblIACode(){return Get_WinOrderDetail_GrpAccount().FindChild("Uid", "TextBlock_7fbd", 10)} //ok

function Get_WinOrderDetail_GrpAccount_TxtIACode(){return Get_WinOrderDetail_GrpAccount().FindChild("Uid", "TextBlock_9b3e", 10)} //ok


function Get_WinOrderDetail_LblSecurity(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_ebb5", 10)} //ok

function Get_WinOrderDetail_GrpSecurity(){return Get_WinOrderDetail().FindChild("Uid", "SecurityPart_3a23", 10)} //ok

function Get_WinOrderDetail_GrpSecurity_DlListPicker(){return Get_WinOrderDetail_GrpSecurity().FindChild(["Uid", "IsVisible"], ["ListPicker_7760", true], 10)} //ok

function Get_WinOrderDetail_GrpSecurity_CmbTypePicker(){return Get_WinOrderDetail_GrpSecurity().FindChild(["Uid", "IsVisible"], ["ListPickerCombo_ae94", true], 10)} //ok

function Get_WinOrderDetail_GrpSecurity_CmbTypePicker_ChSymbol(){
    if (language == "french") return  Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Symbole"], 10)
    else return  Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Symbol"], 10)};

function Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey(){return Get_WinOrderDetail_GrpSecurity().FindChild(["Uid", "IsVisible"], ["TextBox_f1d5", true], 10)} //ok

function Get_WinOrderDetail_GrpSecurity_BtnSearch(){return Get_WinOrderDetail_GrpSecurity().FindChild(["Uid", "IsVisible"], ["ListPickerExec_9344", true], 10)} //ok

function Get_WinOrderDetail_GrpSecurity_LblSymbol(){return Get_WinOrderDetail_GrpSecurity().FindChild("Uid", "TextBlock_f3b2", 10)} //ok

function Get_WinOrderDetail_GrpSecurity_TxtSymbol(){return Get_WinOrderDetail_GrpSecurity().FindChild("Uid", "TextBlock_9a24", 10)} //ok

function Get_WinOrderDetail_GrpSecurity_LblMarket(){return Get_WinOrderDetail_GrpSecurity().FindChild("Uid", "TextBlock_679b", 10)}

function Get_WinOrderDetail_GrpSecurity_TxtMarket(){return Get_WinOrderDetail_GrpSecurity().FindChild("Uid", "TextBlock_4786", 10)}

//GR 

function Get_WinOrderDetail_GrpParameters(){return Get_WinOrderDetail().FindChild("Uid", "GroupBox_f1db", 10)} //ok

function Get_WinStocksOrderDetail_GrpParameters_CmbOrderType(){return Get_WinOrderDetail_GrpParameters().FindChild(["ClrClassName","WPFControlOrdinalNo"],["ComboBox","1"], 10)}

function Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit(){return Get_WinOrderDetail_GrpParameters().FindChild("Uid", "DoubleTextBox_c066", 10)} //ok

function Get_WinStocksOrderDetail_GrpParameters_TxtStopPrice(){return Get_WinOrderDetail_GrpParameters().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DoubleTextBox","2"], 10)} //ok

function Get_WinStocksOrderDetail_GrpParameters_TxtStopPrice2(){return Get_WinOrderDetail_GrpParameters().FindChild("Uid", "DoubleTextBox_a64d", 10)} //new function added

//Boutons Sauvegarder, Vérifier et Annuler (Buttons : Save, Verify and Cancel)

function Get_WinOrderDetail_BtnSave(){return Get_WinOrderDetail().FindChild("Uid", "Button_e1bc", 10)} //ok

function Get_WinOrderDetail_BtnVerify(){return Get_WinOrderDetail().FindChild("Uid", "Button_c2a3", 10)} //ok

function Get_WinOrderDetail_BtnCancel(){return Get_WinOrderDetail().FindChild("Uid", "Button_717d", 10)} //ok


//Boutons pour le statut "En approbation (négociateur)" : Approuver, Rejeter (Buttons for the status "Trader Approval" : Approve, Reject)

function Get_WinOrderDetail_BtnApprove(){return Get_WinOrderDetail().FindChild("Uid", "Button_4a90", 10)}

function Get_WinOrderDetail_BtnReject(){return Get_WinOrderDetail().FindChild("Uid", "Button_fabf", 10)}


//Onglet Comptes sous-jacents (Underlying Accounts tab)

function Get_WinOrderDetail_TabUnderlyingAccounts(){return Get_WinOrderDetail().FindChild("Uid", "TabItem_877c", 10)} //ok?

function Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid(){return Get_WinOrderDetail().FindChild("Uid", "DataGrid_0628", 10)}

function Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild("Uid", "Button_7d16", 10)} //ok?

function Get_WinOrderDetail_TabUnderlyingAccounts_BtnDelete(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild("Uid", "Button_48c2", 10)} //ok?

function Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)} //ok?

function Get_WinOrderDetail_TabUnderlyingAccounts_ChPro(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Pro"], 10)}

function Get_WinOrderDetail_TabUnderlyingAccounts_ChAccountNo() //ok?
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No compte"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_WinOrderDetail_TabUnderlyingAccounts_ChName() //ok?
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinOrderDetail_TabUnderlyingAccounts_ChIACode() //ok?
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code de CP"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "IA Code"], 10)}
}

function Get_WinOrderDetail_TabUnderlyingAccounts_ChCurrency() //ok?
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Devise du compte"], 10)} //EM: 90-06-Be-13 Modifié selon le Jira BNC-2243 - avant : "Devise" 
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account Currency"], 10)} //EM: 90-06-Be-13 Modifié selon le Jira BNC-2243 - avant : "Currency"
}

function Get_WinOrderDetail_TabUnderlyingAccounts_ChRequestedQuantity() //ok?
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité requise"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Requested Quantity"], 10)}
}

function Get_WinOrderDetail_TabUnderlyingAccounts_ChAllocatedQuantity() //ok?
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité attribuée"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Allocated Quantity"], 10)}
}

function Get_WinOrderDetail_TabUnderlyingAccounts_ChTotalValue() //ok?
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale (CAD)"], 10)} //EM: 90-06-Be-13 Modifié selon le Jira BNC-2243 - avant : "Valeur totale"
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value (CAD)"], 10)} //EM: 90-06-Be-13 Modifié selon le Jira BNC-2243 - avant : "Total Value"
}
function Get_WinOrderDetail_TabUnderlyingAccounts_ChTotalValueUSD() //ok?
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Valeur totale (USD)"], 10)} //EM: 90-07-CO-18 ajouté suite au Jira 
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total Value (USD)"], 10)} //EM: 90-07-CO-18 ajouté suite au Jira 
}
function Get_WinOrderDetail_TabUnderlyingAccounts_ChSource(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Source"], 10)} //ok?


//Onglet Exécutions (Fills tab)

function Get_WinOrderDetail_TabFills(){return Get_WinOrderDetail().FindChild("Uid", "TabItem_9f71", 10)} //ok

function Get_WinOrderDetail_TabFills_DgvFills(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)} //ok

function Get_WinOrderDetail_TabFills_ChStatus() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "État"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

function Get_WinOrderDetail_TabFills_ChExecutionDate() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date d'exécution"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Execution Date"], 10)}
}

function Get_WinOrderDetail_TabFills_ChSettlementDate() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date de règlement"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Settlement Date"], 10)}
}

function Get_WinOrderDetail_TabFills_ChQuantity() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantité"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Quantity"], 10)}
}

function Get_WinOrderDetail_TabFills_ChSymbol() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbole"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Symbol"], 10)}
}

function Get_WinOrderDetail_TabFills_ChPrice() //Story GDO-769
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Prix d'exécution"], 10)}//Avant Prix
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Fill price"], 10)}//Avant price
}

function Get_WinOrderDetail_TabFills_ChTotal(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Total"], 10)} //ok

function Get_WinOrderDetail_TabFills_ChMarket() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Bourse"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market"], 10)}
}

function Get_WinOrderDetail_TabFills_ChOurRole() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Notre rôle"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Our role"], 10)}
}


//Onglet Avertissements (Warnings tab)

function Get_WinOrderDetail_TabWarnings(){return Get_WinOrderDetail().FindChild("Uid", "TabItem_e678", 10)} //ok

function Get_WinOrderDetail_TabWarnings_ChLevelIcon(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)} //ok

function Get_WinOrderDetail_TabWarnings_ChLevel() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Niveau"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Level"], 10)}
}

function Get_WinOrderDetail_TabWarnings_ChMessage(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Message"], 10)} //ok

function Get_WinOrderDetail_TabWarnings_Grid(){return Get_WinOrderDetail().FindChild("Uid", "DataGrid_50aa", 10)} //ok

//Onglet Historique (Order Log tab)

function Get_WinOrderDetail_TabOrderLog(){return Get_WinOrderDetail().FindChild("Uid", "TabItem_c80a", 10)} //ok

function Get_WinOrderDetail_TabOrderLog_DgvLogs(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)} //ok

function Get_WinOrderDetail_TabOrderLog_ChSupplierNo() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No du fournisseur"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Supplier No."], 10)}
}

function Get_WinOrderDetail_TabOrderLog_ChOrderNo() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro de l'ordre"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Order No."], 10)}
}

function Get_WinOrderDetail_TabOrderLog_ChStatus() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "État"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Status"], 10)}
}

function Get_WinOrderDetail_TabOrderLog_ChUser() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Utilisateur"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "User"], 10)}
}

function Get_WinOrderDetail_TabOrderLog_ChDate(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Date"], 10)} //ok

function Get_WinOrderDetail_TabOrderLog_ChTime() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Heure"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Time"], 10)}
}

function Get_WinOrderDetail_TabOrderLog_ChMessage(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Message"], 10)} //ok

function Get_WinOrderDetail_TabOrderLog_ChAccountNo() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No de compte"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Account No."], 10)}
}

function Get_WinOrderDetail_TabOrderLog_ChSecurity() //ok
{
  if (language == "french"){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Titre"], 10)}
  else {return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Security"], 10)}
}

//Onglet taux de change
function Get_WinOrderDetail_TabExchangeRate(){return Get_WinOrderDetail().FindChild("Uid", "TabItem_3681", 10);}

function Get_WinOrderDetail_TabExchangeRate_GrpRate_CmbRateOrigin(){return Get_WinOrderDetail_GrpRate().FindChild("Uid", "UniComboBox_4614", 10)}
		 
function Get_WinOrderDetail_GrpRate(){return Get_WinOrderDetail().FindChild("Uid", "GroupBox_5d26", 10)}
//Onglet Notes (Notes tab)

function Get_WinOrderDetail_TabNotes(){return Get_WinOrderDetail().FindChild("Uid", "TabItem_1b75", 10)} //ok

function Get_WinOrderDetail_TabNotes_GrpNotes(){return Get_WinOrderDetail().FindChild("Uid", "TabControl_2c50", 10).FindChild("Uid", "GroupBox_f981", 10)} //ok
//----> fin Ordres_get_functions



//---> ??
//************************************* EDIT QUANTITY WINDOW *******************************************************************************************************

function Get_WinEditQuantity(){return Aliases.CroesusApp.winBlockAccount}

function Get_WinEditQuantity_TxtRequestedQuantity(){return Get_WinEditQuantity().FindChild("Uid", "DoubleTextBox_2560", 10)}

function Get_WinEditQuantity_BtnOK(){return Get_WinEditQuantity().FindChild("Uid", "Button_f6df", 10)}

function Get_WinEditQuantity_BtnCancel(){return Get_WinEditQuantity().FindChild("Uid", "Button_c3bf", 10)}
//--> ??

//---->  Ordres_get_functions
//************************************* STOCKS ORDER DETAIL WINDOW - BUY OR SELL (DÉTAIL DE L'ORDRE - ACHAT OU VENTE D'ACTIONS)*************************************

function Get_WinStocksOrderDetail_LblOrderType(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_31f4", 10)} //"Buy" or "Sell" //ok

function Get_WinStocksOrderDetail_LblAccount(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_50fc", 10)} //ok


function Get_WinStocksOrderDetail_LblQuantity(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_b8f3", 10)} //ok

function Get_WinStocksOrderDetail_TxtQuantity(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_c79c", 10)} //ok


function Get_WinStocksOrderDetail_GrpSecurity_LblMarket(){return Get_WinOrderDetail_GrpSecurity().FindChild("Uid", "TextBlock_679b", 10)} //ok

function Get_WinStocksOrderDetail_GrpSecurity_TxtMarket(){return Get_WinOrderDetail_GrpSecurity().FindChild("Uid", "TextBlock_4786", 10)} //ok


function Get_WinStocksOrderDetail_LblPrice(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_d39a", 10)} //ok

function Get_WinStocksOrderDetail_TxtCurrency(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_3aef", 10)} //ok

function Get_WinStocksOrderDetail_RdoMarket(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_3b6d", 10)} //ok

function Get_WinStocksOrderDetail_RdoAt(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_a606", 10)} //ok

function Get_WinStocksOrderDetail_TxtAtPrice(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_c066", 10)} //ok

function Get_WinStocksOrderDetail_TxtPriceLimit(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_c066", 10)} //ok

function Get_WinStocksOrderDetail_TxtStopPrice(){return Get_WinOrderDetail().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DoubleTextBox","2"], 10)} //ok

function Get_WinStocksOrderDetail_LblExpiration(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_8e55", 10)} //ok

function Get_WinStocksOrderDetail_RdoToday(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_eb41", 10)} //ok

function Get_WinStocksOrderDetail_RdoSpecificDate(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_146f", 10)} //ok

function Get_WinStocksOrderDetail_DtpExpirationSpecificDate(){return Get_WinOrderDetail().FindChild("Uid", "DateField_12ec", 10)} //ok


function Get_WinStocksOrderDetail_LblSolicited(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_58a1", 10)} //ok

function Get_WinStocksOrderDetail_RdoSolicited(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_b88c", 10)} //ok

function Get_WinStocksOrderDetail_RdoUnsolicited(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_aa11", 10)} //ok


function Get_WinStocksOrderDetail_ChkOnStop(){return Get_WinOrderDetail().FindChild("Uid", "CheckBox_1495", 10)} //ok

function Get_WinStocksOrderDetail_ChkStopLimit(){return Get_WinOrderDetail().FindChild("Uid", "CheckBox_ff2a", 10)} //ok

function Get_WinStocksOrderDetail_TxtStopLimit(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_5182", 10)} //ok

function Get_WinStocksOrderDetail_ChkAllOrNone(){return Get_WinOrderDetail().FindChild("Uid", "CheckBox_7056", 10)} //ok


//Onglet Notes (Notes tab)

function Get_WinStocksOrderDetail_TabNotes_GrpNotes_LblTradingNotes(){return Get_WinOrderDetail_TabNotes_GrpNotes().FindChild("Uid", "TextBlock_3980", 10)} //ok

function Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes(){return Get_WinOrderDetail_TabNotes_GrpNotes().FindChild("Uid", "TextBox_a510", 10)} //ok

function Get_WinStocksOrderDetail_TabNotes_GrpNotes_ChkManualOrderHandling(){return Get_WinOrderDetail().FindChild("Uid", "CheckBox_0b76", 10)}



//****************************** FIXED INCOME ORDER DETAIL WINDOW - BUY OR SELL (DÉTAIL DE L'ORDRE - ACHAT OU VENTE DE REVENU FIXE)*********************************

function Get_WinFixedIncomeOrderDetail_LblOrderType(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_07e5", 10)} //"Buy" or "Sell" //ok

function Get_WinFixedIncomeOrderDetail_LblAccount(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_40d9", 10)} //ok

function Get_WinFixedIncomeOrderDetail_LblQuantity(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_14f4", 10)} //ok

function Get_WinFixedIncomeOrderDetail_TxtQuantity(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_bd22", 10)} //ok

function Get_WinFixedIncomeOrderDetail_LblFaceValue(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_9f38", 10)} //ok


function Get_WinFixedIncomeOrderDetail_LblPrice(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_6daf", 10)} //ok

function Get_WinFixedIncomeOrderDetail_LblPriceIA(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_aad7", 10)} //ok

function Get_WinFixedIncomeOrderDetail_TxtPriceIA(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_1c7d", 10)} //ok

function Get_WinFixedIncomeOrderDetail_LblPriceClient(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_3539", 10)} //ok

function Get_WinFixedIncomeOrderDetail_TxtPriceClient(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_44e3", 10)} //ok


function Get_WinFixedIncomeOrderDetail_LblYield(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_4157", 10)} //ok

function Get_WinFixedIncomeOrderDetail_LblYieldIA(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_e821", 10)} //ok

function Get_WinFixedIncomeOrderDetail_TxtYieldIASAPercent(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_69e9", 10)} //ok

function Get_WinFixedIncomeOrderDetail_LblYieldIASAPercent(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_d022", 10)} //ok

function Get_WinFixedIncomeOrderDetail_TxtYieldIAANNPercent(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_043f", 10)} //ok

function Get_WinFixedIncomeOrderDetail_LblYieldIAANNPercent(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_0887", 10)} //ok


function Get_WinFixedIncomeOrderDetail_LblClient(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_dfbd", 10)} //ok

function Get_WinFixedIncomeOrderDetail_TxtClientSAPercent(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_d081", 10)} //ok

function Get_WinFixedIncomeOrderDetail_LblClientSAPercent(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_a77e", 10)} //ok

function Get_WinFixedIncomeOrderDetail_TxtClientANNPercent(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_0550", 10)} //ok

function Get_WinFixedIncomeOrderDetail_LblClientANNPercent(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_69ee", 10)} //ok


function Get_WinFixedIncomeOrderDetail_LblSolicited(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_439c", 10)} //ok

function Get_WinFixedIncomeOrderDetail_RdoSolicited(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_703c", 10)} //ok

function Get_WinFixedIncomeOrderDetail_RdoUnsolicited(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_df05", 10)} //ok


//Onglet Notes (Notes tab)

function Get_WinFixedIncomeOrderDetail_TabNotes_GrpNotes_LblClientNotes(){return Get_WinOrderDetail_TabNotes_GrpNotes().FindChild("Uid", "TextBlock_d66f", 10)}

function Get_WinFixedIncomeOrderDetail_TabNotes_GrpNotes_TxtClientNotes(){return Get_WinOrderDetail_TabNotes_GrpNotes().FindChild("Uid", "TextBox_5aa9", 10)}



//****************************** MUTUAL FUNDS ORDER DETAIL WINDOW - BUY OR SELL (DÉTAIL DE L'ORDRE - ACHAT OU VENTE DE FONDS D'INVESTISSEMENT)*********************************

function Get_WinMutualFundsOrderDetail_LblOrderType(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_c7a5", 10)} //"Buy" or "Sell" //ok


function Get_WinMutualFundsOrderDetail_LblAccount(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_de0b", 10)} //ok


function Get_WinMutualFundsOrderDetail_LblQuantity(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_45c6", 10)} //ok

function Get_WinMutualFundsOrderDetail_TxtQuantity(){return Get_WinOrderDetail().FindChild("Uid", "DoubleTextBox_a162", 10)} //ok

function Get_WinMutualFundsOrderDetail_CmbQuantityType(){return Get_WinOrderDetail().FindChild("Uid", "ComboBox_9806", 10)} //ok


function Get_WinMutualFundsOrderDetail_LblDistribution(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_61e0", 10)} //ok

function Get_WinMutualFundsOrderDetail_RdoReinvested(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_53fd", 10)} //ok

function Get_WinMutualFundsOrderDetail_RdoCash(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_5435", 10)} //ok

function Get_WinMutualFundsOrderDetail_LblSolicited(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_99ad", 10)} //ok

function Get_WinMutualFundsOrderDetail_RdoSolicited(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_3dfe", 10)} //ok

function Get_WinMutualFundsOrderDetail_RdoUnsolicited(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_f5b7", 10)} //ok


function Get_WinMutualFundsOrderDetail_LblFrontEndFund(){return Get_WinOrderDetail().FindChild("Uid", "TextBlock_150c", 10)} //ok

function Get_WinMutualFundsOrderDetail_RdoGross(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_108e", 10)} //ok

function Get_WinMutualFundsOrderDetail_RdoNet(){return Get_WinOrderDetail().FindChild("Uid", "RadioButton_62e9", 10)} //ok

//----> fin Ordres_get_functions


/*
//----> MenuEdit_Get_functions
//*********************************************** SWITCH/BLOCK WINDOW (FENÊTRE ÉCHANGE/BLOC)*************************************************
//Edit--> Prder Entry Module --> Multiple, block and swich orders
function Get_WinSwitchBlock(){return Aliases.CroesusApp.winSwitchBlock}


function Get_WinSwitchBlock_GrpParameters(){return Get_WinSwitchBlock().FindChild("Uid", "GroupBox_8c44", 10)}

function Get_WinSwitchBlock_GrpParameters_LblSources(){return Get_WinSwitchBlock_GrpParameters().FindChild("Uid", "TextBlock_3d5e", 10)}

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
/************************************FENÊTRE TRANSACTION ÉQUIVALENTE  -Equivalent Transaction ***********************************
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
//End Other (Fin Autre)

//-->?? 



//-----> MenuEdit_Get_functions
/******************************************** QUICK SEARCH WINDOW (FENÊTRE DE RECHERCHE RAPIDE) **************************************************
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
//---> fin MenuEdit_Get_functions
*/
/*
//---> MenuTools_Get_functions
//************************ GESTIONNAIRE DE RESTRICTIONS POUR CONFIGURATIONS (RESTRICTIONS MANAGER FOR CONFIGURATIONS) *******************************
//"PREF_CRITERIA_RESTRICTIONS_ACCESS","YES" ; PREF_EDIT_FIRM_FUNCTIONS - YES
//Tools --> Configuration --> Restrictions 
function Get_WinRestrictionsManagerForConfigurations(){return Aliases.CroesusApp.winRestrictionsManagerForConfigurations}

function Get_WinRestrictionsManagerForConfigurations_BarPadHeader(){return Get_WinRestrictionsManagerForConfigurations().FindChild("Uid", "PadHeader_820d", 10)}

function Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnAdd()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Aj_outer"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Add"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnEdit()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Mo_difier"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Edit"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnDelete()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "S_upprimer"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "De_lete"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_BtnClose()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Fermer"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Close"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_DgvRestrictions(){return Get_WinRestrictionsManagerForConfigurations().FindChild("Uid", "DataGrid_010e", 10)}

function Get_WinRestrictionsManagerForConfigurations_DgvRestrictions_ChName()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_DgvRestrictions_ChSeverity()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sévérité"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Severity"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_DgvRestrictions_ChDescription(){return Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}

function Get_WinRestrictionsManagerForConfigurations_BtnOK()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "OK"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "OK"], 10)}
}

function Get_WinRestrictionsManagerForConfigurations_BtnCancel()
{
  if (language == "french"){return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Annuler"], 10)}
  else {return Get_WinRestrictionsManagerForConfigurations().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Cancel"], 10)}
}
//---> fin MenuTools_Get_functions
*/
/*
//--->  MenuEdit_Get_functions
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

//---> fin  MenuEdit_Get_functions

*/

//--->   MenuTools_Get_functions
/*
//********************************* FENÊTRE GESTIONNAIRE DES RESTRICTIONS ASSIGNÉES (ASSIGNED RESTRICTIONS MANAGER WINDOW) **************************************
//"PREF_CRITERIA_RESTRICTIONS_ACCESS","YES" ; PREF_EDIT_FIRM_FUNCTIONS - YES
//Tools --> Configuration --> Restrictions -->ASSIGNED RESTRICTIONS to criteria 
function Get_WinAssignedRestrictionsManager(){return Aliases.CroesusApp.winAssignedRestrictionsManager}

function Get_WinAssignedRestrictionsManager_BarPadHeader(){return Get_WinAssignedRestrictionsManager().FindChild("Uid", "PadHeader_820d", 10)}

function Get_WinAssignedRestrictionsManager_BarPadHeader_BtnAdd()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Aj_outer"], 10)}
  else {return Get_WinAssignedRestrictionsManager_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Add"], 10)}
}

function Get_WinAssignedRestrictionsManager_BarPadHeader_BtnDelete()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "S_upprimer"], 10)}
  else {return Get_WinAssignedRestrictionsManager_BarPadHeader().FindChild(["ClrClassName", "WPFControlText"], ["Button", "De_lete"], 10)}
}

function Get_WinAssignedRestrictionsManager_BtnClose()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Fermer"], 10)}
  else {return Get_WinAssignedRestrictionsManager().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Close"], 10)}
}

function Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions(){return Get_WinAssignedRestrictionsManager().FindChild("Uid", "DataGrid_010e", 10)}

function Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions_ChRestrictionName()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom de la restriction"], 10)}
  else {return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Restriction Name"], 10)}
}

function Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions_ChRestrictionDescription()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description de la restriction"], 10)}
  else {return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Restriction Description"], 10)}
}

function Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions_ChCriterionDescription()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description du critère"], 10)}
  else {return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Criterion Description"], 10)}
}

function Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions_ChSeverity()
{
  if (language == "french"){return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sévérité"], 10)}
  else {return Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Severity"], 10)}
}

//---> fin  MenuTools_Get_functions

//--->   MenuTools_Get_functions
//********************************* FENÊTRE ASSOCIER DES RESTRICTIONS (ASSIGN RESTRICTIONS WINDOW) **************************************
//"PREF_CRITERIA_RESTRICTIONS_ACCESS","YES" ; PREF_EDIT_FIRM_FUNCTIONS - YES
//Tools --> Configuration --> Restrictions -->ASSIGNED RESTRICTIONS to criteria -->Add

function Get_WinAssignRestrictions(){return Aliases.CroesusApp.winAssignRestrictions}

function Get_WinAssignRestrictions_BtnOK(){return Get_WinAssignRestrictions().FindChild("Uid", "Button_c53d", 10)}

function Get_WinAssignRestrictions_BtnCancel(){return Get_WinAssignRestrictions().FindChild("Uid", "Button_dd22", 10)}


function Get_WinAssignRestrictions_GrpRestrictions(){return Get_WinAssignRestrictions().FindChild("Uid", "GroupBox_c8cb", 10)}

function Get_WinAssignRestrictions_GrpRestrictions_BtnAdd(){return Get_WinAssignRestrictions_GrpRestrictions().FindChild("Uid", "Button_4d20", 10)}

function Get_WinAssignRestrictions_GrpRestrictions_BtnDelete(){return Get_WinAssignRestrictions_GrpRestrictions().FindChild("Uid", "Button_3cc6", 10)}

function Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions(){return Get_WinAssignRestrictions_GrpRestrictions().FindChild("Uid", "DataGrid_765a", 10)}

function Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions_ChName()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions_ChSeverity()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Sévérité"], 10)}
  else {return Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Severity"], 10)}
}

function Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions_ChDescription(){return Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description"], 10)}


function Get_WinAssignRestrictions_GrpSearchCriteria(){return Get_WinAssignRestrictions().FindChild("Uid", "GroupBox_3056", 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_BtnAdd(){return Get_WinAssignRestrictions_GrpSearchCriteria().FindChild("Uid", "Button_0770", 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_BtnDelete(){return Get_WinAssignRestrictions_GrpSearchCriteria().FindChild("Uid", "Button_ed5e", 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria(){return Get_WinAssignRestrictions_GrpSearchCriteria().FindChild("Uid", "DataGrid_e480", 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChName()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChAccess()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Accès"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Access"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChType(){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Type"], 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChCreation()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Création"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Creation"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChModule(){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Module"], 10)}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChModified()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modifié"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Modified"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChGenerated()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Généré"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Generated"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChNoOfRecords()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nbre enreg."], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No. of Records"], 10)}
}

function Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria_ChCreated()
{
  if (language == "french"){return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Créé"], 10)}
  else {return Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Created"], 10)}
}
//--->   MenuTools_Get_functions
*/
/*
//--->   MenuEdit_Get_functions
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

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation_ItemA(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "A"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation_ItemB(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "B"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation_ItemC(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "C"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation_ItemD(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "D"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblContactPerson(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPerson_ItemNicolasCopernic(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Nicolas Copernic"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblAccountManager(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManager_ItemNicolasCopernic(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Nicolas Copernic"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblCommunication(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication(){return Get_WinDetailedInfo_TabInfo_GrpFollowUp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "4"], 10)}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication_ItemEmail()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Courriel"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Email"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication_ItemInPerson()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "En personne"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "In person"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication_ItemTelephone()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Téléphone"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Telephone"], 10)}
}

function Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication_ItemWritten()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Écrit"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Written"], 10)}
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

function Get_WinDetailedInfo_TabInfo_GrpNotes_TabGrid_BtnCopy(){return Get_CroesusApp().FindChild("Uid", "Button_13b9", 10)} //YR 

//Les fonctions Get suivantes sont communes aux fenêtres Info Client/Relation et Info Compte (onglet Notes)

//function Get_WinInfo_Notes_TabSummary()
//{
//  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Sommaire"], 10)}
//  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Summary"], 10)}
//}
function Get_WinInfo_Notes_TabSummary(){return Get_CroesusApp().FindChild("Uid", "TabItem_a26f", 10)};//Modification de la fonction suite qu'elle a un UID -version -39

//function Get_WinInfo_Notes_TabSummary_TxtSummary(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextArea", "1"], 10)}

function Get_WinInfo_Notes_TabSummary_TxtSummary(){return Get_CroesusApp().FindChild("Uid","NoteSectionControl_0e30",10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", "1"], 10)}


//function Get_WinInfo_Notes_TabGrid()
//{
//  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Grille"], 10)}
//  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Grid"], 10)}
//}
function  Get_WinInfo_Notes_TabGrid(){return Get_CroesusApp().FindChild("Uid", "TabItem_fc72", 10)}//Modification de la fonction get suite qu'elle a un UID-version 39

function Get_WinInfo_Notes_TabGrid_TxtSearch(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinInfo_Notes_TabGrid_BtnSearch(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "Button_d168", 10)}

//function Get_WinInfo_Notes_TabGrid_BtnPrint(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinInfo_Notes_TabGrid_BtnPrint(){return Get_CroesusApp().FindChild("Uid", "Button_caf1", 10)} //YR 

//function Get_WinInfo_Notes_TabGrid_DgvNotes(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild("Uid", "FixedColumnListView_1b3e", 10)}//YR 90-04-32

function Get_WinInfo_Notes_TabGrid_DgvNotes(){return Get_CroesusApp().FindChild("Uid", "NoteDataGrid_ddf6", 10)}//YR 90-04-44

/*Les fonctions get pour le filtre************************************************************************
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

/********************************Fin Fonctions get Filtre**************************************************
function Get_WinInfo_Notes_TabGrid_DgvNotes_ContextMenu_CreatedBy()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Créée par" , 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Created by" , 10)}
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

function Get_WinInfo_Notes_TabGrid_TxtNote(){return Get_CroesusApp().FindChild("Uid","TextBox_b0b6",10)}//YR 90-04-44


//function Get_WinInfo_Notes_TabGrid_BtnAdd()
//{
//  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Aj_outer"], 10)}
//  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "A_dd"], 10)}
//}
function Get_WinInfo_Notes_TabGrid_BtnAdd(){return Get_CroesusApp().FindChild("Uid", "Button_ddd2", 10)};

//function Get_WinInfo_Notes_TabGrid_BtnDisplay()
//{
//  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Co_nsulter"], 10)}
//  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "D_isplay"], 10)}
//}
function Get_WinInfo_Notes_TabGrid_BtnDisplay(){return Get_CroesusApp().FindChild("Uid", "Button_309d", 10)}

//function Get_WinInfo_Notes_TabGrid_BtnEdit()
//{
//  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Mo_difier"], 10)}
//  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Edit"], 10)}
//}

function Get_WinInfo_Notes_TabGrid_BtnEdit(){return Get_CroesusApp().FindChild("Uid", "Button_5de5", 10)}// YR 90-04-49

function Get_WinInfo_Notes_TabGrid_BtnDelete(){return Get_CroesusApp().FindChild("Uid", "Button_8b6a", 10)}



//function Get_WinInfo_Notes_TabGrid_BtnDelete()
//{
//  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
//  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"], 10)}
//}
//Fin : Fonctions communes aux fenêtres Info Client/Relation et Info Compte (onglet Notes) 

//*********************************** Onglet Note -CR1664 *********************************************************************************************************************
function Get_WinInfo_Notes_TabNote(){
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Notes"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Notes"], 10)} //uid n’a pas été utilisé pour que la fonctionne sera réutilisée dans plusieurs modules  YR 90-04-44
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
function Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText", "WPFControlOrdinalNo"], ["UniCheckBox", "", "1"], 10)}

function Get_WinInfo_TabInvestmentObjective_TxtInvestmentObjectiveForClientAndAccount(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount(){return Get_CroesusApp().FindChild("Uid", "Button_d168", 10)}

function Get_WinInfo_TabInvestmentObjective_TvwAssetAllocationsForClientAndAccount(){return Get_CroesusApp().FindChild("Uid", "TreeView_f006", 10)}
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


//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports()
//{
//  if (language == "french"){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Rapports"], 10)}
//  else {return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Reports"] ,10)}
//}
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_TabReports()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Rapports"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Reports"] ,10)}
//}
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_TabReports_LvwReports(){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniList", "1"], 10)}
//
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
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnAddAReport()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Ajouter un rapport"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Add a Report"] ,10)}
//}
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnRemoveAReport()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Enlever un rapport"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Remove a Report"] ,10)}
//}
//
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnRemoveAllReports()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Enlever tous les rapports"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "ToolTip"], ["UniButton", "Remove All Reports"] ,10)}
//}
//
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
//function Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports_BtnSave()
//{
//  if (language == "french"){return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Sau_vegarder"], 10)}
//  else {return Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports_GrpReports().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Sa_ve"] ,10)}
//}
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

function Get_WinInfo_TabDefaultIndices_LblTargetReturn(){return Get_CroesusApp().FindChild("Uid", "TextBlock_be22", 10)}

function Get_WinInfo_TabDefaultIndices_TxtTargetReturn(){return Get_CroesusApp().FindChild("Uid", "DoubleTextBox_e059", 10)}

function Get_WinInfo_TabDefaultIndices_LblPercent(){return Get_CroesusApp().FindChild("Uid", "TextBlock_2e07", 10)}

function Get_WinInfo_TabDefaultIndices_BtnAddIndices(){return Get_CroesusApp().FindChild("Uid", "Button_2c9f", 10)}

function Get_WinInfo_TabDefaultIndices_BtnRemoveIndices(){return Get_CroesusApp().FindChild("Uid", "Button_acce", 10)}


function Get_WinInfo_TabDefaultIndices_GrpAvailableIndices(){return Get_CroesusApp().FindChild("Uid", "GroupBox_bda6", 10)}

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


function Get_WinInfo_TabDefaultIndices_GrpSelectedIndices(){return Get_CroesusApp().FindChild("Uid", "GroupBox_7a0b", 10)}

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


function Get_WinInfo_TabProfile_ItemControl_ChkHENRY()
{
 return Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CheckBox", "1"], 10)
}

function Get_WinInfo_TabProfile_ItemControl_LblHENRY()
{
 return Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "HENRY"], 10)
}


function Get_WinInfo_TabProfile_ItemControl(){return Get_CroesusApp().FindChild("Uid", "ItemsControl_b25d", 10)}

//Les trois fonctions suivantes sont communes aux fenêtres Info Client/Relation et Info Compte
 
function Get_WinInfo_TabProfile_ChkHideEmptyProfiles(){return Get_CroesusApp().FindChild("Uid", "CheckBox_9862", 10)}

function Get_WinInfo_TabProfile_BtnSetup(){return Get_CroesusApp().FindChild("Uid", "Button_06f8", 10)}

function Get_WinInfo_TabProfile_LblNoDataAvailable(){return Get_CroesusApp().FindChild("Uid", "TextBlock_bff6", 10)}


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
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WndCaption"], ["HwndSource", "Modifier le compte sous-jacent"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WndCaption"], ["HwndSource", "Edit Underlying Account"], 10)}
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

//--->   MenuEdit_Get_functions

*/





//--->   ????
//************************************* BOÎTE DE DIALOGUE TEMPLATETYPEWARNING (TEMPLATETYPEWARNING DIALOG BOX) ******************************************

function Get_DlgTemplateTypeWarning(){return Aliases.CroesusApp.dlgTemplateTypeWarning}
var TemplateTypeWarningPropertyName = ["ClrClassName", "Uid"], TemplateTypeWarningPropertyValue = ["TemplateTypeWarning", "TemplateTypeWarning_7c62"];

function Get_DlgTemplateTypeWarning_LblMessage(){return Get_DlgTemplateTypeWarning().FindChild("Uid", "TextBlock_286a", 10)}

function Get_DlgTemplateTypeWarning_BtnReinitialize(){return Get_DlgTemplateTypeWarning().FindChild("Uid", "Button_9a67", 10)}

function Get_DlgTemplateTypeWarning_BtnOK(){return Get_DlgTemplateTypeWarning().FindChild("Uid", "Button_fe86", 10)}

function Get_DlgTemplateTypeWarning_BtnCancel(){return Get_DlgTemplateTypeWarning().FindChild("Uid", "Button_dd59", 10)}
//---> fin  ????

/*
//--->   MenuEdit_Get_functions
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

//---> fin  MenuEdit_Get_functions


//--->  MenuEdit_Get_functions
//**************************************** FENÊTRE PARAMÈTRES DE FACTURATION INSTANTANÉE (INSTANT BILLING PARAMETERS WINDOW) ******************************************
//Edit --> Info --> Tab Billing --> Cliquer sur le btn "Bill Now"
function Get_WinInstantBillingParameters(){return Aliases.CroesusApp.winInstantBillingParameters}

function Get_WinInstantBillingParameters_BtnOK(){return Get_WinInstantBillingParameters().FindChild("Uid", "Button_1a4a", 10)}

function Get_WinInstantBillingParameters_BtnCancel(){return Get_WinInstantBillingParameters().FindChild("Uid", "Button_e8d0", 10)}

function Get_WinInstantBillingParameters_LblSelectABillingDate(){return Get_WinInstantBillingParameters().FindChild("Uid", "TextBlock_30af", 10)}

//--->  MenuEdit_Get_functions
*/
/*
//--->  MenuTools_Get_functions
//**************************************** FENÊTRE PARAMÈTRES  (BILLING PARAMETERS WINDOW) ******************************************
//Tools-->Billing
function Get_WinBillingParameters(){return Aliases.CroesusApp.winBillingParameters}

function Get_WinBillingParameters_BtnOK(){return Get_WinBillingParameters().FindChild("Uid", "Button_0536", 10)}

function Get_WinBillingParameters_BtnCancel(){return Get_WinBillingParameters().FindChild("Uid", "Button_0dff", 10)}

function Get_WinBillingParameters_RdoInArrears(){return Get_WinBillingParameters().FindChild("Uid", "RadioButton_d478", 10)}

function Get_WinBillingParameters_RdoInAdvance(){return Get_WinBillingParameters().FindChild("Uid", "RadioButton_e5b0", 10)}

function Get_WinBillingParameters_LblPeriodEndingOrBeginningIn(){return Get_WinBillingParameters().FindChild("Uid", "TextBlock_7914", 10)}

//  function Get_WinBillingParameters_DtpBillingDate(){return Get_WinBillingParameters().FindChild("WPFControlName", "_billingDate", 10)} 
function Get_WinBillingParameters_DtpBillingDate(){return Get_WinBillingParameters().FindChild("Uid", "MonthYearField_dbd2", 10)} 

function Get_WinInstantBillingParameters_DtpSelectABillingDate(){return Get_WinInstantBillingParameters().FindChild("Uid", "DateField_35e0", 10)}

function Get_WinInstantBillingParameters_LblMessage(){return Get_WinInstantBillingParameters().FindChild("Uid", "TextBlock_1f3b", 10)}


//**************************************** FENÊTRE PARAMÈTRES DE FACTURATION (BILLING PARAMETERS WINDOW) ******************************************
//Tools-->Billing
function Get_WinBillingParameters_GrpFrequencies(){return Get_WinBillingParameters().FindChild("Uid", "GroupBox_e1ff", 10)}
function Get_WinBillingParameters_GrpFrequencies_ChkMonthly(){return Get_WinBillingParameters().FindChild("WPFControlAutomationId", "CheckBox_44a8_0", 10)}

//function Get_WinBillingParameters_GrpFrequencies_ChkMonthly()
//{
//  if (language == "french"){return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Mensuelle"], 10)}
//  else {return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Monthly"], 10)}
//}
function Get_WinBillingParameters_GrpFrequencies_ChkQuarterly(){return Get_WinBillingParameters().FindChild("WPFControlAutomationId", "CheckBox_44a8_1", 10)}

//function Get_WinBillingParameters_GrpFrequencies_ChkQuarterly()
//{
//  if (language == "french"){return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Trimestrielle"], 10)}
//  else {return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Quarterly"], 10)}
//}
function Get_WinBillingParameters_GrpFrequencies_ChkSemiannual(){return Get_WinBillingParameters().FindChild("WPFControlAutomationId", "CheckBox_44a8_2", 10)}

//function Get_WinBillingParameters_GrpFrequencies_ChkSemiannual()
//{
//  if (language == "french"){return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Semestrielle"], 10)}
//  else {return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Semiannual"], 10)}
//}

function Get_WinBillingParameters_GrpFrequencies_ChkAnnual(){return Get_WinBillingParameters().FindChild("WPFControlAutomationId", "CheckBox_44a8_3", 10)}
*/
/*
function Get_WinBillingParameters_GrpFrequencies_ChkAnnual()
{
  if (language == "french"){return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Annuelle"], 10)}
  else {return Get_WinBillingParameters_GrpFrequencies().FindChild(["ClrClassName", "WPFControlText"], ["CheckBox", "Annual"], 10)}
}*/
//---> fin  MenuTools_Get_functions


//---> Clients_Get_functions ???
//**************************************** FENÊTRE COPIER LES INFORMATIONS (COPY CLIENT INFO WINDOW) ******************************************
//ClickR dans la grille du module Clients ou Etid-->Funtions  --> copy clint Information 

function Get_WinCopyClientInfo(){ return Aliases.CroesusApp.FindChild("Uid", "CopyClientInfoWindow_e365", 10)}

function Get_WinCopyClientInfo_ListPickerCombo(){ return Get_WinCopyClientInfo().FindChild("Uid", "ListPickerCombo_ae94", 10)}

function Get_WinCopyClientInfo_TxtQuickSearch(){ return Get_WinCopyClientInfo().FindChild("Uid", "TextBox_f1d5", 10)}

function Get_WinCopyClientInfo_ListPicker(){ return Get_WinCopyClientInfo().FindChild("Uid", "ListPickerExec_9344", 10)}

function Get_WinCopyClientInfo_ChkBoxAgenda(){ return Get_WinCopyClientInfo().FindChild("Uid", "CheckBox_1524", 10)}

function Get_WinCopyClientInfo_ChkBoxNote(){ return Get_WinCopyClientInfo().FindChild("Uid", "CheckBox_9152", 10)}

function Get_WinCopyClientInfo_BtnOK(){ return Get_WinCopyClientInfo().FindChild("Uid", "Button_a7b1", 10)}

function Get_WinCopyClientInfo_ChkBoxProfile(){ return Get_WinCopyClientInfo().FindChild("Uid", "CheckBox_0ca8", 10)}

function Get_WinCopyClientInfo_ChkBoxAddress(){ return Get_WinCopyClientInfo().FindChild("Uid", "CheckBox_7d3b", 10)}

function Get_WinCopyClientInfo_ChkBoxPhoneNumber(){ return Get_WinCopyClientInfo().FindChild("Uid", "CheckBox_a278", 10)}

//---> fin Clients_Get_functions ???

/*
//--->  MenuTools_Get_functions
//*********************************************** CALENDRIER (CALENDRIER) *******************************************************
//Tools--> Billing-->le btn de calenrier 
function Get_Calendar(){return Get_SubMenus().FindChild("Uid", "MonthCalendar_80ce", 10)}

function Get_Calendar_BtnToday(){return Get_Calendar().FindChild("Uid", "Button_77f6", 10)}

function Get_Calendar_BtnOK(){return Get_Calendar().FindChild("Uid", "Button_92ab", 10)}

function Get_Calendar_BtnCancel(){return Get_Calendar().FindChild("Uid", "Button_9aa4", 10)}

function Get_Calendar_LstDays(){return Get_Calendar().FindChild("Uid", "ListBox_2f71", 10)}

function Get_Calendar_LstDays_Item(dayNumber){return Get_Calendar_LstDays().FindChild(["ClrClassName", "IsEnabled", "WPFControlText"], ["TextBlock", true, dayNumber], 10)}

function Get_Calendar_LstYears(){return Get_Calendar().FindChild("Uid", "ListBox_ee5c", 10)}

function Get_Calendar_LstYears_Item(yearNumber){return Get_Calendar_LstYears().FindChild(["ClrClassName", "DataContext.OleValue"], ["ListBoxItem", yearNumber], 10)}

function Get_Calendar_LstMonths(){return Get_Calendar().FindChild("Uid", "ListBox_ac36", 10)}

function Get_Calendar_LstMonths_Item(monthNumber){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", monthNumber], 10)}

function Get_Calendar_LstMonths_ItemJanuary(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 1], 10)}

function Get_Calendar_LstMonths_ItemFebruary(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10)}

function Get_Calendar_LstMonths_ItemMarch(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10)}

function Get_Calendar_LstMonths_ItemApril(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10)}

function Get_Calendar_LstMonths_ItemMay(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 5], 10)}

function Get_Calendar_LstMonths_ItemJune(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 6], 10)}

function Get_Calendar_LstMonths_ItemJuly(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 7], 10)}

function Get_Calendar_LstMonths_ItemAugust(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 8], 10)}

function Get_Calendar_LstMonths_ItemSeptember(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 9], 10)}

function Get_Calendar_LstMonths_ItemOctober(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 10], 10)}

function Get_Calendar_LstMonths_ItemNovember(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 11], 10)}

function Get_Calendar_LstMonths_ItemDecember(){return Get_Calendar_LstMonths().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 12], 10)}

//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//**************************************** FENÊTRE FACTURATION (BILLING WINDOW) ******************************************
// Tools --> Billing Dans le fenêtre Billing Parameters --> Cliquer OK 
function Get_WinBilling(){return Aliases.CroesusApp.winBilling}

function Get_WinBilling_BtnGenerate(){return Get_WinBilling().FindChild("Uid", "Button_7a8a", 10)}

function Get_WinBilling_BtnView(){return Get_WinBilling().FindChild("Uid", "Button_a7b7", 10)}

function Get_WinBilling_BtnCancel(){return Get_WinBilling().FindChild("Uid", "Button_6893", 10)}


function Get_WinBilling_GrpRelationships(){return Get_WinBilling().FindChild("Uid", "GroupBox_c21b", 10)}

function Get_WinBilling_GrpRelationships_DgvRelationships(){return Get_WinBilling_GrpRelationships().FindChild("Uid", "DataGrid_6e20", 10)}


function Get_WinBilling_GrpAccounts(){return Get_WinBilling().FindChild("Uid", "GroupBox_a81b", 10)}

function Get_WinBilling_GrpAccounts_DgvAccounts(){return Get_WinBilling_GrpAccounts().FindChild("Uid", "DataGrid_3ea8", 10)}

function Get_WinBilling_GrpAccounts_BtnEdit(){return Get_WinBilling_GrpAccounts().FindChild("Uid", "Button_4a0d", 10)}


function Get_WinBilling_GrpSummaryCAD(){return Get_WinBilling().FindChild("Uid", "GroupBox_2124", 10)}

function Get_WinBilling_GrpSummaryCAD_LblBillingDate(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "TextBlock_59ee", 10)}

function Get_WinBilling_GrpSummaryCAD_TxtBillingDate(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "TextBlock_6fdd", 10)}

function Get_WinBilling_GrpSummaryCAD_LblTotalFees(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "TextBlock_990b", 10)}

function Get_WinBilling_GrpSummaryCAD_TxtTotalFees(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "TextBlock_6fb5", 10)}

function Get_WinBilling_GrpSummaryCAD_LblIATotalFees(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "TextBlock_649c", 10)}

function Get_WinBilling_GrpSummaryCAD_TxtIATotalFees(){return Get_WinBilling_GrpSummaryCAD().FindChild("Uid", "ItemsControl_c0aa", 10)}

function Get_WinBilling_GrpSummaryCAD_TxtIATotalFees9047763(){return Get_WinBilling_GrpSummaryCAD_TxtIATotalFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 2], 10)}

function Get_WinBilling_GrpSummaryCAD_TxtIATotalFeesBD88(){return Get_WinBilling_GrpSummaryCAD_TxtIATotalFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}

//Fonction get pour la grille de la partie Messages
function Get_WinBilling_MessagesDgv(){return Get_WinBilling().FindChild("Uid", "DataGrid_1008", 10)}
//---> fin  MenuTools_Get_functions




//--->   MenuTools_Get_functions
//********************************** FENÊTRE DE SÉLECTION DE SORTIE - FACTURATION (OUTPUT SELECTION WINDOW - BILLING) ************************************
// Tools --> Billing Dans le fenêtre Billing Parameters --> Cliquer OK -->Dans la fenêtre `Billing`cliquer sur generate.
function Get_WinOutputSelection(){return Aliases.CroesusApp.winOutputSelection}

function Get_WinOutputSelection_BtnOK(){return Get_WinOutputSelection().FindChild("Uid", "Button_c362", 10)}

function Get_WinOutputSelection_BtnCancel(){return Get_WinOutputSelection().FindChild("Uid", "Button_1e66", 10)}


function Get_WinOutputSelection_GrpOutput(){return Get_WinOutputSelection().FindChild("Uid", "GroupBox_c181", 10)}

function Get_WinOutputSelection_GrpOutput_ChkExportToExcelSummarized(){return Get_WinOutputSelection_GrpOutput().FindChild("Uid", "CheckBox_cf12", 10)}

function Get_WinOutputSelection_GrpOutput_ChkExportToExcelDetailed(){return Get_WinOutputSelection_GrpOutput().FindChild("Uid", "CheckBox_5f49", 10)}

function Get_WinOutputSelection_GrpOutput_ChkExportToPDFFormat(){return Get_WinOutputSelection_GrpOutput().FindChild("Uid", "CheckBox_857c", 10)}
//--->  fin MenuTools_Get_functions




//--->   MenuTools_Get_functions
//********************************** FENÊTRE PARAMÈTRES DE FACTURATION DU COMPTE (ACCOUNT BILLING PARAMETERS WINDOW) ************************************
// Tools --> Billing Dans le fenêtre Billing Parameters --> Cliquer OK -->Dans la fenêtre `Billing`cliquer sur Edit.
function Get_WinAccountBillingParameters(){return Aliases.CroesusApp.winAccountBillingParameters}

function Get_WinAccountBillingParameters_BtnOK(){return Get_WinAccountBillingParameters().FindChild("Uid", "Button_3c4b", 10)}

function Get_WinAccountBillingParameters_BtnCancel(){return Get_WinAccountBillingParameters().FindChild("Uid", "Button_557f", 10)}

function Get_WinAccountBillingParameters_LblAccountNo(){return Get_WinAccountBillingParameters().FindChild("Uid", "TextBlock_b5e0", 10)}

function Get_WinAccountBillingParameters_TxtAccountNo(){return Get_WinAccountBillingParameters().FindChild("Uid", "TextBlock_020d", 10)}

function Get_WinAccountBillingParameters_TxtAccountCurrency(){return Get_WinAccountBillingParameters().FindChild("Uid", "TextBlock_5373", 10)}


function Get_WinAccountBillingParameters_GrpBillingParameters(){return Get_WinAccountBillingParameters().FindChild("Uid", "GroupBox_ff4a", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_ChkIncluded(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "CheckBox_5104", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_LblCalculatedFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "TextBlock_1b7e", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_TxtCalculatedFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "DoubleTextBox_9c36", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_LblBilledFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "TextBlock_d750", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_TxtBilledFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "DoubleTextBox_2eab", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_LblSpecialFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "TextBlock_e267", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_TxtSpecialFees(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "DoubleTextBox_4f47", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_TxtCFAdjustment(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "DoubleTextBox_716d", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_LblNote(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "TextBlock_8999", 10)}

function Get_WinAccountBillingParameters_GrpBillingParameters_TxtNote(){return Get_WinAccountBillingParameters_GrpBillingParameters().FindChild("Uid", "TextBox_7113", 10)}

//--->  fin MenuTools_Get_functions
*/
/*
//--->   MenuEdit_Get_functions
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

///**  Fenêtre Add New Sentence    ***
function Get_WinAddNewSentence(){return Aliases.CroesusApp.winAddNewSentence}

function Get_WinAddNewSentence_TxtName(){return Get_WinAddNewSentence().FindChild("Uid", "LocaleTextbox_4985", 10)}

function Get_WinAddNewSentence_TxtSentence(){return Get_WinAddNewSentence().FindChild("Uid", "LocaleTextbox_cabb", 10)}

function Get_WinAddNewSentence_BtnSave(){return Get_WinAddNewSentence().FindChild("Uid", "Button_6e0f", 10)}

function Get_WinAddNewSentence_BtnCancel(){return Get_WinAddNewSentence().FindChild("Uid", "Button_8134", 10)}

///***** Fenêtre  Edit Sentence***
function Get_WinEditSentence(){return Aliases.CroesusApp.winEditSentence}

function Get_WinEditSentence_TxtName(){return Get_WinEditSentence().FindChild("Uid", "LocaleTextbox_4985", 10)}

function Get_WinEditSentence_TxtSentence(){return Get_WinEditSentence().FindChild("Uid", "LocaleTextbox_cabb", 10)}

function Get_WinEditSentence_BtnSave(){return Get_WinEditSentence().FindChild("Uid", "Button_6e0f", 10)}

function Get_WinEditSentence_BtnCancel(){return Get_WinEditSentence().FindChild("Uid", "Button_8134", 10)}

///*******************************Consulter une note View a note********************************************************************************
//Edit --> Info --> TabInfo --> Cliquer sur le btn Display
function Get_WinNoteDetail(){return Aliases.CroesusApp.winNoteDetail}

function Get_WinNoteDetail_TxtCreationDateForPositionAndSecurity(){return Get_WinNoteDetail().FindChild("Uid", "TextBox_20b4", 10)}

function Get_WinNoteDetail_TxtPositionForPositionAndSecurity(){return Get_WinNoteDetail().FindChild("Uid", "TextBox_a079", 10)}

function Get_WinNoteDetail_TxtCreatedByForPositionAndSecurity(){return Get_WinNoteDetail().FindChild("Uid", "TextBox_053b", 10)}

///*********************************************************************************************************************************************
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
/************************ FENÊTRE ACTIVITÉS DU CLIENT, DU COMPTE ET DE LA RELATION (CLIENT/ACCOUNT/RELATIONSHIP ACTIVITIES WINDOW) ************************
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
//---> fin  MenuEdit_Get_functions
*/

///-->???
/****************** CLIENTS/RELATIONSHIPS/ACCOUNTS GRID CONTEXTUAL MENU (MENU CONTEXTUEL SUR LE GRID DE CLIENTS/RELATIONS/COMPTES) **************/
//Ci-dessous les parties communes (même Uid) aux modules Clients, Relations et Comptes//Edit --> Sum
function Get_RelationshipsClientsAccountsGrid_ContextualMenu(){return Get_SubMenus().FindChild("Uid", "ContextMenu_5055", 10)}


function Get_ClientsAccountsGrid_ContextualMenu_ExternalClientFile(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "CFMenuItem_e7ca", 10)}


function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Detail(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "CFMenuItem_f1c7", 10)}


function Get_RelationshipsClientsGrid_ContextualMenu_Add(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_9f74", 10)}


function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Delete(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_e036", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Copy(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_e6f5", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_CopyWithHeader(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_ae6c", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_ExportToAFile(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_0fca", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_ExportToMSExcel(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_eca5", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_7623", 10)}

function Get_RelationshipsClientsGrid_ContextualMenu_EditSegmentation(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_bdc8", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignDefaultIndices(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_9520", 10)}

function Get_RelationshipsClientsGrid_ContextualMenu_MassEmailing(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_379d", 10)}

function Get_RelationshipsClientsGrid_ContextualMenu_PrintAddresses(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_56b7", 10)}


function Get_RelationshipsClientsAccountsGrid_ContextualMenu_DetailedInfo(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "CFMenuItem_4994", 10)}


function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_6c69", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Relationship_CreateARelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_bdfd", 10)}

function Get_ClientsAccountsGrid_ContextualMenu_Relationship_JoinToARelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_0337", 10)}


function Get_RelationshipsClientsAccountsGrid_ContextualMenu_AssignToAModel(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_baa6", 10)}


function Get_RelationshipsClientsAccountsGrid_ContextualMenu_OrderEntryModule(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_61d0", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_OrderEntryModule_CreateABuyOrder(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_0814", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_OrderEntryModule_CreateASellOrder(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_698d", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_OrderEntryModule_SwitchBlock(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_ae54", 10)}


function Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_4434", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy_Name()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Nom"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Name"], 10)}
}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_SortBy_ClientNo()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "No client"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Client No."], 10)}
}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions(){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild("Uid", "MenuItem_24ad", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Performance(){return Get_CroesusApp().FindChild("Uid", "MenuItem_03e8", 10)}

function Get_RelationshipsAccountsGrid_ContextualMenu_Functions_Restrictions(){return Get_CroesusApp().FindChild("Uid", "MenuItem_04d8", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Activities(){return Get_CroesusApp().FindChild("Uid", "MenuItem_73f0", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Models(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_6a3b", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Relationships(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_d4b1", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Clients(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_eafb", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Accounts(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_d7b3", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Portfolio(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_2755", 10)}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Functions_Transactions(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_8211", 10)}

function Get_ClientsAccountsGrid_ContextualMenu_Functions_Security(){return Get_CroesusApp().FindChild("Uid", "CFMenuItem_6e02", 10)}


function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Help()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Aide"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Help"], 10)}
}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Help_ContextSensitiveHelp()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Aide contextuelle"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Context-Sensitive Help"], 10)}
}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Help_ContentsAndIndex()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Sommaire et index"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Contents and Index"], 10)}
}

function Get_RelationshipsClientsAccountsGrid_ContextualMenu_Print()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Imprimer..."], 10)}
  else {return Get_RelationshipsClientsAccountsGrid_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Print..."], 10)}
}
//--->fin ??


//--->  MenuEdit_Get_functions
/************************* CLIENTS/RELATIONSHIPS/ACCOUNTS SUM WINDOW (FENÊTRE SOMMATION CLIENTS/RELATIONS/COMPTES) *****************************/
//Ci-dessous les parties communes (même Uid) aux modules Clients, Relations et Comptes 
//Edit --> Sum
//function Get_WinRelationshipsClientsAccountsSum(){return Aliases.CroesusApp.winRelationshipsClientsAccountsSum}
//
//function Get_WinRelationshipsClientsAccountsSum_BtnClose(){return Get_WinRelationshipsClientsAccountsSum().FindChild("Uid", "Button_8845", 10)}
//---> fin  MenuEdit_Get_functions


//--->???
/******************************** RELATIONSHIPS, CLIENTS AND ACCOUNTS MAIN WINDOW *****************************************/
//La fenêtre principale possède les mêmes Uid pour le padheader, le grid et la partie détails des trois modules Relations, Clients et Comptes
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount(){return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindChild("Uid", "DataGrid_abbc", 10)}

function Get_RelationshipsClientsAccountsPlugin(){return Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin}

function Get_RelationshipsClientsAccountsGrid(){return Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid}

function Get_RelationshipsClientsAccountsDetails(){return Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.bottomGroupBox}

function Get_RelationshipsClientsAccountsBar(){return Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.barPadHeader}

function Get_RelationshipsClientsAccountsBar_BtnPerformance(){return Get_RelationshipsClientsAccountsBar().FindChild("Uid", "Button_69a8", 10)}

function Get_RelationshipsAccountsBar_BtnRestrictions(){return Get_RelationshipsClientsAccountsBar().FindChild("Uid", "Button_274f", 10)}

function Get_RelationshipsClientsAccountsBar_BtnActivities(){return Get_RelationshipsClientsAccountsBar().FindChild("Uid", "Button_2bc6", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_862d", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_CreateFamilyFirmRelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_0514", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToAFamilyFirmRelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_1c01", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinClients(){return Get_CroesusApp().FindChild("Uid", "MenuItem_c438", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinAccounts(){return Get_CroesusApp().FindChild("Uid", "MenuItem_a739", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_Relationship_JoinToRelationship(){return Get_CroesusApp().FindChild("Uid", "MenuItem_3e78", 10)}

function Get_RelationshipsClientsAccountsDetails_ManagementLevel(){
            return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "CFTextBlock_805f", 10)}
            
function Get_RelationshipsClientsAccountsGrid_ColumnHeader(Header){
        return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", Header], 10)}

/******************************** RELATIONSHIPS, CLIENTS AND ACCOUNTS DETAILS *****************************************/

//Hierarchy panel

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel(){return Get_RelationshipsClientsAccountsDetails().FindChild("Uid", "HierarchyPanel_8528", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu(){return Get_SubMenus().FindChild("Uid", "ContextMenu_58d9", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Info(){return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild("Uid", "MenuItem_6f4e", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Detail(){return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild("Uid", "MenuItem_6d2e", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Delete(){return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild("Uid", "MenuItem_9b41", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Ungroup(){return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild("Uid", "MenuItem_42cc", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Performance(){return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild("Uid", "MenuItem_fc05", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Restrictions(){return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild("Uid", "MenuItem_e841", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign(){return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild("Uid", "MenuItem_6c7c", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Assign_AssignToAnExistingModel(){return Get_CroesusApp().FindChild("Uid", "MenuItem_b319", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_RemoveFromRelationship(){return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild("Uid", "MenuItem_591b", 10)}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Help()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Aide"], 10)}
  else {return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Help"], 10)}
}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Help_ContextSensitiveHelp()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Aide contextuelle"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Context-Sensitive Help"], 10)}
}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Help_ContentsAndIndex()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Sommaire et index"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Contents and Index"], 10)}
}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Print()
{
  if (language == "french"){return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Imprimer..."], 10)}
  else {return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Print..."], 10)}
}
//-->??


//--->   MenuEdit_Get_functions
/******************************** MODULE MODELES BTN ASSIGN, MODULE RELATIONSHIPS BTN JOIN, MODULES CLIENTS/ACCOUNTS JOIN TO RELATIONSHIPS *****************************************/
//La fenêtre où on choisit les relations, les clients ou les comptes à assigner au modèle/à la relation
//Edit--> Assign
/*
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
//---> fin  MenuEdit_Get_functions
*/

/*
//---> fin  MenuTools_Get_functions
//****************************************** FENÊTRE CONFIGURATIONS (CONFIGURATIONS WINDOW) ********************************************
//Tools--> Configurations
function Get_WinConfigurations(){return Aliases.CroesusApp.winConfigurations}

function Get_WinConfigurations_ToolBar(){return Get_WinConfigurations().FindChild("Uid", "ToolBar_1d40", 10)}

function Get_WinConfigurations_ToolBar_BtnDelete()
{
  if (language == "french"){return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Supprimer"], 10, true, 5000)}
  else {return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Delete"], 10, true, 5000)}
}
function Get_WinConfigurations_ToolBar_BtnEdit(){
  if (language == "french"){return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Modifier une configuration"], 10, true, 5000)}
  else {return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Edit a Configuration"], 10, true, 5000)}
}
function Get_WinConfigurations_ToolBar_BtnAddAssetAllocation()
{
  if (language == "french"){return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Ajouter une répartition d'actifs"], 10, true, 5000)}
  else {return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Add Asset Allocation"], 10, true, 5000)}
}

function Get_WinConfigurations_ToolBar_BtnAddInvestmentObjective()
{
  if (language == "french"){return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Ajouter un objectif de placement"], 10, true, 5000)}
  else {return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Add Investment Objective"], 10, true, 5000)}
}

function Get_WinConfigurations_ToolBar_BtnMapClassification()
{
  if (language == "french"){return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Assigner un classement"], 10, true, 5000)}
  else {return Get_WinConfigurations_ToolBar().FindChildEx(["ClrClassName", "ToolTip.OleValue"], ["UniActionButton", "Map Classification"], 10, true, 5000)}
}

function Get_WinConfigurations_TvwTreeview(){return Get_WinConfigurations().FindChildEx("Uid", "TreeView_f006", 10, true, 5000)}

function Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Profils & Dictionnaires"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Profiles & Dictionaries"], 10)}
}

function Get_WinConfigurations_TvwTreeview_LlbUnifiedManagedAccounts()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Comptes à gestion unifiée"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Unified Managed Accounts"], 10)}
}

function Get_WinConfigurations_TvwTreeview_LlbProductsAndServices()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Produits & Services"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Products & Services"], 10)}
}


function Get_WinConfigurations_TvwTreeview_LlbSecurityAndCategorisation()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Catégorisation des titres"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Security categorisation"], 10)}
}



function Get_WinConfigurations_TvwTreeview_LlbRestrictions(){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Restrictions"], 10)}

function Get_WinConfigurations_TvwTreeview_LlbBilling()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Facturation"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Billing"], 10)}
}

function Get_WinConfigurations_TvwTreeview_LlbRiskComplianceManager()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Gestionnaire du risque et de la conformité"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Risk & Compliance Manager"], 10)}
}

function Get_WinConfigurations_LvwListView(){return Get_WinConfigurations().FindChildEx("Uid", "ListView_bc90", 10, true, -1)}

function Get_WinConfigurations_LvwListView_LlbProfiles()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Profils"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Profiles"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbManageRestrictions()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Gérer les restrictions"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Manage Restrictions"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbManageCriteria()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Gérer les critères"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Manage Criteria"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbAssignRestrictionsToCriteria()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Assigner les restrictions aux critères"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Assign Restrictions to Criteria"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbGroupsOfProfiles()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Groupes de profils"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Groups of Profiles"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbDictionaries()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Dictionnaires"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Dictionaries"], 10)}
}


function Get_WinConfigurations_LvwListView_LlbSecurityAndCategorisation()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Catégorisation des titres"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Security categorisation"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbManageBilling()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Gérer la facturation"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Manage Billing"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbRiskRatingAllocation()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Répartition des cotes de risque"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Risk Rating Allocation"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbManageValidationGrid()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Gérer la grille de validation"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Manage Validation Grid"], 10)}
}


function Get_WinConfigurations_TvwTreeview_LlbOptions(){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Options"], 10)}

function Get_WinConfigurations_LvwListView_LlbMyOptions()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Mes options"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "My Options"], 10)}
}


function Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Répartitions et objectifs"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Asset Allocations and Objectives"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbGlobalClassifications()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Classements globaux"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Global Classifications"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbSubcategories()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Sous-catégories"], 10)}
  else {return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Subcategories"], 10)}
}


function Get_WinConfigurations_TvwTreeview_LlbRegionalSettings()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Paramètres régionaux"], 10)}
  else {return Get_WinConfigurations_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Regional Settings"], 10)}
}

function Get_WinConfigurations_LvwListView_LlbUpperRegionalSettings(){return Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListViewItem", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}

function Get_WinConfigurations_LvwListView_LlbItem(itemName)
{
  return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", itemName], 10, true, 5000);
}

function Get_WinConfigurations_LvwListView_LlbMyAssetAllocations()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Mes répartitions"], 10, true, 5000)}
  else {return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "My Asset Allocations"], 10, true, 5000)}
}

function Get_WinConfigurations_LvwListView_LlbBasedOn()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Basé sur"], 10, true, 5000)}
  else {return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Based on"], 10, true, 5000)}
}


function Get_WinConfigurations_LvwListView_LlbMyObjectives()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Mes objectifs"], 10, true, 5000)}
  else {return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "My objectives"], 10, true, 5000)}
}


function Get_WinConfigurations_TvwTreeview_LlbReports()
{
  if (language == "french"){return Get_WinConfigurations_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Rapports"], 10, true, 5000)}
  else {return Get_WinConfigurations_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Reports"], 10, true, 5000)}
}

function Get_WinConfigurations_LvwListView_LlbDefaultConfiguration()
{
  if (language == "french"){return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Configuration des défauts"], 10, true, 5000)}
  else {return Get_WinConfigurations_LvwListView().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Default Configuration"], 10, true, 5000)}
}
//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//*********************************** FENETRE CONFIGURATION DES DÉFAUTS (DEFAULT CONFIGURATION WINDOW) **************
//Tools-->Configurations-->Default Configuration
function Get_WinDefaultConfiguration(){return Aliases.CroesusApp.winDefaultConfiguration}

function Get_WinDefaultConfiguration_RdoGlobal(){return Get_WinDefaultConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Global"], 10)}

function Get_WinDefaultConfiguration_CmbTheme(){return Get_WinDefaultConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinDefaultConfiguration_BtnImport()
{
  if (language == "french"){return Get_WinDefaultConfiguration().FindChildEx(["ClrClassName", "WPFControlText"], ["UniButton", "_Importer..."], 10, true, 5000)}
  else {return Get_WinDefaultConfiguration().FindChildEx(["ClrClassName", "WPFControlText"], ["UniButton", "_Import..."], 10, true, 5000)}
}

function Get_WinDefaultConfiguration_BtnOK(){return Get_WinDefaultConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinDefaultConfiguration_BtnCancel()
{
  if (language == "french"){return Get_WinDefaultConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinDefaultConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}


function Get_WinDefaultConfiguration_TvwTreeview(){return Get_WinDefaultConfiguration().FindChildEx(["ClrClassName", "WPFControlOrdinalNo"], ["TreeView", 1], 10, true, 5000)}

function Get_WinDefaultConfiguration_TvwTreeview_LlbTheme()
{
  if (language == "french"){return Get_WinDefaultConfiguration_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Thème"], 10, true, 5000)}
  else {return Get_WinDefaultConfiguration_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Theme"], 10, true, 5000)}
}

function Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration()
{
  if (language == "french"){return Get_WinDefaultConfiguration_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Configuration spécifique"], 10, true, 5000)}
  else {return Get_WinDefaultConfiguration_TvwTreeview().FindChildEx(["ClrClassName", "WPFControlText"], ["TextBlock", "Specific Configuration"], 10, true, 5000)}
}


//    Paramètre : itemLabel : Nom du sous-élément de Configuration Spécifique

function Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration_LlbItem(itemLabel)
{
    var llbItemObjectParent = Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration().Parent;
    llbItemObjectParent.set_IsExpanded(true);
    var arrayOfTreeviewItems = llbItemObjectParent.FindAllChildren(["ClrClassName", "IsVisible"], ["CFTreeViewItem", true]).toArray();
    for (var i in arrayOfTreeviewItems)
        if (arrayOfTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["TextBlock", true, itemLabel]).Exists)
            return arrayOfTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["TextBlock", true, itemLabel]);
    return Utils.CreateStubObject();
}


//    Paramètre : itemLabel : Nom du sous-élément de Configuration Spécifique

function Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration_LlbItem_LlbTheme(itemLabel)
{
    var labelTheme = (language == "french")? "Thème": "Theme";
    
    var llbItemObjectParent = Get_WinDefaultConfiguration_TvwTreeview_LlbSpecificConfiguration_LlbItem(itemLabel).Parent;
    llbItemObjectParent.set_IsExpanded(true);
    var arrayOfTreeviewItems = llbItemObjectParent.FindAllChildren(["ClrClassName", "IsVisible"], ["CFTreeViewItem", true]).toArray();
    for (var i in arrayOfTreeviewItems)
        if (arrayOfTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["TextBlock", true, labelTheme]).Exists)
            return arrayOfTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["TextBlock", true, labelTheme]);

    return Utils.CreateStubObject();
}

function Get_WinDefaultConfiguration_ChkUseDefault()
{
  if (language == "french"){return Get_WinDefaultConfiguration().FindChildEx(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Utiliser le défaut"], 10, true, 5000)}
  else {return Get_WinDefaultConfiguration().FindChildEx(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Use Default"], 10, true, 5000)}
}
//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//*********************************** FENETRE AJOUT/MODIFICATION D'UN THÈME DE RAPPORT (ADD/EDIT A REPORT Theme WINDOW) **************
//Tools-->Configurations-->Default Configuration --> btnImport
function Get_WinAddOrEditAReportTheme(){return Aliases.CroesusApp.winAddOrEditAReportTheme}

function Get_WinAddOrEditAReportTheme_TxtFirm(){return Get_WinAddOrEditAReportTheme().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 10)}

function Get_WinAddOrEditAReportTheme_CmbLanguage(){return Get_WinAddOrEditAReportTheme().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinAddOrEditAReportTheme_TxtThemeName(){return Get_WinAddOrEditAReportTheme().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 2], 10)}

function Get_WinAddOrEditAReportTheme_TxtFile(){return Get_WinAddOrEditAReportTheme().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 3], 10)}

function Get_WinAddOrEditAReportTheme_BtnOK(){return Get_WinAddOrEditAReportTheme().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//*********************************** FENETRE RISK ALLOCATION CONFIGURATION TOOLS ***********************************************************
//Tools --> Configirations --> RISK ALLOCATION
function Get_WinRiskAllocationConfigurationTool(){return Aliases.CroesusApp.winRiskAllocationConfigurationTool}

function Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation(){return Get_WinRiskAllocationConfigurationTool().FindChild("Uid", "DataGrid_8f5d", 10)}

function Get_WinRiskAllocationConfigurationTool_TabRiskAllocationLevel(){return Get_WinRiskAllocationConfigurationTool().FindChild("Uid", "DataGrid_478a", 10)}

function Get_WinRiskAllocationConfigurationTool_BtnSave()  
{
if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Sau_vegarder"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Sa_ve"], 10)}
}

function Get_WinRiskAllocationConfigurationTool_BtnCancel()
{
if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Annuler"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Cancel"], 10)}
}

function Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation_TxtRatingLevelWeightCell(securityRiskRatingName, riskAllocationLevelName)
{
    var securityRiskRatingColumnHeaderName = "";
    var securityRiskRatingColumnIndex = 1; //Default Index ; the actual one will be retrieved according to the securityRiskRatingColumnHeaderName (if not successfull, the default one will be used)
    
    var dgvRecordListControl = Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
    var columnHeadersCount = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderPresenter", 1], 10).DataContext.Cells.Count;
    
    //Find Risk Allocation Level Column
    var riskAllocationLevelColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", riskAllocationLevelName], 10);
    if (!riskAllocationLevelColumnHeader.Exists){
        dgvRecordListControl.keys("[Home][Home][Home]");
        var keysCount = 0;
        do {
            dgvRecordListControl.keys("[Right]");
            riskAllocationLevelColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", riskAllocationLevelName], 10);
        } while (++keysCount <= (columnHeadersCount) && !riskAllocationLevelColumnHeader.Exists)
    }
    
    //var riskAllocationLevelColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", riskAllocationLevelName], 10);
    if (!riskAllocationLevelColumnHeader.Exists)
        Log.Error(aqString.Quote(riskAllocationLevelName) + " Risk Allocation Level Header Label not found.");
    else {
        var riskAllocationLevelColumnIndex = riskAllocationLevelColumnHeader.WPFControlOrdinalNo;
        
        //Find Security Risk Rating Column
        var arrayOfSecurityRiskRatingColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindAllChildren(["ClrClassName", "WPFControlText"], ["LabelPresenter", securityRiskRatingColumnHeaderName], 10).toArray();
        if (arrayOfSecurityRiskRatingColumnHeader.length == 1)
            securityRiskRatingColumnIndex = arrayOfSecurityRiskRatingColumnHeader[0].WPFControlOrdinalNo;
        else {
            if (arrayOfSecurityRiskRatingColumnHeader.length == 0)
                Log.Warning("Security Risk Rating Header '" + securityRiskRatingColumnHeaderName + "' not found. Consider the default index, securityRiskRatingColumnIndex = " + securityRiskRatingColumnIndex);
            else
                Log.Warning("Security Risk Rating Header duplicate label '" + securityRiskRatingColumnHeaderName + "'. Consider the default index, securityRiskRatingColumnIndex = " + securityRiskRatingColumnIndex);
        }
        
        //Find Security Risk Rating Row and then return the cell component
        var rowsCount = dgvRecordListControl.Items.Count;
        var securityRiskRatingRow = GetSecurityRatingRow(securityRiskRatingName, securityRiskRatingColumnIndex, rowsCount);
        if (securityRiskRatingRow.Exists){
            var riskAllocationLevelColumnHeaderLeftX = riskAllocationLevelColumnHeader.Left;
            var criskAllocationLevelColumnHeaderRightX = riskAllocationLevelColumnHeaderLeftX + riskAllocationLevelColumnHeader.Width;
            var arrayOfSecurityRiskRatingRowWeightCells = securityRiskRatingRow.FindAllChildren(["ClrClassName", "IsVisible"], ["CellValuePresenter", true], 10).toArray();
            for (var cellIndex = 0; cellIndex < arrayOfSecurityRiskRatingRowWeightCells.length; cellIndex++){
                var securityRiskRatingRowWeightCell = arrayOfSecurityRiskRatingRowWeightCells[cellIndex];
                var securityRiskRatingRowWeightCellMiddleX = securityRiskRatingRowWeightCell.Left + (securityRiskRatingRowWeightCell.Width/2);
                if (securityRiskRatingRowWeightCellMiddleX > riskAllocationLevelColumnHeaderLeftX && securityRiskRatingRowWeightCellMiddleX < criskAllocationLevelColumnHeaderRightX)
                    return securityRiskRatingRowWeightCell.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10);
            }
        }
        
        Log.Error(aqString.Quote(securityRiskRatingName) + " Security Risk Rating row not found.");
    }
    
    return Utils.CreateStubObject();
    
    
    function GetSecurityRatingRow(securityRiskRatingName, securityRiskRatingColumnIndex, rowsCount, numTry)
    {
        numTry = (numTry == undefined)? 1: numTry++;
        
        if (numTry > rowsCount)
            return Utils.CreateStubObject();
        
        var dgvRecordListControl = Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
        dgvRecordListControl.Refresh();
        var allSecurityRiskRatingRows = dgvRecordListControl.FindAllChildren(["ClrClassName", "VisibleOnScreen"], ["DataRecordPresenter", true], 10).toArray();
        for (var allSecurityRiskRatingRowsIndex = 0; allSecurityRiskRatingRowsIndex < allSecurityRiskRatingRows.length; allSecurityRiskRatingRowsIndex++){
            var DataRecordCellArea = allSecurityRiskRatingRows[allSecurityRiskRatingRowsIndex].FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordCellArea", 1], 10);
            if (!DataRecordCellArea.Exists)
                continue;
            
            var securityRiskRatingRowLabelCell = DataRecordCellArea.FindChild(["ClrClassName", "WPFControlOrdinalNo", "WPFControlText"], ["CellValuePresenter", securityRiskRatingColumnIndex, securityRiskRatingName], 10);
            if (securityRiskRatingRowLabelCell.Exists)
                return allSecurityRiskRatingRows[allSecurityRiskRatingRowsIndex];
        }
        
        if (numTry == 1)
            dgvRecordListControl.Keys("[PageUp][PageUp][PageUp]");
        
        numTry++;
        dgvRecordListControl.Keys("[Down]");
        dgvRecordListControl.Refresh();
        return GetSecurityRatingRow(securityRiskRatingName, securityRiskRatingColumnIndex, rowsCount, numTry);
    }
}



function Get_WinRiskAllocationConfigurationTool_DgvClientRiskObjectives_TxtRatingLevelMnemonicCodeCell(riskAllocationLevelName)
{    
    var riskAllocationLevelColumnHeaderName = (language == "french")? "Niveaux de répartition du risque (%)": "Risk allocation levels (%)";
    var mnemonicCodeColumnHeaderName = (language == "french")? "Codes Mnémoniques": "Mnemonic codes";
    var riskAllocationLevelColumnIndex = 1; //Default Index, the actual one will be retrieved according to the riskAllocationLevelColumnHeaderName (if not successfull, the default one will be used)
    var mnemonicCodeColumnIndex = 2; //Default Index, the actual one will be retrieved according to the mnemonicCodeColumnHeaderName (if not successfull, the default one will be used)
    
    var dgvRecordListControl = Get_WinRiskAllocationConfigurationTool_TabRiskAllocationLevel().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);

    //Find Risk Allocation Level Column Index
    var riskAllocationLevelColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", riskAllocationLevelColumnHeaderName], 10);
    if (riskAllocationLevelColumnHeader.Exists)
        riskAllocationLevelColumnIndex = riskAllocationLevelColumnHeader.WPFControlOrdinalNo;
    else
        Log.Warning("Risk Allocation Level Header '" + mnemonicCodeColumnHeaderName + "' not found. Consider the default index, riskAllocationLevelColumnIndex = " + riskAllocationLevelColumnIndex);
    
    //Find Mnemonic Code Column Index
    var mnemonicCodeColumnHeader = dgvRecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", mnemonicCodeColumnHeaderName], 10);
    if (mnemonicCodeColumnHeader.Exists)
        mnemonicCodeColumnIndex = mnemonicCodeColumnHeader.WPFControlOrdinalNo;
    else
        Log.Warning("Mnemonic Code Header '" + mnemonicCodeColumnHeaderName + "' not found. Consider the default index, mnemonicCodeColumnIndex = " + mnemonicCodeColumnIndex);
    
    //Find Security Risk Allocation level Row and then return the according Mnemonic cell component
    var rowsCount = dgvRecordListControl.Items.Count;
    var riskAllocationLevelRow = GetRiskAllocationLevelRow(riskAllocationLevelName, riskAllocationLevelColumnIndex, rowsCount);
    if (riskAllocationLevelRow.Exists)
        return riskAllocationLevelRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", mnemonicCodeColumnIndex], 10).WPFObject("XamTextEditor", "", 1);
    
    Log.Error(aqString.Quote(riskAllocationLevelName) + " Security Risk Rating Allocation level row not found.");
    return Utils.CreateStubObject();
    
    
    function GetRiskAllocationLevelRow(riskAllocationLevelName, riskAllocationLevelColumnIndex, rowsCount, numTry)
    {
        numTry = (numTry == undefined)? 1: numTry++;
        
        if (numTry > rowsCount)
            return Utils.CreateStubObject();
        
        var dgvRecordListControl = Get_WinRiskAllocationConfigurationTool_TabRiskAllocationLevel().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10);
        dgvRecordListControl.Refresh();
        var allRiskAllocationLevelRows = dgvRecordListControl.FindAllChildren(["ClrClassName", "VisibleOnScreen"], ["DataRecordPresenter", true], 10).toArray();
        for (var allRiskAllocationLevelRowsIndex = 0; allRiskAllocationLevelRowsIndex < allRiskAllocationLevelRows.length; allRiskAllocationLevelRowsIndex++){
            var DataRecordCellArea = allRiskAllocationLevelRows[allRiskAllocationLevelRowsIndex].FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordCellArea", 1], 10);
            if (!DataRecordCellArea.Exists)
                continue;
            
            var securityRiskRatingRowLabelCell = DataRecordCellArea.FindChild(["ClrClassName", "WPFControlOrdinalNo", "WPFControlText"], ["CellValuePresenter", riskAllocationLevelColumnIndex, riskAllocationLevelName], 10);
            if (securityRiskRatingRowLabelCell.Exists)
                return allRiskAllocationLevelRows[allRiskAllocationLevelRowsIndex];
        }
        
        if (numTry == 1)
            dgvRecordListControl.Keys("[PageUp][PageUp][PageUp]");
        
        numTry++;
        dgvRecordListControl.Keys("[Down]");
        dgvRecordListControl.Refresh();
        return GetRiskAllocationLevelRow(riskAllocationLevelName, riskAllocationLevelColumnIndex, rowsCount, numTry);
    }
}
//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//****************************************** FENÊTRE RÉPARTITION D'ACTIFS (ASSET ALLOCATION WINDOW) ********************************************
//Tools --> Configurations 
function Get_WinAssetAllocation(){return Aliases.CroesusApp.winAssetAllocation}

function Get_WinAssetAllocation_LblDescription(){return Get_WinAssetAllocation().FindChild(["ClrClassName", "Text.OleValue"], ["UniLabel", "Description:"], 10)}

function Get_WinAssetAllocation_TxtDescription(){return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 10)}

function Get_WinAssetAllocation_BtnLanguages(){return Get_WinAssetAllocation().FindChild("Uid", "Button_d168", 10)}

function Get_WinAssetAllocation_ChkReadOnly()
{
  if (language == "french"){return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Lecture seulement"], 10)}
  else {return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Read-only"], 10)}
}

function Get_WinAssetAllocation_BtnOK(){return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinAssetAllocation_BtnCancel()
{
  if (language == "french"){return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinAssetAllocation().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

//---> fin  MenuTools_Get_functions



//--->   MenuTools_Get_functions
//****************************************** FENÊTRE DESCRIPTION (DESCRIPTION WINDOW) ********************************************
//Tools --> Configirations --> WinAssetAllocation --> clique sur la langue 
function Get_WinDescription(){return Aliases.CroesusApp.winDescription}

function Get_WinDescription_LblEnglishCanada(){return Get_WinDescription().FindChild(["ClrClassName", "Text.OleValue"], ["UniLabel", "English (Canada) :"], 10)}

function Get_WinDescription_TxtEnglishCanada(){return Get_WinDescription().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 10)}

function Get_WinDescription_LblFrancaisCanada(){return Get_WinDescription().FindChild(["ClrClassName", "Text.OleValue"], ["UniLabel", "Français (Canada) :"], 10)}

function Get_WinDescription_TxtFrancaisCanada(){return Get_WinDescription().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 2], 10)}

function Get_WinDescription_BtnOK(){return Get_WinDescription().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinDescription_BtnCancel()
{
  if (language == "french"){return Get_WinDescription().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinDescription().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

//---> fin  MenuTools_Get_functions



//--->  MenuTools_Get_functions
//****************************************** FENÊTRE ASSIGNATION D'UN CLASSEMENT (MAP A CLASSIFICATION WINDOW) ********************************************
//Tools-->Configurations 
function Get_WinMapAClassification(){return Aliases.CroesusApp.winMapAClassification}

function Get_WinMapAClassification_LvwAccessLevel(){return Get_WinMapAClassification().FindChildEx(["ClrClassName", "Uid", "WPFControlOrdinalNo"], ["ListViewTable", "ListView_bc90", 1], 10)}

function Get_WinMapAClassification_LvwAccessLevel_LlbGlobalClassifications()
{
  if (language == "french"){return Get_WinMapAClassification_LvwAccessLevel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Classements globaux"], 10)}
  else {return Get_WinMapAClassification_LvwAccessLevel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Global Classifications"], 10)}
}

function Get_WinMapAClassification_LvwAccessLevel_LlbFirmClassifications()
{
  if (language == "french"){return Get_WinMapAClassification_LvwAccessLevel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Classements de la firme"], 10)}
  else {return Get_WinMapAClassification_LvwAccessLevel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Firm Classifications"], 10)}
}

function Get_WinMapAClassification_LvwAvailableClassifications(){return Get_WinMapAClassification().FindChildEx(["ClrClassName", "Uid", "WPFControlOrdinalNo"], ["ListViewTable", "ListView_bc90", 2], 10)}

function Get_WinMapAClassification_LvwAvailableClassifications_LlbSubcategories()
{
  if (language == "french"){return Get_WinMapAClassification_LvwAvailableClassifications().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Sous-catégories"], 10)}
  else {return Get_WinMapAClassification_LvwAvailableClassifications().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Subcategories"], 10)}
}

function Get_WinMapAClassification_BtnOK(){return Get_WinMapAClassification().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinMapAClassification_BtnCancel()
{
  if (language == "french"){return Get_WinMapAClassification().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinMapAClassification().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}
//---> fin  MenuTools_Get_functions
*/
/*
//--->  MenuTools_Get_functions
//****************************************** FENÊTRE OBJECTIF DE PLACEMENT (INVESTMENT OBJECTIVE WINDOW) ********************************************
//Tools--> Configuration
function Get_WinInvestmentObjective(){return Aliases.CroesusApp.winInvestmentObjective}

function Get_WinInvestmentObjective_BtnOK(){return Get_WinInvestmentObjective().FindChild("Uid", "Button_4800", 10)}

function Get_WinInvestmentObjective_BtnCancel(){return Get_WinInvestmentObjective().FindChild("Uid", "Button_5161", 10)}

function Get_WinInvestmentObjective_GrpInformation(){return Get_WinInvestmentObjective().FindChild("Uid", "GroupBox_f674", 10)}

function Get_WinInvestmentObjective_GrpInformation_TxtDescription(){return Get_WinInvestmentObjective_GrpInformation().FindChild("Uid", "LocaleTextbox_28a0", 10)}

function Get_WinInvestmentObjective_GrpInformation_TxtAutomaticMinMaxAdjustment(){return Get_WinInvestmentObjective_GrpInformation().FindChild("Uid", "IntegerTextBox_0d11", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass(){return Get_WinInvestmentObjective().FindChild("Uid", "GroupBox_9794", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective(){return Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass().FindChild("Uid", "DataGrid_8705", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages(){return Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass().FindChild("Uid", "GroupBox_d90d", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages_TxtRecommended(){return Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages().FindChild("Uid", "IntegerTextBox_ef48", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages_TxtMinimum(){return Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages().FindChild("Uid", "IntegerTextBox_73f8", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages_TxtMaximum(){return Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages().FindChild("Uid", "IntegerTextBox_bf2a", 10)}

function Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective_Item(itemLabel)
{
    var itemObject = Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", itemLabel], 10);
    
    if (!itemObject.Exists){
        Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().Keys("[Home][Home]");
        do {
            var previousActiveRecordIndex = Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().Parent.ActiveRecord.Index;
            Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().Keys("[PageDown]");
            var itemObject = Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().FindChild(["ClrClassName", "WPFControlText"], ["CellValuePresenter", itemLabel], 10);
            var newActiveRecordIndex = Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective().Parent.ActiveRecord.Index;
        } while (!itemObject.Exists && newActiveRecordIndex != previousActiveRecordIndex)
    }
    
    return itemObject;
}

//---> fin  MenuTools_Get_functions


//---> MenuTools_Get_functions
//******************** FENÊTRE CONFIGURATION DES PROFILS ET DU DICTIONNAIRE (PROFILES AND DICTIONARY CONFIGURATION WINDOW) *********************
//Tools--> Configarations
function Get_WinProfilesAndDictionaryConfiguration(){return Aliases.CroesusApp.winProfilesAndDictionaryConfiguration}

function Get_WinProfilesAndDictionaryConfiguration_BtnClose(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_d7f6", 10)}


//Onglet Liste des profils (List of Profiles tab)

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "TabItem_8ad0", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "DataGrid_87ea", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnAdd(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_70d5", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnEdit(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_1ddd", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnDelete(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_a526", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnDetailedPreview(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_2540", 10)}


//Onglet Groupes de profils (Groups of Profiles tab)

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "TabItem_fd65", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntAddGroup(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_4d3d", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntEdit(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_6e21", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntDelete(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_3fe5", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntAddSubGroup(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_2753", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_GrpGroup(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "GroupBox_2aed", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "ComboBox_ffbe", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_ProfilGroupsGrid(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "DataGrid_e6c2", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BtnDeleteProfile(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_204b", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_ProfilListGrid(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "DataGrid_9542", 10)}


//FENÊTRE ADD GROUP/ADD SUBGROUP

function Get_WinProfilGroupConfiguration(){return Aliases.CroesusApp.winProfilGroupConfiguration}

function Get_WinProfilGroupConfiguration_TxtDescription(){return Get_WinProfilGroupConfiguration().FindChild("Uid", "LocaleTextbox_6523", 10)}

function Get_WinProfilGroupConfiguration_BtnOk(){return Get_WinProfilGroupConfiguration().FindChild("Uid", "Button_9c0c", 10)}

function Get_WinProfilGroupConfiguration_BtnCancel(){return Get_WinProfilGroupConfiguration().FindChild("Uid", "Button_7b3e", 10)}


//Onglet Dictionnaires (Dictionary tab)

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "TabItem_2e9e", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "GroupBox_4d7b", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList(){return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList().FindChild("Uid", "DataGrid_b038", 10)}


//** Section Liste de dictionnaires **

//colonne Code
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colCode() {
    
    return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Code"], 10)
}

//colonne French Description
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colFrenchDesc() {
    
    if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description en français"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "French Description"], 10)
}

//colonne English Description
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colEnglishDesc() {
    
    if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description en anglais"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "English Description"], 10)
}

//colonne Mnemonic
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList_colMnemonic() {
    
    if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mnémonique"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_DgvDictionariesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mnemonic"], 10)
}


//** Section Unités de dictionnaire **

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries(){
    return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "GroupBox_5964", 10);
}

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList(){
    return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries().FindChild("Uid", "DataGrid_ea69", 10);

}

//colonne Index
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colIndex() {
    
    return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Index"], 10)
}

//colonne Description en français / French Description
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colFrenchDesc() {
    
     if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description en français"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "French Description"], 10)
}

//colonne Description en anglais / English Description
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colEnglishDesc() {
    
     if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Description en anglais"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "English Description"], 10)
}

//colonne Mnémonique en français / French Mnemonic
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colFrenchMnemonic() {
    
     if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mnémonique français"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "French Mnemonic"], 10)
}

//colonne Mnémonique en anglais / English Mnemonic
function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList_colEnglishMnemonic() {
    
     if (language == "french")
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Mnémonique anglais"], 10)
    else
        return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionaryEntries_EntriesList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "English Mnemonic"], 10)
}


function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_BtnAdd(){return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList().FindChild("Uid", "Button_25bc", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_BtnEdit(){return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList().FindChild("Uid", "Button_a5c5", 10)}

function Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList_BtnDelete(){return Get_WinProfilesAndDictionaryConfiguration_TabDictionary_GrpDictionariesList().FindChild("Uid", "Button_aa81", 10)}
//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//*********************************** FENÊTRE AJOUTER/MODIFIER LE DICTIONNAIRE (ADD/EDIT DICTIONARY WINDOW) ************************************
//Tools--> Configarations. Dans la fenêtre "profiles ans Dictionary Configuration" cliquer sur ke btn Add 
function Get_WinCRUDictionary(){return Aliases.CroesusApp.winCRUDictionary}

function Get_WinCRUDictionary_BtnOK(){return Get_WinCRUDictionary().FindChild("Uid", "Button_7827", 10)}

function Get_WinCRUDictionary_BtnCancel(){return Get_WinCRUDictionary().FindChild("Uid", "Button_e0c7", 10)}

function Get_WinCRUDictionary_GrpDetail(){return Get_WinCRUDictionary().FindChild("Uid", "GroupBox_7589", 10)}

function Get_WinCRUDictionary_GrpDetail_LblFrenchDescription()
{
  if (language == "french"){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBlock_7696", 10)}
  else {return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBlock_9771", 10)}
}

function Get_WinCRUDictionary_GrpDetail_TxtFrenchDescription()
{
  if (language == "french"){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBox_38e1", 10)}
  else {return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBox_6ac3", 10)}
}

function Get_WinCRUDictionary_GrpDetail_LblEnglishDescription()
{
  if (language == "french"){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBlock_9771", 10)}
  else {return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBlock_7696", 10)}
}

function Get_WinCRUDictionary_GrpDetail_TxtEnglishDescription()
{
  if (language == "french"){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBox_6ac3", 10)}
  else {return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBox_38e1", 10)}
}

function Get_WinCRUDictionary_GrpDetail_LblMnemonic(){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBlock_8ee2", 10)}

function Get_WinCRUDictionary_GrpDetail_TxtMnemonic(){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "TextBox_cbd9", 10)}

function Get_WinCRUDictionary_GrpDetail_ChkReadOnly(){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "CheckBox_e4cc", 10)}

function Get_WinCRUDictionary_GrpDetail_ChkLoadAtStartup(){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "CheckBox_de0c", 10)}

function Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries(){return Get_WinCRUDictionary_GrpDetail().FindChild("Uid", "GroupBox_9e1e", 10)}

function Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnAdd(){return Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries().FindChild("Uid", "Button_a16b", 10)}

function Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnEdit(){return Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries().FindChild("Uid", "Button_f386", 10)}

function Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_BtnDelete(){return Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries().FindChild("Uid", "Button_cee7", 10)}

function Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries_DgvDictionaryEntries(){return Get_WinCRUDictionary_GrpDetail_GrpDictionaryEntries().FindChild("Uid", "DataGrid_49a4", 10)}

//---> fin  MenuTools_Get_functions


//--->  MenuTools_Get_functions
//******************************* FENÊTRE AJOUTER/MODIFIER UNE UNITÉ DE DICTIONNAIRE (ADD/EDIT DICTIONARY ENTRY WINDOW) ****************************
//Tools--> Configarations. Dans la fenêtre "profiles ans Dictionary Configuration" cliquer sur ke btn Add 
//dans la fenêtre "Add Dictionary" --> cliquer sur le btn Add 
function Get_WinCRUDictionaryEntry(){return Aliases.CroesusApp.winCRUDictionaryEntry}

function Get_WinCRUDictionary_LblFrenchDescription()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_b7c9", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_0b24", 10)}
}

function Get_WinCRUDictionary_TxtFrenchDescription()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_c5ec", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_9785", 10)}
}

function Get_WinCRUDictionary_LblEnglishDescription()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_0b24", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_b7c9", 10)}
}

function Get_WinCRUDictionary_TxtEnglishDescription()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_9785", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_c5ec", 10)}
}

function Get_WinCRUDictionary_LblFrenchMnemonic()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_6146", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_dfbb", 10)}
}

function Get_WinCRUDictionary_TxtFrenchMnemonic()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_0ecd", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_c4d9", 10)}
}

function Get_WinCRUDictionary_LblEnglishMnemonic()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_dfbb", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBlock_6146", 10)}
}

function Get_WinCRUDictionary_TxtEnglishMnemonic()
{
  if (language == "french"){return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_c4d9", 10)}
  else {return Get_WinCRUDictionaryEntry().FindChild("Uid", "TextBox_0ecd", 10)}
}

function Get_WinCRUDictionaryEntry_BtnOK(){return Get_WinCRUDictionaryEntry().FindChild("Uid", "Button_77ac", 10)}

function Get_WinCRUDictionaryEntry_BtnCancel(){return Get_WinCRUDictionaryEntry().FindChild("Uid", "Button_05e5", 10)}
//---> fin  MenuTools_Get_functions



//--->  MenuTools_Get_functions
//*********************************** FENÊTRE AJOUTER OU MODIFIER UN PROFIL (ADD OR EDIT PROFILE WINDOW) *************************************
//Tools--> Configarations. Dans la fenêtre "profiles ans Dictionary Configuration" cliquer sur la tab "List of Profiles" 
// --> cliquer sur le btn Add 
function Get_WinAddOrEditProfile(){return Aliases.CroesusApp.winAddOrEditProfile}

function Get_WinAddOrEditProfile_BtnOK(){return Get_WinAddOrEditProfile().FindChild("Uid", "Button_ecfc", 10)}

function Get_WinAddOrEditProfile_BtnCancel(){return Get_WinAddOrEditProfile().FindChild("Uid", "Button_5da3", 10)}


function Get_WinAddOrEditProfile_GrpProfile(){return Get_WinAddOrEditProfile().FindChild("Uid", "GroupBox_81dc", 10)}

function Get_WinAddOrEditProfile_GrpProfile_LblMnemonic(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "TextBlock_fc22", 10)}

function Get_WinAddOrEditProfile_GrpProfile_TxtMnemonic(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "TextBox_bf53", 10)}


function Get_WinAddOrEditProfile_GrpProfile_GrpDescription(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "GroupBox_b096", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_LblShort(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBlock_e958", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_LblLong(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBlock_1447", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_LblFrench(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBlock_c699", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_LblEnglish(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBlock_b79d", 10)}

//function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchShort(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBox_a528", 10)}
//
//function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchLong(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBox_0e09", 10)}
//
//function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishShort(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBox_b6eb", 10)}
//
//function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishLong(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild("Uid", "TextBox_4843", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchShort(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox","1"], 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchLong(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox","2"], 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishShort(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox","3"], 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishLong(){return Get_WinAddOrEditProfile_GrpProfile_GrpDescription().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["TextBox","4"], 10)}


function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "GroupBox_5595", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblType(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_9ad0", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "ComboBox_2ec0", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblLenght(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_2a36", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_TxtLenght(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "DoubleTextBox_e0f7", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblIncludingDecimals(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_937e", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblNumberOfDecimals(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_aa0b", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_TxtNumberOfDecimals(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "DoubleTextBox_7b44", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblDictionary(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_ce52", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_TxtDictionaryCode(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBox_e283", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_TxtDictionaryDescription(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBox_0e66", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_BtnChooseDictionary(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "Button_768a", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_LblAccessLevel(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "TextBlock_ac81", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbAccessLevel(){return Get_WinAddOrEditProfile_GrpProfile_GrpDefinition().FindChild("Uid", "ComboBox_efc8", 10)}


function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemText()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Texte"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Text"], 10)}
}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemNumeric()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Numérique"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Numeric"], 10)}
}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemListDictionary()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Liste (Dictionnaire)"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "List (Dictionary)"], 10)}
}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemDate(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Date"], 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemCheckbox()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Case à cocher"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Checkbox"], 10)}
}


function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbAccessLevel_ItemOpenToAll(){return Get_CroesusApp().FindChild("Uid", "ComboBoxItem_2749", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbAccessLevel_ItemReadOnly(){return Get_CroesusApp().FindChild("Uid", "ComboBoxItem_efc4", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbAccessLevel_ItemRestrictedAccess(){return Get_CroesusApp().FindChild("Uid", "ComboBoxItem_4401", 10)}


function Get_WinAddOrEditProfile_GrpProfile_GrpModules(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "GroupBox_8615", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_LblGroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "TextBlock_fd64", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_LblSubgroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "TextBlock_0685", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkClients(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "CheckBox_0f0b", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbClientsGroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_214a", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbClientsSubgroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_5759", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkAccounts(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "CheckBox_89a7", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbAccountsGroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_c956", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbAccountsSubgroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_4ff0", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkRelationships(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "CheckBox_9347", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbRelationshipsGroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_a632", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbRelationshipsSubgroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_9fed", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_ChkSecurities(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "CheckBox_bc10", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbSecuritiesGroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_3a1b", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbSecuritiesSubgroup(){return Get_WinAddOrEditProfile_GrpProfile_GrpModules().FindChild("Uid", "ComboBox_6375", 10)}


function Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn(){return Get_WinAddOrEditProfile_GrpProfile().FindChild("Uid", "GroupBox_fbb6", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn_ChkExportToMSWord(){return Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn().FindChild("Uid", "CheckBox_235e", 10)}

function Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn_ChkSearchCriteria(){return Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn().FindChild("Uid", "CheckBox_4ae2", 10)}


//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//******************** FENÊTRE D'AJOUT/ÉDITION DE CATÉGORIE DE TITRES (SECURITY CATEGORY EDIT WINDOW) *********************
//Tools--> Configurations 
function Get_WinAddSecurityCategorisation(){return Aliases.CroesusApp.winAddSecurityCategorisation}

function Get_WinAddSecurityCategorisationCancel(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "Button_78a8", 10)}

function Get_WinAddSecurityCategorisation_BtnSave(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "Button_ac14", 10)}


function Get_WinAddSecurityCategorisation_GrpDescription(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "GroupBox_ce60", 10)}

function Get_WinAddSecurityCategorisation_GrpDescription_TxtEnglishDescription(){return Get_WinAddSecurityCategorisation_GrpDescription().FindChild("Uid", "TextBox_5932", 10)}

function Get_WinAddSecurityCategorisation_GrpDescription_TxtShortEnglishDesc(){return Get_WinAddSecurityCategorisation_GrpDescription().FindChild("Uid", "TextBox_2b8c", 10)}

function Get_WinAddSecurityCategorisation_GrpDescription_TxtFrenchDescription(){return Get_WinAddSecurityCategorisation_GrpDescription().FindChild("Uid", "TextBox_4709", 10)}

function Get_WinAddSecurityCategorisation_GrpDescription_TxtShortFrenchDesc(){return Get_WinAddSecurityCategorisation_GrpDescription().FindChild("Uid", "TextBox_c35a", 10)}


function Get_WinAddSecurityCategorisation_GrpDefinition(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "GroupBox_0de1", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbYield(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_b46e", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbIntDivFrequency(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_b742", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbFactorSign(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_4773", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbDayCount(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_da6b", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_TxtSettlementDays(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "IntegerTextBox_900f", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbOverwriteInvCost(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_c8c0", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbDefaultCalculationFactor(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_8e31", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbFinancialInstr(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_e719", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbFinancialInstrDetail(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_b1cc", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "IntegerTextBox_e02d", 10)}

function Get_WinAddSecurityCategorisation_GrpDefinition_CmbCreationMonth(){return Get_WinAddSecurityCategorisation_GrpDefinition().FindChild("Uid", "ComboBox_ae8d", 10)}


function Get_WinAddSecurityCategorisation_GrpDisplay(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "GroupBox_b99a", 10)}

function Get_WinAddSecurityCategorisation_GrpDisplay_CmbDisplayFactor(){return Get_WinAddSecurityCategorisation_GrpDisplay().FindChild("Uid", "ComboBox_c360", 10)}

function Get_WinAddSecurityCategorisation_GrpDisplay_CmbNumberOfDecimals(){return Get_WinAddSecurityCategorisation_GrpDisplay().FindChild("Uid", "ComboBox_d5c8", 10)}

function Get_WinAddSecurityCategorisation_GrpDisplay_CmbTradeAs(){return Get_WinAddSecurityCategorisation_GrpDisplay().FindChild("Uid", "ComboBox_0664", 10)}


function Get_WinEditSecurityCategorisation_GrpInitialCondition(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "GroupBox_6da7", 10)}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition(){return Get_WinEditSecurityCategorisation_GrpInitialCondition().FindChild("Uid", "ListBox_3457", 10)}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_BtnDelete(){return Get_WinEditSecurityCategorisation_GrpInitialCondition().FindChild("Uid", "Button_7198", 10)}


function Get_WinEditSecurityCategorisation_GrpSecondaryCondition(){return Get_WinAddSecurityCategorisation().FindChild("Uid", "GroupBox_499b", 10)}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions(){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition().FindChild("Uid", "ListView_af6b", 10)}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions_ChFirstSecurityNo()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Premier no de titre"], 10)}
  else {return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "First Security No"], 10)}
}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions_ChLastSecurityNo()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Dernier no de titre"], 10)}
  else {return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Last Security No"], 10)}
}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions_ChType()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Type"], 10)}
  else {return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Type"], 10)}
}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions_ChSecurityClass()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Classe de titre"], 10)}
  else {return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Security Class"], 10)}
}

function Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions_ChFundCategory()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Catégorie du fonds"], 10)}
  else {return Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["ClrClassName", "WPFControlText"], ["GridViewColumnHeader", "Fund category"], 10)}
}




//DEFINITION DE LA CONDITION INITIALE DANS FENÊTRE D'ÉDITION DE CATÉGORIE DE TITRES(INITIAL CONDITION DEFINITION IN THE SECURITY CATEGORY EDIT WINDOW)

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl(partControlName)//Generic
{
    return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition().FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", partControlName], 10);
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_Item(itemName) //Generic
{
    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", itemName], 10);
}


function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbVerb()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Verbe>")}
  else {return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Verb>")}
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbField()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Champ>")}
  else {return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Field>")}
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbOperator()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Opérateur>")}
  else {return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Operator>")}
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbValue()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Valeur>")}
  else {return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Value>")}
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbNext()
{
  if (language == "french"){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Suivant>")}
  else {return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl("<Next>")}
}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbDot(){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbPartControl(".")}

function Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_ItemDot(){return Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_Item(".")}
//---> fin  MenuTools_Get_functions

//--->  MenuTools_Get_functions
//******************** FENÊTRE CONFIGURATION DE catégorisation des titres(SECURITY CATEGORISATION CONFIGURATION WINDOW) *********************

function Get_WinSecurityCategorisationConfigurations(){return Aliases.CroesusApp.winConfiguratorWindowSecurityCategorisation}

function Get_WinSecurityCategorisationConfigurationsBtnClose(){return Get_WinSecurityCategorisationConfigurations().FindChild("Uid", "Button_f3fc", 10)}

function Get_WinSecurityCategorisationConfigurationsBtnAdd(){return Get_WinSecurityCategorisationConfigurations().FindChild("Uid", "Button_b959", 10)}

function Get_WinSecurityCategorisationConfigurations_BtnEdit(){return Get_WinSecurityCategorisationConfigurations().FindChild("Uid", "Button_33bd", 10)}

function Get_WinSecurityCategorisationConfigurations_BtnDelete(){return Get_WinSecurityCategorisationConfigurations().FindChild("Uid", "Button_dfbb", 10)}
//---> fin  MenuTools_Get_functions

//--->   MenuTools_Get_functions
//******************** ARBORESCENCE DE LA FENÊTRE CONFIGURATION DE catégorisation des titres (SECURITY CATEGORISATION CONFIGURATION WINDOW TREEVIEW) *********************


function Get_WinSecurityCategorisationConfiguration_TvwTreeview(){return Get_WinSecurityCategorisationConfigurations().FindChild("Uid", "TreeView_d454", 10)}

function Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbCurriencies()
{
  if (language == "french"){return Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Devises"], 10)}
  else {return Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Currencies"], 10)}
}

function Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbCash()
{
  if (language == "french"){return Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Encaisse"], 10)}
  else {return Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Cash"], 10)}
}


//    Paramètre :
//        categoryLabel : Nom réduit de la catégorie (exemple : 'Titres de croissance')

function Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbCategory(categoryLabel)
{
    var arrayOfTreeviewItems = Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindAllChildren(["ClrClassName", "IsVisible"], ["TreeViewItem", true]).toArray();
    for (var i in arrayOfTreeviewItems)
        if (arrayOfTreeviewItems[i].WPFObject("categoryLabel").WPFControlText == categoryLabel)
            return arrayOfTreeviewItems[i].WPFObject("categoryLabel");
    
    return Utils.CreateStubObject();
}



//Voir aussi la fonction : Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategoryInCategory(categoryLabel, subcategoryDescription)
function Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(subcategoryDescription)
{
    var arrayOfTreeviewItems = Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindAllChildren(["ClrClassName", "IsVisible"], ["TreeViewItem", true]).toArray();
    for (var i in arrayOfTreeviewItems){
        var categoryLabel = arrayOfTreeviewItems[i].WPFObject("categoryLabel").WPFControlText;
        var objectSubcategoryDescription = Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategoryInCategory(categoryLabel, subcategoryDescription);
        if (objectSubcategoryDescription.Exists)
            return objectSubcategoryDescription;
    }
    
    return Utils.CreateStubObject();;
}




//    Paramètres :
//        categoryLabel : Nom réduit de la catégorie (exemple : 'Titres de croissance')
//        subcategoryDescription : Nom simple ou Nom complet de la sous-catégorie (exemple : 'Actions ordinaires' ou 'Actions ordinaires (650)')
//		
//	Voir aussi la fonction : Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(subcategoryDescription)

function Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategoryInCategory(categoryLabel, subcategoryDescription)
{
	var nbOfDescriptionTextBlocks = (aqString.StrMatches(".+\\b\\(\\d+\\)", subcategoryDescription))? 4: 1;
	
    var categoryLabelObject = Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbCategory(categoryLabel);
    if (!categoryLabelObject.Exists) Log.Message("Security Category label '" + categoryLabel + "' object not found");
    categoryLabelObject.Parent.set_IsExpanded(true);
    var arrayOfCategoryTreeviewItems = categoryLabelObject.Parent.FindAllChildren(["ClrClassName", "IsVisible"], ["TreeViewItem", true]).toArray();
    for (var i in arrayOfCategoryTreeviewItems){
        var currentSubcategoryFullDescription = ""
        for (var textBlockIndex = 1; textBlockIndex <= nbOfDescriptionTextBlocks; textBlockIndex++)
            currentSubcategoryFullDescription += arrayOfCategoryTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["TextBlock", true, textBlockIndex]).WPFControlText;
        
        if (Trim(currentSubcategoryFullDescription) == subcategoryDescription)
            return arrayOfCategoryTreeviewItems[i].FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["TextBlock", true, 1]);
    }
    
    return Utils.CreateStubObject();;
}
//---> fin  MenuTools_Get_functions

//--->  MenuTools_Get_functions
//******************************** FENÊTRE CONFIGURATION DE LA MATRICE DE FRAIS (FEE MATRIX CONFIGURATION WINDOW) ***************************************

function Get_WinFeeMatrixConfiguration(){return Aliases.CroesusApp.winFeeMatrixConfiguration}

function Get_WinFeeMatrixConfiguration_BtnOK(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "Button_811d", 10)}

function Get_WinFeeMatrixConfiguration_BtnCancel(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "Button_807a", 10)}

function Get_WinFeeMatrixConfiguration_BtnEdit(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "Button_25b9", 10)}

function Get_WinFeeMatrixConfiguration_BtnMerge(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "Button_289d", 10)}

function Get_WinFeeMatrixConfiguration_BtnSplit(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "Button_7f40", 10)}

function Get_WinFeeMatrixConfiguration_GrpOptions(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "GroupBox_8192", 10)}

function Get_WinFeeMatrixConfiguration_GrpOptions_LblAccruedID(){return Get_WinFeeMatrixConfiguration_GrpOptions().FindChild("Uid", "TextBlock_bc88", 10)}

function Get_WinFeeMatrixConfiguration_GrpOptions_CmbAccruedID(){return Get_WinFeeMatrixConfiguration_GrpOptions().FindChild("Uid", "ComboBox_9e6b", 10)}

function Get_WinFeeMatrixConfiguration_GrpMinimumFees(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "GroupBox_0b37", 10)}
//
//function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblMonthly()
//{
//  if (language == "french"){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Mensuelle:"], 10)}
//  else {return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Monthly:"], 10)}
//}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblMonthly(){return Get_WinFeeMatrixConfiguration().FindChild("WPFControlAutomationId", "TextBlock_967a_0", 10)}
//function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtMonthly(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", "1"], 10)}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtMonthly(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "DoubleTextBox_6d48_0", 10)}
///*function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblQuarterly()
//{
//  if (language == "french"){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Trimestrielle:"], 10)}
//  else {return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Quarterly:"], 10)}
//}

function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblQuarterly(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "TextBlock_967a_1", 10)}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtQuarterly(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "DoubleTextBox_6d48_1", 10)}


//  function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtQuarterly(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", "2"], 10)}

//function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblSemiannual()
//{
//  if (language == "french"){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Semestrielle:"], 10)}
//  else {return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Semiannual:"], 10)}
//}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblSemiannual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "TextBlock_967a_2", 10)}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtSemiannual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "DoubleTextBox_6d48_2", 10)}
//  function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtSemiannual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", "3"], 10)}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblAnnual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "TextBlock_967a_3", 10)}
function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtAnnual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild("WPFControlAutomationId", "DoubleTextBox_6d48_3", 10)}

//function Get_WinFeeMatrixConfiguration_GrpMinimumFees_LblAnnual()
//{
//  if (language == "french"){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Annuelle:"], 10)}
//  else {return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Annual:"], 10)}
//}

//  function Get_WinFeeMatrixConfiguration_GrpMinimumFees_TxtAnnual(){return Get_WinFeeMatrixConfiguration_GrpMinimumFees().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", "4"], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix(){return Get_WinFeeMatrixConfiguration().FindChild("Uid", "DataGrid_b3a1", 10)}


//***** En-têtes de colonne de la matrice de frais (Fee Matrix column headers) *****

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChTotalValue(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 1], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCash(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 2], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCashMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 3], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCashMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 4], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMediumTerm(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 5], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMediumTermMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 6], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMediumTermMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 7], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChLongTerm(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 8], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChLongTermMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 9], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChLongTermMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 10], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOtherFixedIncome(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 11], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOtherFixedIncomeMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 12], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOtherFixedIncomeMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 13], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCAEquity(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 14], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCAEquityMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 15], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChCAEquityMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 16], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChUSEquity(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 17], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChUSEquityMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 18], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChUSEquityMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 19], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChForeignEquity(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 20], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChForeignEquityMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 21], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChForeignEquityMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 22], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMutualFund(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 23], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMutualFundMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 24], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChMutualFundMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 25], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOthers(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 26], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOthersMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 27], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChOthersMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 28], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChFixedIntervals(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 29], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChFixedIntervalsMin(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 30], 10)}

function Get_WinFeeMatrixConfiguration_DgvFeeMatrix_ChFixedIntervalsMax(){return Get_WinFeeMatrixConfiguration_DgvFeeMatrix().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", 31], 10)}
//---> fin  MenuTools_Get_functions


//--->   MenuTools_Get_functions
//******************************** FENÊTRE MODIFIER UNE VALEUR (EDIT FEE MATRIX RANGE WINDOW) ***************************************
//Tools/Configurations/Billing
function Get_WinEditRange(){return Aliases.CroesusApp.winEditRange}

function Get_WinEditRange_BtnOK(){return Get_WinEditRange().FindChild("Uid", "Button_0a82", 10)}

function Get_WinEditRange_BtnCancel(){return Get_WinEditRange().FindChild("Uid", "Button_beda", 10)}

function Get_WinEditRange_LblMessage(){return Get_WinEditRange().FindChild("Uid", "TextBlock_002c", 10)}

function Get_WinEditRange_LblMinimum(){return Get_WinEditRange().FindChild("Uid", "TextBlock_6b83", 10)}

function Get_WinEditRange_TxtMinimum(){return Get_WinEditRange().FindChild("Uid", "DoubleTextBox_8dba", 10)}

function Get_WinEditRange_LblMaximum(){return Get_WinEditRange().FindChild("Uid", "TextBlock_8fbd", 10)}

function Get_WinEditRange_TxtMaximum(){return Get_WinEditRange().FindChild("Uid", "DoubleTextBox_a5bc", 10)}



//************ BOITE DE DIALOGUE FUSIONNER UN INTERVALLE DE LA GRILLE DE VALIDATION (MERGE VALIDATION GRID RANGE DIALOG BOX) *************

function Get_DlgMergeValidationGridRange(){return Aliases.CroesusApp.dlgMergeValidationGridRange}

function Get_DlgMergeValidationGridRange_LblMessage(){return Get_DlgMergeValidationGridRange().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "1"], 10)}

//******************************** FENÊTRE AJOUTER UNE VALEUR (ADD FEE MATRIX RANGE WINDOW) ***************************************

function Get_WinAddRange(){return Aliases.CroesusApp.winAddRange}

function Get_WinAddRange_BtnOK(){return Get_WinAddRange().FindChild("Uid", "Button_b71c", 10)}

function Get_WinAddRange_BtnCancel(){return Get_WinAddRange().FindChild("Uid", "Button_c380", 10)}

function Get_WinAddRange_LblSplitRangeAt(){return Get_WinAddRange().FindChild("Uid", "TextBlock_1f44", 10)}

function Get_WinAddRange_TxtSplitRangeAt(){return Get_WinAddRange().FindChild("Uid", "DoubleTextBox_31a6", 10)}

function Get_WinAddRange_LblMessage(){return Get_WinAddRange().FindChild("Uid", "TextBlock_150e", 10)}



//******************************** FENÊTRE CONFIGURATION DE LA FACTURATION (BILLING CONFIGURATION WINDOW) *********************************

function Get_WinBillingConfiguration(){return Aliases.CroesusApp.winBillingConfiguration}

function Get_WinBillingConfiguration_BtnOK(){return Get_WinBillingConfiguration().FindChild("Uid", "Button_30b2", 10)}

function Get_WinBillingConfiguration_BtnCancel(){return Get_WinBillingConfiguration().FindChild("Uid", "Button_36bf", 10)}


function Get_WinBillingConfiguration_TabFeeSchedule(){return Get_WinBillingConfiguration().FindChild("Uid", "TabItem_be16", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_DgvFeeTemplateManager(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "DataGrid_9a9f", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "Button_cc8f", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_BtnEdit(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "Button_3670", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_BtnCopy(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "Button_7eaa", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_BtnDelete(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "Button_9ba4", 10)}

function Get_WinBillingConfiguration_TabFeeSchedule_BtnMigrate(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "FeeTemplateManagerPage_569c", 10).FindChild("Uid", "Button_7d3d", 10)}


function Get_WinBillingConfiguration_TabValidationGrid(){return Get_WinBillingConfiguration().FindChild("Uid", "TabItem_7b14", 10)}

function Get_WinBillingConfiguration_TabValidationGrid_DgvFeeMatrix(){return Get_WinBillingConfiguration().FindChild("Uid", "TabControl_89b4", 10).FindChild("Uid", "DataGrid_b3a1", 10)}
//---> fin  MenuTools_Get_functions

//---> MenuTools_Get_functions
//******************************** FENÊTRE MISE À JOUR DU MODÈLE DE FRAIS (FEE TEMPLATE EDIT WINDOW) *********************************

function Get_WinFeeTemplateEdit(){return Aliases.CroesusApp.winFeeTemplateEdit}

function Get_WinFeeTemplateEdit_BtnOK(){return Get_WinFeeTemplateEdit().FindChild("Uid", "Button_80be", 10)}

function Get_WinFeeTemplateEdit_BtnCancel(){return Get_WinFeeTemplateEdit().FindChild("Uid", "Button_30b5", 10)}

function Get_WinFeeTemplateEdit_LblName(){return Get_WinFeeTemplateEdit().FindChild("Uid", "TextBlock_1a66", 10)}

function Get_WinFeeTemplateEdit_TxtName(){return Get_WinFeeTemplateEdit().FindChild("Uid", "LocaleTextbox_4095", 10)}

function Get_WinFeeTemplateEdit_LblAccess(){return Get_WinFeeTemplateEdit().FindChild("Uid", "TextBlock_3869", 10)}

function Get_WinFeeTemplateEdit_CmbAccess(){return Get_WinFeeTemplateEdit().FindChild("Uid", "PartyLevelComboBox_03e9", 10)}

function Get_WinFeeTemplateEdit_LblRatePattern(){return Get_WinFeeTemplateEdit().FindChild("Uid", "TextBlock_17c6", 10)}

function Get_WinFeeTemplateEdit_CmbRatePattern(){return Get_WinFeeTemplateEdit().FindChild("Uid", "ComboBox_1941", 10)}

function Get_WinFeeTemplateEdit_ChkTieredCalculationMethod(){return Get_WinFeeTemplateEdit().FindChild("Uid", "CheckBox_bb4c", 10)}

function Get_WinFeeTemplateEdit_ChkShowMinMax(){return Get_WinFeeTemplateEdit().FindChild("Uid", "CheckBox_dd31", 10)}

function Get_WinFeeTemplateEdit_DgvFeeTemplate(){return Get_WinFeeTemplateEdit().FindChild("Uid", "DataGrid_611f", 10)}



//************ BOITE DE DIALOGUE FACTURATION (BILLING DIALOG BOX) *************

function Get_DlgBilling(){return Aliases.CroesusApp.dlgBilling}

function Get_DlgBilling_LblMessage(){return Get_DlgBilling().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "1"], 10)}

//************ BOITE DE DIALOGUE CONFIGURATION DE LA FACTURATION (BILLING CONFIGURATION DIALOG BOX) *************

function Get_DlgBillingConfiguration(){return Aliases.CroesusApp.dlgBillingConfiguration}

function Get_DlgBillingConfiguration_LblMessage(){return Get_DlgBillingConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFTextBlock", "1"], 10)}



//*** FENÊTRE DE MIGRATION DU MODÈLE DE FRAIS FENÊTRE CONVERTIR LA GRILLE DE VALIDATION (FEE TEMPLATE MIGRATION WINDOW - MIGRATE VALIDATION GRID WINDOW) ***

function Get_WinFeeTemplateMigration(){return Aliases.CroesusApp.winFeeTemplateMigration}

function Get_WinFeeTemplateMigration_BtnOK(){return Get_WinFeeTemplateMigration().FindChild("Uid", "Button_8cbe", 10)}

function Get_WinFeeTemplateMigration_BtnCancel(){return Get_WinFeeTemplateMigration().FindChild("Uid", "Button_7a82", 10)}


function Get_WinFeeTemplateMigration_GrpOutdatedGrid(){return Get_WinFeeTemplateMigration().FindChild("Uid", "GroupBox_38b7", 10)}

function Get_WinFeeTemplateMigration_GrpOutdatedGrid_ChkShowMinMax(){return Get_WinFeeTemplateMigration().FindChild("Uid", "CheckBox_4883", 10)}

function Get_WinFeeTemplateMigration_GrpOutdatedGrid_DgvOutdatedFeeTemplate(){return Get_WinFeeTemplateMigration_GrpOutdatedGrid().FindChild("Uid", "DataGrid_611f", 10)}


function Get_WinFeeTemplateMigration_GrpCurrentGrid(){return Get_WinFeeTemplateMigration().FindChild("Uid", "GroupBox_2b72", 10)}

function Get_WinFeeTemplateMigration_GrpCurrentGrid_ChkShowMinMax(){return Get_WinFeeTemplateMigration().FindChild("Uid", "CheckBox_134c", 10)}

function Get_WinFeeTemplateMigration_GrpCurrentGrid_DgvFeeTemplate(){return Get_WinFeeTemplateMigration_GrpCurrentGrid().FindChild("Uid", "DataGrid_611f", 10)}
//---> fin  MenuTools_Get_functions
*/
//--> Relations_Get_Functions [Edit-->Add-->Join existe seulement dans le module Relation]
//******************************** FENÊTRE ASSOCIER À UNE RELATION (ASSIGN TO A RELATIONSHIP WINDOW) ***************************************

function Get_WinAssignToARelationship(){return Aliases.CroesusApp.winAssignToARelationship}

function Get_WinAssignToARelationship_BtnYes(){return Get_WinAssignToARelationship().FindChild("Uid", "Button_d383", 10)}

function Get_WinAssignToARelationship_BtnNo(){return Get_WinAssignToARelationship().FindChild("Uid", "Button_2a58", 10)}

function Get_WinAssignToARelationship_BtnOk(){return Get_WinAssignToARelationship().FindChild("Uid", "Button_0d81", 10)}

function Get_WinAssignToARelationship_LblQuestion(){return Get_WinAssignToARelationship().FindChild("Uid", "Label_cc2d", 10)}

function Get_WinAssignToARelationship_DgvAccountsList(){return Get_WinAssignToARelationship().FindChild("Uid", "DataGrid_1e6a", 10)}

function Get_WinAssignToARelationship_DgvAccountsList_ChCheckbox(){return Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", ""], 10)}

function Get_WinAssignToARelationship_DgvAccountsList_ChConflict()
{
  if (language == "french"){return Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Conflit"], 10)}
  else {return Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Conflict"], 10)}
}

function Get_WinAssignToARelationship_DgvAccountsList_ChName()
{
  if (language == "french"){return Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom"], 10)}
  else {return Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Name"], 10)}
}

function Get_WinAssignToARelationship_DgvAccountsList_ChNumber()
{
  if (language == "french"){return Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Numéro"], 10)}
  else {return Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Number"], 10)}
}

function Get_WinAssignToARelationship_DgvAccountsList_ChReasonOfConflict()
{
  if (language == "french"){return Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Raison du conflit"], 10)}
  else {return Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Reason of Conflict"], 10)}
}

//--> fin Relations_Get_Functions
/*
//-->  MenuTools_Get_Functions
//**************************************** FENÊTRE AJOUTER UN FICHIER (ADD A FILE WINDOW) ********************************************
//Tools-->Archive me Documents --> icone Add
function Get_WinAddAFile(){return Aliases.CroesusApp.winAddAFile}

function Get_WinAddAFile_GrpFile(){return Get_WinAddAFile().FindChild("Uid", "GroupBox_e74d", 10)}

function Get_WinAddAFile_GrpFile_TxtFilePath(){return Get_WinAddAFile_GrpFile().FindChild("Uid", "TextBox_d91c", 10)}

function Get_WinAddAFile_GrpFile_BtnBrowse(){return Get_WinAddAFile_GrpFile().FindChild("Uid", "Button_c96e", 10)}

function Get_WinAddAFile_GrpComments(){return Get_WinAddAFile().FindChild("Uid", "GroupBox_e2dc", 10)}

function Get_WinAddAFile_GrpComments_TxtComments(){return Get_WinAddAFile_GrpComments().FindChild("Uid", "TextBox_e3f6", 10)}

function Get_WinAddAFile_BtnOK(){return Get_WinAddAFile().FindChild("Uid", "Button_a77f", 10)}

function Get_WinAddAFile_BtnCancel(){return Get_WinAddAFile().FindChild("Uid", "Button_1dd6", 10)}
//--> fin  MenuTools_Get_Functions
*/
/*
//--> fin  MenuEdit_Get_Functions
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

function Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem_TvwMyObjectives_TvwMyObjectivesItem(myAssetAllocationsItemName, myObjectivesItemName){return Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem_TvwMyObjectives(myAssetAllocationsItemName).FindChild(["ClrClassName", "IsVisible", "DataContext.Text"], ["TreeViewItem", true, myObjectivesItemName])}
//--> fin  MenuEdit_Get_Functions
*/

//************************************ CONTEXTUAL MENU ON ANY WINDOW (MENU CONTEXTUEL SUR N'IMPORTE QUELLE FENÊTRE) ********************************

function Get_Win_ContextualMenu_Edit()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "_Modifier"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "_Edit"], 10)}
}

function Get_Win_ContextualMenu_Copy()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Co*pier"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "*Copy"], 10)}
}

function Get_Win_ContextualMenu_CopyWithHeader()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Cop*ier avec en-tête"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Copy with *Header"], 10)}
}

function Get_Win_ContextualMenu_ExportToFile()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "E*xporter vers *fichier..."], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "E*xport to *File..."], 10)}
}

function Get_Win_ContextualMenu_ExportToMSExcel()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Exporter vers *MS Excel..."], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "Export to *MS Excel..."], 10)}
}

function Get_Win_ContextualMenu_Print()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "*Imprimer..."], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["*MenuItem", "*Print..."], 10)}
}

function Get_Win_ContextualMenu_Help()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Aide"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Help"], 10)}
}

function Get_Win_ContextualMenu_Help_ContextSensitiveHelp()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Aide contextuelle"], 10, true, -1)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Context-Sensitive Help"], 10, true, -1)}
}

function Get_Win_ContextualMenu_Help_ContentsAndIndex()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Sommaire et index"], 10, true, -1)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["MenuItem", "Contents and Index"], 10, true, -1)}
}


function Get_Win_ContextualMenu_Help2()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Aide"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "_Help"], 10)}
}

function Get_Win_ContextualMenu_Help_ContextSensitiveHelp2()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Aide contextuelle"], 10, true, -1)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Context-Sensitive Help"], 10, true, -1)}
}

function Get_Win_ContextualMenu_Help_ContentsAndIndex2()
{
  if (language == "french"){return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Sommaire et index"], 10, true, -1)}
  else {return Get_CroesusApp().FindChildEx(["ClrClassName", "WPFControlText"], ["CFMenuItem", "Contents and Index"], 10, true, -1)}
}

function Get_Win_ContextualMenu_Print2()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Imprimer..."], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["CFMenuItem", "_Print..."], 10)}
}


function Get_HelpWindow_Title(vServer){
    //return Sys.Browser("iexplore").Page(vServer + "crweb/help/croesus*").Frame(0).Frame("topic").TextNode(1)//SA:Pour l'aide en ligne de la fenêtre ajouter une adresse il manque le bout: Frame("Fenêtre_principale") entre Frame("topic"). et .TextNode(1)
    return Sys.Browser("iexplore").Page(vServer + "crweb/help/croesus*").Panel("body").Panel("contentBody").Panel("contentBodyInner").Frame("topic").Panel(0).Panel(0).Table(0).Cell(0, 1).TextNode(0) //EM : Modifié depuis CO-90-07-23
  }
function Get_HelpWindow_Welcome(vServer){
	return Sys.Browser("iexplore").Page(vServer + "crweb/help/croesus*").Panel("body").Panel("contentBody").Panel("contentBodyInner").Frame("topic").Table(0).Cell(0, 0).TextNode(0) //EM : Modifié depuis CO-90-07-23
}
/*

//-->   MenuEdit_Get_Functions
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

*/
/*
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
//  /*
//  if (language == "french"){return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Graphiques (maximum 2)"], 10)}
//  else {return Get_WinParameters().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Graphs (Maximum 2)"], 10)}
//  
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

function Get_WinParameters_GrpRiskMeasurement_ChkPerformantrBravo
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
  if (language == "french"){return Get_WinParameters_GrpStatus().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Déclenchée"], 10)}
  else {return Get_WinParameters_GrpStatus().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Triggered"], 10)}
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
*/


//---> ????Menu Reports_Get_Functions
//********************************** FENÊTRE SUCCURSALES (BRANCHES WINDOW) *******************************************

function Get_WinBranches(){return Aliases.CroesusApp.winBranches}

function Get_WinBranches_BtnOK(){return Get_WinBranches().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinBranches_BtnCancel()
{
  if (language == "french"){return Get_WinBranches().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinBranches().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinBranches_LblSearch()
{
  if (language == "french"){return Get_WinBranches().FindChild(["ClrClassName", "Text"], ["UniLabel", "Recherche:"], 10)}
  else {return Get_WinBranches().FindChild(["ClrClassName", "Text"], ["UniLabel", "Search:"], 10)}
}

function Get_WinBranches_TxtSearch(){return Get_WinBranches().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 10)}

function Get_WinBranches_BtnMoveUp(){return Get_WinBranches().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 1], 10)}

function Get_WinBranches_BtnMoveDown(){return Get_WinBranches().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 2], 10)}

function Get_WinBranches_BtnAddAllBranches(){return Get_WinBranches().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 3], 10)}

function Get_WinBranches_BtnAddABranch(){return Get_WinBranches().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 4], 10)}

function Get_WinBranches_BtnRemoveABranch(){return Get_WinBranches().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 5], 10)}

function Get_WinBranches_BtnRemoveAllBranches(){return Get_WinBranches().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 6], 10)}//
//---> fin ???Menu Reports_Get_Functions

//---> ???Menu Reports_Get_Functions
//********************************** FENÊTRE CONSEILLERS EN PLACEMENT (INVESTMENT ADVISORS WINDOW) *******************************************

function Get_WinInvestmentAdvisors(){return Aliases.CroesusApp.winInvestmentAdvisors}

function Get_WinInvestmentAdvisors_BtnOK(){return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinInvestmentAdvisors_BtnCancel()
{
  if (language == "french"){return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinInvestmentAdvisors_LblSearch()
{
  if (language == "french"){return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "Text"], ["UniLabel", "Recherche:"], 10)}
  else {return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "Text"], ["UniLabel", "Search:"], 10)}
}

function Get_WinInvestmentAdvisors_TxtSearch(){return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", 1], 10)}

function Get_WinInvestmentAdvisors_BtnMoveUp(){return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 1], 10)}

function Get_WinInvestmentAdvisors_BtnMoveDown(){return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 2], 10)}

function Get_WinInvestmentAdvisors_BtnAddAllInvestmentAdvisors(){return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 3], 10)}

function Get_WinInvestmentAdvisors_BtnAddInvestmentAdvisor(){return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 4], 10)}

function Get_WinInvestmentAdvisors_BtnRemoveInvestmentAdvisor(){return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 5], 10)}

function Get_WinInvestmentAdvisors_BtnRemoveAllInvestmentAdvisors(){return Get_WinInvestmentAdvisors().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", 6], 10)}

//--->fin  ???Menu Reports_Get_Functions

//**************************** SAVE AS DIALOG BOX ****************************

function Get_DlgSaveAs(){
    if (language == "french")
        return Sys.FindChild(["WndCaption","WndClass"], ["Enregistrer sous","#32770"], 10)
    else
        return Sys.FindChild(["WndCaption","WndClass"], ["Save As","#32770"], 10)
}

function Get_DlgSaveAs_CmbFileName(){return Get_DlgSaveAs().FindChild(["WndClass", "Index"], ["ComboBox", "1"], 10)}

function Get_DlgSaveAs_BtnSave(){
    if (language == "french")
        return Get_DlgSaveAs().FindChild(["WndClass", "WndCaption"], ["Button", "&Enregistrer"], 10)
    else
        return Get_DlgSaveAs().FindChild(["WndClass", "WndCaption"], ["Button", "&Save"], 10)
}

function Get_DlgSaveAs_BtnCancel(){
    if (language == "french")
        return Get_DlgSaveAs().FindChild(["WndClass", "WndCaption"], ["Button", "Annuler"], 10)
    else
        return Get_DlgSaveAs().FindChild(["WndClass", "WndCaption"], ["Button", "Cancel"], 10)
}



//**************************** ACROBAT READER - SAVE AS DIALOG BOX ****************************

function GetAcrobatReaderDlgSaveAsLanguage(){
    var acrobatProcessName = GetAcrobatProcessName();
    if (Sys.WaitProcess(acrobatProcessName, 3000, 1).Exists){
        if (Sys.WaitProcess(acrobatProcessName, 0, 1).FindChild(["WndCaption","WndClass"], ["Save As","#32770"], 10).Exists)
            return "english";
        
        if (Sys.WaitProcess(acrobatProcessName, 0, 1).FindChild(["WndCaption","WndClass"], ["Enregistrer sous","#32770"], 10).Exists)
            return "french";
    }
    
    return null;
}

function Get_AcrobatReader_DlgSaveAs(){
    var acrobatProcessName = GetAcrobatProcessName();
    if (GetAcrobatReaderDlgSaveAsLanguage() == "french")
        return Sys.WaitProcess(acrobatProcessName, 0, 1).FindChild(["WndCaption","WndClass"], ["Enregistrer sous","#32770"], 10)
    else
        return Sys.WaitProcess(acrobatProcessName, 0, 1).FindChild(["WndCaption","WndClass"], ["Save As","#32770"], 10)
}

function Get_AcrobatReader_DlgSaveAs_CmbFileName(){return Get_AcrobatReader_DlgSaveAs().FindChild(["WndClass", "Index"], ["ComboBox", "1"], 10)}

function Get_AcrobatReader_DlgSaveAs_BtnSave(){
    if (typeof WINDOWS_DISPLAY_LANGUAGE == 'undefined' || WINDOWS_DISPLAY_LANGUAGE == null)
        Log.Warning("Il est nécessaire d'exécuter, préalablement, la fonction 'Common_functions.GetWindowsDisplayLanguage()' pour renseigner la langue d'affichage de Windows (cf. variable WINDOWS_DISPLAY_LANGUAGE) car le bouton 'Enregistrer' de la boîte de dialogue 'Enregistrer sous' s'affiche dans cette langue. Cette fonction s'exécute systématiquement dans Login, SaveAs_AcrobatReader.");
    
    if (typeof WINDOWS_DISPLAY_LANGUAGE != 'undefined' && WINDOWS_DISPLAY_LANGUAGE == "french")
        return Get_AcrobatReader_DlgSaveAs().FindChild(["WndClass", "WndCaption"], ["Button", "&Enregistrer"], 10)
    else
        return Get_AcrobatReader_DlgSaveAs().FindChild(["WndClass", "WndCaption"], ["Button", "&Save"], 10)
}

function Get_AcrobatReader_DlgSaveAs_BtnCancel(){
    if (typeof WINDOWS_DISPLAY_LANGUAGE == 'undefined' || WINDOWS_DISPLAY_LANGUAGE == null)
        Log.Warning("Il est nécessaire d'exécuter, préalablement, la fonction 'Common_functions.GetWindowsDisplayLanguage()' pour renseigner la langue d'affichage de Windows (cf. variable WINDOWS_DISPLAY_LANGUAGE) car le bouton 'Enregistrer' de la boîte de dialogue 'Enregistrer sous' s'affiche dans cette langue. Cette fonction s'exécute systématiquement dans Login, SaveAs_AcrobatReader.");
    
    if (typeof WINDOWS_DISPLAY_LANGUAGE != 'undefined' && WINDOWS_DISPLAY_LANGUAGE == "french")
        return Get_AcrobatReader_DlgSaveAs().FindChild(["WndClass", "WndCaption"], ["Button", "Annuler"], 10)
    else
        return Get_AcrobatReader_DlgSaveAs().FindChild(["WndClass", "WndCaption"], ["Button", "Cancel"], 10)
}



//*************************** BOÎTE DE DIALOGUE STATUT D'IMPRESSION / MESSAGES (PRINTING STATUS / MESSAGE LOGS DIALOG BOX) ******************************

function Get_DlgPrintingStatusMessageLogs(){return Aliases.CroesusApp.dlgPrintingStatusMessageLogs}

function Get_DlgPrintingStatusMessageLogs_LblProducingTheRequestedReports()
{
  if (language == "french"){return Get_DlgPrintingStatusMessageLogs().FindChild(["ClrClassName", "Text"], ["UniLabel", "Production des rapports en cours..."], 10)}
  else {return Get_DlgPrintingStatusMessageLogs().FindChild(["ClrClassName", "Text"], ["UniLabel", "Producing the requested reports..."], 10)}
}

function Get_DlgPrintingStatusMessageLogs_LblStartedOn(){return Get_DlgPrintingStatusMessageLogs().FindChild("Uid", "TextBlock_3cf0", 10)}

function Get_DlgPrintingStatusMessageLogs_TxtStartedOn(){return Get_DlgPrintingStatusMessageLogs().FindChild("Uid", "TextBlock_2e11", 10)}

function Get_DlgPrintingStatusMessageLogs_TxtMessage(){return Get_DlgPrintingStatusMessageLogs().FindChild("Uid", "TextBlock_017a", 10)}

function Get_DlgPrintingStatusMessageLogs_TxtMessageReportError()
{
  var reportErrorMessage = (language == "french")? "Erreur": "Error";
  return Get_DlgPrintingStatusMessageLogs_TxtMessage().Find(["WPFControlText", "IsVisible"], [reportErrorMessage, true]);
}

function Get_DlgPrintingStatusMessageLogs_TxtMessageReportNoData()
{
  var reportNoDataMessage = (language == "french")? "* aucune donnée. ": "* did not contain data. ";
  return Get_DlgPrintingStatusMessageLogs_TxtMessage().Find(["WPFControlText", "IsVisible"], [reportNoDataMessage, true], 10);
}

function Get_DlgPrintingStatusMessageLogs_BtnCancel(){return Get_DlgPrintingStatusMessageLogs().FindChild("Uid", "Button_e037", 10)}

function Get_DlgPrintingStatusMessageLogs_BtnOK(){return Get_DlgPrintingStatusMessageLogs().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}



//*************************************************** CALENDRIER (CALENDAR)************************************************

function Get_WinCalendar(){return Aliases.CroesusApp.winCalendar}

function Get_WinCalendar_BtnOK(){return Get_WinCalendar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinCalendar_BtnCancel()
{
  if (language == "french"){return Get_WinCalendar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinCalendar().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinCalendar_LstYears(){return Get_WinCalendar().FindChild("Uid", "ListBox_ee5c", 10)}

function Get_WinCalendar_LstYears_Item(yearNumber){return Get_WinCalendar_LstYears().FindChild(["ClrClassName", "DataContext.OleValue"], ["ListBoxItem", yearNumber], 10)}

function Get_WinCalendar_LstMonths(){return Get_WinCalendar().FindChild("Uid", "ListBox_ac36", 10)}

function Get_WinCalendar_LstMonths_Item(monthNameInFrench, monthNameInEnglish)
{
  if (language == "french"){return Get_WinCalendar_LstMonths().FindChild(["ClrClassName", "DataContext.MonthName"], ["ListBoxItem", monthNameInFrench], 10)}
  else {return Get_WinCalendar_LstMonths().FindChild(["ClrClassName", "DataContext.MonthName"], ["ListBoxItem", monthNameInEnglish], 10)}
}

function Get_WinCalendar_LstDays(){return Get_WinCalendar().FindChild("Uid", "ListBox_2f71", 10)}

function Get_WinCalendar_LstDays_Item(dayNumber){return Get_WinCalendar_LstDays().FindChild(["ClrClassName", "IsEnabled", "WPFControlText"], ["TextBlock", true, dayNumber], 10)}



//******************************************** FENÊTRE MESSAGE (MESSAGE WINDOW) *******************************************

function Get_WinMessage(){return Aliases.CroesusApp.winMessage}

function Get_WinMessage_LblLanguage()
{
  if (language == "french"){return Get_WinMessage().FindChild(["ClrClassName", "Text"], ["UniLabel", "Langue:"], 10)}
  else {return Get_WinMessage().FindChild(["ClrClassName", "Text"], ["UniLabel", "Language:"], 10)}
}

function Get_WinMessage_CmbLanguage(){return Get_WinMessage().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinMessage_TxtMessage(){return Get_WinMessage().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextArea", "1"], 10)}

function Get_WinMessage_LblWarningMessage(){return Get_WinMessage().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinMessage_BtnOK(){return Get_WinMessage().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinMessage_BtnCancel()
{
  if (language == "french"){return Get_WinMessage().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinMessage().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}



/**************************************** FENÊTRE CONFIGURATION DES PROFILS VISIBLES (VISIBLE PROFILES CONFIGURATION WINDOW) *****************************************/

function Get_WinVisibleProfilesConfiguration(){return Aliases.CroesusApp.winVisibleProfilesConfiguration}

function Get_WinVisibleProfilesConfiguration_BtnSave(){return Get_WinVisibleProfilesConfiguration().FindChild("Uid", "Button_0af0", 10)}

function Get_WinVisibleProfilesConfiguration_BtnCancel(){return Get_WinVisibleProfilesConfiguration().FindChild("Uid", "Button_1f28", 10)}

function Get_WinVisibleProfilesConfiguration_DefaultExpander()
{
    if (client == "RJ" || client == "US" || client == "TD" || client == "CIBC"){return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10)}
    else {return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "4"], 10)}
}
/*
function Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkLanguage() //Pour la fenêtre "Configuration des profils visibles" de Relations
{
    if (client == "RJ" || client == "US" || client == "TD"){return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "9"], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100)}
    else {return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "8"], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100)}
}*/

function Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkLanguage() //Pour la fenêtre "Configuration des profils visibles" de Relations
{   
    var indice = 8;
    if (client == "CIBC") indice = 10;
    else
      if (client == "RJ" || client == "US" || client == "TD") indice = 9;
    return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", indice], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100);
}
/*
function Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkEmployer() //Pour la fenêtre "Configuration des profils visibles" de Relations
{
    if (client == "RJ" || client == "US" || client == "TD"){return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "6"], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100)}
    else {return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "5"], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100)}
}
*/
function Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkEmployer() //Pour la fenêtre "Configuration des profils visibles" de Relations
{
    var indice = 5;
    if (client == "CIBC") indice = 7;
    else
      if (client == "RJ" || client == "US" || client == "TD") indice = 6;
    return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", indice], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100);
} 
 
function Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkCommission() //Pour la fenêtre "Configuration des profils visibles" de Relations
{
    if (client == "RJ" || client == "US" || client == "TD" || client == "CIBC"){return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100)}
    else {return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100)}
}

function Get_WinVisibleProfilesConfiguration_DefaultExpander_ChkHENRY() //Pour la fenêtre "Configuration des profils visibles" de Relations
{
   return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "4"], 100).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100)
}

function Get_WinVisibleProfilesConfiguration_CaroleAccountExpander(){return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10)}

function Get_WinVisibleProfilesConfiguration_CaroleAccountExpander_SgAccount(){return Get_WinVisibleProfilesConfiguration_CaroleAccountExpander().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10)}

function Get_WinVisibleProfilesConfiguration_CaroleAccountExpander_SgAccount_ChkFeuille(){return Get_WinVisibleProfilesConfiguration_CaroleAccountExpander_SgAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 10)}

function Get_WinVisibleProfilesConfiguration_CaroleAccountExpander_SgAccount_ChkFleur(){return Get_WinVisibleProfilesConfiguration_CaroleAccountExpander_SgAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "2"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 10)}

function Get_WinVisibleProfilesConfiguration_ChkProfile(profileText)
{
    //D'abord trouver le composant du nom du profil
    Get_WinVisibleProfilesConfiguration().Click();
    Sys.Keys("[End][End][End]");
    
    var arrayOfUpperGrids = Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindAllChildren("ClrClassName", "DataRecordPresenter").toArray();
    var arrayOfUpperGridsIndexes = new Array();
    for (var j = 0; j < arrayOfUpperGrids.length; j++)
        arrayOfUpperGridsIndexes.push(arrayOfUpperGrids[j].WPFControlOrdinalNo);
    
    var isWholeWindowVisited = false;
    var profileTextObject = null;
    while (!isWholeWindowVisited){
        profileTextObject = Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "DisplayText", "VisibleOnScreen"], ["XamTextEditor", profileText, true], 100);
        if (profileTextObject != null && profileTextObject.Exists)
            break;
        
        for (var j = 0; j < arrayOfUpperGrids.length; j++){
            var gridVisibleTitle = arrayOfUpperGrids[j].FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordCellArea", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).FindChild(["ClrClassName", "VisibleOnScreen"], ["XamTextEditor", true]);
            if (gridVisibleTitle.Exists)
                arrayOfUpperGridsIndexes.splice(arrayOfUpperGridsIndexes.indexOf(arrayOfUpperGrids[j].WPFControlOrdinalNo), 1);
        }
        
        isWholeWindowVisited = (arrayOfUpperGridsIndexes.length == 0);
        Sys.Keys("[PageUp]");
    }
    
    if (profileTextObject == null || !profileTextObject.Exists){
        Log.Message("Profile '" + profileText + "' was not found.");
        return Utils.CreateStubObject();
    }
    
    //Trouver la case à cocher
    var maxNbOfParents = 20;
    var parentObject = profileTextObject;
    for (var j = 1 ; j <= maxNbOfParents; j++){
        parentObject = parentObject.Parent;
        if (parentObject.ClrClassName == "DataRecordPresenter"){
            var profileCheckbox = parentObject.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", 1], 10);
            if (profileCheckbox.Exists)
                break;
        }
    }
    
    if (!profileCheckbox.Exists)
        Log.Error("Profile '" + profileText + "' was found but the related checkbox was not found, this is unexpected."); 
    
    return profileCheckbox;
}



//********************************************** FENÊTRE CONFIGURATION DES PRODUITS (PRODUCT SETUP WINDOW) **********************************************

function Get_WinProductSetup(){return Aliases.CroesusApp.winProductSetup}

function Get_WinProductSetup_BtnOK(){return Get_WinProductSetup().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinProductSetup_BtnCancel()
{
  if (language == "french"){return Get_WinProductSetup().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinProductSetup().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinProductSetup_ChkProduct(productFrenchName, productEnglishName)
{
  if (language == "french"){return Get_WinProductSetup().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", productFrenchName], 10)}
  else {return Get_WinProductSetup().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", productEnglishName], 10)}
}



//********************************************** FENÊTRE CONFIGURATION DES SERVICES (SERVICE SETUP WINDOW) **********************************************

function Get_WinServiceSetup(){return Aliases.CroesusApp.winServiceSetup}

function Get_WinServiceSetup_BtnOK(){return Get_WinServiceSetup().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinServiceSetup_BtnCancel()
{
  if (language == "french"){return Get_WinServiceSetup().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinServiceSetup().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinServiceSetup_ChkService(serviceFrenchName, serviceEnglishName)
{
  if (language == "french"){return Get_WinServiceSetup().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", serviceFrenchName], 10)}
  else {return Get_WinServiceSetup().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", serviceEnglishName], 10)}
}



//********************** FENÊTRE MÉTHODE DE RÉÉQUILIBRAGE (REBALANCING METHOD WINDOW) *******************************************

function Get_WinRebalancingMethod(){return Aliases.CroesusApp.winRebalancingMethod}

function Get_WinRebalancingMethod_BtnOK(){return Get_WinRebalancingMethod().FindChild("Uid", "Button_8707", 10)} //ok

function Get_WinRebalancingMethod_BtnCancel(){return Get_WinRebalancingMethod().FindChild("Uid", "Button_f16f", 10)} //ok

function Get_WinRebalancingMethod_RdoWithAssignedModel(){return Get_WinRebalancingMethod().FindChild("Uid", "RadioButton_c704", 10)} //ok

function Get_WinRebalancingMethod_RdoWithSelectedModel(){return Get_WinRebalancingMethod().FindChild("Uid", "RadioButton_7d84", 10)} //ok

function Get_WinRebalancingMethod_RdoManually() {return Get_WinRebalancingMethod().FindChild("Uid", "RadioButton_ecd2", 10)} 

function Get_WinRebalancingMethod_GrpParameters(){return Get_WinRebalancingMethod().FindChild("Uid", "GroupBox_49df", 10)}

function Get_WinRebalancingMethod_GrpParameters_LblSources(){return Get_WinRebalancingMethod_GrpParameters().FindChild("Uid", "TextBlock_eccc", 10)}

function Get_WinRebalancingMethod_GrpParameters_CmbSources(){return Get_WinRebalancingMethod_GrpParameters().FindChild("Uid", "ComboBox_81bd", 10)}

function Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount(){return Get_WinRebalancingMethod_GrpParameters().FindChild("Uid", "RadioButton_14c9", 10)}

function Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves(){return Get_WinRebalancingMethod_GrpParameters().FindChild("Uid", "RadioButton_c7a3", 10)}

function Get_WinRebalancingMethod_GrpParameters_RdoRebalanceSelectedSleeves(){return Get_WinRebalancingMethod_GrpParameters().FindChild("Uid", "RadioButton_10fb", 10)}

// Ajout de fonction get pour le groupe box Summary pour la US
function Get_WinPositionInfo_GrpSummary(){return Get_WinPositionInfo().FindChild("Uid", "GroupBox_32dd", 10)} //ok

// ajout de fonction get pour le goupe box Method
function Get_WinPositionInfo_GrpSummary_GrpMethod(){return Get_WinPositionInfo_GrpSummary().FindChild("Uid", "GroupBox_8261", 10)}

function Get_WinPositionInfo_GrpSummary_GrpMethod_LblAsOf(){return Get_WinPositionInfo_GrpSummary_GrpMethod().FindChild("Uid", "TextBlock_27c8", 10)}

function Get_WinPositionInfo_GrpSummary_GrpMethod_Lbl01252010(){return Get_WinPositionInfo_GrpSummary_GrpMethod().FindChild("Uid", "TextBlock_c8c7", 10)}

function Get_WinPositionInfo_GrpSummary_GrpMethod_TxtFIFO(){return Get_WinPositionInfo_GrpSummary_GrpMethod().FindChild("Uid", "TextBox_6beb", 10)}

function Get_WinPositionInfo_GrpSummary_GrpMethod_BtnConfigure(){return Get_WinPositionInfo_GrpSummary_GrpMethod().FindChild("Uid", "Button_ccd4", 10)}

// ajout des fonctions get pour le groupe box Unrealized Gains/Losses
function Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses(){return Get_WinPositionInfo_GrpSummary().FindChild("Uid", "GroupBox_83d3", 10)}

function Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_LblShortTerm(){return Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses().FindChild("Uid", "TextBlock_b7c9", 10)}

function Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_TxtShortTerm(){return Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses().FindChild("Uid", "CustomTextBox_fa5a", 10)}

function Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_LblLongTerm(){return Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses().FindChild("Uid", "TextBlock_e0e1", 10)}

function Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_TxtLongTerm(){return Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses().FindChild("Uid", "CustomTextBox_3043", 10)}

function Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_LblTotal(){return Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses().FindChild("Uid", "TextBlock_6b05", 10)}

function Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_TxtTotal(){return Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses().FindChild("Uid", "CustomTextBox_697c", 10)}



//********************** FENÊTRE RQS (RQS WINDOW) *******************************************

function Get_WinRQS(){return Aliases.CroesusApp.winRQS}

function Get_WinRQS_BtnTreeView(){return Get_WinRQS().FindChild("Uid", "Button_9072", 10).WPFObject("Image", "", 1)}

function Get_WinRQS_TabAlerts(){return Get_WinRQS().FindChild("Uid", "TabItem_a70d", 10)}

function Get_WinRQS_TabAlerts_AlertsControl(){return Get_WinRQS().FindChild("Uid", "AlertsControl_53a1", 10)}

function Get_WinRQS_TabAlerts_BtnFilter(WPFControlOrdinalNo){return Get_WinRQS_TabAlerts_AlertsControl().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", WPFControlOrdinalNo, true], 10)}

function Get_WinRQS_TabAlerts_BtnFilterByDescription(FilterDescription){return Get_WinRQS_TabAlerts_AlertsControl().FindChild(["ClrClassName", "DataContext.FilterDescription", "IsVisible"], ["ToggleButton", FilterDescription, true], 10)}

function Get_WinRQS_TabAlerts_DgvAlerts(){return Get_WinRQS_TabAlerts_AlertsControl().FindChild(["Uid", "IsVisible"], ["AlertList_5770", true], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}

function Get_WinRQS_TabAlerts_DgvAlerts_ChTest(){return Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Test"], 10)}

function Get_WinRQS_TabAlerts_BtnExportToExcel(){return Get_WinRQS_TabAlerts_AlertsControl().WPFObject("alerts").FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button", "3"], 10)}

function Get_WinRQS_TabAlerts_DgvAlerts_ChAlertNo()
{
  if (language == "french"){return Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "No d'alerte"], 10)}
  else {return Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Alert no."], 10)}
}


function Get_WinRQS_TabTransactionBlotter(){return Get_WinRQS().FindChild("Uid", "TabItem_c461", 10)}

function Get_WinRQS_TabTransactionBlotter_BlotterControl(){return Get_WinRQS().FindChild("Uid", "BlotterControl_1280", 10)}

function Get_WinRQS_TabTransactionBlotter_DgvTransactions(){return Get_WinRQS_TabTransactionBlotter_BlotterControl().FindChild(["Uid", "IsVisible"], ["TransactionList_6af9", true], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}

function Get_WinRQS_TabTransactionBlotter_BlotterControl_DateField(){return Get_WinRQS().FindChild("Uid", "DateField_548e", 10)}

function Get_WinRQS_TabTransactionBlotter_BtnReviewSelected(){return Get_WinRQS_TabTransactionBlotter_BlotterControl().FindChild("Uid", "Button_02b8", 10)}

function Get_WinRQS_TabTransactionBlotter_BtnExportToExcel(){
          return Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button", "3"], 10)}

function Get_WinRQS_TabTransactionBlotter_BtnBulkValidate(){return Get_WinRQS_TabTransactionBlotter_BlotterControl().FindChild("Uid", "Button_947a", 10)}

function Get_WinRQS_TabTransactionBlotter_BtnSummary(){return Get_WinRQS_TabTransactionBlotter_BlotterControl().FindChild("Uid", "Button_6f58", 10)}

function Get_WinRQS_TabTransactionBlotter_BtnFilter(){return Get_WinRQS_TabTransactionBlotter_BlotterControl().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlName", "WPFControlOrdinalNo"], ["Button", "PART_Button", 1], 10)}


//Tab Trans Bottom Section
function Get_WinRQS_BottomSection(){return Get_WinRQS().FindChild("Uid", "Expander_f6d2", 10)}

function Get_WinRQS_BottomSection_TabNotesAndAlerts(){return Get_WinRQS_BottomSection().FindChild("Uid", "TabItem_49e0", 10)}
          
function Get_WinRQS_BottomSection_TabNotesAndAlerts_BtnDelete(){return Get_WinRQS_BottomSection().FindChild("Uid", "Button_9e45", 10)}

function Get_WinRQS_BottomSection_TabNotesAndAlerts_DgvNotesAndAlerts(){return Get_WinRQS().FindChild("Uid", "DataGrid_080f", 10)}
          
function Get_WinRQS_TabSecurityAlerts(){return Get_WinRQS().FindChild("Uid", "TabItem_258c", 10)}

function Get_WinRQS_TabSecurityAlerts_SecurityAlertsControl(){return Get_WinRQS().FindChild("Uid", "SecurityAlertsControl_a961", 10)}

function Get_WinRQS_TabSecurityAlerts_DgvAlerts(){return Get_WinRQS_TabSecurityAlerts_SecurityAlertsControl().FindChild(["Uid", "IsVisible"], ["SecurityAlertList_423b", true], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}

//RQS Onglet Rapports
function Get_WinRQS_TabReports(){return Get_WinRQS().FindChild("Uid", "TabItem_3a3b", 10)}

function Get_WinRQS_TabReports_ReportsControl(){return Get_WinRQS().FindChild("Uid", "ReportsControl_2034", 10)}

function Get_WinRQS_TabReports_BtnDisplayReport(){return Get_WinRQS_TabReports_ReportsControl().FindChild("Uid", "Button_e946", 10)}

function Get_WinRQS_TabReports_DgvRiskRatingReports(){return Get_WinRQS_TabReports_ReportsControl().FindChild(["Uid", "IsVisible"], ["RiskRatingList_2bd4", true], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}

function Get_WinRQS_TabReports_BtnExportToExcel(){return Get_WinRQS_TabReports_ReportsControl().WPFObject("offsideAccounts").FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Button", 2], 10)}

function Get_WinRQS_TabReports_CmbReportType(){return Get_WinRQS_TabReports_ReportsControl().FindChild("Uid", "ComboBox_7f10", 10)}

function Get_WinRQS_TabReports_CmbReportType_ItemOffsideAccounts()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "Comptes hors tolérance"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", "Offside Accounts"], 10)}
}

function Get_WinRQS_TabReports_CmbReportType_CmbItem(numero){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBoxItem", numero], 10)}

function Get_WinRQS_TabReports_BtnFilter(){return Get_WinRQS_TabReports_ReportsControl().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["RecordListControl", 1, true], 10).FindChild(["ClrClassName", "WPFControlName", "WPFControlOrdinalNo"], ["Button", "PART_Button", 1], 10)}

function Get_WinRQS_TabReports_ScrollViewer(){return Get_WinRQS_TabReports_ReportsControl().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["RecordListControl", 1, true], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ScrollViewer", 1], 10)}

function Get_WinRQS_TabReports_ScrollViewer_BtnFilter(WPFControlOrdinalNo){return Get_WinRQS_TabReports_ScrollViewer().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", WPFControlOrdinalNo, true], 10)}

function Get_WinRQS_TabReports_ScrollViewer_BtnFilter_BtnTextBlock(WPFControlOrdinalNo){return Get_WinRQS_TabReports_ScrollViewer_BtnFilter(WPFControlOrdinalNo).FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["TextBlock", 1, true], 10)}

function Get_WinRQS_TabReports_ScrollViewer_BtnFilter_BtnEditView(WPFControlOrdinalNo){return Get_WinRQS_TabReports_ScrollViewer_BtnFilter(WPFControlOrdinalNo).FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["Button", 1, true], 10)}

function Get_WinRQS_TabReports_ScrollViewer_BtnFilter_BtnRemove(WPFControlOrdinalNo){return Get_WinRQS_TabReports_ScrollViewer_BtnFilter(WPFControlOrdinalNo).FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["Button", 2, true], 10)}


//RQS Onglet Reports - Offside accounts

function Get_WinRQS_TabReports_DgvOffsideAccounts(){return Get_WinRQS_TabReports_ReportsControl().FindChild(["Uid", "IsVisible"], ["AccountList_046f", true], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", "1"], 10)}

function Get_WinRQS_TabReports_DgvOffsideAccounts_CellTargetLow(rowNum){return Get_WinRQS_TabReports_DgvOffsideAccounts().FindChild(["ClrClassName", "IsVisible", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", true, false, rowNum], 10).FindChild(["ClrClassName", "Uid", "IsVisible"], ["CellValuePresenter", "LowerTolerance", true], 10);}

function Get_WinRQS_TabReports_DgvOffsideAccounts_CellTargetMedium(rowNum){return Get_WinRQS_TabReports_DgvOffsideAccounts().FindChild(["ClrClassName", "IsVisible", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", true, false, rowNum], 10).FindChild(["ClrClassName", "Uid", "IsVisible"], ["CellValuePresenter", "MidTolerance", true], 10);}

function Get_WinRQS_TabReports_DgvOffsideAccounts_CellTargetHigh(rowNum){return Get_WinRQS_TabReports_DgvOffsideAccounts().FindChild(["ClrClassName", "IsVisible", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", true, false, rowNum], 10).FindChild(["ClrClassName", "Uid", "IsVisible"], ["CellValuePresenter", "UpperTolerance", true], 10);}

function Get_WinRQS_TabReports_DgvOffsideAccounts_CellClientNo(rowNum){return Get_WinRQS_TabReports_DgvOffsideAccounts().FindChild(["ClrClassName", "IsVisible", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", true, false, rowNum], 10).FindChild(["ClrClassName", "Uid", "IsVisible"], ["CellValuePresenter", "ClientNumber", true], 10);}

function Get_WinRQS_TabReports_DgvOffsideAccounts_CellClientName(rowNum){return Get_WinRQS_TabReports_DgvOffsideAccounts().FindChild(["ClrClassName", "IsVisible", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", true, false, rowNum], 10).FindChild(["ClrClassName", "Uid", "IsVisible"], ["CellValuePresenter", "ClientName", true], 10);}

function Get_WinRQS_TabReports_DgvOffsideAccounts_CellMgmtLevel(rowNum){return Get_WinRQS_TabReports_DgvOffsideAccounts().FindChild(["ClrClassName", "IsVisible", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", true, false, rowNum], 10).FindChild(["ClrClassName", "Uid", "IsVisible"], ["CellValuePresenter", "ManagementLevel", true], 10);}

function Get_WinRQS_TabReports_DgvOffsideAccounts_CellClientRelNo(rowNum){return Get_WinRQS_TabReports_DgvOffsideAccounts().FindChild(["ClrClassName", "IsVisible", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", true, false, rowNum], 10).FindChild(["ClrClassName", "Uid", "IsVisible"], ["CellValuePresenter", "LinkNumber", true], 10);}

function Get_WinRQS_TabReports_DgvOffsideAccounts_CellClientRelName(rowNum){return Get_WinRQS_TabReports_DgvOffsideAccounts().FindChild(["ClrClassName", "IsVisible", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", true, false, rowNum], 10).FindChild(["ClrClassName", "Uid", "IsVisible"], ["CellValuePresenter", "LinkName", true], 10);}

function Get_WinRQS_TabReports_DgvOffsideAccounts_CellTotalValue(rowNum){return Get_WinRQS_TabReports_DgvOffsideAccounts().FindChild(["ClrClassName", "IsVisible", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", true, false, rowNum], 10).FindChild(["ClrClassName", "Uid", "IsVisible"], ["CellValuePresenter", "TotalValue", true], 10);}


// RQS --> Window 'Transaction Review'
function Get_WinTransactionReview(){return Get_CroesusApp().FindChild("Uid", "Window_fff1", 10)}

function Get_WinTransactionReview_BtnValidate(){return Get_WinTransactionReview().FindChild("Uid", "Button_c9dd", 10)}

function Get_WinTransactionReview_GrpNoteTextBox(){return Get_WinTransactionReview().FindChild("Uid", "TextBox_b392", 10)}

//RQS --> Window 'Transaction Summary'
function Get_WinTransactionSummary(){return Get_CroesusApp().FindChild("Uid", "TransactionSummaryWindow_579d", 10)}

function Get_WinTransactionSummary_BtnClose(){return Get_WinTransactionSummary().FindChild("Uid", "Button_6b17", 10)}

//RQS --> Window 'Bulk Validation'
function Get_WinBulkValidation(){return Get_CroesusApp().FindChild("Uid", "Window_fff1", 10)}

function Get_WinBulkValidation_BtnClose(){return Get_WinBulkValidation().FindChild("Uid", "Button_2076", 10)}

//RQS --> Tab 'Notes and Alerts' --> Button 'Delete' --> Window 'Deletion'
function Get_WinDeletion(){return Get_CroesusApp().FindChild("Uid", "DeletionWindow_5967", 10)}          
 
function Get_WinDeletion_BtnYes(){return Get_WinDeletion().FindChild("Uid", "Button_cbe4", 10)}     
          
function Get_WinDeletion_BtnDeleteForManyTransactions(){return Get_WinDeletion().FindChild("Uid", "Button_8553", 10)}

//ajout des fonctions get pour le groupe box Realized gains and losses
function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses(){return Get_WinPositionInfo_GrpSummary().FindChild("Uid", "GroupBox_e7fa", 10)}

function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_LblShortTerm(){return Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().FindChild("Uid", "TextBlock_d182", 10)}

function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_LblLongTerm(){return Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().FindChild("Uid", "TextBlock_401f", 10)}

function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_LblTotal(){return Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().FindChild("Uid", "TextBlock_a58c", 10)}

function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_LblCurrentYear(){return Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().FindChild("Uid", "TextBlock_3d4a", 10)}

function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_LblSinceInception(){return Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().FindChild("Uid", "TextBlock_01aa", 10)}

function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtShortTermCurrentYear(){return Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().FindChild("Uid", "CustomTextBox_f37d", 10)}

function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtShortTermSinceInception(){return Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().FindChild("Uid", "CustomTextBox_f283", 10)}

function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtLongTermCurrentYear(){return Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().FindChild("Uid", "CustomTextBox_3fcd", 10)}

function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtLongTermSinceInception(){return Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().FindChild("Uid", "CustomTextBox_5cdc", 10)}

function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtTotalCurrentYear(){return Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().FindChild("Uid", "CustomTextBox_3bec", 10)}

function Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtTotalSinceInception(){return Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().FindChild("Uid", "CustomTextBox_9f65", 10)}


// ajout des fonctions get pour l'onglet Lots

function Get_WinPositionInfo_TabLots(){return Get_WinPositionInfo().FindChild("Uid", "TabItem_ca20", 10)} //ok

function Get_WinPositionInfo_TabLots_Grp(){return Get_WinPositionInfo().FindChild("Uid", "DataGrid_eaa2", 10)} //ok

function Get_WinPositionInfo_TabLots_BtnExpandAll(){return  Get_WinPositionInfo().FindChild("Uid", "ToggleButton_1d4c", 10)} //ok

function Get_WinPositionInfo_TabLots_Grp_ChOpeningDate(){return Get_WinPositionInfo_TabLots_Grp().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Opening Date"], 10)} //no uid

function Get_WinPositionInfo_TabLots_Grp_ChClosingDate(){return Get_WinPositionInfo_TabLots_Grp().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Closing Date"], 10)} //no uid

function Get_WinPositionInfo_TabLots_Grp_ChQty(){return Get_WinPositionInfo_TabLots_Grp().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Qty"], 10)} //no uid

function Get_WinPositionInfo_TabLots_Grp_ChCost(){return Get_WinPositionInfo_TabLots_Grp().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cost"], 10)} //no uid

function Get_WinPositionInfo_TabLots_Grp_ChCostBasis(){return Get_WinPositionInfo_TabLots_Grp().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Cost Basis"], 10)} //no uid

function Get_WinPositionInfo_TabLots_Grp_ChGLType(){return Get_WinPositionInfo_TabLots_Grp().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "G/L Type"], 10)} //no uid

function Get_WinPositionInfo_TabLots_Grp_ChMarketPrice(){return Get_WinPositionInfo_TabLots_Grp().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Price"], 10)} //no uid

function Get_WinPositionInfo_TabLots_Grp_ChMarketValue(){return Get_WinPositionInfo_TabLots_Grp().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Market Value"], 10)} //no uid

function Get_WinPositionInfo_TabLots_Grp_ChUnrealGL(){return Get_WinPositionInfo_TabLots_Grp().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Unreal. G/L"], 10)} //no uid

function Get_WinPositionInfo_TabLots_Grp_ChRealGL(){return Get_WinPositionInfo_TabLots_Grp().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Real. G/L"], 10)} //no uid



//********************** FENÊTRE PARAMÈTRES RÉGIONAUX (REGIONAL SETTINGS WINDOW) *******************************************

function Get_WinRegionalSettings(){return Aliases.CroesusApp.winRegionalSettings}

function Get_WinRegionalSettings_CmbBasedOn(){return Get_WinRegionalSettings().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinRegionalSettings_BtnOK(){return Get_WinRegionalSettings().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)}

function Get_WinRegionalSettings_BtnCancel()
{
  if (language == "french"){return Get_WinRegionalSettings().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
  else {return Get_WinRegionalSettings().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}

function Get_WinRegionalSettings_BtnApply()
{
  if (language == "french"){return Get_WinRegionalSettings().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Appliquer"], 10)}
  else {return Get_WinRegionalSettings().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Apply"], 10)}
}

function Get_WinRegionalSettings_TabControl(){return Get_WinRegionalSettings().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", 1], 10)}

function Get_WinRegionalSettings_TabNumbers()
{
  if (language == "french"){return Get_WinRegionalSettings_TabControl().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Nombres"], 10)}
  else {return Get_WinRegionalSettings_TabControl().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Numbers"], 10)}
}

function Get_WinRegionalSettings_TabNumbers_CmbDecimalSymbol(){return Get_WinRegionalSettings_TabControl().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

function Get_WinRegionalSettings_TabNumbers_CmbDigitGroupingSymbol(){return Get_WinRegionalSettings_TabControl().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 2], 10)}

function Get_WinRegionalSettings_TabNumbers_CmbDigitGrouping(){return Get_WinRegionalSettings_TabControl().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 3], 10)}

function Get_WinRegionalSettings_TabNumbers_CmbNegativeNumberFormat(){return Get_WinRegionalSettings_TabControl().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 4], 10)}

function Get_WinRegionalSettings_TabDate(){return Get_WinRegionalSettings_TabControl().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Date"], 10)}

function Get_WinRegionalSettings_TabDate_GrpShortDate()
{
  if (language == "french"){return Get_WinRegionalSettings_TabControl().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Date courte"], 10)}
  else {return Get_WinRegionalSettings_TabControl().FindChild(["ClrClassName", "WPFControlText"], ["UniGroupBox", "Short Date"], 10)}
}

function Get_WinRegionalSettings_TabDate_GrpShortDate_CmbFormat(){return Get_WinRegionalSettings_TabDate_GrpShortDate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", 1], 10)}

/*

/******************************** User Multi Selection window - "Work As" window (Fenêtre Multi Sélection Utilisateurs - fenêtre "Travailler en tant que") ***************************

function Get_WinUserMultiSelection(){return Aliases.CroesusApp.winUserMultiSelection}


function Get_WinUserMultiSelection_TabBranches(){return Get_WinUserMultiSelection().FindChild("Uid", "TabItem_d643", 10)}

function Get_WinUserMultiSelection_TabBranches_DgvBranches(){return Get_WinUserMultiSelection().FindChild("Uid", "DataGrid_97ea", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)}

function Get_WinUserMultiSelection_TxtNumberOfSelectedBranches(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_b911", 10)}

function Get_WinUserMultiSelection_TabIACodes(){return Get_WinUserMultiSelection().FindChild("Uid", "TabItem_44f2", 10)}

function Get_WinUserMultiSelection_TabIACodes_DgvBranches(){return Get_WinUserMultiSelection().FindChild("Uid", "DataGrid_09db", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10)}

function Get_WinUserMultiSelection_TxtNumberOfSelectedIACodes(){return Get_WinUserMultiSelection().FindChild("Uid", "TextBlock_a264", 10)}

function Get_WinUserMultiSelection_BtnApply(){return Get_WinUserMultiSelection().FindChild("Uid", "Button_62f8", 10)}

function Get_WinUserMultiSelection_BtnCancel(){return Get_WinUserMultiSelection().FindChild("Uid", "Button_c483", 10)}

/*
        Fonctions pour gérer le CR1483 (Utilisateurs/Selection)
        Fenêtre "Travailler en tant que" / "Work As"
        Description : Créer toutes les fonctions qui gèrent les objets de cette fenêtre
        Analyste: Abdel Matmat
        Tache jira: DAS-4286 Automatiser le CR 1483 (section Menu utilisateurs)


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
*/


/******************************** WinSCP ***************************/

function Get_DlgWinSCPWarning(){return Aliases.WinSCP.DlgWinSCPWarning}

function Get_DlgWinSCPWarning_BtnUpdate(){return Get_DlgWinSCPWarning().FindChild("ObjectIdentifier", "Yes", 10)}

function Get_WinWinSCP(){return Aliases.WinSCP.WinWinSCP}

function Get_WinWinSCP_PnlRemotePanel(){return Get_WinWinSCP().FindChild("ObjectIdentifier", "RemotePathLabel", 10)}

function Get_DlgWinSCPFileFind(){return Aliases.WinSCP.DlgWinSCPFileFind}

function Get_DlgWinSCPFileFind_GrpFilter(){return Get_DlgWinSCPFileFind().FindChild("ObjectIdentifier", "FilterGroup", 10)}

function Get_DlgWinSCPFileFind_GrpFilter_CmbSearchIn(){return Get_DlgWinSCPFileFind_GrpFilter().FindChild("ObjectIdentifier", "RemoteDirectoryEdit", 10)}

function Get_DlgWinSCPFileFind_GrpFilter_CmbFileMask(){return Get_DlgWinSCPFileFind_GrpFilter().FindChild("ObjectIdentifier", "MaskEdit", 10)}

function Get_DlgWinSCPFileFind_GrpFilter_LvwFileView(){return Get_DlgWinSCPFileFind().FindChild("ObjectIdentifier", "FileView", 10)}

function Get_DlgWinSCPFileFind_BtnEdit(){return Get_DlgWinSCPFileFind().FindChild("ObjectIdentifier", "EditButton", 10)}




/******************************** SSH Secure Shell Client Application (Application SSH Secure Shell Client) ***************************/

function Get_WinSSHSecureShell(){return Aliases.winSSHSecureShell;}

function Get_DlgGoToRemoteFolder(){return Aliases.dlgGoToRemoteFolder;}

function Get_DlgGoToRemoteFolder_CmbEnterFolderName(){return Get_DlgGoToRemoteFolder().FindChild(["WndClass", "Index"], ["ComboBox", 1], 10);}

function Get_DlgGoToRemoteFolder_BtnOK(){return Get_DlgGoToRemoteFolder().FindChild(["WndClass", "WndCaption"], ["Button", "OK"], 10);}

function Get_DlgConfirmDisconnect(){return Aliases.dlgConfirmDisconnect;}

function Get_DlgConfirmDisconnect_BtnOK(){return Get_DlgConfirmDisconnect().FindChild(["WndClass", "WndCaption"], ["Button", "OK"], 10);}

function Get_DlgHostIdentification(){return Aliases.dlgHostIdentification;}

function Get_DlgHostIdentification_BtnYes(){return Get_DlgHostIdentification().FindChild(["WndClass", "WndCaption"], ["Button", "&Yes"], 10);}

function Get_WinSSHSecureShell_Statusbar(){return Get_WinSSHSecureShell().FindChild(["WndClass", "Index"], ["msctls_statusbar32", 1], 10);}

function Get_DlgConnectToRemoteHost(){return Aliases.dlgConnectToRemoteHost;}

function Get_DlgConnectToRemoteHost_TxtHostName(){return Get_DlgConnectToRemoteHost().FindChild(["WndClass", "Index"], ["Edit", 1], 10);}

function Get_DlgConnectToRemoteHost_TxtUserName(){return Get_DlgConnectToRemoteHost().FindChild(["WndClass", "Index"], ["Edit", 2], 10);}

function Get_DlgConnectToRemoteHost_TxtPortNumber(){return Get_DlgConnectToRemoteHost().FindChild(["WndClass", "Index"], ["Edit", 3], 10);}

function Get_DlgConnectToRemoteHost_CmbAuthenticationMethod(){return Get_DlgConnectToRemoteHost().FindChild(["WndClass", "Index"], ["ComboBox", 1], 10);}

function Get_DlgConnectToRemoteHost_BtnConnect(){return Get_DlgConnectToRemoteHost().FindChild(["WndClass", "WndCaption"], ["Button", "Connect"], 10);}

function Get_DlgEnterPassword(){return Aliases.dlgEnterPassword;}

function Get_DlgEnterPassword_TxtPassword(){return Get_DlgEnterPassword().FindChild(["WndClass", "Index"], ["Edit", 1], 10);}

function Get_DlgEnterPassword_BtnOK(){return Get_DlgEnterPassword().FindChild(["WndClass", "WndCaption"], ["Button", "OK"], 10);}

function Get_WinSSHSecureFileTransfer(){return Aliases.winSSHSecureFileTransfer;}

function Get_WinSSHSecureFileTransfer_LvwRemoteFolderContent(){return Get_WinSSHSecureFileTransfer().FindChild(["WndClass", "Index"], ["SysListView32", 1], 10);}

function Get_WinSSHSecureFileTransfer_Statusbar(){return Get_WinSSHSecureFileTransfer().FindChild(["WndClass", "Index"], ["msctls_statusbar32", 1], 10);}

//****************************** Fonctions Get liés à la fenêtre Outils/Configuration/Profils et Dictionnaire/Groupes de Profils ****************************
/*
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule_ItemRelation(){
   if (language == "french") return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Relations"],10);
   else return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Relationships"],10);
}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule_ItemClient(){
   return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Clients"],10);
}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule_ItemAccount(){
   if (language == "french") return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Comptes"],10);
   else return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Accounts"],10);
}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule_ItemSecurity(){
   if (language == "french") return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Titres"],10);
   else return Get_SubMenus().Find(["ClrClassName","WPFControlText"],["TextBlock","Securities"],10);
}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BtnAddProfile(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_2d47", 10)}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BtnEditProfile(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_0a73", 10)}
function Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BtnDetailledPreview(){return Get_WinProfilesAndDictionaryConfiguration().FindChild("Uid", "Button_12fd", 10)}
*/

// *****************Fonction Get ajouter par Alhassane pour Regression Portefeuilles*************************/

function Get_GridHeader_ContextualMenu_AddColumn_FinancialInstrument(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Field: FinancialInstrumentDescription"], 10)}

function Get_DlgInformation_LblMessageV(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)}


   function Get_PortfolioGrid_ContextualMenu_Edit() //uid est le même que pour ajout et ne pointe pas sur edit
{
  if (language=="french"){return Get_CroesusApp().Find("WPFControlText", "_Modifier...", 10)}
  else {return Get_CroesusApp().Find("WPFControlText", "_Edit...", 10)}
}
  

//Fin

// *****************Fonction Get ajouter par Jimena pour Regression Relation*************************/

//Remove from relationship : 
//Note: In common_Get_functions was created but the WPFControlName is different "PART_YES" 

  
  
//Fenêtre de Préférences 


//function Get_WinPreferences()
//{
//	return Aliases.CroesusApp.winDetailedInfoPreferences
//         
//}
//
////Tab Utilisateur - Fenêtre de Préférences 
//function Get_WinPrefe_TadUser(){
//	
//	if (language == "english") 
//	{
//	return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "User"], 10)
//	}
//	else
//	{
//	return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Utilisateur"], 10)
//	}
//}
//
////Tab Secteurs d'activité - Fenêtre de Préférences 
//function Get_WinPrefe_TabInduCode(){
//	
//	if (language == "english")
//	{
//		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Industry Codes"], 10)
//	}
//	else 
//	{
//		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Secteurs d'activité"], 10)
//	}
//	
//}
//
//
////OK bouton Preferences 
//function Get_WinPrefe_BtnOK(){
//	
//	if (language == "french")
//	{
//		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)
//	}
//	else 
//	{
//		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 10)
//	}
//	
//}
//
////Cancel- Annuler bouton Preferences 
//function Get_WinPrefe_BtnCancel(){
//	
//	if (language == "french")
//	{
//		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)
//	}
//	else 
//	{
//		return Get_WinPreferences().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)
//	}
//	
//}


//Info relation / Tab Documents

function Get_WinDetailInfo_TabDocu_LvwtDocu()
{
  return Get_WinDetailedInfo().FindChild("Uid", "ListBox_25ba", 10)
}

//Info relation / Tab Documents/List des documents
function Get_WinDetailInfo_TabDocu_LvwDocuNameLabel()
{
  return Get_WinDetailedInfo().FindChild("Uid", "TextBlock_a307", 10)
}

//function déjà crée dans Common_Get_functions mais il était commenté
function Get_WinDetailedInfo_TabDocu_TxtComments_BtnEdit()
{
  return Get_WinDetailedInfo().FindChild ("Uid", "Button_b3e0", 10)
}

//Gestions de restriction Relation
function WinRestrictionsManager_Rel()
{
  return Get_WinRestrictionsManager().FindChild("Uid","RestrictionManagerWindow_325f",10)

}

//Validation du msg - Info/Relation/Documents/liste de documents/Remove [-] PDF
 function Get_DlgConfirmation_LblMessage_Remove() 
{
  if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Voulez-vous enlever 'SECURITY_INCOME_ANALYSIS.pdf' ?"], 10)}
  else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Are you sure you want to remove 'SECURITY_INCOME_ANALYSIS.pdf'?"], 10)}
}

//Validation du msg - Info/Relation/Documents/liste de documents/Remove [-] Doc
   function Get_DlgConfirmation_LblMessage_RemoveDoc() 
  {
    if (language == "french"){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Voulez-vous enlever 'test1BNC_2222.docx' ?"], 10)}
    else {return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Are you sure you want to remove 'test1BNC_2222.docx'?"], 10)}
  }
  

  //Uid trouve sur la Ligne 7509 dans Common_Get_functions
  //champ textbox - Comments
function Get_WinDetailedInfo_TabDocu_GrpComments_TxtComment()
{
  return Get_WinDetailedInfo().FindChild("Uid", "TextBox_a547", 10)
}

//Click sur le bouton [Save - Sauvegarder] des Comments Info Relation/Documents-Comments
function Get_SaveComments_InfoRelationTabDocu()
{
	return Get_WinDetailedInfo().FindChild("Uid", "Button_d631", 10)
}

//---> Common_functions
// Ajouter un restriction avec Devise de prix - CAD 
function Add_Restriction(security,currency)

{
 
    Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
    var count = Get_WinRestrictionsManager_DgvRestriction().WPFObject("RecordListControl", "", 1).Items.Count;
		Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys(security);
		Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
		Get_WinCRURestriction_GrpSecurity_RdoPriceCurrency().Click();
		Get_WinCRURestriction_GrpSecurity_CmbPriceCurrencyNotEqualTo().Click();
		if(Get_SubMenus().Exists){
		  Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", currency], 10).Click();
		  } 
		Get_WinCRURestriction_BtnOK().Click();
}


//Ligne 4061 - common_Get_functions WPFControlName = (PART_Yes), il a changé à WPFControlName = (PART_OK)
////retirer la relation dans la partie détails module Relations
function Get_DlgConfirmation_BtnRemoveReg()
{
	return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlName"], ["Button", "PART_OK"], 10)
} 

/*
//Ajout de fonctions Get pour les fenêtres Outils / Configurations / rapports / configuration des rapports / Niveau global / sélectionner le rapport
//Ajouté par Abdel
//Date 15/11/2019
function  Get_WinConfigurations_LvwListView_ReportConfiguration(){
          if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Configuration des rapports"], 10)}
          else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "Report Configuration"], 10)}
        }
function Get_WinReportConfiguration(){return Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient}

function Get_WinReportConfiguration_BtnGroup(){ 
    if (language == "french"){return Get_WinReportConfiguration().FindChild(["ClrClassName","WPFControlText"],["UniGroupBox","Groupe"],10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}
         else {return Get_WinReportConfiguration().FindChild(["ClrClassName","WPFControlText"],["UniGroupBox","Group"],10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}
}

function Get_WinReportConfiguration_BtnCopyTo(){
         if (language == "french"){return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Copier _vers..."], 10)}
         else {return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Copy _To..."], 10)}
}
function Get_WinReportConfiguration_BtnDelete(){
         if (language == "french"){return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "S_upprimer"], 10)}
         else {return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "De_lete"], 10)}
}
function Get_WinReportConfiguration_BtnClose(){
         if (language == "french"){return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Fermer"], 10)}
         else {return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Close"], 10)}
}
function Get_WinReportConfiguration_BtnEdit(){
         if (language == "french"){return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Mo_difier..."], 10)}
         else {return Get_WinReportConfiguration().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "_Edit..."], 10)}
}
function Get_WinReportConfiguration_UniList(){ 
  if (language == "french"){return Get_WinReportConfiguration().WPFObject("UniGroupBox", "Sélectionner un rapport", 2).WPFObject("UniList", "", 1)}
  else      return Get_WinReportConfiguration().WPFObject("UniGroupBox", "Select a Report", 2).WPFObject("UniList", "", 1);
}

function Get_WinCopyReport(){return Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient}

function Get_WinCopyReport_CmbUser(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Utilisateur"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "User"], 100)}
}

function Get_WinCopyReport_ChkReadOnly(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Lecture seulement"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Read-Only"], 100)}
}

function Get_WinCopyReport_RdoFirm(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Firme"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Firm"], 100)}
}

function Get_WinCopyReport_RdoBranch(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Succursale"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Branch"], 100)}
}

function Get_WinCopyReport_RdoWorkgroup(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Équipe de travail"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Workgroup"], 100)}
}

function Get_WinCopyReport_ChkReportNotAvailable(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Rapport non visible"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Report not Available"], 100)}
}

function Get_WinCopyReport_TxtDescriprion(){
         if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 100)}
         else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 100)}
}

function Get_WinCopyReport_BtnOK(){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "OK"], 100)}

function Get_WinCopyReport_BtnCancel(){
         if (language == "french"){return Get_WinCopyReport().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Annuler"], 10)}
         else {return Get_WinCopyReport().FindChild(["ClrClassName", "WPFControlText"], ["UniButton", "Cancel"], 10)}
}
function Get_WinReportConfigurationCopy(){return Get_CroesusApp().FindChild("Uid", "ReportConfigurationWindow", 10)}

function Get_WinReportConfigurationCopy_TabDisclaimers(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TabItem_5489", 10)}

function Get_WinReportConfigurationCopy_TabDisclaimers_ChkUseDefault(){return Get_WinReportConfigurationCopy().FindChild("Uid", "CheckBox_18a5", 10)}

function Get_WinReportConfigurationCopy_TabDisclaimers_TxtDisclaimer(){return Get_WinReportConfigurationCopy().FindChild("Uid", "LocaleTextbox_ff77", 10)}

function Get_WinReportConfigurationCopy_TabLayout(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TabItem_b207", 10)}

function Get_WinReportConfigurationCopy_TabLayout_ChkUseDefault(){return Get_WinReportConfigurationCopy().FindChild("Uid", "CheckBox_e5eb", 10)}

function Get_WinReportConfigurationCopy_TabLayout_CmbReportLayout(){return Get_WinReportConfigurationCopy().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", "1"], 10)}

function Get_WinReportConfigurationCopy_BtnCancel(){return Get_WinReportConfigurationCopy().FindChild("Uid", "Button_620a", 10)}

function Get_WinReportConfigurationCopy_BtnAddToRight(){return Get_WinReportConfigurationCopy().FindChild("Uid", "Button_6c18", 10)} 

function Get_WinReportConfigurationCopy_BtnAddToLeft(){return Get_WinReportConfigurationCopy().FindChild("Uid", "Button_b18f", 10)}

function Get_WinReportConfigurationCopy_TabContent(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TabItem_02ec", 10)}

function Get_WinReportConfigurationCopy_TabContent_LstColumnsRight(){return Get_WinReportConfigurationCopy().FindChild("Uid", "ListBox_e04f",10)}

function Get_WinReportConfigurationCopy_TabProperties(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TabItem_0b147", 10)}

function Get_WinReportConfigurationCopy_TabProperties_TxtReportName(){return Get_WinReportConfigurationCopy().FindChild("Uid", "LocaleTextbox_53a3", 10)}

function Get_WinReportConfigurationCopy_TabProperties_TxtReportHeader(){return Get_WinReportConfigurationCopy().FindChild("Uid", "LocaleTextbox_f592", 10)}

function Get_WinReportConfigurationCopy_TabProperties_TxtReportNameWhenChkUseTheReportNameIsChecked(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TextBox_a606", 10)}

function Get_WinReportConfigurationCopy_TabProperties_ChkUseTheReportName(){return Get_WinReportConfigurationCopy().FindChild("Uid", "CheckBox_bc37", 10)}

function Get_WinReportConfigurationCopy_TabProperties_TxtOwner(){return Get_WinReportConfigurationCopy().FindChild("Uid", "TextBox_3664", 10)}

function Get_WinReportConfigurationCopy_Columns(){return Get_WinReportConfigurationCopy().FindChild("Uid", "ListBox_8888", 10)}

function Get_WinReportConfigurationCopy_TabProperties_CmbOwner(){return Get_WinReportConfigurationCopy().FindChild("Uid", "ComboBox_08ee", 10)}

function Get_WinReportConfigurationCopy_TabProperties_ChkReportNotAvailable(){return Get_WinReportConfigurationCopy().FindChild("Uid", "CheckBox_d447", 10)}

function Get_WinReportConfigurationCopy_BtnOK(){return Get_WinReportConfigurationCopy().FindChild("Uid", "Button_02fe", 10)}

function Get_Reports_GrpReports_TabReports_LvwReport(){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClassicTabControl", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TreeView", "1"], 10)} //no uid


function Get_WinReportConfiguration_BtnGroup_ItemUser(){
    if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["MenuItem","Utilisateur"],10)}
    else {return Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["MenuItem","User"],10)}
} 
*/

//******************************************* FENÊTRE Column header**********************************************************
function  Get_WinColumnHeader(){return Get_CroesusApp().FindChild("Uid", "UserDefinedReportColumnLabelWindow_d6ad", 10)}

function Get_WinColumnHeader_ChkUseDeault(){return Get_WinColumnHeader().FindChild("Uid", "CheckBox_6219", 10)}

function Get_WinColumnHeader_TxtDescription(){return Get_WinColumnHeader().FindChild("Uid", "LocaleTextbox_b375", 10)}

function Get_WinColumnHeader_BtnOk(){return Get_WinColumnHeader().FindChild("Uid", "Button_33d4", 10)}

function Get_WinColumnHeader_BtnCancel(){return Get_WinColumnHeader().FindChild("Uid", "Button_216f", 10)}


//************************************* FENÊTRE TAUX de change   (Exchange rate WINDOW) ************************************

function Get_WinExchangeRateOrdre(){return Aliases.CroesusApp.winFXRate}

function Get_WinExchangeRate_GrpRate(){return Get_WinExchangeRateOrdre().FindChild("Uid", "GroupBox_5d26", 10)}

function Get_WinExchangeRate_GrpRate_TxtRateOrigin(){return Get_WinExchangeRate_GrpRate().FindChild("Uid", "TextBlock_cc7c", 10)}

function Get_WinExchangeRate_GrpRate_CmbRateOrigin(){return Get_WinExchangeRate_GrpRate().FindChild("Uid", "UniComboBox_4614", 10)}

function Get_WinExchangeRate_GrpRate_TxtExchangeRate(){return Get_WinExchangeRate_GrpRate().FindChild("Uid", "TextBlock_5230", 10)}

function  Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble(){return Get_WinExchangeRate_GrpRate().FindChild("Uid", "DoubleTextBox_142c", 10)}

function Get_WinExchangeRate_GrpRate_LblCADUSD(){return Get_WinExchangeRate_GrpRate().FindChild("Uid", "TextBlock_c842", 10)} 

function Get_WinExchangeRate_GrpRate_TxtTotalToConvert(){return Get_WinExchangeRate_GrpRate().FindChild("Uid", "TextBlock_bcd0", 10)}

function Get_WinExchangeRate_GrpRate_TxtCustomTotalToConvert(){return Get_WinExchangeRate_GrpRate().FindChild("Uid", "CustomTextBox_5cec", 10)}

function Get_WinExchangeRate_GrpRate_TxtUSDToConvertToCAD(){return Get_WinExchangeRate_GrpRate().FindChild("Uid", "TextBlock_b297", 10)}

function Get_WinExchangeRate_GrpRate_TxtInternalNumber(){return Get_WinExchangeRate_GrpRate().FindChild("Uid", "TextBlock_8e81", 10)}

function Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(){return Get_WinExchangeRate_GrpRate().FindChild("Uid", "CustomTextBox_f462", 10)}

function Get_WinExchangeRate_BtnOK(){return Get_WinExchangeRateOrdre().FindChild(["ClrClassName", "WPFControlText"], ["Button", "OK"], 10)}


function Get_WinExchangeRate_BtnCancel(){ if (language == "french"){return Get_WinExchangeRateOrdre().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Annuler"], 10)}

else {return Get_WinExchangeRateOrdre().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Cancel"], 10)}
}

//***********************Fenêtre de confirmation XrateConfirmation ************************************
function Get_WinFXRateConfirmation(){return Aliases.CroesusApp.winFXRateConfirmation}

function Get_DlgInformation_LblMessageFXRateConfirmation(){return Get_WinFXRateConfirmation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", "1"], 10)}



function Get_WinFXRateConfirmation_BtnSelectAll(){
    if (language == "french"){return Get_WinFXRateConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button","Sélectionner tout"],10)}//Sélectionner tout
    else {return Get_WinFXRateConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button","Select All"],10)}
} 



function Get_WinFXRateConfirmation_BtnUnselectAll(){
    if (language == "french"){return Get_WinFXRateConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button","Désélectionner tout"],10)}//Désélectionner tout
    else {return Get_WinFXRateConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button","Unselect All"],10)}
} 



function Get_WinFXRateConfirmation_BtnContinue(){
    if (language == "french"){return Get_WinFXRateConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button","Continuer"],10)}
    else {return Get_WinFXRateConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button","Continue"],10)}
} 



function Get_WinFXRateConfirmation_BtnCancel(){
    if (language == "french"){return Get_WinFXRateConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button","Annuler"],10)}
    else {return Get_WinFXRateConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button","Cancel"],10)}
} 


function Get_WinFXRateConfirmation_DgvOrderGrid(){return Get_WinFXRateConfirmation().FindChild("Uid", "DataGrid_e262", 10)}

/*
//***********************  Fenêtre Gestionnaire de campagnes  ************************************
//Outils --Gérer les campagnes
//function Get_WinCampaignManager(){ return CroesusApp.Findchild("Uid", "CampaignManager_61ee") }  //Ne fonctionne pas avec le Uid
function Get_WinCampaignManager(){return Aliases.CroesusApp.WPFObject("HwndSource: _campaignManager").WPFObject("_campaignManager")}

function Get_WinCampaignManager_btnAdd(){return Get_WinCampaignManager().FindChild("Uid", "Button_eb10", 10)}

function Get_WinCampaignManager_btnClose(){return Get_WinCampaignManager().FindChild("Uid", "Button_8de6", 10)}


//fenêtre Ajouter campagne
//function Get_WinAddCampaign(){ return CroesusApp.Findchild( "Uid", "CampaignEditor_9c54") }  //Ne fonctionne pas avec le Uid
function Get_WinAddCampaign() {return Aliases.CroesusApp.WPFObject("HwndSource: _campaignEditor").WPFObject("_campaignEditor")}

function Get_WinAddCampaign_Name() {return Get_WinAddCampaign().FindChild("Uid", "LocaleTextbox_44d8", 10)}

function Get_WinAddCampaign_btnClose() {return Get_WinAddCampaign().FindChild("Uid", "Button_f703", 10)}


//Onglet "Target clients"
function Get_WinAddCampaign_TabTargetClients() {return Get_WinAddCampaign().FindChild("Uid", "TabItem_6a57", 10)}

function Get_WinAddCampaign_TabTargetClients_btnAdd() {return Get_WinAddCampaign().FindChild("Uid", "Button_8cb4", 10)}


//Onglet "Activities"
function Get_WinAddCampaign_TabActivities() {return Get_WinAddCampaign().FindChild("Uid", "TabItem_a82c", 10)}

function Get_WinAddCampaign_TabActivities_btnAdd() {return Get_WinAddCampaign().FindChild("Uid", "Button_b6bb", 10)}


//Fenêtre "Ajouter une activité"
function Get_WinAddActivity() {
    if (language == "french")
        return Aliases.CroesusApp.WPFObject("HwndSource: StepWindow", "Ajouter une activité").WPFObject("StepWindow", "Ajouter une activité", 1)
    else
        return Aliases.CroesusApp.WPFObject("HwndSource: StepWindow", "Add an Activity").WPFObject("StepWindow", "Add an Activity", 1)        
}

function Get_WinAddActivity_Media() {return Get_WinAddActivity().FindChild("Uid", "ComboBox_9e60", 10)}

function Get_WinAddActivity_btnCancel() {return Get_WinAddActivity().FindChild("Uid", "Button_a26c", 10)}

function Get_WinAddActivity_btnOK() {return Get_WinAddActivity().FindChild("Uid", "Button_46ae", 10)}


//************************************* FENÊTRE Gabarits de comptes à gestion unifiée   (Unified managed account templates) *************************
//Outils/ Configurations/ Comptes à gestion unifiée
function Get_WinUnifiedManagedAccountTemplates(){return Get_CroesusApp().FindChild("Uid", "ManagerWindow_730e", 10)};

function Get_WinUnifiedManagedAccountTemplates_DgTemplates(){return Get_WinUnifiedManagedAccountTemplates().FindChild("Uid", "DataGrid_010e", 10)};

function Get_WinUnifiedManagedAccountTemplates_BtnAssign(){
    if (language == "french"){return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Associer"],10)}
    else {return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Assign"],10)}
} 

function Get_WinUnifiedManagedAccountTemplates_BtnAdd(){
    if (language == "french"){return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Aj_outer"],10)}
    else {return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","_Add"],10)}
} 

function Get_WinUnifiedManagedAccountTemplates_BtnEdit(){
    if (language == "french"){return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Mo_difier"],10)}
    else {return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","_Edit"],10)}
} 


function Get_WinUnifiedManagedAccountTemplates_BtnDelete(){
    if (language == "french"){return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","S_upprimer"],10)}
    else {return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","De_lete"],10)}
} 

function Get_WinUnifiedManagedAccountTemplates_BtnCopy(){
    if (language == "french"){return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Cop_ier"],10)}
    else {return Get_WinUnifiedManagedAccountTemplates().FindChild(["ClrClassName","WPFControlText"],["Button","Cop_y"],10)}
} 


//************************************* FENÊTRE Ajouter un gabarit de compte à gestion unifiée  (Add a unified managed account template) *************************
//Outils/ Configurations/ Comptes à gestion unifiée
function Get_WinAddUnifiedManagedAccountTemplate(){return Get_CroesusApp().FindChild("Uid", "SleevesManagerWindow_fbcd", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_DgSleeves(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "DataGrid_df77", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_TxtName(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "LocaleTextbox_c0e3", 10)};
        
function Get_WinAddUnifiedManagedAccountTemplate_ChkAutomaticCashManagement(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "CheckBox_af20", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_CmbAccess(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "ComboBox_0b3c", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_BtnAdd(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "Button_9c81", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_BtnDelete(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "Button_e77d", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_BtnEdit(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "Button_39ef", 10)};

function Get_WinAddUnifiedManagedAccountTemplate_BtnSave(){return Get_WinAddUnifiedManagedAccountTemplate().FindChild("Uid", "Button_b82c", 10)};*/



//Ajout de la fonction Get pour le crochet affiché en bas à droite dans les modules Relations, Clients et Comptes
//Date 10/07/2010
// Par Abdel.m
function Get_StatusBarContentSelection(){return Get_CroesusApp().FindChild("Uid", "StatusBarContentSelection", 10)}
function Get_WinQuickSearch_RdoPhone1()
{
  if (language == "french"){return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENT.PHONENUMBER1 - Téléphone 1"], 10)}
  else {return Get_WinQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "CLIENT.PHONENUMBER1 - Telephone 1"], 10)}
}

function Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnEdit()
{
  if (language == "french"){return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild(["ClrClassName", "WPFControlText"], ["Button", "Mo_difier"], 10)}
  else {return Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Edit"] ,10)}
}

//***** Ajout de fonctions Pour les critères de recherches****************************
function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemBalancePercent()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "solde (%)"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "balance (%)"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemLowerThan()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "inférieur(e) à"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "lower than"], 10)}
}

function Get_DlgConfirmation_BtnRestrictions(){return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlName"], ["Button", "PART_Other"], 10)}

function Get_WinCRURestriction_GrpNote(){return Get_WinCRURestriction().FindChild("Uid", "GroupBox_32cb", 10)}

function Get_WinCRURestriction_GrpNote_RdoNote(){return Get_WinCRURestriction_GrpNote().FindChild("Uid", "RadioButton_f0a0", 10)}

function Get_DlgError_BtnRestrictions(){return Get_DlgError().FindChild(["ClrClassName", "WPFControlName"], ["Button", "PART_Other"], 10)}

function Get_WinMain_Btn_SmallChar() {return Aliases.CroesusApp.winMain.WPFObject("SmallFlatImageButton", "", 1)}
function Get_WinMain_Btn_BigChar() {return Aliases.CroesusApp.winMain.WPFObject("SmallFlatImageButton", "", 2)}

function Get_RelationshipsGrid_ChOffside()
{
  if (language=="french"){return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Hors tolérance"], 10)}
  else {return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Offside"], 10)}
}

 
function Get_Toolbar_BtnQuickFilters_ContextMenu_ManagementLevel()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Niveau de gestion", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Management Level", 10)}
}
function Get_Toolbar_BtnQuickFilters_ContextMenu_Offside()
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Hors tolérance", 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild("WPFControlText", "Offside", 10)}
}
//function Get_WinCreateFilter(){
//  return Aliases.CroesusApp.winCreateFilter;
//}

function Get_WinCreateFilter_FieldYes()
{
  if (language == "french"){return Get_WinCreateFilter().FindChild("DisplayText", "Oui", 10)}
  else {return Get_WinCreateFilter().FindChild("DisplayText", "Yes", 10)}
}
function Get_WinCreateFilter_FieldClientProfile()
{
  if (language == "french"){return Get_WinCreateFilter().FindChild("DisplayText", "Profil client", 10)}
  else {return Get_WinCreateFilter().FindChild("DisplayText", "Client Profile", 10)}
}

function Get_WinCreateFilter_FieldIndividual()
{
  if (language == "french"){return Get_WinCreateFilter().FindChild("DisplayText", "Individuel", 10)}
  else {return Get_WinCreateFilter().FindChild("DisplayText", "Individual", 10)}
}

function Get_WinRQS_TabReports_DgvOffsideAccounts_ChManagementLevel()
{
  if (language=="french"){return Get_WinRQS().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Niveau de gestion"], 10)}
  else {return Get_WinRQS().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Management Level"], 10)}
}

function Get_WinRQS_TabReports_DgvOffsideAccounts_ChClientName()
{
  if (language=="french"){return Get_WinRQS().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Nom du client"], 10)}
  else {return Get_WinRQS().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Client name"], 10)}
}

//*****************************************************************************************************************************
// Fonctions Get liées à l'importation des listes manuelles   ********************************************************
function Get_WinSearchCriteriaManager_BtnImportManualList() //no uid
{
  if (language == "french"){return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Importer une liste manuelle"], 10)}
  else {return Get_WinSearchCriteriaManager_PadHeaderBar().FindChild(["ClrClassName", "WPFControlText"], ["Button", "_Import a manual list"], 10)}
}
function Get_WinImportManualList(){ return Get_CroesusApp().WPFObject("HwndSource: _Instance")}
function Get_WinImportManualList_CmbModule(){ return Get_WinImportManualList().FindChild("WPFControlName", "SelectedModule", 10)}
function Get_WinImportManualList_BtnBrowse(){ return Get_WinImportManualList().FindChild("WPFControlName", "BrowseButton", 10)}
function Get_WinImportManualList_BtnImport(){ return Get_WinImportManualList().FindChild("WPFControlName", "ImportButton", 10)}
function Get_WinImportManualList_BtnCancel(){ return Get_WinImportManualList().FindChild("WPFControlName", "CloseButton", 10)}
function Get_DlgOpen_CmbFileName1(){return Aliases.CroesusApp.dlgOpen.Window("ComboBoxEx32", "", 1).Window("ComboBox", "", 1)}
function Get_WinImportManualList_TxtName(){return Get_WinImportManualList().FindChild("WPFControlName", "NameTextBox", 10)}
function Get_DlgWarning_Btn_OK(){return Get_DlgWarning().FindChild(["ClrClassName", "WPFControlName"], ["Button", "PART_OK"], 10)}



/**
    Description: Donne le nom du processus Acrobat par le biais de la base de registre
                 (HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths)
    Résultat: "Acrobat" si la clé "Acrobat.exe" est présente (=> 64 bits)
              "AcroRd32" si la clé "Acrobat.exe" est absente (=> 32 bits)
    Auteur: Christophe Paring
*/
function GetAcrobatProcessName()
{
    var processName = "Acrobat";
    var defaultName = "AcroRd32";
    
    try {
        Storages.Registry("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\App Paths\\" + processName + ".exe", HKEY_LOCAL_MACHINE, AQRT_32_BIT, true);
    }
    catch(excAcroRdProcName) {
        Log.Message("GetAcrobatProcessName(): '" + processName + ".exe' key not found in registry App Paths, Acrobat process name falling back to '" + defaultName + "'. \r\n" + excAcroRdProcName.message, VarToStr(excAcroRdProcName.stack));
        var processName = defaultName;
        excAcroRdProcName = null;
    }
    
    return processName;
}
