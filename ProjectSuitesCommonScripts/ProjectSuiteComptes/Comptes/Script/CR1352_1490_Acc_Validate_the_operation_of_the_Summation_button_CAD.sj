//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Valider le fonctionnement du bouton Sommation des Comptes_Scénario
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6882
    
    Analyste d'assurance qualité : Karima M.
    Analyste d'automatisation : Amine A.
*/
 
function CR1352_1490_Acc_Validate_the_operation_of_the_Summation_button()
{
  
          try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1244");
         
          userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
          userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
          passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
         
          //Les variables
          var accountNumber = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_AccountNumber", language+client);
          var clientNumber  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_ClientNumber",  language+client);
          
         var creditBalanceCAD = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_CreditBalanceCAD", language+client);
         var creditBalanceUSD = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_CreditBalanceUSD", language+client);
         
         var debitBalanceCAD  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_DebitBalanceCAD",  language+client);
         var debitBalanceUSD  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_DebitBalanceUSD",  language+client);
         
         var totalBalanceCAD  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_TotalBalanceCAD",  language+client);
         var totalBalanceUSD  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_TotalBalanceUSD",  language+client);
         
         var accountTotalValueCAD  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_AccountTotalValueCAD",  language+client);
         var accountTotalValueUSD  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_AccountTotalValueUSD",  language+client);
         
         var numberOfAccountsCAD  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_NumberOfAccountsCAD",  language+client);
         var numberOfAccountsUSD  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_NumberOfAccountsUSD",  language+client);
         
         var creditBalanceTotalCAD     = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_CreditBalanceTotalCAD",     language+client);
         var debitBalanceTotalCAD      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_DebitBalanceTotalCAD",      language+client);
         var totalBalanceTotalCAD      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_TotalBalanceTotalCAD",      language+client);
         var accountTotalValueTotalCAD = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_AccountTotalValueTotalCAD", language+client);         
         var numberOfAccountsTotalCAD  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_NumberOfAccountsTotalCAD",  language+client);
         
         var creditBalanceCAD_GreaderThan     = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_CreditBalanceCAD_GreaderThan", language+client);
         var debitBalanceCAD_GreaderThan      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_DebitBalanceCAD_GreaderThan",  language+client);
         var totalBalanceCAD_GreaderThan      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_TotalBalanceCAD_GreaderThan",  language+client);
         var accountTotalValueCAD_GreaderThan = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_AccountTotalValueCAD_GreaderThan",  language+client);
         var numberOfAccountsCAD_GreaderThan  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_NumberOfAccountsCAD_GreaderThan",  language+client);
         
         var creditBalanceCAD_Reagar     = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_CreditBalanceCAD_Reagar", language+client);
         var debitBalanceCAD_Reagar      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_DebitBalanceCAD_Reagar",  language+client);
         var totalBalanceCAD_Reagar      = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_TotalBalanceCAD_Reagar",  language+client);
         var accountTotalValueCAD_Reagar = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_AccountTotalValueCAD_Reagar",  language+client);
         var numberOfAccountsCAD_Reagar  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_NumberOfAccountsCAD_Reagar",  language+client);
         
         var isGreaterThan  = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_IsGreaterThan",  language+client);
         var tenMillions    = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1352.2", "1490_tenMillions",  language+client);

          //Se loguer avec Keynej
          Login(vServerAccounts, userNameKEYNEJ, passwordKEYNEJ, language);

          //Aller au modules 'Accounts' et séléctionner le compte 800302-OB
          Get_ModulesBar_BtnAccounts().Click();        
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
          SearchAccount(accountNumber); 
          Get_RelationshipsClientsAccountsGrid().Find("Value",accountNumber,10).Click();
          
          //Ouvrir la fenêtre Sommation
          Get_Toolbar_BtnSum().Click();
          
          //Solde créditeur/ Credit Balance
          aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceCAD(2), "WPFControlText", cmpEqual, creditBalanceCAD);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceUSD(), "WPFControlText", cmpEqual, creditBalanceUSD);
          
          //Solde débiteur/ Debit Balance
          aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceCAD(2), "WPFControlText", cmpEqual, debitBalanceCAD);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceUSD(), "WPFControlText", cmpEqual, debitBalanceUSD);
          
          //Solde Total / Total Balance
          aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceCAD(2), "WPFControlText", cmpEqual, totalBalanceCAD);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceUSD(), "WPFControlText", cmpEqual, totalBalanceUSD);
          
          //Valeur totale des comptes / Accounts Total Value
          aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueCAD(2), "WPFControlText", cmpEqual, accountTotalValueCAD);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueUSD(), "WPFControlText", cmpEqual, accountTotalValueUSD);
          
          //Nombre de comptes / Number of Accounts
          aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsCAD(2), "WPFControlText", cmpEqual, numberOfAccountsCAD);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsUSD(), "WPFControlText", cmpEqual, numberOfAccountsUSD);
          
          //Fermer Sommation
          Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
          //Sélectionner les 7 comptes de "BEAUCH RAYMOND" (Client:800238) et cliquer le bouton Sommation
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          Get_Toolbar_BtnQuickFilters_ContextMenu_ClientNo().Click();
          Get_WinCreateFilter_TxtValue().Keys(clientNumber);
          Get_WinCreateFilter_BtnApply().Click();
          
          Get_RelationshipsClientsAccountsGrid().Keys("^a");
          Get_Toolbar_BtnSum().Click();
          
          //Valider les champs
          aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(),      "WPFControlText", cmpEqual, creditBalanceTotalCAD);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(),       "WPFControlText", cmpEqual, debitBalanceTotalCAD);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(),       "WPFControlText", cmpEqual, totalBalanceTotalCAD);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText", cmpEqual, accountTotalValueTotalCAD);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(),   "WPFControlText", cmpEqual, numberOfAccountsTotalCAD);
          
          //Fermer Sommation
          Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
          
          //Enlever le filtre appliqué
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
          
          //Appliquer le filtre "valeur totale > 10 000 000"
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          Get_Toolbar_BtnQuickFilters_ContextMenu_TotalValue().Click();
          Get_WinCreateFilter_CmbOperator().Click();
          Get_SubMenus().FindChild("WPFControlText", isGreaterThan, 10).Click();          
          Get_WinCreateFilter_TxtValueDouble().Keys(tenMillions);
          Get_WinCreateFilter_BtnApply().Click();
          
          //Ouvrir la fenêtre Sommation
          Get_Toolbar_BtnSum().Click();
          
          //Valider les champs
          aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceCAD(1),      "WPFControlText", cmpEqual, creditBalanceCAD_GreaderThan);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceCAD(1),       "WPFControlText", cmpEqual, debitBalanceCAD_GreaderThan);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceCAD(1),       "WPFControlText", cmpEqual, totalBalanceCAD_GreaderThan);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueCAD(1), "WPFControlText", cmpEqual, accountTotalValueCAD_GreaderThan);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsCAD(1),   "WPFControlText", cmpEqual, numberOfAccountsCAD_GreaderThan);
          
          //Fermer Sommation
          Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
          
          //Fermer Croesus
          Terminate_CroesusProcess();
          
          //Se loguer avec REAGAR
          Login(vServerAccounts, userNameREAGAR, passwordREAGAR, language);
          
          //Aller au modules 'Accounts' 
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
          
          //Ouvrir la fenêtre Sommation
          Get_Toolbar_BtnSum().Click();
                    
          //Valider les champs
          aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(),      "WPFControlText", cmpEqual, creditBalanceCAD_Reagar);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(),       "WPFControlText", cmpEqual, debitBalanceCAD_Reagar);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(),       "WPFControlText", cmpEqual, totalBalanceCAD_Reagar);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText", cmpEqual, accountTotalValueCAD_Reagar);
          aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(),   "WPFControlText", cmpEqual, numberOfAccountsCAD_Reagar);
           
          //Fermer Sommation
          Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
          
          //Fermer Croesus
          Close_Croesus_SysMenu();  
        }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));        
    }
    finally {  
        Terminate_CroesusProcess(); 
    }
}         

function Get_WinAccountsSum_TxtCreditBalanceCAD(i){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "2"], 10)}          

function Get_WinAccountsSum_TxtDebitBalanceCAD(i){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "3"], 10)}

function Get_WinAccountsSum_TxtTotalBalanceCAD(i){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "4"], 10)}

function Get_WinAccountsSum_TxtAccountsTotalValueCAD(i){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "6"], 10)}

function Get_WinAccountsSum_TxtNumberOfAccountsCAD(i){return Get_WinRelationshipsClientsAccountsSum().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "7"], 10)}
