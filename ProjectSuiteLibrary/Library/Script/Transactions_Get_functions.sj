//USEUNIT Common_Get_functions



//**************************** TRANSACTIONS PLUGIN AND PADHEADER ***************************

function Get_TransactionsPlugin(){return NameMapping.Sys.CroesusClient.HwndSource_MainWindow.MainWindow.contentContainer.tabControl}

function Get_TransactionsBar(){return Get_TransactionsPlugin().Find(["ClrClassName", "WPFControlOrdinalNo","VisibleOnScreen"], ["PadHeader", "1",true], 10)}

function Get_TransactionsBar_BtnInfo(){return Get_TransactionsBar().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_TransactionsBar_BtnGainsLosses(){return Get_TransactionsBar().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}

function Get_TransactionsBar_BtnPosition(){return Get_TransactionsBar().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "3"], 10)}

function Get_TransactionsBar_BtnFilter(){return Get_TransactionsBar().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "4"], 10)}

function Get_TransactionsBar_BtnAll(){return Get_TransactionsBar().Find(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", "5"], 10)}

function Get_TransactionsBar_BtnDisplay(){return Get_TransactionsBar().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "6"], 10)}



//**************************** MENU CONTEXTUEL DE TRANSACTIONS (TRANSACTIONS CONTEXTUAL MENU) ***************************

function Get_Transactions_ContextualMenu(){return Get_CroesusApp().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniActionPopupMenu", "1"], 10)}

function Get_Transactions_ContextualMenu_Edit()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Modifier..."], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Edit..."], 10)}
}

function Get_Transactions_ContextualMenu_Detail()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Détail..."], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Detail..."], 10)}
}

function Get_Transactions_ContextualMenu_Add()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Ajouter..."], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Add..."], 10)}
}

function Get_Transactions_ContextualMenu_Delete()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "S_upprimer"], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "De_lete"], 10)}
}

function Get_Transactions_ContextualMenu_Copy()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Co_pier"], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Co_py"], 10)}
}

function Get_Transactions_ContextualMenu_CopyWithHeader()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Cop_ier avec en-tête"], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Copy with _Header"], 10)}
}

function Get_Transactions_ContextualMenu_ExportToFile()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "E_xporter vers fichier..."], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "E_xport to File..."], 10)}
}

function Get_Transactions_ContextualMenu_ExportToMSExcel()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Exporter vers _MS Excel..."], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Export to _MS Excel..."], 10)}
}

function Get_Transactions_ContextualMenu_Info(){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Info..."], 10)}

function Get_Transactions_ContextualMenu_Relationship()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "Re_lation"], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "Relationsh_ip"], 10)}
}

function Get_Transactions_ContextualMenu_Model()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "Modèle"], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "Model"], 10)}
}

function Get_Transactions_ContextualMenu_OrderEntryModule()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "Module de saisie des ordres"], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "Order Entry Module"], 10)}
}

function Get_Transactions_ContextualMenu_SortBy()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "_Trier par"], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "_Sort by"], 10)}
}

function Get_Transactions_ContextualMenu_Functions()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "_Fonctions"], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "_Functions"], 10)}
}

function Get_Transactions_ContextualMenu_Help()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().FindEx(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "_Aide"], 10, true, -1)}
  else {return Get_Transactions_ContextualMenu().FindEx(["ClrClassName", "WPFControlText"], ["UniActionGroupMenu", "_Help"], 10, true, -1)}
}

function Get_Transactions_ContextualMenu_Print()
{
  if (language=="french"){return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Im_primer..."], 10)}
  else {return Get_Transactions_ContextualMenu().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Print..."], 10)}
}

function Get_GridHeader_ContextualMenu_RemoveThisColumn1()
{
 if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Enlever cette colonne"], 10)}
 else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Remove this Column"], 10)}
}

function Get_GridHeader_ContextualMenu_ColumnStatus1()
{
 if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "État de la colonne"], 10)}
 else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniMenu", "Column status"], 10)}
}

function Get_GridHeader_ContextualMenu_ColumnStatus1_FixToTheRight()
{
 if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", "Fixe à droite"], 10)}
 else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", "Fix to the right"], 10)}
}


//Sous-menu de Module de saisie des ordres (Order Entry Module submenu)

function Get_Transactions_ContextualMenu_OrderEntryModule_OrderEntryBuy()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Saisie des ordres - Achat..."], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Order Entry - _Buy..."], 10)}
}

function Get_Transactions_ContextualMenu_OrderEntryModule_OrderEntrySell()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Sa_isie des ordres - Vente.."], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Order Entry - _Sell..."], 10)}
}

function Get_Transactions_ContextualMenu_OrderEntryModule_SwitchBlock()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Échange/Bloc..."], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Switch/Block..."], 10)}
}

//Sous-menu Trier par (Order by submenu)

function Get_Transactions_ContextualMenu_SortBy_AccountNoProcessingDate()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["UniActionToggleMenu", "_No de compte/Date de traitement"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["UniActionToggleMenu", "_Account No./Processing Date"], 10)}
}

function Get_Transactions_ContextualMenu_SortBy_ProcessingDate()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["UniActionToggleMenu", "_Date de traitement"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["UniActionToggleMenu", "Processing _Date"], 10)}
}

//Sous-menu Fonctions (Functions submenu)

function Get_Transactions_ContextualMenu_Functions_Info()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Info"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "I_nfo"], 10)}
}

function Get_Transactions_ContextualMenu_Functions_GainsLosses()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Gains/Pertes"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Gains/Losses"], 10)}
}

function Get_Transactions_ContextualMenu_Functions_Position(){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Position"], 10)}

function Get_Transactions_ContextualMenu_Functions_Filter()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Fi_ltre"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "F_ilter"], 10)}
}

