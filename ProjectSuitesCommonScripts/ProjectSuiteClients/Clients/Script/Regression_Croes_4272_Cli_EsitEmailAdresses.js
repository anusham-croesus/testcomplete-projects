//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4272
    
   
    Description :Valider qu'il est possible d'ajouter, modifier et de supprimer des adresses courriels d'un client.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-2--V9-croesus-co7x-1_5_565
    
    Date: 01/04/2019
*/

function Regression_Croes_4272_Cli_EsitEmailAdresses()
{
  try{
  
     Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4272", "Croes-4272");
     var clientNum=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum_4272", language+client)
     var Email1=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Email1", language+client)
     var Email2=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Email2", language+client)
     
      
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

    //Valider que la section courriel est affiché
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails(),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails(),"VisibleOnScreen", cmpEqual, true)

    //Ajouter des adresses courriels
    
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.set_Email(Email1);  
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(2).DataItem.set_Email(Email2); 
    Get_WinDetailedInfo_BtnApply().Click();
    
    //Validation de l'affichage des courriels, du consentement et de la date en vigeur
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email1,10), "Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email1,10), "VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email2,10), "Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email2,10), "VisibleOnScreen", cmpEqual, true)
    
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email1,10).DataContext.DataItem, "Consent", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email2,10).DataContext.DataItem, "Consent", cmpEqual, true)
    var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d")  
//    if(language == "french")
//            {
//            var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d")
//            }
//            if(language == "english")
//            {
//              var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y")
//            }
    
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email1,10).DataContext.DataItem, "StartDate", cmpEqual, ToDay)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().Find("Value",Email2,10).DataContext.DataItem, "StartDate", cmpEqual, ToDay)

    //Supprimer la 3eme adreese courriel et valider
     Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(2).DataItem.set_Email("");
     Get_WinDetailedInfo_BtnApply().Click();
     var adressEmailDisplay2=Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(2).DataItem.Email.OleValue
     if (adressEmailDisplay2 == Email2)
      Log.Error("L'adresse émail qui est affichée.")

       else         
      Log.Checkpoint("La troixième adresse courriel est supprimée.")
      
    Get_WinDetailedInfo_BtnApply().Click();
    Delay(1500)
    Get_WinDetailedInfo_BtnOK().Click();
      
    //Rétablir la configuration par défaut
    Search_Client(clientNum);
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabAddresses().Click();
    Get_WinDetailedInfo_TabAddresses().WaitProperty("IsSelected", true, 30000);
    Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.set_Email("");
    Get_WinDetailedInfo_BtnApply().Click();
    var adressEmailDisplay1=Get_WinDetailedInfo_TabAddresses_GrpEmails_DgvEmails().WPFObject("RecordListControl", "", 1).Items.Item(1).DataItem.Email.OleValue
     if (adressEmailDisplay1 == Email1)
      Log.Error("L'adresse e-mail qui est affichée.")
      
       else         
      Log.Checkpoint("Les adresses courriels sont supprimées.")
      
    Get_WinDetailedInfo_BtnApply().Click();
    Get_WinDetailedInfo_BtnOK().Click();
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }  
}
