﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1483_Tran_Common_Functions 


/**
    Module               :  Transactions
    CR                   :  1483
    TestLink             :  Croes-3357
    Description          :  Vérifier l'option "Remember my selection" du menu Users Tab Branches.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-1
    Date                 :  26/11/2018
    
*/


function CR1483_Tran_RememberMySelection() 
{
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3357","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Tran_Commun_Functions
            CR1483_RememberMySelection(vServerTransactions,Get_ModulesBar_BtnTransactions(),"Branches", filePath_Transactions, "Toronto");
}



