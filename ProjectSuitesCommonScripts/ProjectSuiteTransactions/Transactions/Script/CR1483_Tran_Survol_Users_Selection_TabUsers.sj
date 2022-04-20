//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1483_Tran_Common_Functions 


/**
    Module               :  Transactions
    TestLink             :  Croes-3356
    Description          :  Vérifier les libellés de la fenêtre  Travailler en tant que Onglet Utilisateurs.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  27/11/2018
    
*/


function CR1483_Cli_Survol_Users_Selection_TabUsers() 
{
         
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3356","Lien du Cas de test sur Testlink");
    
          //Appel à la fonction Commune dans CR1483_Commun_Functions
          CR1483_Survol_Users_Selection_TabUsers(vServerTransactions,Get_ModulesBar_BtnTransactions(),filePath_Transactions);
}
