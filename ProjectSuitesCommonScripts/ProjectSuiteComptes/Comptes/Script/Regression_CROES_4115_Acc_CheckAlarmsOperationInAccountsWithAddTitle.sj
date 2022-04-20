//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Regression_CROES_4115_Acc_CheckAlarmsOperationInAccountsWithAddEditButton

/**
    Description : Vérifier le fonctionnement des alarmes module compte.
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4115.
    Analyste d'assurance qualité :antonb
    Analyste d'automatisation : Asma Alaoui
    Version : ref90-10-Fm-6--V9
*/

function Regression_CROES_4115_Acc_CheckAlarmsOperationInAccountsWithAddTitle()
{
  try{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4115","CROES_4115");
    var accountNo= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "accountNo", language+client);
    var highPrice=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "highPrice", language+client);
    var lowPrice=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "lowPrice", language+client);
    var symbole=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "symbole", language+client);
    var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "quantity", language+client);
    var desc=ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "descriptionTitre011130", language+client);
        
      
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

      //Cliquer sur Ajouter titre
      Get_WinAlarmsForAccount_BtnAddSecurity().Click();
   
      //Chercher la description "ALCAN ALUM PF-84-SER D  *"   
      Get_WinAddSecurityAlarmForAccount_DvgSecurity().set_Focusable(true)
      Get_WinAddSecurityAlarmForAccount_DvgSecurity().Keys(".") ; 
      Get_WinTransactionsQuickSearch_TxtSearch().set_Text(desc);     
      Get_WinTransactionsQuickSearch_RdoDescription().Click();
      Get_WinTransactionsQuickSearch_BtnOK().Click();
      Delay(5000)
      //Get_WinAddSecurityAlarmForAccount_DvgSecurity().WaitProperty("VisibleOnScreen", true, 20000);
      if ( Get_WinAddSecurityAlarmForAccount_DvgSecurity().Find("Text", desc,10).Exists == false)
          Log.Error("The description does not exist ")
      else
          Log.Checkpoint("The description was found")
          
      Get_WinAddSecurityAlarmForAccount_BtnOk().Click();   
   
      //Modifier la valeur du prix bas et haut
      Get_WinAlarmsForAccount_BtnAddEdit()
      Log.Message("Jira CROES-11229")   
      Get_winAddEditAlarmForAccount_GrpPrice_LowPrice().set_Text(lowPrice);
      Get_winAddEditAlarmForAccount_GrpPrice_HighPrice().set_Text(highPrice);

      //Remplir champ date --> saisir date 
      var date1= aqConvert.DateTimeToFormatStr(aqDateTime.AddMonths(aqDateTime.Now(), 10),"%Y/%m/%d")
      Log.Message(date1)
      Get_winAddEditAlarmForAccount_Date_ExpiryDate().set_StringValue(date1);
   
      //Cliquer sur OK
      Get_winAddEditAlarmForAccount_BtnOK().Click();
    
      //Valider l'affichage du symbole, la quantité, l'icone alarme sur la 1ere ligne de la liste
      WaitObject(Get_CroesusApp(), ["Uid","VisibleOnScreen"], ["FixedColumnListView_1b3e", true]); 
      aqObject.CheckProperty(Get_WinAlarmsForAccount().FindChild("Text", symbole, 10),"Exists", cmpEqual, true)
      aqObject.CheckProperty(Get_WinAlarmsForAccount().FindChild("Text", symbole, 10),"Visible", cmpEqual, true)
      aqObject.CheckProperty(Get_WinAlarmsForAccount().FindChild("ClrClassName", "Image", 10),"Exists", cmpEqual, true)
      aqObject.CheckProperty(Get_WinAlarmsForAccount().FindChild("ClrClassName", "Image", 10),"VisibleOnScreen", cmpEqual, true)
      aqObject.CheckProperty(Get_WinAlarmsForAccount().FindChild("WPFControlOrdinalNo", "1" , 10),"Exists", cmpEqual, true)
      aqObject.CheckProperty(Get_WinAlarmsForAccount().FindChild("Text", quantity,10),"Exists", cmpEqual, true)
         
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
