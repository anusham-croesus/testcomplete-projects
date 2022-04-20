//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Regression_CROES_4129_Acc_ValidateOperationSummationButton


/*
    Description :Valider les valeurs calculées: la valeur au marché additionné aux int./div. courus pour un compte CAD et USD
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4133
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
*/


function Regression_CROES_4133_Acc_ValidateCalculatedValues()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4133","CROES_4133");
    var ClientNo= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "ClientNo", language+client);
    var ClientNo2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "ClientNo2", language+client);
    var accountNO1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo1", language+client);
    var accountNO2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo2", language+client);
    var accountNO3= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo3", language+client);
    var totalValue1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "totalValue1", language+client);
    var totalValue2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "totalValue2", language+client);
    var totalValue3= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "totalValue3", language+client);
    var balance1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "balance1_4133", language+client);
    var balance2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "balance2_4133", language+client);
    var balance3= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "balance3_4133", language+client);
    var accountNoUSD= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNoUSD", language+client);
    var valeurTotalUSD= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "valeurTotalUSD", language+client);
    var valeurTotal= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "valeurTotal_4133", language+client);
    var balanceUSD= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "balanceUSD", language+client);
    var USD= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "USD", language+client);
    
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
  
    //aller sur le module client
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnClients().Click();
  
    //sélectionner le client 800228 et le mailler vers compte
    SelectClients(ClientNo);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Accounts().Click();
    Get_MenuBar_Modules_Accounts_DragSelection().Click();
  
    //Valider les 3 comptes: 80028-FS, 800228-JW et 800228-RE sont associés ce client
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO1, 10),"Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO2, 10),"Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO3, 10),"Exists", cmpEqual, true)
  
  
    //Vérifier le solde et la valeur total pour les 3 comptes
    verifyBalanceAndTotalValueForAccount(accountNO1,balance1, totalValue1)
    verifyBalanceAndTotalValueForAccount(accountNO2,balance2, totalValue2)
    verifyBalanceAndTotalValueForAccount(accountNO3,balance3, totalValue3)
  
    //valider le total des 3 comptes
    var tv1= Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO1, 10).DataContext.DataItem.TotalValue.OleValue;
    var tv2 = Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO2, 10).DataContext.DataItem.TotalValue.OleValue;
    var tv3= Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO3, 10).DataContext.DataItem.TotalValue.OleValue
    var som = VarToFloat(tv1)+ VarToFloat(tv2)+VarToFloat(tv3);
    Log.Message(som);
   
   if (language=="french")
   {
      if (som == VarToFloat(valeurTotal)) {
        Log.Checkpoint("La somme de la valeur totale des 3 comptes correspond à la Valeur totale des comptes")
      }
      else
        Log.Error("Le total des valeurs totales ne correspond à la Valeur totale des comptes")
   }
   if (language== "english")
   {    
     if (som == VarToFloat(valeurTotal)) {
      Log.Checkpoint("The sum of market value and int./Div. accrued is equal to the total value of the 3 accounts")
     }
     else
      Log.Error("The calculation does not equal to the total value of the 3 accounts")
   }
    
    
    //sélectionner le client 800228 et le mailler vers portefeuille
    SelectClients(ClientNo);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    
   //valider que la somme de la "Valeur de marché" et de "Int./Div. courus" sont éagale à la valeur totale
    var mk= Get_PortfolioGrid_GrpSummary_TxtMarketValue().Text.OleValue;
    var id= Get_PortfolioGrid_GrpSummary_TxtAccruedIntDiv().Text.OleValue;
    
    if (language == "french")
     {var som =aqConvert.StrToFloat(aqString.Replace(aqString.Replace(mk, ",", "."), " ", ""))+ aqConvert.StrToFloat(aqString.Replace(aqString.Replace(id, ",", "."), " ", ""))
    Log.Message(som) ;
    
       if (som == VarToFloat(valeurTotal))
       Log.Checkpoint("La somme de la valeur de marché et de int./Div. courus est égale à la valeur totale des 3 comptes.")
       else
       Log.Error("Le calcul ne correspond pas à la valeur total des 3 comptes.")
     }
     
    if (language== "english")
   {mk= aqString.Replace(mk, ",", "")
   mk= aqString.Replace(mk, ".", ",")
   id=aqString.Replace(id, ",", "")
   id= aqString.Replace(id, ".", ",")
  
  var som =(aqConvert.StrToFloat(mk))+ (aqConvert.StrToFloat(id));
    Log.Message(som);
   
      Log.Message(valeurTotal)
    if (som == VarToFloat(valeurTotal))

       Log.Checkpoint("The sum of market value and int./Div. accrued is equal to the total value of the 3 accounts.")
     else
       Log.Error("The calculation does not equal to the total value of the 3 accounts ")
     
    }
    //aller sur le module client
    Get_ModulesBar_BtnClients().Click();
  
    //sélectionner le client 3000006 et le mailler vers compte
    SelectClients(ClientNo2);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Accounts().Click();
    Get_MenuBar_Modules_Accounts_DragSelection().Click();
    
    //valider le compte 300006-OB associé à ce client
     aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNoUSD, 10),"Exists", cmpEqual, true);
    
    //Vérifier le solde et la valeur total pour ce compte
    verifyBalanceAndTotalValueForAccount(accountNoUSD, balanceUSD, valeurTotalUSD)
    
    //sélectionner le client 300006 et le mailler vers portefeuille
    SelectClients(ClientNo2);
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    
    //changer la devise à USD
    Get_PortfolioGrid_BarToolBarTray_CmbCurrency().Click();
    Get_SubMenus().Find("WPFControlText", USD, 10).Click();
    
    //valider que la somme de la "Valeur de marché" et de "Int./Div. courus" sont éagale à la valeur totale
    var mk= Get_PortfolioGrid_GrpSummary_TxtMarketValue().Text.OleValue;
    var id= Get_PortfolioGrid_GrpSummary_TxtAccruedIntDiv().Text.OleValue;
     if (language == "french")
     {
     var som = aqConvert.StrToFloat(aqString.Replace(aqString.Replace(mk, ",", "."), " ", ""))+ aqConvert.StrToFloat(aqString.Replace(aqString.Replace(id, ",", "."), " ", ""))
     Log.Message(som) ;
    
       if (som == VarToFloat(valeurTotalUSD))
         Log.Checkpoint("La somme de la valeur de marché et de int./Div. courus est égale à la valeur attendu.")
       else
         Log.Error("Le calcul ne correspond pas à la valeur attendu.")
     }
    
    if (language== "english")
   {
   mk= aqString.Replace(mk, ",", "")
   mk= aqString.Replace(mk, ".", ",")
   id= aqString.Replace(id, ".", ",")
   var som =(aqConvert.StrToFloat(mk))+ (aqConvert.StrToFloat(id));
   Log.Message(som);
   
     if (som == VarToFloat(valeurTotalUSD))
       Log.Checkpoint("The total value is equal to the expected sum.")
     else
       Log.Error("The total value is diffrent from the sum ")
       }
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
  }
    
}
