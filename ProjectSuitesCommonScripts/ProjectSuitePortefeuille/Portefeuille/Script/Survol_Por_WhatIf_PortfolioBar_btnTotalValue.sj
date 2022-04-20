//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions


/* Description :Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur PortfolioBar-btnWhatIf et par la suite, cliquer sur
le btn Total Value. Vérifier vérifier la présence des contrôles. */

function Survol_Por_WhatIf_PortfolioBar_btnTotalValue()
{
  Login(vServerPortefeuille, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click()
  
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
  
  Get_PortfolioBar_BtnWhatIf().Click();
  Get_PortfolioBar_BtnTotalValue().Click();
     
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()}    
  //Les points de vérification en anglais 
   else {Check_Properties_English()}
   
  Check_Existence_Of_Controls();
  
  Get_WinTotalValue_BtnCancel().Click();
   
  Close_Croesus_AltF4();
}

//Fonctions  (les points de vérification pour les scripts qui testent TotalValue)
function Check_Properties_English()
{
   aqObject.CheckProperty(Get_WinTotalValue().Title, "OleValue", cmpEqual, "Total Value");
   aqObject.CheckProperty(Get_WinTotalValue_BtnOK().Content, "OleValue", cmpEqual, "OK");
   aqObject.CheckProperty(Get_WinTotalValue_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
}

function Check_Properties_French()
{
   aqObject.CheckProperty(Get_WinTotalValue().Title, "OleValue", cmpEqual, "Valeur totale");
   aqObject.CheckProperty(Get_WinTotalValue_BtnOK().Content, "OleValue", cmpEqual, "OK");
   aqObject.CheckProperty(Get_WinTotalValue_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
 
}

function Check_Existence_Of_Controls()
{
  aqObject.CheckProperty(Get_WinTotalValue_TxtTotalValue(), "IsVisible", cmpEqual, true); 
  aqObject.CheckProperty(Get_WinTotalValue_TxtTotalValue(), "IsReadOnly", cmpEqual, false); 
   
  aqObject.CheckProperty(Get_WinTotalValue_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTotalValue_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinTotalValue_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTotalValue_BtnCancel(), "IsEnabled", cmpEqual, true);
}

