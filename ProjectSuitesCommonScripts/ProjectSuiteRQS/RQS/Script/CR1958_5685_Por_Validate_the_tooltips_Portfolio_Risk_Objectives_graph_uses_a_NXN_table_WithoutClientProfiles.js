//USEUNIT CR1958_5685_Por_Validate_the_tooltips_Portfolio_Risk_Objectives_graph_uses_a_NXN_table_WithClientProfiles




/**
    Description : Validate the tooltips Portfolio Risk Objectives graph in portfolio Module uses a NXN table
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5685
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5685_Por_Validate_the_tooltips_Portfolio_Risk_Objectives_graph_uses_a_NXN_table_WithoutClientProfiles()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5685", "CR1958_5685_Por_Validate_the_tooltips_Portfolio_Risk_Objectives_graph_uses_a_NXN_table_WithoutClientProfiles()");
    
    var expectedRiskObjectivesGraphTitle = CR1958_GRAPH_TITLE_RISKALLOCATION;
    var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5685_WithoutClientProfiles_CheckTrianglesDisplayInGraph", language + client));
    CR1958_5685_Por_Validate_the_tooltips_Portfolio_Risk_Objectives_graph_uses_a_NXN_table(false, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);

}
