//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT DBA
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Titre » ,chercher le titre R13021 (Obligation), afficher la fenêtre « Info » en cliquant sur MenuBar - fonctions-Info. 
 Vérifier la présence des contrôles et des étiquetés 
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1794*/
 
function Survol_Tit_Bond_MenuBar_EditFunctions_Info()
{
    
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_INTEGRATIONS_TAB", "YES", vServerTitre);    
    RestartServices(vServerTitre);
    
    
    var type = "bond";
    
    Login(vServerTitre, userName, psw, language);
    Get_ModulesBar_BtnSecurities().Click();
    
    Search_Security("R13021");
    
    Get_MenuBar_Edit().OpenMenu();
    Get_MenuBar_Edit_Functions().OpenMenu();
    Get_MenuBar_Edit_FunctionsForSecurities_Info().Click();
    
    //Les points de vérification en français 
    if (language == "french"){Check_Properties_French(type)} //Se trouve dans la partie FUNCTIONS 
    //Les points de vérification en anglais 
    else {Check_Properties_English(type)} //Se trouve dans la partie FUNCTIONS    
    
    Check_Existence_Of_Controls_Description(type);//Se trouve dans la partie FUNCTIONS 
      
    Get_WinInfoSecurity_BtnCancel().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
    
    
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_INTEGRATIONS_TAB", null, vServerTitre);
    RestartServices(vServerTitre);
    
}


//FUNCTIONS
function Check_Existence_Of_Controls_Description(type) //Les points des vérification pour la partie Description 
{
    //*********************************DESCRIPTION *****************************
    //les combobox et les textbox 
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbSubCategory(), "IsVisible", cmpEqual, true); 
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbSubCategory(), "IsReadOnly", cmpEqual, true); 
       if (client == "US"){
         aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription(), "IsVisible", cmpEqual, false); 
         aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription(), "IsReadOnly", cmpEqual, false);
       }
       else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription(), "IsVisible", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription(), "IsReadOnly", cmpEqual, true);  
       } 
      
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription(), "IsVisible", cmpEqual, true);
      if (client == "US"){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription(), "IsReadOnly", cmpEqual, false);
      } 
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription(), "IsReadOnly", cmpEqual, true);
      } 
      
      
      if (type == "commonStock"|| type == "futures"|| type == "InvestmentFunds" || type == "other")
      {aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbIndustryCode(), "IsVisible", cmpEqual, true)
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbIndustryCode(), "IsReadOnly", cmpEqual, true)};
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCountry(), "IsVisible", cmpEqual, true);
      if (client == "US"){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCountry(), "IsReadOnly", cmpEqual, false);
      } 
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCountry(), "IsReadOnly", cmpEqual, true);
      } 
      
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCurrency(), "IsVisible", cmpEqual, true);
      if (client == "US"){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCurrency(), "IsReadOnly", cmpEqual, false);
      } 
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCurrency(), "IsReadOnly", cmpEqual, true); 
      } 
      
       
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCalculationFactor(), "IsVisible", cmpEqual, true);
      if (client == "US"){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCalculationFactor(), "IsReadOnly", cmpEqual, false);
      } 
      else { 
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbCalculationFactor(), "IsReadOnly", cmpEqual, true);}
     
        
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtUpdatedOn(), "IsVisible", cmpEqual, true); 
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtUpdatedOn(), "IsReadOnly", cmpEqual, true); 
      
      if (type=="options"){
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbOptionType(), "IsVisible", cmpEqual, true)
      if (client == "US"){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbOptionType(), "IsReadOnly", cmpEqual, false)
      } 
      else {
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_CmbOptionType(), "IsReadOnly", cmpEqual, true)}}; 
      
      if (type=="commonStock"|| type=="futures"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtConversionDate(), "IsVisible", cmpEqual, true)
      if (client == "US")
      {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtConversionDate(), "IsReadOnly", cmpEqual, false)
      } 
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtConversionDate(), "IsReadOnly", cmpEqual, true)
      }}; 
      
      if (type=="futures"|| type=="bond"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtIssueDate(), "IsVisible", cmpEqual, true);
      if (client == "US"){
         aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtIssueDate(), "IsReadOnly", cmpEqual, false)
      } 
      else {
         aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtIssueDate(), "IsReadOnly", cmpEqual, true)
      } 
      
     }
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtCreationDate(), "IsVisible", cmpEqual, true)
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtCreationDate(), "IsReadOnly", cmpEqual, true);
      
      if (client == "BNC" ){
          aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtDiscrMgmt(), "IsVisible", cmpEqual, true)
          aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtDiscrMgmt(), "IsReadOnly", cmpEqual, true);
      }
      if (client == "US"){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtDiscrMgmt(), "IsVisible", cmpEqual, false)
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtDiscrMgmt(), "IsReadOnly", cmpEqual, false);
      } 
    
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtSecurity(), "IsVisible", cmpEqual, true); 
      if (client == "US"){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtSecurity(), "IsReadOnly", cmpEqual, false); 
      } 
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtSecurity(), "IsReadOnly", cmpEqual, true); 
      } 
      
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtCUSIP(), "IsVisible", cmpEqual, true); 
      if (client == "US"){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtCUSIP(), "IsReadOnly", cmpEqual, false);
      } 
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtCUSIP(), "IsReadOnly", cmpEqual, true); 
      } 
      
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtTypeClass(), "IsVisible", cmpEqual, true);  
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtTypeClass(), "IsReadOnly", cmpEqual, true); 
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtISIN(), "IsVisible", cmpEqual, true); 
      if (client == "US"){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtISIN(), "IsReadOnly", cmpEqual, false);
      } 
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtISIN(), "IsReadOnly", cmpEqual, true);
      } 
       
      
      if (type=="options"){
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtStrikePrice(), "IsVisible", cmpEqual, true); 
      if (client == "US"){
         aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtStrikePrice(), "IsReadOnly", cmpEqual, false);
      } 
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtStrikePrice(), "IsReadOnly", cmpEqual, true); 
      } 
            
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtExpiration(), "IsVisible", cmpEqual, true); 
      if (client == "US"){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtExpiration(), "IsReadOnly", cmpEqual, false)
      } 
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_TxtExpiration(), "IsReadOnly", cmpEqual, true)
      }}
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_CmbMainMarket(), "IsVisible", cmpEqual, true);  
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_CmbMainMarket(), "IsEditable", cmpEqual, false); 
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol(), "IsVisible", cmpEqual, true);
      if (client == "US"){
      if (type == "futures" || type=="options" || type == "other" ){
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol(), "IsReadOnly", cmpEqual, true)
      } 
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol(), "IsReadOnly", cmpEqual, false);}
      } 
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol(), "IsReadOnly", cmpEqual, true);
      } 
      
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets(), "IsVisible", cmpEqual, true);
      
      if (type=="bond" || type=="commonStock" || type=="InvestmentFunds")aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets(), "IsEnabled", cmpEqual, false);  
      if (type=="futures" || type=="options" || type=="other"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets(), "IsEnabled", cmpEqual, true);}
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "IsEnabled", cmpEqual, false);
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromTheForeignPropertyReport(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromTheForeignPropertyReport(), "IsEnabled", cmpEqual, false);
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_CmbForeignProperty(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_CmbForeignProperty(), "IsReadOnly", cmpEqual, true);
       
      //if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ) {aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromBilling(), "IsVisible", cmpEqual, true)}; //N’existe pas dans l’automation 9
}

