//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Survol_Por_WhatIf_Cash_PortfolioBar_Info
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Rechercher une position avec le symbol 1CAD.
Afficher la fenêtre Info pour la position Cash en cliquant sur PortfolioBar -btnInfo. Fermer la fenêtre en cliquant sur le btn Cancel */
 
function Survol_Por_Cash_PortfolioBar_Info()
{
  var btnType="";
  
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
  
  //Rechercher une position avec le symbol 1CAD
  Search_Position("1CAD")
  
  Get_PortfolioBar_BtnInfo().Click();
  
  Get_WinPositionInfo().set_Height(500);
  Get_WinPositionInfo().set_Width(806);
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_Info_Cash_French()}// la fonction est dans CommonCheckpoints
  //Les points de vérification en anglais 
  else{Check_Properties_Info_Cash_English()} // la fonction est dans CommonCheckpoints
  
  Check_Existence_Of_Controls_Info_Cash(btnType) // la fonction est dans CommonCheckpoints
  
  Get_WinPositionInfo_BtnCancel().Click();
  
  Close_Croesus_AltF4();  
 }
