//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Ord_Common_Functions


/**
    Module               :  Orders
    TestLink             :  Croes-3335 (cette référence de testLink est celle du module Clients, ordres n'as pas de cas sur testLink)
    Description          :  Vérifier les libellés de la fenêtre  Travailler en tant que Onglet Codes de CP.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  28/11/2018
    
*/


function CR1483_Ord_Survol_Users_Selection_TabIACodes() 
{
          
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3335","Lien du Cas de test sur Testlink équivalent à celui des autres modules, on prend Clients");
    
          //Appel à la fonction Commune dans CR1483_Commun_Functions
          CR1483_Survol_Users_Selection_TabIACodes(vServerOrders,Get_ModulesBar_BtnOrders(),filePath_Orders );
}

