//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Rechercher une position avec le symbol OBA (bond).
Afficher la fenêtre Info en cliquant sur MenuBar -Edit-Functions- btnInfo. Fermer la fenêtre par X */
 
function Survol_Por_Bond_MenuBar_EditFunctions_Info()
{
  var type="bond";
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800300")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click();

  //maillage vers le module portefeuille 
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
      
  //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
  
  //Rechercher une position avec le symbol OBA (bond).
  Search_Position("OBA")
  
  //Afficher la fenêtre Info en cliquant sur MenuBar -Edit-Functions- btnInfo
  Get_MenuBar_Edit().OpenMenu()
  Get_MenuBar_Edit_Functions().OpenMenu()
  Get_MenuBar_Edit_FunctionsForPortfolio_Info().Click()
  
 //Les points de vérification 
  Check_Info_Properties(language, type)
  Check_Details_Properties(language, type)
  if(client == "US" ){
    Check_Lots_Properties(language, type);// la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  } 
  Check_PositionInfo_Properties(language, type)
  Check_Existence_Of_Controls_TabInfo(type)
  Check_Existence_Of_Controls_TabDetails(type) 
  if(client == "US" ){
    Check_Existence_Of_Controls_TabLots(type);
  } 
  Check_Existence_Of_Controls_PositionInfo(type)
    
  Get_WinPositionInfo().Close();
  
  Close_Croesus_X();    
 }

 
 //Fonctions  (les points de vérification pour les scripts qui testent Info)
function Check_Info_Properties(language, type)
{
     aqObject.CheckProperty(Get_WinPositionInfo_BtnOK(), "Content", cmpEqual,  GetData(filePath_Portefeuille,"Info",2,language));
     aqObject.CheckProperty(Get_WinPositionInfo_BtnCancel(), "Content", cmpEqual, GetData(filePath_Portefeuille,"Info",3,language));
     
     //Tab Info
     Get_WinPositionInfo_TabInfo().Click()
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo().Header, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",5,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo(), "IsSelected", cmpEqual, true);
     
     //Security Information:
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation().Header, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",6,language));
     
     if(type=="bond"){     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSubcategoryForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",7,language));    
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSecurityForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",8,language));
          
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCalculationFactorForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",9,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblUnderlyingSecurityForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",10,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCallPriceForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",11,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCallDateForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",12,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblInterestForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",13,language));
     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblFrequencyForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",14,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblModifiedDurationForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",15,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCUSIPForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",16,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_Lbl1stCouponForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",17,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblIssueDateForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",18,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblInterestCurrencyForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",19,language));
     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblMaturityForBond().Text, "OleValue", cmpEqual,GetData(filePath_Portefeuille,"Info",20,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblPrincipalFactorForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",21,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblISINForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",22,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCompoundInterestMethodForBond().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",23,language));}
     
     if(type=="equity"){     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSubcategoryForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",27,language)); 
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSectorForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",28,language));     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSymbolForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",29,language));          
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCalculationFactorForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",30,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblFrequencyForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",31,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",32,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblIssueDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",33,language));
     if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
        aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblBetaForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",34,language));
     }
     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSecurityForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",35,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCUSIPForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",36,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",37,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblRecordDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",38,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCallDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",39,language));
     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblMarketForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",40,language));     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblISINForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",41,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendCurrencyForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",42,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblExDividendDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",43,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblConversionDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",44,language));}
     
     if(type=="other"){     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSubcategoryForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",48,language));    
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSymbolForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",49,language)); 
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCUSIPForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",50,language));         
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblFrequencyForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",51,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblExDividendDateForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",52,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblSecurityForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",53,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblISINForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",54,language));
    
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",55,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblRecordDateForOther().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",56,language));
     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblCalculationFactorForOther().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",57,language));   
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendDateForOther().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",58,language));     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblDividendCurrencyForOther().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",59,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_LblBetaForOther().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",60,language));}
}

