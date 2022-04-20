//USEUNIT CR1449_5434_Tit_Acces_a_la_fenetre_de_categorisation_de_titres_AccesSYSADM_PrefYES



/**
    Description : Accès à la fenêtre de catégorisation de titres - Acces FIRMADM
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5434
    Analyste d'assurance qualité : Daniel-Patrick Colas
    Analyste d'automatisation : Christophe Paring
*/

function CR1449_5434_Tit_Acces_a_la_fenetre_de_categorisation_de_titres_AccesFIRMADM()
{
    CR1449_5434_Tit_Acces_a_la_fenetre_de_categorisation_de_titres_TestNegatif("KEYNEJ", "FIRMADM", "NO");
    CR1449_5434_Tit_Acces_a_la_fenetre_de_categorisation_de_titres_TestNegatif("KEYNEJ", "FIRMADM", "YES");
}