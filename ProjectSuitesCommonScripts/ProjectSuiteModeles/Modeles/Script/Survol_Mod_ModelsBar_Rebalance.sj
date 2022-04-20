//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions


/* Description : Dans le module « Modeles ».Afficher la fenêtre « Rééquilibrer » en cliquant sur ToolBar_btnRebalance (D’abord il faut créer un modèle et l’assigner un client ). 
Vérifier la présence des contrôles et des étiquetés dans chaque des 5 étapes de rééquilibrage .*/

 function Survol_Mod_ModelsBar_Rebalance()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
   
  Create_Model("testauto")
   
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Model("testauto")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click()
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click()
  Get_WinPickerWindow_BtnOK().Click() 
  Get_WinAssignToModel_BtnYes().Click()

  Get_Toolbar_BtnRebalance().Click()
  
  //Les points de vérification en français 
   if(language=="french"){Check_Properties_French()}
   //Les points de vérification en anglais 
   else {Check_Properties_English()}
 
  Get_WinRebalance_BtnClose().Click()
  //Get_DlgWarning().Click(158, 90); //EM : Modifié depuis CO: 90-07-22-Be-1
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").WPFObject("MainWindow").WPFObject("contentContainer").WPFObject("tabControl").WPFObject("_currentPad").WPFObject("_bottomGroupBox").WPFObject("_tabCtrl").WPFObject("assignedListView").WPFObject("assigneeDataGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click()
  Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click()
  //Get_DlgCroesus().Click(158, 90); //EM : Modifié depuis CO: 90-07-22-Be-1
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  Get_Toolbar_BtnDelete().Click()
  //Get_DlgCroesus().Click(147, 90); //EM : Modifié depuis CO: 90-07-22-Be-1
  if(Get_DlgConfirmation().Exists){
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);}
  
  Close_Croesus_AltF4()
  Sys.Browser("iexplore").Close() 
}



