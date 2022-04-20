//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions




/**
    Description : Valider le fonctionnement du bouton Sommation des Comptes avec différents niveaux d'Accès
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1493
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/
 
function CR1352_1493_Acc_Validate_the_operation_of_the_Summation_button_with_different_levels_of_access()
{
    var assistantLevelUser = "DALTOJ";
    
    Login(vServerAccounts, assistantLevelUser, psw, language);
    
    Get_ModulesBar_BtnAccounts().Click();
    Get_Toolbar_BtnSum().Click();
    
    if (client == "RJ" || client == "TD"){
      
        aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 134, language));
    }
    if(client == "US"){
        aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 220, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 148, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 149, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 150, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 151, language) );
    } 
    if(client == "RJ" ){
        aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 130, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 131, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 132, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 133, language) );
    } 
    if(client == "TD"  ){
        aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 187, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 188, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 189, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 190, language) );
    } 
    
    if( client == "CIBC" ){
        aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 232, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 233, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 234, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 235, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 236, language) );
    } 
    if(client != "RJ" && client != "US" && client != "TD" && client != "CIBC") {
        aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 24, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 25, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 26, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 27, language));
        aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 28, language));
    }
    
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    Close_Croesus_SysMenu();
}