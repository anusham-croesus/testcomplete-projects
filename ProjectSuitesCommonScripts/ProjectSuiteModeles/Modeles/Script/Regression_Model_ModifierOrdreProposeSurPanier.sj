//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

/**
    Module      : Modeles
    Jira Xray   : TCVE-947
    Description : Résumé du cas de test
                  - Créer un Portefeuille client selon un modèle.
                  - Rééquilibrer, étape 1: Décocher les 3 options.
                  - Étape 4: Portefeuille projeté, mettre la quantité désirée dans le panier.
                  - Valider les VM(%) des positions du SOLDE.
                  - Valider le pie-chart de la section Sommaire.
                  - Modifier l'ordre d'achat proposé.
                  - Valider les VM(%) des positions solde.
                  - Valider le % de liquidités dans pie-chart.
                            
    Auteur               : Frédéric Thériault
    Version de scriptage : 90.15.2020.3-18, qabd157@qa_syb49
    Date                 : 24/03/2020
**/

var maxRetry = 5;

function Regression_Model_ModifierOrdreProposeSurPanier()
{
  var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logRetourEtatInitial;
  try {
    Log.Link("https://jira.croesus.com/browse/TCVE-947","Lien du Cas de test sur Jira Xray");
    var mwUp = 50;
    var mwDown = -50;
    var nomDescription = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "DescriptionPanierCorporatif", language);
    var typeOrdres = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "OrderType", language);
    var nbreOrbres = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "OrderQty", language);
    var lblColEquartQty = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "LabelColEquartQty", language);
    var description = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "SecurityDescription", language);
    var totVMP1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "TotMVPercent1", language);
    var totVMP2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "TotMVPercent2", language);
    var compteNo1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "AccountNo1", language);
    var compteNo2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "AccountNo2", language);
    var lvLibelle = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "LegendLabel", language);
    var lvPourcent = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "LegendPercentValue", language);
    var nouvelleQty = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NouvelleQuantite", language);
    var curencySeparator = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "CentSeparator", language);
    var modifMVP = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "ModifVMPercentAttendu", language);
    var newTotVMP1 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NewTotMVPercent1", language);
    var newTotVMP2 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NewTotMVPercent2", language);
    var newLvPourcent = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NewLegendPercentValue", language);
    
    
    // Étape 1
    logEtape1 = Log.AppendFolder("Étape 1: Créer un Portefeuille client selon un modèle.");
    Log.Message("Étape 1.1: Se connecter avec KEYNEJ.");
    var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");  
    Login(vServerModeles, user, psw ,language);
    Log.Message("Étape 1.2: Aller au module Modeles.");
    Get_ModulesBar_BtnModels().Click();
  
    var nameModel = "TOL PANIER RECHA";
    var createNewModel = false;
    var rootNo = "800040";
  
    Get_Toolbar_BtnSearch().Click();
    Get_WinQuickSearch_TxtSearch().keys(nameModel);
    Get_WinQuickSearch_BtnOK().Click();
  
    /** // N'est plus requis, Karima Mouzaoui à modifié les étapes 1 à 4
    Log.Message("1.2 Mailler vers le module Portefeuille et valider que le panier n'as pas rechange.");
    Get_MenuBar_Modules().OpenMenu();
    Get_MenuBar_Modules_Portfolio().OpenMenu();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 10000);
    
    // DblClick sur la ligne du Panier CP
    if (Get_Portfolio_PositionsGrid().WPFObject("DataRecordPresenter", "", 6).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").Visible == true) {
        Get_Portfolio_PositionsGrid().WPFObject("DataRecordPresenter", "", 6).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").DblClick();
    }
    else
        Log.Error("La ligne du Panier CP n'est pas visible dans la grille.");
  
    // Si la fenêtre de Confirmation (modèle actif) est présente.
    if (Aliases.CroesusApp.dlgConfirmation.VisibleOnScreen == true) {
        Aliases.CroesusApp.dlgConfirmation.WPFObject("MessageWindow", "", 1).WPFObject("PART_No").Click();
    }
  
    // Vérifier qu'il n'y a pas de titre de substitution dans la fenêtre ouverte. // Maheureusement dans le dump pour v.90.15.2020.3-18 le compte a un titre de substitution, on ne peut pas aller plus loin dans cette direction. Karima Mouzaoui à modifié les étapes 1 à 4 pour contourner ce problème et ne pas avoir a faire cette validation.
    if (Aliases.CroesusApp.winSubModelInfo.WPFObject("ScrollViewer", "", 1).WPFObject("SubstitutionInfo").WPFObject("GroupBox", "Substitution securities", 1).WPFObject("SubstitutionDataGrid").WPFObject("RecordListControl", "", 1).VisibleOnScreen == true
        && Aliases.CroesusApp.winSubModelInfo.WPFObject("ScrollViewer", "", 1).WPFObject("SubstitutionInfo").WPFObject("GroupBox", "Substitution securities", 1).WPFObject("SubstitutionDataGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").Visible == true) {
          Log.Error("Il y a un titre de rechange dans la liste de titres de substitutions du Panier CP.");
    }
    Log.Message("1.3 Retourner dans le module Modeles et choisir le modèle TOL PANIER RECHA.");
    **/
    
    Log.Message("Étape 1.3: Section Détail, cliquer sur le bouton Associer et choisir Client racine.");
    Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
    Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
    Log.Message("Étape 1.4: Sélectionner le numéro du client, faire bouton OK.");
    
    SetAutoTimeOut(2000);
    
    Get_Models_Details_TabAssignedPortfolios_PickerWindowElement(rootNo).Click();
    Get_Models_Details_TabAssignedPortfolios_RootClient_BtnOK().Click();
    Log.Message("Étape 1.5: Cliquer Oui pour assigner à un modèle.");
    Get_WinAssignToModel_BtnYes().Click();
    if(Get_Models_Details_TabAssignedPortfolios_RecordListItem(1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "5"], 10).Value.OleValue == rootNo)
      Log.Checkpoint("Le client " +rootNo +" est bien assigné au modèle.");
    else
      Log.Error("L'assignation du client " +rootNo +" n'a pas fonctionné.");
    
    RestoreAutoTimeOut();
  
    // Étape 2
    Log.PopLogFolder();
    logEtape2 = Log.AppendFolder("Étape 2: Rééquilibrer, étape 1: Décocher les 3 options");
    Log.Message("Dans la barre de menu, cliquer sur le bouton Rééquilibrer. Dans l'étape 1 du rééquilibrage, décocher les 3 cases cochées.");
    Get_Toolbar_BtnRebalance().Click();
    caseValidateTargetRange = Get_WinRebalance_TabParameters_ChkValidateTargetRange();
    caseDistributeAccountLiquidity = Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity();
    caseApplyAccountFees = Get_WinRebalance_TabParameters_ChkApplyAccountFees();
    
    Log.Message("À l'étape 1 du rééquilibrage décocher les 3 cases.");
    if (caseValidateTargetRange.wState == 1) {
        Log.Message("Décocher Valider les tolérences des titres.");
        caseValidateTargetRange.Click();
    }
    if (caseDistributeAccountLiquidity.wState == 1) {
        Log.Message("Décocher Répartir la liquidité entre les comptes selon la tolérence du solde.");
        caseDistributeAccountLiquidity.Click();
    }
    if (caseApplyAccountFees.wState == 1) {
        Log.Message("Décocher Appliquer les réserves de liquidité.");
        caseApplyAccountFees.Click();
    }
    if (caseValidateTargetRange.wState == 0 && caseDistributeAccountLiquidity.wState == 0
        && caseApplyAccountFees.wState == 0) {
          Log.Checkpoint("Les 3 cases sont bien décochées.");
    }
    else
      Log.Error("Les 3 cases à cocher n'ont pas été toutes décochées.");
    
    // Étape 3
    Log.PopLogFolder();
    logEtape3 = Log.AppendFolder("Étape 3: Étape 4: Portefeuille projeté, mettre la quantité désirée dans le panier.");
    Log.Message("Étape 3.1: Faire le bouton Next (flèche droite) jusqu'à l'Étape 4 du rééquilibrage.");
    var nbClicks = 0;
    var Step4Detected = false;
    do {
        Get_WinRebalance_BtnNext().Click();
        nbClicks = nbClicks+1
        if (nbClicks == 3) {
          for (i = 1; i <= maxRetry; i++) {
            Log.Message("Attendre le chargement complet.");
            WaitObject(Get_CroesusApp(),"Uid", "PadHeader_7886", 15000);
            if (Get_WinRebalance_TabProjectedPortfolios_BarPadHeader().WaitProperty("VisibleOnScreen", true, 5000) == true) {
                Log.Checkpoint("La page de l'étape 4 du rééquilibrage 'Portefeuilles projetés', est atteinte.");
                Step4Detected = true;
                break;
            }
            else {
              if (i == maxRetry)
                Log.Error("Page de l'étape 4 du rééquilibrage non détecté " +i +" fois sur " +maxRetry +".");
              else
                Log.Message("Page de l'étape 4 du rééquilibrage non détecté " +i +" fois sur " +maxRetry +".");
            }
            Delay(2000);
          }
      }
    } while (Step4Detected == false && nbClicks < 3)
    
    resutatValidation = Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_GridLineCheckByDescriptionTypeQty(nomDescription, typeOrdres, nbreOrbres);
    if (resutatValidation == true)
        Log.Checkpoint("La Description "+nomDescription +", le type "+typeOrdres +" et la quantité recherchés " +nbreOrbres +" se trouvent dans la grille de l'onglet Ordres proposés.");
        
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
    
    Log.Message("Étape 3.2: Onglet " +Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WPFControlText +", afficher un tri décroissant sur la colonne " +lblColEquartQty +".");
    for (j = 1; j <= maxRetry; j++) {
        Get_WinRebalance_TabProjectedPortfolios_Column(lblColEquartQty).Click();
        if (Get_WinRebalance_TabProjectedPortfolios_Column(lblColEquartQty).SortStatus == "Descending") {
            break;
        }
        else {
          if (j == maxRetry)
            Log.Error("Colonne " +lblColEquartQty +" non détecté " +j +" fois sur " +maxRetry +".");
          else
            Log.Message("Colonne " +lblColEquartQty +" non détecté " +j +" fois sur " +maxRetry +".");
        }
        Delay(3000);
    }
    
    // Étape 4
    Log.PopLogFolder();
    logEtape4 = Log.AppendFolder("Étape 4: Valider les VM(%) des positions du solde.");
    // Faire rouler la roulette de souris vers le haut pour s'assurer de voir la 1re ligne de la grille.
    Get_WinRebalance_TabProjectedPortfolios_ProjectedGrid().FindChild("ClrClassName","RecordListControl", 10).MouseWheel(mwUp,0);
    
    Valider_VMpourcentDeLaLigne("2", compteNo1, description, totVMP1);
    Valider_VMpourcentDeLaLigne("3", compteNo2, description, totVMP2);
    
    //Étape 5
    Log.PopLogFolder();
    logEtape5 = Log.AppendFolder("Étape 5: Valider le pie-chart de la section Sommaire.");
    lblLegende = Get_WinRebalance_TabProjectedPortfolios_LegendLabelByLineNb("1").WPFControlText;
    pourcentLiquidites = Get_WinRebalance_TabProjectedPortfolios_LegendPercentValueByLineNb("1").WPFControlText;
    
    if (lblLegende == lvLibelle && pourcentLiquidites == lvPourcent)
      Log.Checkpoint("Les pourcentages sur la ligne " +lvLibelle +" dans la légende du pie-chart correspondent aux valeurs attendues.");
    else
      Log.Error("La ligne " +lblLegende +" et les pourcentages " +pourcentLiquidites +" dans la légende du pie-chart ne correspondent pas aux valeurs attendues.", "Libellé attendu: " +lvLibelle +" Valeurs % attendus:" +lvPourcent);
    
    //Étape 6
    Log.PopLogFolder();
    logEtape6 = Log.AppendFolder("Étape 6: Modifier l'ordre d'achat proposé.");
    Log.Message("Étape 6.1: Modifier la quantité projetée du titre "+nomDescription +".");
    titleToChange = Get_WinRebalance_TabProjectedPortfolios_DescriptionByTextValue(nomDescription);
    titleToChange.DblClick();
    WaitObject(Get_CroesusApp(),"Uid", "DoubleTextBox_d06d", 6000);
    qteProjetee = Get_WinModifyPosition_GrpPositionInformation_TxtProjectedQuantity();
    
    var prevSep = aqString.ListSeparator;
    aqString.ListSeparator = curencySeparator;
    if (qteProjetee.WaitProperty("VisibleOnScreen", true, 5000) == true && qteProjetee.Value == aqString.GetListItem(nbreOrbres, 0)) {
        Log.Checkpoint("La fenêtre Modifier une position est affichée correctement et la valeur Quantité projetée est affichée.");
        qteProjetee.Clear();
        qteProjetee.set_Text(nouvelleQty);
        Get_WinModifyPosition_BtnOK().Click();
    }
    else
        Log.Error("La valeur Quantité projetée attendue n'est pas celle affichée.");
    
    // Remettre l'ancien séparateur
    aqString.ListSeparator = prevSep;
    
    Log.Message("Étape 6.2: Retourner dans l'onglet "+Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().WPFControlText +" et réévaluer.");
    Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
    WaitObject(Get_CroesusApp(),"Uid", "Button_830b", 6000);
    btnReassess = Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_BtnReassess();
    btnReassess.Click();
    
    if (btnReassess.Visible == false)
        Log.Checkpoint("La réévaluation s'est déroulée avec succès.");
    else
        Log.Error("La réévaluation via le bouton " +btnReassess.WPFControlText +" a rencontrée un problème.");
    
    // Retour à Portefeuille projeté et Valider la modification
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
    WaitObject(Get_CroesusApp(),"Uid", "TotalValuePercentageMarket", 6000);
    Log.Message("Valider la modification de l'ordre d'achat du panier (VM%=3.907)");
    var nouvelleValeurVMP = Get_WinRebalance_TabProjectedPortfolios_MVPercentByLineNb("9").WPFControlText;
    if(nouvelleValeurVMP == modifMVP)
        Log.Checkpoint("La valeur VM(%) de " +nomDescription +" correspond à la modification effectuée.", "Valeur de la colonne lue: " +nouvelleValeurVMP +"  Valeur attendue suite à la modification: " +modifMVP);
    else
        Log.Error("La valeur VM(%) de " +nomDescription +", (" +nouvelleValeurVMP +"), ne correspond pas a la valeur attendue suite à la modification: ("+modifMVP +").");
    
    // Étape 7
    Log.PopLogFolder();
    logEtape7 = Log.AppendFolder("Étape 7: Valider les VM(%) des positions SOLDE.");
    Valider_VMpourcentDeLaLigne("2", compteNo1, description, newTotVMP1);
    Valider_VMpourcentDeLaLigne("3", compteNo2, description, newTotVMP2);
    
    // Étape 8
    Log.PopLogFolder();
    logEtape8 = Log.AppendFolder("Étape 8: Valider le % de liquidités dans pie-chart.");
    lblLegende = Get_WinRebalance_TabProjectedPortfolios_LegendLabelByLineNb("1").WPFControlText;
    pourcentLiquidites = Get_WinRebalance_TabProjectedPortfolios_LegendPercentValueByLineNb("1").WPFControlText;
    
    if (lblLegende == lvLibelle && pourcentLiquidites == newLvPourcent)
      Log.Checkpoint("Les nouveaux pourcentages sur la ligne " +lvLibelle +" dans la légende du pie-chart correspondent aux valeurs attendues.");
    else
      Log.Error("La ligne " +lblLegende +" et les nouveaux pourcentages " +pourcentLiquidites +" dans la légende du pie-chart ne correspondent pas aux valeurs attendues.", "Libellé attendu: " +lvLibelle +" Valeurs % attendus:" +newLvPourcent);
  }
  catch (e) {
    // S'il y a exception, en afficher le message
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Log.PopLogFolder();
    logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
    Log.Message("Retour à l'état initial: Retirer les assignations du modèle.");
    
    SetAutoTimeOut(2000);
    
    if (Get_WinRebalance().Exists == true) {
        WaitObject(Get_CroesusApp(),"Uid", "DoubleTextBox_d06d", 6000);
        if (qteProjetee.WaitProperty("VisibleOnScreen", true, 5000)) {
              Log.Message("Fermer la fenêtre Modifier une position.");
              Get_WinModifyPosition_BtnCancel();
        }
        Log.Message("Fermer la fenêtre de rééquilibrage");
        Get_WinRebalance_BtnClose().Click();
        if(Get_DlgConfirmation().Exists){
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73) 
         }
    }
    if (Get_Models_Details_TabAssignedPortfolios().Visible == true) {
      nbAP = Get_Models_Details_TabAssignedPortfolios_RecordList().Items.Count;
      if (nbAP != 0) {
        for(i = 1; i <= nbAP; i++) {
          Get_Models_Details_TabAssignedPortfolios_RecordListItem(i).Click();
          Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
          Get_DlgConfirmation().FindChild(["ClrClassName","WPFControlName"], ["Button", "PART_Yes"], 10).Click();
        }
      }
    }
    
    // Fermer Croesus
    Close_Croesus_MenuBar();
    if (Get_DlgConfirmation().FindChild(["ClrClassName","WPFControlName"], ["Button", "PART_Yes"], 10).VisibleOnScreen == true) {
      Get_DlgConfirmation().FindChild(["ClrClassName","WPFControlName"], ["Button", "PART_Yes"], 10).Click();
      
    RestoreAutoTimeOut();
    
    //Fermer browser et .Net ClickOnce App Deployment Fulfillment Service
    CloseBrowser(browserName);
    TerminateProcess("dfsvc");
    }
  }
}

