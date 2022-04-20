//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Mod_Common_Functions

/**
    Module               :  Models
    TestLink             :  Croes-3365
    Description          :  Vérifier les libellés de la fenêtre  Travailler en tant que Onglet Codes de CP.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  06/12/2018
    
*/


function CR1483_Mod_Survol_Users_Selection_TabIACodes() 
{
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3365","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions
            CR1483_Survol_Users_Selection_TabIACodes(vServerModeles,Get_ModulesBar_BtnModels(),filePath_Modeles);
}
