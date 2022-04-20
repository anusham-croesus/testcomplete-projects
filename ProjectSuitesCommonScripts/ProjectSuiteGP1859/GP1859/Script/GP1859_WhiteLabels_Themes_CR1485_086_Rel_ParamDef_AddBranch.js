//USEUNIT GP1859_CR1485_086_Rel_ParamDef_AddBranch



/**
    Description : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\86. HISTORIQUE DU RENDEMENT\1. Relations\
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-12-Hf-62--V9-croesus-co7x-1_8_2_653
*/

function GP1859_WhiteLabels_Themes_CR1485_086_Rel_ParamDef_AddBranch()
{
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\86. HISTORIQUE DU RENDEMENT\\1. Relations\\", "GP1859_WhiteLabels_Themes_CR1485_086_Rel_ParamDef_AddBranch()");
    Log.Link("https://jira.croesus.com/browse/QAS-55", "Prérequis : GP1859_PreparationBD_WhiteLabels_Themes()");
    GP1859_CR1485_086_Rel_ParamDef_AddBranch.GP1859_CR1485_086_Rel_ParamDef_AddBranch(GP1859_WHITELABELS_THEMES_ID);
}
