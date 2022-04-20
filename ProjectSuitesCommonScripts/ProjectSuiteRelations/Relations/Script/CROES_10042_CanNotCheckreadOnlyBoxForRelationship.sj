//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                      -Activer la pref PREF_RELATIONSHIP_READ_ONLY pour Copern 
                      -Sélectionner une relation existante et cocher la case lecture seulement 
                      -Appliquer et fermer la fenêtre Info relation
                      -Accéder à la meme relation : la case lecture seulement est décochée

 



    Auteur : Sana Ayaz
    Anomalie:CROES-10042
    Version de scriptage:ref90-07-Co-15--V9-Be_1-co6x
*/
function CROES_10042_CanNotCheckreadOnlyBoxForRelationship()
{
    try {
        
          
       userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
       passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
       
       //-Activer la pref PREF_RELATIONSHIP_READ_ONLY pour Copern 
        Activate_Inactivate_Pref('COPERN', "PREF_RELATIONSHIP_READ_ONLY", "YES", vServerRelations);
        RestartServices(vServerRelations)
        //Se connecter avec COPERN
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        
        var relationshipNameCROES10046=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationshipNameCROES10046", language+client);
       //Sélectionner une relation existante et cocher la case lecture seulement 
        
        
        
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(relationshipNameCROES10046)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCROES10046, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCROES10046, 10).DblClick();
        
        Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().set_IsChecked(true);
        //Appliquer et fermer la fenêtre Info relation
         WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlText", "Enabled","IsLoaded"], ["UniButton", "OK",  true,true]);     
         Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().Click();
         Get_WinDetailedInfo_BtnApply().Click();
         Delay(8000)
         Get_WinDetailedInfo_BtnOK().Click();
        
       //Accéder à la meme relation : la case lecture seulement est décochée 
        SearchRelationshipByName(relationshipNameCROES10046)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCROES10046, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCROES10046, 10).DblClick();
        //Les points de vérification
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship(), "IsChecked", cmpEqual, true);
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship(), "VisibleOnScreen", cmpEqual, true);
        Log.Message("CROES-10042")
        Get_WinDetailedInfo_BtnCancel().Click();
        Terminate_CroesusProcess(); 
     
        
        
      
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess(); 
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(relationshipNameCROES10046)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCROES10046, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCROES10046, 10).DblClick();
        if(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().IsChecked)
        {
           Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().set_IsChecked(false);
        }
         Get_WinDetailedInfo_BtnOK().Click();
        Terminate_CroesusProcess(); 
        
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByName(relationshipNameCROES10046)
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCROES10046, 10).Click();
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCROES10046, 10).DblClick();
        if(Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().IsChecked)
        {
           Get_WinDetailedInfo_TabInfo_GrpGeneral_ChkReadOnlyRelationshipForRelationship().set_IsChecked(false);
        }
         Get_WinDetailedInfo_BtnOK().Click();
        Terminate_CroesusProcess(); 
       
    }
}