function Get_Models_Details_TabAssignedPortfolios_PickerWindowElement(rootClientNumber) {return Aliases.CroesusApp.winPickerWindow.WPFObject("_elementsDataGrid").WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "Value"], ["CellValuePresenter", rootClientNumber], 10)}

function Get_Models_Details_TabAssignedPortfolios_RootClient_BtnOK() {return Aliases.CroesusApp.winPickerWindow.WPFObject("Button", "OK", 1)}

function Get_bottomGroupBox_TabsControler() {return Aliases.CroesusApp.winMain.ModelsPlugin.WPFObject("_bottomGroupBox").WPFObject("_tabCtrl")}

function Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOn_GridLineCheckByDescriptionTypeQty(descriptionRecherchee, typeRecherchee, qtyRecherchee) {
  ligneDataRecordPresenter = Aliases.CroesusApp.winRebalance.WPFObject("_tabControl").WPFObject("_openOrdersManagerWindow").WPFObject("_tabControl").WPFObject("_openOrdersGrids").WPFObject("_bulkGroupsGrid").WPFObject("RecordListControl", "", 1).FindChild(["Uid", "WPFControlText"], ["SecurityDescription", descriptionRecherchee], 10).Parent.Parent.Parent;
  orderTypeDeLaLigne = ligneDataRecordPresenter.FindChild("Uid", "OrderTypeDescription", 10).WPFControlText;
  displayQtyDeLaLigne = ligneDataRecordPresenter.FindChild("WPFControlOrdinalNo", "2", 10).WPFControlText;
  if (orderTypeDeLaLigne == typeRecherchee && displayQtyDeLaLigne == qtyRecherchee)
      return true;
  else
      return false;
}

