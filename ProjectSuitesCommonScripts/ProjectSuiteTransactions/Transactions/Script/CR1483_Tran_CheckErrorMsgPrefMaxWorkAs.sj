//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Tran_Common_Functions

/**
    Module               :  Transactions
    CR                   :  1483
    TestLink             :  Croes-3358
    Description          :  Vérifier qu'après la modification de la pref "Pref_max_workas_elements" à une valeur et essayer de selectionner un nombre de succursales 
                            plus grand que la valeur de la pref on reçoit un message d'erreur. .
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-1
    Date                 :  26/11/2018
    
*/


function CR1483_Tran_CheckErrorMsgPrefMaxWorkAs() 
{
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3358","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions
            CR1483_CheckErrorMsgPrefMaxWorkAs(vServerTransactions ,Get_ModulesBar_BtnTransactions(),"Branches",filePath_Transactions,"CR1483_WinSelection_TabBranches_ErrorMsg" );  
}

