//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Dash_Common_Functions


/**
    Module               :  Dashboard
    TestLink             :  Croes-3334
    Description          :  Vérifier qu'après la modification de la pref "Pref_max_workas_elements" à une valeur et essayer de selectionner un nombre de codes de CP 
                            plus grand que la valeur de la pref on reçoit un message d'erreur. .
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  29/11/2018
    
*/


function CR1483_Dash_CheckErrorMsgPrefMaxWorkAs_TabIACodes() 
{
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3334","Lien du Cas de test sur Testlink");
    
            //Appel à la fonction Commune dans CR1483_Common_Functions
            CR1483_CheckErrorMsgPrefMaxWorkAs(vServerDashboard ,Get_ModulesBar_BtnDashboard(),"IACodes",filePath_Dashboard,"CR1483_WinSelection_TabIACodes_ErrorMsg" ); 
}

