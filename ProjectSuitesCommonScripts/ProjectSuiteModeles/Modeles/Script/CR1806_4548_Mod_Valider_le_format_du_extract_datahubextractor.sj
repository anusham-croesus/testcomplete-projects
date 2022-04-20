//USEUNIT CR1806_4548_Valider_le_format_du_extract_datahubextractor


/**
    Description : Valider le format du extract -datahubextractor
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4548
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4548_Mod_Valider_le_format_du_extract_datahubextractor()
{
    Log.Message("CR1806_4548_Mod_Valider_le_format_du_extract_datahubextractor()");
    CR1806_4548_Valider_le_format_du_extract_datahubextractor_PourLeModule(moduleName_Models);
}