function Check_Details_Properties(language, type)
{     
     //Tab Details
     Get_WinPositionInfo_TabDetails().Click()
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails(), "IsSelected", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails().Header, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",62,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions().Header, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",63,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_BtnSeparate().Content, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",64,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_BtnReassign().Content, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",65,language));
        
     //if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChAsterisk().Content, "OleValue", cmpEqual, "*")}; //N’existe pas dans automation 9
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChDate().Content, "OleValue", cmpEqual,GetData(filePath_Portefeuille,"Info",66,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChSettlementDate().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",67,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChType().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",68,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChQty().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",69,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChTotal().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",70,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChExchangeRate().Content, "OleValue", cmpEqual,GetData(filePath_Portefeuille,"Info",71,language));
     if(client != "US" ){
       aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChPositionIC().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",72,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChPositionACB().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",73,language));
     } 
     
     if(type=="bond"){
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChPosCYPercent().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",76,language));}       
     if(type=="equity"  ||  type=="other"){
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChPosCYPercentForEquity().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",74,language));}
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChTransCYPercent().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",75,language));
}
// ajout de la fonction pour Check_Lots_Properties la US
function Check_Lots_Properties(language, type)
{     
     //Tab Lots
     Get_WinPositionInfo_TabLots().Click()
     Get_WinPositionInfo().set_Width(1000);
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots(), "IsSelected", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots().Header, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",115,language));
     
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_BtnExpandAll().Content, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",116,language));
    
        
     //if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_ChAsterisk().Content, "OleValue", cmpEqual, "*")}; //N’existe pas dans automation 9
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_Grp_ChOpeningDate().Content, "OleValue", cmpEqual,GetData(filePath_Portefeuille,"Info",117,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_Grp_ChClosingDate().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",118,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_Grp_ChQty().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",119,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_Grp_ChCost().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",120,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_Grp_ChCostBasis().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",121,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_Grp_ChGLType().Content, "OleValue", cmpEqual,GetData(filePath_Portefeuille,"Info",122,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_Grp_ChMarketPrice().Content, "OleValue", cmpEqual,GetData(filePath_Portefeuille,"Info",123,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_Grp_ChMarketValue().Content, "OleValue", cmpEqual,GetData(filePath_Portefeuille,"Info",124,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_Grp_ChUnrealGL().Content, "OleValue", cmpEqual,GetData(filePath_Portefeuille,"Info",125,language));
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_Grp_ChRealGL().Content, "OleValue", cmpEqual,GetData(filePath_Portefeuille,"Info",126,language));
     
     
}


function Check_PositionInfo_Properties(language, type)
{     

     //Position Information (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation().Header, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",78,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblQuantity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",79,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblCost().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",80,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblValue().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",81,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblValuePercent().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",82,language)); // Jira CROES-4288
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblCurrentYieldPercent().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",83,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblYieldPercent().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",84,language));
     
     if(type=="bond"){
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblYTMNominalPercent().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",85,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblYTMEffectivePercent().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",86,language));}

     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblInvestedCapital().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",87,language));
     if(client !== "US"){
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblBookValue().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",88,language));}
     if(client == "US"){ 
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblCostBasis().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",111,language));}
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_LblMarketValue().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",89,language)); //Jira CROES-3714
     
     if(client !== "US" ){   
     //Gains/Losses(CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses().Header, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",91,language));  
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblUnrealized().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",92,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblUnrealizedPercent().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",93,language));
        
     if(type=="bond"){
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblYTDNominalPercent().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",94,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblYTDEffectivePercent().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",95,language));}
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblInvestedCapital().Content, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",96,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_LblBookValue().Content, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",97,language));} 
     
     //Income (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome().Header, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",99,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_LblAnnual().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",100,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_LblAccruedIntDiv().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",101,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpIncome_LblAccumIntDiv().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",102,language));
     
     //Miscellaneous (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous().Header, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",104,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_LblCommission().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",105,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpMiscellaneous_LblLastBuy().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",106,language));  
       
     //Exclusion
     aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion().Header, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",108,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromProjectedIncome(), "Content", cmpEqual, GetData(filePath_Portefeuille,"Info",109,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkLockedPosition(), "Content", cmpEqual, GetData(filePath_Portefeuille,"Info",110,language));
     if (client == "US"){aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromBilling(), "Content", cmpEqual, GetData(filePath_Portefeuille,"Info",112,language))};
      if(client == "US" ){
      //Summary
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary().Header, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",130,language));
       //Method
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpMethod().Header, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",131,language));
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpMethod_LblAsOf().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",132,language));
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpMethod_Lbl01252010().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",133,language));
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpMethod_TxtFIFO().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",134,language));
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpMethod_BtnConfigure().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",135,language));
       
      // Unrealized Gain/Losses
      aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses().Header, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",139,language));
      aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_LblShortTerm().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",140,language));
      aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_LblLongTerm().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",141,language));
      aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_LblTotal().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",142,language)); 
      
     // Realized gains and losses
      aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses().Header, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",146,language));
      aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_LblShortTerm().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",147,language));
      aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_LblLongTerm().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",148,language));
      aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_LblTotal().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",149,language));
      aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_LblCurrentYear().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",150,language));
      aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_LblSinceInception().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",151,language)); 
     
     
      }
}