function Get_Transactions_ContextualMenu_Functions_All()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["UniActionToggleMenu", "_Toutes"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["UniActionToggleMenu", "_All"], 10)}
}

function Get_Transactions_ContextualMenu_Functions_Display()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Affich_age"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Displa_y"], 10)}
}

function Get_Transactions_ContextualMenu_Functions_Models()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Modèles"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Models"], 10)}
}

function Get_Transactions_ContextualMenu_Functions_Relationships()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Relations"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Relationships"], 10)}
}

function Get_Transactions_ContextualMenu_Functions_Clients(){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Clients"], 10)}

function Get_Transactions_ContextualMenu_Functions_Accounts()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "C_omptes"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Accounts"], 10)}
}

function Get_Transactions_ContextualMenu_Functions_Portfolio()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Portefeuille"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Portfolio"], 10)}
}

function Get_Transactions_ContextualMenu_Functions_Transactions()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Tr_ansactions"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Transactions"], 10)}
}

function Get_Transactions_ContextualMenu_Functions_Securities()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Titres"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Securities"], 10)}
}

function Get_Transactions_ContextualMenu_Functions_Orders()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Ordres"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "Orders"], 10)}
}

//Sous-menu Aide (Help submenu)

function Get_Transactions_ContextualMenu_Help_ContextSensitiveHelp()
{
  if (language=="french"){return Get_CroesusApp().FindEx(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Aide contextuelle"], 10, true, -1)}
  else {return Get_CroesusApp().FindEx(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "_Context-Sensitive Help"], 10, true, -1)}
}

function Get_Transactions_ContextualMenu_Help_ContentsAndIndex()
{
  if (language=="french"){return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "S_ommaire et index"], 10)}
  else {return Get_CroesusApp().Find(["ClrClassName", "WPFControlText"], ["ActionMenuItem", "C_ontents and Index"], 10)}
}


//*********************************************** TRANSACTIONS LISTVIEW - LISTE DES TRANSACTIONS ****************************************************

function Get_TransactionGridListView(){ return Get_TransactionsPlugin().FindChild("Uid", "FixedColumnListView_1b3e", 10) };

function Get_Transactions_ListView(){return Get_TransactionsPlugin().Find("Uid", "FixedColumnListView_1b3e", 10)}

function Get_Transactions_ListView_ChAcctNo()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "No de compte"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Acct. No."], 10)}
}

function Get_Transactions_ListView_ChProcessing()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Traitement"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Processing"], 10)}
}

function Get_Transactions_ListView_ChTransaction(){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Transaction"], 10)}

function Get_Transactions_ListView_ChIACode()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Code de CP"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "IA Code"], 10)}
}

function Get_Transactions_ListView_ChType(){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Type"], 10)}

function Get_Transactions_ListView_ChSymbol()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Symbole"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Symbol"], 10)}
}

function Get_Transactions_ListView_ChQuantity()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Quantité"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Quantity"], 10)}
}

function Get_Transactions_ListView_ChPrice()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Prix"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Price"], 10)}
}

function Get_Transactions_ListView_ChCurrency()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Devise"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Cur."], 10)}
}

function Get_Transactions_ListView_ChTotal(){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Total"], 10)}

function Get_Transactions_ListView_ChCommission(){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Commission"], 10)}

function Get_Transactions_ListView_ChGainsLosses()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Gains/Pertes"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Gains/Losses"], 10)}
}

function Get_Transactions_ListView_ChAccruedInt()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Int. courus"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Accrued Int."], 10)}
}

function Get_Transactions_ListView_ChFees()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Frais"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Fees"], 10)}
}

function Get_Transactions_ListView_ChCashBalance()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Solde"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Cash Balance"], 10)}
}

function Get_Transactions_ListView_ChDescription(){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Description"], 10)}

function Get_Transactions_ListView_ChInvestCapGL()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "G/P cap. investi"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Invest. Cap. G/L"], 10)}
}

function Get_Transactions_ListView_ChMVInd()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Ind. VM"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "MV Ind."], 10)}
}

function Get_Transactions_ListView_ChManualInvestCost()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Invest. unit. manuel"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Manual Invest. Cost"], 10)}
}

function Get_Transactions_ListView_ChCashFlow()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Mouv. d'enc."], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Cash Flow"], 10)}
}

function Get_Transactions_ListView_ChClientNo()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "No client"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Client No."], 10)}
}

function Get_Transactions_ListView_ChName()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Nom"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Name"], 10)}
}

function Get_Transactions_ListView_ChNote(){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Note"], 10)}

function Get_Transactions_ListView_ChManualACB()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "PBR manuel"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Manual ACB"], 10)}
}
// ajout de la fonction get de chManualUnitCost pour la US
function Get_Transactions_ListView_ChManualUnitCost(){
  if (language=="french"){Log.Warning("Le nom du Manual Unit Cost n'existe pas en français puisque ce champ est spécifique a US et pour la US on se connecte juste en anglais ")}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Manual Unit Cost"], 10)}
}

function Get_Transactions_ListView_ChInterestPortion()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Portion de l'intérêt"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Interest Portion"], 10)}
}

function Get_Transactions_ListView_ChSettlement()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Règlement"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Settlement"], 10)}
}

function Get_Transactions_ListView_ChSource(){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Source"], 10)}

function Get_Transactions_ListView_ChRate()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Taux"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Rate"], 10)}
}

function Get_Transactions_ListView_ChSecurity()
{
  if (language=="french"){return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Titre"], 10)}
  else {return Get_Transactions_ListView().Find(["ClrClassName", "WPFControlText"], ["SortableColumnHeaderDisplay", "Security"], 10)}
}


function Get_Transactions_ListView_PartialAssignation_Image(){
    return Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["Image", 1], 10)
}


//************************************ GROUP BOX INFO TRANSACTION (TRANSACTION INFO GROUP BOX) ********************************************

