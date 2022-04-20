//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions




/**
    Description : Valider le fonctionnement du bouton Sommation des Comptes USD
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1491
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/
 
function CR1352_1491_Acc_Validate_the_operation_of_the_Summation_button_USD()
{
    Login(vServerAccounts, userName, psw, language);
    
    Get_ModulesBar_BtnAccounts().Click();
    Get_Toolbar_BtnSum().Click();
    
    if (client == "US"){
        aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 212, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 124, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 214, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 216, language)); }
        
    if (client == "RJ" ){
        aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 204, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 205, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 206, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 208, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 207, language));}
        
    if (client == "US" ){
      aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 140, language));} 
    
      
    if ( client !="US" && client !="RJ"&& client !="TD" && client !="CIBC") {
        aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 10, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 11, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 12, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 13, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 14, language));
    }
    if(client == "TD"){
        aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 179, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 180, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 181, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 182, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 183, language));
    }
    if(client == "CIBC" ){
        aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 184, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 180, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 185, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 177, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsUSD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 183, language));
    }
        
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    Close_Croesus_SysMenu();
}