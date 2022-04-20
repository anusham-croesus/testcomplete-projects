//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

/* Description : Aller au module "Modeles". Vérifier la présence des contrôles, des étiquetés et des en-têtes de colonnes  
dans la partie de détail, en cliquant sur chaque onglet  */

function Survol_Mod_MainWin_Details_FirmModel()
{
  var type="firmModel";
  
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
  WaitObject(Get_CroesusApp(), "Uid", "ModelListView_6fed");
  
  if (client == "BNC"){ 
    if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Model("~M-0000D-0")}
    else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  }
  else if(client == "US" || client == "CIBC"){
     if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Model("~M-0000J-0")}
    else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  } 
  else{
    if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){SearchModelByName("SUSBS_BASIC")}
    else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  }
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French(type)}    
  //Les points de vérification en anglais 
   else {Check_Properties_English(type)}
   
   Check_Existence_Of_Controls(type)
 
   Close_Croesus_AltF4()
}


//Fonctions  (les points de vérification pour les scripts qui testent la partie de Details Dans la fenêtre principal du module Modèle)
function Check_Properties_French(type)
{
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
    aqObject.CheckProperty(Get_Models_Details().Header, "OleValue", cmpEqual, "Détails");
  
    //*****************************************************L’ONGLET ASSIGNED PORTFOLIOS********************************************************
    Get_Models_Details_TabAssignedPortfolios().Click()
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios().Header, "OleValue", cmpEqual, "Portefeuilles associés"); //CROES-5067 
    Log.Message("CROES-5067")
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ToolBar_LblFilter().Content, "OleValue", cmpEqual, "Filtre:");
  
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DdlAssign().Header, "OleValue", cmpEqual, "Associer"); //CROES-5067 
    Log.Message("CROES-5067")
    Log.Message("CROES-9139")
    
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_BtnRemove().Content, "OleValue", cmpEqual, "Enlever");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_BtnRestrictions().Content, "OleValue", cmpEqual, "Restrictions");
  
    //les en-têtes des colonnes 
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChName().Content, "OleValue", cmpEqual, "Nom");
    if (client == "BNC"  || client == "US" || client == "TD" ){
      aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChSleeveDescription().Content, "OleValue", cmpEqual, "Description du segment");
    }
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChNumber().Content, "OleValue", cmpEqual, "Numéro");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChIACode().Content, "OleValue", cmpEqual, "Code de CP");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChCurrency().Content, "OleValue", cmpEqual, "Devise");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChBalance().Content, "OleValue", cmpEqual, "Solde");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChTotalValue().Content, "OleValue", cmpEqual, "Valeur totale");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChMargin().Content, "OleValue", cmpEqual, "Marge");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChLastRebalancing().Content, "OleValue", cmpEqual, "Dernier rééquilibrage");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChLastUser().Content, "OleValue", cmpEqual, "Dernier utilisateur");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChNoOfDaysLate().Content, "OleValue", cmpEqual, "Nbre de jours de retard");
  
    //*******************************************************L’ONGLET POSITIONS***********************************************************************
    Get_Models_Details_TabPositions().Click()
    
    //les en-têtes des colonnes DefaultConfiguration     
    if(type=="basket")
    {
      Delay(150);
      Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinMVPercent().ClickR()
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
    };
     
    //les en-têtes des colonnes DefaultConfiguration   
    if(type=="firmModel")
    {
      Delay(150);
      Log.message("CROES-9570")
      Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent().ClickR()
      if(!Get_SubMenus().Exists){
          Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent().ClickR()
          Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent().ClickR()
      }
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
      Log.Message("CROES-9570")
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent().Content, "OleValue", cmpEqual, "Cible (%)"); //EN: 90-06-Be-17 Modifié selon le Jira CROES-9570 -  avant "VM Cible (%)" 
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinTargetPercent().Content, "OleValue", cmpEqual, "Cible min. (%)");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxTargetPercent().Content, "OleValue", cmpEqual, "Cible max. (%)");
    };
    
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinMVPercent().Content, "OleValue", cmpEqual, "VM min. (%)");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxMVPercent().Content, "OleValue", cmpEqual, "VM max. (%)");
    
    if(type=="basket"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantité")};
    
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription().Content, "OleValue", cmpEqual, "Description");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAssetAllocation().Content, "OleValue", cmpEqual, "Rép. d'actifs");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketPrice().Content, "OleValue", cmpEqual, "Prix au marché");//"Prix du marché" CROES-3714
    
    if(type=="basket")
    {aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketValue().Content, "OleValue", cmpEqual, "Valeur de marché");// CROES-3714
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMYPercent().Content, "OleValue", cmpEqual, "RM (%)");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChYTMMarketPercent().Content, "OleValue", cmpEqual, "Rend. éché. - Marché (%)")
    };
      
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChModDuration().Content, "OleValue", cmpEqual, "Durée mod."); 
     
    if(type=="basket"){
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAccruedID().Content, "OleValue", cmpEqual, "I/D courus"); 
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAnnInc().Content, "OleValue", cmpEqual, "Rev. ann."); }
      
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChLastUpdate().Content, "OleValue", cmpEqual, "Dernière m.-à-j.")};  
    
   //Conter le contenue de la liste (les colonnes qu’on peut ajouter)  
   Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
   
   if(type=="firmModel"){
     if (client == "CIBC" || client == "US" || client == "TD" )
        aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 19); // En réalité dans la liste il y a 18 colonnes qu’on peut ajouter 
     else if (client == "BNC")
        aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 21)  //Abdel: 2020.3-4 nouvelle colonne Bêta dans l'onglet Positions 
     else //RJ
        aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 18); // En réalité dans la liste il y a 17 colonnes qu’on peut ajouter 
   }
   
   //if(type=="basket"){aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 16)}; // En réalité dans la liste il y a 15 colonnes qu’on peut ajouter 
   
    //Faire apparaitre tous les en-têtes des colonnes
   Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription().ClickR()
   while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
    {
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
      Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
      //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
      Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription().ClickR()
    };
      
        
    if(type=="firmModel"){
    Log.Message("Croes-9570")
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent().Content, "OleValue", cmpEqual, "Cible (%)"); //EN: 90-06-Be-17 Modifié selon le Jira CROES-9570 -  avant "VM Cible (%)"
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinTargetPercent().Content, "OleValue", cmpEqual, "Cible min. (%)");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxTargetPercent().Content, "OleValue", cmpEqual, "Cible max. (%)");}
    
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)")};//Cette ligne a été répétée par ce que la colonne est n’est pas dans le même endroit pour le type basket et firmModel
    
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinMVPercent().Content, "OleValue", cmpEqual, "VM min. (%)");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxMVPercent().Content, "OleValue", cmpEqual, "VM max. (%)");
    if(type=="basket"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantité")};
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChVariationPercent().Content, "OleValue", cmpEqual, "Écart (%)")};
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription().Content, "OleValue", cmpEqual, "Description");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAsk().Content, "OleValue", cmpEqual, "Vendeur");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecurity().Content, "OleValue", cmpEqual, "Titre");   
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSubcategory().Content, "OleValue", cmpEqual, "Sous-catégorie")};
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSector().Content, "OleValue", cmpEqual, "Secteur");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChRegion().Content, "OleValue", cmpEqual, "Région");  
    
     if(type=="basket")
    { aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChInterestPortion().Content, "OleValue", cmpEqual, "Portion d'intéret");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChInterest().Content, "OleValue", cmpEqual, "Intérêts")
    };
    
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChName().Content, "OleValue", cmpEqual, "Nom")};    
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Instrument financier");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChFrequency().Content, "OleValue", cmpEqual, "Fréquence");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaturity().Content, "OleValue", cmpEqual, "Échéance");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDividend().Content, "OleValue", cmpEqual, "Dividende"); 
    Scroll_Models_Details_DgvDetails();   
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du prix");
        
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");
    if(client == "BNC")   
        if(type=="firmModel") aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChRiskRating().Content, "OleValue", cmpEqual, "Cote de risque"); //EM : 90.09.Er-9 : Avant c'était non disponible - Modifié suite à l'activation des PREF RQS sur notre Dump
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChIACode().Content, "OleValue", cmpEqual, "Code de CP")}; 
    
    if(type=="basket"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)")};//Cette ligne a été répétée par ce que la colonne est n’est pas dans le même endroit pour le type basket et firmModel
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChClose().Content, "OleValue", cmpEqual, "Clôture");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChBasicCategories().Content, "OleValue", cmpEqual, "Catégories de base");
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
      if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChBeta().Content, "OleValue", cmpEqual, "Bêta")};   
    }
    
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChBid().Content, "OleValue", cmpEqual, "Acheteur");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbole");
    Scroll_Models_Details_DgvDetails();       
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAssetAllocation().Content, "OleValue", cmpEqual, "Rép. d'actifs"); 
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketPrice().Content, "OleValue", cmpEqual, "Prix au marché"); //CROES-3714
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChModDuration().Content, "OleValue", cmpEqual, "Durée mod.");
    
    if(type=="basket")
   {  
      //aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketValue().Content, "OleValue", cmpEqual, "Valeur au marché"); //N’existe pas 
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMYPercent().Content, "OleValue", cmpEqual, "RM (%)");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChYTMMarketPercent().Content, "OleValue", cmpEqual, "Rend. éché. - Marché (%)");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChModDuration().Content, "OleValue", cmpEqual, "Durée mod.");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAccruedID().Content, "OleValue", cmpEqual, "I/D courus"); 
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAnnInc().Content, "OleValue", cmpEqual, "Rev. ann.");
   };
      
   if(type=="firmModel")
   {aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChLastUpdate().Content, "OleValue", cmpEqual, "Dernière m.-à-j.");  
   //Remettre l’affichage par default
   Get_Models_Details_TabPositions_BtnByAssetClassOff_ChLastUpdate().ClickR() 
   Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()}
      
    if(type=="basket")
    { //Remettre l’affichage par default 
      Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAnnInc().ClickR()
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()}
      
    //*****************************************************************"BY ASSET CLASS" ON************************************************************ 
    //************************************************************************************************************************************************
    Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnByAssetClass().Click()
    
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChDescription().Content, "OleValue", cmpEqual, "Description");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChNoOfPositions().Content, "OleValue", cmpEqual, "Nbre de positions");
     if(type=="basket")
    {
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChInvestedCapital().Content, "OleValue", cmpEqual, "Capital investi");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMarketValue().Content, "OleValue", cmpEqual, "Valeur de marché");//CROES-3714
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChInvestCapGL().Content, "OleValue", cmpEqual, "G/P cap. investi");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChAccruedID().Content, "OleValue", cmpEqual, "I/D courus");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChAnnInc().Content, "OleValue", cmpEqual, "Rev. ann.");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChBookValueACB().Content, "OleValue", cmpEqual, "Valeur comptable");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChGLBookValue().Content, "OleValue", cmpEqual, "G/P valeur comptable");   
    }
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMVPercent().Content, "OleValue", cmpEqual, "VM (%)");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMinObj().Content, "OleValue", cmpEqual, "Obj. min.");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMaxObj().Content, "OleValue", cmpEqual, "Obj. max.");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChTargetObj().Content, "OleValue", cmpEqual, "Obj. cible");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChTargetStatus().Content, "OleValue", cmpEqual, "Cible");//CROES-5068 
    Log.Message("CROES-5068")
    Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnByAssetClass().Click()

     //****************************************************************L’ONGLET SUMMARY**************************************************************
    Get_Models_Details_TabSummary().Click()  
    aqObject.CheckProperty(Get_Models_Details_TabSummary().Header, "OleValue", cmpEqual, "Sommaire");
    aqObject.CheckProperty(Get_Models_Details_TabSummary_ToolBarTray_LblAssetAllocation().Text, "OleValue", cmpEqual, "Répartition d'actifs");
    if(type=="basket"){ aqObject.CheckProperty(Get_Models_Details_TabSummary_ToolBarTray_LblFundAllocation().Text, "OleValue", cmpEqual, "Répartition des fonds");}
    
    if(type=="firmModel"){ 
    aqObject.CheckProperty(Get_Models_Details_TabSummary_LblNumberOfPositions().Text, "OleValue", cmpEqual, "Nombre de positions:");
    aqObject.CheckProperty(Get_Models_Details_TabSummary_LblModDurationAvg().Text, "OleValue", cmpEqual, "Durée mod. (moy.):");
    aqObject.CheckProperty(Get_Models_Details_TabSummary_LblBeta().Text, "OleValue", cmpEqual, "Bêta:")};
    
    if(type=="basket"){
     aqObject.CheckProperty(Get_Models_Details_TabSummary_LblNumberOfPositionsForBasketType().Text, "OleValue", cmpEqual, "Nombre de positions:");
     aqObject.CheckProperty(Get_Models_Details_TabSummary_LblMarketValueForBasketType().Text, "OleValue", cmpEqual, "Valeur de marché:");//CROES-3714
     aqObject.CheckProperty(Get_Models_Details_TabSummary_LblModDurationAvgForBasketType().Text, "OleValue", cmpEqual, "Durée mod. (moy.):");
     aqObject.CheckProperty(Get_Models_Details_TabSummary_LblAccruedIntDivForBasketType().Text, "OleValue", cmpEqual, "Int./Div. courus:");
     aqObject.CheckProperty(Get_Models_Details_TabSummary_LblAnnualIncomeForBasketType().Text, "OleValue", cmpEqual, "Revenu annuel:");}
  
    //***************************************************L’ONGLET REBALANCING CRITERIA*************************************************************
    Get_Models_Details_TabRebalancingCriteria().Click() 
    Log.Message("CROES-9139")
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Content, "OleValue", cmpEqual, "Gérer");//CROES-5067 //EM: 90-06-Be-17 Modifié selon le Jira CROES-9139 - avant "Associer/Gérer"
    Log.Message("CROES-5067")
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_BtnRemove().Content, "OleValue", cmpEqual, "Enlever");
  
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChActive().Content, "OleValue", cmpEqual, "Actif");
    //aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChPriority().Content, "OleValue", cmpEqual, "Priorité"); 
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChName().Content, "OleValue", cmpEqual, "Nom");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChDescription().Content, "OleValue", cmpEqual, "Description");   
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChSentence().Content, "OleValue", cmpEqual, "Phrase");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChAccessLevel().Content, "OleValue", cmpEqual, "Niveau d'accès");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChCreationDate().Content, "OleValue", cmpEqual, "Date de création");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChLastUpdate().Content, "OleValue", cmpEqual, "Dernière m.-à-j.");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChCreator().Content, "OleValue", cmpEqual, "Créateur");
}


