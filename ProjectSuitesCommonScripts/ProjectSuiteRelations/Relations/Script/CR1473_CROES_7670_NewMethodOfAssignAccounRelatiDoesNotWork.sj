//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT DBA



/**
        Description : 
                  La nouvelle méthode d'assignation d'un compte à une relation (CR-1473) ne fait aucune validation pour savoir si le compte est déjà assigné directement ou indirectement à un modèle ou s'il est un compte UMA.

                  Étapes:

                  Identifier un compte qui est assigné à un modèle et un autre compte UMA
                  Sélectionner une relation qui est assignée à un modèle
                  Dans le module Relations: tenter d'assigner les 2 comptes de la 1ère étape à la relation à travers le bouton 'Ajouter' de la barre principale en sélectionnant l'option 'Associer des comptes à la relation' et remarquer qu'une fenêtre s'affiche pour nous aviser qu'on ne peut pas assigner ce compte à la relation à cause d'un conflit
                  Si on répète mais à travers la nouvelle méthode:
                  Info relation sur la même relation / onglet 'Comptes sous-jacents' / bouton 'Ajouter'/ sélectionner les mêmes 2 comptes: aucune validation et les 2 comptes sont assignés

    Auteur : Sana Ayaz
    Anomalie:CROES-7670
    Version de scriptage:ref90-04-BNC-59B-11
*/
function CR1473_CROES_7670_NewMethodOfAssignAccounRelatiDoesNotWork()
{
    try {
        
        
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        
         var relationshipNameCroes_7670=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationshipNameCroes_7670", language+client);
         var NumberAccount800239RE=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NumberAccount800239RE", language+client);
         var NumberAccount800003OB=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "NumberAccount800003OB", language+client);
         var MsgDejaAssignARelationFirmFamilCroes_7670_800239RE=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "MsgDejaAssignARelationFirmFamilCroes_7670_800239RE", language+client);
         var MsgDejaAssignARelationFirmFamilCroes_7670_800003OB=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "MsgDejaAssignARelationFirmFamilCroes_7670_800003OB", language+client);
         var nameModeleCroesus_7670=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "nameModeleCroesus_7670", language+client);
         var relationsTestCroes_7670=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationsTestCroes_7670", language+client);
         
        //Se connecter avec Keynej 
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_MainWindow().Maximize();
//        CreateRelationship(relationsTestCroes_7670)
       
        //Assigner a la relation PALIER_SEMIANNUA
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 100000);
        WaitObject(Get_CroesusApp(),"Uid","ModelListView_6fed");        
        
        Get_Toolbar_BtnSearch().Click();
        Get_WinQuickSearch_TxtSearch().SetText(nameModeleCroesus_7670);
        Get_WinQuickSearch_BtnOK().Click();
        WaitObject(Get_CroesusApp(),"Uid","ModelListView_6fed");
        Get_ModelsGrid().FindChild("Value", nameModeleCroesus_7670, 10).Click();
  
        Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
        Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click();
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_f076");
        Get_WinPickerWindow_DgvElements().Keys("R");
        Get_WinQuickSearch_TxtSearch().SetText(relationshipNameCroes_7670);
        Get_WinQuickSearch_BtnOK().Click();
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_f076");
        Get_WinPickerWindow_DgvElements().FindChild("Value", relationshipNameCroes_7670, 10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        Get_WinAssignToModel_BtnYes().Click();
        WaitObject(Get_CroesusApp(),"Uid","ModelListView_6fed");
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        
        SearchRelationshipByName(relationshipNameCroes_7670);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_7670, 10).Click();
        Get_RelationshipsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click();
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_f076");
        // Associer le compte 800239-RE qui est assigné au modéle +FB_MONTAN_SBS
        Sys.Keys("8");
        Get_WinQuickSearch_TxtSearch().SetText(NumberAccount800239RE);
        Get_WinQuickSearch_BtnOK().Click();
        Get_WinPickerWindow().FindChild("Value", NumberAccount800239RE, 10).Click();
        Get_WinPickerWindow_BtnOK().Click();
        
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_1e6a");
       
        /*Les points de vérifications : Vérifier que le message :La relation sélectionnée est associée au modèle ~M-0000U-0 et entre en conflit avec l'association suivante: 
        compte 800239-RE avec le modèle ~M-0000R-0.L'association a été interrompue s'affiche a l'écran*/
        //Get_WinAssignToARelationship_DgvAccountsList
         var CellReasonOfConflict = Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 5], 10).WPFObject("XamTextEditor", "", 1);
         aqObject.CheckProperty(CellReasonOfConflict, "IsVisible", cmpEqual, true)
         aqObject.CheckProperty(CellReasonOfConflict, "Exists", cmpEqual, true);
         aqObject.CheckProperty(CellReasonOfConflict, "DisplayText", cmpEqual, MsgDejaAssignARelationFirmFamilCroes_7670_800239RE);
         
         if (client != "CIBC"){
             Log.Message("CROES-7670");
             Get_WinAssignToARelationship_BtnOk().Click();
              // Associer le compte 800003-OB compte UMA
             Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnAdd().Click();
              WaitObject(Get_CroesusApp(),"UID","PickerBase_dcbf")
             Sys.Keys("8");
             Get_WinQuickSearch_TxtSearch().SetText(NumberAccount800003OB);
             Get_WinQuickSearch_BtnOK().Click();
             Get_WinPickerWindow().FindChild("Value", NumberAccount800003OB, 10).Click();
             Get_WinPickerWindow_BtnOK().Click();
             var CellReasonOfConflict = Get_WinAssignToARelationship_DgvAccountsList().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 5], 10).WPFObject("XamTextEditor", "", 1);
             aqObject.CheckProperty(CellReasonOfConflict, "IsVisible", cmpEqual, true)
             aqObject.CheckProperty(CellReasonOfConflict, "Exists", cmpEqual, true);
             aqObject.CheckProperty(CellReasonOfConflict, "DisplayText", cmpEqual, MsgDejaAssignARelationFirmFamilCroes_7670_800003OB);
             Log.Message("CROES-7670");
             Get_WinAssignToARelationship_BtnOk().Click();
         } 
  
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));        
    }
    finally {
        Terminate_CroesusProcess(); //Fermer Croesus
        //Se connecter avec Keynej 
        Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnRelationships().Click();        
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        SearchRelationshipByName(relationshipNameCroes_7670);
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipNameCroes_7670, 10).Click();
        Get_RelationshipsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click();
        var ResultSearch=Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild("Value", NumberAccount800239RE, 10)
        if(ResultSearch.Exists)
        {
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild("Value", NumberAccount800239RE, 10).Click();
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
        

        var ResultSearch=Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild("Value", NumberAccount800003OB, 10)
        if(ResultSearch.Exists)
        {
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_DgvUnderlyingAccounts().FindChild("Value", NumberAccount800003OB, 10).Click();
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
        Get_WinDetailedInfo_BtnCancel().Click()
        //Enlever la relation PALIER_SEMIANNUA du modéle CH AMERICAN EQUI
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnSearch().Click();
        Get_WinQuickSearch_TxtSearch().keys(nameModeleCroesus_7670);
        Get_WinQuickSearch_BtnOK().Click();
        Get_ModelsGrid().FindChild("Value", nameModeleCroesus_7670, 10).Click();
         var relationAssocie = Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", relationshipNameCroes_7670, 10);
        if(relationAssocie.Exists)
        {
          relationAssocie.Click();
          Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
          /*var width = Get_DlgCroesus().Get_Width();
          Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(1/3)),73);
    
          relationAssocie = Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", relationshipNameCroes_7670, 10);
          if(!relationAssocie.Exists)
            Log.Checkpoint("Relation enlevée correctment.");
          else
            Log.Error("Relation non enlevée.");
        }
        else
          Log.Error("Relation non associée.");
  
        Terminate_CroesusProcess(); //Fermer Croesus        
    }
}

function Test(){
  Get_WinPickerWindow_DgvElements().Keys("R");
}