//Fonctions  (les points de vérification pour les scripts qui testent Rebalance)
function Check_Properties_French()
{

 //***********************************************************PREMIÈRE ÉTAPE***************************************************************
 //**************************************************************************************************************************************** 
 aqObject.CheckProperty(Get_WinRebalance().Title, "OleValue", cmpEqual, "Rééquilibrer");
 //aqObject.CheckProperty(Get_WinRebalance_LblModelName().Text, "OleValue", cmpEqual, "Modèle : ~M-00002-0 CH AMERICAN EQUI");
 
 //LblStepNames et LblStepNumbers
 aqObject.CheckProperty(Get_WinRebalance_LblStep1Name().Text, "OleValue", cmpEqual, "Paramètres");
 aqObject.CheckProperty(Get_WinRebalance_LblStep1Number().Text, "OleValue", cmpEqual, "1");
 aqObject.CheckProperty(Get_WinRebalance_LblStep2Name().Text, "OleValue", cmpEqual, "Portefeuilles à rééquilibrer");
 aqObject.CheckProperty(Get_WinRebalance_LblStep2Number().Text, "OleValue", cmpEqual, "2");
 aqObject.CheckProperty(Get_WinRebalance_LblStep3Name().Text, "OleValue", cmpEqual, "Positions à rééquilibrer");
 aqObject.CheckProperty(Get_WinRebalance_LblStep3Number().Text, "OleValue", cmpEqual, "3");
 aqObject.CheckProperty(Get_WinRebalance_LblStep4Name().Text, "OleValue", cmpEqual, "Portefeuilles projetés");
 aqObject.CheckProperty(Get_WinRebalance_LblStep4Number().Text, "OleValue", cmpEqual, "4");
 aqObject.CheckProperty(Get_WinRebalance_LblStep5Name().Text, "OleValue", cmpEqual, "Ordres à exécuter");
 aqObject.CheckProperty(Get_WinRebalance_LblStep5Number().Text, "OleValue", cmpEqual, "5");
 
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_BarPadHeader().Text, "OleValue", cmpEqual, "Paramètres");
 aqObject.CheckProperty(Get_WinRebalance_BtnClose().Content, "OleValue", cmpEqual, "_Fermer");
 
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_RdoBasedOnTargetValue().Content, "OleValue", cmpEqual, "Selon la valeur cible");
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_RdoBasedOnMarketValue().Content, "OleValue", cmpEqual, "Selon la valeur au marché");
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_LblMinimumOrderAmount().Content, "OleValue", cmpEqual, "Montant minimal par ordre :");
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_LblValidateTargetRange().Content, "OleValue", cmpEqual, "Valider les limites:");
 
 // Rounding Factors
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors().Header, "OleValue", cmpEqual, "Facteurs d'arrondissement");
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblStocks().Content, "OleValue", cmpEqual, "Actions:");
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblCoupons().Content, "OleValue", cmpEqual, "Coupons:");
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblBonds().Content, "OleValue", cmpEqual, "Obligations:");
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblMutualFund().Content, "OleValue", cmpEqual, "Fonds d’investissement:");
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblOptions().Content, "OleValue", cmpEqual, "Options:");
 aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblDebentures().Content, "OleValue", cmpEqual, "Débentures:");
 
 Check_Existence_Of_Controls_Win1()
 

 //***********************************************************DEUXIÈME ÉTAPE*************************************************************** 
 //****************************************************************************************************************************************
 Get_WinRebalance_BtnNext().Click()
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader().Text, "OleValue", cmpEqual, "Portefeuilles à rééquilibrer");
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll().Content, "OleValue", cmpEqual, "Sélectionner tout");
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Content, "OleValue", cmpEqual, "Gestion encaisse");
 
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChName().Content, "OleValue", cmpEqual, "Nom");
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChSleeveDescription().Content, "OleValue", cmpEqual, "Description du segment");
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChNumber().Content, "OleValue", cmpEqual, "Numéro");
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChBalance().Content, "OleValue", cmpEqual, "Solde");
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChCurrency().Content, "OleValue", cmpEqual, "Devise");
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChMargin().Content, "OleValue", cmpEqual, "Marge");
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChTotalValue().Content, "OleValue", cmpEqual, "Valeur totale");
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChCashMgmt().Content, "OleValue", cmpEqual, "Gest. encaisse");
 
 aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_LblNbOfSelectedItems().Content, "OleValue", cmpEqual, "Tous les éléments sont sélectionnés");
 Check_Existence_Of_Controls_Win2()
 
 //***********************************************************TROISIÈME ÉTAPE*************************************************************** 
 //*****************************************************************************************************************************************
 Get_WinRebalance_BtnNext().Click()
 
 Sys.Process("CroesusClient").WPFObject("HwndSource: _resynchronizeParameterWindow").Maximize();
 
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader().Text, "OleValue", cmpEqual, "Positions à rééquilibrer");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll().Content, "OleValue", cmpEqual, "Sélectionner tout");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnAll().Content, "OleValue", cmpEqual, "Tous");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnEditPrices().Content, "OleValue", cmpEqual, "Modifier les prix");
 
 Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().ClickR()
 Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
 
  //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
 Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().ClickR()
 Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
 aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 15);
 
  //les en-têtes des colonnes DefaultConfiguration
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().Content, "OleValue", cmpEqual, "VM cible (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMinTargetPercent().Content, "OleValue", cmpEqual, "Cible min. (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaxTargetPercent().Content, "OleValue", cmpEqual, "Cible max. (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMinMVPercent().Content, "OleValue", cmpEqual, "VM min. (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaxMVPercent().Content, "OleValue", cmpEqual, "VM max. (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChDescription().Content, "OleValue", cmpEqual, "Description");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMarketPrice().Content, "OleValue", cmpEqual, "Prix du marché"); 
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChBasicCategories().Content, "OleValue", cmpEqual, "Catégories de base");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Instrument financier");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChLastUpdate().Content, "OleValue", cmpEqual, "Dernière m.-à-j.");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaturity().Content, "OleValue", cmpEqual, "Échéance");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du titre");
 
 //Faire apparaitre tous les en-têtes des colonnes
 Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().ClickR()
 while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().ClickR()
    }    
    
 Check_Existence_Of_Controls_Win3()
 Sys.Process("CroesusClient").WPFObject("HwndSource: _resynchronizeParameterWindow").Maximize();
 
 //les en-têtes des colonnes
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().Content, "OleValue", cmpEqual, "VM cible (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMinTargetPercent().Content, "OleValue", cmpEqual, "Cible min. (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaxTargetPercent().Content, "OleValue", cmpEqual, "Cible max. (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMinMVPercent().Content, "OleValue", cmpEqual, "VM min. (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaxMVPercent().Content, "OleValue", cmpEqual, "VM max. (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChBid().Content, "OleValue", cmpEqual, "Acheteur");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChBeta().Content, "OleValue", cmpEqual, "Bêta"); 
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChClose().Content, "OleValue", cmpEqual, "Clôture");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChDividend().Content, "OleValue", cmpEqual, "Dividende");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChModifiedDuration().Content, "OleValue", cmpEqual, "Durée modifiée"); 
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChFrequency().Content, "OleValue", cmpEqual, "Fréquence");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChInterest().Content, "OleValue", cmpEqual, "Intérêt");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChRegion().Content, "OleValue", cmpEqual, "Région");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChAssetAllocation().Content, "OleValue", cmpEqual, "Répartition d'actifs");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSector().Content, "OleValue", cmpEqual, "Secteur");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSubcategory().Content, "OleValue", cmpEqual, "Sous-catégorie");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSecurity().Content, "OleValue", cmpEqual, "Titre");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChAsk().Content, "OleValue", cmpEqual, "Vendeur");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChDescription().Content, "OleValue", cmpEqual, "Description");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMarketPrice().Content, "OleValue", cmpEqual, "Prix du marché"); 
 
  Scroll_TabPositionsToRebalance();
  
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChBasicCategories().Content, "OleValue", cmpEqual, "Catégories de base");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Instrument financier");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChLastUpdate().Content, "OleValue", cmpEqual, "Dernière m.-à-j.");
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaturity().Content, "OleValue", cmpEqual, "Échéance");
 
 Scroll_TabPositionsToRebalance();
 
 aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du titre");

 Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().ClickR()
 Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
 
 Check_Existence_Of_Controls_Win3()
   
 //***********************************************************QUATRIÈME ÉTAPE***************************************************************
 //*****************************************************************************************************************************************
  
 Get_WinRebalance_BtnNext().Click()
 
 aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: ProgressCroesusWindow", "Croesus"), "WndCaption", cmpEqual, "Croesus");
 Delay(10000);
 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader().Text, "OleValue", cmpEqual, "Portefeuilles projetés");
 //btns
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd().Content, "OleValue", cmpEqual, "Ajouter");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Content, "OleValue", cmpEqual, "Modifier");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete().Content, "OleValue", cmpEqual, "Supprimer");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Content, "OleValue", cmpEqual, "Grouper");
 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_BtnShowAll().Content, "OleValue", cmpEqual, "Afficher tout");
 
 //Vérification des en têtes des colonnes  
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChRestriction().Content, "OleValue", cmpEqual, "Restriction");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChMessages().Content, "OleValue", cmpEqual, "Message(s)");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChName().Content, "OleValue", cmpEqual, "Nom");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChNo().Content, "OleValue", cmpEqual, "No");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChSleeveDescription().Content, "OleValue", cmpEqual, "Description du segment");
 
 Scroll_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios()
 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChBalance().Content, "OleValue", cmpEqual, "Solde");
 
 Scroll_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios()
 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChMargin().Content, "OleValue", cmpEqual, "Marge");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChTotalValue().Content, "OleValue", cmpEqual, "Valeur totale");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChCurrency().Content, "OleValue", cmpEqual, "Devise");
 
 Scroll_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios()
 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChCashMgmt().Content, "OleValue", cmpEqual, "Gest. encaisse");
 
 //**************************************************************Proposed Orders tab****************************************************
 //**************************************************************btn Block off**********************************************************
 Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click()
 
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Header, "OleValue", cmpEqual, "Ordres proposés");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().Header, "OleValue", cmpEqual, "Message(s) de rééquilibrage");
 
  if(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().IsChecked)
   {
     Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click()
   }
 
 Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().ClickR()
 Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
 
 //les en-têtes des colonnes DefaultConfiguration 
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().Content, "OleValue", cmpEqual, "Inclure");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().Content, "OleValue", cmpEqual, "Nom");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountNo().Content, "OleValue", cmpEqual, "No de compte");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountCurrency().Content, "OleValue", cmpEqual, "Devise du compte");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChType().Content, "OleValue", cmpEqual, "Type");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantité");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceSecurityCurrency().Content, "OleValue", cmpEqual, "Prix selon la devise du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceCurrency().Content, "OleValue", cmpEqual, "Devise du prix"); 
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueSecurityCurrency().Content, "OleValue", cmpEqual, "Valeur au marché selon la devise du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestSecurityCurrency().Content, "OleValue", cmpEqual, "Intérets courus selon la devise du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestAccountCurrency().Content, "OleValue", cmpEqual, "Intérets courus selon la devise du compte");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityDescription().Content, "OleValue", cmpEqual, "Description du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurity().Content, "OleValue", cmpEqual, "Titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRebalDate().Content, "OleValue", cmpEqual, "Date de rééquilibrage");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChBasicCategories().Content, "OleValue", cmpEqual, "Catégories de base");
 
 //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
 Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().ClickR()
 Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
 aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 15);
 
 //Faire apparaitre tous les en-têtes des colonnes 
 Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().ClickR()
 while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().ClickR()
    }
    
 //les en-têtes des colonnes 
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().Content, "OleValue", cmpEqual, "Inclure");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAsk().Content, "OleValue", cmpEqual, "Vendeur");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueAccountCurrency().Content, "OleValue", cmpEqual, "Valeur au marché selon la devise du compte");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSubcategory().Content, "OleValue", cmpEqual, "Sous-catégorie");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRegion().Content, "OleValue", cmpEqual, "Région"); 
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChProjMVPercent().Content, "OleValue", cmpEqual, "Proj. VM (%)");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceAccountCurrency().Content, "OleValue", cmpEqual, "Prix selon la devise du compte");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInterest().Content, "OleValue", cmpEqual, "Intérêt");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Instrument financier");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChFrequency().Content, "OleValue", cmpEqual, "Fréquence");   
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMaturity().Content, "OleValue", cmpEqual, "Échéance");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChDividend().Content, "OleValue", cmpEqual, "Dividende");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChClose().Content, "OleValue", cmpEqual, "Clôture");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChBid().Content, "OleValue", cmpEqual, "Acheteur");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().Content, "OleValue", cmpEqual, "Nom");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountNo().Content, "OleValue", cmpEqual, "No de compte");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountCurrency().Content, "OleValue", cmpEqual, "Devise du compte");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChType().Content, "OleValue", cmpEqual, "Type");
 
 Scroll_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders()
 
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantité");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceSecurityCurrency().Content, "OleValue", cmpEqual, "Prix selon la devise du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceCurrency().Content, "OleValue", cmpEqual, "Devise du prix");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueSecurityCurrency().Content, "OleValue", cmpEqual, "Valeur au marché selon la devise du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestSecurityCurrency().Content, "OleValue", cmpEqual, "Intérets courus selon la devise du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestAccountCurrency().Content, "OleValue", cmpEqual, "Intérets courus selon la devise du compte");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityDescription().Content, "OleValue", cmpEqual, "Description du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurity().Content, "OleValue", cmpEqual, "Titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRebalDate().Content, "OleValue", cmpEqual, "Date de rééquilibrage");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChBasicCategories().Content, "OleValue", cmpEqual, "Catégories de base");
 
 //Remettre la configuration par default 
 Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChBasicCategories().ClickR()
 Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
  
 //**************************************************************btn Block on***********************************************************************
 Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click()
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChType().Content, "OleValue", cmpEqual, "Type");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChQuantity().Content, "OleValue", cmpEqual, "Quantité");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurityDescription().Content, "OleValue", cmpEqual, "Description du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurity().Content, "OleValue", cmpEqual, "Titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChPriceSecurityCurrency().Content, "OleValue", cmpEqual, "Prix selon la devise du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChAccruedInterestSecurityCurrency().Content, "OleValue", cmpEqual, "Intérets courus selon la devise du titre");
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChMarketValueSecurityCurrency().Content, "OleValue", cmpEqual, "Valeur au marché selon la devise du titre");
 
 
 //**********************************************************projected Portfolio tab*******************************************************************
 // ******************************************************the btn By Assert Class off*****************************************************************
 Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click()
 aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Header, "OleValue", cmpEqual, "Portefeuille projeté");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAssetClass().ToolTip, "OleValue", cmpEqual, "Grouper par classe d'actifs");
 
 Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQtyVariation().ClickR()
 Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
 
  //*********************************************************les en-têtes des colonnes DefaultConfiguration**********************************************
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQtyVariation().Content, "OleValue", cmpEqual, "Écart des quantités");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantité");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo().Content, "OleValue", cmpEqual, "No compte");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChName().Content, "OleValue", cmpEqual, "Nom");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChType().Content, "OleValue", cmpEqual, "Type");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChDescription().Content, "OleValue", cmpEqual, "Description");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChLockedPosition().Content, "OleValue", cmpEqual, "Position bloquée");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAssetAllocation().Content, "OleValue", cmpEqual, "Rép. d'actifs");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChACB().Content, "OleValue", cmpEqual, "PBR");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketPrice().Content, "OleValue", cmpEqual, "Prix du marché");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketValue().Content, "OleValue", cmpEqual, "Valeur au marché");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketPrice().Content, "OleValue", cmpEqual, "Prix du marché");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChModDuration().Content, "OleValue", cmpEqual, "Durée mod.");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAnnInc().Content, "OleValue", cmpEqual, "Rev. ann.");
 
  //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
 Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo().ClickR()
 Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
 aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 24);
 
  //Faire apparaitre tous les en-têtes des colonnes 
 Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo().ClickR()
 while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo().ClickR()
    } 
    
