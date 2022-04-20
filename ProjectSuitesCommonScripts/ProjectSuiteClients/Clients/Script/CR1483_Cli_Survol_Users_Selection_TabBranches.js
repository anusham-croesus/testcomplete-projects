//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Common_Functions


/**
    Module               :  Clients
    CR                   :  1483
    TestLink             :  Croes-3335
    Description          :  Vérifier les libellés de la fenêtre  Travailler en tant que.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  26/11/2018
    
*/


function CR1483_Cli_Survol_Users_Selection_TabBranches() 
{
          
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3335","Lien du Cas de test sur Testlink");
    
          //Appel à la fonction Commune dans CR1483_Commun_Functions
          CR1483_Survol_Users_Selection_TabBranches(vServerClients,Get_ModulesBar_BtnClients(), filePath_Clients);
}