function Get_Transactions_GrpTransactionInfo(){return Get_TransactionsPlugin().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "1"], 10)}

function Get_Transactions_GrpTransactionInfo_TxtName(){return Get_Transactions_GrpTransactionInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_Transactions_GrpTransactionInfo_TxtAccountNo(){return Get_Transactions_GrpTransactionInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_Transactions_GrpTransactionInfo_TxtIACode(){return Get_Transactions_GrpTransactionInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_Transactions_GrpTransactionInfo_TxtSource(){return Get_Transactions_GrpTransactionInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_Transactions_GrpTransactionInfo_TxtCF(){return Get_Transactions_GrpTransactionInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_Transactions_GrpTransactionInfo_TxtDescription(){return Get_Transactions_GrpTransactionInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}

function Get_Transactions_GrpTransactionInfo_TxtSymbol(){return Get_Transactions_GrpTransactionInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 10)}

function Get_Transactions_GrpTransactionInfo_LblNote(){return Get_Transactions_GrpTransactionInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "8"], 10)}

function Get_Transactions_GrpTransactionInfo_TxtNote(){return Get_Transactions_GrpTransactionInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "9"], 10)}

function Get_Transactions_GrpTransactionInfo_TxtValidQuantity(){return Get_Transactions_GrpTransactionInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "13"], 10)}

function Get_Transactions_GrpTransactionInfo_TxtCommissionIncludedInThePrice(){return Get_Transactions_GrpTransactionInfo().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "15"], 10)}

////************************************ GROUP BOX DÉTAIL (DETAIL GROUP BOX) ********************************************

function Get_Transactions_GrpDetail(){return Get_TransactionsPlugin().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "2"], 10)}

function Get_Transactions_GrpDetail_LblQuantity(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_Transactions_GrpDetail_TxtQuantity(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_Transactions_GrpDetail_LblGainsLosses(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_Transactions_GrpDetail_TxtGainsLosses(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_Transactions_GrpDetail_LblAccruedInt(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_Transactions_GrpDetail_TxtAccruedInt(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}

function Get_Transactions_GrpDetail_LblTransaction(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 10)}

function Get_Transactions_GrpDetail_TxtTransaction(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "8"], 10)}

function Get_Transactions_GrpDetail_LblPrice(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "9"], 10)}

function Get_Transactions_GrpDetail_TxtPrice(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "10"], 10)}

function Get_Transactions_GrpDetail_LblPositionACB(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "12"], 10)}

function Get_Transactions_GrpDetail_TxtPositionACB(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "13"], 10)}

function Get_Transactions_GrpDetail_LblFees(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "14"], 10)}

function Get_Transactions_GrpDetail_TxtFees(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "15"], 10)}

function Get_Transactions_GrpDetail_LblProcessing(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "16"], 10)}

function Get_Transactions_GrpDetail_TxtProcessing(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "17"], 10)}

function Get_Transactions_GrpDetail_LblTotal(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "18"], 10)}

function Get_Transactions_GrpDetail_TxtTotal(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "19"], 10)}

function Get_Transactions_GrpDetail_LblPositionInvCost(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "20"], 10)}

function Get_Transactions_GrpDetail_TxtPositionInvCost(){return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "21"], 10)}

function Get_Transactions_GrpDetail_LblCommission(){if(client=="US")return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "20"], 10)
else return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "22"], 10)}

function Get_Transactions_GrpDetail_TxtCommission(){if(client=="US")return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "21"], 10)
else return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "23"], 10)}

function Get_Transactions_GrpDetail_LblSettlement(){if(client=="US")return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "22"], 10)
else return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "24"], 10)}

function Get_Transactions_GrpDetail_TxtSettlement(){if(client=="US")return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "23"], 10)
else return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "25"], 10)}

function Get_Transactions_GrpDetail_LblExchangeRate(){if(client=="US")return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "12"], 10)
else return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "26"], 10)}

function Get_Transactions_GrpDetail_TxtExchangeRate(){if(client=="US")return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "13"], 10)
else return Get_Transactions_GrpDetail().Find(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "27"], 10) }



//**************************** BOÎTE DE DIALOGUE DÉFINIR LE TYPE D'IMPRESSION - DEFINE PRINTING TYPE DIALOG BOX *************************************

function Get_DlgDefinePrintingType(){return Aliases.CroesusApp.dlgDefinePrintingType}

function Get_DlgDefinePrintingType_RdoStaticNonManageableColumns(){return Get_DlgDefinePrintingType().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RadioButton", "1"], 10)}

function Get_DlgDefinePrintingType_RdoDynamicManageableColumns(){return Get_DlgDefinePrintingType().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RadioButton", "2"], 10)}

function Get_DlgDefinePrintingType_ChkDoNotShowThisDialogBoxAgain(){return Get_DlgDefinePrintingType().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "1"], 10)}

function Get_DlgDefinePrintingType_BtnOK(){return Get_DlgDefinePrintingType().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_DlgDefinePrintingType_BtnCancel(){return Get_DlgDefinePrintingType().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}



//****************************************** FENÊTRE SOMMATION (TRANSACTIONS) - TRANSACTIONS SUM WINDOW **********************************************

function Get_WinTransactionsSum(){return Aliases.CroesusApp.winTransactionsSum}

function Get_WinTransactionsSum_BtnClose(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}


function Get_WinTransactionsSum_LblTransactionsCAD(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinTransactionsSum_LblTransactionsUSD(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinTransactionsSum_LblTransactionsEUR(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinTransactionsSum_LblTotal(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}


function Get_WinTransactionsSum_LblBuy(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADBuy(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDBuy(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "8"], 10)}

function Get_WinTransactionsSum_TxtTransactionsEURBuy(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "9"], 10)}

function Get_WinTransactionsSum_TxtTotalBuy(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "10"], 10)}