//les en-têtes des colonnes
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQtyVariation().Content, "OleValue", cmpEqual, "Écart des quantités");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantité");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo().Content, "OleValue", cmpEqual, "No compte");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAsk().Content, "OleValue", cmpEqual, "Vendeur");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSecurity().Content, "OleValue", cmpEqual, "Titre");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChTelephone2().Content, "OleValue", cmpEqual, "Téléphone 2");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChTelephone1().Content, "OleValue", cmpEqual, "Téléphone 1"); 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSubcategory().Content, "OleValue", cmpEqual, "Sous-catégorie"); 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSector().Content, "OleValue", cmpEqual, "Secteur");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRegion().Content, "OleValue", cmpEqual, "Région"); 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChInterestPortion().Content, "OleValue", cmpEqual, "Portion d'intéret"); 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChClientNo().Content, "OleValue", cmpEqual, "No client");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChInvestCost().Content, "OleValue", cmpEqual, "Invest. unitaire");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Instrument financier");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChFrequency().Content, "OleValue", cmpEqual, "Fréquence");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChExcludeFromProjectedIncome().Content, "OleValue", cmpEqual, "Exclure de la projection de liquidités");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMaturity().Content, "OleValue", cmpEqual, "Échéance");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChDividend().Content, "OleValue", cmpEqual, "Dividende");  
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du titre");
 
 Scroll_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio()
 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChLastBuy().Content, "OleValue", cmpEqual, "Dernier achat");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChClose().Content, "OleValue", cmpEqual, "Clôture");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBasicCategories().Content, "OleValue", cmpEqual, "Catégories de base");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChInvestedCapital().Content, "OleValue", cmpEqual, "Capital investi");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBeta().Content, "OleValue", cmpEqual, "Bêta");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBid().Content, "OleValue", cmpEqual, "Acheteur");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChName().Content, "OleValue", cmpEqual, "Nom");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChType().Content, "OleValue", cmpEqual, "Type");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChDescription().Content, "OleValue", cmpEqual, "Description");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbole"); 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChLockedPosition().Content, "OleValue", cmpEqual, "Position bloquée"); 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAssetAllocation().Content, "OleValue", cmpEqual, "Rép. d'actifs");
 
 Scroll_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio()
 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChACB().Content, "OleValue", cmpEqual, "PBR");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketPrice().Content, "OleValue", cmpEqual, "Prix du marché");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBookValue().Content, "OleValue", cmpEqual, "Valeur comptable");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketValue().Content, "OleValue", cmpEqual, "Valeur au marché");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChModDuration().Content, "OleValue", cmpEqual, "Durée mod.");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAnnInc().Content, "OleValue", cmpEqual, "Rev. ann.");
 
 //********************************************************* the btn By Assert Class on************************************************************************  
 Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAssetClass().Click()
 //les en-têtes des colonnes 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChDescription().Content, "OleValue", cmpEqual, "Description");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChNoOfPositions().Content, "OleValue", cmpEqual, "Nbre de positions");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChInvestedCapital().Content, "OleValue", cmpEqual, "Capital investi");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMarketValue().Content, "OleValue", cmpEqual, "Valeur au marché");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChInvestCapGL().Content, "OleValue", cmpEqual, "G/P cap. investi");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChAccruedID().Content, "OleValue", cmpEqual, "I/D courus");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChAnnInc().Content, "OleValue", cmpEqual, "Rev. ann."); 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChBookValueACB().Content, "OleValue", cmpEqual, "Valeur comptable");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChGLBookValue().Content, "OleValue", cmpEqual, "G/P valeur comptable");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMinObj().Content, "OleValue", cmpEqual, "Obj. min."); 
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMaxObj().Content, "OleValue", cmpEqual, "Obj. max.");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChTargetObj().Content, "OleValue", cmpEqual, "Obj. cible");
 aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChTargetStatus().Content, "OleValue", cmpEqual, "Cible visée");
 
    //summary
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().Header, "OleValue", cmpEqual, "Sommaire");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblMarketValue().Content, "OleValue", cmpEqual, "Valeur au marché:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblBookValue().Content, "OleValue", cmpEqual, "Valeur comptable:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblBalance().Content, "OleValue", cmpEqual, "Solde:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Int./Div. cumulés:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAnnualIncome().Content, "OleValue", cmpEqual, "Revenu annuel:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblBeta().Content, "OleValue", cmpEqual, "Bêta:");
   
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAverageCostYield().Content, "OleValue", cmpEqual, "Rend. à l'achat moyen:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblModDurationAvg() .Content, "OleValue", cmpEqual, "Durée mod. (moy.):");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblNetInvestment().Content, "OleValue", cmpEqual, "Investissement net:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblMargin().Content, "OleValue", cmpEqual, "Marge:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAccumulatedCommission().Content, "OleValue", cmpEqual, "Commissions cumulées:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Int./Div. cumulés:");
   
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAssetAllocation().Text, "OleValue", cmpEqual, "Répartition d'actifs");
  
      
   Check_Existence_Of_Controls_Win4()
 
   //***********************************************************CINQUIÈME ÉTAPE*************************************************************** 
   //*****************************************************************************************************************************************
  Get_WinRebalance_BtnNext().Click()
  
  Get_WinRebalance_TabOrdersToExecute_ChName().ClickR()
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
  
  //*********************************************************les en-têtes des colonnes DefaultConfiguration************************************ 
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChName().Content, "OleValue", cmpEqual, "Nom");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccountNo().Content, "OleValue", cmpEqual, "No de compte");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccountCurrency().Content, "OleValue", cmpEqual, "Devise du compte");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChType().Content, "OleValue", cmpEqual, "Type");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChQuantity().Content, "OleValue", cmpEqual, "Quantité");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChPriceSecurityCurrency().Content, "OleValue", cmpEqual, "Prix selon la devise du titre");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChPriceCurrency().Content, "OleValue", cmpEqual, "Devise du prix");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChMarketValueSecurityCurrency().Content, "OleValue", cmpEqual, "Valeur au marché selon la devise du titre");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccruedInterestAccountCurrency().Content, "OleValue", cmpEqual, "Intérets courus selon la devise du compte");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurityDescription().Content, "OleValue", cmpEqual, "Description du titre");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurity().Content, "OleValue", cmpEqual, "Titre");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du titre");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChRebalDate().Content, "OleValue", cmpEqual, "Date de rééquilibrage");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChBasicCategories().Content, "OleValue", cmpEqual, "Catégories de base");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChRebalanceNo().Content, "OleValue", cmpEqual, "No de rééquilibrage");

  aqObject.CheckProperty(Get_WinRebalance_BtnGenerate().Content, "OleValue", cmpEqual, "Générer");
  
  //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
   Get_WinRebalance_TabOrdersToExecute_ChName().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 15);
   
    //Faire apparaitre tous les en-têtes des colonnes 
   Get_WinRebalance_TabOrdersToExecute_ChName().ClickR()
   while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
      {
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
        //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
        Get_WinRebalance_TabOrdersToExecute_ChName().ClickR()
      }
    
   
   //tous les en-têtes des colonnes    
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChName().Content, "OleValue", cmpEqual, "Nom");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAsk().Content, "OleValue", cmpEqual, "Vendeur");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChMarketValueAccountCurrency().Content, "OleValue", cmpEqual, "Valeur au marché selon la devise du compte");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSubcategory().Content, "OleValue", cmpEqual, "Sous-catégorie"); 
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChRegion().Content, "OleValue", cmpEqual, "Région");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChProjMVPercent().Content, "OleValue", cmpEqual, "Proj. VM (%)");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChPriceAccountCurrency().Content, "OleValue", cmpEqual, "Prix selon la devise du compte");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChInterest().Content, "OleValue", cmpEqual, "Intérêt");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Instrument financier");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChFrequency().Content, "OleValue", cmpEqual, "Fréquence");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChMaturity().Content, "OleValue", cmpEqual, "Échéance");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChDividend().Content, "OleValue", cmpEqual, "Dividende");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChClose().Content, "OleValue", cmpEqual, "Clôture");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChBid().Content, "OleValue", cmpEqual, "Acheteur");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccountNo().Content, "OleValue", cmpEqual, "No de compte");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccountCurrency().Content, "OleValue", cmpEqual, "Devise du compte");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChType().Content, "OleValue", cmpEqual, "Type");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChQuantity().Content, "OleValue", cmpEqual, "Quantité");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChPriceSecurityCurrency().Content, "OleValue", cmpEqual, "Prix selon la devise du titre");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChPriceCurrency().Content, "OleValue", cmpEqual, "Devise du prix");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChMarketValueSecurityCurrency().Content, "OleValue", cmpEqual, "Valeur au marché selon la devise du titre");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccruedInterestAccountCurrency().Content, "OleValue", cmpEqual, "Intérets courus selon la devise du compte");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurityDescription().Content, "OleValue", cmpEqual, "Description du titre");
  
   Scroll_TabOrdersToExecute_DgvOrdersToExecute()
 
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurity().Content, "OleValue", cmpEqual, "Titre");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du titre");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChRebalDate().Content, "OleValue", cmpEqual, "Date de rééquilibrage");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChBasicCategories().Content, "OleValue", cmpEqual, "Catégories de base");

  Check_Existence_Of_Controls_Win5()
}

