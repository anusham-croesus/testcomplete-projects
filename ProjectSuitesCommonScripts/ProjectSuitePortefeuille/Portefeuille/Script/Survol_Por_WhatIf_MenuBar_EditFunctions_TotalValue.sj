//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Survol_Por_WhatIf_PortfolioBar_btnTotalValue

/* Description :Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur PortfolioBar-btnWhatIf et par la suite, cliquer sur
le MenuBar-Edit-Functions-TotalValue. Vérifier vérifier la présence des contrôles. */

function Survol_Por_MenuBar_EditFunctions_TotalValue()
{
  Login(vServerPortefeuille, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click()
  
  // Rechercher un client 800300. 
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
  
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().OpenMenu();
  Get_MenuBar_Edit_FunctionsForPortfolio_TotalValue().Click();
     
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()} // la fonction est dans le script Survol_Por_PortfolioBar_btnWhatIf_btnTotalValue  
  //Les points de vérification en anglais 
   else {Check_Properties_English()} // la fonction est dans le script Survol_Por_PortfolioBar_btnWhatIf_btnTotalValue 
   
  Check_Existence_Of_Controls(); // la fonction est dans le script Survol_Por_PortfolioBar_btnWhatIf_btnTotalValue 
  
  Get_WinTotalValue().Close();
   
  Close_Croesus_X();
}