function Get_WinTransactionsSum_LblSell(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "11"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADSell(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "12"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDSell(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "13"], 10)}

function Get_WinTransactionsSum_TxtTransactionsEURSell(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "14"], 10)}

function Get_WinTransactionsSum_TxtTotalSell(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "15"], 10)}


function Get_WinTransactionsSum_LblDeposit(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "16"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADDeposit(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "17"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDDeposit(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "18"], 10)}

function Get_WinTransactionsSum_TxtTransactionsEURDeposit(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "19"], 10)}

function Get_WinTransactionsSum_TxtTotalDeposit(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "20"], 10)}


function Get_WinTransactionsSum_LblWithdrawal(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "21"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADWithdrawal(){
  var nb = 22;
  if (client == "CIBC") nb = 18
  return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", nb], 10)}   //"22"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDWithdrawal(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "23"], 10)}

function Get_WinTransactionsSum_TxtTransactionsEURWithdrawal(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "24"], 10)}

function Get_WinTransactionsSum_TxtTotalWithdrawal(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "25"], 10)}


function Get_WinTransactionsSum_LblCommission(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "26"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADCommission(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "27"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDCommission(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "28"], 10)}

function Get_WinTransactionsSum_TxtTransactionsEURCommission(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "29"], 10)}

function Get_WinTransactionsSum_TxtTotalCommission(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "30"], 10)}


function Get_WinTransactionsSum_LblNumberOfTransactions(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "31"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADNumberOfTransactions(){
var nb = 32;
if (client == "CIBC") nb = 26;
return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", nb],10)}    //"32"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDNumberOfTransactions(){
var nb = 33;
if (client == "CIBC") nb = 27;
return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", nb], 10)}  //"33"], 10)}

function Get_WinTransactionsSum_TxtTransactionsEURNumberOfTransactions(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "34"], 10)}

function Get_WinTransactionsSum_TxtTotalNumberOfTransactions(){
var nb = 35;
if (client == "CIBC") nb = 28;
return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", nb], 10)}   //"35"], 10)}

//****************************************** FENÊTRE SOMMATION (TRANSACTIONS) - TRANSACTIONS SUM WINDOW FOR RJ**********************************************


function Get_WinTransactionsSum_LblTransactionsCADRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinTransactionsSum_LblTransactionsUSDRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinTransactionsSum_LblTotalRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}


function Get_WinTransactionsSum_LblBuyRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADBuyRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDBuyRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 10)}

function Get_WinTransactionsSum_TxtTotalBuyRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "8"], 10)}


function Get_WinTransactionsSum_LblSellRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "9"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADSellRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "10"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDSellRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "11"], 10)}

function Get_WinTransactionsSum_TxtTotalSellRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "12"], 10)}


function Get_WinTransactionsSum_LblDepositRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "13"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADDepositRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "14"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDDepositRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "15"], 10)}

function Get_WinTransactionsSum_TxtTotalDepositRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "16"], 10)}


function Get_WinTransactionsSum_LblWithdrawalRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "17"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADWithdrawalRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "18"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDWithdrawalRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "19"], 10)}

function Get_WinTransactionsSum_TxtTotalWithdrawalRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "20"], 10)}


function Get_WinTransactionsSum_LblCommissionRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "21"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADCommissionRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "22"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDCommissionRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "23"], 10)}

function Get_WinTransactionsSum_TxtTotalCommissionRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "24"], 10)}


function Get_WinTransactionsSum_LblNumberOfTransactionsRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "25"], 10)}

function Get_WinTransactionsSum_TxtTransactionsCADNumberOfTransactionsRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "26"], 10)}

function Get_WinTransactionsSum_TxtTransactionsUSDNumberOfTransactionsRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "27"], 10)}

function Get_WinTransactionsSum_TxtTotalNumberOfTransactionsRJ(){return Get_WinTransactionsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "28"], 10)}

//********************* TRANSACTIONS QUICK SEARCH (TRANSACTIONS - RECHERCHER) ***********************************

function Get_WinTransactionsQuickSearch(){return Aliases.CroesusApp.winQuickSearchForTransactions}

function Get_WinTransactionsQuickSearch_LblSearch(){return Get_WinTransactionsQuickSearch().FindChild("Uid", "TextBlock_7c6d", 10)}

function Get_WinTransactionsQuickSearch_TxtSearch(){return Get_WinTransactionsQuickSearch().FindChild("Uid", "TextBox_453e", 10)}

function Get_WinTransactionsQuickSearch_LblIn(){return Get_WinTransactionsQuickSearch().FindChild("Uid", "TextBlock_4864", 10)}

function Get_WinTransactionsQuickSearch_BtnOK(){return Get_WinTransactionsQuickSearch().FindChild("Uid", "Button_5036", 10)}

function Get_WinTransactionsQuickSearch_BtnCancel(){return Get_WinTransactionsQuickSearch().FindChild("Uid", "Button_92c6", 10)}

function Get_WinTransactionsQuickSearch_RdoAccountNo()
{
  if (language=="french"){return Get_WinTransactionsQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "No de compte"], 10)}
  else {return Get_WinTransactionsQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Acct. No."], 10)}
}

function Get_WinTransactionsQuickSearch_RdoType(){return Get_WinTransactionsQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Type"], 10)}

function Get_WinTransactionsQuickSearch_RdoDescription(){return Get_WinTransactionsQuickSearch().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "Description"], 10)}


//********************* TRANSACTIONS INFO WINDOW (FENÊTRE INFO TRANSACTION) ***********************************

function Get_WinTransactionsInfo(){return Aliases.CroesusApp.winTransactionsInfo}


function Get_WinTransactionsInfo_LblType(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 0)}

