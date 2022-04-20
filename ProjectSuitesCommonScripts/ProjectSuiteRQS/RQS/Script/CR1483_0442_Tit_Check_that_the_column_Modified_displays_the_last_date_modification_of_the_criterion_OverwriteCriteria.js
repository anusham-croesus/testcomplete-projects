//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA
//USEUNIT CR1483_0442_Tit_Check_that_the_column_Modified_displays_the_last_date_modification_of_the_criterion_BasicCriteria



/**
    Description : Check that the column "Modified" displays the last date modification of the criterion (for Overwrite Criteria).
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-442
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0442_Tit_Check_that_the_column_Modified_displays_the_last_date_modification_of_the_criterion_OverwriteCriteria()
{
    var overwriteCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereUSD", language + client);
    var overwriteCriterionUpdatedName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0442_Criterion2", language + client);
    CR1483_0442_Tit_Check_that_the_column_Modified_displays_the_last_date_modification_of_the_criterion(overwriteCriterionName, overwriteCriterionUpdatedName, "overwrite");
}