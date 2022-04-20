//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Jira Xray                 : TCVE-1335
    Description               : Vue du portefeuille projeté par compte_Maintenance des Crs 1869, 2044 et 2059
    Version de scriptage      : ref90-16-2020-5-42

    Analyste d'automatisation : Youlia Raisper
**/

function TCVE1335_CR1869CR2044CR2059_ViewOfTheProjectedPortfolioByAccount()
{
    var logEtape1, logEtape2,logEtape3,logEtape4,logEtape6,logEtape7,logEtape8,logEtape9,logEtape10,logEtape11,logEtape12,logEtape13,logEtape14,logEtape15,logEtape16,logEtape17,logEtape18,logEtape19,logRetourEtatInitial;
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-1335");
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var relTESTCH1869=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "relTESTCH1869", language+client);
        var positionSLFPRB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "positionSLFPRB", language+client);
        var CHCANADIANEQUI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "CHCANADIANEQUI", language+client);
        var CmbAssetAllocationValue=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "CmbAssetAllocationValue", language+client);
        var GroupByAccountSortByValue=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "GroupByAccountSortByValue", language+client);
        var GroupByAccountSortByValueTabTextHeader=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "GroupByAccountSortByValueTabTextHeader", language+client);
        var BMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "BMO", language+client);
        var target40=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "target40", language+client);
        var marketValueBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "marketValueBMO", language+client);
        var account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "account800049NA", language+client);
        var marketTargetValueBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "marketTargetValueBMO", language+client);
        var marketTargetValueBMO_addWin=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "marketTargetValueBMO_addWin", language+client);
        var TargetValueAddWin=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "TargetValueAddWin", language+client);
        var MSFT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "MSFT", language+client);
        var account800062NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "account800062NA", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "typePicker", language+client);
        var targetValue30=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "targetValue30", language+client);
        var BCE= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "BCE", language+client);
        
        var ToolTipBMOBuyStep1_0=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOBuyStep1_0", language+client);
        var ToolTipBMOBuyStep1_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOBuyStep1_1", language+client);
        var ToolTipBMOBuyStep1_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOBuyStep1_2", language+client);
        var ToolTipBMOSellStep1_0=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOSellStep1_0", language+client);
        var ToolTipBMOSellStep1_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOSellStep1_1", language+client);
        var ToolTipBMOSellStep1_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOSellStep1_2", language+client);
        var ToolTipBMOBuyStep6_0=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOBuyStep6_0", language+client);
        var ToolTipBMOBuyStep6_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOBuyStep6_1", language+client);
        var ToolTipBMOBuyStep6_2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOBuyStep6_2", language+client);
        var ToolTipBMOBuyStep7_0=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOBuyStep7_0", language+client);
        var ToolTipBMOBuyStep7_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOBuyStep7_1", language+client);
        var ToolTipBMOBuyStep16_0=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOBuyStep16_0", language+client);
        var ToolTipBMOBuyStep16_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "TCVE1335", "ToolTipBMOBuyStep16_1", language+client);
 
       //******************************************* Préconditions*******************************************
        var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerModeles, "config_txt");
        Activate_Inactivate_Pref("KEYNEJ","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","YES",vServerModeles);
        Activate_Inactivate_Pref("KEYNEJ","PREF_PROJECTED_PF_DETAILED_LEVEL ","3",vServerModeles);
        Activate_Inactivate_Pref("KEYNEJ","PREF_PROJECTED_PF_DEFAULT_VIEW","4",vServerModeles);
        Activate_Inactivate_Pref("KEYNEJ","PREF_MULTIPLE_USER_REBALANCE","YES",vServerModeles); 
        // déjà PREF_PROJECTED_PF_DETAILED_LEVEL 
        RestartServices(vServerModeles);

        //******************************************* Étape 1***************************************************        
        logEtape1 = Log.AppendFolder("Étape 1:Associer la relation TESTCH-1869 au modèle CH canadian equities");
        
        Log.Message("Se connecter à croesus");
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        
        Log.Message("aller au module Relations");
        Get_ModulesBar_BtnRelationships().Click();
        
        SearchRelationshipByName(relTESTCH1869);// la relation a deux comptes 800049-NA et 800062-NA
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",relTESTCH1869,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked",true,2000);
        
        if(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionSLFPRB,10).DataContext.DataItem.IsBlocked==false){
            Log.Message("Bloqier la position SLF.PR.B");
            Search_Position(positionSLFPRB);
            SetAutoTimeOut();
            var numberOftries=0; 
            while ( numberOftries < 5 && !Get_SubMenus().Exists){//Dans le cas, si le click ne fonctionne pas 
              Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionSLFPRB),10).ClickR();
              numberOftries++;
            }     
            RestoreAutoTimeOut();
        
            Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
            Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
            Log.Message("Valider que la position est bloquée") 
            aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionSLFPRB,10).DataContext.DataItem, "IsBlocked", cmpEqual,true); //Avant IsLegacy  
        }
        
                   
        Log.Message("aller au module Relations");
        Get_ModulesBar_BtnRelationships().Click();

        Log.Message("Associer la relation au modèle CH canadian equities");
        AssignRelationshipToModel(relTESTCH1869, CHCANADIANEQUI);
  
        //******************************************* Étape 2***************************************************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Rééquilibrer le modèle CH Canadian equities selon la valeur cible");
        
        Log.Message("Rééquilibrer le modèle CH Canadian ");
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        }                                                 
        Get_WinRebalance().Parent.Maximize(); 
        
        Log.Message("Décocher--> Valider les tolérences des titres, Répartir la liquidité entre les comptes selon la tolérence du solde et Appliquer les réserves de liquidités");
        Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
        Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
        Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
                
        Log.Message("Aller au Portefeuille projeté");
        GoToProjectedPortfolios();
        
        SetAutoTimeOut();
        if(Get_WinWarningDeleteGeneratedOrders().Exists){
          Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        }
        RestoreAutoTimeOut();
        
        if(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().IsChecked==false){
            Log.Error("Le Portefeuille projeté ne s'affiche pas avec la vue Par compte");
          
        }else{
            Log.Message("Le Portefeuille projeté s'affiche avec la vue Par compte");
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio(), "IsSelected", cmpEqual,true);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount(), "IsChecked", cmpEqual,true);
        
            Log.Message("Niveau d'affichage Par position et avec la répartition d'actif de la firme");
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortBy().SelectedItem, "Value", cmpEqual,GroupByAccountSortByValue);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GroupByAccount_SortBy().DataContext, "TabTextHeader", cmpEqual,GroupByAccountSortByValueTabTextHeader);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_CmbAssetAllocation().SelectedValue, "Description", cmpEqual,CmbAssetAllocationValue);
        

            //******************************************* Étape 3***************************************************        
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3: 1. Positionner le curseur sur l'ordre d'achat BMO et valider les information affichées dans le Tooltip 2. Positionner le curseur sur l'ordre de vente BCE et valider les informations");
            Log.Message(" Validation de Tooltip. Achat de BMO:Achat 55 283$,10% de la relation,13% du compte");
            ScrollTo(BMO);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(0),"Text", cmpEqual,ToolTipBMOBuyStep1_0);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(1),"Text", cmpEqual,ToolTipBMOBuyStep1_1);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(2),"Text", cmpEqual,ToolTipBMOBuyStep1_2);

            Log.Message("Validation de Tooltip. Vente de BCE:Vente 5 936$ 1% de la relation 5% du compte");
            ScrollTo(BCE);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BCE,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["sellIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(0),"Text", cmpEqual,ToolTipBMOSellStep1_0);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BCE,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["sellIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(1),"Text", cmpEqual,ToolTipBMOSellStep1_1);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BCE,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["sellIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(2),"Text", cmpEqual,ToolTipBMOSellStep1_2);
            //******************************************* Étape 4***************************************************        
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4: modifier la Valeur cible de BMO");
            Log.Message("Double cliquer sur l'icône d'achat de BMO puis modifier la Valeur cible (%)-40%");
            //ScrollTo(BMO);
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).DblClick()
            Log.Message("La fenêtre Modifier une position s'ouvre");
            Get_WinModifyPosition_GrpPositionInformation_TxtTotalValuePercentageMarket().Keys(target40);
            Log.Message("Clique sur OK");
            Get_WinModifyPosition_BtnOK().Click();
        
            //******************************************* Étape 6***************************************************        
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6: Positionner le curseur sur l'icône d'achat BMO puis valider les informations affichées");
            Log.Message("Validation de ToolTip. Achat 113 513$ 21% de la relation 27% du compte");
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(0),"Text", cmpEqual,ToolTipBMOBuyStep6_0);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(1),"Text", cmpEqual,ToolTipBMOBuyStep6_1);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(2),"Text", cmpEqual,ToolTipBMOBuyStep6_2);
            //******************************************* Étape 7***************************************************        
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Étape 7: Sélectionner le compte 800049-NA dans le browser de gauche puis valider les informations du Tooltip sur l'iône d'Achat de BMO");
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",account800049NA,10).Click();
        
            Log.Message("Validation de ToolTip : Achat 113 513$ 27% du compte");
            ScrollTo(BMO);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(0),"Text", cmpEqual,ToolTipBMOBuyStep7_0);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(1),"Text", cmpEqual,ToolTipBMOBuyStep7_1);
            //******************************************* Étape 8***************************************************        
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8: Cliquer sur Par compte pour retourner à la vue standart dans pp");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().Click();
               
            //******************************************* Étape 9***************************************************        
            Log.PopLogFolder();
            logEtape9 = Log.AppendFolder("Étape 9: Valider la valeur de marché de l'ordre d'achat BMO");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();        
            Search(BMO);
            Log.Message("Valeur de marché=218 813.40");
            aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "MarketValue", cmpEqual,marketValueBMO);

            //******************************************* Étape 10***************************************************        
            Log.PopLogFolder();
            logEtape10 = Log.AppendFolder("Étape 10: Sélectionner la relation TESTCH-CR1869");
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",relTESTCH1869,10).Click();
        
            //******************************************* Étape 11***************************************************        
            Log.PopLogFolder();
            logEtape11 = Log.AppendFolder("Étape 11:Sélectionner le titre BMO puis cliquer sur Supprimer et confirmer");
            ScrollTo(BMO);
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Click();
        
            Log.Message("Le titre BMO est supprimé");
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnDelete().Click();
            Get_DlgConfirmation_BtnYes().Click();
        
            //******************************************* Étape 12***************************************************        
            Log.PopLogFolder();
            logEtape12 = Log.AppendFolder("Étape 12:Double cliquer sur l'icône de vente de BMO");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["sellIcon",true],10).DblClick();
        
            Log.Message("La fenêtre Modifier une position s'ouvre La Valeur cible (%)=0");
            aqObject.CheckProperty(Get_WinModifyPosition_GrpPositionInformation_TxtTotalValuePercentageMarket(), "Text", cmpEqual,marketTargetValueBMO);
            Get_WinModifyPosition_BtnCancel().Click();
        
            //******************************************* Étape 13***************************************************        
            Log.PopLogFolder();
            logEtape13 = Log.AppendFolder("Étape 13:Retourner au pp vue standart puis double clic sur le titre BMO et valider la valeur cible (%)");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().Click();
        
            Log.Message("Fenêtre Modifier une position:Valeur cible (%)=0");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();        
            Search(BMO);
            Get_WinRebalance_PositionsGrid().FindChild("Value",BMO,10).DblClick();
            aqObject.CheckProperty(Get_WinModifyPosition_GrpPositionInformation_TxtTotalValuePercentageMarket(), "Text", cmpEqual,marketTargetValueBMO);
            Get_WinModifyPosition_BtnCancel().Click();
        
            //******************************************* Étape 14***************************************************        
            Log.PopLogFolder();
            logEtape14 = Log.AppendFolder("Étape 14:Sélectionnet la relation dans le browser de gauche puis cliquer sur l'icône grise du titre BMO dans le compte 800062-NA");
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",relTESTCH1869,10).Click();
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_BtnGroupByAccount().Click();
            ScrollTo(BMO);
            Log.Message("La fenêtre Ajouter une position est ouverte");
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyDefaultIcon",true],10).DblClick()
            aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtTotalValuePercent(), "Text", cmpEqual,marketTargetValueBMO_addWin);
        
            //******************************************* Étape 15***************************************************        
            Log.PopLogFolder();
            logEtape15 = Log.AppendFolder("Étape 15:Saisir une valeur cible% puis confirmer");
            Log.Message("Valeur sible (%)=10");
            Get_WinAddPosition_GrpPositionInformation_TxtTotalValuePercent().set_Text(TargetValueAddWin);
            Get_WinAddPosition_BtnOK().WaitProperty("Enabled",true,2000);
            Get_WinAddPosition_BtnOK().Click();
            SetAutoTimeOut();
            if(Get_WinAddPosition_BtnOK().Exists){
              Get_WinAddPosition_BtnOK().Click();
            }
            RestoreAutoTimeOut();
            //******************************************* Étape 16***************************************************       
            Log.PopLogFolder();
            logEtape16 = Log.AppendFolder("Étape 16:Valider les informations affichés dans le Tooltip d'Achat de BMO dans le compte 800062-NA");
            Log.Message("Tooltip Achat BMO: Achat 54 703$ 10% de la relation");
            Log.Message("Achat 54 703$ 10% de la relation");
            ScrollTo(BMO);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(0),"Text", cmpEqual,ToolTipBMOBuyStep16_0);
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",BMO,10).Parent.Parent.FindChild(["WPFControlName","VisibleOnScreen"],["buyIcon",true],10).Parent.DataContext.Parent.Parent.ToolTip.Children.Item(0).Child.Children.Item(1),"Text", cmpEqual,ToolTipBMOBuyStep16_1);
            //******************************************* Étape 17***************************************************       
            Log.PopLogFolder();
            logEtape17 = Log.AppendFolder("Étape 17:Cliquer sur Ajouter en haut à droite pour ajouter une position");
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd().Click();
            Log.Message("La fenêtre Ajouter une position est ouverte");
            Get_WinAddPosition().WaitProperty("Exists",true,2000);
        
            //******************************************* Étape 18***************************************************        
            Log.PopLogFolder();
            logEtape18 = Log.AppendFolder("Étape 18: Ajouter la position MSFT");
            Log.Message("Sélectionner le compte 800062-NA.");
            SelectComboBoxItem(Get_WinAddPosition_GrpAccount_CmbAccount(),account800062NA);
        
            Log.Message("Saisir le symbole MSFT.");
            Get_WinAddPosition_GrpAdd_CmbTypePicker().Click();
            Get_SubMenus().Find("Text",typePicker,10).Click();
            Get_WinAddPosition_GrpAdd_TxtQuickSearchKey().Keys(MSFT);
            Get_WinAddPosition_GrpAdd_DlSecurityListPicker().Click();
        
            SetAutoTimeOut()
            if(Get_SubMenus().Exists){
            Get_SubMenus().Find("Value",MSFT,10).DblClick();
            };  
            RestoreAutoTimeOut();  
        
            Log.Message("Dans Valeur cible (%), saisir 30");          
            Get_WinAddPosition_GrpPositionInformation_TxtTotalValuePercent().Keys(targetValue30); 
            Get_WinAddPosition_BtnOK().Click();
        
            //******************************************* Étape 19***************************************************        
            Log.PopLogFolder();
            logEtape19 = Log.AppendFolder("Étape 19:Valider l'ajout de la position MSFT");
            Log.Message("La position MSFT ajouté est affichée");
            aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",MSFT,10), "Exists", cmpEqual,true);
        
            Get_WinRebalance_BtnClose().Click() 
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73);
        };

        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
  
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial: Débloquer la position et ");
        
        Log.Message("Se connecter à croesus");
        Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
        
        Log.Message("aller au module Relations");
        Get_ModulesBar_BtnRelationships().Click();
        
        Log.Message("Bloqier la position SLF.PR.B");
        SearchRelationshipByName(relTESTCH1869);// la relation a deux comptes 800049-NA et 800062-NA
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",relTESTCH1869,10), Get_ModulesBar_BtnPortfolio());
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked",true,2000);
        
        Search_Position(positionSLFPRB);
        SetAutoTimeOut();
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_SubMenus().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionSLFPRB),10).ClickR();
          numberOftries++;
        }    
        RestoreAutoTimeOut();
        
        Log.Message("Débloquer la position");
        Search_Position(positionSLFPRB);
        Get_PortfolioBar_BtnInfo().click();
        Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().Set_IsChecked(false);
        Get_WinPositionInfo_BtnOK().click();
        
        Log.Message("Valider que la position XBB est débloquée");   
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionSLFPRB,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
        
        Log.Message("aller au module Modele");
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(CHCANADIANEQUI);
        Get_ModelsGrid().Find("Value",CHCANADIANEQUI,10).Click();
        
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",relTESTCH1869,10).Exists){
           Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",relTESTCH1869,10).Click();
           Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
           var width = Get_DlgConfirmation().Get_Width();
           Get_DlgConfirmation().Click((width*(1/3)),73);
         }
         if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",relTESTCH1869,10).Exists){
           Log.Error("La relation est toujours associé au modèle")
         }
         else{
           Log.Checkpoint("La relation n'est plus associé au modèle")}
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        
        Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerModeles);
        RestartServices(vServerModeles);
        Runner.Stop(true); 
    }
}

