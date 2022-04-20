//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

 /* Description : A partir du module "Models",rechercher le Modèle ~M-0000S-0,  afficher la fenêtre « Perfomance des comptes sous- jacents » 
 par ContextualMenu_Functions_UnderPerfomance. Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre en cliquant sur le btn Fermer*/

 function Survol_Mod_ContextualMenu_Functions_UnderPerfomance()
 {
  if (client == "BNC" ){
    var model="~M-0000S-0"
  }
  else if(client == "US" ){
    var model="~M-00006-0"
  } 
  else if(client == "CIBC" ){  //Adapté pour CIBC
    var model="~M-00005-0"  
  } 
  else{//RJ
    var model="~M-00002-0"
  }
  
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Model(model)}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  Get_MainWindow().Keys("[Apps]")
  Get_ModelsGrid_ContextualMenu_Functions().Click()
  Get_ModelsGrid_ContextualMenu_Functions_UnderlyingPerformance().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French(model)}
  //Les points de vérification en anglais 
  else {Check_Properties_English(model)}
  
  Check_Existence_Of_Controls()
  
  Get_WinPerformance_BtnClose().Click()
  
  Close_Croesus_X()
 }
 
 //Fonctions  (les points de vérification pour les scripts qui testent Under.Perfomance)
function Check_Properties_French(model)
{
   aqObject.CheckProperty(Get_WinPerformance().Title, "OleValue", cmpEqual, "Performance des comptes sous-jacents au modèle: "+model);
   aqObject.CheckProperty(Get_WinPerformance_BtnClose().Content, "OleValue", cmpEqual, "_Fermer");
   //Period
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances().Header, "OleValue", cmpEqual, "Performance"); //EM : 90.12.7 HF : "Performance" au lieu de "Performances" provient du CR2176 DEVPRJ-3220  
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod().Header, "OleValue", cmpEqual, "Période");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(), "wItemList", cmpEqual, "Cumulative|Fixe");
   //Accounts converted to
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo().Header, "OleValue", cmpEqual, "Comptes convertis en");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_LblDefaultCurrency().Content, "OleValue", cmpEqual, "Défaut : CAD");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "wItemList", cmpEqual, "CAD|EUR|NOK|SEK|USD");
   
   if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
     //Method
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod().Header, "OleValue", cmpEqual, "Méthode");
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(), "wItemList", cmpEqual, "Rendement pondéré dans le temps|Rendement pondéré en dollars");
   }
   
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblFrom().Content, "OleValue", cmpEqual, "Du:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblTo().Content, "OleValue", cmpEqual, "Au:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod1().Text, "OleValue", cmpEqual, "3 Mois");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod2().Text, "OleValue", cmpEqual, "6 Mois");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod3().Text, "OleValue", cmpEqual, "1 An");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod4().Text, "OleValue", cmpEqual, "Depuis le début");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriodOther().Text, "OleValue", cmpEqual, "Autre");
   //Net of fees return
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNet().Content, "OleValue", cmpEqual, "Net:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetROIPercent().Content, "OleValue", cmpEqual, "RCI (%)");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetStandardDeviationPercent().Content, "OleValue", cmpEqual, "Écart type (%)");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetSharpeIndex().Content, "OleValue", cmpEqual, "Indice de Sharpe")
   
      //Missing in Automation 9 
//   //Gross of Fees Return
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGross().Content, "OleValue", cmpEqual, "Brut:");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossROIPercent().Content, "OleValue", cmpEqual, "RCI (%)");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossStandardDeviationPercent().Content, "OleValue", cmpEqual, "Écart type (%)");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossSharpeIndex().Content, "OleValue", cmpEqual, "Indice de Sharpe");
//   
   //tab Perfomance Graph
   Get_WinPerformance_TabPerformanceGraph().Click()
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph().Header, "OleValue", cmpEqual, "Graphique de performance");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph_LblGraphTitle().Text, "OleValue", cmpEqual, "RCI (%) (Net)");
   Get_WinPerformance_TabPerformanceHistory().Click()
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_LblCurrencyMessage().Content, "OleValue", cmpEqual, "Les montants sont affichés dans la devise du compte (CAD)");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChDate().Content, "OleValue", cmpEqual, "Date");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChTotalValue().Content, "OleValue", cmpEqual, "Valeur totale");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChCashFlow().Content, "OleValue", cmpEqual, "Mouv. encaisse");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChNetROIPercent().Content, "OleValue", cmpEqual, "RCI net (%)");
   
    //Missing in Automation 9 
//   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChGrossROIPercent().Content, "OleValue", cmpEqual, "RCI brut (%)");
//   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChFees().Content, "OleValue", cmpEqual, "Frais");
   
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_BtnCashFlow().Content, "OleValue", cmpEqual, "_Mouvements d'encaisse");
}