function Get_WinTransactionsInfo_CmbType(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 0)}

function Get_WinTransactionsInfo_ChkCancelled(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "1"], 0)}

function Get_WinTransactionsInfo_ChkMatched(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "3"], 0)}

function Get_WinTransactionsInfo_ChkOnBalance(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "5"], 0)}

function Get_WinTransactionsInfo_LblDescription(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 0)}

function Get_WinTransactionsInfo_TxtDescription(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 0)}


function Get_WinTransactionsInfo_AccountsSeparator(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TitledSeparator", "1"], 0)}

function Get_WinTransactionsInfo_LblFromAccount(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 0)}

function Get_WinTransactionsInfo_TxtFromAccount(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 0)}

function Get_WinTransactionsInfo_BtnFromAccount(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 0)}

function Get_WinTransactionsInfo_LblFor(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 0)}

function Get_WinTransactionsInfo_TxtFor(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 0)}

function Get_WinTransactionsInfo_LblToAccount(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 0)}

function Get_WinTransactionsInfo_TxtToAccount(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 0)}

function Get_WinTransactionsInfo_BtnToAccount(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 0)}

function Get_WinTransactionsInfo_LblTo(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 0)}

function Get_WinTransactionsInfo_TxtTo(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "8"], 0)}


function Get_WinTransactionsInfo_SecuritySeparator(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TitledSeparator", "2"], 0)}

function Get_WinTransactionsInfo_LblSecurityOrCUSIP(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "9"], 0)}

function Get_WinTransactionsInfo_TxtSecurityOrCUSIP(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "4"], 0)}

function Get_WinTransactionsInfo_BtnSecurityOrCUSIP(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "3"], 0)}

function Get_WinTransactionsInfo_ChkDRIP(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "8"], 0)}

function Get_WinTransactionsInfo_TxtSecurityDescription(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "10"], 0)}

function Get_WinTransactionsInfo_LblDividends(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "11"], 0)}

function Get_WinTransactionsInfo_TxtDividends(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 0)}

function Get_WinTransactionsInfo_CmbDividendsCurrency(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 0)}


function Get_WinTransactionsInfo_DatesSeparator(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TitledSeparator", "3"], 0)}

function Get_WinTransactionsInfo_LblTransaction(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "15"], 0)}

function Get_WinTransactionsInfo_DtpTransaction(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 0)}

function Get_WinTransactionsInfo_LblSettlement(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "18"], 0)}

function Get_WinTransactionsInfo_DtpSettlement(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 0)}

function Get_WinTransactionsInfo_LblCompounded(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "16"], 0)}

//function Get_WinTransactionsInfo_TxtCompounded(){} // Je n'ai pas trouvé de transaction qui a cette donnée

function Get_WinTransactionsInfo_LblPaid(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "19"], 0)}

function Get_WinTransactionsInfo_TxtPaid(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "20"], 0)}


function Get_WinTransactionsInfo_LblNote(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "21"], 0)}

function Get_WinTransactionsInfo_TxtNote(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextArea", "1"], 0)}

function Get_WinTransactionsInfo_BtnSeparate(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "4"], 0)}

function Get_WinTransactionsInfo_BtnReassign(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "5"], 0)}

function Get_WinTransactionsInfo_BtnOK(){
if(client == "US" ){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "6"], 0)}
else{
return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "5"], 0)}}//YR "6" dans 90-04-32

function Get_WinTransactionsInfo_BtnCancel(){if(client == "US" ){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "7"], 0)}else {return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "6"], 0)}}


//Onglet Montants (Amounts tab)

function Get_WinTransactionsInfo_TabAmounts(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TabItem", "1"], 10)}

function Get_WinTransactionsInfo_TabAmounts_LblQuantity(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinTransactionsInfo_TabAmounts_CmbQuantity(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "1"], 10)}

function Get_WinTransactionsInfo_TabAmounts_LblAtSymbol(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinTransactionsInfo_TabAmounts_CmbCost(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "2"], 10)}

function Get_WinTransactionsInfo_TabAmounts_CmbCostCurrency(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}

function Get_WinTransactionsInfo_TabAmounts_LblGrossAmount(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtGrossAmount(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtGrossAmountCurrency(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)}

function Get_WinTransactionsInfo_TabAmounts_LblRate(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)}

function Get_WinTransactionsInfo_TabAmounts_CmbRate(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "3"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtCurrenciesFromTo(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}

function Get_WinTransactionsInfo_TabAmounts_LblAccruedInterest(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 10)}

function Get_WinTransactionsInfo_TabAmounts_CmbAccruedInterest(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "4"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtAccruedInterestCurrency(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "8"], 10)}

function Get_WinTransactionsInfo_TabAmounts_LblCommission(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "9"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtCommission(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}

function Get_WinTransactionsInfo_TabAmounts_CmbCommissionType(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

function Get_WinTransactionsInfo_TabAmounts_ChkIncludedInThePrice(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "1"], 10)}

function Get_WinTransactionsInfo_TabAmounts_LblCommissionPercent(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "10"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtCommissionPercent(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "11"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtCommissionCurrency(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "12"], 10)}

function Get_WinTransactionsInfo_TabAmounts_LblFees(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "13"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtFees(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "3"], 10)}

function Get_WinTransactionsInfo_TabAmounts_LblFeesAndComm(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "15"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtFeesAndComm(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "5"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtFeesAndCommCurrency(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "15"], 10)}

function Get_WinTransactionsInfo_TabAmounts_LblNetAmount(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "20"], 10)}

function Get_WinTransactionsInfo_TabAmounts_CmbNetAmount(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "5"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtNetAmountCurrency(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "20"], 10)}

function Get_WinTransactionsInfo_TabAmounts_LblCashFlow(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "24"], 10)}

