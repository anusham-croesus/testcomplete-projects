//USEUNIT CR1352_CROES_6243_Acc_TestDeSelectionMultipleAvecShift_MouseWheel



/**
    Description : Vérifie dans le module Comptes que lorsqu'on sélectionne plusieurs entrées avec la combinaison du SHIFT + scroll down de la fenêtre,
                  on ne finit pas par perdre les premières entrées sélectionnées. 
    Auteur : Christophe Paring
    Scripté sur la version : ref90-05-8--V9-CX_1-co6x
*/
function CR1352_CROES_8230_Acc_TestDeSelectionMultipleAvecShift_ScrollDown()
{
    Log.Message("Bug CROES-8230");
    CR1352_CROES_6243_Acc_TestDeSelectionMultipleAvecShift("ScrollDown");
}