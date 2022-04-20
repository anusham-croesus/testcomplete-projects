//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/**
    Description : Vérifier le fonctionnement des alarmes du compte.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4115.
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version : ref90-10-Fm-6--V9
*/

function Regression_CROES_4115_Acc_CheckAlarmsOperationInAccountsWithAddEditButton()
{
   try{
     Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4115","CROES_4115");
     var accountNo= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo", language+client);
     var highPrice=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "highPrice", language+client);
     var lowPrice=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "lowPrice", language+client);
     var desc=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "decripBCE", language+client);
          
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    
    //chercher le compte "30001-NA"
    SelectAccounts(accountNo);
        
   //Accès à la fenêtre Alarme
   Get_AccountsBar_BtnAlarms().Click();
   Get_WinAlarmsForAccount_DgvAlarms().Click();
   
   // Chercher le symbole "BCE"
   aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms(),"Exists",cmpEqual, true);
   aqObject.CheckProperty(Get_WinAlarmsForAccount_DgvAlarms(),"Visible",cmpEqual, true);
   Get_WinAlarmsForAccount_DgvAlarms().Find("Text", desc,10).Click();
 
  //Cliquer sur Ajouter/Modifier
   Log.Message("Jira CROES-11229")
   Get_WinAlarmsForAccount_BtnAddEdit().Click();  
    
   //Modifier la valeur du prix bas et haut   
    Get_winAddEditAlarmForAccount_GrpPrice_LowPrice().set_Text(lowPrice);
     
    Get_winAddEditAlarmForAccount_GrpPrice_HighPrice().set_Text(highPrice);
     
   //Remplir champ date --> saisir date 
    var date1= aqConvert.DateTimeToFormatStr(aqDateTime.AddMonths(aqDateTime.Now(), 10),"%Y/%m/%d")
    Log.Message(date1)
   Get_winAddEditAlarmForAccount_Date_ExpiryDate().set_StringValue(date1);
   
    //Cliquer sur OK
    Get_winAddEditAlarmForAccount_BtnOK().Click();
    
    //Valider l'affichage du symbole BCE et l'icone alarme sont sur la première ligne
    
    aqObject.CheckProperty(Get_WinAlarmsForAccount().FindChild("Text", desc, 10),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinAlarmsForAccount().FindChild("ClrClassName", "Image", 10),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinAlarmsForAccount().FindChild("ClrClassName", "Image", 10),"VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinAlarmsForAccount().FindChild("WPFControlOrdinalNo", "1", 10),"Exists", cmpEqual, true)

   
   Get_WinAlarmsForAccount_BtnOK().Click();  
    }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
  finally {
    Terminate_CroesusProcess();
    Log.Message("Delete Alram ");
    Login(vServerAccounts, userName, psw, language);
    DeleteAlarm(accountNo, desc);
    Terminate_CroesusProcess();
    }
}

function DeleteAlarm(accountNo, desc)
{
    Get_ModulesBar_BtnAccounts().Click();    
    SelectAccounts(accountNo);
    Get_AccountsBar_BtnAlarms().Click();
    var searchSymbol = Get_WinAlarmsForAccount_DgvAlarms().Find("Text", desc, 10);
    var searchIcon = Get_WinAlarmsForAccount().Find("ClrClassName", "Image",10);
    if (searchSymbol.Exists && searchIcon.Exists){
    Get_WinAlarmsForAccount_DgvAlarms().Find("Text", desc,10).Click(); 
    Get_WinAlarmsForAccount_BtnDelete().Click();
    WaitObject(Get_CroesusApp(),["ClrClassName","Confirmation"],["BaseWindow","Confirmation"]);
     if (Get_DlgConfirmation().Exists == true )  
       Get_DlgConfirmation_BtnRemove().Click();
            
    Get_WinAlarmsForAccount_BtnOK().Click();  
            
    Log.Checkpoint("The alarm was delete") 
    }
      else{
    Log.Message("The symbol or alarm does not exist.");
    }
}

