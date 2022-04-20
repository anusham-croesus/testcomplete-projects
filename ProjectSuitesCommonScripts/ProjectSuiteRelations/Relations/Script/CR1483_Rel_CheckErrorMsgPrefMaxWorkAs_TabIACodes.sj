//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1483_Common_Functions


/**
    Module               :  Relationships
    TestLink             :  Croes-3361
    Description          :  Vérifier qu'après la modification de la pref "Pref_max_workas_elements" à une valeur et essayer de selectionner un nombre de codes de CP 
                            plus grand que la valeur de la pref on reçoit un message d'erreur. .
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  03/12/2018
    
*/


function CR1483_Rel_CheckErrorMsgPrefMaxWorkAs_TabIACodes() 
{
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3361","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions
            CR1483_CheckErrorMsgPrefMaxWorkAs(vServerRelations ,Get_ModulesBar_BtnRelationships(),"IACodes",filePath_Relations,"CR1483_WinSelection_TabIACodes_ErrorMsg" );    
}

