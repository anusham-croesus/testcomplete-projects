//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions


/* Description :Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur PortfolioBar-btnWhatIf et par la suite, 
Cliquer sur Add du menu contextuel .Vérifier vérifier la présence des contrôles. */


/*    Date: 30-12-2020
      Analyste Auto: Abdel.M
      Objectif: Combiner les différentes façons pour afficher la fenêtre « Add WhatIf »
*/
 
 function Survol_Por_WhatIf_Add_CombinedAccess()
 {
   try {
          // Les variables utilisées dans les points de vérifications 
          var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "client800300", language+client);
          
 //---------- Étape 1 : Se connecter à croesus avec COPERN -------------------------------
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
          Login(vServerPortefeuille, userName, psw, language);
          Get_ModulesBar_BtnClients().Click();
          Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
          if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client(clientNumber)}
          else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}

          //maillage vers le module portefeuille 
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
          
 //----------- Étape 2 : Add WhatIf par menu contextuel ---------------------------------------
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Add WhatIf par menu contextuel");
  
          //Cliquer sur PortfolioBar-btnWhatIf et par la suite, 
          Get_PortfolioBar_BtnWhatIf().Click();
  
          //Cliquer sur Add du menu contextuel
          var numTry = 0; //Christophe : Stabilisation
          do {
            Delay(3000);
            Get_PortfolioPlugin().ClickR();
          } while ((++numTry) <= 3 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1500, 3500))
          
          Get_PortfolioGrid_ContextualMenu_Add().Click();
     
          //Les points de vérification en français 
          if(language=="french"){ Check_Properties_French()}  
          //Les points de vérification en anglais 
          else {Check_Properties_English()} 
   
          Check_Existence_Of_Controls();
  
          Get_WinAddPosition().Close();
          
 //----------- Étape 3 : Add WhatIf par menuBar Edit ---------------------------------------
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Add WhatIf par menuBar Edit");
  
//          Get_PortfolioBar_BtnWhatIf().Click()
  
          Get_MenuBar_Edit().OpenMenu()
          Get_MenuBar_Edit_Add().Click()
     
          //Les points de vérification en français 
          if(language=="french"){ Check_Properties_French()} // la fonction est dans le script Survol_Por_WhatIf_ContextualMenu_Add 
          //Les points de vérification en anglais 
          else {Check_Properties_English()} // la fonction est dans le script Survol_Por_WhatIf_ContextualMenu_Add 
   
          Check_Existence_Of_Controls() // la fonction est dans le script Survol_Por_WhatIf_ContextualMenu_Add 
  
          Get_WinAddPosition_BtnCancel().Click();
          
  //----------- Étape 4 : Add WhatIf par Toolbar boutob Add   ---------------------------------------
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Add WhatIf par Toolbar boutob Add");
          
//          Get_PortfolioBar_BtnWhatIf().Click()
  
          Get_Toolbar_BtnAdd().Click()
     
          //Les points de vérification en français 
          if(language=="french"){ Check_Properties_French()} // la fonction est dans le script Survol_Por_WhatIf_ContextualMenu_Add 
          //Les points de vérification en anglais 
          else {Check_Properties_English()} // la fonction est dans le script Survol_Por_WhatIf_ContextualMenu_Add 
   
          Check_Existence_Of_Controls() // la fonction est dans le script Survol_Por_WhatIf_ContextualMenu_Add 
  
          Get_WinAddPosition_BtnCancel().Click();
  
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

