//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    CR                  : 1490 devenu 1764
    Cas de test         : CROES-6289
    Description         : Valider l'ajout des champs profil selon les valeurs mentionné dans la pref sachant que le max admissible de colonnes a 
                          rajouter =15.
    Préconditions:      : niveau user
                          REAGAR  (rep) valeur du paramètre PREF_PROFILE_MAX_COLUMN=5
                          ADAMSJ (Assist) valeur du paramètre PREF_PROFILE_MAX_COLUMN=1
                          KEYNEJ (FIRMADM) valeur du paramètre PREF_PROFILE_MAX_COLUMN=15 
                          REAGAR PREF_EDIT_FIRM_FUNCTIONS=YES
                                           
    Auteur              : Abdel Matmat
    Version de scriptage: 90-10-Fm-2
    Date                : 29-03-2019
    
*/
function CR1490_CR1764_6289_Rel_ValidateAddProfilesForREAGAR_PrefIs5(){
       
        try {
                //lien pour TestLink
                Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6289","Lien du Cas de test sur Testlink");
                
                var userNameReagar = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
                var passwordReagar = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
                
                //Modifier la pref PREF_PROFILE_MAX_COLUMN pour chaque user
                Activate_Inactivate_Pref(userNameReagar, "PREF_PROFILE_MAX_COLUMN", 5, vServerRelations);
                Activate_Inactivate_Pref("ADAMSJ", "PREF_PROFILE_MAX_COLUMN", 1, vServerRelations);
                Activate_Inactivate_Pref("KEYNEJ", "PREF_PROFILE_MAX_COLUMN", 15, vServerRelations);
                
                //pref REAGAR PREF_EDIT_FIRM_FUNCTIONS = yes
                Activate_Inactivate_Pref(userNameReagar,"PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerRelations);
                
                //Restart services
                RestartServices(vServerRelations);
                
                var profileGroup_6289 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "profileGroup_6289", language+client);
                var profileSubGroup_6289 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "profileSubGroup_6289", language+client);
                var profileDefautGroup_6289 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "profileDefautGroup_6289", language+client);
                var profile1_6289 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "profile1_6289", language+client);
                var profile2_6289 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "profile2_6289", language+client);
                var profile3_6289 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "profile3_6289", language+client);
                var profile4_6289 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "profile4_6289", language+client);
                var profile5_6289 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "profile5_6289", language+client);
                var profile6_6289 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "profile6_6289", language+client);
                var relationshipName_6289 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "relationshipName_6289", language+client);
                var pref = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "prefReagar", language+client));
                
                //Se connecter à l'application
                Login(vServerRelations, userNameReagar, passwordReagar, language);
                
                //Aller au Menu Outils/Configuration/Profils et Dictionnaire/Groupes de Profils
                Log.Message("-------- Accéder au Menu Outils/Configuration/Profils et Dictionnaire/Groupes de Profils ---------");
                Get_MenuBar_Tools().Click();
                Get_MenuBar_Tools_Configurations().Click();
                WaitObject(Get_CroesusApp(),"Uid","TreeView_f006");
                Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
                if (language == "french") WaitObject(Get_CroesusApp(),"WPFControlText", "Groupes de profils");
                else WaitObject(Get_CroesusApp(),"WPFControlText", "Groups of Profiles")
                Get_WinConfigurations_LvwListView_LlbGroupsOfProfiles().DblClick();
                WaitObject(Get_CroesusApp(),"Uid","ConfigurationWindow_a034");
                
                //Choisir module Relations
                Log.Message("------------ Choisir Module Relations ------------------------------------------");
                Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule().Click();
                Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule_ItemRelation().Click();
                
                //Cliquer sur ajouter un groupe
                Log.Message("------------------- Ajouter un groupe ------------------------------------------");
                Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntAddGroup().Click();
                
                //Saisir F1Reagar
                Get_WinProfilGroupConfiguration_TxtDescription().Keys(profileGroup_6289);
                Get_WinProfilGroupConfiguration_BtnOk().Click();
                
                //Selectionner le groupe créé et cliquer le bouton ajouter un sous groupe
                Log.Message("---------------- Sélectionner le groupe créé ------------------------------------");
                Get_WinProfilesAndDictionaryConfiguration().Find(["ClrClassName","Text"],["XamTextEditor",profileGroup_6289],10).Click();
                Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntAddSubGroup().Click();
                
                //Ajouter un sous groupe F1Reagar-SG
                Log.Message("--------------------- Ajouter un sous groupe -------------------------------------");
                Get_WinProfilGroupConfiguration_TxtDescription().Keys(profileSubGroup_6289);
                Get_WinProfilGroupConfiguration_BtnOk().Click();
                
                //Sélectionner le groupe Défaut
                Log.Message("------------ Sélectionner le groupe Défaut ---------------------------------------");
                Get_WinProfilesAndDictionaryConfiguration().Find(["ClrClassName","Text"],["XamTextEditor",profileDefautGroup_6289],10).Click();
                
                //Ajouter 6 profils au groupe Reagar
                Log.Message("------- Ajouter 6 profils du module Relations au groupe créé --------------------------");
                AddProfileToGroup(profile1_6289,profileGroup_6289);
                AddProfileToGroup(profile2_6289,profileGroup_6289);
                AddProfileToGroup(profile3_6289,profileGroup_6289);
                AddProfileToGroup(profile4_6289,profileGroup_6289);
                AddProfileToGroup(profile5_6289,profileGroup_6289);
                AddProfileToGroup(profile6_6289,profileGroup_6289);
                //Fermer la fenêtre
                Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click();
                Get_WinConfigurations().Close();
                
                //Aller au module Relations et accéder à info d'une relation
                Get_ModulesBar_BtnRelationships().Click();
                Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
                Get_RelationshipsClientsAccountsGrid().Find("Value",relationshipName_6289,10).DblClick();
                //Acceder à l'onglet Profil
                Get_WinDetailedInfo_TabProfile().Click();
                //Acceder à Configuration
                Get_WinInfo_TabProfile_BtnSetup().Click();
                WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94");
                //Cliquer sur le scrollDown pour aboutir la fin de la fenêtre
                Get_WinVisibleProfilesConfiguration().Click(Get_WinVisibleProfilesConfiguration().Width-25,Get_WinVisibleProfilesConfiguration().Height-95);
                
                //Cocher tous les profils configurés avant
                Log.Message("----------- Cocher tous les profils du groupe créé ---------------------------------");
                CheckAllChecboxes(Get_WinVisibleProfilesConfiguration_F1ReagarExpander());
                //Sauvegarder
                Get_WinVisibleProfilesConfiguration_BtnSave().WaitProperty("IsEnabled", true, 5000);
                Get_WinVisibleProfilesConfiguration_BtnSave().Click();
                Log.Checkpoint("Le système permet de cocher tous les 6 profils 'plus de 5 profils'");
                WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"]);
        
                Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 5000);
                Get_WinDetailedInfo_BtnOK().Click();
                
                Log.Message("Restore default configuration for the columns.");
                Get_RelationshipsGrid_ChName().ClickR();
                Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
                
                //Ajouter les profils à la grille Relations et vérifier qu'on ne peut ajouter que 5 (défini par la pref)
                Log.Message("Ajouter les profils à la grille Relations et vérifier qu'on ne peut ajouter que 5 (défini par la pref)");
                //Get_RelationshipsGrid_ChName().ClickR()
                AddAndCheck_ProfileColumns(Get_RelationshipsGrid_ChTotalValue(),pref);
                
                //Enlever une colonne profils et vérifier que le sous menu Profils est de nouveau disponible
                Log.Message("Enlever une colonne profils et vérifier que le sous menu Profils est de nouveau disponible");
                if (client == "CIBC")
                    DeleteColumn(Get_RelationshipsGrid_ChOccupation());
                else
                    DeleteColumn(Get_RelationshipsGrid_ChDiscretionary_Manage());
                CheckSubMenuProfileIfExist(Get_RelationshipsGrid_ChTotalValue());
                
                WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
            
        }                
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
                //Décocher tous les profils de F1Reagar
                Log.Message("-------- Décocher tous les profils de F1Reagar -------------------");
                UncheckAllProfilesOfGroup(relationshipName_6289);
                 
                //Supprimer le groupe créé
                Log.Message("---- Supprimer le groupe créé avec les sous groupes les profils seront réassignés au groupe par défaut --------");
                DeleteGroupOfProfiles(profileGroup_6289);
                WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
                
                //Mettre la configuration par défaut des colonnes
                SetDefaultConfiguration(Get_RelationshipsGrid_ChTotalValue());
                WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
                
                // Close Croesus 
                Terminate_CroesusProcess();
                Terminate_IEProcess();              
        }   
}

