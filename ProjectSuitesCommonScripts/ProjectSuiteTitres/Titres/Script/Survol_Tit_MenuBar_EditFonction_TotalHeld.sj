//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions

/* Description : A partir du module « Titre » , afficher la fenêtre « Print » en cliquant sur MenuBar - Edit-Fonction-btnTotalHeld. 
  Vérifier la présence des contrôles et des étiquetés 
  // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1809*/
 
 function Survol_Tit_MenuBar_EditFonctions_TotalHeld()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
  
  Get_MenuBar_Edit().OpenMenu()
  Get_MenuBar_Edit_Functions().OpenMenu()
  Get_MenuBar_Edit_FunctionsForSecurities_TotalHeld().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()}
  //Les points de vérification en anglais 
  else{Check_Properties_English()}
  
  //Les points de vérification: la présence des contrôles
  Check_Existence_Of_Controls() 
   
  Get_WinTotalHeld_BtnClose().Click();
  
  Close_Croesus_MenuBar();    
 }

 //Fonctions  (les points de vérification pour les scripts qui testent Total_Held)
function Check_Properties_French()
{    
    aqObject.CheckProperty(Get_WinTotalHeld_CmbDisplayCurrency(), "wItemList", cmpEqual, "CAD|EUR|NOK|SEK|USD");  
    aqObject.CheckProperty(Get_WinTotalHeld_BtnClose().Content, "OleValue", cmpEqual, "_Fermer");
    aqObject.CheckProperty(Get_WinTotalHeld_BtnCalculate().Text, "OleValue", cmpEqual, "Calcul..."); 
    aqObject.CheckProperty(Get_WinTotalHeld_BtnCancel().Find("ClrClassName","TextBlock",10), "Text", cmpEqual, "Annuler...");
    //les étiquetés
    aqObject.CheckProperty(Get_WinTotalHeld_LblDisplayCurrency().Content, "OleValue", cmpEqual, "Devise d\'affichage:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblNumberOfAccounts().Content, "OleValue", cmpEqual, "Nombre de comptes:");
    Log.Message("CROES-4823, BNC-621")
    aqObject.CheckProperty(Get_WinTotalHeld_LblMarketValue().Content, "OleValue", cmpEqual, "Valeur de marché:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblBookValue().Content, "OleValue", cmpEqual, "Valeur comptable:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblBalance().Content, "OleValue", cmpEqual, "Solde:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Int./Div. courus:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblAnnualIncome().Content, "OleValue", cmpEqual, "Revenu annuel:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblTotalQuantity().Content, "OleValue", cmpEqual, "Quantité totale:");
    
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
    aqObject.CheckProperty(Get_WinTotalHeld_LblBeta().Content, "OleValue", cmpEqual, "Bêta:")
    };//N’existe pas dans l’automation 9 (BD FNB)
    
    aqObject.CheckProperty(Get_WinTotalHeld_LblSecurityCurrency().Content, "OleValue", cmpEqual, "Devise du titre:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblAverageCostYield().Content, "OleValue", cmpEqual, "Rend. éché. moyen - cout (%):"); //CROES-3960
    aqObject.CheckProperty(Get_WinTotalHeld_LblModDurationAvg().Content, "OleValue", cmpEqual, "Durée mod. (moy.):");
    aqObject.CheckProperty(Get_WinTotalHeld_LblAccumIntDiv().Content, "OleValue", cmpEqual, "Int./Div. cumulés:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblAccumulatedCommission().Content, "OleValue", cmpEqual, "Commissions cumulées:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblPercentOfTotalUnderManagement().Content, "OleValue", cmpEqual, "% Total sous gestion:");        
}

function Check_Properties_English()
{  
    if(client == "CIBC"){aqObject.CheckProperty(Get_WinTotalHeld_CmbDisplayCurrency(), "wItemList", cmpEqual, "CAD|CHF|EUR|GBP|HKD|JPY|MEX|NOK|SEK|SGD|USD");}
    else{
    aqObject.CheckProperty(Get_WinTotalHeld_CmbDisplayCurrency(), "wItemList", cmpEqual, "CAD|EUR|NOK|SEK|USD"); } 
    aqObject.CheckProperty(Get_WinTotalHeld_BtnClose().Content, "OleValue", cmpEqual, "_Close");
    aqObject.CheckProperty(Get_WinTotalHeld_BtnCalculate().Text, "OleValue", cmpEqual, "Calculate...");
    aqObject.CheckProperty(Get_WinTotalHeld_BtnCancel().Find("ClrClassName","TextBlock",10), "Text", cmpEqual, "Cancel...");
    
    //les étiquetés
    aqObject.CheckProperty(Get_WinTotalHeld_LblDisplayCurrency().Content, "OleValue", cmpEqual, "Display Currency:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblNumberOfAccounts().Content, "OleValue", cmpEqual, "Number of accounts:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblMarketValue().Content, "OleValue", cmpEqual, "Market Value:");
    if(client == "US" ){
    aqObject.CheckProperty(Get_WinTotalHeld_LblCostBasis().Content, "OleValue", cmpEqual, "Cost Basis:");
    } 
    else {
    aqObject.CheckProperty(Get_WinTotalHeld_LblBookValue().Content, "OleValue", cmpEqual, "Book Value:");}
    aqObject.CheckProperty(Get_WinTotalHeld_LblBalance().Content, "OleValue", cmpEqual, "Balance:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblAccruedIntDiv().Content, "OleValue", cmpEqual, "Accrued Int./Div.:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblAnnualIncome().Content, "OleValue", cmpEqual, "Annual Income:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblTotalQuantity().Content, "OleValue", cmpEqual, "Total Quantity:");
    if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
     aqObject.CheckProperty(Get_WinTotalHeld_LblBeta().Content, "OleValue", cmpEqual, "Beta:")
    };//N’existe pas dans l’automation 9 (BD FNB)
    aqObject.CheckProperty(Get_WinTotalHeld_LblSecurityCurrency().Content, "OleValue", cmpEqual, "Security Currency:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblAverageCostYield().Content, "OleValue", cmpEqual, "Average YTM Cost (%):");
    aqObject.CheckProperty(Get_WinTotalHeld_LblModDurationAvg().Content, "OleValue", cmpEqual, "Mod. Duration (Avg.):");
    aqObject.CheckProperty(Get_WinTotalHeld_LblAccumIntDiv().Content, "OleValue", cmpEqual, "Accum. Int./Div.:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblAccumulatedCommission().Content, "OleValue", cmpEqual, "Accumulated Commission:");
    aqObject.CheckProperty(Get_WinTotalHeld_LblPercentOfTotalUnderManagement().Content, "OleValue", cmpEqual, "% of Total under Management:");
}

function Check_Existence_Of_Controls()
{
  aqObject.CheckProperty(Get_WinTotalHeld_CmbDisplayCurrency(), "IsVisible", cmpEqual, true);  
  aqObject.CheckProperty(Get_WinTotalHeld_CmbDisplayCurrency(), "IsReadOnly", cmpEqual, false);  
  
  aqObject.CheckProperty(Get_WinTotalHeld_BtnCalculate(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTotalHeld_BtnCalculate(), "IsEnabled", cmpEqual, false); // BNC -14 le btn est actif, il faut valider 
  
  aqObject.CheckProperty(Get_WinTotalHeld_BtnClose(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTotalHeld_BtnClose(), "IsEnabled", cmpEqual, true);
  
  if(Get_WinTotalHeld_BtnCancel().VisibleOnScreen){
    Log.Error("Le btn Cancel est visible")
  }
  else{
    Log.Checkpoint("Le btn Cancel n'est pas visible")
  }
  
//  aqObject.CheckProperty(Get_WinTotalHeld_BtnCancel(), "IsVisible", cmpEqual, true);
//  aqObject.CheckProperty(Get_WinTotalHeld_BtnCancel(), "IsEnabled", cmpEqual, true);
}