// La fonction qui vérifie l’existence des contrôles dans l’onglet sélectionné  pour un titre choisi
 function Check_Existence_Of_Controls(tab,type)
 {
  switch (tab)
  {
    case Get_WinInfoSecurity_TabInfo().IsSelected : //bond,commonStock
        //Prix
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid(), "IsVisible", cmpEqual, true); 
        if (client  == "US" ){
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid(), "IsReadOnly", cmpEqual, false);}
        else {
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid(), "IsReadOnly", cmpEqual, true);} 
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk(), "IsVisible", cmpEqual, true); 
         if (client  == "US" ){
         aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk(), "IsReadOnly", cmpEqual, false);}
         else {
         aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk(), "IsReadOnly", cmpEqual, true); }
        
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose(), "IsVisible", cmpEqual, true); 
        if (client  == "US" ){
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose(), "IsReadOnly", cmpEqual, false);
        } 
        else {
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose(), "IsReadOnly", cmpEqual, true);
        } 
         
         
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_CmbCurrency(), "IsVisible", cmpEqual, true);
        if (client  == "US" ){
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_CmbCurrency(), "IsReadOnly", cmpEqual, false);
        } 
        else {
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_CmbCurrency(), "IsReadOnly", cmpEqual, true);
        } 
        
         
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtUpdatedOn(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtUpdatedOn(), "IsReadOnly", cmpEqual, true);  
                      
        if (type=="commonStock" || type=="futures" ||type=="InvestmentFunds" || type=="bond" || type=="other" ) {
          //Devidendes
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_CmbFrequency(), "IsVisible", cmpEqual, true);
          if (client == "US"){
             aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_CmbFrequency(), "IsReadOnly", cmpEqual, false);
          } 
          else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_CmbFrequency(), "IsReadOnly", cmpEqual, true);
          } 
          
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_CmbCurrency(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_CmbCurrency(), "IsReadOnly", cmpEqual, false);
          } 
          else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_CmbCurrency(), "IsReadOnly", cmpEqual, true);
          } 
          }
      
        if (type=="commonStock"||type=="futures"||type=="bond")
          {aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtCallDate(), "IsVisible", cmpEqual, true)
          if (client == "US"){
             aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtCallDate(), "IsReadOnly", cmpEqual, false)
          } 
          else {
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtCallDate(), "IsReadOnly", cmpEqual, true)};}
      
        if (type=="futures")
          {aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtExpiration(), "IsVisible", cmpEqual, true)
          if (client == "US"){
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtExpiration(), "IsReadOnly", cmpEqual, false)
          } 
          else {
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtExpiration(), "IsReadOnly", cmpEqual, true)}}    
          
        if (type=="bond"){
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtRate(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtRate(), "IsReadOnly", cmpEqual, false);
          } 
          else {
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtRate(), "IsReadOnly", cmpEqual, true);} 
               
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtMaturity(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtMaturity(), "IsReadOnly", cmpEqual, false);
          } 
          else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtMaturity(), "IsReadOnly", cmpEqual, true);
          } 
          
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtFirstCoupon(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtFirstCoupon(), "IsReadOnly", cmpEqual, false);
          } 
          else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtFirstCoupon(), "IsReadOnly", cmpEqual, true);
          } 
          
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_CmbCompoundingMethod(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_CmbCompoundingMethod(), "IsReadOnly", cmpEqual, false)
          } 
          else {
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_CmbCompoundingMethod(), "IsReadOnly", cmpEqual, true)}
          }
          
        if (type=="bond")
          {aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtPrincipalFactor(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtPrincipalFactor(), "IsReadOnly", cmpEqual, false);
          } 
          else {
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtPrincipalFactor(), "IsReadOnly", cmpEqual, true);}}
      
        if (type=="commonStock"||type=="futures"||type=="InvestmentFunds" || type=="other"){
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtAmountUnit(), "IsVisible", cmpEqual, true);
          if (client == "US"){
             aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtAmountUnit(), "IsReadOnly", cmpEqual, false);
          } 
          else {
             aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtAmountUnit(), "IsReadOnly", cmpEqual, true);
          } 
         
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtRecordDate(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtRecordDate(), "IsReadOnly", cmpEqual, false);
          } 
          else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtRecordDate(), "IsReadOnly", cmpEqual, true);
          } 
          
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtExDividendDate(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtExDividendDate(), "IsReadOnly", cmpEqual, false);
          } 
          else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtExDividendDate(), "IsReadOnly", cmpEqual, true);
          } 
          
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtPaymentDate(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtPaymentDate(), "IsReadOnly", cmpEqual, false);
          } 
          else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_TxtPaymentDate(), "IsReadOnly", cmpEqual, true);
          } 
          } 
          
        if (type=="commonStock" || type=="futures" ||type=="InvestmentFunds" || type=="bond"|| type=="other"){        
          //Rendement
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_TxtMarketYield(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_TxtMarketYield(), "IsReadOnly", cmpEqual, true);}
      
        if (type=="bond"||type=="futures"){
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_TxtYTMMarketNominal(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_TxtYTMMarketNominal(), "IsReadOnly", cmpEqual, true);
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_TxtYTMMarketEffective(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_TxtYTMMarketEffective(), "IsReadOnly", cmpEqual, true);} 
          
          if (type=="bond" || type=="InvestmentFunds"){
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_TxtModifiedDuration(), "IsVisible", cmpEqual, true)
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_TxtModifiedDuration(), "IsReadOnly", cmpEqual, true)};
        
          
        if (type=="bond"||type=="futures"||type=="options"){  
          //Titre sous-jacent
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtDescription(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtDescription(), "IsReadOnly", cmpEqual, true);
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtSecurity(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtSecurity(), "IsReadOnly", cmpEqual, true);
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtSymbol(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtSymbol(), "IsReadOnly", cmpEqual, true);
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtClose(), "IsVisible", cmpEqual, true);
          aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_TxtClose(), "IsReadOnly", cmpEqual, true);} 
            
        // if (type=="InvestmentFunds"){
        // aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpBuys_TxtSubsequentAmount(), "IsVisible", cmpEqual, true)  ////N’existe pas dans l’automation 9
        // aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpBuys_TxtSubsequentAmount(), "IsReadOnly", cmpEqual, true)}; 
        
        //if (client == "CIBC" || client == "BNC" || client =="US"){aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_BtnChange(), "IsVisible", cmpEqual, true)}; //N’existe pas dans l’automation 9
      break;
    
    case Get_WinInfoSecurity_TabPriceHistory().IsSelected: //bond,commonStock
        if (type=="commonStock" || type=="InvestmentFunds" ||type=="options") {
          if (client == "BNC" ){
              aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_BtnTransfer(), "VisibleOnScreen", cmpEqual, true)
              aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_BtnTransfer(), "IsEnabled", cmpEqual, true)};
              if (client == "US"){
                aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_BtnTransfer(), "VisibleOnScreen", cmpEqual, false)
              aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_BtnTransfer(), "IsEnabled", cmpEqual, false)
              } 
          }
        break;  
      
    case Get_WinInfoSecurity_TabRatings().IsSelected: //bond,commonStock
    
       if (type=="commonStock"||type=="futures"||type=="bond" ||type=="options"){
          aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource1(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource1(), "IsReadOnly", cmpEqual, false);
          } 
          else {
           aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource1(), "IsReadOnly", cmpEqual, true);}
           
          aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating1(), "IsVisible", cmpEqual, true);
          if (client == "US"){
             aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating1(), "IsReadOnly", cmpEqual, false);
          } 
          else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating1(), "IsReadOnly", cmpEqual, true);
          } 
         
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource2(), "IsVisible", cmpEqual, true);
          if (client == "US"){
             aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource2(), "IsReadOnly", cmpEqual, false);
          } 
          else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource2(), "IsReadOnly", cmpEqual, true);
          } 
          
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating2(), "IsVisible", cmpEqual, true); 
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating2(), "IsReadOnly", cmpEqual, false);
          } 
          else {
             aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating2(), "IsReadOnly", cmpEqual, true);
          } 
          
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource3(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource3(), "IsReadOnly", cmpEqual, false);
          } 
          else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRatingSource3(), "IsReadOnly", cmpEqual, true);
          } 
          
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating3(), "IsVisible", cmpEqual, true);
          if (client == "US"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating3(), "IsReadOnly", cmpEqual, false);
          } 
          else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_TxtRating3(), "IsReadOnly", cmpEqual, true);
          } 
           } 
          
          //aqObject.CheckProperty(Get_WinInfoSecurity_tabRatings_GrpRiskRating_CmbRiskRating(), "IsVisible", cmpEqual, true); CROES-4035
          //aqObject.CheckProperty(Get_WinInfoSecurity_tabRatings_GrpRiskRating_CmbRiskRating(), "IsReadOnly", cmpEqual, false); CROES-4035
      break; 
     
    case Get_WinInfoSecurity_TabProfiles().IsSelected: //bond,commonStock
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles_BtnSetup(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles_BtnSetup(), "IsEnabled", cmpEqual, true);
      break; 
     
    case Get_WinInfoSecurity_TabInternetSites().IsSelected: //bond,commonStock   
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_BtnAnalysis(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_BtnAnalysis(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_BtnCompany(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_BtnCompany(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_BtnGraphs(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_BtnGraphs(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_BtnNews(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_BtnNews(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_BtnQuotes(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_BtnQuotes(), "IsEnabled", cmpEqual, true);
      
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_TxtAnalysis(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_TxtAnalysis(), "IsReadOnly", cmpEqual, false);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_TxtCompany(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_TxtCompany(), "IsReadOnly", cmpEqual, false);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_TxtGraphs(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_TxtGraphs(), "IsReadOnly", cmpEqual, false);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_TxtNews(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_TxtNews(), "IsReadOnly", cmpEqual, false);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_TxtQuotes(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_TxtQuotes(), "IsReadOnly", cmpEqual, false);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnOpenURL(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnOpenURL(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnAdd(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnAdd(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnDelete(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnDelete(), "IsEnabled", cmpEqual, false);
      break; 
    case Get_WinInfoSecurity_TabPW1859().IsSelected: //bond,commonStock,
       
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_ChkRemoveFromReports(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_ChkRemoveFromReports(), "IsEnabled", cmpEqual, false);
       
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_TxtAssetAllocation(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_TxtAssetAllocation(), "IsReadOnly", cmpEqual, true);
       
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_CmbManager(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_CmbManager(), "IsReadOnly", cmpEqual, true);
       
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_CmbMandate(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_CmbMandate(), "IsReadOnly", cmpEqual, true);
       
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_TxtPerformanceIndex(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_TxtPerformanceIndex(), "IsEnabled", cmpEqual, false);
       
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_TxtReferenceAccount(), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_TxtReferenceAccount(), "IsEnabled", cmpEqual, false);
       break; 
     case Get_WinInfoSecurity_TabIntegrations().IsSelected: //bond,commonStock, 
     
        aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_CmbIntegrationPartner(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_CmbIntegrationPartner(), "IsEnabled", cmpEqual, true);
        
        if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD"){
            aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_TxtSymbol(), "IsVisible", cmpEqual, true);
            if (client == "US"){
              aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_TxtSymbol(), "IsEnabled", cmpEqual, true);
            } 
            else {
              aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_TxtSymbol(), "IsEnabled", cmpEqual, false);
            } 
            
         
            aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_TxtCUSIP(), "IsVisible", cmpEqual, true);
            if (client == "US"){
              aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_TxtCUSIP(), "IsEnabled", cmpEqual, true);
            }
            else {
              aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_TxtCUSIP(), "IsEnabled", cmpEqual, false);
            } 
            
        }
        else {
            aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_CmbIndentifierType() , "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_CmbIndentifierType() , "IsEnabled", cmpEqual, false);
            
            aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_TxtTradingCountry() , "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_TxtTradingCountry() , "IsEnabled", cmpEqual, false);
            
            aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_CmbSecurityType(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_CmbSecurityType() , "IsEnabled", cmpEqual, false);
            
        }
      break;
      
    }
 }
 
function Check_Properties_French(type)
{     
      aqObject.CheckProperty(Get_WinInfoSecurity_BtnOK().Content, "OleValue", cmpEqual, "OK");
      //aqObject.CheckProperty(Get_WinInfoSecurity_BtnApply().Content, "OleValue", cmpEqual, "_Appliquer");CROES-5489 Le bouton Apply devrait être retiré.
      aqObject.CheckProperty(Get_WinInfoSecurity_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
  
      //*********************************DESCRIPTION ***************************** 
      //les étiquetés
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription().Header, "OleValue", cmpEqual, "Description");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblSubCategory().Text, "OleValue", cmpEqual, "Sous-Catégorie:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblFrenchDescription().Text, "OleValue", cmpEqual, "Description en français:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblEnglishDescription().Text, "OleValue", cmpEqual, "Description en anglais:");
      if (type=="commonStock" || type=="futures" || type=="InvestmentFunds" || type=="other"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblIndustryCode().Text, "OleValue", cmpEqual, "Code d'industrie:")};
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCountry().Text, "OleValue", cmpEqual, "Pays:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCurrency().Text, "OleValue", cmpEqual, "Devise:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCalculationFactor().Text, "OleValue", cmpEqual, "Facteur de calcul:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblUpdatedOn().Text, "OleValue", cmpEqual, "Modifié le:");
      if (type=="futures" || type=="bond"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblIssueDate().Text, "OleValue", cmpEqual, "Date d'émission:")};
      if (type=="commonStock" || type=="futures" || type=="other"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblConversionDate().Text, "OleValue", cmpEqual, "Date de conversion:")};     
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCreationDate().Text, "OleValue", cmpEqual, "Création:"); //Date de création: dans automation 9
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblDiscrMgmt().Text, "OleValue", cmpEqual, "Gestion discr.:");
      if (type=="options"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblOptionType().Text, "OleValue", cmpEqual, "Type d'option:")};
       
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblSecurity().Text, "OleValue", cmpEqual, "Titre:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCUSIP().Text, "OleValue", cmpEqual, "CUSIP:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblTypeClass().Text, "OleValue", cmpEqual, "Type/Classe:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblISIN().Text, "OleValue", cmpEqual, "ISIN:");
      if (type=="futures" ||type=="options"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblStrikePrice().Text, "OleValue", cmpEqual, "Prix d'exercice:")};
      if (type=="options"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblExpiration().Text, "OleValue", cmpEqual, "Expiration:")};
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket().Header, "OleValue", cmpEqual, "Bourse");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_LblMainMarket().Text, "OleValue", cmpEqual, "Bourse principale:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_LblMainSymbol().Text, "OleValue", cmpEqual, "Symbole principal:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets().Content, "OleValue", cmpEqual, "Gérer les bourses...");
      
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().Header, "OleValue", cmpEqual, "Divers");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "Content", cmpEqual, "Non rachetable");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromTheForeignPropertyReport(), "Content", cmpEqual, "Exclure du rapport Biens étrangers");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_LblForeignProperty().Text, "OleValue", cmpEqual, "Biens étrangers:");
      //if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){qObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_LblExcludeFromBilling().Text, "OleValue", cmpEqual, "Exclure de la facturation:")}; //N’existe pas dans l’automation 9  
      
           
      //**************************************** L'ONGLET INFO********************************
      Get_WinInfoSecurity_TabInfo().Click()
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo().Header, "OleValue", cmpEqual, "Info");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo(), "IsSelected", cmpEqual, true);
      
      //Prix
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice().Header, "OleValue", cmpEqual, "Prix");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_LblBid().Text, "OleValue", cmpEqual, "Acheteur:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_LblAsk().Text, "OleValue", cmpEqual, "Vendeur:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_LblClose().Text, "OleValue", cmpEqual, "Clôture:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_LblCurrency().Text, "OleValue", cmpEqual, "Devise:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_LblUpdatedOn().Text, "OleValue", cmpEqual, "Modifié le:"); 
      
      //Devidendes 
      if (type=="commonStock" || type=="futures" ||type=="InvestmentFunds" || type=="bond" || type=="other"){
        if (type=="InvestmentFunds" && client == "BNC")      
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends().Header, "OleValue", cmpEqual, "Historique des distributions");//BNC-2411
        else
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends().Header, "OleValue", cmpEqual, "Dividendes");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblFrequency().Text, "OleValue", cmpEqual, "Frequence:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblCurrency().Text, "OleValue", cmpEqual, "Devise:");  
        if (type=="commonStock" || type=="futures" || type=="bond"){aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblCallDate().Text, "OleValue", cmpEqual, "Rembours. anticipé:")};}
      
      if (type=="bond"){
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblRate().Text, "OleValue", cmpEqual, "Taux:");      
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblMaturity().Text, "OleValue", cmpEqual, "Échéance:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblFirstCoupon().Text, "OleValue", cmpEqual, "Premier coupon:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblCompoundingMethod().Text, "OleValue", cmpEqual, "Méthode de composition:");  
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblPrincipalFactor().Text, "OleValue", cmpEqual, "Facteur principal:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblAccruedInterest().Text, "OleValue", cmpEqual, "Int. courus/1000:");}
      
      if (type=="futures"){aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblExpiration().Text, "OleValue", cmpEqual, "Expiration:")};
      if (type=="bond" || type=="futures"){aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblCallPrice().Text, "OleValue", cmpEqual, "Prix échéance:")};
      
      if (type=="commonStock" || type=="futures" ||type=="InvestmentFunds" || type=="other"){
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblAmountUnit().Text, "OleValue", cmpEqual, "Montant/Unité:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblRecordDate().Text, "OleValue", cmpEqual, "Date d'enregistrement:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblExDividendDate().Text, "OleValue", cmpEqual, "Date ex-dividende:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblPaymentDate().Text, "OleValue", cmpEqual, "Date de versement:"); }
      
         //Rendement
      if (type=="commonStock" || type=="futures" ||type=="InvestmentFunds" || type=="bond" || type=="other"){aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield().Header, "OleValue", cmpEqual, "Rendement");}
       
      if (type=="bond"|| type=="futures"){
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_LblYTMMarketNominal().Text, "OleValue", cmpEqual, "Rend. éché. - Marché - Nominal (%):");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_LblYTMMarketEffective().Text, "OleValue", cmpEqual, "Rend. éché. - Marché - Effectif (%):");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_LblMarketYield().Text, "OleValue", cmpEqual, "Marché (%):");}
        
      if (type=="bond"||type=="InvestmentFunds"){aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_LblModifiedDuration().Text, "OleValue", cmpEqual, "Durée modifiée:")};
      if (type=="commonStock"||type=="InvestmentFunds" || type=="other"){ aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_LblMarketYield().Text, "OleValue", cmpEqual, "Rend. au marché (%):")}
      
        //Titre sous-jacent
      if (type=="bond"|| type=="futures"|| type=="options"){
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity().Header, "OleValue", cmpEqual, "Titre sous-jacent");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblDescription().Text, "OleValue", cmpEqual, "Description:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblSecurity().Text, "OleValue", cmpEqual, "Titre:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblSymbol().Text, "OleValue", cmpEqual, "Symbole:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblClose().Text, "OleValue", cmpEqual, "Clôture:");}
       
         //Achats 
      if (type=="InvestmentFunds"){  
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpBuys().Header, "OleValue", cmpEqual, "Achats");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpBuys_LblInitialAmount().Text, "OleValue", cmpEqual, "Montant initial:"); 
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpBuys_LblSubsequentAmount().Text, "OleValue", cmpEqual, "Montant subséquent:")};
        
      //if (client == "CIBC" || client == "BNC" || client =="US") {aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_BtnChange().Content, "OleValue", cmpEqual, "Mo_difier...")}; //N’existe pas dans l’automation 9
      
      //la présence des contrôles 
      Check_Existence_Of_Controls(Get_WinInfoSecurity_TabInfo().IsSelected,type)
         
      //*************************************** L'ONGLET HISTORIQUE DE PRIX ****************************************
      Get_WinInfoSecurity_TabPriceHistory().Click()
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory().Header, "OleValue", cmpEqual, "Historique des prix");//CROES-8855
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory(), "IsSelected", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChDate().Content, "OleValue", cmpEqual, "Date");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChBid().Content, "OleValue", cmpEqual, "Acheteur");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChAsk().Content, "OleValue", cmpEqual, "Vendeur");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChClose().Content, "OleValue", cmpEqual, "Clôture");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChCurrency().Content, "OleValue", cmpEqual, "Devise");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChLastUpdate().Content, "OleValue", cmpEqual, "Mise à jour"); //Dernière mise à jour dans automation 9
      
      if (type=="commonStock" ||type=="InvestmentFunds" || type=="options"){aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_BtnTransfer().Content, "OleValue", cmpEqual, "_Transfert...")};       
      Check_Existence_Of_Controls(Get_WinInfoSecurity_TabPriceHistory().IsSelected,type)
      
      //************************************** L'ONGLET HISTORIQUE DE DIVIDENDES ***********************************
      if (type=="commonStock"|| type=="future" ||type=="InvestmentFunds" || type=="other")
      {  
        Get_WinInfoSecurity_TabDividendsHistory().Click()
        aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory(), "IsSelected", cmpEqual, true);
        Log.Message("Modifié suite à la réponse de Mamoudou : Ce changement est apporté par le CR1356, Jira BNC-2411 ( depuis la 90.07.Co-5)")
        if (client == "BNC" && type=="InvestmentFunds"){            
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory().Header, "OleValue", cmpEqual, "Historique des distributions"); 
            Log.Message("Jira Croes-10697 :  Colonne 'Date d'enregistrement' n'existe pas : investigation en cours");       
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChRecordDate().Content, "OleValue", cmpEqual, "Date d'enregistrement");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChExDividendDate().Content, "OleValue", cmpEqual, "Date ex-dividende");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChPaymentDate().Content, "OleValue", cmpEqual, "Date de versement");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChTotalDistributions().Content, "OleValue", cmpEqual, "Total des distrib.");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChCapitalGains().Content, "OleValue", cmpEqual, "Gains en capital");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChDividend().Content, "OleValue", cmpEqual, "Dividendes");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChInterest().Content, "OleValue", cmpEqual, "Intérêts");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChROC().Content, "OleValue", cmpEqual, "RDC");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChForeignDividends().Content, "OleValue", cmpEqual, "Dividendes étrangers");
            
        }
        else{
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory().Header, "OleValue", cmpEqual, "Historique des dividendes");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChRecordDate().Content, "OleValue", cmpEqual, "Date d'enregistrement");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChExDividendDate().Content, "OleValue", cmpEqual, "Date ex-dividende");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChPaymentDate().Content, "OleValue", cmpEqual, "Date de versement");
            Log.Message("Jira CROES-11146:  L'affichage de l'entête de la colonne Dividende n'est pas le même dans les deux onglets : Historique des dividendes et Historique des distributions. Une avec s et l'autre sans s")
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChDividend().Content, "OleValue", cmpEqual, "Dividende");
        }
        
        
      }
      
      
      //*********************************************EVENEMENT CORPORATIFS ****************************************
        if (type=="commonStock"){
          Get_WinInfoSecurity_TabCorporateActions().Click()
          aqObject.CheckProperty(Get_WinInfoSecurity_TabCorporateActions().Header, "OleValue", cmpEqual, "Opérations sur titres"); //YR: Corrigé suite à CROES-7740

          aqObject.CheckProperty(Get_WinInfoSecurity_TabCorporateActions(), "IsSelected", cmpEqual, true);
      
          aqObject.CheckProperty(Get_WinInfoSecurity_TabCorporateActions_ChType().Content, "OleValue", cmpEqual, "Type");
          aqObject.CheckProperty(Get_WinInfoSecurity_TabCorporateActions_ChRatio().Content, "OleValue", cmpEqual, "Ratio");
          aqObject.CheckProperty(Get_WinInfoSecurity_TabCorporateActions_ChEffectiveDate().Content, "OleValue", cmpEqual, "Date d'effet");}
          
      //************************************* L'ONGLET COTATIONS***************************************************   
       if (type=="commonStock"||type=="futures"||type=="bond" ||type=="options" || type=="other" || type=="InvestmentFunds")
       {
       
       Get_WinInfoSecurity_TabRatings().Click()
          aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings().Header, "OleValue", cmpEqual, "Cotations");
          aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings(), "IsSelected", cmpEqual, true);
          
          if (type=="commonStock"||type=="futures"||type=="bond" ||type=="options")
          {     
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRatingSource1().Text, "OleValue", cmpEqual, "Agence de cotation 1:");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRating1().Text, "OleValue", cmpEqual, "Cotation:");
          
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRatingSource2().Text, "OleValue", cmpEqual, "Agence de cotation 2:");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRating2().Text, "OleValue", cmpEqual, "Cotation:");
            
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRatingSource3().Text, "OleValue", cmpEqual, "Agence de cotation 3:");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRating3().Text, "OleValue", cmpEqual, "Cotation:");           
          }
          
       aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRiskRating().Header, "OleValue", cmpEqual, "Cote de risque");
        //la présence des contrôles
       Check_Existence_Of_Controls(Get_WinInfoSecurity_TabRatings().IsSelected,type)
      }
     
      //***************************************************** L'ONGLET PROFILS***********************************
      Get_WinInfoSecurity_TabProfiles().Click()
      aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles().Header, "OleValue", cmpEqual, "Profils");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles(), "IsSelected", cmpEqual, true);
          
      aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles().Content, "OleValue", cmpEqual, "Masquer champs vides");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles_BtnSetup().Content, "OleValue", cmpEqual, "Configuration...");
      
      //la présence des contrôles
      Check_Existence_Of_Controls(Get_WinInfoSecurity_TabProfiles().IsSelected,type)
      
      //**************************************** L'ONGLET SITES INTERNET*****************************************
      Get_WinInfoSecurity_TabInternetSites().Click()
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites().Header, "OleValue", cmpEqual, "Sites Internet");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites(), "IsSelected", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_LblAnalysis().Text, "OleValue", cmpEqual, "Analyse:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_LblCompany().Text, "OleValue", cmpEqual, "Compagnie:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_LblGraphs().Text, "OleValue", cmpEqual, "Graphiques:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_LblNews().Text, "OleValue", cmpEqual, "Nouvelles:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_LblQuotes().Text, "OleValue", cmpEqual, "Cours:");
           
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses().Header, "OleValue", cmpEqual, "Autres adresses Internet"); //EM : 90.10.Fm-2 : Modifié suite au CR2083- Avant c'était "Autres adresses internet"
      
      //les entêtes de colonnes 
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_ChURL().Content, "OleValue", cmpEqual, "URL");      
      //cliquer sur scrollbar pour faire l'entête de colonne visible
      var ControlWidth=Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_dgvURLList().get_ActualWidth()
      var ControlHeight=Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_dgvURLList().get_ActualHeight()
      for (i=1; i<=5; i++) { Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_dgvURLList().Click(ControlWidth-5, ControlHeight-5)}
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_ChDescription().Content, "OleValue", cmpEqual, "Description");
     
      //btns
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnAdd().Content, "OleValue", cmpEqual, "Aj_outer");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnDelete().Content, "OleValue", cmpEqual, "S_upprimer...");
      
      //la présence des contrôles
      Check_Existence_Of_Controls(Get_WinInfoSecurity_TabInternetSites().IsSelected,type)
      
      //************************************************** L'ONGLET GP1859****************************************
      if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
        Get_WinInfoSecurity_TabPW1859().Click()
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859(), "IsSelected", cmpEqual, true);
      
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblRemoveFromReports().Text, "OleValue", cmpEqual, "Exclure des rapports:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblAssetAllocation().Text, "OleValue", cmpEqual, "Répartition d'actifs:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblManager().Text, "OleValue", cmpEqual, "Gestionnaire:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblMandate().Text, "OleValue", cmpEqual, "Mandat:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblPerformanceIndex().Text, "OleValue", cmpEqual, "Indice de rendement:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblReferenceAccount().Text, "OleValue", cmpEqual, "Compte de référence:");
      
        //la présence des contrôles
        Check_Existence_Of_Controls(Get_WinInfoSecurity_TabPW1859().IsSelected,type)
      }
      //********************************************* L'ONGLET INTEGRATIONS**************************************
      
    if (client == "CIBC" || client == "BNC" || client == "TD" || client == "US"){
      Delay(3000)
       Get_WinInfoSecurity_TabIntegrations().Click()

       aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations(), "IsSelected", cmpEqual, true);
       aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations().Header, "OleValue", cmpEqual, "Integrations");
       if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
         aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_LblSymbol().Text, "OleValue", cmpEqual, "Symbole:");
         aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_LblCUSIP().Text, "OleValue", cmpEqual, "CUSIP:");
       }
       else {
         aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_LblIndentifier().Text, "OleValue", cmpEqual, "Identifiant:");
         aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_LblTradingCountry().Text, "OleValue", cmpEqual, "Pays de négociation:");
         aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_LblSecurityType().Text, "OleValue", cmpEqual, "Type de titre:");
       }
        //la présence des contrôles
       Check_Existence_Of_Controls(Get_WinInfoSecurity_TabIntegrations().IsSelected,type)
     }
}

