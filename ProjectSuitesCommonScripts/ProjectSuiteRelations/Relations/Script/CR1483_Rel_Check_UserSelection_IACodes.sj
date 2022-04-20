//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Common_Functions


/**
    Module               :  Relations
    CR                   :  1483
    TestLink             :  3361
    Description          :  Vérifier que si on selectionne un utilisateur seulement les codes de CP de ce dernier sont affichés après ajout d'un client.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  03/12/2018
    
*/


function CR1483_Rel_Check_UserSelection_IACodes() 
{

         //lien pour TestLink
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3361","Lien du Cas de test sur Testlink");
    
         //Appel à la fonction Commune dans CR1483_Commun_Functions         
         CR1483_Check_UserSelection_IACodes(vServerRelations,Get_ModulesBar_BtnRelationships(),"Copernic","BD88", "0AED");
}
