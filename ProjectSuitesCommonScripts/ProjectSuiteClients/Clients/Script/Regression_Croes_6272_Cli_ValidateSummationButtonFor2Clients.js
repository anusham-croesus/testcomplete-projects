//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6272
       
    Description :Valider le fonctionnement du bouton Sommation pour 2 Clients.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-10--V9-croesus-co7x-1_5_1_572
    
    Date: 02/05/2019
*/

function Regression_Croes_6272_Cli_ValidateSummationButtonFor2Clients()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6272", "Croes-6272");
      var client800227=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Client_6272", language+client);
      var client800223=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Client800223", language+client);
      var valeurTotale=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientsTotalValue", language+client);
      var nombreClients=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientsNumber", language+client);
    
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    
    //Sélectionner les deux clients 800223 et 8000227
    var clients= new Array(client800227, client800223)
    for (var i =0 ; i < clients.length; i++){          
        
    Log.Message("numeros clients :");
    Log.Message(clients[i]);
    }
    SelectClients(clients)

    //Cliquer sur le bouton Sommantion
    Get_Toolbar_BtnSum().Click();
    
    //Valider l'affichage de la fenêtre Sommation, le Total=CAD, la valeur totale Clients et nombre de clients
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRelationshipsClientsAccountsSum(), "VisibleOnScreen", cmpEqual, true);
    
    if (client == "CIBC"){
        aqObject.CheckProperty(Get_WinClientsSum_LblTotalCAD_CIBC(), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinClientsSum_LblTotalCAD_CIBC(), "VisibleOnScreen", cmpEqual, true); 
       
        aqObject.CheckProperty(Get_WinClientsSum_TxtClientsTotalValue_CIBC(),"Content", cmpEqual, valeurTotale);
        aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients_CIBC(), "Content", cmpEqual, nombreClients);
    }
    else {
        aqObject.CheckProperty(Get_WinClientsSum_LblTotalCAD(), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_WinClientsSum_LblTotalCAD(), "VisibleOnScreen", cmpEqual, true); 
       
        aqObject.CheckProperty(Get_WinClientsSum_TxtClientsTotalValue(),"Text", cmpEqual, valeurTotale);
        aqObject.CheckProperty(Get_WinClientsSum_TxtNumberOfClients(), "Text", cmpEqual, nombreClients);
    }
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }   
}     

function Get_WinClientsSum_LblTotalCAD_CIBC(){        
            return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"], 10)}           
            
function Get_WinClientsSum_TxtClientsTotalValue_CIBC(){
    return Get_WinRelationshipsClientsAccountsSum().WPFObject("DataGrid", "", 3).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10)}  
    
function Get_WinClientsSum_TxtNumberOfClients_CIBC(){
        return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10)}