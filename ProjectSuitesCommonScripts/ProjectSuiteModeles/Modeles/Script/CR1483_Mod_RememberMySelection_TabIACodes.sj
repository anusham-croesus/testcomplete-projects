//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Mod_Common_Functions


/**
    Module               :  Models
    TestLink             :  Croes-3366
    Description          :  Vérifier l'option "Remember my selection" du menu Users.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  06/12/2018
    
*/


function CR1483_Mod_RememberMySelection_TabIACodes() 
{
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3366","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions
            CR1483_RememberMySelection(vServerModeles,Get_ModulesBar_BtnModels(),"IACodes", filePath_Modeles, "BD88", "_FRM");
}