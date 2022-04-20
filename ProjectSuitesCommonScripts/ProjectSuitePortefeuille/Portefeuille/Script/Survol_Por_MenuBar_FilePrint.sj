﻿//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers). Afficher la fenêtre « Print » en cliquant sur MenuBar - btnPrint. 
Cliquer sur le btnCancel, Vérifier le message «Impression annulée». Fermer la fenêtre en cliquant sur le bouton "OK" */
 
function Survol_Por_MenuBar_FilePrint()
{
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click()
  
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
  
  Get_MenuBar_File().OpenMenu();
  Get_MenuBar_File_Print().Click();
  
  //Les points de vérification en français 
  if(language=="french"){Check_Print_Properties_French()}// la fonction est dans le script CommonCheckpoints
  //Les points de vérification en anglais 
  else{Check_Print_Properties_English()}// la fonction est dans le script CommonCheckpoints
  
  //Get_DlgPrinting_BtnOK().Click(); //EM: Modifié pour CO-90-07-22
  Get_DlgInformation().Close();
  
  Close_Croesus_AltF4();
 }
 