function Search(security){
  Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Keys("F");
  WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
  Get_WinQuickSearch_TxtSearch().Clear();
  Get_WinQuickSearch_TxtSearch().Keys(security);
  Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);
  Get_WinQuickSearch_BtnOK().Click();
}

function GoToProjectedPortfolios(){
   Get_WinRebalance_BtnNext().Click();  
   Get_WinRebalance_BtnNext().Click();  
   Get_WinRebalance_BtnNext().Click();
   WaitObject(Get_CroesusApp(), "Uid", "ProjectedPortfolioByAccountGrid_74e4");
}

function ScrollTo(security){
  SetAutoTimeOut();  
  var numberOftries=0;  
  while ( numberOftries < 50 && !Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().FindChild("Value",security,10).Exists){//Dans le cas, si le click ne fonctionne pas 
    Scroll();
    numberOftries++;
  }   
  RestoreAutoTimeOut();
}

function Scroll1(){
  var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().get_ActualWidth();
  var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().get_ActualHeight();
  Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().Click(ControlWidth-80, ControlHeight-20)
}

function Scroll(){
  Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_DgByAccount().WPFObject("RecordListControl", "", 1).Keys("[Down]");
}

function test(){
  if(Get_WinWarningDeleteGeneratedOrders().Exists){
          Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        }
}