function Check_Properties_English(model)
{
   aqObject.CheckProperty(Get_WinPerformance().Title, "OleValue", cmpEqual, "Model's Underlying Accounts Performance: "+model);
   aqObject.CheckProperty(Get_WinPerformance_BtnClose().Content, "OleValue", cmpEqual, "_Close");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances().Header, "OleValue", cmpEqual, "Performance");//EM : 90.12.7 HF : "Performance" au lieu de "Performances" provient du CR2176 DEVPRJ-3220  
   //Period
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod().Header, "OleValue", cmpEqual, "Period");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(), "wItemList", cmpEqual, "Cumulative|Fixed");
   //Accounts converted to
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo().Header, "OleValue", cmpEqual, "Accounts converted to");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_LblDefaultCurrency().Content, "OleValue", cmpEqual, "Default : CAD");
   
   if (client == "CIBC")   // Adapté pour CIBC
          aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "wItemList", cmpEqual, "CAD|CHF|EUR|GBP|HKD|JPY|MEX|NOK|SEK|SGD|USD");
   else  
          aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "wItemList", cmpEqual, "CAD|EUR|NOK|SEK|USD");
          
   if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
      //Method
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod().Header, "OleValue", cmpEqual, "Method");
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(), "wItemList", cmpEqual, "Time-Weighted Return|Money-Weighted Return");
   }
   
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblFrom().Content, "OleValue", cmpEqual, "From:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblTo().Content, "OleValue", cmpEqual, "To:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod1().Text, "OleValue", cmpEqual, "3 Months");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod2().Text, "OleValue", cmpEqual, "6 Months");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod3().Text, "OleValue", cmpEqual, "1 Year");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriod4().Text, "OleValue", cmpEqual, "Since Inception");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblPeriodOther().Text, "OleValue", cmpEqual, "Other");
   //Net of fees return
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNet().Content, "OleValue", cmpEqual, "Net of Fees Return:");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetROIPercent().Content, "OleValue", cmpEqual, "ROI (%)");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetStandardDeviationPercent().Content, "OleValue", cmpEqual, "Standard Deviation (%)");
   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblNetSharpeIndex().Content, "OleValue", cmpEqual, "Sharpe Index")
   
//    //Missing in Automation 9   
//   //Gross of Fees Return
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGross().Content, "OleValue", cmpEqual, "Gross of Fees Return:");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossROIPercent().Content, "OleValue", cmpEqual, "ROI (%)");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossStandardDeviationPercent().Content, "OleValue", cmpEqual, "Standard Deviation (%)");
//   aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_LblGrossSharpeIndex().Content, "OleValue", cmpEqual, "Sharpe Index");
   
   //tab Perfomance Graph
   Get_WinPerformance_TabPerformanceGraph().Click()
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph().Header, "OleValue", cmpEqual, "Performance Graph");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceGraph_LblGraphTitle().Text, "OleValue", cmpEqual, "ROI (%) (Net of Fees)");
   
   Get_WinPerformance_TabPerformanceHistory().Click()
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory(), "IsSelected", cmpEqual, true);
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_LblCurrencyMessage().Content, "OleValue", cmpEqual, "Amounts are displayed in the account currency (CAD)");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChDate().Content, "OleValue", cmpEqual, "Date");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChTotalValue().Content, "OleValue", cmpEqual, "Total Value");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChCashFlow().Content, "OleValue", cmpEqual, "Cash Flow");
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChNetROIPercent().Content, "OleValue", cmpEqual, "Net ROI (%)");
   
   //Missing in Automation 9 
//   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChGrossROIPercent().Content, "OleValue", cmpEqual, "Gross ROI (%)");
//   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_ChFees().Content, "OleValue", cmpEqual, "Fees");
   
   aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_BtnCashFlow().Content, "OleValue", cmpEqual, "Cash _Flow");
}

function Check_Existence_Of_Controls()
{
     aqObject.CheckProperty(Get_WinPerformance_BtnClose(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_BtnClose(), "IsEnabled", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "IsReadOnly", cmpEqual, false);
     
     if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
       aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(), "IsReadOnly", cmpEqual, false);
     }
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1From(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2From(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3From(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4From(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_DtpPeriodOtherFrom(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_DtpPeriodOtherFrom(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1To(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2To(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3To(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4To(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_DtpPeriodOtherTo(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_DtpPeriodOtherTo(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetROIPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetROIPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetROIPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetROIPercent(), "IsVisible", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetSharpeIndex(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetSharpeIndex(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetSharpeIndex(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetSharpeIndex(), "IsVisible", cmpEqual, true);

     
//    //Missing in Automation 9  
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1GrossROIPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2GrossROIPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3GrossROIPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4GrossROIPercent(), "IsVisible", cmpEqual, true);
     //aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriodOtherGrossROIPercent(), "IsVisible", cmpEqual, true);
     
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1GrossStandardDeviationPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2GrossStandardDeviationPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3GrossStandardDeviationPercent(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4GrossStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     //aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriodOtherGrossStandardDeviationPercent(), "IsVisible", cmpEqual, true);
     
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1GrossSharpeIndex(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2GrossSharpeIndex(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3GrossSharpeIndex(), "IsVisible", cmpEqual, true);
//     aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4GrossSharpeIndex(), "IsVisible", cmpEqual, true);
     //aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriodOtherGrossSharpeIndex(), "IsVisible", cmpEqual, true);
     
     Get_WinPerformance_TabPerformanceHistory().Click()
     aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_BtnCashFlow(), "IsVisible", cmpEqual, true); 
     aqObject.CheckProperty(Get_WinPerformance_TabPerformanceHistory_BtnCashFlow(), "IsEnabled", cmpEqual, true);     
}

