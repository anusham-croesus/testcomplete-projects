//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    Description :
                    Valider les colonnes dans l'onglet Grille d'une relation:

                    Présentement nous avons les colonnes : 
                    Date de création, créée par et note
                    Il manque: Date de référence et date de modification que nous avions dans les autres versions

                    Valider également l'icône d'exportation vers excel s'il devrait être là? Nous n'avions pas cet icône dans les anciennes versions.

                    90.04.bnc.28-23 : J'ai date de référence et modification mais pas d'icône excel
                    90.04-78 : Pas date de référence et modification mais icône excel
                    90.03.cibc-58 : pas de date de référence et modification. J'ai un icône imprimante au lieu de celui de excel
                    90.04.CR1356-2 (mainline 90.04-69): date de référence et modification. Pas d'icône.
                   
                    Auteur : Abdel Matmat
                    Version de scriptage:ref90-07-23
                    Numéro de l'anomalie sur JIRA : CROES-7776
    
*/
function CROES_7776_ValidateColumnsInGridTabOfRelationship(){

        Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","1",vServerRelations);
        RestartServices(vServerRelations); 
        
        var relationshipName_CROES_7776 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationshipName_CROES_7776", language+client);
        var IACode_CROES_7776 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "IACode_CROES_7776", language+client);
        
        Log.Link("https://jira.croesus.com/browse/CROES-7776", "Cas de tests JIRA CROES-7776");
        
        try {
                Login(vServerRelations, userName, psw, language);
        
                //Créer une relation et accéder à sa fenêtre Info
                CreateRelationship(relationshipName_CROES_7776,IACode_CROES_7776);
                SearchRelationshipByName(relationshipName_CROES_7776);
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName_CROES_7776, 10).DblClick();
                WaitObject(Get_CroesusApp(), "Uid", "TabControl_8db0");
        
                //Valider les colonnes affichées dans l'onglet Grille de la relation
                Log.Message("Valider les colonnes affichées dans l'onglet Grille de la relation");
                Get_WinInfo_Notes_TabGrid().Click();
        
                // Les en-têtes de colonne de la configuration par défaut
                Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreatedBy().ClickR();
                Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
      
                Log.Message("Valider la colonne (Date de création)");
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "DateCreationCROES_7776", language+client));
                Log.Message("Valider la colonne (Créée par)");
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreatedBy(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "CreeParCROES_7776", language+client));
                Log.Message("Valider la colonne (Note)");
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChNote(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NoteCROES_7776", language+client));
                Log.Message("Valider la colonne (Date de référence)");
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChEffectiveDate(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "DateReferenceCROES_7776", language+client));
  
                //Ajouter les entêtes
                Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR();
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
                for(i=1; i<count; i++){
                Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "1"], 10).Click(); //YR 90-04-44
                Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR(); 
                }
  
                //Les autres en-têtes de colonne
                Log.Message("Valider la colonne (Date de modification)");
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChModificationDate(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "DateModificationCROES_7776", language+client));
                Log.Message("Valider la colonne (Révision)");
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_ChDeclareAsReview(), "Content", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "RevisionCROES_7776", language+client));
                
                //Set the default configuration of columns in the grid
                Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreatedBy().ClickR();
                Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                
                Get_WinDetailedInfo_BtnCancel().Click();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        DeleteRelationship(relationshipName_CROES_7776);
        Terminate_CroesusProcess();
    }
    finally {
    
        DeleteRelationship(relationshipName_CROES_7776);
        Terminate_CroesusProcess();
        
        //Remise de la pref à l'état initial
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_ENABLE_REVIEW","0",vServerRelations);
        RestartServices(vServerRelations);
    }
        
}

function Get_WinInfo_Notes_TabGrid_DgvNotes_ChDeclareAsReview()
{
  if (language == "french"){return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Révision"], 10)}
  else {return Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Review"], 10)}
}