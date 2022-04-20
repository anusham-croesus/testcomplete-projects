﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Acc_Common_Functions


/**
    Module               :  Accounts
    CR                   :  1483
    TestLink             :  Croes-3349
    Description          :  Vérifier que si on selectionne une succursale seulement les codes de CP de cette dernière sont affichés dans la grille client.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  29/11/2018
    
*/


function CR1483_Acc_Check_BranchSelection_IACodes() {
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3349","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions
            CR1483_Check_BranchSelection_IACodes(vServerAccounts,Get_ModulesBar_BtnAccounts(),"Toronto");
            
            
            
}
