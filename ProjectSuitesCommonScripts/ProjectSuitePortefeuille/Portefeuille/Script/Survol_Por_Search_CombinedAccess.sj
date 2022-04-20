//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions

 /* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).  
Afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search. 
 Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre en cliquant sur le btn Cancel*/


/*    Date: 30-12-2020
      Analyste Auto: Abdel.M
      Objectif: Combiner les différentes façons de recherche
*/
 
 function Survol_Por_Search_CombinedAccess()
 {
   try {
          // Les variables utilisées dans les points de vérifications 
          var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "client800300", language+client);
          
 //---------- Étape 1 : Se connecter à croesus avec COPERN -------------------------------
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
          Login(vServerPortefeuille, userName, psw, language);
          Get_ModulesBar_BtnClients().Click();
          if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client(clientNumber)}
          else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}

          //maillage vers le module portefeuille 
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
          
 //----------- Étape 2 : Accès à la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search ---------------------------------------
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Accès à la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search");
  
          //Afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search.
          Get_MenuBar_Edit().OpenMenu();
          Get_MenuBar_Edit_Search().Click();
  
          //Les points de vérification en français 
          if(language=="french"){Check_Properties_French()}
          //Les points de vérification en anglais 
          else {Check_Properties_English()}
  
          Check_Existence_Of_Controls(); // la fonction est dans le script Survol_Por_MenuBar_EditSearch
  
          Get_WinQuickSearch_BtnCancel().Click();
          
 //----------- Étape 3 : Accès à la fenêtre "Rechercher" par clavier ---------------------------------------
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Accès à la fenêtre Rechercher par clavier");
  
          Get_MainWindow().Keys("F");
  
          //Les points de vérification en français 
          if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Por_MenuBar_EditSearch
          //Les points de vérification en anglais 
          else {Check_Properties_English()} // la fonction est dans le script Survol_Por_MenuBar_EditSearch
  
          Check_Existence_Of_Controls(); // la fonction est dans le script Survol_Por_MenuBar_EditSearch
  
          Get_WinQuickSearch_BtnCancel().Click();
          
  //----------- Étape 4 : Accès à la fenêtre « Rechercher » en cliquant sur ToolBar-btnSearch  ---------------------------------------
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Accès à la fenêtre « Rechercher » en cliquant sur ToolBar-btnSearch");
          
          //Afficher la fenêtre « Rechercher » en cliquant sur ToolBar-btnSearch.
          Get_Toolbar_BtnSearch().Click();
  
          //Les points de vérification en français 
          if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Por_MenuBar_EditSearch
          //Les points de vérification en anglais 
          else {Check_Properties_English()} // la fonction est dans le script Survol_Por_MenuBar_EditSearch
  
          Check_Existence_Of_Controls(); // la fonction est dans le script Survol_Por_MenuBar_EditSearch
  
          Get_WinQuickSearch_BtnCancel().Keys("[Esc]");
  
     }  
     catch(e) 
     {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                     
     }
     finally 
     {   
       //Étape 5 : Se déconnecter de Croesus  ------------------------------------------
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Se déconnecter de Croesus ");
        //Fermer Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)       
        
    }
      
 }
 
 function Check_Properties_French()
{
     aqObject.CheckProperty(Get_WinQuickSearch().Title, "OleValue", cmpEqual, "Rechercher");

     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoDescription().DataContext.Label, "OleValue", cmpEqual, "Description");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSecurity().DataContext.Label, "OleValue", cmpEqual, "Titre");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSymbol().DataContext.Label, "OleValue", cmpEqual, "Symbole");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoName().DataContext.Label, "OleValue", cmpEqual, "Nom");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoType().DataContext.Label, "OleValue", cmpEqual, "Type");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoAccountNo().DataContext.Label, "OleValue", cmpEqual, "No compte");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoIACode().DataContext.Label, "OleValue", cmpEqual, "Code de CP");
     
     //btns
     aqObject.CheckProperty(Get_WinQuickSearch_BtnOK().Content, "OleValue", cmpEqual, "OK");
     aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
     
     aqObject.CheckProperty(Get_WinQuickSearch_LblSearch().Text, "OleValue", cmpEqual, "Rechercher:");
     aqObject.CheckProperty(Get_WinQuickSearch_LblIn().Text, "OleValue", cmpEqual, "Dans:");     
}

function Check_Properties_English()
{
     aqObject.CheckProperty(Get_WinQuickSearch().Title, "OleValue", cmpEqual, "Search");
     
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoDescription().DataContext.Label, "OleValue", cmpEqual, "Description");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSecurity().DataContext.Label, "OleValue", cmpEqual, "Security");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSymbol().DataContext.Label, "OleValue", cmpEqual, "Symbol");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoName().DataContext.Label, "OleValue", cmpEqual, "Name");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoType().DataContext.Label, "OleValue", cmpEqual, "Type");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoAccountNo().DataContext.Label, "OleValue", cmpEqual, "Account No.");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoIACode().DataContext.Label, "OleValue", cmpEqual, "IA Code");
     
     //btns
     aqObject.CheckProperty(Get_WinQuickSearch_BtnOK().Content, "OleValue", cmpEqual, "OK");
     aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
     
     aqObject.CheckProperty(Get_WinQuickSearch_LblSearch().Text, "OleValue", cmpEqual, "Search for:");
     aqObject.CheckProperty(Get_WinQuickSearch_LblIn().Text, "OleValue", cmpEqual, "In:");
}

function Check_Existence_Of_Controls()
{
     aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoDescription(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSecurity(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSymbol(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoName(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoType(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoAccountNo(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoIACode(), "IsEnabled", cmpEqual, true);
}
