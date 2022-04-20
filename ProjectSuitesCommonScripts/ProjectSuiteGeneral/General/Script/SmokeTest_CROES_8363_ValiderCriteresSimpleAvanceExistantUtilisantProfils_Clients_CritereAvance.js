//USEUNIT SmokeTest_CROES_8363_ValiderCriteresSimpleAvanceExistantUtilisantProfils_Clients_CritereSimple





/*
    Description : Valider les critères (simple/avancé) existant dans la BD et utilisant des profils
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
    https://jira.croesus.com/browse/CROES-8363
        l`objectif est de s`assurer que leurs conditions sur les champs profils ne seront pas ignorées(CROES-8363)"
        1. Critere simple : Liste des clients(Client réel) ayant Profession différent(e) de Commis.
        2. Critere avancé : clients dont toutes ces conditions sont vraies(ET)
            Classe du client égale  Client réel
            conatct de la banque n`égale pas chrsitine
           Valeur totale(client) est plus grande que 100 000,00"
        
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_CROES_8363_ValiderCriteresSimpleAvanceExistantUtilisantProfils_Clients_CritereAvance()
{
    var searchCriteriaName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValidateCriteria_AdvancedCriteriaName", language + client);
    var isCriteriaSimple = false;
    SmokeTest_CROES_8363_ValiderCriteresSimpleAvanceExistantUtilisantProfils_Clients(searchCriteriaName, isCriteriaSimple);
}

