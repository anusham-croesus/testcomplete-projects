//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions


/* Description :Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur PortfolioBar-btnWhatIf et par la suite, 
Cliquer sur TotalValue du menu contextuel .Vérifier vérifier la présence des contrôles. */

/*    Date: 31-12-2020
      Analyste Auto: Abdel.M
      Objectif: Combiner les différentes façons pour WhatIf Total value
*/
 
 function Survol_Por_WhatIf_TotalValue_CombinedAccess()
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
          
 //----------- Étape 2 : WhatIf Total Value par menu contextuel ---------------------------------------
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: WhatIf Total Value par menu contextuel");
  
          Get_PortfolioBar_BtnWhatIf().Click();
  
          Get_PortfolioPlugin().ClickR();
          Get_PortfolioGrid_ContextualMenu_Functions().Click();
          Get_PortfolioGrid_ContextualMenu_Functions_TotalValue().Click();
     
          //Les points de vérification en français 
          if(language=="french"){ Check_Properties_French()} // la fonction est dans le script Survol_Por_PortfolioBar_btnWhatIf_btnTotalValue  
          //Les points de vérification en anglais 
          else {Check_Properties_English()} // la fonction est dans le script Survol_Por_PortfolioBar_btnWhatIf_btnTotalValue 
   
          Check_Existence_Of_Controls() // la fonction est dans le script Survol_Por_PortfolioBar_btnWhatIf_btnTotalValue 
  
          Get_WinTotalValue().Close();
          
 //----------- Étape 3 : WhatIf Total value par menuBar Edit ---------------------------------------
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: WhatIf Total value par menuBar Edit");
   
          Get_MenuBar_Edit().OpenMenu();
          Get_MenuBar_Edit_Functions().OpenMenu();
          Get_MenuBar_Edit_FunctionsForPortfolio_TotalValue().Click();
     
          //Les points de vérification en français 
          if(language=="french"){ Check_Properties_French()} // la fonction est dans le script Survol_Por_PortfolioBar_btnWhatIf_btnTotalValue  
          //Les points de vérification en anglais 
          else {Check_Properties_English()} // la fonction est dans le script Survol_Por_PortfolioBar_btnWhatIf_btnTotalValue 
   
          Check_Existence_Of_Controls(); // la fonction est dans le script Survol_Por_PortfolioBar_btnWhatIf_btnTotalValue 
  
          Get_WinTotalValue().Close();
          
  //----------- Étape 4 : WhatIf Total value par  bouton Total value   ---------------------------------------
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: WhatIf Total value par  bouton Total value");
          
          Get_PortfolioBar_BtnTotalValue().Click();
     
          //Les points de vérification en français 
          if(language=="french"){ Check_Properties_French()}    
          //Les points de vérification en anglais 
          else {Check_Properties_English()}
   
          Check_Existence_Of_Controls();
  
          Get_WinTotalValue_BtnCancel().Click();
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

