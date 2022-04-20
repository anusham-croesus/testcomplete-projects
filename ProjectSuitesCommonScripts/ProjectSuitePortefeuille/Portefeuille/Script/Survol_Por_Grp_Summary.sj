//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Survol_Por_MenuBar_EditSearch

 /* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).
Vérifier la présencedes étiquetés dans uu groupe "Summary".*/

function Survol_Por_Grp_Summary()
{
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  //Rechercher un client 800300.
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
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()} 
  //Les points de vérification en anglais 
  else {Check_Properties_English()} 
   
  Close_Croesus_SysMenu();
 }
 
 //Fonctions (les points de vérification pour les scripts qui testent «Méthode de rééquilibrage»)
function Check_Properties_French()
{
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary().Header, "OleValue", cmpEqual, "Sommaire");
   
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblMarketValue().Content, "OleValue", cmpEqual, "Valeur de marché:");//CROES-3714
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblBookValue().Content, "OleValue", cmpEqual, "Valeur comptable:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblBalance().Content, "OleValue", cmpEqual, "Solde:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Int./Div. courus:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblAnnualIncome().Content, "OleValue", cmpEqual, "Revenu annuel:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblBeta().Content, "OleValue", cmpEqual, "Bêta:");
   
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblAverageCostYield().Content, "OleValue", cmpEqual, "Rend. éché. moyen - cout (%):"); //CROES-3960
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblModDurationAvg().Content, "OleValue", cmpEqual, "Durée mod. (moy.):");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblNetInvestment().Content, "OleValue", cmpEqual, "Investissement net:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblMargin().Content, "OleValue", cmpEqual, "Marge:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblAccumulatedCommission().Content, "OleValue", cmpEqual, "Commissions cumulées:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblAccumIntDiv().Content, "OleValue", cmpEqual, "Int./Div. cumulés:");
}
function Check_Properties_English()
{
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary().Header, "OleValue", cmpEqual, "Summary");
   
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblMarketValue().Content, "OleValue", cmpEqual, "Market Value:");
   if(client !== "US")
   {aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblBookValue().Content, "OleValue", cmpEqual, "Book Value:");}
    if(client == "US")
   {aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblCostBasis().Content, "OleValue", cmpEqual, "Cost Basis:");}
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblBalance().Content, "OleValue", cmpEqual, "Balance:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Accrued Int./Div.:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblAnnualIncome().Content, "OleValue", cmpEqual, "Annual Income:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblBeta().Content, "OleValue", cmpEqual, "Beta:");
   
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblAverageCostYield().Content, "OleValue", cmpEqual, "Average YTM Cost (%):");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblModDurationAvg().Content, "OleValue", cmpEqual, "Mod. Duration (Avg.):");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblNetInvestment().Content, "OleValue", cmpEqual, "Net Investment:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblMargin().Content, "OleValue", cmpEqual, "Margin:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblAccumulatedCommission().Content, "OleValue", cmpEqual, "Accumulated Commission:");
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LblAccumIntDiv().Content, "OleValue", cmpEqual, "Accum. Int./Div.:");    
}

function Check_Existence_Of_Controls()
{
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtMarketValue(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtBookValue(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtBalance(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtAccruedIntDiv(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtAnnualIncome(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtBeta(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtAverageCostYield(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtModDurationAvg(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtNetInvestment(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_TxtMargin(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LlbAccumulatedCommission(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_PortfolioGrid_GrpSummary_LlbAccumIntDiv(), "IsVisible", cmpEqual, true);  
    
}