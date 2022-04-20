//USEUNIT CR1806_4717_Valider_lexportation_des_donnees_des_rapports_MULTIPLE



/**
    Description : Valider l'exportation des données des rapports MULTIPLE
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4717
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4717_Tit_Valider_lexportation_des_donnees_des_rapports_MULTIPLE()
{
    Log.Message("CR1806_4717_Tit_Valider_lexportation_des_donnees_des_rapports_MULTIPLE()");
    CR1806_4717_Valider_lexportation_des_donnees_des_rapports_MULTIPLE_PourLeModule(moduleName_Securities);
}