function DeleteGroupOfProfiles(group){
       //Aller au Menu Outils/Configuration/Profils et Dictionnaire/Groupes de Profils
       Log.Message("-------- Accéder au Menu Outils/Configuration/Profils et Dictionnaire/Groupes de Profils ---------");
       Get_MenuBar_Tools().Click();
       Delay(500);
       Get_MenuBar_Tools_Configurations().Click();
       WaitObject(Get_CroesusApp(),"Uid","TreeView_f006");
       Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
       if (language == "french") WaitObject(Get_CroesusApp(),"WPFControlText", "Groupes de profils");
       else WaitObject(Get_CroesusApp(),"WPFControlText", "Groups of Profiles")
       Get_WinConfigurations_LvwListView_LlbGroupsOfProfiles().DblClick();
       WaitObject(Get_CroesusApp(),"Uid","ConfigurationWindow_a034");
                
       //Choisir module Relations
       Log.Message("------------ Choisir Module Relations ------------------------------------------");
       Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule().Click();
       Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_CmbModule_ItemRelation().Click();
                
       //Selectionner le groupe F1Reagar et supprimer
       Log.Message("-------------- Suprimer le groupe créé avec le sous groupe ---------------------");
       Get_WinProfilesAndDictionaryConfiguration().Find(["ClrClassName","Text"],["XamTextEditor",group],10).Click();
       Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BntDelete().Click();
       Get_DlgConfirmation_BtnDelete().Click();
                
       //Fermer la fenêtre de configuration des profils et dictionnaire
       Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click();
       Get_WinConfigurations().Close();              
}
function Get_WinVisibleProfilesConfiguration_F1ReagarExpander()
{   var indice = 4;
    if (client == "CIBC")
        indice = 2;
    return Get_WinVisibleProfilesConfiguration().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", indice], 10)    
}
function CheckAllChecboxes(parentComponentObject){
    var arrayOfCheckboxes = parentComponentObject.FindAllChildren(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100).toArray();
    for (var i = 0; i < arrayOfCheckboxes.length; i++){
        if (arrayOfCheckboxes[i].get_IsChecked() == false)
            arrayOfCheckboxes[i].Click();
    }
}
function UnCheckAllChecboxes(parentComponentObject){
    var arrayOfCheckboxes = parentComponentObject.FindAllChildren(["ClrClassName", "WPFControlOrdinalNo"], ["XamCheckEditor", "1"], 100).toArray();
    for (var i = 0; i < arrayOfCheckboxes.length; i++){
        if (arrayOfCheckboxes[i].get_IsChecked() == true)
            arrayOfCheckboxes[i].Click();
    }
}
function AddAndCheck_ProfileColumns(Column,pref){
      Column.ClickR();
      Column.ClickR();
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
      var count = Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).ChildCount;
      for (i=1; i<=count; i++)
      {
        Column.ClickR();
        Column.ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        if (Get_GridHeader_ContextualMenu_AddColumn_Profiles().VisibleOnScreen)
        {
           Get_GridHeader_ContextualMenu_AddColumn_Profiles().OpenMenu();
           Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", "1"], 10).Click();   
           
        }else{
            if(i-1 == pref){
              Log.Checkpoint("Profils n'est pas visible dans le sous menu");
              Log.Checkpoint("On ne peut ajouter que "+(i-1)+" profils défini par la pref");
              break;}
            else
              Log.Error("Le nombre de colonnes ajoutés est différent de la valeur de pref");
        }
      }
}
function CheckSubMenuProfileIfExist(Column){
      Column.ClickR();
      Column.ClickR();
      Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
      if (Get_GridHeader_ContextualMenu_AddColumn_Profiles().VisibleOnScreen)
          Log.Checkpoint("Profils est de nouveau visible dans le sous menu");
      else
          Log.Error("Profils n'est pas visible dans le sous menu");
}

