//USEUNIT CR1352_CROES_6243_Cli_TestDeSelectionMultipleAvecShift_MouseWheel



/**
    Description : Vérifie dans le module Clients que lorsqu'on sélectionne plusieurs entrées avec la combinaison du SHIFT + scroll down de la fenêtre,
                  on ne finit pas par perdre les premières entrées sélectionnées. 
    Auteur : Christophe Paring
    Scripté sur la version : ref90-05-8--V9-CX_1-co6x
*/
function CR1352_CROES_8230_Cli_TestDeSelectionMultipleAvecShift_ScrollDown()
{
    Log.Message("Bug CROES-8230, En appuyant sur le bouton Page down le système flush sa mémoire et affiche uniquement la dernière page. C'est pourquoi l'ensemble de la liste n'est pas sélectionnée.Cette situation sera analysée et améliorée pour la grille web.");
    CR1352_CROES_6243_Cli_TestDeSelectionMultipleAvecShift("ScrollDown");
}