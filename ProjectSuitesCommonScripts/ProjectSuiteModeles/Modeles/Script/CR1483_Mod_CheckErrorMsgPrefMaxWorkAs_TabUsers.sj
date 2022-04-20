//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1483_Mod_Common_Functions


/**
    Module               :  Models
    TestLink             :  Croes-3367
    Description          :  Vérifier qu'après la modification de la pref "Pref_max_workas_elements" à une valeur et essayer de selectionner un nombre d'utilisateurs 
                            plus grand que la valeur de la pref on reçoit un message d'erreur. .
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  06/12/2018
    
*/


function CR1483_Mod_CheckErrorMsgPrefMaxWorkAs_TabUsers() 
{
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3367","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Commun_Functions
            CR1483_CheckErrorMsgPrefMaxWorkAs(vServerModeles ,Get_ModulesBar_BtnModels(),"Users",filePath_Modeles,"CR1483_WinSelection_TabUsers_ErrorMsg" );    
}