function Get_WinTransactionsInfo_TabAmounts_TxtCashFlow(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "7"], 10)}

function Get_WinTransactionsInfo_TabAmounts_ChkCashFlow(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "2"], 10)}


//Onglet Gains/Pertes (Gains/Losses tab)

function Get_WinTransactionsInfo_TabGainsLosses(){return Get_WinTransactionsInfo().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TabItem", "2"], 10)}


function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "1"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblCalculated(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_ChkCalculated(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "1"], 10)}

//Fonction get pour label Unit Cost pour US
function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblUnitCost(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblInvestCost(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblACB(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblPositionCost(){if(client=="US")return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "3"], 10)
else return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10) }

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblManualCost(){if(client=="US")return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "4"], 10)
else return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10) }

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblGainsLosses(){if(client=="US")return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "5"], 10)
else return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "6"], 10)}
//fonctions get spécifiques a US
function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnitCostPositionCost(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnitCostManualCost(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnitCostGainsLosses(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "3"], 10)}


function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInvestCostPositionCost(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBPositionCost(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInvestCostManualCost(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "3"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBManualCost(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "4"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInvestCostGainsLosses(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "5"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBGainsLosses(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "6"], 10)}

//Seulement pour le type Vente
function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblInterestPortion(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "7"], 10)}

//Seulement pour le type Vente
function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInterestPortion(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "7"], 10)}




function Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous(){return Get_WinTransactionsInfo().FindChild("ClrClassName", "ClassicTabControl", 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "2"], 10)}

//Seulement pour le type Vente
function Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous_LblCostYield(){return Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

//Seulement pour le type Vente
function Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous_TxtCostYield(){return Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous_LblLastBuy(){return Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous_DtpLastBuy(){return Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

//Seulement pour le type Vente
function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblUnassignedQty(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "10"], 10)}

//Seulement pour le type Vente
function Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnassignedQty(){return Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "8"], 10)}



// SEPARATE WINDOW

function Get_WinSeparate(){return NameMapping.Sys.CroesusClient.HwndSource_window.winSeparate}

function Get_WinSeperate_SeperatedQuantities(){return Get_WinSeparate().FindChild("Uid", "GroupBox_2e0b", 2)}

function Get_WinSeperate_SeperatedQuantities_Grid(){return Get_WinSeperate_SeperatedQuantities().WPFObject("_secondaryLots").WPFObject("RecordListControl", "", 1)}

function Get_WinSeperate_SeperatedQuantities_BtnSave(){return Get_WinSeparate().FindChild("Uid", "Button_253a", 2)}

function Get_WinSeperate_SeperatedQuantities_BtnCancel(){return Get_WinSeparate().FindChild("Uid", "Button_5be2", 2)}




//********************* FILTER WINDOW (FENÊTRE FILTRE) ***********************************

function Get_WinFilter(){return Aliases.CroesusApp.winFilter}


function Get_WinFilter_GrpAccount(){return Get_WinFilter().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "1"], 10)}

function Get_WinFilter_GrpAccount_TxtAccount(){return Get_WinFilter_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

function Get_WinFilter_GrpAccount_BtnAccount(){return Get_WinFilter_GrpAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}


function Get_WinFilter_GrpProcessingDate(){return Get_WinFilter().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "2"], 10)}

function Get_WinFilter_GrpProcessingDate_LblStart(){return Get_WinFilter_GrpProcessingDate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "1"], 10)}

function Get_WinFilter_GrpProcessingDate_DtpStart(){return Get_WinFilter_GrpProcessingDate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}

function Get_WinFilter_GrpProcessingDate_LblEnd(){return Get_WinFilter_GrpProcessingDate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniLabel", "2"], 10)}

function Get_WinFilter_GrpProcessingDate_DtpEnd(){return Get_WinFilter_GrpProcessingDate().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 10)}


function Get_WinFilter_GrpType(){return Get_WinFilter().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniGroupBox", "3"], 10)}

function Get_WinFilter_GrpType_ChkAdjustment()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Ajustement"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Adjustment"], 10)}
}

function Get_WinFilter_GrpType_ChkAssignment()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Assignation"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Assignment"], 10)}
}

function Get_WinFilter_GrpType_ChkBookValue()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Valeur comptable"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Book Value"], 10)}
}

function Get_WinFilter_GrpType_ChkBookValueAdj()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Ajustement val. compt."], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Book Value Adj."], 10)}
}

function Get_WinFilter_GrpType_ChkBuy()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Achat"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Buy"], 10)}
}

function Get_WinFilter_GrpType_ChkContribution()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Cotisation"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Contribution"], 10)}
}

function Get_WinFilter_GrpType_ChkCorrection()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Correction"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Correction"], 10)}
}

function Get_WinFilter_GrpType_ChkDelivery()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Livraison"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Delivery"], 10)}
}

function Get_WinFilter_GrpType_ChkDeposit()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Dépôt"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Deposit"], 10)}
}

function Get_WinFilter_GrpType_ChkDepositoryFee()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Frais déposit."], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Depository fee"], 10)}
}

function Get_WinFilter_GrpType_ChkDividends()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Dividendes"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Dividends"], 10)}
}

function Get_WinFilter_GrpType_ChkDonation()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Don de titres"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Donation"], 10)}
}

function Get_WinFilter_GrpType_ChkExchange()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Échange"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Exchange"], 10)}
}

function Get_WinFilter_GrpType_ChkExercise()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Exercice"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Exercise"], 10)}
}

function Get_WinFilter_GrpType_ChkExpiration(){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Expiration"], 10)}

function Get_WinFilter_GrpType_ChkFees()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Frais"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Fees"], 10)}
}

function Get_WinFilter_GrpType_ChkGST()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "TPS"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "GST"], 10)}
}

function Get_WinFilter_GrpType_ChkGrossAmount()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Montant brut"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Gross Amount"], 10)}
}

