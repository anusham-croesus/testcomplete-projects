//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Titre » , afficher la fenêtre « Taux de change » avec ClickR- fonctions-ExchangeRate. 
  Vérifier la présence des contrôles et des étiquetés 
  // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1779*/
 
 /*Description    : Combiner les trois façons pour le taux de change
   Date           : 22-01-2021
   version        : 90.24-21
   Analyste Auto  :Abdel.M      
 */
 
 function Survol_Tit_ExchangeRate_CombinedAccess()
 {
   try {
 // ********** Étape 1 : Se connecter à croesus avec COPERN ************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
        Login(vServerTitre, userName , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
    
// ********** Étape 2 : Afficher la fenêtre « Taux de change » avec ClickR *******************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Afficher la fenêtre « Taux de change » avec ClickR ");
        
        Get_SecurityGrid().ClickR()
        Get_SecurityGrid_ContextualMenu_Functions().OpenMenu()
        Get_SecurityGrid_ContextualMenu_Functions_ExchangeRate().Click()
  
        //Les points de vérification en français 
        if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Tit_SecuritiesBar_BtnExchangeRate
        //Les points de vérification en anglais 
        else {Check_Properties_English()} // la fonction est dans le script Survol_Tit_SecuritiesBar_BtnExchangeRate
  
        Get_WinExchangeRate_BtnClose().Click();
        

// ********** Étape 3 : Afficher la fenêtre « Taux de change » en cliquant sur MenuBar - Edit-Fonction  *******************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Afficher la fenêtre « Taux de change » en cliquant sur MenuBar - Edit-Fonction");
        
        Get_MenuBar_Edit().OpenMenu()
        Get_MenuBar_Edit_Functions().OpenMenu()
        Get_MenuBar_Edit_FunctionsForSecurities_ExchangeRate().Click()
  
        //Les points de vérification en français 
        if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Tit_SecuritiesBar_BtnExchangeRate
        //Les points de vérification en anglais 
        else {Check_Properties_English()} // la fonction est dans le script Survol_Tit_SecuritiesBar_BtnExchangeRate
  
        Get_WinExchangeRate_BtnClose().Click();
        
// ********** Étape 4 : Afficher la fenêtre « Taux de change » en cliquant sur SecuritiesBar - btnExchangeRate *******************
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Afficher la fenêtre « Taux de change » en cliquant sur SecuritiesBar - btnExchangeRate");
        
        Get_SecuritiesBar_BtnExchangeRate().Click()
  
        //Les points de vérification en français 
        if(language=="french"){Check_Properties_French()}
        //Les points de vérification en anglais 
        else {Check_Properties_English()}
    
        Get_WinExchangeRate_BtnClose().Click();
        
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

//Fonctions  (les points de vérification pour les scripts qui testent «Taux de change»)
function Check_Properties_French()
{
    //***********************************L’ONGLET TABLE D’ÉQUIVALENCE********************** 
    //Le titre de la fenêtre 
    aqObject.CheckProperty(Aliases.CroesusApp.winExchangeRate.Title, "OleValue", cmpEqual, "Taux de change");    
    //les btns
    aqObject.CheckProperty(Get_WinExchangeRate_BtnClose().Content, "OleValue", cmpEqual, "_Fermer");
    aqObject.CheckProperty(Get_WinExchangeRate_BtnClose(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinExchangeRate_BtnSetup().Content, "OleValue", cmpEqual, "_Configurer...");    
    aqObject.CheckProperty(Get_WinExchangeRate_BtnSetup(), "IsEnabled", cmpEqual, true); 
    //l'onglet 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable().Header, "OleValue", cmpEqual, "Table d\'équivalence"); 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable(), "IsSelected", cmpEqual, true);  
    //les étiquetés
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_LblCurrency().Text, "OleValue", cmpEqual, "Devise:");
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_LblDate().Text, "OleValue", cmpEqual, "Date:");   
    //Les entêtes des colonnes 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_ChColumn1().Content, "OleValue", cmpEqual, "");
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_ChColumn2().Content, "OleValue", cmpEqual, "1 CAD");
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_ChColumn3().Content, "OleValue", cmpEqual, "en CAD");       
    //Le textbox 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_txtDate(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_txtDate(), "IsEnabled", cmpEqual, true);
    //le cmb
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_CmbCurrency(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_CmbCurrency(), "IsEnabled", cmpEqual, true); 
      
    //*********************************L’ONGLET COURS CROISES ***************************** 
    Get_WinExchangeRate_TabCrossRates().Click()
    //l'onglet 
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates().Header, "OleValue", cmpEqual, "Cours croisés");
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates(), "IsSelected", cmpEqual, true);
    //les étiquetés
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_LblDate().Text, "OleValue", cmpEqual, "Date:");
    //Les entêtes des colonnes 
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn1().Content, "OleValue", cmpEqual, "De/Vers");
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn2().Content, "OleValue", cmpEqual, "CAD");
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn3().Content, "OleValue", cmpEqual, "EUR");
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn4().Content, "OleValue", cmpEqual, "NOK");
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn5().Content, "OleValue", cmpEqual, "SEK");
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn6().Content, "OleValue", cmpEqual, "USD");
    // aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn7().Content, "OleValue", cmpEqual, "ZZZ"); //n’existe pas dans automation 9 
    //Le textbox 
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_txtDate(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_txtDate(), "IsEnabled", cmpEqual, true);
      
    //***********************************L’ONGLET HISTORIQUE ******************************  
    Get_WinExchangeRate_TabHistory().Click()
    //l'onglet 
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory().Header, "OleValue", cmpEqual, "Historique");
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory(), "IsSelected", cmpEqual, true);
    //les étiquetés
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_LblCurrency().Text, "OleValue", cmpEqual, "Devise:");
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_LblFrom().Text, "OleValue", cmpEqual, "De:");
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_LblTo().Text, "OleValue", cmpEqual, "À:");
    //Les entêtes des colonnes 
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn1().Content, "OleValue", cmpEqual, "De: CAD vers");
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn2().Content, "OleValue", cmpEqual, "EUR");
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn3().Content, "OleValue", cmpEqual, "NOK");
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn4().Content, "OleValue", cmpEqual, "SEK");
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn5().Content, "OleValue", cmpEqual, "USD");
    //aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn6().Content, "OleValue", cmpEqual, "ZZZ");  //n’existe pas dans automation 9 
    
    //Les textbox 
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_txtFrom(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_txtFrom(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_txtTo(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_txtTo(), "IsEnabled", cmpEqual, true); 
    
    //le cmb
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_CmbCurrency(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_CmbCurrency(), "IsEnabled", cmpEqual, true);    

}

function Check_Properties_English()
{
//***********************************L’ONGLET TABLE D’ÉQUIVALENCE********************** 
    //Le titre de la fenêtre 
    aqObject.CheckProperty(Aliases.CroesusApp.winExchangeRate.Title, "OleValue", cmpEqual, "Exchange Rate");    
    //les btns
    aqObject.CheckProperty(Get_WinExchangeRate_BtnClose().Content, "OleValue", cmpEqual, "_Close");
    aqObject.CheckProperty(Get_WinExchangeRate_BtnClose(), "IsEnabled", cmpEqual, true);
     
    aqObject.CheckProperty(Get_WinExchangeRate_BtnSetup().Content, "OleValue", cmpEqual, "Set_up...");  
    aqObject.CheckProperty(Get_WinExchangeRate_BtnSetup(), "IsEnabled", cmpEqual, true);   
    //l'onglet 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable().Header, "OleValue", cmpEqual, "Equivalence Table"); 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable(), "IsSelected", cmpEqual, true);  
    //les étiquetés
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_LblCurrency().Text, "OleValue", cmpEqual, "Currency:");
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_LblDate().Text, "OleValue", cmpEqual, "Date:");   
    //Les entêtes des colonnes 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_ChColumn1().Content, "OleValue", cmpEqual, "");
    if(client == "US" ){
      aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_ChColumn2().Content, "OleValue", cmpEqual, "1 USD");
     aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_ChColumn3().Content, "OleValue", cmpEqual, "in USD");} 
    else{
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_ChColumn2().Content, "OleValue", cmpEqual, "1 CAD");
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_ChColumn3().Content, "OleValue", cmpEqual, "in CAD");}    
    //Le textbox 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_txtDate(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_txtDate(), "IsEnabled", cmpEqual, true);
    //le cmb
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_CmbCurrency(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinExchangeRate_TabEquivalenceTable_CmbCurrency(), "IsEnabled", cmpEqual, true);  
  
      
    //*********************************L’ONGLET COURS CROISES ***************************** 
    Get_WinExchangeRate_TabCrossRates().Click()
    //l'onglet 
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates().Header, "OleValue", cmpEqual, "Cross Rates");
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates(), "IsSelected", cmpEqual, true);
    //les étiquetés
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_LblDate().Text, "OleValue", cmpEqual, "Date:");
    //Les entêtes des colonnes 
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn1().Content, "OleValue", cmpEqual, "From/To");
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn2().Content, "OleValue", cmpEqual, "CAD");
    
    if(client == "CIBC"){
          //Get_WinExchangeRate().Parent.Maximize();
          aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn3().Content, "OleValue", cmpEqual, "CHF");
          aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn4().Content, "OleValue", cmpEqual, "EUR");
          aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn5().Content, "OleValue", cmpEqual, "GBP");
          aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn6().Content, "OleValue", cmpEqual, "HKD");
          aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn7().Content, "OleValue", cmpEqual, "JPY");
          aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnMEX().Content, "OleValue", cmpEqual, "MEX");
          ScrollToTheRight(2);
          aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnNOK().Content, "OleValue", cmpEqual, "NOK");
          aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnSEK().Content, "OleValue", cmpEqual, "SEK");
          aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnSGD().Content, "OleValue", cmpEqual, "SGD");
          aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnUSD().Content, "OleValue", cmpEqual, "USD");
          aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnZZZ().Content, "OleValue", cmpEqual, "ZZZ");
    } 
    else{
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn3().Content, "OleValue", cmpEqual, "EUR");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn4().Content, "OleValue", cmpEqual, "NOK");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn5().Content, "OleValue", cmpEqual, "SEK");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn6().Content, "OleValue", cmpEqual, "USD");}
    if(client == "US" ){
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn7().Content, "OleValue", cmpEqual, "ZZZ");
    } 
    //aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn7().Content, "OleValue", cmpEqual, "ZZZ"); //n’existe pas dans automation 9 
    //Le textbox 
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_txtDate(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_txtDate(), "IsEnabled", cmpEqual, true); 
  
      
    //***********************************L’ONGLET HISTORIQUE ******************************  
    Get_WinExchangeRate_TabHistory().Click()
    //l'onglet 
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory().Header, "OleValue", cmpEqual, "History");
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory(), "IsSelected", cmpEqual, true);
    //les étiquetés
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_LblCurrency().Text, "OleValue", cmpEqual, "Currency:");
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_LblFrom().Text, "OleValue", cmpEqual, "From:");
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_LblTo().Text, "OleValue", cmpEqual, "To:");
    //Les entêtes des colonnes 
    if(client == "US" ){
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn1().Content, "OleValue", cmpEqual, "From: USD to");
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn2().Content, "OleValue", cmpEqual, "CAD");
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn3().Content, "OleValue", cmpEqual, "EUR");
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn4().Content, "OleValue", cmpEqual, "NOK");
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn5().Content, "OleValue", cmpEqual, "SEK");
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn6().Content, "OleValue", cmpEqual, "ZZZ");
    } 
    else if(client == "CIBC"){
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn2().Content, "OleValue", cmpEqual, "CHF");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn3().Content, "OleValue", cmpEqual, "EUR");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn4().Content, "OleValue", cmpEqual, "GBP");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn5().Content, "OleValue", cmpEqual, "HKD");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumn6().Content, "OleValue", cmpEqual, "JPY");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnMEX().Content, "OleValue", cmpEqual, "MEX");
        ScrollToTheRight(3);
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnNOK().Content, "OleValue", cmpEqual, "NOK");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnSEK().Content, "OleValue", cmpEqual, "SEK");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnSGD().Content, "OleValue", cmpEqual, "SGD");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnUSD().Content, "OleValue", cmpEqual, "USD");
        aqObject.CheckProperty(Get_WinExchangeRate_TabCrossRates_ChColumnZZZ().Content, "OleValue", cmpEqual, "ZZZ");
    
    } 
    else{
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn1().Content, "OleValue", cmpEqual, "From: CAD to");
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn2().Content, "OleValue", cmpEqual, "EUR");
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn3().Content, "OleValue", cmpEqual, "NOK");
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn4().Content, "OleValue", cmpEqual, "SEK");
        aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn5().Content, "OleValue", cmpEqual, "USD");
    }
    //aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_ChColumn6().Content, "OleValue", cmpEqual, "ZZZ"); //n’existe pas dans automation 9 
     
    //Les textbox 
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_txtFrom(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_txtFrom(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_txtTo(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_txtTo(), "IsEnabled", cmpEqual, true); 
    
    //le cmb
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_CmbCurrency(), "IsVisible", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinExchangeRate_TabHistory_CmbCurrency(), "IsEnabled", cmpEqual, true);  
}

