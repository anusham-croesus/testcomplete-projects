//USEUNIT Common_functions


/**
    Description : On ne peut pas supprimer une date de sortie pour un compte,
        1. Créer deux relations incluant des comptes sous-jacents avec des dates d'entrée et de sortie.
        2. Créer une relation groupée et lui assigner les deux relations créées précédemment.
        3. Ouvrir la fenêtre Info de la relation groupée ou d'une des relations appartenant à la relation groupée (onglet comptes sous-jacents) et supprimer la date de sortie d'un des comptes sous-jacents.
        Avec la version 90.04.BNC.59B-4, il est possible de supprimer la date de sortie d'un compte sous-jacent d'une relation groupée tel que requis (Un message d'avertissement s'affiche pour confirmer la suppression.)
    
    https://jira.croesus.com/browse/BNC-1912
    Auteur : Christophe Paring
*/

function BNC_1912_On_ne_peut_pas_supprimer_une_date_de_sortie_pour_un_compte()
{
    try {
        
    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
        
}