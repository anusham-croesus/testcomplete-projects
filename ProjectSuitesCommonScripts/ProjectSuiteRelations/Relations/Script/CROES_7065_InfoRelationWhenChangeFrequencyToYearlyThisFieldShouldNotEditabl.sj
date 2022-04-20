//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  
                      Activer les préférences au niveau firme :
                      PREF_ENABLE_REVIEW=1
                      PREF_EDIT_NOTE=1

                      Étapes: 
                      1. À partir du module Relations, ajouter une relation et cliquer OK pour fermer la fenêtre.
                      2. Ouvrir la fenêtre Info Relation (onglet Info).
                      3. Modifier la fréquence de révision à "Annuelle" et cliquer sur Appliquer.

                      Comportement non valide observé avec la version 90.04-59 (Neo TD et Neo BNC) et la version 90.03.TD-50 : Dans la section Général, le champ Fréquence affiche la valeur "Annuelle" et ce champ est modifiable.

                      Comportement attendu : Dans la section Général, le champ Fréquence affiche la valeur "Annuelle" et ce champ est en lecture seulement (grisé et non modifiable).

                      Voir le fichier joint : CROES7065_Info_Relation_Frequence_Annuelle_Non_Modifiable.PNG
    Auteur : Sana Ayaz
    Anomalie:CROES-7065
    Version de scriptage:ref90-05-13--V9-AT_1-co6x
*/
function CROES_7065_InfoRelationWhenChangeFrequencyToYearlyThisFieldShouldNotEditabl()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        //Se connecter avec KEYNEJ
//        Activate_Inactivate_PrefBranch('0',"PREF_ENABLE_REVIEW","1",vServerRelations)
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","1",vServerRelations);
        //Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","1",vServerRelations); //Déjà activé dans le dump de référence de BNC
        RestartServices(vServerRelations)//YR: 
        
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        var IACodeCroes_7056=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "IACodeCroes_7056", language+client);
        var FrequeReviewAnnualCROES_7056=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "FrequeReviewAnnualCROES_7056", language+client);
        var relationshipNameCroes_7056=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationshipNameCroes_7056", language+client);
        var TitleWinAddRelatioShip=GetData(filePath_Relations,"WinCreateRelationship",2,language)
        
        Get_ModulesBar_BtnRelationships().Click();
        
       // 1. À partir du module Relations, ajouter une relation et cliquer OK pour fermer la fenêtre.
        Log.Message("Add the relationship \"" + relationshipNameCroes_7056 + "\" with the 'Add' button.");
        var SearchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_7056, 10);
        SearchRelationshipByName(relationshipNameCroes_7056);
        if (SearchResult.Exists == true){
            Log.Message("The relationship \"" + relationshipNameCroes_7056 + "\" already exists.");
            return;
        }
        else {
            Get_Toolbar_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "VisibleOnScreen", "Enabled"], ["AddDropDownMenu", true, true]);
            
            Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WndCaption", "VisibleOnScreen", "Enabled"], ["HwndSource", TitleWinAddRelatioShip, true, true]);         
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Keys(relationshipNameCroes_7056);
            Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().Keys(IACodeCroes_7056);
            Get_WinDetailedInfo_BtnOK().Click();
             WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WndCaption"],["HwndSource", TitleWinAddRelatioShip]);
     
        }
        // 2. Ouvrir la fenêtre Info Relation (onglet Info)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_7056, 10).Click();
        Get_RelationshipsBar_BtnInfo().Click();
        // 3. Modifier la fréquence de révision à "Annuelle" et cliquer sur Appliquer.
        Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency().Click();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency_ItemAnnual().Click();
        Get_WinDetailedInfo_BtnApply().Click();
        /* Les points de vérifications:Comportement attendu : Dans la section Général, le champ Fréquence affiche la valeur "Annuelle"
         et ce champ est en lecture seulement (grisé et non modifiable).*/
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency(), "Text", cmpEqual, FrequeReviewAnnualCROES_7056);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency(), "Enabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbReviewFrequency(), "IsEnabled", cmpEqual, false);
        
        Log.Message("CROES-7065")
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        DeleteRelationship(relationshipNameCroes_7056);
        Terminate_CroesusProcess(); 
        
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        DeleteRelationship(relationshipNameCroes_7056);
        Terminate_CroesusProcess(); 
//      Activate_Inactivate_PrefBranch('0',"PREF_ENABLE_REVIEW","0",vServerRelations) 
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","0",vServerRelations);
        RestartServices(vServerRelations)
        
    }
}