function Get_WinRebalance_TabProjectedPortfolios_Column(lblColEquartQty) {return Get_WinRebalance_TabProjectedPortfolios_ProjectedGrid().FindChild("ClrClassName","HeaderLabelArea", 10).FindChild("Content", lblColEquartQty, 10)}

function Get_WinRebalance_TabProjectedPortfolios_AccountNumberByLineNb(strLineNumber){return Get_WinRebalance_TabProjectedPortfolios_ProjectedGrid().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DataRecordPresenter", strLineNumber], 10).FindChild("Uid","DisplayAccountNumber", 10)}

function Get_WinRebalance_TabProjectedPortfolios_DescriptionByLineNb(strLineNumber){return Get_WinRebalance_TabProjectedPortfolios_ProjectedGrid().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DataRecordPresenter", strLineNumber], 10).FindChild("Uid","SecurityDescription", 10)}

function Get_WinRebalance_TabProjectedPortfolios_DescriptionByTextValue(txtValue){return Get_WinRebalance_TabProjectedPortfolios_ProjectedGrid().FindChild(["Uid","Value"],["SecurityDescription", txtValue], 10)}

function Get_WinRebalance_TabProjectedPortfolios_MVPercentByLineNb(strLineNumber){return Get_WinRebalance_TabProjectedPortfolios_ProjectedGrid().FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DataRecordPresenter", strLineNumber], 10).FindChild("Uid","TotalValuePercentageMarket", 10)}

function Get_WinRebalance_TabProjectedPortfolios_LegendLineByNumber(strLineNumber) {return Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary().FindChild(["ClrClassName","Uid"], ["DataGrid", "DataGrid_1440"], 10).FindChild(["ClrClassName","WPFControlOrdinalNo"], ["DataRecordPresenter", strLineNumber], 10)}

function Get_WinRebalance_TabProjectedPortfolios_LegendLabelByLineNb(strLineNumber) {return Get_WinRebalance_TabProjectedPortfolios_LegendLineByNumber(strLineNumber).FindChild(["ClrClassName","WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10)}

function Get_WinRebalance_TabProjectedPortfolios_LegendPercentValueByLineNb(strLineNumber) {return Get_WinRebalance_TabProjectedPortfolios_LegendLineByNumber(strLineNumber).FindChild(["ClrClassName","WPFControlOrdinalNo"], ["CellValuePresenter", "4"], 10)}

function Valider_VMpourcentDeLaLigne(strLineNumber, noCompte, description, strVMPAttendu)
{
  accountNb = Get_WinRebalance_TabProjectedPortfolios_AccountNumberByLineNb(strLineNumber).Value;
  descLue = Get_WinRebalance_TabProjectedPortfolios_DescriptionByLineNb(strLineNumber).Value;
  vmpLue = Get_WinRebalance_TabProjectedPortfolios_MVPercentByLineNb(strLineNumber).WPFControlText;
  var valeurRetour;
  
  try{
    if (accountNb == noCompte && descLue == description && vmpLue == strVMPAttendu) {
        Log.Checkpoint("Le numéro de compte, la description et la valeur VM(%) de la ligne " +strLineNumber +" correspondent aux valeurs attendues.", "No. Compte: " +noCompte +"  Description attendue: " +description +  "  VM(%) attendu: " +strVMPAttendu);
        valeurRetour = true;
    }
    else {
        Log.Error("Le numéro de compte " +accountNb +", la description " +descLue +" et la valeur VM(%) " +vmpLue +" de la ligne " +strLineNumber +" ne correspondent pas aux valeurs attendues.", "No. Compte: " +noCompte +"  Description attendue: " +description +  "  VM(%) attendu: " +strVMPAttendu);
        valeurRetour = false;
    }
  }
  catch (e) {
    // S'il y a exception, en afficher le message
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    return valeurRetour;
  }
}