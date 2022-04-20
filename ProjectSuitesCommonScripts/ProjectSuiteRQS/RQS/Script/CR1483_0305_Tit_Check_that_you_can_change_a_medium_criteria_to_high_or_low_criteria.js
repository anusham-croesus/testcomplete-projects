//USEUNIT CR1483_0304_Tit_Check_that_you_can_change_a_high_criteria_to_medium_criteria_or_low_criteria



/**
    Description : Check that you can change a medium criteria to high or low criteria
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-305
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0305_Tit_Check_that_you_can_change_a_medium_criteria_to_high_or_low_criteria()
{
    var criterion1_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0305_criterion1_name", language + client);
    var criterion2_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0305_criterion2_name", language + client);
    var criteria_former_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0305_former_rating", language + client);
    var criteria_update_rating1 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0305_update_rating1", language + client);
    var criteria_update_rating2 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0305_update_rating2", language + client);
        
    CheckBasicCriteriaRatingUpdate([criterion1_name, criterion2_name], criteria_former_rating, [criteria_update_rating1, criteria_update_rating2]);
}