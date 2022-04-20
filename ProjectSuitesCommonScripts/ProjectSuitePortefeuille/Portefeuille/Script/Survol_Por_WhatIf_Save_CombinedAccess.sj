//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions


/* Description :Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur PortfolioBar-btnWhatIf et par la suite, 
Cliquer sur Save du menu contextuel .Vérifier vérifier la présence des contrôles.Fermer la fenêtre en cliquant sur le btn Cancel */


/*    Date: 31-12-2020
      Analyste Auto: Abdel.M
      Objectif: Combiner les différentes façons pour sauvegarder un WhatIf
*/
 
 function Survol_Por_WhatIf_Save_CombinedAccess()
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
          
 //----------- Étape 2 : WhatIf Save par menu contextuel ---------------------------------------
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: WhatIf Save par menu contextuel");
  
          Get_PortfolioBar_BtnWhatIf().Click();
  
          Get_PortfolioPlugin().ClickR();
          Get_PortfolioGrid_ContextualMenu_Functions().OpenMenu();
          Get_PortfolioGrid_ContextualMenu_Functions_Save().Click();
     
          //Les points de vérification en français 
          if(language=="french"){ Check_Properties_French()} // la fonction est dans le script   
          //Les points de vérification en anglais 
          else {Check_Properties_English()} // la fonction est dans le script 
   
          Check_Existence_Of_Controls(); // la fonction est dans le script  
  
          Get_WinWhatIfSave_BtnCancel().Click();
          
 //----------- Étape 3 : WhatIf Save par menuBar Edit ---------------------------------------
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: WhatIf save par menuBar Edit");
  
//          Get_PortfolioBar_BtnWhatIf().Click();
  
          Get_MenuBar_Edit().OpenMenu();
          Get_MenuBar_Edit_Functions().OpenMenu();
          Get_MenuBar_Edit_FunctionsForPortfolio_Save().Click();
     
          //Les points de vérification en français 
          if(language=="french"){ Check_Properties_French()} // la fonction est dans le script  Survol_Por_WhatIf_ContextualMenu_Save 
          //Les points de vérification en anglais 
          else {Check_Properties_English()} // la fonction est dans le script Survol_Por_WhatIf_ContextualMenu_Save
   
          Check_Existence_Of_Controls(); // la fonction est dans le script Survol_Por_WhatIf_ContextualMenu_Save 
  
          Get_WinWhatIfSave().Close();
          
  //----------- Étape 4 : WhatIf save par  bouton save   ---------------------------------------
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: WhatIf save par  bouton save");
          
//          Get_PortfolioBar_BtnWhatIf().Click();
  
          Get_PortfolioBar_BtnSave().Click();
     
          //Les points de vérification en français 
          if(language=="french"){ Check_Properties_French()} // la fonction est dans le script  Survol_Por_WhatIf_ContextualMenu_Save 
          //Les points de vérification en anglais 
          else {Check_Properties_English()} // la fonction est dans le script Survol_Por_WhatIf_ContextualMenu_Save
   
          Check_Existence_Of_Controls(); // la fonction est dans le script Survol_Por_WhatIf_ContextualMenu_Save 
  
          Get_WinWhatIfSave_BtnCancel().Keys("[Esc]");
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
 
 //Fonctions  (les points de vérification pour les scripts qui testent WhatIf_Save position)
function Check_Properties_English()
{
  aqObject.CheckProperty(Get_WinWhatIfSave().Title, "OleValue", cmpEqual, "What-If Save");
  
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation().Header, "OleValue", cmpEqual, "Account Information");
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().Content, "OleValue", cmpEqual, "New Fictitious Account");
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel().Content, "OleValue", cmpEqual, "New Model");
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_LblShortName().Text, "OleValue", cmpEqual, "Short Name:");
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_LblIACode().Text, "OleValue", cmpEqual, "IA Code:");
  
  aqObject.CheckProperty(Get_WinWhatIfSave_BtnDetailedSave().Content, "OleValue",cmpEqual, "Detailed Save");
  aqObject.CheckProperty(Get_WinWhatIfSave_BtnOK().Content, "OleValue",cmpEqual, "OK");
  aqObject.CheckProperty(Get_WinWhatIfSave_BtnCancel().Content, "OleValue",cmpEqual, "Cancel");
}

function Check_Properties_French()
{
  aqObject.CheckProperty(Get_WinWhatIfSave().Title, "OleValue", cmpEqual, "Sauvegarder la simulation");
  
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation().Header, "OleValue", cmpEqual, "Information sur le compte");
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount().Content, "OleValue", cmpEqual, "Nouveau compte fictif");
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel().Content, "OleValue", cmpEqual, "Nouveau modèle");
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_LblShortName().Text, "OleValue", cmpEqual, "Nom abrégé:");
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_LblIACode().Text, "OleValue", cmpEqual, "Code de CP:");
  
  aqObject.CheckProperty(Get_WinWhatIfSave_BtnDetailedSave().Content, "OleValue", cmpEqual,"Sauvegarde détaillée");
  aqObject.CheckProperty(Get_WinWhatIfSave_BtnOK().Content, "OleValue",cmpEqual,"OK");
  aqObject.CheckProperty(Get_WinWhatIfSave_BtnCancel().Content, "OleValue", cmpEqual,"Annuler");
 
}

function Check_Existence_Of_Controls()
{

  aqObject.CheckProperty(Get_WinWhatIfSave_BtnDetailedSave(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinWhatIfSave_BtnDetailedSave(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinWhatIfSave_BtnOK(), "IsVisible",cmpEqual, true);
  aqObject.CheckProperty(Get_WinWhatIfSave_BtnOK(), "IsEnabled",cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinWhatIfSave_BtnCancel(), "IsVisible",cmpEqual, true);
  aqObject.CheckProperty(Get_WinWhatIfSave_BtnCancel(), "IsEnabled",cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_RdoNewFictitiousAccount(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_CmbIACode(), "IsVisible",cmpEqual, true);
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_CmbIACode(), "IsEnabled",cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_TxtShortName(), "IsVisible",cmpEqual, true);
  aqObject.CheckProperty(Get_WinWhatIfSave_GrpAccountInformation_TxtShortName(), "IsReadOnly",cmpEqual, false);
  
}