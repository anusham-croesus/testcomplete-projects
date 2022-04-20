//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions


/* Description :Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur PortfolioBar-CashFlowProj
vérifier le texte des en-têtes et vérifier les contrôles dans TOOLBARTRAY. */

function Survol_Por_PortfolioBar_btnCashFlowProj()
{
  Login(vServerPortefeuille, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click()
  
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800300")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click()
  
  //maillage vers le module portefeuille
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  
  //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
   
  //Cliquer sur PortfolioBar-CashFlowProj
  Get_PortfolioBar_BtnCashFlowProject().Click();
     
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()}    
  //Les points de vérification en anglais 
   else {Check_Properties_English()}
   
  Check_Existence_Of_Controls()
   
  Close_Croesus_AltF4()
}

//Fonctions  (les points de vérification pour les scripts qui testent Grid_column_header)
function Check_Properties_English()
{
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChDescription(), "WPFControlText", cmpEqual, "Description");  
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChDay().Content, "OleValue", cmpEqual, "Day");
   Log.Message("CROES-6255")
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChJanuary().Content, "OleValue", cmpEqual, "Jan. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChFebruary().Content, "OleValue", cmpEqual, "Feb. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChMarch().Content, "OleValue", cmpEqual, "March 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChApril().Content, "OleValue", cmpEqual, "Apr. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChMay().Content, "OleValue", cmpEqual, "May 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChJune().Content, "OleValue", cmpEqual, "June 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChJuly().Content, "OleValue", cmpEqual, "Jul. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChAugust().Content, "OleValue", cmpEqual, "Aug. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChSeptember().Content, "OleValue", cmpEqual, "Sep. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChOctober().Content, "OleValue", cmpEqual, "Oct. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChNovember().Content, "OleValue", cmpEqual, "Nov. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChDecember().Content, "OleValue", cmpEqual, "Dec. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChTotal().Content, "OleValue", cmpEqual, "Total");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChMatured().Content, "OleValue", cmpEqual, "Matured");
       
}

function Check_Properties_French()
{
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChDescription().Content, "OleValue", cmpEqual, "Description");  
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChDay().Content, "OleValue", cmpEqual, "Jour");
   Log.Message("CROES-6255")
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChJanuary().Content, "OleValue", cmpEqual, "Janv. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChFebruary().Content, "OleValue", cmpEqual, "Févr. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChMarch().Content, "OleValue", cmpEqual, "Mars 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChApril().Content, "OleValue", cmpEqual, "Avr. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChMay().Content, "OleValue", cmpEqual, "Mai 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChJune().Content, "OleValue", cmpEqual, "Juin 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChJuly().Content, "OleValue", cmpEqual, "Juill. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChAugust().Content, "OleValue", cmpEqual, "Août 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChSeptember().Content, "OleValue", cmpEqual, "Sept. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChOctober().Content, "OleValue", cmpEqual, "Oct. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChNovember().Content, "OleValue", cmpEqual, "Nov. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChDecember().Content, "OleValue", cmpEqual, "Déc. 10");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChTotal().Content, "OleValue", cmpEqual, "Total");
   aqObject.CheckProperty(Get_Portfolio_ProjectedAnnualIncomeGrid_ChMatured().Content, "OleValue", cmpEqual, "Échue");
 
}


function Check_Existence_Of_Controls()
{
    aqObject.CheckProperty(Get_PortfolioBar_BtnInfo(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnInfo(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioBar_BtnTradeDateBalance(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnTradeDateBalance(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioBar_BtnAll(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnAll(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioBar_BtnWhatIf(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnWhatIf(), "IsEnabled", cmpEqual, true);
    
    //if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ) {aqObject.CheckProperty(Get_PortfolioBar_BtnCompare(), "IsVisible", cmpEqual, true)}; //le bouton devrait être inactif  
    
    //PORTFOLIO TOOLBARTRAY AND TOGGLEBUTTONTOOLBAR
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_BtnTreeViewButton(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_BtnTreeViewButton(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_CmbCurrency(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_CmbCurrency(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_dtpDate(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_dtpDate(), "IsVisible", cmpEqual, true);
    
    if (client == "BNC" ){
      aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(), "IsEnabled", cmpEqual, true);
    }
    else{
      aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(), "IsEnabled", cmpEqual, false);//RJ
    }
    aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(), "IsVisible", cmpEqual, true);
    
    Log.Message("CROES-4816")
    aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass(), "IsEnabled", cmpEqual, false);//RJ

    aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass(), "IsVisible", cmpEqual, true);
    if(client != "RJ" && client != "US" && client != "TD" && client != "CIBC" ){
      aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket(), "IsEnabled", cmpEqual, false);
      aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket(), "IsVisible", cmpEqual, true);
    }  
}
