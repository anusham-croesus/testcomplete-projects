//USEUNIT CR1958_5474_Por_Validate_the_information_displayed_on_the_Portfolio_Risk_Objectives_graph_in_Portfolio_Module_WithClientProfiles




/**
    Description : Validate the information displayed on the Portfolio Risk Objectives graph in Portfolio Module
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5474
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5474_Por_Validate_the_information_displayed_on_the_Portfolio_Risk_Objectives_graph_in_Portfolio_Module_WithoutClientProfiles()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5474", "CR1958_5474_Por_Validate_the_information_displayed_on_the_Portfolio_Risk_Objectives_graph_in_Portfolio_Module_WithoutClientProfiles()");
    var expectedRiskObjectivesGraphTitle = CR1958_GRAPH_TITLE_RISKALLOCATION;
    var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5474_WithoutClientProfiles_CheckTrianglesDisplayInGraph", language + client));
    CR1958_5474_Por_Validate_the_information_displayed_on_the_Portfolio_Risk_Objectives_graph_in_Portfolio_Module(false, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay);
}
