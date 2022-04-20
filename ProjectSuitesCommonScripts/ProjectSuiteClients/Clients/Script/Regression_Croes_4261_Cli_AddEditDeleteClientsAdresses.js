//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4261
    
   
    Description :Valider qu'il est possible d'ajouter, modifier et de supprimer des adresses de clients.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-2--V9-croesus-co7x-1_5_565
    
    Date: 27/30/2019
*/

function Regression_Croes_4261_Cli_AddEditDeleteClientsAdresses()
{

  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4261", "Croes-4261");  
    
    var clientNum=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum_4261", language+client);
    var street1=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "street1", language+client);
    var street2=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "street2", language+client);
    var country=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "country", language+client);
    var type=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "typeAdress", language+client);
    
    
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //Sélectionner le client 800241    
    Search_Client(clientNum);
    
    //Aller sur Info et sélectionner Adresse    
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);

    //Ajouter une adresse
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
    Get_WinCRUAddress_CmbType().set_SelectedIndex(2);//Bureau
    Get_WinCRUAddress_TxtStreet1().Keys(street1);
    Get_WinCRUAddress_TxtStreet2().Keys(street2);
    Get_WinCRUAddress_BtnOK().Click();
    WaitObject(Get_CroesusApp(), ["WPFControlText","VisibleOnScreen"], ["ALARY ANNY: 800241", true]); 
    
    //Valider l'affichage de la nouvlle adresse
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1(),"Text", cmpEqual, street1)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet1(),"VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(),"Text", cmpEqual, street2)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtStreet2(),"VisibleOnScreen", cmpEqual, true)

    //modifier l'adresse: ajouter le pays Canada
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnEdit().Click();
    Get_WinCRUAddress_CmbType().set_SelectedIndex(2);
    Get_WinCRUAddress_TxtCountry().Keys(country);
    Get_WinCRUAddress_BtnOK().Click();
    WaitObject(Get_CroesusApp(), ["WPFControlText","VisibleOnScreen"], ["ALARY ANNY: 800241", true]);
    
    //valider la modification
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCountry(),"Text", cmpEqual, country)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCountry(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpAddresses_TxtCountry(),"VisibleOnScreen", cmpEqual, true)
    
    //Supprimer l'adresse 
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType().Click();
    Get_SubMenus().FindChild("WPFControlText", type, 10).Click();
    Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnDelete().Click();
    Get_DlgConfirmation_BtnRemove().Click();
    
    //Valider la suppression
   Get_WinDetailedInfo_TabAddresses_GrpAddresses_CmbType().Click();
    if ( (Get_SubMenus().FindChild("WPFControlText", type, 10).Exists== true) && (Get_SubMenus().FindChild("WPFControlText", "Bureau", 10).VisibleOnScreen== true))
     Log.Error("L'adresse " +type+" n'est pas supprimé")
      else 
     Log.Checkpoint("L'adresse "+type+" est supprimé")

  }  
   catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }   
}     
     