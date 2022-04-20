//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions


/* Description : A partir du module « Transactions » , afficher la fenêtre « Info » en cliquant sur EditFunctions_Info. 
 Vérifier la présence des contrôles et des étiquetés */

function Survol_Tra_MenuBar_EditFunctions_Info()
{
   var type="transfer"; // Le variable utilisée dans les points de vérifications 
   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000)){
    Delay(2000);
     if(client == "US" || client == "TD" || client == "CIBC" ){
       Search_Transactions_Type("transfer");
     } 
     // rechercher un transfer
     //Delay(2000);
     //Search_Transactions_Type("transfer");

     //afficher la fenêtre « Info » en cliquant sur EditFunctions_Info.
     Get_MenuBar_Edit().OpenMenu();
     
      var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
   Get_MenuBar_Edit().OpenMenu();
    numberOftries++;
  } 
  
     
    
//     Delay(3000); 
     
      Get_MenuBar_Edit_FunctionsForTransactions().OpenMenu();
     
      var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
    Get_MenuBar_Edit_FunctionsForTransactions().OpenMenu();
    numberOftries++;
       } 
     Get_MenuBar_Edit_FunctionsForTransactions_Info().Click();
     
     //Les points de vérification
     Check_InfoTransactions_Properties(language,type);
     Check_InfoTransactions_Properties_TabAmounts(language);
     Check_InfoTransactions_Properties_TabGainsLosses(language);
   }
   else {
     Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
   
   ////La fermeture de la fenêtre «Info» 
   Get_WinTransactionsInfo_BtnCancel().Click();
   
   Close_Croesus_AltF4();
}


