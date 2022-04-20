//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4307
    
   
    Description :Vérifier le fonctionnement du bouton Performance.
           
    Auteur : Asma Alaoui
    
    ref90-10-Fm-10--V9-croesus-co7x-1_5_1_572
    
    Date: 19/04/2019
*/

function Regression_Croes_4307_Cli_VlaidateOperationPerformanceButton()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4307", "Croes-4307");
    
     var clientNum800223=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Client800223", language+client);
     var clientNum600001=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Client600001", language+client);
     var msgInfo=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "MessageInfo", language+client);
     var clientNum300002=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Client300002", language+client);
     var clientNum300005=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Client300005", language+client);
     var clientNum300006=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Client300006", language+client);
     var clientNum300007=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Client300007", language+client);
     var WndCaption=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "WndCaption", language+client);
    
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //Sélectionner le client 800223   
    Search_Client(clientNum800223);
    Get_RelationshipsClientsAccountsGrid().Find("Value",clientNum800223,10).Click();
    
    //Cliquer sur Performance
    Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();

    //Valider l'affichage de la fenêtre Performance
    aqObject.CheckProperty(Get_WinPerformance(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinPerformance(),"VisibleOnScreen", cmpEqual, true)   
    Get_WinPerformance_BtnClose().Click();
    
    //Sélectionner le client 6000001
    Search_Client(clientNum600001);
    Get_RelationshipsClientsAccountsGrid().Find("Value",clientNum600001,10).Click();
    
    //Cliquer sur le bouton Performance
    Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
    
    //Valider l'affichage du message "Aucune donnée de performance..."
    aqObject.CheckProperty(Get_DlgInformation().FindChild("WPFControlText", msgInfo, 10),"VisibleOnScreen",cmpEqual,true)
    Get_DlgInformation_BtnOK().Click();
    
    //Selectionner les clients ''300002, 300005, 300006 et  300007 "
    var slectClients= new Array(clientNum300002, clientNum300005, clientNum300006, clientNum300007 );
    for (var i =0 ; i < slectClients.length; i++){          
        
    Log.Message("numeros clients :");
    Log.Message(slectClients[i]);
    }
    SelectClients(slectClients);
    
    //Cliquer sur le bouton Performance
    Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
    
    //Valider la fenêtre de Performance du client: Clients groupés
    aqObject.CheckProperty(Get_CroesusApp().FindChild("WndCaption", WndCaption, 10), "VisibleOnScreen",cmpEqual,true)
    aqObject.CheckProperty(Get_CroesusApp().FindChild("WndCaption", WndCaption, 10), "Exists",cmpEqual,true)
  }
    catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }   
}     

