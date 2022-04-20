//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4318
       
    Description :Valider les valeurs calculées dans le module Clients.
                 Pour valider la valeur, mailler vers le module portefeuille.
                 Valeur totale = Valeur au marché du portefeuille + Int./ Div. Courus  
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-10--V9-croesus-co7x-1_5_1_572
    
    Date: 24/04/2019
*/

function Regression_Croes_4318_Cli_ValidateCalculatedValues()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4318", "Croes-4318");
    
    var clientNum800228=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum_4318", language+client);
    var valeurTotale=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "totalValue", language+client);
    var valeurMarche=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "marketValue", language+client);
    var intDiv=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "intDiv", language+client);
    var infoClient=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "header", language+client);
    
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //Sélectionner le client 800228 et cliquer sur le bouton Info  
    Search_Client(clientNum800228);
    Get_ClientsBar_BtnInfo().Click();
    
    //Valider la valeur 476 250.89 dans Valeur totale

    if (Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtTotalValue().Text.OleValue == valeurTotale)
     Log.Checkpoint("La valeur totale attendue est affichée")
      else
     Log.Error("La valeur affichée est erronée")
    Get_WinDetailedInfo_BtnOK().Click();
     
    //Mailler le client vers portefeuille
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum800228, 10).Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
    var isDragSucessfull = Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    if (!isDragSucessfull) Log.Error("The Drag Client to Portfolio was not successfull.");
    return isDragSucessfull;
    aqObject.CheckProperty(Get_Portfolio_Tab(1), "Header", cmpEqual, infoClient)
    
    //Valider dans la section Sommaire la Valeur de marché= 474 087.08 et Int./ Div. Courus = 2 163.81
    if (Get_PortfolioGrid_GrpSummary_TxtMarketValue().Text.OleValue == valeurMarche)
     Log.Checkpoint("La valeur du marché attendue est affichée")
      else
     Log.Error("La valeur affichée est erronée")
    
    if (Get_PortfolioGrid_GrpSummary_TxtAccruedIntDiv().Text.OleValue == intDiv)
     Log.Checkpoint("La valeur  Int./ Div. Courus attendue est affichée")
      else
     Log.Error("La valeur affichée est erronée")

  }
     catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }   
}
