//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_functions
//USEUNIT Common_Get_functions

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur le btn What-if
Rechercher une position avec le symbol 1CAD. Afficher la fenêtre Info pour la position Cash
en cliquant sur btnInfo du menu contextuel. Fermer la fenêtre par ESC */
 
 function Survol_Por_WhatIf_ContextualMenu_Functions_Info()
 {
  Login(vServerPortefeuille, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
  
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800300")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}

  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu()
  Get_MenuBar_Modules_Portfolio_DragSelection().Click()
   
  Get_PortfolioBar_BtnWhatIf().Click();
  
  Search_Position("OBA")
  
  Get_MainWindow().Keys("[Apps]")
  Get_PortfolioGrid_ContextualMenu_Functions().Click()
  Get_PortfolioGrid_ContextualMenu_Functions_Info().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()}
  //Les points de vérification en anglais 
  else{Check_Properties_English()} 
  
  Check_Existence_Of_Controls()
  
  Get_WinPositionInfo_BtnCancel().Keys("[Esc]")
  
  Close_Croesus_X()    
 }
 
 //Fonctions  (les points de vérification pour les scripts qui testent Info)
function Check_Properties_French()
{
     aqObject.CheckProperty(Get_WinPositionInfo_BtnOK(), "Content", cmpEqual, "OK");
     aqObject.CheckProperty(Get_WinPositionInfo_BtnCancel(), "Content", cmpEqual, "Annuler");
             
     //Security Information:
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation().Header, "OleValue", cmpEqual, "Information sur le titre");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSubcategory().Text, "OleValue", cmpEqual, "Sous-catégorie:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSecurity().Text, "OleValue", cmpEqual, "Titre:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCalculationFactor().Text, "OleValue", cmpEqual, "Facteur de calcul:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblUnderlyingSecurity().Text, "OleValue", cmpEqual, "Titre sous-jacent:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCallPrice().Text, "OleValue", cmpEqual, "Prix échéance:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCallDate().Text, "OleValue", cmpEqual, "Rembours. anticipé:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblInterest().Text, "OleValue", cmpEqual, "Intérêts:");
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblFrequency().Text, "OleValue", cmpEqual, "Fréquence:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblModifiedDuration().Text, "OleValue", cmpEqual, "Durée modifiée:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCUSIP().Text, "OleValue", cmpEqual, "CUSIP:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_Lbl1stCoupon().Text, "OleValue", cmpEqual, "1er coupon:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblIssueDate().Text, "OleValue", cmpEqual, "Date d'émission:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblInterest().Text, "OleValue", cmpEqual, "Intérêts:");
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblMaturity().Text, "OleValue", cmpEqual, "Échéance:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblPrincipalFactor().Text, "OleValue", cmpEqual, "Facteur principal:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblISIN().Text, "OleValue", cmpEqual, "ISIN:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCompoundInterestMethod().Text, "OleValue", cmpEqual, "Méthode de composition:");
     
     
     //Position Information (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation().Header, "OleValue", cmpEqual, "Information sur la position (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblQuantity().Text, "OleValue", cmpEqual, "Quantité:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblCost().Text, "OleValue", cmpEqual, "Coût:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblHeldIn().Text, "OleValue", cmpEqual, "Détenue en CAD");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblValue().Text, "OleValue", cmpEqual, "Valeur:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblTotalValuePercent().Text, "OleValue", cmpEqual, "Valeur totale (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblCurrentYieldPercent().Text, "OleValue", cmpEqual, "Rendement courant (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblYieldPercent().Text, "OleValue", cmpEqual, "Rendement (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblYTMNominalPercent().Text, "OleValue", cmpEqual, "Rend. éché. - Nominal (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblYTMEffectivePercent().Text, "OleValue", cmpEqual, "Rend. éché. - En vigueur (%):");

     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblInvestedCapital().Text, "OleValue", cmpEqual, "Capital investi");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblBookValue().Text, "OleValue", cmpEqual, "Valeur comptable");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblMarketValue().Text, "OleValue", cmpEqual, "Valeur au marché"); 
         
     //Gains/Losses(CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses().Header, "OleValue", cmpEqual, "Gains/Pertes (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblInvestedCapital().Content, "OleValue", cmpEqual, "Capital investi");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblBookValue().Content, "OleValue", cmpEqual, "Valeur comptable");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblUnrealized().Content, "OleValue", cmpEqual, "Non réalisés:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblUnrealizedPercent().Content, "OleValue", cmpEqual, "Non réalisés (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblYTDNominalPercent().Content, "OleValue", cmpEqual, "RAJ - Nominal (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblYTDEffectivePercent().Content, "OleValue", cmpEqual, "RAJ - En vigueur (%):");
     
     //Income (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome().Header, "OleValue", cmpEqual, "Revenu (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_LblAnnual().Content, "OleValue", cmpEqual, "Annuel:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Int./Div. courus:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_LblAccumIntDiv().Content, "OleValue", cmpEqual, "Int./Div. cumulés:");
     
     //Miscellaneous (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous().Header, "OleValue", cmpEqual, "Divers (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_LblCommission().Text, "OleValue", cmpEqual, "Commission:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_LblLastBuy().Text, "OleValue", cmpEqual, "Dernier achat:"); 
        
     //Exclusion
     aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion().Header, "OleValue", cmpEqual, "Exclusion");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromProjectedIncome(), "Content", cmpEqual, "Exclure de la projection de liquidités");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkLockedPosition(), "Content", cmpEqual, "Position bloquée");