function Check_InfoTransactions_Properties(language,type)
{
  aqObject.CheckProperty(Get_WinTransactionsInfo(), "Title", cmpEqual, GetData(filePath_Transactions,"Info",2,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnSeparate().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",3,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnSeparate(), "IsVisible", cmpEqual, true);
  if(client == "BNC" ){
    aqObject.CheckProperty(Get_WinTransactionsInfo_BtnSeparate(), "IsEnabled", cmpEqual, true);
  }
  else{
    aqObject.CheckProperty(Get_WinTransactionsInfo_BtnSeparate(), "IsEnabled", cmpEqual, false);
  }
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnOK().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",4,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnOK(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnOK(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnCancel().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",5,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_BtnCancel(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnCancel(), "IsEnabled", cmpEqual, true);
  // ajout des points de vérification  pour le bouton Reassign pour US
  if(client == "US" ){
    aqObject.CheckProperty(Get_WinTransactionsInfo_BtnReassign().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",53,language));
    aqObject.CheckProperty(Get_WinTransactionsInfo_BtnReassign(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinTransactionsInfo_BtnReassign(), "IsEnabled", cmpEqual, false);
  } 
  aqObject.CheckProperty(Get_WinTransactionsInfo_LblType().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",6,language));
  if(client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
  aqObject.CheckProperty(Get_WinTransactionsInfo_CmbType(), "IsEnabled", cmpEqual, false);
  }
  else{
    aqObject.CheckProperty(Get_WinTransactionsInfo_CmbType(), "IsEnabled", cmpEqual, true);
  }
  aqObject.CheckProperty(Get_WinTransactionsInfo_CmbType(), "IsVisible", cmpEqual, true);
  
  if (client == "BNC" || client == "CIBC")
    aqObject.CheckProperty(Get_WinTransactionsInfo_LblDescription().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",55,language)); //EM: 90-12-Hf-5 : Avant c'était "Description"
  else
    aqObject.CheckProperty(Get_WinTransactionsInfo_LblDescription().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",7,language));
    
  if(client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
    aqObject.CheckProperty(Get_WinTransactionsInfo_TxtDescription(), "IsReadOnly", cmpEqual, true);
  }
  else{
    aqObject.CheckProperty(Get_WinTransactionsInfo_TxtDescription(), "IsReadOnly", cmpEqual, false);
  }
  aqObject.CheckProperty(Get_WinTransactionsInfo_ChkCancelled().Content, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",8,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_ChkCancelled(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_ChkCancelled(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_ChkCancelled(), "IsChecked", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_ChkOnBalance().Content, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",9,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_ChkOnBalance(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_ChkOnBalance(), "IsVisible", cmpEqual, true);
  
  if(client == "BNC" ){
    aqObject.CheckProperty(Get_WinTransactionsInfo_ChkOnBalance(), "IsChecked", cmpEqual, false);
  }
  else{
    aqObject.CheckProperty(Get_WinTransactionsInfo_ChkOnBalance(), "IsChecked", cmpEqual, true);
  }
  
  //Accounts
  aqObject.CheckProperty(Get_WinTransactionsInfo_AccountsSeparator(), "TextValue", cmpEqual, GetData(filePath_Transactions,"Info",10,language));  
  aqObject.CheckProperty(Get_WinTransactionsInfo_LblFromAccount().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",11,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_TxtFromAccount(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TxtFromAccount(), "IsVisible", cmpEqual, true);
    
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnFromAccount(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnFromAccount(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_LblFor().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",12,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_LblToAccount().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",13,language));
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_TxtToAccount(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TxtToAccount(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnToAccount(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnToAccount(), "IsVisible", cmpEqual, true);
    
  aqObject.CheckProperty(Get_WinTransactionsInfo_LblTo().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",14,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_TxtTo(), "IsVisible", cmpEqual, true);
    
  //Security
  aqObject.CheckProperty(Get_WinTransactionsInfo_SecuritySeparator(), "TextValue", cmpEqual, GetData(filePath_Transactions,"Info",15,language)); 
  
  if(type=="transfer"){
    aqObject.CheckProperty(Get_WinTransactionsInfo_LblSecurityOrCUSIP().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",16,language))}
  else{
    aqObject.CheckProperty(Get_WinTransactionsInfo_LblSecurityOrCUSIP().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",17,language))
  }
  if(client == "BNC" ){
    aqObject.CheckProperty(Get_WinTransactionsInfo_TxtSecurityOrCUSIP(), "IsReadOnly", cmpEqual, true);
  }
  else{
    aqObject.CheckProperty(Get_WinTransactionsInfo_TxtSecurityOrCUSIP(), "IsReadOnly", cmpEqual, false);
  }
  aqObject.CheckProperty(Get_WinTransactionsInfo_TxtSecurityOrCUSIP(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnSecurityOrCUSIP(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_BtnSecurityOrCUSIP(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_ChkDRIP().Content, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",18,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_ChkDRIP(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_ChkDRIP(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_LblDividends().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",19,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_TxtDividends(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TxtDividends(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_CmbDividendsCurrency(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_CmbDividendsCurrency(), "IsVisible", cmpEqual, true);
      
  //Dates
  aqObject.CheckProperty(Get_WinTransactionsInfo_DatesSeparator(), "TextValue", cmpEqual, GetData(filePath_Transactions,"Info",20,language)); 
  aqObject.CheckProperty(Get_WinTransactionsInfo_LblTransaction().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",21,language));
  if(client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
    aqObject.CheckProperty(Get_WinTransactionsInfo_DtpTransaction(), "IsEnabled", cmpEqual, false);
  }
  else{
    aqObject.CheckProperty(Get_WinTransactionsInfo_DtpTransaction(), "IsEnabled", cmpEqual, true);
  }
  aqObject.CheckProperty(Get_WinTransactionsInfo_LblTransaction(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_LblCompounded().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",22,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_LblSettlement().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",23,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_LblPaid().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",24,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_TxtPaid(), "IsVisible", cmpEqual, true); 
  
  //note
   aqObject.CheckProperty(Get_WinTransactionsInfo_LblNote().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",25,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TxtNote(), "IsVisible", cmpEqual, true);
   if(client=="US")
   {
   aqObject.CheckProperty(Get_WinTransactionsInfo_BtnReassign().Content.Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",53,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_BtnReassign(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinTransactionsInfo_BtnReassign(), "IsEnabled", cmpEqual, false); }
    
   
}

function Check_InfoTransactions_Properties_TabAmounts(language)
{
  //L'ONGLET AMOUNTS 
   Get_WinTransactionsInfo_TabAmounts().Click();
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts().Header, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",28,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_LblQuantity(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",29,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbQuantity(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_LblAtSymbol(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",30,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbCost(), "IsReadOnly", cmpEqual, false);
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbCost(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbCostCurrency(), "IsReadOnly", cmpEqual, false);
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbCostCurrency(), "IsVisible", cmpEqual, true);
    
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_LblGrossAmount(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",31,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtGrossAmount(), "IsVisible", cmpEqual, true);
     
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtGrossAmountCurrency(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_LblRate(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",32,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbRate(), "IsVisible", cmpEqual,true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtCurrenciesFromTo(), "IsVisible", cmpEqual,true);
  
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_LblAccruedInterest(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",33,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbAccruedInterest(), "IsVisible", cmpEqual, true);
   
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtAccruedInterestCurrency(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_LblCommission(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",34,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtCommission(), "IsEnabled", cmpEqual, false);   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtCommission(), "IsVisible", cmpEqual, true);
     
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbCommissionType(), "IsEnabled", cmpEqual, false);   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbCommissionType(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkIncludedInThePrice(), "Content", cmpEqual, GetData(filePath_Transactions,"Info",35,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkIncludedInThePrice(), "IsVisible", cmpEqual, true);
   if(client == "BNC" ){
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkIncludedInThePrice(), "IsChecked", cmpEqual, true);
   }
   else{
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkIncludedInThePrice(), "IsChecked", cmpEqual, false);
   }
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkIncludedInThePrice(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_LblCommissionPercent(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",36,language));
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtCommissionCurrency(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_LblFees(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",37,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtFees(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtFees(), "IsEnabled", cmpEqual, false);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_LblFeesAndComm(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",38,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtFeesAndComm(), "IsReadOnly", cmpEqual, true);
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtFeesAndComm(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtFeesAndCommCurrency(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_LblNetAmount(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",39,language));
   if(client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbNetAmount(), "IsEnabled", cmpEqual, false);
   }
   else{
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbNetAmount(), "IsEnabled", cmpEqual, true);
   }
    
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_CmbNetAmount(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtNetAmountCurrency(), "IsVisible", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_LblCashFlow(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",40,language));
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtCashFlow(), "IsReadOnly ", cmpEqual, true);
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_TxtCashFlow(), "IsVisible ", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkCashFlow(), "IsVisible ", cmpEqual, true);
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkCashFlow(), "IsChecked ", cmpEqual, true);
   if(client == "BNC" ){
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkCashFlow(), "IsEnabled ", cmpEqual, true);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkCashFlow(), "IsChecked ", cmpEqual, true);    
   }
   else{
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkCashFlow(), "IsEnabled ", cmpEqual, false);
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkCashFlow(), "IsChecked ", cmpEqual, true);
   }
   aqObject.CheckProperty(Get_WinTransactionsInfo_TabAmounts_ChkCashFlow(), "IsChecked ", cmpEqual, true);
}


function Check_InfoTransactions_Properties_TabGainsLosses(language, type)
{
  Get_WinTransactionsInfo_TabGainsLosses().Click();
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses().Header, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",43,language));
  //Gains/Losses
  if (client != "CIBC")
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses(), "Header", cmpEqual, GetData(filePath_Transactions,"Info",44,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_ChkCalculated(), "IsChecked ", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_ChkCalculated(), "IsEnabled ", cmpEqual, false);
 
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblCalculated(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",45,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblPositionCost(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",46,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblManualCost(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",47,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblGainsLosses(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",48,language));
  if(client=="US")
  {
  // Les points de vérifications de la toute la ligne de Position Cost:
 
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnitCostPositionCost(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnitCostPositionCost(), "IsVisible", cmpEqual, true);

  // Les points de vérifications de la toute la ligne de Manual Cost:
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnitCostManualCost(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnitCostManualCost(), "IsVisible", cmpEqual, true);
  
  // Les points de vérifications de la toute la ligne de Gains/Losses:
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnitCostGainsLosses(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtUnitCostGainsLosses(), "IsVisible", cmpEqual, true);
  // le point de vérification de Unit Cost
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblUnitCost(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",54,language));
     
  } 
  else
  {
  // Les points de vérifications de la toute la ligne de Position Cost:
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInvestCostPositionCost(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInvestCostPositionCost(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBPositionCost(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBPositionCost(), "IsVisible", cmpEqual, true);
  // Les points de vérifications de la toute la ligne de Manual Cost:
  
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInvestCostManualCost(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInvestCostManualCost(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBManualCost(), "IsEnabled", cmpEqual, false);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBManualCost(), "IsVisible", cmpEqual, true);
  // Les points de vérifications de la toute la ligne de Gains/Losses:
 
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInvestCostGainsLosses(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtInvestCostGainsLosses(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBGainsLosses(), "IsReadOnly", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_TxtACBGainsLosses(), "IsVisible", cmpEqual, true);
  // Les points de vérifications des labels de Invest. Cost et ACB
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblInvestCost(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",49,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpGainsLosses_LblACB(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",50,language));
  
}
  //Miscellaneous
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous().Header, "OleValue", cmpEqual, GetData(filePath_Transactions,"Info",51,language));
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous_LblLastBuy(), "Text", cmpEqual, GetData(filePath_Transactions,"Info",52,language));
  if(client == "BNC" ){
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous_DtpLastBuy(), "IsEnabled", cmpEqual, true);
  }
  else{
    aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous_DtpLastBuy(), "IsEnabled", cmpEqual, false);
  }
  aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses_GrpMiscellaneous_DtpLastBuy(), "IsVisible", cmpEqual, true);
   
}