function Get_RelationshipsGrid_ChDiscretionary_Manage(){ 
      return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Discretionary Manage"], 10)}
function Get_RelationshipsGrid_ChOccupation(){ 
      return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Occupation"], 10)}

function AddProfileToGroup(profile,group){
  Log.Message("---------- Ajouter le profile '"+profile+"' au groupe '"+group+"' ---------------------");
  if (language == "french") var grid = Get_WinProfilesAndDictionaryConfiguration().WPFObject("TabControl", "", 1).WPFObject("ProfilGroupsConfigurationControl", "", 1).WPFObject("GroupBox", "Détail", 2).WPFObject("GroupBox", "Liste des profils", 1).WPFObject("_profilGrid").WPFObject("RecordListControl", "", 1)
  else var grid = Get_WinProfilesAndDictionaryConfiguration().WPFObject("TabControl", "", 1).WPFObject("ProfilGroupsConfigurationControl", "", 1).WPFObject("GroupBox", "Detail", 2).WPFObject("GroupBox", "List of Profiles", 1).WPFObject("_profilGrid").WPFObject("RecordListControl", "", 1)
  grid.Click()
  grid.Keys("[PageDown][PageDown][PageDown][PageDown]");
  WaitObject(grid,"Value",profile);
  grid.Find(["ClrClassName","Value"],["XamTextEditor",profile],10).Click();
  Get_WinProfilesAndDictionaryConfiguration_TabGroupsOfProfiles_BtnEditProfile().Click();
  WaitObject(Get_CroesusApp(),"Uid","ProfilConfigurationWindow_41d4");
  Get_WinAddOrEditProfile_GrpProfile_GrpModules_CmbRelationshipsGroup().Click();
  Get_SubMenus().Find("Text",group,10).Click();
  Get_WinAddOrEditProfile_BtnOK().Click();
}

function UncheckAllProfilesOfGroup(relationship){
        Get_RelationshipsClientsAccountsGrid().Find("Value",relationship,10).Click();
        Get_RelationshipsClientsAccountsGrid().Find("Value",relationship,10).DblClick();
        
        //Acceder à l'onglet Profil
        Get_WinDetailedInfo_TabProfile().Click();
        //Acceder à Configuration
        Get_WinInfo_TabProfile_BtnSetup().Click();
        //Cliquer sur le scrollDown pour aboutir la fin de la fenêtre
        Get_WinVisibleProfilesConfiguration().Click(Get_WinVisibleProfilesConfiguration().Width-25,Get_WinVisibleProfilesConfiguration().Height-95);
                
        //Décocher tous les profils configurés avant
        Log.Message("----------- Décocher tous les profils du droupe créé ---------------------------------");
        UnCheckAllChecboxes(Get_WinVisibleProfilesConfiguration_F1ReagarExpander());
        //Sauvegarder
        Get_WinVisibleProfilesConfiguration_BtnSave().WaitProperty("IsEnabled", true, 5000);
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"]);
        
        Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 5000);
        Get_WinDetailedInfo_BtnOK().Click();
        WaitObject(Get_CroesusApp(),"Uid","CRMDataGrid_3071");
        //WaitUntilObjectDisappears(Get_WinDetailedInfo(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"]);
}

function Get_CheckBoxProfile(index){
      return Get_WinVisibleProfilesConfiguration().WPFObject("_profilGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1)

}

function CheckProfile(index){
    if (Get_CheckBoxProfile(index).get_IsChecked()== false)
        Get_CheckBoxProfile(index).Click();
}
function UnCheckProfile(index){
    if (Get_CheckBoxProfile(index).get_IsChecked()== true)
        Get_CheckBoxProfile(index).Click();
}