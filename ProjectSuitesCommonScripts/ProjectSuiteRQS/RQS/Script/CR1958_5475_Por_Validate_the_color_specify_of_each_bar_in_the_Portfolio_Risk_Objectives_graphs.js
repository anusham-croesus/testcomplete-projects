//USEUNIT CR1958_5477_Por_Validate_the_color_specify_of_each_bar_in_the_Portfolio_Risk_Objectives_graphs



/**
    Description : Validate the color specify of each bar in the Portfolio Risk Objectives graphs
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5475
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/

function CR1958_5475_Por_Validate_the_color_specify_of_each_bar_in_the_Portfolio_Risk_Objectives_graphs()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5475", "CR1958_5475_Por_Validate_the_color_specify_of_each_bar_in_the_Portfolio_Risk_Objectives_graphs()");
    Log.Message("Bug JIRA CROES-11305 : L'application Croesus ferme lorsqu'on click sur l'onglet sommaire dans le module modèles.");
    Log.Message("Bug JIRA CROES-11351 : L'application crash si la  PREF_ENABLE_RISK_SCORE_GRAPH est disactivée");
    
    var clientIACode = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5475_IACode", language + client);
    var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5475_ClientNumber", language + client);
    var expectedClientPortfolioName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5475_PortFolio_DisplayedName", language + client);
    var expectedRiskObjectivesGraphTitle = (client == "CIBC")? CR1958_GRAPH_TITLE_RISKOBJECTIVES: CR1958_GRAPH_TITLE_RISKALLOCATION;
    var checkObjectiveTriangleDisplay = GetBooleanValue(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958", "CR1958_5475_CheckTrianglesDisplayInGraph", language + client));
    
    Validate_the_color_specify_of_each_bar_in_the_Portfolio_Risk_Objectives_graphs(clientIACode, clientNumber, expectedClientPortfolioName, expectedRiskObjectivesGraphTitle, checkObjectiveTriangleDisplay, false);
}