//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6271
       
    Description :Valider l'archivage des documents dans le module client et la gestion du commenataire.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-10--V9-croesus-co7x-1_5_1_572
    
    Date: 29/04/2019
*/

function Regression_Croes_6271_Cli_ValidateSearchClientsModule()
{
  
  try{
  
   Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6271", "Croes-6271");

    var nomClient=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameClient", language+client);
    var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "IACode", language+client);
    var numTel=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "TelNumber", language+client);
    var nomClientTel=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientPhone", language+client);
    var NoClient=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNo_4399", language+client);
    
    
    
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //Lancer la recheche pour le nom du client
    Get_Toolbar_BtnSearch().Click();
    Get_WinQuickSearch_TxtSearch().SetText(nomClient);
    Get_WinClientsQuickSearch_RdoName().Click();
       
    //Valider l'affichage de la fenêtre recherche et le critère Nom coché
    aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "Text", cmpEqual,nomClient);
    aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoName(),"IsChecked", cmpEqual,true);
    Get_WinQuickSearch_BtnOK().Click();
    
    //Valider l'affichage du curseur devant le client JANSEN BABCOCK
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",nomClient, 10 ).DataContext, "IsActive", cmpEqual, true);  
    
    //Lancer la recherche pour le code de CP
    Get_Toolbar_BtnSearch().Click();
    Get_WinQuickSearch_TxtSearch().SetText(codeCP);    
    Get_WinQuickSearch_RdoIACode().Click();
    
    //Valider que le critère Code de CP est coché et BD88 dans le champ rechercher
    aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "Text", cmpEqual,codeCP);
    aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoIACode(),"IsChecked", cmpEqual,true);
    Get_WinQuickSearch_BtnOK().Click();
    
    //Valider que le curseur se place sur le code de CP BD88
    var CpBD88= Get_RelationshipsClientsAccountsGrid().Find("IsActive", true, 10).DataContext.DataItem.RepresentativeNumber.OleValue
    CheckEquals(CpBD88, codeCP, "IACode");
    
    //Lancer la recherche pour le Téléphone 1     
    Get_Toolbar_BtnSearch().Click();
    Get_WinQuickSearch_TxtSearch().SetText(numTel);    
    Get_WinClientsQuickSearch_RdoTelephone1().Click();
    
    //Valider que le critère Téléphone 1 est coché et le numéro de tél (450) 555-6934 est dans le champ rechercher
    aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "Text", cmpEqual, numTel);
    aqObject.CheckProperty(Get_WinClientsQuickSearch_RdoTelephone1(),"IsChecked", cmpEqual,true);
    Get_WinQuickSearch_BtnOK().Click();
    
    //Valider que le curseur se place sur HOFFMAN ARRY
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",nomClientTel, 10).DataContext, "IsActive", cmpEqual, true);  
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",NoClient, 10).DataContext, "IsActive", cmpEqual, true);  
  }
    catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }   
}     