function Check_Properties_English()
{ 
   //***********************************************************PREMIÈRE ÉTAPE*************************************************************** 
   //**************************************************************************************************************************************** 
   aqObject.CheckProperty(Get_WinRebalance().Title, "OleValue", cmpEqual, "Rebalance");
 
   //LblStepNames et LblStepNumbers
   aqObject.CheckProperty(Get_WinRebalance_LblStep1Name().Text, "OleValue", cmpEqual, "Parameters");
   aqObject.CheckProperty(Get_WinRebalance_LblStep1Number().Text, "OleValue", cmpEqual, "1");
   aqObject.CheckProperty(Get_WinRebalance_LblStep2Name().Text, "OleValue", cmpEqual, "Portfolios to Rebalance");
   aqObject.CheckProperty(Get_WinRebalance_LblStep2Number().Text, "OleValue", cmpEqual, "2");
   aqObject.CheckProperty(Get_WinRebalance_LblStep3Name().Text, "OleValue", cmpEqual, "Positions to Rebalance");
   aqObject.CheckProperty(Get_WinRebalance_LblStep3Number().Text, "OleValue", cmpEqual, "3");
   aqObject.CheckProperty(Get_WinRebalance_LblStep4Name().Text, "OleValue", cmpEqual, "Projected Portfolios");
   aqObject.CheckProperty(Get_WinRebalance_LblStep4Number().Text, "OleValue", cmpEqual, "4");
   aqObject.CheckProperty(Get_WinRebalance_LblStep5Name().Text, "OleValue", cmpEqual, "Orders to Execute");
   aqObject.CheckProperty(Get_WinRebalance_LblStep5Number().Text, "OleValue", cmpEqual, "5");
 
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_BarPadHeader().Text, "OleValue", cmpEqual, "Parameters");
   aqObject.CheckProperty(Get_WinRebalance_BtnClose().Content, "OleValue", cmpEqual, "_Close");
 
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_RdoBasedOnTargetValue().Content, "OleValue", cmpEqual, "Based on Target Value");
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_RdoBasedOnMarketValue().Content, "OleValue", cmpEqual, "Based on Market Value");
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_LblMinimumOrderAmount().Content, "OleValue", cmpEqual, "Minimum Order Amount :");
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_LblValidateTargetRange().Content, "OleValue", cmpEqual, "Validate Target Range:");
 
   // Rounding Factors
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors().Header, "OleValue", cmpEqual, "Rounding Factors");
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblStocks().Content, "OleValue", cmpEqual, "Stocks:");
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblCoupons().Content, "OleValue", cmpEqual, "Coupons:");
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblBonds().Content, "OleValue", cmpEqual, "Bonds:");
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblMutualFund().Content, "OleValue", cmpEqual, "Mutual Fund:");
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblOptions().Content, "OleValue", cmpEqual, "Options:");
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_LblDebentures().Content, "OleValue", cmpEqual, "Debentures:");
   
    Check_Existence_Of_Controls_Win1()
 
   //************************************************************DEUXIÈME ÉTAPE************************************************************* 
   //***************************************************************************************************************************************
   Get_WinRebalance_BtnNext().Click()
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader().Text, "OleValue", cmpEqual, "Portfolios to Rebalance");
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll().Content, "OleValue", cmpEqual, "Select All");
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Content, "OleValue", cmpEqual, "Cash Management");
 
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChName().Content, "OleValue", cmpEqual, "Name");
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChSleeveDescription().Content, "OleValue", cmpEqual, "Sleeve Description");
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChNumber().Content, "OleValue", cmpEqual, "Number");
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChCurrency().Content, "OleValue", cmpEqual, "Currency");
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChBalance().Content, "OleValue", cmpEqual, "Balance");
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChMargin().Content, "OleValue", cmpEqual, "Margin");
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChTotalValue().Content, "OleValue", cmpEqual, "Total Value");
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_ChCashMgmt().Content, "OleValue", cmpEqual, "Cash Mgmt");
 
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_LblNbOfSelectedItems().Content, "OleValue", cmpEqual, "All items have been selected");
   
   Check_Existence_Of_Controls_Win2()
 
  //********************************************************TROISIÈME ÉTAPE*************************************************************** 
  //************************************************************************************************************************************** 
   Get_WinRebalance_BtnNext().Click()
 
   Sys.Process("CroesusClient").WPFObject("HwndSource: _resynchronizeParameterWindow").Maximize();
   
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader().Text, "OleValue", cmpEqual, "Positions to Rebalance");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll().Content, "OleValue", cmpEqual, "Select All");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnAll().Content, "OleValue", cmpEqual, "All");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnEditPrices().Content, "OleValue", cmpEqual, "Edit Prices");
   
   //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
   Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 15);

   Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
 
   //les en-têtes des colonnes DefaultConfiguration
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().Content, "OleValue", cmpEqual, "Target MV (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMinTargetPercent().Content, "OleValue", cmpEqual, "Min. Target (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaxTargetPercent().Content, "OleValue", cmpEqual, "Max. Target (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMinMVPercent().Content, "OleValue", cmpEqual, "Min. MV (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaxMVPercent().Content, "OleValue", cmpEqual, "Max. MV (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChDescription().Content, "OleValue", cmpEqual, "Description");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMarketPrice().Content, "OleValue", cmpEqual, "Market Price");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChBasicCategories().Content, "OleValue", cmpEqual, "Basic Categories");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Financial Instrument");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChLastUpdate().Content, "OleValue", cmpEqual, "Last Update");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaturity().Content, "OleValue", cmpEqual, "Maturity");
    aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency");
 
   //Faire apparaitre tous les en-têtes des colonnes 
   Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().ClickR()
   while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
      {
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
        //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
        Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().ClickR()
      }    
    
   //les en-têtes des colonnes
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().Content, "OleValue", cmpEqual, "Target MV (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMinTargetPercent().Content, "OleValue", cmpEqual, "Min. Target (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaxTargetPercent().Content, "OleValue", cmpEqual, "Max. Target (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMinMVPercent().Content, "OleValue", cmpEqual, "Min. MV (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaxMVPercent().Content, "OleValue", cmpEqual, "Max. MV (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChAsk().Content, "OleValue", cmpEqual, "Ask");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChAssetAllocation().Content, "OleValue", cmpEqual, "Asset Allocation");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChBeta().Content, "OleValue", cmpEqual, "Beta");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChBid().Content, "OleValue", cmpEqual, "Bid");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChClose().Content, "OleValue", cmpEqual, "Close");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP"); 
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChDividend().Content, "OleValue", cmpEqual, "Dividend");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChFrequency().Content, "OleValue", cmpEqual, "Frequency");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChInterest().Content, "OleValue", cmpEqual, "Interest");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChModifiedDuration().Content, "OleValue", cmpEqual, "Modified Duration");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChRegion().Content, "OleValue", cmpEqual, "Region");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSector().Content, "OleValue", cmpEqual, "Sector"); 
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSecurity().Content, "OleValue", cmpEqual, "Security");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSubcategory().Content, "OleValue", cmpEqual, "Subcategory");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChDescription().Content, "OleValue", cmpEqual, "Description");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMarketPrice().Content, "OleValue", cmpEqual, "Market Price");
   
   Scroll_TabPositionsToRebalance();
     
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChBasicCategories().Content, "OleValue", cmpEqual, "Basic Categories");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Financial Instrument");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChLastUpdate().Content, "OleValue", cmpEqual, "Last Update");
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChMaturity().Content, "OleValue", cmpEqual, "Maturity");
   
   Scroll_TabPositionsToRebalance();
   
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency");
 
   Get_WinRebalance_TabPositionsToRebalance_ChTargetMVPercent().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
   Check_Existence_Of_Controls_Win3()
 
  //********************************************************QUATRIÈME ÉTAPE***************************************************************
  //**************************************************************************************************************************************  
   Get_WinRebalance_BtnNext().Click()
   
   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: ProgressCroesusWindow", "Croesus"), "WndCaption", cmpEqual, "Croesus");
   Delay(10000);
   
   //bnts
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader().Text, "OleValue", cmpEqual, "Projected Portfolios");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd().Content, "OleValue", cmpEqual, "Add");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Content, "OleValue", cmpEqual, "Edit");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete().Content, "OleValue", cmpEqual, "Delete");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Content, "OleValue", cmpEqual, "Block");
 
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_BtnShowAll().Content, "OleValue", cmpEqual, "Show All");
     
   //Vérification des en têtes des colonnes   
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChRestriction().Content, "OleValue", cmpEqual, "Restriction");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChMessages().Content, "OleValue", cmpEqual, "Message(s)");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChName().Content, "OleValue", cmpEqual, "Name");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChNo().Content, "OleValue", cmpEqual, "No.");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChSleeveDescription().Content, "OleValue", cmpEqual, "Sleeve Description");
   
   Scroll_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios()
     
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChBalance().Content, "OleValue", cmpEqual, "Balance");
   
   Scroll_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios()  
    
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChMargin().Content, "OleValue", cmpEqual, "Margin");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChTotalValue().Content, "OleValue", cmpEqual, "Total Value");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChCurrency().Content, "OleValue", cmpEqual, "Currency");
   
   Scroll_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios()
   
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_ChCashMgmt().Content, "OleValue", cmpEqual, "Cash Mgmt");
 
   //**************************************************************Proposed Orders tab****************************************************
   //**************************************************************btn Block off**********************************************************
   Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click()
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Header, "OleValue", cmpEqual, "Proposed Orders");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().Header, "OleValue", cmpEqual, "Rebalancing Message(s)");
   
   if(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().IsChecked)
   {
     Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click()
   }
 
   Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
 
   //les en-têtes des colonnes DefaultConfiguration
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().Content, "OleValue", cmpEqual, "Include");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().Content, "OleValue", cmpEqual, "Name");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountNo().Content, "OleValue", cmpEqual, "Account No.");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountCurrency().Content, "OleValue", cmpEqual, "Account Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChType().Content, "OleValue", cmpEqual, "Type");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantity");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceSecurityCurrency().Content, "OleValue", cmpEqual, "Price Security Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceCurrency().Content, "OleValue", cmpEqual, "Price Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueSecurityCurrency().Content, "OleValue", cmpEqual, "Market Value Security Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestSecurityCurrency().Content, "OleValue", cmpEqual, "Accrued Interest Security Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestAccountCurrency().Content, "OleValue", cmpEqual, "Accrued Interest Account Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityDescription().Content, "OleValue", cmpEqual, "Security Description");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurity().Content, "OleValue", cmpEqual, "Security");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRebalDate().Content, "OleValue", cmpEqual, "Rebal. Date");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChBasicCategories().Content, "OleValue", cmpEqual, "Basic Categories");
 
    //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
   Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 15);
   
   //Faire apparaitre tous les en-têtes des colonnes 
   Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().ClickR()
   while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
      {
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
        //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().ClickR()
      }
    
   //tous les en-têtes des colonnes
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().Content, "OleValue", cmpEqual, "Include");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSubcategory().Content, "OleValue", cmpEqual, "Subcategory");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().Content, "OleValue", cmpEqual, "Include");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRegion().Content, "OleValue", cmpEqual, "Region");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChProjMVPercent().Content, "OleValue", cmpEqual, "Proj. MV (%)");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceAccountCurrency().Content, "OleValue", cmpEqual, "Price Account Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMaturity().Content, "OleValue", cmpEqual, "Maturity");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueAccountCurrency().Content, "OleValue", cmpEqual, "Market Value Account Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInterest().Content, "OleValue", cmpEqual, "Interest");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChFrequency().Content, "OleValue", cmpEqual, "Frequency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Financial Instrument");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChDividend().Content, "OleValue", cmpEqual, "Dividend");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChClose().Content, "OleValue", cmpEqual, "Close");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChBid().Content, "OleValue", cmpEqual, "Bid");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAsk().Content, "OleValue", cmpEqual, "Ask");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().Content, "OleValue", cmpEqual, "Name");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountNo().Content, "OleValue", cmpEqual, "Account No.");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccountCurrency().Content, "OleValue", cmpEqual, "Account Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChType().Content, "OleValue", cmpEqual, "Type");
   
   Scroll_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders()
   
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantity");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceSecurityCurrency().Content, "OleValue", cmpEqual, "Price Security Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChPriceCurrency().Content, "OleValue", cmpEqual, "Price Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChMarketValueSecurityCurrency().Content, "OleValue", cmpEqual, "Market Value Security Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestSecurityCurrency().Content, "OleValue", cmpEqual, "Accrued Interest Security Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChAccruedInterestAccountCurrency().Content, "OleValue", cmpEqual, "Accrued Interest Account Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityDescription().Content, "OleValue", cmpEqual, "Security Description");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurity().Content, "OleValue", cmpEqual, "Security");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRebalDate().Content, "OleValue", cmpEqual, "Rebal. Date");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChBasicCategories().Content, "OleValue", cmpEqual, "Basic Categories");
 
   //Remettre la configuration par default 
   Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChBasicCategories().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
   
   //**************************************************************btn Block on***********************************************************************
   Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click()
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChType().Content, "OleValue", cmpEqual, "Type");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChQuantity().Content, "OleValue", cmpEqual, "Quantity");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurityDescription().Content, "OleValue", cmpEqual, "Security Description");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurity().Content, "OleValue", cmpEqual, "Security");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChPriceSecurityCurrency().Content, "OleValue", cmpEqual, "Price Security Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChAccruedInterestSecurityCurrency().Content, "OleValue", cmpEqual, "Accrued Interest Security Currency");
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_ChMarketValueSecurityCurrency().Content, "OleValue", cmpEqual, "Market Value Security Currency");
 
 
   //**********************************************************projected Portfolio tab*******************************************************************
   // ******************************************************the btn By Assert Class off*****************************************************************
   Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click()
   aqObject.CheckProperty( Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Header, "OleValue", cmpEqual, "Projected Portfolio");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAssetClass().ToolTip, "OleValue", cmpEqual, "Group by Asset Class");
  
   Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo().ClickR()
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
 
   //*********************************************************les en-têtes des colonnes DefaultConfiguration**********************************************
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQtyVariation().Content, "OleValue", cmpEqual, "Qty Variation");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantity");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo().Content, "OleValue", cmpEqual, "Account No.");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChName().Content, "OleValue", cmpEqual, "Name");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChType().Content, "OleValue", cmpEqual, "Type");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChDescription().Content, "OleValue", cmpEqual, "Description");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChLockedPosition().Content, "OleValue", cmpEqual, "Locked Position");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAssetAllocation().Content, "OleValue", cmpEqual, "Asset Allocation");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChACB().Content, "OleValue", cmpEqual, "ACB");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketPrice().Content, "OleValue", cmpEqual, "Market Price");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBookValue().Content, "OleValue", cmpEqual, "Book Value");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketValue().Content, "OleValue", cmpEqual, "Market Value");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChModDuration().Content, "OleValue", cmpEqual, "Mod. Duration");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAnnInc().Content, "OleValue", cmpEqual, "Ann. Inc.");
 
   
   //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
   Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 24);
   
   
   //Faire apparaitre tous les en-têtes des colonnes 
   Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo().ClickR()
   while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
      {
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
        //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo().ClickR()
      }
    
   //tous les en-têtes des colonnes  
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQtyVariation().Content, "OleValue", cmpEqual, "Qty Variation");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantity");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAccountNo().Content, "OleValue", cmpEqual, "Account No.");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChTelephone2().Content, "OleValue", cmpEqual, "Telephone 2");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChTelephone1().Content, "OleValue", cmpEqual, "Telephone 1");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSubcategory().Content, "OleValue", cmpEqual, "Subcategory"); 
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSecurity().Content, "OleValue", cmpEqual, "Security");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSector().Content, "OleValue", cmpEqual, "Sector");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRegion().Content, "OleValue", cmpEqual, "Region");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMaturity().Content, "OleValue", cmpEqual, "Maturity");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChLastBuy().Content, "OleValue", cmpEqual, "Last Buy");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChInvestedCapital().Content, "OleValue", cmpEqual, "Invested Capital");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChInvestCost().Content, "OleValue", cmpEqual, "Invest. Cost");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChInterestPortion().Content, "OleValue", cmpEqual, "Interest Portion"); 
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChFrequency().Content, "OleValue", cmpEqual, "Frequency");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Financial Instrument");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChExcludeFromProjectedIncome().Content, "OleValue", cmpEqual, "Exclude from Projected Income");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");
   
   Scroll_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio()
   
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChClose().Content, "OleValue", cmpEqual, "Close");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChClientNo().Content, "OleValue", cmpEqual, "Client No.");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBid().Content, "OleValue", cmpEqual, "Bid");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBeta().Content, "OleValue", cmpEqual, "Beta");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBasicCategories().Content, "OleValue", cmpEqual, "Basic Categories");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAsk().Content, "OleValue", cmpEqual, "Ask");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChName().Content, "OleValue", cmpEqual, "Name");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChType().Content, "OleValue", cmpEqual, "Type");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChDescription().Content, "OleValue", cmpEqual, "Description");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChLockedPosition().Content, "OleValue", cmpEqual, "Locked Position");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAssetAllocation().Content, "OleValue", cmpEqual, "Asset Allocation");
   
   Scroll_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio()
   
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChACB().Content, "OleValue", cmpEqual, "ACB");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketPrice().Content, "OleValue", cmpEqual, "Market Price");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChBookValue().Content, "OleValue", cmpEqual, "Book Value");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMarketValue().Content, "OleValue", cmpEqual, "Market Value");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChModDuration().Content, "OleValue", cmpEqual, "Mod. Duration");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChAnnInc().Content, "OleValue", cmpEqual, "Ann. Inc.");
 
   //********************************************************* the btn By Assert Class on************************************************************************ 
   Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAssetClass().Click()
   //les en-têtes des colonnes 
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChDescription().Content, "OleValue", cmpEqual, "Description");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChNoOfPositions().Content, "OleValue", cmpEqual, "No. of Positions");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChInvestedCapital().Content, "OleValue", cmpEqual, "Invested Capital");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMarketValue().Content, "OleValue", cmpEqual, "Market Value");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChInvestCapGL().Content, "OleValue", cmpEqual, "Invest. Cap. G/L");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChAccruedID().Content, "OleValue", cmpEqual, "Accrued I/D");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChAnnInc().Content, "OleValue", cmpEqual, "Ann. Inc.");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChBookValueACB().Content, "OleValue", cmpEqual, "Book Value ACB");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChGLBookValue().Content, "OleValue", cmpEqual, "G/L Book Value");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMinObj().Content, "OleValue", cmpEqual, "Min. Obj.");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChMaxObj().Content, "OleValue", cmpEqual, "Max. Obj.");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChTargetObj().Content, "OleValue", cmpEqual, "Target Obj.");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOn_ChTargetStatus().Content, "OleValue", cmpEqual, "Target Status");
 
   //summary
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().Header, "OleValue", cmpEqual, "Summary");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblMarketValue().Content, "OleValue", cmpEqual, "Market Value:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblBookValue().Content, "OleValue", cmpEqual, "Book Value:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblBalance().Content, "OleValue", cmpEqual, "Balance:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Accum. Int./Div.:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAnnualIncome().Content, "OleValue", cmpEqual, "Annual Income:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblBeta().Content, "OleValue", cmpEqual, "Beta:");
   
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAverageCostYield().Content, "OleValue", cmpEqual, "Average Cost Yield:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblModDurationAvg() .Content, "OleValue", cmpEqual, "Mod. Duration (Avg.):");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblNetInvestment().Content, "OleValue", cmpEqual, "Net Investment:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblMargin().Content, "OleValue", cmpEqual, "Margin:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAccumulatedCommission().Content, "OleValue", cmpEqual, "Accumulated Commission:");
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Accum. Int./Div.:");
   
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LblAssetAllocation().Text, "OleValue", cmpEqual, "Asset Allocation");
  
      
   Check_Existence_Of_Controls_Win4()
 
    //***********************************************************CINQUIÈME ÉTAPE***************************************************************
    //***************************************************************************************************************************************** 
  Get_WinRebalance_BtnNext().Click()
  
  Get_WinRebalance_TabOrdersToExecute_ChName().ClickR()
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
  
  //*********************************************************les en-têtes des colonnes DefaultConfiguration************************************ 
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChName().Content, "OleValue", cmpEqual, "Name");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccountNo().Content, "OleValue", cmpEqual, "Account No.");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccountCurrency().Content, "OleValue", cmpEqual, "Account Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChType().Content, "OleValue", cmpEqual, "Type");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChQuantity().Content, "OleValue", cmpEqual, "Quantity");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChPriceSecurityCurrency().Content, "OleValue", cmpEqual, "Price Security Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChPriceCurrency().Content, "OleValue", cmpEqual, "Price Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChMarketValueSecurityCurrency().Content, "OleValue", cmpEqual, "Market Value Security Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccruedInterestAccountCurrency().Content, "OleValue", cmpEqual, "Accrued Interest Account Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurityDescription().Content, "OleValue", cmpEqual, "Security Description");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurity().Content, "OleValue", cmpEqual, "Security");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChRebalDate().Content, "OleValue", cmpEqual, "Rebal. Date");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChBasicCategories().Content, "OleValue", cmpEqual, "Basic Categories");
  
   //Vérification du contenue de la liste. Le nombre de colonnes qu’on peut ajouter
   Get_WinRebalance_TabOrdersToExecute_ChName().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
   aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 15);
   
   
   //Faire apparaitre tous les en-têtes des colonnes 
   Get_WinRebalance_TabOrdersToExecute_ChName().ClickR()
   while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
      {
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
        //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
        Get_WinRebalance_TabOrdersToExecute_ChName().ClickR()
      }
    
   //tous les en-têtes des colonnes    
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChName().Content, "OleValue", cmpEqual, "Name");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSubcategory().Content, "OleValue", cmpEqual, "Subcategory");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChRegion().Content, "OleValue", cmpEqual, "Region");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChProjMVPercent().Content, "OleValue", cmpEqual, "Proj. MV (%)");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChPriceAccountCurrency().Content, "OleValue", cmpEqual, "Price Account Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChMaturity().Content, "OleValue", cmpEqual, "Maturity");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChMarketValueAccountCurrency().Content, "OleValue", cmpEqual, "Market Value Account Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChInterest().Content, "OleValue", cmpEqual, "Interest");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChFrequency().Content, "OleValue", cmpEqual, "Frequency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Financial Instrument");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChDividend().Content, "OleValue", cmpEqual, "Dividend");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccountNo().Content, "OleValue", cmpEqual, "Account No.");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChClose().Content, "OleValue", cmpEqual, "Close");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChBid().Content, "OleValue", cmpEqual, "Bid");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAsk().Content, "OleValue", cmpEqual, "Ask");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccountNo().Content, "OleValue", cmpEqual, "Account No.");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccountCurrency().Content, "OleValue", cmpEqual, "Account Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChType().Content, "OleValue", cmpEqual, "Type");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChQuantity().Content, "OleValue", cmpEqual, "Quantity");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChPriceSecurityCurrency().Content, "OleValue", cmpEqual, "Price Security Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChPriceCurrency().Content, "OleValue", cmpEqual, "Price Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChMarketValueSecurityCurrency().Content, "OleValue", cmpEqual, "Market Value Security Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChAccruedInterestAccountCurrency().Content, "OleValue", cmpEqual, "Accrued Interest Account Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurityDescription().Content, "OleValue", cmpEqual, "Security Description");
  
  Scroll_TabOrdersToExecute_DgvOrdersToExecute()
  
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurity().Content, "OleValue", cmpEqual, "Security");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChRebalDate().Content, "OleValue", cmpEqual, "Rebal. Date");
  aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_ChBasicCategories().Content, "OleValue", cmpEqual, "Basic Categories");
   

  aqObject.CheckProperty(Get_WinRebalance_BtnGenerate().Content, "OleValue", cmpEqual, "Generate");
  Check_Existence_Of_Controls_Win5()
 
}

 //PREMIÈRE FENÊTRE
