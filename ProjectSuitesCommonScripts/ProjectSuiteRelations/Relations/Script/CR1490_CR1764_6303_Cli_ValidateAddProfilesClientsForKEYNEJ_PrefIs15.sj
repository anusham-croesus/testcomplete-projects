//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT CR1490_CR1764_6289_Rel_ValidateAddProfilesForREAGAR_PrefIs5

/**
    CR                  : 1490 devenu 1764
    Cas de test         : CROES-6303
    Description         : Valider l'ajout des profils clients pour KEYNEJ pref=15
                          Valider l'ajout des champs profil selon les valeurs mentionné dans la pref sachant que le max admissible de colonnes a rajouter =15
                          KEYNEJ (Admin admin) valeur du paramètre PREF_PROFILE_MAX_COLUMN=15
 
   
    Auteur              : Abdel Matmat
    Version de scriptage: 90-10-Fm-11
    Date                : 26-04-2019
    
*/
function CR1490_CR1764_6303_Cli_ValidateAddProfilesClientsForKEYNEJ_PrefIs15(){
       
        try {
                //lien pour TestLink
                Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6303","Lien du Cas de test sur Testlink");
                
                var userNameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
                var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                
                var clientNo_6303 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "clientNo_6302", language+client);
                var pref = StrToInt(ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1490_CR1764", "prefKeynej", language+client));
                
                //Se connecter à l'application
                Login(vServerRelations, userNameKeynej, passwordKeynej, language);
                
                //Aller au module relation et ajouter une relation
                Get_ModulesBar_BtnClients().Click();
                Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
                                
                //Selectionner un client et accéder à la fenêtre info
                Log.Message("------ Selectionner un client et accéder à la fenêtre info ------------------");
                Search_Client(clientNo_6303);
                Get_RelationshipsClientsAccountsGrid().Find("Value.OleValue",clientNo_6303,10).DblClick();
                
                //Acceder à l'onglet Profil
                Get_WinDetailedInfo_TabProfile().Click();
                //Acceder à Configuration
                Get_WinInfo_TabProfile_BtnSetup().Click();
                WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94");
                
                //Cocher les 12 (4 sont déjà cochés pour avoir 16) premiers profils
                for (i=1;i<=pref-3;i++){
                     CheckProfile(i);
                }
                
                //Sauvegarder
                Get_WinVisibleProfilesConfiguration_BtnSave().Click();
                Log.Checkpoint("Le système permet de cocher tous les "+(pref+1)+" profils 'plus de "+pref+" profils définis par la pref'");
                Get_WinDetailedInfo_BtnOK().Click();
                
                //Mettre la configuration par défaut des colonnes
                Log.Message("----------- Mettre la configuration par défaut des colonnes ----------------");
                SetDefaultConfiguration(Get_ClientsGrid_ChTotalValue());
                
                //Ajouter une colonne profile, ici on essaye d'ajouter tous les profils soit 10 et on valide qu'on ne peut ajouter que 5
                Log.Message("---- Ici on essaye d'ajouter tous les profils soit "+(pref+1)+" et on valide qu'on ne peut ajouter que "+pref+" colonnes-------");
                AddAndCheck_ProfileColumns(Get_ClientsGrid_ChTotalValue(),pref);
                
        }                
        catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
                //Décocher tous les profils de 
                Log.Message("-------- Décocher tous les profils cochés  -------------------");
                Log.Message("------ Selectionner le client et accéder à la fenêtre info ------------------");
                 Get_RelationshipsClientsAccountsGrid().Find("Value",clientNo_6303,10).Click();
                  Get_RelationshipsClientsAccountsGrid().Find("Value",clientNo_6303,10).DblClick();
                
                //Acceder à l'onglet Profil
                Get_WinDetailedInfo_TabProfile().Click();
                //Acceder à Configuration
                Get_WinInfo_TabProfile_BtnSetup().Click();
                WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94");
                
                //Décocher les 16 premiers profils
                for (i=1;i<=pref-3;i++){
                     UnCheckProfile(i);
                }
                //Sauvegarder
                Get_WinVisibleProfilesConfiguration_BtnSave().Click();
                Get_WinDetailedInfo_BtnOK().Click();
                 
                //Mettre la configuration par défaut des colonnes
                SetDefaultConfiguration(Get_ClientsGrid_ChTotalValue());
                
                // Close Croesus 
                Terminate_CroesusProcess();
                Terminate_IEProcess();              
        }   
}

function Get_CheckBoxProfile(index){
    if(client == "CIBC")
      return Get_WinVisibleProfilesConfiguration().WPFObject("_profilGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1)
    else
      return Get_WinVisibleProfilesConfiguration().WPFObject("_profilGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 3).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 1).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1);
}
function CheckProfile(index){
    if (Get_CheckBoxProfile(index).get_IsChecked()== false)
        Get_CheckBoxProfile(index).Click();
}
function UnCheckProfile(index){
    if (Get_CheckBoxProfile(index).get_IsChecked()== true)
        Get_CheckBoxProfile(index).Click();
}
function Get_ClientsGrid_ChActifNet(){
  return Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Actif net"], 10);
}