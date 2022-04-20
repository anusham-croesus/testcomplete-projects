//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Dash_Common_Functions


/**
    Module               :  Dashboard
    TestLink             :  Croes-3333
    Description          :  Vérifier l'option "Remember my selection" du menu Users.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  29/11/2018
    
*/


function CR1483_Dash_RememberMySelection_TabUsers() 
{
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3333","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions
            CR1483_RememberMySelection(vServerDashboard,Get_ModulesBar_BtnDashboard(),"Users", filePath_Dashboard, "Copernic");
}


