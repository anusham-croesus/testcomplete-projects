//USEUNIT CR1806_4558_Valider_les_records_dans_la_table_B_DATA_HUB


/**
    Description : Valider les records dans la table B_DATA_HUB
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4558
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4558_Acc_Valider_les_records_dans_la_table_B_DATA_HUB()
{
    Log.Message("CR1806_4558_Acc_Valider_les_records_dans_la_table_B_DATA_HUB()");
    CR1806_4558_Valider_les_records_dans_la_table_B_DATA_HUB_PourLeModule(moduleName_Accounts);
}