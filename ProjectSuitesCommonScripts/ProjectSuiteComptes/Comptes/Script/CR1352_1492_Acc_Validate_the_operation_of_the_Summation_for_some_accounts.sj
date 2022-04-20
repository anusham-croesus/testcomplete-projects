//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Valider le fonctionnement du bouton Sommation de quelques Comptes
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1492
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/
 
function CR1352_1492_Acc_Validate_the_operation_of_the_Summation_for_some_accounts()
{
    var clientName = "BEAUCH RAYMOND";
    
    Login(vServerAccounts, userName, psw, language);
    Get_ModulesBar_BtnAccounts().Click();
    
    var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Count;
    for (var i = 0; i < count; i++){
        if (Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_Name() == clientName){
            Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true);
        }
    }
    
    Get_Toolbar_BtnSum().Click();
    
    if (client == "US"){
    aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 142, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 143, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 144, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 145, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 146, language));
    } 
    else{
    aqObject.CheckProperty(Get_WinAccountsSum_TxtCreditBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 17, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtDebitBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 18, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtTotalBalanceTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 19, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtAccountsTotalValueTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 20, language));
    aqObject.CheckProperty(Get_WinAccountsSum_TxtNumberOfAccountsTotalCAD(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 21, language));}
    
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    Close_Croesus_SysMenu();
}