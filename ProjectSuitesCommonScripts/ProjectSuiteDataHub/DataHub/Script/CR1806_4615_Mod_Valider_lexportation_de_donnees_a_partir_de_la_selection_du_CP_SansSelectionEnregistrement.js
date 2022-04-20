//USEUNIT CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_SansSelectionEnregistrement


/**
    Description : Valider l'exportation de données à partir de la sélection du CP - Sans sélection d'enregistrement
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4615
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4615_Mod_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_SansSelectionEnregistrement()
{
    Log.Message("CR1806_4615_Mod_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_SansSelectionEnregistrement()");
    CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_SansSelectionEnregistrement_PourLeModule(moduleName_Models);
}