//     if(client=="FBN"){aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromBilling(), "Content", cmpEqual, "Exclure de la facturation")}; //N’existe pas dans automation 9
}

function Check_Properties_English()
{
     aqObject.CheckProperty(Get_WinPositionInfo_BtnOK(), "Content", cmpEqual, "OK");
     aqObject.CheckProperty(Get_WinPositionInfo_BtnCancel(), "Content", cmpEqual, "Cancel");
     
     //Security Information:
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation().Header, "OleValue", cmpEqual, "Security Information");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSubcategory().Text, "OleValue", cmpEqual, "Subcategory:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSecurity().Text, "OleValue", cmpEqual, "Security:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCalculationFactor().Text, "OleValue", cmpEqual, "Calculation Factor:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblUnderlyingSecurity().Text, "OleValue", cmpEqual, "Underlying Security:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCallPrice().Text, "OleValue", cmpEqual, "Call Price:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCallDate().Text, "OleValue", cmpEqual, "Call Date:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblInterest().Text, "OleValue", cmpEqual, "Interest:");
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblFrequency().Text, "OleValue", cmpEqual, "Frequency:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblModifiedDuration().Text, "OleValue", cmpEqual, "Modified Duration:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCUSIP().Text, "OleValue", cmpEqual, "CUSIP:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_Lbl1stCoupon().Text, "OleValue", cmpEqual, "1st Coupon:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblIssueDate().Text, "OleValue", cmpEqual, "Issue Date:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblInterest().Text, "OleValue", cmpEqual, "Interest:");
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblMaturity().Text, "OleValue", cmpEqual, "Maturity:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblPrincipalFactor().Text, "OleValue", cmpEqual, "Principal Factor:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblISIN().Text, "OleValue", cmpEqual, "ISIN:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCompoundInterestMethod().Text, "OleValue", cmpEqual, "Compound Interest Method:");
     
     
     //Position Information (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation().Header, "OleValue", cmpEqual, "Position Information (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblQuantity().Text, "OleValue", cmpEqual, "Quantity:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblCost().Text, "OleValue", cmpEqual, "Cost:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblHeldIn().Text, "OleValue", cmpEqual, "Held in CAD");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblValue().Text, "OleValue", cmpEqual, "Value:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblTotalValuePercent().Text, "OleValue", cmpEqual, "Total Value (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblCurrentYieldPercent().Text, "OleValue", cmpEqual, "Current Yield (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblYieldPercent().Text, "OleValue", cmpEqual, "Yield (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblYTMNominalPercent().Text, "OleValue", cmpEqual, "YTM - Nominal (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblYTMEffectivePercent().Text, "OleValue", cmpEqual, "YTM - Effective (%):");

     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblInvestedCapital().Text, "OleValue", cmpEqual, "Invested Cap.");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblBookValue().Text, "OleValue", cmpEqual, "Book Value");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblMarketValue().Text, "OleValue", cmpEqual, "Market Value");  
        
     //Gains/Losses(CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses().Header, "OleValue", cmpEqual, "Gains/Losses (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblInvestedCapital().Content, "OleValue", cmpEqual, "Invested Cap.");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblBookValue().Content, "OleValue", cmpEqual, "Book Value");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblUnrealized().Content, "OleValue", cmpEqual, "Unrealized:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblUnrealizedPercent().Content, "OleValue", cmpEqual, "Unrealized (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblYTDNominalPercent().Content, "OleValue", cmpEqual, "YTD - Nominal (%):");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblYTDEffectivePercent().Content, "OleValue", cmpEqual, "YTD - Effective (%):");
     
     //Income (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome().Header, "OleValue", cmpEqual, "Income (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_LblAnnual().Content, "OleValue", cmpEqual, "Annual:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Accrued Int./Div.:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_LblAccumIntDiv().Content, "OleValue", cmpEqual, "Accum. Int./Div.:");
     
     //Miscellaneous (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous().Header, "OleValue", cmpEqual, "Miscellaneous (CAD)");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_LblCommission().Text, "OleValue", cmpEqual, "Commission:");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_LblLastBuy().Text, "OleValue", cmpEqual, "Last Buy:");    
     
     //Exclusion
     aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion().Header, "OleValue", cmpEqual, "Exclusion");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromProjectedIncome(), "Content", cmpEqual, "Exclude from Projected Income");
     aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkLockedPosition(), "Content", cmpEqual, "Locked Position");
     //if(client=="FBN"){aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromBilling(), "Content", cmpEqual, "Exclude from billing")}; //n’existe pas dans automation 9
}

