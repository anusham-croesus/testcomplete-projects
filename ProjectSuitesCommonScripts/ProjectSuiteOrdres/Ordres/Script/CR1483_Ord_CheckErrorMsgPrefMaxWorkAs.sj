//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1483_Ord_Common_Functions
//USEUNIT DBA
//USEUNIT Global_variables


/**
    Module               :  Orders
    CR                   :  1483
    TestLink             :  Croes-3337 (cette référence de testLink est celle du module Clients, ordres n'as pas de cas sur testLink)
    Description          :  Vérifier qu'après la modification de la pref "Pref_max_workas_elements" à une valeur et essayer de selectionner un nombre de succursales 
                            plus grand que la valeur de la pref on reçoit un message d'erreur. .
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  10/12/2018
    
*/

function CR1483_Ord_CheckErrorMsgPrefMaxWorkAs()
{
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3337","Lien du Cas de test sur Testlink équivalent à celui des autres modules, on prend Clients");
    
        //Appel à la fonction Commune dans CR1483_Commun_Functions
        CR1483_CheckErrorMsgPrefMaxWorkAs(vServerOrders ,Get_ModulesBar_BtnOrders(),"Branches",filePath_Orders,"CR1483_WinSelection_TabBranches_ErrorMsg" );    
}


