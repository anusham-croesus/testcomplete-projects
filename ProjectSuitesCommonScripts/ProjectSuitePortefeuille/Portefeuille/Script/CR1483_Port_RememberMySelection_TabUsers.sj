//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1483_Common_Functions 


/**
    Module               :  Clients
    TestLink             :  Croes-3336
    Description          :  Vérifier l'option "Remember my selection" du menu Users.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  27/11/2018
    
*/


function CR1483_Cli_RememberMySelection_TabUsers() 
{
         
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3336","Lien du Cas de test sur Testlink");
    
          //Appel à la fonction Commune dans CR1483_Commun_Functions
          CR1483_RememberMySelection(vServerPortefeuille,Get_ModulesBar_BtnClients(),"Users", filePath_Clients, "Copernic");
}


