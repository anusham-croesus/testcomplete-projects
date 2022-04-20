//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA
//USEUNIT CR1483_0446_Tit_Check_if_the_Name_column_contains_the_criterion_Name_BasicCriteria



/**
    Description : Check if the Name column contains the criterion Name (for Overwrite Criteria)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-446
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0446_Tit_Check_if_the_Name_column_contains_the_criterion_Name_OverwriteCriteria()
{
    CR1483_0446_Tit_Check_if_the_Name_column_contains_the_criterion_Name("overwrite");
}