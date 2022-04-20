//USEUNIT CR1483_0300_Tit_Check_that_you_can_Activate_a_disabled_criteria



/**
    Description : Check that you can disabled an activate criteria
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-301
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0301_Tit_Check_that_you_can_disabled_an_activate_criteria()
{
    var isCriterionInitiallyEnabled = true;
    Check_that_you_can_change_the_active_status_of_a_criterion(isCriterionInitiallyEnabled);
}