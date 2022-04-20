//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers). Vérifier l’affichage de la fenêtre 
'Croesus - Nicolas Copernic (COPERN)'  contenant les boutons "Info", "Solde date trans.","Proj. Liquidités", "Tous", "Simulation", "Comparaison" 
et vérifier la présence des contrôles dans TOOLBARTRAY .Fermer l’application avec AltF4 */ 

function Survol_Por_AltF4()
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
 
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()}   
  //Les points de vérification en anglais 
   else {Check_Properties_English()}
   
  //Les points de vérification: La présence des contrôles
  Check_Existence_Of_Controls()
  
  Close_Croesus_AltF4()
}

//Fonctions  (les points de vérification pour les scripts qui testent Close_Application)
function Check_Properties_French()
{
    //if(Get_PortfolioBar_BtnIntraday().Exists){Get_PortfolioBar_BtnIntraday().Click()}
    
    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Nicolas Copernic (COPERN)");
    aqObject.CheckProperty(Get_PortfolioBar_BtnInfo().Content, "OleValue", cmpEqual, "_Info");
    aqObject.CheckProperty(Get_PortfolioBar_BtnTradeDateBalance().Content, "OleValue", cmpEqual, "So_lde date trans.");
    aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject().Content, "OleValue", cmpEqual, "Pro_j. liquidités");
    aqObject.CheckProperty(Get_PortfolioBar_BtnAll().Content, "OleValue", cmpEqual, "_Tous");
    aqObject.CheckProperty(Get_PortfolioBar_BtnWhatIf().Content, "OleValue", cmpEqual, "Simulat_ion"); 
//    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){aqObject.CheckProperty(Get_PortfolioBar_BtnCompare().Content, "OleValue", cmpEqual, "_Comparaison")}; //le bouton n’est pas actif dans automation  
    
}

function Check_Properties_English()
{
    //if(Get_PortfolioBar_BtnIntraday().Exists){Get_PortfolioBar_BtnIntraday().Click()}
     
    aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Nicolas Copernic (COPERN)");
    aqObject.CheckProperty(Get_PortfolioBar_BtnInfo().Content, "OleValue", cmpEqual, "I_nfo");
    aqObject.CheckProperty(Get_PortfolioBar_BtnTradeDateBalance().Content, "OleValue", cmpEqual, "Trade Date _Bal.");
    aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject().Content, "OleValue", cmpEqual, "Cash Fl_ow Proj.");
    aqObject.CheckProperty(Get_PortfolioBar_BtnAll().Content, "OleValue", cmpEqual, "_All");
    aqObject.CheckProperty(Get_PortfolioBar_BtnWhatIf().Content, "OleValue", cmpEqual, "_What-If"); //le bouton n’est pas actif dans automation 9
    //if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){aqObject.CheckProperty(Get_PortfolioBar_BtnCompare().Content, "OleValue", cmpEqual, "_Compare")}; //le bouton n’est pas actif dans automation 9           
}

function Check_Existence_Of_Controls()
{
    aqObject.CheckProperty(Get_PortfolioBar_BtnInfo(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnTradeDateBalance(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnCashFlowProject(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnAll(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioBar_BtnWhatIf(), "IsVisible", cmpEqual, true); 
//    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){aqObject.CheckProperty(Get_PortfolioBar_BtnCompare(), "IsVisible", cmpEqual, true)}; //le bouton n’est pas actif dans automation 9
    
    //PORTFOLIO TOOLBARTRAY AND TOGGLEBUTTONTOOLBAR
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_BtnTreeViewButton(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_BtnTreeViewButton(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_CmbCurrency(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_CmbCurrency(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_dtpDate(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_dtpDate(), "IsVisible", cmpEqual, true);
    if (client == "BNC"){
      aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(), "IsEnabled", cmpEqual, true);
    }
    else{//RJ
      aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(), "IsEnabled", cmpEqual, false);
    }
    aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass(), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass(), "IsVisible", cmpEqual, true);
    
    aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket(), "IsEnabled", cmpEqual, false); 
    if(client != "US" && client != "TD" && client != "RJ" && client != "CIBC"){
      aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket(), "IsVisible", cmpEqual, true); 
    }
    else{
      aqObject.CheckProperty(Get_PortfolioGrid_BarToggleButtonToolBar_BtnByBasket(), "IsVisible", cmpEqual, false); 
    }

}













