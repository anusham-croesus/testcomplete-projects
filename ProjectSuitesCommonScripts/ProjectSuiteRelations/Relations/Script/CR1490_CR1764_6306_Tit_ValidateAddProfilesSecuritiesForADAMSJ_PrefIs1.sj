//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR1490_CR1764_6289_Rel_ValidateAddProfilesForREAGAR_PrefIs5

/**
    CR                  : 1490 devenu 1764
    Cas de test         : CROES-6306
    Description         : Valider l'ajout des profils TITRES pour ADAMSJ pref=1
                          Valider l'ajout des champs profil selon les valeurs mentionné dans la pref sachant que le max admissible de colonnes a rajouter =15
                          ADAMSJ (Assist) valeur du paramètre PREF_PROFILE_MAX_COLUMN=1
 
   
    Auteur              : Abdel Matmat
    Version de scriptage: 90-10-Fm-11
    Date                : 26-04-2019
    
*/
function CR1490_CR1764_6306_Tit_ValidateAddProfilesSecuritiesForADAMSJ_PrefIs1(){
       
        try {
                //lien pour TestLink
                Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6306","Lien du Cas de test sur Testlink");
                
                var userNameAdamsj = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ADAMSJ", "username");
                var passwordAdamsj = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "ADAMSJ", "psw");
                
                var security_6306 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "security_6306", language+client);
                var pref = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "prefAdamsj", language+client));
                
                //Se connecter à l'application
                Login(vServerRelations, userNameAdamsj, passwordAdamsj, language);
                
                //Aller au module titre
                Get_ModulesBar_BtnSecurities().Click();
                Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);
                                
                //Selectionner un titre et accéder à la fenêtre info
                Log.Message("------ Selectionner un titre et accéder à la fenêtre info ------------------");
                Search_SecurityByDescription(security_6306);
                Get_SecurityGrid().Find("Value.OleValue",security_6306,10).DblClick();
                
                //Acceder à l'onglet Profil
                Get_WinInfoSecurity_TabProfiles().Click();
                //Acceder à Configuration
                Get_WinInfoSecurity_TabProfiles_BtnSetup().Click();
                WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94");
                
                //Cocher les 4 premiers profils s'ils ne le sont pas
                for (i=1;i<=pref+3;i++){
                     CheckProfile(i);
                }
                
                //Sauvegarder
                Get_WinVisibleProfilesConfiguration_BtnSave().Click();
                Log.Checkpoint("Le système permet de cocher tous les "+(pref+3)+" profils 'plus de "+pref+" profils définis par la pref'");
               Get_WinInfoSecurity_BtnOK().Click();
                
                //Mettre la configuration par défaut des colonnes
                Log.Message("----------- Mettre la configuration par défaut des colonnes ----------------");
                //SetDefaultConfiguration(Get_SecurityGrid_ChExcludeFromBilling());
                SetDefaultConfiguration(Get_SecurityGrid_ChDescription());
                
                //Ajouter une colonne profile, ici on essaye d'ajouter tous les profils soit 4 et on valide qu'on ne peut ajouter que 5
                Log.Message("---- Ici on essaye d'ajouter tous les profils soit "+(pref+3)+" et on valide qu'on ne peut ajouter que "+pref+" colonnes-------");
                if (client == "CIBC")
                    AddAndCheck_ProfileColumns(Get_SecurityGrid_ChYTMMarket(),pref);
                else
                    AddAndCheck_ProfileColumns(Get_SecurityGrid_ChExcludeFromBilling(),pref);
                
                //Enlever une colonne profils et vérifier que le sous menu profils est de nouveau affiché
                Log.Message("Enlever une colonne profils et vérifier que le sous menu Profils est de nouveau disponible");
                if (client == "CIBC"){
                    DeleteColumn(Get_SecurityGrid_ChAnalystCoverage());
                    CheckSubMenuProfileIfExist(Get_SecurityGrid_ChYTMMarket());
                    }
                else{
                    DeleteColumn(Get_SecurityGrid_ChCheckbox());
                    CheckSubMenuProfileIfExist(Get_SecurityGrid_ChExcludeFromBilling());
                }
        }                
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {               
                //Mettre la configuration par défaut des colonnes
                SetDefaultConfiguration(Get_SecurityGrid_ChDescription());
                
                // Close Croesus 
                Terminate_CroesusProcess();
                Terminate_IEProcess(); 
                
                //Mettre la pref PREF_PROFILE_MAX_COLUMN pour Keynej à l'état initial 'par défaut avec le dump'
                Log.Message("------ Mettre la pref PREF_PROFILE_MAX_COLUMN pour Keynej et Adamsj à l'état initial 'par défaut avec le dump' -------");
                Activate_Inactivate_Pref("KEYNEJ", "PREF_PROFILE_MAX_COLUMN", 10, vServerRelations);
                Activate_Inactivate_Pref("ADAMSJ", "PREF_PROFILE_MAX_COLUMN", 5, vServerRelations);
                //Restart services
                RestartServices(vServerRelations);
        }   
}

function Get_CheckBoxProfile(index){
    if(client == "CIBC")
      return Get_WinVisibleProfilesConfiguration().WPFObject("_profilGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1)
    else
      return Get_WinVisibleProfilesConfiguration().WPFObject("_profilGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 2).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1);
}
function CheckProfile(index){
    if (Get_CheckBoxProfile(index).get_IsChecked()== false)
        Get_CheckBoxProfile(index).Click();
}
function UnCheckProfile(index){
    if (Get_CheckBoxProfile(index).get_IsChecked()== true)
        Get_CheckBoxProfile(index).Click();
}
function Get_SecurityGrid_ChCheckbox(){
  return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "CHECKBOX"], 10);
}

function Get_SecurityGrid_ChAnalystCoverage(){
  return Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Analyst Coverage"], 10);
}