//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4322
    
   
    Description :Cette fenêtre vous permet de choisir pour chaque client les produits et services..
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-6--V9-croesus-co7x-1_5_565
    
    Date: 03/04/2019
*/


function Regression_Croes_4322_Cli_AddProductsAndServicesToClient()
{

  try{  

  Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4322", "Croes-4322");
    var clientNum800228=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum_4290", language+client);
    var champ1=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Champ1", language+client);
    var champ2=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Champ2", language+client);
    var champ3=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Champ3", language+client);
  
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //Sélectionner le client 800217    
    Search_Client(clientNum800228);
    
    //Aller sur Info et sélectionner Produits & Services  
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabProductsAndServices().Click();
    Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", "True", 30000);
    
    //Sélectionner Configurer et cocher les produits "Obl. convertibles" et "Obl. corporatives"
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_BtnSetup().Click();
    Get_WinProductSetup_ChkProduct("Obl. convertibles", "Bonds-Convertible").set_IsChecked(true);
    Get_WinProductSetup_ChkProduct( "Obl. corporatives", "Bonds-Corporate").set_IsChecked(true);
    Get_WinProductSetup_BtnOK().Click();
    
    //Dans la section Produits cocher Obl. convertibles" et "Obl. corporatives" et valider la sélection
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. convertibles", "Bonds-Convertible").set_IsChecked(true);
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. corporatives", "Bonds-Corporate").set_IsChecked(true);
    
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. convertibles", "Bonds-Convertible"),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. convertibles", "Bonds-Convertible"),"VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. convertibles", "Bonds-Convertible"),"IsChecked", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. corporatives", "Bonds-Corporate"),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. corporatives", "Bonds-Corporate"),"VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. corporatives", "Bonds-Corporate"),"IsChecked", cmpEqual, true)
    
    //Dans la séction Services cliquer sur configurer et cocher les services "Séminaires" et "Recherches"
    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_BtnSetup().Click();
    Get_WinServiceSetup_ChkService("Séminaires", "Seminars").set_IsChecked(true);
    Get_WinServiceSetup_ChkService("Recherches", "Research").set_IsChecked(true);
    Get_WinServiceSetup_BtnOK().Click();
    
    //Cocher dans le séction Services "Séminaires" et "Recherches" et valider la sélection
    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars").WaitProperty("VisibleOnScreen", "True", 30000);
    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars").set_IsChecked(true);
    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Recherches", "Research").set_IsChecked(true);
    
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars"),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars"),"VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars"),"IsChecked", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Recherches", "Research"),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Recherches", "Research"),"VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Recherches", "Research"),"IsChecked", cmpEqual, true)
    Get_WinDetailedInfo_BtnOK().Click();
     
    //Rétablir la configuration par défaut
    Get_ModulesBar_BtnClients().Click();    
    Search_Client(clientNum800228);  
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabProductsAndServices().Click();
    Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", "True", 30000);
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. convertibles", "Bonds-Convertible").set_IsChecked(false);
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. corporatives", "Bonds-Corporate").set_IsChecked(false);
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_BtnSetup().Click();
    Get_WinProductSetup_ChkProduct("Obl. convertibles", "Bonds-Convertible").set_IsChecked(false);
    Get_WinProductSetup_ChkProduct( "Obl. corporatives", "Bonds-Corporate").set_IsChecked(false);
    Get_WinProductSetup_BtnOK().Click();
    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_BtnSetup().Click();
    Get_WinServiceSetup_ChkService("Séminaires", "Seminars").set_IsChecked(false);
    Get_WinServiceSetup_ChkService("Recherches", "Research").set_IsChecked(false);
    Get_WinServiceSetup_BtnOK().Click();
    Get_WinDetailedInfo_BtnOK().Click();
    
  }
   catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }      
}
