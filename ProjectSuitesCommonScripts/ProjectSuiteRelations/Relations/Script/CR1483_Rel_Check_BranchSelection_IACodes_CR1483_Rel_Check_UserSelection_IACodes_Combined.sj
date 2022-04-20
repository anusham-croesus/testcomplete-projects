//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Common_Functions


/**
    Module                  :  Relationships
    CR                      :  1483
    TestLink                :  Croes-3361
    Combinaison des scripts : CR1483_Rel_Check_UserSelection_IACodes et CR1483_Rel_Check_BranchSelection_IACodes
    Description             : Vérifier que si on selectionne une succursale seulement les codes de CP de cette dernière sont affichés dans la grille client.
                              Vérifier que si on selectionne un utilisateur seulement les codes de CP de ce dernier sont affichés après ajout d'un client.
    Auteur                  : Alhassane Diallo
    Version de scriptage    : 2020.09-36
    Date                    : 16/10/2020
    
*/


function CR1483_Rel_Check_BranchSelection_IACodes_CR1483_Rel_Check_UserSelection_IACodes_Combined() 
{
          var logEtape1, logEtape2
          
           Log.PopLogFolder();
           logEtape1 = Log.AppendFolder(" 1er Cas de test : CR1483_Rel_Check_BranchSelection_IACodes");
          
          
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3361","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions
            CR1483_Check_BranchSelection_IACodes(vServerRelations,Get_ModulesBar_BtnRelationships(),"Toronto");
            
            
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("2 eme Cas de test : Cas de test CR1483_Rel_Check_UserSelection_IACodes");
            
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3361","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions         
            CR1483_Check_UserSelection_IACodes(vServerRelations,Get_ModulesBar_BtnRelationships(),"Copernic","BD88", "0AED");
}