function Check_Existence_Of_Controls()
{   
     aqObject.CheckProperty(Get_WinPositionInfo_BtnOK(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_BtnOK(), "IsEnabled", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPositionInfo_BtnCancel(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
     
     // Tab Info
     //Get_WinPositionInfo().Click()
     
     //Security Information:
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtSubcategory(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtSecurity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCalculationFactor(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtUnderlyingSecurity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCallPrice(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCallDate(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtInterest(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtFrequency(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtModifiedDuration(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCUSIP(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_Txt1stCoupon(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtIssueDate(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtInterestCurrency(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtMaturity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtPrincipalFactor(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtISIN(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCompoundInterestMethod(), "IsVisible", cmpEqual, true);
     
     
     //Position Information (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(), "IsReadOnly", cmpEqual, false);
      
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalCost(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalCost(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValue(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValue(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalTotalValuePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalTotalValuePercent(), "IsReadOnly", cmpEqual, true);
//      
//     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalTotalValuePercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalTotalValuePercent(), "IsReadOnly", cmpEqual, true);
          
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCost(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCost(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValue(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValue(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueTotalValuePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueTotalValuePercent(), "IsReadOnly", cmpEqual, true);
     
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCost(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCost(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValue(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValue(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueTotalValuePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueTotalValuePercent(), "IsReadOnly", cmpEqual, false);
     
     
     //Gains/Losses(CAD)    
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealized(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealized(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealized(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealized(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealizedPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealizedPercent(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalYTDEffectivePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalYTDEffectivePercent(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalYTDNominalPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalYTDNominalPercent(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueYTDNominalPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueYTDNominalPercent(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueYTDEffectivePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueYTDEffectivePercent(), "IsReadOnly", cmpEqual, true);
     
          
     //Income (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAnnual(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAnnual(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAccruedIntDiv(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAccruedIntDiv(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAccumIntDiv(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_TxtAccumIntDiv(), "IsReadOnly", cmpEqual, true);
     
     //Miscellaneous (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_TxtCommission(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_TxtCommission(), "IsReadOnly", cmpEqual, true);
      
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_TxtLastBuy(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_TxtLastBuy(), "IsReadOnly", cmpEqual, false);
     
     //Exclusion
     if(client=="FBN")
//     {aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromBilling(), "IsEnabled", cmpEqual, false); //N’existe pas dans automation 9
//      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromBilling(), "IsVisible", cmpEqual, true);}//N’existe pas dans automation 9
      
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromProjectedIncome(), "IsEnabled", cmpEqual, true); 
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromProjectedIncome(), "IsVisible", cmpEqual, true); 
      
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkLockedPosition(), "IsEnabled", cmpEqual, true);
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkLockedPosition(), "IsVisible", cmpEqual, true);
}