function Check_Existence_Of_Controls_TabInfo(type)
{   
     // Tab Info
     Get_WinPositionInfo_TabInfo().Click()
     //Security Information:
     if(type=="bond"){
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSubcategoryForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSecurityForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCalculationFactorForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtUnderlyingSecurityForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCallPriceForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCallDateForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtInterestCurrencyForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtFrequencyForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtModifiedDurationForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCUSIPForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_Txt1stCouponForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtIssueDateForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtInterestCurrencyForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtMaturityForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtPrincipalFactorForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtISINForBond(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCompoundInterestMethodForBond(), "IsVisible", cmpEqual, true);}
     
     if(type=="equity"){
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSubcategoryForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSectorForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSymbolForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCalculationFactorForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtFrequencyForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtDividendDateForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtIssueDateForEquity(), "IsVisible", cmpEqual, true);
       if (client == "BNC" ){
        aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtBetaForEquity(), "IsVisible", cmpEqual, true);
       }
     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtSecurityForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCUSIPForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtDividendForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtRecordDateForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtCallDateForEquity(), "IsVisible", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtMarketForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtISINForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtDividendCurrencyForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtExDividendDateForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation_TxtConversionDateForEquity(), "IsVisible", cmpEqual, true);
     }
}
function Check_Existence_Of_Controls_TabDetails(type) 
{   
     // Tab Details
     Get_WinPositionInfo_TabDetails().Click()
     //aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_BtnReassign(), "IsVisible", cmpEqual, true); YR 90-04-44
     //aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_BtnReassign(), "IsEnabled", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_BtnSeparate(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_BtnSeparate(), "IsEnabled", cmpEqual, true);
     

}


// ajout de la fonction Check_Existence_Of_Controls_TabLots pour la US
function Check_Existence_Of_Controls_TabLots(type) 
{   
     // Tab Lots
     Get_WinPositionInfo_TabLots().Click()
     //aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_BtnReassign(), "IsVisible", cmpEqual, true); YR 90-04-44
     //aqObject.CheckProperty(Get_WinPositionInfo_TabDetails_GrpTransactions_BtnReassign(), "IsEnabled", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_BtnExpandAll(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_TabLots_BtnExpandAll(), "IsEnabled", cmpEqual, true);
     
     

}

