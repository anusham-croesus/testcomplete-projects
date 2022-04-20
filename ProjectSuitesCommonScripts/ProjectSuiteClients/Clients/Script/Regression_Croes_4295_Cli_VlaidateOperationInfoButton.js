//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4295
    
   
    Description :Vérifier le fonctionnement du bouton Info Clients.
           
    Auteur : Asma Alaoui
    
    ref90-10-Fm-10--V9-croesus-co7x-1_5_1_572
    
    Date: 18/04/2019
*/


function Regression_Croes_4295_Cli_VlaidateOperationInfoButton()
{
  
try {
  Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4295", "Croes-4295");
    
      Activate_Inactivate_PrefFirm("FIRM_1", "PREF_EDIT_CLIENT", "REP", vServerClients);     
      RestartServices(vServerClients);  
  
     var clientNum800228=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum_4295", language+client);
     var date=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "date_Croes4295", language+client);
     var dateBefore=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "dateBefore", language+client);
     var gender=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "gender_Croes4295", language+client);
     var genderBefore=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "genderBefore", language+client);
     var sin=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "sin_Croes4295", language+client);
     var sinBefore=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "sinBefore", language+client);
   
  
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //Sélectionner le client 800228   
    Search_Client(clientNum800228);
    
    //Aller sur Info
    Get_ClientsBar_BtnInfo().Click();
    
    //Modifier les informations du client
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClient().Click();
    Get_SubMenus().FindChild("WPFControlText",gender , 10).Click();
    Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient().set_StringValue(date);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient().set_Text(sin);
    Get_WinDetailedInfo_BtnApply().Click();
    WaitObject(Get_WinDetailedInfo(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10);
    Get_WinDetailedInfo_BtnOK().Click();
    
    //Aller sur Info pour le même client 800228 et valider les changements des informations 
    Search_Client(clientNum800228);            
    Get_ClientsBar_BtnInfo().Click();
    WaitObject(Get_CroesusApp(), "WindowMetricTag", "CLIENT_NOTEBOOK", 2000)
    
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient(),"StringValue",cmpEqual,date)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClient(),"Text",cmpEqual, gender)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient(),"Text",cmpEqual, sin)
    
           
    //Remettre les données
    Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbGenderForClient().Click();
    Get_SubMenus().FindChild("WPFControlText",genderBefore , 10).Click();
    Get_WinDetailedInfo_TabInfo_GrpGeneral_DtpDateOfBirthForClient().set_StringValue(dateBefore);
    Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtSINForClient().set_Text(sinBefore);
    Get_WinDetailedInfo_BtnApply().Click();
    WaitObject(Get_WinDetailedInfo(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"], 10);
    Get_WinDetailedInfo_BtnOK().Click();


  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
     
  finally{
    Terminate_CroesusProcess();
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_EDIT_CLIENT", "NULL", vServerClients);     
    RestartServices(vServerClients); 
    
  }
}
