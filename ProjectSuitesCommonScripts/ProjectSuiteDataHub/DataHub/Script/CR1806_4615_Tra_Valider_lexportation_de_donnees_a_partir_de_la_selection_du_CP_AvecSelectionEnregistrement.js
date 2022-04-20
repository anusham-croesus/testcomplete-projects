//USEUNIT CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_AvecSelectionEnregistrement


/**
    Description : Valider l'exportation de données à partir de la sélection du CP - Avec sélection d'enregistrement
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4615
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4615_Tra_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_AvecSelectionEnregistrement()
{
    Log.Message("CR1806_4615_Tra_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_AvecSelectionEnregistrement()");
    CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_AvecSelectionEnregistrement_PourLeModule(moduleName_Transactions);
}