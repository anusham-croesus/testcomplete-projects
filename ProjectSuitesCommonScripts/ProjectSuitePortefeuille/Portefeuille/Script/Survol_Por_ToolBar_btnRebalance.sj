//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Survol_Por_MenuBar_EditSearch

 /* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300 (un compte qui n’est pas associé au modèle). 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).
Afficher la fenêtre «Méthode de rééquilibrage» en cliquant sur ToolBar-btnRebalance.  
Vérifier la présence des contrôles et des étiquetés. Fermer la fenêtre en cliquant sur le btn Annuler*/

function Survol_Por_ToolBar_btnRebalance() //LE BOUTON N’EST PAS ACTIF DANS AUTOMATION 9 
{
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
//  //Rechercher un client 800300
//  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Account("800300")}
//  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click();

 //maillage vers le module portefeuille 
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
      
  //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
  
  //Afficher la fenêtre «Méthode de rééquilibrage»
  Get_Toolbar_BtnRebalance().Click();
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()} 
  //Les points de vérification en anglais 
  else {Check_Properties_English()} 
  
  Get_WinRebalancingMethod_BtnCancel().Click();
  
  Close_Croesus_SysMenu();
}
 
 //Fonctions (les points de vérification pour les scripts qui testent «Méthode de rééquilibrage»)
function Check_Properties_French()
{
   aqObject.CheckProperty(Get_WinRebalancingMethod().Title, "OleValue", cmpEqual, "Rééquilibrer");
   aqObject.CheckProperty(Get_WinRebalancingMethod_RdoWithSelectedModel().Content, "OleValue", cmpEqual, "Avec un modèle sélectionné");
   aqObject.CheckProperty(Get_WinRebalancingMethod_BtnOK().Content, "OleValue", cmpEqual, "OK");
   aqObject.CheckProperty(Get_WinRebalancingMethod_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
}
function Check_Properties_English()
{
   aqObject.CheckProperty(Get_WinRebalancingMethod().Title, "OleValue", cmpEqual, "Rebalance");
   aqObject.CheckProperty(Get_WinRebalancingMethod_RdoWithSelectedModel().Content, "OleValue", cmpEqual, "With Selected Model");
   aqObject.CheckProperty(Get_WinRebalancingMethod_BtnOK().Content, "OleValue", cmpEqual, "OK");
   aqObject.CheckProperty(Get_WinRebalancingMethod_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
}

function Check_Existence_Of_Controls()
{
   aqObject.CheckProperty(Get_WinRebalancingMethod_RdoWithAssignedModel(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalancingMethod_BtnOK(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinRebalancingMethod_BtnCancel(), "IsVisible", cmpEqual, true);
}