function Get_WinFilter_GrpType_ChkHST()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "TVH"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "HST"], 10)}
}

function Get_WinFilter_GrpType_ChkInterest()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Intérêts"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Interest"], 10)}
}

function Get_WinFilter_GrpType_ChkJournalEntry()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Journal"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Journal Entry"], 10)}
}

function Get_WinFilter_GrpType_ChkManagementFee()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Frais de gestion"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Management Fee"], 10)}
}

function Get_WinFilter_GrpType_ChkMiscellaneous()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Divers"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Miscellaneous"], 10)}
}

function Get_WinFilter_GrpType_ChkNonResidentTax()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Imp. non résident"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Non-Resident tax"], 10)}
}

function Get_WinFilter_GrpType_ChkPST()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "TVP"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "PST"], 10)}
}

function Get_WinFilter_GrpType_ChkReceipt()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Réception"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Receipt"], 10)}
}

function Get_WinFilter_GrpType_ChkRedemption()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Remboursement"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Redemption"], 10)}
}

function Get_WinFilter_GrpType_ChkSell()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Vente"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Sell"], 10)}
}

function Get_WinFilter_GrpType_ChkSplit()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Fractionnement"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Split"], 10)}
}

function Get_WinFilter_GrpType_ChkSubstitution(){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Substitution"], 10)}

function Get_WinFilter_GrpType_ChkTransfer()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Transfert"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Transfer"], 10)}
}

function Get_WinFilter_GrpType_ChkTransferDisposition()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Disposition"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Transfer Disposition"], 10)}
}

function Get_WinFilter_GrpType_ChkWithdrawal()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Retrait"], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Withdrawal"], 10)}
}

function Get_WinFilter_GrpType_ChkWitholdingTax()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Impôt retenu"], 10)}
    else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Withholding tax"], 10)}//SA: 90-04-78 (US)Modification suite a la correction de l'anomalie CROES-3652
}

function Get_WinFilter_GrpType_ChkCashFlow()
{
  if (language=="french"){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Mouv. enc."], 10)}
  else {return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckBox", "Cash Flow"], 10)}
}

function Get_WinFilter_GrpType_BtnSelectAll(){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinFilter_GrpType_BtnRemoveAll(){return Get_WinFilter_GrpType().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}


function Get_WinFilter_BtnOK(){return Get_WinFilter().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinFilter_BtnCancel(){return Get_WinFilter().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}

function Get_WinFilter_BtnApply(){return Get_WinFilter().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "3"], 10)}


//****************************************************WINDOW MODIFIY A POSITION*****************************************************************

function Get_WinModifyPosition(){return Aliases.CroesusApp.winPositionInfo}

function Get_WinModifyPosition_BtnOK(){return Get_WinModifyPosition().FindChild("Uid", "Button_11da", 10)} //ok

function Get_WinModifyPosition_BtnCancel(){return Get_WinModifyPosition().FindChild("Uid", "Button_dee6", 10)} //ok

function Get_WinModifyPosition_CmbCompte(){return Get_WinModifyPosition().FindChild("Uid", "ComboBox_3ae5", 10)} //ok

function Get_WinModifyPosition_GrpPositionInformation(){return Get_WinModifyPosition().FindChild("Uid", "GroupBox_202c", 10)}

function Get_WinModifyPosition_GrpPositionInformation_TxtMarketPrice(){return Get_WinModifyPosition().FindChild("Uid", "DoubleTextBox_3815", 10)}

function Get_WinModifyPosition_GrpPositionInformation_TxtQtyVariation(){return Get_WinModifyPosition().FindChild("Uid", "DoubleTextBox_8b23", 10)}

function Get_WinModifyPosition_GrpPositionInformation_TxtProjectedQuantity(){return Get_WinModifyPosition().FindChild("Uid", "DoubleTextBox_d06d", 10)}



//*********************  WINDOW Ajout d'une Transaction  (FENÊTRE TRANSACTION) ***********************************

function Get_WinAddTransaction(){return Aliases.CroesusApp.winAddTransaction}

//Groupe Type
function Get_WinAddTransaction_GrpType_cmbType(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}
function Get_WinAddTransaction_GrpType_TxtDescription(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

//Groupe Account
function Get_WinAddTransaction_GrpAccounts_TxtFromAccount(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}
function Get_WinAddTransaction_GrpAccounts_BtnFromAccount(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinAddTransaction_GrpAccounts_TxtToAccount(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}
function Get_WinAddTransaction_GrpAccounts_BtnToAccount(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}

//Groupe Security
function Get_WinAddTransaction_GrpSecurity_TxtSecurity(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "4"], 10)}
function Get_WinAddTransaction_GrpSecurity_BtnSecurity(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "3"], 10)}
function Get_WinAddTransaction_GrpSecurity_chkDRIP(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "7"], 10)}

function Get_WinAddTransaction_GrpSecurity_TxtDividents(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "5"], 10)}
function Get_WinAddTransaction_GrpSecurity_cmbCurrency(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

//Groupe Dates
function Get_WinAddTransaction_GrpDates_TxtTransaction(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}
function Get_WinAddTransaction_GrpDates_TxtSettlement(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 10)}

