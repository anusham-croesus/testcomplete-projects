//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/*
    Description :Valider les valeurs calculées avec le bouton sommation
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4129
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version: ref90-10-Fm-6--V
    
*/

function Regression_CROES_4129_Acc_ValidateOperationSummationButton()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4129", "Croes-4129");
     
    var ClientNo= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "ClientNo", language+client);
    var accountNO1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo1", language+client);
    var accountNO2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo2", language+client);
    var accountNO3= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo3", language+client);
    var soldeDeb= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "soldeDeb", language+client);
    var soldeCred= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "soldeCred", language+client);
    var soldeTotal= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "soldeTotal", language+client);
    var valeurTotal= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "valeurTotal", language+client);
    var nombreComp= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "nombreComp", language+client);   
    var balance1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "balance1", language+client);
    var balance2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "balance2", language+client);
    var balance3= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "balance3", language+client);
    var totalValue1= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "totalValue1", language+client);
    var totalValue2= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "totalValue2", language+client);
    var totalValue3= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "totalValue3", language+client);
    var somSoldeCred= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "somSoldeCred", language+client);
    var somValTotalCompte= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "somValTotalCompte", language+client);

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
  
    //Cliquer sur le bouton sommation
    Get_Toolbar_BtnSum().Click();
  
    //valider les valeurs de la fenêtre sommation : solde créditeur , solde 
    aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(),"WPFControlText", cmpEqual, soldeCred);
    aqObject.CheckProperty( Get_WinAccountsSum_TxtDebitBalanceTotalCAD(),"WPFControlText", cmpEqual, soldeDeb); 
    aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(),"WPFControlText", cmpEqual, soldeTotal);
    aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText",cmpEqual, valeurTotal);
    aqObject.CheckProperty( Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(),"WPFControlText",cmpEqual, nombreComp);
 
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
  
    //Vérifier le solde et la valeur total pour les 3 comptes
    verifyBalanceAndTotalValueForAccount(accountNO1, balance1, totalValue1)
    verifyBalanceAndTotalValueForAccount(accountNO2,balance2, totalValue2)
    verifyBalanceAndTotalValueForAccount(accountNO3,balance3, totalValue3)
  
    //valider la somme des soldes des 3 comptes
  
    var b1= Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO1, 10).DataContext.DataItem.Balance.OleValue;
    var b2 = Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO2, 10).DataContext.DataItem.Balance.OleValue;
    var b3= Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO3, 10).DataContext.DataItem.Balance.OleValue
    var total = VarToFloat(b1)+ VarToFloat(b2)+VarToFloat(b3);
    Log.Message(total);
    if (total == VarToFloat(somSoldeCred)) 
      Log.Checkpoint("La somme du solde des 3 comptes correspond au Solde créditeur","expected = "+somSoldeCred+"detected = "+total)
    else
      Log.Error("Le total du solde ne correspond au Solde créditeur","expected = "+somSoldeCred+" detected = "+total)
  
    //Valider la somme de la valeur totale des 3 comptes
    var tv1= Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO1, 10).DataContext.DataItem.TotalValue.OleValue;
    var tv2 = Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO2, 10).DataContext.DataItem.TotalValue.OleValue;
    var tv3= Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO3, 10).DataContext.DataItem.TotalValue.OleValue
    var som = VarToFloat(tv1)+ VarToFloat(tv2)+VarToFloat(tv3);
    Log.Message(som);
   
    if (som == VarToFloat(somValTotalCompte)) 
    Log.Checkpoint("La somme de la valeur totale des 3 comptes correspond à la Valeur totale des comptes","expected = "+somValTotalCompte+" detected = "+som)
    else
    Log.Error("Le total des valeurs totales ne correspond à la Valeur totale des comptes","expected = "+somValTotalCompte+" detected = "+som)
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
  }
}

function verifyBalanceAndTotalValueForAccount(accountNO, balance, totalValue)
{
 if(Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO, 10).Exists)
 {
 aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO, 10).DataContext.DataItem,"Balance", cmpEqual, balance);
 aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNO, 10).DataContext.DataItem,"TotalValue", cmpEqual, totalValue);
 }
  else 
 {
   Log.Error("The Account number '" + accountNO + "' cell was not found.")
 }

} 
