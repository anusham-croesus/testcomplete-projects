//USEUNIT CR1958_2_6653_6073_Validate_in_OffsideAccountReport_Display_MgmtLevel_ClientProfile


/**
    Description : Steps #5 and #6 (Management Level = Individual). Validate if the Plugin and the new column added in Offside Account Report Client Relationship number,Client Relationship Name,Management level)
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6653
    Steps #5 and #6 (Management Level = Individual)
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-10--V9-croesus-co7x-1_8_2_653
*/

function CR1958_2_6653_6073_Validate_in_OffsideAccountReport_Display_MgmtLevel_Individual()
{
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6653", "Croes-6653 Steps #5 and #6 - Client Profile : Validate display in Reports Offside grid --> CR1958_2_6653_6073_Validate_in_OffsideAccountReport_Display_MgmtLevel_Individual()");
    
    var managementLevel         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_Label_ManagementLevel_Individual", language + client);
    var clientNumber            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_Individual_ClientNumber", language + client);
    var clientInvRiskLow        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_Individual_ClientKYC_InvRiskLow", language + client);
    var clientInvRiskMed        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_Individual_ClientKYC_InvRiskMed", language + client);
    var clientInvRiskHigh       = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_Individual_ClientKYC_InvRiskHigh", language + client);
    var relationshipNumber      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_Individual_RelationshipNumber", language + client);
    var relationshipShortName   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_Individual_RelationshipShortName", language + client);
    var clientRelationshipName  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "CR1958_2_6653_6073_Display_MgmtLevel_Individual_ClientRelationshipName", language + client);
    var clientNumberInOffsideReports = clientNumber;
    
    CR1958_2_6653_6073_Validate_in_OffsideAccountReport_Display(managementLevel, clientNumber, clientInvRiskLow, clientInvRiskMed, clientInvRiskHigh, relationshipNumber, relationshipShortName, clientRelationshipName, clientNumberInOffsideReports);
}
