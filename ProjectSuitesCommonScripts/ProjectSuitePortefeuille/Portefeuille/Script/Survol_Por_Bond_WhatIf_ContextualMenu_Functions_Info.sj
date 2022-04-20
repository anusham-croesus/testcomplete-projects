//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Survol_Por_Bond_MenuBar_EditFunctions_Info

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur le btn What-if
Rechercher une position avec le symbol 1CAD. Afficher la fenêtre Info pour la position Cash
en cliquant sur btnInfo du menu contextuel. Fermer la fenêtre par ESC */
 
function Survol_Por_Bond_WhatIf_ContextualMenu_Functions_Info()
{
 // Les variables utilisées dans les points de vérifications 
  var type="bond";
  var btnType="whatif";
  
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
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
    
  Get_PortfolioBar_BtnWhatIf().Click();
  
  Search_Position("OBA")
  
  Get_MainWindow().Keys("[Apps]")
  Get_PortfolioGrid_ContextualMenu_Functions().Click()
  Get_PortfolioGrid_ContextualMenu_Functions_Info().Click()

 //Les points de vérification 
  Check_WhatIfInfo_Properties(language, type) 
  Check_Existence_Of_Controls_InfoWhatif(type)
  Check_PositionInfo_Properties(language, type)// la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  Check_Existence_Of_Controls_PositionInfo(type,btnType)// la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  
  Get_WinPositionInfo_BtnCancel().Keys("[Esc]");
  
  Close_Croesus_X();    
 }
 
 //Fonctions  (les points de vérification pour les scripts qui testent Info)
function Check_WhatIfInfo_Properties(language, type)
{
     aqObject.CheckProperty(Get_WinPositionInfo_BtnOK(), "Content", cmpEqual, GetData(filePath_Portefeuille,"Info",2,language));
     aqObject.CheckProperty(Get_WinPositionInfo_BtnCancel(), "Content", cmpEqual, GetData(filePath_Portefeuille,"Info",3,language));
             
     //Security Information:
     if(type=="bond"){  
     Get_WinPositionInfo_TabInfo().Click();
     aqObject.CheckProperty(Get_WinPositionInfo_TabInfo_GrpSecurityInformation().Header, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",6,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSubcategory().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",7,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSecurity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",8,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCalculationFactor().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",9,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblUnderlyingSecurity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",10,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCallPrice().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",11,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCallDate().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",12,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblInterest().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",13,language));
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblFrequency().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",14,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblModifiedDuration().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",15,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCUSIP().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",16,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_Lbl1stCoupon().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",17,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblIssueDate().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",18,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblInterestCurrency().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",19,language));
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblMaturity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",20,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblPrincipalFactor().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",21,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblISIN().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",22,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCompoundInterestMethod().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",23,language));}
     
     if(type=="equity"){     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSubcategoryForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",27,language)); 
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSectorForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",28,language));     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSymbolForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",29,language));          
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCalculationFactorForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",30,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblFrequencyForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",31,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblDividendDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",32,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblIssueDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",33,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblBetaForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",34,language));
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSecurityForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",35,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCUSIPForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",36,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblDividendForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",37,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblRecordDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",38,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCallDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",39,language));
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblMarketForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",40,language));     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblISINForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",41,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblDividendCurrencyForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",42,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblExDividendDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",43,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblConversionDateForEquity().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",44,language));}
     
     if(type=="other"){     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSubcategoryForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",48,language));    
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSymbolForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",49,language)); 
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCUSIPForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",50,language));         
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblFrequencyForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",51,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblExDividendDateForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",52,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblSecurityForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",53,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblISINForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",54,language));
    
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblDividendForOther().Text, "OleValue", cmpEqual, GetData(filePath_Portefeuille,"Info",55,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblRecordDateForOther().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",56,language));
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblCalculationFactorForOther().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",57,language));   
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblDividendDateForOther().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",58,language));     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblDividendCurrencyForOther().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",59,language));
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_LblBetaForOther().Text, "OleValue", cmpEqual,  GetData(filePath_Portefeuille,"Info",60,language));}
}

 function Check_Existence_Of_Controls_InfoWhatif(type)
{   

     //Security Information:
     if(type=="bond"){
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtSubcategory(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtSecurity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCalculationFactor(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtUnderlyingSecurity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCallPrice(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCallDate(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtInterestCurrency(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtFrequency(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtModifiedDuration(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCUSIP(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_Txt1stCoupon(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtIssueDate(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtInterestCurrency(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtMaturity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtPrincipalFactor(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtISIN(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCompoundInterestMethod(), "IsVisible", cmpEqual, true);}
     
     if(type=="equity"){
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtSubcategoryForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtSectorForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtSymbolForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCalculationFactorForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtFrequencyForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtDividendDateForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtIssueDateForEquity(), "IsVisible", cmpEqual, true);
     
       if (client == "BNC"  ){
          aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtBetaForEquity(), "IsVisible", cmpEqual, true);
       }    
       
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtSecurityForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCUSIPForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtDividendForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtRecordDateForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtCallDateForEquity(), "IsVisible", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtMarketForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtISINForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtDividendCurrencyForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtExDividendDateForEquity(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSecurityInformation_TxtConversionDateForEquity(), "IsVisible", cmpEqual, true);}
}
    
     
  
     
     

