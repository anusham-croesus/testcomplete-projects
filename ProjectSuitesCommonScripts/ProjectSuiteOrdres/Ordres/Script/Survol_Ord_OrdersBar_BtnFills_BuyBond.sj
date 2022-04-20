//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions


/**
    Description : Aller au module "Orders" en cliquant sur BarModules-btnOrders.
    Rechercher un ordre d'achat d'obligation et cliquer sur le bouton "Exécutions" de la barre des Ordres.
    Vérifier les textes et la présence des contrôles de la fenêtre Exécutions.
    @author : christophe.paring@croesus.com
*/

function Survol_Ord_OrdersBar_BtnFills_BuyBond()
{
    var type = "bond";
    var order = "buy";
    var securityDescription = GetData(filePath_Orders, "Order_Fills", 72, language)
        Login(vServerOrders, userNameOrders, pswOrders, language);
        Get_ModulesBar_BtnOrders().Click();
      
        Search_Order_Symbol("Q01560");
    
        Get_OrdersBar_BtnFills().Click();
  
        Check_Properties_OrderFills(language, type, order,securityDescription);
    
        Get_WinOrderFills_BtnCancel().Click();
   
        Close_Croesus_AltF4();
   
}

function Check_Properties_OrderFills(language, type, order,securityDescription)
{
    //Le titre de la fenêtreif 
	Log.Message("Jira CROES-8458 ")
    if(client == "BNC")		
        aqObject.CheckProperty(Get_WinOrderFills(), "Title", cmpContains, GetData(filePath_Orders, "Order_Fills", 5, language)+securityDescription);//Jira CROES-8458
    else
        aqObject.CheckProperty(Get_WinOrderFills(), "Title", cmpContains, GetData(filePath_Orders, "Order_Fills", 2, language));  
    
    //Les boutons OK et Annuler
    aqObject.CheckProperty(Get_WinOrderFills_BtnSave(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 3, language));
    aqObject.CheckProperty(Get_WinOrderFills_BtnSave(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_BtnCancel(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 4, language));
    aqObject.CheckProperty(Get_WinOrderFills_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_BtnCancel(), "IsEnabled", cmpEqual, true);  
    
    
    //Le groupbox Ordre d'achat ou Ordre de vente
    if (order == "sell"){
        aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder(), "Header", cmpStartsWith, GetData(filePath_Orders, "Order_Fills", 7, language));
    }

    if (order == "buy"){
        aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder(), "Header", cmpStartsWith, GetData(filePath_Orders, "Order_Fills", 8, language));
    }
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblSymbol(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 9, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblSymbol(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtSymbol(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtSymbol(), "IsReadOnly", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblOrderNumber(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 10, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblOrderNumber(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtOrderNumber(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtOrderNumber(), "IsReadOnly", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblInitialQuantity(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 11, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblInitialQuantity(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtInitialQuantity(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtInitialQuantity(), "IsReadOnly", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblIACode(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 12, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblIACode(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtIACode(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtIACode(), "IsReadOnly", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblPreviouslyExec(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 13, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblPreviouslyExec(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtPreviouslyExec(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtPreviouslyExec(), "IsReadOnly", cmpEqual, true);
    
    Log.Message("Jira: GDO-1833. On devrait avoir le texte: Valide jusqu'au: / Valid until: ")
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblExpiration(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 14, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblExpiration(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtExpiration(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtExpiration(), "IsReadOnly", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblExecToday(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 15, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblExecToday(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtExecToday(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtExecToday(), "IsReadOnly", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblTodaysAvgPrice(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 16, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblTodaysAvgPrice(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtTodaysAvgPrice(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtTodaysAvgPrice(), "IsReadOnly", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblStatus(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 17, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblStatus(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtStatus(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtStatus(), "IsReadOnly", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblRemainingQuantity(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 18, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_LblRemainingQuantity(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtRemainingQuantity(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtRemainingQuantity(), "IsReadOnly", cmpEqual, true);
    
    
    //Le groupbox Exécutions
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills(), "Header", cmpEqual, GetData(filePath_Orders, "Order_Fills", 21, language));
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblDate(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 22, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblDate(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_CmbDate(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_CmbDate(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_BtnAdd(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 23, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_BtnAdd(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_BtnModify(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 24, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_BtnModify(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_BtnDelete(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 25, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_BtnDelete(), "IsVisible", cmpEqual, true);
    
    if (type == "equity"){ //(type == "stocks") || (type == "equity")
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblRateOriginForEquity(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 26, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblRateOriginForEquity(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_CmbRateOriginForEquity(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_CmbRateOriginForEquity(), "IsEnabled", cmpEqual, false);
        
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblExchangeRateForEquity(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 27, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblExchangeRateForEquity(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtExchangeRateForEquity(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtExchangeRateForEquity(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblExchangeRateCurrenciesForEquity(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 28, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblExchangeRateCurrenciesForEquity(), "IsVisible", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblTotalToConvertForEquity(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 29, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblTotalToConvertForEquity(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtTotalToConvertForEquity(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtTotalToConvertForEquity(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblTotalToConvertCurrenciesForEquity(), "WPFControlText", cmpContains, GetData(filePath_Orders, "Order_Fills", 30, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblTotalToConvertCurrenciesForEquity(), "IsVisible", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblCodedTrailerForEquity(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 31, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblCodedTrailerForEquity(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtDefaultCodedTrailerForEquity(), "Text", cmpEqual, GetData(filePath_Orders, "Order_Fills", 32, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtDefaultCodedTrailerForEquity(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtCodedTrailerForEquity(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtCodedTrailerForEquity(), "IsReadOnly", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblAdditionalNoteForEquity(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 33, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblAdditionalNoteForEquity(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtAdditionalNoteForEquity(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtAdditionalNoteForEquity(), "IsReadOnly", cmpEqual, true);
    }
    
    if ((type == "stocks") ||(type == "bond") || (type == "fixedIncome")){
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblRateOriginForBond(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 26, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblRateOriginForBond(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_CmbRateOriginForBond(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_CmbRateOriginForBond(), "IsEnabled", cmpEqual, false);
        
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblExchangeRateForBond(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 27, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblExchangeRateForBond(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtExchangeRateForBond(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtExchangeRateForBond(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblExchangeRateCurrenciesForBond(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 28, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblExchangeRateCurrenciesForBond(), "IsVisible", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblTotalToConvertForBond(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 29, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblTotalToConvertForBond(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtTotalToConvertForBond(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtTotalToConvertForBond(), "IsReadOnly", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblTotalToConvertCurrenciesForBond(), "WPFControlText", cmpContains, GetData(filePath_Orders, "Order_Fills", 30, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblTotalToConvertCurrenciesForBond(), "IsVisible", cmpEqual, true);
        
        if( type!=="stocks"){
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblAdditionalNoteForBond(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 33, language));
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblAdditionalNoteForBond(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtAdditionalNoteForBond(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtAdditionalNoteForBond(), "IsReadOnly", cmpEqual, true);
        }
        else{
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblCodedTrailerForStock(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 31, language));
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtCodedTrailer1ForStock(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtCodedTrailer1ForStock(), "IsReadOnly", cmpEqual, true);
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtCodedTrailer2ForStock(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtCodedTrailer2ForStock(), "IsReadOnly", cmpEqual, true);
        
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblAdditionalNoteForStock(), "WPFControlText", cmpEqual, GetData(filePath_Orders, "Order_Fills", 33, language));
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_LblAdditionalNoteForStock(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtAdditionalNoteForStock(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinOrderFills_GrpFills_TxtAdditionalNoteForStock(), "IsReadOnly", cmpEqual, true);
          
        } 
    }
    
    //Les en-têtes de colonne par défaut du groupbox Exécutions
    //Get_WinOrderFills_GrpFills_DgvFills_ChStatus().ClickR(); GDO-686 
    Get_WinOrderFills_GrpFills_DgvFills_ChExecutionDate().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChStatus(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 35, language)); GDO-686
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChExecutionDate(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 36, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChSettlementDate(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 37, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChQuantity(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 38, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChSymbol(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 39, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChTotal(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 40, language));
    if ((type == "stocks") || (type == "equity")){
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChPriceForEquity(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 41, language));
    }
    if ((type == "bond") || (type == "fixedIncome")){
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChIAPriceForBond(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 42, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChClientPriceForBond(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 43, language));
    }
    
    //Les autres en-têtes de colonne du groupbox Exécutions
    Get_WinOrderFills_GrpFills_DgvFills_ChExecutionDate().ClickR();
    while (Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true){
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click();
        //Get_WinOrderFills_GrpFills_DgvFills_ChStatus().ClickR(); GDO-686
        Get_WinOrderFills_GrpFills_DgvFills_ChExecutionDate().ClickR();
    }
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChMarket(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 45, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChOurRole(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 46, language));
    if ((type == "bond") || (type == "fixedIncome")){
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChANNPercentForBond(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 47, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChSAPercentForBond(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 48, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChIndexationFactorForBond(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 49, language));
        aqObject.CheckProperty(Get_WinOrderFills_GrpFills_DgvFills_ChInventoryCodeForBond(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 50, language));
    }
    
    
    //L'expander "Répartition (au prorata)"
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander(), "Header", cmpEqual, GetData(filePath_Orders, "Order_Fills", 53, language));
    
    //Les en-têtes de colonne par défaut de l'expander "Répartition (au prorata)"
    Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChAccountNo().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 55, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChName(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 56, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChIACode(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 57, language));
    Log.Message("BNC-2243")
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChCurrency(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 58, language)); //EM: 90-06-Be-13 datapool modifié selon le Jira BNC-2243
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChRequestedQuantity(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 59, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChQuantityAllocatedToday(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 60, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChPreviouslyAllocatedQuantity(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 61, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChTodaysTotalValue(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 62, language));
    
    //Les autres en-têtes de colonne de l'expander "Répartition (au prorata)"
    Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChAccountNo().ClickR();
    while (Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true){
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click();
        Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChAccountNo().ClickR();
    }
    
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChAveragePrice(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 64, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChSymbol(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 65, language));
    aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChTodaysTotalValueNotConverted(), "Content", cmpEqual, GetData(filePath_Orders, "Order_Fills", 66, language));
    
}