function Check_Existence_Of_Controls_PositionInfo(type,btnType)
{
     //Position Information (CAD)
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(), "IsVisible", cmpEqual, true);
     if(btnType=="whatif"){
       aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(), "IsReadOnly", cmpEqual, false);}
     else{
       aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtQuantity(), "IsReadOnly", cmpEqual, true);};
     if( client != "US" ){
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalCost(), "IsVisible", cmpEqual, true);}
     if (client == "CIBC" || client == "BNC" || client == "TD" ){
        aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalCost(), "IsReadOnly", cmpEqual, false);
     }
     if(client != "US" && client != "BNC"  &&  client!= "CIBC"&& client != "TD"  ){//RJ
        aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalCost(), "IsReadOnly", cmpEqual, true);
     }
     if( client != "US" ){          
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValue(), "IsVisible", cmpEqual, true);}
     if (client == "CIBC" || client == "BNC" || client == "TD" ){
        aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValue(), "IsReadOnly", cmpEqual, false);
     }
     if(client != "US" && client != "BNC"  &&  client!= "CIBC" && client != "TD"  ){
        aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValue(), "IsReadOnly", cmpEqual, true);
     }
     if(client != "US" ){
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValuePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtInvestedCapitalValuePercent(), "IsReadOnly", cmpEqual, true);}
    // ajouter le point de vérification pour Cost Basis pour la US et pour les autres c'est BNC
    if(client == "US" ){
      aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisCost(), "IsVisible", cmpEqual, true);
    } 
    else{
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCost(), "IsVisible", cmpEqual, true);}
     
     if(btnType=="whatif"){
     if(client == "US" ){
       aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisCost(), "IsReadOnly", cmpEqual, false) 
       
     } 
       else {aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCost(), "IsReadOnly", cmpEqual, false)}}
     else{
     if(client == "US" ){
       aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisCost(), "IsReadOnly", cmpEqual, true)
     } 
     else{
       aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueCost(), "IsReadOnly", cmpEqual, true)}}
     if(client == "US" ){
       aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisValue(), "IsVisible", cmpEqual, true);
     } 
     else{
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValue(), "IsVisible", cmpEqual, true);}
     
     if(btnType=="whatif"){
     if(client == "US" ){
       aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisValue(), "IsReadOnly", cmpEqual, false)
     } 
       else {aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValue(), "IsReadOnly", cmpEqual, false)}}
     else{
     if(client == "US" ){
      aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisValue(), "IsReadOnly", cmpEqual, true) 
     } 
     else{
       aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValue(), "IsReadOnly", cmpEqual, true)}}
     if(client == "US" ){
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisValuePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisValuePercent(), "IsReadOnly", cmpEqual, true);
     } 
     else{
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValuePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValuePercent(), "IsReadOnly", cmpEqual, true);}
    
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCost(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueCost(), "IsReadOnly", cmpEqual, true);
               
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValue(), "IsVisible", cmpEqual, true);
     
     if(btnType=="whatif"){
        aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValue(), "IsReadOnly", cmpEqual, false)}
     else{
     if(client == "US" ){
      aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtCostBasisValue(), "IsReadOnly", cmpEqual, true) 
     } else{
        aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtBookValueValue(), "IsReadOnly", cmpEqual, true)}}
      
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValuePercent(), "IsVisible", cmpEqual, true);
     if(btnType=="whatif"){
        aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValuePercent(), "IsReadOnly", cmpEqual, false)}
     else{
        aqObject.CheckProperty(Get_WinPositionInfo_GrpPositionInformation_TxtMarketValueValuePercent(), "IsReadOnly", cmpEqual, true)}
     
     //Gains/Losses(CAD)  
     if(client != "US" ){ 
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealized(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealized(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealized(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealized(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealizedPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalUnrealizedPercent(), "IsReadOnly", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealizedPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueUnrealizedPercent(), "IsReadOnly", cmpEqual, true);} 
     
     if(type=="bond" && client != "US" ){ 
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalYTDEffectivePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalYTDEffectivePercent(), "IsReadOnly", cmpEqual, true);     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalYTDNominalPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtInvestedCapitalYTDNominalPercent(), "IsReadOnly", cmpEqual, true);         
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueYTDNominalPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueYTDNominalPercent(), "IsReadOnly", cmpEqual, true);    
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueYTDEffectivePercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpGainsLosses_TxtBookValueYTDEffectivePercent(), "IsReadOnly", cmpEqual, true);
     }
          
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
//     if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" )
//     {aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromBilling(), "IsEnabled", cmpEqual, false); //N’existe pas dans automation 9
//      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromBilling(), "IsVisible", cmpEqual, true);} //N’existe pas dans automation 9
      
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromProjectedIncome(), "IsEnabled", cmpEqual, true);
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromProjectedIncome(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromProjectedIncome(), "IsChecked", cmpEqual, false);
      
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkLockedPosition(), "IsEnabled", cmpEqual, true);
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkLockedPosition(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkLockedPosition(), "IsChecked", cmpEqual, false);
      

      
      if( client == "US"){
       aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromBilling(), "IsEnabled", cmpEqual, true);
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromBilling(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinPositionInfo_GrpExclusion_ChkExcludeFromBilling(), "IsChecked", cmpEqual, false);
       //Method
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpMethod_TxtFIFO(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpMethod_TxtFIFO(), "IsReadOnly", cmpEqual, true);
        
      //Unrealized Gains/Losses
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_TxtShortTerm(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_TxtShortTerm(), "IsReadOnly", cmpEqual, true);
       
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_TxtLongTerm(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_TxtLongTerm(), "IsReadOnly", cmpEqual, true);
       
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_TxtTotal(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpUnrealizedGainsLosses_TxtTotal(), "IsReadOnly", cmpEqual, true);
      
      //Realized gains and losses
      
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtShortTermCurrentYear(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtShortTermCurrentYear(), "IsReadOnly", cmpEqual, true);
       
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtShortTermSinceInception(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtShortTermSinceInception(), "IsReadOnly", cmpEqual, true);
       
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtLongTermCurrentYear(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtLongTermCurrentYear(), "IsReadOnly", cmpEqual, true);
       
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtLongTermSinceInception(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtLongTermSinceInception(), "IsReadOnly", cmpEqual, true);
       
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtTotalCurrentYear(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtTotalCurrentYear(), "IsReadOnly", cmpEqual, true);
       
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtTotalSinceInception(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpRealizedGainsAndLosses_TxtTotalSinceInception(), "IsReadOnly", cmpEqual, true);
      
      } 
}

function test(){
 aqObject.CheckProperty(Get_WinPositionInfo_GrpSummary_GrpMethod_BtnConfigure().Content, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",135,language));
} 