function Check_Existence_Of_Controls_Win1()
{
   aqObject.CheckProperty(Get_WinRebalance_BtnPrevious(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnPrevious(), "IsEnabled", cmpEqual, false);
 
   aqObject.CheckProperty(Get_WinRebalance_BtnClose(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnClose(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_BtnNext(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnNext(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_RdoBasedOnTargetValue(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_RdoBasedOnMarketValue(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_TxtMinimumOrderAmount(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_TxtMinimumOrderAmount(), "IsReadOnly", cmpEqual, false);
 
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_ChkValidateTargetRange(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_ChkValidateTargetRange(), "IsChecked", cmpEqual, false);
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_ChkValidateTargetRange(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtStocks(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtStocks(), "IsReadOnly", cmpEqual, false);
  
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtCoupons(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtCoupons(), "IsReadOnly", cmpEqual, false);
 
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtBonds(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtBonds(), "IsReadOnly", cmpEqual, false);
  
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtMutualFund(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtMutualFund(), "IsReadOnly", cmpEqual, false);
 
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtOptions(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtOptions(), "IsReadOnly", cmpEqual, false);
 
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtDebentures(), "IsVisible", cmpEqual, true); 
   aqObject.CheckProperty(Get_WinRebalance_TabParameters_GrpRoundingFactors_TxtDebentures(), "IsReadOnly", cmpEqual, false); 
  }
  
  //DEUXIÈME FENÊTRE 
  function Check_Existence_Of_Controls_Win2()
{
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_BtnPrevious(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnPrevious(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_BtnClose(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnClose(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_BtnNext(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnNext(), "IsEnabled", cmpEqual, true);
}
 //TROISIÈME FENÊTRE 
function Check_Existence_Of_Controls_Win3()
{
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnAll(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnAll(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnEditPrices(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnEditPrices(), "IsEnabled", cmpEqual, true)
 
   aqObject.CheckProperty(Get_WinRebalance_BtnPrevious(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnPrevious(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_BtnClose(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnClose(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_BtnNext(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnNext(), "IsEnabled", cmpEqual, true);
}

 //QUATRIÈME FENÊTRE 
function Check_Existence_Of_Controls_Win4()
{       
   Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders()
   
   if(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().IsChecked)
   {
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd(), "IsEnabled", cmpEqual, false);
 
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit(), "IsEnabled", cmpEqual, false);
 
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete(), "IsEnabled", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsChecked", cmpEqual, true);
    
    Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click()
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd(), "IsEnabled", cmpEqual, false);
 
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit(), "IsEnabled", cmpEqual, false);
 
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete(), "IsEnabled", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsChecked", cmpEqual, false);
    
   }
   else
   {
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd(), "IsEnabled", cmpEqual, false);
 
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit(), "IsEnabled", cmpEqual, true);
 
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete(), "IsEnabled", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsChecked", cmpEqual, false);
    
    Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd(), "IsEnabled", cmpEqual, false);
 
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit(), "IsEnabled", cmpEqual, false);
 
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete(), "IsEnabled", cmpEqual, false);
    
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock(), "IsChecked", cmpEqual, true);
   }
    
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_BtnShowAll(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_BtnShowAll(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_BtnPrevious(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnPrevious(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_BtnClose(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnClose(), "IsEnabled", cmpEqual, true);
 
   aqObject.CheckProperty(Get_WinRebalance_BtnNext(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnNext(), "IsEnabled", cmpEqual, true);
   
   
   Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click()
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnTreeviewButton(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnTreeviewButton(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_CmbCurrency(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_CmbCurrency(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAssetClass(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAssetClass(), "IsEnabled", cmpEqual, true);
   
   //summary
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBookValue(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBalance(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtAccruedIntDiv(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtAnnualIncome(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBeta(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtAverageCostYield(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtModDurationAvg(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtNetInvestment(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMargin(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbAccumulatedCommission(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbAccumIntDiv(), "IsVisible", cmpEqual, true);
   
   Scroll_TabOrdersToExecute_DgvOrdersToExecute()
   
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation(), "IsEnabled", cmpEqual, true);
   
}

 //CINQUIÈME FENÊTRE
function Check_Existence_Of_Controls_Win5()
{
   aqObject.CheckProperty(Get_WinRebalance_BtnPrevious(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnPrevious(), "IsEnabled", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnClose(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnClose(), "IsEnabled", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnGenerate(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalance_BtnGenerate(), "IsEnabled", cmpEqual, true);
}

//Scroll pour faire apparaitre tous les en-têtes des colonnes PositionsToRebalance
function Scroll_TabPositionsToRebalance()
{
  var ControlWidth=Get_WinRebalance_TabPositionsToRebalance_DgvPositionsToRebalance().get_ActualWidth()
  var ControlHeight=Get_WinRebalance_TabPositionsToRebalance_DgvPositionsToRebalance().get_ActualHeight()
  for (i=1; i<=1; i++) {Get_WinRebalance_TabPositionsToRebalance_DgvPositionsToRebalance().Click(ControlWidth-40, ControlHeight-5)}
}

//Scroll pour faire apparaitre tous les en-têtes des colonnes ProjectedPortfolios
function Scroll_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios()
{
  var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().get_ActualWidth()
  var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().get_ActualHeight()
  for (i=1; i<=1; i++) {Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvProjectedPortfolios().Click(ControlWidth-40, ControlHeight-5)}
}

//Scroll pour faire apparaitre tous les en-têtes des colonnes ProposedOrders
function Scroll_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders()
{
  var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().get_ActualWidth()
  var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().get_ActualHeight()
  Log.Message(ControlWidth)
  Log.Message(ControlHeight)
  for (i=1; i<=1; i++) {Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Click(ControlWidth-40, ControlHeight-5)}
}

//Scroll pour faire apparaitre tous les en-têtes des colonnes ProjectedPortfolio
function Scroll_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio()
{
  var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().get_ActualWidth()
  var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().get_ActualHeight()
  Log.Message(ControlWidth)
  Log.Message(ControlHeight)
  for (i=1; i<=1; i++) {Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Click(ControlWidth-40, ControlHeight-5)}
}

//Scroll pour faire apparaitre tous les en-têtes des colonnes DgvOrdersToExecute (5 etape)
function Scroll_TabOrdersToExecute_DgvOrdersToExecute()
{
  var ControlWidth=Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().get_ActualWidth()
  var ControlHeight=Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().get_ActualHeight()
  Log.Message(ControlWidth)
  Log.Message(ControlHeight)
  for (i=1; i<=1; i++) {Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Click(ControlWidth-40, ControlHeight-5)}
}