function Check_Properties_English(type)
{
    Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").Maximize() 
    aqObject.CheckProperty(Get_Models_Details().Header, "OleValue", cmpEqual, "Details");
  
    //*****************************************************L’ONGLET ASSIGNED PORTFOLIOS*********************************************************
    Get_Models_Details_TabAssignedPortfolios().Click()
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios().Header, "OleValue", cmpEqual, "Assigned portfolios");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ToolBar_LblFilter().Content, "OleValue", cmpEqual, "Filter:");
  
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DdlAssign().Header, "OleValue", cmpEqual, "Assign");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_BtnRemove().Content, "OleValue", cmpEqual, "Remove");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_BtnRestrictions().Content, "OleValue", cmpEqual, "Restrictions");
  
    //les en-têtes des colonnes 
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChName().Content, "OleValue", cmpEqual, "Name");
    if (client == "BNC" || client == "TD" ){
      aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChSleeveDescription().Content, "OleValue", cmpEqual, "Sleeve Description");
    }
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChNumber().Content, "OleValue", cmpEqual, "Number");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChIACode().Content, "OleValue", cmpEqual, "IA Code");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChCurrency().Content, "OleValue", cmpEqual, "Currency");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChBalance().Content, "OleValue", cmpEqual, "Balance");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChTotalValue().Content, "OleValue", cmpEqual, "Total Value");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChMargin().Content, "OleValue", cmpEqual, "Margin");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChLastRebalancing().Content, "OleValue", cmpEqual, "Last Rebalancing");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChLastUser().Content, "OleValue", cmpEqual, "Last User");
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ChNoOfDaysLate().Content, "OleValue", cmpEqual, "No. of Days Late");
  
    //*************************************************************L’ONGLET POSITIONS***********************************************************
    Get_Models_Details_TabPositions().Click()
    
    if(type=="basket")
    { //les en-têtes des colonnes DefaultConfiguration 
      Delay(150);
      Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinMVPercent().ClickR()
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
    }
    
    if(type=="firmModel")
    { //les en-têtes des colonnes DefaultConfiguration 
      Delay(150);
      Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent().ClickR()
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()
      Log.Message("Croes-9570")
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent().Content, "OleValue", cmpEqual, "Target (%)"); //EN: 90-06-Be-17 Modifié selon le Jira CROES-9570 -  avant "Target VM (%)"
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinTargetPercent().Content, "OleValue", cmpEqual, "Min. Target (%)");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxTargetPercent().Content, "OleValue", cmpEqual, "Max. Target (%)");
    }
    
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinMVPercent().Content, "OleValue", cmpEqual, "Min. MV (%)");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxMVPercent().Content, "OleValue", cmpEqual, "Max. MV (%)");
    
    if(type=="basket"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantity")}; 
    
     
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription().Content, "OleValue", cmpEqual, "Description");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAssetAllocation().Content, "OleValue", cmpEqual, "Asset Allocation");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketPrice().Content, "OleValue", cmpEqual, "Market Price");
    
    if(type=="basket")
    {
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketValue().Content, "OleValue", cmpEqual, "Market Value");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMYPercent().Content, "OleValue", cmpEqual, "MY (%)");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChYTMMarketPercent().Content, "OleValue", cmpEqual, "YTM - Market (%)")     
    };
    
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChModDuration().Content, "OleValue", cmpEqual, "Mod. Duration"); 
    
    if(type=="basket")
    {
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAccruedID().Content, "OleValue", cmpEqual, "Accrued I/D"); 
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAnnInc().Content, "OleValue", cmpEqual, "Ann. Inc."); 
    };
      
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChLastUpdate().Content, "OleValue", cmpEqual, "Updated on")};
    
   //Conter le contenue de la liste (les colonnes qu’on peut ajouter)  
   Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription().ClickR()
   Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
   
   if(type=="firmModel"){
        if (client == "CIBC")
            aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 19); // En réalité dans la liste il y a 18 colonnes qu’on peut ajouter 
        else if (client == "BNC")
            aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 20);  //EM : 90.09.Er-9 : Avant c'était 19 - Modifié suite à l'activation des PREF RQS 
        else //RJ
            aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 18); // En réalité dans la liste il y a 17 colonnes qu’on peut ajouter 
   }
    
   if(type=="basket"){aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 16)}; // En réalité dans la liste il y a 15 colonnes qu’on peut ajouter 
   
   //Faire apparaitre tous les en-têtes des colonnes
   Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription().ClickR()
   while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
      {
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu()
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
        Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription().ClickR()
      }    

    if(type=="firmModel")
    {
      Log.Message("Croes-9570") 
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChTargetMVPercent().Content, "OleValue", cmpEqual, "Target (%)"); //EN: 90-06-Be-17 Modifié selon le Jira CROES-9570 -  avant "Target VM (%)"
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinTargetPercent().Content, "OleValue", cmpEqual, "Min. Target (%)");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxTargetPercent().Content, "OleValue", cmpEqual, "Max. Target (%)");
    };
      
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)")};//Cette ligne a été répétée parce que la colonne est n’est pas dans le même endroit pour le type basket et firmModel
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMinMVPercent().Content, "OleValue", cmpEqual, "Min. MV (%)");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaxMVPercent().Content, "OleValue", cmpEqual, "Max. MV (%)");
    if(type=="basket"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChQuantity().Content, "OleValue", cmpEqual, "Quantity")};
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChVariationPercent().Content, "OleValue", cmpEqual, "Variation (%)")};
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDescription().Content, "OleValue", cmpEqual, "Description");
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSubcategory().Content, "OleValue", cmpEqual, "Subcategory")};
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSecurity().Content, "OleValue", cmpEqual, "Security");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSector().Content, "OleValue", cmpEqual, "Sector");
    if(client == "BNC")   
        if(type=="firmModel") aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChRiskRating().Content, "OleValue", cmpEqual, "Risk Rating"); //EM : 90.09.Er-9 : Avant c'était non disponible - Modifié suite à l'activation des PREF RQS sur notre Dump
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChRegion().Content, "OleValue", cmpEqual, "Region");
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChName().Content, "OleValue", cmpEqual, "Name")};
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMaturity().Content, "OleValue", cmpEqual, "Maturity");
    if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChIACode().Content, "OleValue", cmpEqual, "IA Code")};
    
    if(type=="basket")
    { aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChInterestPortion().Content, "OleValue", cmpEqual, "Interest Portion");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChInterest().Content, "OleValue", cmpEqual, "Interest")}; 
         
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChFrequency().Content, "OleValue", cmpEqual, "Frequency");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChFinancialInstrument().Content, "OleValue", cmpEqual, "Financial Instrument");
    
    if(client == "CIBC" || client == "BNC"){ Scroll_Models_Details_DgvDetails()}
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChDividend().Content, "OleValue", cmpEqual, "Dividend");
    Delay(200)
    if(client == "US" || client == "TD"){Scroll_Models_Details_DgvDetails()
    Delay(200)}
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChCUSIP().Content, "OleValue", cmpEqual, "CUSIP");
    
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChClose().Content, "OleValue", cmpEqual, "Close");
    
    Scroll_Models_Details_DgvDetails()

    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChBid().Content, "OleValue", cmpEqual, "Bid");
    if (client == "BNC" ){
      if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChBeta().Content, "OleValue", cmpEqual, "Beta")};
    }
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChBasicCategories().Content, "OleValue", cmpEqual, "Basic Categories");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAsk().Content, "OleValue", cmpEqual, "Ask");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChSymbol().Content, "OleValue", cmpEqual, "Symbol");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAssetAllocation().Content, "OleValue", cmpEqual, "Asset Allocation");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketPrice().Content, "OleValue", cmpEqual, "Market Price");
    
    if(type=="basket")
    { 
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)")//Cette ligne a été répétée par ce que la colonne est n’est pas dans le même endroit pour le type basket et firmModel
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMarketValue().Content, "OleValue", cmpEqual, "Market Value");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChMYPercent().Content, "OleValue", cmpEqual, "MY (%)");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChYTMMarketPercent().Content, "OleValue", cmpEqual, "YTM - Market (%)");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChModDuration().Content, "OleValue", cmpEqual, "Mod. Duration");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAccruedID().Content, "OleValue", cmpEqual, "Accrued I/D"); 
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAnnInc().Content, "OleValue", cmpEqual, "Ann. Inc.");
    };
    
    //Remettre l’affichage par default
    if(type=="firmModel")
    { 
    if(client == "CIBC" || client == "TD" || client == "BNC"){Scroll_Models_Details_DgvDetails()}
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOff_ChLastUpdate().Content, "OleValue", cmpEqual, "Updated on");      
      Get_Models_Details_TabPositions_BtnByAssetClassOff_ChLastUpdate().ClickR()
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()    
    };
    
    //Remettre l’affichage par default 
    if(type=="basket")
    { Get_Models_Details_TabPositions_BtnByAssetClassOff_ChAnnInc().ClickR()
      Get_GridHeader_ContextualMenu_DefaultConfiguration().Click()}
  
    //***********************************************************"by asset class" on**************************************************************** 
    Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnByAssetClass().Click()
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChDescription().Content, "OleValue", cmpEqual, "Description");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChNoOfPositions().Content, "OleValue", cmpEqual, "No. of Positions");
    if(type=="basket")
    {
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChInvestedCapital().Content, "OleValue", cmpEqual, "Invested Capital");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMarketValue().Content, "OleValue", cmpEqual, "Market Value");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChInvestCapGL().Content, "OleValue", cmpEqual, "Invest. Cap. G/L");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChAccruedID().Content, "OleValue", cmpEqual, "Accrued I/D");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChAnnInc().Content, "OleValue", cmpEqual, "Ann. Inc.");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChBookValueACB().Content, "OleValue", cmpEqual, "Book Value ACB");
      aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChGLBookValue().Content, "OleValue", cmpEqual, "G/L Book Value");   
    }
    
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMVPercent().Content, "OleValue", cmpEqual, "MV (%)");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMinObj().Content, "OleValue", cmpEqual, "Min. Obj.");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChMaxObj().Content, "OleValue", cmpEqual, "Max. Obj.");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChTargetObj().Content, "OleValue", cmpEqual, "Target Obj.");
    aqObject.CheckProperty(Get_Models_Details_TabPositions_BtnByAssetClassOn_ChTargetStatus().Content, "OleValue", cmpEqual, "Target");//CROES-5070 le bon texte est "Target Status"
    Log.Message("bug CROES-5070")
    Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnByAssetClass().Click()

     //*******************************************************************L’ONGLET SUMMARY*********************************************************
    Get_Models_Details_TabSummary().Click()  
    aqObject.CheckProperty(Get_Models_Details_TabSummary().Header, "OleValue", cmpEqual, "Summary");
    aqObject.CheckProperty(Get_Models_Details_TabSummary_ToolBarTray_LblAssetAllocation().Text, "OleValue", cmpEqual, "Asset Allocation");
    if(type=="basket"){ aqObject.CheckProperty(Get_Models_Details_TabSummary_ToolBarTray_LblFundAllocation().Text, "OleValue", cmpEqual, "Fund Allocation");}
     
    if(type=="firmModel"){
    aqObject.CheckProperty(Get_Models_Details_TabSummary_LblBeta().Text, "OleValue", cmpEqual, "Beta:")
    aqObject.CheckProperty(Get_Models_Details_TabSummary_LblNumberOfPositions().Text, "OleValue", cmpEqual, "Number of positions:");
    aqObject.CheckProperty(Get_Models_Details_TabSummary_LblModDurationAvg().Text, "OleValue", cmpEqual, "Mod. Duration (Avg.):");};
    
    if(type=="basket"){
     aqObject.CheckProperty(Get_Models_Details_TabSummary_LblNumberOfPositionsForBasketType().Text, "OleValue", cmpEqual, "Number of positions:");
     aqObject.CheckProperty(Get_Models_Details_TabSummary_LblMarketValueForBasketType().Text, "OleValue", cmpEqual, "Market Value:");
     aqObject.CheckProperty(Get_Models_Details_TabSummary_LblModDurationAvgForBasketType().Text, "OleValue", cmpEqual, "Mod. Duration (Avg.):");
     aqObject.CheckProperty(Get_Models_Details_TabSummary_LblAccruedIntDivForBasketType().Text, "OleValue", cmpEqual, "Accrued Int./Div.:");
     aqObject.CheckProperty(Get_Models_Details_TabSummary_LblAnnualIncomeForBasketType().Text, "OleValue", cmpEqual, "Annual Income:");}
  
    //************************************************************L’ONGLET REBALANCING CRITERIA****************************************************
    Get_Models_Details_TabRebalancingCriteria().Click() 
    Log.Message("CROES-9139")
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_BtnAssignManage().Content, "OleValue", cmpEqual, "Manage");//EM: 90-06-Be-17 Modifié selon le Jira CROES-9139 - avant "Associer/Gérer"
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_BtnRemove().Content, "OleValue", cmpEqual, "Remove");
  
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChActive().Content, "OleValue", cmpEqual, "Active");
    //aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChPriority().Content, "OleValue", cmpEqual, "Priority");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChName().Content, "OleValue", cmpEqual, "Name");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChDescription().Content, "OleValue", cmpEqual, "Description");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChSentence().Content, "OleValue", cmpEqual, "Sentence");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChAccessLevel().Content, "OleValue", cmpEqual, "Access Level");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChCreationDate().Content, "OleValue", cmpEqual, "Creation Date");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChLastUpdate().Content, "OleValue", cmpEqual, "Updated on");
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_ChCreator().Content, "OleValue", cmpEqual, "Creator");
  
}