function ScrollToTheRight(tab){
  
      var grid = "_crossRatesGrid";
      if (tab == 3) grid = "_historyRatesGrid";
      
      Get_WinExchangeRate().WPFObject("TabControl", "", 1).WPFObject(grid).Keys("[Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right]");  
      Get_WinExchangeRate().WPFObject("TabControl", "", 1).WPFObject(grid).Keys("[Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right][Right]");
}
//Aliases.CroesusApp.winExchangeRate.WPFObject("TabControl", "", 1).WPFObject("_historyRatesGrid").WPFObject("RecordListControl", "", 1).WPFObject("GridViewPanelAdorner", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("HeaderPresenter", "", 1).WPFObject("HeaderLabelArea", "", 1).WPFObject("VirtualizingDataRecordCellPanel", "", 1).WPFObject("LabelPresenter", "EUR", 3)
function Get_WinExchangeRate_TabCrossRates_ChColumnMEX(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "MEX"], 10)}//ok
function Get_WinExchangeRate_TabCrossRates_ChColumnNOK(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "NOK"], 10)}//ok
function Get_WinExchangeRate_TabCrossRates_ChColumnSEK(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "SEK"], 10)}//ok
function Get_WinExchangeRate_TabCrossRates_ChColumnSGD(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "SGD"], 10)}//ok
function Get_WinExchangeRate_TabCrossRates_ChColumnUSD(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "USD"], 10)}//ok
function Get_WinExchangeRate_TabCrossRates_ChColumnZZZ(){return Get_WinExchangeRate().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "ZZZ"], 10)}//ok

