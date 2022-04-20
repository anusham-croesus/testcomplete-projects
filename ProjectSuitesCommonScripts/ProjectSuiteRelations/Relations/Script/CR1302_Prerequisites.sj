//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 



/**
    Module               :  Relationships
    CR                   :  1302
    TestLink             :  Croes-6156
    Description          :  Pref et script pré-requis pour cas de test:CR1302.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.09.Er-11
    Date                 :  14/02/2019
    
*/


function CR1302_Prerequisites() 
{
         
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6156","Lien du Cas de test sur Testlink");
    
            //Activer les prefs au niveau firm PREF_ENABLE_REVIEW=1,PREF_EDIT_NOTE=oui 
            Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","1",vServerRelations);
            Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerRelations);
            RestartServices(vServerRelations);
            
}

function Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency(){return Get_WinDetailedInfo_TabInfo_GrpGeneral().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CFComboBox", "5"], 10)}