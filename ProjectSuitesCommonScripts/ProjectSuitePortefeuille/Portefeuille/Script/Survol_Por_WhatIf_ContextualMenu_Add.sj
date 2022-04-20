//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions


/* Description :Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur PortfolioBar-btnWhatIf et par la suite, 
Cliquer sur Add du menu contextuel .Vérifier vérifier la présence des contrôles. */

function Survol_Por_WhatIf_ContextualMenu_Add()
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
  
  //Cliquer sur PortfolioBar-btnWhatIf et par la suite, 
  Get_PortfolioBar_BtnWhatIf().Click();
  
  //Cliquer sur Add du menu contextuel
  Get_PortfolioPlugin().ClickR();
  Get_PortfolioGrid_ContextualMenu_Add().Click();
     
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()}  
  //Les points de vérification en anglais 
   else {Check_Properties_English()} 
   
  Check_Existence_Of_Controls();
  
  Get_WinAddPosition().Close();
   
  Close_Croesus_SysMenu();
}

//Fonctions  (les points de vérification pour les scripts qui testent Add position)
function Check_Properties_English()
{
   aqObject.CheckProperty(Get_WinAddPosition().Title, "OleValue", cmpEqual, "Add a Position");
   //btns
   aqObject.CheckProperty(Get_WinAddPosition_BtnOK().Content, "OleValue", cmpEqual, "OK");
   aqObject.CheckProperty(Get_WinAddPosition_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
   
   aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation().Header, "OleValue", cmpEqual, "Add a:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation_LblSecurity().Content, "OleValue", cmpEqual, "Security:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation_CmbTypePicker().SelectedValue, "OleValue", cmpEqual, "Desc.");
   
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation().Header, "OleValue", cmpEqual, "Position Information(CAD)");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblTotalValuePercent().Content, "OleValue", cmpEqual, "Total Value (%):");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblQuantity().Content, "OleValue", cmpEqual, "Quantity:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblPrice().Content, "OleValue", cmpEqual, "Price:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblValue().Content, "OleValue", cmpEqual, "Value:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblYield().Content, "OleValue", cmpEqual, "Yield:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblLastBuy().Content, "OleValue", cmpEqual, "Last Buy:");
   // point de vérification pour Unit cost spécifique pour la US qui remplace Invest.Cost de BNC
   if(client == "US" )
   {aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblUnitCost().Content, "OleValue", cmpEqual, "Unit Cost");}
   else{
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblInvestCost().Content, "OleValue", cmpEqual, "Invest. Cost");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblACB().Content, "OleValue", cmpEqual, "ACB");}
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblMarket().Content, "OleValue", cmpEqual, "Market");
}

function Check_Properties_French()
{
   aqObject.CheckProperty(Get_WinAddPosition().Title, "OleValue", cmpEqual, "Ajouter une position");
   //btns
   aqObject.CheckProperty(Get_WinAddPosition_BtnOK().Content, "OleValue", cmpEqual, "OK");
   aqObject.CheckProperty(Get_WinAddPosition_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
   
   aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation().Header, "OleValue", cmpEqual, "Ajouter un:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation_LblSecurity().Content, "OleValue", cmpEqual, "Titre:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation_CmbTypePicker().SelectedValue, "OleValue", cmpEqual, "Desc.");
   
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation().Header, "OleValue", cmpEqual, "Information sur la position(CAD)");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblTotalValuePercent().Content, "OleValue", cmpEqual, "Valeur totale (%):");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblQuantity().Content, "OleValue", cmpEqual, "Quantité:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblPrice().Content, "OleValue", cmpEqual, "Prix:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblValue().Content, "OleValue", cmpEqual, "Valeur:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblYield().Content, "OleValue", cmpEqual, "Rendement:");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblLastBuy().Content, "OleValue", cmpEqual, "Dernier achat:");
   
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblInvestCost().Content, "OleValue", cmpEqual, "Invest. unit.");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblACB().Content, "OleValue", cmpEqual, "PBR");
   aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_LblMarket().Content, "OleValue", cmpEqual, "Marché");
 
}

function Check_Existence_Of_Controls()
{
  aqObject.CheckProperty(Get_WinAddPosition_BtnOK(), "IsVisible", cmpEqual, true);  
  aqObject.CheckProperty(Get_WinAddPosition_BtnOK(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAddPosition_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_BtnCancel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation_DlListPicker(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation_DlListPicker(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation_CmbTypePicker(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation_CmbTypePicker(), "IsReadOnly", cmpEqual, false); 
  
  aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation_TxtQuickSearchKey(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpSecurityInformation_TxtQuickSearchKey(), "IsReadOnly", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtTotalValuePercent(), "IsVisible", cmpEqual, true);
  Log.Message("Jira BNC-2418")
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtTotalValuePercent(), "IsReadOnly", cmpEqual, true); //EM :90.10.Fm-2 : Avant c'était false Modifié suite à la réponse de Karima car pour qu'il soit active il faut avant ajouter un titre //EM : 90.09.Er-9 : Modifié suite au Jira BNC-2418 - Avant c'était true
  
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtQuantity(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtQuantity(), "IsReadOnly", cmpEqual, true); //EM :90.10.Fm-2 : Avant c'était false Modifié suite à la réponse de Karima car pour qu'il soit active il faut avant ajouter un titre
  if(client == "US" ){
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtUnitCostPrice(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtUnitCostPrice(), "IsReadOnly", cmpEqual, true);  
  } 
  else{
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtInvestCostPrice(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtInvestCostPrice(), "IsReadOnly", cmpEqual, true);  
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtACBPrice(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtACBPrice(), "IsReadOnly", cmpEqual, true); }
   
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtMarketPrice(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtMarketPrice(), "IsReadOnly", cmpEqual, true);
  if(client == "US" ){
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtUnitCostValue(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtUnitCostValue(), "IsReadOnly", cmpEqual, true);
  } 
  else{
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtInvestCostValue(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtInvestCostValue(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtACBValue(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtACBValue(), "IsReadOnly", cmpEqual, true);}
  
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtMarketValue(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtMarketValue(), "IsReadOnly", cmpEqual, true);
  if(client == "US" ){
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtUnitCostYield(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtUnitCostYield(), "IsReadOnly", cmpEqual, true);
  } 
  else{
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtInvestCostYield(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtInvestCostYield(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtACBYield(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_TxtACBYield(), "IsReadOnly", cmpEqual, true);}
  
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_DtpLastBuy(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinAddPosition_GrpPositionInformation_DtpLastBuy(), "IsReadOnly", cmpEqual, false);
  
}

