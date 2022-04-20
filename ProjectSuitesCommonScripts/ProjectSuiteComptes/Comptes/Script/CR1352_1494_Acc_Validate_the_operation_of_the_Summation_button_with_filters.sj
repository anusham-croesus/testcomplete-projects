//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions




/**
    Description : Valider le fonctionnement du bouton Sommation des Comptes avec des filtres
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1494
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/
 
function CR1352_1494_Acc_Validate_the_operation_of_the_Summation_button_with_filters()
{
    Login(vServerAccounts, userName, psw, language);
    
    Get_ModulesBar_BtnAccounts().Click();
    
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();

    //Scroll to make appear the Total Value item
    //var height = Get_Toolbar_BtnQuickFilters_ContextMenu().get_ActualHeight();
    //for (i = 0; i <= 3; i++){      
    //    Get_Toolbar_BtnQuickFilters_ContextMenu().Click(20, height-5);
    //}
    
    Get_Toolbar_BtnQuickFilters_ContextMenu_TotalValue().Click();
    
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();
    Get_WinCreateFilter_TxtValueDouble().Keys("10000000");
    Get_WinCreateFilter_BtnApply().Click();
    
    Get_Toolbar_BtnSum().Click();
    if ( client == "US" ){
    aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 31, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 32, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 33, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 153, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 35, language));
    }
    else if ( client == "TD" ||  client == "CIBC"){
    aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 197, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 198, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 199, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 200, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 201, language));
    }
    else{
    aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 31, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 32, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 33, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 34, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 35, language));} 
    
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
    //Close the filter
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
    
    Close_Croesus_SysMenu();
}