﻿//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers). Afficher la fenêtre « Sommation des titres » en cliquant sur MenuBar - btnSum. 
 Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre du message en cliquant sur le btn Close */

function Survol_Por_MenuBar_EditSum()
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
    
    //Afficher la fenêtre « Sommation des titres » en cliquant sur MenuBar - btnSum. 
    Get_MenuBar_Edit().OpenMenu();
    Get_MenuBar_Edit_Sum().Click();
    
    //Les points de vérification en français 
    if(language=="french"){Check_Properties_French()} 
    //Les points de vérification en anglais 
    else {Check_Properties_English()} 
    
    Check_Existence_Of_Controls();
    
    Get_WinPortfolioSum_BtnClose().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_AltQ();
}
 
 
  //Fonctions  (les points de vérification pour les scripts qui testent Sum)
function Check_Properties_French()
{
    aqObject.CheckProperty(Get_WinPortfolioSum().Title, "OleValue", cmpEqual, "Sommation (Positions)");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency().Header, "OleValue", cmpEqual, "CAD");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblNumberOfPositions().Content, "OleValue", cmpEqual, "Nombre de positions:");
    Log.Message("CROES-3671")
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblMarketValue().Content, "OleValue", cmpEqual, "Valeur de marché:"); //CROES-3714
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblBookValue().Content, "OleValue", cmpEqual, "Valeur comptable:");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblBalance().Content, "OleValue", cmpEqual, "Solde:");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Int./Div. courus:");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblAnnualIncome().Content, "OleValue", cmpEqual, "Revenu annuel:");  
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblBeta().Content, "OleValue", cmpEqual, "Bêta:")};
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblAverageCostYield().Content, "OleValue", cmpEqual, "Rend. éché. moyen - cout (%):");//CROES-3960
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblModDurationAvg().Content, "OleValue", cmpEqual, "Durée mod. (moy.):");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblAccumIntDiv().Content, "OleValue", cmpEqual, "Int./Div. cumulés:");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblAccumulatedCommission().Content, "OleValue", cmpEqual, "Commissions cumulées:");
    //EM: Modifié depuis 90-08-DY-2 suite à la réponse de Karima : C'est une amélioration -- Avant il n'ya pas le lien Calcul...
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_CalculLinkAccumIntDiv(), "WPFControlText", cmpEqual, "Calcul...");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_CalculLinkAccumulatedCommission(), "WPFControlText", cmpEqual, "Calcul...");
    aqObject.CheckProperty(Get_WinPortfolioSum_BtnClose().Content, "OleValue", cmpEqual, "Fermer");
}

function Check_Properties_English()
{
    aqObject.CheckProperty(Get_WinPortfolioSum().Title, "OleValue", cmpEqual, "Sum (Positions)");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency().Header, "OleValue", cmpEqual, "CAD");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblNumberOfPositions().Content, "OleValue", cmpEqual, "Number of positions:");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblMarketValue().Content, "OleValue", cmpEqual, "Market Value:");
    if(client !== "US" )
    {aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblBookValue().Content, "OleValue", cmpEqual, "Book Value:");}
    // Ajout le point de vérification pour US pour le Cost Basis (pour BNC c'est Book Value mais pour la US c'est Cost Basis) 90-04-49
     if(client == "US" )
    {aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblCostBasis().Content, "OleValue", cmpEqual, "Cost Basis:");}
    
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblBalance().Content, "OleValue", cmpEqual, "Balance:");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Accrued Int./Div.:");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblAnnualIncome().Content, "OleValue", cmpEqual, "Annual Income:");  
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblBeta().Content, "OleValue", cmpEqual, "Beta:")};
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblAverageCostYield().Content, "OleValue", cmpEqual, "Average YTM Cost (%):");//Croes 3960
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblModDurationAvg().Content, "OleValue", cmpEqual, "Mod. Duration (Avg.):");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblAccumIntDiv().Content, "OleValue", cmpEqual, "Accum. Int./Div.:");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_LblAccumulatedCommission().Content, "OleValue", cmpEqual, "Accumulated Commission:");
    //EM: Modifié depuis 90-08-DY-2 suite à la réponse de Karima : C'est une amélioration -- Avant il n'ya pas le lien Calcul...
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_CalculLinkAccumIntDiv(), "WPFControlText", cmpEqual, "Calculate...");
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_CalculLinkAccumulatedCommission(), "WPFControlText", cmpEqual, "Calculate...");
    aqObject.CheckProperty(Get_WinPortfolioSum_BtnClose().Content, "OleValue", cmpEqual, "Close");
}

function Check_Existence_Of_Controls()
{
    aqObject.CheckProperty(Get_WinPortfolioSum_BtnClose(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPortfolioSum_BtnClose(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtNumberOfPositions(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtMarketValue(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtBookValue(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtBalance(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtAccruedIntDiv(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtAnnualIncome(), "IsVisible", cmpEqual, true);  
    if (client == "BNC" ){aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtBeta(), "IsVisible", cmpEqual, true)};
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtAverageCostYield(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtModDurationAvg(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_CalculLinkAccumIntDiv(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_CalculLinkAccumulatedCommission(), "IsVisible", cmpEqual, true);
    Get_WinPortfolioSum_GrpCurrency_CalculLinkAccumIntDiv().Click();//EM: Modifié depuis 90-08-DY-2 suite à la réponse de Karima : C'est une amélioration -- Avant il n'ya pas le lien Calcul...
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtAccumIntDiv(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinPortfolioSum_GrpCurrency_TxtAccumulatedCommission(), "IsVisible", cmpEqual, true);
    
}