function Check_Properties_English(type)
{
      aqObject.CheckProperty(Get_WinInfoSecurity_BtnOK().Content, "OleValue", cmpEqual, "OK");
      //aqObject.CheckProperty(Get_WinInfoSecurity_BtnApply().Content, "OleValue", cmpEqual, "_Apply");;CROES-5489 Le bouton Apply devrait être retiré.
      aqObject.CheckProperty(Get_WinInfoSecurity_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
      
      //***********************************************DESCRIPTION ******************************************** 
      //les étiquetés
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription().Header, "OleValue", cmpEqual, "Description");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblSubCategory().Text, "OleValue", cmpEqual, "Subcategory:");
      if (client == "US")
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblDescription().Text, "OleValue", cmpEqual, "Description:");
      else {
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblFrenchDescription().Text, "OleValue", cmpEqual, "French Desc.:");
        aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblEnglishDescription().Text, "OleValue", cmpEqual, "English Desc.:");
      }
      if(client == "RJ"){
        if (type=="commonStock"||type=="futures"||type=="InvestmentFunds"||type=="other" ){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblIndustryCode().Text, "OleValue", cmpEqual, "Sector:")};
      }
      else{
        if (type=="commonStock"||type=="futures"||type=="InvestmentFunds"||type=="other"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblIndustryCode().Text, "OleValue", cmpEqual, "Industry Code:")};
      }
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCountry().Text, "OleValue", cmpEqual, "Country:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCurrency().Text, "OleValue", cmpEqual, "Currency:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCalculationFactor().Text, "OleValue", cmpEqual, "Calculation Factor:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblUpdatedOn().Text, "OleValue", cmpEqual, "Updated On:");
      if (type=="futures" || type=="bond"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblIssueDate().Text, "OleValue", cmpEqual, "Issue Date:")};
      if (type=="commonStock"||type=="futures"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblConversionDate().Text, "OleValue", cmpEqual, "Conversion Date:")};
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCreationDate().Text, "OleValue", cmpEqual, "Creation Date:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblDiscrMgmt().Text, "OleValue", cmpEqual, "Discr. Mgmt:");
      if (type=="options"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblOptionType().Text, "OleValue", cmpEqual, "Option Type:")};
         
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblSecurity().Text, "OleValue", cmpEqual, "Security:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblCUSIP().Text, "OleValue", cmpEqual, "CUSIP:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblTypeClass().Text, "OleValue", cmpEqual, "Type/Class:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblISIN().Text, "OleValue", cmpEqual, "ISIN:");
      if (type=="futures"||type=="options"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblStrikePrice().Text, "OleValue", cmpEqual, "Strike Price:")};
      if (type=="options"){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_LblExpiration().Text, "OleValue", cmpEqual, "Expiration:")};
      
      //Market
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket().Header, "OleValue", cmpEqual, "Market");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_LblMainMarket().Text, "OleValue", cmpEqual, "Main Market:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_LblMainSymbol().Text, "OleValue", cmpEqual, "Main Symbol:");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMarket_BtnManageMarkets().Content, "OleValue", cmpEqual, "Manage Markets...");
      
      //Miscellaneous
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous().Header, "OleValue", cmpEqual, "Miscellaneous");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkNonRedeemable(), "Content", cmpEqual, "Non-redeemable");
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_ChkExcludeFromTheForeignPropertyReport(), "Content", cmpEqual, "Exclude from the Foreign Property report", false);
      aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_LblForeignProperty().Text, "OleValue", cmpEqual, "Foreign Property:");
      //if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){aqObject.CheckProperty(Get_WinInfoSecurity_GrpDescription_GrpMiscellaneous_LblExcludeFromBilling().Text, "OleValue", cmpEqual, "Exclude from billing:")}; //N’existe pas dans l’automation 9   
     
      
      //**************************************** L'ONGLET INFO*******************************************************
      Get_WinInfoSecurity_TabInfo().Click()
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo().Header, "OleValue", cmpEqual, "Info");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo(), "IsSelected", cmpEqual, true);
      
      //Price
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice().Header, "OleValue", cmpEqual, "Price");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_LblBid().Text, "OleValue", cmpEqual, "Bid:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_LblAsk().Text, "OleValue", cmpEqual, "Ask:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_LblClose().Text, "OleValue", cmpEqual, "Close:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_LblCurrency().Text, "OleValue", cmpEqual, "Currency:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_LblUpdatedOn().Text, "OleValue", cmpEqual, "Updated On:"); 
       
      //Devidendes  
      if (type=="commonStock" || type=="futures" ||type=="InvestmentFunds" || type=="bond" || type=="other"){       
        if (type=="InvestmentFunds" && (client == "BNC" || client == "CIBC"))
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends().Header, "OleValue", cmpEqual, "Distribution History");//BNC-2411
        else 
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends().Header, "OleValue", cmpEqual, "Dividends")
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblFrequency().Text, "OleValue", cmpEqual, "Frequency:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblCurrency().Text, "OleValue", cmpEqual, "Currency:");
        if (type=="commonStock" || type=="futures" || type=="bond"){aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblCallDate().Text, "OleValue", cmpEqual, "Call Date:")}
        
      if (type=="bond"){
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblRate().Text, "OleValue", cmpEqual, "Rate:");      
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblMaturity().Text, "OleValue", cmpEqual, "Maturity:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblFirstCoupon().Text, "OleValue", cmpEqual, "First Coupon:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblCompoundingMethod().Text, "OleValue", cmpEqual, "Compounding Method:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblPrincipalFactor().Text, "OleValue", cmpEqual, "Principal Factor:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblAccruedInterest().Text, "OleValue", cmpEqual, "Accrued Int./1000:");}
      
      if (type=="futures"){aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblExpiration().Text, "OleValue", cmpEqual, "Expiration:")};
      if (type=="bond"||type=="futures"){aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblCallPrice().Text, "OleValue", cmpEqual, "Call Price:")};
      
      if (type=="commonStock" ||type=="futures" ||type=="InvestmentFunds" || type=="other"){
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblAmountUnit().Text, "OleValue", cmpEqual, "Amount/Unit:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblRecordDate().Text, "OleValue", cmpEqual, "Record Date:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblExDividendDate().Text, "OleValue", cmpEqual, "Ex-Dividend Date:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpDividends_LblPaymentDate().Text, "OleValue", cmpEqual, "Payment Date:");}
        
       //Rendement  
      if (type == "commonStock" || type == "futures" || type == "InvestmentFunds" || type == "bond" || type == "other" ) {aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield().Header, "OleValue", cmpEqual, "Yield");}
      
      if (type == "bond" || type == "futures"){
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_LblYTMMarketNominal().Text, "OleValue", cmpEqual, "YTM - Market - Nominal (%):");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_LblYTMMarketEffective().Text, "OleValue", cmpEqual, "YTM - Market - Effective (%):");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_LblMarketYield().Text, "OleValue", cmpEqual, "Market (%):");}
        
      if (type == "bond" || type == "InvestmentFunds"){aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_LblModifiedDuration().Text, "OleValue", cmpEqual, "Modified Duration:")};
      if (type == "commonStock" || type == "InvestmentFunds" || type == "other"){ aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpYield_LblMarketYield().Text, "OleValue", cmpEqual, "Market Yield (%):");} 
       
      //Titre sous-jacent 
      if (type == "bond" || type == "futures" || type == "options")
      { aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity().Header, "OleValue", cmpEqual, "Underlying Security");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblDescription().Text, "OleValue", cmpEqual, "Description:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblSecurity().Text, "OleValue", cmpEqual, "Security:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblSymbol().Text, "OleValue", cmpEqual, "Symbol:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_LblClose().Text, "OleValue", cmpEqual, "Close:");}
      
      //Achats            
      if (type == "InvestmentFunds")
      { aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpBuys().Header, "OleValue", cmpEqual, "Buys");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpBuys_LblInitialAmount().Text, "OleValue", cmpEqual, "Initial Amount:"); 
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpBuys_LblSubsequentAmount().Text, "OleValue", cmpEqual, "Subsequent Amount:"); }  
         
      //if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpUnderlyingSecurity_BtnChange().Content, "OleValue", cmpEqual, "_Change...")};//N’existe pas dans l’automation 9
      
      //la présence des contrôles
      Check_Existence_Of_Controls(Get_WinInfoSecurity_TabInfo().IsSelected,type)
         
      //**************************** L'ONGLET HISTORIQUE DE PRIX *********************************************
      Get_WinInfoSecurity_TabPriceHistory().Click()
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory().Header, "OleValue", cmpEqual, "Price History",false);
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory(), "IsSelected", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChDate().Content, "OleValue", cmpEqual, "Date");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChBid().Content, "OleValue", cmpEqual, "Bid");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChAsk().Content, "OleValue", cmpEqual, "Ask");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChClose().Content, "OleValue", cmpEqual, "Close");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChCurrency().Content, "OleValue", cmpEqual, "Currency");
      if (client  == "CIBC")
          aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChLastUpdate().Content, "OleValue", cmpEqual, "Updated on");
      else
          aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_ChLastUpdate().Content, "OleValue", cmpEqual, "Last Update");
      
      if (type == "commonStock" || type == "InvestmentFunds" || type == "options") {aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory_BtnTransfer().Content, "OleValue", cmpEqual, "_Transfer...")};
      Check_Existence_Of_Controls(Get_WinInfoSecurity_TabPriceHistory().IsSelected,type)
      
      //************************* L'ONGLET HISTORIQUE DE DIVIDENDES ****************************************
      if (type == "commonStock" || type == "futures" || type == "InvestmentFunds" || type == "other")
      {
        Get_WinInfoSecurity_TabDividendsHistory().Click()        
        aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory(), "IsSelected", cmpEqual, true);
         Log.Message("Modifié suite à la réponse de Mamoudou : Ce changement est apporté par le CR1356, Jira BNC-2411 ( depuis la 90.07.Co-5)")
        if (client == "BNC" && type=="InvestmentFunds"){            
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory().Header, "OleValue", cmpEqual, "Distribution History"); 
            Log.Message("Jira Croes-10697 :  Colonne 'Date d'enregistrement' n'existe pas : investigation en cours");       
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChRecordDate().Content, "OleValue", cmpEqual, "Record Date");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChExDividendDate().Content, "OleValue", cmpEqual, "Ex-Dividend Date");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChPaymentDate().Content, "OleValue", cmpEqual, "Payment Date");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChTotalDistributions().Content, "OleValue", cmpEqual, "Total Distributions");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChCapitalGains().Content, "OleValue", cmpEqual, "Capital Gains");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChDividend().Content, "OleValue", cmpEqual, "Dividends");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChInterest().Content, "OleValue", cmpEqual, "Interest");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChROC().Content, "OleValue", cmpEqual, "ROC");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChForeignDividends().Content, "OleValue", cmpEqual, "Foreign Dividends");
            
        }
        else{
            if (client == "CIBC" && type == "InvestmentFunds")
                aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory().Header, "OleValue", cmpEqual, "Distribution History");        
            else{
                Log.Message("CROES-8032");
                aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory().Header, "OleValue", cmpEqual, "Dividend History"); //Dividends History in automation 9        
            }
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChRecordDate().Content, "OleValue", cmpEqual, "Record Date");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChExDividendDate().Content, "OleValue", cmpEqual, "Ex-Dividend Date");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChPaymentDate().Content, "OleValue", cmpEqual, "Payment Date");
            if (client != "CIBC")
                aqObject.CheckProperty(Get_WinInfoSecurity_TabDividendsHistory_ChDividend().Content, "OleValue", cmpEqual, "Dividend");  
        }     
      }
      
      //********************************EVENEMENT CORPORATIFS *********************************************
      if (type == "commonStock")
      {
        Get_WinInfoSecurity_TabCorporateActions().Click()
        aqObject.CheckProperty(Get_WinInfoSecurity_TabCorporateActions().Header, "OleValue", cmpEqual, "Corporate Actions", false);
        aqObject.CheckProperty(Get_WinInfoSecurity_TabCorporateActions(), "IsSelected", cmpEqual, true);
      
        aqObject.CheckProperty(Get_WinInfoSecurity_TabCorporateActions_ChType().Content, "OleValue", cmpEqual, "Type");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabCorporateActions_ChRatio().Content, "OleValue", cmpEqual, "Ratio");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabCorporateActions_ChEffectiveDate().Content, "OleValue", cmpEqual, "Effective Date");
      }
      
      //************************** L'ONGLET COTATIONS DE CREDIT (Ratings) *****************************************
       if (type == "commonStock" || type == "futures" || type == "bond" || type == "options" || type == "other" || type == "InvestmentFunds")
       {
          Get_WinInfoSecurity_TabRatings().Click();
          
          aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings().Header, "OleValue", cmpEqual, "Ratings");
          aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings(), "IsSelected", cmpEqual, true);
          
          if (type == "commonStock" || type == "futures" || type == "bond" || type == "options")
          {              
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRating1().Text, "OleValue", cmpEqual, "Rating:");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRatingSource1().Text, "OleValue", cmpEqual, "Rating Source 1:");
          
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRatingSource2().Text, "OleValue", cmpEqual, "Rating Source 2:");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRating2().Text, "OleValue", cmpEqual, "Rating:");  
          
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRatingSource3().Text, "OleValue", cmpEqual, "Rating Source 3:");
            aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRatings_LblRating3().Text, "OleValue", cmpEqual, "Rating:");       
          }  
        
         aqObject.CheckProperty(Get_WinInfoSecurity_TabRatings_GrpRiskRating().Header, "OleValue", cmpEqual, "Risk Rating");
         //la présence des contrôles
         Check_Existence_Of_Controls(Get_WinInfoSecurity_TabRatings().IsSelected,type);
       }
      }
      
     //**************************************** L'ONGLET PROFILS************************************************
      Get_WinInfoSecurity_TabProfiles().Click()
      aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles().Header, "OleValue", cmpEqual, "Profiles");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles(), "IsSelected", cmpEqual, true);
          
      aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles_ChkHideEmptyProfiles().Content, "OleValue", cmpEqual, "Hide Empty Profiles");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles_BtnSetup().Content, "OleValue", cmpEqual, "Setup...");
      
      //la présence des contrôles
      Check_Existence_Of_Controls(Get_WinInfoSecurity_TabProfiles().IsSelected,type)
      
      //**************************************** L'ONGLET SITES INTERNET****************************************
      if (client != "TD" && client != "CIBC")  {
      Get_WinInfoSecurity_TabInternetSites().Click()
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites().Header, "OleValue", cmpEqual, "Internet Sites");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites(), "IsSelected", cmpEqual, true);
      
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_LblAnalysis().Text, "OleValue", cmpEqual, "Analysis:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_LblCompany().Text, "OleValue", cmpEqual, "Company:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_LblGraphs().Text, "OleValue", cmpEqual, "Graphs:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_LblNews().Text, "OleValue", cmpEqual, "News:");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_LblQuotes().Text, "OleValue", cmpEqual, "Quotes:");
           
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses().Header, "OleValue", cmpEqual, "Other Internet Addresses");
      
      //les entêtes de colonnes 
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_ChURL().Content, "OleValue", cmpEqual, "URL");      
      //cliquer sur scrollbar pour faire visible les entêtes de colonnes 
      var ControlWidth=Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_dgvURLList().get_ActualWidth()
      var ControlHeight=Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_dgvURLList().get_ActualHeight()
      for (i=1; i<=5; i++) { Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_dgvURLList().Click(ControlWidth-5, ControlHeight-5)}
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_ChDescription().Content, "OleValue", cmpEqual, "Description");
     
      //btns
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnAdd().Content, "OleValue", cmpEqual, "A_dd");
      aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites_GrpOtherInternetAddresses_BtnDelete().Content, "OleValue", cmpEqual, "De_lete");
      
      //la présence des contrôles
      Check_Existence_Of_Controls(Get_WinInfoSecurity_TabInternetSites().IsSelected,type)}
      
      //**************************************** L'ONGLET GP1859************************************************
      if (client == "BNC"){
        Get_WinInfoSecurity_TabPW1859().Click()
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859(), "IsSelected", cmpEqual, true);
      
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblRemoveFromReports().Text, "OleValue", cmpEqual, "Remove from Reports:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblAssetAllocation().Text, "OleValue", cmpEqual, "Asset Allocation:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblManager().Text, "OleValue", cmpEqual, "Manager:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblMandate().Text, "OleValue", cmpEqual, "Mandate:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblPerformanceIndex().Text, "OleValue", cmpEqual, "Performance Index:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPW1859_LblReferenceAccount().Text, "OleValue", cmpEqual, "Reference Account:");
      
        //la présence des contrôles
        Check_Existence_Of_Controls(Get_WinInfoSecurity_TabPW1859().IsSelected,type)
      }
       //**************************************** L'ONGLET INTEGRATIONS*****************************************
      if (client == "CIBC" || client == "BNC" || client == "TD" || client == "US"){
      Delay(35000) 
      Get_WinInfoSecurity_TabIntegrations().Click()

      aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations(), "IsSelected", cmpEqual, true);
      aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations().Header, "OleValue", cmpEqual, "Integrations");
      if (client == "CIBC" || client == "BNC" || client == "TD" || client == "US"){
        aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_LblSymbol().Text, "OleValue", cmpEqual, "Symbol:");
        aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_LblCUSIP().Text, "OleValue", cmpEqual, "CUSIP:");
      }
     else {
         aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_LblIndentifier().Text, "OleValue", cmpEqual, "Identifier:");
         aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_LblTradingCountry().Text, "OleValue", cmpEqual, "Trading Country:");
         aqObject.CheckProperty(Get_WinInfoSecurity_TabIntegrations_LblSecurityType().Text, "OleValue", cmpEqual, "Security Type:");
     }
      //la présence des contrôles
      Check_Existence_Of_Controls(Get_WinInfoSecurity_TabIntegrations().IsSelected,type);
      }
}

