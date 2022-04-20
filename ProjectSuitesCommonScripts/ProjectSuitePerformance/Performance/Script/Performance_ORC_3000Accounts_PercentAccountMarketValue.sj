//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT Performance_ORC_Common_functions


/**
    Description : 
    https://docs.google.com/spreadsheets/d/1rn-P_6hBwQIkSDSNih_H71u_j1eVNnH6/edit#gid=1560668979
    Analyste d'assurance qualité : 
    Analyste d'automatisation : Abdelm
    Version: 2020.09.87-24 (environnement NFR)
    Date: 2020-02-16
*/

function Performance_ORC_3000Accounts_PercentAccountMarketValue()
{
        var cmbTransactionAccountMarketValue = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "cmbTransactionAccountMarketValue", language+client);        
        var SoughtForValueAccountMarketValue = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "SoughtForValueAccountMarketValue", language+client);        
        
        Performance_ORC_3000Accounts(cmbTransactionAccountMarketValue, SoughtForValueAccountMarketValue)
        
}