//Groupe Amounts
function Get_WinAddTransaction_GrpAmounts_TxtQuantity(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "1"], 10)}
function Get_WinAddTransaction_GrpAmounts_TxtPrix(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "2"], 10)}
function Get_WinAddTransaction_GrpAmounts_cmbCurrency(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "3"], 10)}
function Get_WinAddTransaction_GrpAmounts_TxtPrixBrut(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "1"], 10)}
function Get_WinAddTransaction_GrpAmounts_TxtTaux(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "3"], 10)}
function Get_WinAddTransaction_GrpAmounts_TxtInteret(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "4"], 10)}
function Get_WinAddTransaction_GrpAmounts_TxtCommission(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}
function Get_WinAddTransaction_GrpAmounts_TxtFrais(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "3"], 10)}
function Get_WinAddTransaction_GrpAmounts_TxtFraisComm(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "4"], 10)}
function Get_WinAddTransaction_GrpAmounts_TxtMontantNet(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "5"], 10)}
function Get_WinAddTransaction_GrpAmounts_TxtNote(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextArea", "1"], 10)}


function Get_WinAddTransaction_BtnOK(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "5"], 10)}
function Get_WinAddTransaction_BtnCancel(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "6"], 10)}
function Get_WinAddTransaction_BtnSeparate(){return Get_WinAddTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "4"], 10)}




function Get_WinAccounts(){return Aliases.CroesusApp.winAccounts}
function Get_WinAccounts_BtnCptOK(){return Get_WinAccounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}




//*********************  WINDOW Edit d'une Transaction  (FENÊTRE TRANSACTION) ***********************************

function Get_WinEditTransaction(){return Aliases.CroesusApp.winEditTransaction}

//Groupe Type
function Get_WinEditTransaction_GrpType_cmbType(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}
function Get_WinEditTransaction_GrpType_TxtDescription(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "1"], 10)}

//Groupe Account
function Get_WinEditTransaction_GrpAccounts_TxtFromAccount(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "2"], 10)}
function Get_WinEditTransaction_GrpAccounts_BtnFromAccount(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}

function Get_WinEditTransaction_GrpAccounts_TxtToAccount(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "3"], 10)}
function Get_WinEditTransaction_GrpAccounts_BtnToAccount(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "2"], 10)}

//Groupe Security
function Get_WinEditTransaction_GrpSecurity_TxtSecurity(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "4"], 10)}
function Get_WinEditTransaction_GrpSecurity_BtnSecurity(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "3"], 10)}
function Get_WinEditTransaction_GrpSecurity_chkDRIP(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckBox", "7"], 10)}

function Get_WinEditTransaction_GrpSecurity_TxtDividents(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniTextField", "5"], 10)}
function Get_WinEditTransaction_GrpSecurity_cmbCurrency(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "2"], 10)}

//Groupe Dates
function Get_WinEditTransaction_GrpDates_TxtTransaction(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "1"], 10)}
function Get_WinEditTransaction_GrpDates_TxtSettlement(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", "2"], 10)}

//Groupe Amounts
function Get_WinEditTransaction_GrpAmounts(){return Aliases.CroesusApp.winEditTransaction.WPFObject("ClassicTabControl", "", 1)}
function Get_WinEditTransaction_GrpAmounts_TxtQuantity(){return Get_WinEditTransaction_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "1"], 10)}
function Get_WinEditTransaction_GrpAmounts_TxtPrix(){return Get_WinEditTransaction_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleCombo", "2"], 10)}
function Get_WinEditTransaction_GrpAmounts_cmbCurrency(){return Get_WinEditTransaction_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "1"], 10)}
function Get_WinEditTransaction_GrpAmounts_TxtCommission(){return Get_WinEditTransaction_GrpAmounts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBoxPS", "2"], 10)}


function Get_WinEditTransaction_BtnOK(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "5"], 10)}
function Get_WinEditTransaction_BtnCancel(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "6"], 10)}
function Get_WinEditTransaction_BtnSeparate(){return Get_WinEditTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "4"], 10)}


//*********************  WINDOW Delete d'une Transaction  (FENÊTRE TRANSACTION) ***********************************

function Get_WinDeleteTransaction(){return Aliases.CroesusApp.winDetailedInfoForRelationshipAndClient}

function Get_WinDeleteTransaction_GrpAction_rdoAnnulled(){return Get_WinDeleteTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RadioButton", "1"], 10)}
function Get_WinDeleteTransaction_GrpAction_rdoDelete(){return Get_WinDeleteTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RadioButton", "2"], 10)}

function Get_WinDeleteTransaction_GrpAction_BtnOK(){return Get_WinDeleteTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}
function Get_WinDeleteTransaction_GrpAction_BtnCancel(){return Get_WinDeleteTransaction().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10)}





function GetAllDisplayedTransactionsNumbers()
{
    var isEndOfGriReached = false;
    var arrayOfAllDisplayedAccountsNumbers = new Array();
    Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, 50);
    
    while (!isEndOfGriReached){
        accountsPageCount = Get_Transactions_ListView().Items.get_Count();
        
        for (var i = 0; i < accountsPageCount; i++){
            displayedAccountNumber = VarToStr(Get_Transactions_ListView().Items.Item(i).DataItem.get_AccountNumber());
            if (GetIndexOfItemInArray(arrayOfAllDisplayedAccountsNumbers, displayedAccountNumber) == -1)
                arrayOfAllDisplayedAccountsNumbers.push(displayedAccountNumber);
        }

        var firstRowAccountBeforeScroll = VarToStr(Get_Transactions_ListView().Items.Item(0).DataItem.get_AccountNumber());
        Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, Get_Transactions_ListView().Height - 40);
        var firstRowAccountAfterScroll = VarToStr(Get_Transactions_ListView().Items.Item(0).DataItem.get_AccountNumber());
        
        if (firstRowAccountBeforeScroll == firstRowAccountAfterScroll){
            Get_Transactions_ListView().Click(Get_Transactions_ListView().Width - 10, Get_Transactions_ListView().Height - 40);
            firstRowAccountAfterScroll = VarToStr(Get_Transactions_ListView().Items.Item(0).DataItem.get_AccountNumber());
        }
        
        isEndOfGriReached = (firstRowAccountBeforeScroll == firstRowAccountAfterScroll);
    }
    
    return arrayOfAllDisplayedAccountsNumbers;
}