function Check_Existence_Of_Controls(type)
{ 
  //************************************************************L’ONGLET ASSIGNED PORTFOLIOS*****************************************************
  Get_Models_Details_TabAssignedPortfolios().Click()
  aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_ToolBar_CmbFilter(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DdlAssign(), "IsVisible", cmpEqual, true);
  if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DdlAssign(), "IsEnabled", cmpEqual, true)};
  if(type=="basket"){aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DdlAssign(), "IsEnabled", cmpEqual, false)};
  
  aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_BtnRemove(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_BtnRemove(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_BtnRestrictions(), "IsVisible", cmpEqual, true);
  if(type=="firmModel")aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_BtnRestrictions(), "IsEnabled", cmpEqual, true);
  if(type=="basket"){aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_BtnRestrictions(), "IsEnabled", cmpEqual, false);}
  
  //******************************************************************L’ONGLET POSITIONS**************************************************************
  Get_Models_Details_TabPositions().Click()
  aqObject.CheckProperty(Get_Models_Details_TabPositions_ToolBarTray_TreeViewButton(), "IsVisible", cmpEqual, true);
  if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_ToolBarTray_TreeViewButton(), "IsEnabled", cmpEqual, true)};
  if(type=="basket"){aqObject.CheckProperty(Get_Models_Details_TabPositions_ToolBarTray_TreeViewButton(), "IsEnabled", cmpEqual, false)};
  
  aqObject.CheckProperty(Get_Models_Details_TabPositions_ToolBarTray_TreeViewButton_LblModelNoAndName(), "IsVisible", cmpEqual, true);
  if(type=="firmModel"){aqObject.CheckProperty(Get_Models_Details_TabPositions_ToolBarTray_TreeViewButton_LblModelNoAndName(), "IsEnabled", cmpEqual, true)};
  if(type=="basket"){aqObject.CheckProperty(Get_Models_Details_TabPositions_ToolBarTray_TreeViewButton_LblModelNoAndName(), "IsEnabled", cmpEqual, false)};
  
  aqObject.CheckProperty(Get_Models_Details_TabPositions_ToolBarTray_dtpDate(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Models_Details_TabPositions_ToolBarTray_dtpDate(), "IsEnabled", cmpEqual, false);

  aqObject.CheckProperty(Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnAll(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnAll(), "IsEnabled", cmpEqual, true);
      
  aqObject.CheckProperty(Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnByAssetClass(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnByAssetClass(), "IsEnabled", cmpEqual, true);
  
  if(type=="basket")
  {
    aqObject.CheckProperty(Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnBySecurity(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_Models_Details_TabPositions_ToggleButtonToolBar_BtnBySecurity(), "IsEnabled", cmpEqual, false);
  }
    
   //*******************************************************************L’ONGLET SUMMARY*********************************************************
  Get_Models_Details_TabSummary().Click()
 
  aqObject.CheckProperty(Get_Models_Details_TabSummary_ToolBarTray_CmbAssetAllocation(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Models_Details_TabSummary_ToolBarTray_CmbAssetAllocation(), "IsEnabled", cmpEqual, true);
  if(type=="basket"){ aqObject.CheckProperty(Get_Models_Details_TabSummary_ToolBarTray_ChkFundAllocation(), "IsVisible", cmpEqual, true);}

  if(type=="firmModel"){
    if (client == "BNC" ){
      aqObject.CheckProperty(Get_Models_Details_TabSummary_TxtBeta(), "IsVisible", cmpEqual, true)
    }
    aqObject.CheckProperty(Get_Models_Details_TabSummary_TxtNumberOfPositions(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_Models_Details_TabSummary_TxtModDurationAvg(), "IsVisible", cmpEqual, true);
  };
  
  if(type=="basket"){
    aqObject.CheckProperty(Get_Models_Details_TabSummary_TxtNumberOfPositionsForBasketType(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_Models_Details_TabSummary_TxtMarketValueForBasketType(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_Models_Details_TabSummary_TxtModDurationAvgForBasketType(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_Models_Details_TabSummary_TxtAccruedIntDivForBasketType(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_Models_Details_TabSummary_TxtAnnualIncomeForBasketType(), "IsVisible", cmpEqual, true);}
   
    //****************************************************L’ONGLET REBALANCING CRITERIA*****************************************************************
  Get_Models_Details_TabRebalancingCriteria().Click() 
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_BtnAssignManage(), "IsVisible", cmpEqual, true);
  if (client == "BNC"){
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_BtnAssignManage(), "IsEnabled", cmpEqual, false);
  }
  else{//RJ
    aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_BtnAssignManage(), "IsEnabled", cmpEqual, true);
  }
  
  aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_BtnRemove(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria_BtnRemove(), "IsEnabled", cmpEqual, false);
  
}

//Scroll pour faire apparaitre tous les en-têtes des colonnes 
function Scroll_Models_Details_DgvDetails()
{
  var ControlWidth=Get_Models_Details_DgvDetails().get_ActualWidth()
  var ControlHeight=Get_Models_Details_DgvDetails().get_ActualHeight()
  Log.Message(ControlWidth)
  Log.Message(ControlHeight)
  for (i=1; i<=1; i++) {Get_Models_Details_DgvDetails().Click(ControlWidth-40, ControlHeight-5)}
}
