//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Ord_Common_Functions


/**
    Module               :  Orders
    TestLink             :  Croes-3337 (cette référence de testLink est celle du module Clients, ordres n'as pas de cas sur testLink)
    Description          :  Vérifier qu'après la modification de la pref "Pref_max_workas_elements" à une valeur et essayer de selectionner un nombre de codes de CP 
                            plus grand que la valeur de la pref on reçoit un message d'erreur. .
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  10/12/2018
    
*/


function CR1483_Ord_CheckErrorMsgPrefMaxWorkAs_TabIACodes() 
{
         
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3337","Lien du Cas de test sur Testlink équivalent à celui des autres modules, on prend Clients");
    
        //Appel à la fonction Commune dans CR1483_Common_Functions
        CR1483_CheckErrorMsgPrefMaxWorkAs(vServerOrders ,Get_ModulesBar_BtnOrders(),"IACodes",filePath_Orders,"CR1483_WinSelection_TabIACodes_ErrorMsg" );    
}