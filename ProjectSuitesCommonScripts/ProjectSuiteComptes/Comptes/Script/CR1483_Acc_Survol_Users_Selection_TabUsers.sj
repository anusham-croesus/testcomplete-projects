﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Acc_Common_Functions


/**
    Module               :  Accounts
    TestLink             :  Croes-3347
    Description          :  Vérifier les libellés de la fenêtre  Travailler en tant que Onglet Utilisateurs.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  29/11/2018
    
*/


function CR1483_Acc_Survol_Users_Selection_TabUsers() 
{
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3347","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions
            CR1483_Survol_Users_Selection_TabUsers(vServerAccounts,Get_ModulesBar_BtnAccounts(),filePath_Accounts);
}

