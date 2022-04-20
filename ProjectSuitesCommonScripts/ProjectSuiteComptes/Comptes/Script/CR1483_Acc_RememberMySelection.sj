//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Acc_Common_Functions


/**
    Module               :  Accounts
    CR                   :  1483
    TestLink             :  Croes-3348
    Description          :  Vérifier l'option "Remember my selection" du menu Users.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  26/11/2018
    
*/


function CR1483_Acc_RememberMySelection() 
{
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3348","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions
            CR1483_RememberMySelection(vServerAccounts,Get_ModulesBar_BtnAccounts(),"Branches", filePath_Accounts, "Toronto");
}




